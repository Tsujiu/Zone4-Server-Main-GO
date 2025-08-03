-----------------------------------------
-- Script Entry Point
-----------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)

local g_STRING_MAPNAME_1 = PreCreateString_1163	--GetSStringInfo(LAN_LUA_WND_LOBBY_MR_1)	-- 한판 뛰어 볼까??
local g_STRING_MAPNAME_2 = PreCreateString_1164	--GetSStringInfo(LAN_LUA_WND_LOBBY_MR_2)	-- 여긴 우리가 접수한다!!
local g_STRING_MAPNAME_3 = PreCreateString_1165	--GetSStringInfo(LAN_LUA_WND_LOBBY_MR_3)	-- 야!! 모두 다 덤벼!!
local g_STRING_MAPNAME_4 = PreCreateString_1166	--GetSStringInfo(LAN_LUA_WND_LOBBY_MR_4)	-- 얼른 들어와라!!
local g_STRING_MAPNAME_5 = PreCreateString_1167	--GetSStringInfo(LAN_LUA_WND_LOBBY_MR_5)	-- 자신있나? 그럼 들어와!!
local g_STRING_MAPNAME_6 = PreCreateString_1168	--GetSStringInfo(LAN_LUA_WND_LOBBY_MR_6)	-- 제4구역으로 GO GO!!

local g_STRING_MAPNAME_7 = PreCreateString_1961	--GetSStringInfo(LAN_LUA_WND_LOBBY_MR_7)	-- 한판 뛰어 볼까??
local g_STRING_MAPNAME_8 = PreCreateString_1962	--GetSStringInfo(LAN_LUA_WND_LOBBY_MR_8)	-- 여긴 우리가 접수한다!!
local g_STRING_MAPNAME_9 = PreCreateString_1963	--GetSStringInfo(LAN_LUA_WND_LOBBY_MR_9)	-- 야!! 모두 다 덤벼!!
local g_STRING_MAPNAME_10 = PreCreateString_1964	--GetSStringInfo(LAN_LUA_WND_LOBBY_MR_10)	-- 얼른 들어와라!!
local g_STRING_MAPNAME_11 = PreCreateString_1965	--GetSStringInfo(LAN_LUA_WND_LOBBY_MR_11)	-- 자신있나? 그럼 들어와!!
local g_STRING_MAPNAME_12 = PreCreateString_1966	--GetSStringInfo(LAN_LUA_WND_LOBBY_MR_12)	-- 제4구역으로 GO GO!!
local g_STRING_MAPNAME_13 = PreCreateString_1967	--GetSStringInfo(LAN_LUA_WND_LOBBY_MR_13)	-- 한판 뛰어 볼까??
local g_STRING_MAPNAME_14 = PreCreateString_1968	--GetSStringInfo(LAN_LUA_WND_LOBBY_MR_14)	-- 여긴 우리가 접수한다!!
local g_STRING_MAPNAME_15 = PreCreateString_1969	--GetSStringInfo(LAN_LUA_WND_LOBBY_MR_15)	-- 야!! 모두 다 덤벼!!
local g_STRING_MAPNAME_16 = PreCreateString_1970	--GetSStringInfo(LAN_LUA_WND_LOBBY_MR_16)	-- 얼른 들어와라!!

local g_STRING_ABUSING_SECRETROOM_CREATE = PreCreateString_3383	--GetSStringInfo(ABUSING_SECRETROOM_CREATE)	-- 얼른 들어와라!!

-- 좀비 파일 이름 넘버
local ZOMBIEFILENUM = 0

-- 래더 제한
local LADDERLIMIT = false

-- 현재 랭귀지 타입을 얻어온다.
local LANGUAGECODE = GetLanguageType()

-- 자신의 래더 점수를 얻어 온다
local MYLADDER = GetLadderPoint() + 1



--------------------------------------------------------------------

-- 방만들기 팝업창

--------------------------------------------------------------------
-- 백그라운드 알파 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_lobby_makeroomAlphaWindow")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

-- 방만들기 알파창 ESC키, ENTER키 등록
RegistEscEventInfo("sj_lobby_makeroomAlphaWindow", "MakeRoom_CANCEL")
RegistEnterEventInfo("sj_lobby_makeroomAlphaWindow", "MakeRoom_OK")

tempBackwindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_lobby_makeroom_tempBackImage")
tempBackwindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
tempBackwindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
tempBackwindow:setProperty("FrameEnabled", "False")
tempBackwindow:setProperty("BackgroundEnabled", "False")
tempBackwindow:setWideType(6);
tempBackwindow:setPosition(344, 100)
tempBackwindow:setSize(340, 600)
tempBackwindow:setVisible(false)
tempBackwindow:setAlwaysOnTop(true)
tempBackwindow:setZOrderingEnabled(false)
root:addChildWindow(tempBackwindow)

makeroomwindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_lobby_makeroom_adjustDesc")
makeroomwindow:setTexture("Enabled", "UIData/option.tga", 332, 458)
makeroomwindow:setTexture("Disabled", "UIData/option.tga", 332, 458)
makeroomwindow:setProperty("FrameEnabled", "False")
makeroomwindow:setProperty("BackgroundEnabled", "False")
makeroomwindow:setPosition(0, 0)
makeroomwindow:setSize(340, 508)
makeroomwindow:setSubscribeEvent("MouseButtonDown", "DropDownButtonInit")
makeroomwindow:setAlwaysOnTop(true)
makeroomwindow:setZOrderingEnabled(false)
tempBackwindow:addChildWindow(makeroomwindow)

--------------------------------------------------------------------

-- 방만들기 확인, 방만들기 취소버튼

--------------------------------------------------------------------
tMakeBattleRoomName  = { ["protecterr"]=0, "sj_lobby_makeroom_okBtn", "sj_lobby_makeroom_cancleBtn" }
tMakeBattleRoomTexX	 = { ["protecterr"]=0, 864, 944 }
tMakeBattleRoomPosX	 = { ["protecterr"]=0, 90, 180 }
tMakeBattleRoomEvent = { ["protecterr"]=0, "MakeRoom_OK", "MakeRoom_CANCEL" }

mywindow = winMgr:createWindow("TaharezLook/Button", "sj_lobby_makeroom_okBtn")
mywindow:setTexture("Normal", "UIData/popup001.tga", 693, 617)
mywindow:setTexture("Hover", "UIData/popup001.tga", 693, 646)
mywindow:setTexture("Pushed", "UIData/popup001.tga", 693, 675)
mywindow:setTexture("PushedOff", "UIData/popup001.tga", 693, 617)
mywindow:setPosition(4, 474)
mywindow:setSize(331, 29)
mywindow:setAlwaysOnTop(true)
mywindow:subscribeEvent("Clicked", "MakeRoom_OK")
makeroomwindow:addChildWindow(mywindow)

function MakeRoom_OK()
	--MakeRoom_CANCEL()
	
	roomName	 = winMgr:getWindow("sj_lobby_roomInfo_title"):getText()
	roomPassword = winMgr:getWindow("sj_lobby_roomInfo_password"):getText()
	
	-- 익스트림 모드인지 체크후 금액을 넘긴다.
	if g_BattleMode == BATTLETYPE_NORMAL then
		extremeZen = 0
	elseif g_BattleMode == BATTLETYPE_EXTREME then
		extremeZen = tonumber(tExtremeZenText[g_extremeZenIndex])
	end
	
	if IsKoreanLanguage() or string.len(roomPassword) == 0 then
		WndLobby_CreateRoom(roomName, nGameMode, bTeam, bItem, nMaxUser, roomPassword, extremeZen, autoBalance, exceptE, bLadderType, ZOMBIEFILENUM, LADDERLIMIT)
	else
		ShowLobbyOkCancelBoxFunction('', g_STRING_ABUSING_SECRETROOM_CREATE, 'OnClickCheckPasswordRoomEnterOk', 'OnClickCheckPasswordRoomEnterCancel')
	end
end

-- 수락
function OnClickCheckPasswordRoomEnterOk(args)

	if winMgr:getWindow('sj_lobby_backWindow') then
		local okfunc = winMgr:getWindow('sj_lobby_backWindow'):getUserString("okFunction")
		if okfunc ~= "OnClickCheckPasswordRoomEnterOk" then
			return
		end
		winMgr:getWindow('sj_lobby_backWindow'):setUserString("okFunction", "")	-- 초기화를 해야함
		
		winMgr:getWindow('sj_lobby_alphaWindow'):setVisible(false)
		root:removeChildWindow(winMgr:getWindow('sj_lobby_alphaWindow'))
		local local_window = winMgr:getWindow('sj_lobby_backWindow')
		winMgr:getWindow('sj_lobby_alphaWindow'):removeChildWindow(local_window)
		local_window:setVisible(false)
		
		roomName	 = winMgr:getWindow("sj_lobby_roomInfo_title"):getText()
		roomPassword = winMgr:getWindow("sj_lobby_roomInfo_password"):getText()
		
		-- 익스트림 모드인지 체크후 금액을 넘긴다.
		if g_BattleMode == BATTLETYPE_NORMAL then
			extremeZen = 0
		elseif g_BattleMode == BATTLETYPE_EXTREME then
			extremeZen = tonumber(tExtremeZenText[g_extremeZenIndex])
		end
		WndLobby_CreateRoom(roomName, nGameMode, bTeam, bItem, nMaxUser, roomPassword, extremeZen, autoBalance, exceptE, bLadderType, ZOMBIEFILENUM, LadderLimit)
	end
end


-- 거절
function OnClickCheckPasswordRoomEnterCancel(args)
	
	if winMgr:getWindow('sj_lobby_backWindow') then
		local nofunc = winMgr:getWindow('sj_lobby_backWindow'):getUserString("noFunction")
		if nofunc ~= "OnClickCheckPasswordRoomEnterCancel" then
			return
		end
		winMgr:getWindow('sj_lobby_backWindow'):setUserString("noFunction", "")	-- 초기화를 해야함
		
		winMgr:getWindow('sj_lobby_alphaWindow'):setVisible(false)
		root:removeChildWindow( winMgr:getWindow('sj_lobby_alphaWindow'))
		local local_window = winMgr:getWindow('sj_lobby_backWindow')
		winMgr:getWindow('sj_lobby_alphaWindow'):removeChildWindow(local_window)
		local_window:setVisible(false)
		
		MakeRoom_CANCEL()
	end
end

-- 파티 매치 ESC키 등록
RegistEnterEventInfo("sj_lobby_alphaWindow", "OnClickCheckPasswordRoomEnterOk")
RegistEscEventInfo("sj_lobby_alphaWindow", "OnClickCheckPasswordRoomEnterCancel")



mywindow = winMgr:createWindow("TaharezLook/Button", "sj_lobby_makeroom_cancleBtn")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setPosition(308, 6)
mywindow:setSize(23, 23)
mywindow:setAlwaysOnTop(true)
mywindow:subscribeEvent("Clicked", "MakeRoom_CANCEL")
winMgr:getWindow("sj_lobby_makeroom_adjustDesc"):addChildWindow(mywindow)

function MakeRoom_CANCEL()
	winMgr:getWindow("sj_lobby_makeroomAlphaWindow"):setVisible(false)
	winMgr:getWindow("sj_lobby_makeroom_tempBackImage"):setVisible(false)
	
	DropDownButtonInit()
	-- 방만들기를 완성하면 채팅창을 활성화 시킨다
	Chatting_SetChatEnabled(true)
	
	
	SetLobbyMatchText(PreCreateString_4195)
	
	winMgr:getWindow("Lobby_Select_Match0"):setProperty("Selected", "true")
end






------------------------------------------------------------------------
-- 방만들기 팝업창 안의 내용들(방만들기 팝업창 Child) (9개)

-- 1. 방제목,   2. 게임모드, 3. 개인전, 팀전, 4. 아템전
-- 5. 인원설정  6. 비밀번호
------------------------------------------------------------------------
-- 1. 방제목(에디트 박스)
tRoomName = {["err"]=0, g_STRING_MAPNAME_1,  g_STRING_MAPNAME_2,  g_STRING_MAPNAME_3,  g_STRING_MAPNAME_4,  g_STRING_MAPNAME_5,
						g_STRING_MAPNAME_6,  g_STRING_MAPNAME_7,  g_STRING_MAPNAME_8,  g_STRING_MAPNAME_9,  g_STRING_MAPNAME_10,
						g_STRING_MAPNAME_11, g_STRING_MAPNAME_12, g_STRING_MAPNAME_13, g_STRING_MAPNAME_14, g_STRING_MAPNAME_15,
						g_STRING_MAPNAME_16}
						
mywindow = winMgr:createWindow("TaharezLook/Editbox", "sj_lobby_roomInfo_title")
mywindow:setPosition(106, 68)
mywindow:setSize(204, 22)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setText(tRoomName[1])
mywindow:subscribeEvent("TextAccepted", "MakeRoom_OK")
makeroomwindow:addChildWindow(mywindow)
CEGUI.toEditbox(winMgr:getWindow("sj_lobby_roomInfo_title")):setMaxTextLength(32)


