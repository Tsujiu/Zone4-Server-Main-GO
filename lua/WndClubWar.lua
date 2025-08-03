-------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
guiSystem:setGUISheet(root)


g_MyClubWaitListPage = 1
g_MyClubInviteListPage = 1
g_MyClubInviteListMaxPage = 1
--------------------------------------------------------------------

-- drawTexture(StartRender:시작시에 그리기)

--------------------------------------------------------------------
function WndClubWar_RenderBackImage(currentBattleChannelName)
	
	--drawer:drawTexture("UIData/mainBG_Button001.tga", 30, 15, 281, 46, 0, 440)	--FIGHTCLUB 글자
	drawer:drawTexture("UIData/GameNewImage.tga", 11 , 730, 420, 22, 2, 1000);
	drawer:drawTexture("UIData/fightclub_006.tga", 477 , 320, 75, 36, 898 , 751);
	-- 대전채널 이름
	if g_BattleMode == BATTLETYPE_NORMAL then
		drawer:setTextColor(255, 255, 255, 255)
	elseif g_BattleMode == BATTLETYPE_EXTREME then
		drawer:setTextColor(220, 80, 220, 255)
	end

end

-- 한글, 영문모드
function WndClubWar_CurrentHanMode(hanMode)
	if hanMode then
		drawer:drawTexture("UIData/GameNewImage.tga", 412, 732, 16, 17, 404, 964);
	else
		drawer:drawTexture("UIData/GameNewImage.tga", 412, 732, 16, 17, 404, 981);
	end	
end


---------------------------------------------------------------------
-- ClubWarLobby 제목 밑 Bar
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ClubWarLobbyTitleBar")
mywindow:setTexture("Enabled", "UIData/fightclub_006.tga", 0, 787)
mywindow:setTexture("Disabled", "UIData/fightclub_006.tga", 0, 787)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 75);
mywindow:setSize(1024,40)
mywindow:setVisible(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)



---------------------------------------------------------------------
-- ClubWarLobby 좌측 길드 백판
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ClubWarLobbyLeftBackImage")
mywindow:setTexture("Enabled", "UIData/fightclub_006.tga", 0, 345)
mywindow:setTexture("Disabled", "UIData/fightclub_006.tga", 0, 345)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(20,115);
mywindow:setSize(456, 442)
mywindow:setVisible(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)




---------------------------------------------------------------------
-- ClubWarLobby 우측 길드 백판
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ClubWarLobbyRightBackImage")
mywindow:setTexture("Enabled", "UIData/fightclub_006.tga", 0, 345)
mywindow:setTexture("Disabled", "UIData/fightclub_006.tga", 0, 345)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(550,115);
mywindow:setSize(456, 442)
mywindow:setVisible(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)


---------------------------------------------------------------------
-- ClubWarLobby 좌측 이름 Bar
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ClubWarLobbyLeftNameBar")
mywindow:setTexture("Enabled", "UIData/fightclub_006.tga", 456, 749)
mywindow:setTexture("Disabled", "UIData/fightclub_006.tga", 456, 749)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(7,7);
mywindow:setSize(442, 38)
mywindow:setVisible(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("ClubWarLobbyLeftBackImage"):addChildWindow(mywindow)

---------------------------------------------------------------------
-- ClubWarLobby 우측 이름 Bar
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ClubWarLobbyRightNameBar")
mywindow:setTexture("Enabled", "UIData/fightclub_006.tga", 456, 711)
mywindow:setTexture("Disabled", "UIData/fightclub_006.tga", 456, 71)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(7,7);
mywindow:setSize(442, 38)
mywindow:setVisible(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("ClubWarLobbyRightBackImage"):addChildWindow(mywindow)

---------------------------------------------------------------------
-- ClubWarLobby 하단 백판
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ClubWarLobbyDownBackImage")
mywindow:setTexture("Enabled", "UIData/fightclub_006.tga", 0, 827)
mywindow:setTexture("Disabled", "UIData/fightclub_006.tga", 0, 827)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 572);
mywindow:setSize(1024, 197)
mywindow:setVisible(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)

---------------------------------------------------------------------
-- 초대하기 버튼
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "ClubWarLobbyInviteBtn")
mywindow:setTexture("Normal", "UIData/fightclub_006.tga", 456,475)
mywindow:setTexture("Hover", "UIData/fightclub_006.tga", 456, 534)
mywindow:setTexture("Pushed", "UIData/fightclub_006.tga", 456, 593)
mywindow:setTexture("PushedOff","UIData/fightclub_006.tga", 456, 475)
mywindow:setTexture("Disabled","UIData/fightclub_006.tga", 456, 652)
mywindow:setPosition(630, 135)
mywindow:setSize(181, 59)
mywindow:setZOrderingEnabled(false)
mywindow:setSubscribeEvent("Clicked", "OnClickClubWarLobbyInvite")
winMgr:getWindow("ClubWarLobbyDownBackImage"):addChildWindow(mywindow)

