If Not FileExists('C:\СПО\pkko-autologin\') Then ; если нет папки с настройками, то создается
	MsgBox(0,"Внимание", "Необходимо добавить в настройки логин и пароль", 3)
	DirCreate('C:\СПО\pkko-autologin\')
	IniWrite($sPathToIni, 'AUTOLOGIN', 'Login', '')
	IniWrite($sPathToIni, 'AUTOLOGIN', 'Password', '')
	Sleep(2000)
	Exit
EndIf

;~ отключает остановку скрипта по нажатию на иконку в трее
Opt("TrayAutoPause", 0)

; Проверка на запуск одного экземпляра приложения
$p = ProcessList(StringReplace(@ScriptName,".au3",".exe"))
If $p[0][0] > 1 Then
    MsgBox(0,"Внимание", "Приложение уже запущенно", 3)
    Exit
EndIf

$sPathToIni = 'C:\СПО\pkko-autologin\config.ini'

$iniLogin = IniRead($sPathToIni, 'AUTOLOGIN', 'Login', -1)
$iniPassword = IniRead($sPathToIni, 'AUTOLOGIN', 'Password', -1)




While 1
	ProcessWait("GKO.exe") ; Ожидает до появления процесса GKO.exe
	Sleep(2000)
	ControlSetText("Авторизация пользователя", "", "[CLASS:WindowsForms10.EDIT.app.0.13965fa_r9_ad1; INSTANCE:2]", $iniLogin) ;Вставка логина
	ControlSetText("Авторизация пользователя", "", "[CLASS:WindowsForms10.EDIT.app.0.13965fa_r9_ad1; INSTANCE:1]", $iniPassword) ;Вставка пароля
	ControlClick('Авторизация пользователя', '', '[CLASS:WindowsForms10.BUTTON.app.0.13965fa_r9_ad1; INSTANCE:2]', "main") ;Нажатие на кнопку войти
WEnd