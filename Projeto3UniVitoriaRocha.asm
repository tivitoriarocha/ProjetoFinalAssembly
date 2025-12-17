%INCLUDE "io.inc"

section .data
    ; Requisito: Vetor de números (Array)
    array_numeros dd 10, 20, 30, 40, 50
    tamanho_array dd 5
    
    ; O número que queremos procurar
    valor_alvo    dd 10  ; Tente mudar para 99 para ver o erro
    
    msg_achei     db "Valor encontrado no indice: ", 0
    msg_nao_achei db "Valor NAO encontrado.", 0

section .text
global main

main:
    mov ebp, esp ; Debugging
    
    PRINT_STRING "Procurando pelo valor: "
    PRINT_DEC 4, [valor_alvo]
    NEWLINE
    
    ; Chama a função de busca
    call buscar_valor
    
    xor eax, eax
    ret

; --- FUNÇÃO MODULAR ---
buscar_valor:
    ; Vamos usar ECX como contador (índice)
    xor ecx, ecx            ; Zera o contador (ecx = 0)

.loop_busca:
    ; 1. Verifica se chegou ao fim do array
    cmp ecx, [tamanho_array]
    jge .nao_encontrado     ; Se contador >= tamanho, acabou e não achou
    
    ; 2. Compara o valor do array com o alvo
    ; Endereço = base + (indice * 4 bytes)
    mov ebx, [array_numeros + ecx*4] 
    
    cmp ebx, [valor_alvo]   ; Compara valor atual com alvo
    je .encontrado          ; Se igual, achou!
    
    ; 3. Prepara próxima volta
    inc ecx                 ; Próximo índice
    jmp .loop_busca         ; Volta pro começo do loop

.encontrado:
    PRINT_STRING msg_achei
    PRINT_DEC 4, ecx        ; Imprime o índice (0, 1, 2...)
    NEWLINE
    ret

.nao_encontrado:
    PRINT_STRING msg_nao_achei
    NEWLINE
    ret
