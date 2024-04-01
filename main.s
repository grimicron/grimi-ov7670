	.arch armv8-a
	.file	"main.c"
	.text
	.global	gpio
	.bss
	.align	3
	.type	gpio, %object
	.size	gpio, 8
gpio:
	.zero	8
	.global	clk
	.align	3
	.type	clk, %object
	.size	clk, 8
clk:
	.zero	8
	.text
	.align	2
	.global	RESISTOR
	.type	RESISTOR, %function
RESISTOR:
.LFB6:
	.cfi_startproc
	stp	x29, x30, [sp, -32]!
	.cfi_def_cfa_offset 32
	.cfi_offset 29, -32
	.cfi_offset 30, -24
	mov	x29, sp
	str	w0, [sp, 28]
	str	w1, [sp, 24]
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	add	x0, x0, 148
	ldr	w1, [sp, 24]
	str	w1, [x0]
	mov	w0, 150
	bl	usleep
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	add	x0, x0, 152
	ldr	w1, [sp, 28]
	mov	w2, 1
	lsl	w1, w2, w1
	str	w1, [x0]
	mov	w0, 150
	bl	usleep
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	add	x0, x0, 152
	str	wzr, [x0]
	nop
	ldp	x29, x30, [sp], 32
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE6:
	.size	RESISTOR, .-RESISTOR
	.section	.rodata
	.align	3
.LC0:
	.string	"/dev/mem"
	.text
	.align	2
	.global	init_mmaps
	.type	init_mmaps, %function
init_mmaps:
.LFB7:
	.cfi_startproc
	stp	x29, x30, [sp, -32]!
	.cfi_def_cfa_offset 32
	.cfi_offset 29, -32
	.cfi_offset 30, -24
	mov	x29, sp
	mov	w1, 4098
	movk	w1, 0x10, lsl 16
	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
	bl	open
	str	w0, [sp, 28]
	mov	x5, 4263510016
	ldr	w4, [sp, 28]
	mov	w3, 1
	mov	w2, 3
	mov	x1, 4096
	mov	x0, 0
	bl	mmap
	mov	x1, x0
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	str	x1, [x0]
	mov	x5, 4096
	movk	x5, 0xfe10, lsl 16
	ldr	w4, [sp, 28]
	mov	w3, 1
	mov	w2, 3
	mov	x1, 4096
	mov	x0, 0
	bl	mmap
	mov	x1, x0
	adrp	x0, clk
	add	x0, x0, :lo12:clk
	str	x1, [x0]
	ldr	w0, [sp, 28]
	bl	close
	nop
	ldp	x29, x30, [sp], 32
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE7:
	.size	init_mmaps, .-init_mmaps
	.align	2
	.global	init_mclk
	.type	init_mclk, %function
init_mclk:
.LFB8:
	.cfi_startproc
	stp	x29, x30, [sp, -48]!
	.cfi_def_cfa_offset 48
	.cfi_offset 29, -48
	.cfi_offset 30, -40
	mov	x29, sp
	str	s0, [sp, 28]
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	ldr	w0, [x0]
	and	w1, w0, -28673
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	orr	w1, w1, 16384
	str	w1, [x0]
	adrp	x0, clk
	add	x0, x0, :lo12:clk
	ldr	x0, [x0]
	add	x0, x0, 112
	mov	w1, 32
	movk	w1, 0x5a00, lsl 16
	str	w1, [x0]
	nop
.L4:
	adrp	x0, clk
	add	x0, x0, :lo12:clk
	ldr	x0, [x0]
	add	x0, x0, 112
	ldr	w0, [x0]
	and	w0, w0, 128
	cmp	w0, 0
	bne	.L4
	ldr	s0, [sp, 28]
	mov	w0, 27432
	movk	w0, 0x4dee, lsl 16
	fmov	s1, w0
	fdiv	s0, s1, s0
	str	s0, [sp, 40]
	ldr	s0, [sp, 40]
	fcvt	d0, s0
	bl	round
	fcvtzs	w0, d0
	str	w0, [sp, 44]
	ldr	w0, [sp, 44]
	cmp	w0, 0
	bgt	.L5
	mov	w0, 1
	str	w0, [sp, 44]
	b	.L6
.L5:
	ldr	w0, [sp, 44]
	cmp	w0, 4096
	ble	.L6
	mov	w0, 4095
	str	w0, [sp, 44]
