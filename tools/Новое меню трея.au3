#NoTrayIcon
$sPathToIni = 'C:\���\pkko-autologin\config.ini' ; ���� � ����� ��������

Opt("TrayMenuMode", 1 + 2) ; �� ���������� � ���� ������ ���� �� ��������� (Script Paused/Exit) � �� �������� ��������� ��� ������.

$iAbout = TrayCreateItem("� ���������")
TrayCreateItem("") ; ������ �����������

$iExit = TrayCreateItem("�����")

TraySetState(1) ; ���������� ���� ����

While 1
    Switch TrayGetMsg()
        Case $iAbout
            MsgBox(4096, "", "��������� � ����_2021 � ����" & @CRLF & @CRLF & _
                    "������ ����������: " & IniRead($sPathToIni,'INFO', 'Version', -1)))

        Case $iExit ; �����
            ExitLoop
    EndSwitch
WEnd