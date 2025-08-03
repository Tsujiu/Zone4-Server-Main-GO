-----------------------------------------
-- Script Entry Point
-----------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)


g_tEscEventWindow_toBattleRoom	= { ["err"]=0 }
g_tEscEventFunction_toBattleRoom = { ["err"]=0 }

local g_STRING_INVITE_1 = PreCreateString_1134	--GetSStringInfo(LAN_LUA_WND_BR_INVITE_1)	-- 초대할 유저를 먼저 선택하세요
local g_STRING_INVITE_2 = PreCreateString_1135	--GetSStringInfo(LAN_LUA_WND_BR_INVITE_2)	-- %님에게 초대메세지를 보냈습니다.


-- 룸, 유저 최대 페이지를 얻는다.
local MAX_USERPAGE = WndMatchMaking_GetMaxUserPages()


--------------------------------------------------------------------

-- 백그라운드 알파 이미지

--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_matchmaking_alphaWindow")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)




--------------------------------------------------------------------

-- 초대하기

--------------------------------------------------------------------
invitewindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_matchmaking_inviteAdjustWindow")
invitewindow:setTexture("Enabled", "UIData/LobbyImage_new.tga", 671, 425)
invitewindow:setTexture("Disabled", "UIData/LobbyImage_new.tga", 671, 425)
invitewindow:setProperty("FrameEnabled", "False")
invitewindow:setProperty("BackgroundEnabled", "False")
invitewindow:setWideType(6);
invitewindow:setPosition(350, 130)
invitewindow:setSize(331, 453)
invitewindow:setVisible(false)
invitewindow:setAlwaysOnTop(true)
invitewindow:setZOrderingEnabled(false)
root:addChildWindow(invitewindow)

-- 파티 매치 ESC키 등록
RegistEscEventInfo("sj_matchmaking_inviteAdjustWindow", "Invite_CANCEL")


-- 현재 유저 / 최대 유저
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_matchmaking_inviteUserList")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 16)
mywindow:setText("")
mywindow:setPosition(141, 420)
mywindow:setSize(40, 20)
mywindow:setZOrderingEnabled(false)
invitewindow:addChildWindow(mywindow)

function WndMatchMaking_InviteUserPageInfo(curUser, maxUser)
	local userText = tostring((curUser+1).." / "..(maxUser+1))
	local size = GetStringSize(g_STRING_FONT_GULIMCHE, 16, userText)	
	winMgr:getWindow("sj_matchmaking_inviteUserList"):setText(userText)
	winMgr:getWindow("sj_matchmaking_inviteUserList"):setPosition(170-size/2, 394)
end




for i=0, MAX_USERPAGE-1 do
	-- 1. 유저 리스트(라디오 버튼) 생성
	userwindow = winMgr:createWindow("TaharezLook/RadioButton", i .. "sj_matchmaking_inviteUser_RadioBtn")
	userwindow:setTexture("Normal", "UIData/invisible.tga", 0, 0)
	userwindow:setTexture("Hover", "UIData/LobbyImage_new.tga", 312, 937)
	userwindow:setTexture("Pushed", "UIData/LobbyImage_new.tga", 312, 962)
	userwindow:setTexture("PushedOff", "UIData/LobbyImage_new.tga", 0, 0)
	userwindow:setTexture("SelectedNormal", "UIData/LobbyImage_new.tga", 312, 962)
	userwindow:setTexture("SelectedHover", "UIData/LobbyImage_new.tga", 312, 962)
	userwindow:setTexture("SelectedPushed", "UIData/LobbyImage_new.tga", 312, 962)
	userwindow:setTexture("SelectedPushedOff", "UIData/LobbyImage_new.tga", 312, 962)
	userwindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	userwindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	userwindow:setTexture("SelectedEnabled", "UIData/invisible.tga", 0, 0)
	userwindow:setTexture("SelectedDisabled", "UIData/invisible.tga", 0, 0)
	userwindow:setPosition(11, 78+(i*32))
	userwindow:setSize(308, 23)
	userwindow:setProperty("GroupID", 700)
	userwindow:setZOrderingEnabled(false)
	userwindow:setUserString("UserNumber", i)
	userwindow:subscribeEvent("MouseDoubleClicked", "Invite_OK")
	invitewindow:addChildWindow(userwindow)
	

	-- 2. 유저 레벨
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_matchmaking_inviteUser_level")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(5, 3)
	mywindow:setSize(40, 20)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)	-- 선택해도 다른것들이 선택되게
	userwindow:addChildWindow(mywindow)


	-- 3. 유저 이름
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_matchmaking_inviteUser_name")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(52, 3)
	mywindow:setSize(40, 20)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	userwindow:addChildWindow(mywindow)
	
	-- 4. 유저 스타일
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_matchmaking_inviteUser_style")
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
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_matchmaking_inviteUser_ladder")
	mywindow:setTexture("Enabled", "UIData/numberUi001.tga", 113, 600)
	mywindow:setTexture("Disabled", "UIData/numberUi001.tga", 113, 600)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(64, 2)
	mywindow:setSize(47, 21)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	userwindow:addChildWindow(mywindow)
	
	-- 6. 유저 클럽
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i .. "sj_matchmaking_inviteUser_club")
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

end



-- 유저가 없을때
function WndMatchMaking_ClearInviteUserList()
	for i=0, MAX_USERPAGE-1 do
		winMgr:getWindow(i .. "sj_matchmaking_inviteUser_RadioBtn"):setVisible(false)
		winMgr:getWindow(i .. "sj_matchmaking_inviteUser_level"):setVisible(false)
		winMgr:getWindow(i .. "sj_matchmaking_inviteUser_name"):setVisible(false)
		winMgr:getWindow(i .. "sj_matchmaking_inviteUser_style"):setVisible(false)
		winMgr:getWindow(i .. "sj_matchmaking_inviteUser_ladder"):setVisible(false)
		winMgr:getWindow(i .. "sj_matchmaking_inviteUser_club"):setVisible(false)
	end
end




