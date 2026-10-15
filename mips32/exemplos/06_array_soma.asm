# ============================================================
# 06_array_soma.asm - Soma e maior elemento de um vetor
# Conceitos: .word, lw, aritmética de endereços (4 bytes por word),
#            ponteiro que avança pelo vetor
# Executar: java -jar tools/Mars4_5.jar nc mips32/exemplos/06_array_soma.asm
# Saída: "Soma: 51" e "Maior: 20"
# ============================================================

.data
vetor:  .word 3, 8, -2, 20, 15, 7     # 6 elementos de 4 bytes cada
tam:    .word 6
msg_s:  .asciiz "Soma: "
msg_m:  .asciiz "Maior: "
nl:     .asciiz "\n"

.text
.globl main
main:
    la   $t0, vetor          # $t0 = ponteiro para o elemento atual
    lw   $t1, tam            # $t1 = quantidade de elementos
    li   $t2, 0              # $t2 = soma = 0
    lw   $t3, 0($t0)         # $t3 = maior = primeiro elemento
    li   $t4, 0              # $t4 = índice i

loop:
    bge  $t4, $t1, fim       # i >= tam -> terminou

    lw   $t5, 0($t0)         # $t5 = vetor[i]
    add  $t2, $t2, $t5       # soma += vetor[i]

    ble  $t5, $t3, proximo   # se vetor[i] <= maior, não atualiza
    move $t3, $t5            # maior = vetor[i]

proximo:
    addi $t0, $t0, 4         # avança o ponteiro 4 bytes (1 word)
    addi $t4, $t4, 1         # i++
    j    loop

fim:
    li   $v0, 4
    la   $a0, msg_s
    syscall
    li   $v0, 1
    move $a0, $t2
    syscall
    li   $v0, 4
    la   $a0, nl
    syscall

    li   $v0, 4
    la   $a0, msg_m
    syscall
    li   $v0, 1
    move $a0, $t3
    syscall
    li   $v0, 4
    la   $a0, nl
    syscall

    li   $v0, 10
    syscall
