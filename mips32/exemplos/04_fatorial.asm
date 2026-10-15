# ============================================================
# 04_fatorial.asm - Fatorial iterativo de N
# Conceitos: laço decrescente, mul (32 bits baixos do produto)
# Atenção: fatorial de N > 12 estoura 32 bits.
# Executar: java -jar tools/Mars4_5.jar nc mips32/exemplos/04_fatorial.asm
# Entrada 5 -> "5! = 120"
# ============================================================

.data
prompt: .asciiz "N (0 a 12): "
igual:  .asciiz "! = "
nl:     .asciiz "\n"

.text
.globl main
main:
    li   $v0, 4
    la   $a0, prompt
    syscall

    li   $v0, 5
    syscall
    move $t0, $v0            # $t0 = N (preservado para imprimir depois)

    li   $t1, 1              # $t1 = resultado = 1
    move $t2, $t0            # $t2 = contador, começa em N

loop:
    ble  $t2, 1, fim         # quando contador <= 1, terminou (0! = 1! = 1)
    mul  $t1, $t1, $t2       # resultado *= contador
    addi $t2, $t2, -1        # contador--
    j    loop

fim:
    li   $v0, 1              # imprime N
    move $a0, $t0
    syscall

    li   $v0, 4              # imprime "! = "
    la   $a0, igual
    syscall

    li   $v0, 1              # imprime o resultado
    move $a0, $t1
    syscall

    li   $v0, 4
    la   $a0, nl
    syscall

    li   $v0, 10
    syscall