.L6:
	ldr	w0, [sp, 44]
	lsl	w2, w0, 12
	adrp	x0, clk
	add	x0, x0, :lo12:clk
	ldr	x0, [x0]
	add	x0, x0, 116
	mov	w1, 1509949440
	orr	w1, w2, w1
	str	w1, [x0]
	adrp	x0, clk
	add	x0, x0, :lo12:clk
	ldr	x0, [x0]
	add	x0, x0, 112
	mov	w1, 22
	movk	w1, 0x5a00, lsl 16
	str	w1, [x0]
	ldr	s0, [sp, 44]
	scvtf	s0, s0
	mov	w0, 27432
	movk	w0, 0x4dee, lsl 16
	fmov	s1, w0
	fdiv	s0, s1, s0
	ldp	x29, x30, [sp], 48
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE8:
	.size	init_mclk, .-init_mclk
	.align	2
	.global	init_i2c
	.type	init_i2c, %function
init_i2c:
.LFB9:
	.cfi_startproc
	stp	x29, x30, [sp, -16]!
	.cfi_def_cfa_offset 16
	.cfi_offset 29, -16
	.cfi_offset 30, -8
	mov	x29, sp
	mov	w1, 2
	mov	w0, 3
	bl	RESISTOR
	mov	w1, 2
	mov	w0, 2
	bl	RESISTOR
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	add	x0, x0, 40
	mov	w1, 8
	str	w1, [x0]
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	add	x0, x0, 40
	mov	w1, 4
	str	w1, [x0]
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	ldr	w1, [x0]
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	and	w1, w1, -3585
	str	w1, [x0]
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	ldr	w1, [x0]
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	and	w1, w1, -449
	str	w1, [x0]
	nop
	ldp	x29, x30, [sp], 16
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE9:
	.size	init_i2c, .-init_i2c
	.align	2
	.global	i2c_in_use
	.type	i2c_in_use, %function
i2c_in_use:
.LFB10:
	.cfi_startproc
	stp	x29, x30, [sp, -32]!
	.cfi_def_cfa_offset 32
	.cfi_offset 29, -32
	.cfi_offset 30, -24
	mov	x29, sp
	str	wzr, [sp, 28]
	b	.L10
.L14:
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	add	x0, x0, 52
	ldr	w0, [x0]
	and	w0, w0, 8
	cmp	w0, 0
	bne	.L11
	mov	w0, 1
	b	.L12
.L11:
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	add	x0, x0, 52
	ldr	w0, [x0]
	and	w0, w0, 4
	cmp	w0, 0
	bne	.L13
	mov	w0, 1
	b	.L12
.L13:
	mov	w0, 1
	bl	usleep
	ldr	w0, [sp, 28]
	add	w0, w0, 1
	str	w0, [sp, 28]
.L10:
	ldr	w0, [sp, 28]
	cmp	w0, 9
	ble	.L14
	mov	w0, 0
.L12:
	ldp	x29, x30, [sp], 32
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE10:
	.size	i2c_in_use, .-i2c_in_use
	.align	2
	.global	i2c_start
	.type	i2c_start, %function
i2c_start:
.LFB11:
	.cfi_startproc
	stp	x29, x30, [sp, -16]!
	.cfi_def_cfa_offset 16
	.cfi_offset 29, -16
	.cfi_offset 30, -8
	mov	x29, sp
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	ldr	w0, [x0]
	and	w1, w0, -449
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	orr	w1, w1, 64
	str	w1, [x0]
	mov	w0, 5
	bl	usleep
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	ldr	w0, [x0]
	and	w1, w0, -3585
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	orr	w1, w1, 512
	str	w1, [x0]
	mov	w0, 5
	bl	usleep
	nop
	ldp	x29, x30, [sp], 16
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE11:
	.size	i2c_start, .-i2c_start
	.align	2
	.global	i2c_stop
	.type	i2c_stop, %function
i2c_stop:
.LFB12:
	.cfi_startproc
	stp	x29, x30, [sp, -16]!
	.cfi_def_cfa_offset 16
	.cfi_offset 29, -16
	.cfi_offset 30, -8
	mov	x29, sp
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	ldr	w0, [x0]
	and	w1, w0, -449
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	orr	w1, w1, 64
	str	w1, [x0]
	mov	w0, 5
	bl	usleep
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	ldr	w1, [x0]
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	and	w1, w1, -3585
	str	w1, [x0]
	mov	w0, 5
	bl	usleep
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	ldr	w1, [x0]
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	and	w1, w1, -449
	str	w1, [x0]
	mov	w0, 5
	bl	usleep
	nop
	ldp	x29, x30, [sp], 16
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE12:
	.size	i2c_stop, .-i2c_stop
	.align	2
	.global	i2c_send_addr
	.type	i2c_send_addr, %function
