# Baixa o simulador MARS (MIPS Assembler and Runtime Simulator) para tools\Mars4_5.jar.
# Compatível com Windows PowerShell 5.1 e PowerShell 7+. Idempotente.
# Uso: pwsh scripts/baixar-mars.ps1   (ou: powershell -File scripts\baixar-mars.ps1)

$ErrorActionPreference = 'Stop'

$Url     = 'https://github.com/dpetersanderson/MARS/releases/download/v.4.5.1/Mars4_5.jar'
$Raiz    = Split-Path -Parent $PSScriptRoot
$Pasta   = Join-Path $Raiz 'tools'
$Destino = Join-Path $Pasta 'Mars4_5.jar'
$Tmp     = "$Destino.part"

if (-not (Get-Command java -ErrorAction SilentlyContinue)) {
    Write-Warning 'Java não encontrado no PATH. O MARS precisa de Java para rodar.'
}

if ((Test-Path $Destino) -and ((Get-Item $Destino).Length -gt 0)) {
    Write-Host "MARS já existe em $Destino (nada a fazer)."
    exit 0
}

# PowerShell 5.1 pode não negociar TLS 1.2 por padrão.
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12

New-Item -ItemType Directory -Force -Path $Pasta | Out-Null

try {
    Write-Host "Baixando MARS de $Url ..."
    $ProgressPreference = 'SilentlyContinue'
    Invoke-WebRequest -Uri $Url -OutFile $Tmp -UseBasicParsing

    # Um JAR é um ZIP: deve começar com os bytes 'PK'.
    $Cabecalho = [System.IO.File]::ReadAllBytes($Tmp)[0..1]
    if ($Cabecalho[0] -ne 0x50 -or $Cabecalho[1] -ne 0x4B) {
        throw 'O arquivo baixado não é um JAR válido.'
    }

    Move-Item -Force -Path $Tmp -Destination $Destino
}
finally {
    if (Test-Path $Tmp) { Remove-Item -Force $Tmp }
}

Write-Host "Pronto: $Destino"
Write-Host 'Execute com: java -jar tools/Mars4_5.jar'
