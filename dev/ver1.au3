If Not FileExists('C:\���\pkko-autologin\') Then ; ���� ��� ����� � �����������, �� ���������
	MsgBox(0,"��������", "���������� �������� � ��������� ����� � ������", 3)
	DirCreate('C:\���\pkko-autologin\')
	IniWrite($sPathToIni, 'AUTOLOGIN', 'Login', '')
	IniWrite($sPathToIni, 'AUTOLOGIN', 'Password', '')
	Sleep(2000)
	Exit
EndIf

;~ ��������� ��������� ������� �� ������� �� ������ � ����
Opt("TrayAutoPause", 0)

; �������� �� ������ ������ ���������� ����������
$p = ProcessList(StringReplace(@ScriptName,".au3",".exe"))
If $p[0][0] > 1 Then
    MsgBox(0,"��������", "���������� ��� ���������", 3)
    Exit
EndIf

$sPathToIni = 'C:\���\pkko-autologin\config.ini'

$iniLogin = IniRead($sPathToIni, 'AUTOLOGIN', 'Login', -1)
$iniPassword = IniRead($sPathToIni, 'AUTOLOGIN', 'Password', -1)




While 1
	ProcessWait("GKO.exe") ; ������� �� ��������� �������� GKO.exe
	Sleep(2000)
	ControlSetText("����������� ������������", "", "[CLASS:WindowsForms10.EDIT.app.0.13965fa_r9_ad1; INSTANCE:2]", $iniLogin) ;������� ������
	ControlSetText("����������� ������������", "", "[CLASS:WindowsForms10.EDIT.app.0.13965fa_r9_ad1; INSTANCE:1]", $iniPassword) ;������� ������
	ControlClick('����������� ������������', '', '[CLASS:WindowsForms10.BUTTON.app.0.13965fa_r9_ad1; INSTANCE:2]', "main") ;������� �� ������ �����
WEnd