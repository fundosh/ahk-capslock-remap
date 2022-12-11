; Autohotkey Capslock Remapping Script 
; Danik
; More info at http://danikgames.com/blog/?p=714
; danikgames.com
; 
; Functionality:
; - Deactivates capslock for normal (accidental) use.
; - Hold Capslock and drag anywhere in a window to move it (not just the title bar).
; - Access the following functions when pressing Capslock: 
;     Cursor keys           - J, K, L, I
;     Space                 - Enter
;     Home, PgDn, PgUp, End - U, O, Y, H
;     Backspace and Del     - N, M
;
;     Insert                - B
;     Select all            - A
;     Cut, copy, paste      - S, D, F
;     Close tab, window     - W, E
;     Esc                   - R
;     Next, previous tab    - Tab, Q
;     Undo, redo            - , and .
;
; To use capslock as you normally would, you can press WinKey + Capslock


; This script is mostly assembled from modified versions of the following awesome scripts:
;
; # Home Row Computing by Gustavo Duarte: http://duartes.org/gustavo/blog/post/home-row-computing for 
; Changes: 
; - Does not need register remapping of AppsKey using SharpKeys.
; - Uses normal cursor key layout 
; - Added more hotkeys for insert, undo, redo etc.
;
; # Get the Linux Alt+Window Drag Functionality in Windows: http://www.howtogeek.com/howto/windows-vista/get-the-linux-altwindow-drag-functionality-in-windows/
; Changes: The only change was using Capslock instead of Alt. This 
; also removes problems in certain applications.




Persistent
SetCapsLockState "AlwaysOff"


; Capslock + jkli (left, down, up, right)

CapsLock & h::Send "{Blind}{Left DownTemp}"
CapsLock & h up::Send "{Blind}{Left Up}"

CapsLock & j::Send "{Blind}{Down DownTemp}"
CapsLock & j up::Send "{Blind}{Down Up}"

CapsLock & k::Send "{Blind}{Up DownTemp}"
CapsLock & k up::Send "{Blind}{Up Up}"

CapsLock & l::Send "{Blind}{Right DownTemp}"
CapsLock & l up::Send "{Blind}{Right Up}"


; CapsLock + uohy (pgdown, pgup, home, end)

CapsLock & y::SendInput "{Blind}{Home Down}"
CapsLock & y up::SendInput "{Blind}{Home Up}"

CapsLock & o::SendInput "{Blind}{End Down}"
CapsLock & o up::SendInput "{Blind}{End Up}"

CapsLock & u::SendInput "{Blind}{PgDn Down}"
CapsLock & u up::SendInput "{Blind}{PgDn Up}"

CapsLock & i::SendInput "{Blind}{PgUp Down}"
CapsLock & i up::SendInput "{Blind}{PgUp Up}"

; CapsLock + asdf (select all, cut-copy-paste)

CapsLock & a::SendInput "{Blind}{Ctrl Down}{a Down}"
CapsLock & a up::SendInput "{Blind}{Ctrl Up}{a Up}"

CapsLock & s::SendInput "{Blind}{Ctrl Down}{x Down}"
CapsLock & s up::SendInput "{Blind}{Ctrl Up}{x Up}"

CapsLock & d::SendInput "{Blind}{Ctrl Down}{c Down}"
CapsLock & d up::SendInput "{Blind}{Ctrl Up}{c Up}"

CapsLock & f::SendInput "{Blind}{Ctrl Down}{v Down}"
CapsLock & f up::SendInput "{Blind}{Ctrl Up}{v Up}"


; CapsLock + wer (close tab or window, press esc)

CapsLock & w::SendInput "{Blind}{Ctrl down}{F4}{Ctrl up}"
CapsLock & e::SendInput "{Blind}{Alt down}{F4}{Alt up}"
CapsLock & r::SendInput "{Blind}{Esc Down}"


