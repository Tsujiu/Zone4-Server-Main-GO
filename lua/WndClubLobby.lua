-----------------------------------------
-- Script Entry Point
-----------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)
root:activate()
local My_LobbyCharacterName = ""
local g_SelectedClubLobbyTab = 4
local g_RegistTeam = false
local myClubName = ""
local OnClickUserName = ""
g_lobbyUserPage = 1
g_lobbyUserMaxPage = 1

g_lobbyMatchPage = 1
g_lobbyMatchMaxPage = 1
g_lobbyMatchHistoryPage = 1
g_lobbyMatchHistoryMaxPage = 1

--------------------------------------------------------------------
-- 채널 정보 백판 붙이기
--------------------------------------------------------------------
root:addChildWindow(winMgr:getWindow('ChannelPositionBG'));
winMgr:getWindow('ChannelPositionBG'):setWideType(6);
winMgr:getWindow('ChannelPositionBG'):setPosition(795, 2);
winMgr:getWindow('NewMoveServerBtn'):setVisible(true)
winMgr:getWindow('NewMoveExitBtn'):setVisible(false)


root:setSubscribeEvent("MouseButtonUp", "OnRootMouseButtonUp")
function OnRootMouseButtonUp(args)
	root:removeChildWindow(winMgr:getWindow('pu_btnContainer'))
end
--------------------------------------------------------------------

-- drawTexture(StartRender:시작시에 그리기)

--------------------------------------------------------------------
function WndClubLobby_RenderBackImage(currentBattleChannelName)
	
	drawer:drawTexture("UIData/mainBG_Button001.tga", 30, 15, 281, 46, 0, 440, WIDETYPE_6)	--FIGHTCLUB 글자
	
	-- 대전채널 이름
	if g_BattleMode == BATTLETYPE_NORMAL then
		drawer:setTextColor(255, 255, 255, 255)
	elseif g_BattleMode == BATTLETYPE_EXTREME then
		drawer:setTextColor(220, 80, 220, 255)
	end

end


