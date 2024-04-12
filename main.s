	.arch armv8-a
	.file	"main.c"
	.text
	.align	2
	.p2align 4,,11
	.global	RESISTOR
	.type	RESISTOR, %function
RESISTOR:
.LFB22:
	stp	x29, x30, [sp, -32]!
.LCFI0:
	mov	x29, sp
	stp	x19, x20, [sp, 16]
.LCFI1:
	adrp	x19, .LANCHOR0
	mov	w20, w0
	ldr	x2, [x19, #:lo12:.LANCHOR0]
	mov	w0, 150
	str	w1, [x2, 148]
	bl	usleep
	ldr	x2, [x19, #:lo12:.LANCHOR0]
	mov	w1, 1
	lsl	w1, w1, w20
	mov	w0, 150
	str	w1, [x2, 152]
	bl	usleep
	ldr	x0, [x19, #:lo12:.LANCHOR0]
	ldp	x19, x20, [sp, 16]
	str	wzr, [x0, 152]
	ldp	x29, x30, [sp], 32
.LCFI2:
	ret
.LFE22:
	.size	RESISTOR, .-RESISTOR
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"/dev/mem"
	.text
	.align	2
	.p2align 4,,11
	.global	init_mmaps
	.type	init_mmaps, %function
init_mmaps:
.LFB23:
	stp	x29, x30, [sp, -32]!
.LCFI3:
	mov	w1, 4098
	movk	w1, 0x10, lsl 16
	mov	x29, sp
	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
	stp	x19, x20, [sp, 16]
.LCFI4:
	bl	open
	mov	x5, 4263510016
	mov	w19, w0
	mov	w4, w0
	mov	w3, 1
	mov	w2, 3
	mov	x1, 4096
	mov	x0, 0
	bl	mmap
	adrp	x1, .LANCHOR0
	add	x20, x1, :lo12:.LANCHOR0
	mov	x5, 4096
	mov	w4, w19
	str	x0, [x1, #:lo12:.LANCHOR0]
	mov	x1, 4096
	movk	x5, 0xfe10, lsl 16
	mov	w3, 1
	mov	w2, 3
	mov	x0, 0
	bl	mmap
	mov	x1, x0
	str	x1, [x20, 8]
	mov	w0, w19
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 32
.LCFI5:
	b	close
.LFE23:
	.size	init_mmaps, .-init_mmaps
	.align	2
	.p2align 4,,11
	.global	i2c_init
	.type	i2c_init, %function
i2c_init:
.LFB24:
	stp	x29, x30, [sp, -48]!
.LCFI6:
	mov	w0, 150
	mov	x29, sp
	stp	x19, x20, [sp, 16]
.LCFI7:
	adrp	x19, .LANCHOR0
	mov	w20, 4
	ldr	x1, [x19, #:lo12:.LANCHOR0]
	stp	x21, x22, [sp, 32]
.LCFI8:
	mov	w22, 2
	mov	w21, 8
	str	w22, [x1, 148]
	bl	usleep
	ldr	x1, [x19, #:lo12:.LANCHOR0]
	mov	w0, 150
	str	w21, [x1, 152]
	bl	usleep
	ldr	x1, [x19, #:lo12:.LANCHOR0]
	mov	w0, 150
	str	wzr, [x1, 152]
	str	w22, [x1, 148]
	bl	usleep
	ldr	x1, [x19, #:lo12:.LANCHOR0]
	mov	w0, 150
	str	w20, [x1, 152]
	bl	usleep
	ldr	x0, [x19, #:lo12:.LANCHOR0]
	str	wzr, [x0, 152]
	str	w21, [x0, 40]
	str	w20, [x0, 40]
	ldp	x19, x20, [sp, 16]
	ldr	w1, [x0]
	ldp	x21, x22, [sp, 32]
	and	w1, w1, -3585
	str	w1, [x0]
	ldr	w1, [x0]
	and	w1, w1, -449
	str	w1, [x0]
	ldp	x29, x30, [sp], 48
.LCFI9:
	ret
.LFE24:
	.size	i2c_init, .-i2c_init
	.align	2
	.p2align 4,,11
	.global	i2c_in_use
	.type	i2c_in_use, %function
i2c_in_use:
.LFB25:
	stp	x29, x30, [sp, -32]!
.LCFI10:
	mov	x29, sp
	stp	x19, x20, [sp, 16]
.LCFI11:
	mov	w19, 10
	adrp	x20, .LANCHOR0
	.p2align 3,,7
.L10:
	ldr	x1, [x20, #:lo12:.LANCHOR0]
	mov	w0, 1
	ldr	w2, [x1, 52]
	tbz	x2, 3, .L12
	ldr	w1, [x1, 52]
	tbz	x1, 2, .L12
	bl	usleep
	subs	w19, w19, #1
	bne	.L10
	ldp	x19, x20, [sp, 16]
	mov	w0, 0
	ldp	x29, x30, [sp], 32
.LCFI12:
	ret
	.p2align 2,,3
.L12:
.LCFI13:
	ldp	x19, x20, [sp, 16]
	mov	w0, 1
	ldp	x29, x30, [sp], 32
.LCFI14:
	ret
.LFE25:
	.size	i2c_in_use, .-i2c_in_use
	.align	2
	.p2align 4,,11
	.global	i2c_start
	.type	i2c_start, %function
i2c_start:
.LFB26:
	stp	x29, x30, [sp, -32]!
.LCFI15:
	mov	w0, 5
	mov	x29, sp
	str	x19, [sp, 16]
.LCFI16:
	adrp	x19, .LANCHOR0
	ldr	x2, [x19, #:lo12:.LANCHOR0]
	ldr	w1, [x2]
	and	w1, w1, -449
	str	w1, [x2]
	bl	usleep
	ldr	x2, [x19, #:lo12:.LANCHOR0]
	mov	w0, 5
	ldr	w1, [x2]
	and	w1, w1, -3585
	str	w1, [x2]
	bl	usleep
	ldr	x2, [x19, #:lo12:.LANCHOR0]
	mov	w0, 5
	ldr	w1, [x2]
	and	w1, w1, -449
	orr	w1, w1, 64
	str	w1, [x2]
	bl	usleep
	ldr	x2, [x19, #:lo12:.LANCHOR0]
	mov	w0, 5
	ldr	x19, [sp, 16]
	ldr	w1, [x2]
	and	w1, w1, -3585
	orr	w1, w1, 512
	str	w1, [x2]
	ldp	x29, x30, [sp], 32
.LCFI17:
	b	usleep
.LFE26:
	.size	i2c_start, .-i2c_start
	.align	2
	.p2align 4,,11
	.global	i2c_stop
	.type	i2c_stop, %function
i2c_stop:
.LFB27:
	stp	x29, x30, [sp, -32]!
.LCFI18:
	mov	w0, 5
	mov	x29, sp
	str	x19, [sp, 16]
.LCFI19:
	adrp	x19, .LANCHOR0
	ldr	x2, [x19, #:lo12:.LANCHOR0]
	ldr	w1, [x2]
	and	w1, w1, -449
	orr	w1, w1, 64
	str	w1, [x2]
	bl	usleep
	ldr	x2, [x19, #:lo12:.LANCHOR0]
	mov	w0, 5
	ldr	w1, [x2]
	and	w1, w1, -3585
	str	w1, [x2]
	bl	usleep
	ldr	x2, [x19, #:lo12:.LANCHOR0]
	mov	w0, 5
	ldr	x19, [sp, 16]
	ldr	w1, [x2]
	and	w1, w1, -449
	str	w1, [x2]
	ldp	x29, x30, [sp], 32
.LCFI20:
	b	usleep
.LFE27:
	.size	i2c_stop, .-i2c_stop
	.align	2
	.p2align 4,,11
	.global	i2c_send_addr
	.type	i2c_send_addr, %function
i2c_send_addr:
.LFB28:
	stp	x29, x30, [sp, -48]!
.LCFI21:
	mov	x29, sp
	stp	x19, x20, [sp, 16]
.LCFI22:
	and	w19, w0, 255
	mov	w20, 7
	str	x21, [sp, 32]
.LCFI23:
	adrp	x21, .LANCHOR0
	b	.L23
	.p2align 2,,3
.L30:
	ldr	w2, [x1]
	ubfiz	w19, w19, 1, 7
	and	w2, w2, -449
.L28:
	str	w2, [x1]
	ldr	w2, [x1]
	and	w2, w2, -3585
	str	w2, [x1]
	bl	usleep
	ldr	x2, [x21, #:lo12:.LANCHOR0]
	mov	w0, 5
	ldr	w1, [x2]
	and	w1, w1, -3585
	orr	w1, w1, 512
	str	w1, [x2]
	bl	usleep
	subs	w20, w20, #1
	beq	.L29
.L23:
	ldr	x1, [x21, #:lo12:.LANCHOR0]
	mov	w0, 5
	tbnz	x19, 6, .L30
	ldr	w2, [x1]
	ubfiz	w19, w19, 1, 7
	mov	w0, 5
	and	w2, w2, -449
	orr	w2, w2, 64
	b	.L28
	.p2align 2,,3
.L29:
	ldp	x19, x20, [sp, 16]
	ldr	x21, [sp, 32]
	ldp	x29, x30, [sp], 48
.LCFI24:
	ret
.LFE28:
	.size	i2c_send_addr, .-i2c_send_addr
	.align	2
	.p2align 4,,11
	.global	i2c_send_mode
	.type	i2c_send_mode, %function
i2c_send_mode:
.LFB29:
	stp	x29, x30, [sp, -32]!
.LCFI25:
	tst	w0, 255
	mov	x29, sp
	str	x19, [sp, 16]
.LCFI26:
	adrp	x19, .LANCHOR0
	ldr	x1, [x19, #:lo12:.LANCHOR0]
	ldr	w0, [x1]
	and	w0, w0, -449
	bne	.L35
	orr	w0, w0, 64
.L35:
	str	w0, [x1]
	mov	w0, 5
	ldr	w2, [x1]
	and	w2, w2, -3585
	str	w2, [x1]
	bl	usleep
	ldr	x2, [x19, #:lo12:.LANCHOR0]
	mov	w0, 5
	ldr	x19, [sp, 16]
	ldr	w1, [x2]
	and	w1, w1, -3585
	orr	w1, w1, 512
	str	w1, [x2]
	ldp	x29, x30, [sp], 32
.LCFI27:
	b	usleep
.LFE29:
	.size	i2c_send_mode, .-i2c_send_mode
	.align	2
	.p2align 4,,11
	.global	i2c_get_ack
	.type	i2c_get_ack, %function
i2c_get_ack:
.LFB30:
	stp	x29, x30, [sp, -32]!
.LCFI28:
	mov	w0, 5
	mov	x29, sp
	str	x19, [sp, 16]
.LCFI29:
	adrp	x19, .LANCHOR0
	ldr	x2, [x19, #:lo12:.LANCHOR0]
	ldr	w1, [x2]
	and	w1, w1, -3585
	str	w1, [x2]
	bl	usleep
	ldr	x1, [x19, #:lo12:.LANCHOR0]
	.p2align 3,,7
.L37:
	ldr	w0, [x1, 52]
	tbz	x0, 3, .L37
	ldr	w19, [x1, 52]
	mov	w0, 5
	ldr	w2, [x1]
	and	w2, w2, -3585
	orr	w2, w2, 512
	str	w2, [x1]
	bl	usleep
	ubfx	x0, x19, 2, 1
	ldr	x19, [sp, 16]
	ldp	x29, x30, [sp], 32
.LCFI30:
	ret
.LFE30:
	.size	i2c_get_ack, .-i2c_get_ack
	.align	2
	.p2align 4,,11
	.global	i2c_send_byte
	.type	i2c_send_byte, %function
i2c_send_byte:
.LFB31:
	stp	x29, x30, [sp, -48]!
.LCFI31:
	mov	x29, sp
	stp	x19, x20, [sp, 16]
.LCFI32:
	and	w20, w0, 255
	mov	w19, 8
	str	x21, [sp, 32]
.LCFI33:
	adrp	x21, .LANCHOR0
	b	.L45
	.p2align 2,,3
.L42:
	ldr	w2, [x1]
	ubfiz	w20, w20, 1, 7
	and	w2, w2, -449
	orr	w2, w2, 64
.L50:
	str	w2, [x1]
	ldr	w2, [x1]
	and	w2, w2, -3585
	str	w2, [x1]
	bl	usleep
	ldr	x2, [x21, #:lo12:.LANCHOR0]
	mov	w0, 5
	ldr	w1, [x2]
	and	w1, w1, -3585
	orr	w1, w1, 512
	str	w1, [x2]
	bl	usleep
	subs	w19, w19, #1
	beq	.L51
.L45:
	ldr	x1, [x21, #:lo12:.LANCHOR0]
	mov	w0, 5
	tbz	x20, 7, .L42
	ldr	w2, [x1]
	ubfiz	w20, w20, 1, 7
	and	w2, w2, -449
	b	.L50
	.p2align 2,,3
.L51:
	ldp	x19, x20, [sp, 16]
	ldr	x21, [sp, 32]
	ldp	x29, x30, [sp], 48
.LCFI34:
	ret
.LFE31:
	.size	i2c_send_byte, .-i2c_send_byte
	.align	2
	.p2align 4,,11
	.global	i2c_get_byte
	.type	i2c_get_byte, %function
i2c_get_byte:
.LFB32:
	stp	x29, x30, [sp, -48]!
.LCFI35:
	mov	x29, sp
	stp	x19, x20, [sp, 16]
.LCFI36:
	mov	w20, 8
	mov	w19, 0
	str	x21, [sp, 32]
.LCFI37:
	adrp	x21, .LANCHOR0
	.p2align 3,,7
.L53:
	ldr	x2, [x21, #:lo12:.LANCHOR0]
	mov	w0, 5
	ubfiz	w19, w19, 1, 7
	ldr	w1, [x2]
	and	w1, w1, -3585
	str	w1, [x2]
	bl	usleep
	ldr	x3, [x21, #:lo12:.LANCHOR0]
	mov	w0, 5
	ldr	w2, [x3, 52]
	ldr	w1, [x3]
	and	w1, w1, -3585
	ubfx	x2, x2, 2, 1
	orr	w1, w1, 512
	str	w1, [x3]
	orr	w19, w19, w2
	bl	usleep
	subs	w20, w20, #1
	bne	.L53
	ldr	x21, [sp, 32]
	mov	w0, w19
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 48
.LCFI38:
	ret
.LFE32:
	.size	i2c_get_byte, .-i2c_get_byte
	.align	2
	.p2align 4,,11
	.global	i2c_send_ack
	.type	i2c_send_ack, %function
i2c_send_ack:
.LFB33:
	stp	x29, x30, [sp, -32]!
.LCFI39:
	mov	x29, sp
	str	x19, [sp, 16]
.LCFI40:
	adrp	x19, .LANCHOR0
	ldr	x1, [x19, #:lo12:.LANCHOR0]
	cbz	w0, .L57
	ldr	w0, [x1]
	and	w0, w0, -449
	str	w0, [x1]
.L58:
	ldr	w2, [x1]
	mov	w0, 5
	and	w2, w2, -3585
	str	w2, [x1]
	bl	usleep
	ldr	x1, [x19, #:lo12:.LANCHOR0]
	.p2align 3,,7
.L59:
	ldr	w0, [x1, 52]
	tbz	x0, 3, .L59
	ldr	w2, [x1]
	mov	w0, 5
	ldr	x19, [sp, 16]
	and	w2, w2, -3585
	orr	w2, w2, 512
	str	w2, [x1]
	ldp	x29, x30, [sp], 32
.LCFI41:
	b	usleep
	.p2align 2,,3
.L57:
.LCFI42:
	ldr	w0, [x1]
	and	w0, w0, -449
	orr	w0, w0, 64
	str	w0, [x1]
	b	.L58
.LFE33:
	.size	i2c_send_ack, .-i2c_send_ack
	.align	2
	.p2align 4,,11
	.global	i2c_start_transmission
	.type	i2c_start_transmission, %function
i2c_start_transmission:
.LFB34:
	stp	x29, x30, [sp, -48]!
.LCFI43:
	mov	x29, sp
	stp	x21, x22, [sp, 32]
.LCFI44:
	and	w21, w0, 255
	and	w22, w1, 255
	stp	x19, x20, [sp, 16]
.LCFI45:
	mov	w20, 10
	adrp	x19, .LANCHOR0
	.p2align 3,,7
.L65:
	ldr	x1, [x19, #:lo12:.LANCHOR0]
	mov	w0, 1
	ldr	w2, [x1, 52]
	tbz	x2, 3, .L75
	ldr	w1, [x1, 52]
	tbz	x1, 2, .L75
	bl	usleep
	subs	w20, w20, #1
	bne	.L65
	ldr	x2, [x19, #:lo12:.LANCHOR0]
	mov	w0, 5
	mov	w20, 7
	ldr	w1, [x2]
	and	w1, w1, -449
	str	w1, [x2]
	bl	usleep
	ldr	x2, [x19, #:lo12:.LANCHOR0]
	mov	w0, 5
	ldr	w1, [x2]
	and	w1, w1, -3585
	str	w1, [x2]
	bl	usleep
	ldr	x2, [x19, #:lo12:.LANCHOR0]
	mov	w0, 5
	ldr	w1, [x2]
	and	w1, w1, -449
	orr	w1, w1, 64
	str	w1, [x2]
	bl	usleep
	ldr	x2, [x19, #:lo12:.LANCHOR0]
	mov	w0, 5
	ldr	w1, [x2]
	and	w1, w1, -3585
	orr	w1, w1, 512
	str	w1, [x2]
	bl	usleep
	b	.L70
	.p2align 2,,3
.L87:
	ldr	w2, [x1]
	ubfiz	w21, w21, 1, 7
	and	w2, w2, -449
.L84:
	str	w2, [x1]
	ldr	w2, [x1]
	and	w2, w2, -3585
	str	w2, [x1]
	bl	usleep
	ldr	x2, [x19, #:lo12:.LANCHOR0]
	mov	w0, 5
	ldr	w1, [x2]
	and	w1, w1, -3585
	orr	w1, w1, 512
	str	w1, [x2]
	bl	usleep
	subs	w20, w20, #1
	beq	.L86
.L70:
	ldr	x1, [x19, #:lo12:.LANCHOR0]
	mov	w0, 5
	tbnz	x21, 6, .L87
	ldr	w2, [x1]
	ubfiz	w21, w21, 1, 7
	mov	w0, 5
	and	w2, w2, -449
	orr	w2, w2, 64
	b	.L84
	.p2align 2,,3
.L86:
	ldr	x1, [x19, #:lo12:.LANCHOR0]
	ldr	w0, [x1]
	and	w0, w0, -449
	cbnz	w22, .L85
	orr	w0, w0, 64
.L85:
	str	w0, [x1]
	mov	w0, 5
	ldr	w2, [x1]
	and	w2, w2, -3585
	str	w2, [x1]
	bl	usleep
	ldr	x2, [x19, #:lo12:.LANCHOR0]
	mov	w0, 5
	ldr	w1, [x2]
	and	w1, w1, -3585
	orr	w1, w1, 512
	str	w1, [x2]
	bl	usleep
	ldr	x2, [x19, #:lo12:.LANCHOR0]
	mov	w0, 5
	ldr	w1, [x2]
	and	w1, w1, -3585
	str	w1, [x2]
	bl	usleep
	ldr	x1, [x19, #:lo12:.LANCHOR0]
	.p2align 3,,7
.L73:
	ldr	w0, [x1, 52]
	tbz	x0, 3, .L73
	ldr	w19, [x1, 52]
	mov	w0, 5
	ldr	w2, [x1]
	and	w2, w2, -3585
	orr	w2, w2, 512
	str	w2, [x1]
	bl	usleep
	ubfx	x0, x19, 2, 1
	ldp	x19, x20, [sp, 16]
	lsl	w0, w0, 1
	ldp	x21, x22, [sp, 32]
	ldp	x29, x30, [sp], 48
.LCFI46:
	ret
	.p2align 2,,3
.L75:
.LCFI47:
	ldp	x19, x20, [sp, 16]
	mov	w0, 1
	ldp	x21, x22, [sp, 32]
	ldp	x29, x30, [sp], 48
.LCFI48:
	ret
.LFE34:
	.size	i2c_start_transmission, .-i2c_start_transmission
	.align	2
	.p2align 4,,11
	.global	i2c_write
	.type	i2c_write, %function
i2c_write:
.LFB35:
	stp	x29, x30, [sp, -48]!
.LCFI49:
	mov	x29, sp
	stp	x19, x20, [sp, 16]
.LCFI50:
	and	w19, w0, 255
	mov	w20, 8
	str	x21, [sp, 32]
.LCFI51:
	adrp	x21, .LANCHOR0
	b	.L92
	.p2align 2,,3
.L89:
	ldr	w2, [x1]
	ubfiz	w19, w19, 1, 7
	and	w2, w2, -449
	orr	w2, w2, 64
.L100:
	str	w2, [x1]
	ldr	w2, [x1]
	and	w2, w2, -3585
	str	w2, [x1]
	bl	usleep
	ldr	x2, [x21, #:lo12:.LANCHOR0]
	mov	w0, 5
	ldr	w1, [x2]
	and	w1, w1, -3585
	orr	w1, w1, 512
	str	w1, [x2]
	bl	usleep
	subs	w20, w20, #1
	beq	.L101
.L92:
	ldr	x1, [x21, #:lo12:.LANCHOR0]
	mov	w0, 5
	tbz	x19, 7, .L89
	ldr	w2, [x1]
	ubfiz	w19, w19, 1, 7
	and	w2, w2, -449
	b	.L100
	.p2align 2,,3
.L101:
	ldr	x2, [x21, #:lo12:.LANCHOR0]
	mov	w0, 5
	ldr	w1, [x2]
	and	w1, w1, -3585
	str	w1, [x2]
	bl	usleep
	ldr	x1, [x21, #:lo12:.LANCHOR0]
	.p2align 3,,7
.L93:
	ldr	w0, [x1, 52]
	tbz	x0, 3, .L93
	ldr	w19, [x1, 52]
	mov	w0, 5
	ldr	w2, [x1]
	and	w2, w2, -3585
	orr	w2, w2, 512
	str	w2, [x1]
	bl	usleep
	ldr	x21, [sp, 32]
	ubfx	x0, x19, 2, 1
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 48
.LCFI52:
	ret
.LFE35:
	.size	i2c_write, .-i2c_write
	.align	2
	.p2align 4,,11
	.global	i2c_write_buf
	.type	i2c_write_buf, %function
i2c_write_buf:
.LFB36:
	cmp	w1, 0
	ble	.L123
	stp	x29, x30, [sp, -64]!
.LCFI53:
	mov	x29, sp
	stp	x19, x20, [sp, 16]
.LCFI54:
	mov	x20, x0
	adrp	x19, .LANCHOR0
	stp	x21, x22, [sp, 32]
.LCFI55:
	add	x21, x0, w1, sxtw
	str	x23, [sp, 48]
.LCFI56:
	.p2align 3,,7
.L110:
	ldrb	w22, [x20]
	mov	w23, 8
	b	.L108
	.p2align 2,,3
.L105:
	ldr	w2, [x1]
	ubfiz	w22, w22, 1, 7
	and	w2, w2, -449
	orr	w2, w2, 64
.L122:
	str	w2, [x1]
	ldr	w2, [x1]
	and	w2, w2, -3585
	str	w2, [x1]
	bl	usleep
	ldr	x2, [x19, #:lo12:.LANCHOR0]
	mov	w0, 5
	ldr	w1, [x2]
	and	w1, w1, -3585
	orr	w1, w1, 512
	str	w1, [x2]
	bl	usleep
	subs	w23, w23, #1
	beq	.L124
.L108:
	ldr	x1, [x19, #:lo12:.LANCHOR0]
	mov	w0, 5
	tbz	x22, 7, .L105
	ldr	w2, [x1]
	ubfiz	w22, w22, 1, 7
	and	w2, w2, -449
	b	.L122
	.p2align 2,,3
.L124:
	ldr	x2, [x19, #:lo12:.LANCHOR0]
	mov	w0, 5
	ldr	w1, [x2]
	and	w1, w1, -3585
	str	w1, [x2]
	bl	usleep
	ldr	x1, [x19, #:lo12:.LANCHOR0]
	.p2align 3,,7
.L109:
	ldr	w0, [x1, 52]
	tbz	x0, 3, .L109
	ldr	w22, [x1, 52]
	mov	w0, 5
	ldr	w2, [x1]
	and	w2, w2, -3585
	orr	w2, w2, 512
	str	w2, [x1]
	bl	usleep
	tbnz	x22, 2, .L112
	add	x20, x20, 1
	cmp	x21, x20
	bne	.L110
	ldp	x19, x20, [sp, 16]
	mov	w0, 0
	ldp	x21, x22, [sp, 32]
	ldr	x23, [sp, 48]
	ldp	x29, x30, [sp], 64
.LCFI57:
	ret
.L112:
.LCFI58:
	ldp	x19, x20, [sp, 16]
	mov	w0, 1
	ldp	x21, x22, [sp, 32]
	ldr	x23, [sp, 48]
	ldp	x29, x30, [sp], 64
.LCFI59:
	ret
.L123:
	mov	w0, 0
	ret
.LFE36:
	.size	i2c_write_buf, .-i2c_write_buf
	.align	2
	.p2align 4,,11
	.global	i2c_read
	.type	i2c_read, %function
i2c_read:
.LFB37:
	stp	x29, x30, [sp, -48]!
.LCFI60:
	mov	x29, sp
	stp	x19, x20, [sp, 16]
.LCFI61:
	mov	w20, w0
	mov	w19, 0
	stp	x21, x22, [sp, 32]
.LCFI62:
	mov	w21, 8
	adrp	x22, .LANCHOR0
	.p2align 3,,7
.L126:
	ldr	x2, [x22, #:lo12:.LANCHOR0]
	mov	w0, 5
	ubfiz	w19, w19, 1, 7
	ldr	w1, [x2]
	and	w1, w1, -3585
	str	w1, [x2]
	bl	usleep
	ldr	x3, [x22, #:lo12:.LANCHOR0]
	mov	w0, 5
	ldr	w2, [x3, 52]
	ldr	w1, [x3]
	and	w1, w1, -3585
	ubfx	x2, x2, 2, 1
	orr	w1, w1, 512
	str	w1, [x3]
	orr	w19, w19, w2
	bl	usleep
	subs	w21, w21, #1
	bne	.L126
	ldr	x1, [x22, #:lo12:.LANCHOR0]
	ldr	w0, [x1]
	and	w0, w0, -449
	cbnz	w20, .L134
	orr	w0, w0, 64
.L134:
	str	w0, [x1]
	mov	w0, 5
	ldr	w2, [x1]
	and	w2, w2, -3585
	str	w2, [x1]
	bl	usleep
	ldr	x1, [x22, #:lo12:.LANCHOR0]
	.p2align 3,,7
.L129:
	ldr	w0, [x1, 52]
	tbz	x0, 3, .L129
	ldr	w2, [x1]
	mov	w0, 5
	and	w2, w2, -3585
	orr	w2, w2, 512
	str	w2, [x1]
	bl	usleep
	ldp	x21, x22, [sp, 32]
	mov	w0, w19
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 48
.LCFI63:
	ret
.LFE37:
	.size	i2c_read, .-i2c_read
	.align	2
	.p2align 4,,11
	.global	cam_init_pins
	.type	cam_init_pins, %function
cam_init_pins:
.LFB38:
	stp	x29, x30, [sp, -64]!
.LCFI64:
	mov	x29, sp
	stp	x19, x20, [sp, 16]
.LCFI65:
	adrp	x19, .LANCHOR0
	mov	w20, 1
	ldr	x3, [x19, #:lo12:.LANCHOR0]
	stp	x21, x22, [sp, 32]
.LCFI66:
	mov	w22, 52429
	movk	w22, 0xcccc, lsl 16
	mov	w21, 7
	str	x23, [sp, 48]
.LCFI67:
	mov	w23, 14
	.p2align 3,,7
.L136:
	umull	x2, w23, w22
	mov	w0, 150
	lsr	x1, x2, 35
	mov	x2, x1
	add	w1, w1, w1, lsl 2
	sub	w1, w23, w1, lsl 1
	ldr	w4, [x3, x2, lsl 2]
	add	w1, w1, w1, lsl 1
	lsl	w1, w21, w1
	bic	w1, w4, w1
	str	w1, [x3, x2, lsl 2]
	str	wzr, [x3, 148]
	bl	usleep
	ldr	x1, [x19, #:lo12:.LANCHOR0]
	lsl	w2, w20, w23
	mov	w0, 150
	add	w23, w23, 1
	str	w2, [x1, 152]
	bl	usleep
	ldr	x3, [x19, #:lo12:.LANCHOR0]
	str	wzr, [x3, 152]
	cmp	w23, 22
	bne	.L136
	ldr	w1, [x3, 8]
	mov	w0, 150
	and	w1, w1, -449
	str	w1, [x3, 8]
	str	wzr, [x3, 148]
	bl	usleep
	ldr	x1, [x19, #:lo12:.LANCHOR0]
	mov	w2, 4194304
	mov	w0, 150
	str	w2, [x1, 152]
	bl	usleep
	ldr	x1, [x19, #:lo12:.LANCHOR0]
	mov	w0, 150
	str	wzr, [x1, 152]
	ldr	w2, [x1, 8]
	and	w2, w2, -14680065
	str	w2, [x1, 8]
	str	wzr, [x1, 148]
	bl	usleep
	ldr	x1, [x19, #:lo12:.LANCHOR0]
	mov	w2, 134217728
	mov	w0, 150
	str	w2, [x1, 152]
	bl	usleep
	ldr	x1, [x19, #:lo12:.LANCHOR0]
	mov	w0, 150
	str	wzr, [x1, 152]
	ldr	w2, [x1, 8]
	and	w2, w2, -3585
	str	w2, [x1, 8]
	str	wzr, [x1, 148]
	bl	usleep
	ldr	x1, [x19, #:lo12:.LANCHOR0]
	mov	w2, 8388608
	mov	w0, 150
	str	w2, [x1, 152]
	bl	usleep
	ldr	x2, [x19, #:lo12:.LANCHOR0]
	mov	w0, 150
	str	wzr, [x2, 152]
	ldr	w1, [x2]
	and	w1, w1, -28673
	orr	w1, w1, 16384
	str	w1, [x2]
	str	wzr, [x2, 148]
	bl	usleep
	ldr	x1, [x19, #:lo12:.LANCHOR0]
	mov	w2, 16
	mov	w0, 150
	str	w2, [x1, 152]
	bl	usleep
	ldr	x0, [x19, #:lo12:.LANCHOR0]
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	ldr	x23, [sp, 48]
	str	wzr, [x0, 152]
	ldr	w1, [x0, 76]
	and	w1, w1, -8388609
	str	w1, [x0, 76]
	ldr	w1, [x0, 88]
	and	w1, w1, -8388609
	str	w1, [x0, 88]
	ldr	w1, [x0, 100]
	and	w1, w1, -8388609
	str	w1, [x0, 100]
	ldr	w1, [x0, 112]
	and	w1, w1, -8388609
	str	w1, [x0, 112]
	ldr	w1, [x0, 124]
	orr	w1, w1, 8388608
	str	w1, [x0, 124]
	ldr	w1, [x0, 136]
	and	w1, w1, -8388609
	str	w1, [x0, 136]
	ldp	x29, x30, [sp], 64
.LCFI68:
	ret
.LFE38:
	.size	cam_init_pins, .-cam_init_pins
	.align	2
	.p2align 4,,11
	.global	cam_init_mclk
	.type	cam_init_mclk, %function
cam_init_mclk:
.LFB39:
	adrp	x0, .LANCHOR0+8
	mov	w2, 32
	movk	w2, 0x5a00, lsl 16
	ldr	x1, [x0, #:lo12:.LANCHOR0+8]
	str	w2, [x1, 112]
	.p2align 3,,7
.L140:
	ldr	w0, [x1, 112]
	tbnz	x0, 7, .L140
	mov	w0, 27432
	movk	w0, 0x4dee, lsl 16
	fmov	s1, w0
	fdiv	s0, s1, s0
	fcvtas	w0, s0
	cmp	w0, 0
	ble	.L142
	cmp	w0, 4096
	bgt	.L143
	scvtf	s0, w0
	mov	w2, 1509949440
	orr	w2, w2, w0, lsl 12
	mov	w0, 22
	str	w2, [x1, 116]
	movk	w0, 0x5a00, lsl 16
	str	w0, [x1, 112]
	fdiv	s0, s1, s0
	ret
	.p2align 2,,3
.L143:
	mov	w0, 31248
	mov	w2, 61440
	movk	w0, 0x47ee, lsl 16
	movk	w2, 0x5aff, lsl 16
	fmov	s0, w0
	mov	w0, 22
	str	w2, [x1, 116]
	movk	w0, 0x5a00, lsl 16
	str	w0, [x1, 112]
	ret
	.p2align 2,,3
.L142:
	mov	w2, 4096
	mov	w0, 22
	movk	w2, 0x5a00, lsl 16
	str	w2, [x1, 116]
	movk	w0, 0x5a00, lsl 16
	fmov	s0, s1
	str	w0, [x1, 112]
	ret
.LFE39:
	.size	cam_init_mclk, .-cam_init_mclk
	.section	.rodata.str1.8
	.align	3
.LC1:
	.string	"Initialization of camera settings failed (I2C line was in use)"
	.align	3
.LC2:
	.string	"Initialization of camera settings failed (camera not found on I2C line, maybe address 0x%02x is wrong?)\n"
	.align	3
.LC3:
	.string	"Initialization of camera settings failed (NACK received when sending settings)"
	.text
	.align	2
	.p2align 4,,11
	.global	cam_init_settings
	.type	cam_init_settings, %function
cam_init_settings:
.LFB40:
	stp	x29, x30, [sp, -64]!
.LCFI69:
	mov	x29, sp
	stp	x19, x20, [sp, 16]
.LCFI70:
	mov	w20, 10
	adrp	x19, .LANCHOR0
	.p2align 3,,7
.L147:
	ldr	x1, [x19, #:lo12:.LANCHOR0]
	mov	w0, 1
	ldr	w2, [x1, 52]
	tbz	x2, 3, .L146
	ldr	w2, [x1, 52]
	tbz	x2, 2, .L146
	bl	usleep
	subs	w20, w20, #1
	bne	.L147
	ldr	x2, [x19, #:lo12:.LANCHOR0]
	stp	x21, x22, [sp, 32]
.LCFI71:
	mov	w0, 5
	mov	w21, 7
	mov	w20, 33
	ldr	w1, [x2]
	and	w1, w1, -449
	str	w1, [x2]
	bl	usleep
	ldr	x2, [x19, #:lo12:.LANCHOR0]
	mov	w0, 5
	ldr	w1, [x2]
	and	w1, w1, -3585
	str	w1, [x2]
	bl	usleep
	ldr	x2, [x19, #:lo12:.LANCHOR0]
	mov	w0, 5
	ldr	w1, [x2]
	and	w1, w1, -449
	orr	w1, w1, 64
	str	w1, [x2]
	bl	usleep
	ldr	x2, [x19, #:lo12:.LANCHOR0]
	mov	w0, 5
	ldr	w1, [x2]
	and	w1, w1, -3585
	orr	w1, w1, 512
	str	w1, [x2]
	bl	usleep
	b	.L148
	.p2align 2,,3
.L185:
	ldr	w2, [x1]
	ubfiz	w20, w20, 1, 7
	and	w2, w2, -449
.L182:
	str	w2, [x1]
	ldr	w2, [x1]
	and	w2, w2, -3585
	str	w2, [x1]
	bl	usleep
	ldr	x2, [x19, #:lo12:.LANCHOR0]
	mov	w0, 5
	ldr	w1, [x2]
	and	w1, w1, -3585
	orr	w1, w1, 512
	str	w1, [x2]
	bl	usleep
	subs	w21, w21, #1
	beq	.L184
.L148:
	ldr	x1, [x19, #:lo12:.LANCHOR0]
	mov	w0, 5
	tbnz	x20, 6, .L185
	ldr	w2, [x1]
	ubfiz	w20, w20, 1, 7
	mov	w0, 5
	and	w2, w2, -449
	orr	w2, w2, 64
	b	.L182
	.p2align 2,,3
.L146:
.LCFI72:
	ldr	w2, [x1]
	mov	w0, 5
	and	w2, w2, -449
	orr	w2, w2, 64
	str	w2, [x1]
	bl	usleep
	ldr	x2, [x19, #:lo12:.LANCHOR0]
	mov	w0, 5
	ldr	w1, [x2]
	and	w1, w1, -3585
	str	w1, [x2]
	bl	usleep
	ldr	x2, [x19, #:lo12:.LANCHOR0]
	mov	w0, 5
	ldr	w1, [x2]
	and	w1, w1, -449
	str	w1, [x2]
	bl	usleep
	ldp	x19, x20, [sp, 16]
	adrp	x0, .LC1
	ldp	x29, x30, [sp], 64
.LCFI73:
	add	x0, x0, :lo12:.LC1
	b	puts
	.p2align 2,,3
.L184:
.LCFI74:
	ldr	x2, [x19, #:lo12:.LANCHOR0]
	mov	w0, 5
	ldr	w1, [x2]
	and	w1, w1, -449
	orr	w1, w1, 64
	str	w1, [x2]
	ldr	w1, [x2]
	and	w1, w1, -3585
	str	w1, [x2]
	bl	usleep
	ldr	x2, [x19, #:lo12:.LANCHOR0]
	mov	w0, 5
	ldr	w1, [x2]
	and	w1, w1, -3585
	orr	w1, w1, 512
	str	w1, [x2]
	bl	usleep
	ldr	x2, [x19, #:lo12:.LANCHOR0]
	mov	w0, 5
	ldr	w1, [x2]
	and	w1, w1, -3585
	str	w1, [x2]
	bl	usleep
	ldr	x1, [x19, #:lo12:.LANCHOR0]
	.p2align 3,,7
.L152:
	ldr	w0, [x1, 52]
	tbz	x0, 3, .L152
	ldr	w20, [x1, 52]
	mov	w0, 5
	ldr	w2, [x1]
	and	w2, w2, -3585
	orr	w2, w2, 512
	str	w2, [x1]
	bl	usleep
	tbnz	x20, 2, .L186
	adrp	x20, .LANCHOR1
	add	x20, x20, :lo12:.LANCHOR1
	add	x21, x20, 18
	str	x23, [sp, 48]
.LCFI75:
	.p2align 3,,7
.L160:
	ldrb	w22, [x20]
	mov	w23, 8
	b	.L157
	.p2align 2,,3
.L154:
	ldr	w2, [x1]
	ubfiz	w22, w22, 1, 7
	and	w2, w2, -449
	orr	w2, w2, 64
.L183:
	str	w2, [x1]
	ldr	w2, [x1]
	and	w2, w2, -3585
	str	w2, [x1]
	bl	usleep
	ldr	x2, [x19, #:lo12:.LANCHOR0]
	mov	w0, 5
	ldr	w1, [x2]
	and	w1, w1, -3585
	orr	w1, w1, 512
	str	w1, [x2]
	bl	usleep
	subs	w23, w23, #1
	beq	.L187
.L157:
	ldr	x1, [x19, #:lo12:.LANCHOR0]
	mov	w0, 5
	tbz	x22, 7, .L154
	ldr	w2, [x1]
	ubfiz	w22, w22, 1, 7
	and	w2, w2, -449
	b	.L183
	.p2align 2,,3
.L187:
	ldr	x2, [x19, #:lo12:.LANCHOR0]
	mov	w0, 5
	ldr	w1, [x2]
	and	w1, w1, -3585
	str	w1, [x2]
	bl	usleep
	ldr	x1, [x19, #:lo12:.LANCHOR0]
	.p2align 3,,7
.L158:
	ldr	w0, [x1, 52]
	tbz	x0, 3, .L158
	ldr	w22, [x1, 52]
	mov	w0, 5
	ldr	w2, [x1]
	and	w2, w2, -3585
	orr	w2, w2, 512
	str	w2, [x1]
	bl	usleep
	tbnz	x22, 2, .L159
	add	x20, x20, 1
	cmp	x20, x21
	bne	.L160
	ldr	x2, [x19, #:lo12:.LANCHOR0]
	mov	w0, 5
	ldr	w1, [x2]
	and	w1, w1, -449
	orr	w1, w1, 64
	str	w1, [x2]
	bl	usleep
	ldr	x2, [x19, #:lo12:.LANCHOR0]
	mov	w0, 5
	ldr	w1, [x2]
	and	w1, w1, -3585
	str	w1, [x2]
	bl	usleep
	ldr	x2, [x19, #:lo12:.LANCHOR0]
	mov	w0, 5
	ldp	x19, x20, [sp, 16]
	ldr	w1, [x2]
	ldp	x21, x22, [sp, 32]
.LCFI76:
	and	w1, w1, -449
	ldr	x23, [sp, 48]
.LCFI77:
	str	w1, [x2]
	ldp	x29, x30, [sp], 64
.LCFI78:
	b	usleep
.L186:
.LCFI79:
	ldr	x2, [x19, #:lo12:.LANCHOR0]
	mov	w0, 5
	ldr	w1, [x2]
	and	w1, w1, -449
	orr	w1, w1, 64
	str	w1, [x2]
	bl	usleep
	ldr	x2, [x19, #:lo12:.LANCHOR0]
	mov	w0, 5
	ldr	w1, [x2]
	and	w1, w1, -3585
	str	w1, [x2]
	bl	usleep
	ldr	x2, [x19, #:lo12:.LANCHOR0]
	mov	w0, 5
	ldr	w1, [x2]
	and	w1, w1, -449
	str	w1, [x2]
	bl	usleep
	ldp	x19, x20, [sp, 16]
	adrp	x0, .LC2
	ldp	x21, x22, [sp, 32]
.LCFI80:
	add	x0, x0, :lo12:.LC2
	ldp	x29, x30, [sp], 64
.LCFI81:
	mov	w1, 33
	b	printf
.L159:
.LCFI82:
	ldr	x2, [x19, #:lo12:.LANCHOR0]
	mov	w0, 5
	ldr	w1, [x2]
	and	w1, w1, -449
	orr	w1, w1, 64
	str	w1, [x2]
	bl	usleep
	ldr	x2, [x19, #:lo12:.LANCHOR0]
	mov	w0, 5
	ldr	w1, [x2]
	and	w1, w1, -3585
	str	w1, [x2]
	bl	usleep
	ldr	x2, [x19, #:lo12:.LANCHOR0]
	mov	w0, 5
	ldr	w1, [x2]
	and	w1, w1, -449
	str	w1, [x2]
	bl	usleep
	ldp	x19, x20, [sp, 16]
	adrp	x0, .LC3
	ldp	x21, x22, [sp, 32]
.LCFI83:
	add	x0, x0, :lo12:.LC3
	ldr	x23, [sp, 48]
.LCFI84:
	ldp	x29, x30, [sp], 64
.LCFI85:
	b	puts
.LFE40:
	.size	cam_init_settings, .-cam_init_settings
	.align	2
	.p2align 4,,11
	.global	cam_init_buffer
	.type	cam_init_buffer, %function
cam_init_buffer:
.LFB41:
	mov	x0, 24576
	movk	x0, 0x9, lsl 16
	b	malloc
.LFE41:
	.size	cam_init_buffer, .-cam_init_buffer
	.align	2
	.p2align 4,,11
	.global	cam_get_frame
	.type	cam_get_frame, %function
cam_get_frame:
.LFB42:
	adrp	x4, .LANCHOR0
	mov	x3, x0
	ldr	x0, [x4, #:lo12:.LANCHOR0]
.L190:
	ldr	w1, [x0, 52]
	tbz	x1, 22, .L190
.L191:
	ldr	w1, [x0, 52]
	and	w5, w1, 4194304
	tbnz	x1, 22, .L191
	add	x3, x3, 1280
	.p2align 3,,7
.L192:
	ldr	w1, [x0, 52]
	tbz	x1, 27, .L192
	sub	x2, x3, #1280
	.p2align 3,,7
.L193:
	ldr	w1, [x0, 52]
	tbz	x1, 23, .L193
	ldr	w0, [x0, 52]
	asr	w0, w0, 14
	strb	w0, [x2]
	ldr	x0, [x4, #:lo12:.LANCHOR0]
	.p2align 3,,7
.L194:
	ldr	w1, [x0, 52]
	tbnz	x1, 23, .L194
	add	x2, x2, 1
	cmp	x2, x3
	bne	.L193
	add	w5, w5, 1280
	.p2align 3,,7
.L196:
	ldr	w1, [x0, 52]
	tbnz	x1, 27, .L196
	add	x3, x3, 1280
	cmp	w5, 614400
	bne	.L192
	ret
.LFE42:
	.size	cam_get_frame, .-cam_get_frame
	.align	2
	.p2align 4,,11
	.global	cam_setup
	.type	cam_setup, %function
cam_setup:
.LFB43:
	stp	x29, x30, [sp, -64]!
.LCFI86:
	mov	w1, 4098
	movk	w1, 0x10, lsl 16
	mov	x29, sp
	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
	stp	x19, x20, [sp, 16]
.LCFI87:
	adrp	x19, .LANCHOR0
	stp	x21, x22, [sp, 32]
.LCFI88:
	add	x21, x19, :lo12:.LANCHOR0
	str	x23, [sp, 48]
.LCFI89:
	bl	open
	mov	x5, 4263510016
	mov	w20, w0
	mov	w4, w0
	mov	w3, 1
	mov	w2, 3
	mov	x1, 4096
	mov	x0, 0
	bl	mmap
	mov	x1, 4096
	mov	x5, 4096
	mov	w4, w20
	movk	x5, 0xfe10, lsl 16
	mov	w3, 1
	mov	w2, 3
	str	x0, [x19, #:lo12:.LANCHOR0]
	mov	x0, 0
	bl	mmap
	mov	x1, x0
	mov	w0, w20
	str	x1, [x21, 8]
	bl	close
	bl	cam_init_pins
	ldr	x1, [x21, 8]
	mov	w0, 32
	movk	w0, 0x5a00, lsl 16
	str	w0, [x1, 112]
	.p2align 3,,7
.L210:
	ldr	w0, [x1, 112]
	tbnz	x0, 7, .L210
	ldr	x0, [x19, #:lo12:.LANCHOR0]
	mov	w2, 8192
	movk	w2, 0x5a03, lsl 16
	str	w2, [x1, 116]
	mov	w2, 22
	mov	w22, 2
	movk	w2, 0x5a00, lsl 16
	str	w2, [x1, 112]
	str	w22, [x0, 148]
	mov	w0, 150
	mov	w21, 8
	mov	w20, 4
	bl	usleep
	add	x23, x19, :lo12:.LANCHOR0
	ldr	x1, [x19, #:lo12:.LANCHOR0]
	mov	w0, 150
	str	w21, [x1, 152]
	bl	usleep
	ldr	x1, [x19, #:lo12:.LANCHOR0]
	mov	w0, 150
	str	wzr, [x1, 152]
	str	w22, [x1, 148]
	bl	usleep
	ldr	x1, [x19, #:lo12:.LANCHOR0]
	mov	w0, 150
	str	w20, [x1, 152]
	bl	usleep
	ldr	x0, [x19, #:lo12:.LANCHOR0]
	str	wzr, [x0, 152]
	str	w21, [x0, 40]
	str	w20, [x0, 40]
	ldr	w1, [x0]
	and	w1, w1, -3585
	str	w1, [x0]
	ldr	w1, [x0]
	and	w1, w1, -449
	str	w1, [x0]
	bl	cam_init_settings
	mov	x0, 24576
	movk	x0, 0x9, lsl 16
	bl	malloc
	ldp	x19, x20, [sp, 16]
	ldp	x21, x22, [sp, 32]
	str	x0, [x23, 16]
	ldr	x23, [sp, 48]
	ldp	x29, x30, [sp], 64
.LCFI90:
	ret
.LFE43:
	.size	cam_setup, .-cam_setup
	.section	.text.startup,"ax",@progbits
	.align	2
	.p2align 4,,11
	.global	main
	.type	main, %function
main:
.LFB44:
	stp	x29, x30, [sp, -16]!
.LCFI91:
	mov	x29, sp
	bl	cam_setup
	mov	w0, 0
	ldp	x29, x30, [sp], 16
.LCFI92:
	ret
.LFE44:
	.size	main, .-main
	.global	img
	.global	clk
	.global	gpio
	.global	CAM_SETTINGS
	.data
	.align	4
	.set	.LANCHOR1,. + 0
	.type	CAM_SETTINGS, %object
	.size	CAM_SETTINGS, 18
CAM_SETTINGS:
	.string	"\022\004\025"
	.string	"\021\037>\034@\020\214"
	.ascii	"s\bq\265p:"
	.bss
	.align	3
	.set	.LANCHOR0,. + 0
	.type	gpio, %object
	.size	gpio, 8
gpio:
	.zero	8
	.type	clk, %object
	.size	clk, 8
clk:
	.zero	8
	.type	img, %object
	.size	img, 8
img:
	.zero	8
	.section	.eh_frame,"a",@progbits
.Lframe1:
	.4byte	.LECIE1-.LSCIE1
.LSCIE1:
	.4byte	0
	.byte	0x3
	.string	"zR"
	.uleb128 0x1
	.sleb128 -8
	.uleb128 0x1e
	.uleb128 0x1
	.byte	0x1b
	.byte	0xc
	.uleb128 0x1f
	.uleb128 0
	.align	3
.LECIE1:
.LSFDE1:
	.4byte	.LEFDE1-.LASFDE1
.LASFDE1:
	.4byte	.LASFDE1-.Lframe1
	.4byte	.LFB22-.
	.4byte	.LFE22-.LFB22
	.uleb128 0
	.byte	0x4
	.4byte	.LCFI0-.LFB22
	.byte	0xe
	.uleb128 0x20
	.byte	0x9d
	.uleb128 0x4
	.byte	0x9e
	.uleb128 0x3
	.byte	0x4
	.4byte	.LCFI1-.LCFI0
	.byte	0x93
	.uleb128 0x2
	.byte	0x94
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI2-.LCFI1
	.byte	0xde
	.byte	0xdd
	.byte	0xd3
	.byte	0xd4
	.byte	0xe
	.uleb128 0
	.align	3
.LEFDE1:
.LSFDE3:
	.4byte	.LEFDE3-.LASFDE3
.LASFDE3:
	.4byte	.LASFDE3-.Lframe1
	.4byte	.LFB23-.
	.4byte	.LFE23-.LFB23
	.uleb128 0
	.byte	0x4
	.4byte	.LCFI3-.LFB23
	.byte	0xe
	.uleb128 0x20
	.byte	0x9d
	.uleb128 0x4
	.byte	0x9e
	.uleb128 0x3
	.byte	0x4
	.4byte	.LCFI4-.LCFI3
	.byte	0x93
	.uleb128 0x2
	.byte	0x94
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI5-.LCFI4
	.byte	0xde
	.byte	0xdd
	.byte	0xd3
	.byte	0xd4
	.byte	0xe
	.uleb128 0
	.align	3
.LEFDE3:
.LSFDE5:
	.4byte	.LEFDE5-.LASFDE5
.LASFDE5:
	.4byte	.LASFDE5-.Lframe1
	.4byte	.LFB24-.
	.4byte	.LFE24-.LFB24
	.uleb128 0
	.byte	0x4
	.4byte	.LCFI6-.LFB24
	.byte	0xe
	.uleb128 0x30
	.byte	0x9d
	.uleb128 0x6
	.byte	0x9e
	.uleb128 0x5
	.byte	0x4
	.4byte	.LCFI7-.LCFI6
	.byte	0x93
	.uleb128 0x4
	.byte	0x94
	.uleb128 0x3
	.byte	0x4
	.4byte	.LCFI8-.LCFI7
	.byte	0x95
	.uleb128 0x2
	.byte	0x96
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI9-.LCFI8
	.byte	0xde
	.byte	0xdd
	.byte	0xd5
	.byte	0xd6
	.byte	0xd3
	.byte	0xd4
	.byte	0xe
	.uleb128 0
	.align	3
.LEFDE5:
.LSFDE7:
	.4byte	.LEFDE7-.LASFDE7
.LASFDE7:
	.4byte	.LASFDE7-.Lframe1
	.4byte	.LFB25-.
	.4byte	.LFE25-.LFB25
	.uleb128 0
	.byte	0x4
	.4byte	.LCFI10-.LFB25
	.byte	0xe
	.uleb128 0x20
	.byte	0x9d
	.uleb128 0x4
	.byte	0x9e
	.uleb128 0x3
	.byte	0x4
	.4byte	.LCFI11-.LCFI10
	.byte	0x93
	.uleb128 0x2
	.byte	0x94
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI12-.LCFI11
	.byte	0xa
	.byte	0xde
	.byte	0xdd
	.byte	0xd3
	.byte	0xd4
	.byte	0xe
	.uleb128 0
	.byte	0x4
	.4byte	.LCFI13-.LCFI12
	.byte	0xb
	.byte	0x4
	.4byte	.LCFI14-.LCFI13
	.byte	0xde
	.byte	0xdd
	.byte	0xd3
	.byte	0xd4
	.byte	0xe
	.uleb128 0
	.align	3
.LEFDE7:
.LSFDE9:
	.4byte	.LEFDE9-.LASFDE9
.LASFDE9:
	.4byte	.LASFDE9-.Lframe1
	.4byte	.LFB26-.
	.4byte	.LFE26-.LFB26
	.uleb128 0
	.byte	0x4
	.4byte	.LCFI15-.LFB26
	.byte	0xe
	.uleb128 0x20
	.byte	0x9d
	.uleb128 0x4
	.byte	0x9e
	.uleb128 0x3
	.byte	0x4
	.4byte	.LCFI16-.LCFI15
	.byte	0x93
	.uleb128 0x2
	.byte	0x4
	.4byte	.LCFI17-.LCFI16
	.byte	0xde
	.byte	0xdd
	.byte	0xd3
	.byte	0xe
	.uleb128 0
	.align	3
.LEFDE9:
.LSFDE11:
	.4byte	.LEFDE11-.LASFDE11
.LASFDE11:
	.4byte	.LASFDE11-.Lframe1
	.4byte	.LFB27-.
	.4byte	.LFE27-.LFB27
	.uleb128 0
	.byte	0x4
	.4byte	.LCFI18-.LFB27
	.byte	0xe
	.uleb128 0x20
	.byte	0x9d
	.uleb128 0x4
	.byte	0x9e
	.uleb128 0x3
	.byte	0x4
	.4byte	.LCFI19-.LCFI18
	.byte	0x93
	.uleb128 0x2
	.byte	0x4
	.4byte	.LCFI20-.LCFI19
	.byte	0xde
	.byte	0xdd
	.byte	0xd3
	.byte	0xe
	.uleb128 0
	.align	3
.LEFDE11:
.LSFDE13:
	.4byte	.LEFDE13-.LASFDE13
.LASFDE13:
	.4byte	.LASFDE13-.Lframe1
	.4byte	.LFB28-.
	.4byte	.LFE28-.LFB28
	.uleb128 0
	.byte	0x4
	.4byte	.LCFI21-.LFB28
	.byte	0xe
	.uleb128 0x30
	.byte	0x9d
	.uleb128 0x6
	.byte	0x9e
	.uleb128 0x5
	.byte	0x4
	.4byte	.LCFI22-.LCFI21
	.byte	0x93
	.uleb128 0x4
	.byte	0x94
	.uleb128 0x3
	.byte	0x4
	.4byte	.LCFI23-.LCFI22
	.byte	0x95
	.uleb128 0x2
	.byte	0x4
	.4byte	.LCFI24-.LCFI23
	.byte	0xde
	.byte	0xdd
	.byte	0xd5
	.byte	0xd3
	.byte	0xd4
	.byte	0xe
	.uleb128 0
	.align	3
.LEFDE13:
.LSFDE15:
	.4byte	.LEFDE15-.LASFDE15
.LASFDE15:
	.4byte	.LASFDE15-.Lframe1
	.4byte	.LFB29-.
	.4byte	.LFE29-.LFB29
	.uleb128 0
	.byte	0x4
	.4byte	.LCFI25-.LFB29
	.byte	0xe
	.uleb128 0x20
	.byte	0x9d
	.uleb128 0x4
	.byte	0x9e
	.uleb128 0x3
	.byte	0x4
	.4byte	.LCFI26-.LCFI25
	.byte	0x93
	.uleb128 0x2
	.byte	0x4
	.4byte	.LCFI27-.LCFI26
	.byte	0xde
	.byte	0xdd
	.byte	0xd3
	.byte	0xe
	.uleb128 0
	.align	3
.LEFDE15:
.LSFDE17:
	.4byte	.LEFDE17-.LASFDE17
.LASFDE17:
	.4byte	.LASFDE17-.Lframe1
	.4byte	.LFB30-.
	.4byte	.LFE30-.LFB30
	.uleb128 0
	.byte	0x4
	.4byte	.LCFI28-.LFB30
	.byte	0xe
	.uleb128 0x20
	.byte	0x9d
	.uleb128 0x4
	.byte	0x9e
	.uleb128 0x3
	.byte	0x4
	.4byte	.LCFI29-.LCFI28
	.byte	0x93
	.uleb128 0x2
	.byte	0x4
	.4byte	.LCFI30-.LCFI29
	.byte	0xde
	.byte	0xdd
	.byte	0xd3
	.byte	0xe
	.uleb128 0
	.align	3
.LEFDE17:
.LSFDE19:
	.4byte	.LEFDE19-.LASFDE19
.LASFDE19:
	.4byte	.LASFDE19-.Lframe1
	.4byte	.LFB31-.
	.4byte	.LFE31-.LFB31
	.uleb128 0
	.byte	0x4
	.4byte	.LCFI31-.LFB31
	.byte	0xe
	.uleb128 0x30
	.byte	0x9d
	.uleb128 0x6
	.byte	0x9e
	.uleb128 0x5
	.byte	0x4
	.4byte	.LCFI32-.LCFI31
	.byte	0x93
	.uleb128 0x4
	.byte	0x94
	.uleb128 0x3
	.byte	0x4
	.4byte	.LCFI33-.LCFI32
	.byte	0x95
	.uleb128 0x2
	.byte	0x4
	.4byte	.LCFI34-.LCFI33
	.byte	0xde
	.byte	0xdd
	.byte	0xd5
	.byte	0xd3
	.byte	0xd4
	.byte	0xe
	.uleb128 0
	.align	3
.LEFDE19:
.LSFDE21:
	.4byte	.LEFDE21-.LASFDE21
.LASFDE21:
	.4byte	.LASFDE21-.Lframe1
	.4byte	.LFB32-.
	.4byte	.LFE32-.LFB32
	.uleb128 0
	.byte	0x4
	.4byte	.LCFI35-.LFB32
	.byte	0xe
	.uleb128 0x30
	.byte	0x9d
	.uleb128 0x6
	.byte	0x9e
	.uleb128 0x5
	.byte	0x4
	.4byte	.LCFI36-.LCFI35
	.byte	0x93
	.uleb128 0x4
	.byte	0x94
	.uleb128 0x3
	.byte	0x4
	.4byte	.LCFI37-.LCFI36
	.byte	0x95
	.uleb128 0x2
	.byte	0x4
	.4byte	.LCFI38-.LCFI37
	.byte	0xde
	.byte	0xdd
	.byte	0xd5
	.byte	0xd3
	.byte	0xd4
	.byte	0xe
	.uleb128 0
	.align	3
.LEFDE21:
.LSFDE23:
	.4byte	.LEFDE23-.LASFDE23
.LASFDE23:
	.4byte	.LASFDE23-.Lframe1
	.4byte	.LFB33-.
	.4byte	.LFE33-.LFB33
	.uleb128 0
	.byte	0x4
	.4byte	.LCFI39-.LFB33
	.byte	0xe
	.uleb128 0x20
	.byte	0x9d
	.uleb128 0x4
	.byte	0x9e
	.uleb128 0x3
	.byte	0x4
	.4byte	.LCFI40-.LCFI39
	.byte	0x93
	.uleb128 0x2
	.byte	0x4
	.4byte	.LCFI41-.LCFI40
	.byte	0xa
	.byte	0xde
	.byte	0xdd
	.byte	0xd3
	.byte	0xe
	.uleb128 0
	.byte	0x4
	.4byte	.LCFI42-.LCFI41
	.byte	0xb
	.align	3
.LEFDE23:
.LSFDE25:
	.4byte	.LEFDE25-.LASFDE25
.LASFDE25:
	.4byte	.LASFDE25-.Lframe1
	.4byte	.LFB34-.
	.4byte	.LFE34-.LFB34
	.uleb128 0
	.byte	0x4
	.4byte	.LCFI43-.LFB34
	.byte	0xe
	.uleb128 0x30
	.byte	0x9d
	.uleb128 0x6
	.byte	0x9e
	.uleb128 0x5
	.byte	0x4
	.4byte	.LCFI44-.LCFI43
	.byte	0x95
	.uleb128 0x2
	.byte	0x96
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI45-.LCFI44
	.byte	0x93
	.uleb128 0x4
	.byte	0x94
	.uleb128 0x3
	.byte	0x4
	.4byte	.LCFI46-.LCFI45
	.byte	0xa
	.byte	0xde
	.byte	0xdd
	.byte	0xd5
	.byte	0xd6
	.byte	0xd3
	.byte	0xd4
	.byte	0xe
	.uleb128 0
	.byte	0x4
	.4byte	.LCFI47-.LCFI46
	.byte	0xb
	.byte	0x4
	.4byte	.LCFI48-.LCFI47
	.byte	0xde
	.byte	0xdd
	.byte	0xd5
	.byte	0xd6
	.byte	0xd3
	.byte	0xd4
	.byte	0xe
	.uleb128 0
	.align	3
.LEFDE25:
.LSFDE27:
	.4byte	.LEFDE27-.LASFDE27
.LASFDE27:
	.4byte	.LASFDE27-.Lframe1
	.4byte	.LFB35-.
	.4byte	.LFE35-.LFB35
	.uleb128 0
	.byte	0x4
	.4byte	.LCFI49-.LFB35
	.byte	0xe
	.uleb128 0x30
	.byte	0x9d
	.uleb128 0x6
	.byte	0x9e
	.uleb128 0x5
	.byte	0x4
	.4byte	.LCFI50-.LCFI49
	.byte	0x93
	.uleb128 0x4
	.byte	0x94
	.uleb128 0x3
	.byte	0x4
	.4byte	.LCFI51-.LCFI50
	.byte	0x95
	.uleb128 0x2
	.byte	0x4
	.4byte	.LCFI52-.LCFI51
	.byte	0xde
	.byte	0xdd
	.byte	0xd5
	.byte	0xd3
	.byte	0xd4
	.byte	0xe
	.uleb128 0
	.align	3
.LEFDE27:
.LSFDE29:
	.4byte	.LEFDE29-.LASFDE29
.LASFDE29:
	.4byte	.LASFDE29-.Lframe1
	.4byte	.LFB36-.
	.4byte	.LFE36-.LFB36
	.uleb128 0
	.byte	0x4
	.4byte	.LCFI53-.LFB36
	.byte	0xe
	.uleb128 0x40
	.byte	0x9d
	.uleb128 0x8
	.byte	0x9e
	.uleb128 0x7
	.byte	0x4
	.4byte	.LCFI54-.LCFI53
	.byte	0x93
	.uleb128 0x6
	.byte	0x94
	.uleb128 0x5
	.byte	0x4
	.4byte	.LCFI55-.LCFI54
	.byte	0x95
	.uleb128 0x4
	.byte	0x96
	.uleb128 0x3
	.byte	0x4
	.4byte	.LCFI56-.LCFI55
	.byte	0x97
	.uleb128 0x2
	.byte	0x4
	.4byte	.LCFI57-.LCFI56
	.byte	0xa
	.byte	0xde
	.byte	0xdd
	.byte	0xd7
	.byte	0xd5
	.byte	0xd6
	.byte	0xd3
	.byte	0xd4
	.byte	0xe
	.uleb128 0
	.byte	0x4
	.4byte	.LCFI58-.LCFI57
	.byte	0xb
	.byte	0x4
	.4byte	.LCFI59-.LCFI58
	.byte	0xde
	.byte	0xdd
	.byte	0xd7
	.byte	0xd5
	.byte	0xd6
	.byte	0xd3
	.byte	0xd4
	.byte	0xe
	.uleb128 0
	.align	3
.LEFDE29:
.LSFDE31:
	.4byte	.LEFDE31-.LASFDE31
.LASFDE31:
	.4byte	.LASFDE31-.Lframe1
	.4byte	.LFB37-.
	.4byte	.LFE37-.LFB37
	.uleb128 0
	.byte	0x4
	.4byte	.LCFI60-.LFB37
	.byte	0xe
	.uleb128 0x30
	.byte	0x9d
	.uleb128 0x6
	.byte	0x9e
	.uleb128 0x5
	.byte	0x4
	.4byte	.LCFI61-.LCFI60
	.byte	0x93
	.uleb128 0x4
	.byte	0x94
	.uleb128 0x3
	.byte	0x4
	.4byte	.LCFI62-.LCFI61
	.byte	0x95
	.uleb128 0x2
	.byte	0x96
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI63-.LCFI62
	.byte	0xde
	.byte	0xdd
	.byte	0xd5
	.byte	0xd6
	.byte	0xd3
	.byte	0xd4
	.byte	0xe
	.uleb128 0
	.align	3
.LEFDE31:
.LSFDE33:
	.4byte	.LEFDE33-.LASFDE33
.LASFDE33:
	.4byte	.LASFDE33-.Lframe1
	.4byte	.LFB38-.
	.4byte	.LFE38-.LFB38
	.uleb128 0
	.byte	0x4
	.4byte	.LCFI64-.LFB38
	.byte	0xe
	.uleb128 0x40
	.byte	0x9d
	.uleb128 0x8
	.byte	0x9e
	.uleb128 0x7
	.byte	0x4
	.4byte	.LCFI65-.LCFI64
	.byte	0x93
	.uleb128 0x6
	.byte	0x94
	.uleb128 0x5
	.byte	0x4
	.4byte	.LCFI66-.LCFI65
	.byte	0x95
	.uleb128 0x4
	.byte	0x96
	.uleb128 0x3
	.byte	0x4
	.4byte	.LCFI67-.LCFI66
	.byte	0x97
	.uleb128 0x2
	.byte	0x4
	.4byte	.LCFI68-.LCFI67
	.byte	0xde
	.byte	0xdd
	.byte	0xd7
	.byte	0xd5
	.byte	0xd6
	.byte	0xd3
	.byte	0xd4
	.byte	0xe
	.uleb128 0
	.align	3
.LEFDE33:
.LSFDE35:
	.4byte	.LEFDE35-.LASFDE35
.LASFDE35:
	.4byte	.LASFDE35-.Lframe1
	.4byte	.LFB39-.
	.4byte	.LFE39-.LFB39
	.uleb128 0
	.align	3
.LEFDE35:
.LSFDE37:
	.4byte	.LEFDE37-.LASFDE37
.LASFDE37:
	.4byte	.LASFDE37-.Lframe1
	.4byte	.LFB40-.
	.4byte	.LFE40-.LFB40
	.uleb128 0
	.byte	0x4
	.4byte	.LCFI69-.LFB40
	.byte	0xe
	.uleb128 0x40
	.byte	0x9d
	.uleb128 0x8
	.byte	0x9e
	.uleb128 0x7
	.byte	0x4
	.4byte	.LCFI70-.LCFI69
	.byte	0x93
	.uleb128 0x6
	.byte	0x94
	.uleb128 0x5
	.byte	0x4
	.4byte	.LCFI71-.LCFI70
	.byte	0x96
	.uleb128 0x3
	.byte	0x95
	.uleb128 0x4
	.byte	0x4
	.4byte	.LCFI72-.LCFI71
	.byte	0xd5
	.byte	0xd6
	.byte	0x4
	.4byte	.LCFI73-.LCFI72
	.byte	0xde
	.byte	0xdd
	.byte	0xd3
	.byte	0xd4
	.byte	0xe
	.uleb128 0
	.byte	0x4
	.4byte	.LCFI74-.LCFI73
	.byte	0xe
	.uleb128 0x40
	.byte	0x93
	.uleb128 0x6
	.byte	0x94
	.uleb128 0x5
	.byte	0x95
	.uleb128 0x4
	.byte	0x96
	.uleb128 0x3
	.byte	0x9d
	.uleb128 0x8
	.byte	0x9e
	.uleb128 0x7
	.byte	0x4
	.4byte	.LCFI75-.LCFI74
	.byte	0x97
	.uleb128 0x2
	.byte	0x4
	.4byte	.LCFI76-.LCFI75
	.byte	0xd6
	.byte	0xd5
	.byte	0x4
	.4byte	.LCFI77-.LCFI76
	.byte	0xd7
	.byte	0x4
	.4byte	.LCFI78-.LCFI77
	.byte	0xde
	.byte	0xdd
	.byte	0xd3
	.byte	0xd4
	.byte	0xe
	.uleb128 0
	.byte	0x4
	.4byte	.LCFI79-.LCFI78
	.byte	0xe
	.uleb128 0x40
	.byte	0x93
	.uleb128 0x6
	.byte	0x94
	.uleb128 0x5
	.byte	0x95
	.uleb128 0x4
	.byte	0x96
	.uleb128 0x3
	.byte	0x9d
	.uleb128 0x8
	.byte	0x9e
	.uleb128 0x7
	.byte	0x4
	.4byte	.LCFI80-.LCFI79
	.byte	0xd6
	.byte	0xd5
	.byte	0x4
	.4byte	.LCFI81-.LCFI80
	.byte	0xde
	.byte	0xdd
	.byte	0xd3
	.byte	0xd4
	.byte	0xe
	.uleb128 0
	.byte	0x4
	.4byte	.LCFI82-.LCFI81
	.byte	0xe
	.uleb128 0x40
	.byte	0x93
	.uleb128 0x6
	.byte	0x94
	.uleb128 0x5
	.byte	0x95
	.uleb128 0x4
	.byte	0x96
	.uleb128 0x3
	.byte	0x97
	.uleb128 0x2
	.byte	0x9d
	.uleb128 0x8
	.byte	0x9e
	.uleb128 0x7
	.byte	0x4
	.4byte	.LCFI83-.LCFI82
	.byte	0xd6
	.byte	0xd5
	.byte	0x4
	.4byte	.LCFI84-.LCFI83
	.byte	0xd7
	.byte	0x4
	.4byte	.LCFI85-.LCFI84
	.byte	0xde
	.byte	0xdd
	.byte	0xd3
	.byte	0xd4
	.byte	0xe
	.uleb128 0
	.align	3
.LEFDE37:
.LSFDE39:
	.4byte	.LEFDE39-.LASFDE39
.LASFDE39:
	.4byte	.LASFDE39-.Lframe1
	.4byte	.LFB41-.
	.4byte	.LFE41-.LFB41
	.uleb128 0
	.align	3
.LEFDE39:
.LSFDE41:
	.4byte	.LEFDE41-.LASFDE41
.LASFDE41:
	.4byte	.LASFDE41-.Lframe1
	.4byte	.LFB42-.
	.4byte	.LFE42-.LFB42
	.uleb128 0
	.align	3
.LEFDE41:
.LSFDE43:
	.4byte	.LEFDE43-.LASFDE43
.LASFDE43:
	.4byte	.LASFDE43-.Lframe1
	.4byte	.LFB43-.
	.4byte	.LFE43-.LFB43
	.uleb128 0
	.byte	0x4
	.4byte	.LCFI86-.LFB43
	.byte	0xe
	.uleb128 0x40
	.byte	0x9d
	.uleb128 0x8
	.byte	0x9e
	.uleb128 0x7
	.byte	0x4
	.4byte	.LCFI87-.LCFI86
	.byte	0x93
	.uleb128 0x6
	.byte	0x94
	.uleb128 0x5
	.byte	0x4
	.4byte	.LCFI88-.LCFI87
	.byte	0x95
	.uleb128 0x4
	.byte	0x96
	.uleb128 0x3
	.byte	0x4
	.4byte	.LCFI89-.LCFI88
	.byte	0x97
	.uleb128 0x2
	.byte	0x4
	.4byte	.LCFI90-.LCFI89
	.byte	0xde
	.byte	0xdd
	.byte	0xd7
	.byte	0xd5
	.byte	0xd6
	.byte	0xd3
	.byte	0xd4
	.byte	0xe
	.uleb128 0
	.align	3
.LEFDE43:
.LSFDE45:
	.4byte	.LEFDE45-.LASFDE45
.LASFDE45:
	.4byte	.LASFDE45-.Lframe1
	.4byte	.LFB44-.
	.4byte	.LFE44-.LFB44
	.uleb128 0
	.byte	0x4
	.4byte	.LCFI91-.LFB44
	.byte	0xe
	.uleb128 0x10
	.byte	0x9d
	.uleb128 0x2
	.byte	0x9e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI92-.LCFI91
	.byte	0xde
	.byte	0xdd
	.byte	0xe
	.uleb128 0
	.align	3
.LEFDE45:
	.ident	"GCC: (Debian 12.2.0-14) 12.2.0"
	.section	.note.GNU-stack,"",@progbits
