.data
prompt: .asciiz "Digite um número inteiro: "
ret: .asciiz "Aqui está o valor escrito: "

.text

li $v0, 4
la $a0, prompt
syscall

li $v0, 5
syscall # faltou aqui
move $t0, $v0 

li $v0, 4
la $a0, ret
syscall

li $v0, 1
move $a0, $t0
syscall

li $v0, 10
syscall
