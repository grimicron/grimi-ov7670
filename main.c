// DOCS:
// ~/gitrepos/WiringPi (WiringPi source)
// https://www.raspberrypi.org/app/uploads/2012/02/BCM2835-ARM-Peripherals.pdf (BCM2835 datasheet)
// https://raspberrypi.stackexchange.com/questions/50406/multiple-clock-outputs-from-rpi (relevant thread on GPCLK)
// https://www.reddit.com/r/raspberry_pi/comments/e9kffn/help_with_gpclk_i_have_checked_my_approach_for/ (relevant thread on GPCLK)
// https://pinout.xyz/pinout/gpclk (RPi pinouts, info on GPCLK)
// https://web.mit.edu/6.111/www/f2016/tools/OV7670_2006.pdf (OV7670 datasheet)
// https://www.ti.com/lit/an/slva704/slva704.pdf?ts=1711951306149 (I2C protocol datasheet) 
// https://www.prodigytechno.com/i2c-clock-stretching (on I2C clock stretching)

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <unistd.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <math.h>

// Datasheets and docs are all over the place with this (see BCM2835 datasheet sections
// 1.1 and 6.1), some say that it's 0x7E000000, others say 0xFE000000, others say both,
// but 0xFE000000 has worked for me (I'm pretty sure there's a ton of kernel/model 
// revision/signed integer magic around this)
#define GPIO_BASE 0xFE000000
#define GPIO_CLK  (GPIO_BASE + 0x00101000)
#define GPIO_PINS (GPIO_BASE + 0x00200000)
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
#define R_DOWN 1
#define R_UP 2

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

// Will be approximated as accurately as possible, in Hz
#define MCLK_FREQ 10000000

#define I2C_WRITE_MODE 0
#define I2C_READ_MODE 1
// Since I2C is done using software, bit-banging, the fastest way we have
// of creating timings is with usleep, which can only wait up to 1 microsecond,
// meaning the maximum frequency we can achieve is 500KHz (theoretically, in
// practice the maximum would be slightly slower), in Hz
#define I2C_FREQ 100000
// We divide it by 2f because each cycle takes 2 clock changes (and by extension sleeps)
// We don't have to worry about this big expression with the round function, as the
// compiler automatically evaluates it (yes, I looked at the machine codes it produces)
#define I2C_WAIT round(500000.0/((float)I2C_FREQ))
// This is only te first 7 bits of the address, so in reality the 8-bit addresses are
// 0x42 for WRITE and 0x43 for READ
#define I2C_CAM_ADDR 0x21
// These should be coordinated with the resolution and divider settings in CAM_SETTINGS
#define CAM_IMG_WIDTH 640
#define CAM_IMG_HEIGHT 480

// It's a very good idea to have a look at the datasheet for this one
char CAM_SETTINGS[] = {
     0x12, 0x04 // RGB format
    ,0x15, 0x00 // HS acts like HREF, no PCLK during horizontal blank
    ,0x11, 0x00 // Divide internal clock by 1
};

volatile int* gpio = NULL;
volatile int* clk = NULL;
// char* is just as space and speed efficient as int*, since the instruction set for this ARM
// CPU (Cortex A-72) permits 1 byte-aligned accesses and the compiler makes full use of them (I checked
// the assembly)
char** img = NULL;

// Sets the pull-down/pull-up resistor of p to the mode specified by m, only working for GPIO 0-31
// This is a VERY slow operation since it has to wait twice for clock signals to stabilise,
// so it should be used SPARINGLY
// As much as I would like for this to be a macro, the process is just too complex to fit
// it all into one, but it still uses the same nomenclature
void RESISTOR(int p, int m){
    // GPPUD 0x25
    // GPPUDCLK0 0x26
    // Set the mode on GPPUD
    gpio[0x25] = m;
    // Datasheet says we have to wait 150 cycles of a clock, but it doesn't say the
    // the frequency of the clock, so we assume a 1MHz clock which is pretty slow
    usleep(150);
    // Clock the pin we want to apply the changes to in GPPUDCLK0
    gpio[0x26] = 1<<p;
    // Wait again
    usleep(150);
    // Reset GPPUDCLK0
    gpio[0x26] = 0x00000000;
}

void init_mmaps(){
    // Simple kernel calls to access physical addresses (some sources say that the memory
    // maps should be done with /dev/gpiomem or others similar)
    int fd = open("/dev/mem", O_RDWR | O_SYNC);
    gpio = (int*)mmap(NULL, BLOCK_SIZE, PROT_READ|PROT_WRITE, MAP_SHARED, fd, GPIO_PINS);
    clk = (int*)mmap(NULL, BLOCK_SIZE, PROT_READ|PROT_WRITE, MAP_SHARED, fd, GPIO_CLK);
    close(fd);
}