i2c_send_addr:
.LFB13:
	.cfi_startproc
	stp	x29, x30, [sp, -48]!
	.cfi_def_cfa_offset 48
	.cfi_offset 29, -48
	.cfi_offset 30, -40
	mov	x29, sp
	strb	w0, [sp, 31]
	str	wzr, [sp, 44]
	b	.L18
.L21:
	ldrb	w0, [sp, 31]
	and	w0, w0, 64
	cmp	w0, 0
	beq	.L19
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	ldr	w1, [x0]
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	and	w1, w1, -449
	str	w1, [x0]
	b	.L20
.L19:
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	ldr	w0, [x0]
	and	w1, w0, -449
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	orr	w1, w1, 64
	str	w1, [x0]
.L20:
	ldrb	w0, [sp, 31]
	ubfiz	w0, w0, 1, 7
	strb	w0, [sp, 31]
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	ldr	w1, [x0]
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	and	w1, w1, -3585
	str	w1, [x0]
	mov	w0, 5
	bl	usleep
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	ldr	w0, [x0]
	and	w1, w0, -3585
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	orr	w1, w1, 512
	str	w1, [x0]
	mov	w0, 5
	bl	usleep
	ldr	w0, [sp, 44]
	add	w0, w0, 1
	str	w0, [sp, 44]
.L18:
	ldr	w0, [sp, 44]
	cmp	w0, 6
	ble	.L21
	nop
	nop
	ldp	x29, x30, [sp], 48
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE13:
	.size	i2c_send_addr, .-i2c_send_addr
	.align	2
	.global	i2c_send_mode
	.type	i2c_send_mode, %function
i2c_send_mode:
.LFB14:
	.cfi_startproc
	stp	x29, x30, [sp, -32]!
	.cfi_def_cfa_offset 32
	.cfi_offset 29, -32
	.cfi_offset 30, -24
	mov	x29, sp
	strb	w0, [sp, 31]
	ldrb	w0, [sp, 31]
	cmp	w0, 0
	beq	.L23
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	ldr	w1, [x0]
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	and	w1, w1, -449
	str	w1, [x0]
	b	.L24
.L23:
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	ldr	w0, [x0]
	and	w1, w0, -449
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	orr	w1, w1, 64
	str	w1, [x0]
.L24:
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	ldr	w1, [x0]
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	and	w1, w1, -3585
	str	w1, [x0]
	mov	w0, 5
	bl	usleep
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	ldr	w0, [x0]
	and	w1, w0, -3585
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	orr	w1, w1, 512
	str	w1, [x0]
	mov	w0, 5
	bl	usleep
	nop
	ldp	x29, x30, [sp], 32
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE14:
	.size	i2c_send_mode, .-i2c_send_mode
	.align	2
	.global	i2c_get_ack
	.type	i2c_get_ack, %function
i2c_get_ack:
.LFB15:
	.cfi_startproc
	stp	x29, x30, [sp, -32]!
	.cfi_def_cfa_offset 32
	.cfi_offset 29, -32
	.cfi_offset 30, -24
	mov	x29, sp
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	ldr	w1, [x0]
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	and	w1, w1, -3585
	str	w1, [x0]
	mov	w0, 5
	bl	usleep
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	add	x0, x0, 52
	ldr	w0, [x0]
	and	w0, w0, 4
	str	w0, [sp, 28]
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	ldr	w0, [x0]
	and	w1, w0, -3585
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	orr	w1, w1, 512
	str	w1, [x0]
	mov	w0, 5
	bl	usleep
	ldr	w0, [sp, 28]
	cmp	w0, 0
	cset	w0, ne
	and	w0, w0, 255
	ldp	x29, x30, [sp], 32
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE15:
	.size	i2c_get_ack, .-i2c_get_ack
	.align	2
	.global	i2c_clock_stretch
	.type	i2c_clock_stretch, %function
i2c_clock_stretch:
.LFB16:
	.cfi_startproc
	nop
.L28:
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	add	x0, x0, 52
	ldr	w0, [x0]
	and	w0, w0, 8
	cmp	w0, 0
	beq	.L28
	nop
	nop
	ret
	.cfi_endproc
.LFE16:
	.size	i2c_clock_stretch, .-i2c_clock_stretch
	.align	2
	.global	i2c_send_byte
	.type	i2c_send_byte, %function
