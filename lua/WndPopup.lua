--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root	    = winMgr:getWindow("DefaultWindow")
guiSystem:setGUISheet(root)
root:activate();

local g_MsgCount = 0
local g_STRING_POPUP_1 = PreCreateString_1273		--GetSStringInfo(LAN_LUA_WND_POPUP_2)	-- 준비중입니다

--------------------------------------------------------------------
-- 클릭시 나오는 소리
--------------------------------------------------------------------
function OnPopButtonMouseEnterSound(args)
	PlayWave('sound/Quickmenu01.wav')
end

function OnPopButtonMouseBtnUpSound(args)
	PlayWave('sound/Top_popmenu.wav')
end
 


--------------------------------------------------------------------
-- 팝업창 버튼을 이동시킨다.
--------------------------------------------------------------------
function MovePopupButton(xPos, yPos)
   
end

--------------------------------------------------------------------

-- Popup Window

--------------------------------------------------------------------
-- 백그라운드 알파 이미지
--------------------------------------------------------------------
backalphawindow = winMgr:createWindow("TaharezLook/StaticImage", "Popup_AlphaBackImg")
backalphawindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
backalphawindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
backalphawindow:setProperty("FrameEnabled", "False")
backalphawindow:setProperty("BackgroundEnabled", "False")
backalphawindow:setPosition(0, 0)
backalphawindow:setSize(1920, 1200)
backalphawindow:setVisible(false)
backalphawindow:setAlwaysOnTop(true)
backalphawindow:setZOrderingEnabled(false)
root:addChildWindow(backalphawindow)

--------------------------------------------------------------------
-- 팝업 메세지 창
--------------------------------------------------------------------
messagewindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_popup_messageWindow")
messagewindow:setTexture("Enabled", "UIData/popup002.tga", 0, 0)
messagewindow:setTexture("Disabled", "UIData/popup002.tga", 0, 0)
messagewindow:setWideType(6)
messagewindow:setPosition(342, 300)
messagewindow:setSize(340, 141)
messagewindow:setVisible(false)
messagewindow:setAlwaysOnTop(true)
messagewindow:setZOrderingEnabled(false)
root:addChildWindow(messagewindow)

-- 팝업 메세지창 ESC키, ENTER키 등록
RegistEscEventInfo("sj_popup_messageWindow", "PopupExit_CANCEL")
RegistEnterEventInfo("sj_popup_messageWindow", "PopupExit_OK")

--------------------------------------------------------------------
-- 메세지 내용
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_popup_messageDesc")
mywindow:setPosition(0, 20)
mywindow:setSize(340, 100)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:clearTextExtends()
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(1)
messagewindow:addChildWindow(mywindow)

--------------------------------------------------------------------
-- 종료 확인, 취소버튼
--------------------------------------------------------------------
local tPopupExitName  = {["protecterr"]=0, "sj_popup_eixt_OkBtn", "sj_popup_eixt_CancelBtn" }
local tPopupExitTexY  = {['protecterr']=0,		0,				108}
local tPopupExitPosX  = {['protecterr']=0,		63,				187}
local tPopupExitEvent = {["protecterr"]=0, "PopupExit_OK", "PopupExit_CANCEL" }

for i=1, #tPopupExitName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tPopupExitName[i])
	mywindow:setTexture("Normal", "UIData/popup002.tga", 340, tPopupExitTexY[i])
	mywindow:setTexture("Hover", "UIData/popup002.tga", 340, tPopupExitTexY[i] + 27)
	mywindow:setTexture("Pushed", "UIData/popup002.tga", 340, tPopupExitTexY[i] + 54)
	mywindow:setTexture("PushedOff", "UIData/popup002.tga", 340, tPopupExitTexY[i] + 54)
	mywindow:setPosition(tPopupExitPosX[i], 96)
	mywindow:setSize(90, 27)
	mywindow:setVisible(false)
	if i == 1 then
		mywindow:setUserString("wndType", -1)
	end
	
	mywindow:setAlwaysOnTop(true)
	messagewindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", tPopupExitEvent[i])
	messagewindow:addChildWindow(mywindow)
end

