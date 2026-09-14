.data
	  msg: .asciiz "Ola mundo!\n"
.text
	 main:
		li $v0, 4 # carrega o código 4 em $v0, sys_write
		la $a0, msg # passa o endereço de msg e coloca no registrador
		syscall # chama o kernel
		
		li $v0, 10 # código 10 em $v0, sys_exit
		syscall # chama o kernel