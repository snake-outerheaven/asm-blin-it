# ============================================================
# 02_par_impar.asm - Diz se um número é par ou ímpar
# Conceitos: andi (máscara de bits), desvio condicional (beq), j
# Truque: o bit 0 de um inteiro é 1 se ele é ímpar e 0 se é par.
# Executar: java -jar tools/Mars4_5.jar nc mips32/exemplos/02_par_impar.asm
# Entrada 7 -> "ímpar"; entrada 10 -> "par"
# ============================================================

.data
prompt: .asciiz "Digite um número: "
par:    .asciiz "O número é par\n"
impar:  .asciiz "O número é ímpar\n"

.text
.globl main
main:
    li   $v0, 4
    la   $a0, prompt
    syscall

    li   $v0, 5              # lê inteiro
    syscall
    move $t0, $v0

    andi $t1, $t0, 1         # $t1 = bit menos significativo de $t0
    beq  $t1, $zero, eh_par  # se for 0, pula para eh_par

    la   $a0, impar          # caso contrário é ímpar
    j    imprime             # pula o bloco "par"

eh_par:
    la   $a0, par

imprime:
    li   $v0, 4              # $a0 já tem o endereço da mensagem
    syscall

    li   $v0, 10
    syscall
