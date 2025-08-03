-----------------------------------------
-- Script Entry Point
-----------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)
root:activate()

g_BattleMode = GetCurrentChannelBattleMode() -- ���� ä���� ��Ʋ��带 ��´�(0:�Ϲ�, 1:�ͽ�Ʈ��)

local g_MAPNAME_MR1	= PreCreateString_2374	--GetSStringInfo(LAN_LUA_BATTLEROOM_MR_MAP1)	-- ���� ���̽� ��1(���̵� ��)
local g_MAPNAME_MR2	= PreCreateString_2375	--GetSStringInfo(LAN_LUA_BATTLEROOM_MR_MAP2)	-- ���� ���̽� ��1(���̵� ��)
local g_MAPNAME_MR3	= PreCreateString_2376	--GetSStringInfo(LAN_LUA_BATTLEROOM_MR_MAP3)	-- ���� ���̽� ��1(���̵� ��)
local g_MAPNAME_R	= PreCreateString_2081	--GetSStringInfo(LAN_LUA_BATTLEROOM_RANDOMMAP)	-- ����
local g_MAPNAME_1	= PreCreateString_1673	--GetSStringInfo(LAN_LUA_BATTLEROOM_MAP1)		-- �� ��Ʈ��Ʈ ��Ʈ (��)
local g_MAPNAME_2	= PreCreateString_1675	--GetSStringInfo(LAN_LUA_BATTLEROOM_MAP2)		-- ��� ��ġ (��)
local g_MAPNAME_3	= PreCreateString_1678	--GetSStringInfo(LAN_LUA_BATTLEROOM_MAP4)		-- ��ũ �ߵ� (��)
local g_MAPNAME_4	= PreCreateString_1677	--GetSStringInfo(LAN_LUA_BATTLEROOM_MAP3)		-- ������Ʈ ��ũ (��)
local g_MAPNAME_5	= PreCreateString_1679	--GetSStringInfo(LAN_LUA_BATTLEROOM_MAP5)		-- ������ ��Ÿ�� (��)
local g_MAPNAME_6	= PreCreateString_1680	--GetSStringInfo(LAN_LUA_BATTLEROOM_MAP6)		-- ����Ʈ ��Ʈ��Ʈ (��)
local g_MAPNAME_7	= PreCreateString_1901	--GetSStringInfo(LAN_LUA_BATTLEROOM_MAP8)		-- ��ī�� ����� (��)
local g_MAPNAME_8	= PreCreateString_1681	--GetSStringInfo(LAN_LUA_BATTLEROOM_MAP7)		-- ����ö (��)
local g_MAPNAME_9	= PreCreateString_2173	--GetSStringInfo(LAN_LUA_BATTLEROOM_MAP9)		-- �Ʒ��� �� (��)
local g_MAPNAME_10	= PreCreateString_2524	--GetSStringInfo(LAN_LUA_BATTLEROOM_MAP10)		-- �踮�� ���丮 (��)
local g_MAPNAME_11	= PreCreateString_2748	--GetSStringInfo(LAN_LUA_BATTLEROOM_MAP11)		-- ����â�� (��)
local g_MAPNAME_12	= PreCreateString_4296	--GetSStringInfo(LAN_LUA_BATTLEROOM_MAP14)		-- ����� (��)

local g_MAPNAME_DUAL = PreCreateString_3447	--GetSStringInfo(LAN_LUA_BATTLEROOM_MAP12)		-- ����ġ ��
local g_MAPNAME_BOMB = PreCreateString_4205	--GetSStringInfo(LAN_LUA_BATTLEROOM_MAP13)		-- ��ź����
local g_MAPNAME_MINITOWER = PreCreateString_4635	--GetSStringInfo(LAN_LUA_BATTLEROOM_MAP15)-- �̴�Ÿ������(���׸����丮 (��))

local g_STRING_WARNING_CHANGEMAP	= PreCreateString_1128	--GetSStringInfo(LAN_LUA_WND_BATTLEROOM_1)	-- �ʺ����� ���常 �Ҽ� �ֽ��ϴ�.
local g_STRING_WARNING_ADJUSTROOM	= PreCreateString_1129	--GetSStringInfo(LAN_LUA_WND_BATTLEROOM_2)	-- �漳���� ���常 �Ҽ� �ֽ��ϴ�.
local g_STRING_WARNING_1			= PreCreateString_1130	--GetSStringInfo(LAN_LUA_WND_BATTLEROOM_3)	-- �غ� Ǯ��� ������ �� �ֽ��ϴ�.
local g_STRING_PREPARING			= PreCreateString_1273	--GetSStringInfo(LAN_LUA_WND_POPUP_2)		-- �غ����Դϴ�.
local g_STRING_CANNOT_ROOMSETTING   = PreCreateString_2291	--GetSStringInfo(LAN_LUA_CANNOT_ROOMSETTING)
local g_STRING_ABUSING_SECRETROOM_DESCRIPTION = PreCreateString_3384	--GetSStringInfo(ABUSING_SECRETROOM_DESCRIPTION)
local g_SelectedBattleTab = 4
local g_currentTeamBattle = WndMatchMaking_IsTeamBattle()
local g_currentClubBattle = WndMatchMaking_IsClubBattle()

local PLAYTYPE_NOITEM = 0
local PLAYTYPE_ITEM = 1
local PLAYTYPE_CLASS = 2
local PLAYTYPE_BOMB = 3
local PLAYTYPE_MINITOWER_NOITEM = 4
local PLAYTYPE_MINITOWER_ITEM = 5

local tTeamMark = { ["protecterr"]=0, [4]=169, [6]=189, [8]=209 }
local tPrivateMark = { ["protecterr"]=0, 0, 229, 249, 269, 289, 309, 329, 349 }

local PASSWORD_NOT_SELECT	= -1
local PASSWORD_ONE			= 1
local PASSWORD_TWO			= 2
local PASSWORD_THREE		= 3
local PASSWORD_FOUR			= 4

-- mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_matchmaking_bg")
-- mywindow:setTexture("Enabled", "UIData/BackGroundMatchMaking.tga", 448, 156)
-- mywindow:setTexture("Disabled", "UIData/BackGroundMatchMaking.tga", 448, 156)
-- mywindow:setProperty("FrameEnabled", "False")
-- mywindow:setProperty("BackgroundEnabled", "False")
-- mywindow:setWideType(6);
-- mywindow:setPosition(0, 0)
-- mywindow:setSize(1024, 768)
-- mywindow:setZOrderingEnabled(false)
-- root:addChildWindow(mywindow)

--------------------------------------------------------------------
-- ä�� ���� ���� ���̱�
--------------------------------------------------------------------
root:addChildWindow(winMgr:getWindow('ChannelPositionBG'));
winMgr:getWindow('ChannelPositionBG'):setVisible(true)
winMgr:getWindow('ChannelPositionBG'):setWideType(6);
winMgr:getWindow('ChannelPositionBG'):setPosition(795, 2);
winMgr:getWindow('NewMoveServerBtn'):setVisible(false)
winMgr:getWindow('NewMoveExitBtn'):setVisible(false)
--ChangeChannelPosition('Battle room')


userInfoBackWindow = winMgr:createWindow("TaharezLook/StaticImage", "userinfoInvisibleback")
userInfoBackWindow:setTexture("Enabled", "UIData/invisible.tga", 0, 828)
userInfoBackWindow:setTexture("Disabled", "UIData/invisible.tga", 0, 828)
-- userInfoBackWindow:setTexture("Enabled", "UIData/MatchMakingRoom1.png", 3, 827)
-- userInfoBackWindow:setTexture("Disabled", "UIData/MatchMakingRoom1.png", 3, 827)
userInfoBackWindow:setProperty("FrameEnabled", "True")
userInfoBackWindow:setProperty("BackgroundEnabled", "True")
userInfoBackWindow:setWideType(6);
userInfoBackWindow:setPosition(0, 0)
userInfoBackWindow:setSize(1024, 768)
userInfoBackWindow:setZOrderingEnabled(false)
userInfoBackWindow:setEnabled(true)
userInfoBackWindow:setVisible(true)
root:addChildWindow(userInfoBackWindow)


-- �ʱ� ä��â ����
function SetChatInitBattleRoom()
	Chatting_SetChatWideType(6)
	Chatting_SetChatPosition(3, 527)
	Chatting_SetChatEditVisible(true)
	Chatting_SetChatEditEvent(2)
	winMgr:getWindow("doChatting"):deactivate()
	Chatting_SetChatTabDefault()
end

--------------------------------------------------------------------

-- drawTexture(StartRender:���۽ÿ� �׸���)

--------------------------------------------------------------------
function WndMatchMaking_BackImage(myLevel, EVENT_EX_LEVEL, currentBattleChannelName, extremeZen, 
				continueWinTeam, continueWinCount, autoBalance, bTeam, maxUser, exceptE, roomPassword, gameMode, currentLadderChannelType)
	
	-- if g_currentClubBattle  then
	-- 	drawer:drawTexture("UIData/match001.tga", 0, 0, 1024, 70, 0, 0, WIDETYPE_6)	
	-- else
	-- 	drawer:drawTexture("UIData/match003.tga", 0, 0, 1024, 70, 0, 0, WIDETYPE_6)				-- ���� ��
	-- end
	
	
	-- drawer:drawTexture("UIData/match003.tga", 0, 558, 1024, 210, 0, 814, WIDETYPE_6)		-- �Ʒ��� ��
	
	-- -- �̺�Ʈ ���� ����ȭ��
	-- if CheckfacilityData(FACILITYCODE_WINSTREAK) == 1 then
	-- 	if myLevel >= EVENT_EX_LEVEL then
	-- 		drawer:drawTexture("UIData/match003.tga", 434, 567, 241, 180, 227, 418, WIDETYPE_6)	-- �̺�Ʈ ����(Pro, Fight, Win)
	-- 	else
	-- 		drawer:drawTexture("UIData/match003.tga", 434, 567, 241, 180, 227, 238, WIDETYPE_6)	-- �̺�Ʈ ����(Go, Fight, Win)
	-- 	end
	-- else
	-- 	drawer:drawTexture("UIData/match003.tga", 434, 567, 241, 180, 500, 658, WIDETYPE_6)	-- �⺻ ����(VS)
	-- end
	
	-- -- ����ä�� �̸�
	-- drawer:setTextColor(255, 255, 255, 255)
	-- drawer:setFont(g_STRING_FONT_GULIMCHE, 14)

	-- -- �ͽ�Ʈ�� ����� ���
	-- if g_BattleMode == BATTLETYPE_EXTREME then
	-- 	drawer:drawTexture("UIData/match001.tga", 352, 70, 321, 120, 292, 904, WIDETYPE_6)
	-- 	_left, _right = DrawEachNumberWide("UIData/match001.tga", extremeZen, 8, 450, 186, 613, 975, 41, 49, 41, WIDETYPE_6)
	-- 	drawer:drawTexture("UIData/match001.tga", _right+44, 196, 77, 37, 947, 938, WIDETYPE_6)
	-- end
	
	-- -- ����ǥ��
	-- if continueWinCount >= 2 then
	-- 	drawer:drawTexture("UIData/match003.tga", 376, 8, 291, 28, 708, 74, WIDETYPE_6)
	-- 	local winCountTen = continueWinCount / 10
	-- 	local winCountOne = continueWinCount % 10
	-- 	drawer:drawTextureSA("UIData/match001.tga", 618, 12, 19, 30, 789+(winCountTen*19), 883, 180, 180, 255, 0, 0, WIDETYPE_6)	-- 10�ڸ�
	-- 	drawer:drawTextureSA("UIData/match001.tga", 636, 12, 19, 30, 789+(winCountOne*19), 883, 180, 180, 255, 0, 0, WIDETYPE_6)	-- 1�ڸ�
		
	-- 	if continueWinTeam == 0 then
	-- 		drawer:drawTexture("UIData/match003.tga", 412, 14, 60, 19, 708, 130, WIDETYPE_6)
	-- 	else
	-- 		drawer:drawTexture("UIData/match003.tga", 412, 14, 60, 19, 768, 130, WIDETYPE_6)
	-- 	end
	-- end
		
	-- -- �ڵ� ������ �������� ����
	-- if autoBalance == 1 then
	-- 	drawer:drawTexture("UIData/match003.tga", 376, 34, 291, 28, 708, 102, WIDETYPE_6)
	-- end
	
	-- -- E�ʻ�� ����
	-- if exceptE == 1 then
	-- 	drawer:drawTexture("UIData/LobbyImage_new.tga", 300, 37, 26, 26, 998, 370, WIDETYPE_6)
	-- end
	
	-- -- ���� ä���� �����(0:�Ϲ�, 1:�ͽ���Ʈ ä��)
	-- if currentLadderChannelType == 1 then
	-- 	drawer:drawTexture("UIData/match003.tga", 320, 33, 54, 34, 265, 200, WIDETYPE_6)
	-- end
	
	-- -- ���� ������
	-- drawer:drawTexture("UIData/match003.tga", 430, 68, 163, 30, 300, 656, WIDETYPE_6)
	-- if bTeam == 1 then
	-- 	if maxUser == 4 or maxUser == 6 or maxUser == 8 then
	-- 		drawer:drawTexture("UIData/match003.tga", 468, 72, 89, 20, 935, tTeamMark[maxUser], WIDETYPE_6)
	-- 	end
	-- else
	-- 	if 1 <= maxUser and maxUser <= 8 then
	-- 		drawer:drawTexture("UIData/match003.tga", 468, 72, 89, 20, 935, tPrivateMark[maxUser], WIDETYPE_6)
	-- 	end
	-- end
	
	-- if string.len(roomPassword) > 0 then
	-- 	drawer:setTextColor(255, 255, 255, 255)
	-- 	drawer:setFont(g_STRING_FONT_GULIMCHE, 14)
		
	-- 	if CheckfacilityData(FACILITYCODE_SECRETROOMDESC) == 1 then  
	-- 		common_DrawOutlineText1(drawer, g_STRING_ABUSING_SECRETROOM_DESCRIPTION, 410, 110, 255,0,0,255, 255,255,255,255, WIDETYPE_6)
	-- 	end
	-- end
	
	-- if gameMode == 8 then
	-- 	drawer:drawTexture("UIData/battleroom001.tga", 211, 140, 602, 46, 0, 777, WIDETYPE_6)
	-- end
end


function WndMatchMaking_ClubMatchDraw(LeftEmblem, RightEmblem , LeftClubName, RightClubName)

	local PlusXpos = 189
	local PlusYpos = 2
	
	drawer:setFont(g_STRING_FONT_GULIMCHE, 17)
	drawer:setTextColor(255,255,255,255)
	drawer:drawTexture("UIData/match001.tga", 40+PlusXpos, PlusYpos , 570, 63, 150, 705, WIDETYPE_6)	
	
	if LeftClubName ~= "" then
		common_DrawOutlineText1(drawer, LeftClubName, 150+PlusXpos, 28+PlusYpos , 0,0,0,255, 255,255,255,255, WIDETYPE_6)
	end
	
	local leftName_width  = (GetStringSize(g_STRING_FONT_GULIMCHE, 17, LeftClubName))
	local RightName_width = (GetStringSize(g_STRING_FONT_GULIMCHE, 17, RightClubName))
	
	if RightClubName ~= "" then
		common_DrawOutlineText1(drawer, RightClubName, 385+PlusXpos, 28+PlusYpos, 0,0,0,255, 255,255,255,255, WIDETYPE_6)
	end
	
	--������
	if LeftEmblem > 0 then 
		drawer:drawTextureSA(GetClubDirectory(GetLanguageType())..LeftEmblem..".tga", 117+PlusXpos, 21+PlusYpos, 32, 32, 0, 0, 255, 255, 255, 0, 0, WIDETYPE_6)
	end
	
	--������
	if RightEmblem > 0 then
		drawer:drawTextureSA(GetClubDirectory(GetLanguageType())..RightEmblem..".tga", 347+PlusXpos, 21+PlusYpos, 32, 32, 0, 0, 255, 255, 255, 0, 0, WIDETYPE_6)
	end
	
end

--------------------------------------------------------------------

-- �������� �޴´�

--------------------------------------------------------------------
-- 1. ���ȣ
-- 131 698
-- 130 38
local roomIndexOffsetX = 5
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_matchmaking_roomIndex_bg")
mywindow:setTexture("Enabled", "UIData/MatchMakingRoom1.tga", 1, 660)
mywindow:setTexture("Disabled", "UIData/MatchMakingRoom1.tga", 1, 660)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(13, 10)
mywindow:setSize(130, 38)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_matchmaking_roomIndex_outline1")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 0, 0, 255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setText("")
mywindow:setWideType(6);
mywindow:setPosition(35, 21)
mywindow:setSize(60, 20)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_matchmaking_roomIndex_outline2")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 0, 0, 255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setText("")
mywindow:setWideType(6);
mywindow:setPosition(37, 21)
mywindow:setSize(60, 20)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_matchmaking_roomIndex_outline3")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 0, 0, 255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setText("")
mywindow:setWideType(6);
mywindow:setPosition(35, 23)
mywindow:setSize(60, 20)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_matchmaking_roomIndex_outline4")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 0, 0, 255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setText("")
mywindow:setWideType(6);
mywindow:setPosition(37, 23)
mywindow:setSize(60, 20)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_matchmaking_roomIndex")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setText("")
mywindow:setWideType(6);
mywindow:setPosition(36, 22)
mywindow:setSize(60, 20)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

-- -- 2. ������
-- mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_matchmaking_roomTitle")
-- mywindow:setProperty("FrameEnabled", "false")
-- mywindow:setProperty("BackgroundEnabled", "false")
-- mywindow:setTextColor(255, 255, 255, 255)
-- mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
-- mywindow:setWideType(6);
-- mywindow:setPosition(96, 13)
-- mywindow:setSize(300, 20)
-- mywindow:setZOrderingEnabled(false)
-- if g_currentClubBattle == false then
-- 	root:addChildWindow(mywindow)
-- end

-- -- 3. ��й�ȣ ������
-- mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_matchmaking_passwordIcon")
-- mywindow:setTexture("Enabled", "UIData/match003.tga", 227, 137)
-- mywindow:setTexture("Disabled", "UIData/match003.tga", 227, 137)
-- mywindow:setProperty("FrameEnabled", "False")
-- mywindow:setProperty("BackgroundEnabled", "False")
-- mywindow:setWideType(6);
-- mywindow:setPosition(246, 38)
-- mywindow:setSize(22, 21)
-- mywindow:setZOrderingEnabled(false)
-- root:addChildWindow(mywindow)

-- -- 5. ���Ӹ��(������ġ, ��ƿ��ġ)
-- mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_matchmaking_gameMode")
-- mywindow:setTexture("Enabled", "UIData/match003.tga", 265, 120)
-- mywindow:setTexture("Disabled", "UIData/match003.tga", 319, 120)
-- mywindow:setProperty("FrameEnabled", "False")
-- mywindow:setProperty("BackgroundEnabled", "False")
-- mywindow:setWideType(6);
-- mywindow:setPosition(17, 37)
-- mywindow:setSize(54, 23)
-- mywindow:setZOrderingEnabled(false)
-- root:addChildWindow(mywindow)

-- -- 6. ������, ����
-- mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_matchmaking_isTeamBattle")
-- mywindow:setTexture("Enabled", "UIData/match003.tga", 373, 74)
-- mywindow:setTexture("Disabled", "UIData/match003.tga", 373, 97)
-- mywindow:setProperty("FrameEnabled", "False")
-- mywindow:setProperty("BackgroundEnabled", "False")
-- mywindow:setWideType(6);
-- mywindow:setPosition(74, 37)
-- mywindow:setSize(54, 23)
-- mywindow:setZOrderingEnabled(false)
-- root:addChildWindow(mywindow)

-- -- 7. ������, ��������, EQUIP
-- mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_matchmaking_isItemBattle")
-- mywindow:setTexture("Enabled", "UIData/match003.tga", 265, 74)
-- mywindow:setTexture("Disabled", "UIData/match003.tga", 265, 97)
-- mywindow:setProperty("FrameEnabled", "False")
-- mywindow:setProperty("BackgroundEnabled", "False")
-- mywindow:setWideType(6);
-- mywindow:setPosition(131, 37)
-- mywindow:setSize(54, 23)
-- mywindow:setZOrderingEnabled(false)
-- root:addChildWindow(mywindow)

-- -- 8. �ð�
-- mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_matchmaking_limitTime")
-- mywindow:setTexture("Enabled", "UIData/match003.tga", 300, 610)
-- mywindow:setTexture("Disabled", "UIData/match003.tga", 300, 610)
-- mywindow:setProperty("FrameEnabled", "False")
-- mywindow:setProperty("BackgroundEnabled", "False")
-- mywindow:setWideType(6);
-- mywindow:setPosition(188, 37)
-- mywindow:setSize(54, 23)
-- mywindow:setZOrderingEnabled(false)
-- root:addChildWindow(mywindow)

-- -- 9. ��й�ȣ ����
-- mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_matchmaking_passwordDesc")
-- mywindow:setProperty("FrameEnabled", "false")
-- mywindow:setProperty("BackgroundEnabled", "false")
-- mywindow:setTextColor(255, 0, 0, 255)
-- mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
-- mywindow:setText("")
-- mywindow:setWideType(6);
-- mywindow:setPosition(264, 40)
-- mywindow:setSize(60, 20)
-- mywindow:setZOrderingEnabled(false)
-- root:addChildWindow(mywindow)