------------------------------------------------------------------------------------
----- 시간 공지 이미지 
------------------------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ClubLobby_TimeNoticeImage")
mywindow:setTexture("Enabled", "UIData/fightclub_004.tga", 908, 967)
mywindow:setTexture("Disabled", "UIData/fightclub_004.tga",  908, 967)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(230 , 32);
mywindow:setSize(115, 18)
mywindow:setEnabled(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

------------------------------------------------------------------------------------
----- 로비 My팀생성+ 생성된 팀 백판 
------------------------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ClubLobby_BackImage")
mywindow:setTexture("Enabled", "UIData/fightclub_004.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/fightclub_004.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(0 ,72);
mywindow:setSize(1024, 415)
mywindow:setEnabled(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(true)
mywindow:setSubscribeEvent('MouseButtonDown', 'ClubLobbyMouseClick');
root:addChildWindow(mywindow)

------------------------------------------------------------------------------------
----- 로비 마이클럽멤버 + 마이 팀 목록 배경백판 1
------------------------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ClubLobby_MyGangBackImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(10 ,72);
mywindow:setSize(455, 320)
mywindow:setEnabled(true)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setSubscribeEvent('MouseButtonDown', 'ClubLobbyMouseClick');
winMgr:getWindow('ClubLobby_BackImage'):addChildWindow(mywindow)

------------------------------------------------------------------------------------
----- 로비 마이클럽멤버 + 마이 팀 목록 배경백판 2
------------------------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ClubLobby_MyTeamListBackImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(10 ,72);
mywindow:setSize(455, 320)
mywindow:setEnabled(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setSubscribeEvent('MouseButtonDown', 'ClubLobbyMouseClick');
winMgr:getWindow('ClubLobby_BackImage'):addChildWindow(mywindow)


----- 로비 마이클럽멤버 backimamge
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ClubLobby_MemberBackImage")
mywindow:setTexture("Enabled", "UIData/fightclub_004.tga", 0, 415)
mywindow:setTexture("Disabled", "UIData/fightclub_004.tga", 0, 415)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(15 , 20);
mywindow:setSize(225, 270)
mywindow:setEnabled(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('ClubLobby_MyGangBackImage'):addChildWindow(mywindow)

----- 로비 초대된 멤버 backimamge
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ClubLobby_InviteBackImage")
mywindow:setTexture("Enabled", "UIData/fightclub_004.tga", 225, 415)
mywindow:setTexture("Disabled", "UIData/fightclub_004.tga", 225, 415)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(240 , 35);
mywindow:setSize(201, 264)
mywindow:setEnabled(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('ClubLobby_MyGangBackImage'):addChildWindow(mywindow)

-- My팀 엠블렘 이미지
child_window = winMgr:createWindow('TaharezLook/StaticImage', 'MyTeamInfo_ClubEmbelm')
child_window:setTexture('Enabled', 'UIData/Invisible.tga', 0, 0)
child_window:setTexture('Disabled', 'UIData/Invisible.tga', 0, 0)
child_window:setProperty('BackgroundEnabled', 'False')
child_window:setProperty('FrameEnabled', 'False')
child_window:setPosition(34, 39)
child_window:setSize(32, 32)
child_window:setEnabled(false)
child_window:setVisible(true)
child_window:setZOrderingEnabled(false)
winMgr:getWindow('ClubLobby_BackImage'):addChildWindow(child_window)

-- My클럽 정보 텍스트
MyTeamInfoText =   { ["protecterr"]=0, "MyTeamInfo_ClubName", "MyTeamInfo_Master" ,"MyTeamInfo_Level", "MyTeamInfo_Rank"}																   
MyTeamInfoPosX  =    { ["protecterr"]=0, 166, 174 , 403 , 418 }
MyTeamInfoPosY  =    { ["protecterr"]=0, 36,  57 , 36, 57 }
MyTeamInfoSetText		= {['err'] = 0, 'ClubName', 'Master', 'Level', 'Rank' }

for i=1 , #MyTeamInfoText do
	mywindow = winMgr:createWindow("TaharezLook/StaticText", MyTeamInfoText[i])
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(MyTeamInfoPosX[i],MyTeamInfoPosY[i])
	mywindow:setSize(20, 18)
	mywindow:setText(MyTeamInfoSetText[i])
	mywindow:setZOrderingEnabled(false)	
	mywindow:setFont(g_STRING_FONT_GULIM, 12)
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setVisible(true)
	winMgr:getWindow('ClubLobby_BackImage'):addChildWindow( winMgr:getWindow(MyTeamInfoText[i]) );
end


-----  마이클럽 팀 리스트 --------------------------------------------------------------------------------------------------
														   
MyTeamList_PosX  =    { ["protecterr"]=0, 18, 231 , 18, 231, 18, 231, 18, 231}
MyTeamList_PosY  =    { ["protecterr"]=0, 19,  19 , 84, 84, 149, 149, 214, 214 }
MyTeamList_Text	= {['err'] = 0, 'LeaderName', '1 / 1'}
MyTeamList_TextPosX =  { ["protecterr"]=0, 100 , 60}
MyTeamList_TextPosY =  { ["protecterr"]=0, 10 , 43 }
for i=1 , 8 do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyTeamList_image_"..i)
	mywindow:setTexture("Enabled", "UIData/fightclub_004.tga", 0, 690)
	mywindow:setTexture("Disabled", "UIData/fightclub_004.tga", 0, 690)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(MyTeamList_PosX[i] , MyTeamList_PosY[i]);
	mywindow:setSize(213, 66)
	mywindow:setEnabled(true)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	winMgr:getWindow('ClubLobby_MyTeamListBackImage'):addChildWindow(mywindow)
	
	mywindow2 = winMgr:createWindow("TaharezLook/StaticImage", "MyTeamList_Empty_"..i)
	mywindow2:setTexture("Enabled", "UIData/fightclub_004.tga", 0, 756)
	mywindow2:setTexture("Disabled", "UIData/fightclub_004.tga", 0, 756)
	mywindow2:setProperty("FrameEnabled", "False")
	mywindow2:setProperty("BackgroundEnabled", "False")
	mywindow2:setPosition(MyTeamList_PosX[i] , MyTeamList_PosY[i]);
	mywindow2:setSize(213, 66)
	mywindow2:setEnabled(true)
	mywindow2:setAlwaysOnTop(true)
	mywindow2:setZOrderingEnabled(true)
	winMgr:getWindow('ClubLobby_MyTeamListBackImage'):addChildWindow(mywindow2)
	
	for j=1, #MyTeamList_Text do
		local child_window = winMgr:createWindow("TaharezLook/StaticText", "MyTeamList_image_"..i..MyTeamList_Text[j])	
		child_window:setProperty("FrameEnabled", "false")
		child_window:setProperty("BackgroundEnabled", "false")
		child_window:setSize(5, 5)
		child_window:setVisible(true)
		child_window:setPosition(MyTeamList_TextPosX[j], MyTeamList_TextPosY[j])
		child_window:setViewTextMode(1)	
		child_window:setAlign(8)
		child_window:setLineSpacing(1)
		child_window:addTextExtends(MyTeamList_Text[j], g_STRING_FONT_GULIMCHE, 112,    255,255,255,255,     0,     0,0,0,255)
		mywindow:addChildWindow(child_window)
	end
	
	child_window = winMgr:createWindow("TaharezLook/Button", "MyTeamList_image_"..i.."JoinBtn")
	child_window:setTexture("Normal", "UIData/fightclub_004.tga", 410, 679)
	child_window:setTexture("Hover", "UIData/fightclub_004.tga", 410, 698)
	child_window:setTexture("Pushed", "UIData/fightclub_004.tga", 410, 717)
	child_window:setTexture("PushedOff", "UIData/fightclub_004.tga", 410, 736)
	child_window:setTexture("Disabled", "UIData/fightclub_004.tga", 410, 736) 
	child_window:setPosition(133, 40)
	child_window:setSize(75, 19)
	child_window:setVisible(true)
	child_window:setUserString('JoinIndex', tostring(i))
	child_window:setAlwaysOnTop(true)
	child_window:setZOrderingEnabled(false)
	child_window:subscribeEvent("Clicked", "OnClickJoinTeam")
	mywindow:addChildWindow(child_window)	
	
	child_window = winMgr:createWindow("TaharezLook/StaticImage", "MyTeamList_image_"..i.."MemberImage")
	child_window:setTexture('Enabled', 'UIData/fightclub_004.tga', 427, 574)
	child_window:setTexture('Disabled', 'UIData/fightclub_004.tga', 427, 574)
	child_window:setPosition(10, 38)
	child_window:setSize(25, 19)
	child_window:setVisible(true)
	child_window:setAlwaysOnTop(true)
	child_window:setZOrderingEnabled(false)
	mywindow:addChildWindow(child_window)	
	
end
function OnclickJoinClubTeam(args)
	OnClickJoinTeam(args)
end

-- 클럽 팀생성 버튼
mywindow = winMgr:createWindow("TaharezLook/Button", 'MyTeamCreateBtn')
mywindow:setTexture("Normal", "UIData/fightclub_004.tga", 840, 851)
mywindow:setTexture("Hover", "UIData/fightclub_004.tga", 840, 880)
mywindow:setTexture("Pushed", "UIData/fightclub_004.tga", 840, 909)
mywindow:setTexture("PushedOff", "UIData/fightclub_004.tga", 840, 909)
mywindow:setTexture("Disabled", "UIData/fightclub_004.tga", 840, 938)
mywindow:setPosition(17, 285)
mywindow:setSize(183, 29)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:subscribeEvent("Clicked", "OnclickMyTeamCreate")
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('ClubLobby_MyTeamListBackImage'):addChildWindow(mywindow)	


function OnclickMyTeamCreate()
	OnClickCreateTeam()
end

function Setting_MyClubTeamList(index, leaderName , MemberCount , TeamState)

	if leaderName == "" then
		winMgr:getWindow("MyTeamList_image_"..index):setVisible(false)
		winMgr:getWindow("MyTeamList_Empty_"..index):setVisible(true)
		
	else
		if TeamState == 0 then
			winMgr:getWindow("MyTeamList_image_"..index.."JoinBtn"):setEnabled(true)
		else
			winMgr:getWindow("MyTeamList_image_"..index.."JoinBtn"):setEnabled(false)
		end
		winMgr:getWindow("MyTeamList_Empty_"..index):setVisible(false)
		winMgr:getWindow("MyTeamList_image_"..index):setVisible(true)
		winMgr:getWindow("MyTeamList_image_"..index..MyTeamList_Text[1]):clearTextExtends()
		winMgr:getWindow("MyTeamList_image_"..index..MyTeamList_Text[2]):clearTextExtends()
		winMgr:getWindow("MyTeamList_image_"..index..MyTeamList_Text[1]):addTextExtends(leaderName,g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
		winMgr:getWindow("MyTeamList_image_"..index..MyTeamList_Text[2]):addTextExtends(tostring(MemberCount)..' / 4', g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
		winMgr:getWindow("MyTeamList_image_"..index.."MemberImage"):setTexture('Enabled', 'UIData/fightclub_004.tga', 427, 574+(MemberCount*19)-19)
		winMgr:getWindow("MyTeamList_image_"..index..MyTeamList_Text[1]):setText(leaderName)
	end
end

---------------------------------------------------------------------------------------------------------------------------
-- 초대된 클럽원 목록
MyTeamMemberText =   { ["protecterr"]=0, "MyTeamMemberText1", "MyTeamMemberText2" ,"IMyTeamMemberText3", "MyTeamMemberText4"}																   
MyTeamMemberPosX  =    { ["protecterr"]=0, 65, 65 , 65 , 65 }
MyTeamMemberPosY  =    { ["protecterr"]=0, 38 , 68 , 98,  128 }
MyTeamMemberSetText		= {['err'] = 0, 'Leader', 'Member1', 'Member2', 'Member3' }

for i=1 , #MyTeamMemberText do
	mywindow = winMgr:createWindow("TaharezLook/StaticText", MyTeamMemberText[i])
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(MyTeamMemberPosX[i],MyTeamMemberPosY[i])
	mywindow:setSize(20, 18)
	mywindow:setZOrderingEnabled(false)	
	mywindow:setFont(g_STRING_FONT_GULIM, 12)
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setVisible(true)
	winMgr:getWindow('ClubLobby_InviteBackImage'):addChildWindow( winMgr:getWindow(MyTeamMemberText[i]) );
end

-- 클럽 팀등록 버튼
mywindow = winMgr:createWindow("TaharezLook/Button", 'MyTeamRegistBtn')
mywindow:setTexture("Normal", "UIData/fightclub_004.tga", 931, 735)
mywindow:setTexture("Hover", "UIData/fightclub_004.tga", 931, 764)
mywindow:setTexture("Pushed", "UIData/fightclub_004.tga", 931, 793)
mywindow:setTexture("PushedOff", "UIData/fightclub_004.tga", 931, 793)
mywindow:setTexture("Disabled", "UIData/fightclub_004.tga", 931, 822)
mywindow:setPosition(9, 222)
mywindow:setSize(91, 29)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:subscribeEvent("Clicked", "OnclickMyTeamRegist")
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('ClubLobby_InviteBackImage'):addChildWindow(mywindow)	

-- 클럽 팀등록 취소버튼
mywindow = winMgr:createWindow("TaharezLook/Button", 'MyTeamRegistCancelBtn')
mywindow:setTexture("Normal", "UIData/fightclub_004.tga", 749, 735)
mywindow:setTexture("Hover", "UIData/fightclub_004.tga", 749, 764)
mywindow:setTexture("Pushed", "UIData/fightclub_004.tga", 749, 793)
mywindow:setTexture("PushedOff", "UIData/fightclub_004.tga", 749, 793)
mywindow:setTexture("Disabled", "UIData/fightclub_004.tga", 749, 822)
mywindow:setPosition(9, 222)
mywindow:setSize(91, 29)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:subscribeEvent("Clicked", "OnClickCancelTeam")
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('ClubLobby_InviteBackImage'):addChildWindow(mywindow)
	
-- 나가기 버튼
mywindow = winMgr:createWindow("TaharezLook/Button", 'MyTeamOutBtn')
mywindow:setTexture("Normal", "UIData/fightclub_004.tga", 840, 735)
mywindow:setTexture("Hover", "UIData/fightclub_004.tga", 840, 764)
mywindow:setTexture("Pushed", "UIData/fightclub_004.tga", 840, 793)
mywindow:setTexture("PushedOff", "UIData/fightclub_004.tga", 840, 793)
mywindow:setTexture("Disabled", "UIData/fightclub_004.tga", 840, 822)
mywindow:setPosition(100, 222)
mywindow:setSize(91, 29)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:subscribeEvent("Clicked", "OnclickMyTeamOut")
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('ClubLobby_InviteBackImage'):addChildWindow(mywindow)	

function OnclickMyTeamOut()
	OnClickOutTeam()
end

function OnclickMyTeamRegist()
	OnClickRegistTeam()
end
------------------------------------------------------------------------------------
----- 로비 My클럽원 초대가능 목록 
------------------------------------------------------------------------------------
Lobby_MyClubMember_Radio = 
{ ["protecterr"]=0, "Lobby_MyClubMember_Radio1", "Lobby_MyClubMember_Radio2", "Lobby_MyClubMember_Radio3" , "Lobby_MyClubMember_Radio4", "Lobby_MyClubMember_Radio5",
					"Lobby_MyClubMember_Radio6", "Lobby_MyClubMember_Radio7", "Lobby_MyClubMember_Radio8" , "Lobby_MyClubMember_Radio9", "Lobby_MyClubMember_Radio10"}
	
	
Lobby_MyClubMember_Text	= {['err'] = 0, 'MyClubMemberLevel', 'MyClubMemberName'}
								
Lobby_MyClubMember_PosX		= {['err'] = 0, 20, 100}
Lobby_MyClubMember_PosY		= {['err'] = 0, 3, 3 }
Lobby_MyClubMember_SizeX	= {['err'] = 0, 5, 5 }
Lobby_MyClubMember_SizeY	= {['err'] = 0, 5, 5 }
Lobby_MyClubMember_SetText		= {['err'] = 0, 'Level', 'Name'}



for i=1, #Lobby_MyClubMember_Radio do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton",	Lobby_MyClubMember_Radio[i])
	mywindow:setTexture("Normal", "UIData/invisible.tga",		0, 822)    
	mywindow:setTexture("Hover", "UIData/invisible.tga",		0, 822)
	mywindow:setTexture("Pushed", "UIData/invisible.tga",		0, 844)
	mywindow:setTexture("PushedOff", "UIData/invisible.tga",	0, 844)
	mywindow:setTexture("SelectedNormal", "UIData/invisible.tga",	 0, 844)
	mywindow:setTexture("SelectedHover", "UIData/invisible.tga",	 0, 844)
	mywindow:setTexture("SelectedPushed", "UIData/invisible.tga",	 0, 844)
	mywindow:setTexture("SelectedPushedOff", "UIData/invisible.tga", 0, 844)
	mywindow:setSize(225, 21)
	mywindow:setPosition(0, 18+25*(i-1))
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true)
	winMgr:getWindow('ClubLobby_MemberBackImage'):addChildWindow(mywindow)
	
	--  레벨 , 이름
	for j=1, #Lobby_MyClubMember_Text do
		local child_window = winMgr:createWindow("TaharezLook/StaticText", Lobby_MyClubMember_Radio[i]..Lobby_MyClubMember_Text[j])	
		child_window:setProperty("FrameEnabled", "false")
		child_window:setProperty("BackgroundEnabled", "false")
		child_window:setSize(Lobby_MyClubMember_SizeX[j], Lobby_MyClubMember_SizeY[j])
		child_window:setVisible(true)
		child_window:setPosition(Lobby_MyClubMember_PosX[j], Lobby_MyClubMember_PosY[j])
		child_window:setViewTextMode(1)	
		child_window:setAlign(8)
		child_window:setLineSpacing(1)
		mywindow:addChildWindow(child_window)
	end
	
	child_window = winMgr:createWindow("TaharezLook/Button", Lobby_MyClubMember_Radio[i]..'InviteMember')
	child_window:setTexture("Normal", "UIData/fightclub_004.tga", 320, 679)
	child_window:setTexture("Hover", "UIData/fightclub_004.tga", 320, 698)
	child_window:setTexture("Pushed", "UIData/fightclub_004.tga", 320, 717)
	child_window:setTexture("PushedOff", "UIData/fightclub_004.tga", 320, 736)
	child_window:setTexture("Disabled", "UIData/fightclub_004.tga", 320, 736)
	child_window:setPosition(166, 0)
	child_window:setSize(54, 19)
	child_window:setVisible(false)
	child_window:setAlwaysOnTop(true)
	child_window:setZOrderingEnabled(false)
	child_window:subscribeEvent("Clicked", "OnClickInviteClubMember")
	child_window:setUserString("InviteIndex",tostring(i))
	mywindow:addChildWindow(child_window)	
end

-- 클릭한 클럽멤버를 팀에 초대한다 
function OnClickInviteClubMember(args)
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
	local InviteMemberName = winMgr:getWindow(Lobby_MyClubMember_Radio[index]..Lobby_MyClubMember_Text[2]):getText()
	DebugStr('InviteMemberName:'..InviteMemberName);
	-- 이미 초대된 사람일경우 리턴
	for i=1, #MyTeamMemberText do
		local invitedName = winMgr:getWindow(MyTeamMemberText[i]):getText()
		if invitedName == InviteMemberName then
			--이미 팀에 가입된 멤버입니다
			ShowCommonAlertOkBoxWithFunction(PreCreateString_2294,'OnClickAlertOkSelfHide');
												-GetSStringInfo(LAN_ALREADY_JOINED)
			return
		end
	end
	InviteTeamMember(InviteMemberName)
end

function InviteFightClubMsg(InviteMemberId)
	local systemMessage = '[!] '..string.format(PreCreateString_2307, InviteMemberId)
													-GetSStringInfo(LAN_LUA_INVITE_FIGHTMATCH)
	OnChatPublic(systemMessage, 5, 0)
end

------------------------------------------------------------------------------------
----- 로비 클럽전 팀 배경백판 
------------------------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ClubLobby_TeamBackImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 60)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 60)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(495 ,63);
mywindow:setSize(510, 330)
mywindow:setEnabled(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow('ClubLobby_BackImage'):addChildWindow(mywindow)

------------------------------------------------------------------------------------
----- 로비 클럽전 팀 목록 
------------------------------------------------------------------------------------
ClubLobby_Team_Radio = 
{ ["protecterr"]=0, "ClubLobby_Team_Radio1", "ClubLobby_Team_Radio2", "ClubLobby_Team_Radio3" , "ClubLobby_Team_Radio4", "ClubLobby_Team_Radio5",
					"ClubLobby_Team_Radio6", "ClubLobby_Team_Radio7", "ClubLobby_Team_Radio8" , "ClubLobby_Team_Radio9", "ClubLobby_Team_Radio10"}
	
ClubLobbyTeamText	= {['err'] = 0, 'ClubLobbyNum', 'ClubLobbyLevel', 'ClubLobbyClubName', 'ClubLobbyTeamLeader' , 'ClubLobbyTeamEmblem'
                                 , 'ClubLobbyMaster' , 'ClubLobbyContinueWin', 'ClubLobbyMemberCount' , 'ClubLobbyMemberMaxCount', 'ClubLobbyWin'
                                 , 'ClubLobbyLose' , 'ClubLobbyRank'}
								
ClubLobbyTeamTextPosX		= {['err'] = 0, 13, 13, 150 , 280 , 0 , 0, 0 , 0, 0, 0, 0, 0}
ClubLobbyTeamTextPosY		= {['err'] = 0, 7, 7, 7 ,7 ,7 , 7, 7, 7 ,7 ,7 ,7 ,7}
ClubLobbyTeamSizeX			= {['err'] = 0, 5, 5, 5 ,5 , 5, 5, 5, 5 ,5 , 5, 5, 5}
ClubLobbyTeamSizeY			= {['err'] = 0, 5, 5, 5 ,5 , 5 , 5, 5, 5 ,5 , 5, 5, 5}
ClubLobbyTeamSetText		= {['err'] = 0, '20', '30', 'ClubName', 'TeamLeader' , '11' , 'TeamMaster', '0', '1', '1', '0','0', '1'}



for i=1, #ClubLobby_Team_Radio do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton",	ClubLobby_Team_Radio[i])
	mywindow:setTexture("Normal", "UIData/fightClub_004.tga",		522, 471)    
	mywindow:setTexture("Hover", "UIData/fightClub_004.tga",		522, 415)
	mywindow:setTexture("Pushed", "UIData/fightClub_004.tga",		522, 443)
	mywindow:setTexture("PushedOff", "UIData/fightClub_004.tga",	522, 443)
	mywindow:setTexture("SelectedNormal", "UIData/fightClub_004.tga",	 522, 443)
	mywindow:setTexture("SelectedHover", "UIData/fightClub_004.tga",	 522, 443)
	mywindow:setTexture("SelectedPushed", "UIData/fightClub_004.tga",	 522, 443)
	mywindow:setTexture("SelectedPushedOff", "UIData/fightClub_004.tga", 522, 443)
	mywindow:setTexture("Disabled", "UIData/fightClub_004.tga",			522, 471);
	mywindow:setSize(500, 28)
	mywindow:setPosition(3, 30*(i-1))
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true)
	mywindow:setEnabled(false)
	mywindow:setUserString('DetailIndex', tostring(i))
	--mywindow:subscribeEvent("SelectStateChanged", "OnSelectedTeamInfo");
	mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_ShowClubInfo")
	mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_HideClubInfo")
	winMgr:getWindow('ClubLobby_TeamBackImage'):addChildWindow(mywindow)
	

	
	--  번호 레벨 클럽명 팀리더
	for j=1, #ClubLobbyTeamText do
		local child_window = winMgr:createWindow("TaharezLook/StaticText", ClubLobby_Team_Radio[i]..ClubLobbyTeamText[j])	
		child_window:setProperty("FrameEnabled", "false")
		child_window:setProperty("BackgroundEnabled", "false")
		child_window:setSize(ClubLobbyTeamSizeX[j], ClubLobbyTeamSizeY[j])
		child_window:setVisible(true)
		child_window:setPosition(ClubLobbyTeamTextPosX[j], ClubLobbyTeamTextPosY[j])
		child_window:setViewTextMode(1)	
		child_window:setAlign(8)
		child_window:setLineSpacing(1)
		mywindow:addChildWindow(child_window)
	end
	
	
	--  클럽 엠블렘 이미지
	child_window = winMgr:createWindow('TaharezLook/StaticImage', ClubLobby_Team_Radio[i]..'ClubEmbleImage')
	child_window:setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
	child_window:setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
	child_window:setProperty('BackgroundEnabled', 'False')
	child_window:setProperty('FrameEnabled', 'False')
	child_window:setPosition(40, 3)
	child_window:setScaleWidth(183)
	child_window:setScaleHeight(183)
	child_window:setSize(32, 32)
	child_window:setEnabled(false)
	child_window:setVisible(true)
	child_window:setZOrderingEnabled(false)
	mywindow:addChildWindow(child_window)
	
	--  팀 인원수 이미지
	child_window = winMgr:createWindow('TaharezLook/StaticImage', ClubLobby_Team_Radio[i]..'TeamCountImage')
	child_window:setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
	child_window:setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
	child_window:setProperty('BackgroundEnabled', 'False')
	child_window:setProperty('FrameEnabled', 'False')
	child_window:setPosition(365, 4)
	child_window:setSize(25, 19)
	child_window:setEnabled(false)
	child_window:setVisible(true)
	child_window:setZOrderingEnabled(false)
	mywindow:addChildWindow(child_window)
	
	--  클럽 매치 신청버튼
	child_window = winMgr:createWindow("TaharezLook/Button", ClubLobby_Team_Radio[i]..'ClubMatchPropose')
	child_window:setTexture("Normal", "UIData/fightclub_004.tga", 427, 416)
	child_window:setTexture("Hover", "UIData/fightclub_004.tga", 427, 435)
	child_window:setTexture("Pushed", "UIData/fightclub_004l.tga", 427, 454)
	child_window:setTexture("PushedOff", "UIData/fightclub_004.tga", 427, 416)
	child_window:setTexture('Disabled', "UIData/fightclub_004.tga", 427, 473)
	child_window:setPosition(408, 4)
	child_window:setSize(80, 19)
	child_window:setVisible(false)
	child_window:setAlwaysOnTop(true)
	child_window:setSubscribeEvent("Clicked", "OnClickRequestClubMacth")
	child_window:setUserString('MatchIndex', tostring(i))
	child_window:setZOrderingEnabled(false)
	mywindow:addChildWindow(child_window)	
	
end

for i=1 , 10 do
	winMgr:getWindow(ClubLobby_Team_Radio[i]..'ClubEmbleImage'):setScaleWidth(163)
	winMgr:getWindow(ClubLobby_Team_Radio[i]..'ClubEmbleImage'):setScaleHeight(163)
end

function OnClickClubMatchPropose()
	OnClickClubMacth()
end



function Reset_LobbyTeamList()
	for i=1, #ClubLobby_Team_Radio do
		winMgr:getWindow(ClubLobby_Team_Radio[i]):setEnabled(false)
		winMgr:getWindow(ClubLobby_Team_Radio[i]..'ClubEmbleImage'):setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
		winMgr:getWindow(ClubLobby_Team_Radio[i]..'ClubEmbleImage'):setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
		winMgr:getWindow(ClubLobby_Team_Radio[i]..'TeamCountImage'):setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
		winMgr:getWindow(ClubLobby_Team_Radio[i]..'TeamCountImage'):setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
		
		winMgr:getWindow(ClubLobby_Team_Radio[i]..'ClubMatchPropose'):setVisible(false)
		for j=1 , #ClubLobbyTeamText do
			winMgr:getWindow(ClubLobby_Team_Radio[i]..ClubLobbyTeamText[j]):clearTextExtends()
		end
	end
end

-- 로비 팀 라디오 버튼 내용 세팅
function Setting_LobbyTeamList(LobbyTeamIndex , LobbyTeamLevel, LobbyTeamClubName , LobbyTeamLeader , TeamEmblemKey 
		, TeamMasterName , TeamContinue , TeamMebmerCount , TeamMaxMemberCount , TeamWin, Teamlose , TeamRank , TeamMemberCount , MyTeamMemberCount)
	
	--DebugStr('TeamMemberCount:'..TeamMemberCount)
	winMgr:getWindow(ClubLobby_Team_Radio[LobbyTeamIndex]):setEnabled(true)
	for i=1, #ClubLobbyTeamText do
		winMgr:getWindow(ClubLobby_Team_Radio[LobbyTeamIndex]..ClubLobbyTeamText[i]):clearTextExtends()
	end
	RealIndex = LobbyTeamIndex + (g_TeamListPage-1)*10 
	--winMgr:getWindow(ClubLobby_Team_Radio[LobbyTeamIndex]..ClubLobbyTeamText[1]):addTextExtends(RealIndex, g_STRING_FONT_GULIMCHE, 112,    200,200,200,255,     0,     0,0,0,255)
	winMgr:getWindow(ClubLobby_Team_Radio[LobbyTeamIndex]..ClubLobbyTeamText[2]):addTextExtends(LobbyTeamLevel, g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
	winMgr:getWindow(ClubLobby_Team_Radio[LobbyTeamIndex]..ClubLobbyTeamText[3]):addTextExtends(LobbyTeamClubName, g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
	winMgr:getWindow(ClubLobby_Team_Radio[LobbyTeamIndex]..ClubLobbyTeamText[4]):addTextExtends(LobbyTeamLeader, g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
	
	winMgr:getWindow(ClubLobby_Team_Radio[LobbyTeamIndex]..ClubLobbyTeamText[2]):setText(LobbyTeamLevel)
	winMgr:getWindow(ClubLobby_Team_Radio[LobbyTeamIndex]..ClubLobbyTeamText[3]):setText(LobbyTeamClubName)
	winMgr:getWindow(ClubLobby_Team_Radio[LobbyTeamIndex]..ClubLobbyTeamText[4]):setText(LobbyTeamLeader)
	winMgr:getWindow(ClubLobby_Team_Radio[LobbyTeamIndex]..ClubLobbyTeamText[5]):setText(TeamEmblemKey)
	winMgr:getWindow(ClubLobby_Team_Radio[LobbyTeamIndex]..ClubLobbyTeamText[6]):setText(TeamMasterName)
	winMgr:getWindow(ClubLobby_Team_Radio[LobbyTeamIndex]..ClubLobbyTeamText[7]):setText(TeamContinue)
	winMgr:getWindow(ClubLobby_Team_Radio[LobbyTeamIndex]..ClubLobbyTeamText[8]):setText(TeamMebmerCount)
	winMgr:getWindow(ClubLobby_Team_Radio[LobbyTeamIndex]..ClubLobbyTeamText[9]):setText(TeamMaxMemberCount)
	winMgr:getWindow(ClubLobby_Team_Radio[LobbyTeamIndex]..ClubLobbyTeamText[10]):setText(TeamWin)
	winMgr:getWindow(ClubLobby_Team_Radio[LobbyTeamIndex]..ClubLobbyTeamText[11]):setText(Teamlose)
	winMgr:getWindow(ClubLobby_Team_Radio[LobbyTeamIndex]..ClubLobbyTeamText[12]):setText(TeamRank)
	
	
	if TeamEmblemKey > 0 then
		winMgr:getWindow(ClubLobby_Team_Radio[LobbyTeamIndex]..'ClubEmbleImage'):setTexture('Enabled',  GetClubDirectory(GetLanguageType())..TeamEmblemKey..".tga", 0, 0)
		winMgr:getWindow(ClubLobby_Team_Radio[LobbyTeamIndex]..'ClubEmbleImage'):setTexture('Disabled', GetClubDirectory(GetLanguageType())..TeamEmblemKey..".tga", 0, 0)
		
	else
		winMgr:getWindow(ClubLobby_Team_Radio[LobbyTeamIndex]..'ClubEmbleImage'):setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
		winMgr:getWindow(ClubLobby_Team_Radio[LobbyTeamIndex]..'ClubEmbleImage'):setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
	end
	if LobbyTeamClubName == myClubName then
		winMgr:getWindow(ClubLobby_Team_Radio[LobbyTeamIndex]..'ClubMatchPropose'):setVisible(false)
	else
		winMgr:getWindow(ClubLobby_Team_Radio[LobbyTeamIndex]..'ClubMatchPropose'):setVisible(true)
		if TeamMemberCount == MyTeamMemberCount then
			winMgr:getWindow(ClubLobby_Team_Radio[LobbyTeamIndex]..'ClubMatchPropose'):setEnabled(true)
		else
			winMgr:getWindow(ClubLobby_Team_Radio[LobbyTeamIndex]..'ClubMatchPropose'):setEnabled(false)
		end
	end
	
	if TeamMemberCount > 0 then
		winMgr:getWindow(ClubLobby_Team_Radio[LobbyTeamIndex]..'TeamCountImage'):setTexture('Enabled', 'UIData/fightclub_004.tga', 452, 574+(TeamMemberCount*19)-19)
		winMgr:getWindow(ClubLobby_Team_Radio[LobbyTeamIndex]..'TeamCountImage'):setTexture('Disabled', 'UIData/fightclub_004.tga', 452, 574+(TeamMemberCount*19)-19)
	end
	
end
------------------------------------------------------------------------------------
----- 로비 클럽전 팀 툴팁 백판 
------------------------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ClubLobby_TeamInfoImage")
mywindow:setTexture("Enabled", "UIData/fightclub_004.tga", 538, 851)
mywindow:setTexture("Disabled", "UIData/fightclub_004.tga", 538, 851)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
--mywindow:setWideType(6);
mywindow:setPosition(475 ,490);
mywindow:setSize(302, 159)
mywindow:setEnabled(true)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)


-- 팀 세부 정보 텍스트
TeamInfoText =   { ["protecterr"]=0, "TeamInfo_ClubName", "TeamInfo_Master" ,"TeamInfo_Level", "TeamInfo_Rank"
								   , "TeamInfo_Leader", "TeamInfo_Stats" , "TeamInfo_Wins", "TeamInfo_MemberCount" }
								   
TeamInfoPosX  =    { ["protecterr"]=0, 110, 110 , 240 , 240 , 110 , 110 , 145, 200}
TeamInfoPosY  =    { ["protecterr"]=0, 32,  51 , 115, 134,  70, 115,  132,  90 }
TeamInfoSetText		= {['err'] = 0, 'ClubName', 'Master', 'Level', 'Rank' , 'Leader' , 'Win/Lose', 'Wins' , 'MemberCount'}

for i=1 , #TeamInfoText do
	mywindow = winMgr:createWindow("TaharezLook/StaticText", TeamInfoText[i])
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(TeamInfoPosX[i],TeamInfoPosY[i])
	mywindow:setSize(20, 18)
	mywindow:setZOrderingEnabled(false)	
	mywindow:setFont(g_STRING_FONT_GULIM, 12)
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setVisible(true)
	winMgr:getWindow('ClubLobby_TeamInfoImage'):addChildWindow( winMgr:getWindow(TeamInfoText[i]) );
end


g_MyClubListPage = 1;
g_MaxClubListPage = 1;
g_MyClubPageSize = 10;
g_TeamListPage = 1;
g_TeamListMaxPage = 1;
g_MyClubTeamListPage = 1 
g_MyClubTeamListMaxPage =1 
g_ClubTutorialPage = 1
g_ClubTutorialMaxPage = 4
--------------------------------------------------
---마이 클럽멤버 리스트 갱신하기------------------
--------------------------------------------------
function RefreshMyClubMemberList()
	if winMgr:getWindow('ClubLobby_MyGangBackImage'):isVisible() == false then
		return 
	end
	g_MaxClubListPage = GetTotalGuildPage(g_MyClubPageSize)
	if g_MaxClubListPage < 1 then
		g_MaxClubListPage = 1
	end
	
	winMgr:getWindow('MyClubMemberList_PageText'):clearTextExtends()
	winMgr:getWindow('MyClubMemberList_PageText'):addTextExtends(tostring(g_MyClubListPage)..' / '..tostring(g_MaxClubListPage), g_STRING_FONT_GULIMCHE, 114,    230,230,230,255,     0,     0,0,0,255)
	for i=1, g_MyClubPageSize do
		local user_window = winMgr:getWindow('Lobby_MyClubMember_Radio'..tostring(i));
		
		local MyClub_level_window	= winMgr:getWindow('Lobby_MyClubMember_Radio'..tostring(i)..'MyClubMemberLevel')
		local MyClub_Name_window	= winMgr:getWindow('Lobby_MyClubMember_Radio'..tostring(i)..'MyClubMemberName')
		winMgr:getWindow('Lobby_MyClubMember_Radio'..tostring(i)..'InviteMember'):setVisible(false)
		MyClub_level_window:clearTextExtends();
		MyClub_Name_window:clearTextExtends();
		MyClub_Name_window:setText("")
	
		local level, name, state = GetGuildList(i, g_MyClubListPage, g_PageSize)
		
		
		if name ~= 'none' then
			winMgr:getWindow('Lobby_MyClubMember_Radio'..tostring(i)..'InviteMember'):setVisible(true)
			winMgr:getWindow('Lobby_MyClubMember_Radio'..tostring(i)..'InviteMember'):setEnabled(true)
			MyClub_level_window:addTextExtends('Lv.'..level, g_STRING_FONT_GULIMCHE, 112,    255,255,255,255,     0,     0,0,0,255);
			MyClub_Name_window:addTextExtends(name, g_STRING_FONT_GULIMCHE, 112,    255,255,255,255,     0,     0,0,0,255);		
			MyClub_Name_window:setText(name)
		end
		if state == 'offline' then					
			winMgr:getWindow('Lobby_MyClubMember_Radio'..tostring(i)..'InviteMember'):setEnabled(false)	
		end
	end
end
--------------------------------------------------
---마이 클럽정보 세팅하기-------------------------
--------------------------------------------------
function Setting_ClubLobbyInfo(MyclubEmblemKey , MyclubName,  MyclubLevel , MyclubMasterName , MyclubRank )

	if MyclubEmblemKey > 0 then
		MyteamClubEmblemSetting(MyclubEmblemKey)
	end
	winMgr:getWindow("MyTeamInfo_ClubName"):setText(MyclubName)
	winMgr:getWindow("MyTeamInfo_Master"):setText(MyclubMasterName)
	winMgr:getWindow("MyTeamInfo_Level"):setText(MyclubLevel)
	winMgr:getWindow("MyTeamInfo_Rank"):setText(MyclubRank)
end

--------------------------------------------------
---마이 클럽 엠블렘 세팅--------------------------
--------------------------------------------------
function MyteamClubEmblemSetting(ClubEmblem)
	winMgr:getWindow("MyTeamInfo_ClubEmbelm"):setVisible(true)
	winMgr:getWindow("MyTeamInfo_ClubEmbelm"):setTexture('Enabled', GetClubDirectory(GetLanguageType())..ClubEmblem..".tga", 0, 0)
	winMgr:getWindow("MyTeamInfo_ClubEmbelm"):setTexture('Disabled',GetClubDirectory(GetLanguageType())..ClubEmblem..".tga", 0, 0)
	winMgr:getWindow("MyTeamInfo_ClubEmbelm"):setSize(32, 32)
	winMgr:getWindow("MyTeamInfo_ClubEmbelm"):setScaleWidth(255)
	winMgr:getWindow("MyTeamInfo_ClubEmbelm"):setScaleHeight(255)	
end


----------------------------------------------
--- 마이 클럽 팀 리스트  페이지텍스트---------
----------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyClubTeamList_PageText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 16)
mywindow:setPosition(285, 290)
mywindow:setSize(80, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:clearTextExtends()
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('ClubLobby_MyTeamListBackImage'):addChildWindow(mywindow)

---------------------------------------
---마이 클럽 팀 리스트 페이지앞뒤버튼--
---------------------------------------
local MyClubTeamList_BtnName  = {["err"]=0, [0]="MyClubTeamList_LBtn", "MyClubTeamList_RBtn"}
local MyClubTeamList_BtnTexX  = {["err"]=0, [0]= 427, 454}
local MyClubTeamList_BtnPosX  = {["err"]=0, [0]= 260, 370}
local MyClubTeamList_BtnEvent = {["err"]=0, [0]= "OnClickMyClubTeam_PrevPage", "OnClickMyClubTeam_NextPage"}
for i=0, #MyClubTeamList_BtnName do
	mywindow = winMgr:createWindow("TaharezLook/Button", MyClubTeamList_BtnName[i])
	mywindow:setTexture("Normal", "UIData/fightclub_004.tga", MyClubTeamList_BtnTexX[i], 493)
	mywindow:setTexture("Hover", "UIData/fightclub_004.tga", MyClubTeamList_BtnTexX[i], 520)
	mywindow:setTexture("Pushed", "UIData/fightclub_004.tga",MyClubTeamList_BtnTexX[i], 547)
	mywindow:setTexture("PushedOff", "UIData/fightclub_004.tga", MyClubTeamList_BtnTexX[i], 547)
	mywindow:setPosition(MyClubTeamList_BtnPosX[i], 285)
	mywindow:setSize(27, 27)
	mywindow:setAlwaysOnTop(true)
	mywindow:setSubscribeEvent("Clicked", MyClubTeamList_BtnEvent[i])
	winMgr:getWindow('ClubLobby_MyTeamListBackImage'):addChildWindow(mywindow)
end

----------------------------------------
---마이 클럽 팀 리스트 이전페이지이벤트-
----------------------------------------
		 
function  OnClickMyClubTeam_PrevPage()
   
	if	g_MyClubTeamListPage > 1 then
			g_MyClubTeamListPage = g_MyClubTeamListPage - 1
			SaveCurrentPage(g_MyClubTeamListPage)
			RefreshMyClubTeamList(g_MyClubTeamListMaxPage, g_MyClubTeamListMaxPage)
	end
	
end

----------------------------------------
---마이 클럽 팀 리스트다음페이지이벤트--
----------------------------------------
function OnClickMyClubTeam_NextPage()
  
	if	g_MyClubTeamListPage < g_MyClubTeamListMaxPage then
			g_MyClubTeamListPage = g_MyClubTeamListPage + 1  
			SaveCurrentPage(g_MyClubTeamListPage)
			RefreshMyClubTeamList(g_MyClubTeamListPage , g_MyClubTeamListMaxPage)
	end
	
end

function RefreshMyClubTeamList(CurrentSize , MaxSize)
	
	g_MyClubTeamListMaxPage = MaxSize
	g_MyClubTeamListPage = CurrentSize
	if g_MyClubTeamListPage > g_MyClubTeamListMaxPage then
		g_MyClubTeamListPage = g_MyClubTeamListMaxPage
	end
	winMgr:getWindow('MyClubTeamList_PageText'):clearTextExtends()
	winMgr:getWindow('MyClubTeamList_PageText'):addTextExtends(tostring(g_MyClubTeamListPage)..' / '..tostring(g_MyClubTeamListMaxPage), g_STRING_FONT_GULIMCHE, 114,    230,230,230,255,     0,     0,0,0,255)
	
end
----------------------------------------------
---마이 클럽멤버 페이지텍스트-----------------
----------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyClubMemberList_PageText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 16)
mywindow:setPosition(84, 295)
mywindow:setSize(80, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:clearTextExtends()
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('ClubLobby_MyGangBackImage'):addChildWindow(mywindow)


--------------------------------------------------
---마이 클럽멤버 페이지앞뒤버튼-------------------
--------------------------------------------------
local MyClubMemberList_BtnName  = {["err"]=0, [0]="MyClubMemberList_LBtn", "MyClubMemberList_RBtn"}
local MyClubMemberList_BtnTexX  = {["err"]=0, [0]= 374, 392}
local MyClubMemberList_BtnPosX  = {["err"]=0, [0]= 65, 163}
local MyClubMemberList_BtnEvent = {["err"]=0, [0]= "OnClickMyMember_PrevPage", "OnClickMyMember_NextPage"}
for i=0, #MyClubMemberList_BtnName do
	mywindow = winMgr:createWindow("TaharezLook/Button", MyClubMemberList_BtnName[i])
	mywindow:setTexture("Normal", "UIData/fightclub_004.tga", MyClubMemberList_BtnTexX[i], 679)
	mywindow:setTexture("Hover", "UIData/fightclub_004.tga", MyClubMemberList_BtnTexX[i], 697)
	mywindow:setTexture("Pushed", "UIData/fightclub_004.tga", MyClubMemberList_BtnTexX[i], 715)
	mywindow:setTexture("PushedOff", "UIData/fightclub_004.tga", MyClubMemberList_BtnTexX[i],  715)
	mywindow:setPosition(MyClubMemberList_BtnPosX[i], 292)
	mywindow:setSize(18, 18)
	mywindow:setSubscribeEvent("Clicked", MyClubMemberList_BtnEvent[i])
	winMgr:getWindow('ClubLobby_MyGangBackImage'):addChildWindow(mywindow)
end

------------------------------------
---이전페이지이벤트-------------------
------------------------------------
		 
function  OnClickMyMember_PrevPage()
     
     DebugStr('OnClickMyMember_PrevPage');
   
	if	g_MyClubListPage > 1 then
			g_MyClubListPage = g_MyClubListPage - 1
            RefreshMyClubMemberList()
	end
	
end
------------------------------------
---다음페이지이벤트-----------------
------------------------------------
function OnClickMyMember_NextPage()
  
	DebugStr('OnClickMailItemList_NextPage');
	 
	if	g_MyClubListPage < g_MaxClubListPage then
			g_MyClubListPage = g_MyClubListPage + 1
            RefreshMyClubMemberList()
	end
	
end


----------------------------------------------
---팀 목록  페이지텍스트----------------------
----------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "TeamList_PageText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 16)
mywindow:setPosition(210, 305)
mywindow:setSize(80, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:clearTextExtends()
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('ClubLobby_TeamBackImage'):addChildWindow(mywindow)
-----------------------------------------------
---팀 목록 페이지앞뒤버튼----------------------
-----------------------------------------------
local TeamList_BtnName  = {["err"]=0, [0]="TeamList_LBtn", "TeamList_RBtn"}
local TeamList_BtnTexX  = {["err"]=0, [0]= 427, 454}
local TeamrList_BtnPosX  = {["err"]=0, [0]= 180, 290}
local TeamList_BtnEvent = {["err"]=0, [0]= "OnClickTeam_PrevPage", "OnClickTeam_NextPage"}
for i=0, #TeamList_BtnName do
	mywindow = winMgr:createWindow("TaharezLook/Button",TeamList_BtnName[i])
	mywindow:setTexture("Normal", "UIData/fightclub_004.tga", TeamList_BtnTexX[i], 493)
	mywindow:setTexture("Hover", "UIData/fightclub_004.tga", TeamList_BtnTexX[i], 520)
	mywindow:setTexture("Pushed", "UIData/fightclub_004.tga",TeamList_BtnTexX[i], 547)
	mywindow:setTexture("PushedOff", "UIData/fightclub_004.tga", TeamList_BtnTexX[i], 547)
	mywindow:setPosition(TeamrList_BtnPosX[i], 300)
	mywindow:setSize(27, 27)
	mywindow:setSubscribeEvent("Clicked", TeamList_BtnEvent[i])
	winMgr:getWindow('ClubLobby_TeamBackImage'):addChildWindow(mywindow)
end

------------------------------------
---팀 목록 이전페이지이벤트---------
------------------------------------
		 
function  OnClickTeam_PrevPage()
     
     DebugStr('OnClickTeam_PrevPage');
	if	g_TeamListPage > 1 then
			g_TeamListPage = g_TeamListPage - 1
			SaveListCurrentPage(g_TeamListPage)
            RefreshTeamList(g_TeamListPage , g_TeamListMaxPage)
	end
	
end
------------------------------------
---팀 목록 다음페이지이벤트---------
------------------------------------
function OnClickTeam_NextPage()
  
	DebugStr('OnClickTeamList_NextPage');
	if	g_TeamListPage < g_TeamListMaxPage then
			g_TeamListPage = g_TeamListPage + 1
			SaveListCurrentPage(g_TeamListPage)
            RefreshTeamList(g_TeamListPage , g_TeamListMaxPage)
	end
	
end

function RefreshTeamList(CurrentPage , MaxPage)
	g_TeamListMaxPage = MaxPage
	g_TeamListPage = CurrentPage
	if g_TeamListPage > g_TeamListMaxPage then
		g_TeamListPage = g_TeamListMaxPage
	end
	winMgr:getWindow('TeamList_PageText'):clearTextExtends()
	winMgr:getWindow('TeamList_PageText'):addTextExtends(tostring(g_TeamListPage)..' / '..tostring(g_TeamListMaxPage), g_STRING_FONT_GULIMCHE, 114,    230,230,230,255,     0,     0,0,0,255)
	
end

----------------팀을 생성시
function OnClickCreateTeam(args)
	DebugStr('OnClickCreateTeam start');
	str_name = "hihi"
	ShowCommonAlertOkCancelBoxWithFunction("", PreCreateString_2266,  'OnClickCreateTeamOk', 'OnClickCreateTeamCancel');
	DebugStr('OnClickCreateTeam end');			--GetSStringInfo(LAN_CLUBMATCH_CREATETEAM)
end

----------------팀을 등록시
function OnClickRegistTeam(args)
	DebugStr('OnClickRegistTeam start');
	local leaderName = winMgr:getWindow("MyTeamMemberText1"):getText()
	-- 자신이 방장이 아닐경우 리턴
	if My_LobbyCharacterName ~= leaderName then
		ShowCommonAlertOkBoxWithFunction(PreCreateString_2285,'OnClickAlertOkSelfHide');
											--GetSStringInfo(LAN_ENABLE_TEAMLEADER)
		return
	end
	ShowCommonAlertOkCancelBoxWithFunction("", PreCreateString_2267,  'OnClickRegistTeamOk', 'OnClickRegistTeamCancel');
	DebugStr('OnClickRegistTeam end');			--GetSStringInfo(LAN_CLUBMATCH_REGISTTEAM)
end
-------------팀등록 취소시
function OnClickCancelTeam(args)
	DebugStr('OnClickCancelTeam start');
	local leaderName = winMgr:getWindow("MyTeamMemberText1"):getText()
	-- 자신이 방장이 아닐경우 리턴
	if My_LobbyCharacterName ~= leaderName then
		ShowCommonAlertOkBoxWithFunction(PreCreateString_2285,'OnClickAlertOkSelfHide');
		return								--GetSStringInfo(LAN_ENABLE_TEAMLEADER)
	end
	ShowCommonAlertOkCancelBoxWithFunction("", PreCreateString_2284,  'OnClickCancelTeamOk', 'OnClickCancelTeamCancel');
	DebugStr('OnClickCancelTeam end');			--GetSStringInfo(LAN_CLUBMATCH_UNREGIST)
end

----------------팀에 가입시
function OnClickJoinTeam(args)
	DebugStr('OnClickJoinTeam start');	
	local index = tonumber(CEGUI.toWindowEventArgs(args).window:getUserString("JoinIndex"))
	DebugStr('index:'..index);
	local realindex = tonumber(index + (g_MyClubTeamListPage * 8) - 8)
	DebugStr('realindex:'..realindex)
	JoinClubTeam(index)
	DebugStr('OnClickJoinTeam end');
end
----------------팀을 탈퇴시
function OnClickOutTeam(args)
	DebugStr('OnClickOutTeam start');
	ShowCommonAlertOkCancelBoxWithFunction("", PreCreateString_2269,  'OnClickOutTeamOk', 'OnClickOutTeamCancel');
	DebugStr('OnClickOutTeam end');				--GetSStringInfo(LAN_CLUBMATCH_OUT)
end

--------------팀매치 신청왔을시
function OnClickClubMacth(clubname, leadername)
	DebugStr('OnClickClubMacth start');
	ClubCommonAlertRejectBoxWithFunction("", string.format(PreCreateString_2271, clubname , leadername),  'OnClickClubMacthOk', 'OnClickClubMacthCancel');
	DebugStr('OnClickClubMacth end');						--GetSStringInfo(LAN_CLUBMATCH_PROPOSE)
end

-------------팀매치 신청시
function OnClickRequestClubMacth(args)
	DebugStr('OnClickRequestClubMacth start');
	local leaderName = winMgr:getWindow("MyTeamMemberText1"):getText()
	-- 자신이 방장이 아닐경우 리턴
	if My_LobbyCharacterName ~= leaderName then
		ShowCommonAlertOkBoxWithFunction(PreCreateString_2285,'OnClickAlertOkSelfHide');
		return								--GetSStringInfo(LAN_ENABLE_TEAMLEADER)
	end
	local index = tonumber(CEGUI.toWindowEventArgs(args).window:getUserString("MatchIndex"))
	
	local realindex = tonumber(index + (g_TeamListPage * 10) - 10)
	ReqeustClubMatch(realindex)
	DebugStr('OnClickRequestClubMacth end');
end

function ClubMatchMsg(MatchId)
	local systemMessage = '[!] '..string.format(PreCreateString_2310, MatchId)	--GetSStringInfo(LAN_PROPOSE_CLUBMACTH_SEND)
	OnChatPublic(systemMessage, 5, 0)
end

---팀 생성 확인
function OnClickCreateTeamOk(args) 
	DebugStr('OnClickFriendDeleteQuestOk start');
	
	local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "OnClickCreateTeamOk" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
	local_window:setProperty('Visible', 'False');
	CreateClubTeam()
	
end


--- 팀 생성 취소
function OnClickCreateTeamCancel(args)  
	DebugStr('OnClickCreateTeamCancel start');
	
	local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
	if nofunc ~= "OnClickCreateTeamCancel" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
	local_window:setVisible(false)
	
	DebugStr('OnClickFriendDeleteQuestCancel end');
end


---팀 등록 확인
function OnClickRegistTeamOk(args) 
	DebugStr('OnClickRegistTeamOk start');
	
	local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "OnClickRegistTeamOk" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
	local_window:setProperty('Visible', 'False');
	RegistClubTeam()
end


--- 팀 등록 취소
function OnClickRegistTeamCancel(args)  
	DebugStr('OnClickRegistTeamCancel start');
	
	local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
	if nofunc ~= "OnClickRegistTeamCancel" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
	local_window:setVisible(false)
	DebugStr('OnClickRegistTeamCancel end');
end


---팀 등록 취소하기(등록된상태에서)
function OnClickCancelTeamOk(args) 
	DebugStr('OnClickCancelTeamOk start');
	
	local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "OnClickCancelTeamOk" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
	local_window:setProperty('Visible', 'False');
	RegistCancelClubTeam()
end


--- 팀 등록 취소를 취소
function OnClickCancelTeamCancel(args)  
	DebugStr('OnClickCancelTeamCancel start');
	
	local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
	if nofunc ~= "OnClickCancelTeamCancel" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
	local_window:setVisible(false)
	DebugStr('OnClickCancelTeamCancel end');
end
-- 팀 가입 확인

function OnClickJoinTeamOk(args) 
	DebugStr('OnClickJoinTeamOk start');
	
	local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "OnClickJoinTeamOk" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
	local_window:setProperty('Visible', 'False');
	local index = tonumber(CEGUI.toWindowEventArgs(args).window:getUserString("JoinIndex"))
	
	
end


-- 팀 가입 취소
function OnClickJoinTeamCancel(args) 
	DebugStr('OnClickJoinTeamCancel start');
	
	local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
	if nofunc ~= "OnClickJoinTeamCancel" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
	local_window:setVisible(false)
	
	DebugStr('OnClickJoinTeamCancel end');
end


-- 팀 탈퇴 확인

function OnClickOutTeamOk(args) 
	DebugStr('OnClickJoinTeamOk start');
	
	local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "OnClickOutTeamOk" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
	local_window:setProperty('Visible', 'False');
	OutClubTeam()
	
end


-- 팀 탈퇴 취소
function OnClickOutTeamCancel(args) 
	DebugStr('OnClickJoinTeamCancel start');
	
	local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
	if nofunc ~= "OnClickOutTeamCancel" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
	local_window:setVisible(false)
	
	DebugStr('OnClickOutTeamCancel end');
end

-- 팀 매치 수락

function OnClickClubMacthOk(args) 
	DebugStr('OnClickClubMacthOk start');
	
	local okfunc = winMgr:getWindow('CommonAlertOkCancelBox3'):getUserString("okFunction")
	if okfunc ~= "OnClickClubMacthOk" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox3'):setUserString("okFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('ClubAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('ClubAlertAlphaImg') );
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox3');
	winMgr:getWindow('ClubAlertAlphaImg'):removeChildWindow( local_window );
	local_window:setProperty('Visible', 'False');
	ResponseClubMatch()
	
end


-- 팀 매치 거절
function OnClickClubMacthCancel(args)  
	DebugStr('OnClickClubMacthCancel start');
	
	local nofunc = winMgr:getWindow('CommonAlertOkCancelBox3'):getUserString("noFunction")
	if nofunc ~= "OnClickClubMacthCancel" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox3'):setUserString("noFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('ClubAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('ClubAlertAlphaImg') );
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox3');
	winMgr:getWindow('ClubAlertAlphaImg'):removeChildWindow( local_window );
	local_window:setVisible(false)
	MatchClubName , MatchLeaderName = GetMatchListSize()
	if MatchClubName == "" then
		return
	end
	OnClickClubMacth(MatchClubName, MatchLeaderName)
	DebugStr('OnClickClubMacthCancel end');
end

-- Ui를 두개중에 선택
function SelectedLobbyUI(bNumber)
	if bNumber == 0 then
		winMgr:getWindow('ClubLobby_MyGangBackImage'):setVisible(false)
		winMgr:getWindow('ClubLobby_MyTeamListBackImage'):setVisible(true)
	else
		winMgr:getWindow('ClubLobby_MyTeamListBackImage'):setVisible(false)
		winMgr:getWindow('ClubLobby_MyGangBackImage'):setVisible(true)
	end
end

-- 팀원 목록을 업데이트 해준다
function RefreshMyTeamInfo(index , MemberName)
	winMgr:getWindow(MyTeamMemberText[index+1]):setText(MemberName)
end

-- 자신의 이름을 얻어온다 
function Setting_LobbyMyName(MyCharacterName)
	My_LobbyCharacterName = MyCharacterName
	DebugStr('My_LobbyCharacterName:'..My_LobbyCharacterName)
end

function Setting_MyClubName(MyClubNAME)
	myClubName = MyClubNAME
end


-- 팀 등록 버튼을 감추기/보이기
function ShowResigstBtn(bnum)
	local leaderName = winMgr:getWindow("MyTeamMemberText1"):getText()
	DebugStr('leaderName:'..leaderName)
	DebugStr('My_LobbyCharacterName:'..My_LobbyCharacterName)
	if bnum == 0 then
		winMgr:getWindow('MyTeamRegistBtn'):setVisible(false)  -- 버튼 숨기기
		winMgr:getWindow('MyTeamRegistCancelBtn'):setVisible(true)
		if My_LobbyCharacterName ~= leaderName then
			winMgr:getWindow('MyTeamRegistCancelBtn'):setEnabled(false)
		else
			winMgr:getWindow('MyTeamRegistCancelBtn'):setEnabled(true)
		end
	else
		winMgr:getWindow('MyTeamRegistCancelBtn'):setVisible(false)
		winMgr:getWindow('MyTeamRegistBtn'):setVisible(true)	
		if My_LobbyCharacterName ~= leaderName then
			winMgr:getWindow('MyTeamRegistBtn'):setEnabled(false)
		else
			winMgr:getWindow('MyTeamRegistBtn'):setEnabled(true)
		end
	end
	 
end



---------------------------------------------------------------------
-- 클럽전 추가 이미지들
---------------------------------------------------------------------

------------------------------------------------------------------------------------
----- 클럽전 유저 리스트 (로비에에 접속한 사람들) 백판 
------------------------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ClubLobby_UserBackImage")
mywindow:setTexture("Enabled", "UIData/messenger2.tga", 0, 767)
mywindow:setTexture("Disabled", "UIData/messenger2.tga", 0, 767)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(450 ,470);
mywindow:setSize(631, 257)
mywindow:setEnabled(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(true)
mywindow:setSubscribeEvent('MouseButtonDown', 'ClubLobbyMouseClick');
root:addChildWindow(mywindow)

------------------------------------------------------------------------------------
----- 로비에 들어온 유저리스트 목록 
------------------------------------------------------------------------------------
Lobby_User_Radio = 
{ ["protecterr"]=0, "Lobby_User_Radio1", "Lobby_User_Radio2", "Lobby_User_Radio3" , "Lobby_User_Radio4", "Lobby_User_Radio5"}
	
	
Lobby_User_Text	= {['err'] = 0, 'UserClub', 'UserLevel' , 'UserName' , 'EmblemKey'}
								
Lobby_User_PosX		= {['err'] = 0, 250, 47 , 145 , 200}
Lobby_User_PosY		= {['err'] = 0, 5, 5, 5, 5 }
Lobby_User_SizeX	= {['err'] = 0, 5, 5 ,5, 5 }
Lobby_User_SizeY	= {['err'] = 0, 5, 5 ,5, 5}
Lobby_User_SetText		= {['err'] = 0, 'clubname', '11' ,'username', ''}



for i=1, #Lobby_User_Radio do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton",	Lobby_User_Radio[i])
	mywindow:setTexture("Normal", "UIData/invisible.tga",		522, 471)    
	mywindow:setTexture("Hover", "UIData/fightClub_004.tga",		520, 735)
	mywindow:setTexture("Pushed", "UIData/fightClub_004.tga",		522, 757)
	mywindow:setTexture("PushedOff", "UIData/fightClub_004.tga",	522, 757)
	mywindow:setTexture("SelectedNormal", "UIData/fightClub_004.tga",	 522, 757)
	mywindow:setTexture("SelectedHover", "UIData/fightClub_004.tga",	 522, 757)
	mywindow:setTexture("SelectedPushed", "UIData/fightClub_004.tga",	 522, 757)
	mywindow:setTexture("SelectedPushedOff", "UIData/fightClub_004.tga", 522, 757)
	mywindow:setTexture("Disabled", "UIData/invisible.tga",			522, 471);
	mywindow:setSize(227, 22)
	mywindow:setPosition(5, 75+26*(i-1))
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true)
	mywindow:subscribeEvent("MouseRButtonUp", "OnClickUserMouseRButtonUp")
	mywindow:subscribeEvent("SelectStateChanged","RefreshLobbyPopupButton")
	mywindow:subscribeEvent("MouseButtonDown","RefreshLobbyPopupButton")
	winMgr:getWindow('ClubLobby_UserBackImage'):addChildWindow(mywindow)
	
	--  레벨 , 이름 , 클래스 , 엠블렘키
	for j=1, #Lobby_User_Text do
		local child_window = winMgr:createWindow("TaharezLook/StaticText", Lobby_User_Radio[i]..Lobby_User_Text[j])	
		child_window:setProperty("FrameEnabled", "false")
		child_window:setProperty("BackgroundEnabled", "false")
		child_window:setSize(Lobby_User_SizeX[j], Lobby_User_SizeY[j])
		child_window:setVisible(true)
		child_window:setPosition(Lobby_User_PosX[j], Lobby_User_PosY[j])
		child_window:setViewTextMode(1)	
		child_window:setAlign(8)
		child_window:setLineSpacing(1)
		--child_window:addTextExtends(Lobby_User_SetText[j], g_STRING_FONT_GULIMCHE, 112,    255,255,255,255,     0,     0,0,0,255)
		mywindow:addChildWindow(child_window)
	end
	
	--  클럽 엠블렘 이미지
	child_window = winMgr:createWindow('TaharezLook/StaticImage', Lobby_User_Radio[i]..'ClubEmbleImage')
	child_window:setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
	child_window:setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
	child_window:setProperty('BackgroundEnabled', 'False')
	child_window:setProperty('FrameEnabled', 'False')
	child_window:setPosition(4, 1)
	child_window:setScaleWidth(163)
	child_window:setScaleHeight(163)
	child_window:setSize(32, 32)
	child_window:setEnabled(false)
	child_window:setVisible(true)
	child_window:setZOrderingEnabled(false)
	mywindow:addChildWindow(child_window)
end


function Reset_LobbyUserList()
	for i=1, #Lobby_User_Radio do
		winMgr:getWindow(Lobby_User_Radio[i]):setEnabled(false)
		winMgr:getWindow(Lobby_User_Radio[i]..'ClubEmbleImage'):setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
		winMgr:getWindow(Lobby_User_Radio[i]..'ClubEmbleImage'):setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
		
		for j=1 , #Lobby_User_Text do
			winMgr:getWindow(Lobby_User_Radio[i]..Lobby_User_Text[j]):clearTextExtends()
		end
	end
end



------------------------------------------------------------------------------------
----- 매치중인 클럽 vs 목록 
------------------------------------------------------------------------------------
Lobby_matching_Radio = 
{ ["protecterr"]=0, "Lobby_matching_Radio1", "Lobby_matching_Radio2", "Lobby_matching_Radio3" , "Lobby_matching_Radio4", "Lobby_matching_Radio5"}
	
	
Lobby_matching_Text	= {['err'] = 0, 'ClubName1', 'ClubName2' }
								
Lobby_matching_PosX		= {['err'] = 0, 33, 203 }
Lobby_matching_PosY		= {['err'] = 0, 3, 3 }
Lobby_matching_SizeX	= {['err'] = 0, 5, 5 }
Lobby_matching_SizeY	= {['err'] = 0, 5, 5 }
Lobby_matching_SetText		= {['err'] = 0, 'aaaaaaaaaaaaaa', 'aaaaaaaaaaaaaa'}



for i=1, #Lobby_matching_Radio do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton",	Lobby_matching_Radio[i])
	mywindow:setTexture("Normal", "UIData/invisible.tga",		522, 471)    
	mywindow:setTexture("Hover", "UIData/invisible.tga",		522, 415)
	mywindow:setTexture("Pushed", "UIData/invisible.tga",		522, 443)
	mywindow:setTexture("PushedOff", "UIData/invisible.tga",	522, 443)
	mywindow:setTexture("SelectedNormal", "UIData/invisible.tga",	 522, 443)
	mywindow:setTexture("SelectedHover", "UIData/invisible.tga",	 522, 443)
	mywindow:setTexture("SelectedPushed", "UIData/invisible.tga",	 522, 443)
	mywindow:setTexture("SelectedPushedOff", "UIData/invisible.tga", 522, 443)
	mywindow:setTexture("Disabled", "UIData/invisible.tga",			522, 471);
	
	mywindow:setSize(315, 22)
	mywindow:setPosition(240,75+26*(i-1))
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true)
	winMgr:getWindow('ClubLobby_UserBackImage'):addChildWindow(mywindow)
	
	for j=1, #Lobby_matching_Text do
		local child_window = winMgr:createWindow("TaharezLook/StaticText", Lobby_matching_Radio[i]..Lobby_matching_Text[j])	
		child_window:setProperty("FrameEnabled", "false")
		child_window:setProperty("BackgroundEnabled", "false")
		child_window:setSize(Lobby_matching_SizeX[j], Lobby_matching_SizeY[j])
		child_window:setVisible(true)
		child_window:setPosition(Lobby_matching_PosX[j], Lobby_matching_PosY[j])
		child_window:setViewTextMode(1)	
		child_window:setAlign(0)
		child_window:setLineSpacing(1)
		mywindow:addChildWindow(child_window)
	end
	
	--  클럽 엠블렘 이미지
	child_window = winMgr:createWindow('TaharezLook/StaticImage', Lobby_matching_Radio[i]..'ClubEmbleImage1')
	child_window:setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
	child_window:setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
	child_window:setProperty('BackgroundEnabled', 'False')
	child_window:setProperty('FrameEnabled', 'False')
	child_window:setPosition(3, 1)
	child_window:setScaleWidth(163)
	child_window:setScaleHeight(163)
	child_window:setSize(32, 32)
	child_window:setEnabled(false)
	child_window:setVisible(true)
	child_window:setZOrderingEnabled(false)
	mywindow:addChildWindow(child_window)
	
	--  클럽 엠블렘 이미지
	child_window = winMgr:createWindow('TaharezLook/StaticImage', Lobby_matching_Radio[i]..'ClubEmbleImage2')
	child_window:setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
	child_window:setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
	child_window:setProperty('BackgroundEnabled', 'False')
	child_window:setProperty('FrameEnabled', 'False')
	child_window:setPosition(173, 1)
	child_window:setScaleWidth(163)
	child_window:setScaleHeight(163)
	child_window:setSize(32, 32)
	child_window:setEnabled(false)
	child_window:setVisible(true)
	child_window:setZOrderingEnabled(false)
	mywindow:addChildWindow(child_window)
end


function Reset_LobbyMatchingList()
	for i=1, #Lobby_matching_Radio do
		winMgr:getWindow(Lobby_matching_Radio[i]):setEnabled(false)
		winMgr:getWindow(Lobby_matching_Radio[i]..'ClubEmbleImage1'):setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
		winMgr:getWindow(Lobby_matching_Radio[i]..'ClubEmbleImage1'):setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
		
		winMgr:getWindow(Lobby_matching_Radio[i]):setEnabled(false)
		winMgr:getWindow(Lobby_matching_Radio[i]..'ClubEmbleImage2'):setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
		winMgr:getWindow(Lobby_matching_Radio[i]..'ClubEmbleImage2'):setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
		
		for j=1 , #Lobby_matching_Text do
			winMgr:getWindow(Lobby_matching_Radio[i]..Lobby_matching_Text[j]):clearTextExtends()
		end
	end
end


function Setting_UserList(LobbyUserIndex , LobbyUserLevel, LobbyUserClubName , LobbyUserName , UserEmblemKey)
	winMgr:getWindow(Lobby_User_Radio[LobbyUserIndex]):setEnabled(true)
	for i=1, #Lobby_User_Text do
		winMgr:getWindow(Lobby_User_Radio[LobbyUserIndex]..Lobby_User_Text[i]):clearTextExtends()
	end
	
	winMgr:getWindow(Lobby_User_Radio[LobbyUserIndex]..Lobby_User_Text[2]):addTextExtends(LobbyUserLevel, g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
	winMgr:getWindow(Lobby_User_Radio[LobbyUserIndex]..Lobby_User_Text[3]):addTextExtends(LobbyUserName, g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
	winMgr:getWindow(Lobby_User_Radio[LobbyUserIndex]..Lobby_User_Text[3]):setText(LobbyUserName)
	
	-- 엠블렘 설정
	if UserEmblemKey > 0 then
		winMgr:getWindow(Lobby_User_Radio[LobbyUserIndex]..'ClubEmbleImage'):setTexture('Enabled',  GetClubDirectory(GetLanguageType())..UserEmblemKey..".tga", 0, 0)
		winMgr:getWindow(Lobby_User_Radio[LobbyUserIndex]..'ClubEmbleImage'):setTexture('Disabled', GetClubDirectory(GetLanguageType())..UserEmblemKey..".tga", 0, 0)
		
	else
		winMgr:getWindow(Lobby_User_Radio[LobbyUserIndex]..'ClubEmbleImage'):setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
		winMgr:getWindow(Lobby_User_Radio[LobbyUserIndex]..'ClubEmbleImage'):setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
	end
	
end


function Setting_MatchingList(LobbyMatchingIndex , LobbyMatchingEmblem1, LobbyMatchingEmblem2 , LobbyMatchingClub1 , LobbyMatchingClub2)
	
	winMgr:getWindow(Lobby_matching_Radio[LobbyMatchingIndex]):setEnabled(true)
	for i=1, #Lobby_matching_Text do
		winMgr:getWindow(Lobby_matching_Radio[LobbyMatchingIndex]..Lobby_matching_Text[i]):clearTextExtends()
	end
	
	winMgr:getWindow(Lobby_matching_Radio[LobbyMatchingIndex]..Lobby_matching_Text[1]):addTextExtends(LobbyMatchingClub1, g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
	winMgr:getWindow(Lobby_matching_Radio[LobbyMatchingIndex]..Lobby_matching_Text[2]):addTextExtends(LobbyMatchingClub2, g_STRING_FONT_GULIMCHE, 112,    230,230,230,255,     0,     0,0,0,255)
	
	
	-- 엠블렘 설정
	if LobbyMatchingEmblem1 > 0 then
		winMgr:getWindow(Lobby_matching_Radio[LobbyMatchingIndex]..'ClubEmbleImage1'):setTexture('Enabled',  GetClubDirectory(GetLanguageType())..LobbyMatchingEmblem1..".tga", 0, 0)
		winMgr:getWindow(Lobby_matching_Radio[LobbyMatchingIndex]..'ClubEmbleImage1'):setTexture('Disabled', GetClubDirectory(GetLanguageType())..LobbyMatchingEmblem1..".tga", 0, 0)
	
	else
		winMgr:getWindow(Lobby_matching_Radio[LobbyMatchingIndex]..'ClubEmbleImage1'):setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
		winMgr:getWindow(Lobby_matching_Radio[LobbyMatchingIndex]..'ClubEmbleImage1'):setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
	end
	
	if LobbyMatchingEmblem2 > 0 then
		winMgr:getWindow(Lobby_matching_Radio[LobbyMatchingIndex]..'ClubEmbleImage2'):setTexture('Enabled',  GetClubDirectory(GetLanguageType())..LobbyMatchingEmblem2..".tga", 0, 0)
		winMgr:getWindow(Lobby_matching_Radio[LobbyMatchingIndex]..'ClubEmbleImage2'):setTexture('Disabled', GetClubDirectory(GetLanguageType())..LobbyMatchingEmblem2..".tga", 0, 0)
	
	else
		winMgr:getWindow(Lobby_matching_Radio[LobbyMatchingIndex]..'ClubEmbleImage2'):setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
		winMgr:getWindow(Lobby_matching_Radio[LobbyMatchingIndex]..'ClubEmbleImage2'):setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
	end
end


---------------------------------------
---로비 유저 리스트 페이지 앞뒤버튼--
---------------------------------------
local LobbyUser_BtnName  = {["err"]=0, [0]="LobbyUser_LBtn", "LobbyUser_RBtn"}
local LobbyUser_BtnTexX  = {["err"]=0, [0]= 374, 392}
local LobbyUser_BtnPosX  = {["err"]=0, [0]= 65, 160}
local LobbyUser_BtnEvent = {["err"]=0, [0]= "LobbyUser_PrevPage", "LobbyUser_NextPage"}
for i=0, #LobbyUser_BtnEvent do
	mywindow = winMgr:createWindow("TaharezLook/Button", LobbyUser_BtnName[i])
	mywindow:setTexture("Normal", "UIData/fightclub_004.tga", LobbyUser_BtnTexX[i], 679)
	mywindow:setTexture("Hover", "UIData/fightclub_004.tga", LobbyUser_BtnTexX[i], 697)
	mywindow:setTexture("Pushed", "UIData/fightclub_004.tga",LobbyUser_BtnTexX[i], 715)
	mywindow:setTexture("PushedOff", "UIData/fightclub_004.tga", LobbyUser_BtnTexX[i], 679)
	mywindow:setPosition(LobbyUser_BtnPosX[i], 205)
	mywindow:setSize(18, 18)
	mywindow:setAlwaysOnTop(true)
	mywindow:setSubscribeEvent("Clicked", LobbyUser_BtnEvent[i])
	mywindow:addTextExtends(tostring(g_lobbyUserPage)..' / '..tostring(g_lobbyUserMaxPage), g_STRING_FONT_GULIMCHE, 114,    230,230,230,255,     0,     0,0,0,255)
	winMgr:getWindow('ClubLobby_UserBackImage'):addChildWindow(mywindow)
end

mywindow = winMgr:createWindow("TaharezLook/StaticText", "LobbyUser_PageText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 16)
mywindow:setPosition(85, 207)
mywindow:setSize(80, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:clearTextExtends()
mywindow:setZOrderingEnabled(false)
mywindow:addTextExtends(tostring(g_lobbyUserPage)..' / '..tostring(g_lobbyUserMaxPage), g_STRING_FONT_GULIMCHE, 114,    230,230,230,255,     0,     0,0,0,255)
winMgr:getWindow('ClubLobby_UserBackImage'):addChildWindow(mywindow)
---------------------------------------
---로비 매칭 페이지 앞뒤버튼--
---------------------------------------
local Matching_BtnName  = {["err"]=0, [0]="Matching_LBtn", "Matching_RBtn"}
local Matching_BtnTexX  = {["err"]=0, [0]= 374, 392}
local Matching_BtnPosX  = {["err"]=0, [0]= 290, 390}
local Matching_BtnEvent = {["err"]=0, [0]= "Matching_PrevPage", "Matching_NextPage"}
for i=0, #Matching_BtnName do
	mywindow = winMgr:createWindow("TaharezLook/Button", Matching_BtnName[i])
	mywindow:setTexture("Normal", "UIData/fightclub_004.tga", Matching_BtnTexX[i], 679)
	mywindow:setTexture("Hover", "UIData/fightclub_004.tga", Matching_BtnTexX[i], 697)
	mywindow:setTexture("Pushed", "UIData/fightclub_004.tga",Matching_BtnTexX[i], 715)
	mywindow:setTexture("PushedOff", "UIData/fightclub_004.tga", Matching_BtnTexX[i], 679)
	mywindow:setPosition(Matching_BtnPosX[i], 205)
	mywindow:setSize(18, 18)
	mywindow:setAlwaysOnTop(true)
	mywindow:setSubscribeEvent("Clicked", Matching_BtnEvent[i])
	winMgr:getWindow('ClubLobby_UserBackImage'):addChildWindow(mywindow)
end

mywindow = winMgr:createWindow("TaharezLook/StaticText", "Matching_PageText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 16)
mywindow:setPosition(310, 207)
mywindow:setSize(80, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:clearTextExtends()
mywindow:addTextExtends(tostring(g_lobbyUserPage)..' / '..tostring(g_lobbyUserMaxPage), g_STRING_FONT_GULIMCHE, 114,    230,230,230,255,     0,     0,0,0,255)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('ClubLobby_UserBackImage'):addChildWindow(mywindow)


---------------------------------------
---로비 유저 이전페이지 버튼--
---------------------------------------
function LobbyUser_PrevPage()

	if	g_lobbyUserPage  > 1 then
		g_lobbyUserPage = g_lobbyUserPage - 1 
		
		winMgr:getWindow('LobbyUser_PageText'):clearTextExtends()
		winMgr:getWindow('LobbyUser_PageText'):addTextExtends(tostring(g_lobbyUserPage)..' / '..tostring(g_lobbyUserMaxPage), g_STRING_FONT_GULIMCHE, 114,    230,230,230,255,     0,     0,0,0,255)
		ReqeustLobbyUserList(g_lobbyUserPage)
	end
end

---------------------------------------
---로비 유저 다음페이지 버튼--
---------------------------------------
function LobbyUser_NextPage()

	if	g_lobbyUserPage < g_lobbyUserMaxPage  then
		g_lobbyUserPage = g_lobbyUserPage + 1 
		
		winMgr:getWindow('LobbyUser_PageText'):clearTextExtends()
		winMgr:getWindow('LobbyUser_PageText'):addTextExtends(tostring(g_lobbyUserPage)..' / '..tostring(g_lobbyUserMaxPage), g_STRING_FONT_GULIMCHE, 114,    230,230,230,255,     0,     0,0,0,255)
		ReqeustLobbyUserList(g_lobbyUserPage)
	end
end

---------------------------------------
---로비 매칭 이전페이지 버튼--
---------------------------------------
function Matching_PrevPage()
	if	g_lobbyMatchPage  > 1 then
		g_lobbyMatchPage = g_lobbyMatchPage - 1 
		
		winMgr:getWindow('Matching_PageText'):clearTextExtends()
		winMgr:getWindow('Matching_PageText'):addTextExtends(tostring(g_lobbyMatchPage)..' / '..tostring(g_lobbyMatchMaxPage), g_STRING_FONT_GULIMCHE, 114,    230,230,230,255,     0,     0,0,0,255)
		ReqeustMatcthingList(g_lobbyMatchPage)
	end
end

---------------------------------------
---로비 매칭 다음페이지 버튼--
---------------------------------------
function Matching_NextPage()
	if	g_lobbyMatchPage < g_lobbyMatchMaxPage  then
		g_lobbyMatchPage = g_lobbyMatchPage + 1 
		
		winMgr:getWindow('Matching_PageText'):clearTextExtends()
		winMgr:getWindow('Matching_PageText'):addTextExtends(tostring(g_lobbyMatchPage)..' / '..tostring(g_lobbyMatchMaxPage), g_STRING_FONT_GULIMCHE, 114,    230,230,230,255,     0,     0,0,0,255)
		ReqeustMatcthingList(g_lobbyMatchPage)
	end
end

---------------------------------------
---로비 유저 페이지 리세팅
---------------------------------------
function Setting_LobbyUserPageText(Usercurrentpage, Usermaxpage)
	g_lobbyUserPage = Usercurrentpage
	g_lobbyUserMaxPage = Usermaxpage
	winMgr:getWindow('LobbyUser_PageText'):clearTextExtends()
	winMgr:getWindow('LobbyUser_PageText'):addTextExtends(tostring(g_lobbyUserPage)..' / '..tostring(g_lobbyUserMaxPage), g_STRING_FONT_GULIMCHE, 114,    230,230,230,255,     0,     0,0,0,255)
end

---------------------------------------
---로비 매칭 페이지 리세팅
---------------------------------------
function Setting_LobbyMatchingPageText(Matchingcurrentpage, Matchingmaxpage)
	g_lobbyMatchPage = Matchingcurrentpage
	g_lobbyMatchMaxPage = Matchingmaxpage
	winMgr:getWindow('Matching_PageText'):clearTextExtends()
	winMgr:getWindow('Matching_PageText'):addTextExtends(tostring(g_lobbyMatchPage)..' / '..tostring(g_lobbyMatchMaxPage), g_STRING_FONT_GULIMCHE, 114,    230,230,230,255,     0,     0,0,0,255)
end


-------------------------------------------------------------------------------------------
--클럽 매니저 라디오 버튼에 사용되는 팝업 윈도우들 
-------------------------------------------------------------------------------------------

mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'ClubUser_PopupWindow');
mywindow:setPosition(773, 32);
mywindow:setSize(94, 100);
mywindow:setTexture('Enabled', 'UIData/invisible.tga', 530, 406);
mywindow:setProperty('BackgroundEnabled', 'False');
mywindow:setProperty('FrameEnabled', 'False');
mywindow:setAlwaysOnTop(true)
mywindow:setVisible(false)


ClubLobby_PopupLine  = {["err"]=0,  "Lobbypu_Topline", "Lobbypu_Bottomline"}
ClubLobby_PopupLineTexX	 = {['err'] = 0,  0, 0}
ClubLobby_PopupLineTexY	 = {['err'] = 0, 311, 311}
ClubLobby_PopupLinePosX	 = {['err'] = 0,  0, 0}
ClubLobby_PopupLinePosY	 = {['err'] = 0,  0, 250}
ClubLobby_PopupLineSizeX = {['err'] = 0,  94, 94}
ClubLobby_PopupLineSizeY = {['err'] = 0,  2, 2}

for i=1, #ClubLobby_PopupLine do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", ClubLobby_PopupLine[i])
	mywindow:setTexture("Enabled", "UIData/messenger.tga",	ClubLobby_PopupLineTexX[i], ClubLobby_PopupLineTexY[i])
	mywindow:setTexture("Disabled", "UIData/messenger.tga", ClubLobby_PopupLineTexX[i], ClubLobby_PopupLineTexY[i])
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(ClubLobby_PopupLinePosX[i], ClubLobby_PopupLinePosY[i])
	mywindow:setSize(ClubLobby_PopupLineSizeX[i], ClubLobby_PopupLineSizeY[i])
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
end


ClubUser_PopupButtonName =
{ ["protecterr"]=0,  "ClubLobby_Popup_Info", "ClubLobby_Popup_AddFriend" }
nPositionY = 22

for i=1, #ClubUser_PopupButtonName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton",	ClubUser_PopupButtonName[i])
	mywindow:setTexture("Disabled", "UIData/fightClub_002.tga",		842, 221+nPositionY*(i-1)+66)
	mywindow:setTexture("Normal", "UIData/fightClub_002.tga",		560, 221+nPositionY*(i-1)+66)
	mywindow:setTexture("Hover", "UIData/fightClub_002.tga",		654, 221+nPositionY*(i-1)+66)
	mywindow:setTexture("Pushed", "UIData/fightClub_002.tga",		748, 221+nPositionY*(i-1)+66)
	mywindow:setTexture("PushedOff", "UIData/fightClub_002.tga",	748, 221+nPositionY*(i-1)+66)
	mywindow:setTexture("SelectedNormal", "UIData/fightClub_002.tga",	 748, 221+nPositionY*(i-1)+66)
	mywindow:setTexture("SelectedHover", "UIData/fightClub_002.tga",	 748, 221+nPositionY*(i-1)+66)
	mywindow:setTexture("SelectedPushed", "UIData/fightClub_002.tga",	 748, 221+nPositionY*(i-1)+66)
	mywindow:setTexture("SelectedPushedOff", "UIData/fightClub_002.tga", 748, 221+nPositionY*(i-1)+66)
	mywindow:setSize(94, 22)
	mywindow:setPosition(0, nPositionY*(i-1))
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true)
	mywindow:setUserString('Index', tostring(i))
	mywindow:setSubscribeEvent("SelectStateChanged", "OnSelectedClubLobbyPopup")
	
	local child_window = winMgr:createWindow("TaharezLook/StaticText", ClubUser_PopupButtonName[i].."ClubPopupText")	
	child_window:setProperty("FrameEnabled", "false")
	child_window:setProperty("BackgroundEnabled", "false")
	child_window:setSize(5, 5)
	child_window:setVisible(true)
	child_window:setPosition(40,3)
	child_window:setViewTextMode(1)	
	child_window:setAlign(8)
	child_window:setLineSpacing(1)
end

function OnClickUserMouseRButtonUp(args)
	DebugStr('OnClickUserMouseRButtonUp() start');
	
	-- 캐릭터 네임을 알아온다.
	for i=1, #ClubLobby_PopupButtonName do
		winMgr:getWindow(ClubLobby_PopupButtonName[i]):setProperty('Selected', 'false')
	end
	local local_window = CEGUI.toWindowEventArgs(args).window;
	local win_name = local_window:getName();
	OnClickUserName = winMgr:getWindow(win_name..'UserName'):getText();
	DebugStr('OnClickUserName:'..OnClickUserName)
	
	root:removeChildWindow(winMgr:getWindow('pu_btnContainer'));
	
	-- 광장일때만 체크 해준다.	
	local messenger_window = winMgr:getWindow('sj_messengerBackWindow');
	
	if messenger_window ~= nil then
	
		local messenger_visible = messenger_window:isVisible()
		if messenger_visible == false then
			local name
			name = OnClickUserName
					
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
				
				MakeMessengerPopup("pu_windowName", "pu_showInfo","pu_profile", "pu_privatChat");
			end
			return
				
			
		end
	end
	--[[
	local isMyMessengerFriend = IsMyMessengerFriend(OnClickUserName);
	if	OnClickUserName == My_LobbyCharacterName then
			MakeClubLobbyPopup("ClubLobby_Popup_Info")
						
	elseif isMyMessengerFriend == true then
	
			MakeClubLobbyPopup("ClubLobby_Popup_Info")
	else
			MakeClubLobbyPopup("ClubLobby_Popup_Info", "ClubLobby_Popup_AddFriend")
	end
    --]]
end
-- 매니저 우클릭 팝업창
function MakeClubLobbyPopup(...)
	
	DebugStr('MakeClubLobbyLobbyPopup start');
	m_pos = mouseCursor:getPosition()
	-- 타입을 지정해준다.
	winMgr:getWindow('ClubUser_PopupWindow'):setVisible(false);
	winMgr:getWindow('Lobbypu_Topline'):setVisible(false);
	winMgr:getWindow('Lobbypu_Topline'):setVisible(false);
	root:removeChildWindow(winMgr:getWindow('ClubUser_PopupWindow'))
	winMgr:getWindow("ClubUser_PopupWindow"):removeChildWindow(winMgr:getWindow("Lobbypu_Topline"))
	winMgr:getWindow("ClubUser_PopupWindow"):removeChildWindow(winMgr:getWindow("Lobbypu_Bottomline"))
	
	for i=1, #ClubUser_PopupButtonName do
		winMgr:getWindow(ClubUser_PopupButtonName[i]):setVisible(false);
		winMgr:getWindow('ClubUser_PopupWindow'):removeChildWindow(winMgr:getWindow(ClubUser_PopupButtonName[i]))
	end
	
	local para_count = select('#', ...)
	local win_name = 'none';
	
	if para_count > 0 then
		
		for i=1, para_count do
			win_name = select(i, ...);
			winMgr:getWindow(win_name):setPosition(0, (i-1)*22)
			winMgr:getWindow(win_name):setVisible(true)
			winMgr:getWindow('ClubUser_PopupWindow'):addChildWindow(winMgr:getWindow(win_name))
		end
	end	
	
	root:addChildWindow(winMgr:getWindow('ClubUser_PopupWindow'))
	winMgr:getWindow('ClubUser_PopupWindow'):setVisible(true);
	winMgr:getWindow('ClubUser_PopupWindow'):setPosition(m_pos.x, m_pos.y);

	winMgr:getWindow('Lobbypu_Topline'):setPosition(0, 0)
	winMgr:getWindow('Lobbypu_Bottomline'):setPosition(0, para_count*22)
	winMgr:getWindow("ClubUser_PopupWindow"):addChildWindow(winMgr:getWindow("Lobbypu_Topline"))
	winMgr:getWindow("ClubUser_PopupWindow"):addChildWindow(winMgr:getWindow("Lobbypu_Bottomline"))
	winMgr:getWindow('Lobbypu_Topline'):setVisible(true);
	winMgr:getWindow('Lobbypu_Bottomline'):setVisible(true);
	
	DebugStr('MakeClubLobbyPopup end');
end


function OnSelectedClubLobbyPopup(args)

	DebugStr('OnSelectedClubLobbyPopup start');
	
	
	local local_window = CEGUI.toWindowEventArgs(args).window;
	if CEGUI.toRadioButton(local_window):isSelected() then
	
		local win_name = local_window:getName();
		
		
		if win_name == 'ClubLobby_Popup_Info' then   -- 정보보기
			
			--InfoVisibleCheck(true);	
			GetCharacterInfo(OnClickUserName, 1);
			ShowUserInfoWindow()
			RefreshLobbyPopupButton()
			
		elseif win_name == 'ClubLobby_Popup_AddFriend' then --친구추가
			
			local bRet = RequestNewFriend(OnClickUserName);
			DebugStr('bRet : ' .. tostring(bRet));
			if bRet == false then
				--ShowCommonAlertOkBoxWithFunction('친구추가를 실패했습니다.', 'OnClickAlertOkSelfHide');
				ShowCommonAlertOkBoxWithFunction(PreCreateString_1173,'OnClickAlertOkSelfHide');	 
			end										--GetSStringInfo(LAN_LUA_WND_MESSENGER_5)
			RefreshLobbyPopupButton()
			
		end
	end
end


function RefreshLobbyPopupButton()
	DebugStr('RefreshLobbyPopupButton()')
	for i=1, #ClubUser_PopupButtonName do
		winMgr:getWindow(ClubUser_PopupButtonName[i]):setProperty('Selected', 'false')
		winMgr:getWindow(ClubUser_PopupButtonName[i]):setVisible(false);
	end
	winMgr:getWindow('ClubUser_PopupWindow'):setVisible(false);
end


----------------------------------------------
--- 튜토리얼 BackImage------------------------
----------------------------------------------

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ClubLobby_TutoBackImage")
mywindow:setTexture("Enabled", "UIData/tutorial005.tga", 369, 0)
mywindow:setTexture("Disabled", "UIData/tutorial005.tga", 369, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(300 , 200);
mywindow:setSize(514, 344)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setVisible(false)
root:addChildWindow(mywindow)

RegistEscEventInfo("ClubLobby_TutoBackImage", "Club_Close_Tutorial")

----------------------------------------------
--- 튜토리얼 내용 기본------------------------
----------------------------------------------

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ClubLobby_TutorialImage")
mywindow:setTexture("Enabled", "UIData/tutorial005.tga", 0, 530)
mywindow:setTexture("Disabled", "UIData/tutorial005.tga", 0, 530)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(20 , 40);
mywindow:setSize(486, 247)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('ClubLobby_TutoBackImage'):addChildWindow(mywindow)

----------------------------------------------
--- 튜토리얼 이미지 Visible/Invisible---------
----------------------------------------------
function ShowTutorialImage(bNumber)
	if bNumber == 1 then
		winMgr:getWindow('ClubLobby_TutoBackImage'):setVisible(true)
	else
		winMgr:getWindow('ClubLobby_TutoBackImage'):setVisible(false)
	end	
end


----------------------------------------------
--- 마이 클럽 팀 리스트  페이지텍스트---------
----------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "Tutorial_PageText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 16)
mywindow:setPosition(220, 300)
mywindow:setSize(80, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:clearTextExtends()
mywindow:addTextExtends(tostring(g_ClubTutorialPage)..' / '..tostring(g_ClubTutorialMaxPage), g_STRING_FONT_GULIMCHE, 114,    230,230,230,255,     0,     0,0,0,255)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('ClubLobby_TutoBackImage'):addChildWindow(mywindow)

---------------------------------------
---마이 클럽 팀 리스트 페이지앞뒤버튼--
---------------------------------------
local Tutorial_BtnName  = {["err"]=0, [0]="Tutorial_LBtn", "Tutorial_RBtn"}
local Tutorial_BtnTexX  = {["err"]=0, [0]= 427, 454}
local Tutorial_BtnPosX  = {["err"]=0, [0]= 190, 300}
local Tutorial_BtnEvent = {["err"]=0, [0]= "Tutorial_PrevPage", "Tutorial_NextPage"}
for i=0, #Tutorial_BtnName do
	mywindow = winMgr:createWindow("TaharezLook/Button", Tutorial_BtnName[i])
	mywindow:setTexture("Normal", "UIData/fightclub_004.tga", Tutorial_BtnTexX[i], 493)
	mywindow:setTexture("Hover", "UIData/fightclub_004.tga", Tutorial_BtnTexX[i], 520)
	mywindow:setTexture("Pushed", "UIData/fightclub_004.tga",Tutorial_BtnTexX[i], 547)
	mywindow:setTexture("PushedOff", "UIData/fightclub_004.tga", Tutorial_BtnTexX[i], 547)
	mywindow:setPosition(Tutorial_BtnPosX[i], 295)
	mywindow:setSize(27, 27)
	mywindow:setAlwaysOnTop(true)
	mywindow:setSubscribeEvent("Clicked", Tutorial_BtnEvent[i])
	winMgr:getWindow('ClubLobby_TutoBackImage'):addChildWindow(mywindow)
end

----------------------------------------
---튜토리얼 이전페이지이벤트-
----------------------------------------
function Tutorial_PrevPage()
	if	g_ClubTutorialPage  > 1 then
		g_ClubTutorialPage = g_ClubTutorialPage - 1 
		DebugStr('g_ClubTutorialPage:'..g_ClubTutorialPage)
		Tutirial_ChangeUi(g_ClubTutorialPage)
		winMgr:getWindow('Tutorial_PageText'):clearTextExtends()
		winMgr:getWindow('Tutorial_PageText'):addTextExtends(tostring(g_ClubTutorialPage)..' / '..tostring(g_ClubTutorialMaxPage), g_STRING_FONT_GULIMCHE, 114,    230,230,230,255,     0,     0,0,0,255)
	end
end

----------------------------------------
---튜토리얼 다음페이지이벤트--
----------------------------------------
function Tutorial_NextPage()
	if	g_ClubTutorialPage < g_ClubTutorialMaxPage then
		g_ClubTutorialPage = g_ClubTutorialPage + 1 
		DebugStr('g_ClubTutorialPage:'..g_ClubTutorialPage)
		Tutirial_ChangeUi(g_ClubTutorialPage)
		winMgr:getWindow('Tutorial_PageText'):clearTextExtends()
		winMgr:getWindow('Tutorial_PageText'):addTextExtends(tostring(g_ClubTutorialPage)..' / '..tostring(g_ClubTutorialMaxPage), g_STRING_FONT_GULIMCHE, 114,    230,230,230,255,     0,     0,0,0,255)
	end
end

----------------------------------------
---튜토리얼 화면 전환-------------------
----------------------------------------
function Tutirial_ChangeUi(TutorialPageNum)
	if TutorialPageNum == 1 then
		winMgr:getWindow('ClubLobby_TutorialImage'):setTexture("Enabled", "UIData/tutorial005.tga", 0, 530)
		winMgr:getWindow('ClubLobby_TutorialImage'):setTexture("Disabled", "UIData/tutorial005.tga", 0, 530)
	elseif TutorialPageNum == 2 then
		winMgr:getWindow('ClubLobby_TutorialImage'):setTexture("Enabled", "UIData/tutorial005.tga", 486, 530)
		winMgr:getWindow('ClubLobby_TutorialImage'):setTexture("Disabled", "UIData/tutorial005.tga", 486, 530)
	elseif TutorialPageNum == 3 then
		winMgr:getWindow('ClubLobby_TutorialImage'):setTexture("Enabled", "UIData/tutorial005.tga", 0, 777)
		winMgr:getWindow('ClubLobby_TutorialImage'):setTexture("Disabled", "UIData/tutorial005.tga", 0, 777)
	else 
		winMgr:getWindow('ClubLobby_TutorialImage'):setTexture("Enabled", "UIData/tutorial005.tga", 485, 777)
		winMgr:getWindow('ClubLobby_TutorialImage'):setTexture("Disabled", "UIData/tutorial005.tga", 485, 777)
	end
end
----------------------------------------
---튜토리얼 종료 버튼-------------------
----------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", 'ClubTutorial_Close')
mywindow:setTexture("Normal",		"UIData/mainBG_Button002.tga",	354, 159)
mywindow:setTexture("Hover",		"UIData/mainBG_Button002.tga",	354, 182)
mywindow:setTexture("Pushed",		"UIData/mainBG_Button002.tga",	354, 159)
mywindow:setTexture("PushedOff",	"UIData/mainBG_Button002.tga",	354, 159)
mywindow:setTexture("Disabled",		"UIData/mainBG_Button002.tga",	354, 159)
mywindow:setPosition(483, 9)
mywindow:setSize(23, 23)
mywindow:setSubscribeEvent("Clicked", 'Club_Close_Tutorial')
winMgr:getWindow('ClubLobby_TutoBackImage'):addChildWindow(mywindow)


function Club_Close_Tutorial()
	winMgr:getWindow('ClubLobby_TutoBackImage'):setVisible(false)
end


---------------------------------------
-- 클럽전 툴팁 관련 -------------------
---------------------------------------

function OnMouseEnter_ShowClubInfo(args)
	DebugStr('OnMouseEnter_ShowClubInfo()')
	winMgr:getWindow('ClubLobby_TeamInfoImage'):setVisible(true)
	-- 툴팁 띄워준다.
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local x, y = GetBasicRootPoint(EnterWindow)
	DebugStr('x:'..x)
	DebugStr('y:'..y)
	-- 현재 선택된 윈도우를 찾는다.
	local index = tonumber(EnterWindow:getUserString("DetailIndex"))

	winMgr:getWindow('ClubLobby_TeamInfoImage'):setVisible(true)
	winMgr:getWindow('ClubLobby_TeamInfoImage'):setPosition(x, y+25)
	
	local ClubLevel  = winMgr:getWindow(ClubLobby_Team_Radio[index]..ClubLobbyTeamText[2]):getText()
	local ClubName   = winMgr:getWindow(ClubLobby_Team_Radio[index]..ClubLobbyTeamText[3]):getText()
	local LeaderName = winMgr:getWindow(ClubLobby_Team_Radio[index]..ClubLobbyTeamText[4]):getText()

    local ClubMaster = winMgr:getWindow(ClubLobby_Team_Radio[index]..ClubLobbyTeamText[6]):getText()
	local ContinueWins = winMgr:getWindow(ClubLobby_Team_Radio[index]..ClubLobbyTeamText[7]):getText()
	local ClubMemberCount = winMgr:getWindow(ClubLobby_Team_Radio[index]..ClubLobbyTeamText[8]):getText()
	local MaxClubMemberCount = winMgr:getWindow(ClubLobby_Team_Radio[index]..ClubLobbyTeamText[9]):getText()
	local ClubWins = winMgr:getWindow(ClubLobby_Team_Radio[index]..ClubLobbyTeamText[10]):getText()
	local ClubLose = winMgr:getWindow(ClubLobby_Team_Radio[index]..ClubLobbyTeamText[11]):getText()
	local ClubRank  = tonumber(winMgr:getWindow(ClubLobby_Team_Radio[index]..ClubLobbyTeamText[12]):getText())
	
	winMgr:getWindow(TeamInfoText[1]):setText(ClubName)
	winMgr:getWindow(TeamInfoText[2]):setText(ClubMaster)
	winMgr:getWindow(TeamInfoText[3]):setText(ClubLevel)
	winMgr:getWindow(TeamInfoText[5]):setText(LeaderName)
	winMgr:getWindow(TeamInfoText[6]):setText(ClubWins.." / "..ClubLose)
	winMgr:getWindow(TeamInfoText[7]):setText(ContinueWins)
	winMgr:getWindow(TeamInfoText[8]):setText(ClubMemberCount.." / "..MaxClubMemberCount)
	
	if ClubRank > 9998 then
		winMgr:getWindow(TeamInfoText[4]):setText('-')
	else
		winMgr:getWindow(TeamInfoText[4]):setText(ClubRank)
	end
	
	return
end

function OnMouseLeave_HideClubInfo()
	DebugStr('OnMouseLeave_HideClubInfo()')
	winMgr:getWindow('ClubLobby_TeamInfoImage'):setVisible(false)
	return
end


---------------------------------------
---클럽전 기록실 버튼--
---------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", 'MatchHistoryBtn')
mywindow:setTexture("Normal", "UIData/fightclub_005.tga", 398, 344)
mywindow:setTexture("Hover", "UIData/fightclub_005.tga", 398, 369)
mywindow:setTexture("Pushed", "UIData/fightclub_005.tga", 398, 394)
mywindow:setTexture("PushedOff", "UIData/fightclub_005.tga", 398, 419)
mywindow:setPosition(435, 203)
mywindow:setSize(116, 25)
mywindow:setAlwaysOnTop(true)
mywindow:setSubscribeEvent("Clicked", 'CallGetMatchHistory')
winMgr:getWindow('ClubLobby_UserBackImage'):addChildWindow(mywindow)

---------------------------------------
---클럽전 기록실 호출
---------------------------------------
function CallGetMatchHistory()
	winMgr:getWindow('MatchHistory_BackImage'):setVisible(true)
	GetMatchHistory(g_lobbyMatchHistoryPage)
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
		GetMatchHistory(g_lobbyMatchHistoryPage)
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
		GetMatchHistory(g_lobbyMatchHistoryPage)
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
	DebugStr('GetSStringInfo를 실행하고 있습니다'..HistoryMatchRoom)
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

function ClubLobbyMouseClick()
	PlayWave("sound/button_click.wav");
	root:removeChildWindow(winMgr:getWindow('pu_btnContainer'));
end


-- 초기 채팅창 설정
function SetChatInitLobby()
	Chatting_SetChatWideType(6)
	Chatting_SetChatPosition(3, 527)
	Chatting_SetChatEditVisible(true)
	Chatting_SetChatEditEvent(2)
	winMgr:getWindow("doChatting"):deactivate()
	Chatting_SetChatTabDefault()
end

