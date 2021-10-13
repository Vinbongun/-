#include <file.au3>
$sPathToIni = 'C:\СПО\pkko-autologin\config.ini' ; путь к файлу настроек

;~ отключает остановку скрипта по нажатию на иконку в трее
Opt("TrayAutoPause", 0)


If Not FileExists($sPathToIni) Then ; если нет папки с настройками, то создается
	MsgBox(0,"Внимание", "Необходимо добавить в настройки логин и пароль", 3)
	_FileCreate($sPathToIni)
	IniWrite($sPathToIni, 'INFO', 'Version', '0.3')
	IniWrite($sPathToIni, '2021_OKS', 'Login', 'TestLogin_2021_OKS')
	IniWrite($sPathToIni, '2021_OKS', 'Password', 'TestPassword_2021_OKS')
	IniWrite($sPathToIni, '2021_ZU', 'Login', 'TestLogin_2021_ZU')
	IniWrite($sPathToIni, '2021_ZU', 'Password', 'TestPassword_2021_ZU')
	IniWrite($sPathToIni, 'VUON_OKS', 'Login', 'TestLogin_VUON_OKS')
	IniWrite($sPathToIni, 'VUON_OKS', 'Password', 'TestPassword_VUON_OKS')
	IniWrite($sPathToIni, 'VUON_ZU', 'Login', 'TestLogin_VUON_ZU')
	IniWrite($sPathToIni, 'VUON_ZU', 'Password', 'TestPassword_VUON_ZU')

	Sleep(2000)
	Run ( "notepad.exe " & $sPathToIni, @WindowsDir)
	Exit
EndIf


; Проверка на запуск одного экземпляра приложения
$p = ProcessList(StringReplace(@ScriptName,".au3",".exe"))
If $p[0][0] > 1 Then
    MsgBox(0,"Внимание", "Приложение уже запущенно", 3)
    Exit
EndIf


While 1
	$hWnd = WinWait("Авторизация пользователя")

	;~ Если открыт ПККО 2021, то для автохода используется логин и пароль от 2021, иначе от ВУОН
	$isOpen2021 = StringInStr(ProcessToPathFull("gko.exe"), "2021")
	$isOpenZU = StringInStr(ProcessToPathFull("gko.exe"), "ЗУ")
	$isOpenVUON = StringInStr(ProcessToPathFull("gko.exe"), "ВУОН")

	If $isOpen2021 <> 0 And $isOpenZU <> 0  Then ; Открыт ПККО 2021 ЗУ
;~ 		MsgBox(4096, 'Сообщение', "Открыт ПККО 2021 ЗУ")
		$iniLogin = IniRead($sPathToIni, '2021_ZU', 'Login', -1)
		$iniPassword = IniRead($sPathToIni, '2021_ZU', 'Password', -1)
	EndIf
	If $isOpen2021 <> 0 And $isOpenZU = 0  Then ; Открыт ПККО 2021 ОКС
;~ 		MsgBox(4096, 'Сообщение', "Открыт ПККО 2021 ОКС")
		$iniLogin = IniRead($sPathToIni, '2021_OKS', 'Login', -1)
		$iniPassword = IniRead($sPathToIni, '2021_OKS', 'Password', -1)
	EndIf
	If $isOpenVUON <> 0 And $isOpenZU <> 0  Then ; Открыт ПККО ВУОН ЗУ
;~ 		MsgBox(4096, 'Сообщение', "Открыт ПККО ВУОН ЗУ")
		$iniLogin = IniRead($sPathToIni, 'VUON_ZU', 'Login', -1)
		$iniPassword = IniRead($sPathToIni, 'VUON_ZU', 'Password', -1)
	EndIf
	If $isOpenVUON <> 0 And $isOpenZU = 0  Then; Открыт ПККО ВУОН ОКС
;~ 		MsgBox(4096, 'Сообщение', "Открыт ПККО ВУОН ОКС")
		$iniLogin = IniRead($sPathToIni, 'VUON_OKS', 'Login', -1)
		$iniPassword = IniRead($sPathToIni, 'VUON_OKS', 'Password', -1)
	EndIf

	ControlSetText($hWnd, "", "[NAME:tbLogin]", $iniLogin) ;Вставка логина
	ControlSetText($hWnd, "", "[NAME:tbPassword]", $iniPassword) ;Вставка пароля
	ControlClick($hWnd, '', '[NAME:btnLogin]', "main") ;Нажатие на кнопку войти

	; Проверка на правильность логина и пароля
	If WinActive("[CLASS:#32770]", "Ошибка авторизации пользователя") <> 0 Then ; Если появилось сообщение об ошибки
		MsgBox(4096, 'Внимание', "Проверьте логин и пароль. Запустите приложение Автологин ПККО заново")
		Run ( "notepad.exe " & $sPathToIni, @WindowsDir) ; Открываем файл для редактирования пароля
		Exit
	EndIf

WEnd

;~ Функция определения версии запущенного приложения
Func ProcessToPathFull($NameProcess)
	Local $PathProc = ""
	Local $objWMIService = ObjGet("WinMgmts:\\.\root\cimv2")
	Local $colItems = $objWMIService.ExecQuery('SELECT * FROM Win32_Process where Caption="' & $NameProcess & '"')
	If IsObj($colItems) Then
		For $objItem In $colItems
			$PathProc = $objItem.ExecutablePath
		Next
	EndIf

	If $PathProc = "" Then
		Return SetError(1, 0, '')
	EndIf

	Return $PathProc
EndFunc
;~ //Функция определения версии запущенного приложения