-- 2. 비밀번호(에디트 박스)
mywindow = winMgr:createWindow("TaharezLook/Editbox", "sj_lobby_roomInfo_password")
mywindow:setPosition(106, 101)
mywindow:setSize(113, 22)
mywindow:setFont(g_STRING_FONT_GULIM, 12)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:subscribeEvent("TextAccepted", "MakeRoom_OK")
CEGUI.toEditbox(mywindow):setInputOnlyNumber()
CEGUI.toEditbox(mywindow):setMaxTextLength(4)
makeroomwindow:addChildWindow(mywindow)

-- 자동 팀균형 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_lobby_select_autobalanceImage")
mywindow:setTexture("Enabled", "UIData/option.tga", 535, 1002)
mywindow:setTexture("Disabled", "UIData/option.tga", 535, 1002)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(30, 315)
mywindow:setSize(292, 21)
mywindow:setZOrderingEnabled(false)
makeroomwindow:addChildWindow(mywindow)

-- 자동 팀균형 체크박스
mywindow = winMgr:createWindow("TaharezLook/Checkbox", "sj_lobby_select_autobalanceCheckbox")
mywindow:setTexture("Normal", "UIData/option.tga", 493, 1002)
mywindow:setTexture("Hover", "UIData/option.tga", 493, 1002)
mywindow:setTexture("Pushed", "UIData/option.tga", 514, 1002)
mywindow:setTexture("PushedOff", "UIData/option.tga", 514, 1002)
mywindow:setTexture("SelectedNormal", "UIData/option.tga", 514, 1002)
mywindow:setTexture("SelectedHover", "UIData/option.tga", 514, 1002)
mywindow:setTexture("SelectedPushed", "UIData/option.tga", 493, 1002)
mywindow:setTexture("SelectedPushedOff", "UIData/option.tga", 493, 1002)
mywindow:setSize(21, 21)
mywindow:setPosition(9, 316)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("CheckStateChanged", "SelectAutoBalance")
makeroomwindow:addChildWindow(mywindow)

function SelectAutoBalance(args)
	local local_window = CEGUI.toWindowEventArgs(args).window
	if CEGUI.toCheckbox(local_window):isSelected() then
		autoBalance = true
	else
		autoBalance = false
	end
end

function InitAutoBalance()
	winMgr:getWindow("sj_lobby_select_autobalanceCheckbox"):setProperty("Selected", "true")
end

function ChangeAutoBalance()
	if bTeam then
		winMgr:getWindow("sj_lobby_select_autobalanceImage"):setVisible(true)
		winMgr:getWindow("sj_lobby_select_autobalanceCheckbox"):setVisible(true)
		InitAutoBalance()
	else
		winMgr:getWindow("sj_lobby_select_autobalanceImage"):setVisible(false)
		winMgr:getWindow("sj_lobby_select_autobalanceCheckbox"):setVisible(false)
		InitAutoBalance()
	end
	
	if g_BattleMode == BATTLETYPE_GUILD_BATTLE then
		winMgr:getWindow("sj_lobby_select_autobalanceImage"):setVisible(false)
		winMgr:getWindow("sj_lobby_select_autobalanceCheckbox"):setVisible(false)
	end
end


-- E필살기 제외모드
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_lobby_select_exceptEImage")
mywindow:setTexture("Enabled", "UIData/option.tga", 201, 1002)
mywindow:setTexture("Disabled", "UIData/option.tga", 201, 1002)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")

if IsThaiLanguage() or IsEngLanguage() or IsGSPLanguage() then----0421KSG
	mywindow:setPosition(30, 365)
else
	mywindow:setPosition(28, 340)
end

mywindow:setSize(292, 21)
mywindow:setZOrderingEnabled(false)

if CheckfacilityData(FACILITYCODE_EXCEPTEMODE) == 1 then
	makeroomwindow:addChildWindow(mywindow)
end

-- E필살기 제외 체크박스
mywindow = winMgr:createWindow("TaharezLook/Checkbox", "sj_lobby_select_exceptECheckbox")
mywindow:setTexture("Normal", "UIData/option.tga", 493, 1002)
mywindow:setTexture("Hover", "UIData/option.tga", 493, 1002)
mywindow:setTexture("Pushed", "UIData/option.tga", 514, 1002)
mywindow:setTexture("PushedOff", "UIData/option.tga", 514, 1002)
mywindow:setTexture("SelectedNormal", "UIData/option.tga", 514, 1002)
mywindow:setTexture("SelectedHover", "UIData/option.tga", 514, 1002)
mywindow:setTexture("SelectedPushed", "UIData/option.tga", 493, 1002)
mywindow:setTexture("SelectedPushedOff", "UIData/option.tga", 493, 1002)
mywindow:setSize(21, 21)

if IsThaiLanguage() or IsEngLanguage() or IsGSPLanguage() then----0421KSG
	mywindow:setPosition(9, 366)
else
	mywindow:setPosition(9, 341)
end

mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("CheckStateChanged", "SelectExceptE")

if CheckfacilityData(FACILITYCODE_EXCEPTEMODE) == 1 then
	makeroomwindow:addChildWindow(mywindow)
end

function SelectExceptE(args)
	local local_window = CEGUI.toWindowEventArgs(args).window
	if CEGUI.toCheckbox(local_window):isSelected() then
		exceptE = true
	else
		exceptE = false
	end
end

function InitExceptE()
	if IsKoreanLanguage() then
		if GetIsCurrentLadderChannel() == 1 then
			winMgr:getWindow("sj_lobby_select_exceptEImage"):setVisible(true)
			winMgr:getWindow("sj_lobby_select_exceptECheckbox"):setVisible(true)
			winMgr:getWindow("sj_lobby_select_exceptECheckbox"):setProperty("Selected", "false")
		else
			winMgr:getWindow("sj_lobby_select_exceptEImage"):setVisible(false)
			winMgr:getWindow("sj_lobby_select_exceptECheckbox"):setVisible(false)
		end
	else
		winMgr:getWindow("sj_lobby_select_exceptEImage"):setVisible(true)
		winMgr:getWindow("sj_lobby_select_exceptECheckbox"):setVisible(true)
		winMgr:getWindow("sj_lobby_select_exceptECheckbox"):setProperty("Selected", "false")
	end

	if g_BattleMode == BATTLETYPE_GUILD_BATTLE then
		winMgr:getWindow("sj_lobby_select_exceptEImage"):setVisible(true)
		winMgr:getWindow("sj_lobby_select_exceptECheckbox"):setVisible(true)
		winMgr:getWindow("sj_lobby_select_exceptECheckbox"):setProperty("Selected", "false")
	end
end


-- 래더 제한 모드
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Lobby_Ladder_Limit_Image")
mywindow:setTexture("Enabled", "UIData/option.tga", 535, 981)
mywindow:setTexture("Disabled", "UIData/option.tga", 535, 981)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(33, 340)
mywindow:setSize(292, 21)
mywindow:setZOrderingEnabled(false)
makeroomwindow:addChildWindow(mywindow)

-- 래더 제한 모드 체크박스
mywindow = winMgr:createWindow("TaharezLook/Checkbox", "Lobby_Ladder_Limit_SelectBox")
mywindow:setTexture("Normal", "UIData/option.tga", 493, 1002)
mywindow:setTexture("Hover", "UIData/option.tga", 493, 1002)
mywindow:setTexture("Pushed", "UIData/option.tga", 514, 1002)
mywindow:setTexture("PushedOff", "UIData/option.tga", 514, 1002)
mywindow:setTexture("SelectedNormal", "UIData/option.tga", 514, 1002)
mywindow:setTexture("SelectedHover", "UIData/option.tga", 514, 1002)
mywindow:setTexture("SelectedPushed", "UIData/option.tga", 493, 1002)
mywindow:setTexture("SelectedPushedOff", "UIData/option.tga", 493, 1002)
mywindow:setSize(21, 21)
mywindow:setPosition(9, 341)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("CheckStateChanged", "SelectLadderLimit")
makeroomwindow:addChildWindow(mywindow)


function SelectLadderLimit(args)
	local local_window = CEGUI.toWindowEventArgs(args).window
	if CEGUI.toCheckbox(local_window):isSelected() then
		LADDERLIMIT = true
	else
		LADDERLIMIT = false
	end
end

function InitLadderLimit()
	LADDERLIMIT = false
	
	if IsThaiLanguage() or IsEngLanguage() or IsGSPLanguage() then----0421KSG
		if GetLadderLimitChannel() == 1 then
			--winMgr:getWindow("sj_lobby_select_exceptEImage"):setPosition(28, 340)
			--winMgr:getWindow("sj_lobby_select_exceptECheckbox"):setPosition(9, 341)
			
			winMgr:getWindow("Lobby_Ladder_Limit_Image"):setVisible(false)
			winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setVisible(false)
			
			winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setProperty("Selected", "false")
		else
			winMgr:getWindow("Lobby_Ladder_Limit_Image"):setVisible(true)
			winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setVisible(true)
			winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setProperty("Selected", "false")
					
			MyLadderPointImageSetting(MYLADDER)
		end
		
	else
		winMgr:getWindow("Lobby_Ladder_Limit_Image"):setVisible(false)
		winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setVisible(false)
		winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setProperty("Selected", "false")
	end
end

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Lobby_Ladder_Limit_Max_TenImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(195, 343)
mywindow:setSize(8, 14)
mywindow:setZOrderingEnabled(false)
makeroomwindow:addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Lobby_Ladder_Limit_Max_OneImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(203, 343)
mywindow:setSize(8, 14)
mywindow:setZOrderingEnabled(false)
makeroomwindow:addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Lobby_Ladder_Limit_Min_TenImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(146, 343)
mywindow:setSize(8, 14)
mywindow:setZOrderingEnabled(false)
makeroomwindow:addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Lobby_Ladder_Limit_Min_OneImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(154, 343)
mywindow:setSize(8, 14)
mywindow:setZOrderingEnabled(false)
makeroomwindow:addChildWindow(mywindow)

function MyLadderPointImageSetting(Number)
	local MaxLadder = Number + 2
	local MinLadder = Number - 2
	
	if MaxLadder >= 10 then
		local TexXTen = MaxLadder / 10
		local TexXOne = MaxLadder % 10
	
		winMgr:getWindow("Lobby_Ladder_Limit_Max_TenImage"):setTexture("Enabled", "UIData/option.tga", 902 + (TexXTen * 8), 911)
		winMgr:getWindow("Lobby_Ladder_Limit_Max_TenImage"):setTexture("Disabled", "UIData/option.tga", 902 + (TexXTen * 8), 911)
		
		winMgr:getWindow("Lobby_Ladder_Limit_Max_OneImage"):setPosition(203, 343)
		winMgr:getWindow("Lobby_Ladder_Limit_Max_OneImage"):setTexture("Enabled", "UIData/option.tga", 902 + (TexXOne * 8), 911)
		winMgr:getWindow("Lobby_Ladder_Limit_Max_OneImage"):setTexture("Disabled", "UIData/option.tga", 902 + (TexXOne * 8), 911)			
	elseif MaxLadder < 10 then
	
		winMgr:getWindow("Lobby_Ladder_Limit_Max_OneImage"):setPosition(199, 343)
		winMgr:getWindow("Lobby_Ladder_Limit_Max_OneImage"):setTexture("Enabled", "UIData/option.tga", 902 + (MaxLadder * 8), 911)
		winMgr:getWindow("Lobby_Ladder_Limit_Max_OneImage"):setTexture("Disabled", "UIData/option.tga", 902 + (MaxLadder * 8), 911)
	end
	
	if MinLadder >= 10 then
		local TexXTen = MinLadder / 10
		local TexXOne = MinLadder % 10
		
		winMgr:getWindow("Lobby_Ladder_Limit_Min_TenImage"):setTexture("Enabled", "UIData/option.tga", 902 + (TexXTen * 8), 911)
		winMgr:getWindow("Lobby_Ladder_Limit_Min_TenImage"):setTexture("Disabled", "UIData/option.tga", 902 + (TexXTen * 8), 911)
		
		winMgr:getWindow("Lobby_Ladder_Limit_Min_OneImage"):setPosition(154, 343)
		winMgr:getWindow("Lobby_Ladder_Limit_Min_OneImage"):setTexture("Enabled", "UIData/option.tga", 902 + (TexXOne * 8), 911)
		winMgr:getWindow("Lobby_Ladder_Limit_Min_OneImage"):setTexture("Disabled", "UIData/option.tga", 902 + (TexXOne * 8), 911)
		
	elseif MinLadder < 10 then
	
		if MinLadder <= 0 then
			MinLadder = 1
		end
	
		winMgr:getWindow("Lobby_Ladder_Limit_Min_OneImage"):setPosition(150, 343)
		winMgr:getWindow("Lobby_Ladder_Limit_Min_OneImage"):setTexture("Enabled", "UIData/option.tga", 902 + (MinLadder * 8), 911)
		winMgr:getWindow("Lobby_Ladder_Limit_Min_OneImage"):setTexture("Disabled", "UIData/option.tga", 902 + (MinLadder * 8), 911)
	end