--------------------------------------------------------------------
-- 종료 팝업창을 띄워준다.
--------------------------------------------------------------------
function PopupMessage(message)
	winMgr:getWindow("Popup_AlphaBackImg"):setVisible(true)
	winMgr:getWindow("sj_popup_messageWindow"):setVisible(true)
	
	winMgr:getWindow("sj_popup_messageDesc"):setPosition(0, 49)
	winMgr:getWindow("sj_popup_messageDesc"):setTextExtends(message,g_STRING_FONT_DODUM,14,   255,255,255,255,   2,   0,0,0,255)
end



------------------------------------------------------------------------
-- 팝업(이벤트)
------------------------------------------------------------------------
function CallPopupEvent()
	
	if winMgr:getWindow("sj_eventPopupAlphaImage"):isVisible() then
		OnClickedEventPopupClosed()
	else
		RequestEventPopup()
	end
end

------------------------------------------------------------------------
-- 팝업(내정보)
------------------------------------------------------------------------
function CallPopupMyInfo()
	if winMgr:getWindow("UserInfo_Main"):isVisible() then
		CloseUserInfoWindow()
	else
		GetMyCharacterInfo();
		ShowUserInfoWindow()	
	end
end


------------------------------------------------------------------------
-- 팝업(인벤토리)
------------------------------------------------------------------------
function CallPopupInven()
	if winMgr:getWindow("MyInven_BackImage"):isVisible() then
		HideMyInventory()
	else
		ShowMyInventory(false, true);		
	end
end

------------------------------------------------------------------------
-- 팝업(선물함 창)
------------------------------------------------------------------------
function CallPopupPresent()
	if winMgr:getWindow("MailBackImage"):isVisible() then
	CloseMail();
	else
	ShowMail();
	end
end

------------------------------------------------------------------------
-- 팝업(메신져창)
------------------------------------------------------------------------
function CallPopupMessenger()
	--if winMgr:getWindow("bj_messengerBackWindow"):isVisible() then -- old messenger
	if winMgr:getWindow("NewFriendMessenger_MainWindow"):isVisible() then -- new messenger
		OnClickClose()
	else
		ShowFriendMessenger(true)
	end
end


------------------------------------------------------------------------
-- 팝업(챌린지미션)
------------------------------------------------------------------------
function CallPopupMission()
	
	if IsKoreanLanguage() then
		return
	end
	
	if winMgr:getWindow("ChallengeMissionWindow"):isVisible() then
		CM_CloseButtonClick()
	else
		ShowChallengeMission(false)
	end	
end


---------------------------------------------------------
-- 팝업(클럽 정보)
---------------------------------------------------------
function CallPopupMyClub()
	
    if	winMgr:getWindow("FightClub_ClubNameWindow"):isVisible() or winMgr:getWindow("FightClub_ClubListWindow"):isVisible() then
		OnClickClubList_Close() 
		OnClickClubName_Close()
    else
		CheckClubJoined()
    end
   
end


------------------------------------------------------------------------
-- 팝업(퀘스트)
------------------------------------------------------------------------
function CallPopupQuest()
	if winMgr:getWindow("MyQuestMainBackWindow"):isVisible() then
		HideMyQuestMainWindow()
	else
		ShowMyQuestMainWindow()
	end	
end


------------------------------------------------------------------------
-- 팝업(옵션창)
------------------------------------------------------------------------
function CallPopupOption()
	if winMgr:getWindow("Option_MainBackImg"):isVisible() then
		CancleButton()
	else
		ShowOption()
	end	
	
end


------------------------------------------------------------------------
-- 팝업(종료창)
------------------------------------------------------------------------
function CallPopupExit(wndtype)
	-- 광장 캐릭터 미니 팝업창을 제거(피킹시 나오는 창)
	root:removeChildWindow(winMgr:getWindow('pu_btnContainer'))
	
	-- 종료시 아케이드, 대전등으로 갈건지 물어보는 로직삭제
	local typeEnumIndex = LAN_MOVE_VILLAGE
	if wndtype == 0 then	typeEnumIndex = LAN_LUA_WND_POPUP_1
	elseif wndtype == 6 then	typeEnumIndex = LAN_MOVE_CHARACTER_SELECT
	elseif wndtype == 12 then	typeEnumIndex = LAN_MOVE_CHARACTER_SELECT
	elseif wndtype == 22 then	typeEnumIndex = LAN_MOVE_CHANNEL_SELECT
	end		
	winMgr:getWindow("sj_popup_eixt_OkBtn"):setUserString("wndType", wndtype)
	root:addChildWindow(winMgr:getWindow("Popup_AlphaBackImg"))
	local g_STRING_EIXT = GetSStringInfo(typeEnumIndex)	-- 제4구역을 종료 하시겠습니까?
	PopupMessage(g_STRING_EIXT)
	root:addChildWindow( winMgr:getWindow('sj_popup_messageWindow') )
	winMgr:getWindow("sj_popup_eixt_OkBtn"):setVisible(true)
	winMgr:getWindow("sj_popup_eixt_CancelBtn"):setVisible(true)		