-- 유저가 있을때
function WndMatchMaking_ExistInviteUser(index, realIndex, level, ladder, style, userName, userClub, promotion, attribute, bEnable)

	DebugStr('bEnable:'..bEnable)
	if bEnable == 0 then
		winMgr:getWindow(index .. "sj_matchmaking_inviteUser_RadioBtn"):setEnabled(false)
		winMgr:getWindow(index .. "sj_matchmaking_inviteUser_level"):setTextColor(170, 170, 170, 255)
		winMgr:getWindow(index .. "sj_matchmaking_inviteUser_name"):setTextColor(170, 170, 170, 255)
	else
		winMgr:getWindow(index .. "sj_matchmaking_inviteUser_RadioBtn"):setEnabled(true)
		winMgr:getWindow(index .. "sj_matchmaking_inviteUser_level"):setTextColor(255, 255, 255, 255)
		winMgr:getWindow(index .. "sj_matchmaking_inviteUser_name"):setTextColor(255, 255, 255, 255)
	end
	
	winMgr:getWindow(index .. "sj_matchmaking_inviteUser_RadioBtn"):setVisible(true)
	winMgr:getWindow(index .. "sj_matchmaking_inviteUser_RadioBtn"):setUserString("UserNumber", realIndex)
	winMgr:getWindow(index .. "sj_matchmaking_inviteUser_level"):setVisible(true)
	winMgr:getWindow(index .. "sj_matchmaking_inviteUser_name"):setVisible(true)
	winMgr:getWindow(index .. "sj_matchmaking_inviteUser_style"):setVisible(true)
	winMgr:getWindow(index .. "sj_matchmaking_inviteUser_ladder"):setVisible(true)
	winMgr:getWindow(index .. "sj_matchmaking_inviteUser_club"):setVisible(true)
	
	
	-- 2. 유저 레벨
	local levelSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(level))
	winMgr:getWindow(index .. "sj_matchmaking_inviteUser_level"):setText(tostring(level))
	winMgr:getWindow(index .. "sj_matchmaking_inviteUser_level"):setPosition(46-levelSize/2, 3)
	
	
	-- 3. 유저 이름
	local nameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, userName)
	winMgr:getWindow(index .. "sj_matchmaking_inviteUser_name"):setText(userName)
	winMgr:getWindow(index .. "sj_matchmaking_inviteUser_name"):setPosition(182-nameSize/2, 2)
	
	
	-- 4. 유저 스타일
	winMgr:getWindow(index .. "sj_matchmaking_inviteUser_style"):setTexture("Disabled", "UIData/Skill_up2.tga", tAttributeImgTexXTable[style][attribute], tAttributeImgTexYTable[style][attribute])
	winMgr:getWindow(index .. "sj_matchmaking_inviteUser_style"):setTexture("Layered", "UIData/Skill_up2.tga", promotionImgTexXTable[style], promotionImgTexYTable[promotion])
	winMgr:getWindow(index .. "sj_matchmaking_inviteUser_style"):setScaleWidth(190)
	winMgr:getWindow(index .. "sj_matchmaking_inviteUser_style"):setScaleHeight(190)
	
	
	-- 5. 유저 래더
	winMgr:getWindow(index .. "sj_matchmaking_inviteUser_ladder"):setTexture("Disabled", "UIData/numberUi001.tga", 113, 600+21*ladder)
	
	-- 6. 유저 클럽
	if userClub == "" then
		winMgr:getWindow(index .. "sj_matchmaking_inviteUser_club"):setText("-")
	else
	end
end





--------------------------------------------------------------------

-- 유저 정보(채널, 친구, 클럽) 라디오 버튼

--------------------------------------------------------------------
--[[
tUserInfoName = { ["protectErr"]=0, [0]="sj_matchmaking_invite_channel", "sj_matchmaking_invite_friend", "sj_matchmaking_invite_club" }
tUserInfoTexX = { ["protectErr"]=0, [0]=667, 763, 859 }
tUserInfoPosX = { ["protectErr"]=0, [0]=3, 99, 195 }

for i=0, 2 do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tUserInfoName[i])
	mywindow:setTexture("Normal", "UIData/LobbyImage_new.tga", tUserInfoTexX[i], 344)
	mywindow:setTexture("Hover", "UIData/LobbyImage_new.tga", tUserInfoTexX[i], 311)
	mywindow:setTexture("Pushed", "UIData/LobbyImage_new.tga", tUserInfoTexX[i], 278)
	mywindow:setTexture("PushedOff", "UIData/LobbyImage_new.tga", tUserInfoTexX[i], 344)
	mywindow:setTexture("SelectedNormal", "UIData/LobbyImage_new.tga", tUserInfoTexX[i], 278)
	mywindow:setTexture("SelectedHover", "UIData/LobbyImage_new.tga", tUserInfoTexX[i], 278)
	mywindow:setTexture("SelectedPushed", "UIData/LobbyImage_new.tga", tUserInfoTexX[i], 278)
	mywindow:setTexture("SelectedPushedOff", "UIData/LobbyImage_new.tga", tUserInfoTexX[i], 278)
	mywindow:setPosition(tUserInfoPosX[i], 43)
	mywindow:setSize(96, 33)
	mywindow:setZOrderingEnabled(false)
	mywindow:setProperty("GroupID", 1602)
	mywindow:setUserString("userInfoList", i)
	mywindow:subscribeEvent("SelectStateChanged", "ChangeUserInfoList")
	
	if i == 0 then
		mywindow:setEnabled(true)
	else
		mywindow:setEnabled(false)
	end
	invitewindow:addChildWindow(mywindow)
end


function ChangeUserInfoList()
	local userList
	for i=0, 2 do
		if CEGUI.toRadioButton(winMgr:getWindow(tUserInfoName[i])):isSelected() then
			userList = winMgr:getWindow(tUserInfoName[i]):getUserString("userInfoList")
		end
	end
	WndMatchMaking_ChangeUserInfoList(tonumber(userList))
	for i=0, MAX_USERPAGE-1 do
		winMgr:getWindow(i .. "sj_matchmaking_inviteUser_RadioBtn"):setProperty("Selected", "false")
	end
end


function SelectCurrentUserInfoList()
	local userList = WndMatchMaking_GetUserInfoList()
	winMgr:getWindow(tUserInfoName[userList]):setProperty("Selected", "true")
end
SelectCurrentUserInfoList()
--]]



