section .data
    lld_format      db "%lld", 0
    c_format        db "%c", 0
    double_format   db "%.15f", 0


section .text

%macro io_symbol 3
    push    rax
    push    rbx
    push    rcx
    push    rdx
    push    rsi
    push    rdi
        mov     rsi, %2
        mov     rdi, %1
        xor     rax, rax
        xor     rbx, rbx
        xor     rcx, rcx
        xor     rdx, rdx
            call    %3
    pop     rdi
    pop     rsi
    pop     rdx
    pop     rcx
    pop     rbx
    pop     rax
%endmacro

%macro io_lld 2
    io_symbol lld_format, %1, %2
%endmacro

%macro io_char 2
    io_symbol c_format, %1, %2
%endmacro

%macro print_array 3
    push    rax
    push    rcx
    mov     rax, %2
    mov     rcx, %3

    %%loop:
        io_symbol   %1, [rax], printf
        add     rax, 8
    loop %%loop
    pop     rcx
    pop     rax
%endmacro

%macro scan_array 3
    push    rax
    push    rcx
    mov     rax, %2
    mov     rcx, %3

    %%loop:
        io_symbol   %1, rax, scanf
        add     rax, 8
    loop %%loop
    pop     rcx
    pop     rax
%endmacro
    
%macro print_symbol 2
    io_symbol %1, %2, printf
%endmacro

%macro print_lld 1
    io_symbol lld_format, %1, printf
%endmacro

%macro print_char 1
    io_symbol c_format, %1, printf
%endmacro

%macro print_double 1
    
    push    rax
    push    rbx
    push    rcx
    push    rdx
    push    rsi
    push    rdi
        mov    rdi, double_format
        mov    rax, 1
        movq    xmm0, %1
            call    printf
    pop     rdi
    pop     rsi
    pop     rdx
    pop     rcx
    pop     rbx
    pop     rax
%endmacro