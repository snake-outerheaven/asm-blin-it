# Como montar arquivos de assembly no nasm no Unix/Linux

bash```
    nasm -f elf64 file.asm <-- cria o arquivo objeto sem resolução de símbolos (precisa do linker)
    ld file
```


# MIPS32 no simulador MARS

```sh
sh scripts/baixar-mars.sh                      # Linux/macOS: baixa tools/Mars4_5.jar
pwsh scripts/baixar-mars.ps1                   # Windows/PowerShell
java -jar tools/Mars4_5.jar                    # interface gráfica
java -jar tools/Mars4_5.jar nc arquivo.asm     # executa pela linha de comando
```

Exemplos documentados em `mips32/exemplos/`.
