section .text
	global	_ft_strcmp
_ft_strcmp:
	push	rcx
	mov		rcx, 0
loop:
	cmp		byte[rdi + rcx], 0
	je		finish
	mov		dl, byte[rdi + rcx]
	cmp		dl, byte[rsi + rcx]
	jne 	finish
	inc		rcx
	jmp		loop
finish:
	xor		rax, rax
	mov		al, byte[rdi + rcx]
	sub		al, byte[rsi + rcx]
	jnc		finish_end
	neg		al
	neg		eax
finish_end:
	pop		rcx
	ret