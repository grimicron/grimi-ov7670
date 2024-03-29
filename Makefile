CC = gcc
CFLAGS = -lc -lm -lwiringPi -Wall -Wextra -Wpedantic

main: main.c
	$(CC) -o main main.c $(CFLAGS)

