-----------------------------------------
-- Script Entry Point
-----------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)
root:activate()

g_BattleMode = GetCurrentChannelBattleMode() -- 현재 채널의 배틀모드를 얻는다(0:일반, 1:익스트림)
local g_STRING_SELECTROOM			= PreCreateString_1682		--GetSStringInfo(LAN_LUA_LOBBY_SELECTROOM)	-- 방을 선택해 주세요.
local g_STRING_INPUT_PASSWORD		= PreCreateString_1161		--GetSStringInfo(LAN_LUA_WND_LOBBY_1)		-- 비밀번호를 입력해 주세요
local STRING_SUCCESS_CHANGECLASS	= PreCreateString_1162		--GetSStringInfo(LAN_LUA_WND_LOBBY_2)		-- 전직하였습니다.
local g_SelectedLobbyTab = 4
local MAX_USERNUM_IN_ROOM = 8

-- 룸, 유저 최대 페이지를 얻는다.
local MAX_ROOMPAGE, MAX_USERPAGE = WndLobby_GetMaxPages()

local g_currentRoomNumber = -1
local g_currentRoomIndex = -1

local USERINFO_POSX = 688
local USERINFO_POSY = 92	-- 유저정보 y위치

-- 현재 랭귀지 타입을 얻어온다.
local LANGUAGECODE = GetLanguageType()

--------------------------------------------------------------------
-- 채널 정보 백판 붙이기
--------------------------------------------------------------------
root:addChildWindow(winMgr:getWindow('ChannelPositionBG'));
winMgr:getWindow('ChannelPositionBG'):setWideType(6);
winMgr:getWindow('ChannelPositionBG'):setPosition(795, 2);
winMgr:getWindow('NewMoveServerBtn'):setVisible(true)
winMgr:getWindow('NewMoveExitBtn'):setVisible(false)
--ChangeChannelPosition('Battle lobby')



-- 초기 채팅창 설정
function SetChatInitNewClubLobby()
	Chatting_SetChatWideType(6)
	Chatting_SetChatPosition(3, 527)
	Chatting_SetChatEditVisible(true)
	Chatting_SetChatEditEvent(2)
	winMgr:getWindow("doChatting"):deactivate()
	Chatting_SetChatTabDefault()
end


--------------------------------------------------------------------

-- drawTexture(StartRender:시작시에 그리기)

--------------------------------------------------------------------
function WndLobby_RenderBackImage(currentBattleChannelName)
	
	g_LOBBY_WIN_SIZEX, g_LOBBY_WIN_SIZEY = GetCurrentResolution()
	
	
	drawer:drawTexture("UIData/RoomWideBack.dds", 0, 0, g_LOBBY_WIN_SIZEX, g_LOBBY_WIN_SIZEY, (1920-g_LOBBY_WIN_SIZEX)/2 , (1200-g_LOBBY_WIN_SIZEY)/2)
	drawer:drawTexture("UIData/mainBG_Button001.tga", 0, 0, 1024, 71, 0, 0, WIDETYPE_6)			-- 윗쪽 바
	drawer:drawTexture("UIData/mainBG_Button001.tga", 40, 5, 281, 50, 0, 435, WIDETYPE_6)	-- 파이트클럽 글자
	
	drawer:drawTexture("UIData/LobbyImage_new.tga", 13, 123, 662, 389, 2, 3, WIDETYPE_6)		-- 방 정보
	drawer:drawTexture("UIData/LobbyImage_new002.tga", 705, 527, 289, 164, 0, 0, WIDETYPE_6)	-- 빠른시작
	drawer:drawTexture("UIData/LobbyImage_new.tga", USERINFO_POSX, USERINFO_POSY+29, 323, 393, 0, 396, WIDETYPE_6)		-- 유저정보
	
	drawer:drawTexture("UIData/LobbyImage_new.tga", 411, 81, 240, 29, 353, 632, WIDETYPE_6)		-- 대전방 가기	
	
	
--	drawer:drawTexture("UIData/bunhae_002.tga", 13, 88, 113, 27, 0, 82, WIDETYPE_6)		-- 도움말 버튼 이미지

	-- 대전채널 이름
	if g_BattleMode == BATTLETYPE_NORMAL then
		drawer:setTextColor(255, 255, 255, 255)
	elseif g_BattleMode == BATTLETYPE_EXTREME then
		drawer:setTextColor(220, 80, 220, 255)
	end
	
	if IsKoreanLanguage() then
		drawer:setFont(g_STRING_FONT_GULIMCHE, 16)
		--drawer:drawText("- "..currentBattleChannelName, 800, 42, WIDETYPE_6)
		--drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
		--drawer:drawText("- 친선 대전은 KO률, 래더등 모든 수치가 적용되지 않습니다 -", 250, 42, WIDETYPE_6)
	else
		drawer:setFont(g_STRING_FONT_GULIMCHE, 14)
		drawer:drawText("- "..currentBattleChannelName, 800, 42, WIDETYPE_6)
	end
end




--------------------------------------------------------------------

-- 팀전, 개인전 방색상 다르게 하기위해

--------------------------------------------------------------------
local tRoomListReversPosX	= { ["protecterr"]=0, [0]=343, 50, 343, 50, 343, 50, 343, 50 }
local tRoomListPosX			= { ["protecterr"]=0, [0]=32, 347 }
local tRoomListPosY			= { ["protecterr"]=0, [0]=144, 144, 222, 222, 300, 300, 378, 378 }
function WndLobby_IsTeamBattle(index, gameMode, bTeam)
	if gameMode == 0 then
		if bTeam == 1 then
			drawer:drawTexture("UIData/LobbyImage_new.tga", tRoomListPosX[index%2], tRoomListPosY[index], 309, 73, 0, 790, WIDETYPE_6)
		end
	elseif gameMode == 6 then
		drawer:drawTexture("UIData/LobbyImage_new.tga", tRoomListPosX[index%2], tRoomListPosY[index], 309, 73, 621, 881, WIDETYPE_6)
	elseif gameMode == 8 then
		drawer:drawTexture("UIData/LobbyImage_new.tga", tRoomListPosX[index%2], tRoomListPosY[index], 309, 73, 665, 128, WIDETYPE_6)
	elseif gameMode == 11 then
		if bTeam == 1 then
			drawer:drawTexture("UIData/LobbyImage_new.tga", tRoomListPosX[index%2], tRoomListPosY[index], 309, 73, 0, 790, WIDETYPE_6)
		end
	end
end




--------------------------------------------------------------------

-- 룸 페이지, 유저 페이지

--------------------------------------------------------------------
function WndLobby_AllPageInfo(currRoomPage, maxRoomPage, currUserPage, maxUserPage)
	drawer:setTextColor(255, 255, 255, 255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 16)

-----------------------------------------
-- 룸 페이지
-----------------------------------------	
	local roomPageText = tostring((currRoomPage+1).."  /  "..(maxRoomPage+1))
	local roomPageSize = GetStringSize(g_STRING_FONT_GULIMCHE, 16, roomPageText)
	drawer:drawText(roomPageText, 572-roomPageSize/2, 473, WIDETYPE_6)

-----------------------------------------
-- 유저 페이지
-----------------------------------------
	local userPageText = tostring((currUserPage+1).."  /  "..(maxUserPage+1))
	local userPageSize = GetStringSize(g_STRING_FONT_GULIMCHE, 16, userPageText)
	drawer:drawText(userPageText, 850-userPageSize/2, USERINFO_POSY+383 , WIDETYPE_6)
end





--------------------------------------------------------------------

-- 대전방 가기버튼

--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_lobby_GoBattleRoomBtn")
mywindow:setTexture("Normal", "UIData/LobbyImage_new.tga", 354, 562)
mywindow:setTexture("Hover", "UIData/LobbyImage_new.tga", 354, 585)
mywindow:setTexture("Pushed", "UIData/LobbyImage_new.tga", 354, 608)
mywindow:setTexture("PushedOff", "UIData/LobbyImage_new.tga", 354, 562)
mywindow:setWideType(6);
mywindow:setPosition(583, 84)
mywindow:setSize(62, 23)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "SearchGoBattleRoom")
mywindow:setSubscribeEvent('MouseButtonDown', 'BattleRoomMouseClick');
mywindow:setSubscribeEvent('MouseEnter', 'BattleRoomMouseEnter');
root:addChildWindow(mywindow)


-- 대전방 가기
function SearchGoBattleRoom()

	local roomNum = winMgr:getWindow("sj_lobby_enterRoomEditBox"):getText()
	WndLobby_SearchBattleRoom(tonumber(roomNum), true)
	winMgr:getWindow("sj_lobby_enterRoomEditBox"):setText("")
	
end





--------------------------------------------------------------------

-- 대전방 가기 에디트 박스

--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Editbox", "sj_lobby_enterRoomEditBox")
mywindow:setWideType(6);
mywindow:setPosition(504, 84)
mywindow:setSize(70, 23)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setAlphaWithChild(0)
mywindow:setUseEventController(false)
mywindow:subscribeEvent("TextAccepted", "SearchGoBattleRoom")
CEGUI.toEditbox(mywindow):setInputOnlyNumber()
CEGUI.toEditbox(mywindow):setMaxTextLength(4)
root:addChildWindow(mywindow)







--------------------------------------------------------------------

-- 방만들때 필요한 변수들(6개)

--------------------------------------------------------------------
PLAYTYPE_NOITEM = 0
PLAYTYPE_ITEM = 1
PLAYTYPE_CLASS = 2

roomName		= ""
nGameMode		= 0
bTeam			= true
bItem			= PLAYTYPE_ITEM
nMaxUser		= 8
roomPassword	= ""
extremeZen		= 0
autoBalance		= false
exceptE			= false
bLadderType		= false

function InitBattleRoomInfo()
	roomName		= ""
	nGameMode		= 0
	bTeam			= true
	bItem			= PLAYTYPE_ITEM
	nMaxUser		= 8
	roomPassword	= ""
	extremeZen		= 0
	autoBalance		= false
	exceptE			= false
	bLadderType		= false
end





--------------------------------------------------------------------

-- 배틀룸 리스트(MAX_ROOMPAGE)

