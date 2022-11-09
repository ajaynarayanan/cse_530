	.file	"Perm.c"
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
	.text
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
	.globl	Swap
	.type	Swap, @function
Swap:
.LFB4:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	-24(%rbp), %rax
	movl	(%rax), %eax
	movl	%eax, -4(%rbp)
	movq	-32(%rbp), %rax
	movl	(%rax), %edx
	movq	-24(%rbp), %rax
	movl	%edx, (%rax)
	movq	-32(%rbp), %rax
	movl	-4(%rbp), %edx
	movl	%edx, (%rax)
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	Swap, .-Swap
	.globl	Initialize
	.type	Initialize, @function
Initialize:
.LFB5:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$1, -4(%rbp)
	jmp	.L6
.L7:
	movl	-4(%rbp), %eax
	leal	-1(%rax), %edx
	movl	-4(%rbp), %eax
	cltq
	movl	%edx, permarray(,%rax,4)
	addl	$1, -4(%rbp)
.L6:
	cmpl	$7, -4(%rbp)
	jle	.L7
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	Initialize, .-Initialize
	.globl	Permute
	.type	Permute, @function
Permute:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	%edi, -20(%rbp)
	movl	pctr(%rip), %eax
	addl	$1, %eax
	movl	%eax, pctr(%rip)
	cmpl	$1, -20(%rbp)
	je	.L8
	movl	-20(%rbp), %eax
	subl	$1, %eax
	movl	%eax, %edi
	call	Permute
	movl	-20(%rbp), %eax
	subl	$1, %eax
	movl	%eax, -4(%rbp)
	jmp	.L10
.L11:
	movl	-4(%rbp), %eax
	cltq
	salq	$2, %rax
	leaq	permarray(%rax), %rdx
	movl	-20(%rbp), %eax
	cltq
	salq	$2, %rax
	addq	$permarray, %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	Swap
	movl	-20(%rbp), %eax
	subl	$1, %eax
	movl	%eax, %edi
	call	Permute
	movl	-4(%rbp), %eax
	cltq
	salq	$2, %rax
	leaq	permarray(%rax), %rdx
	movl	-20(%rbp), %eax
	cltq
	salq	$2, %rax
	addq	$permarray, %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	Swap
	subl	$1, -4(%rbp)
.L10:
	cmpl	$0, -4(%rbp)
	jg	.L11
.L8:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	Permute, .-Permute
	.section	.rodata
.LC0:
	.string	" Error in Perm."
.LC1:
	.string	"%d\n"
	.text
	.globl	Perm
	.type	Perm, @function
Perm:
.LFB7:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	$0, pctr(%rip)
	movl	$1, -4(%rbp)
	jmp	.L13
.L14:
	movl	$0, %eax
	call	Initialize
	movl	$7, %edi
	call	Permute
	addl	$1, -4(%rbp)
.L13:
	cmpl	$5, -4(%rbp)
	jle	.L14
	movl	pctr(%rip), %eax
	cmpl	$43300, %eax
	je	.L15
	movl	$.LC0, %edi
	call	puts
.L15:
	movl	pctr(%rip), %eax
	movl	%eax, %esi
	movl	$.LC1, %edi
	movl	$0, %eax
	call	printf
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	Perm, .-Perm
	.globl	main
	.type	main, @function
main:
.LFB8:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	$0, -4(%rbp)
	jmp	.L17
.L18:
	movl	$0, %eax
	call	Perm
	addl	$1, -4(%rbp)
.L17:
	cmpl	$9, -4(%rbp)
	jle	.L18
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	main, .-main
	.ident	"GCC: (GNU) 4.8.5 20150623 (Red Hat 4.8.5-44)"
	.section	.note.GNU-stack,"",@progbits