end

------------------------------------------------------------------------
-- 종료 오케이 버튼
------------------------------------------------------------------------
function PopupExit_OK()
	local wndType = tonumber(winMgr:getWindow("sj_popup_eixt_OkBtn"):getUserString("wndType"))
	BtnPageMove_MoveBackWindow(wndType)
	winMgr:getWindow("sj_popup_eixt_OkBtn"):setUserString("wndType", -1)
end


------------------------------------------------------------------------
-- 종료 취소 버튼
------------------------------------------------------------------------
function PopupExit_CANCEL()
	WndPopupButtonClickSound()
	winMgr:getWindow("Popup_AlphaBackImg"):setVisible(false)
	winMgr:getWindow("sj_popup_messageWindow"):setVisible(false)
	winMgr:getWindow("sj_popup_eixt_OkBtn"):setVisible(false)
	winMgr:getWindow("sj_popup_eixt_CancelBtn"):setVisible(false)
end








----------------------------------------------

-- 태국에서 종료버튼을 눌렀을 때

----------------------------------------------
-- 종료 알파창
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_exit_newMenuAlphaWindow")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setPosition(0, 0)
mywindow:setVisible(false)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

-- 종료 팝업창
newMenuWindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_exit_newMenuPopupWindow")
newMenuWindow:setTexture("Enabled", "UIData/mainBG_button002.tga", 756, 183)
newMenuWindow:setTexture("Disabled", "UIData/mainBG_button002.tga", 756, 183)
newMenuWindow:setProperty("FrameEnabled", "False")
newMenuWindow:setProperty("BackgroundEnabled", "False")
newMenuWindow:setWideType(5)
newMenuWindow:setPosition(378, 241)
newMenuWindow:setSize(268, 285)
newMenuWindow:setVisible(false)
newMenuWindow:setAlwaysOnTop(true)
newMenuWindow:setZOrderingEnabled(false)
root:addChildWindow(newMenuWindow)

-- 종료 팝업창 종료버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_exit_newMenuPopupExitBtn")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setPosition(240, 6)
mywindow:setSize(23, 23)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "CloseExitAskPopup")
newMenuWindow:addChildWindow(mywindow)


-- 종료 팝업창 ESC키 등록
RegistEscEventInfo("sj_exit_newMenuPopupWindow", "CloseExitAskPopup")

if CheckfacilityData(FACILITYCODE_EXITGOLOGIN) == 0 then
	-- 종료 팝업창 버튼(0:채널/캐릭터 선택으로 이동, 1:로그인 화면으로 이동, 2:게임종료)
	tNewMenuBtnName  = {["err"]=0, [0]="sj_exit_newMenuPopupBtn_goChannel", "sj_exit_newMenuPopupBtn_exitGame"}
	tNewMenuBtnTexX  = {["err"]=0, [0]=0, 420 }
	tNewMenuBtnPosY  = {["err"]=0, [0]=62, 132 }
else
	-- 종료 팝업창 버튼(0:채널/캐릭터 선택으로 이동, 1:로그인 화면으로 이동, 2:게임종료)
	tNewMenuBtnName  = {["err"]=0, [0]="sj_exit_newMenuPopupBtn_goChannel", "sj_exit_newMenuPopupBtn_exitGame", "sj_exit_newMenuPopupBtn_goLogin"}
	tNewMenuBtnTexX  = {["err"]=0, [0]=0, 420, 210 }
	tNewMenuBtnPosY  = {["err"]=0, [0]=44, 152, 98 }
