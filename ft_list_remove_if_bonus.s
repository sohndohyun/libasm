section	.text
	global _ft_list_remove_if
	extern _free

%macro function_save 0
	push rdi
	push rsi
	push rdx
	push rcx
%endmacro

%macro function_save_end 0
	pop  rcx
	pop  rdx
	pop  rsi
	pop  rdi
%endmacro

; ft_list_remove_if(t_list **begin_list, void *data_ref,
;                   int (*cmp)(void *data, void *data_ref),
;                   void (*free_fct)(void *))
_ft_list_remove_if:
	push rbp
	mov  rbp, rsp
	sub  rsp, 8
	cmp  rdi, 0
	je   _ft_list_remove_if_end
	cmp  qword [rdi], 0
	je   _ft_list_remove_if_end
	function_save
	mov  rdi, [rdi]
	mov  rdi, [rdi + 0] 
	call rdx
	function_save_end
	cmp  rax, 0
	je   _ft_list_remove_if_remove
	push rdi
	mov  rdi, [rdi]
	lea  rdi, [rdi + 8]
	call _ft_list_remove_if
	pop  rdi
	jmp  _ft_list_remove_if_end
_ft_list_remove_if_remove:
	mov  rax, [rdi]                    
	mov  rax, [rax + 8]                
	mov  [rbp - 8], rax                
	push rdi                           
	function_save
	mov  rdi, [rdi]
	mov  rdi, [rdi + 0]
	call rcx                           
	function_save_end
	pop  rdi
	function_save
	mov  rdi, [rdi]
	call _free                         
	function_save_end
	mov rax, [rbp - 8]
	mov [rdi], rax
	call _ft_list_remove_if
_ft_list_remove_if_end:
	mov  rsp, rbp
	pop  rbp
	ret