// Called once at the beginning of the program
void i2c_init(){
    // I2C buses have both lines pulled up HIGH (for this same reason, the pins
    // selected for I2C must have the capacity to be pulled HIGH by a resistor, which
    // is specified in the BCM2835 datasheet for each pin)
    RESISTOR(SCL, R_UP);
    RESISTOR(SDA, R_UP);
    // Mode INPUT for the I2C pins is the same as HIGH, as the lines
    // are pulled up, while mode OUTPUT is the same as LOW, as the output
    // driver is tied to ground when producing a LOW signal, draining the line
    OUTPUT(SCL, LOW);
    OUTPUT(SDA, LOW);
    MODE(SCL, M_INPUT);
    MODE(SDA, M_INPUT);
}

// Checks if the I2C line is in use, waits an entire clock cycle just to make sure, but because
// of that it's a relatively slow operation
// Returns 0 if it didn't detect the I2C line to be in use, otherwise returns 1
int i2c_in_use(){
    for (int i = 0; i < (2*I2C_WAIT); i++){
        if (!INPUT(SCL)) return 1;
        if (!INPUT(SDA)) return 1;
        usleep(1);
    }
    return 0;
}

// Sends a START condition on the I2C line
// Can also be used for repeated starts
void i2c_start(){
    // SDA -> LOW before SCL -> LOW
    // Make sure SDA and SCL are HIGH beforehand
    MODE(SDA, M_INPUT);
    usleep(I2C_WAIT);
    MODE(SCL, M_INPUT);
    usleep(I2C_WAIT);
    // Actually send START signal
    MODE(SDA, M_OUTPUT);
    usleep(I2C_WAIT);
    MODE(SCL, M_OUTPUT);
    usleep(I2C_WAIT);
}

// Sends a STOP condition on the I2C line
void i2c_stop(){
    // SDA -> HIGH before SCL -> LOW
    // Make sure SDA is LOW beforehand
    MODE(SDA, M_OUTPUT);
    usleep(I2C_WAIT);
    // Actually send STOP signal
    MODE(SCL, M_INPUT);
    usleep(I2C_WAIT);
    MODE(SDA, M_INPUT);
    usleep(I2C_WAIT);
}

// Sends the address is the 7 bit address, so it shouldn't exceed 0x7F
void i2c_send_addr(char addr){
    for (int i = 0; i < 7; i++){
        if (addr & 0x40) MODE(SDA, M_INPUT);
        else             MODE(SDA, M_OUTPUT);
        // Shift bits right to compare next bit next loop
        addr <<= 1;
        MODE(SCL, M_INPUT);
        usleep(I2C_WAIT);
        MODE(SCL, M_OUTPUT);
        usleep(I2C_WAIT);
    }
}

// Sends the last bit of the address at the beginning of the transmission
void i2c_send_mode(char mode){
    // WRITE mode (0) is indicated by a LOW pulse on the line, viceversa
    // for READ mode (1)
    if (mode) MODE(SDA, M_INPUT);
    else      MODE(SDA, M_OUTPUT);
    MODE(SCL, M_INPUT);
    usleep(I2C_WAIT);
    MODE(SCL, M_OUTPUT);
    usleep(I2C_WAIT);
}

// Returns 0 if ACK was received, 1 if NACK was received
int i2c_get_ack(){
    MODE(SCL, M_INPUT);
    usleep(I2C_WAIT);
    // The slave may stretch the clock so service internal interrupts or processing,
    // so we have to wait for it after releasing the line
    while (!INPUT(SCL));
    int ack = INPUT(SDA);
    MODE(SCL, M_OUTPUT);
    usleep(I2C_WAIT);
    return !!ack;
}

// Writes a byte of data to the I2C line
void i2c_send_byte(char byte){
    // Same idea as i2c_send_addr but for 8 bits
    for (int i = 0; i < 8; i++){
        if (byte & 0x80) MODE(SDA, M_INPUT);
        else             MODE(SDA, M_OUTPUT);
        byte <<= 1;
        MODE(SCL, M_INPUT);
        usleep(I2C_WAIT);
        MODE(SCL, M_OUTPUT);
        usleep(I2C_WAIT);
    } 
}

// Receives a byte of data from the I2C slave, I2C_READ_MODE must have been set when
// starting the transmission
char i2c_get_byte(){
    char val = 0x00;
    for (int i = 0; i < 8; i++){
        MODE(SCL, M_INPUT);
        usleep(I2C_WAIT);
        // Shift val left to keep the bits coming into the LSB
        val <<= 1;
        // Turn the INPUT macro into return either 1 or 0
        val |= !!INPUT(SDA);
        MODE(SCL, M_OUTPUT);
        usleep(I2C_WAIT);
    }
    return val;
}


// Sends ACK if ack is 0, otherwise sends NACK 
void i2c_send_ack(int ack){
    if (ack) MODE(SDA, M_INPUT);
    else     MODE(SDA, M_OUTPUT);
    MODE(SCL, M_INPUT);
    usleep(I2C_WAIT);
    // Same clock stretching idea as in get_ack
    while (!INPUT(SCL));
    MODE(SCL, M_OUTPUT);
    usleep(I2C_WAIT);
}

// Begins the I2C transmission properly
// Return codes:
// 0 -> no error
// 1 -> I2C line in use
// 2 -> NACK received
int i2c_start_transmission(char addr, char mode){
    if (i2c_in_use()) return 1;
    i2c_start();
    i2c_send_addr(addr);
    i2c_send_mode(mode);
    if (i2c_get_ack()) return 2;
    return 0;
}