function OnClickClubWarLobbyInvite()
	ShowMyClubInviteList()
end

---------------------------------------------------------------------
-- 나가기 버튼
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "ClubWarLobbyOutBtn")
mywindow:setTexture("Normal", "UIData/fightclub_006.tga", 637,475)
mywindow:setTexture("Hover", "UIData/fightclub_006.tga", 637, 534)
mywindow:setTexture("Pushed", "UIData/fightclub_006.tga", 637, 593)
mywindow:setTexture("PushedOff","UIData/fightclub_006.tga", 637, 475)
mywindow:setTexture("Disabled","UIData/fightclub_006.tga", 637, 652)
mywindow:setPosition(820, 135)
mywindow:setSize(181, 59)
mywindow:setZOrderingEnabled(false)
mywindow:setSubscribeEvent("Clicked", "OnClickClubWarLobbyOut")
winMgr:getWindow("ClubWarLobbyDownBackImage"):addChildWindow(mywindow)

function OnClickClubWarLobbyOut()
	BtnPageMove_RequestVillage()
end



-- 좌측클럽 정보 텍스트
LeftClubInfoText =   { ["protecterr"]=0, "LeftClub_level", "LeftClub_ClubName" , "LeftClub_Stats" , "LeftClub_Wins"}
								   
LeftClubInfoPosX  =    { ["protecterr"]=0, 60, 110 , 50 , 50}
LeftClubInfoPosY  =    { ["protecterr"]=0, 15,  15 , 64, 88}
LeftClubInfoSetText		= {['err'] = 0, 'LV.12', 'REDCLUB', 'STATS : 6000 / 2331', 'Rank 1: 8 Rank 2: 1'}

for i=1 , #LeftClubInfoText do
	mywindow = winMgr:createWindow("TaharezLook/StaticText", LeftClubInfoText[i])
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(LeftClubInfoPosX[i],LeftClubInfoPosY[i])
	mywindow:setSize(20, 18)
	mywindow:setZOrderingEnabled(false)	
	if i < 3 then
		mywindow:setFont(g_STRING_FONT_GULIM, 15)
		mywindow:setTextColor(255, 255, 255, 255)
	else
		mywindow:setFont(g_STRING_FONT_GULIM, 12)
		mywindow:setTextColor(255, 255, 255, 255)
	end
	mywindow:setVisible(true)
	mywindow:setText(LeftClubInfoSetText[i])
	winMgr:getWindow('ClubWarLobbyLeftBackImage'):addChildWindow(mywindow);
end