end


-- 3. 게임모드
tMakeRoomName_battleMode = { ["protecterr"]=0, "sj_lobby_select_deathMatch", "sj_lobby_select_survival", "sj_lobby_select_dualMatch"}
tMakeRoomPosX_battleMode = { ["protecterr"]=0, 108, 216, 108 }
tMakeRoomPosY_battleMode = { ["protecterr"]=0, 142, 142, 174 }

for i=1, #tMakeRoomName_battleMode do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tMakeRoomName_battleMode[i])
	mywindow:setTexture("Normal", "UIData/popup001.tga", 440, 753)
	mywindow:setTexture("Hover", "UIData/popup001.tga", 440, 753)
	mywindow:setTexture("Pushed", "UIData/popup001.tga", 440, 772)
	mywindow:setTexture("PushedOff", "UIData/popup001.tga", 440, 753)
	mywindow:setTexture("SelectedNormal", "UIData/popup001.tga", 440, 772)
	mywindow:setTexture("SelectedHover", "UIData/popup001.tga", 440, 772)
	mywindow:setTexture("SelectedPushed", "UIData/popup001.tga", 440, 772)
	mywindow:setTexture("SelectedPushedOff", "UIData/popup001.tga", 440, 772)
	mywindow:setTexture("Enabled", "UIData/popup001.tga", 440, 753)
	mywindow:setTexture("Disabled", "UIData/popup001.tga", 440, 791)	
	mywindow:setPosition(tMakeRoomPosX_battleMode[i], tMakeRoomPosY_battleMode[i])
	mywindow:setSize(78, 19)
	mywindow:setVisible(false)
	mywindow:setZOrderingEnabled(false)
	mywindow:setProperty("GroupID", 1610)
--	mywindow:subscribeEvent("SelectStateChanged", "SelectGameMode")
	makeroomwindow:addChildWindow(mywindow)
	
	-- 한국은 서바이벌, 대장전 모드 제외
	if IsKoreanLanguage() then
		if i == 2 then
			mywindow:setVisible(false)
		elseif i == 3 then
			if GetIsMyMasterLadder() == 0 then
				mywindow:setEnabled(false)
			end
		end
	end
end

mywindow = winMgr:createWindow("TaharezLook/Button", "Lobby_select_Match")
mywindow:setTexture("Normal", "UIData/option.tga", 650, 377)
mywindow:setTexture("Hover", "UIData/option.tga", 650, 397)
mywindow:setTexture("Pushed", "UIData/option.tga", 650, 417)
mywindow:setTexture("PushedOff", "UIData/option.tga", 650, 437)
mywindow:setPosition(304, 158)
mywindow:setSize(20, 20)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "MatchDropDownButton")
winMgr:getWindow("sj_lobby_makeroom_adjustDesc"):addChildWindow(mywindow)

function SetLobbyMatchText( text )

	local size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, text)
	
	winMgr:getWindow("Lobby_Match_Text"):setText( text )
	winMgr:getWindow("Lobby_Match_Text"):setPosition( 210 - size/2, 160 )
end

mywindow = winMgr:createWindow("TaharezLook/StaticText", "Lobby_Match_Text")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(50, 192, 254, 255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setSize(161, 20)
mywindow:setProperty("Disabled", "true")
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("sj_lobby_makeroom_adjustDesc"):addChildWindow(mywindow)

SetLobbyMatchText(PreCreateString_4195)


local MathcModeCount = -1  -- 현재 버전에 나와야 할 매치 모드 갯수를 저장

if g_BattleMode == BATTLETYPE_GUILD_BATTLE then

	MathcModeCount = 1
	
	tMatchModeName = {}
	tMatchModeEvent = {}

	tMatchModeName = { [0] = "Death Match"}
	tMatchModeEvent  = {['err'] = 0, [0]= "ClubDeathGameMode", "ClubDuelGameMode"}
	
	for i=0, #tMatchModeName do
		mywindow = winMgr:createWindow("TaharezLook/RadioButton", "Lobby_Select_Match"..i)
		mywindow:setTexture("Normal", "UIData/option.tga", 0, 934)
		mywindow:setTexture("Hover", "UIData/option.tga", 0, 954)
		mywindow:setTexture("Pushed", "UIData/option.tga", 0, 934)
		mywindow:setTexture("SelectedNormal", "UIData/option.tga", 0, 954)
		mywindow:setTexture("SelectedHover", "UIData/option.tga", 0, 954)
		mywindow:setTexture("SelectedPushed", "UIData/option.tga", 0, 934)
		mywindow:setSize(194, 20)
		mywindow:setPosition(110, 179 + (i * 21) )
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:setUserString("Index", i)
		mywindow:setSubscribeEvent("MouseEnter",		 "MouseEnterTextColorChange")
		mywindow:setSubscribeEvent("MouseLeave",		 "MouseLeaveTextColorChange")
		mywindow:setSubscribeEvent("SelectStateChanged", "DropDownButtonInit")
		mywindow:setSubscribeEvent("MouseButtonDown",	 tMatchModeEvent[i])
		mywindow:setProperty("GroupID", 12000)
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		winMgr:getWindow("sj_lobby_makeroom_adjustDesc"):addChildWindow(mywindow)
		
		
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "Lobby_select_Match_Text"..i)
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(255, 255, 255, 255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
		mywindow:setPosition(10, 1)
		mywindow:setSize(161, 20)
		mywindow:setText(tMatchModeName[i])
		mywindow:setProperty("Disabled", "true")
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("Lobby_Select_Match"..i):addChildWindow(mywindow)
	end
	
else
	tMatchModeName_KOR  = { [0] = "데스매치",    "대장전",           "서바이벌",  "코인전",      "폭탄전", "타워전" }
	--tMatchModeName_THAI = { [0] = "Death Match", "Duel Battle",      "Survival",  "Coin Battle", "Bomb Battle", "Tower Battle" }
	tMatchModeName_THAI = { [0] = "Death Match", "Duel Battle", "BoomBall", "Tower Battle" }
	tMatchModeName_MAS  = { [0] = "Death Match", "Team Elimination", "Survival",  "Coin Battle", "BoomBall", "Tower Battle" }
	tMatchModeName_ENG  = { [0] = "Death Match", "Team Elimination", "Survival",  "Coin Battle", "BoomBall", "Tower Battle" }
	tMatchModeName_IDN  = { [0] = "Death Match", "Team Elimination", "Survival",  "Coin Battle", "BoomBall", "Tower Battle" }
	tMatchModeName_GSP  = { [0] = "Death Match", "Team Elimination", "Survival",  "Coin Battle", "BoomBall", "Tower Battle" }

	tLanguageModeName  = {['err'] = 0, [0]=  tMatchModeName_ENG, tMatchModeName_KOR, tMatchModeName_THAI, tMatchModeName_MAS, tMatchModeName_IDN, tMatchModeName_GSP }
	
	-- 데스매치
	if CheckfacilityData(FACILITYCODE_DEATHMATCH) == 1 then
		-- 모드 갯수 추가
		MathcModeCount = MathcModeCount + 1
		
		mywindow = winMgr:createWindow("TaharezLook/RadioButton", "Lobby_Select_Match"..MathcModeCount)
		mywindow:setTexture("Normal", "UIData/option.tga", 0, 934)
		mywindow:setTexture("Hover", "UIData/option.tga", 0, 954)
		mywindow:setTexture("Pushed", "UIData/option.tga", 0, 934)
		mywindow:setTexture("SelectedNormal", "UIData/option.tga", 0, 954)
		mywindow:setTexture("SelectedHover", "UIData/option.tga", 0, 954)
		mywindow:setTexture("SelectedPushed", "UIData/option.tga", 0, 934)
		mywindow:setSize(194, 20)
		mywindow:setPosition(110, 179 + (MathcModeCount * 21) )
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:setUserString("Index", MathcModeCount)
		mywindow:setSubscribeEvent("MouseEnter",		 "MouseEnterTextColorChange")
		mywindow:setSubscribeEvent("MouseLeave",		 "MouseLeaveTextColorChange")
		mywindow:setSubscribeEvent("SelectStateChanged", "DropDownButtonInit")
		mywindow:setSubscribeEvent("MouseButtonDown",	 "DeathGameMode")
		mywindow:setProperty("GroupID", 12000)
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		winMgr:getWindow("sj_lobby_makeroom_adjustDesc"):addChildWindow(mywindow)
		
		
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "Lobby_select_Match_Text"..MathcModeCount)
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(255, 255, 255, 255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
		mywindow:setPosition(10, 1)
		mywindow:setSize(161, 20)
		mywindow:setText(tLanguageModeName[LANGUAGECODE][0])
		mywindow:setProperty("Disabled", "true")
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("Lobby_Select_Match"..MathcModeCount):addChildWindow(mywindow)
	end

	-- 듀얼 모드
	if CheckfacilityData(FACILITYCODE_DUELBATTLE) == 1 then
		-- 모드 갯수 추가
		MathcModeCount = MathcModeCount + 1
	
		mywindow = winMgr:createWindow("TaharezLook/RadioButton", "Lobby_Select_Match"..MathcModeCount)
		mywindow:setTexture("Normal", "UIData/option.tga", 0, 934)
		mywindow:setTexture("Hover", "UIData/option.tga", 0, 954)
		mywindow:setTexture("Pushed", "UIData/option.tga", 0, 934)
		mywindow:setTexture("SelectedNormal", "UIData/option.tga", 0, 954)
		mywindow:setTexture("SelectedHover", "UIData/option.tga", 0, 954)
		mywindow:setTexture("SelectedPushed", "UIData/option.tga", 0, 934)
		mywindow:setSize(194, 20)
		mywindow:setPosition(110, 179 + (MathcModeCount * 21) )
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:setUserString("Index", MathcModeCount)
		mywindow:setSubscribeEvent("MouseEnter",		 "MouseEnterTextColorChange")
		mywindow:setSubscribeEvent("MouseLeave",		 "MouseLeaveTextColorChange")
		mywindow:setSubscribeEvent("SelectStateChanged", "DropDownButtonInit")
		mywindow:setSubscribeEvent("MouseButtonDown",	 "DuelGameMode")
		mywindow:setProperty("GroupID", 12000)
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		winMgr:getWindow("sj_lobby_makeroom_adjustDesc"):addChildWindow(mywindow)
		
		
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "Lobby_select_Match_Text"..MathcModeCount)
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(255, 255, 255, 255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
		mywindow:setPosition(10, 1)
		mywindow:setSize(161, 20)
		mywindow:setText(tLanguageModeName[LANGUAGECODE][1])
		mywindow:setProperty("Disabled", "true")
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("Lobby_Select_Match"..MathcModeCount):addChildWindow(mywindow)

	end

	-- 서바이벌
	if CheckfacilityData(FACILITYCODE_SURVIVAL) == 1 then
		-- 모드 갯수 추가
		MathcModeCount = MathcModeCount + 1
	
		mywindow = winMgr:createWindow("TaharezLook/RadioButton", "Lobby_Select_Match"..MathcModeCount)
		mywindow:setTexture("Normal", "UIData/option.tga", 0, 934)
		mywindow:setTexture("Hover", "UIData/option.tga", 0, 954)
		mywindow:setTexture("Pushed", "UIData/option.tga", 0, 934)
		mywindow:setTexture("SelectedNormal", "UIData/option.tga", 0, 954)
		mywindow:setTexture("SelectedHover", "UIData/option.tga", 0, 954)
		mywindow:setTexture("SelectedPushed", "UIData/option.tga", 0, 934)
		mywindow:setSize(194, 20)
		mywindow:setPosition(110, 179 + (MathcModeCount * 21) )
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:setUserString("Index", MathcModeCount)
		mywindow:setSubscribeEvent("MouseEnter",		 "MouseEnterTextColorChange")
		mywindow:setSubscribeEvent("MouseLeave",		 "MouseLeaveTextColorChange")
		mywindow:setSubscribeEvent("SelectStateChanged", "DropDownButtonInit")
		mywindow:setSubscribeEvent("MouseButtonDown",	 "SurvivalGameMode")
		mywindow:setProperty("GroupID", 12000)
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		winMgr:getWindow("sj_lobby_makeroom_adjustDesc"):addChildWindow(mywindow)
		
		
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "Lobby_select_Match_Text"..MathcModeCount)
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(255, 255, 255, 255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
		mywindow:setPosition(10, 1)
		mywindow:setSize(161, 20)
		mywindow:setText(tLanguageModeName[LANGUAGECODE][2])
		mywindow:setProperty("Disabled", "true")
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("Lobby_Select_Match"..MathcModeCount):addChildWindow(mywindow)
	end

	-- 코인전
	if CheckfacilityData(FACILITYCODE_COINBATTLE) == 1 then
		-- 모드 갯수 추가
		MathcModeCount = MathcModeCount + 1

		mywindow = winMgr:createWindow("TaharezLook/RadioButton", "Lobby_Select_Match"..MathcModeCount)
		mywindow:setTexture("Normal", "UIData/option.tga", 0, 934)
		mywindow:setTexture("Hover", "UIData/option.tga", 0, 954)
		mywindow:setTexture("Pushed", "UIData/option.tga", 0, 934)
		mywindow:setTexture("SelectedNormal", "UIData/option.tga", 0, 954)
		mywindow:setTexture("SelectedHover", "UIData/option.tga", 0, 954)
		mywindow:setTexture("SelectedPushed", "UIData/option.tga", 0, 934)
		mywindow:setSize(194, 20)
		mywindow:setPosition(110, 179 + (MathcModeCount * 21) )
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:setUserString("Index", MathcModeCount)
		mywindow:setSubscribeEvent("MouseEnter",		 "MouseEnterTextColorChange")
		mywindow:setSubscribeEvent("MouseLeave",		 "MouseLeaveTextColorChange")
		mywindow:setSubscribeEvent("SelectStateChanged", "DropDownButtonInit")
		mywindow:setSubscribeEvent("MouseButtonDown",	 "CoinGameMode")
		mywindow:setProperty("GroupID", 12000)
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		winMgr:getWindow("sj_lobby_makeroom_adjustDesc"):addChildWindow(mywindow)
		
		
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "Lobby_select_Match_Text"..MathcModeCount)
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(255, 255, 255, 255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
		mywindow:setPosition(10, 1)
		mywindow:setSize(161, 20)
		mywindow:setText(tLanguageModeName[LANGUAGECODE][3])
		mywindow:setProperty("Disabled", "true")
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("Lobby_Select_Match"..MathcModeCount):addChildWindow(mywindow)
	end

	-- 폭탄전
	if CheckfacilityData(FACILITYCODE_BOOMBATTLE) == 1 then
		-- 모드 갯수 추가
		MathcModeCount = MathcModeCount + 1

		mywindow = winMgr:createWindow("TaharezLook/RadioButton", "Lobby_Select_Match"..MathcModeCount)
		mywindow:setTexture("Normal", "UIData/option.tga", 0, 934)
		mywindow:setTexture("Hover", "UIData/option.tga", 0, 954)
		mywindow:setTexture("Pushed", "UIData/option.tga", 0, 934)
		mywindow:setTexture("SelectedNormal", "UIData/option.tga", 0, 954)
		mywindow:setTexture("SelectedHover", "UIData/option.tga", 0, 954)
		mywindow:setTexture("SelectedPushed", "UIData/option.tga", 0, 934)
		mywindow:setSize(194, 20)
		mywindow:setPosition(110, 179 + (MathcModeCount * 21) )
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:setUserString("Index", MathcModeCount)
		mywindow:setSubscribeEvent("MouseEnter",		 "MouseEnterTextColorChange")
		mywindow:setSubscribeEvent("MouseLeave",		 "MouseLeaveTextColorChange")
		mywindow:setSubscribeEvent("SelectStateChanged", "DropDownButtonInit")
		mywindow:setSubscribeEvent("MouseButtonDown",	 "BombGameMode")
		mywindow:setProperty("GroupID", 12000)
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		winMgr:getWindow("sj_lobby_makeroom_adjustDesc"):addChildWindow(mywindow)
		
		
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "Lobby_select_Match_Text"..MathcModeCount)
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(255, 255, 255, 255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
		mywindow:setPosition(10, 1)
		mywindow:setSize(161, 20)
		mywindow:setText("Bomb Battle")--"tLanguageModeName[LANGUAGECODE][4])
		mywindow:setProperty("Disabled", "true")
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("Lobby_Select_Match"..MathcModeCount):addChildWindow(mywindow)

	end

	-- 미니타워전
	if CheckfacilityData(FACILITYCODE_MINITOWERBATTLE) == 1 then
		-- 모드 갯수 추가
		MathcModeCount = MathcModeCount + 1

		mywindow = winMgr:createWindow("TaharezLook/RadioButton", "Lobby_Select_Match"..MathcModeCount)
		mywindow:setTexture("Normal", "UIData/option.tga", 0, 934)
		mywindow:setTexture("Hover", "UIData/option.tga", 0, 954)
		mywindow:setTexture("Pushed", "UIData/option.tga", 0, 934)
		mywindow:setTexture("SelectedNormal", "UIData/option.tga", 0, 954)
		mywindow:setTexture("SelectedHover", "UIData/option.tga", 0, 954)
		mywindow:setTexture("SelectedPushed", "UIData/option.tga", 0, 934)
		mywindow:setSize(194, 20)
		mywindow:setPosition(110, 179 + (MathcModeCount * 21) )
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:setUserString("Index", MathcModeCount)
		mywindow:setSubscribeEvent("MouseEnter",		 "MouseEnterTextColorChange")
		mywindow:setSubscribeEvent("MouseLeave",		 "MouseLeaveTextColorChange")
		mywindow:setSubscribeEvent("SelectStateChanged", "DropDownButtonInit")
		mywindow:setSubscribeEvent("MouseButtonDown",	 "MiniTowerGameMode")
		mywindow:setProperty("GroupID", 12000)
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		winMgr:getWindow("sj_lobby_makeroom_adjustDesc"):addChildWindow(mywindow)
		
		
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "Lobby_select_Match_Text"..MathcModeCount)
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(255, 255, 255, 255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
		mywindow:setPosition(10, 1)
		mywindow:setSize(161, 20)
		mywindow:setText("Tower Battle")--tLanguageModeName[LANGUAGECODE][5])
		mywindow:setProperty("Disabled", "true")
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("Lobby_Select_Match"..MathcModeCount):addChildWindow(mywindow)

	end
	
