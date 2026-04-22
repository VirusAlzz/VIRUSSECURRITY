#Requires AutoHotkey v2.0
#SingleInstance Force

; --- TOMBOL DARURAT (ESC) ---
; Tekan ini buat balikin kursor dan matiin semua suara/jendela
Esc:: {
    DllCall("ShowCursor", "Int", 1) ; Balikin kursor
    DllCall("winmm.dll\PlaySound", "Ptr", 0, "Ptr", 0, "UInt", 0) ; Matiin semua suara
    ExitApp
}

global FileSpongebob := "spongebob-music_-grass-skirt-chase-1.mp3"
global FileErro := "erro.mp3"
global GlitchWindows := []

; --- 1. JENDELA PASSWORD ---
Login := Gui("+AlwaysOnTop", "Auth System")
Login.Add("Text",, "Enter Password:")
PassEdit := Login.Add("Edit", "w200 Password")
Login.Add("Button", "Default", "OK").OnEvent("Click", (*) => PassEdit.Value = "12" ? (Login.Destroy(), MulaiChaos()) : MsgBox("Salah!"))
Login.Show()

MulaiChaos() {
    DllCall("ShowCursor", "Int", 0) ; SEMBUNYIKAN KURSOR

    ; START SUARA ERRO PUTUS-PUTUS
    SetTimer(LoopSuaraErro, 2000)
    LoopSuaraErro() 

    ; BUAT 5 JENDELA WARNA-WARNI
    Loop 5 {
        g := Gui("-Caption +AlwaysOnTop +ToolWindow")
        Warna := ["Red", "Blue", "Green", "Yellow", "Purple", "00FF00", "FF00FF", "00FFFF"]
        g.BackColor := Warna[Random(1, Warna.Length)]
        g.SetFont("s12 Bold cBlack")
        g.Add("Text", "Center w250", "THIS COMPUTER HAS`nCORRUPT BY VIRUSALZZ")
        
        x := Random(0, A_ScreenWidth-250), y := Random(0, A_ScreenHeight-100)
        g.Show("x" x " y" y " w250 h70 NoActivate")
        GlitchWindows.Push({gui: g, x: x, y: y, dx: Random(35, 55), dy: Random(35, 55)})
    }

    Sleep(5000) ; JEDA 5 DETIK (DIEM)
    SetTimer(GerakKencang, 10) ; GERAK KENCANG
    Sleep(5000) ; JEDA 5 DETIK (GERAK)
    
    LanjutMBR()
}

LoopSuaraErro() {
    if FileExist(FileErro)
        SoundPlay(FileErro)
}

GerakKencang() {
    for w in GlitchWindows {
        w.x += w.dx, w.y += w.dy
        if (w.x <= 0 || w.x >= A_ScreenWidth - 250) w.dx *= -1
        if (w.y <= 0 || w.y >= A_ScreenHeight - 100) w.dy *= -1
        w.gui.Move(w.x, w.y)
    }
}

LanjutMBR() {
    SetTimer(LoopSuaraErro, 0)
    SetTimer(GerakKencang, 0)
    DllCall("winmm.dll\PlaySound", "Ptr", 0, "Ptr", 0, "UInt", 0) ; Stop Erro
    
    for w in GlitchWindows
        try w.gui.Destroy()

    ; --- LAYAR HITAM MBR ---
    Mbr := Gui("-Caption +AlwaysOnTop")
    Mbr.BackColor := "Black"
    
    ; Judul Utama (Besar)
    Mbr.SetFont("s30 cWhite", "Consolas")
    TxtUtama := Mbr.Add("Text", "x100 y200 w" . A_ScreenWidth-200, "")
    
    ; Peringatan (Kecil)
    Mbr.SetFont("s14 cWhite", "Consolas")
    TxtKecil := Mbr.Add("Text", "x100 y350 w" . A_ScreenWidth-200, "")
    
    Mbr.Show("Maximize")
    
    ; --- PLAY SPONGEBOB UNLIMITED LOOP ---
    try {
        if FileExist(FileSpongebob) {
            SoundPlay(FileSpongebob, "Loop") ; Flag "Loop" bikin lagu muter terus
        }
    }
    
    ; KETIK TEKS UTAMA
    Pesan1 := "THANK YOU FOR TRYING MY VIRUS`nYOUR MBR HAS BEEN REPLACED"
    Loop Parse, Pesan1 {
        TxtUtama.Value .= A_LoopField
        Sleep(70)
    }
    
    Sleep(500) 
    
    ; KETIK TEKS KECIL
    Pesan2 := "THIS IS A JOKE VIRUS, DON'T PANIC"
    Loop Parse, Pesan2 {
        TxtKecil.Value .= A_LoopField
        Sleep(50)
    }
}