-- 10. �����(��Ű��:0, �Ϲ�:1)
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_matchmaking_rookieImage")
mywindow:setTexture("Enabled", "UIData/match003.tga", 265, 166)
mywindow:setTexture("Disabled", "UIData/match003.tga", 265, 166)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(320, 33)
mywindow:setSize(54, 34)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Battleroom_LadderLimitImage")
mywindow:setTexture("Enabled", "UIData/option.tga", 673, 903)
mywindow:setTexture("Disabled", "UIData/option.tga", 673, 903)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6)
mywindow:setPosition(370, 10)
mywindow:setSize(85, 23)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Battleroom_LadderLimitImage_Max_Ten_Img")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(65, 4)
mywindow:setSize(8, 14)
mywindow:setVisible(false)
winMgr:getWindow("Battleroom_LadderLimitImage"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Battleroom_LadderLimitImage_Max_One_Img")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(73, 4)
mywindow:setSize(8, 14)
mywindow:setVisible(false)
winMgr:getWindow("Battleroom_LadderLimitImage"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Battleroom_LadderLimitImage_Min_Ten_Img")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(21, 4)
mywindow:setSize(8, 14)
mywindow:setVisible(false)
winMgr:getWindow("Battleroom_LadderLimitImage"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Battleroom_LadderLimitImage_Min_One_Img")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(29, 4)
mywindow:setSize(8, 14)
mywindow:setVisible(false)
winMgr:getWindow("Battleroom_LadderLimitImage"):addChildWindow(mywindow)


function WndMatchMaking_RoomInfomation(roomIndex, roomName, password, curUser, maxUser, gameMode, 
			bTeam, bItem, killCount, limitTime, roomKind, exreamzen, LadderLimit)

		-- 1. ���ȣ
		local roomIndexOffsetX = 40
		local roomIndexSize = GetStringSize(g_STRING_FONT_GULIMCHE, 14, tostring(roomIndex))
		winMgr:getWindow("sj_matchmaking_roomIndex"):setPosition(roomIndexOffsetX-roomIndexSize/2, 12)
		winMgr:getWindow("sj_matchmaking_roomIndex"):setText("Room NO."..roomIndex)
		winMgr:getWindow("sj_matchmaking_roomIndex_outline1"):setPosition(roomIndexOffsetX-roomIndexSize/2, 12)
		winMgr:getWindow("sj_matchmaking_roomIndex_outline1"):setText("Room NO."..roomIndex)
		winMgr:getWindow("sj_matchmaking_roomIndex_outline2"):setPosition(roomIndexOffsetX-roomIndexSize/2, 12)
		winMgr:getWindow("sj_matchmaking_roomIndex_outline2"):setText("Room NO."..roomIndex)
		winMgr:getWindow("sj_matchmaking_roomIndex_outline3"):setPosition(roomIndexOffsetX-roomIndexSize/2, 12)
		winMgr:getWindow("sj_matchmaking_roomIndex_outline3"):setText("Room NO."..roomIndex)
		winMgr:getWindow("sj_matchmaking_roomIndex_outline4"):setPosition(roomIndexOffsetX-roomIndexSize/2, 12)
		winMgr:getWindow("sj_matchmaking_roomIndex_outline4"):setText("Room NO."..roomIndex)
		
		-- 2. ������
		local roomSummaryName = SummaryString(g_STRING_FONT_GULIMCHE, 12, roomName, 220)
		winMgr:getWindow("sj_matchmaking_roomTitle"):setText(roomSummaryName)
		
		-- 3. ��й�ȣ ������
		if string.len(password) > 0 then
			winMgr:getWindow("sj_matchmaking_passwordIcon"):setTexture("Enabled", "UIData/match003.tga", 227, 137)
		else
			winMgr:getWindow("sj_matchmaking_passwordIcon"):setTexture("Enabled", "UIData/match003.tga", 227, 158)
		end
	
		winMgr:getWindow("sj_matchmaking_mapChange_LBtn"):setVisible(true)
		winMgr:getWindow("sj_matchmaking_mapChange_RBtn"):setVisible(true)

		-- 5. ���Ӹ��(������ġ) 
		if gameMode == 0 then
			if bItem == 3 then
				winMgr:getWindow("sj_matchmaking_gameMode"):setTexture("Enabled", "UIData/match003.tga", 516, 610)
			elseif bItem == PLAYTYPE_MINITOWER_NOITEM or bItem == PLAYTYPE_MINITOWER_ITEM then
				winMgr:getWindow("sj_matchmaking_gameMode"):setTexture("Enabled", "UIData/match003.tga", 570, 610)
			else
				winMgr:getWindow("sj_matchmaking_gameMode"):setTexture("Enabled", "UIData/match003.tga", 265, 120)
			end
		elseif gameMode == 6 then
			winMgr:getWindow("sj_matchmaking_gameMode"):setTexture("Enabled", "UIData/match003.tga", 373, 120)
		elseif gameMode == 8 then
			winMgr:getWindow("sj_matchmaking_gameMode"):setTexture("Enabled", "UIData/match003.tga", 408, 610)
			winMgr:getWindow("sj_matchmaking_mapChange_LBtn"):setVisible(false)
			winMgr:getWindow("sj_matchmaking_mapChange_RBtn"):setVisible(false)
		elseif gameMode == 11 then -- ������
			winMgr:getWindow("sj_matchmaking_gameMode"):setTexture("Enabled", "UIData/match003.tga", 462, 610)
		end
	
		-- 6. ����, ������
		if bItem == PLAYTYPE_NOITEM then
			winMgr:getWindow("sj_matchmaking_isItemBattle"):setTexture("Enabled", "UIData/match003.tga", 265, 74)
		elseif bItem == PLAYTYPE_ITEM then
			winMgr:getWindow("sj_matchmaking_isItemBattle"):setTexture("Enabled", "UIData/match003.tga", 319, 74)
		elseif bItem == PLAYTYPE_CLASS then
			winMgr:getWindow("sj_matchmaking_isItemBattle"):setTexture("Enabled", "UIData/match003.tga", 265, 143)
		elseif bItem == PLAYTYPE_BOMB then
			winMgr:getWindow("sj_matchmaking_mapChange_LBtn"):setVisible(false)
			winMgr:getWindow("sj_matchmaking_mapChange_RBtn"):setVisible(false)
			DebugStr('�ʺ���')
			winMgr:getWindow("sj_matchmaking_isItemBattle"):setTexture("Enabled", "UIData/match003.tga", 319, 74)
			winMgr:getWindow("sj_matchmaking_mapName"):setTextExtends(g_MAPNAME_BOMB, g_STRING_FONT_GULIM, 12, 97,230,255,255, 0, 0,255,100,255)
		elseif bItem == PLAYTYPE_MINITOWER_NOITEM or bItem == PLAYTYPE_MINITOWER_ITEM then
			winMgr:getWindow("sj_matchmaking_mapChange_LBtn"):setVisible(false)
			winMgr:getWindow("sj_matchmaking_mapChange_RBtn"):setVisible(false)
			DebugStr('�ʺ���')
		--	winMgr:getWindow("sj_matchmaking_isItemBattle"):setTexture("Enabled", "UIData/match003.tga", 319, 74)
			winMgr:getWindow("sj_matchmaking_mapName"):setTextExtends(g_MAPNAME_MINITOWER, g_STRING_FONT_GULIM, 12, 97,230,255,255, 0, 0,255,100,255)
		end
		
		-- 7. ��������
		if bTeam == 1 then
			winMgr:getWindow("sj_matchmaking_isTeamBattle"):setTexture("Enabled", "UIData/match003.tga", 427, 74)
		else
			winMgr:getWindow("sj_matchmaking_isTeamBattle"):setTexture("Enabled", "UIData/match003.tga", 373, 74)
		end
		
		-- 8. ���ѽð�
		if gameMode == 0 then
			winMgr:getWindow("sj_matchmaking_limitTime"):setVisible(true)
			winMgr:getWindow("sj_matchmaking_limitTime"):setTexture("Enabled", "UIData/match003.tga", 300, 633-((limitTime-1)*23))
		elseif gameMode == 11 then
			winMgr:getWindow("sj_matchmaking_limitTime"):setVisible(true)
			winMgr:getWindow("sj_matchmaking_limitTime"):setTexture("Enabled", "UIData/match003.tga", 300, 633-((limitTime-1)*23))
		else
			winMgr:getWindow("sj_matchmaking_limitTime"):setVisible(false)
		end
		
		-- 9. ��й�ȣ ����
		winMgr:getWindow("sj_matchmaking_passwordDesc"):setText(password)
	
	
		-- 10. ��Ű �̹���
		if roomKind == 1 then
			winMgr:getWindow("sj_matchmaking_rookieImage"):setVisible(true)
			if g_currentClubBattle  then
				winMgr:getWindow("sj_matchmaking_rookieImage"):setVisible(false)
			end
		else
			winMgr:getWindow("sj_matchmaking_rookieImage"):setVisible(false)
		end
		
		-- ���� ����
		if LadderLimit ~= -1 then
			BattleRoomLadderPointImageSetting(LadderLimit + 1)
			winMgr:getWindow("Battleroom_LadderLimitImage"):setVisible(true)
		else
			winMgr:getWindow("Battleroom_LadderLimitImage"):setVisible(false)
		end
end

function BattleRoomLadderPointImageSetting(Number)
	local MaxLadder = Number + 2
	local MinLadder = Number - 2
	
	if MaxLadder >= 10 then
		local TexXTen = MaxLadder / 10
		local TexXOne = MaxLadder % 10
		
		winMgr:getWindow("Battleroom_LadderLimitImage_Max_Ten_Img"):setVisible(true)
		winMgr:getWindow("Battleroom_LadderLimitImage_Max_One_Img"):setVisible(true)
	
		winMgr:getWindow("Battleroom_LadderLimitImage_Max_Ten_Img"):setTexture("Enabled", "UIData/option.tga", 818 + (TexXTen * 8), 911)
		winMgr:getWindow("Battleroom_LadderLimitImage_Max_Ten_Img"):setTexture("Disabled", "UIData/option.tga", 818 + (TexXTen * 8), 911)
	
		winMgr:getWindow("Battleroom_LadderLimitImage_Max_One_Img"):setPosition(73, 4)
		winMgr:getWindow("Battleroom_LadderLimitImage_Max_One_Img"):setTexture("Enabled", "UIData/option.tga", 818 + (TexXOne * 8), 911)
		winMgr:getWindow("Battleroom_LadderLimitImage_Max_One_Img"):setTexture("Disabled", "UIData/option.tga", 818 + (TexXOne * 8), 911)			
	elseif MaxLadder < 10 then
	
		winMgr:getWindow("Battleroom_LadderLimitImage_Max_One_Img"):setVisible(true)
	
		winMgr:getWindow("Battleroom_LadderLimitImage_Max_One_Img"):setPosition(69, 4)
		winMgr:getWindow("Battleroom_LadderLimitImage_Max_One_Img"):setTexture("Enabled", "UIData/option.tga", 818 + (MaxLadder * 8), 911)
		winMgr:getWindow("Battleroom_LadderLimitImage_Max_One_Img"):setTexture("Disabled", "UIData/option.tga", 818 + (MaxLadder * 8), 911)
	end
	
	if MinLadder >= 10 then
		local TexXTen = MinLadder / 10
		local TexXOne = MinLadder % 10
		
		winMgr:getWindow("Battleroom_LadderLimitImage_Min_Ten_Img"):setVisible(true)
		winMgr:getWindow("Battleroom_LadderLimitImage_Min_One_Img"):setVisible(true)
		
		winMgr:getWindow("Battleroom_LadderLimitImage_Min_Ten_Img"):setTexture("Enabled", "UIData/option.tga", 818 + (TexXTen * 8), 911)
		winMgr:getWindow("Battleroom_LadderLimitImage_Min_Ten_Img"):setTexture("Disabled", "UIData/option.tga", 818 + (TexXTen * 8), 911)
		
		winMgr:getWindow("Battleroom_LadderLimitImage_Min_One_Img"):setPosition(29, 4)
		winMgr:getWindow("Battleroom_LadderLimitImage_Min_One_Img"):setTexture("Enabled", "UIData/option.tga", 818 + (TexXOne * 8), 911)
		winMgr:getWindow("Battleroom_LadderLimitImage_Min_One_Img"):setTexture("Disabled", "UIData/option.tga", 818 + (TexXOne * 8), 911)
		
	elseif MinLadder < 10 then
	
		if MinLadder <= 0 then
			MinLadder = 1
		end
	
		winMgr:getWindow("Battleroom_LadderLimitImage_Min_One_Img"):setVisible(true)

		winMgr:getWindow("Battleroom_LadderLimitImage_Min_One_Img"):setPosition(25, 4)
		winMgr:getWindow("Battleroom_LadderLimitImage_Min_One_Img"):setTexture("Enabled", "UIData/option.tga", 818 + (MinLadder * 8), 911)
		winMgr:getWindow("Battleroom_LadderLimitImage_Min_One_Img"):setTexture("Disabled", "UIData/option.tga", 818 + (MinLadder * 8), 911)
	end
end


--------------------------------------------------------------------

-- �� �̸�

--------------------------------------------------------------------
-- local tMapName = { ["err"]=0, [0]=g_MAPNAME_1, g_MAPNAME_2, g_MAPNAME_3, g_MAPNAME_4, 
-- 								  g_MAPNAME_5, g_MAPNAME_6, g_MAPNAME_7, g_MAPNAME_8, 
-- 								  g_MAPNAME_9, g_MAPNAME_10, g_MAPNAME_11, g_MAPNAME_12 }
								  
-- local tMRMapName = { ["err"]=0, g_MAPNAME_MR1, g_MAPNAME_MR2, g_MAPNAME_MR3}
-- g_currentMapName = ""

-- -- �� �̸�
-- mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_matchmaking_mapName")
-- mywindow:setProperty("FrameEnabled", "false")
-- mywindow:setProperty("BackgroundEnabled", "false")
-- mywindow:setTextColor(255, 255, 255, 255)
-- mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
-- mywindow:setText(tMapName[WndMatchMaking_CurrentMapIndex()])
-- mywindow:setWideType(6);
-- mywindow:setPosition(752, 572)
-- mywindow:setSize(200, 20)
-- mywindow:setViewTextMode(1)
-- mywindow:setAlign(7)
-- mywindow:setLineSpacing(2)
-- mywindow:clearTextExtends()
-- mywindow:setZOrderingEnabled(false)
-- root:addChildWindow(mywindow)

--------------------------------------------------------------------

-- �ʺ��� ��ư

--------------------------------------------------------------------
-- tLRMapButtonName  = { ["protecterr"]=0, "sj_matchmaking_mapChange_LBtn", "sj_matchmaking_mapChange_RBtn" }
-- tLRMapButtonTexX  = { ["protecterr"]=0, 0, 22 }
-- tLRMapButtonPosX  = { ["protecterr"]=0, 699, 976 }
-- tLRMapButtonEvent = { ["protecterr"]=0, "ChangeMap_Left", "ChangeMap_Right" }
-- for i=1, #tLRMapButtonName do
-- 	mywindow = winMgr:createWindow("TaharezLook/Button", tLRMapButtonName[i])
-- 	mywindow:setTexture("Normal", "UIData/C_Button.tga", tLRMapButtonTexX[i], 0)
-- 	mywindow:setTexture("Hover", "UIData/C_Button.tga", tLRMapButtonTexX[i], 27)
-- 	mywindow:setTexture("Pushed", "UIData/C_Button.tga", tLRMapButtonTexX[i], 54)
-- 	mywindow:setTexture("PushedOff", "UIData/C_Button.tga", tLRMapButtonTexX[i], 0)
-- 	mywindow:setWideType(6);
-- 	mywindow:setPosition(tLRMapButtonPosX[i], 567)
-- 	mywindow:setSize(22, 25)
-- 	mywindow:setZOrderingEnabled(false)
-- 	mywindow:subscribeEvent("Clicked", tLRMapButtonEvent[i])
-- 	root:addChildWindow(mywindow)
-- end

-- -- �� ���� ��ư Ŭ��
-- function ChangeMap_Left()
-- 	if WndMatchMaking_IsMaster() == true then
-- 		WndMatchMaking_ChangeMap(0)
-- 	else
-- 		ShowNotifyOKMessage_Lua(g_STRING_WARNING_CHANGEMAP)
-- 	end
-- end

-- -- �� ������ ��ư Ŭ��
-- function ChangeMap_Right()
-- 	if WndMatchMaking_IsMaster() == true then
-- 		WndMatchMaking_ChangeMap(1)
-- 	else
-- 		ShowNotifyOKMessage_Lua(g_STRING_WARNING_CHANGEMAP)
-- 	end
-- end

-- -- ������ �̸� ����
-- function WndMatchMaking_RandomMap()
-- 	DebugStr('WndMatchMaking_RandomMap')
-- 	winMgr:getWindow("sj_matchmaking_mapName"):clearTextExtends()
-- 	winMgr:getWindow("sj_matchmaking_mapName"):setTextExtends(g_MAPNAME_R, g_STRING_FONT_GULIM, 12, 97,230,255,255, 0, 0,255,100,255)
-- end

-- -- ���̸� ����
-- function WndMatchMaking_CurrentMap(mapIndex, gameMode)
-- 	DebugStr('WndMatchMaking_CurrentMap')
-- 	if gameMode == 0 then
-- 		g_currentMapName = tMapName[mapIndex]
-- 		winMgr:getWindow("sj_matchmaking_mapName"):clearTextExtends()
-- 		winMgr:getWindow("sj_matchmaking_mapName"):setTextExtends(tMapName[mapIndex], g_STRING_FONT_GULIM, 12, 97,230,255,255, 0, 0,255,100,255)
-- 	elseif gameMode == 6 then
-- 		if mapIndex >= 100 then
-- 			local index = mapIndex / 100
-- 			g_currentMapName = tMRMapName[index]
-- 			winMgr:getWindow("sj_matchmaking_mapName"):clearTextExtends()
-- 			winMgr:getWindow("sj_matchmaking_mapName"):setTextExtends(tMRMapName[index], g_STRING_FONT_GULIM, 12, 97,230,255,255, 0, 0,255,100,255)
-- 		end
-- 	elseif gameMode == 8 then
-- 		winMgr:getWindow("sj_matchmaking_mapName"):clearTextExtends()
-- 		winMgr:getWindow("sj_matchmaking_mapName"):setTextExtends(g_MAPNAME_DUAL, g_STRING_FONT_GULIM, 12, 97,230,255,255, 0, 0,255,100,255)
-- 	elseif gameMode == 11 then
-- 		g_currentMapName = tMapName[mapIndex]
-- 		winMgr:getWindow("sj_matchmaking_mapName"):clearTextExtends()
-- 		winMgr:getWindow("sj_matchmaking_mapName"):setTextExtends(tMapName[mapIndex], g_STRING_FONT_GULIM, 12, 97,230,255,255, 0, 0,255,100,255)		
-- 	end
-- end

-- function Bomb_CurrentMap(mapIndex)
-- 	winMgr:getWindow("sj_matchmaking_mapName"):setTextExtends(g_MAPNAME_BOMB, g_STRING_FONT_GULIM, 12, 97,230,255,255, 0, 0,255,100,255)		
-- end

-- function MiniTower_CurrentMap(mapIndex)
-- 	winMgr:getWindow("sj_matchmaking_mapName"):setTextExtends(g_MAPNAME_MINITOWER, g_STRING_FONT_GULIM, 12, 97,230,255,255, 0, 0,255,100,255)		
-- end


--------------------------------------------------------------------

-- �漳�� �ʿ��� ����(7��)

--------------------------------------------------------------------
nGameMode		= 0
bTeam			= true
nMaxUser		= 8
nKillCount		= 10
nTimeLimit		= 2
roomName		= ""
roomPassword	= ""


function InitBattleRoomInfo()
	nGameMode		= 0
	bTeam			= true
	nMaxUser		= 8
	nKillCount		= 10
	nTimeLimit		= 2
	roomName		= ""
	roomPassword	= ""
end

--------------------------------------------------------------------

-- �漳��, �ʴ�, ������

--------------------------------------------------------------------
-- tBR_Btn_Name = {["err"]=0, "sj_br_inviteBtn"}
-- tBR_Btn_TexX = {["err"]=0, 100}
-- tBR_Btn_PosX = {["err"]=0, 683}
-- tBR_Btn_PosY = {["err"]=0, 647}
-- tBR_Btn_SizeX = {["err"]=0,  100}
-- tBR_Btn_Event = {["err"]=0, "InviteUserListMode"}
-- tBR_Btn_DisibleTexX = {["err"]=0,  300,  400}
-- for i=1, #tBR_Btn_Name do
-- 	mywindow = winMgr:createWindow("TaharezLook/Button", tBR_Btn_Name[i])
-- 	mywindow:setTexture("Normal", "UIData/match003.tga", tBR_Btn_TexX[i], 610)
-- 	mywindow:setTexture("Hover", "UIData/match003.tga", tBR_Btn_TexX[i], 663)
-- 	mywindow:setTexture("Pushed", "UIData/match003.tga", tBR_Btn_TexX[i], 716)
-- 	mywindow:setTexture("PushedOff", "UIData/match003.tga", tBR_Btn_TexX[i], 610)
-- 	mywindow:setTexture("Disabled", "UIData/match003.tga", tBR_Btn_DisibleTexX[i], 716)
-- 	mywindow:setWideType(6);
-- 	mywindow:setPosition(tBR_Btn_PosX[i], tBR_Btn_PosY[i])
-- 	mywindow:setSize(tBR_Btn_SizeX[i], 53)
-- 	mywindow:setZOrderingEnabled(false)
-- 	if g_currentClubBattle == true then
-- 		--mywindow:setEnabled(false)
-- 	end
-- 	mywindow:subscribeEvent("Clicked", tBR_Btn_Event[i])
-- 	root:addChildWindow(mywindow)
-- end

-- 140 645
-- 139 54
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_br_inviteBtn")
mywindow:setTexture("Normal", "UIData/MatchMakingRoom1.tga", 1, 591)
mywindow:setTexture("Hover", "UIData/MatchMakingRoom1.tga", 142, 591)
mywindow:setTexture("Pushed", "UIData/MatchMakingRoom1.tga", 1, 591)
mywindow:setTexture("PushedOff", "UIData/MatchMakingRoom1.tga", 1, 591)
mywindow:setTexture("Disabled", "UIData/MatchMakingRoom1.tga", 1, 591)
mywindow:setWideType(6);
mywindow:setPosition(876, 54)
mywindow:setSize(142, 56)
mywindow:setZOrderingEnabled(false)
if g_currentClubBattle == true then
	--mywindow:setEnabled(false)
end
mywindow:subscribeEvent("Clicked", "InviteUserListMode")
root:addChildWindow(mywindow)
--------------------------------------------------------------------
-- Rungsimun @ GameInside - Remove invite and room option button.
--------------------------------------------------------------------


-- �漳�� �ϱ�
function BattleRoomReSetupClick()
	if WndMatchMaking_IsMaster() == true then
		if g_currentClubBattle == true then -- Ŭ�����ΰ�� �漳�� �Ҽ� �����Ѵ�
			ShowCommonAlertOkBoxWithFunction(g_STRING_CANNOT_ROOMSETTING, 'OnClickAlertOkSelfHide')
			return 
		end
		winMgr:getWindow("sj_matchmaking_alphaWindow"):setVisible(true)
		winMgr:getWindow("sj_matchmaking_roomAdjustWindow"):setVisible(true)
		
		nGameMode, bTeam, nMaxUser, nKillCount, nTimeLimit, roomName, roomPassword = WndMatchMaking_GetRoomInfo()
		winMgr:getWindow("sj_matchmaking_roomAdjust_roomTitleWindow"):setText(roomName)
		
		if CheckfacilityData(FACILITYCODE_SETROOMPASSWORD) == 1 then
			winMgr:getWindow("sj_matchmaking_roomAdjust_passwordWindow"):setText(roomPassword)
		end
		ChangeUser()
		ChangeLimitTime()
	else
		ShowNotifyOKMessage_Lua(g_STRING_WARNING_ADJUSTROOM)
	end
	
	-- �漳���� ������ ä��â�� ��Ȱ��ȭ ��Ų��
	winMgr:getWindow("doChatting"):setEnabled(false)
end


-- �ʴ��ϱ�
function InviteUserListMode()
	if WndMatchMaking_IsNotIdle() then
		return
	end
	if g_currentClubBattle == true then -- Ŭ�����ΰ�� �ʴ븦 �Ҽ� ���� �Ѵ�
		--return 
	end
	winMgr:getWindow("sj_matchmaking_alphaWindow"):setVisible(true)
	winMgr:getWindow("sj_matchmaking_inviteAdjustWindow"):setVisible(true)
	WndMatchMaking_GetInviteUserList()
end


-- ������
function BattleRoomOut()

	-- ���� ���� �غ������� Ȯ���� �ƴϸ� ������.
	if WndMatchMaking_IsObserver() == true then
		RequestExitRoom()
	else
		if WndMatchMaking_GetReady(WndMatchMaking_GetMyIndex()) == false then
			if WndMatchMaking_IsNotIdle() then
				return
			end
			RequestExitRoom()
		else
			ShowNotifyOKMessage_Lua(g_STRING_WARNING_1)
			-- isExit = false
			-- DoShowExitBtn(true)
		end
	end
end

--------------------------------------------------------------------

-- �����ϱ�/�غ��ϱ� ��ư

--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_matchmaking_startAndReadyBtn")
mywindow:setTexture("Normal", "UIData/MatchMakingRoom1.tga", 1, 1)
mywindow:setTexture("Hover", "UIData/MatchMakingRoom1.tga", 334, 1)
mywindow:setTexture("Pushed", "UIData/MatchMakingRoom1.tga", 1, 1)
mywindow:setTexture("PushedOff", "UIData/MatchMakingRoom1.tga", 1, 1)
mywindow:setTexture("Disabled", "UIData/MatchMakingRoom1.tga", 667, 1)
mywindow:setWideType(6);
mywindow:setPosition(688, 568)
mywindow:setSize(331, 128)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnWndMatchMaking_Ready")
root:addChildWindow(mywindow)


--------------------------------------------------------------------

-- ���콺 Ŭ�� �̹���

--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_matchmaking_mouseClickImage")
mywindow:setTexture("Enabled", "UIData/other001.tga", 0, 397)
mywindow:setTexture("Disabled", "UIData/other001.tga", 0, 397)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(770, 630)
mywindow:setSize(155, 98)
mywindow:setZOrderingEnabled(false)
mywindow:setEnabled(false)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
root:addChildWindow(mywindow)


--------------------------------------------------------------------

-- ���ٲٱ� ��ư

--------------------------------------------------------------------
if g_currentClubBattle == false then  -- Ŭ�� ��尡 �ƴҰ�츸
	if g_currentTeamBattle == true then
		mywindow = winMgr:createWindow("TaharezLook/Button", "sj_matchmaking_changeTeamBtn")
		mywindow:setTexture("Normal", "UIData/battleroom001.tga", 894, 239)
		mywindow:setTexture("Hover", "UIData/battleroom001.tga", 894, 341)
		mywindow:setTexture("Pushed", "UIData/battleroom001.tga", 894, 443)
		mywindow:setTexture("PushedOff", "UIData/battleroom001.tga", 894, 545)
		mywindow:setWideType(6);
		mywindow:setPosition(447, 273)
		mywindow:setSize(130, 102)
		mywindow:setZOrderingEnabled(false)
		mywindow:subscribeEvent("Clicked", "RequestChangeTeam")
		root:addChildWindow(mywindow)
	end
end


--------------------------------------------------------------------

-- ������ Ŭ����/���� ���ù�ư

--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_matchmaking_freezoneSelectBtn")
mywindow:setTexture("Normal", "UIData/Event_FreezoneSelect.tga", 708, 0)
mywindow:setTexture("Hover", "UIData/Event_FreezoneSelect.tga", 708, 45)
mywindow:setTexture("Pushed", "UIData/Event_FreezoneSelect.tga", 708, 90)
mywindow:setTexture("PushedOff", "UIData/Event_FreezoneSelect.tga", 708, 0)
mywindow:setWideType(6);
mywindow:setPosition(465, 415)
mywindow:setSize(95, 45)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickedFreeZoneSelect")
root:addChildWindow(mywindow)

function SetFreeZoneSelectButton(bShow)
	winMgr:getWindow("sj_matchmaking_freezoneSelectBtn"):setVisible(bShow)
end

function ClickedFreeZoneSelect()
	CallFreeZoneSelect(true)
end


--------------------------------------------------------------------

-- ȣ��Ʈ ����

--------------------------------------------------------------------
-- 1, 282, 564
-- function WndMatchMaking_HostChanged(hostindex, myindex)
	
-- 	winMgr:getWindow("sj_matchmaking_startAndReadyBtn"):setEnabled(true)
		
-- 	if hostindex == myindex then
		
-- 		local allOK = PlayManager_IsAllPlayable()
		
-- 		if( allOK > 0 ) then		
-- 			winMgr:getWindow("sj_matchmaking_startAndReadyBtn"):setTexture("Normal",		"UIData/match003.tga", 0, 74)
-- 			winMgr:getWindow("sj_matchmaking_startAndReadyBtn"):setTexture("Hover",		"UIData/match003.tga", 0, 208)
-- 			winMgr:getWindow("sj_matchmaking_startAndReadyBtn"):setTexture("Pushed",		"UIData/match003.tga", 0, 342)
-- 			winMgr:getWindow("sj_matchmaking_startAndReadyBtn"):setTexture("PushedOff",	"UIData/match003.tga", 0, 74)
-- 		else
-- 			winMgr:getWindow("sj_matchmaking_startAndReadyBtn"):setEnabled(false)
-- 			winMgr:getWindow("sj_matchmaking_startAndReadyBtn"):setTexture("Disabled",	"UIData/match003.tga", 0, 476)
-- 		end
-- 	else
		
-- 		local settingOK = PlayManager_IsNetworkSettingOK(myindex)
				
-- 		if WndMatchMaking_GetReady(myindex) == true then
-- 			if settingOK > 0 then
-- 				winMgr:getWindow("sj_matchmaking_startAndReadyBtn"):setTexture("Normal",		"UIData/match003.tga", 708, 149)
-- 				winMgr:getWindow("sj_matchmaking_startAndReadyBtn"):setTexture("Hover",		"UIData/match003.tga", 708, 283)
-- 				winMgr:getWindow("sj_matchmaking_startAndReadyBtn"):setTexture("Pushed",		"UIData/match003.tga", 708, 417)
-- 				winMgr:getWindow("sj_matchmaking_startAndReadyBtn"):setTexture("PushedOff",	"UIData/match003.tga", 708, 149)
-- 			else
-- 				winMgr:getWindow("sj_matchmaking_startAndReadyBtn"):setEnabled(false)
-- 				winMgr:getWindow("sj_matchmaking_startAndReadyBtn"):setTexture("Disabled",	"UIData/match003.tga", 481, 476)
-- 			end
-- 		else
-- 			if settingOK > 0 then
-- 				winMgr:getWindow("sj_matchmaking_startAndReadyBtn"):setTexture("Normal",		"UIData/match003.tga", 481, 74)
-- 				winMgr:getWindow("sj_matchmaking_startAndReadyBtn"):setTexture("Hover",		"UIData/match003.tga", 481, 208)
-- 				winMgr:getWindow("sj_matchmaking_startAndReadyBtn"):setTexture("Pushed",		"UIData/match003.tga", 481, 342)
-- 				winMgr:getWindow("sj_matchmaking_startAndReadyBtn"):setTexture("PushedOff",	"UIData/match003.tga", 481, 74)
-- 			else
-- 				winMgr:getWindow("sj_matchmaking_startAndReadyBtn"):setEnabled(false)
-- 				winMgr:getWindow("sj_matchmaking_startAndReadyBtn"):setTexture("Disabled",	"UIData/match003.tga", 708, 551)
-- 			end
-- 		end
-- 	end
-- end


-- function WndMatchMaking_ChangeReady(isReady)
-- 	if isReady == 1 then
-- 		winMgr:getWindow("sj_matchmaking_startAndReadyBtn"):setTexture("Normal",		"UIData/match003.tga", 481, 74)
-- 		winMgr:getWindow("sj_matchmaking_startAndReadyBtn"):setTexture("Hover",		"UIData/match003.tga", 481, 208)
-- 		winMgr:getWindow("sj_matchmaking_startAndReadyBtn"):setTexture("Pushed",		"UIData/match003.tga", 481, 342)
-- 		winMgr:getWindow("sj_matchmaking_startAndReadyBtn"):setTexture("PushedOff",	"UIData/match003.tga", 481, 74)
-- 	else
-- 		winMgr:getWindow("sj_matchmaking_startAndReadyBtn"):setTexture("Normal",		"UIData/match003.tga", 708, 149)
-- 		winMgr:getWindow("sj_matchmaking_startAndReadyBtn"):setTexture("Hover",		"UIData/match003.tga", 708, 283)
-- 		winMgr:getWindow("sj_matchmaking_startAndReadyBtn"):setTexture("Pushed",		"UIData/match003.tga", 708, 417)
-- 		winMgr:getWindow("sj_matchmaking_startAndReadyBtn"):setTexture("PushedOff",	"UIData/match003.tga", 708, 149)
-- 	end
-- end




-- function WndMatchMaking_ClickEffectState(state)
-- 	if winMgr:getWindow("sj_matchmaking_startAndReadyBtn"):isDisabled() == false then
-- 		if state == 1 then
-- 			winMgr:getWindow("sj_matchmaking_mouseClickImage"):setVisible(true)
-- 		else
-- 			winMgr:getWindow("sj_matchmaking_mouseClickImage"):setVisible(false)
-- 		end
-- 	end
-- end



-- function WndMatchMaking_LastEffectState(state)
-- 	if state == 1 then
-- 		winMgr:getWindow("sj_matchmaking_mouseClickImage"):setVisible(true)
-- 	else
-- 		winMgr:getWindow("sj_matchmaking_mouseClickImage"):setVisible(false)
-- 	end
-- end



-- function WndMatchMaking_PressingReady(flag)
-- 	if winMgr:getWindow("sj_matchmaking_startAndReadyBtn"):isDisabled() == false then
-- 		if flag == 0 then
-- 			winMgr:getWindow("sj_matchmaking_mouseClickImage"):setTexture("Disabled", "UIData/other001.tga", 0, 397)
-- 		else
-- 			winMgr:getWindow("sj_matchmaking_mouseClickImage"):setTexture("Disabled", "UIData/other001.tga", 0, 495)
-- 		end
-- 	end
-- end


--------------------------------------------------------------------
-- ������! �ο���! �̱���! �̺�Ʈ ��������
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_battleroomWinCountBackImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 439, 200)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 439, 200)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(446, 648)
mywindow:setSize(215, 36)
mywindow:setZOrderingEnabled(false)
mywindow:setEnabled(false)
if CheckfacilityData(FACILITYCODE_WINSTREAK) == 0 then
	mywindow:setVisible(false)
end
root:addChildWindow(mywindow)

--------------------------------------------------------------------

-- ������! �ο���! �̱���! �̺�Ʈ

--------------------------------------------------------------------
-- mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_battleroomWinCount")
-- mywindow:setTexture("Enabled", "UIData/match003.tga", 439, 200)
-- mywindow:setTexture("Disabled", "UIData/match003.tga", 439, 200)
-- mywindow:setProperty("FrameEnabled", "False")
-- mywindow:setProperty("BackgroundEnabled", "False")
-- mywindow:setPosition(0, 0)
-- mywindow:setSize(40, 36)
-- mywindow:setZOrderingEnabled(false)
-- mywindow:setEnabled(false)
-- mywindow:setAlign(8);
-- mywindow:addController("successController", "eventAction", "xscale", "Elastic_EaseOut", 1, 260, 9, true, true, 10)
-- mywindow:addController("successController", "eventAction", "yscale", "Elastic_EaseOut", 1, 260, 9, true, true, 10)
-- winMgr:getWindow('sj_battleroomWinCountBackImage'):addChildWindow(mywindow)
-- local bCallEventOnce = true

-- function WndMatchMaking_InitEventInfo()
-- 	bCallEventOnce = true
-- end

-- function WndMatchMaking_ShowEventInfo(bComplete, step, winCount, currentRewardValue, timeInfo)
-- 	if CheckfacilityData(FACILITYCODE_WINSTREAK) == 1 then
-- 		if bComplete == 1 then
-- 			drawer:drawTexture("UIData/match003.tga", 442, 590, 232, 24, 439, 845, WIDETYPE_6)	-- ���������� �ܰ���� �����
-- 			drawer:drawTexture("UIData/match003.tga", 442, 638, 232, 100, 439, 910, WIDETYPE_6)	-- ���������� ��� ���� �����
-- 			drawer:drawTexture("UIData/match001.tga", 445, 670, 219, 40, 775, 71, WIDETYPE_6)	-- Complete �����ֱ�
-- 		else	

-- 			-- �ܰ�
-- 			drawer:setFont(g_STRING_FONT_DODUMCHE, 16)
-- 			drawer:setTextColor(255,0,0,255)
-- 			local stepSize = GetStringSize(g_STRING_FONT_DODUMCHE, 16, tostring(step+1))
-- 			drawer:drawText(tostring(step+1), 509-stepSize/2, 582, WIDETYPE_6)
			
-- 			-- ���� �׶�
-- 			drawer:setFont(g_STRING_FONT_DODUMCHE, 16)
-- 			drawer:setTextColor(0,255,0,255)
-- 			local timeSize = GetStringSize(g_STRING_FONT_DODUMCHE, 16, tostring(currentRewardValue))
-- 			drawer:drawText(currentRewardValue, 606-timeSize, 583, WIDETYPE_6)
		
-- 			-- �¸� ǥ��
-- 			local tryCount = winCount + 1
-- 			if tryCount > 0 then
-- 				for i=1, tryCount do
-- 					if i == tryCount then
-- 						if bCallEventOnce then
-- 							bCallEventOnce = false
-- 							winMgr:getWindow("sj_battleroomWinCount"):setVisible(true)
-- 							winMgr:getWindow("sj_battleroomWinCount"):setPosition(i*44-44,0)
-- 							winMgr:getWindow("sj_battleroomWinCount"):activeMotion("eventAction")
-- 						end
-- 					else
-- 						drawer:drawTexture("UIData/match003.tga", i*44+402, 647, 42, 39, 439, 160, WIDETYPE_6)
-- 					end
-- 				end
-- 			end
-- 		end
		
-- 		-- �ð�
-- 		drawer:setFont(g_STRING_FONT_DODUMCHE, 13)
-- 		drawer:setTextColor(255,255,255,255)
-- 		local timeSize = GetStringSize(g_STRING_FONT_DODUMCHE, 14, timeInfo)
-- 		--drawer:drawText(timeInfo, 470, 705, WIDETYPE_6)
-- 		common_DrawOutlineText1(drawer, timeInfo, 476, 688, 255,50,120, 255, 255,255,255,255 ,WIDETYPE_6)
-- 	end
-- end



--------------------------------------------

-- ���� ���� �˾�â

--------------------------------------------
-- ��׶��� ���� �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_matchmaking_ban_alphaWindow")
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


-- �������� ��ǥ ����â
banpollwindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_matchmaking_ban_backWindow")
banpollwindow:setTexture("Enabled", "UIData/frame/frame_002.tga", 0, 0)
banpollwindow:setTexture("Disabled", "UIData/frame/frame_002.tga", 0, 0)
banpollwindow:setframeWindow(true)
banpollwindow:setProperty("FrameEnabled", "False")
banpollwindow:setProperty("BackgroundEnabled", "False")
banpollwindow:setPosition(342, 250)
banpollwindow:setSize(339, 268)
banpollwindow:setVisible(false)
banpollwindow:setAlwaysOnTop(true)
banpollwindow:setZOrderingEnabled(false)
root:addChildWindow(banpollwindow)

-- ��Ƽ ��ġ ESCŰ ���
RegistEscEventInfo("sj_matchmaking_ban_backWindow", "BanToPollNo")

-- �������� ��ǥ âŸ��Ʋ �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_matchmaking_ban_backWindowTitleImage")
mywindow:setTexture("Enabled", "UIData/party003.tga", 383, 907)
mywindow:setTexture("Disabled", "UIData/party003.tga", 383, 907)
mywindow:setPosition(104, 3)
mywindow:setSize(130, 27)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
banpollwindow:addChildWindow(mywindow)

-- �������� ��ǥ �����ؽ�Ʈ
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_matchmaking_ban_descWindow")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setPosition(0, 128)
mywindow:setSize(349, 100)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:clearTextExtends()
mywindow:setAlwaysOnTop(true)
banpollwindow:addChildWindow(mywindow)

-- �������� ��ǥ �̸� �ؽ�Ʈ ���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_matchmaking_ban_nameBackground");
mywindow:setTexture("Enabled", "UIData/party003.tga", 557, 751)
mywindow:setTexture("Disabled", "UIData/party003.tga", 557, 751)
mywindow:setPosition(34, 59)
mywindow:setSize(267, 32)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
banpollwindow:addChildWindow(mywindow)

-- �������� ��ǥ �̸� �ؽ�Ʈ
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_matchmaking_ban_nameWindow")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 200, 80, 255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setPosition(0, 30)
mywindow:setSize(349, 100)
mywindow:setAlwaysOnTop(true)
banpollwindow:addChildWindow(mywindow)

-- �������� ��ǥ ���� �ð� �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_matchmaking_ban_decisionTime")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 324, 419)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 324, 419)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(300, 60)
mywindow:setSize(20, 27)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
banpollwindow:addChildWindow(mywindow)

tTimeNumber = {["err"]=0, [0]=324, 344, 364, 384, 404, 424, 444, 464, 484, 504}
function WndMatchMaking_SetPollTime(time)
	if winMgr:getWindow("sj_matchmaking_ban_decisionTime") then
		if winMgr:getWindow("sj_matchmaking_ban_decisionTime"):isVisible() then
			winMgr:getWindow("sj_matchmaking_ban_decisionTime"):setTexture("Enabled", "UIData/numberUi001.tga", tTimeNumber[time], 419)
			winMgr:getWindow("sj_matchmaking_ban_decisionTime"):setTexture("Enabled", "UIData/numberUi001.tga", tTimeNumber[time], 419)
		end
	end
end

-- �������� ��ǥ ������ư
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_matchmaking_ban_YesBtn")
mywindow:setTexture("Normal", "UIData/party003.tga", 383, 751)
mywindow:setTexture("Hover", "UIData/party003.tga", 383, 790)
mywindow:setTexture("Pushed", "UIData/party003.tga", 383, 829)
mywindow:setTexture("PushedOff", "UIData/party003.tga", 383, 751)
mywindow:setTexture("Disabled", "UIData/party003.tga", 383, 868)
mywindow:setPosition(62, 216)
mywindow:setSize(87, 39)
mywindow:setAlwaysOnTop(true)
mywindow:subscribeEvent("Clicked", "BanToPollYes")
banpollwindow:addChildWindow(mywindow)

function BanToPollYes()
	WndMatchMaking_DecisionPollToBan(true)
	ClearBanWindows(false)
end

-- �������� ��ǥ �ݴ��ư
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_matchmaking_ban_NoBtn")
mywindow:setTexture("Normal", "UIData/party003.tga", 470, 751)
mywindow:setTexture("Hover", "UIData/party003.tga", 470, 790)
mywindow:setTexture("Pushed", "UIData/party003.tga", 470, 829)
mywindow:setTexture("PushedOff", "UIData/party003.tga", 470, 751)
mywindow:setTexture("Disabled", "UIData/party003.tga", 470, 868)
mywindow:setPosition(189, 216)
mywindow:setSize(87, 39)
mywindow:setAlwaysOnTop(true)
mywindow:subscribeEvent("Clicked", "BanToPollNo")
banpollwindow:addChildWindow(mywindow)

function BanToPollNo()
	WndMatchMaking_DecisionPollToBan(false)
	ClearBanWindows(false)
end

-- �������� ��ǥ�� �������� ��
function WndMatchMaking_ProposePollToBan(name, msg)
	ClearBanWindows(true)
	winMgr:getWindow("sj_matchmaking_ban_descWindow"):setTextExtends(msg, g_STRING_FONT_GULIMCHE, 14, 255,255,255,255,  0, 0,0,0,255)
	
	local nameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 14, name)
	winMgr:getWindow("sj_matchmaking_ban_nameWindow"):setPosition(171-nameSize/2, 26)
	winMgr:getWindow("sj_matchmaking_ban_nameWindow"):setText(name)