--------------------------------------------------------------------
local tRoomListSort = {["err"]=0, [0]=1, 3, 5, 7, 0, 2, 4, 6}
for index=0, MAX_ROOMPAGE-1 do

	i = tRoomListSort[index]

	-- 1. 배틀룸 방리스트(라디오 버튼) 생성
	roomwindow = winMgr:createWindow("TaharezLook/RadioButton", i .. "sj_lobby_roomList_radioBtn")
	roomwindow:setTexture("Normal", "UIData/invisible.tga", 0, 0)
	roomwindow:setTexture("Hover", "UIData/LobbyImage_new.tga", 312, 790)
	roomwindow:setTexture("Pushed", "UIData/LobbyImage_new.tga", 0, 863)
	roomwindow:setTexture("PushedOff", "UIData/invisible.tga", 0, 0)
	roomwindow:setTexture("SelectedNormal", "UIData/LobbyImage_new.tga", 0, 863)
	roomwindow:setTexture("SelectedHover", "UIData/LobbyImage_new.tga", 0, 863)
	roomwindow:setTexture("SelectedPushed", "UIData/LobbyImage_new.tga", 0, 863)
	roomwindow:setTexture("SelectedPushedOff", "UIData/LobbyImage_new.tga", 0, 863)
	roomwindow:setTexture("Enabled", "UIData/LobbyImage_new.tga", 312, 863)				-- empty
	roomwindow:setTexture("Disabled", "UIData/LobbyImage_new.tga", 312, 863)			-- empty
	roomwindow:setTexture("SelectedEnabled", "UIData/LobbyImage_new.tga", 312, 863)		-- empty(선택후 방이 없어질때를 위해)
	roomwindow:setTexture("SelectedDisabled", "UIData/LobbyImage_new.tga", 312, 863)	-- empty(선택후 방이 없어질때를 위해)
	roomwindow:setWideType(6);
	roomwindow:setPosition(tRoomListPosX[i%2], tRoomListPosY[i])
	roomwindow:setSize(309, 73)
	roomwindow:setProperty("GroupID", 600)
	roomwindow:setZOrderingEnabled(false)
	roomwindow:setUserString("RoomIndex", i)
	roomwindow:setUserString("RoomNumber", 0)
	roomwindow:setVisible(true)
	roomwindow:setEnabled(false)
	roomwindow:subscribeEvent("MouseDoubleClicked", "EnterBattleRoom")	
	roomwindow:subscribeEvent("MouseEnter", "OnMouseEnter_UserInfo_inRoom")
	roomwindow:subscribeEvent("MouseLeave", "OnMouseLeave_UserInfo_inRoom")
	root:addChildWindow(roomwindow)
	
	-- 2. 방번호
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_lobby_roomList_roomIndex")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
	mywindow:setPosition(15, 11)
	mywindow:setSize(60, 20)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	roomwindow:addChildWindow(mywindow)
	
	-- 3. 제목
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_lobby_roomList_roomTitle")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 13)
	mywindow:setPosition(70, 2)
	mywindow:setSize(300, 36)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	--roomwindow:addChildWindow(mywindow)
	
	-- 4. 대전모드
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_lobby_roomList_isMRBattleRoom")
	mywindow:setTexture("Enabled", "UIData/LobbyImage_new.tga", 462, 748)
	mywindow:setTexture("Disabled", "UIData/LobbyImage_new.tga", 516, 748)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(4, 42)
	mywindow:setSize(54, 23)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	roomwindow:addChildWindow(mywindow)	
		
	-- 5. 개인전, 팀전
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_lobby_roomList_isTeamBattleRoom")
	mywindow:setTexture("Enabled", "UIData/LobbyImage_new.tga", 462, 702)
	mywindow:setTexture("Disabled", "UIData/LobbyImage_new.tga", 516, 702)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(58, 42)
	mywindow:setSize(54, 23)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	roomwindow:addChildWindow(mywindow)
	
	-- 6. 노템전, 아이템전
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_lobby_roomList_isItemBattleRoom")
	mywindow:setTexture("Enabled", "UIData/LobbyImage_new.tga", 354, 702)
	mywindow:setTexture("Disabled", "UIData/LobbyImage_new.tga", 354, 702)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(112, 42)
	mywindow:setSize(54, 23)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	roomwindow:addChildWindow(mywindow)
	
	-- 7. 비밀번호
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_lobby_roomList_roomPassword")
	mywindow:setTexture("Enabled", "UIData/LobbyImage_new.tga", 667, 206)
	mywindow:setTexture("Disabled", "UIData/LobbyImage_new.tga", 667, 206)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(256, 45)
	mywindow:setSize(15, 17)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	roomwindow:addChildWindow(mywindow)
	
	-- 8. 현재인원(숫자는 굴림)
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_lobby_roomList_roomCurrentUserNum")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont(g_STRING_FONT_GULIM, 12)
	mywindow:setPosition(274, 44)
	mywindow:setSize(80, 26)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	roomwindow:addChildWindow(mywindow)
	
	-- 9. 루키 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_lobby_roomList_roomRookieImage")
	mywindow:setTexture("Enabled", "UIData/GameNewImage2.tga", 964, 94)
	mywindow:setTexture("Disabled", "UIData/GameNewImage2.tga", 964, 94)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(255, 5)
	mywindow:setSize(47, 30)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	--roomwindow:addChildWindow(mywindow)
	
	-- 10. 게임중 알파이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_lobby_roomList_roomIsGamingAlphaImage")
	mywindow:setTexture("Enabled", "UIData/LobbyImage_new.tga", 0, 936)
	mywindow:setTexture("Disabled", "UIData/LobbyImage_new.tga", 0, 936)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setWideType(6);
	mywindow:setPosition(tRoomListPosX[i%2], tRoomListPosY[i])
	mywindow:setSize(309, 73)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	root:addChildWindow(mywindow)
	
	-- 11. Waiting, Playing 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_lobby_roomList_roomIsGamingImage")
	mywindow:setTexture("Enabled", "UIData/LobbyImage_new.tga", 510, 664)
	mywindow:setTexture("Disabled", "UIData/LobbyImage_new.tga", 510, 664)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(191, 42)
	mywindow:setSize(78, 23)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	roomwindow:addChildWindow(mywindow)
	
	-- 12. 연승 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_lobby_roomList_continueWinImage")
	mywindow:setTexture("Enabled", "UIData/LobbyImage_new.tga", 608, 630)
	mywindow:setTexture("Disabled", "UIData/LobbyImage_new.tga", 608, 630)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(237, 3)
	mywindow:setSize(34, 34)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	--roomwindow:addChildWindow(mywindow)
	
	-- 13. 연승글자
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_lobby_roomList_continueWinText")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(0, 10)
	mywindow:setSize(33, 20)
	mywindow:setViewTextMode(1)
	mywindow:setAlign(8)
	mywindow:setLineSpacing(2)
	mywindow:clearTextExtends()
	mywindow:setZOrderingEnabled(false)
	--winMgr:getWindow(i .. "sj_lobby_roomList_continueWinImage"):addChildWindow(mywindow)
	
	-- 14. 익스트림 모드 말풍선
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_lobby_roomList_extremeImage")
	mywindow:setTexture("Enabled", "UIData/LobbyImage_new.tga", 570, 702)
	mywindow:setTexture("Disabled", "UIData/LobbyImage_new.tga", 570, 702)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setWideType(6);
	mywindow:setPosition(tRoomListPosX[i%2]+230, tRoomListPosY[i]-16)
	mywindow:setSize(101, 44)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	--root:addChildWindow(mywindow)
	
	-- 15. 익스트림 모드 ZEN
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_lobby_roomList_extremeZenText")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(10, 11)
	mywindow:setSize(100, 20)
	mywindow:setViewTextMode(1)
	mywindow:setAlign(8)
	mywindow:setLineSpacing(2)
	mywindow:clearTextExtends()
	mywindow:setZOrderingEnabled(false)
	--winMgr:getWindow(i .. "sj_lobby_roomList_extremeImage"):addChildWindow(mywindow)

	-- 16. 자동 팀균형 경험치 젠 50%증가 표시
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_lobby_roomList_autobalanceImage")
	mywindow:setTexture("Enabled", "UIData/LobbyImage_new.tga", 462, 771)
	mywindow:setTexture("Disabled", "UIData/LobbyImage_new.tga", 462, 771)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setWideType(6);
	mywindow:setPosition(tRoomListPosX[i%2]-1, tRoomListPosY[i]-7)
	mywindow:setSize(178, 19)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	--root:addChildWindow(mywindow)
	
	-- 17. E필살기 제외
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_lobby_roomList_exceptEImage")
	mywindow:setTexture("Enabled", "UIData/LobbyImage_new.tga", 998, 370)
	mywindow:setTexture("Disabled", "UIData/LobbyImage_new.tga", 998, 370)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setWideType(6);
	mywindow:setPosition(tRoomListPosX[i%2]+166, tRoomListPosY[i]+41)
	mywindow:setSize(26, 26)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	root:addChildWindow(mywindow)
	
	-- 18. 친선, 래더전
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_lobby_roomList_friendShipImage")
	mywindow:setTexture("Enabled", "UIData/LobbyImage_new.tga", 419, 987)
	mywindow:setTexture("Disabled", "UIData/LobbyImage_new.tga", 419, 987)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setWideType(6);
	mywindow:setPosition(tRoomListPosX[i%2]+178, tRoomListPosY[i]-7)
	mywindow:setSize(85, 19)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	root:addChildWindow(mywindow)	
	
	-- 래더 제한 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "Lobby_RoomList_LadderLimitImg")
	mywindow:setTexture("Enabled", "UIData/option.tga", 673, 903)
	mywindow:setTexture("Disabled", "UIData/option.tga", 673, 903)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setWideType(6)
	mywindow:setScaleHeight(210)
	mywindow:setScaleWidth(210)
	mywindow:setPosition(tRoomListPosX[i%2]+210, tRoomListPosY[i]-7)
	mywindow:setSize(85, 23)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	root:addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "Lobby_RoomList_LadderLimit_Max_Ten_Img")
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(65, 4)
	mywindow:setSize(8, 14)
	mywindow:setVisible(false)
	winMgr:getWindow(i .."Lobby_RoomList_LadderLimitImg"):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "Lobby_RoomList_LadderLimit_Max_One_Img")
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(73, 4)
	mywindow:setSize(8, 14)
	mywindow:setVisible(false)
	winMgr:getWindow(i .."Lobby_RoomList_LadderLimitImg"):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "Lobby_RoomList_LadderLimit_Min_Ten_Img")
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(21, 4)
	mywindow:setSize(8, 14)
	mywindow:setVisible(false)
	winMgr:getWindow(i .."Lobby_RoomList_LadderLimitImg"):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "Lobby_RoomList_LadderLimit_Min_One_Img")
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(29, 4)
	mywindow:setSize(8, 14)
	mywindow:setVisible(false)
	winMgr:getWindow(i .."Lobby_RoomList_LadderLimitImg"):addChildWindow(mywindow)
	
	-- 클럽 배경 이미지
	mywindow = winMgr:createWindow('TaharezLook/StaticImage', i .."Lobby_RoomList_ClubBackImg")
	mywindow:setTexture('Enabled', 'UIData/match001.tga', 454, 682)
	mywindow:setTexture('Disabled', 'UIData/match001.tga', 454, 682)
	mywindow:setProperty('BackgroundEnabled', 'False')
	mywindow:setProperty('FrameEnabled', 'False')
	mywindow:setPosition(35, 1)
	mywindow:setSize(256, 33)
	mywindow:setEnabled(false)
	roomwindow:addChildWindow(mywindow)
	
	-- 클럽 left 이름
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i.."Lobby_RoomList_leftClubName")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(25, 12)
	mywindow:setSize(100, 20)
	mywindow:setViewTextMode(1)
	mywindow:setAlign(1)
	mywindow:setLineSpacing(2)
	mywindow:clearTextExtends()
	mywindow:setZOrderingEnabled(false)
	--mywindow:setTextExtends("왼쪽클럽이름222", g_STRING_FONT_GULIMCHE, 11, 255,255,255,255,   0, 0,0,0,255)
	winMgr:getWindow(i .."Lobby_RoomList_ClubBackImg"):addChildWindow(mywindow)
	
	-- 클럽 right 이름
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i.."Lobby_RoomList_RightClubName")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(170, 12)
	mywindow:setSize(100, 20)
	mywindow:setViewTextMode(1)
	mywindow:setAlign(1)
	mywindow:setLineSpacing(2)
	mywindow:clearTextExtends()
	mywindow:setZOrderingEnabled(false)
	--mywindow:setTextExtends("오른쪽클럽이름", g_STRING_FONT_GULIMCHE, 11, 255,255,255,255,   0, 0,0,0,255)
	winMgr:getWindow(i .."Lobby_RoomList_ClubBackImg"):addChildWindow(mywindow)
	
	-- 클럼 마크 left
	mywindow = winMgr:createWindow('TaharezLook/StaticImage', i .."Lobby_RoomList_LeftClubEmblem_Img")
	mywindow:setTexture('Enabled', 'UIData/debug_b.tga', 0, 0)
	mywindow:setTexture('Disabled', 'UIData/debug_b.tga', 0, 0)
	mywindow:setProperty('BackgroundEnabled', 'False')
	mywindow:setProperty('FrameEnabled', 'False')
	mywindow:setPosition(4, 8)
	mywindow:setSize(32, 32)
	mywindow:setScaleWidth(163)
	mywindow:setScaleHeight(163)
	mywindow:setEnabled(false)
	winMgr:getWindow(i .."Lobby_RoomList_ClubBackImg"):addChildWindow(mywindow)
	
	-- 클럽 마크 right
	mywindow = winMgr:createWindow('TaharezLook/StaticImage', i .."Lobby_RoomList_RightClubEmblem_Img")
	mywindow:setTexture('Enabled', 'UIData/debug_b.tga', 0, 0)
	mywindow:setTexture('Disabled', 'UIData/debug_b.tga', 0, 0)
	mywindow:setProperty('BackgroundEnabled', 'False')
	mywindow:setProperty('FrameEnabled', 'False')
	mywindow:setPosition(145, 8)
	mywindow:setSize(32, 32)
	mywindow:setEnabled(false)
	mywindow:setScaleWidth(163)
	mywindow:setScaleHeight(163)
	winMgr:getWindow(i .."Lobby_RoomList_ClubBackImg"):addChildWindow(mywindow)
end


-- 8개의 방중에서 현재 방이 없을경우
function WndLobby_ClearBattleRoom()
	for i=0, MAX_ROOMPAGE-1 do
		winMgr:getWindow(i .. "sj_lobby_roomList_radioBtn"):setVisible(true)
		winMgr:getWindow(i .. "sj_lobby_roomList_radioBtn"):setEnabled(false)
		winMgr:getWindow(i .. "sj_lobby_roomList_radioBtn"):setUserString("RoomNumber", 0)
		
		winMgr:getWindow(i .. "sj_lobby_roomList_roomIndex"):setVisible(false)
		winMgr:getWindow(i .. "sj_lobby_roomList_roomTitle"):setVisible(false)
		winMgr:getWindow(i .. "sj_lobby_roomList_isTeamBattleRoom"):setVisible(false)
		winMgr:getWindow(i .. "sj_lobby_roomList_isItemBattleRoom"):setVisible(false)
		winMgr:getWindow(i .. "sj_lobby_roomList_isMRBattleRoom"):setVisible(false)
		winMgr:getWindow(i .. "sj_lobby_roomList_roomPassword"):setVisible(false)
		winMgr:getWindow(i .. "sj_lobby_roomList_roomCurrentUserNum"):setVisible(false)
		winMgr:getWindow(i .. "sj_lobby_roomList_roomRookieImage"):setVisible(false)
		winMgr:getWindow(i .. "sj_lobby_roomList_roomIsGamingAlphaImage"):setVisible(false)
		winMgr:getWindow(i .. "sj_lobby_roomList_roomIsGamingImage"):setVisible(false)
		winMgr:getWindow(i .. "sj_lobby_roomList_continueWinImage"):setVisible(false)
		winMgr:getWindow(i .. "sj_lobby_roomList_extremeImage"):setVisible(false)
		winMgr:getWindow(i .. "sj_lobby_roomList_autobalanceImage"):setVisible(false)
		winMgr:getWindow(i .. "sj_lobby_roomList_exceptEImage"):setVisible(false)
		winMgr:getWindow(i .. "sj_lobby_roomList_friendShipImage"):setVisible(false)
		winMgr:getWindow(i .. "Lobby_RoomList_LadderLimitImg"):setVisible(false)
		winMgr:getWindow(i .."Lobby_RoomList_ClubBackImg"):setVisible(false)
	end
end


-- MAX_ROOMPAGE의 방중에서 현재 생성되어 있는경우
function WndLobby_ExistBattleRoom(index, roomNumber, roomName, bTeam, bItem, 
			currentUser, maxUser, password, roomState, roomKind, extremeZen, continueWin, autobalance, gameMode, exceptE, friendShip, LadderLimit)

	-- 1. 번방 라디오버튼
	if gameMode == 0 then
		if bTeam == 1 then
			winMgr:getWindow(index .. "sj_lobby_roomList_radioBtn"):setTexture("Normal", "UIData/LobbyImage_new.tga", 0, 790)	-- 팀전
		else
			winMgr:getWindow(index .. "sj_lobby_roomList_radioBtn"):setTexture("Normal", "UIData/invisible.tga", 0, 0)			-- 개인전
		end
	elseif gameMode == 6 then
		winMgr:getWindow(index .. "sj_lobby_roomList_radioBtn"):setTexture("Normal", "UIData/LobbyImage_new.tga", 621, 881)		-- 몬스터 레이싱
	elseif gameMode == 8 then
		winMgr:getWindow(index .. "sj_lobby_roomList_radioBtn"):setTexture("Normal", "UIData/LobbyImage_new.tga", 665, 128)		-- 듀얼모드
	end
	
	winMgr:getWindow(index .. "sj_lobby_roomList_radioBtn"):setVisible(true)
	winMgr:getWindow(index .. "sj_lobby_roomList_radioBtn"):setEnabled(true)
	winMgr:getWindow(index .. "sj_lobby_roomList_radioBtn"):setUserString("RoomNumber", roomNumber)
	
	winMgr:getWindow(index .. "sj_lobby_roomList_roomIndex"):setVisible(true)
	winMgr:getWindow(index .. "sj_lobby_roomList_roomTitle"):setVisible(true)
	winMgr:getWindow(index .. "sj_lobby_roomList_isTeamBattleRoom"):setVisible(true)
	winMgr:getWindow(index .. "sj_lobby_roomList_isItemBattleRoom"):setVisible(true)
	winMgr:getWindow(index .. "sj_lobby_roomList_roomPassword"):setVisible(true)
	winMgr:getWindow(index .. "sj_lobby_roomList_roomCurrentUserNum"):setVisible(true)
	winMgr:getWindow(index .. "sj_lobby_roomList_roomIsGamingImage"):setVisible(true)
	winMgr:getWindow(index .. "sj_lobby_roomList_isMRBattleRoom"):setVisible(true)
	
	-- 2. 방번호
	local roomNum = GetStringSize(g_STRING_FONT_GULIMCHE, 14, tostring(roomNumber))
	winMgr:getWindow(index .. "sj_lobby_roomList_roomIndex"):setText(tostring(roomNumber))
	winMgr:getWindow(index .. "sj_lobby_roomList_roomIndex"):setPosition(20-roomNum/2, 11)

	-- 3. 제목
	local roomSummaryName = SummaryString(g_STRING_FONT_GULIMCHE, 13, roomName, 170)
	winMgr:getWindow(index .. "sj_lobby_roomList_roomTitle"):setText(roomSummaryName)
	
	
	-- 대기중일때
	if roomState == 0 then
	
		-- 4. 노템전, 아이템전
		if bItem == PLAYTYPE_NOITEM then
			winMgr:getWindow(index .. "sj_lobby_roomList_isItemBattleRoom"):setTexture("Disabled", "UIData/LobbyImage_new.tga", 354, 702)
		elseif bItem == PLAYTYPE_ITEM then
			winMgr:getWindow(index .. "sj_lobby_roomList_isItemBattleRoom"):setTexture("Disabled", "UIData/LobbyImage_new.tga", 408, 702)
		elseif bItem == PLAYTYPE_CLASS then
			winMgr:getWindow(index .. "sj_lobby_roomList_isItemBattleRoom"):setTexture("Disabled", "UIData/LobbyImage_new.tga", 311, 987)
		elseif bItem == 3 then
			winMgr:getWindow(index .. "sj_lobby_roomList_isItemBattleRoom"):setTexture("Disabled", "UIData/LobbyImage_new.tga", 408, 702)
		end	
		
		-- 5. 개인전, 팀전
		if bTeam == 1 then
			winMgr:getWindow(index .. "sj_lobby_roomList_isTeamBattleRoom"):setTexture("Disabled", "UIData/LobbyImage_new.tga", 516, 702)
		else
			winMgr:getWindow(index .. "sj_lobby_roomList_isTeamBattleRoom"):setTexture("Disabled", "UIData/LobbyImage_new.tga", 462, 702)
		end
		
		if gameMode == 0 then
			if bItem == 3 then
				winMgr:getWindow(index .. "sj_lobby_roomList_isMRBattleRoom"):setTexture("Disabled", "UIData/match003.tga", 516, 610)
			else
				winMgr:getWindow(index .. "sj_lobby_roomList_isMRBattleRoom"):setTexture("Disabled", "UIData/LobbyImage_new.tga", 354, 764)
			end
		elseif gameMode == 6 then
			winMgr:getWindow(index .. "sj_lobby_roomList_isMRBattleRoom"):setTexture("Disabled", "UIData/LobbyImage_new.tga", 462, 748)
		elseif gameMode == 8 then
			winMgr:getWindow(index .. "sj_lobby_roomList_isMRBattleRoom"):setTexture("Disabled", "UIData/match003.tga", 408, 610)
		elseif gameMode == 11 then --코인전
			winMgr:getWindow(index .. "sj_lobby_roomList_isMRBattleRoom"):setTexture("Disabled", "UIData/match003.tga", 462, 610)
		end
		
	-- 게임중일때
	else
		
		-- 4. 노템전, 아이템전
		if bItem == PLAYTYPE_NOITEM then
			winMgr:getWindow(index .. "sj_lobby_roomList_isItemBattleRoom"):setTexture("Disabled", "UIData/LobbyImage_new.tga", 354, 725)
		elseif bItem == PLAYTYPE_ITEM then
			winMgr:getWindow(index .. "sj_lobby_roomList_isItemBattleRoom"):setTexture("Disabled", "UIData/LobbyImage_new.tga", 408, 725)
		elseif bItem == PLAYTYPE_CLASS then
			winMgr:getWindow(index .. "sj_lobby_roomList_isItemBattleRoom"):setTexture("Disabled", "UIData/LobbyImage_new.tga", 311, 987)
		elseif bItem == 3 then
			winMgr:getWindow(index .. "sj_lobby_roomList_isItemBattleRoom"):setTexture("Disabled", "UIData/LobbyImage_new.tga", 408, 725)
		end	
		
		-- 5. 개인전, 팀전
		if bTeam == 1 then
			winMgr:getWindow(index .. "sj_lobby_roomList_isTeamBattleRoom"):setTexture("Disabled", "UIData/LobbyImage_new.tga", 516, 725)
		else
			winMgr:getWindow(index .. "sj_lobby_roomList_isTeamBattleRoom"):setTexture("Disabled", "UIData/LobbyImage_new.tga", 462, 725)
		end
		
		
		if gameMode == 0 then
			if bItem == 3 then
				winMgr:getWindow(index .. "sj_lobby_roomList_isMRBattleRoom"):setTexture("Disabled", "UIData/match003.tga", 516, 633)
			else
				winMgr:getWindow(index .. "sj_lobby_roomList_isMRBattleRoom"):setTexture("Disabled", "UIData/LobbyImage_new.tga", 408, 764)
			end
		elseif gameMode == 6 then
			winMgr:getWindow(index .. "sj_lobby_roomList_isMRBattleRoom"):setTexture("Disabled", "UIData/LobbyImage_new.tga", 516, 748)
		elseif gameMode == 8 then
			winMgr:getWindow(index .. "sj_lobby_roomList_isMRBattleRoom"):setTexture("Disabled", "UIData/match003.tga", 408, 633)
			
		elseif gameMode == 11 then --코인전
			winMgr:getWindow(index .. "sj_lobby_roomList_isMRBattleRoom"):setTexture("Disabled", "UIData/match003.tga", 462, 633)
		end
	end
	
	
	
	-- 6. 비밀번호
	if string.len(password) == 0 then
		winMgr:getWindow(index .. "sj_lobby_roomList_roomPassword"):setTexture("Disabled", "UIData/LobbyImage_new.tga", 667, 206)
	else
		winMgr:getWindow(index .. "sj_lobby_roomList_roomPassword"):setTexture("Disabled", "UIData/LobbyImage_new.tga", 682, 206)
	end	
	
	-- 7. 현재인원
	if currentUser == maxUser then
		winMgr:getWindow(index .. "sj_lobby_roomList_roomCurrentUserNum"):setTextColor(255,0,0,255)
	else
		winMgr:getWindow(index .. "sj_lobby_roomList_roomCurrentUserNum"):setTextColor(255,255,255,255)
	end
	local userString = currentUser .. " / " .. maxUser
	winMgr:getWindow(index .. "sj_lobby_roomList_roomCurrentUserNum"):setText(userString)
	
	
	-- 8. 룸상태(일반:0, 루키:1)
	if roomKind == 1 then
		winMgr:getWindow(index .. "sj_lobby_roomList_roomRookieImage"):setVisible(true)
	end
	
	
	-- 9. 게임중
	if roomState == 0 then
		if currentUser == maxUser then
			winMgr:getWindow(index .. "sj_lobby_roomList_roomIsGamingAlphaImage"):setVisible(true)
			
			-- 현재 선택이 되어있는데 full이 되면 선택된것 취소
			if CEGUI.toRadioButton(winMgr:getWindow(index .. "sj_lobby_roomList_radioBtn")):isSelected() then
				winMgr:getWindow(index .. "sj_lobby_roomList_radioBtn"):setProperty("Selected", "false")
			end
			winMgr:getWindow(index .. "sj_lobby_roomList_roomIsGamingImage"):setTexture("Disabled", "UIData/LobbyImage_new.tga", 354, 664)
		else
			winMgr:getWindow(index .. "sj_lobby_roomList_roomIsGamingAlphaImage"):setVisible(false)
			winMgr:getWindow(index .. "sj_lobby_roomList_roomIsGamingImage"):setTexture("Disabled", "UIData/LobbyImage_new.tga", 510, 664)
		end
		
	else
		winMgr:getWindow(index .. "sj_lobby_roomList_roomIsGamingAlphaImage"):setVisible(true)
		winMgr:getWindow(index .. "sj_lobby_roomList_roomIsGamingImage"):setTexture("Disabled", "UIData/LobbyImage_new.tga", 432, 664)
		
		-- 현재 선택이 되어있는데 게임이 시작되면 선택된것 취소
		if CEGUI.toRadioButton(winMgr:getWindow(index .. "sj_lobby_roomList_radioBtn")):isSelected() then
			winMgr:getWindow(index .. "sj_lobby_roomList_radioBtn"):setProperty("Selected", "false")
		end
	end
	
	-- 10. 연승방
	if continueWin >= 2 then
		winMgr:getWindow(index .. "sj_lobby_roomList_continueWinImage"):setVisible(true)
		winMgr:getWindow(index .. "sj_lobby_roomList_continueWinText"):clearTextExtends()
		winMgr:getWindow(index .. "sj_lobby_roomList_continueWinText"):setTextExtends(continueWin, g_STRING_FONT_GULIMCHE, 13, 0,0,0,255,   0, 0,0,0,255)
		
	end
	
	
	-- 11. 익스트림 모드
	if g_BattleMode == BATTLETYPE_EXTREME then
		winMgr:getWindow(index .. "sj_lobby_roomList_extremeImage"):setVisible(true)
		
		local extremeString = CommatoMoneyStr(extremeZen)
		winMgr:getWindow(index .. "sj_lobby_roomList_extremeZenText"):clearTextExtends()
		winMgr:getWindow(index .. "sj_lobby_roomList_extremeZenText"):setTextExtends(extremeString, g_STRING_FONT_GULIMCHE, 15, 0,255,0,255,   2, 0,0,0,255)
	end
	
	-- 12. 자동 팀균형
	if autobalance == 1 then
		winMgr:getWindow(index .. "sj_lobby_roomList_autobalanceImage"):setVisible(true)
	end
	
	-- 13. E필살기 제외
	if exceptE == 1 then
		if roomState == 0 then
			if currentUser == maxUser then
				winMgr:getWindow(index .. "sj_lobby_roomList_exceptEImage"):setTexture("Enabled", "UIData/LobbyImage_new.tga", 998, 344)
				winMgr:getWindow(index .. "sj_lobby_roomList_exceptEImage"):setTexture("Disabled", "UIData/LobbyImage_new.tga", 998, 344)
				winMgr:getWindow(index .. "sj_lobby_roomList_exceptEImage"):setVisible(true)
			else
				winMgr:getWindow(index .. "sj_lobby_roomList_exceptEImage"):setTexture("Enabled", "UIData/LobbyImage_new.tga", 998, 370)
				winMgr:getWindow(index .. "sj_lobby_roomList_exceptEImage"):setTexture("Disabled", "UIData/LobbyImage_new.tga", 998, 370)
				winMgr:getWindow(index .. "sj_lobby_roomList_exceptEImage"):setVisible(true)
			end
		else
			winMgr:getWindow(index .. "sj_lobby_roomList_exceptEImage"):setTexture("Enabled", "UIData/LobbyImage_new.tga", 998, 344)
			winMgr:getWindow(index .. "sj_lobby_roomList_exceptEImage"):setTexture("Disabled", "UIData/LobbyImage_new.tga", 998, 344)
			winMgr:getWindow(index .. "sj_lobby_roomList_exceptEImage"):setVisible(true)
		end
	end
	
	-- 14. 친선, 래더
	if friendShip == 1 then
		winMgr:getWindow(index .. "sj_lobby_roomList_friendShipImage"):setVisible(true)
	end

	-- 15. 래더 제한	
	if LadderLimit ~= -1 then
		LadderPointImageSetting(LadderLimit + 1, index)
		winMgr:getWindow(index .. "Lobby_RoomList_LadderLimitImg"):setVisible(true)
	else
		winMgr:getWindow(index .. "Lobby_RoomList_LadderLimitImg"):setVisible(false)
	end
