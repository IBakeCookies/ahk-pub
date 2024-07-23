resolutionX := 3840
resolutionY := 2160
UW_W := 3440
WQHD_W := 2560
WQHD_H := 1440

; Some offset from the bottom
windowBottomOffest := 100
windowTop := resolutionY - WQHD_H - windowBottomOffest
windowLeftUW := (resolutionX - UW_W) / 2
windowRightUW := resolutionX / 2
windowWQHDLeft := (resolutionX - WQHD_W) / 2

isWindowMaximized() { 
    windowState := WinGetMinMax("A")

    return !!(windowState == 1)
}

openFocusWindow(name, path) {
    if !WinExist(name) {
        Run path
        return
    } 

    WinActivate
}

openMinimize(name, path) {
    if !WinActive(name) {
        openFocusWindow(name, path) 
        return
    }

    WinMinimize
}

togglePath(name, path) { 
    if !WinActive(name) {
        openFocusWindow(name, path) 
        return
    }

    WinClose
} 

moveWindow(x, y, w, h) {
    if isWindowMaximized() {
        WinRestore "A"
        WinMove x, y, w, h, "A"
        return 
    } 

    WinMove x, y, w, h, "A"
} 

; toggleSoundOutput() {
;     Run "mmsys.cpl"
;     ; WinWait "Sound"
;     ; Sleep 200
;     ; Send "{down 2}"
;     ; ControlClick "Set Default"
;     ; ControlClick "OK"
; }

goToLeftDesktop() {
    Send "#^{left}"
}

goToRightDesktop() {
    Send "#^{right}"
}

toggleHDR() {
    Send "#!{b}"
}

; this will open brave if its not open, otherwise it will focus it on
F13::openMinimize("Brave", "brave")

; move selected window to left
F18::moveWindow(windowLeftUW, windowTop, UW_W / 2, WQHD_H)

; center selected window
F19::moveWindow(windowWQHDLeft, windowTop, WQHD_W, WQHD_H)

; move selected window to right
F20::moveWindow(windowRightUW, windowTop, UW_W / 2, WQHD_H)

; F21::toggleSoundOutput()

F22::goToLeftDesktop()

F23::goToRightDesktop()

F24::toggleHDR()


ALT & F24:: {
    WinMaximize "A"
}

SHIFT & F14:: {
    Send "{Volume_Down}"
}

SHIFT & F15:: {
    Send "{Volume_Up}"
} 

; This is a nice way to fast search something, you press the shortcut and it will copy the current selection to the clipboard and open a new tab in brave and paste it there.
SHIFT & F16:: {
    Send "^c"
    ClipWait

    openFocusWindow("Brave", "brave")

    Send "^t"
    Send "^v" 
    Send "{Enter}"
}

; Pc sleep
SHIFT & F20:: {
    DllCall("PowrProf\SetSuspendState", "int", 1, "int", 1, "int", 0)
}

; open task manager
SHIFT & F21:: {
    Send "^+{Esc}"
}
