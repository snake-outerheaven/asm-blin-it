# ============================================================
# 10_fila.asm - Fila (FIFO) circular sobre um vetor
# Conceitos: buffer circular, índice de início + tamanho,
#            módulo por potência de 2 com andi (i & (CAP-1))
# Interface:
#   enqueue: $a0 = valor     -> $v0 = 1 (ok) ou 0 (fila cheia)
#   dequeue:                 -> $v1 = 1 (ok) ou 0 (vazia); valor em $v0
# Demonstração (capacidade 4): enfileira 1..5 (o 5 não cabe), tira 2,
# enfileira 5 e 6 (o fim "dá a volta" no vetor) e esvazia a fila.
# Executar: java -jar tools/Mars4_5.jar nc mips32/exemplos/10_fila.asm
# Saída:
#   fila cheia
#   1 2
#   3 4 5 6
# ============================================================

.eqv CAP    4                    # capacidade (potência de 2)
.eqv MASCARA 3                   # CAP - 1

.data
fila:      .space 16             # 4 words
inicio:    .word 0               # índice do elemento mais antigo
tam:       .word 0               # quantidade de elementos
espaco:    .asciiz " "
msg_cheia: .asciiz "fila cheia\n"
nl:        .asciiz "\n"

.text
.globl main
main:
    # --- fase 1: enfileira 1..5 ---
    li   $s0, 1
f1:
    bgt  $s0, 5, f1_fim
    move $a0, $s0
    jal  enqueue
    bnez $v0, f1_ok
    li   $v0, 4                  # enqueue falhou: avisa
    la   $a0, msg_cheia
    syscall
f1_ok:
    addi $s0, $s0, 1
    j    f1
f1_fim:

    # --- fase 2: desenfileira 2 elementos ---
    li   $s0, 2
f2:
    beqz $s0, f2_fim
    jal  dequeue
    move $a0, $v0
    jal  imprime_num
    addi $s0, $s0, -1
    j    f2
f2_fim:
    li   $v0, 4
    la   $a0, nl
    syscall

    # --- fase 3: enfileira 5 e 6 (usa as posições liberadas no início) ---
    li   $s0, 5
f3:
    bgt  $s0, 6, f3_fim
    move $a0, $s0
    jal  enqueue
    addi $s0, $s0, 1
    j    f3
f3_fim:

    # --- fase 4: esvazia a fila ---
f4:
    jal  dequeue
    beqz $v1, f4_fim
    move $a0, $v0
    jal  imprime_num
    j    f4
f4_fim:
    li   $v0, 4
    la   $a0, nl
    syscall
    li   $v0, 10
    syscall

# ------------------------------------------------------------
# enqueue: insere $a0 no fim da fila.
# posição de escrita = (inicio + tam) & MASCARA
# ------------------------------------------------------------
enqueue:
    lw   $t0, tam
    li   $t1, CAP
    bge  $t0, $t1, enq_cheia

    lw   $t2, inicio
    add  $t3, $t2, $t0           # inicio + tam
    andi $t3, $t3, MASCARA       # volta ao começo se passar do fim
    sll  $t3, $t3, 2             # índice -> bytes
    la   $t4, fila
    add  $t4, $t4, $t3
    sw   $a0, 0($t4)

    addi $t0, $t0, 1             # tam++
    sw   $t0, tam
    li   $v0, 1
    jr   $ra
enq_cheia:
    li   $v0, 0
    jr   $ra

# ------------------------------------------------------------
# dequeue: remove o elemento mais antigo. Valor em $v0, status em $v1.
# ------------------------------------------------------------
dequeue:
    lw   $t0, tam
    beqz $t0, deq_vazia

    lw   $t2, inicio
    sll  $t3, $t2, 2
    la   $t4, fila
    add  $t4, $t4, $t3
    lw   $v0, 0($t4)             # elemento da frente

    addi $t2, $t2, 1             # inicio = (inicio + 1) & MASCARA
    andi $t2, $t2, MASCARA
    sw   $t2, inicio
    addi $t0, $t0, -1            # tam--
    sw   $t0, tam
    li   $v1, 1
    jr   $ra
deq_vazia:
    li   $v1, 0
    jr   $ra

# imprime_num: imprime o inteiro em $a0 seguido de um espaço (função folha)
imprime_num:
    li   $v0, 1
    syscall
    li   $v0, 4
    la   $a0, espaco
    syscall
    jr   $ra