--좌측 팀클럽마크
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "LeftClubEmblemImage")
mywindow:setTexture("Enabled", "UIData/blackfadein.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/blackfadein.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(15, 15);
mywindow:setSize(32, 32)
mywindow:setScaleWidth(183)
mywindow:setScaleHeight(183)
mywindow:setEnabled(false)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow('ClubWarLobbyLeftBackImage'):addChildWindow(mywindow)

-----  좌측클럽 대기자 리스트 --------------------------------------------------------------------------------------------------													   
LeftClubWaitList_PosX  =    { ["protecterr"]=0, 18, 231 , 18, 231, 18, 231, 18, 231 , 18, 231 , 18, 231, 18, 231, 18, 231}
LeftClubWaitList_PosY  =    { ["protecterr"]=0, 150, 150 , 189, 189, 229, 229, 268, 268, 307, 307, 346, 346, 385, 385 ,422, 422}
LeftClubWaitList_Text	= {['err'] = 0, 'UserName', 'Lv.1'}
LeftClubWaitList_TextPosX =  { ["protecterr"]=0, 80 , 20}
LeftClubWaitList_TextPosY =  { ["protecterr"]=0, 10 , 10 }


	
for i=1 , 16 do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "LeftClubWaitList_image_"..i)
	mywindow:setTexture("Enabled", "UIData/fightclub_006.tga", 818, 676)
	mywindow:setTexture("Disabled", "UIData/fightclub_006.tga", 818, 676)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(LeftClubWaitList_PosX[i]+10 , LeftClubWaitList_PosY[i]-37);
	mywindow:setSize(190, 35)
	mywindow:setEnabled(true)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	winMgr:getWindow('ClubWarLobbyLeftBackImage'):addChildWindow(mywindow)
	
	
	for j=1, #LeftClubWaitList_Text do
		local child_window = winMgr:createWindow("TaharezLook/StaticText", "LeftClubWaitList_image_"..i..LeftClubWaitList_Text[j])	
		child_window:setProperty("FrameEnabled", "false")
		child_window:setProperty("BackgroundEnabled", "false")
		child_window:setSize(5, 5)
		child_window:setVisible(true)
		child_window:setPosition(LeftClubWaitList_TextPosX[j], LeftClubWaitList_TextPosY[j])
		child_window:setViewTextMode(1)	
		child_window:setAlign(8)
		child_window:setLineSpacing(1)
		child_window:addTextExtends(LeftClubWaitList_Text[j], g_STRING_FONT_GULIMCHE, 112,    255,255,255,255,     0,     0,0,0,255)
		mywindow:addChildWindow(child_window)
	end
	
	child_window = winMgr:createWindow("TaharezLook/Button", "LeftClubWaitList_image_"..i.."CancelBtn")
	child_window:setTexture("Normal", "UIData/fightclub_006.tga", 818, 592)
	child_window:setTexture("Hover", "UIData/fightclub_006.tga", 818, 613)
	child_window:setTexture("Pushed", "UIData/fightclub_006.tga", 818, 634)
	child_window:setTexture("PushedOff", "UIData/fightclub_006.tga", 818, 592)
	child_window:setTexture("Disabled", "UIData/fightclub_006.tga", 818, 655) 
	child_window:setPosition(160, 7)
	child_window:setSize(21, 21)
	child_window:setVisible(true)
	child_window:setUserString('JoinIndex', tostring(i))
	child_window:setAlwaysOnTop(true)
	child_window:setZOrderingEnabled(false)
	child_window:subscribeEvent("Clicked", "OnCancelWarMember")
	mywindow:addChildWindow(child_window)	
end


function OnCancelWarMember()
end


-- 우측클럽 정보 텍스트
RightClubInfoText =   { ["protecterr"]=0, "RightClub_level", "RightClub_ClubName" , "RightClub_Stats" , "RightClub_Wins"}
								   
RightClubInfoPosX  =    { ["protecterr"]=0, 60, 110 , 50 , 50}
RightClubInfoPosY  =    { ["protecterr"]=0, 15,  15 , 64, 88}
RightClubInfoSetText		= {['err'] = 0, 'LV.12', 'BLUECLUB', 'STATS : 1523 / 2331', 'Rank 1: 5 Rank 2: 7'}

for i=1 , #RightClubInfoText do
	mywindow = winMgr:createWindow("TaharezLook/StaticText", RightClubInfoText[i])
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(RightClubInfoPosX[i],RightClubInfoPosY[i])
	mywindow:setSize(20, 18)
	mywindow:setZOrderingEnabled(false)	
	if i < 3 then
		mywindow:setFont(g_STRING_FONT_GULIM, 15)
		mywindow:setTextColor(255, 255, 255, 255)
	else
		mywindow:setFont(g_STRING_FONT_GULIM, 12)
		mywindow:setTextColor(255, 255, 255, 255)
	end
	mywindow:setVisible(true)
	mywindow:setText(RightClubInfoSetText[i])
	winMgr:getWindow('ClubWarLobbyRightBackImage'):addChildWindow(mywindow);
end

-----  우측클럽 대기자 리스트 --------------------------------------------------------------------------------------------------
														   