end

function LadderPointImageSetting(Number, Index)

	local MaxLadder = Number + 2
	local MinLadder = Number - 2
	
	if MaxLadder >= 10 then
		local TexXTen = MaxLadder / 10
		local TexXOne = MaxLadder % 10
		
		winMgr:getWindow(Index.."Lobby_RoomList_LadderLimit_Max_Ten_Img"):setVisible(true)
		winMgr:getWindow(Index.."Lobby_RoomList_LadderLimit_Max_One_Img"):setVisible(true)
	
		winMgr:getWindow(Index.."Lobby_RoomList_LadderLimit_Max_Ten_Img"):setTexture("Enabled", "UIData/option.tga", 818 + (TexXTen * 8), 911)
		winMgr:getWindow(Index.."Lobby_RoomList_LadderLimit_Max_Ten_Img"):setTexture("Disabled", "UIData/option.tga", 818 + (TexXTen * 8), 911)
	
		winMgr:getWindow(Index.."Lobby_RoomList_LadderLimit_Max_One_Img"):setPosition(73, 4)
		winMgr:getWindow(Index.."Lobby_RoomList_LadderLimit_Max_One_Img"):setTexture("Enabled", "UIData/option.tga", 818 + (TexXOne * 8), 911)
		winMgr:getWindow(Index.."Lobby_RoomList_LadderLimit_Max_One_Img"):setTexture("Disabled", "UIData/option.tga", 818 + (TexXOne * 8), 911)			
	elseif MaxLadder < 10 then
	
		winMgr:getWindow(Index.."Lobby_RoomList_LadderLimit_Max_Ten_Img"):setVisible(false)
		winMgr:getWindow(Index.."Lobby_RoomList_LadderLimit_Max_One_Img"):setVisible(true)
	
		winMgr:getWindow(Index.."Lobby_RoomList_LadderLimit_Max_One_Img"):setPosition(69, 4)
		winMgr:getWindow(Index.."Lobby_RoomList_LadderLimit_Max_One_Img"):setTexture("Enabled", "UIData/option.tga", 818 + (MaxLadder * 8), 911)
		winMgr:getWindow(Index.."Lobby_RoomList_LadderLimit_Max_One_Img"):setTexture("Disabled", "UIData/option.tga", 818 + (MaxLadder * 8), 911)
	end
	
	if MinLadder >= 10 then
		local TexXTen = MinLadder / 10
		local TexXOne = MinLadder % 10
		
		winMgr:getWindow(Index.."Lobby_RoomList_LadderLimit_Min_Ten_Img"):setVisible(true)
		winMgr:getWindow(Index.."Lobby_RoomList_LadderLimit_Min_One_Img"):setVisible(true)
		
		winMgr:getWindow(Index.."Lobby_RoomList_LadderLimit_Min_Ten_Img"):setTexture("Enabled", "UIData/option.tga", 818 + (TexXTen * 8), 911)
		winMgr:getWindow(Index.."Lobby_RoomList_LadderLimit_Min_Ten_Img"):setTexture("Disabled", "UIData/option.tga", 818 + (TexXTen * 8), 911)
		
		winMgr:getWindow(Index.."Lobby_RoomList_LadderLimit_Min_One_Img"):setPosition(29, 4)
		winMgr:getWindow(Index.."Lobby_RoomList_LadderLimit_Min_One_Img"):setTexture("Enabled", "UIData/option.tga", 818 + (TexXOne * 8), 911)
		winMgr:getWindow(Index.."Lobby_RoomList_LadderLimit_Min_One_Img"):setTexture("Disabled", "UIData/option.tga", 818 + (TexXOne * 8), 911)
		
	elseif MinLadder < 10 then
	
		if MinLadder <= 0 then
			MinLadder = 1
		end
		
		winMgr:getWindow(Index.."Lobby_RoomList_LadderLimit_Min_Ten_Img"):setVisible(false)
		winMgr:getWindow(Index.."Lobby_RoomList_LadderLimit_Min_One_Img"):setVisible(true)

		winMgr:getWindow(Index.."Lobby_RoomList_LadderLimit_Min_One_Img"):setPosition(25, 4)
		winMgr:getWindow(Index.."Lobby_RoomList_LadderLimit_Min_One_Img"):setTexture("Enabled", "UIData/option.tga", 818 + (MinLadder * 8), 911)
		winMgr:getWindow(Index.."Lobby_RoomList_LadderLimit_Min_One_Img"):setTexture("Disabled", "UIData/option.tga", 818 + (MinLadder * 8), 911)
	end
end



-- 대전방 더블클릭 했을경우(해당 룸으로 들어간다)
function EnterBattleRoom(args)
	local roomNumber
	for i=0, MAX_ROOMPAGE-1 do
		if CEGUI.toRadioButton(winMgr:getWindow(i .. "sj_lobby_roomList_radioBtn")):isSelected() then
			roomNumber = winMgr:getWindow(i .. "sj_lobby_roomList_radioBtn"):getUserString("RoomNumber")
			WndLobby_EnterBattleRoom(tonumber(roomNumber), true)
			return
		end
	end
	
	ShowNotifyOKMessage_Lua(g_STRING_SELECTROOM)
end





--------------------------------------------------------------------

-- 방만들기, 입장하기 버튼

--------------------------------------------------------------------
tLobbyButtonName  = { ["protectErr"]=0, "sj_lobby_enterRoomBtn", "sj_lobby_makeRoomBtn" }
tLobbyButtonTexX  = { ["protectErr"]=0, 581, 697 }
tLobbyButtonPosX  = { ["protectErr"]=0, 30, 290 }
tLobbyButtonEvent = { ["protectErr"]=0, "EnterBattleRoom", "CreateBattleRoom" }

for i=1, #tLobbyButtonName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tLobbyButtonName[i])
	mywindow:setTexture("Normal", "UIData/mainBG_Button002.tga", tLobbyButtonTexX[i], 512)
	mywindow:setTexture("Hover", "UIData/mainBG_Button002.tga", tLobbyButtonTexX[i], 555)
	mywindow:setTexture("Pushed", "UIData/mainBG_Button002.tga", tLobbyButtonTexX[i], 598)
	mywindow:setTexture("PushedOff", "UIData/mainBG_Button002.tga", tLobbyButtonTexX[i], 512)
	mywindow:setWideType(6);
	mywindow:setPosition(tLobbyButtonPosX[i], 460)
	mywindow:setSize(116, 42)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", tLobbyButtonEvent[i])
	mywindow:setSubscribeEvent('MouseButtonDown', 'BattleRoomMouseClick');
	mywindow:setSubscribeEvent('MouseEnter', 'BattleRoomMouseEnter');
	root:addChildWindow(mywindow)
end


function CreateBattleRoom()

	-- 익스트림 모드일 경우
	if g_BattleMode == BATTLETYPE_NORMAL then
		winMgr:getWindow("sj_lobby_extreme_backImage"):setVisible(false)
		winMgr:getWindow("sj_lobby_extreme_backImage"):setVisible(false)
		
	elseif g_BattleMode == BATTLETYPE_EXTREME then
		winMgr:getWindow("sj_lobby_extreme_backImage"):setVisible(true)
		winMgr:getWindow("sj_lobby_extreme_backImage"):setVisible(true)
	end
	
	InitBattleRoomInfo()
	InitGameMode()
	InitTeamBattle()
	InitItemBattle()
	InitLadderType()
	InitUserNum()
	InitAutoBalance()
	--InitExceptE()
	InitLadderLimit()
	
	local MAX_ROOM_NAME = #tRoomName
	winMgr:getWindow("sj_lobby_roomInfo_title"):setText(tRoomName[WndLobby_RandomRoomName(MAX_ROOM_NAME)])
	winMgr:getWindow("sj_lobby_roomInfo_password"):setText("")
	winMgr:getWindow("sj_lobby_makeroomAlphaWindow"):setVisible(true)
	winMgr:getWindow("sj_lobby_makeroom_tempBackImage"):setVisible(true)
	
	-- 방만들기 창이 있으면 채팅창을 비활성 시킨다
	Chatting_SetChatEnabled(false)
end


--------------------------------------------------------------------

-- 대기방 보기, 모든방 보기(토글 버튼)

--------------------------------------------------------------------
local g_roomShowMode = 0
ttoggleButtonTexX = { ["protectErr"]=0, [0]=465, 349 }
togglewindow = winMgr:createWindow("TaharezLook/Button", "sj_lobby_showRoom_toggleBtn")
togglewindow:setTexture("Normal", "UIData/mainBG_Button002.tga", ttoggleButtonTexX[g_roomShowMode], 512)
togglewindow:setTexture("Hover", "UIData/mainBG_Button002.tga", ttoggleButtonTexX[g_roomShowMode], 555)
togglewindow:setTexture("Pushed", "UIData/mainBG_Button002.tga", ttoggleButtonTexX[g_roomShowMode], 598)
togglewindow:setTexture("PushedOff", "UIData/mainBG_Button002.tga", ttoggleButtonTexX[g_roomShowMode], 512)
togglewindow:setWideType(6);
togglewindow:setPosition(160, 460)
togglewindow:setSize(116, 42)
togglewindow:setZOrderingEnabled(false)
togglewindow:subscribeEvent("Clicked", "ShowRoomMethodEvent")
togglewindow:setSubscribeEvent('MouseButtonDown', 'BattleRoomMouseClick');
togglewindow:setSubscribeEvent('MouseEnter', 'BattleRoomMouseEnter');
root:addChildWindow(togglewindow)

-- 기본이 모든방 보기
WndLobby_SetRoomMode(0)
g_roomShowMode = WndLobby_GetRoomMode()
function ShowRoomMethodEvent()
	if g_roomShowMode == 0 then
		g_roomShowMode = 1
	elseif g_roomShowMode == 1 then
		g_roomShowMode = 0
	end
	
	WndLobby_SetRoomMode(g_roomShowMode)
	
	togglewindow:setTexture("Normal", "UIData/mainBG_Button002.tga", ttoggleButtonTexX[g_roomShowMode], 512)
	togglewindow:setTexture("Hover", "UIData/mainBG_Button002.tga", ttoggleButtonTexX[g_roomShowMode], 555)
	togglewindow:setTexture("Pushed", "UIData/mainBG_Button002.tga", ttoggleButtonTexX[g_roomShowMode], 598)
	togglewindow:setTexture("PushedOff", "UIData/mainBG_Button002.tga", ttoggleButtonTexX[g_roomShowMode], 512)
	
	-- 모든방 선택 해제
	for i=0, MAX_ROOMPAGE-1 do
		winMgr:getWindow(i .. "sj_lobby_roomList_radioBtn"):setProperty("Selected", "false")
	end
