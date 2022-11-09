	.file	"Puzzle.c"
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
	.globl	Fit
	.type	Fit, @function
Fit:
.LFB4:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -20(%rbp)
	movl	%esi, -24(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L5
.L8:
	movl	-4(%rbp), %eax
	cltq
	movl	-20(%rbp), %edx
	movslq	%edx, %rdx
	salq	$9, %rdx
	addq	%rdx, %rax
	movl	p(,%rax,4), %eax
	testl	%eax, %eax
	je	.L6
	movl	-4(%rbp), %eax
	movl	-24(%rbp), %edx
	addl	%edx, %eax
	cltq
	movl	puzzl(,%rax,4), %eax
	testl	%eax, %eax
	je	.L6
	movl	$0, %eax
	jmp	.L7
.L6:
	addl	$1, -4(%rbp)
.L5:
	movl	-20(%rbp), %eax
	cltq
	movl	piecemax(,%rax,4), %eax
	cmpl	-4(%rbp), %eax
	jge	.L8
	movl	$1, %eax
.L7:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	Fit, .-Fit
	.globl	Place
	.type	Place, @function
Place:
.LFB5:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -20(%rbp)
	movl	%esi, -24(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L10
.L12:
	movl	-4(%rbp), %eax
	cltq
	movl	-20(%rbp), %edx
	movslq	%edx, %rdx
	salq	$9, %rdx
	addq	%rdx, %rax
	movl	p(,%rax,4), %eax
	testl	%eax, %eax
	je	.L11
	movl	-4(%rbp), %eax
	movl	-24(%rbp), %edx
	addl	%edx, %eax
	cltq
	movl	$1, puzzl(,%rax,4)
.L11:
	addl	$1, -4(%rbp)
.L10:
	movl	-20(%rbp), %eax
	cltq
	movl	piecemax(,%rax,4), %eax
	cmpl	-4(%rbp), %eax
	jge	.L12
	movl	-20(%rbp), %eax
	cltq
	movl	class(,%rax,4), %ecx
	movl	-20(%rbp), %eax
	cltq
	movl	class(,%rax,4), %eax
	cltq
	movl	piececount(,%rax,4), %eax
	leal	-1(%rax), %edx
	movslq	%ecx, %rax
	movl	%edx, piececount(,%rax,4)
	movl	-24(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.L13
.L16:
	movl	-4(%rbp), %eax
	cltq
	movl	puzzl(,%rax,4), %eax
	testl	%eax, %eax
	jne	.L14
	movl	-4(%rbp), %eax
	jmp	.L15
.L14:
	addl	$1, -4(%rbp)
.L13:
	cmpl	$511, -4(%rbp)
	jle	.L16
	movl	$0, %eax
.L15:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	Place, .-Place
	.globl	Remove
	.type	Remove, @function
Remove:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -20(%rbp)
	movl	%esi, -24(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L18
.L20:
	movl	-4(%rbp), %eax
	cltq
	movl	-20(%rbp), %edx
	movslq	%edx, %rdx
	salq	$9, %rdx
	addq	%rdx, %rax
	movl	p(,%rax,4), %eax
	testl	%eax, %eax
	je	.L19
	movl	-4(%rbp), %eax
	movl	-24(%rbp), %edx
	addl	%edx, %eax
	cltq
	movl	$0, puzzl(,%rax,4)
.L19:
	addl	$1, -4(%rbp)
.L18:
	movl	-20(%rbp), %eax
	cltq
	movl	piecemax(,%rax,4), %eax
	cmpl	-4(%rbp), %eax
	jge	.L20
	movl	-20(%rbp), %eax
	cltq
	movl	class(,%rax,4), %ecx
	movl	-20(%rbp), %eax
	cltq
	movl	class(,%rax,4), %eax
	cltq
	movl	piececount(,%rax,4), %eax
	leal	1(%rax), %edx
	movslq	%ecx, %rax
	movl	%edx, piececount(,%rax,4)
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	Remove, .-Remove
	.globl	Trial
	.type	Trial, @function
Trial:
.LFB7:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	%edi, -20(%rbp)
	movl	kount(%rip), %eax
	addl	$1, %eax
	movl	%eax, kount(%rip)
	movl	$0, -4(%rbp)
	jmp	.L22
.L27:
	movl	-4(%rbp), %eax
	cltq
	movl	class(,%rax,4), %eax
	cltq
	movl	piececount(,%rax,4), %eax
	testl	%eax, %eax
	je	.L23
	movl	-20(%rbp), %edx
	movl	-4(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	Fit
	testl	%eax, %eax
	je	.L23
	movl	-20(%rbp), %edx
	movl	-4(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	Place
	movl	%eax, -8(%rbp)
	movl	-8(%rbp), %eax
	movl	%eax, %edi
	call	Trial
	testl	%eax, %eax
	jne	.L24
	cmpl	$0, -8(%rbp)
	jne	.L25
.L24:
	movl	$1, %eax
	jmp	.L26
.L25:
	movl	-20(%rbp), %edx
	movl	-4(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	Remove
.L23:
	addl	$1, -4(%rbp)
.L22:
	cmpl	$12, -4(%rbp)
	jle	.L27
	movl	$0, %eax
.L26:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	Trial, .-Trial
	.section	.rodata
.LC0:
	.string	"Error1 in Puzzle"
.LC1:
	.string	"Error2 in Puzzle."
.LC2:
	.string	"Error3 in Puzzle."
.LC3:
	.string	"%d\n"
	.text
	.globl	Puzzle
	.type	Puzzle, @function
Puzzle:
.LFB8:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	$0, -16(%rbp)
	jmp	.L29
.L30:
	movl	-16(%rbp), %eax
	cltq
	movl	$1, puzzl(,%rax,4)
	addl	$1, -16(%rbp)
.L29:
	cmpl	$511, -16(%rbp)
	jle	.L30
	movl	$1, -4(%rbp)
	jmp	.L31
.L36:
	movl	$1, -8(%rbp)
	jmp	.L32
.L35:
	movl	$1, -12(%rbp)
	jmp	.L33
.L34:
	movl	-12(%rbp), %eax
	leal	0(,%rax,8), %edx
	movl	-8(%rbp), %eax
	addl	%edx, %eax
	leal	0(,%rax,8), %edx
	movl	-4(%rbp), %eax
	addl	%edx, %eax
	cltq
	movl	$0, puzzl(,%rax,4)
	addl	$1, -12(%rbp)
.L33:
	cmpl	$5, -12(%rbp)
	jle	.L34
	addl	$1, -8(%rbp)
.L32:
	cmpl	$5, -8(%rbp)
	jle	.L35
	addl	$1, -4(%rbp)
.L31:
	cmpl	$5, -4(%rbp)
	jle	.L36
	movl	$0, -4(%rbp)
	jmp	.L37
.L40:
	movl	$0, -16(%rbp)
	jmp	.L38
.L39:
	movl	-16(%rbp), %eax
	cltq
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$9, %rdx
	addq	%rdx, %rax
	movl	$0, p(,%rax,4)
	addl	$1, -16(%rbp)
.L38:
	cmpl	$511, -16(%rbp)
	jle	.L39
	addl	$1, -4(%rbp)
.L37:
	cmpl	$12, -4(%rbp)
	jle	.L40
	movl	$0, -4(%rbp)
	jmp	.L41
.L46:
	movl	$0, -8(%rbp)
	jmp	.L42
.L45:
	movl	$0, -12(%rbp)
	jmp	.L43
.L44:
	movl	-12(%rbp), %eax
	leal	0(,%rax,8), %edx
	movl	-8(%rbp), %eax
	addl	%edx, %eax
	leal	0(,%rax,8), %edx
	movl	-4(%rbp), %eax
	addl	%edx, %eax
	cltq
	movl	$1, p(,%rax,4)
	addl	$1, -12(%rbp)
.L43:
	cmpl	$0, -12(%rbp)
	jle	.L44
	addl	$1, -8(%rbp)
.L42:
	cmpl	$1, -8(%rbp)
	jle	.L45
	addl	$1, -4(%rbp)
.L41:
	cmpl	$3, -4(%rbp)
	jle	.L46
	movl	$0, class(%rip)
	movl	$11, piecemax(%rip)
	movl	$0, -4(%rbp)
	jmp	.L47
.L52:
	movl	$0, -8(%rbp)
	jmp	.L48
.L51:
	movl	$0, -12(%rbp)
	jmp	.L49
.L50:
	movl	-12(%rbp), %eax
	leal	0(,%rax,8), %edx
	movl	-8(%rbp), %eax
	addl	%edx, %eax
	leal	0(,%rax,8), %edx
	movl	-4(%rbp), %eax
	addl	%edx, %eax
	cltq
	addq	$512, %rax
	movl	$1, p(,%rax,4)
	addl	$1, -12(%rbp)
.L49:
	cmpl	$3, -12(%rbp)
	jle	.L50
	addl	$1, -8(%rbp)
.L48:
	cmpl	$0, -8(%rbp)
	jle	.L51
	addl	$1, -4(%rbp)
.L47:
	cmpl	$1, -4(%rbp)
	jle	.L52
	movl	$0, class+4(%rip)
	movl	$193, piecemax+4(%rip)
	movl	$0, -4(%rbp)
	jmp	.L53
.L58:
	movl	$0, -8(%rbp)
	jmp	.L54
.L57:
	movl	$0, -12(%rbp)
	jmp	.L55
.L56:
	movl	-12(%rbp), %eax
	leal	0(,%rax,8), %edx
	movl	-8(%rbp), %eax
	addl	%edx, %eax
	leal	0(,%rax,8), %edx
	movl	-4(%rbp), %eax
	addl	%edx, %eax
	cltq
	addq	$1024, %rax
	movl	$1, p(,%rax,4)
	addl	$1, -12(%rbp)
.L55:
	cmpl	$1, -12(%rbp)
	jle	.L56
	addl	$1, -8(%rbp)
.L54:
	cmpl	$3, -8(%rbp)
	jle	.L57
	addl	$1, -4(%rbp)
.L53:
	cmpl	$0, -4(%rbp)
	jle	.L58
	movl	$0, class+8(%rip)
	movl	$88, piecemax+8(%rip)
	movl	$0, -4(%rbp)
	jmp	.L59
.L64:
	movl	$0, -8(%rbp)
	jmp	.L60
.L63:
	movl	$0, -12(%rbp)
	jmp	.L61
.L62:
	movl	-12(%rbp), %eax
	leal	0(,%rax,8), %edx
	movl	-8(%rbp), %eax
	addl	%edx, %eax
	leal	0(,%rax,8), %edx
	movl	-4(%rbp), %eax
	addl	%edx, %eax
	cltq
	addq	$1536, %rax
	movl	$1, p(,%rax,4)
	addl	$1, -12(%rbp)
.L61:
	cmpl	$0, -12(%rbp)
	jle	.L62
	addl	$1, -8(%rbp)
.L60:
	cmpl	$3, -8(%rbp)
	jle	.L63
	addl	$1, -4(%rbp)
.L59:
	cmpl	$1, -4(%rbp)
	jle	.L64
	movl	$0, class+12(%rip)
	movl	$25, piecemax+12(%rip)
	movl	$0, -4(%rbp)
	jmp	.L65
.L70:
	movl	$0, -8(%rbp)
	jmp	.L66
.L69:
	movl	$0, -12(%rbp)
	jmp	.L67
.L68:
	movl	-12(%rbp), %eax
	leal	0(,%rax,8), %edx
	movl	-8(%rbp), %eax
	addl	%edx, %eax
	leal	0(,%rax,8), %edx
	movl	-4(%rbp), %eax
	addl	%edx, %eax
	cltq
	addq	$2048, %rax
	movl	$1, p(,%rax,4)
	addl	$1, -12(%rbp)
.L67:
	cmpl	$1, -12(%rbp)
	jle	.L68
	addl	$1, -8(%rbp)
.L66:
	cmpl	$0, -8(%rbp)
	jle	.L69
	addl	$1, -4(%rbp)
.L65:
	cmpl	$3, -4(%rbp)
	jle	.L70
	movl	$0, class+16(%rip)
	movl	$67, piecemax+16(%rip)
	movl	$0, -4(%rbp)
	jmp	.L71
.L76:
	movl	$0, -8(%rbp)
	jmp	.L72
.L75:
	movl	$0, -12(%rbp)
	jmp	.L73
.L74:
	movl	-12(%rbp), %eax
	leal	0(,%rax,8), %edx
	movl	-8(%rbp), %eax
	addl	%edx, %eax
	leal	0(,%rax,8), %edx
	movl	-4(%rbp), %eax
	addl	%edx, %eax
	cltq
	addq	$2560, %rax
	movl	$1, p(,%rax,4)
	addl	$1, -12(%rbp)
.L73:
	cmpl	$3, -12(%rbp)
	jle	.L74
	addl	$1, -8(%rbp)
.L72:
	cmpl	$1, -8(%rbp)
	jle	.L75
	addl	$1, -4(%rbp)
.L71:
	cmpl	$0, -4(%rbp)
	jle	.L76
	movl	$0, class+20(%rip)
	movl	$200, piecemax+20(%rip)
	movl	$0, -4(%rbp)
	jmp	.L77
.L82:
	movl	$0, -8(%rbp)
	jmp	.L78
.L81:
	movl	$0, -12(%rbp)
	jmp	.L79
.L80:
	movl	-12(%rbp), %eax
	leal	0(,%rax,8), %edx
	movl	-8(%rbp), %eax
	addl	%edx, %eax
	leal	0(,%rax,8), %edx
	movl	-4(%rbp), %eax
	addl	%edx, %eax
	cltq
	addq	$3072, %rax
	movl	$1, p(,%rax,4)
	addl	$1, -12(%rbp)
.L79:
	cmpl	$0, -12(%rbp)
	jle	.L80
	addl	$1, -8(%rbp)
.L78:
	cmpl	$0, -8(%rbp)
	jle	.L81
	addl	$1, -4(%rbp)
.L77:
	cmpl	$2, -4(%rbp)
	jle	.L82
	movl	$1, class+24(%rip)
	movl	$2, piecemax+24(%rip)
	movl	$0, -4(%rbp)
	jmp	.L83
.L88:
	movl	$0, -8(%rbp)
	jmp	.L84
.L87:
	movl	$0, -12(%rbp)
	jmp	.L85
.L86:
	movl	-12(%rbp), %eax
	leal	0(,%rax,8), %edx
	movl	-8(%rbp), %eax
	addl	%edx, %eax
	leal	0(,%rax,8), %edx
	movl	-4(%rbp), %eax
	addl	%edx, %eax
	cltq
	addq	$3584, %rax
	movl	$1, p(,%rax,4)
	addl	$1, -12(%rbp)
.L85:
	cmpl	$0, -12(%rbp)
	jle	.L86
	addl	$1, -8(%rbp)
.L84:
	cmpl	$2, -8(%rbp)
	jle	.L87
	addl	$1, -4(%rbp)
.L83:
	cmpl	$0, -4(%rbp)
	jle	.L88
	movl	$1, class+28(%rip)
	movl	$16, piecemax+28(%rip)
	movl	$0, -4(%rbp)
	jmp	.L89
.L94:
	movl	$0, -8(%rbp)
	jmp	.L90
.L93:
	movl	$0, -12(%rbp)
	jmp	.L91
.L92:
	movl	-12(%rbp), %eax
	leal	0(,%rax,8), %edx
	movl	-8(%rbp), %eax
	addl	%edx, %eax
	leal	0(,%rax,8), %edx
	movl	-4(%rbp), %eax
	addl	%edx, %eax
	cltq
	addq	$4096, %rax
	movl	$1, p(,%rax,4)
	addl	$1, -12(%rbp)
.L91:
	cmpl	$2, -12(%rbp)
	jle	.L92
	addl	$1, -8(%rbp)
.L90:
	cmpl	$0, -8(%rbp)
	jle	.L93
	addl	$1, -4(%rbp)
.L89:
	cmpl	$0, -4(%rbp)
	jle	.L94
	movl	$1, class+32(%rip)
	movl	$128, piecemax+32(%rip)
	movl	$0, -4(%rbp)
	jmp	.L95
.L100:
	movl	$0, -8(%rbp)
	jmp	.L96
.L99:
	movl	$0, -12(%rbp)
	jmp	.L97
.L98:
	movl	-12(%rbp), %eax
	leal	0(,%rax,8), %edx
	movl	-8(%rbp), %eax
	addl	%edx, %eax
	leal	0(,%rax,8), %edx
	movl	-4(%rbp), %eax
	addl	%edx, %eax
	cltq
	addq	$4608, %rax
	movl	$1, p(,%rax,4)
	addl	$1, -12(%rbp)
.L97:
	cmpl	$0, -12(%rbp)
	jle	.L98
	addl	$1, -8(%rbp)
.L96:
	cmpl	$1, -8(%rbp)
	jle	.L99
	addl	$1, -4(%rbp)
.L95:
	cmpl	$1, -4(%rbp)
	jle	.L100
	movl	$2, class+36(%rip)
	movl	$9, piecemax+36(%rip)
	movl	$0, -4(%rbp)
	jmp	.L101
.L106:
	movl	$0, -8(%rbp)
	jmp	.L102
.L105:
	movl	$0, -12(%rbp)
	jmp	.L103
.L104:
	movl	-12(%rbp), %eax
	leal	0(,%rax,8), %edx
	movl	-8(%rbp), %eax
	addl	%edx, %eax
	leal	0(,%rax,8), %edx
	movl	-4(%rbp), %eax
	addl	%edx, %eax
	cltq
	addq	$5120, %rax
	movl	$1, p(,%rax,4)
	addl	$1, -12(%rbp)
.L103:
	cmpl	$1, -12(%rbp)
	jle	.L104
	addl	$1, -8(%rbp)
.L102:
	cmpl	$0, -8(%rbp)
	jle	.L105
	addl	$1, -4(%rbp)
.L101:
	cmpl	$1, -4(%rbp)
	jle	.L106
	movl	$2, class+40(%rip)
	movl	$65, piecemax+40(%rip)
	movl	$0, -4(%rbp)
	jmp	.L107
.L112:
	movl	$0, -8(%rbp)
	jmp	.L108
.L111:
	movl	$0, -12(%rbp)
	jmp	.L109
.L110:
	movl	-12(%rbp), %eax
	leal	0(,%rax,8), %edx
	movl	-8(%rbp), %eax
	addl	%edx, %eax
	leal	0(,%rax,8), %edx
	movl	-4(%rbp), %eax
	addl	%edx, %eax
	cltq
	addq	$5632, %rax
	movl	$1, p(,%rax,4)
	addl	$1, -12(%rbp)
.L109:
	cmpl	$1, -12(%rbp)
	jle	.L110
	addl	$1, -8(%rbp)
.L108:
	cmpl	$1, -8(%rbp)
	jle	.L111
	addl	$1, -4(%rbp)
.L107:
	cmpl	$0, -4(%rbp)
	jle	.L112
	movl	$2, class+44(%rip)
	movl	$72, piecemax+44(%rip)
	movl	$0, -4(%rbp)
	jmp	.L113
.L118:
	movl	$0, -8(%rbp)
	jmp	.L114
.L117:
	movl	$0, -12(%rbp)
	jmp	.L115
.L116:
	movl	-12(%rbp), %eax
	leal	0(,%rax,8), %edx
	movl	-8(%rbp), %eax
	addl	%edx, %eax
	leal	0(,%rax,8), %edx
	movl	-4(%rbp), %eax
	addl	%edx, %eax
	cltq
	addq	$6144, %rax
	movl	$1, p(,%rax,4)
	addl	$1, -12(%rbp)
.L115:
	cmpl	$1, -12(%rbp)
	jle	.L116
	addl	$1, -8(%rbp)
.L114:
	cmpl	$1, -8(%rbp)
	jle	.L117
	addl	$1, -4(%rbp)
.L113:
	cmpl	$1, -4(%rbp)
	jle	.L118
	movl	$3, class+48(%rip)
	movl	$73, piecemax+48(%rip)
	movl	$13, piececount(%rip)
	movl	$3, piececount+4(%rip)
	movl	$1, piececount+8(%rip)
	movl	$1, piececount+12(%rip)
	movl	$73, -16(%rbp)
	movl	$0, kount(%rip)
	movl	-16(%rbp), %eax
	movl	%eax, %esi
	movl	$0, %edi
	call	Fit
	testl	%eax, %eax
	je	.L119
	movl	-16(%rbp), %eax
	movl	%eax, %esi
	movl	$0, %edi
	call	Place
	movl	%eax, n(%rip)
	jmp	.L120
.L119:
	movl	$.LC0, %edi
	call	puts
.L120:
	movl	n(%rip), %eax
	movl	%eax, %edi
	call	Trial
	testl	%eax, %eax
	jne	.L121
	movl	$.LC1, %edi
	call	puts
	jmp	.L122
.L121:
	movl	kount(%rip), %eax
	cmpl	$2005, %eax
	je	.L122
	movl	$.LC2, %edi
	call	puts
.L122:
	movl	n(%rip), %eax
	movl	%eax, %esi
	movl	$.LC3, %edi
	movl	$0, %eax
	call	printf
	movl	kount(%rip), %eax
	movl	%eax, %esi
	movl	$.LC3, %edi
	movl	$0, %eax
	call	printf
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	Puzzle, .-Puzzle
	.globl	main
	.type	main, @function
main:
.LFB9:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	$0, -4(%rbp)
	jmp	.L124
.L125:
	movl	$0, %eax
	call	Puzzle
	addl	$1, -4(%rbp)
.L124:
	cmpl	$4, -4(%rbp)
	jle	.L125
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	main, .-main
	.ident	"GCC: (GNU) 4.8.5 20150623 (Red Hat 4.8.5-44)"
	.section	.note.GNU-stack,"",@progbits