RightClubWaitList_PosX  =    { ["protecterr"]=0, 18, 231 , 18, 231, 18, 231, 18, 231 , 18, 231 , 18, 231, 18, 231, 18, 231}
RightClubWaitList_PosY  =    { ["protecterr"]=0, 150, 150 , 189, 189, 229, 229, 268, 268, 307, 307, 346, 346, 385, 385 ,422, 422}
RightClubWaitList_Text	= {['err'] = 0, 'UserName', 'Lv.1'}
RightClubWaitList_TextPosX =  { ["protecterr"]=0, 80 , 20}
RightClubWaitList_TextPosY =  { ["protecterr"]=0, 10 , 10 }

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RightClubEmblemImage")
mywindow:setTexture("Enabled", "UIData/blackfadein.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/blackfadein.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(15 , 15);
mywindow:setSize(32, 32)
mywindow:setScaleWidth(183)
mywindow:setScaleHeight(183)
mywindow:setEnabled(false)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow('ClubWarLobbyRightBackImage'):addChildWindow(mywindow)


for i=1 , 16 do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RightClubWaitList_image_"..i)
	mywindow:setTexture("Enabled", "UIData/fightclub_006.tga", 818, 676)
	mywindow:setTexture("Disabled", "UIData/fightclub_006.tga", 818, 676)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(RightClubWaitList_PosX[i]+10 , RightClubWaitList_PosY[i]-37);
	mywindow:setSize(190, 35)
	mywindow:setEnabled(true)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	winMgr:getWindow('ClubWarLobbyRightBackImage'):addChildWindow(mywindow)
	
	
	for j=1, #RightClubWaitList_Text do
		local child_window = winMgr:createWindow("TaharezLook/StaticText", "RightClubWaitList_image_"..i..RightClubWaitList_Text[j])	
		child_window:setProperty("FrameEnabled", "false")
		child_window:setProperty("BackgroundEnabled", "false")
		child_window:setSize(5, 5)
		child_window:setVisible(true)
		child_window:setPosition(RightClubWaitList_TextPosX[j], RightClubWaitList_TextPosY[j])
		child_window:setViewTextMode(1)	
		child_window:setAlign(8)
		child_window:setLineSpacing(1)
		child_window:addTextExtends(RightClubWaitList_Text[j], g_STRING_FONT_GULIMCHE, 112,    255,255,255,255,     0,     0,0,0,255)
		mywindow:addChildWindow(child_window)
	end
	
	child_window = winMgr:createWindow("TaharezLook/Button", "RightClubWaitList_image_"..i.."CancelBtn")
	child_window:setTexture("Normal", "UIData/fightclub_006.tga", 818, 592)
	child_window:setTexture("Hover", "UIData/fightclub_006.tga", 818, 613)
	child_window:setTexture("Pushed", "UIData/fightclub_006.tga", 818, 634)
	child_window:setTexture("PushedOff", "UIData/fightclub_006.tga", 818, 592)
	child_window:setTexture("Disabled", "UIData/fightclub_006.tga", 818, 655) 
	child_window:setPosition(160, 7)
	child_window:setSize(21, 21)
	child_window:setVisible(true)
	child_window:setUserString('JoinIndex', tostring(i))
	child_window:setAlwaysOnTop(true)
	child_window:setZOrderingEnabled(false)
	child_window:subscribeEvent("Clicked", "OnCancelWarMember")
	mywindow:addChildWindow(child_window)	
end

-----  마이클럽 대기자 리스트 --------------------------------------------------------------------------------------------------
														   
MyClubWaitList_Text	= {['err'] = 0, 'UserName', 'Lv.1'}
MyClubWaitList_TextPosX =  { ["protecterr"]=0, 80 , 20}
MyClubWaitList_TextPosY =  { ["protecterr"]=0, 5 , 5 }
for i=1 , 5 do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyClubWaitList_image_"..i)
	mywindow:setTexture("Enabled", "UIData/debug_b.tga", 818, 676)
	mywindow:setTexture("Disabled", "UIData/debug_b.tga", 818, 676)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(440 , 10+(i*26));
	mywindow:setSize(178, 25)
	mywindow:setEnabled(true)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	winMgr:getWindow('ClubWarLobbyDownBackImage'):addChildWindow(mywindow)
	
	
	for j=1, #MyClubWaitList_Text do
		local child_window = winMgr:createWindow("TaharezLook/StaticText", "MyClubWaitList_image_"..i..MyClubWaitList_Text[j])	
		child_window:setProperty("FrameEnabled", "false")
		child_window:setProperty("BackgroundEnabled", "false")
		child_window:setSize(5, 5)
		child_window:setVisible(true)
		child_window:setPosition(MyClubWaitList_TextPosX[j], MyClubWaitList_TextPosY[j])
		child_window:setViewTextMode(1)	
		child_window:setAlign(8)
		child_window:setLineSpacing(1)
		child_window:addTextExtends(MyClubWaitList_Text[j], g_STRING_FONT_GULIMCHE, 112,    255,255,255,255,     0,     0,0,0,255)
		mywindow:addChildWindow(child_window)
	end
	
	child_window = winMgr:createWindow("TaharezLook/Button", "MyClubWaitList_image_"..i.."CancelBtn")
	child_window:setTexture("Normal", "UIData/fightclub_006.tga", 818, 592)
	child_window:setTexture("Hover", "UIData/fightclub_006.tga", 818, 613)
	child_window:setTexture("Pushed", "UIData/fightclub_006.tga", 818, 634)
	child_window:setTexture("PushedOff", "UIData/fightclub_006.tga", 818, 592)
	child_window:setTexture("Disabled", "UIData/fightclub_006.tga", 818, 655) 
	child_window:setPosition(150, 2)
	child_window:setSize(21, 21)
	child_window:setVisible(true)
	child_window:setUserString('JoinIndex', tostring(i))
	child_window:setAlwaysOnTop(true)
	child_window:setZOrderingEnabled(false)
	child_window:subscribeEvent("Clicked", "OnCancelWarMember")
	mywindow:addChildWindow(child_window)	
end


---------------------------------------
---대기자 리스트 앞뒤버튼
---------------------------------------
local MyClubWaitListPage_BtnName  = {["err"]=0, [0]="MyClubWaitListPage_LBtn", "MyClubWaitListPage_RBtn"}
local MyClubWaitListPage_BtnTexX  = {["err"]=0, [0]= 0, 22}

local MyClubWaitListPage_BtnPosX  = {["err"]=0, [0]= 480, 565}
local MyClubWaitListPage_BtnEvent = {["err"]=0, [0]= "MyClubWaitListPage_PrevPage", "MyClubWaitListPage_NextPage"}
for i=0, #MyClubWaitListPage_BtnEvent do
	mywindow = winMgr:createWindow("TaharezLook/Button", MyClubWaitListPage_BtnName[i])
	mywindow:setTexture("Normal", "UIData/C_Button.tga", MyClubWaitListPage_BtnTexX[i], 0)
	mywindow:setTexture("Hover", "UIData/C_Button.tga", MyClubWaitListPage_BtnTexX[i], 27)
	mywindow:setTexture("Pushed", "UIData/C_Button.tga",MyClubWaitListPage_BtnTexX[i], 54)
	mywindow:setTexture("PushedOff", "UIData/C_Button.tga", MyClubWaitListPage_BtnTexX[i], 0)
	mywindow:setTexture("Disabled", "UIData/C_Button.tga", MyClubWaitListPage_BtnTexX[i], 81)
	mywindow:setPosition(MyClubWaitListPage_BtnPosX[i], 168)
	mywindow:setSize(22, 27)
	
	mywindow:setAlwaysOnTop(true)
	mywindow:setSubscribeEvent("Clicked", MyClubWaitListPage_BtnEvent[i])
	winMgr:getWindow('ClubWarLobbyDownBackImage'):addChildWindow(mywindow)
end

mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyClubWaitListPage_PageText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 16)
mywindow:setPosition(491, 170)
mywindow:setSize(80, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:clearTextExtends()
mywindow:setZOrderingEnabled(false)
mywindow:addTextExtends(tostring(g_MyClubWaitListPage), g_STRING_FONT_GULIMCHE, 114,    230,230,230,255,     0,     0,0,0,255)
winMgr:getWindow('ClubWarLobbyDownBackImage'):addChildWindow(mywindow)


---------------------------------------
---대기자 리스트 이전페이지 버튼--
---------------------------------------
function MyClubWaitListPage_PrevPage()
	DebugStr('MyClubWaitListPage_PrevPage()')
	if	g_MyClubWaitListPage  > 1 then
		GetProfileVisitedList(g_MyClubWaitListPage - 1)
	end
end

---------------------------------------
---대기자 리스트 다음페이지 버튼--
---------------------------------------
function MyClubWaitListPage_NextPage()
	DebugStr('MyClubWaitListPage_NextPage()')
	GetProfileVisitedList(g_MyClubWaitListPage + 1)
end
---------------------------------------
---대기자 리스트 페이지 설정--
---------------------------------------
function SettingMyClubWaitListPage(CurrentPage)
	g_MyClubWaitListPage =	CurrentPage
	winMgr:getWindow('MyClubWaitListPage_PageText'):clearTextExtends()
	winMgr:getWindow('MyClubWaitListPage_PageText'):addTextExtends(tostring(g_MyClubWaitListPage), g_STRING_FONT_GULIMCHE, 114,    230,230,230,255,     0,     0,0,0,255)
end





------------------------------------------------------------------------------------
--대기자 초대 가능 목록 
------------------------------------------------------------------------------------

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyClubInviteListBackImage")
mywindow:setTexture("Enabled", "UIData/blackfadein.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/blackfadein.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(400 , 300);
mywindow:setSize(230, 320)
mywindow:setEnabled(true)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)
RegistEscEventInfo("MyClubInviteListBackImage", "OnClickCloseInviteList")
------------------------------------------------------------------
-- 대기자 초대 가능 목록 닫기버튼
------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "CloseInviteList");	
mywindow:setTexture("Normal",		"UIData/mainBG_Button002.tga",	354, 159)
mywindow:setTexture("Hover",		"UIData/mainBG_Button002.tga",	354, 182)
mywindow:setTexture("Pushed",		"UIData/mainBG_Button002.tga",	354, 159)
mywindow:setTexture("PushedOff",	"UIData/mainBG_Button002.tga",	354, 159)
mywindow:setTexture("Disabled",		"UIData/mainBG_Button002.tga",	354, 159)	
mywindow:setPosition(200, 5)
mywindow:setSize(23, 23);
mywindow:setVisible(true);
mywindow:setZOrderingEnabled(false);
mywindow:setAlwaysOnTop(true)
mywindow:subscribeEvent("Clicked", "OnClickCloseInviteList");
winMgr:getWindow("MyClubInviteListBackImage"):addChildWindow(mywindow)