--------------------------------------------------------------------

-- 유저 리스트 변경 좌, 우 버튼

--------------------------------------------------------------------
local tUserListLRButtonName  = {["err"]=0, [0]="sj_matchmaking_inviteUser_LBtn", "sj_matchmaking_inviteUser_RBtn"}
local tUserListLRButtonTexX  = {["err"]=0, [0]=987, 970}
local tUserListLRButtonPosX  = {["err"]=0, [0]=106, 218}
local tUserListLRButtonEvent = {["err"]=0, [0]="ChagneInviteUserList_L", "ChagneInviteUserList_R"}
for i=0, #tUserListLRButtonName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tUserListLRButtonName[i])
	mywindow:setTexture("Normal", "UIData/myinfo.tga", tUserListLRButtonTexX[i], 0)
	mywindow:setTexture("Hover", "UIData/myinfo.tga", tUserListLRButtonTexX[i], 22)
	mywindow:setTexture("Pushed", "UIData/myinfo.tga", tUserListLRButtonTexX[i], 44)
	mywindow:setTexture("PushedOff", "UIData/myinfo.tga", tUserListLRButtonTexX[i], 0)
	mywindow:setPosition(tUserListLRButtonPosX[i], 394)
	mywindow:setSize(17, 22)
	mywindow:setSubscribeEvent("Clicked", tUserListLRButtonEvent[i])
	invitewindow:addChildWindow(mywindow)
end


-- 룸리스트를 변경한후 그 페이지의 정보를 셋팅해야 한다.
function ChagneInviteUserList_L()
	local currUserNum = WndMatchMaking_GetCurrentUserPage()
	if currUserNum > 0 then
		currUserNum = currUserNum - 1
	end
	WndMatchMaking_GetInviteUserList(tonumber(currUserNum))
end


function ChagneInviteUserList_R()
	local currUserNum = WndMatchMaking_GetCurrentUserPage()
	local maxUserNum  = WndMatchMaking_GetMaxUserPage()
	if currUserNum < maxUserNum then
		currUserNum = currUserNum + 1
	end
	WndMatchMaking_GetInviteUserList(tonumber(currUserNum))
end





--------------------------------------------------------------------

-- 초대하기 확인, 취소버튼

--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_matchmaking_invite_okBtn")
mywindow:setTexture("Normal", "UIData/LobbyImage_new.tga", 665, 280)
mywindow:setTexture("Hover", "UIData/LobbyImage_new.tga", 665, 309)
mywindow:setTexture("Pushed", "UIData/LobbyImage_new.tga", 665, 338)
mywindow:setTexture("PushedOff", "UIData/LobbyImage_new.tga", 665, 280)
mywindow:setPosition(6, 421)
mywindow:setSize(319, 29)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:subscribeEvent("Clicked", "Invite_OK")
invitewindow:addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/Button", "sj_matchmaking_invite_cancleBtn")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setPosition(299, 6)
mywindow:setSize(23, 23)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "Invite_CANCEL")
invitewindow:addChildWindow(mywindow)


-- 초대하기 OK를 누르면 유저가 선택이 되어있는지 확인후 초대메세지를 보낸다.
function Invite_OK()
	local bSelect = false
	local userNumber
	for i=0, MAX_USERPAGE-1 do
		if CEGUI.toRadioButton(winMgr:getWindow(i .. "sj_matchmaking_inviteUser_RadioBtn")):isSelected() then
			bSelect = true
			userNumber = winMgr:getWindow(i .. "sj_matchmaking_inviteUser_RadioBtn"):getUserString("UserNumber")
		end
	end
	
	-- 유저라디오 버튼이 선택이 되어 있으면 초대메세지를 보내고 선택되어있는 라디오 버튼을 해제한다.
	if bSelect == true then
		Invite_CANCEL()
	
		local inviteUserName = WndMatchMaking_SendInviteMessage(userNumber)
		winMgr:getWindow(userNumber .. "sj_matchmaking_inviteUser_RadioBtn"):setProperty("Selected", "false")
		
		if IsKoreanLanguage() then
			WndMatchMaking_WarningMessageEx(inviteUserName, '님에게', '초대메세지를 보냈습니다.');
		else
			WndMatchMaking_WarningMessage(string.format(g_STRING_INVITE_2, inviteUserName))
		end
		
	else
		
		ShowNotifyOKMessage_Lua(g_STRING_INVITE_1)
	end
end



-- 초대하기 취소버튼을 누르면 초대창을 닫고 더이상 유저정보를 받지 않는다.
function Invite_CANCEL()

	WndMatchMaking_CloseInvite()
	
	winMgr:getWindow("sj_matchmaking_alphaWindow"):setVisible(false)
	winMgr:getWindow("sj_matchmaking_inviteAdjustWindow"):setVisible(false)
end




--------------------------------------------------------------------

-- 랜덤 초대 버튼

--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_matchmaking_invite_randomBtn")
mywindow:setTexture("Normal", "UIData/popup001.tga", 944, 689)
mywindow:setTexture("Hover", "UIData/popup001.tga", 944, 723)
mywindow:setTexture("Pushed", "UIData/popup001.tga", 944, 757)
mywindow:setTexture("PushedOff", "UIData/popup001.tga", 944, 689)
mywindow:setPosition(108, 488)
mywindow:setSize(80, 34)
mywindow:setZOrderingEnabled(false)
mywindow:setVisible(false)
mywindow:subscribeEvent("Clicked", "Invite_Random")
invitewindow:addChildWindow(mywindow)


function Invite_Random()
	Invite_CANCEL()
end









--------------------------------------------------------------------

-- 방설정

--------------------------------------------------------------------
-- 방설정 셋팅창
roomsetupwindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_matchmaking_roomAdjustWindow")
roomsetupwindow:setTexture("Enabled", "UIData/popup001.tga", 0, 0)
roomsetupwindow:setTexture("Disabled", "UIData/popup001.tga", 0, 0)
roomsetupwindow:setProperty("FrameEnabled", "False")
roomsetupwindow:setProperty("BackgroundEnabled", "False")
roomsetupwindow:setWideType(6);
roomsetupwindow:setPosition(338, 200)
roomsetupwindow:setSize(346, 270)
roomsetupwindow:setVisible(false)
roomsetupwindow:setAlwaysOnTop(true)
roomsetupwindow:setZOrderingEnabled(false)
root:addChildWindow(roomsetupwindow)

