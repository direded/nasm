extern printf     
extern scanf      

%include "misc.asm"

; -------------------------------
section .data      
asking_text_1       db "Введите вещественное значение:", 10, 0
asking_text_2       db "Введите натуральную степень корня:", 10, 0
asking_text_3       db "Введите точность вычисления (e > 0):", 10, 0
scanf_f_1           db "%lf", 0
scanf_f_2           db "%lld", 0
test_text           db "test", 10, 0
n                   dq 2

; -------------------------------
section .bss
value         resq 1
eps         resq 1
root_power  resq 1
debug  resq 1
vars        times 5 resq 1
root_vars        times 5 resq 1

; rax, rbx, rcx, rdx, rsi, rdi
; -------------------------------
section .text           

global main     

%macro debug_st 1
    fxch    st%1
    fst    qword [debug]
    print_double qword [debug]
    print_char 10
    fxch    st%1
%endmacro

; raise st1 to st0 power and store in st1
; st1 - value and result
; st0 - power
pow:

    fld     st0
    fisttp  qword [vars]
    mov     rdi, qword [vars]

    ; print_lld   rdi
    ; print_char  10

    cmp     rdi, 0
    jne     .continue
        fld1
        fxch    st2
        fstp    st0
        ret
    .continue:


    fld     st1 ; copy st1
    fld1
    fxch    st3
    fstp    st0

    ; debug_st 1
    mov     rax, 1
    ror     rax, 1
    .loop:
        cmp     rax, 1
        je     .end_loop

            fld     st2
            fmulp    st3, st0

            ror     rax, 1

            mov     rdi, qword [vars] ; rdi is power now
            and     rdi, rax
            cmp     rdi, 0
            je      .loop
            fmul   st2, st0

        jmp     .loop

    .end_loop:
    fstp    st0

    ret

; get rdi root of rsi
; rdx - eps
; rsi - value and result is double
; rdi - power of root is int
root:
    mov     [root_vars], rsi
    mov     [root_vars + 8], rsi ; left bound
    mov     [root_vars + 16], rsi ; right bound
    mov     [root_vars + 24], rdx ; eps
    mov     [root_vars + 32], rdi ; power
    fld1                          ; push
    fld     qword [root_vars + 8] ; push 
    fabs
    fadd    st0, st1
    fchs
    fld     qword [root_vars + 16] ; push 
    fabs
    fadd    st0, st2
    fstp     qword [root_vars + 16] ; pop 
    fstp     qword [root_vars + 8] ; pop
    fstp     st0                   ; pop

    .loop:

        fld     qword [root_vars + 16] ; push right
        fld     qword [root_vars + 8]  ; push left
        fsubp    st1, st0              ; pop

        ; print_lld   [root_vars]
        ; print_char  10

        fld     qword [root_vars + 24] ; push eps
        fxch    st1

        fcomi   st0, st1 ; right - left < eps
        fstp    st0                     ; pop
        fstp    st0                     ; pop
        jb      .end_loop

            fld     qword [root_vars + 8]  ; push left
            fadd    qword [root_vars + 16]
            fld1                           ; push
            fadd    st0, st0
            fdivp   st1, st0 ; pop, now st0 is medium

            fld     st0                    ; push, copy medium
            fild     qword [root_vars + 32] ; push power

            call    pow                  ; result in st1
            fstp    st0                    ; pop power

            fld     qword [root_vars]      ; push value
            fcomi   st1
            jb      .shift_right_bound
                fxch    st2
                fstp    qword [root_vars + 8]  ; pop
                fstp    st0 ; pop
                fstp    st0 ; pop
            jmp     .loop
                
            .shift_right_bound:
                fxch    st2
                fstp    qword [root_vars + 16]  ; pop
                fstp    st0 ; pop
                fstp    st0 ; pop


        jmp     .loop
    
    .end_loop:
    fld     qword [root_vars]
    fldz
    fcomi   st1
    jb      .positive   
        fld     qword [root_vars + 8]
        jmp     .negative
            .positive:   
            fld     qword [root_vars + 16]
    .negative:
    fxch    st2
    fstp    st0
    fstp    st0
    ret

main:      
; --- enter point ---
    push    rbp     

; --- input ---         

    print_text  asking_text_1
    io_symbol   scanf_f_1, qword value, scanf

    print_text  asking_text_2
    io_symbol   scanf_f_2, qword root_power, scanf

    print_text  asking_text_3
    io_symbol   scanf_f_1, qword eps, scanf

; --- implementation ---    

    finit

    mov     rdx, qword [eps]
    mov     rsi, qword [value]
    mov     rdi, qword [root_power]

    call root

    debug_st 0


    pop     rbp
    xor     rax, rax
    ret