--[[
	-- 나라별로 New 이미지를 띄어줄 곳
	tNewChildWindowNum_KOR  = {['err'] = 0, [0]= 2, 3 }
	tNewChildWindowNum_THAI = {['err'] = 0, [0]= 4 }
	tNewChildWindowNum_ENG  = {['err'] = 0, [0]= 3 }
	tNewChildWindowNum_MAS  = {['err'] = 0, [0]= 0, 1, 2 }
	tNewChildWindowNum_IDN  = {['err'] = 0, [0]= 0, 1, 2 }
	tNewChildWindowNum_GSP  = {['err'] = 0, [0]= 3 }

	local tLanguageNewImg	 = {['err'] = 0, [0]=  tNewChildWindowNum_ENG,	tNewChildWindowNum_KOR, tNewChildWindowNum_THAI,	tNewChildWindowNum_MAS	, tNewChildWindowNum_IDN, tNewChildWindowNum_GSP }

	for i = 0, #tLanguageNewImg[LANGUAGECODE] do
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Lobby_Select_Match_New"..i)
		mywindow:setTexture("Enabled", "UIData/option.tga", 0, 1009)
		mywindow:setTexture("Disabled", "UIData/option.tga", 0, 1009)
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")
		mywindow:setSize(33, 15)
		mywindow:setVisible(true)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		
		if IsKoreanLanguage() then
			mywindow:setPosition(60, 2)
		elseif IsThaiLanguage() or IsEngLanguage() or IsGSPLanguage() then----0421KSG
			mywindow:setPosition(88, 2)
		else
			mywindow:setPosition(85, 2)
		end
		
		winMgr:getWindow("Lobby_Select_Match"..tLanguageNewImg[LANGUAGECODE][i]):addChildWindow(mywindow)
	end]]--
end


function MatchDropDownButton()

	if winMgr:getWindow("Lobby_Select_Match0"):isVisible() then
		DropDownButtonInit()
	else
		for i=0, MathcModeCount do
			winMgr:getWindow("Lobby_Select_Match"..i):setVisible(true)
			
			if CEGUI.toRadioButton(winMgr:getWindow("Lobby_Select_Match"..i)):isSelected() then
				winMgr:getWindow("Lobby_select_Match_Text"..i):setTextColor(0, 0, 0, 255)
			else
				winMgr:getWindow("Lobby_select_Match_Text"..i):setTextColor(255, 255, 255, 255)	
			end
		end
	end

	if g_BattleMode == BATTLETYPE_EXTREME then
		winMgr:getWindow("Lobby_Select_Match3"):setVisible(false)
	end
end

function DropDownButtonInit()
	for i=0, MathcModeCount do
		winMgr:getWindow("Lobby_Select_Match"..i):setVisible(false)
	end
end

function MouseEnterTextColorChange(args)
	local EnterWindow = CEGUI.toWindowEventArgs(args).window:getUserString("Index")
	
	winMgr:getWindow("Lobby_select_Match_Text"..EnterWindow):setTextColor(0, 0, 0, 255)
end

function MouseLeaveTextColorChange(args)
	local EnterWindow = CEGUI.toWindowEventArgs(args).window:getUserString("Index")	
	
	if CEGUI.toRadioButton(winMgr:getWindow("Lobby_Select_Match"..EnterWindow)):isSelected() then
		return
	else
		winMgr:getWindow("Lobby_select_Match_Text"..EnterWindow):setTextColor(255, 255, 255, 255)	
	end
end

function DeathGameMode(args)
	local EnterWindow = CEGUI.toWindowEventArgs(args).window:getUserString("Index")
	local WindowNum	  = tonumber(EnterWindow)
	
	SetLobbyMatchText(tLanguageModeName[LANGUAGECODE][0])
	
	nMaxUser = 8
	nGameMode = 0
	bTeam = true
	bItem = PLAYTYPE_ITEM
	ChangeUser()
	ChangeAutoBalance()
	InitLadderType()
	
	winMgr:getWindow("sj_lobby_select_privateBattle"):setEnabled(true)
	winMgr:getWindow("sj_lobby_select_teamBattle"):setEnabled(true)
	
	if IsKoreanLanguage() then
		winMgr:getWindow("Lobby_Ladder_Limit_Image"):setVisible(false)
		winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setVisible(false)
		winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setProperty("Selected", "false")
					
		if GetIsCurrentLadderChannel() == 1 then
			winMgr:getWindow("sj_lobby_select_noItemBattle"):setEnabled(true)
			winMgr:getWindow("sj_lobby_select_ItemBattle"):setEnabled(true)
			--winMgr:getWindow("sj_lobby_select_exceptEImage"):setVisible(true)
			--winMgr:getWindow("sj_lobby_select_exceptECheckbox"):setVisible(true)
			--winMgr:getWindow("sj_lobby_select_exceptECheckbox"):setProperty("Selected", "false")
		else
			winMgr:getWindow("sj_lobby_select_noItemBattle"):setEnabled(false)
			winMgr:getWindow("sj_lobby_select_ItemBattle"):setEnabled(true)
			--winMgr:getWindow("sj_lobby_select_exceptEImage"):setVisible(false)
			--winMgr:getWindow("sj_lobby_select_exceptECheckbox"):setVisible(false)
		end
	elseif IsThaiLanguage() or IsEngLanguage() or IsGSPLanguage() then----0421KSG
		if GetLadderLimitChannel() == 1 then
			--winMgr:getWindow("sj_lobby_select_exceptEImage"):setPosition(28, 340)
			--winMgr:getWindow("sj_lobby_select_exceptECheckbox"):setPosition(9, 341)
			
			winMgr:getWindow("Lobby_Ladder_Limit_Image"):setVisible(false)
			winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setVisible(false)
			winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setProperty("Selected", "false")
		else
			winMgr:getWindow("Lobby_Ladder_Limit_Image"):setVisible(true)
			winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setVisible(true)
			winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setProperty("Selected", "false")
		end
		
		winMgr:getWindow("sj_lobby_select_noItemBattle"):setEnabled(true)
		winMgr:getWindow("sj_lobby_select_ItemBattle"):setEnabled(true)
		
		--winMgr:getWindow("sj_lobby_select_exceptEImage"):setVisible(true)
		--winMgr:getWindow("sj_lobby_select_exceptECheckbox"):setVisible(true)
		--winMgr:getWindow("sj_lobby_select_exceptECheckbox"):setProperty("Selected", "false")
	else
		--winMgr:getWindow("sj_lobby_select_exceptEImage"):setPosition(28, 340)
		--winMgr:getWindow("sj_lobby_select_exceptECheckbox"):setPosition(9, 341)
			
		winMgr:getWindow("Lobby_Ladder_Limit_Image"):setVisible(false)
		winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setVisible(false)
		winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setProperty("Selected", "false")
		
		winMgr:getWindow("sj_lobby_select_noItemBattle"):setEnabled(true)
		winMgr:getWindow("sj_lobby_select_ItemBattle"):setEnabled(true)
		
		--winMgr:getWindow("sj_lobby_select_exceptEImage"):setVisible(true)
		--winMgr:getWindow("sj_lobby_select_exceptECheckbox"):setVisible(true)
		--winMgr:getWindow("sj_lobby_select_exceptECheckbox"):setProperty("Selected", "false")
	end
	
	winMgr:getWindow("sj_lobby_select_ClassBattle"):setEnabled(true)

	winMgr:getWindow("sj_lobby_select_privateBattle"):setProperty("Selected", "false")
	winMgr:getWindow("sj_lobby_select_teamBattle"):setProperty("Selected", "true")
	winMgr:getWindow("sj_lobby_select_noItemBattle"):setProperty("Selected", "false")
	winMgr:getWindow("sj_lobby_select_ItemBattle"):setProperty("Selected", "true")
	winMgr:getWindow("sj_lobby_select_ClassBattle"):setProperty("Selected", "false")