function ShowMyClubInviteList()
	--root:addChildWindow(winMgr:getWindow("MyClubInviteListBackImage"))
	winMgr:getWindow("MyClubInviteListBackImage"):setVisible(true)
	RefreshMyClubInviteList()
end
function OnClickCloseInviteList()
	winMgr:getWindow("MyClubInviteListBackImage"):setVisible(false)
end

MyClubInviteList_Radio = 
{ ["protecterr"]=0, "MyClubInviteList_Radio1", "MyClubInviteList_Radio2", "MyClubInviteList_Radio3" , "MyClubInviteList_Radio4", "MyClubInviteList_Radio5",
					"MyClubInviteList_Radio6", "MyClubInviteList_Radio7", "MyClubInviteList_Radio8" , "MyClubInviteList_Radio9", "MyClubInviteList_Radio10"}
	
	
MyClubInviteList_Text	= {['err'] = 0, 'MyClubMemberLevel', 'MyClubMemberName'}
								
MyClubInviteList_PosX		= {['err'] = 0, 20, 100}
MyClubInviteList_PosY		= {['err'] = 0, 3, 3 }
MyClubInviteList_SizeX	= {['err'] = 0, 5, 5 }
MyClubInviteList_SizeY	= {['err'] = 0, 5, 5 }
MyClubInviteList_SetText		= {['err'] = 0, 'Level', 'Name'}