// Sends a byte on the I2C line properly
// Returns 0 if ACK was received, otherwise returns 1
int i2c_write(char byte){
    i2c_send_byte(byte);
    return i2c_get_ack();
}

// Writes a buffer of bytes to the I2C line
// Returns 0 if ACK was received at any pouint, otherwise returns 1
int i2c_write_buf(char* buf, int len){
    for (int i = 0; i < len; i++){
        if (i2c_write(buf[i])) return 1;
    }
    return 0;
}

// Reads a byte from the I2C line and retrusn it
// Sends ACK if ack is 0, otherwise responds with a NACK
// If this is the last byte to be received before the transmission ends, a NACK
// should in theory be sent, but I don't think it absolutely breaks everything
// if an ACK is sent and then a STOP
char i2c_read(int ack){
    char val = i2c_get_byte();
    i2c_send_ack(ack);
    return val;
}

void cam_init_pins(){
    // Basically all pins are on INPUT mode, the I2C pins are taken care of by the i2c_init function
    for (int i = 0; i < 8; i++){
        MODE(DATA+i, M_INPUT);
        RESISTOR(DATA+i, R_FLOAT);
    }
    MODE(VS, M_INPUT);
    RESISTOR(VS, R_FLOAT);
    MODE(HS, M_INPUT);
    RESISTOR(HS, R_FLOAT);
    MODE(PCLK, M_INPUT);
    RESISTOR(PCLK, R_FLOAT);
    // Activate GPCLK function (this isn't specific to any one GPCLK, all pins which support
    // GPCLK have it on ALT0)
    MODE(MCLK, M_ALT0);
    RESISTOR(MCLK, R_FLOAT);
}

// Initializes the MCLK pin to output the best approximation with whole dividers in MHz
// of the provided frequency (also in MHz), returns the approximated frequency in MHz
float cam_init_mclk(float hz){
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
    while (clk[0x1C] & (1<<7));
    // Calculate the ideal divisor to achieve the target frequency
    float f_div = 500000000.0 / (float)hz;
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
    return 500000000.0 / ((float)i_div);
}

void cam_init_settings(){
    int res = i2c_start_transmission(I2C_CAM_ADDR, I2C_WRITE_MODE);
    if (res == 1){
        i2c_stop();
        printf("Initialization of camera settings failed (I2C line was in use)\n");
        return;
    }
    else if (res == 2){
        i2c_stop();
        printf("Initialization of camera settings failed (camera not found on I2C line, maybe address 0x%02x is wrong?)\n", I2C_CAM_ADDR);
        return;
    }
    // We don't need to divide the size of CAM_SETTINGS since it's already in bytes
    res = i2c_write_buf(CAM_SETTINGS, sizeof(CAM_SETTINGS));
    if (res){
        i2c_stop();
        printf("Initialization of camera settings failed (NACK received when sending settings)\n");
        return;
    }
    i2c_stop();
    printf("Initialization of camera settings successful\n");
}

char** cam_init_buffer(){
    // We split the buffer into memory blocks in order to avoid situations where
    // malloc fails because there aren't enough continuous free memory blocks
    char** buf = (char**)malloc(sizeof(char*) * CAM_IMG_HEIGHT);
    for (int i = 0; i < CAM_IMG_HEIGHT; i++){
        // We don't need to multiply by a size since we know a char is 1 byte
        buf[i] = (char*)malloc(CAM_IMG_WIDTH);
    }
	return buf;
}

// Writes the raw data to the buffer given to it
// The buffer should be an array with CAM_IMG_HEIGHT pointers to char arrays
// with CAM_IMG_WIDTH entries
void cam_get_frame(char** buf){
    // Wait for new frame
    while (!INPUT(VS));
    while (INPUT(VS));
    for (int i = 0; i < CAM_IMG_HEIGHT; i++){
        // Wait for HREF
        while (!INPUT(HS));
        for (int j = 0; j < CAM_IMG_WIDTH; j++){
            while (!INPUT(PCLK));
            // Receive byte while PCLK is HIGH
            buf[i][j] = BYTEIN(DATA);
            while (INPUT(PCLK));
        }
        while (INPUT(HS));
    }
}

void cam_setup(){
    init_mmaps();
    printf("Memory maps to GPIO (%p) and GPCLK (%p) registers successful\n", (void*)GPIO_PINS, (void*)GPIO_CLK);
    cam_init_pins();
    printf("Pins assigned correct function\n");
    float out_freq = cam_init_mclk(MCLK_FREQ);
    printf("MCLK outputing %.2fMHz\n", out_freq/1000000.0);
    i2c_init();
    printf("I2C line initialized at %.2fKHz\n", (float)I2C_FREQ/1000.0);
    cam_init_settings();
    img = cam_init_buffer();
    printf("Camera image buffer allocated (%d bytes)\n", CAM_IMG_HEIGHT*CAM_IMG_WIDTH);

}

int main(){
    cam_setup();
	while (1){
		cam_get_frame(img);
		printf("Camera frame captured\n");
	}
    return 0;
}

