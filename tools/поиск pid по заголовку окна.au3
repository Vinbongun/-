; Ожидание 5 секунд до появление окна блокнота
$hWnd = WinWait("[CLASS:WindowsForms10.Window.8.app.0.13965fa_r9_ad1]", "", 5)
If Not $hWnd Then
    MsgBox(4096, 'Сообщение', 'Окно не найдено, завершаем работу скрипта')
    Exit
EndIf

; Возвращает PID блокнота.
Local $iPID = WinGetProcess($hWnd)

MsgBox(0, "Идентификатор процесса (PID)", $iPID)

; Закрывает блокнот.
WinClose($hWnd)

