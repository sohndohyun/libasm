section .text
	extern	_malloc
	global	_ft_list_push_front

_ft_list_push_front: ; void (t_list** rdi, void* rsi);
	cmp		rdi, 0
	je		_ft_list_push_front_end
	push	rdi
	push	rsi
	mov		rdi, 0
	mov		edi, 16
	call	_malloc
	pop		rsi
	pop		rdi
	cmp		rax, 0
	je		_ft_list_push_front_end
	mov		qword[rax + 0], rsi
	push	r10
	mov		r10, [rdi]
	mov		[rax + 8], r10
	pop		r10
	mov		[rdi], rax
_ft_list_push_front_end:
	ret
