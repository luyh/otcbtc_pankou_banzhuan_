[General]
SyntaxVersion=2
BeginHotkey=121
BeginHotkeyMod=0
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=123
StopHotkeyMod=0
RunOnce=1
EnableWindow=
MacroID=cd619243-eeea-4350-be3a-d52c3755e73a
Description=我的脚本1
Enable=1
AutoRun=0
[Repeat]
Type=0
Number=1
[SetupUI]
Type=2
QUI=
[Relative]
SetupOCXFile=
[Comment]

[UIPackage]
UEsDBBQAAgAIADabL0xaowS3HAAAAC8AAAAJABEAVUlQYWNrYWdlVVQNAAcnAF1aJwBdWicAXVpjYmBgYIRiFrf8olxWEGHICOIjgXgmBoYfQBoAUEsBAhcLFAACAAgANpsvTFqjBLccAAAALwAAAAkACQAAAAAAAAAAAACAAAAAAFVJUGFja2FnZVVUBQAHJwBdWlBLBQYAAAAAAQABAEAAAABUAAAAAAA=


[Script]
FindPic 0,0,1024,768,"C:\Users\Administrator.USER-20170728IF\Desktop\jb\买单.bmp",0.9,intX,intY
If intX > 0 And intY > 0 Then 
    // TracePrint "找到买单图标"
    
Else 
    TracePrint"请检查页面，没找到买单图标"
End If

    Call 撤买单
    Delay 2000
    Call 撤卖单
    Delay 2000

While (1)
    Call 获取行情
    Delay 200
    Call 获取资产余额
    Delay 200
    Call 获取委托
    Delay 200
    Call 资产详情
    Delay 200

    差价大于1 = 差价百分比-1
    If 差价大于1>0 then
        Call 挂卖单(可卖EOS)
        Delay 1000
        Call 挂买单(可买EOS)
        Delay 1000

        //
        //Call 检查成交
        Call 检查是否撤单
        Delay 1000
    Else 
        TracePrint "差价小于1%，不操作"
    End If

    Delay 5000
Wend


Sub 资产详情
    TracePrint "等价总额EOS:"
    等价总额EOS = 可卖EOS+ 可买EOS+锁定买EOS+锁定卖EOS
    TracePrint 等价总额EOS
    Delay 200
    TracePrint "钱币比:"
    币 = 可卖EOS + 锁定卖EOS
    钱 = 可买EOS+锁定买EOS
    If 币 Then 
        钱币比 = 钱/币*100
        TracePrint 钱币比
    Else 
        TracePrint "手上没有币，只有钱"
    End If

End Sub

Sub 获取委托
//	MoveTo intX + 258, intY + 281
//	Delay 2000
//	MoveTo intX+1042,intY+473
//	Delay 2000
	
    FindPic intX+258,intY+281,intX+1042,intY+473,"C:\Users\Administrator.USER-20170728IF\Desktop\jb\买入.bmp",0.9,买入X,买入Y
    If 买入X > 0 And 买入Y > 0 Then
        TracePrint "找到买单"
        MoveTo 买入X + 263, 买入Y + 8
        LeftDoubleClick 1
        KeyDown "Ctrl", 1
        KeyDown "C", 1
        Delay(100)
        KeyUp "C", 1
        KeyUp "Ctrl", 1
        
        锁定买EOS = Plugin.Sys.GetCLB()
        TracePrint "锁定买EOS:"
        TracePrint 锁定买EOS
        
        MoveTo 买入X + 120, 买入Y + 8
        LeftDoubleClick 1
        KeyDown "Ctrl", 1
        KeyDown "C", 1
        Delay(100)
        KeyUp "C", 1
        KeyUp "Ctrl", 1
        
        我的买价 = Plugin.Sys.GetCLB()
        TracePrint "我的买价:"
        TracePrint 我的买价

    Else 
        TracePrint "没找到买单"
    End If
	Delay 2000
    FindPic intX+258,intY+281,intX+1042,intY+473,"C:\Users\Administrator.USER-20170728IF\Desktop\jb\卖出.bmp",0.9,卖出X,卖出Y
    If 卖出X > 0 And 卖出Y > 0 Then
        TracePrint "找到卖单"
        MoveTo 卖出X + 263, 卖出Y + 8
        LeftDoubleClick 1
        KeyDown "Ctrl", 1
        KeyDown "C", 1
        Delay(100)
        KeyUp "C", 1
        KeyUp "Ctrl", 1
        
        锁定卖EOS = Plugin.Sys.GetCLB()
        TracePrint "锁定卖EOS:"
        TracePrint 锁定卖EOS
        
        MoveTo 卖出X + 120, 卖出Y + 8
        LeftDoubleClick 1
        KeyDown "Ctrl", 1
        KeyDown "C", 1
        Delay(100)
        KeyUp "C", 1
        KeyUp "Ctrl", 1
        
        我的卖价 = Plugin.Sys.GetCLB()
        TracePrint "我的卖价:"
        TracePrint 我的卖价
        
        
    Else 
        TracePrint "没找到卖单"

    End If
	
End Sub

Sub 获取资产余额

    MoveTo intX + 835, intY + 55
    //Delay(3000)	
    LeftDoubleClick 1
    KeyDown "Ctrl", 1
    KeyDown "C", 1
    Delay(100)
    KeyUp "C", 1
    KeyUp "Ctrl", 1

    可卖EOS = Plugin.Sys.GetCLB()
    Delay 200
    TracePrint "获取初始EOS:"
    TracePrint 可卖EOS
    
    MoveTo intX + 575, intY + 55
    // Delay(3000)	
    LeftDoubleClick 1
    KeyDown "Ctrl", 1
    KeyDown "C", 1
    Delay(100)
    KeyUp "C", 1
    KeyUp "Ctrl", 1

    ETH = Plugin.Sys.GetCLB()
    Delay 200
    TracePrint "获取初始ETH:"
    TracePrint ETH
    
    TracePrint "可买EOS:"
    可买EOS = ETH/(买一价 + 0.000001)
    TracePrint 可买EOS  



	
