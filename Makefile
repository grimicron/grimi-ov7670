CC = gcc
FLAGS = -Wall -Wextra -Wpedantic -Ofast
ASMFLAGS = -fno-asynchronous-unwind-tables -fno-dwarf2-cfi-asm
COMPFLAGS = -lc -lm

asm: main.c
	$(CC) -S main.s main.c $(FLAGS) $(ASMFLAGS)

main: cam_get_frame_fast.S main.c
	$(CC) -o main main.c cam_get_frame_fast.S $(FLAGS) $(COMPFLAGS)

