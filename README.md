# asm-blin-it

Bem-vindo ao **asm-blin-it**, um repositório dedicado à documentação e acompanhamento dos meus estudos com **Assembly** — inicialmente focado em **MASM** (Microsoft Macro Assembler) no ambiente **Windows**, com planos de expansão para o **GNU Assembler** (GAS) em outros sistemas.
Aqui você encontrará projetos, anotações e exemplos práticos, todos organizados de forma modular, com cada exemplo podendo ser montado, vinculado e executado de maneira independente.

---

## 📁 Estrutura do Repositório

Cada diretório de primeiro nível corresponde a um projeto ou exemplo independente, contendo seu código-fonte e um script de build (geralmente um `build.bat` ou Makefile). Isso permite que cada módulo seja explorado, compilado e executado individualmente, facilitando o aprendizado incremental e o reaproveitamento de código.

```
.
├── exemplo-1/
│   ├── main.asm
│   └── build.bat
├── exemplo-2/
│   ├── main.asm
│   └── build.bat
├── docs/
│   └── anotações.md
└── README.md
```

Para montar e executar qualquer exemplo no Windows (com MASM já instalado via Visual Studio Build Tools ou SDK):
```cmd
cd exemplo-1
build
```

O script `build.bat` típico pode conter:
```bat
@echo off
ml /c /coff main.asm
link /SUBSYSTEM:CONSOLE main.obj
main.exe
```

---

## 🎯 Objetivos

- Documentar o progresso e aprendizados em Assembly (MASM e futuramente GAS)
- Compartilhar códigos comentados e exemplos práticos (interrupções, chamadas de sistema, manipulação de memória, etc.)
- Registrar resoluções de desafios, exercícios e problemas reais do mundo do baixo nível
- Servir de referência para mim e para a comunidade que deseja mergulhar em Assembly

---

## Por que Assembly (MASM)?

Na minha opinião, Assembly é a camada mais próxima do hardware que ainda conseguimos programar de forma legível. Entender Assembly nos dá:

- **Controle total** sobre a CPU, registradores, pilha e gerenciamento de memória.
- **Performance extrema** — essencial para otimizações finas, drivers, sistemas embarcados e engenharia reversa.
- **Compreensão profunda** de como linguagens de alto nível são traduzidas e executadas.

No Windows, o MASM é a ferramenta tradicional e robusta, integrada ao ecossistema da Microsoft:

- **ml.exe** e **link.exe** fazem parte das ferramentas de build do Visual Studio, oferecendo um fluxo maduro e bem documentado.
- Acesso direto à **WinAPI**, permitindo criar aplicações nativas sem camadas intermediárias.
- Depuradores como **WinDbg** e **x64dbg** são poderosos aliados para entender o comportamento dos binários.

Além disso, a extensão para **GNU Assembler** (GAS) permitirá que eu explore o universo Linux e multiplataforma, ampliando horizontes e comparando sintaxes (AT&T vs Intel) e convenções de chamada.

---

## 📚 Recursos Úteis

- [Documentação oficial do MASM (Microsoft)](https://learn.microsoft.com/en-us/cpp/assembler/masm/)
- [WinAPI Reference](https://learn.microsoft.com/en-us/windows/win32/api/)
- [The Art of Assembly Language (online)](https://www.plantation-productions.com/Webster/www.artofasm.com/index.html) — clássico e abrangente.
- [MASM32 SDK](http://www.masm32.com/) — bibliotecas e exemplos para Windows.
- [GNU Assembler (GAS) — Using as](https://sourceware.org/binutils/docs/as/)
- [x86 Assembly Guide (CS 107)](https://web.stanford.edu/class/cs107/guide/x86-64.html) — referência rápida.

---

## 🚀 Próximos Passos (GNU Assembler)

Assim que consolidar a base com MASM no Windows, pretendo migrar parte dos exemplos para GAS no Linux, abordando:

- Sintaxe AT&T e Intel (com `.intel_syntax`).
- Chamadas de sistema via `int 0x80` ou `syscall`.
- Linkagem com `ld` e uso de bibliotecas C.
- Comparação de desempenho e portabilidade.

---

## 📞 Contato

Dúvidas, sugestões ou feedback?
Abra uma [issue](https://github.com/snake-outerheaven/asm-blin-it/issues) ou entre em contato pelo [GitHub](https://github.com/snake-outerheaven).

---

Feito com paixão, dedicação e muitos registradores!
**snake-outerheaven**
