extern printf     
extern scanf      

%include "misc.asm"

; -------------------------------
section .data      
asking_text:    db "Введите два натуральных числа:", 10, 0
input_format:   db "%lld %lld", 0
arr:            times 64 dq 0
arr_length:     dq 0
probe:          dq 2

; -------------------------------
section .bss
n1: resq 1
n2: resq 1

; rax, rbx, rcx, rdx, rsi, rdi

; -------------------------------
section .text           

global main     
gcd:
    cmp     rcx, 0
    jne     .continue
        mov     rsi, 0
        mov     rdi, 1
        mov     rax, rdx
        ret
    .continue:

    push    rcx
    push    rdx

        mov     rax, rdx
        xor     rdx, rdx
        div     rcx
        push    rdx
        mov     rdx, rcx
        pop     rcx
    
        call    gcd
    pop     rdx
    pop     rcx

    push    rsi

    push    rax
    push    rdx
        
        mov     rax, rdx
        xor     rdx, rdx
        idiv     rcx
        imul     rsi

        mov     rsi, rdi
        sub     rsi, rax 

    pop     rdx
    pop     rax

    pop     rdi

    ret

main:      
; --- input ---         
    push    rbp     
    
    mov     rdi, asking_text
        call    printf   

    mov     rdi, input_format
    mov     rsi, n1
    mov     rdx, n2
        call    scanf

; --- implementation ---

    mov     rcx, [n1]
    mov     rdx, [n2]
        call    gcd
    
    print_lld   rsi  
    print_char  32
    print_lld   rdi  
    print_char  10

    print_lld   rax
    print_char  10

    pop     rbp
    xor     rax, rax
    ret