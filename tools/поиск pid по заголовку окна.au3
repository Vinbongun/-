; �������� 5 ������ �� ��������� ���� ��������
$hWnd = WinWait("[CLASS:WindowsForms10.Window.8.app.0.13965fa_r9_ad1]", "", 5)
If Not $hWnd Then
    MsgBox(4096, '���������', '���� �� �������, ��������� ������ �������')
    Exit
EndIf

; ���������� PID ��������.
Local $iPID = WinGetProcess($hWnd)

MsgBox(0, "������������� �������� (PID)", $iPID)

; ��������� �������.
WinClose($hWnd)