end



--------------------------------------------------------------------

-- 방리스트 변경 좌, 우 버튼

--------------------------------------------------------------------

tRoomListLRButtonName  = { ["protecterr"]=0, "sj_lobby_roomlist_LBtn", "sj_lobby_roomlist_RBtn" }
tRoomListLRButtonTexX  = { ["protecterr"]=0, 987, 970}
tRoomListLRButtonPosX  = { ["protecterr"]=0, 497, 630 }
tRoomListLRButtonEvent = { ["protecterr"]=0, "ChagneRoomList_L", "ChagneRoomList_R" }
for i=1, 2 do
	mywindow = winMgr:createWindow("TaharezLook/Button", tRoomListLRButtonName[i])
	mywindow:setTexture("Normal", "UIData/myinfo.tga", tRoomListLRButtonTexX[i], 0)
	mywindow:setTexture("Hover", "UIData/myinfo.tga", tRoomListLRButtonTexX[i], 22)
	mywindow:setTexture("Pushed", "UIData/myinfo.tga", tRoomListLRButtonTexX[i], 44)
	mywindow:setTexture("PushedOff", "UIData/myinfo.tga", tRoomListLRButtonTexX[i], 0)
	mywindow:setWideType(6);
	mywindow:setPosition(tRoomListLRButtonPosX[i], 470)
	mywindow:setSize(17, 22)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", tRoomListLRButtonEvent[i])
	root:addChildWindow(mywindow)
end

-- 룸리스트를 변경한후 그 페이지의 정보를 셋팅해야 한다.
function ChagneRoomList_L()
	local currRoomNum = WndLobby_GetCurrentRoomPage()
	if currRoomNum > 0 then
		currRoomNum = currRoomNum - 1
		WndLobby_ChangeCurrentRoomPage(tonumber(currRoomNum))
	end	
end


function ChagneRoomList_R()
	local currRoomNum = WndLobby_GetCurrentRoomPage()
	local maxRoomNum  = WndLobby_GetMaxRoomPage()
	if currRoomNum < maxRoomNum then
		currRoomNum = currRoomNum + 1
		WndLobby_ChangeCurrentRoomPage(tonumber(currRoomNum))
	end	
end


-- 랜덤 빠른시작
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_lobby_fastMatch_random")
mywindow:setTexture("Normal", "UIData/LobbyImage_new002.tga", 290, 0)
mywindow:setTexture("Hover", "UIData/LobbyImage_new002.tga", 290, 71)
mywindow:setTexture("Pushed", "UIData/LobbyImage_new002.tga", 290, 142)
mywindow:setTexture("PushedOff", "UIData/LobbyImage_new002.tga", 290, 0)
mywindow:setWideType(6);
mywindow:setPosition(712, 535)
mywindow:setSize(275, 71)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "WndLobby_JustGo_Random")
mywindow:setSubscribeEvent('MouseButtonDown', 'BattleRoomMouseClick');
mywindow:setSubscribeEvent('MouseEnter', 'BattleRoomMouseEnter');
root:addChildWindow(mywindow)

-- 조건 빠른시작
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_lobby_fastMatch_adjust")
mywindow:setTexture("Normal", "UIData/LobbyImage_new002.tga", 565, 0)
mywindow:setTexture("Hover", "UIData/LobbyImage_new002.tga", 565, 74)
mywindow:setTexture("Pushed", "UIData/LobbyImage_new002.tga", 565, 148)
mywindow:setTexture("PushedOff", "UIData/LobbyImage_new002.tga", 565, 0)
mywindow:setWideType(6);
mywindow:setPosition(711, 611)
mywindow:setSize(200, 74)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickFitMatchButton")
mywindow:setSubscribeEvent('MouseButtonDown', 'BattleRoomMouseClick');
mywindow:setSubscribeEvent('MouseEnter', 'BattleRoomMouseEnter');
--root:addChildWindow(mywindow)

-- 퀵 매치 설정버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_lobby_fastMatch_adjustBox")
mywindow:setTexture("Normal", "UIData/LobbyImage_new002.tga", 765, 0)
mywindow:setTexture("Hover", "UIData/LobbyImage_new002.tga", 765, 73)
mywindow:setTexture("Pushed", "UIData/LobbyImage_new002.tga", 765, 146)
mywindow:setTexture("PushedOff", "UIData/LobbyImage_new002.tga", 765, 0)
mywindow:setWideType(6);
mywindow:setPosition(915, 611)
mywindow:setSize(73, 73)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "CallQuckMatchAdjustBox")
mywindow:setSubscribeEvent('MouseButtonDown', 'BattleRoomMouseClick');
mywindow:setSubscribeEvent('MouseEnter', 'BattleRoomMouseEnter');
--root:addChildWindow(mywindow)

function CallQuckMatchAdjustBox()
	winMgr:getWindow("sj_lobby_quickmatchAlphaWindow"):setVisible(true)
	winMgr:getWindow("sj_lobby_quickmatch_tempBackImage"):setVisible(true)
end

-- 클럽대전결과
mywindow = winMgr:createWindow("TaharezLook/Button", "NewClublobby_pvp_resultBtn")
mywindow:setTexture("Normal", "UIData/match001.tga", 747, 591)
mywindow:setTexture("Hover", "UIData/match001.tga", 747, 591+73)
mywindow:setTexture("Pushed", "UIData/match001.tga", 747, 591+146)
mywindow:setTexture("PushedOff", "UIData/match001.tga", 747, 591)
mywindow:setWideType(6);
mywindow:setPosition(710, 610)
mywindow:setSize(277, 73)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "CallGetMatchHistory")
mywindow:setSubscribeEvent('MouseButtonDown', 'BattleRoomMouseClick');
mywindow:setSubscribeEvent('MouseEnter', 'BattleRoomMouseEnter');
root:addChildWindow(mywindow)


-- 백그라운드 알파 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_lobby_quickmatchAlphaWindow")
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

-- 퀵매치 알파창 ESC키, ENTER키 등록
RegistEscEventInfo("sj_lobby_quickmatchAlphaWindow", "QuickMatchAdjust_OK")
RegistEnterEventInfo("sj_lobby_quickmatchAlphaWindow", "QuickMatchAdjust_OK")

quickmatchBackwindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_lobby_quickmatch_tempBackImage")
quickmatchBackwindow:setTexture("Enabled", "UIData/LobbyImage_new002.tga", 0, 284)
quickmatchBackwindow:setTexture("Disabled", "UIData/LobbyImage_new002.tga", 0, 284)
quickmatchBackwindow:setProperty("FrameEnabled", "False")
quickmatchBackwindow:setProperty("BackgroundEnabled", "False")
quickmatchBackwindow:setWideType(6);
quickmatchBackwindow:setPosition(254, 241)
quickmatchBackwindow:setSize(515, 236)
quickmatchBackwindow:setVisible(false)
quickmatchBackwindow:setAlwaysOnTop(true)
quickmatchBackwindow:setZOrderingEnabled(false)
root:addChildWindow(quickmatchBackwindow)

local NOT_CHECK = 0
local SELECTED	= 1

-- Match 체크박스
local MATCH_DEATHMATCH		= 1
local MATCH_MONSTERRACING	= 1
local MATCH_DUALMATCH		= 1
local MATCH_COINMATCH		= 1
local MATCH_BOMBMATCH		= 1
local MATCH_MINITOWERMATCH	= 1

local tMatchKorName   = {['err'] = 0, [0]= "Lobby_CheckBox_DeathMatch", "Lobby_CheckBox_DualMatch", "Lobby_CheckBox_CoinMatch",
							"Lobby_CheckBox_BombMatch"}
							
local tMatchEngName   = {['err'] = 0, [0]= "Lobby_CheckBox_DeathMatch", "Lobby_CheckBox_MonsterRacing", "Lobby_CheckBox_DualMatch"}

							
local tMatchThaiName  = {['err'] = 0, [0]= "Lobby_CheckBox_DeathMatch", "Lobby_CheckBox_MonsterRacing", "Lobby_CheckBox_DualMatch",
							"Lobby_CheckBox_CoinMatch"}

local tMatchMasName  = {['err'] = 0, [0]= "Lobby_CheckBox_DeathMatch", "Lobby_CheckBox_MonsterRacing", "Lobby_CheckBox_DualMatch",
							"Lobby_CheckBox_CoinMatch"}

local tMatchIdnName  = {['err'] = 0, [0]= "Lobby_CheckBox_DeathMatch", "Lobby_CheckBox_MonsterRacing", "Lobby_CheckBox_DualMatch",
							"Lobby_CheckBox_CoinMatch"}
							
local tMatchGSOName  = {['err'] = 0, [0]= "Lobby_CheckBox_DeathMatch", "Lobby_CheckBox_MonsterRacing", "Lobby_CheckBox_DualMatch",
							"Lobby_CheckBox_CoinMatch"}
							
local tMatchPosX  = {['err'] = 0, [0]= 112, 209, 306, 112}
local tMatchPosY  = {['err'] = 0, [0]= 39,  39, 39, 77}

local tMatchKorEvent  = {['err'] = 0, [0]= "DeathMatchCheck", "DualMatchCheck",     "CoiMatchCheck",  "BombMatchCheck"}
local tMatchEngEvent  = {['err'] = 0, [0]= "DeathMatchCheck", "MonsterRacingCheck", "DualMatchCheck", "CoiMatchCheck"}
local tMatchThaiEvent = {['err'] = 0, [0]= "DeathMatchCheck", "MonsterRacingCheck", "DualMatchCheck", "CoiMatchCheck"}
local tMatchMasEvent  = {['err'] = 0, [0]= "DeathMatchCheck", "MonsterRacingCheck", "DualMatchCheck", "CoiMatchCheck"}
local tMatchIdnEvent  = {['err'] = 0, [0]= "DeathMatchCheck", "MonsterRacingCheck", "DualMatchCheck", "CoiMatchCheck"}
local tMatchGSPEvent  = {['err'] = 0, [0]= "DeathMatchCheck", "MonsterRacingCheck", "DualMatchCheck", "CoiMatchCheck"}


local tLanguageMatchName  = {['err'] = 0, [0]= tMatchEngName,  tMatchKorName,  tMatchThaiName,		tMatchMasName,	tMatchIdnName, tMatchGSPName }
local tLanguageMatchEvent = {['err'] = 0, [0]= tMatchEngEvent, tMatchKorEvent, tMatchThaiEvent,		tMatchMasEvent,	tMatchIdnEvent, tMatchGSPEvent } 


for i=0, #tLanguageMatchName[LANGUAGECODE] do
	mywindow = winMgr:createWindow("TaharezLook/Checkbox", tLanguageMatchName[LANGUAGECODE][i])
	mywindow:setTexture("Normal", "UIData/invisible.tga", 515, 284)
	mywindow:setTexture("Hover", "UIData/invisible.tga", 515, 284)
	mywindow:setTexture("Pushed", "UIData/LobbyImage_new002.tga", 515, 284)
	mywindow:setTexture("PushedOff", "UIData/invisible.tga", 515, 284)
	mywindow:setTexture("SelectedNormal", "UIData/LobbyImage_new002.tga", 515, 284)
	mywindow:setTexture("SelectedHover", "UIData/LobbyImage_new002.tga", 515, 284)
	mywindow:setTexture("SelectedPushed", "UIData/LobbyImage_new002.tga", 515, 284)
	mywindow:setTexture("SelectedPushedOff", "UIData/invisible.tga", 515, 284)
	mywindow:setPosition(tMatchPosX[i], tMatchPosY[i])
	mywindow:setSize(27, 27)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setProperty("Selected", "false")
	mywindow:subscribeEvent("CheckStateChanged", tLanguageMatchEvent[LANGUAGECODE][i])
	quickmatchBackwindow:addChildWindow(mywindow)
end

function DeathMatchCheck(args)
	if CEGUI.toCheckbox(CEGUI.toWindowEventArgs(args).window):isSelected() then
		MATCH_DEATHMATCH = SELECTED
	else
		MATCH_DEATHMATCH = NOT_CHECK
	end
end

function MonsterRacingCheck(args)
	if CEGUI.toCheckbox(CEGUI.toWindowEventArgs(args).window):isSelected() then
		MATCH_MONSTERRACING = SELECTED
	else
		MATCH_MONSTERRACING = NOT_CHECK
	end
end

function DualMatchCheck(args)
	if CEGUI.toCheckbox(CEGUI.toWindowEventArgs(args).window):isSelected() then
		MATCH_DUALMATCH = SELECTED
	else
		MATCH_DUALMATCH = NOT_CHECK
	end
end

function CoiMatchCheck(args)
	if CEGUI.toCheckbox(CEGUI.toWindowEventArgs(args).window):isSelected() then
		MATCH_COINMATCH = SELECTED
	else
		MATCH_COINMATCH = NOT_CHECK
	end
end

function BombMatchCheck(args)
	if CEGUI.toCheckbox(CEGUI.toWindowEventArgs(args).window):isSelected() then
		MATCH_BOMBMATCH = SELECTED
	else
		MATCH_BOMBMATCH = NOT_CHECK
	end
end

-- Mode 체크박스
local MODE_PRIVATE  = SELECTED
local MODE_TEAM     = SELECTED

local tModeName  = {['err'] = 0, [0]= "sj_lobby_checkbox_privateMode", "sj_lobby_checkbox_teamMode"}
local tModePosX  = {['err'] = 0, [0]= 112, 209 }
local tModeEvent = {['err'] = 0, [0]= "PrivateModeCheck", "TeamModeCheck"}

for i=0, #tModeName do
	mywindow = winMgr:createWindow("TaharezLook/Checkbox", tModeName[i])
	mywindow:setTexture("Normal", "UIData/invisible.tga", 515, 284)
	mywindow:setTexture("Hover", "UIData/invisible.tga", 515, 284)
	mywindow:setTexture("Pushed", "UIData/LobbyImage_new002.tga", 515, 284)
	mywindow:setTexture("PushedOff", "UIData/invisible.tga", 515, 284)
	mywindow:setTexture("SelectedNormal", "UIData/LobbyImage_new002.tga", 515, 284)
	mywindow:setTexture("SelectedHover", "UIData/LobbyImage_new002.tga", 515, 284)
	mywindow:setTexture("SelectedPushed", "UIData/LobbyImage_new002.tga", 515, 284)
	mywindow:setTexture("SelectedPushedOff", "UIData/invisible.tga", 515, 284)
	mywindow:setPosition(tModePosX[i], 115)
	mywindow:setSize(27, 27)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setProperty("Selected", "false")
	mywindow:subscribeEvent("CheckStateChanged", tModeEvent[i])
	quickmatchBackwindow:addChildWindow(mywindow)
end

function PrivateModeCheck(args)
	if CEGUI.toCheckbox(CEGUI.toWindowEventArgs(args).window):isSelected() then
		MODE_PRIVATE = SELECTED
	else
		MODE_PRIVATE = NOT_CHECK
	end
end

function TeamModeCheck(args)
	if CEGUI.toCheckbox(CEGUI.toWindowEventArgs(args).window):isSelected() then
		MODE_TEAM = SELECTED
	else
		MODE_TEAM = NOT_CHECK
	end
end


-- Type 체크박스
local TYPE_NOITEM = SELECTED
local TYPE_ITEM   = SELECTED
local TYPE_CLASS  = SELECTED

local tTypeName   = {['err'] = 0, [0]= "sj_lobby_checkbox_NoItemType", "sj_lobby_checkbox_ItemType", "sj_lobby_checkbox_ClassType"}
local tTypeEvent  = {['err'] = 0, [0]= "NoItemTypeCheck", "ItemTypeCheck", "ClassTypeCheck"}

local tTypePosX  = {['err'] = 0, [0]= 112, 209, 306 }

if IsKoreanLanguage() then
	mywindow = winMgr:createWindow("TaharezLook/Checkbox", "sj_lobby_checkbox_ItemType")
	mywindow:setTexture("Normal", "UIData/invisible.tga", 515, 284)
	mywindow:setTexture("Hover", "UIData/invisible.tga", 515, 284)
	mywindow:setTexture("Pushed", "UIData/LobbyImage_new002.tga", 515, 284)
	mywindow:setTexture("PushedOff", "UIData/invisible.tga", 515, 284)
	mywindow:setTexture("SelectedNormal", "UIData/LobbyImage_new002.tga", 515, 284)
	mywindow:setTexture("SelectedHover", "UIData/LobbyImage_new002.tga", 515, 284)
	mywindow:setTexture("SelectedPushed", "UIData/LobbyImage_new002.tga", 515, 284)
	mywindow:setTexture("SelectedPushedOff", "UIData/invisible.tga", 515, 284)
	mywindow:setPosition(tTypePosX[i], 152)
	mywindow:setSize(27, 27)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setProperty("Selected", "false")
	mywindow:subscribeEvent("CheckStateChanged", "ItemTypeCheck")
	quickmatchBackwindow:addChildWindow(mywindow)
