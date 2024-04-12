#include "constants.h"

.arch armv8-a
.global cam_get_frame_fast
cam_get_frame_fast:
    // Register purposes:
    // r0: base image buffer pointer
    // r1: GPIO input register pointer
    // r2: GPIO input value
    // r3: image buffer offset counter
    // r4: image buffer end counter
    // r5: event detect register reset value
    // The calling conventions for ARM say that only x0-3 can be modified after a function
    // call, while all others should be perserved, so we have to store the 2 extra registers
    // that we will be using in the stack
    stp x4, x5, [sp, #-16]!
    // The argument buf is stored in x0, and the GPIO base in x1
    // Offset x1 to the input register
    add x1, x1, #0x34
    // Initialize registers
    eor x3, x3, x3
    eor x4, x4, x4
    mov x3, #CAM_IMG_HEIGHT
    mov x4, #CAM_IMG_WIDTH
    mul x4, x4, x3
    mov x3, #CAM_IMG_BPP
    mul x4, x4, x3
    add x4, x4, x0
    mov x3, x0
    mov x5, #1
    lsl x5, x5, #PCLK
    // Wait for VS to go HIGH
.CAM_VS_WAIT_HIGH:
    ldr w2, [x1]
    tbz w2, #VS, .CAM_VS_WAIT_HIGH
.CAM_GET_PCLK:
    // Check if we are at the end of the image
    cmp x3, x4
    beq .CAM_GET_FRAME_FAST_END
// Since all other events except for the rising edge detect should be disabled for the
// PCLK pin, we can wait to detect an event to know when we receive a PCLK pulse
/*
.CAM_PCLK_WAIT_RISE:
    ldr w2, [x1]
    tbz w2, #PCLK, .CAM_PCLK_WAIT_RISE
    // Store value at pins DATA+0..7 in buffer
    ldr w2, [x1]
    lsr w2, w2, #DATA
    strb w2, [x3]
    // Increase index
    add x3, x3, #1
    // Reset event register
    str x5, [x1]
    // Repeat loop
    b .CAM_GET_PCLK
*/

// Wait for PCLK pulse
.CAM_PCLK_WAIT_HIGH:
    ldr w2, [x1]
    tbz w2, #PCLK, .CAM_PCLK_WAIT_HIGH
.CAM_STORE_PIXEL:
    // Store value at pins DATA+0..7 in buffer
    nop
    ldr w2, [x1]
    lsr w2, w2, #DATA
    strb w2, [x3]
    add x3, x3, #1
// Wait for PCLK pulse to end
.CAM_PCLK_WAIT_LOW:
    ldr w2, [x1]
    tbnz w2, #PCLK, .CAM_PCLK_WAIT_LOW
    b .CAM_GET_PCLK


.CAM_GET_FRAME_FAST_END:
    // Reload registers from stack
    ldp x4, x5, [sp], #16
    ret

