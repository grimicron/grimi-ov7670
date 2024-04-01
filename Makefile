CC = gcc
CFLAGS = -lc -lm -lwiringPi -Wall -Wextra -Wpedantic

asm: main.c
	$(CC) -c main main.c $(CFLAGS) -S

main: main.c
	$(CC) -o main main.c $(CFLAGS)

