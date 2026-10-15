# ============================================================
# 08_funcao_jal.asm - Funções, jal/jr e uso da pilha
# Conceitos: convenção de chamada ($a0 = argumento, $v0 = retorno),
#            jal grava o retorno em $ra, pilha ($sp) para salvar $ra
#            ao chamar outra função dentro de uma função.
# Funções:   quadrado(x) = x*x
#            soma_quadrados(a, b) = quadrado(a) + quadrado(b)
# Executar: java -jar tools/Mars4_5.jar nc mips32/exemplos/08_funcao_jal.asm
# Saída: "3^2 + 4^2 = 25"
# ============================================================

.data
msg: .asciiz "3^2 + 4^2 = "
nl:  .asciiz "\n"

.text
.globl main
main:
    li   $a0, 3              # argumento a
    li   $a1, 4              # argumento b
    jal  soma_quadrados      # chama; $ra = endereço da próxima instrução
    move $s0, $v0            # $s0 = retorno (registrador $s sobrevive a syscalls)

    li   $v0, 4
    la   $a0, msg
    syscall

    li   $v0, 1
    move $a0, $s0
    syscall

    li   $v0, 4
    la   $a0, nl
    syscall

    li   $v0, 10
    syscall

# ------------------------------------------------------------
# quadrado: $a0 = x  ->  $v0 = x*x   (função folha, não usa pilha)
# ------------------------------------------------------------
quadrado:
    mul  $v0, $a0, $a0
    jr   $ra                 # volta para quem chamou

# ------------------------------------------------------------
# soma_quadrados: $a0 = a, $a1 = b  ->  $v0 = a*a + b*b
# Chama outra função, então precisa salvar $ra e $a1 na pilha.
# ------------------------------------------------------------
soma_quadrados:
    addi $sp, $sp, -12       # reserva 3 words na pilha (a pilha cresce para baixo)
    sw   $ra, 8($sp)         # salva o endereço de retorno
    sw   $a1, 4($sp)         # salva b (a chamada abaixo pode alterar $a*)
    sw   $s1, 0($sp)         # salva $s1 (convenção: $s é responsabilidade de quem usa)

    jal  quadrado            # $v0 = a*a   ($a0 já é a)
    move $s1, $v0            # guarda a*a em $s1

    lw   $a0, 4($sp)         # recupera b como argumento
    jal  quadrado            # $v0 = b*b

    add  $v0, $s1, $v0       # $v0 = a*a + b*b

    lw   $s1, 0($sp)         # restaura os registradores salvos
    lw   $ra, 8($sp)
    addi $sp, $sp, 12        # libera o espaço da pilha
    jr   $ra