else
	for i=0, #tTypeName do
		mywindow = winMgr:createWindow("TaharezLook/Checkbox", tTypeName[i])
		mywindow:setTexture("Normal", "UIData/invisible.tga", 515, 284)
		mywindow:setTexture("Hover", "UIData/invisible.tga", 515, 284)
		mywindow:setTexture("Pushed", "UIData/LobbyImage_new002.tga", 515, 284)
		mywindow:setTexture("PushedOff", "UIData/invisible.tga", 515, 284)
		mywindow:setTexture("SelectedNormal", "UIData/LobbyImage_new002.tga", 515, 284)
		mywindow:setTexture("SelectedHover", "UIData/LobbyImage_new002.tga", 515, 284)
		mywindow:setTexture("SelectedPushed", "UIData/LobbyImage_new002.tga", 515, 284)
		mywindow:setTexture("SelectedPushedOff", "UIData/invisible.tga", 515, 284)
		mywindow:setPosition(tTypePosX[i], 152)
		mywindow:setSize(27, 27)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:setProperty("Selected", "false")
		mywindow:subscribeEvent("CheckStateChanged", tTypeEvent[i])
		quickmatchBackwindow:addChildWindow(mywindow)
	end
end


function NoItemTypeCheck(args)
	if CEGUI.toCheckbox(CEGUI.toWindowEventArgs(args).window):isSelected() then
		TYPE_NOITEM = SELECTED
	else
		TYPE_NOITEM = NOT_CHECK
	end
end

function ItemTypeCheck(args)
	if CEGUI.toCheckbox(CEGUI.toWindowEventArgs(args).window):isSelected() then
		TYPE_ITEM = SELECTED
	else
		TYPE_ITEM = NOT_CHECK
	end
end

function ClassTypeCheck(args)
	if CEGUI.toCheckbox(CEGUI.toWindowEventArgs(args).window):isSelected() then
		TYPE_CLASS = SELECTED
	else
		TYPE_CLASS = NOT_CHECK
	end
end


-- 조건 확인 버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_lobby_quickmatch_okBtn")
mywindow:setTexture("Normal", "UIData/Profile001.tga",813, 324)
mywindow:setTexture("Hover", "UIData/Profile001.tga", 813, 351)
mywindow:setTexture("Pushed", "UIData/Profile001.tga", 813, 378)
mywindow:setTexture("PushedOff", "UIData/Profile001.tga", 813, 324)
mywindow:setPosition(420, 196)
mywindow:setSize(81, 27)
mywindow:setAlwaysOnTop(true)
mywindow:subscribeEvent("Clicked", "QuickMatchAdjust_OK")
quickmatchBackwindow:addChildWindow(mywindow)

function QuickMatchAdjust_OK()
	winMgr:getWindow("sj_lobby_quickmatchAlphaWindow"):setVisible(false)
	winMgr:getWindow("sj_lobby_quickmatch_tempBackImage"):setVisible(false)
	
	WndLobby_FileSaveFixMatch( MATCH_DEATHMATCH, MATCH_MONSTERRACING, MATCH_DUALMATCH,
								MATCH_COINMATCH, MATCH_BOMBMATCH,
								MODE_PRIVATE, MODE_TEAM,
								TYPE_NOITEM, TYPE_ITEM, TYPE_CLASS )
end

function ClickFitMatchButton()
	WndLobby_JustGo_Adjust( MATCH_DEATHMATCH, MATCH_MONSTERRACING, MATCH_DUALMATCH,
							MATCH_COINMATCH,
							MODE_PRIVATE, MODE_TEAM,
							TYPE_NOITEM, TYPE_ITEM, TYPE_CLASS,
							MATCH_BOMBMATCH )
end

-- 초기설정
function SetFitMatchInfo( _MATCH_DEATHMATCH, _MATCH_MONSTERRACING, _MATCH_DUALMATCH,
						  _MATCH_COINMATCH, _MATCH_BOMBMATCH, _MATCH_MINITOWERMATCH,
						  _MODE_PRIVATE, _MODE_TEAM,
						  _TYPE_NOITEM, _TYPE_ITEM, _TYPE_CLASS )
						  
	MATCH_DEATHMATCH	= _MATCH_DEATHMATCH
	MATCH_MONSTERRACING	= _MATCH_MONSTERRACING
	MATCH_DUALMATCH		= _MATCH_DUALMATCH
	
	--0426KSG삭제
	--if IsEngLanguage() then
	--	MATCH_COINMATCH		= 0
	--	MATCH_BOMBMATCH		= 0
	--else
	
	if IsKoreanLanguage() then
		MATCH_COINMATCH			= _MATCH_COINMATCH
		MATCH_BOMBMATCH			= _MATCH_BOMBMATCH
		MATCH_MINITOWERMATCH	= _MATCH_MINITOWERMATCH
	else
		MATCH_COINMATCH			= _MATCH_COINMATCH
		MATCH_BOMBMATCH			= 0
		MATCH_MINITOWERMATCH	= 0
	end
	
	MODE_PRIVATE		= _MODE_PRIVATE
	MODE_TEAM			= _MODE_TEAM
	TYPE_NOITEM			= _TYPE_NOITEM
	TYPE_ITEM			= _TYPE_ITEM
	TYPE_CLASS			= _TYPE_CLASS
	
	-- MATCH
	if MATCH_DEATHMATCH == 1 then
		local WindowData = winMgr:getWindow("Lobby_CheckBox_DeathMatch")
		
		if WindowData ~= nil then
			winMgr:getWindow("Lobby_CheckBox_DeathMatch"):setProperty("Selected", "true")			
		end
	else
		local WindowData = winMgr:getWindow("Lobby_CheckBox_DeathMatch")
		
		if WindowData ~= nil then
			winMgr:getWindow("Lobby_CheckBox_DeathMatch"):setProperty("Selected", "false")			
		end
	end
	
	
	if MATCH_MONSTERRACING == 1 then
		local WindowData = winMgr:getWindow("Lobby_CheckBox_MonsterRacing")
		
		if WindowData ~= nil then
			winMgr:getWindow("Lobby_CheckBox_MonsterRacing"):setProperty("Selected", "true")			
		end
	else
		local WindowData = winMgr:getWindow("Lobby_CheckBox_MonsterRacing")
		
		if WindowData ~= nil then
			winMgr:getWindow("Lobby_CheckBox_MonsterRacing"):setProperty("Selected", "false")			
		end
	end
	
	if MATCH_DUALMATCH == 1 then
		local WindowData = winMgr:getWindow("Lobby_CheckBox_DualMatch")
		
		if WindowData ~= nil then
			winMgr:getWindow("Lobby_CheckBox_DualMatch"):setProperty("Selected", "true")			
		end
	else
		local WindowData = winMgr:getWindow("Lobby_CheckBox_DualMatch")
		
		if WindowData ~= nil then
			winMgr:getWindow("Lobby_CheckBox_DualMatch"):setProperty("Selected", "false")			
		end
	end
	
	if MATCH_COINMATCH == 1 then
		local WindowData = winMgr:getWindow("Lobby_CheckBox_CoinMatch")
		
		if WindowData ~= nil then
			winMgr:getWindow("Lobby_CheckBox_CoinMatch"):setProperty("Selected", "true")			
		end
	else
		local WindowData = winMgr:getWindow("Lobby_CheckBox_CoinMatch")
		
		if WindowData ~= nil then
			winMgr:getWindow("Lobby_CheckBox_CoinMatch"):setProperty("Selected", "false")			
		end
	end

	if MATCH_BOMBMATCH == 1 then
		local WindowData = winMgr:getWindow("Lobby_CheckBox_BombMatch")
		
		if WindowData ~= nil then
			winMgr:getWindow("Lobby_CheckBox_BombMatch"):setProperty("Selected", "true")			
		end
	else
		local WindowData = winMgr:getWindow("Lobby_CheckBox_BombMatch")
		
		if WindowData ~= nil then
			winMgr:getWindow("Lobby_CheckBox_BombMatch"):setProperty("Selected", "false")			
		end
	end

	if MATCH_MINITOWERMATCH == 1 then
		local WindowData = winMgr:getWindow("Lobby_CheckBox_MiniTowerMatch")
		
		if WindowData ~= nil then
			winMgr:getWindow("Lobby_CheckBox_BombMatch"):setProperty("Selected", "true")			
		end
	else
		local WindowData = winMgr:getWindow("Lobby_CheckBox_MiniTowerMatch")
		
		if WindowData ~= nil then
			winMgr:getWindow("Lobby_CheckBox_MiniTowerMatch"):setProperty("Selected", "false")			
		end
	end
	
	-- MODE
	if MODE_PRIVATE == 1 then
		local WindowData = winMgr:getWindow("sj_lobby_checkbox_privateMode")
		
		if WindowData ~= nil then
			winMgr:getWindow("sj_lobby_checkbox_privateMode"):setProperty("Selected", "true")			
		end
	else
		local WindowData = winMgr:getWindow("sj_lobby_checkbox_privateMode")
		
		if WindowData ~= nil then
			winMgr:getWindow("sj_lobby_checkbox_privateMode"):setProperty("Selected", "false")			
		end
	end
	
	if MODE_TEAM == 1 then
		local WindowData = winMgr:getWindow("sj_lobby_checkbox_teamMode")
		
		if WindowData ~= nil then
			winMgr:getWindow("sj_lobby_checkbox_teamMode"):setProperty("Selected", "true")			
		end
	else
		local WindowData = winMgr:getWindow("sj_lobby_checkbox_teamMode")
		
		if WindowData ~= nil then
			winMgr:getWindow("sj_lobby_checkbox_teamMode"):setProperty("Selected", "false")			
		end
	end

	-- TYPE
	if TYPE_NOITEM == 1 then
		local WindowData = winMgr:getWindow("sj_lobby_checkbox_NoItemType")
		
		if WindowData ~= nil then
			winMgr:getWindow("sj_lobby_checkbox_NoItemType"):setProperty("Selected", "true")			
		end
	else
		local WindowData = winMgr:getWindow("sj_lobby_checkbox_NoItemType")
		
		if WindowData ~= nil then
			winMgr:getWindow("sj_lobby_checkbox_NoItemType"):setProperty("Selected", "false")			
		end
	end
	
	if TYPE_ITEM == 1 then
		local WindowData = winMgr:getWindow("sj_lobby_checkbox_ItemType")
		
		if WindowData ~= nil then
			winMgr:getWindow("sj_lobby_checkbox_ItemType"):setProperty("Selected", "true")			
		end
	else
		local WindowData = winMgr:getWindow("sj_lobby_checkbox_ItemType")
		
		if WindowData ~= nil then
			winMgr:getWindow("sj_lobby_checkbox_ItemType"):setProperty("Selected", "false")			
		end
	end
	
	if TYPE_CLASS == 1 then
		local WindowData = winMgr:getWindow("sj_lobby_checkbox_ClassType")
		
		if WindowData ~= nil then
			winMgr:getWindow("sj_lobby_checkbox_ClassType"):setProperty("Selected", "true")			
		end
	else
		local WindowData = winMgr:getWindow("sj_lobby_checkbox_ClassType")
		
		if WindowData ~= nil then
			winMgr:getWindow("sj_lobby_checkbox_ClassType"):setProperty("Selected", "false")			
		end
	end
end




--------------------------------------------------------------------

-- 유저 리스트(MAX_USERPAGE)

--------------------------------------------------------------------
for i=0, MAX_USERPAGE-1 do
	-- 1. 유저 리스트(라디오 버튼) 생성
	userwindow = winMgr:createWindow("TaharezLook/RadioButton", i .. "sj_lobby_userlist_radioBtn")
	userwindow:setTexture("Normal", "UIData/invisible.tga", 0, 0)
	userwindow:setTexture("Hover", "UIData/LobbyImage_new.tga", 312, 937)
	userwindow:setTexture("Pushed", "UIData/LobbyImage_new.tga", 312, 962)
	userwindow:setTexture("PushedOff", "UIData/invisible.tga", 0, 0)
	userwindow:setTexture("SelectedNormal", "UIData/LobbyImage_new.tga", 312, 962)
	userwindow:setTexture("SelectedHover", "UIData/LobbyImage_new.tga", 312, 962)
	userwindow:setTexture("SelectedPushed", "UIData/LobbyImage_new.tga", 312, 962)
	userwindow:setTexture("SelectedPushedOff", "UIData/LobbyImage_new.tga", 312, 962)
	userwindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	userwindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	userwindow:setTexture("SelectedEnabled", "UIData/invisible.tga", 0, 0)
	userwindow:setTexture("SelectedDisabled", "UIData/invisible.tga", 0, 0)
	userwindow:setWideType(6);
	userwindow:setPosition(USERINFO_POSX+7, USERINFO_POSY+62+(i*31))
	userwindow:setSize(308, 23)
	userwindow:setProperty("GroupID", 700)
	userwindow:setZOrderingEnabled(false)
	userwindow:setVisible(true)
	userwindow:setRButtonEnabled(true)
	userwindow:setUserString("UserName", "")
	userwindow:subscribeEvent("MouseDoubleClicked", "UserDoubleClicked")
	userwindow:setSubscribeEvent("MouseRButtonUp", "WndLobby_OnRootMouseRButtonUp")
	userwindow:setSubscribeEvent('MouseButtonDown', 'BattleRoomMouseClick');
	userwindow:setSubscribeEvent('MouseEnter', 'BattleRoomMouseEnter');
	root:addChildWindow(userwindow)
	
	-- 2. 유저 레벨
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_lobby_userlist_level")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setText("9")
	mywindow:setPosition(12, 3)
	mywindow:setSize(40, 20)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)	-- 선택해도 다른것들이 선택되게
	userwindow:addChildWindow(mywindow)

	-- 3. 유저 이름
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_lobby_userlist_name")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setText("")
	mywindow:setPosition(116, 3)
	mywindow:setSize(100, 20)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	userwindow:addChildWindow(mywindow)
	
	-- 4. 유저 스타일
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_lobby_userlist_style")
	mywindow:setTexture("Enabled", "UIData/skillitem001.tga", 497, 0)
	mywindow:setTexture("Disabled", "UIData/skillitem001.tga", 497, 0)
	mywindow:setTexture("Layered", "UIData/skillitem001.tga", 497, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(250, -1)
	mywindow:setSize(89, 35)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	mywindow:setLayered(true)
	userwindow:addChildWindow(mywindow)
	
	-- 5. 유저 래더
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_lobby_userlist_ladder")
	mywindow:setTexture("Enabled", "UIData/numberUi001.tga", 113, 600)
	mywindow:setTexture("Disabled", "UIData/numberUi001.tga", 113, 600)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(62, 1)
	mywindow:setSize(47, 21)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	userwindow:addChildWindow(mywindow)
	
	-- 6. 유저 클럽
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_lobby_userlist_club")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setText("")
	mywindow:setPosition(14, 3)
	mywindow:setSize(40, 20)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	userwindow:addChildWindow(mywindow)
	
	-- 7. 클럽 이미지
	mywindow = winMgr:createWindow('TaharezLook/StaticImage', i .."sj_lobby_clubEmbleImage")
	mywindow:setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
	mywindow:setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
	mywindow:setProperty('BackgroundEnabled', 'False')
	mywindow:setProperty('FrameEnabled', 'False')
	mywindow:setPosition(4, 3)
	mywindow:setSize(32, 32)
	mywindow:setEnabled(false)
	mywindow:setVisible(false)
	mywindow:setScaleWidth(140)
	mywindow:setScaleHeight(140)
	userwindow:addChildWindow(mywindow)
	
end

function NoFunctionA()
end


-- 유저가 없을때
function WndLobby_ClearUserList()
	for i=0, MAX_USERPAGE-1 do
		winMgr:getWindow(i .. "sj_lobby_userlist_radioBtn"):setVisible(false)
		winMgr:getWindow(i .. "sj_lobby_userlist_level"):setVisible(false)
		winMgr:getWindow(i .. "sj_lobby_userlist_name"):setVisible(false)
		winMgr:getWindow(i .. "sj_lobby_userlist_style"):setVisible(false)
		winMgr:getWindow(i .. "sj_lobby_userlist_ladder"):setVisible(false)
		winMgr:getWindow(i .. "sj_lobby_userlist_club"):setVisible(false)
		winMgr:getWindow(i .. "sj_lobby_clubEmbleImage"):setVisible(false)
	end
end


-- 유저가 있을때
function WndLobby_ExistUser(index, level, ladder, style, userName, userClub , Emblemkey, promotion, attribute)
	winMgr:getWindow(index .. "sj_lobby_userlist_radioBtn"):setVisible(true)
	winMgr:getWindow(index .. "sj_lobby_userlist_radioBtn"):setUserString("UserName", tostring(userName))
	winMgr:getWindow(index .. "sj_lobby_userlist_level"):setVisible(true)
	winMgr:getWindow(index .. "sj_lobby_userlist_name"):setVisible(true)
	winMgr:getWindow(index .. "sj_lobby_userlist_style"):setVisible(true)
	winMgr:getWindow(index .. "sj_lobby_userlist_ladder"):setVisible(true)
	winMgr:getWindow(index .. "sj_lobby_userlist_club"):setVisible(true)
	winMgr:getWindow(index .. "sj_lobby_clubEmbleImage"):setVisible(true)
	-- 2. 유저 레벨
	local levelSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(level))
	winMgr:getWindow(index .. "sj_lobby_userlist_level"):setText(tostring(level))
	winMgr:getWindow(index .. "sj_lobby_userlist_level"):setPosition(46-levelSize/2, 3)
	
	-- 3. 유저 이름
	local nameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, userName)
	winMgr:getWindow(index .. "sj_lobby_userlist_name"):setText(userName)
	winMgr:getWindow(index .. "sj_lobby_userlist_name"):setPosition(184-nameSize/2, 3)
	
	-- 4. 유저 스타일
	winMgr:getWindow(index .. "sj_lobby_userlist_style"):setTexture("Disabled", "UIData/Skill_up2.tga", tAttributeImgTexXTable[style][attribute], tAttributeImgTexYTable[style][attribute])
	winMgr:getWindow(index .. "sj_lobby_userlist_style"):setTexture("Layered", "UIData/Skill_up2.tga", promotionImgTexXTable[style], promotionImgTexYTable[promotion])
	winMgr:getWindow(index .. "sj_lobby_userlist_style"):setScaleWidth(190)
	winMgr:getWindow(index .. "sj_lobby_userlist_style"):setScaleHeight(190)
	
	-- 5. 유저 래더
	winMgr:getWindow(index .. "sj_lobby_userlist_ladder"):setTexture("Disabled", "UIData/numberUi001.tga", 113, 600+21*ladder)
	
	-- 6. 유저 클럽
	if userClub == "" then
		winMgr:getWindow(index .. "sj_lobby_userlist_club"):setText("-")
	else
	
	end
	winMgr:getWindow(index .. "sj_lobby_clubEmbleImage"):setScaleWidth(140)
	winMgr:getWindow(index .. "sj_lobby_clubEmbleImage"):setScaleHeight(140)

	if Emblemkey > 0 then
		winMgr:getWindow(index .. "sj_lobby_clubEmbleImage"):setVisible(true)
		winMgr:getWindow(index .. "sj_lobby_clubEmbleImage"):setTexture('Enabled', GetClubDirectory(GetLanguageType())..Emblemkey..".tga", 0, 0)
		winMgr:getWindow(index .. "sj_lobby_clubEmbleImage"):setTexture('Disabled',GetClubDirectory(GetLanguageType())..Emblemkey..".tga", 0, 0)	
	else
		winMgr:getWindow(index .. "sj_lobby_clubEmbleImage"):setVisible(false)
		winMgr:getWindow(index .. "sj_lobby_clubEmbleImage"):setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
		winMgr:getWindow(index .. "sj_lobby_clubEmbleImage"):setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
	end
	
	