end

for i=0, #tNewMenuBtnName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tNewMenuBtnName[i])
	mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", tNewMenuBtnTexX[i], 229)
	mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", tNewMenuBtnTexX[i], 278)
	mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", tNewMenuBtnTexX[i], 327)
	mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", tNewMenuBtnTexX[i], 229)
	mywindow:setTexture("Disabled", "UIData/mainBG_button002.tga", tNewMenuBtnTexX[i], 376)
	mywindow:setPosition(28, tNewMenuBtnPosY[i])
	mywindow:setSize(210, 49)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("index", i)
	mywindow:subscribeEvent("Clicked", "SelectNewMenuPopupBtn")
	newMenuWindow:addChildWindow(mywindow)
end

function SelectNewMenuPopupBtn(args)	
	CloseExitAskPopup()
	
	local index = CEGUI.toWindowEventArgs(args).window:getUserString("index")
	ExitAskPopupSelected(index)
end


-- 계속 진행하기 버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_exit_newMenuPopupContinueBtn")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 814, 468)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 814, 517)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 814, 566)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 814, 468)
mywindow:setTexture("Disabled", "UIData/mainBG_button002.tga", 814, 615)
mywindow:setPosition(28, 222)
mywindow:setSize(210, 49)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "CloseExitAskPopup")
newMenuWindow:addChildWindow(mywindow)


-- 종료창 닫기
function CloseExitAskPopup()
	winMgr:getWindow("sj_exit_newMenuAlphaWindow"):setVisible(false)
	winMgr:getWindow("sj_exit_newMenuPopupWindow"):setVisible(false)
end


-- 종료창 보여주기
function ShowExitAskPopup()
	root:addChildWindow(winMgr:getWindow("sj_exit_newMenuAlphaWindow"))
	root:addChildWindow(winMgr:getWindow("sj_exit_newMenuPopupWindow"))
	winMgr:getWindow("sj_exit_newMenuAlphaWindow"):setVisible(true)
	winMgr:getWindow("sj_exit_newMenuPopupWindow"):setVisible(true)
end





-----------------------------------------------------------

--	키눌렀을 때 함수 호출하기

