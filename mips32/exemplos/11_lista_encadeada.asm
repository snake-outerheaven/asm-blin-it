# ============================================================
# 11_lista_encadeada.asm - Lista simplesmente encadeada no heap
# Conceitos: alocação dinâmica (syscall 9 = sbrk), nó de 8 bytes,
#            ponteiros (0 = nulo), percorrer, inserir e remover
# Nó:  offset 0 = valor (word)   offset 4 = ponteiro para o próximo
# A "cabeça" da lista é só um ponteiro; as funções que a alteram
# devolvem a nova cabeça em $v0. (Não há free: o sbrk só cresce.)
# Funções:
#   insere_inicio($a0=cabeça, $a1=valor) -> $v0 = nova cabeça
#   insere_fim   ($a0=cabeça, $a1=valor) -> $v0 = nova cabeça
#   remove       ($a0=cabeça, $a1=valor) -> $v0 = nova cabeça (1ª ocorrência)
#   busca        ($a0=cabeça, $a1=valor) -> $v0 = 1 se achou, 0 se não
#   imprime      ($a0=cabeça)
# Executar: java -jar tools/Mars4_5.jar nc mips32/exemplos/11_lista_encadeada.asm
# Saída:
#   1 -> 2 -> 3 -> 4 -> nulo
#   2 -> 4 -> nulo
#   busca 4: 1
#   busca 3: 0
# ============================================================

.data
seta:    .asciiz " -> "
nulo:    .asciiz "nulo\n"
msg_b4:  .asciiz "busca 4: "
msg_b3:  .asciiz "busca 3: "
nl:      .asciiz "\n"

.text
.globl main
main:
    li   $s0, 0                  # $s0 = cabeça da lista (0 = lista vazia)

    move $a0, $s0                # insere 2 no fim  -> [2]
    li   $a1, 2
    jal  insere_fim
    move $s0, $v0

    move $a0, $s0                # insere 3 no fim  -> [2, 3]
    li   $a1, 3
    jal  insere_fim
    move $s0, $v0

    move $a0, $s0                # insere 1 no início -> [1, 2, 3]
    li   $a1, 1
    jal  insere_inicio
    move $s0, $v0

    move $a0, $s0                # insere 4 no fim  -> [1, 2, 3, 4]
    li   $a1, 4
    jal  insere_fim
    move $s0, $v0

    move $a0, $s0
    jal  imprime

    move $a0, $s0                # remove 3 (meio)
    li   $a1, 3
    jal  remove
    move $s0, $v0

    move $a0, $s0                # remove 1 (cabeça)
    li   $a1, 1
    jal  remove
    move $s0, $v0

    move $a0, $s0
    jal  imprime                 # [2, 4]

    li   $v0, 4                  # busca 4
    la   $a0, msg_b4
    syscall
    move $a0, $s0
    li   $a1, 4
    jal  busca
    move $a0, $v0
    li   $v0, 1
    syscall
    li   $v0, 4
    la   $a0, nl
    syscall

    li   $v0, 4                  # busca 3 (já removido)
    la   $a0, msg_b3
    syscall
    move $a0, $s0
    li   $a1, 3
    jal  busca
    move $a0, $v0
    li   $v0, 1
    syscall
    li   $v0, 4
    la   $a0, nl
    syscall

    li   $v0, 10
    syscall

# ------------------------------------------------------------
# novo_no: $a0 = valor -> $v0 = endereço de um nó novo (próximo = nulo)
# ------------------------------------------------------------
novo_no:
    move $t0, $a0                # guarda o valor (syscall usa $a0)
    li   $v0, 9                  # syscall 9: aloca $a0 bytes no heap
    li   $a0, 8
    syscall                      # endereço do bloco em $v0
    sw   $t0, 0($v0)             # nó.valor = valor
    sw   $zero, 4($v0)           # nó.próximo = nulo
    jr   $ra

# ------------------------------------------------------------
insere_inicio:
    addi $sp, $sp, -8
    sw   $ra, 4($sp)
    sw   $a0, 0($sp)             # salva a cabeça antiga
    move $a0, $a1
    jal  novo_no                 # $v0 = nó novo
    lw   $t0, 0($sp)
    sw   $t0, 4($v0)             # nó.próximo = cabeça antiga; nó novo é a cabeça
    lw   $ra, 4($sp)
    addi $sp, $sp, 8
    jr   $ra

# ------------------------------------------------------------
insere_fim:
    addi $sp, $sp, -8
    sw   $ra, 4($sp)
    sw   $a0, 0($sp)
    move $a0, $a1
    jal  novo_no                 # $v0 = nó novo
    lw   $t0, 0($sp)             # $t0 = cabeça
    lw   $ra, 4($sp)
    addi $sp, $sp, 8
    beqz $t0, if_fim             # lista vazia: o nó novo é a cabeça ($v0 já está certo)

    move $t1, $t0                # percorre até o último nó (próximo == nulo)
if_acha:
    lw   $t2, 4($t1)
    beqz $t2, if_liga
    move $t1, $t2
    j    if_acha
if_liga:
    sw   $v0, 4($t1)             # último.próximo = nó novo
    move $v0, $t0                # a cabeça não mudou
if_fim:
    jr   $ra

# ------------------------------------------------------------
remove:
    move $v0, $a0                # por padrão a cabeça não muda
    beqz $a0, rm_fim             # lista vazia
    lw   $t0, 0($a0)
    bne  $t0, $a1, rm_procura
    lw   $v0, 4($a0)             # remove a cabeça: a nova cabeça é o próximo
    jr   $ra
rm_procura:
    move $t1, $a0                # $t1 = anterior
    lw   $t2, 4($t1)             # $t2 = atual
rm_loop:
    beqz $t2, rm_fim             # chegou ao fim sem achar
    lw   $t3, 0($t2)
    beq  $t3, $a1, rm_achou
    move $t1, $t2
    lw   $t2, 4($t2)
    j    rm_loop
rm_achou:
    lw   $t4, 4($t2)
    sw   $t4, 4($t1)             # anterior.próximo = atual.próximo (desliga o nó)
rm_fim:
    jr   $ra

# ------------------------------------------------------------
busca:
    li   $v0, 0
    move $t0, $a0
bs_loop:
    beqz $t0, bs_fim
    lw   $t1, 0($t0)
    beq  $t1, $a1, bs_achou
    lw   $t0, 4($t0)
    j    bs_loop
bs_achou:
    li   $v0, 1
bs_fim:
    jr   $ra

# ------------------------------------------------------------
imprime:
    move $t0, $a0
im_loop:
    beqz $t0, im_fim
    lw   $a0, 0($t0)
    li   $v0, 1
    syscall
    li   $v0, 4
    la   $a0, seta
    syscall
    lw   $t0, 4($t0)             # avança para o próximo nó
    j    im_loop
im_fim:
    li   $v0, 4
    la   $a0, nulo
    syscall
    jr   $ra