end

function ClearBanWindows(bVisible)
	winMgr:getWindow("sj_matchmaking_ban_alphaWindow"):setVisible(bVisible)
	winMgr:getWindow("sj_matchmaking_ban_backWindow"):setVisible(bVisible)
	winMgr:getWindow("sj_matchmaking_ban_nameWindow"):setText("")
end

--------------------------------------------

-- ��������(1.�ɸ�����(����)  2.�ɸ�����(�̸�)  3.��Ÿ��  4.��Ʈ��ũ  5.������  6.��������  7.������  8.����  9. ����â)

--------------------------------------------

for i=0, 3 do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_matchmaking_playerclass")
	mywindow:setTexture("Enabled", "UIData/MatchMakingRoom2.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/MatchMakingRoom2.tga", 0, 0)
	-- userInfoWindow:setTexture("Enabled", "UIData/MatchMakingRoom2.tga", 142, 309)
	-- userInfoWindow:setTexture("Disabled", "UIData/MatchMakingRoom2.tga", 142, 309)
	mywindow:setProperty("FrameEnabled", "True")
	mywindow:setProperty("BackgroundEnabled", "True")
	mywindow:setWideType(6);
	mywindow:setPosition(114 + ((142 + 74)*i), 215)
	mywindow:setSize(144, 310)
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(true)
	mywindow:setVisible(true)
	-- mywindow:setUserString("userIndex", tostring(i))
	-- mywindow:setUserString("posX", 0)
	-- mywindow:setUserString("posY", 0)
	-- mywindow:subscribeEvent("MouseMove",  "OnMouseMove_UserInfo")
	-- mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_UserInfo")
	-- mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_UserInfo")
	root:addChildWindow(mywindow)
end

