;~ $info = WinActive("", "�� ������������� ������ ������� ������?")
;~ MsgBox(4096, '��������', $info)

While 1
	If WinActive("[CLASS:#32770]", "������ ����������� ������������") <> 0 Then
		MsgBox(4096, '��������', "��������� ����� � ������. ��������� ���������� ��������� ���� ������")
;~ 		Run ( "notepad.exe " & $sPathToIni, @WindowsDir)
		Exit
	EndIf
WEnd