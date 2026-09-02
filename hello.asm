option casemap:none          ; Torna o assembly case-sensitive

; -------- Importação de funções da API Windows --------
extrn MessageBoxA : proc     ; Função da user32.dll
extrn ExitProcess : proc     ; Função da kernel32.dll

; as funções da Win32 são importadas da seguinte maneira no asm
; extrn SimboloDaLib : proc
; extrn diz ao assembler colocar no objeto que o simbolo deve ser resolvido pelo linker
; usando uma dll.
; proc indica que o simbolo externo é um procedimento/rotina/função

; -------- Bibliotecas para o linker --------
includelib user32.lib ; o linker procura o simbolo na dll de funções gráficas nativas do windows
includelib kernel32.lib ; o linker procura o simbolo na dll fundamental do windows.

; -------- Segmento de dados ----------
.data
    szText    db "Hello World!", 0
    szCaption db "Montado pelo MASM", 0

; o segmento de dados é onde as "variáveis" são declaradas no assembly
; remete muito ao C89

; -------- Segmento de código ----------
.code
main proc
    ; Reserva 40 bytes (28h) na pilha:
    ; - 32 bytes (20h) para o "shadow space" dos 4 argumentos (RCX, RDX, R8, R9)
    ; - 8 bytes extras para alinhar a pilha em 16 bytes
    sub rsp, 28h

    ; Chama MessageBoxA(0, szText, szCaption, 0)
    xor rcx, rcx            ; 1º arg: hWnd = NULL (0)
    lea rdx, [szText]       ; 2º arg: lpText
    lea r8,  [szCaption]    ; 3º arg: lpCaption
    xor r9d, r9d            ; 4º arg: uType = MB_OK (0)
    call MessageBoxA

    ; Chama ExitProcess(0)
    xor ecx, ecx            ; Argumento: uExitCode = 0
    call ExitProcess

main endp
end
