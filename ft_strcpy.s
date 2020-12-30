section .text
	global	_ft_strcpy
_ft_strcpy:
	mov		rax, 0
loop:
	mov		dl, byte[rsi + rax]
	mov		byte[rdi + rax], dl
	cmp		byte[rsi + rax], 0
	je		finish
	inc 	rax
	jmp 	loop
finish:
	mov		rax, rdi
	ret