end


function UserDoubleClicked(args)
	local local_window = CEGUI.toWindowEventArgs(args).window
	if CEGUI.toRadioButton(local_window):isSelected() == true then
		local name = local_window:getUserString("UserName")
		if name ~= nil and name ~= "" then
			WndLobby_SetPrivateChat(name)
		end
	end
end


--------------------------------------------------------------------

-- 유저 리스트 변경 좌, 우 버튼

--------------------------------------------------------------------

tUserListLRButtonName  = { ["protecterr"]=0, "sj_lobby_userlist_LBtn", "sj_lobby_userlist_RBtn" }
tUserListLRButtonTexX  = { ["protecterr"]=0, 987, 970}
tUserListLRButtonPosX  = { ["protecterr"]=0, USERINFO_POSX+87, USERINFO_POSX+219 }
tUserListLRButtonEvent = { ["protecterr"]=0, "ChagneUserList_L", "ChagneUserList_R" }
for i=1, 2 do
	mywindow = winMgr:createWindow("TaharezLook/Button", tUserListLRButtonName[i])
	mywindow:setTexture("Normal", "UIData/myinfo.tga", tUserListLRButtonTexX[i], 0)
	mywindow:setTexture("Hover", "UIData/myinfo.tga", tUserListLRButtonTexX[i], 22)
	mywindow:setTexture("Pushed", "UIData/myinfo.tga", tUserListLRButtonTexX[i], 44)
	mywindow:setTexture("PushedOff", "UIData/myinfo.tga", tUserListLRButtonTexX[i], 0)
	mywindow:setWideType(6);
	mywindow:setPosition(tUserListLRButtonPosX[i], 470)
	mywindow:setSize(17, 22)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", tUserListLRButtonEvent[i])
	root:addChildWindow(mywindow)
end

-- 룸리스트를 변경한후 그 페이지의 정보를 셋팅해야 한다.
function ChagneUserList_L()
	local currUserNum = WndLobby_GetCurrentUserPage()
	if currUserNum > 0 then
		currUserNum = currUserNum - 1
		WndLobby_GetLobbyUserList(tonumber(currUserNum))
	end	
end


function ChagneUserList_R()
	local currUserNum = WndLobby_GetCurrentUserPage()
	local maxUserNum  = WndLobby_GetMaxUserPage()
	if currUserNum < maxUserNum then
		currUserNum = currUserNum + 1
		WndLobby_GetLobbyUserList(tonumber(currUserNum))
	end	
end



--------------------------------------------------------------------

-- 배틀룸 비밀번호 확인창

--------------------------------------------------------------------
-- 백그라운드 알파 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_lobby_forPassword_alphaWindow")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)


pwwindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_lobby_forPassword_showWindow")
pwwindow:setTexture("Enabled", "UIData/popup001.tga", 0, 0)
pwwindow:setTexture("Enabled", "UIData/popup001.tga", 0, 0)
pwwindow:setProperty("FrameEnabled", "False")
pwwindow:setProperty("BackgroundEnabled", "False")
pwwindow:setWideType(6);
pwwindow:setPosition(338, 246)
pwwindow:setSize(346, 275)
pwwindow:setVisible(false)
pwwindow:setAlwaysOnTop(true)
pwwindow:setZOrderingEnabled(false)
root:addChildWindow(pwwindow)


-- 비밀번호 보일창 ESC키, ENTER키 등록
RegistEscEventInfo("sj_lobby_forPassword_showWindow", "Password_CANCEL")


mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_lobby_forPassword_descWindow")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setText(g_STRING_INPUT_PASSWORD)
mywindow:setPosition(60, 106)
mywindow:setSize(170, 36)
mywindow:setAlwaysOnTop(true)
pwwindow:addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/Editbox", "sj_lobby_forPassword_editbox")
mywindow:setText("")
mywindow:setPosition(82, 134)
mywindow:setSize(174, 24)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("TextAccepted", "Password_OK")
CEGUI.toEditbox(mywindow):setInputOnlyNumber()
CEGUI.toEditbox(mywindow):setMaxTextLength(4)
CEGUI.toEditbox(mywindow):subscribeEvent("EditboxFull", "OnPasswordFull")
pwwindow:addChildWindow(mywindow)


function OnPasswordFull(args)
	PlayWave('sound/FullEdit.wav')
end


tPasswordName  = { ["protecterr"]=0, "sj_lobby_forPassword_okBtn", "sj_lobby_forPassword_cancelBtn" }
tPasswordTexX  = { ["protecterr"]=0, 693, 858}
tPasswordPosX  = { ["protecterr"]=0, 4, 169 }
tPasswordEvent = { ["protecterr"]=0, "Password_OK", "Password_CANCEL" }

for i=1, 2 do
	mywindow = winMgr:createWindow("TaharezLook/Button", tPasswordName[i])
	mywindow:setTexture("Normal", "UIData/popup001.tga", tPasswordTexX[i], 849)
	mywindow:setTexture("Hover", "UIData/popup001.tga", tPasswordTexX[i], 878)
	mywindow:setTexture("Pushed", "UIData/popup001.tga", tPasswordTexX[i], 907)
	mywindow:setTexture("PushedOff", "UIData/popup001.tga", tPasswordTexX[i], 849)	
	mywindow:setPosition(tPasswordPosX[i], 235)
	mywindow:setSize(166, 29)
	mywindow:setAlwaysOnTop(true)
	mywindow:subscribeEvent("Clicked", tPasswordEvent[i])
	pwwindow:addChildWindow(mywindow)
end



function Password_OK()
	local roomIndex  = winMgr:getWindow("sj_lobby_forPassword_showWindow"):getUserString("roomIndex")
	local password   = winMgr:getWindow("sj_lobby_forPassword_editbox"):getText()
	WndLobby_EnterPasswordBattleRoom(tonumber(roomIndex), password)
	
	Password_CANCEL()
end



function Password_CANCEL()
	winMgr:getWindow("sj_lobby_forPassword_alphaWindow"):setVisible(false)
	winMgr:getWindow("sj_lobby_forPassword_showWindow"):setVisible(false)
	winMgr:getWindow("sj_lobby_forPassword_editbox"):setText("")
end



function WndLobby_NotifyPassword(roomIndex)
	winMgr:getWindow("sj_lobby_forPassword_alphaWindow"):setVisible(true)
	winMgr:getWindow("sj_lobby_forPassword_showWindow"):setVisible(true)
	
	local size = GetStringSize(g_STRING_FONT_DODUM, 115, g_STRING_INPUT_PASSWORD)
	winMgr:getWindow("sj_lobby_forPassword_descWindow"):setPosition(170-size/2, 106)
	winMgr:getWindow("sj_lobby_forPassword_descWindow"):clearTextExtends()
	winMgr:getWindow("sj_lobby_forPassword_descWindow"):setViewTextMode(1)
	winMgr:getWindow("sj_lobby_forPassword_descWindow"):setAlign(1)
	winMgr:getWindow("sj_lobby_forPassword_descWindow"):setLineSpacing(5)
	winMgr:getWindow("sj_lobby_forPassword_descWindow"):addTextExtends(g_STRING_INPUT_PASSWORD, g_STRING_FONT_DODUM, 115, 255,255,255,255, 1, 0,0,0,255)
	winMgr:getWindow("sj_lobby_forPassword_showWindow"):setUserString("roomIndex", roomIndex)
	winMgr:getWindow("sj_lobby_forPassword_editbox"):activate()
end



function WndLobby_OnRootMouseButtonUp(args)
	root:removeChildWindow(winMgr:getWindow('pu_btnContainer'));
end


function WndLobby_OnRootMouseRButtonUp(args)

	if winMgr:getWindow('CommonAlertAlphaImg'):isVisible() then
		return
	end
	
	if winMgr:getWindow('Popup_AlphaBackImg'):isVisible() then
		return
	end
	
	root:removeChildWindow(winMgr:getWindow('pu_btnContainer'));
	
	-- 광장일때만 체크 해준다.	
	local messenger_window = winMgr:getWindow('sj_messengerBackWindow');
	
	if messenger_window ~= nil then
	
		local messenger_visible = messenger_window:isVisible()
		if messenger_visible == false then
			local name
			for i=0, MAX_USERPAGE-1 do
				if CEGUI.toRadioButton(winMgr:getWindow(i .. "sj_lobby_userlist_radioBtn")):isSelected() then
					name = winMgr:getWindow(i .. "sj_lobby_userlist_radioBtn"):getUserString("UserName")
					
					-- 나일경우 내정보만 띄운다.
					local _my_name, _money, _level, _promotion, _my_style, _type, _sp_point, _hp_point, _experience = GetMyInfo(false);
					if name == _my_name then
						local m_pos = mouseCursor:getPosition()
						ShowPopupWindow(m_pos.x, m_pos.y, 1)
						g_strSelectRButtonUp = name
						winMgr:getWindow('pu_myInfo'):setProperty('Disabled', 'False')
						MakeMessengerPopup("pu_windowName", "pu_myInfo" ,"pu_profile")
						
					-- 다른사람 일 경우
					else
						local m_pos = mouseCursor:getPosition();
						ShowPopupWindow(m_pos.x, m_pos.y, 1);
						g_strSelectRButtonUp = name;
						
						local isMyMessengerFriend = IsMyMessengerFriend(name);
						winMgr:getWindow('pu_showInfo'):setEnabled(true)
						
						-- 현재 내 친구 목록 리스트에 있는지 확인한다.
						-- 내 친구 목록 리스트에 있으면
						if isMyMessengerFriend == true then
							winMgr:getWindow('pu_addFriend'):setEnabled(false)	-- 비활성
							winMgr:getWindow('pu_deleteFriend'):setEnabled(true)	-- 활성
							
						else -- 내친구 목록리스트에 없으면
							winMgr:getWindow('pu_addFriend'):setEnabled(true)	-- 활성
							winMgr:getWindow('pu_deleteFriend'):setEnabled(false)	-- 비활성
						end
						
						-- 귓속말도 왠만하면 돼긴하는데..
						winMgr:getWindow('pu_privatChat'):setEnabled(true)
						
						-- 파티 초대는 상대가 파티가 속해 있는지 없는지 확인해야 한다.
						winMgr:getWindow('pu_inviteParty'):setEnabled(false)
						winMgr:getWindow('pu_vanishParty'):setEnabled(false)	-- 비활성
						
						-- 차단하기
						winMgr:getWindow('pu_blockUser'):setEnabled(true)
						
						if IsKoreanLanguage() then
							MakeMessengerPopup("pu_windowName", "pu_showInfo","pu_profile",  "pu_addFriend", "pu_deleteFriend", "pu_privatChat", "pu_blockUser", "pu_inviteParty", "pu_vanishParty");	-- 신고하기 기능 제한
						else
							MakeMessengerPopup("pu_windowName", "pu_showInfo","pu_profile",  "pu_addFriend", "pu_deleteFriend", "pu_privatChat", "pu_inviteParty", "pu_vanishParty");	-- 신고하기 기능 제한
						end
					end
					return
				end
			end
		end
	end
	
end
root:setSubscribeEvent("MouseButtonUp", "WndLobby_OnRootMouseButtonUp");





-- 로비에서만 쓰이는 전직 관련 로직
function OnMsgJobChanged(jobType)
	OnChatPublic(STRING_SUCCESS_CHANGECLASS, 4);
end


-- 마우스 오버시
function BattleRoomMouseEnter(args)
	PlayWave('sound/listmenu_click.wav')
end

-- 마우스 클릭시.
function BattleRoomMouseClick()
	PlayWave("sound/button_click.wav");
	root:removeChildWindow(winMgr:getWindow('pu_btnContainer'));
end




---------------------------------------------------------------

--	루키방 관련

---------------------------------------------------------------
local g_selectRoomIndex = 0

--------------------------------------------------------------------

-- 알림메세지

--------------------------------------------------------------------
-- 알파창
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_lobby_alphaWindow")
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

---------------------------------------------
--- OK, CANCEL 알림창
---------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_lobby_backWindow")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setTexture("Enabled", "UIData/popup001.tga", 0, 0)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setUserString("okFunction", "")
mywindow:setUserString("noFunction", "")
mywindow:setSize(349, 276)
mywindow:setWideType(6)
mywindow:setPosition(338, 246)
root:addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_lobby_descWindow")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setFont(g_STRING_FONT_GULIMCHE, 15)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setSize(340, 180)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setPosition(3, 45)
mywindow:clearTextExtends()
mywindow:setViewTextMode(1)
mywindow:setAlign(7)
mywindow:setLineSpacing(1)
winMgr:getWindow("sj_lobby_backWindow"):addChildWindow(mywindow)

-- OK, CANCEL 버튼
local tAlertName = {['protecterr'] = 0, "sj_lobby_okBtn", "sj_lobby_CancelBtn"}
local tAlertTexX = {['protecterr'] = 0, 693, 858}
local tAlertPosX = {['protecterr'] = 0, 4, 169}
local tAlertPosY = {['protecterr'] = 0, 235, 235}
for i=1, #tAlertName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tAlertName[i])
	mywindow:setTexture("Normal", "UIData/popup001.tga", tAlertTexX[i], 849)
	mywindow:setTexture("Hover", "UIData/popup001.tga", tAlertTexX[i], 878)
	mywindow:setTexture("Pushed", "UIData/popup001.tga", tAlertTexX[i], 907)
	mywindow:setTexture("PushedOff", "UIData/popup001.tga", tAlertTexX[i], 849)
	mywindow:setSize(166, 29)
	mywindow:setPosition(tAlertPosX[i], tAlertPosY[i])
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_lobby_backWindow"):addChildWindow(mywindow)
end


function WndLobby_CheckRoomEnter(roomIndex, msg)
	g_selectRoomIndex = roomIndex	
	ShowLobbyOkCancelBoxFunction('', msg, 'OnClickCheckRoomEnterOk', 'OnClickCheckRoomEnterCancel')
end

