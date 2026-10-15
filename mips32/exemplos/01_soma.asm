# ============================================================
# 01_soma.asm - Lê dois inteiros, soma e imprime o resultado
# Conceitos: syscalls de entrada/saída, add, move
# Syscalls: 4 (print string), 5 (read int), 1 (print int), 10 (exit)
# Executar: java -jar tools/Mars4_5.jar nc mips32/exemplos/01_soma.asm
# Entrada 7 e 5 -> saída: "Soma: 12"
# ============================================================

.data
prompt1: .asciiz "Primeiro número: "
prompt2: .asciiz "Segundo número: "
msg:     .asciiz "Soma: "
nl:      .asciiz "\n"

.text
.globl main
main:
    # --- lê o primeiro número ---
    li   $v0, 4              # syscall 4: imprime string
    la   $a0, prompt1        # $a0 = endereço da string
    syscall

    li   $v0, 5              # syscall 5: lê inteiro (resultado em $v0)
    syscall
    move $t0, $v0            # guarda o primeiro número em $t0

    # --- lê o segundo número ---
    li   $v0, 4
    la   $a0, prompt2
    syscall

    li   $v0, 5
    syscall
    move $t1, $v0            # guarda o segundo número em $t1

    # --- calcula a soma ---
    add  $t2, $t0, $t1       # $t2 = $t0 + $t1

    # --- imprime o resultado ---
    li   $v0, 4
    la   $a0, msg
    syscall

    li   $v0, 1              # syscall 1: imprime inteiro em $a0
    move $a0, $t2
    syscall

    li   $v0, 4
    la   $a0, nl
    syscall

    li   $v0, 10             # syscall 10: encerra o programa
    syscall
