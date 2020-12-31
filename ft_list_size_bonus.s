section	.text
	global	_ft_list_size

_ft_list_size:
	mov		rax, 0
	push	rdx
	mov		rdx, rdi
loop:
	cmp		rdx, 0
	je		loop_end
	inc		rax
	mov		rdx, [rdx + 8]
	jmp		loop
loop_end:
	pop		rdx
	ret