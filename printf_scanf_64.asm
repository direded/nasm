extern  printf     
extern  scanf      

section .data      
input_text:    db "%s", 0
output_text:   db "You entered: %s ", 0

section .bss
number: resb 255

; rax, rbx, rcx, rdx, rsi, rdi

section .text           

global main     
main:               
    push    rbp     
    
    mov     rdi, input_text
    mov     rsi, number
    xor     rax, rax
        call    scanf   

    mov     rdi, output_text
    mov		rsi, number
        call    printf

    pop rbp    
    xor rax, rax      

    ret