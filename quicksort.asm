extern printf     
extern scanf      

%include "misc.asm"

; -------------------------------
section .data      
asking_text_1:    db "Введите размер массива (не больше 64):", 10, 0
asking_text_2:    db "Введите %lld целых чисел:", 10, 0
input_format:   db "%lld", 0
output_format:   db "%lld ", 0

; -------------------------------
section .bss
arr:        times 64 resq 1
arr_length: resq 1

; rax, rbx, rcx, rdx, rsi, rdi

; -------------------------------
section .text           

global main     

; args:
; array, left_bound, right_bound (included)
; bounds is addresses
; rdx, rsi, rdi respectively

qsort:
    cmp     rsi, rdi
    jl      .continue_rec
        ret
    .continue_rec:
    mov     rax, rdi ; rax is pivot
    mov     rbx, rsi ; rbx is iterator2

    mov     rcx, rsi ; rcx is iterator1

    .loop:
        cmp     rcx, rdi ; if iterator1 g then right bound
        jg      .end_loop

        cmp     rcx, rax  ; if iterator1 is pivot
        je      .continue_loop
        
        push    rsi
        push    rdi
        mov     rdi, [rcx]
        mov     rsi, [rax]
        cmp     rdi, rsi ; if *iterator1 ... *pivot
        jge     .do_not_replace
            mov     rsi, [rbx]
            mov     [rcx], rsi     
            mov     [rbx], rdi
            add     rbx, 8

        .do_not_replace:
        pop     rdi
        pop     rsi

    .continue_loop:
        add     rcx, 8
    jmp     .loop
    .end_loop:

    push    rdi
    push    rsi
        mov     rdi, [rax]
        mov     rsi, [rbx]
        mov     [rax], rsi
        mov     [rbx], rdi
    pop     rsi
    pop     rdi
    
    ; print_lld       rdx
    ; print_char      32
    ; print_lld       rsi
    ; print_char      32
    ; print_lld       rdi
    ; print_char  10
    ; print_array     output_format, arr, [arr_length]
    ; print_char  10

    push    rsi
    push    rdi
    mov     rdi, rbx
    sub     rdi, 8
    call qsort
    pop     rdi
    pop     rsi

    push    rsi
    push    rdi
    mov     rsi, rbx
    add     rsi, 8
    call qsort
    pop     rdi
    pop     rsi

    ret
    

main:      
; --- enter point ---
    push    rbp     

; --- input ---         
    
    mov     rdi, asking_text_1
        call    printf

    mov     rdi, input_format
    mov     rsi, arr_length
        call    scanf        


    mov     rdi, asking_text_2
    mov     rsi, [arr_length]
        call    printf

    scan_array  input_format, arr, [arr_length]

; --- implementation ---

    mov     rdx, arr
    mov     rsi, arr
    mov     rdi, arr
    mov     rcx, [arr_length]
    .loop:
        add     rdi, 8
    loop    .loop
    sub     rdi, 8
    call    qsort

    print_char  10
    print_array     output_format, arr, [arr_length]
    print_char  10

; --- end ---
    pop     rbp
    xor     rax, rax
    ret