#NoTrayIcon
$sPathToIni = 'C:\СПО\pkko-autologin\config.ini' ; путь к файлу настроек

Opt("TrayMenuMode", 1 + 2) ; Не отображать в трее пункты меню по умолчанию (Script Paused/Exit) и не отмечать галочками при выборе.

$iAbout = TrayCreateItem("О программе")
TrayCreateItem("") ; Создаёт разделитель

$iExit = TrayCreateItem("Выход")

TraySetState(1) ; Показывает меню трея

While 1
    Switch TrayGetMsg()
        Case $iAbout
            MsgBox(4096, "", "Автовоход в ПККО_2021 и ВУОН" & @CRLF & @CRLF & _
                    "Версия приложения: " & IniRead($sPathToIni,'INFO', 'Version', -1)))

        Case $iExit ; Выход
            ExitLoop
    EndSwitch
WEnd