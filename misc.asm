%macro print_symbol 2
    push    rax
    push    rbx
    push    rcx
    push    rdi
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

%macro print_char 1
    print_symbol char_format, %1
%endmacro