local tReverseSort1 = {["err"]=0, [0]=1, 3, 5, 7, 4, 6, 0, 2 }	-- (������)���̾� ������ ���� �����ϰ� �ϱ�^^;
local tReverseSort2 = {["err"]=0, [0]=4, 5, 6, 7, 2, 3, 0, 1 }	-- (����)���̾� ������ ���� �����ϰ� �ϱ�^^;
for index=0, 7 do

	local i = tReverseSort1[index]
	if g_currentTeamBattle then
		i = tReverseSort2[index]
	end	

	-- �������� �����̹���
	userInfoWindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_matchmaking_userBackImage")
	-- userInfoWindow:setTexture("Enabled", "UIData/battleroom001.tga", 0, 828)
	-- userInfoWindow:setTexture("Disabled", "UIData/battleroom001.tga", 0, 828)
	userInfoWindow:setTexture("Enabled", "UIData/MatchMakingRoom1.png", 242, 837)
	userInfoWindow:setProperty("FrameEnabled", "True")
	userInfoWindow:setProperty("BackgroundEnabled", "True")
	userInfoWindow:setPosition(0, 0)
	-- userInfoWindow:setSize(128, 43)
	userInfoWindow:setSize(151, 93)
	userInfoWindow:setZOrderingEnabled(false)
	userInfoWindow:setEnabled(true)
	userInfoWindow:setVisible(false)
	userInfoWindow:setUserString("userIndex", tostring(i))
	userInfoWindow:setUserString("posX", 0)
	userInfoWindow:setUserString("posY", 0)
	userInfoWindow:subscribeEvent("MouseMove",  "OnMouseMove_UserInfo")
	userInfoWindow:subscribeEvent("MouseEnter", "OnMouseEnter_UserInfo")
	userInfoWindow:subscribeEvent("MouseLeave", "OnMouseLeave_UserInfo")
	--root:addChildWindow(userInfoWindow)
	userInfoBackWindow:addChildWindow(userInfoWindow)	-- ACTIVATE/DEACTIVATE

	-- �ɸ�����(����)
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_matchmaking_userInfo_level")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setText("")
	mywindow:setPosition(3, 25)
	mywindow:setSize(20, 15)
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(false)
	mywindow:setVisible(true)
	userInfoWindow:addChildWindow(mywindow)	
	
	-- �ɸ�����(�̸�)
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_matchmaking_userInfo_name")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setText("")
	mywindow:setPosition(50, 25)
	mywindow:setSize(100, 15)
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(false)
	mywindow:setVisible(true)
	userInfoWindow:addChildWindow(mywindow)

	-- ��Ÿ��
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_matchmaking_userInfo_styleImage")
	mywindow:setTexture("Enabled", "UIData/skillitem001.tga", 497, 0)
	mywindow:setTexture("Disabled", "UIData/skillitem001.tga", 497, 0)
	mywindow:setTexture("Layered", "UIData/skillitem001.tga", 497, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(56, -6)
	mywindow:setSize(87, 35)
	mywindow:setScaleWidth(160)
	mywindow:setScaleHeight(160)
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(false)
	mywindow:setVisible(true)
	mywindow:setLayered(true)
	userInfoWindow:addChildWindow(mywindow)	
	
	-- Īȣ
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_matchmaking_userInfo_title")
	mywindow:setTexture("Enabled", "UIData/numberUi001.tga", 0, 201)
	mywindow:setTexture("Disabled", "UIData/numberUi001.tga", 0, 201)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(-3, 26)
	mywindow:setSize(107, 18)
	mywindow:setPosition(46, 25 + 28)
	mywindow:setScaleWidth(240)
	mywindow:setScaleHeight(240)
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(false)
	mywindow:setVisible(true)
	userInfoWindow:addChildWindow(mywindow)	
	
	-- Ŭ��Īȣ
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_matchmaking_userInfo_title2")
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setText("")
	mywindow:setPosition(5, 26)
	mywindow:setSize(107, 18)
	mywindow:setViewTextMode(1)
	mywindow:setAlign(1)
	mywindow:setLineSpacing(5)
	mywindow:clearTextExtends()
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(false)
	mywindow:setVisible(false)
	userInfoWindow:addChildWindow(mywindow)
	
	-- ����
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_matchmaking_userInfo_ladder")
	mywindow:setTexture("Enabled", "UIData/numberUi001.tga", 113, 600)
	mywindow:setTexture("Disabled", "UIData/numberUi001.tga", 113, 600)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(2, 23)
	mywindow:setSize(47, 21)
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(false)
	mywindow:setVisible(true)
	userInfoWindow:addChildWindow(mywindow)
	
	-- Ŭ�� �̹���
	mywindow = winMgr:createWindow('TaharezLook/StaticImage', i .."sj_matchmaking_clubEmbleImage")
	mywindow:setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
	mywindow:setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
	mywindow:setProperty('BackgroundEnabled', 'False')
	mywindow:setProperty('FrameEnabled', 'False')
	mywindow:setPosition(-41, -5) ---23, 23
	mywindow:setSize(32, 32)
	mywindow:setEnabled(false)
	mywindow:setVisible(false)
	userInfoWindow:addChildWindow(mywindow)
	
	-- �������� �̹���
	mywindow = winMgr:createWindow('TaharezLook/StaticImage', i .."sj_matchmaking_profileImage")
	mywindow:setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
	mywindow:setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
	mywindow:setProperty('BackgroundEnabled', 'False')
	mywindow:setProperty('FrameEnabled', 'False')
	mywindow:setPosition(-41, 18)
	mywindow:setSize(64, 64)
	mywindow:setEnabled(false)
	mywindow:setVisible(false)
	userInfoWindow:addChildWindow(mywindow)
	
	-- �ٸ� ������ Īȣ �̹���.
	mywindow = winMgr:createWindow('TaharezLook/StaticImage', i .."sj_matchmaking_DiffTitleImage")
	mywindow:setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
	mywindow:setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
	mywindow:setPosition(-41, 18)
	mywindow:setSize(64, 64)
	mywindow:setEnabled(false)
	mywindow:setVisible(false)
	userInfoWindow:addChildWindow(mywindow)
	
	---------------------------------
	-- ��Ʈ��ũ
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_matchmaking_userInfo_networkImage")
	mywindow:setTexture("Enabled", "UIData/battleroom001.tga", 0, 1017)
	mywindow:setTexture("Disabled", "UIData/battleroom001.tga", 0, 1017)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(3, 18)
	mywindow:setSize(0, 5)
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(false)
	mywindow:setVisible(true)
	userInfoWindow:addChildWindow(mywindow)
	
	-- ��������
	mywindow = winMgr:createWindow("TaharezLook/Button", i .. "sj_matchmaking_userInfo_banBtn")
	mywindow:setTexture("Normal", "UIData/battleroom001.tga", 770, 655)
	mywindow:setTexture("Hover", "UIData/battleroom001.tga", 770, 671)
	mywindow:setTexture("Pushed", "UIData/battleroom001.tga", 770, 687)
	mywindow:setTexture("PushedOff", "UIData/battleroom001.tga", 770, 655)
	mywindow:setTexture("Enabled", "UIData/battleroom001.tga", 770, 655)
	mywindow:setTexture("Disabled", "UIData/battleroom001.tga", 770, 703)
	--mywindow:setPosition(136, 10)
	mywindow:setPosition(136, 10)
	mywindow:setSize(16, 16)
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(true)
	mywindow:setVisible(true)
	mywindow:setUserString("userIndex", tostring(i))
	mywindow:subscribeEvent("Clicked", "CompulsorilyOutClick")
	userInfoWindow:addChildWindow(mywindow)
	
	-- ���� ������ 1
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_matchmaking_userInfo_superMasterImage1")
	mywindow:setTexture("Enabled", "UIData/battleroom001.tga", 129, 966)
	mywindow:setTexture("Disabled", "UIData/battleroom001.tga", 129, 966)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(-29, -24)
	mywindow:setSize(95, 40)
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(false)
	mywindow:setVisible(true)
	mywindow:addController("motion", "AlphaMotion1", "alpha", "Sine_EaseInOut", 255, 0, 10, true, true, 10)
	mywindow:addController("motion", "AlphaMotion1", "alpha", "Sine_EaseInOut", 0, 255, 10, true, true, 10)
	userInfoWindow:addChildWindow(mywindow)
	
	-- ���� ������ 2
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_matchmaking_userInfo_superMasterImage2")
	mywindow:setTexture("Enabled", "UIData/battleroom001.tga", 224, 966)
	mywindow:setTexture("Disabled", "UIData/battleroom001.tga", 224, 966)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(-29, -24)
	mywindow:setSize(95, 40)
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(false)
	mywindow:setVisible(true)
	mywindow:addController("motion", "AlphaMotion2", "alpha", "Sine_EaseInOut", 0, 255, 10, true, true, 10)
	mywindow:addController("motion", "AlphaMotion2", "alpha", "Sine_EaseInOut", 255, 0, 10, true, true, 10)
	userInfoWindow:addChildWindow(mywindow)
	
	-- ������
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_matchmaking_userInfo_masterImage")
	mywindow:setTexture("Enabled", "UIData/battleroom001.tga", 136, 837)
	mywindow:setTexture("Disabled", "UIData/battleroom001.tga", 136, 837)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(0, 5)
	mywindow:setSize(75, 24)
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(false)
	mywindow:setVisible(true)
	userInfoWindow:addChildWindow(mywindow)
		
	-- ����
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_matchmaking_userInfo_readyImage")
	mywindow:setTexture("Enabled", "UIData/battleroom001.tga", 136, 868)
	mywindow:setTexture("Disabled", "UIData/battleroom001.tga", 136, 868)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(0, 5)
	mywindow:setSize(75, 26)
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(false)
	mywindow:setVisible(true)
	userInfoWindow:addChildWindow(mywindow)

	-- Init rank image
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_matchmaking_userInfo_rankImage")
	mywindow = drawRankWindow(mywindow, 0, -2, 27, 200)
	-- 565 296 , 3 
	userInfoWindow:addChildWindow(mywindow)
	
	-- ����ī��
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_matchmaking_userInfo_icafeImage")
	mywindow:setTexture("Enabled", "UIData/LobbyImage_new.tga", 729, 235)
	mywindow:setTexture("Disabled", "UIData/LobbyImage_new.tga", 729, 235)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(128, -6)
	mywindow:setSize(64, 45)
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(false)
	mywindow:setVisible(true)
	mywindow:setScaleWidth(160)
	mywindow:setScaleHeight(160)
	userInfoWindow:addChildWindow(mywindow)
		
	-- ���Ƽ
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_matchmaking_userInfo_penaltyDesc")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setText("")
	mywindow:setPosition(4, 45)
	mywindow:setSize(20, 15)
	mywindow:setViewTextMode(1)
	mywindow:setAlign(1)
	mywindow:setLineSpacing(5)
	mywindow:clearTextExtends()
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(false)
	mywindow:setVisible(false)
	userInfoWindow:addChildWindow(mywindow)
	
	
	-----------------------------------------
	-- ����â
	-----------------------------------------
	recordwindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_matchmaking_userInfo_infoWindow")
	recordwindow:setTexture("Enabled", "UIData/myinfo.tga", 737, 731)
	recordwindow:setTexture("Disabled", "UIData/myinfo.tga", 737, 731)
	recordwindow:setProperty("FrameEnabled", "False")
	recordwindow:setProperty("BackgroundEnabled", "False")
	recordwindow:setPosition(0, 0)
	recordwindow:setSize(164, 241)
	recordwindow:setZOrderingEnabled(false)
	recordwindow:setEnabled(false)
	recordwindow:setVisible(false)
	root:addChildWindow(recordwindow)
	
	-- ���ϵ� ����
	---------------------------------
		-- ����â ���ϵ�(������)
		mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_matchmaking_infoWindow_totalRecord")
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(255,255,0,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
		mywindow:setPosition(120, 25)
		mywindow:setSize(60, 15)
		mywindow:setZOrderingEnabled(false)
		mywindow:setEnabled(false)
		recordwindow:addChildWindow(mywindow)
		
		-- ����â ���ϵ�(������)
		mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_matchmaking_infoWindow_privatBattleNum")
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(11,246,255,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
		mywindow:setPosition(120, 43)
		mywindow:setSize(60, 15)
		mywindow:setZOrderingEnabled(false)
		mywindow:setEnabled(false)
		recordwindow:addChildWindow(mywindow)
		
		-- ����â ���ϵ�(����)
		mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_matchmaking_infoWindow_teamBattleNum")
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(11,246,255,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
		mywindow:setPosition(120, 64)
		mywindow:setSize(60, 15)
		mywindow:setZOrderingEnabled(false)
		mywindow:setEnabled(false)
		recordwindow:addChildWindow(mywindow)
		
		-- ����â ���ϵ�(KO)
		mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_matchmaking_infoWindow_koNum")
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(217,115,255,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
		mywindow:setPosition(120, 86)
		mywindow:setSize(60, 15)
		mywindow:setZOrderingEnabled(false)
		mywindow:setEnabled(false)
		recordwindow:addChildWindow(mywindow)
		
		-- ����â ���ϵ�(KO��)
		mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_matchmaking_infoWindow_koRate")
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(217,115,255,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
		mywindow:setPosition(120, 111)
		mywindow:setSize(60, 15)
		mywindow:setZOrderingEnabled(false)
		mywindow:setEnabled(false)
		recordwindow:addChildWindow(mywindow)
		
		-- ����â ���ϵ�(��������Ʈ)
		mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_matchmaking_infoWindow_ladderPoint")
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(217,115,255,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
		mywindow:setPosition(120, 111)
		mywindow:setSize(60, 15)
		mywindow:setZOrderingEnabled(false)
		mywindow:setEnabled(false)
		recordwindow:addChildWindow(mywindow)
		
		-- ����â ���ϵ�(MVP)
		mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_matchmaking_infoWindow_mvpNum")
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(7,150,252,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
		mywindow:setPosition(120, 134)
		mywindow:setSize(60, 15)
		mywindow:setZOrderingEnabled(false)
		mywindow:setEnabled(false)
		recordwindow:addChildWindow(mywindow)
		
		-- ����â ���ϵ�(������)
		mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_matchmaking_infoWindow_teamAtkNum")
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(7,150,252,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
		mywindow:setPosition(120, 157)
		mywindow:setSize(60, 15)
		mywindow:setZOrderingEnabled(false)
		mywindow:setEnabled(false)
		recordwindow:addChildWindow(mywindow)
		
		-- ����â ���ϵ�(��������)
		mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_matchmaking_infoWindow_doubleAtkNum")
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(7,150,252,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
		mywindow:setPosition(120, 180)
		mywindow:setSize(60, 15)
		mywindow:setZOrderingEnabled(false)
		mywindow:setEnabled(false)
		recordwindow:addChildWindow(mywindow)
		
		-- ����â ���ϵ�(����Ʈ ���� Ƚ��)
		mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_matchmaking_infoWindow_perfectNum")
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(9,255,36,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
		mywindow:setPosition(120, 203)
		mywindow:setSize(60, 15)
		mywindow:setZOrderingEnabled(false)
		mywindow:setEnabled(false)
		recordwindow:addChildWindow(mywindow)
		
		-- ����â ���ϵ�(�ִ뿬��)
		mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_matchmaking_infoWindow_MaxcontinueWinNum")
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(9,255,36,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
		mywindow:setPosition(120, 226)
		mywindow:setSize(60, 15)
		mywindow:setZOrderingEnabled(false)
		mywindow:setEnabled(false)
		if CheckfacilityData(FACILITYCODE_WINSTREAK) == 1 then
			recordwindow:addChildWindow(mywindow)
		end
		-- ����â ���ϵ�(���°��� Ƚ��)
		mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_matchmaking_infoWindow_breakContinueWinNum")
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(9,255,36,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
		mywindow:setPosition(120, 249)
		mywindow:setSize(60, 15)
		mywindow:setZOrderingEnabled(false)
		mywindow:setEnabled(false)
		if CheckfacilityData(FACILITYCODE_WINSTREAK) == 1 then
			recordwindow:addChildWindow(mywindow)
		end
		
		-- ����â ���ϵ�(�ų� ����Ʈ)
		mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_matchmaking_infoWindow_mannerPoint")
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(255,255,255,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
		mywindow:setPosition(120, 272)
		mywindow:setSize(60, 15)
		mywindow:setZOrderingEnabled(false)
		mywindow:setEnabled(false)
		recordwindow:addChildWindow(mywindow)
	---------------------------------
	-- ���ϵ� ��
	---------------------------------
		
end




-- ��������
function CompulsorilyOutClick(args)
	local userIndex = CEGUI.toWindowEventArgs(args).window:getUserString("userIndex")
	if userIndex ~= "" then
		WndMatchMaking_UserBan(tonumber(userIndex))
	--	UserBan(tonumber(userIndex))
	end
end


function WndMatchMaking_SetSuperMaster(slot)
	if winMgr:getWindow(slot .. "sj_matchmaking_userInfo_superMasterImage1") then
		winMgr:getWindow(slot .. "sj_matchmaking_userInfo_superMasterImage1"):setVisible(true)
		winMgr:getWindow(slot .. "sj_matchmaking_userInfo_superMasterImage1"):activeMotion("AlphaMotion1")
	end
	
	if winMgr:getWindow(slot .. "sj_matchmaking_userInfo_superMasterImage2") then
		winMgr:getWindow(slot .. "sj_matchmaking_userInfo_superMasterImage2"):setVisible(true)
		winMgr:getWindow(slot .. "sj_matchmaking_userInfo_superMasterImage2"):activeMotion("AlphaMotion2")
	end
end


function WndMatchMaking_ClearUserInfo(slot)	
	winMgr:getWindow(slot .. "sj_matchmaking_userBackImage"):setVisible(false)

	local window = winMgr:getWindow(slot .. "sj_matchmaking_playerclass")
	window:setTexture("Enabled", "UIData/MatchMakingRoom2.tga", 0, 0)
	window:setTexture("Disabled", "UIData/MatchMakingRoom2.tga", 0, 0)
end

-- local tPlayerRank = { ['protecterr']=0, [0]=0, 0, 0, 0, 0, 0, 0, 0 }
function WndMatchMaking_UpdateUserRank(slot, rank)
	local window = winMgr:getWindow(slot .. "sj_matchmaking_userInfo_rankImage")
	drawRankWindow(window, rank, -2, 27, 200)
end

-- local tBattlePosX = { ['protecterr']=0, [0]=50,  140, 240, 340, 839, 746, 654, 550 }
-- local tBattlePosY = { ['protecterr']=0, [0]=100, 450, 100, 500, 100, 450, 100, 500 }
local tBattlePosX = { ['protecterr']=0, [0]=140,  573, 0, 0, 356, 790, 0, 0 }
local tBattlePosY = { ['protecterr']=0, [0]=140, 140, 140, 140, 140, 140, 140, 140 }
local g_mySlot = 0
function WndMatchMaking_UpdateUserInfo(slot, mySlot, battleIndex, hostIndex, bTeam, enemyType, level, name, style, relay, network, INFINITE_PING, 
			titleNumber, ladderGrade, flag, roomKind, penalty, bSuperOwner, icafe , emblemKey, ClubTitle , ImageKey, promotion, attribute, bDiffTitleCheck,
			AniTitleTick)
	g_mySlot = mySlot
	
	-- 0. �����̹���
	local window = winMgr:getWindow(slot .. "sj_matchmaking_userBackImage")
	window:setVisible(true)
	window:setPosition(tBattlePosX[battleIndex] - 30, tBattlePosY[battleIndex] - 40)
	window:setUserString("posX", tostring(tBattlePosX[battleIndex]))
	window:setUserString("posY", tostring(tBattlePosY[battleIndex]))
	
	
	-- Īȣ�� ������� ũ�⸦ �ٸ��� �Ѵ�.
	local TEXT_POSY = 25
	if titleNumber >= 0 then
		TEXT_POSY = 46
		-- winMgr:getWindow(slot .. "sj_matchmaking_userBackImage"):setSize(128, 65)
		-- winMgr:getWindow(slot .. "sj_matchmaking_userBackImage"):setSize(223, 106)
		-- if bTeam == 1 then
		-- 	if enemyType == 0 then
		-- 		window:setTexture("Enabled", "UIData/battleroom001.tga", 419, 829)
		-- 	else
		-- 		window:setTexture("Enabled", "UIData/battleroom001.tga", 419, 894)
		-- 	end
		-- else
		-- 	window:setTexture("Enabled", "UIData/battleroom001.tga", 419, 959)
		-- end
		
		-- Īȣ
		if titleNumber == 26 then	-- Ŭ��Īȣ
			local _window = winMgr:getWindow(slot .. "sj_matchmaking_userInfo_title")
			local _window2 = winMgr:getWindow(slot .. "sj_matchmaking_userInfo_title2")
			_window:setVisible(false)
			_window2:setVisible(true)
			_window2:setTextExtends(ClubTitle, g_STRING_FONT_GULIMCHE, 12, 120,200,255,255, 1, 0,0,0,255)
			_window2:setPosition(48, 56)
		elseif titleNumber > 0 and #tTitleFilName >= titleNumber then
			local _window = winMgr:getWindow(slot .. "sj_matchmaking_userInfo_title")
			local _window2 = winMgr:getWindow(slot .. "sj_matchmaking_userInfo_title2")
			_window:setVisible(true)
			_window2:setVisible(false)
			_window:setTexture("Disabled", "UIData/"..tTitleFilName[titleNumber], tTitleTexX[titleNumber], tTitleTexY[titleNumber])
			-- _window:setPosition(46, 25 + 28)
			-- _window:setScaleWidth(240)
			-- _window:setScaleHeight(240)
		elseif titleNumber >= 10001 then	-- �ִ� Īȣ
			local _window = winMgr:getWindow(slot .. "sj_matchmaking_userInfo_title")
			local _window2 = winMgr:getWindow(slot .. "sj_matchmaking_userInfo_title2")
			_window:setVisible(true)
			_window2:setVisible(false)
			_window:setSize(107, 18)
			_window:setTexture("Disabled", "UIData/"..tAniTitleFilName[titleNumber - 10001], tAniTitleTexX[titleNumber - 10001], 18 * AniTitleTick)
			-- _window:setPosition(46, 25 + 28)
			-- _window:setScaleWidth(240)
			-- _window:setScaleHeight(240)
		else
			local _window = winMgr:getWindow(slot .. "sj_matchmaking_userInfo_title")
			local _window2 = winMgr:getWindow(slot .. "sj_matchmaking_userInfo_title2")
			_window:setVisible(false)
			_window2:setVisible(false)				
		end		
		-- _window:setPosition(46, 25 + 28)
		-- _window:setScaleWidth(240)
		-- _window:setScaleHeight(240)
	else
		local _window = winMgr:getWindow(slot .. "sj_matchmaking_userInfo_title")
		local _window2 = winMgr:getWindow(slot .. "sj_matchmaking_userInfo_title2")
		_window:setVisible(false)
		_window2:setVisible(false)
		
		-- winMgr:getWindow(slot .. "sj_matchmaking_userBackImage"):setSize(128, 43)
		-- if bTeam == 1 then
		-- 	if enemyType == 0 then
		-- 		window:setTexture("Enabled", "UIData/battleroom001.tga", 0, 872)
		-- 	else
		-- 		window:setTexture("Enabled", "UIData/battleroom001.tga", 0, 916)
		-- 	end
		-- else
		-- 	window:setTexture("Enabled", "UIData/battleroom001.tga", 0, 828)
		-- end	
	end

	-- local _window = winMgr:getWindow(slot .. "sj_matchmaking_userInfo_title")
	-- 	local _window2 = winMgr:getWindow(slot .. "sj_matchmaking_userInfo_title2")
	-- 	_window:setVisible(false)
	-- 	_window2:setVisible(true)
	-- 	_window2:setTextExtends("ABDCEFGHIJK123", g_STRING_FONT_GULIMCHE, 12, 120,200,255,255, 1, 0,0,0,255)
	-- 	_window2:setPosition(48, 56)
	
	-- ���Ƽ(����)
	-- if roomKind == 1 then
	-- 	local PENALTY = 2
	-- 	if IsKoreanLanguage() or IsMasLanguage() then
	-- 		PENALTY = 5
	-- 	end
		
	-- 	if ladderGrade > PENALTY then
	-- 		winMgr:getWindow(slot .. "sj_matchmaking_userInfo_penaltyDesc"):setVisible(true)
	-- 		winMgr:getWindow(slot .. "sj_matchmaking_userInfo_penaltyDesc"):setPosition(4, TEXT_POSY+20)
	-- 		winMgr:getWindow(slot .. "sj_matchmaking_userInfo_penaltyDesc"):clearTextExtends()
	-- 		winMgr:getWindow(slot .. "sj_matchmaking_userInfo_penaltyDesc"):setTextExtends("HP, GetSP -"..penalty.."%", g_STRING_FONT_GULIMCHE, 12, 255,255,255,255, 1, 255,0,0,255)
	-- 	else
	-- 		winMgr:getWindow(slot .. "sj_matchmaking_userInfo_penaltyDesc"):setVisible(false)
	-- 		winMgr:getWindow(slot .. "sj_matchmaking_userInfo_penaltyDesc"):clearTextExtends()
	-- 		winMgr:getWindow(slot .. "sj_matchmaking_userInfo_penaltyDesc"):setTextExtends("", g_STRING_FONT_GULIMCHE, 12, 255,255,255,255, 1, 255,0,0,255)
	-- 	end
	-- else
	-- 	winMgr:getWindow(slot .. "sj_matchmaking_userInfo_penaltyDesc"):setVisible(false)
	-- 	winMgr:getWindow(slot .. "sj_matchmaking_userInfo_penaltyDesc"):clearTextExtends()
	-- 	winMgr:getWindow(slot .. "sj_matchmaking_userInfo_penaltyDesc"):setTextExtends("", g_STRING_FONT_GULIMCHE, 12, 255,255,255,255, 1, 255,0,0,255)
	-- end
	

	
	-- �ɸ�����(����)
	-- if flag == 1 then
	-- 	winMgr:getWindow(slot .. "sj_matchmaking_userInfo_level"):setVisible(true)
	-- 	winMgr:getWindow(slot .. "sj_matchmaking_userInfo_ladder"):setVisible(false)
	-- 	local _window = winMgr:getWindow(slot .. "sj_matchmaking_userInfo_level")
	-- 	_window:setTextColor(255,255,255,255)
	-- 	if slot == mySlot then
	-- 		_window:setTextColor(255,205,86,255)
	-- 	end
	-- 	local characterLevel = "Lv." .. level
	-- 	_window:setText(characterLevel)
	-- 	_window:setPosition(3, TEXT_POSY)
		
	-- -- ����
	-- else
		winMgr:getWindow(slot .. "sj_matchmaking_userInfo_level"):setVisible(false)
		winMgr:getWindow(slot .. "sj_matchmaking_userInfo_ladder"):setVisible(false)
		-- local _window = winMgr:getWindow(slot .. "sj_matchmaking_userInfo_ladder")
		-- if (ladderGrade >= 0 and ladderGrade <= 4) then
		-- 	_window:setTexture("Disabled", "UIData/Rank/Rookie.png", 0, 0)
		-- elseif (ladderGrade >= 5 and ladderGrade <= 9) then
		-- 	_window:setTexture("Disabled", "UIData/Rank/Iron.png", 0, 0)
		-- elseif (ladderGrade >= 10 and ladderGrade <= 14) then
		-- 	_window:setTexture("Disabled", "UIData/Rank/Bronze.png", 0, 0)
		-- elseif (ladderGrade >= 15 and ladderGrade <= 19) then
		-- 	_window:setTexture("Disabled", "UIData/Rank/Silver.png", 0, 0)
		-- elseif (ladderGrade >= 20 and ladderGrade <= 24) then
		-- 	_window:setTexture("Disabled", "UIData/Rank/Gold.png", 0, 0)
		-- elseif (ladderGrade >= 25 and ladderGrade <= 29) then
		-- 	_window:setTexture("Disabled", "UIData/Rank/Platinum.png", 0, 0)
		-- elseif (ladderGrade >= 30 and ladderGrade <= 34) then
		-- 	_window:setTexture("Disabled", "UIData/Rank/Diamond.png", 0, 0)
		-- elseif (ladderGrade >= 35) then
		-- 	_window:setTexture("Disabled", "UIData/Rank/Master.png", 0, 0)
		-- else
		-- 	_window:setTexture("Disabled", "UIData/Rank/Rookie.png", 0, 0)
		-- end
		
			-- _window:setTexture("Disabled", "UIData/numberUi001.tga", 113, 600+21*ladderGrade)
		-- _window:setPosition(-2, TEXT_POSY-3)
		-- _window:setPosition(20, TEXT_POSY-10)
	-- end
	
	-- ������ Ű
	
	-- winMgr:getWindow(slot .. "sj_matchmaking_clubEmbleImage"):setScaleWidth(160)
	-- winMgr:getWindow(slot .. "sj_matchmaking_clubEmbleImage"):setScaleHeight(160)

	-- if emblemKey > 0 then
	-- 	winMgr:getWindow(slot .. "sj_matchmaking_clubEmbleImage"):setVisible(true) 
	-- 	winMgr:getWindow(slot .. "sj_matchmaking_clubEmbleImage"):setTexture('Enabled', GetClubDirectory(GetLanguageType())..emblemKey..".tga", 0, 0)
	-- 	winMgr:getWindow(slot .. "sj_matchmaking_clubEmbleImage"):setTexture('Disabled',GetClubDirectory(GetLanguageType())..emblemKey..".tga", 0, 0)
	-- else
	-- 	winMgr:getWindow(slot .. "sj_matchmaking_clubEmbleImage"):setVisible(false)
	-- 	winMgr:getWindow(slot .. "sj_matchmaking_clubEmbleImage"):setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
	-- 	winMgr:getWindow(slot .. "sj_matchmaking_clubEmbleImage"):setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
	-- end
	
	
	-- �ٸ������� Īȣ
	if bDiffTitleCheck > 0 and ImageKey > 0 then
		if flag == 1 then
			-- Īȣ 
			local titleIndex = titleNumber - 27 
			local tTexIndexTableX = {['err']=0, [0]= 256, 320, 384, 448, 0, 256, 320, 384, 448}
			local tTexIndexTableY = {['err']=0, [0]= 0, 0, 0, 0, 0, 64, 64, 64, 64}

			winMgr:getWindow(slot .. "sj_matchmaking_DiffTitleImage"):setVisible(true)
			winMgr:getWindow(slot .. "sj_matchmaking_profileImage"):setVisible(false) 
			winMgr:getWindow(slot .. "sj_matchmaking_DiffTitleImage"):setTexture('Enabled', 'UIData/numberUi002.tga', tTexIndexTableX[titleIndex], tTexIndexTableY[titleIndex])
			winMgr:getWindow(slot .. "sj_matchmaking_DiffTitleImage"):setTexture('Disabled', 'UIData/numberUi002.tga', tTexIndexTableX[titleIndex], tTexIndexTableY[titleIndex])
		else
			-- �̹��� Ű
			winMgr:getWindow(slot .. "sj_matchmaking_profileImage"):setVisible(true)
			winMgr:getWindow(slot .. "sj_matchmaking_DiffTitleImage"):setVisible(false)
			winMgr:getWindow(slot .. "sj_matchmaking_profileImage"):setTexture('Enabled', "UIData/Profile/"..ImageKey..".tga", 0, 0)
			winMgr:getWindow(slot .. "sj_matchmaking_profileImage"):setTexture('Disabled',"UIData/Profile/"..ImageKey..".tga", 0, 0)
		end
	elseif bDiffTitleCheck > 0 then
		-- Īȣ 
		local titleIndex = titleNumber - 27 
		local tTexIndexTableX = {['err']=0, [0]= 256, 320, 384, 448, 0, 256, 320, 384, 448}
		local tTexIndexTableY = {['err']=0, [0]= 0, 0, 0, 0, 0, 64, 64, 64, 64}

		winMgr:getWindow(slot .. "sj_matchmaking_DiffTitleImage"):setVisible(true)
		winMgr:getWindow(slot .. "sj_matchmaking_profileImage"):setVisible(false) 
		winMgr:getWindow(slot .. "sj_matchmaking_DiffTitleImage"):setTexture('Enabled', 'UIData/numberUi002.tga', tTexIndexTableX[titleIndex], tTexIndexTableY[titleIndex])
		winMgr:getWindow(slot .. "sj_matchmaking_DiffTitleImage"):setTexture('Disabled', 'UIData/numberUi002.tga', tTexIndexTableX[titleIndex], tTexIndexTableY[titleIndex])
	else
		-- �̹��� Ű
		if ImageKey > 0 then
			winMgr:getWindow(slot .. "sj_matchmaking_profileImage"):setVisible(true) 
			winMgr:getWindow(slot .. "sj_matchmaking_profileImage"):setTexture('Enabled', "UIData/Profile/"..ImageKey..".tga", 0, 0)
			winMgr:getWindow(slot .. "sj_matchmaking_profileImage"):setTexture('Disabled',"UIData/Profile/"..ImageKey..".tga", 0, 0)
		else
			winMgr:getWindow(slot .. "sj_matchmaking_profileImage"):setVisible(true)
			winMgr:getWindow(slot .. "sj_matchmaking_profileImage"):setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
			winMgr:getWindow(slot .. "sj_matchmaking_profileImage"):setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
		end
	end
	winMgr:getWindow(slot .. "sj_matchmaking_profileImage"):setScaleWidth(160)
	winMgr:getWindow(slot .. "sj_matchmaking_profileImage"):setScaleHeight(160)
	winMgr:getWindow(slot .. "sj_matchmaking_DiffTitleImage"):setScaleWidth(160)
	winMgr:getWindow(slot .. "sj_matchmaking_DiffTitleImage"):setScaleHeight(160)
	
	-- �ɸ�����(�̸�)
	window = winMgr:getWindow(slot .. "sj_matchmaking_userInfo_name")
	window:setTextColor(255,255,255,255)
	if slot == mySlot then
		window:setTextColor(255,205,86,255)
	end
	local summaryName = SummaryString(g_STRING_FONT_GULIMCHE, 12, name, 70)
	local nameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(summaryName))
	-- window:setPosition((88-nameSize/2) - 18, TEXT_POSY - 13) -- username position
	window:setPosition(48, TEXT_POSY - 13)
	-- window:setText("-> " .. style .. " " .. attribute)
	window:setText(summaryName)
	

	-- ��Ÿ�� -- class
	window = winMgr:getWindow(slot .. "sj_matchmaking_userInfo_styleImage")
	window:setTexture("Disabled", "UIData/Skill_up2.tga", tAttributeImgTexXTable[style][attribute], tAttributeImgTexYTable[style][attribute])
	window:setTexture("Layered", "UIData/Skill_up2.tga", promotionImgTexXTable[style], promotionImgTexYTable[promotion])
	-- winMgr:getWindow("UserInfoClassImage"):setScaleWidth(255)
	-- winMgr:getWindow("UserInfoClassImage"):setScaleHeight(200)
	window:setPosition(48, TEXT_POSY+25)

	-- update player info image
	local tPlayerInfoClassIndex = {
		['err']=0, [0]= 
		{ ['err']=0, [0]= 1, 2, 3, 4, 5, 11, 12, 13, 14, 15 }, 		-- 0 chr_strike
		{ ['err']=0, [0]= 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 },		-- 1 chr_grab
	}
	local tPlayerInfoClassImage = {
		['err']=0, [0]=
		{ ['err']=0, [0]= 0, 0 }, 			-- 0 empty
		{ ['err']=0, [0]= 754, 640 }, 		-- 1 street *
		{ ['err']=0, [0]= 150, 640 }, 		-- 2 taekwondo
		{ ['err']=0, [0]= 150, 0 }, 		-- 3 boxing
		{ ['err']=0, [0]= 301, 0 }, 		-- 4 capoeira
		{ ['err']=0, [0]= 301, 320 }, 		-- 5 muay thai
		{ ['err']=0, [0]= 754, 640 }, 		-- 6 rush *
		{ ['err']=0, [0]= 754, 0 }, 		-- 7 judo
		{ ['err']=0, [0]= 301, 640 }, 		-- 8 pro wrestling *
		{ ['err']=0, [0]= 603, 0 }, 		-- 9 hapgido
		{ ['err']=0, [0]= 603, 320 }, 		-- 10 sambo
		{ ['err']=0, [0]= 452, 0 }, 		-- 11 dirty-x
		{ ['err']=0, [0]= 754, 320 }, 		-- 12 sumo
		{ ['err']=0, [0]= 150, 320 }, 		-- 13 kungfu
		{ ['err']=0, [0]= 452, 320 }, 		-- 14 ninja
		{ ['err']=0, [0]= 452, 640 }, 		-- 15 systema *
	}
	-- local tPlayerInfoIndex = { 0, 1, 2, 3, 4, 5, 6, 7, 8 }
	local classIndex = tPlayerInfoClassIndex[style][promotion]
	local window = winMgr:getWindow(slot .. "sj_matchmaking_playerclass")
	window:setTexture("Enabled", "UIData/MatchMakingRoom2.tga", 
		tPlayerInfoClassImage[classIndex][0], tPlayerInfoClassImage[classIndex][1]
	)
	window:setTexture("Disabled", "UIData/MatchMakingRoom2.tga", 
		tPlayerInfoClassImage[classIndex][0], tPlayerInfoClassImage[classIndex][1]
	)
		
	-- ��Ʈ��ũ
	-- if network == INFINITE_PING then
	-- 	window = winMgr:getWindow(slot .. "sj_matchmaking_userInfo_networkImage")
	-- 	window:setTexture("Enabled", "UIData/GameNewImage.tga", 123, 63)
	-- 	window:setTexture("Disabled", "UIData/GameNewImage.tga", 123, 63)
	-- 	window:setPosition(-38, -7)
	-- 	window:setSize(18, 18)
	-- 	window:setScaleWidth(300)
	-- 	window:setScaleHeight(300)
	-- else
	-- 	local WIDTH = 120
	-- 	if		 0 <= network and network <= 20 then	offset = 120
	-- 	elseif	20 <  network and network <= 40 then	offset = 96
	-- 	elseif	40 <  network and network <= 60 then	offset = 72
	-- 	elseif	60 <  network and network <= 80 then	offset = 48
	-- 	elseif	80 <  network and network <= 100 then	offset = 24
	-- 	else											offset = 24
	-- 	end
		
	-- 	window = winMgr:getWindow(slot .. "sj_matchmaking_userInfo_networkImage")
	-- 	window:setTexture("Enabled", "UIData/battleroom001.tga", 0, 1017)
	-- 	window:setTexture("Disabled", "UIData/battleroom001.tga", 0, 1017)
	-- 	window:setPosition(3, 18)
	-- 	window:setSize(offset, 5)
	-- 	window:setScaleWidth(255)
	-- 	window:setScaleHeight(255)
	-- end
	
	
	
	-- ��������
	window = winMgr:getWindow(slot .. "sj_matchmaking_userInfo_banBtn")		
	if hostIndex == mySlot then
		if slot == mySlot then	-- �����̸� �غ�, �����ư�� �Ⱥ��̰� �Ѵ�.
			window:setVisible(false)
			window:setEnabled(false)
		else
			window:setVisible(true)
			window:setEnabled(true)
		end
	else
		window:setVisible(false)
		window:setEnabled(false)
	end
	
	--�������� --GM���� Ȯ���ؼ� GM�̸� �����ư ���̰� �Ѵ�
	if CheckIsGM() then
		window:setVisible(true)
		window:setEnabled(true)
	end
	
	
	-- ������, ����
	local superMasterWindow1 = winMgr:getWindow(slot .. "sj_matchmaking_userInfo_superMasterImage1")
	local superMasterWindow2 = winMgr:getWindow(slot .. "sj_matchmaking_userInfo_superMasterImage2")
	local masterWindow = winMgr:getWindow(slot .. "sj_matchmaking_userInfo_masterImage")
	local readyWindow  = winMgr:getWindow(slot .. "sj_matchmaking_userInfo_readyImage")
	
	if hostIndex == slot then
		if bSuperOwner == 1 then
			superMasterWindow1:setVisible(true)
			superMasterWindow2:setVisible(true)
			masterWindow:setVisible(false)
		else
			superMasterWindow1:setVisible(false)
			superMasterWindow2:setVisible(false)
			masterWindow:setVisible(true)
		end
		
		readyWindow:setVisible(false)
	else
		superMasterWindow1:setVisible(false)
		superMasterWindow2:setVisible(false)
		masterWindow:setVisible(false)
		readyWindow:setVisible(true)
		
		-- �غ�(ready) ����
		if WndMatchMaking_GetReady(slot) == true then
			readyWindow:setTexture("Disabled", "UIData/battleroom001.tga", 136, 868)
		else
			readyWindow:setTexture("Disabled", "UIData/battleroom001.tga", 136, 899)
		end
	end
	
	
	-- ����ī��
	window = winMgr:getWindow(slot .. "sj_matchmaking_userInfo_icafeImage")
	if icafe == 1 then
		window:setVisible(true)
		window:setTexture("Enabled", "UIData/LobbyImage_new.tga", 729, 235)
		window:setTexture("Disabled", "UIData/LobbyImage_new.tga", 729, 235)
		window:setScaleWidth(160)
		window:setScaleHeight(160)
		
	elseif icafe == 2 then
		window:setVisible(true)
		window:setTexture("Enabled", "UIData/LobbyImage_new.tga", 665, 235)
		window:setTexture("Disabled", "UIData/LobbyImage_new.tga", 665, 235)
		window:setScaleWidth(160)
		window:setScaleHeight(160)
	else
		window:setVisible(false)
	end
	
end


function WndBattleRoomClearUserInfoWindow(slot)
	winMgr:getWindow(slot .. "sj_matchmaking_userInfo_infoWindow"):setVisible(false)
end



-- ���콺�� ������ ��
local tAdjustIndex = {["err"]=0, [0]=0, 4, 1, 5, 2, 6, 3, 7}
function OnMouseMove_UserInfo(args)
	
	local window = CEGUI.toWindowEventArgs(args).window
	if window:isVisible() then

		local szUserIndex = window:getUserString("userIndex")
		if szUserIndex ~= "" then
			userIndex = tonumber(szUserIndex)
			
			local adjustIndex = userIndex
			if g_currentTeamBattle == false then
				adjustIndex = tAdjustIndex[userIndex]
			end
			local posX = CEGUI.toMouseEventArgs(args).position.x + 40
			local posY = CEGUI.toMouseEventArgs(args).position.y
			
		
			-- ������ �ѱ��� ���̻� x������ �������� �ʱ�
			if adjustIndex == 0 or adjustIndex == 2 or adjustIndex == 4 or adjustIndex == 6 then
				posY = posY + 28
			else
				-- posY = posY - 214
				posY = posY + 28
			end
			
			if posX >= g_CURRENT_WIN_SIZEX-200 then
				posX = posX - 200
			end
			
			-- ����â x, y�� ����
			if winMgr:getWindow(szUserIndex .. "sj_matchmaking_userInfo_infoWindow") then
				if winMgr:getWindow(szUserIndex .. "sj_matchmaking_userInfo_infoWindow"):isVisible() then
					winMgr:getWindow(szUserIndex .. "sj_matchmaking_userInfo_infoWindow"):setPosition(posX, posY)
				end
			end
		end
	end
	
end




-- ���콺�� �������� �̹���â�� ��������
function OnMouseEnter_UserInfo(args)
	
	local window = CEGUI.toWindowEventArgs(args).window	
--	if tonumber(userIndex) ~= g_mySlot then
--		return
--	end
	
	if window:isVisible() then
		local szUserIndex = window:getUserString("userIndex")
		if szUserIndex ~= "" then
			userIndex = tonumber(szUserIndex)
			winMgr:getWindow(userIndex .. "sj_matchmaking_userInfo_infoWindow"):setAlwaysOnTop(true)
			winMgr:getWindow(userIndex .. "sj_matchmaking_userInfo_infoWindow"):setVisible(true)
			
			local total, individual, team, ko, koRate, mvp, teamAtk, doubleAtk, ladderExp, perfect, consecutiveWin, consecutiveWinBreak, mannerPoint = WndMatchMaking_GetCharacterRecord(userIndex)
			if total < 0 then	-- �����ϰ�� ����
				return
			end
			
			local TEXT_X = 150
			local ADDTEXT_X = 10
			
			-- ������
			local size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(total))
			local posX = TEXT_X - size
			winMgr:getWindow(szUserIndex .. "sj_matchmaking_infoWindow_totalRecord"):setPosition(posX, 26)
			winMgr:getWindow(szUserIndex .. "sj_matchmaking_infoWindow_totalRecord"):setText(tostring(total))
			
			-- ������
			size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(individual))
			posX = TEXT_X - size
			winMgr:getWindow(szUserIndex .. "sj_matchmaking_infoWindow_privatBattleNum"):setPosition(posX, 41)
			winMgr:getWindow(szUserIndex .. "sj_matchmaking_infoWindow_privatBattleNum"):setText(tostring(individual))
			
			-- ����
			size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(team))
			posX = TEXT_X - size
			winMgr:getWindow(szUserIndex .. "sj_matchmaking_infoWindow_teamBattleNum"):setPosition(posX, 56)
			winMgr:getWindow(szUserIndex .. "sj_matchmaking_infoWindow_teamBattleNum"):setText(tostring(team))
			
			
			---------------------------
			-- KO
			size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(ko))
			posX = TEXT_X - size + ADDTEXT_X
			winMgr:getWindow(szUserIndex .. "sj_matchmaking_infoWindow_koNum"):setPosition(posX, 74)
			winMgr:getWindow(szUserIndex .. "sj_matchmaking_infoWindow_koNum"):setText(tostring(ko))
		
			-- KO��
			size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(koRate))
			posX = TEXT_X - size + ADDTEXT_X
			winMgr:getWindow(szUserIndex .. "sj_matchmaking_infoWindow_koRate"):setPosition(posX, 89)
			winMgr:getWindow(szUserIndex .. "sj_matchmaking_infoWindow_koRate"):setText(tostring(koRate))
			
			-- ��������Ʈ
			size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(ladderExp))
			posX = TEXT_X - size + ADDTEXT_X
			winMgr:getWindow(szUserIndex .. "sj_matchmaking_infoWindow_ladderPoint"):setPosition(posX, 105)
			winMgr:getWindow(szUserIndex .. "sj_matchmaking_infoWindow_ladderPoint"):setText(tostring(ladderExp))
			
			
			---------------------------
			-- MVP
			size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(mvp))
			posX = TEXT_X - size + ADDTEXT_X
			winMgr:getWindow(szUserIndex .. "sj_matchmaking_infoWindow_mvpNum"):setPosition(posX, 122)
			winMgr:getWindow(szUserIndex .. "sj_matchmaking_infoWindow_mvpNum"):setText(tostring(mvp))
			
			-- ������
			size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(teamAtk))
			posX = TEXT_X - size + ADDTEXT_X
			winMgr:getWindow(szUserIndex .. "sj_matchmaking_infoWindow_teamAtkNum"):setPosition(posX, 138)
			winMgr:getWindow(szUserIndex .. "sj_matchmaking_infoWindow_teamAtkNum"):setText(tostring(teamAtk))
		
			-- ��������
			size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(doubleAtk))
			posX = TEXT_X - size + ADDTEXT_X
			winMgr:getWindow(szUserIndex .. "sj_matchmaking_infoWindow_doubleAtkNum"):setPosition(posX, 154)
			winMgr:getWindow(szUserIndex .. "sj_matchmaking_infoWindow_doubleAtkNum"):setText(tostring(doubleAtk))
			
			
			---------------------------
			-- ����Ʈ ���� Ƚ��
			size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(perfect))
			posX = TEXT_X - size + ADDTEXT_X
			winMgr:getWindow(szUserIndex .. "sj_matchmaking_infoWindow_perfectNum"):setPosition(posX, 174)
			winMgr:getWindow(szUserIndex .. "sj_matchmaking_infoWindow_perfectNum"):setText(tostring(perfect))
			
			-- �ִ뿬��
			size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(consecutiveWin))
			posX = TEXT_X - size + ADDTEXT_X
			winMgr:getWindow(szUserIndex .. "sj_matchmaking_infoWindow_MaxcontinueWinNum"):setPosition(posX, 190)
			winMgr:getWindow(szUserIndex .. "sj_matchmaking_infoWindow_MaxcontinueWinNum"):setText(tostring(consecutiveWin))
		
			-- ���°��� Ƚ��
			size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(consecutiveWinBreak))
			posX = TEXT_X - size + ADDTEXT_X
			winMgr:getWindow(szUserIndex .. "sj_matchmaking_infoWindow_breakContinueWinNum"):setPosition(posX, 205)
			winMgr:getWindow(szUserIndex .. "sj_matchmaking_infoWindow_breakContinueWinNum"):setText(tostring(consecutiveWinBreak))
			
			-- �ų� ����Ʈ
			size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(mannerPoint))
			posX = TEXT_X - size + ADDTEXT_X
			if mannerPoint >= 0 then
				winMgr:getWindow(szUserIndex .. "sj_matchmaking_infoWindow_mannerPoint"):setTextColor(255,255,255,255)
			else
				winMgr:getWindow(szUserIndex .. "sj_matchmaking_infoWindow_mannerPoint"):setTextColor(255,0,0,255)
			end			
			winMgr:getWindow(szUserIndex .. "sj_matchmaking_infoWindow_mannerPoint"):setPosition(posX, 224)
			winMgr:getWindow(szUserIndex .. "sj_matchmaking_infoWindow_mannerPoint"):setText(tostring(mannerPoint))
		end
	end
	