-----------------------------------------------------------
function RootKeyUp(args)
	-- 로딩중일 때는 못하게 막는다.
	if GetFinishLoading() == 0 then
		return
	end
	
	local keyEvent = CEGUI.toKeyEventArgs(args)
	currentWndType = GetCurrentWndType()
	
	--DebugStr("currentWndType: " .. currentWndType)
	
	----------------
	-- ESC 키
	----------------

	if keyEvent.scancode == 27 then
		UIEscEvent()
	
	----------------
	-- F2 키
	----------------
	elseif keyEvent.scancode == 113 then  
	 
		if currentWndType == 3 or currentWndType == 4 or currentWndType == 1 or currentWndType == 21 or currentWndType == WND_LUA_AUTOMATCHLOBBY then --(로비, 상점 , 마이룸, 클럽로비, 매치로비)
			--BtnPageMove_RequestVillage() -- 광장으로 이동
			OpenChannelImage()
			return
		end
	--[[
	----------------
	-- F3 키
	----------------
	elseif keyEvent.scancode == 114 then-- F3
		
		if currentWndType == 3 or currentWndType == 4 or currentWndType == 1 or currentWndType == 21 then --( 로비, 상점 , 마이룸 , 클럽로비)
			ShowChannelSelect() --대전으로 이동
			SetSelectBattle()
			BtnPageMove_RequestBattleChannel()
			return
		end
	--]]
	----------------
	-- F5 키
	----------------
	elseif keyEvent.scancode == 116 then-- F5
		if currentWndType == 3  or currentWndType == 1 or currentWndType == 21 then --( 로비, 상점 , 마이룸, 클럽로비)
			if IsTestPassport() == false then
				
				if IsKoreanLanguage() then
					return
				end
	
				--BtnPageMove_GoToItemShop() -- 샵으로 이동
				return
			end
		end
	----------------
	-- F4 키
	----------------
	elseif keyEvent.scancode == 115 then-- F4
		
		if IsKoreanLanguage() then
			return
		end
				
		if currentWndType == 4 or currentWndType == 1 or currentWndType == 21 then --( 로비, 상점 , 마이룸, 클럽로비)
			BtnPageMove_GoToMyItem()  -- 마이룸으로 이동
			return
		end
		
	----------------
	-- F11 키
	----------------
	elseif keyEvent.scancode == 122 then-- F11
		if currentWndType == 1 or currentWndType == 21 then --( 로비, 상점 , 마이룸, 클럽로비)
			CallPopupOption() -- 옵션호출
			return
		end
	----------------
	-- F7 키
	----------------
	elseif keyEvent.scancode == 118 then-- F7
		if currentWndType == 1 then --(대전로비일때)
			CreateBattleRoom()
			return
		end
	----------------
	-- F6 키
	----------------
	elseif keyEvent.scancode == 117 then-- F6
		if currentWndType == 1 then  --(대전로비일때)
			--if IsTestPassport() == false then
				WndLobby_JustGo_Random()
				return
			--end
		end
	
	----------------
	-- Enter 키
	----------------
	elseif keyEvent.scancode == 13 then
		UIEnterEvent()
	--Tab키
	elseif keyEvent.scancode == 9 then 
		if currentWndType == WND_LUA_LOBBY or
			currentWndType == WND_LUA_BATTLEROOM or
			currentWndType == WND_LUA_QUESTROOM or
			currentWndType == WND_LUA_CLUBLOBBY or
			currentWndType == WND_LUA_AUTOMATCHLOBBY then
			
			if winMgr:getWindow('doChatting'):isActive() == true or winMgr:getWindow('PrivateChatting'):isActive()  then
				ChangeChatPopupTab()
			end
		end
	
	--아래화살표키
	elseif keyEvent.scancode == 40 then	
		--[[
		if winMgr:getWindow("Lobby_tab_allChat") ~= nil then
			if winMgr:getWindow('doChatting'):isActive() == true  then
				local ChatMsg, ListSize = ChatMsgListLoad(g_MsgCount)
				g_MsgCount = g_MsgCount + 1
			
				if g_MsgCount >= ListSize then
					g_MsgCount = 0
				end
				winMgr:getWindow('doChatting'):setText(ChatMsg)
			end
		elseif winMgr:getWindow("Battle_tab_allChat") ~= nil then
			if winMgr:getWindow('doChatting'):isActive() == true  then
				local ChatMsg, ListSize = ChatMsgListLoad(g_MsgCount)
				g_MsgCount = g_MsgCount + 1
			
				if g_MsgCount >= ListSize then
					g_MsgCount = 0
				end
				winMgr:getWindow('doChatting'):setText(ChatMsg)
			end
			
		elseif winMgr:getWindow("Quest_tab_allChat") ~= nil then
			if winMgr:getWindow('doChatting'):isActive() == true  then
				local ChatMsg, ListSize = ChatMsgListLoad(g_MsgCount)
				g_MsgCount = g_MsgCount + 1
			
				if g_MsgCount >= ListSize then
					g_MsgCount = 0
				end
				winMgr:getWindow('doChatting'):setText(ChatMsg)
			end
			
		elseif winMgr:getWindow("ClubLobby_tab_allChat") ~= nil then
			if winMgr:getWindow('doChatting'):isActive() == true  then
				local ChatMsg, ListSize = ChatMsgListLoad(g_MsgCount)
				g_MsgCount = g_MsgCount + 1
			
				if g_MsgCount >= ListSize then
					g_MsgCount = 0
				end
				winMgr:getWindow('doChatting'):setText(ChatMsg)
			end
		end
		--]]
	end
	
	if	ForLuaCheckActivationEditBox() == false then
		
		if currentWndType == WND_LUA_CREATECHARACTER then
			return
		end
		local CommonBox1 =  winMgr:getWindow('CommonAlertAlphaImg'):isVisible()
		local CommonBox2 =  winMgr:getWindow("FriendAlertAlphaImg"):isVisible()
		local CommonBox4 = false;
		if winMgr:getWindow("ApdaterAlphaImage") ~= nil then
		  CommonBox4 = winMgr:getWindow("ApdaterAlphaImage"):isVisible()
		end;
		local CommonBox5 =  winMgr:getWindow("PetStatUpgrade_MainWindow"):isVisible()
		
		if CommonBox1 == false
			and CommonBox2 == false
			and CommonBox4 == false 
			and CommonBox5 == false then
		
			if currentWndType ~= WND_LUA_CREATECHARACTER and currentWndType ~= WND_LUA_SELECTCHANNEL then
				if keyEvent.scancode == 84 then  -- 이벤트 단축키(T)
					if isShowAble('MainBar_Event') == true then
						CallPopupEvent()
						return
					end
				end
				
				if keyEvent.scancode == 67 then  -- 내정보 단축키(c)
					CallPopupMyInfo()
					return
				end
				
				if keyEvent.scancode == 73 then  -- 가방 단축키(I)
					if IsKoreanLanguage() == false then -- ★
						-- 마이룸/캐시샵이면 리턴
						if currentWndType == WND_LUA_MYROOM or currentWndType == WND_LUA_ITEMSHOP then
							return
						end
						
						CallPopupInven()
						return
					end -- end of GetLanguageType()
					
					
					CallPopupInven()
					return
				end
				
				if keyEvent.scancode == 75 then  -- 메일 단축키(k)
					if isShowAble('MainBar_Mail') == true then
						CallPopupPresent()
						return
					end
				end
				
				if keyEvent.scancode == 77 then  -- 메신져 단축키(M)
					CallPopupMessenger()
					return
				end
				
				if keyEvent.scancode == 78 then  -- 클럽 단축키(n)
					CallPopupMyClub()
					return
				end
				
				if keyEvent.scancode == 71 then  -- 게임심의(g)
					--CallPopupMyClub()
					if IsKoreanLanguage() then
						ShowGameRating()
					end
					return
				end
				
				if keyEvent.scancode == 76 then  -- 퀘스트 단축키(L)
					CallPopupQuest()
					return
				end
				
				if keyEvent.scancode == 80 then -- 프로필 단축키(p) 
					ShowProfileUi()
					return
				end
			end
		end
	end