;; CapsLock + nm (insert, backspace, del)
;
;CapsLock & b::SendInput "{Blind}{Insert Down}"
;CapsLock & m::SendInput "{Blind}{Del Down}"
;CapsLock & n::SendInput "{Blind}{BS Down}"
;CapsLock & BS::SendInput "{Blind}{BS Down}"
;
;
;; Make CapsLock & Enter equivalent to Control+Enter
;CapsLock & Enter::SendInput "{Ctrl down}{Enter}{Ctrl up}"
;
;
;; Make CapsLock & Alt Equivalent to Control+Alt
;;!CapsLock::SendInput "{Ctrl down}{Alt Down}"
;;!CapsLock up::SendInput "{Ctrl up}{Alt up}"
;
;
;; CapsLock + TAB/q (prev/next tab)
;;
;CapsLock & q::SendInput ""{Ctrl Down}{Tab Down}""
;CapsLock & q up::SendInput ""{Ctrl Up}{Tab Up}""
;CapsLock & Tab::SendInput ""{Ctrl Down}{Shift Down}{Tab Down}""
;CapsLock & Tab up::SendInput ""{Ctrl Up}{Shift Up}{Tab Up}""
;
;; CapsLock + ,/. (undo/redo)
;
;CapsLock & ,::SendInput ""{Ctrl Down}{z Down}""
;CapsLock & , up::SendInput ""{Ctrl Up}{z Up}""
;CapsLock & .::SendInput ""{Ctrl Down}{y Down}""
;CapsLock & . up::SendInput ""{Ctrl Up}{y Up}""
;
;
;; Make CapsLock+Space -> Enter
;CapsLock & Space::SendInput "{Enter Down}"



;; Make Win Key + CapsLock work like Capslock
;#CapsLock::
;If GetKeyState("CapsLock", "T") = 1
;    SetCapsLockState, AlwaysOff
;Else 
;    SetCapsLockState, AlwaysOn
;Return





; Drag windows anywhere
;
; This script modified from the original: http://www.autohotkey.com/docs/scripts/EasyWindowDrag.htm
; by The How-To Geek
; http://www.howtogeek.com 

;CapsLock & LButton::
;CoordMode, Mouse  ; Switch to screen/absolute coordinates.
;MouseGetPos, EWD_MouseStartX, EWD_MouseStartY, EWD_MouseWin
;WinGetPos, EWD_OriginalPosX, EWD_OriginalPosY,,, ahk_id %EWD_MouseWin%
;WinGet, EWD_WinState, MinMax, ahk_id %EWD_MouseWin% 
;if EWD_WinState = 0  ; Only if the window isn't maximized 
;    SetTimer, EWD_WatchMouse, 10 ; Track the mouse as the user drags it.
;return
;
;EWD_WatchMouse:
;GetKeyState, EWD_LButtonState, LButton, P
;if EWD_LButtonState = U  ; Button has been released, so drag is complete.
;{
;    SetTimer, EWD_WatchMouse, off
;    return
;}
;GetKeyState, EWD_EscapeState, Escape, P
;if EWD_EscapeState = D  ; Escape has been pressed, so drag is cancelled.
;{
;    SetTimer, EWD_WatchMouse, off
;    WinMove, ahk_id %EWD_MouseWin%,, %EWD_OriginalPosX%, %EWD_OriginalPosY%
;    return
;}
;; Otherwise, reposition the window to match the change in mouse coordinates
;; caused by the user having dragged the mouse:
;CoordMode, Mouse
;MouseGetPos, EWD_MouseX, EWD_MouseY
;WinGetPos, EWD_WinX, EWD_WinY,,, ahk_id %EWD_MouseWin%
;SetWinDelay, -1   ; Makes the below move faster/smoother.
;WinMove, ahk_id %EWD_MouseWin%,, EWD_WinX + EWD_MouseX - EWD_MouseStartX, EWD_WinY + EWD_MouseY - EWD_MouseStartY
;EWD_MouseStartX := EWD_MouseX  ; Update for the next timer-call to this subroutine.
;EWD_MouseStartY := EWD_MouseY
;return
