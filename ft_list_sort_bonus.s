section	.text
	global	_ft_list_sort

_ft_list_sort:
	cmp  rdi, 0
	je   ft_ret
	mov  rax, [rdi]
	cmp  rax, 0
	je   ft_ret
	mov  rbx, [rax + 8]
	cmp  rbx, 0
	je   ft_ret
_ft_list_sort_loop1:
	mov  rbx, [rbx + 8]
	cmp  rbx, 0
	je   _ft_list_sort_loop1_end 
	mov  rbx, [rbx + 8]
	mov  rax, [rax + 8]
	cmp  rbx, 0
	jne  _ft_list_sort_loop1
_ft_list_sort_loop1_end:
	push rbp
	mov  rbp, rsp
	sub  rsp, 8
	mov  rcx, [rax + 8]
	mov  [rbp - 8], rcx
	mov  qword [rax + 8], 0
	push rdi
	push rsi
	call _ft_list_sort
	lea  rdi, [rbp - 8]
	call _ft_list_sort
	pop  rsi
	pop  rdi
	push rdi
	push rsi
	mov  rdi, [rdi]
	mov  rdx, rsi
	mov  rsi, [rbp - 8]
	call merge_sort
	pop  rsi
	pop  rdi
	mov  [rdi], rax
	mov  rsp, rbp
	pop  rbp
ft_ret:
	ret

merge_sort:
	cmp  rdi, 0
	je   merge_return_right
	cmp  rsi, 0
	je   merge_return_left
	push rdi
	push rsi
	push rdx
	mov  rdi, [rdi + 0]
	mov  rsi, [rsi + 0]
	xor  rax, rax
	call rdx
	pop  rdx
	pop  rsi
	pop  rdi
	cmp  eax, 0
	jl   merge_left_right
	push rsi
	mov  rsi, [rsi + 8]
	call merge_sort
	pop  rsi
	mov  [rsi + 8], rax
	mov  rax, rsi
	jmp  ft_ret
merge_left_right:
	push rdi
	mov  rdi, [rdi + 8]
	call merge_sort
	pop  rdi
	mov  [rdi + 8], rax
	mov  rax, rdi
	jmp  ft_ret
merge_return_left:
	mov  rax, rdi
	ret
merge_return_right:
	mov  rax, rsi