for i=1, #MyClubInviteList_Radio do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton",	MyClubInviteList_Radio[i])
	mywindow:setTexture("Normal", "UIData/invisible.tga",		0, 822)    
	mywindow:setTexture("Hover", "UIData/invisible.tga",		0, 822)
	mywindow:setTexture("Pushed", "UIData/invisible.tga",		0, 844)
	mywindow:setTexture("PushedOff", "UIData/invisible.tga",	0, 844)
	mywindow:setTexture("SelectedNormal", "UIData/invisible.tga",	 0, 844)
	mywindow:setTexture("SelectedHover", "UIData/invisible.tga",	 0, 844)
	mywindow:setTexture("SelectedPushed", "UIData/invisible.tga",	 0, 844)
	mywindow:setTexture("SelectedPushedOff", "UIData/invisible.tga", 0, 844)
	mywindow:setSize(225, 21)
	mywindow:setPosition(0, 38+25*(i-1))
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true)
	winMgr:getWindow('MyClubInviteListBackImage'):addChildWindow(mywindow)
	
	--  레벨 , 이름
	for j=1, #MyClubInviteList_Text do
		local child_window = winMgr:createWindow("TaharezLook/StaticText", MyClubInviteList_Radio[i]..MyClubInviteList_Text[j])	
		child_window:setProperty("FrameEnabled", "false")
		child_window:setProperty("BackgroundEnabled", "false")
		child_window:setSize(MyClubInviteList_SizeX[j], MyClubInviteList_SizeY[j])
		child_window:setVisible(true)
		child_window:setPosition(MyClubInviteList_PosX[j], MyClubInviteList_PosY[j])
		child_window:setViewTextMode(1)	
		child_window:setAlign(8)
		child_window:setLineSpacing(1)
		mywindow:addChildWindow(child_window)
	end
	
	child_window = winMgr:createWindow("TaharezLook/Button", MyClubInviteList_Radio[i]..'InviteMember')
	child_window:setTexture("Normal", "UIData/fightclub_004.tga", 320, 679)
	child_window:setTexture("Hover", "UIData/fightclub_004.tga", 320, 698)
	child_window:setTexture("Pushed", "UIData/fightclub_004.tga", 320, 717)
	child_window:setTexture("PushedOff", "UIData/fightclub_004.tga", 320, 736)
	child_window:setTexture("Disabled", "UIData/fightclub_004.tga", 320, 736)
	child_window:setPosition(166, 0)
	child_window:setSize(54, 19)
	child_window:setVisible(true)
	child_window:setAlwaysOnTop(true)
	child_window:setZOrderingEnabled(false)
	child_window:subscribeEvent("Clicked", "OnClickInviteClubMember")
	child_window:setUserString("InviteIndex",tostring(i))
	mywindow:addChildWindow(child_window)	
