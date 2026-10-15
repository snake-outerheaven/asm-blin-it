# Exemplos em MIPS32 (MARS)

Projetos pequenos e comentados, em ordem crescente de dificuldade.

## Como rodar

Baixe o MARS (uma vez):

```sh
sh scripts/baixar-mars.sh          # Linux/macOS
pwsh scripts/baixar-mars.ps1       # Windows / PowerShell
```

Interface gráfica (File > Open, depois F3 monta e F5 executa):

```sh
java -jar tools/Mars4_5.jar
```

Linha de comando (`nc` = sem o banner de copyright; a entrada vem do stdin):

```sh
printf '7\n5\n' | java -jar tools/Mars4_5.jar nc mips32/exemplos/01_soma.asm
```

## Índice

| Arquivo | Conceitos | Saída esperada |
|---|---|---|
| `01_soma.asm` | syscalls de E/S, `add` | entradas 7 e 5 → `Soma: 12` |
| `02_par_impar.asm` | `andi`, `beq`, `j` | 7 → ímpar; 10 → par |
| `03_contagem.asm` | laço, `bgt`, `addi` | 5 → `1 2 3 4 5` |
| `04_fatorial.asm` | `mul`, laço decrescente | 5 → `5! = 120` |
| `05_fibonacci.asm` | troca de registradores | 8 → `0 1 1 2 3 5 8 13` |
| `06_array_soma.asm` | `.word`, `lw`, ponteiro | `Soma: 51`, `Maior: 20` |
| `07_string_tamanho.asm` | `lb`, terminador nulo | `Tamanho: 9` |
| `08_funcao_jal.asm` | `jal`, `jr $ra`, pilha | `3^2 + 4^2 = 25` |
| `09_pilha.asm` | pilha (LIFO) em vetor, push/pop | `30 20 10 [vazia]` |
| `10_fila.asm` | fila (FIFO) circular, `andi` como módulo | `1 2` e `3 4 5 6` |
| `11_lista_encadeada.asm` | lista no heap (syscall 9), ponteiros | `1 -> 2 -> 3 -> 4 -> nulo` |

## Syscalls do MARS usadas (número em `$v0`)

| `$v0` | Serviço | Argumento / retorno |
|---|---|---|
| 1 | imprimir inteiro | `$a0` = valor |
| 4 | imprimir string | `$a0` = endereço da string terminada em 0 |
| 5 | ler inteiro | retorno em `$v0` |
| 9 | alocar memória no heap (sbrk) | `$a0` = bytes; endereço em `$v0` |
| 10 | encerrar programa | — |

## Registradores (convenção)

| Registrador | Uso |
|---|---|
| `$zero` | sempre 0 |
| `$v0`–`$v1` | número da syscall / valores de retorno |
| `$a0`–`$a3` | argumentos |
| `$t0`–`$t9` | temporários (a função chamada pode alterar) |
| `$s0`–`$s7` | salvos (quem os usa deve restaurá-los) |
| `$sp` / `$ra` | ponteiro da pilha / endereço de retorno |
