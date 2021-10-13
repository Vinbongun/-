;~ $info = WinActive("", "Вы действительно хотите закрыть модуль?")
;~ MsgBox(4096, 'Внимание', $info)

While 1
	If WinActive("[CLASS:#32770]", "Ошибка авторизации пользователя") <> 0 Then
		MsgBox(4096, 'Внимание', "Проверьте логин и пароль. Запустите приложение Автологин ПККО заново")
;~ 		Run ( "notepad.exe " & $sPathToIni, @WindowsDir)
		Exit
	EndIf
WEnd