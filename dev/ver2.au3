#include <file.au3>
$sPathToIni = 'C:\���\pkko-autologin\config.ini' ; ���� � ����� ��������

;~ ��������� ��������� ������� �� ������� �� ������ � ����
Opt("TrayAutoPause", 0)


If Not FileExists($sPathToIni) Then ; ���� ��� ����� � �����������, �� ���������
	MsgBox(0,"��������", "���������� �������� � ��������� ����� � ������", 3)
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


; �������� �� ������ ������ ���������� ����������
$p = ProcessList(StringReplace(@ScriptName,".au3",".exe"))
If $p[0][0] > 1 Then
    MsgBox(0,"��������", "���������� ��� ���������", 3)
    Exit
EndIf


While 1
	$hWnd = WinWait("����������� ������������")

	;~ ���� ������ ���� 2021, �� ��� �������� ������������ ����� � ������ �� 2021, ����� �� ����
	$isOpen2021 = StringInStr(ProcessToPathFull("gko.exe"), "2021")
	$isOpenZU = StringInStr(ProcessToPathFull("gko.exe"), "��")
	$isOpenVUON = StringInStr(ProcessToPathFull("gko.exe"), "����")

	If $isOpen2021 <> 0 And $isOpenZU <> 0  Then ; ������ ���� 2021 ��
;~ 		MsgBox(4096, '���������', "������ ���� 2021 ��")
		$iniLogin = IniRead($sPathToIni, '2021_ZU', 'Login', -1)
		$iniPassword = IniRead($sPathToIni, '2021_ZU', 'Password', -1)
	EndIf
	If $isOpen2021 <> 0 And $isOpenZU = 0  Then ; ������ ���� 2021 ���
;~ 		MsgBox(4096, '���������', "������ ���� 2021 ���")
		$iniLogin = IniRead($sPathToIni, '2021_OKS', 'Login', -1)
		$iniPassword = IniRead($sPathToIni, '2021_OKS', 'Password', -1)
	EndIf
	If $isOpenVUON <> 0 And $isOpenZU <> 0  Then ; ������ ���� ���� ��
;~ 		MsgBox(4096, '���������', "������ ���� ���� ��")
		$iniLogin = IniRead($sPathToIni, 'VUON_ZU', 'Login', -1)
		$iniPassword = IniRead($sPathToIni, 'VUON_ZU', 'Password', -1)
	EndIf
	If $isOpenVUON <> 0 And $isOpenZU = 0  Then; ������ ���� ���� ���
;~ 		MsgBox(4096, '���������', "������ ���� ���� ���")
		$iniLogin = IniRead($sPathToIni, 'VUON_OKS', 'Login', -1)
		$iniPassword = IniRead($sPathToIni, 'VUON_OKS', 'Password', -1)
	EndIf

	ControlSetText($hWnd, "", "[NAME:tbLogin]", $iniLogin) ;������� ������
	ControlSetText($hWnd, "", "[NAME:tbPassword]", $iniPassword) ;������� ������
	ControlClick($hWnd, '', '[NAME:btnLogin]', "main") ;������� �� ������ �����

	; �������� �� ������������ ������ � ������
	If WinActive("[CLASS:#32770]", "������ ����������� ������������") <> 0 Then ; ���� ��������� ��������� �� ������
		MsgBox(4096, '��������', "��������� ����� � ������. ��������� ���������� ��������� ���� ������")
		Run ( "notepad.exe " & $sPathToIni, @WindowsDir) ; ��������� ���� ��� �������������� ������
		Exit
	EndIf

WEnd

;~ ������� ����������� ������ ����������� ����������
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
;~ //������� ����������� ������ ����������� ����������