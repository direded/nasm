section .data
	lld_format		db "%lld", 0
	c_format		db "%c", 0


section .text

%macro print_symbol 2
    push    rax
    push    rbx
    push    rcx
    push    rdx
    push    rsi
    push    rdi
    mov     rdi, %1
    mov     rsi, %2
    xor     rax, rax
        call    printf
    pop     rdi
    pop     rsi
    pop     rdx
    pop     rcx
    pop     rbx
    pop     rax

%endmacro

%macro print_lld 1
    print_symbol lld_format, %1
%endmacro

%macro print_char 1
    print_symbol c_format, %1
%endmacro