end

function ClubDeathGameMode(args)
	local EnterWindow = CEGUI.toWindowEventArgs(args).window:getUserString("Index")
	local WindowNum	  = tonumber(EnterWindow)
	
	SetLobbyMatchText(tMatchModeName[WindowNum])
			
	nMaxUser = 8
	nGameMode = 0
	bTeam = true
	bItem = PLAYTYPE_ITEM
	ChangeUser()
	
	winMgr:getWindow("sj_lobby_select_autobalanceImage"):setVisible(false)
	winMgr:getWindow("sj_lobby_select_autobalanceCheckbox"):setVisible(false)
		
	InitLadderType()
	
	winMgr:getWindow("sj_lobby_select_privateBattle"):setEnabled(false)
	winMgr:getWindow("sj_lobby_select_teamBattle"):setEnabled(true)
	
	if IsKoreanLanguage() then
		winMgr:getWindow("Lobby_Ladder_Limit_Image"):setVisible(false)
		winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setVisible(false)
		winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setProperty("Selected", "false")
				
		winMgr:getWindow("sj_lobby_select_noItemBattle"):setEnabled(true)
		winMgr:getWindow("sj_lobby_select_ItemBattle"):setEnabled(true)
		--winMgr:getWindow("sj_lobby_select_exceptEImage"):setVisible(true)
		--winMgr:getWindow("sj_lobby_select_exceptECheckbox"):setVisible(true)
		--winMgr:getWindow("sj_lobby_select_exceptECheckbox"):setProperty("Selected", "false")
	elseif IsThaiLanguage() or IsEngLanguage() or IsGSPLanguage() then----0421KSG
		if GetLadderLimitChannel() == 1 then
			--winMgr:getWindow("sj_lobby_select_exceptEImage"):setPosition(28, 340)
			--winMgr:getWindow("sj_lobby_select_exceptECheckbox"):setPosition(9, 341)
			
			winMgr:getWindow("Lobby_Ladder_Limit_Image"):setVisible(false)
			winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setVisible(false)
			winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setProperty("Selected", "false")
		else
			winMgr:getWindow("Lobby_Ladder_Limit_Image"):setVisible(true)
			winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setVisible(true)
			winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setProperty("Selected", "false")
		end
		
		winMgr:getWindow("sj_lobby_select_noItemBattle"):setEnabled(true)
		winMgr:getWindow("sj_lobby_select_ItemBattle"):setEnabled(true)
		
		--winMgr:getWindow("sj_lobby_select_exceptEImage"):setVisible(true)
		--winMgr:getWindow("sj_lobby_select_exceptECheckbox"):setVisible(true)
		--winMgr:getWindow("sj_lobby_select_exceptECheckbox"):setProperty("Selected", "false")
	else
		--winMgr:getWindow("sj_lobby_select_exceptEImage"):setPosition(28, 340)
		--winMgr:getWindow("sj_lobby_select_exceptECheckbox"):setPosition(9, 341)
			
		winMgr:getWindow("Lobby_Ladder_Limit_Image"):setVisible(false)
		winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setVisible(false)
		winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setProperty("Selected", "false")
		
		winMgr:getWindow("sj_lobby_select_noItemBattle"):setEnabled(true)
		winMgr:getWindow("sj_lobby_select_ItemBattle"):setEnabled(true)
		
		--winMgr:getWindow("sj_lobby_select_exceptEImage"):setVisible(true)
		--winMgr:getWindow("sj_lobby_select_exceptECheckbox"):setVisible(true)
		--winMgr:getWindow("sj_lobby_select_exceptECheckbox"):setProperty("Selected", "false")
	end
	
	winMgr:getWindow("sj_lobby_select_ClassBattle"):setEnabled(true)

	winMgr:getWindow("sj_lobby_select_privateBattle"):setProperty("Selected", "false")
	winMgr:getWindow("sj_lobby_select_teamBattle"):setProperty("Selected", "true")
	winMgr:getWindow("sj_lobby_select_noItemBattle"):setProperty("Selected", "false")
	winMgr:getWindow("sj_lobby_select_ItemBattle"):setProperty("Selected", "true")
	winMgr:getWindow("sj_lobby_select_ClassBattle"):setProperty("Selected", "false")
end

function ClubDuelGameMode(args)
	if GetIsMyMasterLadder() == 0 and IsKoreanLanguage() then
		ShowCommonAlertOkBoxWithFunction("레더 6이상만 참여 가능합니다.", 'OnClickAlertOkSelfHide')
		DropDownButtonInit()
		return
	end
	
	local EnterWindow = CEGUI.toWindowEventArgs(args).window:getUserString("Index")
	local WindowNum	  = tonumber(EnterWindow)
	
	SetLobbyMatchText(tLanguageModeName[LANGUAGECODE][1])
	
	nMaxUser = 8
	nGameMode = 8	-- 듀얼매치
	bTeam = true
	bItem = PLAYTYPE_NOITEM
	ChangeUser()
	InitLadderType()
	
	if IsThaiLanguage() or IsEngLanguage() or IsGSPLanguage() then----0421KSG
		if GetLadderLimitChannel() == 1 then
			--winMgr:getWindow("sj_lobby_select_exceptEImage"):setPosition(28, 340)
			--winMgr:getWindow("sj_lobby_select_exceptECheckbox"):setPosition(9, 341)
			
			winMgr:getWindow("Lobby_Ladder_Limit_Image"):setVisible(false)
			winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setVisible(false)
			winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setProperty("Selected", "false")
		else
			winMgr:getWindow("Lobby_Ladder_Limit_Image"):setVisible(true)
			winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setVisible(true)
			winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setProperty("Selected", "false")
		end
	else
		--winMgr:getWindow("sj_lobby_select_exceptEImage"):setPosition(28, 340)
		--winMgr:getWindow("sj_lobby_select_exceptECheckbox"):setPosition(9, 341)
			
		winMgr:getWindow("Lobby_Ladder_Limit_Image"):setVisible(false)
		winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setVisible(false)
		winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setProperty("Selected", "false")
	end
	
	--winMgr:getWindow("sj_lobby_select_exceptEImage"):setVisible(false)
	--winMgr:getWindow("sj_lobby_select_exceptECheckbox"):setVisible(false)
	--winMgr:getWindow("sj_lobby_select_exceptECheckbox"):setProperty("Selected", "false")
	
	winMgr:getWindow("sj_lobby_select_privateBattle"):setEnabled(false)
	winMgr:getWindow("sj_lobby_select_teamBattle"):setEnabled(true)
	
	winMgr:getWindow("sj_lobby_select_noItemBattle"):setEnabled(true)
	winMgr:getWindow("sj_lobby_select_ItemBattle"):setEnabled(false)
	winMgr:getWindow("sj_lobby_select_ClassBattle"):setEnabled(false)
	
	winMgr:getWindow("sj_lobby_select_privateBattle"):setProperty("Selected", "false")
	winMgr:getWindow("sj_lobby_select_teamBattle"):setProperty("Selected", "true")
	winMgr:getWindow("sj_lobby_select_noItemBattle"):setProperty("Selected", "true")
	winMgr:getWindow("sj_lobby_select_ItemBattle"):setProperty("Selected", "false")
	
	winMgr:getWindow("sj_lobby_select_autobalanceImage"):setVisible(false)
	winMgr:getWindow("sj_lobby_select_autobalanceCheckbox"):setVisible(false)
end

function DuelGameMode(args)
	if GetIsMyMasterLadder() == 0 and IsKoreanLanguage() then
		ShowCommonAlertOkBoxWithFunction("레더 6이상만 참여 가능합니다.", 'OnClickAlertOkSelfHide')
		DropDownButtonInit()
		return
	end
	
	local EnterWindow = CEGUI.toWindowEventArgs(args).window:getUserString("Index")
	local WindowNum	  = tonumber(EnterWindow)
	
	SetLobbyMatchText(tLanguageModeName[LANGUAGECODE][WindowNum])
	
	nMaxUser = 8
	nGameMode = 8	-- 듀얼매치
	bTeam = true
	bItem = PLAYTYPE_NOITEM
	ChangeUser()
	ChangeAutoBalance()
	InitLadderType()
	
	if IsThaiLanguage() or IsEngLanguage() or IsGSPLanguage() then----0421KSG
		if GetLadderLimitChannel() == 1 then
			--winMgr:getWindow("sj_lobby_select_exceptEImage"):setPosition(28, 340)
			--winMgr:getWindow("sj_lobby_select_exceptECheckbox"):setPosition(9, 341)
			
			winMgr:getWindow("Lobby_Ladder_Limit_Image"):setVisible(false)
			winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setVisible(false)
			winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setProperty("Selected", "false")
		else
			winMgr:getWindow("Lobby_Ladder_Limit_Image"):setVisible(true)
			winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setVisible(true)
			winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setProperty("Selected", "false")
		end
	else
		--winMgr:getWindow("sj_lobby_select_exceptEImage"):setPosition(28, 340)
		--winMgr:getWindow("sj_lobby_select_exceptECheckbox"):setPosition(9, 341)
			
		winMgr:getWindow("Lobby_Ladder_Limit_Image"):setVisible(false)
		winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setVisible(false)
		winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setProperty("Selected", "false")
	end
	
	--winMgr:getWindow("sj_lobby_select_exceptEImage"):setVisible(false)
	--winMgr:getWindow("sj_lobby_select_exceptECheckbox"):setVisible(false)
	--winMgr:getWindow("sj_lobby_select_exceptECheckbox"):setProperty("Selected", "false")
	
	winMgr:getWindow("sj_lobby_select_privateBattle"):setEnabled(false)
	winMgr:getWindow("sj_lobby_select_teamBattle"):setEnabled(true)
	
	winMgr:getWindow("sj_lobby_select_noItemBattle"):setEnabled(true)
	winMgr:getWindow("sj_lobby_select_ItemBattle"):setEnabled(false)
	winMgr:getWindow("sj_lobby_select_ClassBattle"):setEnabled(false)
	
	winMgr:getWindow("sj_lobby_select_privateBattle"):setProperty("Selected", "false")
	winMgr:getWindow("sj_lobby_select_teamBattle"):setProperty("Selected", "true")
	winMgr:getWindow("sj_lobby_select_noItemBattle"):setProperty("Selected", "true")
	winMgr:getWindow("sj_lobby_select_ItemBattle"):setProperty("Selected", "false")
end

function SurvivalGameMode(args)
	local EnterWindow = CEGUI.toWindowEventArgs(args).window:getUserString("Index")
	local WindowNum	  = tonumber(EnterWindow)
	
	SetLobbyMatchText(tLanguageModeName[LANGUAGECODE][2])
	
	nMaxUser = 8
	nGameMode = 6	-- 몬스터 레이싱
	bTeam = true
	bItem = PLAYTYPE_ITEM
	ChangeUser()
	ChangeAutoBalance()
	InitLadderType()
	
	if IsThaiLanguage() or IsEngLanguage() or IsGSPLanguage() then----0421KSG
		if GetLadderLimitChannel() == 1 then
			--winMgr:getWindow("sj_lobby_select_exceptEImage"):setPosition(28, 340)
			--winMgr:getWindow("sj_lobby_select_exceptECheckbox"):setPosition(9, 341)
			
			winMgr:getWindow("Lobby_Ladder_Limit_Image"):setVisible(false)
			winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setVisible(false)
			winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setProperty("Selected", "false")
		else
			winMgr:getWindow("Lobby_Ladder_Limit_Image"):setVisible(true)
			winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setVisible(true)
			winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setProperty("Selected", "false")
		end
	else
		--winMgr:getWindow("sj_lobby_select_exceptEImage"):setPosition(28, 340)
		--winMgr:getWindow("sj_lobby_select_exceptECheckbox"):setPosition(9, 341)
			
		winMgr:getWindow("Lobby_Ladder_Limit_Image"):setVisible(false)
		winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setVisible(false)
		winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setProperty("Selected", "false")
	end
	
	--winMgr:getWindow("sj_lobby_select_exceptEImage"):setVisible(true)
	--winMgr:getWindow("sj_lobby_select_exceptECheckbox"):setVisible(true)
	--winMgr:getWindow("sj_lobby_select_exceptECheckbox"):setProperty("Selected", "false")
	
	winMgr:getWindow("sj_lobby_select_privateBattle"):setEnabled(false)
	winMgr:getWindow("sj_lobby_select_teamBattle"):setEnabled(true)
	
	winMgr:getWindow("sj_lobby_select_noItemBattle"):setEnabled(true)
	winMgr:getWindow("sj_lobby_select_ItemBattle"):setEnabled(true)
	winMgr:getWindow("sj_lobby_select_ClassBattle"):setEnabled(false)
	
	winMgr:getWindow("sj_lobby_select_privateBattle"):setProperty("Selected", "false")
	winMgr:getWindow("sj_lobby_select_teamBattle"):setProperty("Selected", "true")
	winMgr:getWindow("sj_lobby_select_noItemBattle"):setProperty("Selected", "false")
	winMgr:getWindow("sj_lobby_select_ItemBattle"):setProperty("Selected", "true")
