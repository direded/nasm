extern printf     
extern scanf      

%include "misc.asm"

; -------------------------------
section .data      
asking_text     db "Введите точность вычисления (e > 0):", 10, 0
scanf_f         db "%lf", 0
n               dq 2

; -------------------------------
section .bss
eps    resq 1
factorial  resq 1
res     resq 1
vars       times 5 resq 1
; temp    resq 1

; rax, rbx, rcx, rdx, rsi, rdi

; -------------------------------
section .text           

global main     

%macro debug 0
    fst    qword [vars]
    print_double qword [vars]
    print_char 10
%endmacro

main:      
; --- enter point ---
    push    rbp     

; --- input ---         
    
    mov     rdi, asking_text
        call    printf

    io_symbol scanf_f, qword eps, scanf

; --- implementation ---
    

    finit

    fld    qword [eps] ; st2 is eps
    fild    qword [n] ; st1 is e
    fild    qword [n] ; st0 is factorial

    mov     rcx, [n]

    .loop:
        inc     rcx

        fld1
        fdiv    st1 ; divide by factorial

        fcomi    st3 
        jb     .end_loop

        cmp     rcx, 15
        jge     .end_loop

        faddp   st2, st0 ; add member to e
        
        mov     [vars], rcx
        fild    qword [vars] 
        fmulp    st1, st0 ; increase factorial

        jmp     .loop

    .end_loop:


    fxch    st2
    debug

    pop     rbp
    xor     rax, rax
    ret