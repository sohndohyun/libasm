section .text
	extern	_ft_strlen
	extern	_ft_strcpy
	extern	_malloc
	extern	___error
	global	_ft_strdup
_ft_strdup:
	push	rdi
	call	_ft_strlen
	inc		rax
	mov		rdi, rax
	call	_malloc
	pop		rsi
	cmp		rax, 0
	je		dup_error
	mov		rdi, rax
	call	_ft_strcpy
	ret
dup_error:
	push	rax
	call	___error
	mov		qword[rax], 12
	pop		rax
	ret
