# ============================================================
# 07_string_tamanho.asm - strlen: conta os caracteres de uma string
# Conceitos: lb (carrega 1 byte), terminador nulo, ponteiro de string
# Executar: java -jar tools/Mars4_5.jar nc mips32/exemplos/07_string_tamanho.asm
# Saída: "Tamanho: 9" (para "Assembly!")
# ============================================================

.data
texto: .asciiz "Assembly!"      # .asciiz acrescenta o byte 0 no final
msg:   .asciiz "Tamanho: "
nl:    .asciiz "\n"

.text
.globl main
main:
    la   $t0, texto          # $t0 = ponteiro para o caractere atual
    li   $t1, 0              # $t1 = contador

loop:
    lb   $t2, 0($t0)         # $t2 = byte apontado (com sinal)
    beq  $t2, $zero, fim     # byte 0 = fim da string
    addi $t1, $t1, 1         # contador++
    addi $t0, $t0, 1         # próximo caractere (1 byte)
    j    loop

fim:
    li   $v0, 4
    la   $a0, msg
    syscall

    li   $v0, 1
    move $a0, $t1
    syscall

    li   $v0, 4
    la   $a0, nl
    syscall

    li   $v0, 10
    syscall
