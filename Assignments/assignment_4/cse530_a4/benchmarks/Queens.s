	.file	"Queens.c"
	.text
	.comm	value,4,4
	.comm	fixed,4,4
	.comm	floated,4,4
	.comm	seed,8,8
	.comm	permarray,44,32
	.comm	pctr,4,4
	.comm	tree,8,8
	.comm	stack,16,16
	.comm	cellspace,152,32
	.comm	freelist,4,4
	.comm	movesdone,4,4
	.comm	ima,6724,32
	.comm	imb,6724,32
	.comm	imr,6724,32
	.comm	rma,6724,32
	.comm	rmb,6724,32
	.comm	rmr,6724,32
	.comm	piececount,16,16
	.comm	class,52,32
	.comm	piecemax,52,32
	.comm	puzzl,2048,32
	.comm	p,26624,32
	.comm	n,4,4
	.comm	kount,4,4
	.comm	sortlist,20004,32
	.comm	biggest,4,4
	.comm	littlest,4,4
	.comm	top,4,4
	.comm	z,2056,32
	.comm	w,2056,32
	.comm	e,1040,32
	.comm	zr,4,4
	.comm	zi,4,4
	.globl	Initrand
	.type	Initrand, @function
Initrand:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	$74755, seed(%rip)
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	Initrand, .-Initrand
	.globl	Rand
	.type	Rand, @function
Rand:
.LFB3:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	seed(%rip), %rax
	imulq	$1309, %rax, %rax
	addq	$13849, %rax
	movzwl	%ax, %eax
	movq	%rax, seed(%rip)
	movq	seed(%rip), %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	Rand, .-Rand
	.globl	Try
	.type	Try, @function
Try:
.LFB4:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movl	%edi, -20(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movq	%rcx, -48(%rbp)
	movq	%r8, -56(%rbp)
	movq	%r9, -64(%rbp)
	movl	$0, -4(%rbp)
	movq	-32(%rbp), %rax
	movl	$0, (%rax)
	jmp	.L5
.L9:
	addl	$1, -4(%rbp)
	movq	-32(%rbp), %rax
	movl	$0, (%rax)
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-48(%rbp), %rax
	addq	%rdx, %rax
	movl	(%rax), %eax
	testl	%eax, %eax
	je	.L5
	movl	-20(%rbp), %edx
	movl	-4(%rbp), %eax
	addl	%edx, %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	movl	(%rax), %eax
	testl	%eax, %eax
	je	.L5
	movl	-20(%rbp), %eax
	subl	-4(%rbp), %eax
	cltq
	addq	$7, %rax
	leaq	0(,%rax,4), %rdx
	movq	-56(%rbp), %rax
	addq	%rdx, %rax
	movl	(%rax), %eax
	testl	%eax, %eax
	je	.L5
	movl	-20(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-64(%rbp), %rax
	addq	%rax, %rdx
	movl	-4(%rbp), %eax
	movl	%eax, (%rdx)
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-48(%rbp), %rax
	addq	%rdx, %rax
	movl	$0, (%rax)
	movl	-20(%rbp), %edx
	movl	-4(%rbp), %eax
	addl	%edx, %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	movl	$0, (%rax)
	movl	-20(%rbp), %eax
	subl	-4(%rbp), %eax
	cltq
	addq	$7, %rax
	leaq	0(,%rax,4), %rdx
	movq	-56(%rbp), %rax
	addq	%rdx, %rax
	movl	$0, (%rax)
	cmpl	$7, -20(%rbp)
	jg	.L6
	movl	-20(%rbp), %eax
	leal	1(%rax), %edi
	movq	-64(%rbp), %r8
	movq	-56(%rbp), %rsi
	movq	-48(%rbp), %rcx
	movq	-40(%rbp), %rdx
	movq	-32(%rbp), %rax
	movq	%r8, %r9
	movq	%rsi, %r8
	movq	%rax, %rsi
	call	Try
	movq	-32(%rbp), %rax
	movl	(%rax), %eax
	testl	%eax, %eax
	jne	.L5
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-48(%rbp), %rax
	addq	%rdx, %rax
	movl	$1, (%rax)
	movl	-20(%rbp), %edx
	movl	-4(%rbp), %eax
	addl	%edx, %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	movl	$1, (%rax)
	movl	-20(%rbp), %eax
	subl	-4(%rbp), %eax
	cltq
	addq	$7, %rax
	leaq	0(,%rax,4), %rdx
	movq	-56(%rbp), %rax
	addq	%rdx, %rax
	movl	$1, (%rax)
	jmp	.L5
.L6:
	movq	-32(%rbp), %rax
	movl	$1, (%rax)
.L5:
	movq	-32(%rbp), %rax
	movl	(%rax), %eax
	testl	%eax, %eax
	jne	.L10
	cmpl	$8, -4(%rbp)
	jne	.L9
.L10:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	Try, .-Try
	.section	.rodata
.LC0:
	.string	" Error in Queens."
	.text
	.globl	Doit
	.type	Doit, @function
Doit:
.LFB5:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$240, %rsp
	movl	$-7, -4(%rbp)
	jmp	.L12
.L16:
	cmpl	$0, -4(%rbp)
	jle	.L13
	cmpl	$8, -4(%rbp)
	jg	.L13
	movl	-4(%rbp), %eax
	cltq
	movl	$1, -48(%rbp,%rax,4)
.L13:
	cmpl	$1, -4(%rbp)
	jle	.L14
	movl	-4(%rbp), %eax
	cltq
	movl	$1, -128(%rbp,%rax,4)
.L14:
	cmpl	$7, -4(%rbp)
	jg	.L15
	movl	-4(%rbp), %eax
	addl	$7, %eax
	cltq
	movl	$1, -192(%rbp,%rax,4)
.L15:
	addl	$1, -4(%rbp)
.L12:
	cmpl	$16, -4(%rbp)
	jle	.L16
	leaq	-240(%rbp), %rdi
	leaq	-192(%rbp), %rsi
	leaq	-48(%rbp), %rcx
	leaq	-128(%rbp), %rdx
	leaq	-8(%rbp), %rax
	movq	%rdi, %r9
	movq	%rsi, %r8
	movq	%rax, %rsi
	movl	$1, %edi
	call	Try
	movl	-8(%rbp), %eax
	testl	%eax, %eax
	jne	.L18
	movl	$.LC0, %edi
	call	puts
.L18:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	Doit, .-Doit
	.section	.rodata
.LC1:
	.string	"%d\n"
	.text
	.globl	Queens
	.type	Queens, @function
Queens:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	%edi, -20(%rbp)
	movl	$1, -4(%rbp)
	jmp	.L20
.L21:
	movl	$0, %eax
	call	Doit
	addl	$1, -4(%rbp)
.L20:
	cmpl	$50, -4(%rbp)
	jle	.L21
	movl	-20(%rbp), %eax
	addl	$1, %eax
	movl	%eax, %esi
	movl	$.LC1, %edi
	movl	$0, %eax
	call	printf
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	Queens, .-Queens
	.globl	main
	.type	main, @function
main:
.LFB7:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	$0, -4(%rbp)
	jmp	.L23
.L24:
	movl	-4(%rbp), %eax
	movl	%eax, %edi
	call	Queens
	addl	$1, -4(%rbp)
.L23:
	cmpl	$19, -4(%rbp)
	jle	.L24
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	main, .-main
	.ident	"GCC: (GNU) 7.3.0"
	.section	.note.GNU-stack,"",@progbits