end
root:subscribeEvent("KeyUp", "RootKeyUp")



--[[
	if tWindowName[i] == "Common알파이미지" then
		winMgr:getWindow('Common알파이미지'):setVisible(false)
		root:removeChildWindow(winMgr:getWindow('Common알파이미지'))
	end
--]]

-----------------------------------------------------------

--	esc이벤트 에따라 ui close

-----------------------------------------------------------
function UIEscEvent()
	DebugStr('UIEscEvent()')
	tWindowNumber = {['protecterr']=0}
	for i=1, #g_tEscEventWindow do
		tWindowNumber[i] = 0
	end

	local _HighNumBuf = 0;		--가장 높은 수
	local _NumBuf = 0;			--비교될 수
	for i=1, #g_tEscEventWindow do
		
		tWindowNumber[i] = root:getTopWindow(g_tEscEventWindow[i]);
		_NumBuf = tWindowNumber[i];
		
		--비교해준다.
		if _HighNumBuf >= _NumBuf then
			_HighNumBuf = _HighNumBuf;
			
		elseif _HighNumBuf < _NumBuf then
			_HighNumBuf = _NumBuf;
		end
	end
	DebugStr('_HighNumBuf:'.._HighNumBuf)
	--ui창이 없다면
	if _HighNumBuf == 0 then
	
		-- 배틀룸(2), 아케이드룸(14) 에서는 ESC를 할수 없음
		local currentWndType = GetCurrentWndType()
		if currentWndType == 2 then
			--BattleRoomOut() 
			return
		elseif currentWndType == 14 then
			--ExitDungeon()
			return
		elseif currentWndType == 6 then
			WndCreateCharacter_CheckIntroSkip()
			return
		else
			CallPopupExit(currentWndType)
		end
		
	else	--창이 하나라도 떠있으면.
		for i=1, #g_tEscEventWindow do
			if tWindowNumber[i] == _HighNumBuf then
				CallFunction(g_tEscEventFunction[i])
			end		
		end
	end
	
	WndPopupButtonClickSound()
end



