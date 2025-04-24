 Persistent 
 KeyHistory(0) 
 #SingleInstance force 
 InstallKeybdHook() 
 InstallMouseHook() 
 KeyHistory(0) 
 A_MaxHotkeysPerInterval := 255 
 ListLines(false) 
 SendMode("Input") 
 ProcessSetPriority("A") 
 SetKeyDelay(-1, -1) 
 CoordMode("Mouse", "Client") 
 #MaxThreads 255 
 ;#NoTrayIcon 
 SetTimer WatchCursor, 25 
 global toggle 
 toggle := 0 
 return 
  
  ~*LControl:: 
 { 
 global 
 if toggle = 1 
 { 
 toggle := 0 
 ;BlockInput MouseMove 
 sleep 70 
 Send ("{LButton}") 
 sleep 70 
 MouseMove VroomX, VroomY, 0 
 sleep 70 
 Send ("{LButton Down}") 
 sleep 70 
 Send ("{LButton Up}") 
 sleep 70 
 MouseMove XCen, YCen, 0 
 toggle := 1 
 BlockInput false 
 } 
 } 
  
 ~*F1:: ;Begins Script  
 {  
 global 
 CoordMode("Mouse", "Client") 
 WinGetPos(&LeftB1, &TopB1, &RightB1, &BottomB1, "A") 
 LeftB2 := (RightB1 * 0.1)  
 TopB2 := (BottomB1 * 0.1)  
 RightB2 := (RightB1 * 0.9)  
 BottomB2 := (BottomB1 * 0.75)  
 TopB3 := (TopB1 * 1.15)  
 VroomX := (RightB1 * 0.08)  
 VroomY := (BottomB1 * 0.92)  
 xCen := (RightB1 / 2) ; This will be where your mouse snaps back to horizontally   
 yCen := (BottomB1 / 2) ; This will be where your mouse snaps back to vertically  
 toggle := 1 
 ClipCursor(true, LeftB1 + 10, TopB1 + 60, LeftB1 + RightB1 - 10, TopB1 + BottomB1 - 150) 
 SetTimer Activate, 50 
 } 
  
   ~*F2:: ; Restarts Script    
 { 
 global 
 CoordMode("Mouse", "Client")  
 toggle := 0 
 sleep 100 
 Send("{LButton}") 
 ClipCursor(False, 0, 0, 0, 0) 
 return  
 }   
  
 WatchCursor()  
 { ; V1toV2: Added bracket 
 global XCur 
 global YCur 
 CoordMode "Mouse", "Client" 
 MouseGetPos &XCur, &YCur ; Tracks mouse at all times  
 return  
 } ; V1toV2: Added bracket in the end 
  
 Activate() 
 { 
 While toggle = 1 
 {  
 	if (XCur > RightB2) ; Right boundary    
 	{   
 		Send ("{LButton}") ;Cancels the click to stop in game snapping   
 		;BlockInput MouseMove  
 		MouseMove XCen, YCen, 0 ; Moves mouse back to initial position  
 		Sleep (50) ; Freezes inputs for a frame or two, this stops in game snapping. Comment out if you want less dead time in exchange for snapping movements   
 		;BlockInput false 
 		Send ("{LButton Down}") ; Restarts click   
 	}   
 		if (XCur < LeftB2) ; Left boundary    
 	{   
 		Send ("{LButton}")  
 		;BlockInput MouseMove  
 		MouseMove XCen, YCen, 0  
 		Sleep (50)  
 		BlockInput false  
 		Send ("{LButton Down}") 
 	}   
 		if (YCur > BottomB2) ; Bottom boundary    
 	{   
 		Send ("{LButton}")  
 		;BlockInput MouseMove  
 		MouseMove XCen, YCen, 0  
 		Sleep (50)  
 		BlockInput false  
 		Send ("{LButton Down}")  
 	}   
 		if (YCur < TopB2) ; Top boundary   
 	{   
 		Send ("{LButton}")  
 		;BlockInput MouseMove  
 		MouseMove XCen, YCen, 0  
 		Sleep (50)  
 		BlockInput false 
 		Send ("{LButton Down}") 
 	}    
 		Send ("{LButton Down}") ; Ensures touch screen is always tapped 
 	}  
 if toggle = 0  
 return 
 } 
  
   
 ClipCursor(confine, x1, y1, x2, y2) { 
  
 hData := DllCall("GlobalAlloc", "uint",0x2, "ptr",16) 
 pData := DllCall("GlobalLock", "ptr",hData) 
 NumPut("UPtr",x1,pData+0) 
 NumPut("UPtr",y1,pData+4) 
 NumPut("UPtr",x2,pData+8) 
 NumPut("UPtr",y2,pData+12) 
  
 value :=  Confine ? DllCall( "ClipCursor", "Ptr",pData ) : DllCall( "ClipCursor" ) 
 DllCall("GlobalUnlock", "ptr",hData) 
 DllCall("GlobalFree", "ptr",hData) 
  
 return 
 } 
