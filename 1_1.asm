extern printf     
extern scanf      

%include "misc.asm"

; -------------------------------
section .data      
asking_text:    db "Введите число и базу:", 10, 0
input_format:   db "%lld %lld", 0
char_format:    db "%c", 0
num_format:     db "%lld", 0          
arr:            times 64 dq 0
arr_length:     dq 0

; -------------------------------
section .bss
number: resq 1
base:   resq 1

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
    mov     rdx, base
        call    scanf

; --- implementation ---

    mov     rbx, qword [number]
.loop0:
    xor     rax, rax
    xor     rdx, rdx

    mov     rax, rbx
    cmp     rbx, qword [base]
    jl     .continue0
    div     qword [base]

    mov     rbx, rax
    mov     rax, arr
    mov     rcx, [arr_length]
    mov     [rax + 8 * rcx], rdx
    inc     rcx
    mov     [arr_length], rcx
    jmp     .loop0

.continue0:
    mov     rax, arr
    mov     rcx, [arr_length]
    mov     [rax + 8 * rcx], rbx

.loop1:
    mov     rax, [arr + 8 * rcx]
    mov     rbx, num_format
    cmp     rax, 10
    jl      .num
        add     rax, 55
        mov     rbx, char_format
    .num:

    print_symbol    rbx, rax
    cmp     rcx, 0
    dec     rcx
    jge      .loop1

    print_char    10

    pop     rbp
    xor     rax, rax
    ret