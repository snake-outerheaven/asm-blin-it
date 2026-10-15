# ============================================================
# 03_contagem.asm - Imprime os números de 1 até N
# Conceitos: laço com contador, ble, addi, j
# Executar: java -jar tools/Mars4_5.jar nc mips32/exemplos/03_contagem.asm
# Entrada 5 -> "1 2 3 4 5"
# ============================================================

.data
prompt: .asciiz "Contar até: "
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
    move $t0, $v0            # $t0 = N (limite)

    li   $t1, 1              # $t1 = i = 1 (contador)

loop:
    bgt  $t1, $t0, fim       # se i > N, sai do laço

    li   $v0, 1              # imprime i
    move $a0, $t1
    syscall

    li   $v0, 4              # imprime um espaço
    la   $a0, espaco
    syscall

    addi $t1, $t1, 1         # i++
    j    loop                # volta ao início do laço

fim:
    li   $v0, 4
    la   $a0, nl
    syscall

    li   $v0, 10
    syscall