end




-- ���콺�� �������� �̹���â�� ������ ��
function OnMouseLeave_UserInfo(args)

	local window = CEGUI.toWindowEventArgs(args).window
	if window:isVisible() then
		local szUserIndex = window:getUserString("userIndex")
		if szUserIndex ~= "" then
			local userIndex = szUserIndex
			winMgr:getWindow(userIndex .. "sj_matchmaking_userInfo_infoWindow"):setVisible(false)
			
			winMgr:getWindow(userIndex .. "sj_matchmaking_infoWindow_totalRecord"):setText("")
			winMgr:getWindow(userIndex .. "sj_matchmaking_infoWindow_privatBattleNum"):setText("")
			winMgr:getWindow(userIndex .. "sj_matchmaking_infoWindow_teamBattleNum"):setText("")
			winMgr:getWindow(userIndex .. "sj_matchmaking_infoWindow_koNum"):setText("")
			winMgr:getWindow(userIndex .. "sj_matchmaking_infoWindow_koRate"):setText("")
			winMgr:getWindow(userIndex .. "sj_matchmaking_infoWindow_ladderPoint"):setText("")
			winMgr:getWindow(userIndex .. "sj_matchmaking_infoWindow_mvpNum"):setText("")
			winMgr:getWindow(userIndex .. "sj_matchmaking_infoWindow_teamAtkNum"):setText("")
			winMgr:getWindow(userIndex .. "sj_matchmaking_infoWindow_doubleAtkNum"):setText("")
			winMgr:getWindow(userIndex .. "sj_matchmaking_infoWindow_perfectNum"):setText("")
			winMgr:getWindow(userIndex .. "sj_matchmaking_infoWindow_MaxcontinueWinNum"):setText("")
			winMgr:getWindow(userIndex .. "sj_matchmaking_infoWindow_breakContinueWinNum"):setText("")
			winMgr:getWindow(userIndex .. "sj_matchmaking_infoWindow_mannerPoint"):setText("")
		end
	end

end

function OnCharacterPicking(name, index, bGM)
	
	if name == nil or name == "" then
		return
	end

	if winMgr:getWindow('CommonAlertAlphaImg'):isVisible() then
		return
	end
	
	if winMgr:getWindow('Popup_AlphaBackImg'):isVisible() then
		return
	end
	
	root:removeChildWindow(winMgr:getWindow('pu_btnContainer'));
	
	-- �����϶��� üũ ���ش�.	
	local messenger_window = winMgr:getWindow('sj_messengerBackWindow');
	
	if messenger_window ~= nil then
	
		local messenger_visible = messenger_window:isVisible()
		if messenger_visible == false then
					
			-- ���ϰ�� �������� ����.
			local _my_name, _money, _level, _promotion, _my_style, _type, _sp_point, _hp_point, _experience = GetMyInfo(false);
			if name == _my_name then
				local m_pos = mouseCursor:getPosition()
				ShowPopupWindow(m_pos.x, m_pos.y, 1)
				g_strSelectRButtonUp = name
				winMgr:getWindow('pu_myInfo'):setEnabled(true)
				MakeMessengerPopup("pu_windowName", "pu_myInfo" ,"pu_profile")
				
			-- �ٸ���� �� ���
			else
				local m_pos = mouseCursor:getPosition();
				ShowPopupWindow(m_pos.x, m_pos.y, 1);
				g_strSelectRButtonUp = name;
				
				local isMyMessengerFriend = IsMyMessengerFriend(name);
				winMgr:getWindow('pu_showInfo'):setEnabled(true)
				
				-- ���� �� ģ�� ��� ����Ʈ�� �ִ��� Ȯ���Ѵ�.
				-- �� ģ�� ��� ����Ʈ�� ������
				if isMyMessengerFriend == true then
					winMgr:getWindow('pu_addFriend'):setEnabled(false)	-- ��Ȱ��
					winMgr:getWindow('pu_deleteFriend'):setEnabled(true)	-- Ȱ��
					
				else -- ��ģ�� ��ϸ���Ʈ�� ������
					winMgr:getWindow('pu_addFriend'):setEnabled(true)	-- Ȱ��
					winMgr:getWindow('pu_deleteFriend'):setEnabled(false)	-- ��Ȱ��
				end
				
				-- �ӼӸ��� �ظ��ϸ� �ű��ϴµ�..
				winMgr:getWindow('pu_privatChat'):setEnabled(true)
				winMgr:getWindow('pu_watchEquipment'):setEnabled(true)
				
				-- ��Ƽ �ʴ�� ��밡 ��Ƽ�� ���� �ִ��� ������ Ȯ���ؾ� �Ѵ�.
				winMgr:getWindow('pu_inviteParty'):setEnabled(false)
				winMgr:getWindow('pu_vanishParty'):setEnabled(false)	-- ��Ȱ��
				
				-- �����ϱ�
				winMgr:getWindow('pu_blockUser'):setEnabled(true)
						
				-- �������� üũ
				if bGM == 1 then
					DebugStr("���������Դϴ�")
					if IsKoreanLanguage() then
						MakeMessengerPopup("pu_windowName", "pu_showInfo", "pu_profile", "pu_addFriend", "pu_deleteFriend", "pu_privatChat", "pu_blockUser", "pu_inviteParty", "pu_vanishParty", "pu_watchEquipment");
					else
						MakeMessengerPopup("pu_windowName", "pu_showInfo", "pu_profile", "pu_addFriend", "pu_deleteFriend", "pu_privatChat", "pu_inviteParty", "pu_vanishParty", "pu_watchEquipment");
					end
				else
					DebugStr("������ �ƴϴ�")
					if IsKoreanLanguage() then
						MakeMessengerPopup("pu_windowName", "pu_showInfo", "pu_profile", "pu_addFriend", "pu_deleteFriend", "pu_privatChat", "pu_blockUser", "pu_inviteParty", "pu_vanishParty" ); -- �Ű��ϱ� ��� ����
					else
						MakeMessengerPopup("pu_windowName", "pu_showInfo", "pu_profile", "pu_addFriend", "pu_deleteFriend", "pu_privatChat", "pu_inviteParty", "pu_vanishParty" ); -- �Ű��ϱ� ��� ����
					end
				end
			end
		end
	end
	
end


function WndMatchMaking_OnRootMouseButtonUp(args)
	root:removeChildWindow(winMgr:getWindow('pu_btnContainer'));
end


function WndMatchMaking_OnRootMouseRButtonUp(args)

	if winMgr:getWindow('CommonAlertAlphaImg'):isVisible() then
		return
	end
	
	if winMgr:getWindow('Popup_AlphaBackImg'):isVisible() then
		return
	end
	
	if winMgr:getWindow('CJ_NotifyPopupBack'):isVisible() then
		return
	end
	
	if winMgr:getWindow('sj_battleroom_alphaWindow'):isVisible() then
		return
	end
	
	if winMgr:getWindow('UserInfo_Main'):isVisible() then
		return
	end
	
	root:removeChildWindow(winMgr:getWindow('pu_btnContainer'));
	local messenger_window = winMgr:getWindow('sj_messengerBackWindow');
	
	if messenger_window ~= nil then
		local messenger_visible = messenger_window:isVisible()
		if messenger_visible == false then
			WndMatchMaking_PickObjects();
		end
	end
end

root:setSubscribeEvent("MouseButtonUp", "WndMatchMaking_OnRootMouseButtonUp");
root:setSubscribeEvent("MouseRButtonUp", "WndMatchMaking_OnRootMouseRButtonUp");




----------------------------------------------------

-- ���� ���̽� ���� �����ֱ�

----------------------------------------------------
function WndMatchMaking_ShowMRVersion(version)
--	DrawEachNumberWide("UIData/dungeonmsg.tga", version, 1, 980, 560, 516, 224, 12, 14, 15 , WIDETYPE_6)
end




------------------------------------------------

--	��ǳ�� �׸���

------------------------------------------------
function WndMatchMaking_OnDrawBoolean(str_chat, px, py, chatBubbleType)
	
	local real_str_chat = str_chat;
	if string.len(real_str_chat) <= 0 then
		return
	end
		
	if 0 > chatBubbleType or chatBubbleType > MAX_CHAT_BUBBLE_NUM then
		return
	end
	
	local alpha  = 200
	local UNIT   = 18		-- 1edge�� ������
	local UNIT2X = UNIT*2								-- 1edge�� ������ * 2
	local texX_L = tChatBubbleTexX[chatBubbleType]		-- �ؽ�ó ���� x��ġ
	local texY_L = tChatBubbleTexY[chatBubbleType]		-- �ؽ�ó ���� y��ġ
	local texX_R = texX_L+(UNIT*2)						-- �ؽ�ó ������ x��ġ
	local texY_R = texY_L+(UNIT*2)						-- �ؽ�ó ������ y��ġ
	local r,g,b  = GetChatBubbleColor(chatBubbleType)	-- �ؽ�Ʈ ����(0:���, 1:������)
	local posX	 = 0		-- ��ǳ�� x��ġ
	local posY	 = tChatBubblePosY[chatBubbleType]		-- ��ǳ�� y��ġ

	local textPosY = tChatTextPosY[chatBubbleType]
	
	local twidth, theight = GetBooleanTextSize(real_str_chat, g_STRING_FONT_GULIMCHE, 14)
	local AREA_X = twidth
	local AREA_Y = theight
	
	-- ��� ���� �ϱ�
	local DIV_X = twidth  / UNIT
	local DIV_Y = theight / UNIT
	local X = px-(UNIT2X+UNIT+(DIV_X*UNIT))/2 + posX
	local Y = py-AREA_Y-(UNIT*3) + posY - 14
	
	-- ������ 4����
	drawer = root:getDrawer()
	drawer:drawTextureA("UIData/gamedesign.tga", posX+X,					 posY+Y,					 UNIT, UNIT, texX_L, texY_L, alpha)-- ���� ��
	drawer:drawTextureA("UIData/gamedesign.tga", posX+X+UNIT2X+(DIV_X*UNIT), posY+Y,					 UNIT, UNIT, texX_R, texY_L, alpha)-- ������ ��
	drawer:drawTextureA("UIData/gamedesign.tga", posX+X,					 posY+Y+UNIT2X+(DIV_Y*UNIT), UNIT, UNIT, texX_L, texY_R, alpha)-- ���� �Ʒ�
	drawer:drawTextureA("UIData/gamedesign.tga", posX+X+UNIT2X+(DIV_X*UNIT), posY+Y+UNIT2X+(DIV_Y*UNIT), UNIT, UNIT, texX_R, texY_R, alpha)-- ������ �Ʒ�
	
	-- ���� ����
	for i=0, DIV_X do
		drawer:drawTextureA("UIData/gamedesign.tga", posX+X+UNIT+(i*UNIT), posY+Y,						UNIT, UNIT, texX_L+UNIT, texY_L, alpha)-- ������
		drawer:drawTextureA("UIData/gamedesign.tga", posX+X+UNIT+(i*UNIT), posY+Y+UNIT2X+(DIV_Y*UNIT),	UNIT, UNIT, texX_L+UNIT, texY_R, alpha)-- �Ʒ�����
		
		-- ���
		for j=0, DIV_Y do
			drawer:drawTextureA("UIData/gamedesign.tga", posX+X+UNIT+(i*UNIT), posY+Y+UNIT+(j*UNIT), UNIT, UNIT, texX_L+UNIT, texY_L+UNIT, alpha)
		end
	end
	
	-- ���� ����
	for i=0, DIV_Y do
		drawer:drawTextureA("UIData/gamedesign.tga", posX+X,					 posY+Y+UNIT+(i*UNIT), UNIT, UNIT, texX_L, texY_L+UNIT, alpha)-- ���ʶ���
		drawer:drawTextureA("UIData/gamedesign.tga", posX+X+UNIT2X+(DIV_X*UNIT), posY+Y+UNIT+(i*UNIT), UNIT, UNIT, texX_R, texY_L+UNIT, alpha)-- �����ʶ���
	end
	
	
	-- �ؽ�Ʈ �׸���
	drawer:setTextColor(r,g,b,255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 14)
	drawer:drawText(real_str_chat, X+UNIT+2, Y+UNIT+textPosY)
end




local g_LevelupMoney = 0
------------------------------------------------
-- ������ �̺�Ʈ �����ش�.
------------------------------------------------
function ShowLevelUpEvent(LevelupMoney)
	g_LevelupMoney = LevelupMoney
	RegistEscEventInfo("LevelUpEventAlpha", "LevelUpEventButtonEvent")
	RegistEnterEventInfo("LevelUpEventAlpha", "LevelUpEventButtonEvent")
	root:addChildWindow(winMgr:getWindow("LevelUpEventAlpha"))
	winMgr:getWindow("LevelUpEventAlpha"):setVisible(true)
	
end


function LevelUpEventRender(args)
	local drawer = CEGUI.toWindowEventArgs(args).window:getDrawer()
	
	local _left = DrawEachNumber("UIData/other001.tga", g_LevelupMoney, 8, 195, 34, 11, 683, 24, 33, 25,  drawer)
	drawer:drawTexture("UIData/other001.tga", _left-25, 35, 30, 29, 266, 685)
	

end


function LevelUpEventButtonEvent()
	winMgr:getWindow("LevelUpEventAlpha"):setVisible(false)
end


--------------------------------------------------------------------

-- �����̹� ��ŷ���� ��ư

--------------------------------------------------------------------
function WndMatchMaking_SetGameMode(gameMode)
--[[	if gameMode == 6 then
		if winMgr:getWindow("sj_matchmaking_mrRankingInfoBtn") then
			winMgr:getWindow("sj_matchmaking_mrRankingInfoBtn"):setVisible(true)
		end
	end]]
end

mywindow = winMgr:createWindow("TaharezLook/Button", "sj_matchmaking_mrRankingInfoBtn")
mywindow:setTexture("Normal", "UIData/match001.tga", 257, 508)
mywindow:setTexture("Hover", "UIData/match001.tga", 257, 538)
mywindow:setTexture("Pushed", "UIData/match001.tga", 257, 569)
mywindow:setTexture("PushedOff", "UIData/match001.tga", 257, 508)	
mywindow:setWideType(6);
mywindow:setPosition(5, 544)
mywindow:setSize(79, 30)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickTabToMRRankInfo")
root:addChildWindow(mywindow)

function ClickedMRRankInfoWindow(gameMode)
	if gameMode == 6 then
		ClickTabToMRRankInfo()
	end
end

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_matchmaking_mrRankingInfo_alphaWindow")
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

-- ��ŷ���� ����
mrrankwindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_matchmaking_mr_rankInfo_backImage")
mrrankwindow:setTexture("Enabled", "UIData/match002.tga", 0, 0)
mrrankwindow:setTexture("Disabled", "UIData/match002.tga", 0, 0)
mrrankwindow:setProperty("FrameEnabled", "False")
mrrankwindow:setProperty("BackgroundEnabled", "False")
mrrankwindow:setWideType(6);
mrrankwindow:setPosition(257, 95)
mrrankwindow:setSize(510, 577)
mrrankwindow:setAlwaysOnTop(true)
mrrankwindow:setZOrderingEnabled(false)
winMgr:getWindow("sj_matchmaking_mrRankingInfo_alphaWindow"):addChildWindow(mrrankwindow)

-- �ݱ��ư
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_matchmaking_mr_rankInfo_cancelBtn")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setPosition(478, 10)
mywindow:setSize(23, 23)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "HideMRRanking")
mrrankwindow:addChildWindow(mywindow)

function HideMRRanking()
	winMgr:getWindow("sj_matchmaking_mrRankingInfo_alphaWindow"):setVisible(false)
	WndMatchMaking_InitMRRankInfo()
end

-- ���̸�
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_matchmaking_mr_rankInfo_MapName")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(0,0,0,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setText("")
mywindow:setPosition(230, 62)
mywindow:setSize(200, 20)
mywindow:setZOrderingEnabled(false)
mrrankwindow:addChildWindow(mywindow)

local MAX_MR_RANK = 20
local tMRRankInfoName = {["err"]=0, [0]="_rank", "_name", "_time", "_kill"}
local tMRRankInfoPosX = {["err"]=0, [0]=92, 188, 270, 392}

-- 1 ~ 20�� ��������
for i=0, MAX_MR_RANK-1 do
	for j=0, #tMRRankInfoName do
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_matchmaking_mr_rankInfo_"..i..tMRRankInfoName[j])
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(255,200,80,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
		mywindow:setText("")
		mywindow:setPosition(tMRRankInfoPosX[j], 135+(i*21))
		mywindow:setSize(60, 20)
		mywindow:setZOrderingEnabled(false)
		mrrankwindow:addChildWindow(mywindow)
	end
end


function WndMatchMaking_SetMRRankInfo(i, rank, name, time, kill)
	local size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, rank)
	winMgr:getWindow("sj_matchmaking_mr_rankInfo_"..i..tMRRankInfoName[0]):setPosition(tMRRankInfoPosX[0]-size, 135+(i*21))
	winMgr:getWindow("sj_matchmaking_mr_rankInfo_"..i..tMRRankInfoName[0]):setText(rank)
	
	size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, name)
	winMgr:getWindow("sj_matchmaking_mr_rankInfo_"..i..tMRRankInfoName[1]):setPosition(tMRRankInfoPosX[1]-size/2, 135+(i*21))
	winMgr:getWindow("sj_matchmaking_mr_rankInfo_"..i..tMRRankInfoName[1]):setText(name)
	
	winMgr:getWindow("sj_matchmaking_mr_rankInfo_"..i..tMRRankInfoName[2]):setText(time)
	
	size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, kill)
	winMgr:getWindow("sj_matchmaking_mr_rankInfo_"..i..tMRRankInfoName[3]):setPosition(tMRRankInfoPosX[3]-size/2, 135+(i*21))
	winMgr:getWindow("sj_matchmaking_mr_rankInfo_"..i..tMRRankInfoName[3]):setText(kill)
end

function WndMatchMaking_InitMRRankInfo()
	for i=0, MAX_MR_RANK-1 do
		for j=0, #tMRRankInfoName do
			winMgr:getWindow("sj_matchmaking_mr_rankInfo_"..i..tMRRankInfoName[j]):setText("")
		end
	end
end

function ClickTabToMRRankInfo()
--[[	if winMgr:getWindow("sj_matchmaking_mrRankingInfo_alphaWindow") then
		if winMgr:getWindow("sj_matchmaking_mrRankingInfo_alphaWindow"):isVisible() then
			winMgr:getWindow("sj_matchmaking_mrRankingInfo_alphaWindow"):setVisible(false)
			winMgr:getWindow("sj_matchmaking_mr_rankInfo_MapName"):setText("")
			WndMatchMaking_InitMRRankInfo()
		else
			winMgr:getWindow("sj_matchmaking_mrRankingInfo_alphaWindow"):setVisible(true)

			local size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, g_currentMapName)
			winMgr:getWindow("sj_matchmaking_mr_rankInfo_MapName"):setPosition(256-size/2, 62)
			winMgr:getWindow("sj_matchmaking_mr_rankInfo_MapName"):setText(g_currentMapName)
			
			WndMatchMaking_RequestMRRank()
		end
	end]]
end
RegistEscEventInfo("sj_matchmaking_mrRankingInfo_alphaWindow", "HideMRRanking")







--------------------------------------------------------------------

-- �˸��޼���

--------------------------------------------------------------------
-- ����â
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_matchmaking_lphaWindow")
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
--- OK, CANCEL �˸�â
---------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_matchmaking_backWindow")
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

mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_matchmaking_descWindow")
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
winMgr:getWindow("sj_matchmaking_backWindow"):addChildWindow(mywindow)

-- OK, CANCEL ��ư
local tAlertName = {['protecterr'] = 0, "sj_matchmaking_okBtn", "sj_matchmaking_CancelBtn"}
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
	winMgr:getWindow("sj_matchmaking_backWindow"):addChildWindow(mywindow)
end


---------------------------------------

-- ���� �������� �� ��

---------------------------------------
function WndMatchMaking_RequestExitRoom(msg)
	ShowbattleRoomOkCancelBoxFunction1(msg, 'OnClickExitRoomOk', 'OnClickExitRoomCancel')
end

function ShowbattleRoomOkCancelBoxFunction1(arg, argYesFunc, argNoFunc)
	if winMgr:getWindow('sj_battleRoom_lphaWindow') then
		local aa= winMgr:getWindow("sj_matchmaking_lphaWindow"):getChildCount()
		if aa >= 1 then
			local bb= winMgr:getWindow("sj_matchmaking_lphaWindow"):getChildAtIdx(0)  
			winMgr:getWindow("sj_matchmaking_lphaWindow"):removeChildWindow(bb)		
		end
		winMgr:getWindow("sj_matchmaking_lphaWindow"):setVisible(true)
		root:addChildWindow(winMgr:getWindow("sj_matchmaking_lphaWindow"))
		local local_window = winMgr:getWindow("sj_matchmaking_backWindow")
		local_window:setUserString("okFunction", argYesFunc)
		local_window:setUserString("noFunction", argNoFunc)
		winMgr:getWindow("sj_matchmaking_lphaWindow"):addChildWindow(local_window)
		local_window:setVisible(true)
		
		local local_txt_window = winMgr:getWindow("sj_matchmaking_descWindow")
		local_window:setVisible(true)
		local_txt_window:clearTextExtends()
		local_txt_window:addTextExtends(arg, g_STRING_FONT_GULIMCHE, 15, 255,255,255,255,    2, 0,0,0,255)
		winMgr:getWindow("sj_matchmaking_okBtn"):setSubscribeEvent("Clicked", argYesFunc)
		winMgr:getWindow("sj_matchmaking_CancelBtn"):setSubscribeEvent("Clicked", argNoFunc)
	end
end

-- ����
function OnClickExitRoomOk(args)

	if winMgr:getWindow('sj_battleRoom_backWindow') then
		local okfunc = winMgr:getWindow('sj_battleRoom_backWindow'):getUserString("okFunction")
		if okfunc ~= "OnClickExitRoomOk" then
			return
		end
		winMgr:getWindow('sj_battleRoom_backWindow'):setUserString("okFunction", "")	-- �ʱ�ȭ�� �ؾ���
		
		winMgr:getWindow('sj_battleRoom_lphaWindow'):setVisible(false)
		root:removeChildWindow(winMgr:getWindow('sj_battleRoom_lphaWindow'))
		local local_window = winMgr:getWindow('sj_battleRoom_backWindow')
		winMgr:getWindow('sj_battleRoom_lphaWindow'):removeChildWindow(local_window)
		local_window:setVisible(false)
		
		FromWndBattleRoomGoToWndLobby()
	end
end


-- ����
function OnClickExitRoomCancel(args)
	
	if winMgr:getWindow('sj_battleRoom_backWindow') then
		local nofunc = winMgr:getWindow('sj_battleRoom_backWindow'):getUserString("noFunction")
		if nofunc ~= "OnClickExitRoomCancel" then
			return
		end
		winMgr:getWindow('sj_battleRoom_backWindow'):setUserString("noFunction", "")	-- �ʱ�ȭ�� �ؾ���
		
		winMgr:getWindow('sj_battleRoom_lphaWindow'):setVisible(false)
		root:removeChildWindow( winMgr:getWindow('sj_battleRoom_lphaWindow'))
		local local_window = winMgr:getWindow('sj_battleRoom_backWindow')
		winMgr:getWindow('sj_battleRoom_lphaWindow'):removeChildWindow(local_window)
		local_window:setVisible(false)
	end
end

-- ��Ƽ ��ġ ESCŰ ���
RegistEnterEventInfo("sj_matchmaking_lphaWindow", "OnClickExitRoomOk")
RegistEscEventInfo("sj_matchmaking_lphaWindow", "OnClickExitRoomCancel")



---------------------------------------

-- ���� ������ �� �����.

---------------------------------------
function WndMatchMaking_RequestChangeTeam(msg)
	ShowbattleRoomOkCancelBoxFunction2(msg, 'OnClickChangeTeamOk', 'OnClickChangeTeamCancel')
end


function ShowbattleRoomOkCancelBoxFunction2(arg, argYesFunc, argNoFunc)
	if winMgr:getWindow('sj_battleRoom_lphaWindow') then
		local aa= winMgr:getWindow("sj_matchmaking_lphaWindow"):getChildCount()
		if aa >= 1 then
			local bb= winMgr:getWindow("sj_matchmaking_lphaWindow"):getChildAtIdx(0)  
			winMgr:getWindow("sj_matchmaking_lphaWindow"):removeChildWindow(bb)		
		end
		winMgr:getWindow("sj_matchmaking_lphaWindow"):setVisible(true)
		root:addChildWindow(winMgr:getWindow("sj_matchmaking_lphaWindow"))
		local local_window = winMgr:getWindow("sj_matchmaking_backWindow")
		local_window:setUserString("okFunction", argYesFunc)
		local_window:setUserString("noFunction", argNoFunc)
		winMgr:getWindow("sj_matchmaking_lphaWindow"):addChildWindow(local_window)
		local_window:setVisible(true)
		
		local local_txt_window = winMgr:getWindow("sj_matchmaking_descWindow")
		local_window:setVisible(true)
		local_txt_window:clearTextExtends()
		local_txt_window:addTextExtends(arg, g_STRING_FONT_GULIMCHE, 15, 255,255,255,255,    2, 0,0,0,255)
		winMgr:getWindow("sj_matchmaking_okBtn"):setSubscribeEvent("Clicked", argYesFunc)
		winMgr:getWindow("sj_matchmaking_CancelBtn"):setSubscribeEvent("Clicked", argNoFunc)
	end
end

-- ����
function OnClickChangeTeamOk(args)

	if winMgr:getWindow('sj_battleRoom_backWindow') then
		
		if WndMatchMaking_IsObserver() then
			return
		end
		
		local okfunc = winMgr:getWindow('sj_battleRoom_backWindow'):getUserString("okFunction")
		if okfunc ~= "OnClickChangeTeamOk" then
			return
		end
		winMgr:getWindow('sj_battleRoom_backWindow'):setUserString("okFunction", "")	-- �ʱ�ȭ�� �ؾ���
		
		winMgr:getWindow('sj_battleRoom_lphaWindow'):setVisible(false)
		root:removeChildWindow(winMgr:getWindow('sj_battleRoom_lphaWindow'))
		local local_window = winMgr:getWindow('sj_battleRoom_backWindow')
		winMgr:getWindow('sj_battleRoom_lphaWindow'):removeChildWindow(local_window)
		local_window:setVisible(false)
		
		WndMatchMaking_ChangeTeam()
	end
end


-- ����
function OnClickChangeTeamCancel(args)
	
	if winMgr:getWindow('sj_battleRoom_backWindow') then
		local nofunc = winMgr:getWindow('sj_battleRoom_backWindow'):getUserString("noFunction")
		if nofunc ~= "OnClickChangeTeamCancel" then
			return
		end
		winMgr:getWindow('sj_battleRoom_backWindow'):setUserString("noFunction", "")	-- �ʱ�ȭ�� �ؾ���
		
		winMgr:getWindow('sj_battleRoom_lphaWindow'):setVisible(false)
		root:removeChildWindow( winMgr:getWindow('sj_battleRoom_lphaWindow'))
		local local_window = winMgr:getWindow('sj_battleRoom_backWindow')
		winMgr:getWindow('sj_battleRoom_lphaWindow'):removeChildWindow(local_window)
		local_window:setVisible(false)
	end
end

-- ��Ƽ ��ġ ESCŰ ���
RegistEnterEventInfo("sj_matchmaking_lphaWindow", "OnClickChangeTeamOk")
RegistEscEventInfo("sj_matchmaking_lphaWindow", "OnClickChangeTeamCancel")
--winMgr:getWindow("doChatting"):deactivate()


----------------------------------------------------
--  ������ ���� BackImage
----------------------------------------------------
-- ������ �˾� BackImage
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TipPopUpBackImageBG")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setWideType(6)
mywindow:setVisible(false)
mywindow:setPosition((g_MAIN_WIN_SIZEX-764)/2, (g_MAIN_WIN_SIZEY-463)/2)
mywindow:setSize(764, 463)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

-- ������ �˾� ESC
RegistEscEventInfo("TipPopUpBackImageBG", "GameTipPopUpCancel")


local WATCHING_WHO = PreCreateString_2488	--GetSStringInfo(LAN_CLUBWAR_PLAY_OBSERVER)	-- %s ������
function WndRoom_DrawObserverInfo()
	local characterName = ""
	drawer:drawTexture("UIData/fightClub_005.tga", 257, 160, 514, 41, 0, 220, WIDETYPE_5)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 16)
	if team == 0 then
		drawer:setTextColor(254,87,87,255)
	else
		drawer:setTextColor(97,161,240,255)
	end
	local szName = string.format(WATCHING_WHO, characterName)
	local size = GetStringSize(g_STRING_FONT_GULIMCHE, 16, szName)
	drawer:drawText(szName, 512-size/2, 173, WIDETYPE_5)
end