end


---------------------------------------
---초대가능 리스트 앞뒤버튼
---------------------------------------
local MyClubInviteListPage_BtnName  = {["err"]=0, [0]="MyClubInviteListPage_LBtn", "MyClubInviteListPage_RBtn"}
local MyClubInviteListPage_BtnTexX  = {["err"]=0, [0]= 0, 22}

local MyClubInviteListPage_BtnPosX  = {["err"]=0, [0]= 63, 148}
local MyClubInviteListPage_BtnEvent = {["err"]=0, [0]= "MyClubInviteListPage_PrevPage", "MyClubInviteListPage_NextPage"}
for i=0, #MyClubInviteListPage_BtnEvent do
	mywindow = winMgr:createWindow("TaharezLook/Button", MyClubInviteListPage_BtnName[i])
	mywindow:setTexture("Normal", "UIData/C_Button.tga", MyClubInviteListPage_BtnTexX[i], 0)
	mywindow:setTexture("Hover", "UIData/C_Button.tga", MyClubInviteListPage_BtnTexX[i], 27)
	mywindow:setTexture("Pushed", "UIData/C_Button.tga",MyClubInviteListPage_BtnTexX[i], 54)
	mywindow:setTexture("PushedOff", "UIData/C_Button.tga", MyClubInviteListPage_BtnTexX[i], 0)
	mywindow:setTexture("Disabled", "UIData/C_Button.tga", MyClubInviteListPage_BtnTexX[i], 81)
	mywindow:setPosition(MyClubInviteListPage_BtnPosX[i], 286)
	mywindow:setSize(22, 27)
	
	mywindow:setAlwaysOnTop(true)
	mywindow:setSubscribeEvent("Clicked", MyClubInviteListPage_BtnEvent[i])
	winMgr:getWindow('MyClubInviteListBackImage'):addChildWindow(mywindow)
end

mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyClubInviteListPage_PageText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 16)
mywindow:setPosition(76, 292)
mywindow:setSize(80, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:clearTextExtends()
mywindow:setZOrderingEnabled(false)
mywindow:setTextExtends(tostring(g_MyClubInviteListPage)..' / '..tostring(g_MyClubInviteListMaxPage), g_STRING_FONT_GULIMCHE, 114,    230,230,230,255,     0,     0,0,0,255)
winMgr:getWindow('MyClubInviteListBackImage'):addChildWindow(mywindow)


---------------------------------------
---초대가능 리스트 이전페이지 버튼--
---------------------------------------
function MyClubInviteListPage_PrevPage()
	DebugStr('MyClubInviteListPage_PrevPage()')
	if g_MyClubInviteListPage  > 1 then
		g_MyClubInviteListPage = g_MyClubInviteListPage - 1
		RefreshMyClubInviteList()
	end
end

---------------------------------------
---초대가능 리스트 다음페이지 버튼--
---------------------------------------
function MyClubInviteListPage_NextPage()
	DebugStr('MyClubInviteListPage_NextPage()')
	if g_MyClubInviteListPage < g_MyClubInviteListMaxPage then
		g_MyClubInviteListPage = g_MyClubInviteListPage + 1
		RefreshMyClubInviteList()
	end
end
---------------------------------------
---초대가능 리스트 페이지 설정--
---------------------------------------
function SettingMyClubInviteListPage(CurrentPage)
	g_MyClubInviteListPage = CurrentPage
	winMgr:getWindow('MyClubInviteListPage_PageText'):setTextExtends(tostring(g_MyClubInviteListPage)..' / '..tostring(g_MyClubInviteListMaxPage), g_STRING_FONT_GULIMCHE, 114,    230,230,230,255,     0,     0,0,0,255)
end


-- 클릭한 클럽멤버를 팀에 초대한다 
function OnClickInviteClubMember(args)
--[[
	DebugStr('OnClickInviteClubMember')
	local leaderName = winMgr:getWindow("MyTeamMemberText1"):getText()
	-- 자신이 방장이 아닐경우 리턴
	if My_LobbyCharacterName ~= leaderName then
		--팀리더만 가능합니다
		ShowCommonAlertOkBoxWithFunction(PreCreateString_2285,'OnClickAlertOkSelfHide');
											--GetSStringInfo(LAN_ENABLE_TEAMLEADER)
		return
	end
	local index = tonumber(CEGUI.toWindowEventArgs(args).window:getUserString("InviteIndex"))
	DebugStr('index:'..index);
	local InviteMemberName = winMgr:getWindow(MyClubInviteList_Radio[index]..MyClubInviteList_Text[2]):getText()
	DebugStr('InviteMemberName:'..InviteMemberName);
	-- 이미 초대된 사람일경우 리턴
	for i=1, #MyTeamMemberText do
		local invitedName = winMgr:getWindow(MyTeamMemberText[i]):getText()
		if invitedName == InviteMemberName then
			--이미 팀에 가입된 멤버입니다
			ShowCommonAlertOkBoxWithFunction(PreCreateString_2294,'OnClickAlertOkSelfHide');
			return								--GetSStringInfo(LAN_ALREADY_JOINED)
		end
	end
	InviteTeamMember(InviteMemberName)
--]]
end

--------------------------------------------------
---마이 클럽초대가능멤버 리스트 갱신하기----------
--------------------------------------------------
function RefreshMyClubInviteList()

	g_MyClubInviteListMaxPage = GetTotalGuildPage(10)
	winMgr:getWindow('MyClubInviteListPage_PageText'):setTextExtends(tostring(g_MyClubInviteListPage)..' / '..tostring(g_MyClubInviteListMaxPage), g_STRING_FONT_GULIMCHE, 114,    230,230,230,255,     0,     0,0,0,255)
	for i=1, 10 do
		local level, name, state = GetGuildList(i, g_MyClubInviteListPage, 10)
		--DebugStr('name:'..name)
		if name ~= 'none' then
			winMgr:getWindow(MyClubInviteList_Radio[i]..'InviteMember'):setVisible(true)	
			winMgr:getWindow(MyClubInviteList_Radio[i]..'InviteMember'):setEnabled(true)	
			winMgr:getWindow(MyClubInviteList_Radio[i]..'MyClubMemberLevel'):setVisible(true)
			winMgr:getWindow(MyClubInviteList_Radio[i]..'MyClubMemberName'):setVisible(true)
			winMgr:getWindow(MyClubInviteList_Radio[i]..'MyClubMemberLevel'):setTextExtends('Lv.'..level, g_STRING_FONT_GULIM, 14, 255,255,255,255,   0, 255,255,255,255)
			winMgr:getWindow(MyClubInviteList_Radio[i]..'MyClubMemberName'):setTextExtends(name, g_STRING_FONT_GULIM, 14, 255,255,255,255,   0, 255,255,255,255)
		else
			winMgr:getWindow(MyClubInviteList_Radio[i]..'InviteMember'):setVisible(false)	
			winMgr:getWindow(MyClubInviteList_Radio[i]..'MyClubMemberLevel'):clearTextExtends()
			winMgr:getWindow(MyClubInviteList_Radio[i]..'MyClubMemberName'):clearTextExtends()
		end
		
		if state == 'offline' then	
			winMgr:getWindow(MyClubInviteList_Radio[i]..'InviteMember'):setVisible(true)					
			winMgr:getWindow(MyClubInviteList_Radio[i]..'InviteMember'):setEnabled(false)	
		end
	end
end

--[[
---------------------------------------------------------------------
--ClubWar NPC 백판1 
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ClubWarNpcBackImage1")
mywindow:setTexture("Enabled", "UIData/fightclub_003.tga", 578, 22)
mywindow:setTexture("Disabled", "UIData/fightclub_003.tga", 578, 22)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(50,60);
mywindow:setSize(334, 471)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)

---------------------------------------------------------------------
--ClubWar NPC 백판2 
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ClubWarNpcBackImage2")
mywindow:setTexture("Enabled", "UIData/fightclub_003.tga", 692, 493)
mywindow:setTexture("Disabled", "UIData/fightclub_003.tga", 692, 493)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(450,80);
mywindow:setSize(332, 251)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)

---------------------------------------------------------------------
--ClubWar NPC 백판3
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ClubWarNpcBackImage3")
mywindow:setTexture("Enabled", "UIData/fightclub_003.tga", 804, 745)
mywindow:setTexture("Disabled", "UIData/fightclub_003.tga", 804, 745)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(450,340);
mywindow:setSize(220,197)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)
--]]