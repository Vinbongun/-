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
;~ $isOpenGKO2021 = StringInStr(ProcessToPathFull("gko.exe"), "2021")
;~ If $isOpenGKO2021 <> 0 Then
;~ 	MsgBox(4096, '���������', "������ ��� 2021")
;~ Else
;~ 	MsgBox(4096, '���������', "������ ����")
;~ EndIf

;~ MsgBox(4096, '���������', ProcessToPathFull("gko.exe"))


While 1
	$isOpen2021 = StringInStr(ProcessToPathFull("gko.exe"), "2021")
	$isOpenZU = StringInStr(ProcessToPathFull("gko.exe"), "��")
	$isOpenVUON = StringInStr(ProcessToPathFull("gko.exe"), "����")

	If $isOpen2021 <> 0 And $isOpenZU <> 0  Then
		MsgBox(4096, '���������', "������ ��� 2021 ��")
	EndIf

	If $isOpen2021 <> 0 And $isOpenZU = 0  Then
		MsgBox(4096, '���������', "������ ��� 2021 ���")
	EndIf

	If $isOpenVUON <> 0 And $isOpenZU <> 0  Then
		MsgBox(4096, '���������', "������ ��� ���� ��")
	EndIf

	If $isOpenVUON <> 0 And $isOpenZU = 0  Then
		MsgBox(4096, '���������', "������ ��� ���� ���")
	EndIf
WEnd