-- 배틀룸 방설정 셋팅창 ESC키, ENTER키 등록
RegistEscEventInfo("sj_matchmaking_roomAdjustWindow", "RoomSetup_CANCEL")
RegistEnterEventInfo("sj_matchmaking_roomAdjustWindow", "RoomSetup_OK")

-- "방설정" 글자
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_matchmaking_roomAdjust_title")
mywindow:setTexture("Enabled", "UIData/popup001.tga", 0, 734)
mywindow:setTexture("Disabled", "UIData/popup001.tga", 0, 734)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 2)
mywindow:setSize(346, 35)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
roomsetupwindow:addChildWindow(mywindow)

-- 방제목, 비밀번호
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_matchmaking_roomAdjust_roomNameAndpassword")
mywindow:setTexture("Enabled", "UIData/option.tga", 656, 120)
mywindow:setTexture("Disabled", "UIData/option.tga", 656, 120)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(6, 45)
if IsKoreanLanguage() then
	mywindow:setSize(328, 36)
else
	mywindow:setSize(328, 70)
end
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
roomsetupwindow:addChildWindow(mywindow)

-- 인원설정
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_matchmaking_roomAdjust_userNum")
mywindow:setTexture("Enabled", "UIData/option.tga", 656, 346)
mywindow:setTexture("Disabled", "UIData/option.tga", 656, 346)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(6, 126)
mywindow:setSize(328, 30)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
roomsetupwindow:addChildWindow(mywindow)

-- 제한시간
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_matchmaking_roomAdjust_limitTime")
mywindow:setTexture("Enabled", "UIData/option.tga", 944, 457)
mywindow:setTexture("Disabled", "UIData/option.tga", 944, 457)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(16, 176)
mywindow:setSize(80, 20)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
roomsetupwindow:addChildWindow(mywindow)

if WndMatchMaking_GetGameMode() == 8 then
	winMgr:getWindow("sj_matchmaking_roomAdjust_limitTime"):setVisible(false)
elseif WndMatchMaking_GetItemMode() == 3 or WndMatchMaking_GetItemMode() == 4 or WndMatchMaking_GetItemMode() == 5 then
	winMgr:getWindow("sj_matchmaking_roomAdjust_limitTime"):setVisible(false)
else
	winMgr:getWindow("sj_matchmaking_roomAdjust_limitTime"):setVisible(true)
end



------------------------------------------------------

-- 방만들기 확인, 방만들기 취소버튼

------------------------------------------------------

-- 방설정 확인버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_matchmaking_roomAdjust_okBtn")
mywindow:setTexture("Normal", "UIData/popup001.tga", 693, 617)
mywindow:setTexture("Hover", "UIData/popup001.tga", 693, 646)
mywindow:setTexture("Pushed", "UIData/popup001.tga", 693, 675)
mywindow:setTexture("PushedOff", "UIData/popup001.tga", 693, 617)
mywindow:setPosition(4, 235)
mywindow:setSize(331, 29)
mywindow:setAlwaysOnTop(true)
mywindow:subscribeEvent("Clicked", "RoomSetup_OK")
roomsetupwindow:addChildWindow(mywindow)

function RoomSetup_OK()
	RoomSetup_CANCEL()
	
	roomName	 = winMgr:getWindow("sj_matchmaking_roomAdjust_roomTitleWindow"):getText()
	roomPassword = ""	
	if IsKoreanLanguage() == false then
		roomPassword = winMgr:getWindow("sj_matchmaking_roomAdjust_passwordWindow"):getText()
	end
	WndMatchMaking_ChangeRoomSetup(nMaxUser, nKillCount, nTimeLimit, roomName, roomPassword)
end


-- 방설정 취소버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_matchmaking_roomAdjust_cancelBtn")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setPosition(308, 6)
mywindow:setSize(23, 23)
mywindow:setAlwaysOnTop(true)
mywindow:subscribeEvent("Clicked", "RoomSetup_CANCEL")
roomsetupwindow:addChildWindow(mywindow)

function RoomSetup_CANCEL()
	winMgr:getWindow("sj_matchmaking_alphaWindow"):setVisible(false)
	winMgr:getWindow("sj_matchmaking_roomAdjustWindow"):setVisible(false)
	
	-- 방설정을 누르면 채팅창을 활성화 시킨다
	winMgr:getWindow("doChatting"):activate()
end





------------------------------------------------------

-- 방변경 정보(4개)

------------------------------------------------------
-- 1. 방설정 방제목
mywindow = winMgr:createWindow("TaharezLook/Editbox", "sj_matchmaking_roomAdjust_roomTitleWindow")
mywindow:setPosition(106, 8)
mywindow:setSize(204, 22)
mywindow:setFont(g_STRING_FONT_GULIM, 12)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setText("")
mywindow:subscribeEvent("TextAccepted", "RoomSetup_OK")
winMgr:getWindow("sj_matchmaking_roomAdjust_roomNameAndpassword"):addChildWindow(mywindow)
CEGUI.toEditbox(winMgr:getWindow("sj_matchmaking_roomAdjust_roomTitleWindow")):setMaxTextLength(32)


-- 2. 방설정 비밀번호
if IsKoreanLanguage() == false then
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_matchmaking_roomAdjust_passwordWindow")
	mywindow:setPosition(106, 43)
	mywindow:setSize(113, 22)
	mywindow:setFont(g_STRING_FONT_GULIM, 12)
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:subscribeEvent("TextAccepted", "RoomSetup_OK")
	winMgr:getWindow("sj_matchmaking_roomAdjust_roomNameAndpassword"):addChildWindow(mywindow)
end