-- 에디트 박스에 TextAccepted 이벤트 때문에 엔터가 미리 적용될 수 있어서 여기서 예외처리 해준다(수동ㅠ)
tExceptionWindow = { ["err"]=0, "sj_realDelete_editbox", "sj_lobby_forPassword_editbox", 
					"PartyCreate_PartyNameEdit", "PartyInvite_ChrNameText", --"CommonAlertEditBox",
					"sjParty_Create_NameEditbox", "sjParty_Invite_NameEditbox",
					"login_ID_editbox", "login_Password_editbox", "Club_List_EditBox",
					"Club_Board_EditBox", "ClubManage_InviteEditbox", "ClubManage_TransEditbox",
					"GuestBookReplyEditBox" , "AddBlackListEditBox" , "InputGuestBook", "SearchGuestBook",
					"ClubWarMoneyEditbox", "sj_recommendFriendSendNameText", "CouponEdit1","CouponEdit2","CouponEdit3","CouponEdit4", "CouponEdit5"
					}
					
g_editboxWindowName = "doChatting"

function UIEnterEvent()
	
	for i=0, #tExceptionWindow do
		if winMgr:getWindow(tExceptionWindow[i]) then
			if winMgr:getWindow(tExceptionWindow[i]):isActive() then
				winMgr:getWindow(tExceptionWindow[i]):deactivate()
				return
			end
		end
	end
	
		
	tWindowNumber = {['err']=0}
	for i=1, #g_tEnterEventWindow do
		tWindowNumber[i] = 0
	end

	local _HighNumBuf = 0;		--가장 높은 수
	local _NumBuf = 0;			--비교될 수
	for i = 1, #g_tEnterEventWindow do
		
		tWindowNumber[i] = root:getTopWindow(g_tEnterEventWindow[i]);
		_NumBuf = tWindowNumber[i];
		
		--비교해준다.
		if _HighNumBuf >= _NumBuf then
			_HighNumBuf = _HighNumBuf;
			
		elseif _HighNumBuf < _NumBuf then
			_HighNumBuf = _NumBuf;
		end
	end
	
	-- ui창이 없다면
	if _HighNumBuf == 0 then
	else
		for i=1, #g_tEnterEventWindow do
			if tWindowNumber[i] == _HighNumBuf then
				if winMgr:getWindow(g_editboxWindowName) then
					if winMgr:getWindow(g_editboxWindowName):isActive() then
					else
						CallFunction(g_tEnterEventFunction[i])
						g_EnterEventState = true
					end
				else
					CallFunction(g_tEnterEventFunction[i])
					g_EnterEventState = true
				end
			end
		end
	end
	
	WndPopupButtonClickSound()
end





--이벤트가 발생될 윈도우의 이름을 얻어옴
g_EventWindowName = nil;
function GetEventWindowName(WindowName)
	g_EventWindowName = WindowName;		
end

function ResetMsgCount()
	g_MsgCount = 0;
end

--Enter이벤트를 발생시킴
--[[
function UIEnterEvent()

	--현재 띄워져있는 윈도우가 없다면 return
	if g_EventWindowName == nil then
		return;
	end
	
	local args = CEGUI.WindowEventArgs:new(winMgr:getWindow(g_EventWindowName));	
	winMgr:getWindow(g_EventWindowName):fireEvent("Clicked", args, "PushButton");
	--guiSystem:WindowClickEvent(g_EventWindowName); 
	
	--엔터 이벤트 발생후 윈도우는 다시 초기화.
	g_EventWindowName = nil;

end
--]]

--[[
function CheckFastKeyEnable()
	FastExceptionWindow = { ["err"]=0, "PartyCreate_PartyNameEdit", "PartyInvite_ChrNameText", 
						"sjParty_Create_NameEditbox", "sjParty_Invite_NameEditbox",
						"login_ID_editbox", "login_Password_editbox", "Club_List_EditBox" ,  "Club_Board_EditBox" , "ClubManage_InviteEditbox" , "ClubManage_TransEditbox"}
	for i=0, #FastExceptionWindow do
		if winMgr:getWindow(FastExceptionWindow[i]) then
			if winMgr:getWindow(tExceptionWindow[i]):isActive() then
				return
			end
		end
	end
end
--]]

function isShowAble(BTName)
	local Mailwindow = winMgr:getWindow(BTName)
	if Mailwindow ~= nil then
		isDisabled = Mailwindow:isDisabled()
		if isDisabled == false then
			return true
		end 
	end
	return false
end
