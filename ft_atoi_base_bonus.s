section .text
	global	_ft_atoi_base
_ft_is_whitespace: ; int is_whitespace(char dil)
	cmp		dil, 0x20
	je		_ft_is_whitespace_ret
	sub		dil, 9
	cmp		dil, 5
	jb		_ft_is_whitespace_ret
	mov		rax, 0
	ret		
_ft_is_whitespace_ret:
	mov		rax, 1
	ret

_ft_is_right: ; int is_right(int rdi)
	push	rdx
	push	rcx
	mov		rdx, 0
_ft_is_right_loop1:
	cmp		byte[rdi + rdx], 0
	je		_ft_is_right_loop1_end
	cmp		byte[rdi + rdx], 0x2b ; +
	je		_ft_is_right_ret_zero
	cmp		byte[rdi + rdx], 0x2d ; -
	je		_ft_is_right_ret_zero
	push	rdi
	call	_ft_is_whitespace
	pop		rdi
	cmp		rax, 1
	je		_ft_is_right_ret_zero
	mov		rcx, rdx
	inc		rcx
_ft_is_right_loop2:
	cmp		byte[rdi + rcx], 0
	je		_ft_is_right_loop2_end
	mov		al, byte[rdi + rdx]
	cmp		byte[rdi + rcx], al
	je		_ft_is_right_ret_zero
	inc		rcx
	jmp		_ft_is_right_loop2
_ft_is_right_loop2_end:
	inc		rdx
	jmp		_ft_is_right_loop1
_ft_is_right_loop1_end:
	cmp		rdx, 1
	jbe		_ft_is_right_ret_zero
	mov		rax, rdx
	jmp		_ft_is_right_ret
_ft_is_right_ret_zero:
	mov		rax, 0
_ft_is_right_ret:
	pop		rcx
	pop		rdx
	ret

_ft_btot: ; int	btot(char dil, char *rsi);
	mov		rax, 0
_ft_btot_loop:
	cmp		byte[rsi + rax], 0
	je		_ft_btot_loop_end_minus
	cmp		byte[rsi + rax], dil
	je		_ft_btot_loop_end
	inc		rax
	jmp		_ft_btot_loop
_ft_btot_loop_end_minus:
	mov		rax, -1
_ft_btot_loop_end:
	ret

_ft_atoi_base:; int ft_atoi_base(char * rdi, char * rsi)
	push	r8	;r
	push	r9	;n
	push	r11	;m
	push	r12 ;rdi's index
	mov		r8, 0
	mov		r9, 1
	push	rdi
	mov		rdi, rsi
	call	_ft_is_right
	mov		r11, rax
	pop		rdi
	cmp		r11, 0
	je		_ft_atoi_base_end
	mov		r12, 0
_ft_atoi_base_wsloop:
	push	rdi
	mov		dil, byte[rdi + r12]
	call	_ft_is_whitespace
	pop		rdi
	cmp		rax, 1
	jne		_ft_atoi_base_pmloop
	inc		r12
	jmp		_ft_atoi_base_wsloop
_ft_atoi_base_pmloop:
	cmp		byte[rdi + r12], 0x2b
	je		_ft_atoi_base_pmloop_jmp
	cmp		byte[rdi + r12], 0x2d
	jne		_ft_atoi_base_loop
	imul	r9, -1		
_ft_atoi_base_pmloop_jmp:
	inc		r12
	jmp		_ft_atoi_base_pmloop
_ft_atoi_base_loop:
	cmp		byte[rdi + r12], 0
	je		_ft_atoi_base_end
	push	rdi
	mov		dil, byte[rdi + r12]
	call	_ft_btot
	pop		rdi
	cmp		rax, -1
	je		_ft_atoi_base_end
	imul	r8, r11
	add		r8, rax
	inc		r12
	jmp		_ft_atoi_base_loop
_ft_atoi_base_end:
	mov		rax, r9
	imul	rax, r8
	pop		r12
	pop		r11
	pop		r9
	pop		r8
	ret