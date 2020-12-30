section .text
	extern	_ft_strlen
	extern	_ft_strcpy
	extern	_malloc
	global	_ft_strdup
_ft_strdup:
	push	rdi
	call	_ft_strlen
	inc		rax
	mov		rdi, rax
	call	_malloc
	cmp		rax, 0
	je		dup_error
	pop		rsi
	mov		rdi, rax
	call	_ft_strcpy
	ret
dup_error:
	pop		rdi
	ret
