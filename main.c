#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <unistd.h>
#include <sys/mman.h>
#include <fcntl.h>

// I'm very comfortable working with these types, but I want to be
// really pedantic about their size just in case
#define byte uint8_t
#define short int16_t
#define int int32_t
#define long int64_t

// All of the code communicating with the kernel and mapping
// the physical memory is taken from the wiringPi library
// In some cases it is /dev/mem or /dev/gpiomem0
#define GPIO_MEM_PATH "/dev/gpiomem" 
#define GPIO_PERI 0x7E000000
#define GPIO_PADS  (GPIO_PERI + 0x00100000)
#define GPIO_CLOCK (GPIO_PERI + 0x00101000)
#define GPIO_BASE  (GPIO_PERI + 0x00200000)
#define GPIO_TIMER (GPIO_PERI + 0x0000B000)
#define GPIO_PWM   (GPIO_PERI + 0x0020C000)
#define BLOCK_SIZE (1024*4)

int main(int argc, char** argv){
	int fd = open(GPIO_MEM_PATH, O_RDWR | O_SYNC | O_CLOEXEC);
	int* gpio = (int*)mmap(NULL, BLOCK_SIZE, PROT_READ|PROT_WRITE, MAP_SHARED, fd, GPIO_BASE);
	*(gpio + 0x00000002) = 1 << 18;
	for (int i = 0; i < 10; i++){
		*(gpio + 0x0000007) = 1 << 26;
		printf("LED on\n");
		usleep(250000);
		*(gpio + 0x000000A) = 1 << 26;
		printf("LED off\n");
		usleep(250000);
	}
	return 0;
}

