# Como montar arquivos de assembly no nasm no Unix/Linux

bash```
    nasm -f elf64 file.asm <-- cria o arquivo objeto sem resolução de símbolos (precisa do linker)
    ld file
```
