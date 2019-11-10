	.file	"tcp.c"
	.text
	.globl	error
	.type	error, @function
error:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	perror
	movl	$0, %edi
	call	exit
	.cfi_endproc
.LFE2:
	.size	error, .-error
	.section	.rodata
.LC0:
	.string	"usage: %s <hostname> <port>\n"
.LC1:
	.string	"ERROR opening socket"
.LC2:
	.string	"ERROR, no such host as %s\n"
.LC3:
	.string	"ERROR connecting"
.LC4:
	.string	"Please enter msg: "
.LC5:
	.string	"ERROR writing to socket"
.LC6:
	.string	"ERROR reading from socket"
.LC7:
	.string	"Echo from server: %s"
	.text
	.globl	main
	.type	main, @function
main:
.LFB3:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$1104, %rsp
	movl	%edi, -1092(%rbp)
	movq	%rsi, -1104(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	cmpl	$3, -1092(%rbp)
	je	.L3
	movq	-1104(%rbp), %rax
	movq	(%rax), %rdx
	movq	stderr(%rip), %rax
	movl	$.LC0, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf
	movl	$0, %edi
	call	exit
.L3:
	movq	-1104(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, -1072(%rbp)
	movq	-1104(%rbp), %rax
	addq	$16, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	atoi
	movl	%eax, -1084(%rbp)
	movl	$0, %edx
	movl	$1, %esi
	movl	$2, %edi
	call	socket
	movl	%eax, -1080(%rbp)
	cmpl	$0, -1080(%rbp)
	jns	.L4
	movl	$.LC1, %edi
	call	error
.L4:
	movq	-1072(%rbp), %rax
	movq	%rax, %rdi
	call	gethostbyname
	movq	%rax, -1064(%rbp)
	cmpq	$0, -1064(%rbp)
	jne	.L5
	movq	stderr(%rip), %rax
	movq	-1072(%rbp), %rdx
	movl	$.LC2, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf
	movl	$0, %edi
	call	exit
.L5:
	leaq	-1056(%rbp), %rax
	movl	$16, %esi
	movq	%rax, %rdi
	call	bzero
	movw	$2, -1056(%rbp)
	movq	-1064(%rbp), %rax
	movl	20(%rax), %eax
	movslq	%eax, %rdx
	movq	-1064(%rbp), %rax
	movq	24(%rax), %rax
	movq	(%rax), %rax
	leaq	-1056(%rbp), %rcx
	addq	$4, %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	bcopy
	movl	-1084(%rbp), %eax
	movzwl	%ax, %eax
	movl	%eax, %edi
	call	htons
	movw	%ax, -1054(%rbp)
	leaq	-1056(%rbp), %rcx
	movl	-1080(%rbp), %eax
	movl	$16, %edx
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	connect
	testl	%eax, %eax
	jns	.L6
	movl	$.LC3, %edi
	call	error
.L6:
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	leaq	-1040(%rbp), %rax
	movl	$1024, %esi
	movq	%rax, %rdi
	call	bzero
	movq	stdin(%rip), %rdx
	leaq	-1040(%rbp), %rax
	movl	$1024, %esi
	movq	%rax, %rdi
	call	fgets
	leaq	-1040(%rbp), %rax
	movq	%rax, %rdi
	call	strlen
	movq	%rax, %rdx
	leaq	-1040(%rbp), %rcx
	movl	-1080(%rbp), %eax
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	write
	movl	%eax, -1076(%rbp)
	cmpl	$0, -1076(%rbp)
	jns	.L7
	movl	$.LC5, %edi
	call	error
.L7:
	leaq	-1040(%rbp), %rax
	movl	$1024, %esi
	movq	%rax, %rdi
	call	bzero
	leaq	-1040(%rbp), %rcx
	movl	-1080(%rbp), %eax
	movl	$1024, %edx
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	read
	movl	%eax, -1076(%rbp)
	cmpl	$0, -1076(%rbp)
	jns	.L8
	movl	$.LC6, %edi
	call	error
.L8:
	leaq	-1040(%rbp), %rax
	movq	%rax, %rsi
	movl	$.LC7, %edi
	movl	$0, %eax
	call	printf
	movl	-1080(%rbp), %eax
	movl	%eax, %edi
	call	close
	movl	$0, %eax
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L10
	call	__stack_chk_fail
.L10:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.10) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