-----------------------------------
-- OK, CANCE 버튼 2개있는 함수
-----------------------------------
function ShowLobbyOkCancelBoxFunction(specialArg, arg, argYesFunc, argNoFunc)
	if winMgr:getWindow('sj_lobby_alphaWindow') then
		local aa= winMgr:getWindow("sj_lobby_alphaWindow"):getChildCount()
		if aa >= 1 then
			local bb= winMgr:getWindow("sj_lobby_alphaWindow"):getChildAtIdx(0)  
			winMgr:getWindow("sj_lobby_alphaWindow"):removeChildWindow(bb)		
		end
		winMgr:getWindow("sj_lobby_alphaWindow"):setVisible(true)
		root:addChildWindow(winMgr:getWindow("sj_lobby_alphaWindow"))
		local local_window = winMgr:getWindow("sj_lobby_backWindow")
		local_window:setUserString("okFunction", argYesFunc)
		local_window:setUserString("noFunction", argNoFunc)
		winMgr:getWindow("sj_lobby_alphaWindow"):addChildWindow(local_window)
		local_window:setVisible(true)
		
		local local_txt_window = winMgr:getWindow("sj_lobby_descWindow")
		local_window:setVisible(true)
		local_txt_window:clearTextExtends()
		local_txt_window:addTextExtends(specialArg, g_STRING_FONT_GULIMCHE, 15, 255,205,86,255,   1, 0,0,0,255)
		local_txt_window:addTextExtends(arg, g_STRING_FONT_GULIMCHE, 15, 255,255,255,255,    2, 0,0,0,255)
		winMgr:getWindow("sj_lobby_okBtn"):setSubscribeEvent("Clicked", argYesFunc)
		winMgr:getWindow("sj_lobby_CancelBtn"):setSubscribeEvent("Clicked", argNoFunc)
	end
end

-- 수락
function OnClickCheckRoomEnterOk(args)

	if winMgr:getWindow('sj_lobby_backWindow') then
		local okfunc = winMgr:getWindow('sj_lobby_backWindow'):getUserString("okFunction")
		if okfunc ~= "OnClickCheckRoomEnterOk" then
			return
		end
		winMgr:getWindow('sj_lobby_backWindow'):setUserString("okFunction", "")	-- 초기화를 해야함
		
		winMgr:getWindow('sj_lobby_alphaWindow'):setVisible(false)
		root:removeChildWindow(winMgr:getWindow('sj_lobby_alphaWindow'))
		local local_window = winMgr:getWindow('sj_lobby_backWindow')
		winMgr:getWindow('sj_lobby_alphaWindow'):removeChildWindow(local_window)
		local_window:setVisible(false)
		
		WndLobby_EnterBattleRoom(g_selectRoomIndex, false)
	end
end


-- 거절
function OnClickCheckRoomEnterCancel(args)
	
	if winMgr:getWindow('sj_lobby_backWindow') then
		local nofunc = winMgr:getWindow('sj_lobby_backWindow'):getUserString("noFunction")
		if nofunc ~= "OnClickCheckRoomEnterCancel" then
			return
		end
		winMgr:getWindow('sj_lobby_backWindow'):setUserString("noFunction", "")	-- 초기화를 해야함
		
		winMgr:getWindow('sj_lobby_alphaWindow'):setVisible(false)
		root:removeChildWindow( winMgr:getWindow('sj_lobby_alphaWindow'))
		local local_window = winMgr:getWindow('sj_lobby_backWindow')
		winMgr:getWindow('sj_lobby_alphaWindow'):removeChildWindow(local_window)
		local_window:setVisible(false)
	end
end

-- 파티 매치 ESC키 등록
RegistEnterEventInfo("sj_lobby_alphaWindow", "OnClickCheckRoomEnterOk")
RegistEscEventInfo("sj_lobby_alphaWindow", "OnClickCheckRoomEnterCancel")



-----------------------------------------
-- 룸안에 있는 캐릭터 정보
-----------------------------------------
inroomwindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_lobby_userInfo_inRoom_backImage")
inroomwindow:setTexture("Enabled", "UIData/popup001.tga", 688, 116)
inroomwindow:setTexture("Disabled", "UIData/popup001.tga", 688, 116)
inroomwindow:setProperty("FrameEnabled", "False")
inroomwindow:setProperty("BackgroundEnabled", "False")
inroomwindow:setWideType(6);
inroomwindow:setPosition(0, 0)
inroomwindow:setSize(294, 204)
inroomwindow:setZOrderingEnabled(false)
inroomwindow:setEnabled(false)
inroomwindow:setVisible(false)
inroomwindow:setAlwaysOnTop(true)
root:addChildWindow(inroomwindow)

for i=0, MAX_USERNUM_IN_ROOM-1 do

	-- 레벨
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_lobby_userInfo_inRoom_level")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(13, (i*22)+30)
	mywindow:setSize(20, 15)
	mywindow:setViewTextMode(1)
	mywindow:setAlign(1)
	mywindow:setLineSpacing(5)
	mywindow:clearTextExtends()
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(false)
	mywindow:setVisible(false)
	inroomwindow:addChildWindow(mywindow)	
	
	-- 래더
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_lobby_userInfo_inRoom_ladder")
	mywindow:setTexture("Enabled", "UIData/numberUi001.tga", 113, 600)
	mywindow:setTexture("Disabled", "UIData/numberUi001.tga", 113, 600)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(42, (i*22)+26)
	mywindow:setSize(47, 21)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	inroomwindow:addChildWindow(mywindow)

	-- 이름
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_lobby_userInfo_inRoom_name")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(120, (i*22)+30)
	mywindow:setSize(100, 15)
	mywindow:setViewTextMode(1)
	mywindow:setAlign(1)
	mywindow:setLineSpacing(5)
	mywindow:clearTextExtends()
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(false)
	mywindow:setVisible(false)
	inroomwindow:addChildWindow(mywindow)
	
	-- 클래스
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_lobby_userInfo_inRoom_style")
	mywindow:setTexture("Enabled", "UIData/skillitem001.tga", 497, 0)
	mywindow:setTexture("Disabled", "UIData/skillitem001.tga", 497, 0)
	mywindow:setTexture("Layered", "UIData/skillitem001.tga", 497, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(230, (i*22)+21)
	mywindow:setSize(87, 35)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	mywindow:setLayered(true)
	inroomwindow:addChildWindow(mywindow)
	
end

function OnMouseEnter_UserInfo_inRoom(args)
	local window = CEGUI.toWindowEventArgs(args).window	
	g_currentRoomNumber = tonumber(window:getUserString("RoomNumber"))
	g_currentRoomIndex = tonumber(window:getUserString("RoomIndex"))
	SetCurrentHoverRoomState(g_currentRoomNumber, g_currentRoomIndex)
	GetUserInfoInRoom(g_currentRoomNumber, g_currentRoomIndex)
end

function OnMouseLeave_UserInfo_inRoom(args)
	g_currentRoomNumber = -1
	g_currentRoomIndex = -1
	SetCurrentHoverRoomState(g_currentRoomNumber, g_currentRoomIndex)
	winMgr:getWindow("sj_lobby_userInfo_inRoom_backImage"):setVisible(false)
end

function WndLobby_ShowUserInfoInRoom(roomIndex)
	winMgr:getWindow("sj_lobby_userInfo_inRoom_backImage"):setVisible(true)
	winMgr:getWindow("sj_lobby_userInfo_inRoom_backImage"):setPosition(tRoomListReversPosX[roomIndex], tRoomListPosY[roomIndex]-3)
end

function WndLobby_ClosedUserInfoInRoom()
	winMgr:getWindow("sj_lobby_userInfo_inRoom_backImage"):setVisible(false)
end

function WndLobby_InitUserInfoInRoom()
	for i=0, MAX_USERNUM_IN_ROOM-1 do
		winMgr:getWindow(i.."sj_lobby_userInfo_inRoom_level"):setVisible(false)
		winMgr:getWindow(i.."sj_lobby_userInfo_inRoom_ladder"):setVisible(false)
		winMgr:getWindow(i.."sj_lobby_userInfo_inRoom_name"):setVisible(false)
		winMgr:getWindow(i.."sj_lobby_userInfo_inRoom_style"):setVisible(false)
	end
end


function WndLobby_SetUserInfoInRoom(index, level, ladder, name, style, promotion, attribute)

	winMgr:getWindow(index.."sj_lobby_userInfo_inRoom_level"):setVisible(true)
	winMgr:getWindow(index.."sj_lobby_userInfo_inRoom_ladder"):setVisible(true)
	winMgr:getWindow(index.."sj_lobby_userInfo_inRoom_name"):setVisible(true)
	winMgr:getWindow(index.."sj_lobby_userInfo_inRoom_style"):setVisible(true)
	
	-- 레벨
	local levelSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(level))	
	winMgr:getWindow(index.."sj_lobby_userInfo_inRoom_level"):setPosition(21-levelSize/2, (index*22)+30)
	winMgr:getWindow(index.."sj_lobby_userInfo_inRoom_level"):clearTextExtends()
	winMgr:getWindow(index.."sj_lobby_userInfo_inRoom_level"):setTextExtends(tostring(level), g_STRING_FONT_GULIMCHE, 12, 255,255,255,255, 0, 0,0,0,255)
		
	-- 래더
	winMgr:getWindow(index.."sj_lobby_userInfo_inRoom_ladder"):setTexture("Disabled", "UIData/numberUi001.tga", 113, 600+21*ladder)
	
	-- 이름
	local nameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, name)	
	winMgr:getWindow(index.."sj_lobby_userInfo_inRoom_name"):setPosition(158-nameSize/2, (index*22)+30)
	winMgr:getWindow(index.."sj_lobby_userInfo_inRoom_name"):clearTextExtends()
	winMgr:getWindow(index.."sj_lobby_userInfo_inRoom_name"):setTextExtends(name, g_STRING_FONT_GULIMCHE, 12, 255,255,255,255, 0, 0,0,0,255)
	
	-- 클래스
	winMgr:getWindow(index.."sj_lobby_userInfo_inRoom_style"):setTexture("Disabled", "UIData/Skill_up2.tga", tAttributeImgTexXTable[style][attribute], tAttributeImgTexYTable[style][attribute])
	winMgr:getWindow(index.."sj_lobby_userInfo_inRoom_style"):setTexture("Layered", "UIData/Skill_up2.tga", promotionImgTexXTable[style], promotionImgTexYTable[promotion])
	winMgr:getWindow(index.."sj_lobby_userInfo_inRoom_style"):setScaleWidth(190)
	winMgr:getWindow(index.."sj_lobby_userInfo_inRoom_style"):setScaleHeight(190)
end


function WndLobby_RequestUserInfoInRoom(roomIndex)	
	local window = winMgr:getWindow(roomIndex.."sj_lobby_roomList_radioBtn")
	g_currentRoomNumber = tonumber(window:getUserString("RoomNumber"))
	g_currentRoomIndex = tonumber(window:getUserString("RoomIndex"))
	SetCurrentHoverRoomState(g_currentRoomNumber, g_currentRoomIndex)
	GetUserInfoInRoom(g_currentRoomNumber, g_currentRoomIndex)
end


-----------------------------------------

-- 매너포인트 알림 메세지

