# ============================================================
# 09_pilha.asm - Pilha (LIFO) implementada sobre um vetor
# Conceitos: estrutura em memória estática (.space), índice de topo,
#            funções push/pop com retorno de status em $v0/$v1
# Interface:
#   push: $a0 = valor        -> $v0 = 1 (ok) ou 0 (pilha cheia)
#   pop :                    -> $v1 = 1 (ok) ou 0 (vazia); valor em $v0
# Executar: java -jar tools/Mars4_5.jar nc mips32/exemplos/09_pilha.asm
# Saída: "30 20 10 [vazia]"
# ============================================================

.eqv CAP 8                       # capacidade: 8 elementos

.data
pilha:     .space 32             # 8 words * 4 bytes
topo:      .word 0               # quantidade de elementos (próxima posição livre)
espaco:    .asciiz " "
msg_vazia: .asciiz "[vazia]"
nl:        .asciiz "\n"

.text
.globl main
main:
    li   $a0, 10
    jal  push
    li   $a0, 20
    jal  push
    li   $a0, 30
    jal  push

    li   $s0, 4                  # 4 pops: os 3 valores e uma tentativa na pilha vazia
loop:
    beqz $s0, fim
    jal  pop
    beqz $v1, vazia              # $v1 == 0: nada para desempilhar

    move $a0, $v0                # imprime o valor desempilhado
    li   $v0, 1
    syscall
    li   $v0, 4
    la   $a0, espaco
    syscall
    j    proximo

vazia:
    li   $v0, 4
    la   $a0, msg_vazia
    syscall

proximo:
    addi $s0, $s0, -1
    j    loop

fim:
    li   $v0, 4
    la   $a0, nl
    syscall
    li   $v0, 10
    syscall

# ------------------------------------------------------------
# push: empilha $a0. $v0 = 1 em sucesso, 0 se cheia.
# ------------------------------------------------------------
push:
    lw   $t0, topo               # $t0 = topo atual
    li   $t1, CAP
    bge  $t0, $t1, push_cheia    # topo >= CAP: não cabe

    la   $t2, pilha
    sll  $t3, $t0, 2             # deslocamento em bytes = topo * 4
    add  $t2, $t2, $t3           # endereço de pilha[topo]
    sw   $a0, 0($t2)

    addi $t0, $t0, 1             # topo++
    sw   $t0, topo
    li   $v0, 1
    jr   $ra
push_cheia:
    li   $v0, 0
    jr   $ra

# ------------------------------------------------------------
# pop: desempilha. Valor em $v0; $v1 = 1 em sucesso, 0 se vazia.
# ------------------------------------------------------------
pop:
    lw   $t0, topo
    beqz $t0, pop_vazia

    addi $t0, $t0, -1            # topo-- (agora aponta para o último elemento)
    sw   $t0, topo

    la   $t2, pilha
    sll  $t3, $t0, 2
    add  $t2, $t2, $t3
    lw   $v0, 0($t2)             # valor do elemento removido
    li   $v1, 1
    jr   $ra
pop_vazia:
    li   $v1, 0
    jr   $ra