i2c_send_byte:
.LFB17:
	.cfi_startproc
	stp	x29, x30, [sp, -48]!
	.cfi_def_cfa_offset 48
	.cfi_offset 29, -48
	.cfi_offset 30, -40
	mov	x29, sp
	strb	w0, [sp, 31]
	str	wzr, [sp, 44]
	b	.L30
.L33:
	ldrsb	w0, [sp, 31]
	cmp	w0, 0
	bge	.L31
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	ldr	w1, [x0]
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	and	w1, w1, -449
	str	w1, [x0]
	b	.L32
.L31:
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	ldr	w0, [x0]
	and	w1, w0, -449
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	orr	w1, w1, 64
	str	w1, [x0]
.L32:
	ldrb	w0, [sp, 31]
	ubfiz	w0, w0, 1, 7
	strb	w0, [sp, 31]
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	ldr	w1, [x0]
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	and	w1, w1, -3585
	str	w1, [x0]
	mov	w0, 5
	bl	usleep
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	ldr	w0, [x0]
	and	w1, w0, -3585
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	orr	w1, w1, 512
	str	w1, [x0]
	mov	w0, 5
	bl	usleep
	ldr	w0, [sp, 44]
	add	w0, w0, 1
	str	w0, [sp, 44]
.L30:
	ldr	w0, [sp, 44]
	cmp	w0, 7
	ble	.L33
	nop
	nop
	ldp	x29, x30, [sp], 48
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE17:
	.size	i2c_send_byte, .-i2c_send_byte
	.align	2
	.global	i2c_get_byte
	.type	i2c_get_byte, %function
i2c_get_byte:
.LFB18:
	.cfi_startproc
	stp	x29, x30, [sp, -32]!
	.cfi_def_cfa_offset 32
	.cfi_offset 29, -32
	.cfi_offset 30, -24
	mov	x29, sp
	strb	wzr, [sp, 31]
	str	wzr, [sp, 24]
	b	.L35
.L36:
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	ldr	w1, [x0]
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	and	w1, w1, -3585
	str	w1, [x0]
	mov	w0, 5
	bl	usleep
	ldrb	w0, [sp, 31]
	ubfiz	w0, w0, 1, 7
	strb	w0, [sp, 31]
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	add	x0, x0, 52
	ldr	w0, [x0]
	and	w0, w0, 4
	cmp	w0, 0
	cset	w0, ne
	and	w0, w0, 255
	sxtb	w1, w0
	ldrsb	w0, [sp, 31]
	orr	w0, w1, w0
	sxtb	w0, w0
	strb	w0, [sp, 31]
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	ldr	w0, [x0]
	and	w1, w0, -3585
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	orr	w1, w1, 512
	str	w1, [x0]
	mov	w0, 5
	bl	usleep
	ldr	w0, [sp, 24]
	add	w0, w0, 1
	str	w0, [sp, 24]
.L35:
	ldr	w0, [sp, 24]
	cmp	w0, 7
	ble	.L36
	ldrb	w0, [sp, 31]
	ldp	x29, x30, [sp], 32
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE18:
	.size	i2c_get_byte, .-i2c_get_byte
	.align	2
	.global	i2c_send_ack
	.type	i2c_send_ack, %function
i2c_send_ack:
.LFB19:
	.cfi_startproc
	stp	x29, x30, [sp, -32]!
	.cfi_def_cfa_offset 32
	.cfi_offset 29, -32
	.cfi_offset 30, -24
	mov	x29, sp
	str	w0, [sp, 28]
	ldr	w0, [sp, 28]
	cmp	w0, 0
	beq	.L39
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	ldr	w1, [x0]
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	and	w1, w1, -449
	str	w1, [x0]
	b	.L40
.L39:
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	ldr	w0, [x0]
	and	w1, w0, -449
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	orr	w1, w1, 64
	str	w1, [x0]
.L40:
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	ldr	w1, [x0]
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	and	w1, w1, -3585
	str	w1, [x0]
	mov	w0, 5
	bl	usleep
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	ldr	w0, [x0]
	and	w1, w0, -3585
	adrp	x0, gpio
	add	x0, x0, :lo12:gpio
	ldr	x0, [x0]
	orr	w1, w1, 512
	str	w1, [x0]
	mov	w0, 5
	bl	usleep
	nop
	ldp	x29, x30, [sp], 32
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE19:
	.size	i2c_send_ack, .-i2c_send_ack
	.align	2
	.global	i2c_start_transmission
	.type	i2c_start_transmission, %function