End Sub

Function 挂买单(可买EOS)
    可买大于0点3= 可买EOS-0.3
    If 可买大于0点3>0 Then 
        TracePrint "挂买单："
        MoveTo intX+680, intY+87
        LeftDoubleClick 1
        设置买价 = 买一价 + 0.000001
        TracePrint "设置买价:"
        TracePrint 设置买价
        SayString 设置买价
		 Delay 1000

        //设置数量
        MoveTo intX+680, intY+138	
        LeftDoubleClick 1

        TracePrint "设置买数量:"
        SayString 可买EOS
        TracePrint 可买EOS
	
        TracePrint "确认买入:"
        MoveTo intX + 680, intY + 235
         Delay 1000
        LeftClick 1
	
        锁定买EOS = 可买EOS
        可买EOS = 0
    Else 
        TracePrint "可买EOS<0.3，不再挂单"
	
    End If
End Function

Function 挂卖单(可卖EOS)
    可卖EOS大于0点3 = 可卖EOS-0.3
    If 可卖EOS大于0点3>0 Then 
        TracePrint "挂卖单:"
        MoveTo intX+884, intY+87
        LeftDoubleClick 1
        设置卖价 = 卖一价 - 0.000001
        TracePrint "设置卖价:"
        TracePrint 设置卖价
        SayString 设置卖价
	
		 Delay 500
        //设置数量
        MoveTo intX+918, intY+138	
        LeftDoubleClick 1
	
        TracePrint "设置卖数量:"
        SayString 可卖EOS
        TracePrint 可卖EOS
	
        TracePrint "确认卖出:"
        MoveTo intX + 918, intY + 235
         Delay 500
        LeftClick 1	
	
        锁定卖EOS = 可卖EOS
        可卖EOS = 0
    Else 
        TracePrint "可卖EOS〈0.3，不挂卖单："
	
    End If
End Function


Sub 检查是否撤单
    
    If 锁定卖EOS then
        我的卖价高于卖一价= 我的卖价 -卖一价
        If 我的卖价高于卖一价>0 Then 
            TracePrint "我的卖价高于卖一价"
            TracePrint "需要重新挂卖单"		
            Call 撤卖单
            可卖EOS = 锁定卖EOS
            锁定卖EOS = 0
		Else 
			TracePrint "我的卖单排在前面不用撤单"
        End If
    Else      
        TracePrint "目前没有挂卖单"
    End If
    
    If 锁定买EOS then
        我的买价低于买一价 = 我的买价 - 买一价
        If 我的买价低于买一价>0 Then 
            TracePrint "我的买价低于买一价"
            TracePrint "需要重新挂买单"
	
            Call 撤买单
            可买EOS = 锁定买EOS
            锁定买EOS = 0
		Else 
			TracePrint "我的买单排在前面不用撤单"
        End If
    Else      
        TracePrint "目前没有挂买单"
    End If
End sub

Sub 撤买单

    FindPic intX+258,intY+281,intX+1042,intY+473,"C:\Users\Administrator.USER-20170728IF\Desktop\jb\买入.bmp",0.9,买入X,买入Y
    If 买入X > 0 And 买入Y > 0 Then
        TracePrint "找到买单"
        TracePrint "撤买单"
        MoveTo 买入X + 600, 买入Y +10
        LeftClick 1
        Delay 1000
    Else 
        TracePrint "没找到买单"
    End If

End Sub

Sub 撤卖单
    
    FindPic intX+258,intY+281,intX+1042,intY+473,"C:\Users\Administrator.USER-20170728IF\Desktop\jb\卖出.bmp",0.9,卖出X,卖出Y
    If 卖出X > 0 And 卖出Y > 0 Then
        TracePrint "找到卖单"
        TracePrint "撤卖单"
        MoveTo 卖出X + 600, 卖出Y +10
        LeftClick 1
    Else 
        TracePrint "没找到卖单"
    End If

End Sub

Sub 检查成交
    //检查成交
    MoveTo intX+828, intY+345	
    LeftDoubleClick 1
    KeyDown "Ctrl", 1
    KeyDown "C", 1
    Delay(100)
    KeyUp "C", 1
    KeyUp "Ctrl", 1


    成交率= Plugin.Sys.GetCLB()

    TracePrint 成交率

End sub

Sub 获取行情
    MoveTo intX+25, intY+55
    LeftDoubleClick 1
    KeyDown "Ctrl", 1
    KeyDown "C", 1
    Delay(100)
    KeyUp "C", 1
    KeyUp "Ctrl", 1

    TracePrint "获取行情"
    Delay 200
    买一价= Plugin.Sys.GetCLB()
    TracePrint "买一价:"
    TracePrint 买一价


    MoveTo intX+302, intY+55
    LeftDoubleClick 1
    KeyDown "Ctrl", 1
    KeyDown "C", 1
    Delay(100)
    KeyUp "C", 1
    KeyUp "Ctrl", 1

	Delay 200
    卖一价= Plugin.Sys.GetCLB()
    TracePrint "卖一价:"
    TracePrint 卖一价
	Delay 200
    差价百分比 = (卖一价 / 买一价 - 1)*100
    TracePrint "差价百分比:"
    TracePrint 差价百分比


End Sub

