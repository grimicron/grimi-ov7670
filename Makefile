CC = gcc
CFLAGS = -lc -lwiringPi -Wall -Wextra -Wpedantic

main: main.c
	$(CC) -o main main.c $(CFLAGS)