end

function CoinGameMode(args)
	local EnterWindow = CEGUI.toWindowEventArgs(args).window:getUserString("Index")
	local WindowNum	  = tonumber(EnterWindow)
	
	SetLobbyMatchText(tLanguageModeName[LANGUAGECODE][3])
	
	nMaxUser = 8
	nGameMode = 11	--코인전
	bTeam = true
	bItem = PLAYTYPE_NOITEM
	ChangeUser()
	ChangeAutoBalance()
	InitLadderType()
	
	if IsThaiLanguage()  or IsEngLanguage() or IsGSPLanguage() then----0421KSG
		if GetLadderLimitChannel() == 1 then
			--winMgr:getWindow("sj_lobby_select_exceptEImage"):setPosition(28, 340)
			--winMgr:getWindow("sj_lobby_select_exceptECheckbox"):setPosition(9, 341)
			
			winMgr:getWindow("Lobby_Ladder_Limit_Image"):setVisible(false)
			winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setVisible(false)
			winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setProperty("Selected", "false")
		else
			winMgr:getWindow("Lobby_Ladder_Limit_Image"):setVisible(true)
			winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setVisible(true)
			winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setProperty("Selected", "false")
		end
	else
		--winMgr:getWindow("sj_lobby_select_exceptEImage"):setPosition(28, 340)
		--winMgr:getWindow("sj_lobby_select_exceptECheckbox"):setPosition(9, 341)
			
		winMgr:getWindow("Lobby_Ladder_Limit_Image"):setVisible(false)
		winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setVisible(false)
		winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setProperty("Selected", "false")
	end
	
	--winMgr:getWindow("sj_lobby_select_exceptEImage"):setVisible(false)
	--winMgr:getWindow("sj_lobby_select_exceptECheckbox"):setVisible(false)
	--winMgr:getWindow("sj_lobby_select_exceptECheckbox"):setProperty("Selected", "false")
	
	winMgr:getWindow("sj_lobby_select_privateBattle"):setEnabled(true)
	winMgr:getWindow("sj_lobby_select_teamBattle"):setEnabled(true)
	
	winMgr:getWindow("sj_lobby_select_noItemBattle"):setEnabled(true)
	winMgr:getWindow("sj_lobby_select_ItemBattle"):setEnabled(false)
	winMgr:getWindow("sj_lobby_select_ClassBattle"):setEnabled(false)
	
	winMgr:getWindow("sj_lobby_select_privateBattle"):setProperty("Selected", "false")
	winMgr:getWindow("sj_lobby_select_teamBattle"):setProperty("Selected", "true")
	winMgr:getWindow("sj_lobby_select_noItemBattle"):setProperty("Selected", "true")
	winMgr:getWindow("sj_lobby_select_ItemBattle"):setProperty("Selected", "false")
end

function BombGameMode(args)
	
	local EnterWindow = CEGUI.toWindowEventArgs(args).window:getUserString("Index")
	local WindowNum	  = tonumber(EnterWindow)
	
	SetLobbyMatchText("Bomb Battle")
	
	nMaxUser = 8
	nGameMode = 0
	bTeam = true
	bItem = 3
	ChangeUser()
	ChangeAutoBalance()
	InitLadderType()
	
	if IsThaiLanguage() or IsEngLanguage() or IsGSPLanguage() then----0421KSG
		if GetLadderLimitChannel() == 1 then
			--winMgr:getWindow("sj_lobby_select_exceptEImage"):setPosition(28, 340)
			--winMgr:getWindow("sj_lobby_select_exceptECheckbox"):setPosition(9, 341)
			
			winMgr:getWindow("Lobby_Ladder_Limit_Image"):setVisible(false)
			winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setVisible(false)
			winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setProperty("Selected", "false")
		else
			winMgr:getWindow("Lobby_Ladder_Limit_Image"):setVisible(true)
			winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setVisible(true)
			winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setProperty("Selected", "false")
		end
	else
		--winMgr:getWindow("sj_lobby_select_exceptEImage"):setPosition(28, 340)
		--winMgr:getWindow("sj_lobby_select_exceptECheckbox"):setPosition(9, 341)
			
		winMgr:getWindow("Lobby_Ladder_Limit_Image"):setVisible(false)
		winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setVisible(false)
		winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setProperty("Selected", "false")
	end
	
	--winMgr:getWindow("sj_lobby_select_exceptEImage"):setVisible(false)
	--winMgr:getWindow("sj_lobby_select_exceptECheckbox"):setVisible(false)
	--winMgr:getWindow("sj_lobby_select_exceptECheckbox"):setProperty("Selected", "false")
	
	winMgr:getWindow("sj_lobby_select_privateBattle"):setEnabled(false)
	winMgr:getWindow("sj_lobby_select_teamBattle"):setEnabled(true)
	
	winMgr:getWindow("sj_lobby_select_noItemBattle"):setEnabled(false)
	winMgr:getWindow("sj_lobby_select_ItemBattle"):setEnabled(true)
	winMgr:getWindow("sj_lobby_select_ClassBattle"):setEnabled(false)
	
	winMgr:getWindow("sj_lobby_select_privateBattle"):setProperty("Selected", "false")
	winMgr:getWindow("sj_lobby_select_teamBattle"):setProperty("Selected", "true")
	winMgr:getWindow("sj_lobby_select_noItemBattle"):setProperty("Selected", "false")
	winMgr:getWindow("sj_lobby_select_ItemBattle"):setProperty("Selected", "true")
end

function MiniTowerGameMode(args)
	
	local EnterWindow = CEGUI.toWindowEventArgs(args).window:getUserString("Index")
	local WindowNum	  = tonumber(EnterWindow)
	
	SetLobbyMatchText("Tower Battle")--tLanguageModeName[LANGUAGECODE][5])
	
	nMaxUser = 8
	nGameMode = 0
	bTeam = true
	bItem = PLAYTYPE_MINITOWER_ITEM
	ChangeUser()
	ChangeAutoBalance()
	InitLadderType()
	
	if IsThaiLanguage() or IsEngLanguage() or IsGSPLanguage() then----0421KSG
		if GetLadderLimitChannel() == 1 then
			--winMgr:getWindow("sj_lobby_select_exceptEImage"):setPosition(28, 340)
			--winMgr:getWindow("sj_lobby_select_exceptECheckbox"):setPosition(9, 341)
			
			winMgr:getWindow("Lobby_Ladder_Limit_Image"):setVisible(false)
			winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setVisible(false)
			winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setProperty("Selected", "false")
		else
			winMgr:getWindow("Lobby_Ladder_Limit_Image"):setVisible(true)
			winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setVisible(true)
			winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setProperty("Selected", "false")
		end
	else
		--winMgr:getWindow("sj_lobby_select_exceptEImage"):setPosition(28, 340)
		--winMgr:getWindow("sj_lobby_select_exceptECheckbox"):setPosition(9, 341)
			
		winMgr:getWindow("Lobby_Ladder_Limit_Image"):setVisible(false)
		winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setVisible(false)
		winMgr:getWindow("Lobby_Ladder_Limit_SelectBox"):setProperty("Selected", "false")
	end
	
	--winMgr:getWindow("sj_lobby_select_exceptEImage"):setVisible(true)
	--winMgr:getWindow("sj_lobby_select_exceptECheckbox"):setVisible(true)
	--winMgr:getWindow("sj_lobby_select_exceptECheckbox"):setProperty("Selected", "false")
	
	winMgr:getWindow("sj_lobby_select_privateBattle"):setEnabled(false)
	winMgr:getWindow("sj_lobby_select_teamBattle"):setEnabled(true)
	
	winMgr:getWindow("sj_lobby_select_noItemBattle"):setEnabled(true)
	winMgr:getWindow("sj_lobby_select_ItemBattle"):setEnabled(true)
	winMgr:getWindow("sj_lobby_select_ClassBattle"):setEnabled(false)
	
	winMgr:getWindow("sj_lobby_select_privateBattle"):setProperty("Selected", "false")
	winMgr:getWindow("sj_lobby_select_teamBattle"):setProperty("Selected", "true")
	winMgr:getWindow("sj_lobby_select_noItemBattle"):setProperty("Selected", "false")
	winMgr:getWindow("sj_lobby_select_ItemBattle"):setProperty("Selected", "true")
end

local ZOMBIEFILENAMELIST = {["err"]=0, }
local ZOMBIEFILENAMEMAX  = 10

function ZombieFileNameStting(Index, FileName)
	if Index == 10 then
		return
	end
	
	table.insert(ZOMBIEFILENAMELIST, Index, FileName)
end

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ZombieDefenceFileNameBackImage")
mywindow:setTexture("Enabled", "UIData/Profile001.tga", 806, 569)
mywindow:setTexture("Disabled", "UIData/Profile001.tga", 806, 569)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(70, 80)
mywindow:setSize(218, 308)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