-----------------------------------------
-- 백그라운드 알파 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_lobby_notify_alphaWindow")
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

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_lobby_notify_mannerPoint")
mywindow:setTexture("Enabled", "UIData/LobbyImage_new002.tga", 515, 311)
mywindow:setTexture("Disabled", "UIData/LobbyImage_new002.tga", 515, 311)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(5)
mywindow:setPosition(342, 314)
mywindow:setSize(340, 141)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(false)
winMgr:getWindow("sj_lobby_notify_alphaWindow"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/Button", "sj_lobby_notify_mannerPoint_okBtn")
mywindow:setTexture("Normal", "UIData/LobbyImage_new002.tga", 838, 0)
mywindow:setTexture("Hover", "UIData/LobbyImage_new002.tga", 838, 27)
mywindow:setTexture("Pushed", "UIData/LobbyImage_new002.tga", 838, 54)
mywindow:setTexture("PushedOff", "UIData/LobbyImage_new002.tga", 839, 0)
mywindow:setPosition(125, 100)
mywindow:setSize(90, 27)
mywindow:subscribeEvent("Clicked", "ClickedNotifyMannerPointOK")
winMgr:getWindow("sj_lobby_notify_mannerPoint"):addChildWindow(mywindow)

function WndLobby_ShowNotifyMannerPoint()
	winMgr:getWindow("sj_lobby_notify_alphaWindow"):setVisible(true)
end

function ClickedNotifyMannerPointOK(args)
	winMgr:getWindow("sj_lobby_notify_alphaWindow"):setVisible(false)
end

function ResetRoomClubInfo()
	for index= 0, MAX_ROOMPAGE-1 do
		winMgr:getWindow(index .."Lobby_RoomList_LeftClubEmblem_Img"):setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
		winMgr:getWindow(index .."Lobby_RoomList_RightClubEmblem_Img"):setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
		winMgr:getWindow(index .."Lobby_RoomList_leftClubName"):clearTextExtends()
		winMgr:getWindow(index .."Lobby_RoomList_RightClubName"):clearTextExtends()
	end
end

function WndLobby_UpdateRoomClubInfo(index, leftEmblem, rightEmblem, leftclubname, rightclubname)

	winMgr:getWindow(index .."Lobby_RoomList_ClubBackImg"):setVisible(true)
	
	if leftEmblem > 0 then
		winMgr:getWindow(index .."Lobby_RoomList_LeftClubEmblem_Img"):setVisible(true)
		winMgr:getWindow(index .."Lobby_RoomList_LeftClubEmblem_Img"):setTexture('Enabled', GetClubDirectory(GetLanguageType())..leftEmblem..".tga", 0, 0)
		winMgr:getWindow(index .."Lobby_RoomList_LeftClubEmblem_Img"):setTexture('Disabled',GetClubDirectory(GetLanguageType())..leftEmblem..".tga", 0, 0)	
	else
		winMgr:getWindow(index .."Lobby_RoomList_LeftClubEmblem_Img"):setVisible(false)
		winMgr:getWindow(index .."Lobby_RoomList_LeftClubEmblem_Img"):setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
		winMgr:getWindow(index .."Lobby_RoomList_LeftClubEmblem_Img"):setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
	end
	
	if rightEmblem > 0 then
		winMgr:getWindow(index .."Lobby_RoomList_RightClubEmblem_Img"):setVisible(true)
		winMgr:getWindow(index .."Lobby_RoomList_RightClubEmblem_Img"):setTexture('Enabled', GetClubDirectory(GetLanguageType())..rightEmblem..".tga", 0, 0)
		winMgr:getWindow(index .."Lobby_RoomList_RightClubEmblem_Img"):setTexture('Disabled',GetClubDirectory(GetLanguageType())..rightEmblem..".tga", 0, 0)	
	else
		winMgr:getWindow(index .."Lobby_RoomList_RightClubEmblem_Img"):setVisible(false)
		winMgr:getWindow(index .."Lobby_RoomList_RightClubEmblem_Img"):setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
		winMgr:getWindow(index .."Lobby_RoomList_RightClubEmblem_Img"):setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
	end
	
	if leftclubname ~= "" then
		winMgr:getWindow(index .."Lobby_RoomList_leftClubName"):setTextExtends(leftclubname, g_STRING_FONT_GULIMCHE, 11, 255,255,255,255,   0, 0,0,0,255)
	end
	
	if rightclubname ~= "" then
		winMgr:getWindow(index .."Lobby_RoomList_RightClubName"):setTextExtends(rightclubname, g_STRING_FONT_GULIMCHE, 11, 255,255,255,255,   0, 0,0,0,255)
	end
end



g_lobbyMatchHistoryPage = 1
g_lobbyMatchHistoryMaxPage = 1

---------------------------------------
---클럽전 기록실 호출
---------------------------------------
function CallGetMatchHistory()
	winMgr:getWindow('MatchHistory_BackImage'):setVisible(true)
	GetClubMatchHistory(g_lobbyMatchHistoryPage)
end

---------------------------------------
---클럽전 기록실 백그라운드 이미지
---------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MatchHistory_BackImage")
mywindow:setTexture("Enabled", "UIData/fightclub_005.tga", 514, 164)
mywindow:setTexture("Disabled", "UIData/fightclub_005.tga", 514, 164)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(280 ,180);
mywindow:setSize(508, 358)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

RegistEscEventInfo("MatchHistory_BackImage", "OnClickMatchHistroyExit")

----------------------------------------------
--- 클럽전 기록실  페이지텍스트---------
----------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "MatchHistory_PageText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 15)
mywindow:setPosition(152, 332)
mywindow:setSize(80, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:clearTextExtends()
mywindow:addTextExtends(tostring(g_lobbyMatchHistoryPage)..' / '..tostring(g_lobbyMatchHistoryMaxPage), g_STRING_FONT_GULIMCHE, 114,    230,230,230,255,     0,     0,0,0,255)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('MatchHistory_BackImage'):addChildWindow(mywindow)

---------------------------------------
--- 클럽전 기록실 페이지앞뒤버튼--
---------------------------------------
local MatchHistory_BtnName  = {["err"]=0, [0]="MatchHistory_LBtn", "MatchHistory_RBtn"}
local MatchHistory_BtnTexX  = {["err"]=0, [0]= 374, 392}
local MatchHistory_BtnPosX  = {["err"]=0, [0]= 125, 235}
local MatchHistory_BtnEvent = {["err"]=0, [0]= "MatchHistory_PrevPage", "MatchHistory_NextPage"}
for i=0, #MatchHistory_BtnName do
	mywindow = winMgr:createWindow("TaharezLook/Button", MatchHistory_BtnName[i])
	mywindow:setTexture("Normal", "UIData/fightclub_004.tga", MatchHistory_BtnTexX[i], 679)
	mywindow:setTexture("Hover", "UIData/fightclub_004.tga", MatchHistory_BtnTexX[i], 697)
	mywindow:setTexture("Pushed", "UIData/fightclub_004.tga",MatchHistory_BtnTexX[i], 715)
	mywindow:setTexture("PushedOff", "UIData/fightclub_004.tga", MatchHistory_BtnTexX[i], 679)
	mywindow:setPosition(MatchHistory_BtnPosX[i], 330)
	mywindow:setSize(18, 18)
	mywindow:setAlwaysOnTop(true)
	mywindow:setSubscribeEvent("Clicked", MatchHistory_BtnEvent[i])
	winMgr:getWindow('MatchHistory_BackImage'):addChildWindow(mywindow)
end


----------------------------------------
---클럽전 기록실 이전페이지이벤트-
----------------------------------------
function MatchHistory_PrevPage()

	if	g_lobbyMatchHistoryPage  > 1 then
		g_lobbyMatchHistoryPage = g_lobbyMatchHistoryPage - 1 
		CallGetMatchHistory(g_lobbyMatchHistoryPage)
		winMgr:getWindow('MatchHistory_PageText'):clearTextExtends()
		winMgr:getWindow('MatchHistory_PageText'):addTextExtends(tostring(g_lobbyMatchHistoryPage)..' / '..tostring(g_lobbyMatchHistoryMaxPage), g_STRING_FONT_GULIMCHE, 114,    230,230,230,255,     0,     0,0,0,255)
	end
end

----------------------------------------
---클럽전 기록실 다음페이지이벤트--
----------------------------------------
function MatchHistory_NextPage()
	
	if	g_lobbyMatchHistoryPage < g_lobbyMatchHistoryMaxPage then
		g_lobbyMatchHistoryPage = g_lobbyMatchHistoryPage + 1 
		CallGetMatchHistory(g_lobbyMatchHistoryPage)
		winMgr:getWindow('MatchHistory_PageText'):clearTextExtends()
		winMgr:getWindow('MatchHistory_PageText'):addTextExtends(tostring(g_lobbyMatchHistoryPage)..' / '..tostring(g_lobbyMatchHistoryMaxPage), g_STRING_FONT_GULIMCHE, 114,    230,230,230,255,     0,     0,0,0,255)
	end
end

----------------------------------------
---클럽전 기록실 닫기 버튼
----------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", MatchHistory_ExitBtn)
mywindow:setTexture("Normal", "UIData/fightclub_005.tga", 254, 344)
mywindow:setTexture("Hover", "UIData/fightclub_005.tga", 254, 366)
mywindow:setTexture("Pushed", "UIData/fightclub_005.tga",254, 388)
mywindow:setTexture("PushedOff", "UIData/fightclub_005.tga", 254, 344)
mywindow:setPosition(355, 330)
mywindow:setSize(144, 22)
mywindow:setAlwaysOnTop(true)
mywindow:setSubscribeEvent("Clicked", 'OnClickMatchHistroyExit')
winMgr:getWindow('MatchHistory_BackImage'):addChildWindow(mywindow)

function OnClickMatchHistroyExit()
	winMgr:getWindow('MatchHistory_BackImage'):setVisible(false)
end
------------------------------------------------------------------------------------
----- 클럽전 기록실 라디오버튼
------------------------------------------------------------------------------------
MatchHistory_Radio = 
{ ["protecterr"]=0, "MatchHistory_Radio1", "MatchHistory_Radio2", "MatchHistory_Radio3" , "MatchHistory_Radio4", "MatchHistory_Radio5",
					"MatchHistory_Radio6", "MatchHistory_Radio7", "MatchHistory_Radio8" , "MatchHistory_Radio9", "MatchHistory_Radio10"}
	
MatchHistoryText	= {['err'] = 0, 'ClubName1', 'ClubName2', 'ClubFlag1', 'ClubFlag2' , 'KillCount1', 'KillCount2' , 'ClubEmbem1',  'ClubEmbem2' , 'MatchRoom'}
								
MatchHistoryTextPosX		= {['err'] = 0, 65, 245, 0 , 0 , 15, 198, 0 , 0, 422}
MatchHistoryTextPosY		= {['err'] = 0, 7, 7, 7 ,7 ,12 , 12, 7, 7 ,7 }
MatchHistorySizeX			= {['err'] = 0, 5, 5, 5 ,5 , 5, 5, 5, 5 ,5 }
MatchHistorySizeY			= {['err'] = 0, 5, 5, 5 ,5 , 5 , 5, 5, 5 ,5 }
MatchHistorySetText		= {['err'] = 0,  'ClubName1', 'ClubName2' , '' , '', '5', '10', '', '','aaaroom'}



for i=1, #MatchHistory_Radio do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton",	MatchHistory_Radio[i])
	mywindow:setTexture("Normal", "UIData/invisible.tga",		522, 471)    
	mywindow:setTexture("Hover", "UIData/invisible.tga",		522, 415)
	mywindow:setTexture("Pushed", "UIData/invisible.tga",		522, 443)
	mywindow:setTexture("PushedOff", "UIData/invisible.tga",	522, 443)
	mywindow:setTexture("SelectedNormal", "UIData/invisible.tga",	 522, 443)
	mywindow:setTexture("SelectedHover", "UIData/invisible4.tga",	 522, 443)
	mywindow:setTexture("SelectedPushed", "UIData/invisible.tga",	 522, 443)
	mywindow:setTexture("SelectedPushedOff", "UIData/invisible.tga", 522, 443)
	mywindow:setTexture("Disabled", "UIData/invisible.tga",			522, 471);
	mywindow:setSize(500, 28)
	mywindow:setPosition(3, 33+30*(i-1))
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true)
	mywindow:setEnabled(false)
	winMgr:getWindow('MatchHistory_BackImage'):addChildWindow(mywindow)
	
	child_window = winMgr:createWindow('TaharezLook/StaticImage', MatchHistory_Radio[i]..'WinFlag1')
	child_window:setTexture('Enabled', 'UIData/invisible.tga', 970, 11)
	child_window:setTexture('Disabled', 'UIData/invisible.tga', 970, 11)
	child_window:setProperty('BackgroundEnabled', 'False')
	child_window:setProperty('FrameEnabled', 'False')
	child_window:setPosition(3, 0)
	child_window:setSize(30, 11)
	child_window:setEnabled(false)
	child_window:setVisible(true)
	child_window:setZOrderingEnabled(false)
	mywindow:addChildWindow(child_window)
	
	child_window = winMgr:createWindow('TaharezLook/StaticImage', MatchHistory_Radio[i]..'WinFlag2')
	child_window:setTexture('Enabled', 'UIData/invisible.tga', 970, 11)
	child_window:setTexture('Disabled', 'UIData/invisible.tga', 970, 11)
	child_window:setProperty('BackgroundEnabled', 'False')
	child_window:setProperty('FrameEnabled', 'False')
	child_window:setPosition(187, 0)
	child_window:setSize(30, 11)
	child_window:setEnabled(false)
	child_window:setVisible(true)
	child_window:setZOrderingEnabled(false)
	mywindow:addChildWindow(child_window)

	for j=1, #MatchHistoryText do
		local child_window = winMgr:createWindow("TaharezLook/StaticText", MatchHistory_Radio[i]..MatchHistoryText[j])	
		child_window:setProperty("FrameEnabled", "false")
		child_window:setProperty("BackgroundEnabled", "false")
		child_window:setSize(MatchHistorySizeX[j], MatchHistorySizeY[j])
		child_window:setVisible(true)
		child_window:setPosition(MatchHistoryTextPosX[j], MatchHistoryTextPosY[j])
		child_window:setViewTextMode(1)	
		if j < 3 then
			child_window:setAlign(0)
		else
			child_window:setAlign(8)
		end
		child_window:setLineSpacing(1)
		--child_window:addTextExtends(MatchHistorySetText[j], g_STRING_FONT_GULIMCHE, 112,    255,255,255,255,     0,     0,0,0,255)
		mywindow:addChildWindow(child_window)
	end
	
	
	--  클럽 엠블렘 이미지1
	child_window = winMgr:createWindow('TaharezLook/StaticImage', MatchHistory_Radio[i]..'ClubEmbleImage1')
	child_window:setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
	child_window:setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
	child_window:setProperty('BackgroundEnabled', 'False')
	child_window:setProperty('FrameEnabled', 'False')
	child_window:setPosition(40, 3)
	child_window:setScaleWidth(163)
	child_window:setScaleHeight(163)
	child_window:setSize(32, 32)
	child_window:setEnabled(false)
	child_window:setVisible(true)
	child_window:setZOrderingEnabled(false)
	mywindow:addChildWindow(child_window)
	
	--  클럽 엠블렘 이미지2
	child_window = winMgr:createWindow('TaharezLook/StaticImage', MatchHistory_Radio[i]..'ClubEmbleImage2')
	child_window:setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
	child_window:setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
	child_window:setProperty('BackgroundEnabled', 'False')
	child_window:setProperty('FrameEnabled', 'False')
	child_window:setPosition(221, 3)
	child_window:setScaleWidth(163)
	child_window:setScaleHeight(163)
	child_window:setSize(32, 32)
	child_window:setEnabled(false)
	child_window:setVisible(true)
	child_window:setZOrderingEnabled(false)
	mywindow:addChildWindow(child_window)
end

-- 클럽 기록실 페이지 저장
function Setting_MatchHistoryText(HistoryCurrentPage, HistoryMaxPage)
	g_lobbyMatchHistoryPage = HistoryCurrentPage
	g_lobbyMatchHistoryMaxPage = HistoryMaxPage
	winMgr:getWindow('MatchHistory_PageText'):clearTextExtends()
	winMgr:getWindow('MatchHistory_PageText'):addTextExtends(tostring(g_lobbyMatchHistoryPage)..' / '..tostring(g_lobbyMatchHistoryMaxPage), g_STRING_FONT_GULIMCHE, 114,    230,230,230,255,     0,     0,0,0,255)
end


-- 클럽 기록실 정보 세팅
function Setting_LobbyMatchHistoryList(MatchHistoryIndex ,HistoryClubName1, HistoryClubName2, 
				HistoryFlag , HistoryKillCount1, HistoryKillCount2 , HistoryClubEmbem1,  HistoryClubEmbem2 , HistoryMatchRoom)
	
	
	winMgr:getWindow(MatchHistory_Radio[MatchHistoryIndex]):setEnabled(true)
	for i=1, #MatchHistoryText do
		winMgr:getWindow(MatchHistory_Radio[MatchHistoryIndex]..MatchHistoryText[i]):clearTextExtends()
	end
	local RoomName = GetSStringInfo(HistoryMatchRoom)
	if HistoryFlag == 1 then
		winMgr:getWindow(MatchHistory_Radio[MatchHistoryIndex]..MatchHistoryText[1]):addTextExtends(HistoryClubName1, g_STRING_FONT_GULIMCHE, 112,    255,198,0,255,     0,     0,0,0,255)
		winMgr:getWindow(MatchHistory_Radio[MatchHistoryIndex]..MatchHistoryText[2]):addTextExtends(HistoryClubName2, g_STRING_FONT_GULIMCHE, 112,    200,200,200,255,     0,     0,0,0,255)
	else
		winMgr:getWindow(MatchHistory_Radio[MatchHistoryIndex]..MatchHistoryText[1]):addTextExtends(HistoryClubName1, g_STRING_FONT_GULIMCHE, 112,    200,200,200,255,     0,     0,0,0,255)
		winMgr:getWindow(MatchHistory_Radio[MatchHistoryIndex]..MatchHistoryText[2]):addTextExtends(HistoryClubName2, g_STRING_FONT_GULIMCHE, 112,    255,198,0,255,     0,     0,0,0,255)
	end
	winMgr:getWindow(MatchHistory_Radio[MatchHistoryIndex]..MatchHistoryText[5]):addTextExtends(HistoryKillCount1, g_STRING_FONT_GULIMCHE, 112,    250,150,150,255,     0,     0,0,0,255)
	winMgr:getWindow(MatchHistory_Radio[MatchHistoryIndex]..MatchHistoryText[6]):addTextExtends(HistoryKillCount2, g_STRING_FONT_GULIMCHE, 112,    150,150,250,255,     0,     0,0,0,255)
	winMgr:getWindow(MatchHistory_Radio[MatchHistoryIndex]..MatchHistoryText[9]):addTextExtends(RoomName, g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
	
	DebugStr('HistoryClubEmbem1:'..HistoryClubEmbem1)
	DebugStr('HistoryClubEmbem2:'..HistoryClubEmbem2)
	if HistoryClubEmbem1 > 0 then
		winMgr:getWindow(MatchHistory_Radio[MatchHistoryIndex]..'ClubEmbleImage1'):setTexture('Enabled',  GetClubDirectory(GetLanguageType())..HistoryClubEmbem1..".tga", 0, 0)
		winMgr:getWindow(MatchHistory_Radio[MatchHistoryIndex]..'ClubEmbleImage1'):setTexture('Disabled', GetClubDirectory(GetLanguageType())..HistoryClubEmbem1..".tga", 0, 0)
	
	else
		winMgr:getWindow(MatchHistory_Radio[MatchHistoryIndex]..'ClubEmbleImage1'):setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
		winMgr:getWindow(MatchHistory_Radio[MatchHistoryIndex]..'ClubEmbleImage1'):setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
	end
	
	if HistoryClubEmbem2 > 0 then
		winMgr:getWindow(MatchHistory_Radio[MatchHistoryIndex]..'ClubEmbleImage2'):setTexture('Enabled',  GetClubDirectory(GetLanguageType())..HistoryClubEmbem2..".tga", 0, 0)
		winMgr:getWindow(MatchHistory_Radio[MatchHistoryIndex]..'ClubEmbleImage2'):setTexture('Disabled', GetClubDirectory(GetLanguageType())..HistoryClubEmbem2..".tga", 0, 0)
	
	else
		winMgr:getWindow(MatchHistory_Radio[MatchHistoryIndex]..'ClubEmbleImage2'):setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
		winMgr:getWindow(MatchHistory_Radio[MatchHistoryIndex]..'ClubEmbleImage2'):setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
	end
	
	if HistoryFlag == 1 then
		winMgr:getWindow(MatchHistory_Radio[MatchHistoryIndex]..'WinFlag1'):setTexture('Enabled', 'UIData/fightClub_005.tga', 970, 0)
		winMgr:getWindow(MatchHistory_Radio[MatchHistoryIndex]..'WinFlag1'):setTexture('Disabled', 'UIData/fightClub_005.tga', 970, 0)	
		winMgr:getWindow(MatchHistory_Radio[MatchHistoryIndex]..'WinFlag2'):setTexture('Enabled', 'UIData/fightClub_005.tga', 970, 11)
		winMgr:getWindow(MatchHistory_Radio[MatchHistoryIndex]..'WinFlag2'):setTexture('Disabled', 'UIData/fightClub_005.tga', 970, 11)
	else
		winMgr:getWindow(MatchHistory_Radio[MatchHistoryIndex]..'WinFlag1'):setTexture('Enabled', 'UIData/fightClub_005.tga', 970, 11)
		winMgr:getWindow(MatchHistory_Radio[MatchHistoryIndex]..'WinFlag1'):setTexture('Disabled', 'UIData/fightClub_005.tga', 970, 11)	
		winMgr:getWindow(MatchHistory_Radio[MatchHistoryIndex]..'WinFlag2'):setTexture('Enabled', 'UIData/fightClub_005.tga', 970, 0)
		winMgr:getWindow(MatchHistory_Radio[MatchHistoryIndex]..'WinFlag2'):setTexture('Disabled', 'UIData/fightClub_005.tga', 970, 0)
	end
	
end


-- 클럽 기록실 초기화
function Reset_HistoryList()
	for i=1, #MatchHistory_Radio do
		winMgr:getWindow(MatchHistory_Radio[i]):setEnabled(false)
		winMgr:getWindow(MatchHistory_Radio[i]..'ClubEmbleImage1'):setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
		winMgr:getWindow(MatchHistory_Radio[i]..'ClubEmbleImage1'):setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
		winMgr:getWindow(MatchHistory_Radio[i]..'ClubEmbleImage2'):setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
		winMgr:getWindow(MatchHistory_Radio[i]..'ClubEmbleImage2'):setTexture('Disabled', 'UIData/invisible.tga', 0, 0)	
		winMgr:getWindow(MatchHistory_Radio[i]..'WinFlag1'):setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
		winMgr:getWindow(MatchHistory_Radio[i]..'WinFlag1'):setTexture('Disabled', 'UIData/invisible.tga', 0, 0)	
		winMgr:getWindow(MatchHistory_Radio[i]..'WinFlag2'):setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
		winMgr:getWindow(MatchHistory_Radio[i]..'WinFlag2'):setTexture('Disabled', 'UIData/invisible.tga', 0, 0)	
		for j=1 , #MatchHistoryText do
			winMgr:getWindow(MatchHistory_Radio[i]..MatchHistoryText[j]):clearTextExtends()
		end
	end
end

RegistEscEventInfo("sj_lobby_notify_alphaWindow", "ClickedNotifyMannerPointOK")
RegistEnterEventInfo("sj_lobby_notify_alphaWindow", "ClickedNotifyMannerPointOK")
--winMgr:getWindow("doChatting"):deactivate()
