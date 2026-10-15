#!/bin/sh
# Baixa o simulador MARS (MIPS Assembler and Runtime Simulator) para tools/Mars4_5.jar.
# POSIX sh: usa wget e, se não existir, curl. Idempotente: não baixa de novo se o jar já existe.
# Uso: sh scripts/baixar-mars.sh

set -eu

URL="https://github.com/dpetersanderson/MARS/releases/download/v.4.5.1/Mars4_5.jar"

RAIZ=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
DESTINO="$RAIZ/tools/Mars4_5.jar"

if ! command -v java >/dev/null 2>&1; then
    echo "Aviso: Java não encontrado no PATH. O MARS precisa de Java para rodar." >&2
fi

if [ -s "$DESTINO" ]; then
    echo "MARS já existe em $DESTINO (nada a fazer)."
    exit 0
fi

mkdir -p "$RAIZ/tools"
TMP="$DESTINO.part"
trap 'rm -f "$TMP"' EXIT

echo "Baixando MARS de $URL ..."
if command -v wget >/dev/null 2>&1; then
    wget -q -O "$TMP" "$URL"
elif command -v curl >/dev/null 2>&1; then
    curl -fsSL -o "$TMP" "$URL"
else
    echo "Erro: instale wget ou curl para baixar o MARS." >&2
    exit 1
fi

# Um JAR é um ZIP: deve começar com os bytes "PK".
if [ "$(head -c 2 "$TMP")" != "PK" ]; then
    echo "Erro: o arquivo baixado não é um JAR válido." >&2
    exit 1
fi

mv "$TMP" "$DESTINO"
echo "Pronto: $DESTINO"
echo "Execute com: java -jar tools/Mars4_5.jar"
