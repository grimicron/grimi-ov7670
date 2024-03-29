// DOCS:
// ~/gitrepos/WiringPi (WiringPi source)
// https://www.raspberrypi.org/app/uploads/2012/02/BCM2835-ARM-Peripherals.pdf (BCM2835 datasheet)
// https://raspberrypi.stackexchange.com/questions/50406/multiple-clock-outputs-from-rpi (relevant thread on GPCLK)
// https://www.reddit.com/r/raspberry_pi/comments/e9kffn/help_with_gpclk_i_have_checked_my_approach_for/ (relevant thread on GPCLK)
// https://pinout.xyz/pinout/gpclk (RPi pinouts, info on GPCLK)
// https://web.mit.edu/6.111/www/f2016/tools/OV7670_2006.pdf (OV7670 datasheet)

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <unistd.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <math.h>

// I'm very comfortable working with these types, but I want to be
// really pedantic about their size just in case
#define byte uint8_t
#define short int16_t
#define int int32_t
#define long int64_t

// Datasheets and docs are all over the place with this (see BCM2835 datasheet sections
// 1.1 and 6.1), some say that it's 0x7E000000, others say 0xFE000000, others say both,
// but 0xFE000000 has worked for me (I'm pretty sure there's a ton of kernel/model 
// revision/signed integer magic around this)
#define GPIO_BASE 0xFE000000
#define GPIO_CLK  (GPIO_BASE + 0x00101000)
#define GPIO_PINS (GPIO_BASE + 0x00200000)
#define GPIO_PWM  (GPIO_BASE + 0x0020c000)
#define BLOCK_SIZE (1024*4)

// GPIO macros for faster GPIO operations (only working for GPIO 0-31 inclusive)
// Sets GPIO pin p to output mode
// Explanation behind bitwise magic: there are 10 GPIO function
// selects per FSEL register, so we need to offset by the GPIO number
// divided by 10, then we offset from 0 the mode (which we assume is less
// than 8) by 3 times remainder, as there are 3 mode bits per pin (we have
// to mask and then OR because we dont want to modify the state of other pins) 
#define MODE(p,m) gpio[(p)/10]=(gpio[(p)/10]&(~(7<<(((p)%10)*3))))|((m)<<(((p)%10)*3))
// Sets GPIO p to output level HIGH if l is truthy, otherwise to LOW
#define OUTPUT(p,l) gpio[(l)?0x07:0x0A]=1<<(p)
// Returns 1<<p if GPIO p is HIGH, otherwise returns LOW
#define INPUT(p) (gpio[0x0D]&(1<<(p)))
// Returns the byte of data of 8 consequetive GPIO pins, starting at p
// p must be between 0 and 24 (inclusive) since pins p...p+7 are read
#define BYTEIN(p) ((gpio[0x0D]&(0xFF<<(p)))>>(p))
// Sets the resistor mode of GPIO p to whatver m specifies
// Explanation behind bitwise magic: there are 4 total resistor mode
// registers, as each pin has 2 bits dedicated to them, so we implement
// a similar process to the MODE macro
#define RESISTOR(p,m) gpio[0x39+((p)/16)]=(gpio[0x39+((p)/16)]&(~(3<<(((p)%16)*2))))|((m)<<(((p)%16)*2))

// Mode values
#define M_INPUT  0
#define M_OUTPUT 1
#define M_ALT0   4
#define M_ALT1   5
#define M_ALT2   6
#define M_ALT3   7
#define M_ALT4   3
#define M_ALT5   2

// Output values
#define HIGH 1
#define LOW 0

// Resistor mode values
#define R_FLOAT 0
#define R_PULLUP 1
#define R_PULLDOWN 2

// Pin connections
#define SCL  3
#define SDA  2
// This connection is pretty much obligatory, since only GPIO04 has the
// alternate function of GPCLK (general purpose clock), at least by default
#define MCLK 4
#define PCLK 23
#define HS   27
#define VS   22
// The D0...7 pins must all be connected to consequetive GPIO pins
// (this is done in order to improve performance)
#define DATA 14

volatile int* gpio = NULL;
volatile int* clk = NULL;

void init_mmaps(){
    // Simple kernel calls to access physical addresses (some sources say that the memory
    // maps should be done with /dev/gpiomem or others similar)
    int fd = open("/dev/mem", O_RDWR | O_SYNC);
    gpio = (int*)mmap(NULL, BLOCK_SIZE, PROT_READ|PROT_WRITE, MAP_SHARED, fd, GPIO_PINS);
    clk = (int*)mmap(NULL, BLOCK_SIZE, PROT_READ|PROT_WRITE, MAP_SHARED, fd, GPIO_CLK);
    close(fd);
}

// Initializes the MCLK pin to output the best approximation with whole dividers in MHz
// of the provided frequency (also in MHz), returns the approximated frequency in MHz
float init_mclk(float mhz){
    // Activate GPCLK function (this isn't specific to any one GPCLK, all pins which support
    // GPCLK have it on ALT0)
    MODE(MCLK, M_ALT0);
    // Docs for this are in the BCM2835 datasheet, section 5.4 (don't trust the base addresses!!)
    // For some reason every time we write to these GPCLK registers,
    // the highest byte has to be 0x5A, as it's some sort of clock manager
    // password (huh??)
    // The addresses that we use for this setup are hardcoded to be the ones programming
    // GPCLK0, but they can be increased by 2 or 4 to program the other 2 GPCLKs
    // Disable the ENABLE bit, turn on KILL bit (just in case even though it's unsafe)
    // and clear the selected source on CM_GP0CTL register
    clk[0x1C] = 0x5A000020;
    // Wait for BUSY to go LOW
    while (clk[0x1C] & (1<<7)) usleep(1);
    // Calculate the ideal divisor to achieve the target frequency
    float f_div = 500.0 / mhz;
    // Round it and clamp it (cases shouldn't be this extreme though)
    int i_div = round(f_div);
    if      (i_div <= 0)     i_div = 1;
    // It can't exceed 12 bits
    else if (i_div > 0x1000) i_div = 0xFFF;
    // Send it to register
    clk[0x1D] = 0x5A000000 | (i_div << 12);
    // Set ENABLE bit again, set source to PLLD (500MHz), disable MASH
    clk[0x1C] = 0x5A000016;
    // Return the approximated frequency
    return 500.0 / ((float)i_div);
}

int main(){
    init_mmaps();
    float f = init_mclk(24.0);
    printf("MCLK outputing %fMHz\n", f);
    MODE(VS, M_INPUT);
    int was_vs = 0;
    while(1){
        int is_vs = INPUT(VS);
        if ((!was_vs) && is_vs) printf("VS rising edge\n");
        was_vs = is_vs;
    }
    return 0;
}