i2c_start_transmission:
.LFB20:
	.cfi_startproc
	stp	x29, x30, [sp, -32]!
	.cfi_def_cfa_offset 32
	.cfi_offset 29, -32
	.cfi_offset 30, -24
	mov	x29, sp
	strb	w0, [sp, 31]
	strb	w1, [sp, 30]
	bl	i2c_in_use
	cmp	w0, 0
	beq	.L42
	mov	w0, 1
	b	.L43
.L42:
	bl	i2c_start
	ldrb	w0, [sp, 31]
	bl	i2c_send_addr
	ldrb	w0, [sp, 30]
	bl	i2c_send_mode
	bl	i2c_get_ack
	cmp	w0, 0
	beq	.L44
	mov	w0, 2
	b	.L43
.L44:
	bl	i2c_clock_stretch
	mov	w0, 0
.L43:
	ldp	x29, x30, [sp], 32
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE20:
	.size	i2c_start_transmission, .-i2c_start_transmission
	.align	2
	.global	i2c_write
	.type	i2c_write, %function
i2c_write:
.LFB21:
	.cfi_startproc
	stp	x29, x30, [sp, -32]!
	.cfi_def_cfa_offset 32
	.cfi_offset 29, -32
	.cfi_offset 30, -24
	mov	x29, sp
	strb	w0, [sp, 31]
	ldrb	w0, [sp, 31]
	bl	i2c_send_byte
	bl	i2c_get_ack
	cmp	w0, 0
	beq	.L46
	mov	w0, 1
	b	.L47
.L46:
	bl	i2c_clock_stretch
	mov	w0, 0
.L47:
	ldp	x29, x30, [sp], 32
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE21:
	.size	i2c_write, .-i2c_write
	.align	2
	.global	i2c_write_buf
	.type	i2c_write_buf, %function
i2c_write_buf:
.LFB22:
	.cfi_startproc
	stp	x29, x30, [sp, -48]!
	.cfi_def_cfa_offset 48
	.cfi_offset 29, -48
	.cfi_offset 30, -40
	mov	x29, sp
	str	x0, [sp, 24]
	str	w1, [sp, 20]
	str	wzr, [sp, 44]
	b	.L49
.L52:
	ldrsw	x0, [sp, 44]
	ldr	x1, [sp, 24]
	add	x0, x1, x0
	ldrb	w0, [x0]
	bl	i2c_write
	cmp	w0, 0
	beq	.L50
	mov	w0, 1
	b	.L51
.L50:
	ldr	w0, [sp, 44]
	add	w0, w0, 1
	str	w0, [sp, 44]
.L49:
	ldr	w1, [sp, 44]
	ldr	w0, [sp, 20]
	cmp	w1, w0
	blt	.L52
	mov	w0, 0
.L51:
	ldp	x29, x30, [sp], 48
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE22:
	.size	i2c_write_buf, .-i2c_write_buf
	.align	2
	.global	i2c_read
	.type	i2c_read, %function
i2c_read:
.LFB23:
	.cfi_startproc
	stp	x29, x30, [sp, -48]!
	.cfi_def_cfa_offset 48
	.cfi_offset 29, -48
	.cfi_offset 30, -40
	mov	x29, sp
	str	w0, [sp, 28]
	bl	i2c_get_byte
	strb	w0, [sp, 47]
	ldr	w0, [sp, 28]
	bl	i2c_send_ack
	bl	i2c_clock_stretch
	ldrb	w0, [sp, 47]
	ldp	x29, x30, [sp], 48
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE23:
	.size	i2c_read, .-i2c_read
	.section	.rodata
	.align	3
.LC1:
	.string	"MCLK outputing %fMHz\n"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
.LFB24:
	.cfi_startproc
	stp	x29, x30, [sp, -32]!
	.cfi_def_cfa_offset 32
	.cfi_offset 29, -32
	.cfi_offset 30, -24
	mov	x29, sp
	bl	init_mmaps
	mov	w0, 6912
	movk	w0, 0x4c37, lsl 16
	fmov	s0, w0
	bl	init_mclk
	str	s0, [sp, 28]
	ldr	s0, [sp, 28]
	fcvt	d0, s0
	adrp	x0, .LC1
	add	x0, x0, :lo12:.LC1
	bl	printf
	bl	init_i2c
	mov	w1, 0
	mov	w0, 66
	bl	i2c_start_transmission
	bl	i2c_stop
	mov	w0, 0
	ldp	x29, x30, [sp], 32
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE24:
	.size	main, .-main
	.ident	"GCC: (Debian 12.2.0-14) 12.2.0"
	.section	.note.GNU-stack,"",@progbits
