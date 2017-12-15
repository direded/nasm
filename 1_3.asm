extern printf     
extern scanf      

%include "misc.asm"

; -------------------------------
section .data      
asking_text:    db "Введите натуральное число:", 10, 0
input_format:   db "%lld", 0
multiplier_format:     db "%lld * ", 0
last_multiplier_format:     db "%lld", 10, 0
arr:            times 64 dq 0
arr_length:     dq 0
probe:			dq 2

; -------------------------------
section .bss
number: resq 1
mult: resq 1

; rax, rbx, rcx, rdx, rsi, rdi

; -------------------------------
section .text           

global main     
main:      
; --- input ---         
    push    rbp     
    
    mov     rdi, asking_text
        call    printf   

    mov     rdi, input_format
    mov     rsi, number
        call    scanf

; --- implementation ---
	mov 	rax, [number]
	mov		[mult], rax

.loop0:
	mov		rax, [mult]
    mov 	rbx, [probe]
    xor 	rdx, rdx
    div		qword rbx

    cmp		rdx, 0
    je		.is_multiplier
    jne		.is_not_multiplier
   	
   	.is_not_multiplier
    inc		rbx
    mov		[probe], rbx
   	jmp		.endif0
    
    .is_multiplier:
    print_lld [probe]
   	print_char 32
   	mov 	[mult], rax

   	jmp		.endif0
   	
   	.endif0:
    mov		rax, rbx
    cmp		rax, [number]
    jle		.loop0

   	print_char 10
    pop     rbp
    xor     rax, rax
    ret