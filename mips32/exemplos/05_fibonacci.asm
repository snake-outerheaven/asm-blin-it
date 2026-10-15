# ============================================================
# 05_fibonacci.asm - Imprime os N primeiros termos de Fibonacci
# Conceitos: troca de valores entre registradores, laço com contador
# Executar: java -jar tools/Mars4_5.jar nc mips32/exemplos/05_fibonacci.asm
# Entrada 8 -> "0 1 1 2 3 5 8 13"
# ============================================================

.data
prompt: .asciiz "Quantos termos? "
espaco: .asciiz " "
nl:     .asciiz "\n"

.text
.globl main
main:
    li   $v0, 4
    la   $a0, prompt
    syscall

    li   $v0, 5
    syscall
    move $t0, $v0            # $t0 = quantidade de termos

    li   $t1, 0              # $t1 = termo atual   (F0 = 0)
    li   $t2, 1              # $t2 = próximo termo (F1 = 1)
    li   $t3, 0              # $t3 = índice i

loop:
    bge  $t3, $t0, fim       # se i >= N, termina

    li   $v0, 1              # imprime o termo atual
    move $a0, $t1
    syscall

    li   $v0, 4
    la   $a0, espaco
    syscall

    add  $t4, $t1, $t2       # $t4 = atual + próximo
    move $t1, $t2            # atual   = próximo
    move $t2, $t4            # próximo = soma

    addi $t3, $t3, 1         # i++
    j    loop

fim:
    li   $v0, 4
    la   $a0, nl
    syscall

    li   $v0, 10
    syscall