------------------------------------------------------
-- [���� ��ȣ] ȭ�� ��ü������ ���� ���� ������
------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SecondPassWord_AlphaWindow")
mywindow:setTexture("Enabled",	"UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0 , 0) 
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

------------------------------------------------------
-- [���� ��ȣ] ���� ������ �θ� ����
------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SecondPassWord_ROOT_AlphaWindow")
mywindow:setTexture("Enabled",	"UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6)
mywindow:setPosition( (g_MAIN_WIN_SIZEX / 2) - 165, (g_MAIN_WIN_SIZEY / 2) - 165)
mywindow:setSize(328, 347)
mywindow:setVisible(false)
mywindow:setAlpha(150)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

------------------------------------------------------
-- [���� ��ȣ] ���� ������
------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SecondPassWord_MainWindow")
mywindow:setTexture("Enabled",	"UIData/Login002.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/Login002.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
--mywindow:setWideType(6)
mywindow:setPosition(0, 0)
mywindow:setSize(328, 347)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("SecondPassWord_ROOT_AlphaWindow"):addChildWindow(mywindow)

------------------------------------------------------------------------------------------
-- [���� ��ȣ] ���� ��ȣ�� �Է��ϼ���
------------------------------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SecondPassWord_Input_1stImage")
mywindow:setTexture("Enabled",	"UIData/Login002.tga", 512, 0)
mywindow:setTexture("Disabled", "UIData/Login002.tga", 512, 0)
mywindow:setPosition(12 , 45) 
mywindow:setSize(298, 48)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("SecondPassWord_MainWindow"):addChildWindow(mywindow)

------------------------------------------------------
-- [2�� ��й�ȣ] ���� ������ "Ȯ��"��ư
------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "ProtectNum_MainWindow_OKButton")
mywindow:setTexture("Normal",	"UIData/Login002.tga", 334, 0)
mywindow:setTexture("Hover",	"UIData/Login002.tga", 334, 32)
mywindow:setTexture("Pushed",	"UIData/Login002.tga", 334, 64)
mywindow:setTexture("PushedOff","UIData/Login002.tga", 334, 64)
mywindow:setSize(89, 32)
mywindow:setEnabled(true)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
--mywindow:setAlpha(10)
mywindow:setPosition(120, 305)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "RequestSubmitProtectNumber")
winMgr:getWindow("SecondPassWord_MainWindow"):addChildWindow(mywindow)

-----------------------------------------------------
-- RequestSubmitProtectNumber()
-- OK��ư Ŭ���� �̺�Ʈ
------------------------------------------------------
function RequestSubmitProtectNumber()
	SendProtectNum();	
end


------------------------------------------------------
-- AllCloseSecondPassWord()
-- ù��° ��й�ȣ ������ Ȯ�ι�ư Ŭ���� �Լ�
------------------------------------------------------
function AllCloseSecondPassWord()
	DebugStr("AllCloseSecondPassWord1");
	winMgr:getWindow("SecondPassWord_ROOT_AlphaWindow"):setVisible(false)
	winMgr:getWindow("SecondPassWord_MainWindow"):setVisible(false)
	winMgr:getWindow("SecondPassWord_AlphaWindow"):setVisible(false)
	DebugStr("AllCloseSecondPassWord2");
	
	DebugStr("AllCloseSecondPassWord3");
	
	DebugStr("AllCloseSecondPassWord5");
	--winMgr:getWindow("SecondPassWord_Modify_Button"):setEnabled(true)
	--winMgr:getWindow("SecondPassWord_Setting_Button"):setEnabled(true)
	
	--winMgr:getWindow("SecondPassWord_Destroy_Back_Image"):setVisible(false)
	DebugStr("AllCloseSecondPassWord6");

end


------------------------------------------------------
-- ���� ��ȣ (����)
------------------------------------------------------
local nButtonSize = 3
local nCntX = 0
local nCntY = 0

for i=0, nButtonSize do
	mywindow = winMgr:createWindow("TaharezLook/Button",	"ProtecNumber_" .. i)
	mywindow:setTexture("Normal",		"UIData/Login002.tga",	( 30 * (i-1) ), 362)
	mywindow:setPosition( (50 * i) + 63 - 48, 103 - 35 )
	mywindow:setSize(32, 32)
	mywindow:setVisible(true)
	mywindow:setUserString("SecondButton", i)
	winMgr:getWindow('SecondPassWord_MainWindow'):addChildWindow(mywindow)
end

------------------------------------------------------
-- Ű�е� ��ư (����)
------------------------------------------------------
local nButtonSize = 10
local nCntX = 0
local nCntY = 0

for i=1, nButtonSize do
	mywindow = winMgr:createWindow("TaharezLook/Button",	"SecondPassWord_NumButton_" .. i)
	mywindow:setTexture("Normal",		"UIData/Login002.tga",	( 70 * (i-1) ), 362)
	mywindow:setTexture("Hover",		"UIData/Login002.tga",	( 70 * (i-1) ), 387)
	mywindow:setTexture("Pushed",		"UIData/Login002.tga",	( 70 * (i-1) ), 412)
	mywindow:setTexture("PushedOff",	"UIData/Login002.tga",	( 70 * (i-1) ), 362)	
	
	if i ~= 10 then
		-- 1 ~ 9 ����
		mywindow:setPosition( (70 * nCntX) + 63 , (25 * nCntY) + 203 )
	else
		-- 0 ��ư�� ���� ����
		mywindow:setPosition( (70 * 1) + 63 , (25 * nCntY) + 203 )
	end
	
	-- X Count ����
	if nCntX >= 2 then
		nCntX = 0
	else
		nCntX = nCntX + 1
	end
	
	-- Y Count ����
	if i % 3 == 0 then
		nCntY = nCntY + 1
	end	
	

	mywindow:setSize(70, 25)
	mywindow:setVisible(false)
	mywindow:setEnabled(true)
	mywindow:subscribeEvent("Clicked", "tProtectNumButtonClickEvent")
	mywindow:setUserString("SecondButton", i)
	winMgr:getWindow('SecondPassWord_MainWindow'):addChildWindow(mywindow)
end


------------------------------------------------------
-- tProtectNumButtonClickEvent()
-- ù��° ��й�ȣ ������ Ȯ�ι�ư Ŭ���� �Լ�
------------------------------------------------------ rkatk
function tProtectNumButtonClickEvent(args)
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local index = tonumber(EnterWindow:getUserString("SecondButton"))
	
	g_bPassWordFullSelected = SetUserPassWord(index)
	
	if g_bPassWordFullSelected then
		winMgr:getWindow("ProtectNum_MainWindow_OKButton"):setEnabled(true)
		winMgr:getWindow("ProtectNum_MainWindow_OKButton"):setVisible(true)
		winMgr:getWindow("ProtectNum_MainWindow_OKButton"):setTexture("Normal",		"UIData/Login001.tga", 334, 0)
		winMgr:getWindow("ProtectNum_MainWindow_OKButton"):setTexture("Hover",		"UIData/Login001.tga", 334, 32)
		winMgr:getWindow("ProtectNum_MainWindow_OKButton"):setTexture("Pushed",		"UIData/Login001.tga", 334, 64)
		winMgr:getWindow("ProtectNum_MainWindow_OKButton"):setTexture("PushedOff",	"UIData/Login001.tga", 334, 64)
		DebugStr("ù��° ��й�ȣ ������ Ȯ�ι�ư Ŭ���� �Լ�_________true")
	end
end

------------------------------------------------------
-- ����� ,  ���� ��ư
------------------------------------------------------
tModeButtonTexPosX = { ['err'] = 0,		700,	770 }
for j=1, 2 do
	mywindow = winMgr:createWindow("TaharezLook/Button",	"SecondPassWord_ModeButton_" .. j)
	mywindow:setTexture("Normal",	"UIData/Login002.tga",	tModeButtonTexPosX[j] , 362)
	mywindow:setTexture("Hover",	"UIData/Login002.tga",	tModeButtonTexPosX[j] , 387)
	mywindow:setTexture("Pushed",	"UIData/Login002.tga",	tModeButtonTexPosX[j] , 412)
	mywindow:setTexture("PushedOff","UIData/Login002.tga",	tModeButtonTexPosX[j] , 362)	
	
	if j == 1 then			-- 1�� ��ư
		mywindow:setPosition( 60, 230 )
	elseif j == 2 then		-- 2�� ��ư
		mywindow:setPosition( 200 , 230 )
	end
	
	mywindow:setSize(70, 25)
	--mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(false)
	mywindow:setEnabled(true)

	mywindow:subscribeEvent("Clicked", "tSecondPassWordClickModeEvent")
	mywindow:setUserString("SecondModeButton", j)
	winMgr:getWindow('SecondPassWord_MainWindow'):addChildWindow(mywindow)
end

------------------------------------------------------
-- tSecondPassWordClickModeEvent()
-- ����� , ���� �̺�Ʈ
------------------------------------------------------
function tSecondPassWordClickModeEvent(args)
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local index = tonumber(EnterWindow:getUserString("SecondModeButton"))
	
	UserPassWordClear(index)
	
	-- Ȯ�ι�ư ��Ȱ��ȭ
	winMgr:getWindow("ProtectNum_MainWindow_OKButton"):setEnabled(false)
		DebugStr("ProtectNum_MainWindow_OKButton_________false")	
	winMgr:getWindow("ProtectNum_MainWindow_OKButton"):setTexture("Normal",		"UIData/Login002.tga", 334, 96)
	winMgr:getWindow("ProtectNum_MainWindow_OKButton"):setTexture("Hover",		"UIData/Login002.tga", 334, 96)
	winMgr:getWindow("ProtectNum_MainWindow_OKButton"):setTexture("Pushed",		"UIData/Login002.tga", 334, 96)
	winMgr:getWindow("ProtectNum_MainWindow_OKButton"):setTexture("PushedOff",	"UIData/Login002.tga", 334, 96)
end


------------------------------------------------------
-- MakeNumberTable()
-- �迭�� �޾Ƽ� ���̺��� ������Ų��
------------------------------------------------------
g_tNumberBuff = {}

function MakeNumberTable(index , number)
	-- index��	������	1
	--			����	10
	
	g_tNumberBuff[index] = number
end

------------------------------------------------------
-- MakeProtectNumTable()
-- �迭�� �޾Ƽ� ���̺��� ������Ų��
------------------------------------------------------
g_tProtectNumberBuff = {}

function MakeProtectNumTable(index , number)
	g_tProtectNumberBuff[index] = number
end


------------------------------------------------------
-- SetRandomNumberPosition()
-- ��ư ������ �����ϰ� ����
------------------------------------------------------
function SetRandomNumberPosition()
	
	local nCntX = 0
	local nCntY = 0
	
	for i = 1 , 10 do
		if i ~= 10 then
			-- 1 ~ 9 ��ư ����
			winMgr:getWindow("SecondPassWord_NumButton_" .. g_tNumberBuff[i]):setPosition( (70 * nCntX) + 60 , (25 * nCntY) + 155 )
		else
			-- 0 ��ư�� ���� ����
			winMgr:getWindow("SecondPassWord_NumButton_" .. g_tNumberBuff[i]):setPosition( (70 * 1) + 60 , (25 * nCntY) + 155 )
		end
		
		-- X Count ����
		if nCntX >= 2 then
			nCntX = 0
		else
			nCntX = nCntX + 1
		end
		
		-- Y Count ����
		if i % 3 == 0 then
			nCntY = nCntY + 1
		end
		
	end	-- end of for
	
end	-- end of function

---------------------------------------------------------------------
-- SetProtectNumberImage()
-- ���� ���ڸ� ǥ���ϴ� ���� �̹����� ���ڸ� ���� �� ǥ�� ��ġ�� ����
---------------------------------------------------------------------
function SetProtectNumberImage()
	
	local nCntX = 0
	local nCntY = 0
	for i = 0 , 3 do
		DebugStr("SetProtectNumberImage____________" .. g_tProtectNumberBuff[i]);
		winMgr:getWindow("ProtecNumber_" .. i):setTexture("Normal",		"UIData/Login002.tga",	( 32 * (g_tProtectNumberBuff[i] - 1) ), 439)
		DebugStr("SetProtectNumberImage____________e____________" .. g_tProtectNumberBuff[i]);
		winMgr:getWindow("ProtecNumber_" .. i):setPosition( (50 * (i + 1 )) + 20, 90 )
		DebugStr("SetProtectNumberImage____________e_____________e____________" .. i);	
	end
end


------------------------------------------------------
-- SetPassWordStarVisible()
-- ��ȣȭ *��� ��ư �����Լ�
------------------------------------------------------
function SetPassWordStarVisible(StarNumber)
	DebugStr("-1���� ���� ������ �� �ѹ� : " .. StarNumber)
	
	if StarNumber == PASSWORD_NOT_SELECT then -- (-1)
		for i = 1 , 4 do
			--DebugStr("��Ÿ�ѹ� ��ξ���")
			winMgr:getWindow("SecondPassWord_SecretStar_" .. i):setVisible(false)
		end
	elseif StarNumber == 0 then -- 1
		for i = 1 , 4 do
			--DebugStr("��Ÿ�ѹ� ��ξ���")
			winMgr:getWindow("SecondPassWord_SecretStar_" .. i):setVisible(false)
		end
	elseif StarNumber == PASSWORD_ONE then -- 1
		DebugStr("��Ÿ�ѹ� 1")
		winMgr:getWindow("SecondPassWord_SecretStar_1"):setVisible(true)
		winMgr:getWindow("SecondPassWord_SecretStar_2"):setVisible(false)
		winMgr:getWindow("SecondPassWord_SecretStar_3"):setVisible(false)
		winMgr:getWindow("SecondPassWord_SecretStar_4"):setVisible(false)
	elseif StarNumber == PASSWORD_TWO then -- 2
		DebugStr("��Ÿ�ѹ� 2")
		winMgr:getWindow("SecondPassWord_SecretStar_1"):setVisible(true)
		winMgr:getWindow("SecondPassWord_SecretStar_2"):setVisible(true)
		winMgr:getWindow("SecondPassWord_SecretStar_3"):setVisible(false)
		winMgr:getWindow("SecondPassWord_SecretStar_4"):setVisible(false)
	elseif StarNumber == PASSWORD_THREE then -- 3
		--DebugStr("��Ÿ�ѹ� 3")
		winMgr:getWindow("SecondPassWord_SecretStar_1"):setVisible(true)
		winMgr:getWindow("SecondPassWord_SecretStar_2"):setVisible(true)
		winMgr:getWindow("SecondPassWord_SecretStar_3"):setVisible(true)
		winMgr:getWindow("SecondPassWord_SecretStar_4"):setVisible(false)
	elseif StarNumber == PASSWORD_FOUR then -- 4
		--DebugStr("��Ÿ�ѹ� 4")	
		winMgr:getWindow("SecondPassWord_SecretStar_1"):setVisible(true)
		winMgr:getWindow("SecondPassWord_SecretStar_2"):setVisible(true)
		winMgr:getWindow("SecondPassWord_SecretStar_3"):setVisible(true)
		winMgr:getWindow("SecondPassWord_SecretStar_4"):setVisible(true)
	end
	
end

------------------------------------------------------
-- [2�� ��й�ȣ] �� ��� �̹���
------------------------------------------------------
for i=1 , 4 do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SecondPassWord_SecretStar_" .. i)
	mywindow:setTexture("Enabled",	"UIData/Login001.tga", 334, 256)
	mywindow:setTexture("Disabled", "UIData/Login001.tga", 334, 256)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(95 + (22*i) , 265)
	mywindow:setSize(22, 22)
	mywindow:setUserString("StarNumber_" .. i , -1)
	mywindow:setVisible(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("SecondPassWord_MainWindow"):addChildWindow(mywindow)
end









------------------------------------------------------
-- �� ��й�ȣ �ֻ��� �Լ� ��
------------------------------------------------------
function SecondPassWordRootFunc()
	SecondPassWordRootFunction()
end


-- 2�� ��й�ȣ Ȱ��ȭ ���� �Լ�
function SetModeButtonEnable(bFirst , bSecond)
	
	winMgr:getWindow("SecondPassWord_Modify_Button"):setEnabled(bFirst)
	if bFirst then
		winMgr:getWindow("SecondPassWord_Modify_Button"):setTexture("Normal",	"UIData/Login001.tga", 912, 0)
		winMgr:getWindow("SecondPassWord_Modify_Button"):setTexture("Hover",	"UIData/Login001.tga", 912, 37)
		winMgr:getWindow("SecondPassWord_Modify_Button"):setTexture("Pushed",	"UIData/Login001.tga", 912, 74)
		winMgr:getWindow("SecondPassWord_Modify_Button"):setTexture("PushedOff","UIData/Login001.tga", 912, 74)
	elseif bFirst == false then
		winMgr:getWindow("SecondPassWord_Modify_Button"):setTexture("Normal",	"UIData/Login001.tga", 912, 111)
		winMgr:getWindow("SecondPassWord_Modify_Button"):setTexture("Hover",	"UIData/Login001.tga", 912, 111)
		winMgr:getWindow("SecondPassWord_Modify_Button"):setTexture("Pushed",	"UIData/Login001.tga", 912, 111)
		winMgr:getWindow("SecondPassWord_Modify_Button"):setTexture("PushedOff","UIData/Login001.tga", 912, 111)
	end
	
	
	winMgr:getWindow("SecondPassWord_Setting_Button"):setEnabled(bSecond)
	if bSecond then
		winMgr:getWindow("SecondPassWord_Setting_Button"):setTexture("Normal",	"UIData/Login001.tga", 912, 148)
		winMgr:getWindow("SecondPassWord_Setting_Button"):setTexture("Hover",	"UIData/Login001.tga", 912, 185)
		winMgr:getWindow("SecondPassWord_Setting_Button"):setTexture("Pushed",	"UIData/Login001.tga", 912, 222)
		winMgr:getWindow("SecondPassWord_Setting_Button"):setTexture("PushedOff","UIData/Login001.tga", 912, 222)
	elseif bSecond == false then
		winMgr:getWindow("SecondPassWord_Setting_Button"):setTexture("Normal",	"UIData/Login001.tga", 912, 259)
		winMgr:getWindow("SecondPassWord_Setting_Button"):setTexture("Hover",	"UIData/Login001.tga", 912, 259)
		winMgr:getWindow("SecondPassWord_Setting_Button"):setTexture("Pushed",	"UIData/Login001.tga", 912, 259)
		winMgr:getWindow("SecondPassWord_Setting_Button"):setTexture("PushedOff","UIData/Login001.tga", 912, 259)
	end
	
end

function ShowWndProtectNumberInput(ProtectNum)
	DebugStr("CheckSecondPassWord üũ1" .. ProtectNum)
	-- �����Ҷ� �ѹ� ������ �����ش�
	AllCloseSecondPassWord()
	
	root:addChildWindow(winMgr:getWindow("SecondPassWord_AlphaWindow"))
	winMgr:getWindow("SecondPassWord_AlphaWindow"):setVisible(true)
	DebugStr("CheckSecondPassWord üũ2")
	
	--�ʱ�ȭ
	UserPassWordClear(0)
	
	-- ��Ȳ�� �´� �ȳ����� �ֱ�
	winMgr:getWindow("SecondPassWord_Input_1stImage"):setVisible(true)
	
	-- Ȯ�ι�ư ��Ȱ��ȭ
	winMgr:getWindow("ProtectNum_MainWindow_OKButton"):setEnabled(false)
		DebugStr("Ȯ�ι�ư ��Ȱ��ȭ_________false")		
	winMgr:getWindow("ProtectNum_MainWindow_OKButton"):setTexture("Normal",		"UIData/Login002.tga", 334, 96)
	winMgr:getWindow("ProtectNum_MainWindow_OKButton"):setTexture("Hover",		"UIData/Login002.tga", 334, 96)
	winMgr:getWindow("ProtectNum_MainWindow_OKButton"):setTexture("Pushed",		"UIData/Login002.tga", 334, 96)
	winMgr:getWindow("ProtectNum_MainWindow_OKButton"):setTexture("PushedOff",	"UIData/Login002.tga", 334, 96)
		DebugStr("CheckSecondPassWord üũ3")
	--
	--winMgr:getWindow("SecondPassWord_AlphaWindow"):setVisible(false)
	winMgr:getWindow("SecondPassWord_ROOT_AlphaWindow"):setVisible(true)
	winMgr:getWindow("SecondPassWord_MainWindow"):setVisible(true)
	winMgr:getWindow("ProtectNum_MainWindow_OKButton"):setVisible(true)
	DebugStr("CheckSecondPassWord üũ4")
	for i = 1 , 10 do
		winMgr:getWindow("SecondPassWord_NumButton_" .. i):setVisible(true)
	end
	
	for j = 1 , 2 do
		winMgr:getWindow("SecondPassWord_ModeButton_" .. j):setVisible(true)
	end
	
	DebugStr("CheckSecondPassWord üũ5")
end

mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_matchmaking_info_timer")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 200, 80, 255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
-- mywindow:setWideType(6)
mywindow:setPosition(0, 30)
mywindow:setSize(349, 100)
mywindow:setAlwaysOnTop(true)
banpollwindow:addChildWindow(mywindow)


--------------------------------------------------------------------
-- Rungsimun @ GameInside - WndMatchMaking Status
--------------------------------------------------------------------
function WndMatchMaking_RenderTime(min, sec, milliSec)
	tTime = { ["err"]=0, [0]=3, 67, 131, 195, 259, 325, 391, 457, 523, 589 }

	local startPos1	= 400
	local startPos2	= startPos1 + 48
	local changePosY = 32

	drawer:drawTexture("UIData/MatchMakingRoom1.tga", startPos1, changePosY, 62, 78, tTime[min/10], 943, 6)
	drawer:drawTexture("UIData/MatchMakingRoom1.tga", startPos2, changePosY, 62, 78, tTime[min%10], 943, 6)
	
	drawer:drawTexture("UIData/MatchMakingRoom1.tga", startPos2+32, changePosY, 62, 78, 655, 943, 6)
	
	drawer:drawTexture("UIData/MatchMakingRoom1.tga", startPos1+114, changePosY, 62, 78, tTime[sec/10], 943, 6)
	drawer:drawTexture("UIData/MatchMakingRoom1.tga", startPos2+114, changePosY, 62, 78, tTime[sec%10], 943, 6)
	
	-- MATCHMAKING player info

	-- for i = 1 , 4 do
	-- 	drawer:drawTexture("UIData/MatchMakingRoom2.tga", startPos2+114, changePosY, 62, 78, tTime[sec%10], 943, 1)
	-- end
end
-- 65 1021
-- 62 78

-- mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_matchmaking_logo")
-- mywindow:setTexture("Enabled", "UIData/matchmaking.tga", 0, 0)
-- mywindow:setTexture("Disabled", "UIData/matchmaking.tga", 0, 0)
-- mywindow:setProperty("FrameEnabled", "False")
-- mywindow:setProperty("BackgroundEnabled", "False")
-- mywindow:setWideType(6);
-- mywindow:setPosition(1, 8)
-- mywindow:setSize(499, 101)
-- mywindow:setZOrderingEnabled(false)
-- root:addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/Button", "sj_matchmaking_userReadyBtn")
mywindow:setTexture("Normal", "UIData/MatchMakingRoom1.tga", 1, 131)
mywindow:setTexture("Hover", "UIData/MatchMakingRoom1.tga", 334, 131)
mywindow:setTexture("Pushed", "UIData/MatchMakingRoom1.tga", 1, 131)
mywindow:setTexture("PushedOff", "UIData/MatchMakingRoom1.tga", 1, 131)
mywindow:setWideType(6);
mywindow:setPosition(688, 568)
mywindow:setSize(331, 128)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnWndMatchMaking_Ready")
root:addChildWindow(mywindow)
if WndMatchMaking_IsMaster() == false then
	winMgr:getWindow("sj_matchmaking_userReadyBtn"):setVisible(true)
end

mywindow = winMgr:createWindow("TaharezLook/Button", "sj_matchmaking_cancelBtn")
mywindow:setTexture("Normal", "UIData/MatchMakingRoom1.tga", 1, 261)
mywindow:setTexture("Hover", "UIData/MatchMakingRoom1.tga", 334, 261)
mywindow:setTexture("Pushed", "UIData/MatchMakingRoom1.tga", 1, 261)
mywindow:setTexture("PushedOff", "UIData/MatchMakingRoom1.tga", 1, 261)
mywindow:setWideType(6);
mywindow:setPosition(688, 568)
mywindow:setSize(331, 128)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnWndMatchMaking_Ready")
root:addChildWindow(mywindow)

function OnWndMatchMaking_Ready()
	PlayWave("sound/button_click.wav");
	WndMatchMaking_Ready()
end

-- PlayWave("sound/button_click.wav");
MATCHMAKING_IDLE 				= 0
MATCHMAKING_WAITING 			= 1
MATCHMAKING_FINDING_MATCH 		= 2
MATCHMAKING_MATCHED				= 3
MATCHMAKING_ENTERING_GAME		= 4
MATCHMAKING_PLAYING				= 5

current_status = MATCHMAKING_IDLE
-- 855 816
function WndMatchMaking_ShowMatchStatus(status)

	local x	= 272
	local y = 283
	local ty = { ["err"]=230, [0]=230, 301, 352, 352, 402, }
	-- drawer:drawTexture("UIData/matchmaking.tga", x, 0, 499, 50, 0, ty[status], 1)

	if status >= 2 then
		drawer:drawTexture("UIData/MatchMakingRoom1.tga", 299, 28, 426, 103, 1, 713, 6)
	end

end

function WndMatchMaking_UpdateStartButton(status)
	if status == MATCHMAKING_WAITING or status == MATCHMAKING_IDLE then
		if winMgr:getWindow("sj_matchmaking_cancelBtn") then
			winMgr:getWindow("sj_matchmaking_cancelBtn"):setVisible(false)
		end

		if winMgr:getWindow("sj_matchmaking_readyBtn") then
			winMgr:getWindow("sj_matchmaking_readyBtn"):setVisible(false)
		end
	end

	-- READY FOR NON MASTER
	if WndMatchMaking_IsMaster() == false then
		if WndMatchMaking_IsReady() == false then
			winMgr:getWindow("sj_matchmaking_userReadyBtn"):setVisible(true)
			winMgr:getWindow("sj_matchmaking_cancelBtn"):setVisible(false)
		else
			winMgr:getWindow("sj_matchmaking_userReadyBtn"):setVisible(false)
			winMgr:getWindow("sj_matchmaking_cancelBtn"):setVisible(true)
		end
	else
		winMgr:getWindow("sj_matchmaking_userReadyBtn"):setVisible(false)
	end

	-- CANCEL
	if status == MATCHMAKING_FINDING_MATCH then
		if winMgr:getWindow("sj_matchmaking_cancelBtn") then
			winMgr:getWindow("sj_matchmaking_cancelBtn"):setEnabled(true)
			winMgr:getWindow("sj_matchmaking_cancelBtn"):setVisible(true)
		end

		winMgr:getWindow("sj_matchmaking_alphaWindow"):setVisible(false)
		winMgr:getWindow("sj_matchmaking_inviteAdjustWindow"):setVisible(false)
		WndMatchMakingReward_Toggle(false)
	end

	if status == MATCHMAKING_MATCHED and current_status ~= status then
		if winMgr:getWindow("sj_matchmaking_cancelBtn") then
			winMgr:getWindow("sj_matchmaking_cancelBtn"):setEnabled(false)
			winMgr:getWindow("sj_matchmaking_cancelBtn"):setTexture("Disabled",	"UIData/MatchMakingRoom1.tga", 667, 261)
			winMgr:getWindow("sj_matchmaking_cancelBtn"):setVisible(true)
		end
	end

	current_status = status
end

function WndMatchMaking_HideReadyButton()
	if winMgr:getWindow("sj_matchmaking_readyBtn") then
		winMgr:getWindow("sj_matchmaking_readyBtn"):setVisible(false)
	end
end

function WndMatchMaking_ShowMatchFound()
	anim_mode = 1

	if winMgr:getWindow("sj_matchmaking_ready") then	
		mywindow = winMgr:getWindow("sj_matchmaking_ready")
		mywindow:setVisible(true)
		mywindow:setEnabled(true)

		exitBtn = winMgr:getWindow("NewMatchMakingExitBtn")
		exitBtn:setEnabled(false)
		exitBtn:setVisible(false)
	end
	
	if winMgr:getWindow("sj_matchmaking_ready_button") then	
		mywindow = winMgr:getWindow("sj_matchmaking_ready_button")
		mywindow:setEnabled(true)
	end
end

function WndMatchMaking_HideMatchFound()
	winMgr:getWindow("sj_matchmaking_ready"):setVisible(false)

	exitBtn = winMgr:getWindow("NewMatchMakingExitBtn")
	exitBtn:setEnabled(true)
	exitBtn:setVisible(true)
end

-- mywindow = winMgr:createWindow("TaharezLook/StaticText", "matchmaking_ui_version")
-- mywindow:setProperty("FrameEnabled", "false")
-- mywindow:setProperty("BackgroundEnabled", "false")
-- mywindow:setTextColor(255, 255, 255, 255)
-- mywindow:setFont("tahoma", 18)
-- mywindow:setText("v.0.0.11")
-- mywindow:setPosition(200, 400)
-- mywindow:setSize(250, 36)
-- mywindow:setAlwaysOnTop(true)
-- root:addChildWindow(mywindow)	
debug_count = 0
mywindow = winMgr:createWindow("TaharezLook/StaticText", "matchmaking_debug")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont("tahoma", 18)
mywindow:setText("")
mywindow:setWideType(6)
mywindow:setPosition(200, 400)
mywindow:setSize(250, 36)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
root:addChildWindow(mywindow)	

teamBtn = winMgr:createWindow("TaharezLook/StaticImage", "sj_matchmaking_team4v4mode")
teamBtn:setTexture("Enabled", "UIData/MatchMakingRoom3.tga", 0, 426)
teamBtn:setWideType(6)
teamBtn:setPosition(478, 569)
teamBtn:setSize(202, 128)
teamBtn:setZOrderingEnabled(false)
teamBtn:subscribeEvent("Clicked", "WndMatchMaking_Team4v4_Click")
root:addChildWindow(teamBtn)

-- teamBtn = winMgr:createWindow("TaharezLook/Button", "sj_matchmaking_team4v4")
-- teamBtn:setTexture("Normal", "UIData/MatchMakingRoom1.tga", 205, 458)
-- teamBtn:setTexture("Hover", "UIData/MatchMakingRoom1.tga", 409, 458)
-- teamBtn:setTexture("Pushed", "UIData/MatchMakingRoom1.tga", 205, 458)
-- teamBtn:setTexture("PushedOff", "UIData/MatchMakingRoom1.tga", 205, 458)
-- teamBtn:setWideType(6)
-- teamBtn:setPosition(478, 569)
-- teamBtn:setSize(204, 59)
-- teamBtn:setZOrderingEnabled(false)
-- teamBtn:subscribeEvent("Clicked", "WndMatchMaking_Team4v4_Click")
-- root:addChildWindow(teamBtn)

-- teamBtn = winMgr:createWindow("TaharezLook/Button", "sj_matchmaking_team4v4_selected")
-- teamBtn:setTexture("Normal", "UIData/MatchMakingRoom1.tga", 1, 458)
-- teamBtn:setTexture("Hover", "UIData/MatchMakingRoom1.tga", 1, 458)
-- teamBtn:setTexture("Pushed", "UIData/MatchMakingRoom1.tga", 1, 458)
-- teamBtn:setTexture("PushedOff", "UIData/MatchMakingRoom1.tga", 1, 458)
-- teamBtn:setWideType(6)
-- teamBtn:setPosition(478, 569)
-- teamBtn:setSize(204, 59)
-- teamBtn:setZOrderingEnabled(false)
-- teamBtn:setVisible(false)
-- root:addChildWindow(teamBtn)

-- teamBtn = winMgr:createWindow("TaharezLook/Button", "sj_matchmaking_team2v2")
-- teamBtn:setTexture("Normal", "UIData/MatchMakingRoom1.tga", 205, 518)
-- teamBtn:setTexture("Hover", "UIData/MatchMakingRoom1.tga", 409, 518)
-- teamBtn:setTexture("Pushed", "UIData/MatchMakingRoom1.tga", 205, 518)
-- teamBtn:setTexture("PushedOff", "UIData/MatchMakingRoom1.tga", 205, 518)
-- teamBtn:setWideType(6)
-- teamBtn:setPosition(478, 637)
-- teamBtn:setSize(204, 59)
-- teamBtn:setZOrderingEnabled(false)
-- teamBtn:subscribeEvent("Clicked", "WndMatchMaking_Team2v2_Click")
-- root:addChildWindow(teamBtn)

-- teamBtn = winMgr:createWindow("TaharezLook/Button", "sj_matchmaking_team2v2_selected")
-- teamBtn:setTexture("Normal", "UIData/MatchMakingRoom1.tga", 1, 518)
-- teamBtn:setTexture("Hover", "UIData/MatchMakingRoom1.tga", 1, 518)
-- teamBtn:setTexture("Pushed", "UIData/MatchMakingRoom1.tga", 1, 518)
-- teamBtn:setTexture("PushedOff", "UIData/MatchMakingRoom1.tga", 1, 518)
-- teamBtn:setWideType(6)
-- teamBtn:setPosition(478, 637)
-- teamBtn:setSize(204, 59)
-- teamBtn:setZOrderingEnabled(false)
-- teamBtn:setVisible(false)
-- root:addChildWindow(teamBtn)

mywindow = winMgr:createWindow("TaharezLook/Button", "NewRankRewardEnterBtn")
mywindow:setTexture("Normal", "UIData/MatchMakingRoom3.tga", 551, 1)
mywindow:setTexture("Hover", "UIData/MatchMakingRoom3.tga", 628, 1)
mywindow:setTexture("Pushed", "UIData/MatchMakingRoom3.tga", 551, 1)
mywindow:setTexture("PushedOff", "UIData/MatchMakingRoom3.tga", 551, 1)
mywindow:setTexture("Enabled", "UIData/MatchMakingRoom3.tga", 551, 1)
mywindow:setTexture("Disabled", "UIData/MatchMakingRoom3.tga", 551, 1)
mywindow:setWideType(6)
mywindow:setPosition(938, 106)
mywindow:setSize(76, 84)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "DoOnclickEnterRankReward")
root:addChildWindow(mywindow)

function DoOnclickEnterRankReward()
	PlayWave("sound/button_click.wav");
	if WndMatchMaking_IsNotIdle() then
		return
	end
	WndMatchMakingReward_Toggle(true)
	WndMatchMakingReward_Open()
end

function WndMatchMaking_OnChangeTeamMode(teammode)
	if winMgr:getWindow("sj_matchmaking_team2v2_selected") then		
		winMgr:getWindow("sj_matchmaking_team2v2_selected"):setVisible(teammode == 2)
	end

	if winMgr:getWindow("sj_matchmaking_team4v4_selected") then		
		winMgr:getWindow("sj_matchmaking_team4v4_selected"):setVisible(teammode == 4)
	end
end

function DoChangeTeamMode(teammode)
	if current_status == MATCHMAKING_FINDING_MATCH or current_status == MATCHMAKING_MATCHED then
		return
	end
	currentTeammode = teammode
	WndMatchMaking_OnChangeTeamMode(teammode)
	WndMatchMaking_ChangeTeamMode(teammode)
end

local currentTeammode = 4
DoChangeTeamMode(currentTeammode)

function WndMatchMaking_Team4v4_Click()
	PlayWave("sound/button_click.wav");
	DoChangeTeamMode(4)
end

function WndMatchMaking_Team2v2_Click()
	PlayWave("sound/button_click.wav");
	DoChangeTeamMode(2)
end

g_GAME_WIN_SIZEX, g_GAME_WIN_SIZEY = GetCurrentResolution()
screenOffsetX = (1920 - g_GAME_WIN_SIZEX) / 2
screenOffsetY = (1080 - g_GAME_WIN_SIZEY) / 2

-- NEW MATCHMAKING READY CONFIRMATION
local mConfirmWindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_matchmaking_ready")
mConfirmWindow:setTexture("Enabled", "UIData/BackGroundMatchMakingReady.tga", screenOffsetX, screenOffsetY)
mConfirmWindow:setPosition(0, 0)
mConfirmWindow:setSize(1920, 1080)
mConfirmWindow:setVisible(false)
-- mConfirmWindow:setAlwaysOnTop(true)
-- mConfirmWindow:setZOrderingEnabled(false)
-- mConfirmWindow:setWideType(6)
root:addChildWindow(mConfirmWindow)

local mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_matchmaking_ready2")
mywindow:setTexture("Enabled", "UIData/BackGroundMatchMakingReady.tga", screenOffsetX, 1080+screenOffsetY)
-- mywindow:setWideType(6)
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 128)
-- mywindow:setEnabled(false)
mywindow:setVisible(true)
mConfirmWindow:addChildWindow(mywindow)