-- 3. 방설정 인원설정
tPersons_team	 = { ["protecterr"]=0, [4]=882, [6]=910, [8]=938 }
tPersons_private = { ["protecterr"]=0, 0, 826, 854, 882, 910, 938, 966, 994 }
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_matchmaking_roomAdjust_userNumImage")
mywindow:setTexture("Enabled", "UIData/battleroom001.tga", 680, 938)
mywindow:setTexture("Disabled", "UIData/battleroom001.tga", 680, 938)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(154, 5)
mywindow:setSize(102, 26)
mywindow:setEnabled(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("sj_matchmaking_roomAdjust_userNum"):addChildWindow(mywindow)



-- 4. 방설정 제한시간
tLimitTimeImage = { ["err"]=0, 826, 854 }
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_matchmaking_roomAdjust_limitTimeImage")
mywindow:setTexture("Enabled", "UIData/battleroom001.tga", 680, 854)
mywindow:setTexture("Disabled", "UIData/battleroom001.tga", 680, 854)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(144, 0)
mywindow:setSize(102, 26)
mywindow:setEnabled(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("sj_matchmaking_roomAdjust_limitTime"):addChildWindow(mywindow)





--------------------------------------------------------------

-- 인원설정, 목표설정, 시간설정 L, R 버튼

--------------------------------------------------------------
tLRButtonName  = { ["protecterr"]=0, { ["protecterr"]=0, "sj_matchmaking_roomAdjust_userNum_LBtn", "sj_matchmaking_roomAdjust_userNum_RBtn" }, 
				 { ["protecterr"]=0, "sj_matchmaking_roomAdjust_limittime_LBtn", "sj_matchmaking_roomAdjust_limittime_RBtn" } }
tLRButtonTexX  = { ["protecterr"]=0, 987, 970 }
tLRButtonPosX  = { ["protecterr"]=0, 134, 270 }
tLRButtonPosY  = { ["protecterr"]=0, 134, 177 }
tLRButtonEvent = { ["protecterr"]=0, { ["protecterr"]=0, "ChangeLUserNum", "ChangeRUserNum" }, 
				 { ["protecterr"]=0, "ChangeLTimeNum", "ChangeRTimeNum" } }

for i=1, 2 do
for j=1, 2 do
	mywindow = winMgr:createWindow("TaharezLook/Button", tLRButtonName[i][j])
	mywindow:setTexture("Normal", "UIData/myinfo.tga", tLRButtonTexX[j], 0)
	mywindow:setTexture("Hover", "UIData/myinfo.tga", tLRButtonTexX[j], 22)
	mywindow:setTexture("Pushed", "UIData/myinfo.tga", tLRButtonTexX[j], 44)
	mywindow:setTexture("PushedOff", "UIData/myinfo.tga", tLRButtonTexX[j], 0)
	mywindow:setPosition(tLRButtonPosX[j], tLRButtonPosY[i])
	mywindow:setSize(17, 22)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", tLRButtonEvent[i][j])
	roomsetupwindow:addChildWindow(mywindow)
	
	if WndMatchMaking_GetGameMode() == 8 then
		if i == 2 then
			if j == 1 or j == 2 then
				mywindow:setVisible(false)
			end
		end
	elseif WndMatchMaking_GetItemMode() == 3 or WndMatchMaking_GetItemMode() == 4 or WndMatchMaking_GetItemMode() == 5 then -- 폭탄전, 미니타워전
		mywindow:setVisible(false)
	else
		mywindow:setVisible(true)
	end
end
end

------------------------------

-- 인원설정

------------------------------
function ChangeLUserNum()
	if bTeam == 1 then
		-- 대장전일 경우
		if WndMatchMaking_GetGameMode() == 8 or 
			WndMatchMaking_GetItemMode() == 3 or
			WndMatchMaking_GetItemMode() == 4 or
			WndMatchMaking_GetItemMode() == 5 then
			
			if nMaxUser == 6 then nMaxUser = 8
			else nMaxUser = nMaxUser - 2
			end
		else
			if nMaxUser == 4 then nMaxUser = 8
			else nMaxUser = nMaxUser - 2
			end
		end
	else
		if nMaxUser == 2 then nMaxUser = 8
		else nMaxUser = nMaxUser - 1
		end
	end	
	ChangeUser()
end

function ChangeRUserNum()
	if bTeam == 1 then
		-- 대장전일 경우
		if WndMatchMaking_GetGameMode() == 8 or 
			WndMatchMaking_GetItemMode() == 3 or
			WndMatchMaking_GetItemMode() == 4 or
			WndMatchMaking_GetItemMode() == 5 then
			
			if nMaxUser == 8 then nMaxUser = 6
			else nMaxUser = nMaxUser + 2
			end
		else
			if nMaxUser == 8 then nMaxUser = 4
			else nMaxUser = nMaxUser + 2
			end
		end
	else
		if nMaxUser == 8 then nMaxUser = 2
		else nMaxUser = nMaxUser + 1
		end
	end
	ChangeUser()
end

function ChangeUser()
	if bTeam == 1 then
		winMgr:getWindow("sj_matchmaking_roomAdjust_userNumImage"):setTexture("Disabled", "UIData/battleroom001.tga", 680, tPersons_team[nMaxUser])
	else
		winMgr:getWindow("sj_matchmaking_roomAdjust_userNumImage"):setTexture("Disabled", "UIData/battleroom001.tga", 574, tPersons_private[nMaxUser])
	end
end





------------------------------

-- 제한시간

------------------------------
function ChangeLTimeNum()
	if nTimeLimit == 1 then
		nTimeLimit = 2
	elseif nTimeLimit == 2 then
		nTimeLimit = 1
	end
	ChangeLimitTime()
end

function ChangeRTimeNum()
	if nTimeLimit == 2 then
		nTimeLimit = 1
	elseif nTimeLimit == 1 then
		nTimeLimit = 2
	end
	ChangeLimitTime()
end

function ChangeLimitTime()
	-- 대장전일 경우
	if WndMatchMaking_GetGameMode() == 8 then
		winMgr:getWindow("sj_matchmaking_roomAdjust_limitTimeImage"):setVisible(false)
	else
		winMgr:getWindow("sj_matchmaking_roomAdjust_limitTimeImage"):setVisible(true)
		winMgr:getWindow("sj_matchmaking_roomAdjust_limitTimeImage"):setTexture("Disabled", "UIData/battleroom001.tga", 680, tLimitTimeImage[nTimeLimit])
	end
end







--------------------------------------------------------------------

-- 에러메세지(C에서 호출)

--------------------------------------------------------------------
-- 백그라운드 알파 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_matchmaking_error_alphaWindow")
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


-- 에러 보일창
errorwindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_matchmaking_error_backWindow")
errorwindow:setTexture("Enabled", "UIData/popup001.tga", 0, 0)
errorwindow:setTexture("Disabled", "UIData/popup001.tga", 0, 0)
errorwindow:setProperty("FrameEnabled", "False")
errorwindow:setProperty("BackgroundEnabled", "False")
errorwindow:setWideType(6)
errorwindow:setPosition(338, 246)
errorwindow:setSize(346, 275)
errorwindow:setVisible(false)
errorwindow:setAlwaysOnTop(true)
errorwindow:setZOrderingEnabled(false)
root:addChildWindow(errorwindow)

-- 파티 매치 ESC키 등록
RegistEscEventInfo("sj_matchmaking_error_backWindow", "BattleRoomErrorOK")

-- 에러 내용창
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_matchmaking_error_descWindow")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setPosition(0, 126)
mywindow:setSize(349, 100)
mywindow:setAlwaysOnTop(true)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:clearTextExtends()
errorwindow:addChildWindow(mywindow)

-- 에러 확인버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_matchmaking_error_okBtn")
mywindow:setTexture("Normal", "UIData/popup001.tga",693, 617)
mywindow:setTexture("Hover", "UIData/popup001.tga", 693, 646)
mywindow:setTexture("Pushed", "UIData/popup001.tga", 693, 675)
mywindow:setTexture("PushedOff", "UIData/popup001.tga", 693, 704)
mywindow:setPosition(4, 235)
mywindow:setSize(331, 29)
mywindow:setAlwaysOnTop(true)
mywindow:subscribeEvent("Clicked", "BattleRoomErrorOK")
errorwindow:addChildWindow(mywindow)


function BattleRoomErrorOK()
	winMgr:getWindow("sj_matchmaking_error_alphaWindow"):setVisible(false)
	winMgr:getWindow("sj_matchmaking_error_backWindow"):setVisible(false)
	winMgr:getWindow("sj_matchmaking_error_descWindow"):setText("")
	
	-- 에러OK를 누르면 채팅창을 활성화 시킨다
	winMgr:getWindow("doChatting"):setEnabled(true)
end


function WndMatchMaking_WarningMessage(errorMessgae)
	winMgr:getWindow("sj_matchmaking_error_alphaWindow"):setVisible(true)
	winMgr:getWindow("sj_matchmaking_error_backWindow"):setVisible(true)
	winMgr:getWindow("sj_matchmaking_error_descWindow"):setTextExtends(errorMessgae, g_STRING_FONT_GULIMCHE, 14, 255,255,255,255,  0, 0,0,0,255)
end



function WndMatchMaking_WarningMessageEx(errorMessage0, errorMsg1, errorMsg2)

	winMgr:getWindow("sj_matchmaking_error_alphaWindow"):setVisible(true)
	winMgr:getWindow("sj_matchmaking_error_backWindow"):setVisible(true)
	
	winMgr:getWindow("sj_matchmaking_error_descWindow"):setPosition(0, 120)
	winMgr:getWindow("sj_matchmaking_error_descWindow"):clearTextExtends()
	winMgr:getWindow("sj_matchmaking_error_descWindow"):setViewTextMode(1)
	winMgr:getWindow("sj_matchmaking_error_descWindow"):setAlign(8)
	winMgr:getWindow("sj_matchmaking_error_descWindow"):setLineSpacing(7);
	winMgr:getWindow("sj_matchmaking_error_descWindow"):addTextExtends(errorMessage0, g_STRING_FONT_DODUM,15, 255,205,86,255,   1, 0,0,0,255)
	winMgr:getWindow("sj_matchmaking_error_descWindow"):addTextExtends('님에게\n', g_STRING_FONT_DODUM,115, 255,255,255,255,   0, 0,0,0,255)
	winMgr:getWindow("sj_matchmaking_error_descWindow"):addTextExtends(''.. errorMsg2, g_STRING_FONT_DODUM,115, 255,255,255,255,   0, 0,0,0,255)
	
	winMgr:getWindow("sj_matchmaking_error_descWindow"):setVisible(true)
end




--------------------------------------------------------------------

-- 프리존 관련 윈도우

--------------------------------------------------------------------
local tClassName = {["err"]=0,	[0]="class_TaeKwonDo",	"class_Boxing",		"class_MuayThai",	"class_Capoera",
								"class_ProWrestling",	"class_Judo",		"class_Hapgido",	"class_Sambo"}
								
local tTransformName = {["err"]=0, [0]="t_singo", "t_violet", "t_muffin", "t_hRose", "t_crown"}
						
-- esc로 창을 없애기 위해 투명 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_matchmaking_freeZone_emptyWindow")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

RegistEscEventInfo("sj_matchmaking_freeZone_emptyWindow", "ClickedFreeZoneSelectCancel")
		
-- 백그라운드 알파 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_matchmaking_freeZone_alphaWindow")
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


-- 프리존 선택 배경 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_matchmaking_freeZone_backWindow")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);

if WndMatchMaking_IsFreeZoneNormal() == true then
	mywindow:setTexture("Enabled", "UIData/Event_FreezoneSelect.tga", 0, 510)
	mywindow:setTexture("Disabled", "UIData/Event_FreezoneSelect.tga", 0, 510)
	mywindow:setPosition(212, 236)
	mywindow:setSize(597, 296)
else
	mywindow:setTexture("Enabled", "UIData/Event_FreezoneSelect.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/Event_FreezoneSelect.tga", 0, 0)
	mywindow:setPosition(212, 129)
	mywindow:setSize(597, 510)
end

mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("sj_matchmaking_freeZone_alphaWindow"):addChildWindow(mywindow)

function CallFreeZoneSelect(bShow)
	root:addChildWindow(winMgr:getWindow("sj_matchmaking_freeZone_alphaWindow"))
	winMgr:getWindow("sj_matchmaking_freeZone_alphaWindow"):setVisible(bShow)
	
	if WndMatchMaking_GetChangingFreeZone() then
		winMgr:getWindow("sj_matchmaking_freeZone_emptyWindow"):setVisible(true)
		winMgr:getWindow("sj_matchmaking_freezoneCancelBtn"):setVisible(true)
	else
		winMgr:getWindow("sj_matchmaking_freeZone_emptyWindow"):setVisible(false)
		winMgr:getWindow("sj_matchmaking_freezoneCancelBtn"):setVisible(false)
	end
end


-- 클래스 관련
local g_selectClass = -1
local tClassPosX = {["err"]=0, [0]=0, 69, 138, 207, 276, 345, 414, 483}
for i=0, #tClassName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tClassName[i])
	mywindow:setTexture("Normal", "UIData/Event_ClassImage.tga", tClassPosX[i], 0)
	mywindow:setTexture("Hover", "UIData/Event_ClassImage.tga", tClassPosX[i], 174)
	mywindow:setTexture("Pushed", "UIData/Event_ClassImage.tga", tClassPosX[i], 348)
	mywindow:setTexture("PushedOff", "UIData/Event_ClassImage.tga", tClassPosX[i], 0)
	mywindow:setTexture("SelectedNormal", "UIData/Event_ClassImage.tga", tClassPosX[i], 348)
	mywindow:setTexture("SelectedHover", "UIData/Event_ClassImage.tga", tClassPosX[i], 348)
	mywindow:setTexture("SelectedPushed", "UIData/Event_ClassImage.tga", tClassPosX[i], 348)
	mywindow:setTexture("SelectedPushedOff", "UIData/Event_ClassImage.tga", tClassPosX[i], 348)
	mywindow:setSize(69, 174)
	mywindow:setProperty("GroupID", 7771)
	mywindow:setPosition((i*70)+19, 74)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("index", tostring(i))
	mywindow:subscribeEvent("SelectStateChanged", "OnSelectedClass")
	mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_ClassInfo")
	mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_ClassInfo")
	winMgr:getWindow("sj_matchmaking_freeZone_backWindow"):addChildWindow(mywindow)
end

local tClassNamePosY = {["err"]=0, [0]=0, 20, 40, 60, 80, 100, 120, 140}
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_matchmaking_freeZone_classDescImage")
mywindow:setTexture("Enabled", "UIData/Event_FreezoneSelect.tga", 597, 160)
mywindow:setTexture("Disabled", "UIData/Event_FreezoneSelect.tga", 597, 160)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(460, 52)
mywindow:setSize(111, 20)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("sj_matchmaking_freeZone_backWindow"):addChildWindow(mywindow)

function OnSelectedClass(args)
	for i=0, #tClassName do
		if CEGUI.toRadioButton(winMgr:getWindow(tClassName[i])):isSelected() then
			local szIndex = winMgr:getWindow(tClassName[i]):getUserString("index")
			if szIndex ~= "" then
				g_selectClass = tonumber(szIndex)
				CheckFreeZoneSelectBtn()
				return
			end
		end
	end
end

function OnMouseEnter_ClassInfo(args)
	local window = CEGUI.toWindowEventArgs(args).window
	local szIndex = window:getUserString("index")
	if szIndex ~= "" then
		local index = tonumber(szIndex)
		if index <= #tClassNamePosY then
			winMgr:getWindow("sj_matchmaking_freeZone_classDescImage"):setTexture("Enabled", "UIData/Event_FreezoneSelect.tga", 597, tClassNamePosY[index])
			winMgr:getWindow("sj_matchmaking_freeZone_classDescImage"):setTexture("Disabled", "UIData/Event_FreezoneSelect.tga", 597, tClassNamePosY[index])
		end
	end
end

function OnMouseLeave_ClassInfo(args)
	local window = CEGUI.toWindowEventArgs(args).window
	local szIndex = window:getUserString("index")
	if szIndex ~= "" then
		local index = tonumber(szIndex)
		if index <= #tClassNamePosY then
			if g_selectClass >= 0 then
				winMgr:getWindow("sj_matchmaking_freeZone_classDescImage"):setTexture("Enabled", "UIData/Event_FreezoneSelect.tga", 597, tClassNamePosY[g_selectClass])
				winMgr:getWindow("sj_matchmaking_freeZone_classDescImage"):setTexture("Disabled", "UIData/Event_FreezoneSelect.tga", 597, tClassNamePosY[g_selectClass])
			else
				winMgr:getWindow("sj_matchmaking_freeZone_classDescImage"):setTexture("Enabled", "UIData/Event_FreezoneSelect.tga", 597, 160)
				winMgr:getWindow("sj_matchmaking_freeZone_classDescImage"):setTexture("Disabled", "UIData/Event_FreezoneSelect.tga", 597, 160)
			end
		end
	end
end


if WndMatchMaking_IsFreeZoneNormal() == false then
	-- 변신 관련
	local g_selecttransformIndex = -1
	local tTransformPosX = {["err"]=0, [0]=552, 621, 690, 759, 828}
	for i=0, #tTransformName do
		mywindow = winMgr:createWindow("TaharezLook/RadioButton", tTransformName[i])
		mywindow:setTexture("Normal", "UIData/Event_ClassImage.tga", tTransformPosX[i], 0)
		mywindow:setTexture("Hover", "UIData/Event_ClassImage.tga", tTransformPosX[i], 174)
		mywindow:setTexture("Pushed", "UIData/Event_ClassImage.tga", tTransformPosX[i], 348)
		mywindow:setTexture("PushedOff", "UIData/Event_ClassImage.tga", tTransformPosX[i], 0)
		mywindow:setTexture("SelectedNormal", "UIData/Event_ClassImage.tga", tTransformPosX[i], 348)
		mywindow:setTexture("SelectedHover", "UIData/Event_ClassImage.tga", tTransformPosX[i], 348)
		mywindow:setTexture("SelectedPushed", "UIData/Event_ClassImage.tga", tTransformPosX[i], 348)
		mywindow:setTexture("SelectedPushedOff", "UIData/Event_ClassImage.tga", tTransformPosX[i], 348)
		mywindow:setSize(69, 174)
		mywindow:setProperty("GroupID", 7772)
		mywindow:setPosition((i*70)+19, 286)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:setUserString("index", tostring(i))
		mywindow:subscribeEvent("SelectStateChanged", "OnSelectedTransform")
		mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_TransformInfo")
		mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_TransformInfo")
		winMgr:getWindow("sj_matchmaking_freeZone_backWindow"):addChildWindow(mywindow)
	end

	local tTransformNamePosY = {["err"]=0, [0]=200, 220, 240, 260, 280}
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_matchmaking_freeZone_transformDescImage")
	mywindow:setTexture("Enabled", "UIData/Event_FreezoneSelect.tga", 597, 160)
	mywindow:setTexture("Disabled", "UIData/Event_FreezoneSelect.tga", 597, 160)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(460, 264)
	mywindow:setSize(111, 20)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_matchmaking_freeZone_backWindow"):addChildWindow(mywindow)
end

function OnSelectedTransform(args)
	for i=0, #tTransformName do
		if CEGUI.toRadioButton(winMgr:getWindow(tTransformName[i])):isSelected() then
			local szIndex = winMgr:getWindow(tTransformName[i]):getUserString("index")
			if szIndex ~= "" then
				g_selecttransformIndex = tonumber(szIndex)
				CheckFreeZoneSelectBtn()
				return
			end
		end
	end
end

function OnMouseEnter_TransformInfo(args)
	local window = CEGUI.toWindowEventArgs(args).window
	local szIndex = window:getUserString("index")
	if szIndex ~= "" then
		local index = tonumber(szIndex)
		if index <= #tTransformNamePosY then
			winMgr:getWindow("sj_matchmaking_freeZone_transformDescImage"):setTexture("Enabled", "UIData/Event_FreezoneSelect.tga", 597, tTransformNamePosY[index])
			winMgr:getWindow("sj_matchmaking_freeZone_transformDescImage"):setTexture("Disabled", "UIData/Event_FreezoneSelect.tga", 597, tTransformNamePosY[index])
		end
	end
end

function OnMouseLeave_TransformInfo(args)
	local window = CEGUI.toWindowEventArgs(args).window
	local szIndex = window:getUserString("index")
	if szIndex ~= "" then
		local index = tonumber(szIndex)
		if index <= #tTransformNamePosY then
			if g_selecttransformIndex >= 0 then
				winMgr:getWindow("sj_matchmaking_freeZone_transformDescImage"):setTexture("Enabled", "UIData/Event_FreezoneSelect.tga", 597, tTransformNamePosY[g_selecttransformIndex])
				winMgr:getWindow("sj_matchmaking_freeZone_transformDescImage"):setTexture("Disabled", "UIData/Event_FreezoneSelect.tga", 597, tTransformNamePosY[g_selecttransformIndex])
			else
				winMgr:getWindow("sj_matchmaking_freeZone_transformDescImage"):setTexture("Enabled", "UIData/Event_FreezoneSelect.tga", 597, 160)
				winMgr:getWindow("sj_matchmaking_freeZone_transformDescImage"):setTexture("Disabled", "UIData/Event_FreezoneSelect.tga", 597, 160)
			end
		end
	end
end

mywindow = winMgr:createWindow("TaharezLook/Button", "sj_matchmaking_freezoneOkBtn")
mywindow:setTexture("Normal", "UIData/profile001.tga", 813, 324)
mywindow:setTexture("Hover", "UIData/profile001.tga", 813, 351)
mywindow:setTexture("Pushed", "UIData/profile001.tga", 813, 378)
mywindow:setTexture("PushedOff", "UIData/profile001.tga", 813, 324)
mywindow:setTexture("Enabled", "UIData/profile001.tga", 813, 324)
mywindow:setTexture("Disabled", "UIData/profile001.tga", 813, 405)

if WndMatchMaking_IsFreeZoneNormal() == true then
	mywindow:setPosition(506, 261)
else
	mywindow:setPosition(506, 475)
end

mywindow:setSize(81, 27)
mywindow:setEnabled(false)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickedFreeZoneSelectOK")
winMgr:getWindow("sj_matchmaking_freeZone_backWindow"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/Button", "sj_matchmaking_freezoneCancelBtn")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setPosition(565, 10)
mywindow:setSize(23, 23)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickedFreeZoneSelectCancel")
winMgr:getWindow("sj_matchmaking_freeZone_backWindow"):addChildWindow(mywindow)

function ClickedFreeZoneSelectOK()

	CallFreeZoneSelect(false)
	
	if WndMatchMaking_IsFreeZoneNormal() == true then
		g_selecttransformIndex = 0
	end
	
	WndMatchMaking_SetFullSkill(g_selectClass, g_selecttransformIndex)
	winMgr:getWindow("sj_matchmaking_freeZone_emptyWindow"):setVisible(false)
end

function ClickedFreeZoneSelectCancel()
	CallFreeZoneSelect(false)
	winMgr:getWindow("sj_matchmaking_freeZone_emptyWindow"):setVisible(false)
	local currentClass, currentTransformIndex = WndMatchMaking_GetFullSkillInfo()
	if currentClass >= 0 and currentTransformIndex >= 0 then
		for i=0, #tClassName do
			if i == currentClass then
				CEGUI.toRadioButton(winMgr:getWindow(tClassName[i])):setSelected(true)
			else
				CEGUI.toRadioButton(winMgr:getWindow(tClassName[i])):setSelected(false)
			end
		end
		
		for i=0, #tTransformName do
			if i == currentTransformIndex then
				CEGUI.toRadioButton(winMgr:getWindow(tTransformName[i])):setSelected(true)
			else
				CEGUI.toRadioButton(winMgr:getWindow(tTransformName[i])):setSelected(false)
			end
		end
	end
end

function CheckFreeZoneSelectBtn()

	if WndMatchMaking_IsFreeZoneNormal() == true then
		if g_selectClass >= 0 then
			winMgr:getWindow("sj_matchmaking_freezoneOkBtn"):setEnabled(true)
		else
			winMgr:getWindow("sj_matchmaking_freezoneOkBtn"):setEnabled(false)
		end
	else
		if g_selectClass >= 0 and g_selecttransformIndex >= 0 then
			winMgr:getWindow("sj_matchmaking_freezoneOkBtn"):setEnabled(true)
		else
			winMgr:getWindow("sj_matchmaking_freezoneOkBtn"):setEnabled(false)
		end
	end
end
