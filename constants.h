// Datasheets and docs are all over the place with this (see BCM2835 datasheet sections
// 1.1 and 6.1), some say that it's 0x7E000000, others say 0xFE000000, others say both,
// but 0xFE000000 has worked for me (I'm pretty sure there's a ton of kernel/model 
// revision/signed integer magic around this)
#define GPIO_BASE 0xFE000000
#define GPIO_CLK  (GPIO_BASE + 0x00101000)
#define GPIO_PINS (GPIO_BASE + 0x00200000)
#define BLOCK_SIZE (1024*4)

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

// These should be coordinated with the resolution and divider settings in CAM_SETTINGS in main.c
#define CAM_IMG_WIDTH 640
#define CAM_IMG_HEIGHT 480
// Bytes per pixel, is usually 2 can be be 1 if the camera is returning raw data
#define CAM_IMG_BPP 2
#define CAM_IMG_SIZE (CAM_IMG_WIDTH*CAM_IMG_HEIGHT*CAM_IMG_BPP)