readychar1 = winMgr:createWindow("TaharezLook/StaticImage", "sj_matchmaking_char1")
readychar1:setTexture("Enabled", "UIData/MatchMakingReadyAnim.tga", 0, 0)
-- readychar1:setWideType(6)
readychar1:setPosition(-screenOffsetX, -screenOffsetY)
readychar1:setSize(919, 895)
-- readychar1:setEnabled(false)
readychar1:setVisible(true)
-- readychar1:setWideType(6)
mConfirmWindow:addChildWindow(readychar1)

readychar2 = winMgr:createWindow("TaharezLook/StaticImage", "sj_matchmaking_char2")
readychar2:setTexture("Enabled", "UIData/MatchMakingReadyAnim.tga", 1274, 0)
-- readychar2:setWideType(6)
readychar2:setPosition(-screenOffsetX+1084, -screenOffsetY)
-- +1920-62-786, 0)
readychar2:setSize(786, 1042)
-- readychar2:setEnabled(false)
readychar2:setVisible(true)
-- readychar2:setWideType(6)
mConfirmWindow:addChildWindow(readychar2)


mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_matchmaking_ready_title")
mywindow:setTexture("Enabled", "UIData/MatchMakingRoom3.tga", 1, 225)
mywindow:setWideType(6)
mywindow:setPosition(348, 49)
mywindow:setSize(326, 95)
-- mywindow:setEnabled(false)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mConfirmWindow:addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_matchmaking_ready_timebox")
mywindow:setTexture("Enabled", "UIData/MatchMakingRoom3.tga", 1, 322)
mywindow:setWideType(6)
mywindow:setPosition(352, 140)
mywindow:setSize(326, 95)
-- mywindow:setEnabled(false)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mConfirmWindow:addChildWindow(mywindow)

-- EXIT ROOM BUTTON
isExit = false
mywindow = winMgr:createWindow("TaharezLook/Button", "NewMatchMakingExitBtn")
mywindow:setTexture("Normal", "UIData/MatchMakingRoom1.tga", 1, 405)
mywindow:setTexture("Hover", "UIData/MatchMakingRoom1.tga", 202, 405)
mywindow:setTexture("Pushed", "UIData/MatchMakingRoom1.tga", 1, 405)
mywindow:setTexture("PushedOff", "UIData/MatchMakingRoom1.tga", 1, 405)
mywindow:setTexture("Enabled", "UIData/MatchMakingRoom1.tga", 1, 405)
mywindow:setTexture("Disabled", "UIData/MatchMakingRoom1.tga", 1, 405)
mywindow:setWideType(6)
mywindow:setPosition(813, 10)
mywindow:setSize(199, 35)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "DoOnclickOutNewBtn")
root:addChildWindow(mywindow)

function DoShowExitBtn(isShow)
	mywindow = winMgr:getWindow("NewMatchMakingExitBtn")
	mywindow:setEnabled(isShow)
	mywindow:setVisible(isShow)
end

function DoOnclickOutNewBtn()
	PlayWave("sound/button_click.wav");
	-- if isExit == false then
	-- 	isExit = true
	-- 	DoShowExitBtn(false)
		OnclickOutNewBtn()
	-- end
end

local tMatchReadyInfo = { ["err"]=0 , 
	charType	= { ["err"]=0, [0]=1, 2, 5, 4, 3, 1, 2, 4 },
	ready		= { ["err"]=0, [0]=0, 0, 0, 0, 0, 0, 0, 0 },
	enable		= { ["err"]=0, [0]=1, 1, 1, 1, 1, 1, 1, 1 },
	scale		= { ["err"]=0, [0]=0, 0, 0, 0, 0, 0, 0, 0 },
	scale2		= { ["err"]=0, [0]=0, 0, 0, 0, 0, 0, 0, 0 },
	exit		= { ["err"]=0, [0]=0, 0, 0, 0, 0, 0, 0, 0 },
}
local tCharX = {['err']=0, [0]= 313, 313, 313, 729, 729, 729, 729, 729}
local tCharY = {['err']=0, [0]= 677, 781, 885, 677, 781, 885, 885, 885}
local tCharPX = {['err']=0, [0]= 22, 133, 244, 356, 565, 678, 791, 904}

function WndMatchMaking_Ready_SetReady(slot)
	tMatchReadyInfo.ready[slot] = 1;
	tMatchReadyInfo.scale2[slot] = 50;
	-- WndMatchMaking_Ready_RenderPlayer()
end

function WndMatchMaking_Ready_SetExit(slot)
	tMatchReadyInfo.exit[slot] = 1;
	-- WndMatchMaking_Ready_RenderPlayer()
end

function WndMatchMaking_Ready_SetReadyInfo(slot, charType, enable)
	tMatchReadyInfo.charType[slot] = charType;
	tMatchReadyInfo.ready[slot] = 0;
	tMatchReadyInfo.enable[slot] = enable;
	tMatchReadyInfo.scale[slot] = 50;
	tMatchReadyInfo.exit[slot] = 0;
end

function WndMatchMaking_Ready_RenderPlayer()
	for i=0, 7 do
		mywindow = winMgr:getWindow("sj_matchmaking_ready_player" .. i)
		if mywindow ~= '' then
			mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_matchmaking_ready_player" .. i)
		end
		local j = tMatchReadyInfo.charType[i]
		local finalCharX = tMatchReadyInfo.ready[i] == 1 and tCharX[j] - 104 or tCharX[j]
		mywindow:setTexture("Enabled", "UIData/channel_001.tga", finalCharX, tCharY[j])
		mywindow:setWideType(6)
		mywindow:setPosition(tCharPX[i], 334)
		mywindow:setSize(102, 102)
		mywindow:setScaleWidth(255 + tMatchReadyInfo.scale[i] + tMatchReadyInfo.scale2[i])
		mywindow:setScaleHeight(255 + (tMatchReadyInfo.scale[i] * 9) + tMatchReadyInfo.scale2[i])
		mywindow:setAlign(8)
		mywindow:setAlpha(255 - (tMatchReadyInfo.scale[i] * 5))
		mywindow:setVisible(tMatchReadyInfo.enable[i] == 1)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mConfirmWindow:addChildWindow(mywindow)

		tMatchReadyInfo.scale[i] = tMatchReadyInfo.scale[i] / 2;
		tMatchReadyInfo.scale2[i] = tMatchReadyInfo.scale2[i] / 2;

		mywindow = winMgr:getWindow("sj_matchmaking_ready_player_exit" .. i)
		if mywindow ~= '' then
			mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_matchmaking_ready_player_exit" .. i)
		end
		mywindow:setTexture("Enabled", "UIData/MatchMakingRoom3.tga", 1, 555)
		mywindow:setWideType(6)
		mywindow:setPosition(tCharPX[i], 334)
		mywindow:setSize(102, 102)
		-- mywindow:setScaleWidth(255 + tMatchReadyInfo.scale[i] + tMatchReadyInfo.scale2[i])
		-- mywindow:setScaleHeight(255 + (tMatchReadyInfo.scale[i] * 9) + tMatchReadyInfo.scale2[i])
		mywindow:setAlign(8)
		-- mywindow:setAlpha(255 - (tMatchReadyInfo.scale[i] * 5))
		mywindow:setVisible(tMatchReadyInfo.exit[i] == 1)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mConfirmWindow:addChildWindow(mywindow)
	end
end

mywindow = winMgr:createWindow("TaharezLook/Button", "sj_matchmaking_ready_button")
mywindow:setTexture("Normal", "UIData/MatchMakingRoom3.tga", 0, 0)
mywindow:setTexture("Hover", "UIData/MatchMakingRoom3.tga", 0, 75)
mywindow:setTexture("Pushed", "UIData/MatchMakingRoom3.tga", 0, 0)
mywindow:setTexture("PushedOff", "UIData/MatchMakingRoom3.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/MatchMakingRoom3.tga", 0, 150)
mywindow:setWideType(6)
mywindow:setPosition(330, 589)
mywindow:setSize(365, 74)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnWndMatchMaking_Ready")
mConfirmWindow:addChildWindow(mywindow)

function OnWndMatchMaking_Ready()
	PlayWave("sound/button_click.wav");
	-- anim_mode = 2
	mywindow = winMgr:getWindow("sj_matchmaking_ready_button")
	-- mywindow:setVisible(false)
	mywindow:setEnabled(false)
	WndMatchMaking_Ready()
end

startPosX = 448
changePosY = 134
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_matchmaking_ready_time1")
mywindow:setTexture("Enabled", "UIData/MatchMakingRoom3.tga", 1, 225)
mywindow:setWideType(6)
mywindow:setPosition(startPosX, changePosY)
mywindow:setSize(76, 96)
-- mywindow:setEnabled(false)
mywindow:setVisible(true)
mConfirmWindow:addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_matchmaking_ready_time2")
mywindow:setTexture("Enabled", "UIData/MatchMakingRoom3.tga", 1, 225)
mywindow:setWideType(6)
mywindow:setPosition(startPosX + 52, changePosY)
mywindow:setSize(76, 96)
-- mywindow:setEnabled(false)
mywindow:setVisible(true)
mConfirmWindow:addChildWindow(mywindow)

tick = 1
-- yyyyy = -screenOffsetX
-- speed = 100
-- amp = 50
-- freq = 2
side = 0
charMX = 100
char1X = 0
acc = 16
delay = 16
offset = 0
tick = 0
a = 0
anim_mode = 1
function WndMatchMaking_Ready_RenderTime(sec)
	tTime = { ["err"]=0, [0]=1, 78, 155, 232, 309, 386, 463, 540, 617, 694 }

	-- local startPos1	= 445
	-- local startPos2	= startPos1 + 58
	-- local changePosY = 134
	if sec > 0 then
		mywindow = winMgr:getWindow("sj_matchmaking_ready_time1")
		mywindow:setTexture("Enabled", "UIData/MatchMakingRoom3.tga", tTime[sec/10], 927);
		mywindow = winMgr:getWindow("sj_matchmaking_ready_time2")
		mywindow:setTexture("Enabled", "UIData/MatchMakingRoom3.tga", tTime[sec%10], 927);
	end

	-- mywindow = winMgr:getWindow("sj_matchmaking_ready_timebox")
	-- mywindow:setScaleWidth(300)
	-- mywindow:setPosition(252, 140)
	-- angle = math.fmod(tick, 360)
	-- sin = math.sin(angle) + 0.0
	-- yyyyy = amp * math.sin(freq * tick)
	-- animOffset = sin * 10000.0
	
	-- readychar1 = winMgr:getWindow("sj_matchmaking_char1")
	-- if readychar1 ~= '' then
	-- 	readychar1:setPosition(500,500)
	-- end
	-- readychar2 = winMgr:getWindow("sj_matchmaking_char2")
	-- readychar2:setPosition(-screenOffsetX+1084 + (animOffset), -screenOffsetY)

	WndMatchMaking_Ready_RenderPlayer()
	-- drawRank(math.fmod(50, 36), 797+10, 532+12, 240)
	-- mConfirmWindow:setVisible(false)
	-- drawer:setFont(g_STRING_FONT_GULIMCHE, 18)
	-- drawer:setTextColor(255, 206, 81, 255)
	-- drawer:drawText(tostring(0.5), 930, 557, WIDETYPE_6)

	-- drawer:drawTexture("UIData/MatchMakingRoom3.tga", startPos1, changePosY, 76, 96, tTime[sec/10], 927, 6)
	-- drawer:drawTexture("UIData/MatchMakingRoom3.tga", startPos2, changePosY, 76, 96, tTime[sec%10], 927, 6)

	if anim_mode == 1 then
		acc = acc + 3
		if side == 0 then
			offset = offset + acc + 10
		else
			offset = offset - acc - 10
		end

		if offset > 100000 then
			side = 1
			acc = 40
		end
		if offset < 0 then
			side = 0
			acc = 40
		end

		readychar1:setPosition(-screenOffsetX + (offset / 4000), -screenOffsetY + (offset / 10000))
		readychar2:setPosition(-screenOffsetX+1084 - (offset / 4000), -screenOffsetY - (offset / 10000))

		if winMgr:getWindow("wndtest_debug1") ~= '' then
			winMgr:getWindow("wndtest_debug1"):setText(tostring(offset))
		end
		if winMgr:getWindow("wndtest_debug2") ~= '' then
			winMgr:getWindow("wndtest_debug2"):setText(tostring(acc))
		end
		-- readychar1:setAngle((offset / 40000))
		-- readychar2:setAngle(-(offset / 40000))
	end

	if anim_mode == 2 then
		readychar1:setScaleWidth(-255)
		readychar1:setAlpha(255 - (offset / 100 / 3))
		readychar1:setPosition(-screenOffsetX+1750-0 - (offset / 1000), -screenOffsetY+200 + (offset / 10000))
		readychar2:setPosition(-screenOffsetX+1084-0 + (offset / 500), -screenOffsetY - (offset / 50000))
		-- readychar1:setPosition(-screenOffsetX+1700-0 - (offset / 500), -screenOffsetY+170 + (offset / 10000))
		-- readychar2:setPosition(-screenOffsetX+1084-0 + (offset / 1000), -screenOffsetY - (offset / 50000))
		-- readychar1:setPosition(-screenOffsetX+1700-0 - (offset / 10), -screenOffsetY+200 + (offset / 10))
		-- readychar2:setPosition(-screenOffsetX+1084-0 + (offset / 100), -screenOffsetY + (offset / 500))

		tick = tick + 1
		if tick > 10 then
			offset = 50000
			tick = 0
		end

		if offset > 0 then
			offset = offset / 6
		end
	end

	-- ShowFadeIn(alpha, 255)
	
	-- ShowFadeIn(255, tick)
	-- tick = tick - 1
	-- if tick <= 0 then
	-- 	if side == 0 then
	-- 		offset = offset + 1
	-- 	else
	-- 		offset = offset - 1
	-- 	end

	-- 	tick = delay
	-- end

	-- if delay > 0 then
	-- 	a = a + 1
	-- 	if delay == 2 and a > 1000 then
	-- 		a = 0
	-- 		delay = delay - 1
	-- 	else
	-- 		delay = delay - 1
	-- 	end
	-- else
	-- 	if side == 0 then
	-- 		side = 1
	-- 	else
	-- 		side = 0
	-- 	end
	-- 	delay = 16
	-- 	-- acc = 5
	-- end
end

local penaltySize1 = GetStringSize(g_STRING_FONT_GULIMCHE, 20, tostring("Penalty Time"))
local penaltySize2 = GetStringSize(g_STRING_FONT_GULIMCHE, 44, tostring("15"))
local penaltyTextY = 15

mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_matchmaking_penalty_text")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")


mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 20)
mywindow:setText("Penalty Time")

mywindow:setWideType(6);
mywindow:setPosition(688 + 160 - (penaltySize1 / 2), 568 + 16 + penaltyTextY)
mywindow:setSize(200, 0)
mywindow:setEnabled(false)
mywindow:setVisible(false)
-- mywindow:setZOrderingEnabled(false)
-- mywindow:setAlwaysOnTop(true)
root:addChildWindow(mywindow)

-- mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_matchmaking_penalty_time")
-- mywindow:setProperty("FrameEnabled", "false")
-- mywindow:setProperty("BackgroundEnabled", "false")


-- mywindow:setTextColor(255, 255, 255, 255)
-- mywindow:setFont(g_STRING_FONT_GULIMCHE, 44)
-- mywindow:setText("14")

-- mywindow:setWideType(6)
-- mywindow:setPosition(688 + 160 - (penaltySize2 / 2), 568 + 38 + penaltyTextY)
-- mywindow:setSize(200, 0)
-- mywindow:setEnabled(false)
-- mywindow:setVisible(false)
-- -- mywindow:setZOrderingEnabled(false)
-- -- mywindow:setAlwaysOnTop(true)
-- root:addChildWindow(mywindow)

startPosX = 688 + 105
startPosX2 = startPosX + 48
-- startPosX2 = startPosX2 + 52
changePosY = 568 + 28 + penaltyTextY
-- startPosX = 688 + 120
-- changePosY = 568 + 18 + penaltyTextY

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_matchmaking_penalty_time1")
mywindow:setTexture("Enabled", "UIData/MatchMakingRoom1.tga", 3, 943)
mywindow:setWideType(6)
mywindow:setPosition(startPosX, changePosY)
mywindow:setSize(62, 78)
-- mywindow:setEnabled(false)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
root:addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_matchmaking_penalty_time2")
mywindow:setTexture("Enabled", "UIData/MatchMakingRoom1.tga", 3, 943)
mywindow:setWideType(6)
mywindow:setPosition(startPosX2, changePosY)
mywindow:setSize(62, 78)
-- mywindow:setEnabled(false)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
root:addChildWindow(mywindow)

function WndMatchMaking_DrawPenaltyTime(sec)
	startButtonWindow = winMgr:getWindow("sj_matchmaking_startAndReadyBtn")
	startButtonWindow:setEnabled(sec <= 0)

	mywindow = winMgr:getWindow("sj_matchmaking_penalty_text")
	mywindow:setVisible(sec > 0)

	mywindow = winMgr:getWindow("sj_matchmaking_penalty_time1")
	mywindow:setVisible(sec > 0)

	mywindow = winMgr:getWindow("sj_matchmaking_penalty_time2")
	mywindow:setVisible(sec > 0)

	-- tTime = { ["err"]=0, [0]=1, 78, 155, 232, 309, 386, 463, 540, 617, 694 }
	tTime = { ["err"]=0, [0]=3, 67, 131, 195, 259, 325, 391, 457, 523, 589 }

	if sec > 0 then
		mywindow = winMgr:getWindow("sj_matchmaking_penalty_time1")
		-- mywindow:setTexture("Enabled", "UIData/MatchMakingRoom3.tga", tTime[sec/10], 927);
		mywindow:setTexture("Enabled", "UIData/MatchMakingRoom1.tga", tTime[sec/10], 943);
		mywindow = winMgr:getWindow("sj_matchmaking_penalty_time2")
		-- mywindow:setTexture("Enabled", "UIData/MatchMakingRoom3.tga", tTime[sec%10], 927);
		mywindow:setTexture("Enabled", "UIData/MatchMakingRoom1.tga", tTime[sec%10], 943);
	end
	-- mywindow = winMgr:getWindow("sj_matchmaking_penalty_time")
	-- mywindow:setVisible(sec > 0)

	-- local penaltySize2 = GetStringSize(g_STRING_FONT_GULIMCHE, 44, tostring(sec))
	-- mywindow:setText(tostring(sec))
	-- mywindow:setPosition(688 + 160 - (penaltySize2 / 2), 568 + 38 + penaltyTextY)

	-- drawer:setFont(g_STRING_FONT_GULIMCHE, 44);
	-- drawer:setTextColor(255, 255, 255, 255)
	-- drawer:drawText(tostring(sec), 688 + 160, 568 + 38)
end


-- DEBUG READER TIME
-- local startPos1	= 445
-- local startPos2	= startPos1 + 58
-- local changePosY = 134
-- mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_matchmaking_ready_time1")
-- mywindow:setTexture("Enabled", "UIData/MatchMakingRoom3.tga", 309, 927)
-- mywindow:setPosition(startPos1, changePosY)
-- mywindow:setSize(76, 96)
-- mywindow:setVisible(true)
-- mywindow:setAlwaysOnTop(true)
-- mywindow:setZOrderingEnabled(false)
-- root:addChildWindow(mywindow)
-- mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_matchmaking_ready_time2")
-- mywindow:setTexture("Enabled", "UIData/MatchMakingRoom3.tga", 1, 927)
-- mywindow:setPosition(startPos2, changePosY)
-- mywindow:setSize(76, 96)
-- mywindow:setVisible(true)
-- mywindow:setAlwaysOnTop(true)
-- mywindow:setZOrderingEnabled(false)
-- root:addChildWindow(mywindow)