for i=0, ZOMBIEFILENAMEMAX - 1 do
	mywindow = winMgr:createWindow("TaharezLook/Button",	"ZombieDefenceFileNameBtn"..i)
	mywindow:setTexture("Normal", "UIData/profile001.tga",		513, 763)    
	mywindow:setTexture("Hover", "UIData/profile001.tga",		513, 786)
	mywindow:setTexture("Pushed", "UIData/profile001.tga",		513, 809)
	mywindow:setTexture("PushedOff", "UIData/profile001.tga",	513, 763)
	mywindow:setTexture("Disabled", "UIData/profile001.tga",		513, 763)
	mywindow:setSize(195, 23)
	mywindow:setPosition(12, 50+24*(i-1))
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:setVisible(true)
	mywindow:setUserString("Index", i)
	mywindow:setSubscribeEvent("MouseButtonDown",		 "ZombieFileListClose")
	winMgr:getWindow("ZombieDefenceFileNameBackImage"):addChildWindow(mywindow)

	mywindow = winMgr:createWindow("TaharezLook/StaticText", "ZombieDefenceFileNameText"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(10, 2)
	mywindow:setSize(30, 20)
	mywindow:setText("")
	mywindow:setProperty("Disabled", "true")
	mywindow:setVisible(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("ZombieDefenceFileNameBtn"..i):addChildWindow(mywindow)
end

function ZombieFileListClose(args)
	ZOMBIEFILENUM = CEGUI.toWindowEventArgs(args).window:getUserString("Index")
	
	winMgr:getWindow("ZombieDefenceFileNameBackImage"):setVisible(false)
	ZombieTestRoomStart()
end

function ZombieGameMode(args)
	local EnterWindow = CEGUI.toWindowEventArgs(args).window:getUserString("Index")
	local WindowNum	  = tonumber(EnterWindow)
	
	SetLobbyMatchText(tLanguageModeName[LANGUAGECODE][WindowNum])
	
	for i = 0, #ZOMBIEFILENAMELIST do
		winMgr:getWindow("ZombieDefenceFileNameText"..i):setText(ZOMBIEFILENAMELIST[i])
	end
	
	winMgr:getWindow("ZombieDefenceFileNameBackImage"):setVisible(true)
	
	DropDownButtonInit()
	
	nMaxUser = 4
	nGameMode = 10
	bTeam = false
	bItem = PLAYTYPE_NOITEM
	
	--winMgr:getWindow("sj_lobby_select_exceptEImage"):setVisible(false)
	--winMgr:getWindow("sj_lobby_select_exceptECheckbox"):setVisible(false)
	winMgr:getWindow("sj_lobby_select_exceptECheckbox"):setProperty("Selected", "false")
	
	winMgr:getWindow("sj_lobby_select_privateBattle"):setEnabled(false)
	winMgr:getWindow("sj_lobby_select_teamBattle"):setEnabled(false)
	
	winMgr:getWindow("sj_lobby_select_noItemBattle"):setEnabled(false)
	winMgr:getWindow("sj_lobby_select_ItemBattle"):setEnabled(false)
	winMgr:getWindow("sj_lobby_select_ClassBattle"):setEnabled(false)
	
	winMgr:getWindow("sj_lobby_select_privateBattle"):setProperty("Selected", "false")
	winMgr:getWindow("sj_lobby_select_teamBattle"):setProperty("Selected", "false")
	winMgr:getWindow("sj_lobby_select_noItemBattle"):setProperty("Selected", "false")
	winMgr:getWindow("sj_lobby_select_ItemBattle"):setProperty("Selected", "false")
end

-- 좀비 연습 모드 테스트 함수--------------------------------------------
function ZombieTestRoomCrate()
	for i = 0, #ZOMBIEFILENAMELIST do
		winMgr:getWindow("ZombieDefenceFileNameText"..i):setText(ZOMBIEFILENAMELIST[i])
	end
	
	winMgr:getWindow("ZombieDefenceFileNameBackImage"):setVisible(true)
end

function ZombieTestRoomStart()
	nMaxUser = 4
	nGameMode = 10
	bTeam = false
	bItem = PLAYTYPE_NOITEM
	
	MakeRoom_OK()
end
-----------------------------------------------------------------------
function InitGameMode()
--	winMgr:getWindow("Lobby_Select_Match0"):setProperty("Selected", "true")
end


-- 4. 개인전, 팀전
tMakeRoomName_teamMode = { ["protecterr"]=0, "sj_lobby_select_privateBattle", "sj_lobby_select_teamBattle" }
tMakeRoomPosX_teamMode = { ["protecterr"]=0, 108, 210 }
for i=1, 2 do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tMakeRoomName_teamMode[i])
	mywindow:setTexture("Normal", "UIData/popup001.tga", 440, 753)
	mywindow:setTexture("Hover", "UIData/popup001.tga", 440, 753)
	mywindow:setTexture("Pushed", "UIData/popup001.tga", 440, 772)
	mywindow:setTexture("PushedOff", "UIData/popup001.tga", 440, 753)
	mywindow:setTexture("SelectedNormal", "UIData/popup001.tga", 440, 772)
	mywindow:setTexture("SelectedHover", "UIData/popup001.tga", 440, 772)
	mywindow:setTexture("SelectedPushed", "UIData/popup001.tga", 440, 772)
	mywindow:setTexture("SelectedPushedOff", "UIData/popup001.tga", 440, 772)
	mywindow:setTexture("Enabled", "UIData/popup001.tga", 440, 753)
	mywindow:setTexture("Disabled", "UIData/popup001.tga", 440, 791)
	mywindow:setPosition(tMakeRoomPosX_teamMode[i], 212)
	mywindow:setSize(78, 19)
	if g_BattleMode == BATTLETYPE_GUILD_BATTLE then
		if i == 1 then
			mywindow:setEnabled(false)
		end
	end
	mywindow:setZOrderingEnabled(false)
	mywindow:setProperty("GroupID", 1620)
	mywindow:subscribeEvent("SelectStateChanged", "SelectIsTeamBattle")
	makeroomwindow:addChildWindow(mywindow)
end

tTeamNum	= { ["protecterr"]=0, [4]=882, [6]=910, [8]=938 }
tSingleNum	= { ["protecterr"]=0, 0, 826, 854, 882, 910, 938, 966, 994 }
function ChangeUser()
	if bTeam == true then
		winMgr:getWindow("sj_lobby_select_userNum"):setTexture("Disabled", "UIData/battleroom001.tga", 680, tTeamNum[nMaxUser])
	else
		winMgr:getWindow("sj_lobby_select_userNum"):setTexture("Disabled", "UIData/battleroom001.tga", 574, tSingleNum[nMaxUser])
	end
end


function SelectIsTeamBattle()
	if CEGUI.toRadioButton(winMgr:getWindow("sj_lobby_select_privateBattle")):isSelected() then	
		bTeam = false	
	elseif CEGUI.toRadioButton(winMgr:getWindow("sj_lobby_select_teamBattle")):isSelected() then	
		bTeam = true
	end
		
	nMaxUser = 8
	ChangeUser()
	ChangeAutoBalance()
end

function InitTeamBattle()
	winMgr:getWindow("sj_lobby_select_teamBattle"):setProperty("Selected", "true")
end


-- 5. 노템전, 아이템전
tMakeRoomName_BattleType = { ["protecterr"]=0, "sj_lobby_select_noItemBattle", "sj_lobby_select_ItemBattle", "sj_lobby_select_ClassBattle" }
tMakeRoomPosX_BattleType = { ["protecterr"]=0, 108, 210, 108 }
tMakeRoomPosY_BattleType = { ["protecterr"]=0, 247, 247, 278 }
for i=1, #tMakeRoomName_BattleType do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tMakeRoomName_BattleType[i])
	mywindow:setTexture("Normal", "UIData/popup001.tga", 440, 753)
	mywindow:setTexture("Hover", "UIData/popup001.tga", 440, 753)
	mywindow:setTexture("Pushed", "UIData/popup001.tga", 440, 772)
	mywindow:setTexture("PushedOff", "UIData/popup001.tga", 440, 753)
	mywindow:setTexture("SelectedNormal", "UIData/popup001.tga", 440, 772)
	mywindow:setTexture("SelectedHover", "UIData/popup001.tga", 440, 772)
	mywindow:setTexture("SelectedPushed", "UIData/popup001.tga", 440, 772)
	mywindow:setTexture("SelectedPushedOff", "UIData/popup001.tga", 440, 772)
	mywindow:setTexture("Enabled", "UIData/popup001.tga", 440, 753)
	mywindow:setTexture("Disabled", "UIData/popup001.tga", 440, 791)
	mywindow:setPosition(tMakeRoomPosX_BattleType[i], tMakeRoomPosY_BattleType[i])
	mywindow:setSize(78, 19)
	mywindow:setZOrderingEnabled(false)
	mywindow:setProperty("GroupID", 1630)
	mywindow:subscribeEvent("SelectStateChanged", "SelectIsItem")
	makeroomwindow:addChildWindow(mywindow)
	
	if IsKoreanLanguage() then
		if i == 1 then
			mywindow:setVisible(false)
			mywindow:setEnabled(false)
			--mywindow:setVisible(true)
			--if GetIsCurrentLadderChannel() == 1 then
			--	mywindow:setEnabled(true)
			--else
			--	mywindow:setEnabled(false)
			--end
			
			--if g_BattleMode == BATTLETYPE_GUILD_BATTLE then
			--	mywindow:setEnabled(true)
			--end
		elseif i == 2 then
			mywindow:setVisible(true)
		elseif i == 3 then
			mywindow:setVisible(false)
			mywindow:setEnabled(false)
		end
	end
end

function SelectIsItem()

	if bItem == PLAYTYPE_MINITOWER_NOITEM or bItem == PLAYTYPE_MINITOWER_ITEM then
		if CEGUI.toRadioButton(winMgr:getWindow("sj_lobby_select_noItemBattle")):isSelected() then
			bItem = PLAYTYPE_MINITOWER_NOITEM
		elseif CEGUI.toRadioButton(winMgr:getWindow("sj_lobby_select_ItemBattle")):isSelected() then
			bItem = PLAYTYPE_MINITOWER_ITEM
		end
	else
		if CEGUI.toRadioButton(winMgr:getWindow("sj_lobby_select_noItemBattle")):isSelected() then
			bItem = PLAYTYPE_NOITEM
		elseif CEGUI.toRadioButton(winMgr:getWindow("sj_lobby_select_ItemBattle")):isSelected() then
			bItem = PLAYTYPE_ITEM
		elseif CEGUI.toRadioButton(winMgr:getWindow("sj_lobby_select_ClassBattle")):isSelected() then
			bItem = PLAYTYPE_CLASS
		end
	end
end

function InitItemBattle()
	winMgr:getWindow("sj_lobby_select_ItemBattle"):setProperty("Selected", "true")
	winMgr:getWindow("sj_lobby_select_ClassBattle"):setEnabled(true)
end



-- 5. 래더, 친선(한국만)
tMakeRoomName_ladderType = { ["protecterr"]=0, "sj_lobby_select_EnableLadder", "sj_lobby_select_DisableLadder" }
tMakeRoomPosX_ladderType = { ["protecterr"]=0, 108, 210 }
tMakeRoomPosY_ladderType = { ["protecterr"]=0, 283, 283 }
for i=1, #tMakeRoomName_ladderType do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tMakeRoomName_ladderType[i])
	mywindow:setTexture("Normal", "UIData/popup001.tga", 440, 753)
	mywindow:setTexture("Hover", "UIData/popup001.tga", 440, 753)
	mywindow:setTexture("Pushed", "UIData/popup001.tga", 440, 772)
	mywindow:setTexture("PushedOff", "UIData/popup001.tga", 440, 753)
	mywindow:setTexture("SelectedNormal", "UIData/popup001.tga", 440, 772)
	mywindow:setTexture("SelectedHover", "UIData/popup001.tga", 440, 772)
	mywindow:setTexture("SelectedPushed", "UIData/popup001.tga", 440, 772)
	mywindow:setTexture("SelectedPushedOff", "UIData/popup001.tga", 440, 772)
	mywindow:setTexture("Enabled", "UIData/popup001.tga", 440, 753)
	mywindow:setTexture("Disabled", "UIData/popup001.tga", 440, 791)
	mywindow:setPosition(tMakeRoomPosX_ladderType[i], tMakeRoomPosY_ladderType[i])
	mywindow:setSize(78, 19)
	mywindow:setZOrderingEnabled(false)
	mywindow:setProperty("GroupID", 1631)
	mywindow:subscribeEvent("SelectStateChanged", "SelectIsLadderType")
	makeroomwindow:addChildWindow(mywindow)
	
	if IsKoreanLanguage() then
		mywindow:setVisible(true)
	else
		mywindow:setVisible(false)
	end
end

function SelectIsLadderType()
	if CEGUI.toRadioButton(winMgr:getWindow("sj_lobby_select_EnableLadder")):isSelected() then
		bLadderType = true
	elseif CEGUI.toRadioButton(winMgr:getWindow("sj_lobby_select_DisableLadder")):isSelected() then
		bLadderType = false
	end
end

function InitLadderType()
	if IsKoreanLanguage() then
		if GetIsCurrentLadderChannel() == 1 then
			bLadderType = true
			winMgr:getWindow("sj_lobby_select_EnableLadder"):setVisible(true)
			winMgr:getWindow("sj_lobby_select_DisableLadder"):setVisible(true)
			winMgr:getWindow("sj_lobby_select_EnableLadder"):setEnabled(true)
			winMgr:getWindow("sj_lobby_select_DisableLadder"):setEnabled(true)
			winMgr:getWindow("sj_lobby_select_EnableLadder"):setProperty("Selected", "true")
		else
			bLadderType = false
			winMgr:getWindow("sj_lobby_select_EnableLadder"):setVisible(true)
			winMgr:getWindow("sj_lobby_select_DisableLadder"):setVisible(true)
			winMgr:getWindow("sj_lobby_select_EnableLadder"):setEnabled(false)
			winMgr:getWindow("sj_lobby_select_DisableLadder"):setEnabled(false)
			--winMgr:getWindow("sj_lobby_select_DisableLadder"):setProperty("Selected", "true")
		end
	else
		bLadderType = false
		winMgr:getWindow("sj_lobby_select_EnableLadder"):setVisible(false)
		winMgr:getWindow("sj_lobby_select_DisableLadder"):setVisible(false)
		winMgr:getWindow("sj_lobby_select_DisableLadder"):setProperty("Selected", "true")
	end
end



-- 6. 인원설정
tLRButtonName  = { ["err"]=0, "sj_lobby_select_userNum_LBtn", "sj_lobby_select_userNum_RBtn" }
tLRButtonTexX  = { ["err"]=0, 987, 970 }
tLRButtonPosX  = { ["err"]=0, 128, 264 }
tLRButtonEvent = { ["err"]=0, "ChangeLUserNum", "ChangeRUserNum" }
for i=1, 2 do
	mywindow = winMgr:createWindow("TaharezLook/Button", tLRButtonName[i])
	mywindow:setTexture("Normal", "UIData/myinfo.tga", tLRButtonTexX[i], 0)
	mywindow:setTexture("Hover", "UIData/myinfo.tga", tLRButtonTexX[i], 22)
	mywindow:setTexture("Pushed", "UIData/myinfo.tga", tLRButtonTexX[i], 44)
	mywindow:setTexture("PushedOff", "UIData/myinfo.tga", tLRButtonTexX[i], 0)
	
	if IsThaiLanguage() or IsEngLanguage() or IsGSPLanguage() then----0421KSG
		mywindow:setPosition(tLRButtonPosX[i], 392)
	else
		mywindow:setPosition(tLRButtonPosX[i], 380)
	end
	
	mywindow:setSize(17, 22)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", tLRButtonEvent[i])
	makeroomwindow:addChildWindow(mywindow)
end


mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_lobby_select_userNum")
mywindow:setTexture("Enabled", "UIData/battleroom001.tga", 680, 938)
mywindow:setTexture("Disabled", "UIData/battleroom001.tga", 680, 938)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")

if IsThaiLanguage() or IsEngLanguage() or IsGSPLanguage() then----0421KSG
	mywindow:setPosition(153, 389)
else
	mywindow:setPosition(154, 377)
end

mywindow:setSize(102, 26)
mywindow:setEnabled(false)
mywindow:setZOrderingEnabled(false)
makeroomwindow:addChildWindow(mywindow)


function ChangeLUserNum()
	local user = 0
	if nGameMode == 8 or bItem == 3 or bItem == PLAYTYPE_MINITOWER_ITEM or bItem == PLAYTYPE_MINITOWER_NOITEM then
		if nMaxUser == 6 then 
			user = 8
		else 
			user = nMaxUser - 2
		end
	else
		if bTeam == true then
			if nMaxUser == 4 then 
				user = 8
			else 
				user = nMaxUser - 2
			end
		else			
			if nMaxUser == 2 then 
				user = 8
			else
				user = nMaxUser - 1
			end
		end
	end
	
	nMaxUser = user
	ChangeUser()
end

function ChangeRUserNum()
	local user = 0
	if nGameMode == 8 or bItem == 3 or bItem == PLAYTYPE_MINITOWER_ITEM or bItem == PLAYTYPE_MINITOWER_NOITEM then
		if nMaxUser == 8 then 
			user = 6
		else 
			user = nMaxUser + 2
		end
	else
		if bTeam == true then
			if nMaxUser == 8 then 
				user = 4
			else 
				user = nMaxUser + 2
			end
		else
			if nMaxUser == 8 then 
				user = 2
			else 
				user = nMaxUser + 1
			end
		end
	end
	nMaxUser = user
	ChangeUser()
end

function InitUserNum()
	ChangeUser()
end



--------------------------------
-- 7. 익스트림 모드를 위한 추가 UI
--------------------------------

-- 익스트림 금액
g_extremeZenIndex = 0
tExtremeZenText = {['err']=0, [0]="100", "500", "1000", "3000", "5000", "10000"}
tExtremeZenPosY = {['err']=0, [0]=6,	31,		31 + ( 25 * 1 ),	31 + ( 25 * 2 ),	31 + ( 25 * 3 ),	31 + ( 25 * 4 )}

-- 익스트림 바탕 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_lobby_extreme_backImage")
mywindow:setTexture("Enabled", "UIData/option.tga", 673, 926)
mywindow:setTexture("Disabled", "UIData/option.tga", 673, 926)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(14, 420)
mywindow:setSize(309, 48)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setVisible(false)
makeroomwindow:addChildWindow(mywindow)

-- 익스트림 금액을 설정하기 위한 화살표
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_lobby_extreme_selectBtn")
mywindow:setTexture("Normal", "UIData/option.tga", 371, 310)
mywindow:setTexture("Hover", "UIData/option.tga", 399, 310)
mywindow:setTexture("Pushed", "UIData/option.tga", 427, 310)
mywindow:setTexture("PushedOff", "UIData/option.tga", 427, 310)
mywindow:setPosition(268, 12)
mywindow:setSize(25, 23)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickedExtremeZen")
winMgr:getWindow("sj_lobby_extreme_backImage"):addChildWindow(mywindow)

-- 선택된 익스트림 금액
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_lobby_extreme_selectedDesc")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setPosition(180, 17)
mywindow:setSize(90, 25)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:clearTextExtends()
mywindow:setTextExtends(tExtremeZenText[g_extremeZenIndex], g_STRING_FONT_GULIMCHE, 12, 255,255,255,255,   0, 255,255,255,255)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("sj_lobby_extreme_backImage"):addChildWindow(mywindow)

-- 아래로 라디오버튼을 넣기위한 투명공간
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_lobby_extreme_tempSpace")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(170, 450)
mywindow:setSize(140, 180)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
tempBackwindow:addChildWindow(mywindow)


-- ZEN을 설정하기 위해 클릭
function ClickedExtremeZen(args)
	if winMgr:getWindow("sj_lobby_extreme_tempSpace"):isVisible() then
		winMgr:getWindow("sj_lobby_extreme_tempSpace"):setVisible(false)
	else
		winMgr:getWindow("sj_lobby_extreme_tempSpace"):setVisible(true)
	end
end


for i=0, #tExtremeZenText do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", "sj_extreme_zen_"..i)
	mywindow:setTexture("Normal", "UIData/option.tga", 828, 975)
	mywindow:setTexture("Hover", "UIData/option.tga", 828, 999)
	mywindow:setTexture("Pushed", "UIData/option.tga", 828, 999)
	mywindow:setTexture("PushedOff", "UIData/option.tga", 828, 999)
	mywindow:setPosition(0, tExtremeZenPosY[i])
	mywindow:setProperty("GroupID", 5751)
	mywindow:setSize(140, 24)
	mywindow:setAlwaysOnTop(true)
	mywindow:setUserString("index", i)
	mywindow:setZOrderingEnabled(true)
	mywindow:subscribeEvent("SelectStateChanged", "ChangedExtremeZen")
	winMgr:getWindow("sj_lobby_extreme_tempSpace"):addChildWindow(mywindow)
	
	-- 다른 랭킹타입 글자
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_extreme_zen_text_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(0, 6)
	mywindow:setSize(140, 24)
	mywindow:setViewTextMode(1)
	mywindow:setAlign(8)
	mywindow:setLineSpacing(2)
	mywindow:clearTextExtends()
	mywindow:setTextExtends(tExtremeZenText[i], g_STRING_FONT_GULIMCHE, 12, 0, 0, 0, 255,   0, 0,0,0,255)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(true)
	winMgr:getWindow("sj_extreme_zen_"..i):addChildWindow(mywindow)
end


-- 대전의 다른 랭킹타입을 변경
function ChangedExtremeZen(args)
	local local_window = CEGUI.toWindowEventArgs(args).window
	if CEGUI.toRadioButton(local_window):isSelected() then
		winMgr:getWindow("sj_lobby_extreme_tempSpace"):setVisible(false)
		
		g_extremeZenIndex = tonumber(local_window:getUserString("index"))
		winMgr:getWindow("sj_lobby_extreme_selectedDesc"):setVisible(true)
		winMgr:getWindow("sj_lobby_extreme_selectedDesc"):clearTextExtends()
		winMgr:getWindow("sj_lobby_extreme_selectedDesc"):setTextExtends(tExtremeZenText[g_extremeZenIndex], g_STRING_FONT_GULIMCHE, 12, 255, 255, 255, 255,   0, 255,255,255,255)
		
		local_window:setProperty("Selected", "false")
	end
end

----------------------------------------------

-- 레벨 5이하, 대전에서 2번이상 졌을 경우(던전으로 유도)

----------------------------------------------
-- 알파창
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_lobby_induce_alphaWindow")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

RegistEscEventInfo("sj_lobby_induce_alphaWindow", "IsGoDungeon_CANCEL")


-- 던전유도 팝업창
inducewindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_lobby_induce_popupWindow")
inducewindow:setTexture("Enabled", "UIData/messenger2.tga", 0, 486)
inducewindow:setTexture("Disabled", "UIData/messenger2.tga", 0, 486)
inducewindow:setProperty("FrameEnabled", "False")
inducewindow:setProperty("BackgroundEnabled", "False")
inducewindow:setPosition(315, 100)
inducewindow:setSize(410, 538)
inducewindow:setVisible(false)
inducewindow:setAlwaysOnTop(true)
inducewindow:setZOrderingEnabled(false)
root:addChildWindow(inducewindow)


-- 던전유도 라디오 버튼
tInducePopupTexX  = { ["protecterr"]=0, [0]=419, 546, 673 }
tInducePopupPosX  = { ["protecterr"]=0, [0]=12, 139, 266 }
for i=0, #tInducePopupTexX do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", i .. "sj_lobby_induce_selectBtn")
	mywindow:setTexture("Normal", "UIData/messenger2.tga", 12+(i*127), 775)
	mywindow:setTexture("Hover", "UIData/messenger2.tga", tInducePopupTexX[i], 652)
	mywindow:setTexture("Pushed", "UIData/messenger2.tga", tInducePopupTexX[i], 838)
	mywindow:setTexture("PushedOff", "UIData/messenger2.tga", 12+(i*127), 775)
	mywindow:setTexture("SelectedNormal", "UIData/messenger2.tga", tInducePopupTexX[i], 838)
	mywindow:setTexture("SelectedHover", "UIData/messenger2.tga", tInducePopupTexX[i], 838)
	mywindow:setTexture("SelectedPushed", "UIData/messenger2.tga", tInducePopupTexX[i], 838)
	mywindow:setTexture("SelectedPushedOff", "UIData/messenger2.tga", tInducePopupTexX[i], 838)
	mywindow:setPosition(tInducePopupPosX[i], 289)
	mywindow:setProperty("GroupID", 777)
	mywindow:setSize(121, 186)
	mywindow:setUserString("selectNum", i+1)
	mywindow:setAlwaysOnTop(true)
	mywindow:subscribeEvent("SelectStateChanged", "SelectChanged")
	mywindow:subscribeEvent("MouseDoubleClicked", "SelectBeginnersNeed")
	inducewindow:addChildWindow(mywindow)
end


-- 던전유도 확인버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_lobby_induce_okBtn")
mywindow:setTexture("Normal", "UIData/popup001.tga",864, 485)
mywindow:setTexture("Hover", "UIData/popup001.tga", 864, 519)
mywindow:setTexture("Pushed", "UIData/popup001.tga", 864, 553)
mywindow:setTexture("PushedOff", "UIData/popup001.tga", 864, 485)
mywindow:setTexture("Enabled", "UIData/popup001.tga",864, 485)
mywindow:setTexture("Disabled", "UIData/popup001.tga",827, 267)
mywindow:setPosition(158, 489)
mywindow:setSize(80, 34)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:subscribeEvent("Clicked", "SelectBeginnersNeed")
inducewindow:addChildWindow(mywindow)


-- 종료창의 종료버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_lobby_induce_cancelBtn")

------------------------------------------------------------------------------
-- 이미지상에 이미 삭제된 자리 invisible.tga 로 대체 (확인해서 코드삭제 처리)
--[[
mywindow:setTexture("Normal", "UIData/button.tga", 367, 625)
mywindow:setTexture("Hover", "UIData/button.tga", 353, 593)
mywindow:setTexture("Pushed", "UIData/button.tga", 376, 593)
mywindow:setTexture("PushedOff", "UIData/button.tga", 367, 625)
--]]
mywindow:setTexture("Normal", "UIData/invisible.tga", 367, 625)
mywindow:setTexture("Hover", "UIData/invisible.tga", 353, 593)
mywindow:setTexture("Pushed", "UIData/invisible.tga", 376, 593)
mywindow:setTexture("PushedOff", "UIData/invisible.tga", 367, 625)
------------------------------------------------------------------------------

mywindow:setPosition(368, 9)
mywindow:setSize(23, 23)
mywindow:setAlwaysOnTop(true)
mywindow:subscribeEvent("Clicked", "IsGoDungeon_CANCEL")
inducewindow:addChildWindow(mywindow)

function SelectChanged()
	winMgr:getWindow("sj_lobby_induce_okBtn"):setEnabled(true)
end


function SelectBeginnersNeed(args)
	local selectNum
	for i=0, #tInducePopupTexX do
		if CEGUI.toRadioButton(winMgr:getWindow(i .. "sj_lobby_induce_selectBtn")):isSelected() then
			selectNum = winMgr:getWindow(i .. "sj_lobby_induce_selectBtn"):getUserString("selectNum")			
			winMgr:getWindow("sj_lobby_induce_alphaWindow"):setVisible(false)
			winMgr:getWindow("sj_lobby_induce_popupWindow"):setVisible(false)			
			WndLobby_GoBeginnersSelect(tonumber(selectNum))			
			return
		end
	end
end

function IsGoDungeon_CANCEL()
	winMgr:getWindow("sj_lobby_induce_alphaWindow"):setVisible(false)
	winMgr:getWindow("sj_lobby_induce_popupWindow"):setVisible(false)
	WndLobby_GoBeginnersSelect(3)
end


function ShowIsGoDungeon()
	winMgr:getWindow("sj_lobby_induce_alphaWindow"):setVisible(true)
	winMgr:getWindow("sj_lobby_induce_popupWindow"):setVisible(true)
end


function InitClubMatchLimit()
	DebugStr('클럽초기화')
	--winMgr:getWindow("Lobby_Select_Match0"):setProperty("Selected", "false")
	winMgr:getWindow("Lobby_Select_Match0"):setProperty("Selected", "true")
end