-----------------------------------------
-- Script Entry Point
-----------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local Realroot		= winMgr:getWindow("DefaultWindow")
local drawer	= Realroot:getDrawer()
guiSystem:setGUISheet(Realroot)
Realroot:activate()

--------------------------------------------------------------------
-- 아케이드룸 와이드용 백판
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "root")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setWideType(6);
mywindow:setPosition(0, 0)
mywindow:setSize(1024, 768)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
Realroot:addChildWindow(mywindow)
local root = winMgr:getWindow("root")

--------------------------------------------------------------------
-- 채널 정보 백판 붙이기
--------------------------------------------------------------------
root:addChildWindow(winMgr:getWindow('ChannelPositionBG'));
winMgr:getWindow('ChannelPositionBG'):setVisible(true);
winMgr:getWindow('ChannelPositionBG'):setWideType(0);
winMgr:getWindow('ChannelPositionBG'):setPosition(795, 2);
winMgr:getWindow('NewMoveServerBtn'):setVisible(false)
winMgr:getWindow('NewMoveExitBtn'):setVisible(true)
ChangeChannelPosition('Arcade lobby')

root:setSubscribeEvent("MouseButtonUp", "OnRootMouseButtonUp")
function OnRootMouseButtonUp(args)
	Realroot:removeChildWindow(winMgr:getWindow('pu_btnContainer'))
end


local g_STRING_QEUSTROOM_EX1 = PreCreateString_1363	--GetSStringInfo(LAN_LUA_WND_QUEST_ROOM_2) -- 파티전원이 함께 나가게 됩니다.\n그래도 나가시겠습니까?
local g_STRING_QEUSTROOM_EX2 = PreCreateString_1365	--GetSStringInfo(LAN_LUA_WND_QUEST_ROOM_4) -- 파티탈퇴가 됩니다.\n그래도 나가시겠습니까?
local g_STRING_QUESTROOM1	 = PreCreateString_1690	--GetSStringInfo(LAN_LUA_QEUESTROOM_1)		-- 코인획득불가
local g_STRING_PREPARING	 = PreCreateString_1273	--GetSStringInfo(LAN_LUA_WND_POPUP_2)		-- 준비중입니다.
local g_SelectedQuestTab = 4


--------------------------------------------------------------------

-- drawTexture(StartRender:시작시에 그리기)

--------------------------------------------------------------------
function WndQuestRoom_RenderBackImages(dungeonFileName)

	-- 1. 타이틀
	drawer:drawTexture(dungeonFileName, 0, 0, 1024, 71, 0, 0, WIDETYPE_6)
	
	-- 2. WANTED
	drawer:drawTexture(dungeonFileName, 585, 71, 439, 541, 585, 71, WIDETYPE_6)
	
	-- 3. 방그림 배경
	--drawer:drawTexture("UIData/Arcade_lobby.tga", 585, 615, 176, 137, 137, 50, WIDETYPE_6)
	--drawer:drawTexture(dungeonFileName, 589, 619, 168, 130, 160, 309, WIDETYPE_6)
	
	-- 4. 히든 모드
	--drawer:drawTexture("UIData/Arcade_lobby.tga", 438, 514, 141, 239, 137, 187, WIDETYPE_6)	-- 기본 아무것도 없을경우
	--drawer:drawTexture(dungeonFileName, 438, 514, 141, 239, 0, 106, WIDETYPE_6)				-- 히든 모드 일경우
end

function WndQuestRoom_RenderHuntingImages()

end







--------------------------------------------------------------------

-- 나가기 버튼

--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_qr_ExitRoomBtn")
mywindow:setTexture("Normal", "UIData/Arcade_rank.tga", 247, 103)
mywindow:setTexture("Hover", "UIData/Arcade_rank.tga", 247, 151)
mywindow:setTexture("Pushed", "UIData/Arcade_rank.tga", 247, 199)
mywindow:setTexture("PushedOff", "UIData/Arcade_rank.tga", 247, 103)
mywindow:setPosition(765, 703)
mywindow:setSize(247, 48)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ExitDungeon")
root:addChildWindow(mywindow)

RegistEscEventInfo("CommonAlertAlphaImg", "CancelExitDungeon")

local g_PartyMasterIsMe = false
function ExitDungeon()
	
	if IsPartyPlaying() > 1 then
		if g_PartyMasterIsMe then
		
			if IsKoreanLanguage() then
				ShowCommonAlertOkCancelBoxWithFunction("파티전원", "이 함께 나가게 됩니다.\n그래도 나가시겠습니까?", "OkExitDungeon", "CancelExitDungeon")
			else				
				ShowCommonAlertOkCancelBoxWithFunction("", g_STRING_QEUSTROOM_EX1, "OkExitDungeon", "CancelExitDungeon")
			end
		else
			if IsKoreanLanguage() then
				ShowCommonAlertOkCancelBoxWithFunction("파티탈퇴", "가 됩니다.\n그래도 나가시겠습니까?", "OkExitDungeon", "CancelExitDungeon")
			else				
				ShowCommonAlertOkCancelBoxWithFunction("", g_STRING_QEUSTROOM_EX2, "OkExitDungeon", "CancelExitDungeon")
			end		
		end
	
	else
		GotoWndVillage()
	end
end


function OkExitDungeon()
	local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "OkExitDungeon" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)
	
	GotoWndVillage()
end


function CancelExitDungeon()
	local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
	if nofunc ~= "CancelExitDungeon" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)	
end



--------------------------------------------------------------------

-- 시작하기 버튼

--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_questroom_startAndReadyBtn")
mywindow:setTexture("Normal", "UIData/Arcade_rank.tga", 0, 103)
mywindow:setTexture("Hover", "UIData/Arcade_rank.tga", 0, 186)
mywindow:setTexture("Pushed", "UIData/Arcade_rank.tga", 0, 269)
mywindow:setTexture("PushedOff", "UIData/Arcade_rank.tga", 0, 103)
mywindow:setTexture("Disabled", "UIData/Arcade_rank.tga", 0, 352)
mywindow:setPosition(676, 615)
mywindow:setSize(237, 73)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "WndQuestRoom_Ready")
root:addChildWindow(mywindow)







--------------------------------------------------------------------

-- 케릭터 정보(얼굴, 레벨, 이름, 마스터)

--------------------------------------------------------------------
local g_spacingX = 143
for i=0, 3 do
		
	-- 유저 정보 백그라운드
	userbackwindow = winMgr:createWindow("TaharezLook/StaticImage", i.."sj_wndQuestRoom_userInfoBack")
	userbackwindow:setTexture("Enabled", "UIData/Arcade_lobby.tga", 0, 432)
	userbackwindow:setTexture("Disabled", "UIData/Arcade_lobby.tga", 0, 432)
	userbackwindow:setProperty("FrameEnabled", "False")
	userbackwindow:setProperty("BackgroundEnabled", "False")
	userbackwindow:setPosition(10+(i*g_spacingX), 385) -- 432
	userbackwindow:setSize(137, 78)
	userbackwindow:setVisible(true)
	userbackwindow:setEnabled(false)
	userbackwindow:setZOrderingEnabled(false)
	root:addChildWindow(userbackwindow)
	
	-- 1. 유저 레벨
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i.."sj_wndQuestRoom_userInfo_level")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(10, -2)
	mywindow:setSize(30, 36)
	mywindow:setEnabled(false)
	userbackwindow:addChildWindow(mywindow)
	
	-- 2. 유저 이름
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i.."sj_wndQuestRoom_userInfo_name")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(43, 59)
	mywindow:setSize(50, 20)
	mywindow:setEnabled(false)
	userbackwindow:addChildWindow(mywindow)
		
	-- 3. 유저 스타일
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i.."sj_wndQuestRoom_userInfo_style")
	mywindow:setTexture("Enabled", "UIData/skillitem001.tga", 497, 0)
	mywindow:setTexture("Disabled", "UIData/skillitem001.tga", 497, 0)
	mywindow:setTexture("Layered", "UIData/skillitem001.tga", 497, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(56, -2)
	mywindow:setSize(87, 35)
	mywindow:setScaleWidth(210)
	mywindow:setScaleHeight(210)
	mywindow:setLayered(true)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	userbackwindow:addChildWindow(mywindow)
	
	-- 4. 유저 네트워크
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_wndQuestRoom_userInfo_networkImage")
	mywindow:setTexture("Enabled", "UIData/battleroom001.tga", 0, 1017)
	mywindow:setTexture("Disabled", "UIData/battleroom001.tga", 0, 1017)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(8, 24)
	mywindow:setSize(120, 5)
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(false)
	userbackwindow:addChildWindow(mywindow)
	
	-- 5. 유저 칭호
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i.."sj_wndQuestRoom_userInfo_title")
	mywindow:setTexture("Enabled", "UIData/numberUi001.tga", 0, 201)
	mywindow:setTexture("Disabled", "UIData/numberUi001.tga", 0, 201)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(2, 34)
	mywindow:setSize(107, 18)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	userbackwindow:addChildWindow(mywindow)
	
	-- 6. 유저 래더
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i.."sj_wndQuestRoom_userInfo_ladder")
	mywindow:setTexture("Enabled", "UIData/numberUi001.tga", 113, 600)
	mywindow:setTexture("Disabled", "UIData/numberUi001.tga", 113, 600)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(-2, 54)
	mywindow:setSize(47, 21)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	userbackwindow:addChildWindow(mywindow)
	
	-- 7. 유저 마스터 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i.."sj_wndQuestRoom_userInfo_master")
	mywindow:setTexture("Enabled", "UIData/Arcade_lobby.tga", 137, 0)
	mywindow:setTexture("Disabled", "UIData/Arcade_lobby.tga", 137, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(8+(i*g_spacingX), 80)
	mywindow:setSize(135, 25)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	root:addChildWindow(mywindow)
	
	-- 8. 유저 하트 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i.."sj_wndQuestRoom_userInfo_lifeImage")
	mywindow:setTexture("Enabled", "UIData/dungeonmsg.tga", 570, 704)
	mywindow:setTexture("Disabled", "UIData/dungeonmsg.tga", 570, 704)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(14+(i*g_spacingX), 350)
	mywindow:setSize(19, 17)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	root:addChildWindow(mywindow)
	
	-- 9. 유저 하트 갯수
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i.."sj_wndQuestRoom_userInfo_lifeNum")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_DODUMCHE, 12)
	mywindow:setPosition(35+(i*g_spacingX), 343)
	mywindow:setSize(170, 36)
	mywindow:setEnabled(false)
	root:addChildWindow(mywindow)
	
	-- 10. 유저 티켓 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i.."sj_wndQuestRoom_userInfo_coinImage")
	mywindow:setTexture("Enabled", "UIData/dungeonmsg.tga", 590, 702)
	mywindow:setTexture("Disabled", "UIData/dungeonmsg.tga",590, 702)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(15+(i*g_spacingX), 368)
	mywindow:setSize(19, 17)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	root:addChildWindow(mywindow)
	
	-- 11. 유저 티켓 갯수
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i.."sj_wndQuestRoom_userInfo_coinNum")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_DODUMCHE, 12)
	mywindow:setPosition(35+(i*g_spacingX), 359)
	mywindow:setSize(170, 36)
	mywindow:setEnabled(false)
	root:addChildWindow(mywindow)
	
	-- 12. 유저 티켓 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i.."sj_wndQuestRoom_userInfo_HardArcadeImage")
	mywindow:setTexture("Enabled", "UIData/dungeonmsg.tga", 609, 702)
	mywindow:setTexture("Disabled", "UIData/dungeonmsg.tga",609, 702)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(80 +(i*g_spacingX), 368)
	mywindow:setSize(19, 17)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	root:addChildWindow(mywindow)
	
	-- 13. 유저 티켓 갯수
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i.."sj_wndQuestRoom_userInfo_HardArcadeNum")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_DODUMCHE, 12)
	mywindow:setPosition(100+(i*g_spacingX), 359)
	mywindow:setSize(170, 36)
	mywindow:setEnabled(false)
	root:addChildWindow(mywindow)
	
	-- 12. 아이카페
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_wndQuestRoom_userInfo_icafeImage")
	mywindow:setTexture("Enabled", "UIData/LobbyImage_new.tga", 729, 235)
	mywindow:setTexture("Disabled", "UIData/LobbyImage_new.tga", 729, 235)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(102+(i*g_spacingX), 80)
	mywindow:setSize(64, 45)
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(false)
	mywindow:setVisible(true)
	mywindow:setScaleWidth(160)
	mywindow:setScaleHeight(160)
	root:addChildWindow(mywindow)
	
	-- 13. 클럽마크
	--mywindow = winMgr:createWindow('TaharezLook/StaticImage', i .."sj_wndQuestRoom_userInfo_clubEmbleImage")
	--mywindow:setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
	--mywindow:setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
	--mywindow:setProperty('BackgroundEnabled', 'False')
	--mywindow:setProperty('FrameEnabled', 'False')
	--mywindow:setPosition(12+(i*g_spacingX), 407)
	--mywindow:setSize(32, 32)
	--mywindow:setEnabled(false)
	--mywindow:setVisible(true)
	--root:addChildWindow(mywindow)
end


-- 정보 초기화
function WndQuestRoom_ClearCharacterInfo()

	for i=0, 3 do
		winMgr:getWindow(i.."sj_wndQuestRoom_userInfoBack"):setVisible(false)
		winMgr:getWindow(i.."sj_wndQuestRoom_userInfo_master"):setVisible(false)
		winMgr:getWindow(i.."sj_wndQuestRoom_userInfo_lifeImage"):setVisible(false)
		winMgr:getWindow(i.."sj_wndQuestRoom_userInfo_lifeNum"):setVisible(false)
		winMgr:getWindow(i.."sj_wndQuestRoom_userInfo_coinImage"):setVisible(false)
		winMgr:getWindow(i.."sj_wndQuestRoom_userInfo_coinNum"):setVisible(false)
		winMgr:getWindow(i.."sj_wndQuestRoom_userInfo_coinImage"):setVisible(false)
		winMgr:getWindow(i.."sj_wndQuestRoom_userInfo_HardArcadeImage"):setVisible(false)
		winMgr:getWindow(i.."sj_wndQuestRoom_userInfo_HardArcadeNum"):setVisible(false)
		winMgr:getWindow(i.."sj_wndQuestRoom_userInfo_icafeImage"):setVisible(false)
		--winMgr:getWindow(i.."sj_wndQuestRoom_userInfo_clubEmbleImage"):setVisible(false)
	end
end


-- 있는 케릭터만 보여준다.
function WndQuestRoom_RenderCharacterInfo(slot, mySlot, level, name, bone, style, network, titleNumber, ladderGrade
								, partyOwner, life, coin, HardCoupon, icafe , EmblemKey, promotion, AniTitleTick, attribute)
	
	winMgr:getWindow(slot.."sj_wndQuestRoom_userInfoBack"):setVisible(true)
	winMgr:getWindow(slot.."sj_wndQuestRoom_userInfo_master"):setVisible(true)
	--winMgr:getWindow(slot.."sj_wndQuestRoom_userInfo_clubEmbleImage"):setVisible(true)
	winMgr:getWindow(slot.."sj_wndQuestRoom_userInfo_style"):setScaleWidth(210)
	winMgr:getWindow(slot.."sj_wndQuestRoom_userInfo_style"):setScaleHeight(210)
	
	-- 레벨, 이름 색상설정
	if slot == mySlot then
		winMgr:getWindow(slot.."sj_wndQuestRoom_userInfo_level"):setTextColor(255, 205, 86, 255)
		winMgr:getWindow(slot.."sj_wndQuestRoom_userInfo_name"):setTextColor(255, 205, 86, 255)
	else
		winMgr:getWindow(slot.."sj_wndQuestRoom_userInfo_level"):setTextColor(255, 255, 255, 255)
		winMgr:getWindow(slot.."sj_wndQuestRoom_userInfo_name"):setTextColor(255, 255, 255, 255)
	end
	
	-- 레벨
	winMgr:getWindow(slot.."sj_wndQuestRoom_userInfo_level"):setText("Lv."..level)
	
	-- 이름
	local summaryName = SummaryString(g_STRING_FONT_GULIMCHE, 12, name, 70)
	local nameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, summaryName)
	winMgr:getWindow(slot.."sj_wndQuestRoom_userInfo_name"):setPosition(90-nameSize/2, 57)
	winMgr:getWindow(slot.."sj_wndQuestRoom_userInfo_name"):setText(summaryName)
	
	-- 스타일
	winMgr:getWindow(slot.."sj_wndQuestRoom_userInfo_style"):setTexture("Disabled", "UIData/Skill_up2.tga", tAttributeImgTexXTable[style][attribute], tAttributeImgTexYTable[style][attribute])
	winMgr:getWindow(slot.."sj_wndQuestRoom_userInfo_style"):setTexture("Layered", "UIData/Skill_up2.tga", promotionImgTexXTable[style], promotionImgTexYTable[promotion])
	
	-- 네트워크
	local offset = 0
	if		 0 <= network and network <= 20 then	offset = 120
	elseif	20 <  network and network <= 40 then	offset = 96
	elseif	40 <  network and network <= 60 then	offset = 72
	elseif	60 <  network and network <= 80 then	offset = 48
	elseif	80 <  network and network <= 100 then	offset = 24
	else											offset = 24
	end	
	winMgr:getWindow(slot.."sj_wndQuestRoom_userInfo_networkImage"):setSize(offset, 5)
	
	-- 칭호
	if titleNumber <= 0 or titleNumber == 26 then
		winMgr:getWindow(slot.."sj_wndQuestRoom_userInfo_title"):setTexture("Disabled", "UIData/invisible.tga", 0, 201+21*(titleNumber-1))
	elseif titleNumber > 0 and #tTitleFilName >= titleNumber then
		winMgr:getWindow(slot.."sj_wndQuestRoom_userInfo_title"):setTexture("Disabled", "UIData/"..tTitleFilName[titleNumber], tTitleTexX[titleNumber], tTitleTexY[titleNumber])
	elseif titleNumber >= 10001 then	-- 애니 칭호
		winMgr:getWindow(slot.."sj_wndQuestRoom_userInfo_title"):setSize(110, 18)
		winMgr:getWindow(slot.."sj_wndQuestRoom_userInfo_title"):setPosition(13, 32)
		winMgr:getWindow(slot.."sj_wndQuestRoom_userInfo_title"):setTexture("Disabled", "UIData/"..tAniTitleFilName[titleNumber - 10001], tAniTitleTexX[titleNumber - 10001], 18 * AniTitleTick)
	else
		winMgr:getWindow(slot.."sj_wndQuestRoom_userInfo_title"):setTexture("Disabled", "UIData/invisible.tga", 0, 201+21*(titleNumber-1))
	end	
	
	-- 래더
	winMgr:getWindow(slot.."sj_wndQuestRoom_userInfo_ladder"):setTexture("Disabled", "UIData/numberUi001.tga", 113, 600+21*ladderGrade)
	
	-- 라이프
	local lifeText = CommatoMoneyStr(life)
	winMgr:getWindow(slot.."sj_wndQuestRoom_userInfo_lifeImage"):setVisible(true)
	winMgr:getWindow(slot.."sj_wndQuestRoom_userInfo_lifeNum"):setVisible(true)
	winMgr:getWindow(slot.."sj_wndQuestRoom_userInfo_lifeNum"):setText("x "..lifeText)
	
	-- 내경우만 보여준다.(코인)
	--if slot == mySlot then		
		winMgr:getWindow(slot.."sj_wndQuestRoom_userInfo_coinImage"):setVisible(true)
		winMgr:getWindow(slot.."sj_wndQuestRoom_userInfo_coinNum"):setVisible(true)
		
		local coinText = CommatoMoneyStr(coin)
		local r,g,b = GetGranColor(tonumber(coin))		
		winMgr:getWindow(slot.."sj_wndQuestRoom_userInfo_coinNum"):setText("x "..coinText)
		winMgr:getWindow(slot.."sj_wndQuestRoom_userInfo_coinNum"):setTextColor(255,255,255,255)

	-- 하드 아케이드 쿠폰
		winMgr:getWindow(slot.."sj_wndQuestRoom_userInfo_HardArcadeImage"):setVisible(true)
		winMgr:getWindow(slot.."sj_wndQuestRoom_userInfo_HardArcadeNum"):setVisible(true)
		
		local coinText = CommatoMoneyStr(HardCoupon)
		local r,g,b = GetGranColor(tonumber(HardCoupon))		
		winMgr:getWindow(slot.."sj_wndQuestRoom_userInfo_HardArcadeNum"):setText("x "..HardCoupon)
		winMgr:getWindow(slot.."sj_wndQuestRoom_userInfo_HardArcadeNum"):setTextColor(255,255,255,255)
	--end
	
	
	-- 내가 마스터일 경우
	if mySlot == partyOwner then
		g_PartyMasterIsMe = true
		winMgr:getWindow("sj_questroom_startAndReadyBtn"):setEnabled(true)		

	else
		g_PartyMasterIsMe = false
		winMgr:getWindow("sj_questroom_startAndReadyBtn"):setEnabled(false)		
	end
	
	
	-- 마스터 일경우
	if slot == partyOwner then
		winMgr:getWindow(slot.."sj_wndQuestRoom_userInfo_master"):setTexture("Disabled", "UIData/Arcade_lobby.tga", 137, 0)
	else
		winMgr:getWindow(slot.."sj_wndQuestRoom_userInfo_master"):setTexture("Disabled", "UIData/Arcade_lobby.tga", 137, 25)
	end
	
	
	-- icafe
	local window = winMgr:getWindow(slot .. "sj_wndQuestRoom_userInfo_icafeImage")
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
	end
	
	--gang
	--local window = winMgr:getWindow(slot .. "sj_wndQuestRoom_userInfo_clubEmbleImage")
	--winMgr:getWindow(slot .. "sj_wndQuestRoom_userInfo_clubEmbleImage"):setScaleWidth(200)
	--winMgr:getWindow(slot .. "sj_wndQuestRoom_userInfo_clubEmbleImage"):setScaleHeight(200)
	--if EmblemKey > 0 then
	--	window:setVisible(true) 
	--	window:setTexture('Enabled', GetClubDirectory(GetLanguageType())..EmblemKey..".tga", 0, 0)
	--	window:setTexture('Disabled',GetClubDirectory(GetLanguageType())..EmblemKey..".tga", 0, 0)
	--else
	--	window:setVisible(false)
	--	window:setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
	--	window:setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
	--end

end


------------------------------------------------

--	말풍선 그리기

------------------------------------------------
function WndQuestRoom_OnDrawBoolean(str_chat, px, py, chatBubbleType)
	
	local real_str_chat = str_chat;
	if string.len(real_str_chat) <= 0 then
		return
	end
		
	if 0 > chatBubbleType or chatBubbleType > MAX_CHAT_BUBBLE_NUM then
		return
	end
	
	local alpha  = 200
	local UNIT   = 18		-- 1edge당 사이즈
	local UNIT2X = UNIT*2								-- 1edge당 사이즈 * 2
	local texX_L = tChatBubbleTexX[chatBubbleType]		-- 텍스처 왼쪽 x위치
	local texY_L = tChatBubbleTexY[chatBubbleType]		-- 텍스처 왼쪽 y위치
	local texX_R = texX_L+(UNIT*2)						-- 텍스처 오른쪽 x위치
	local texY_R = texY_L+(UNIT*2)						-- 텍스처 오른쪽 y위치
	local r,g,b  = GetChatBubbleColor(chatBubbleType)	-- 텍스트 색상(0:흰색, 1:검은색)
	local posX	 = 0		-- 말풍선 x위치
	local posY	 = tChatBubblePosY[chatBubbleType]		-- 말풍선 y위치
	
	local tailPosY = tChatBubbleTailPosY[chatBubbleType]
	local textPosY = tChatTextPosY[chatBubbleType]
	
	local twidth, theight = GetBooleanTextSize(real_str_chat, g_STRING_FONT_GULIMCHE, 14)
	local AREA_X = twidth
	local AREA_Y = theight
	
	-- 가운데 정렬 하기
	local DIV_X = twidth  / UNIT
	local DIV_Y = theight / UNIT
	local X = px-(UNIT2X+UNIT+(DIV_X*UNIT))/2 + posX
	local Y = py-AREA_Y-(UNIT*3) + posY
	
	-- 꼭지점 4군데
	--drawer = root:getDrawer()
	drawer = Realroot:getDrawer()
	drawer:drawTextureA("UIData/gamedesign.tga", posX+X,					 posY+Y,					 UNIT, UNIT, texX_L, texY_L, alpha)-- 왼쪽 위
	drawer:drawTextureA("UIData/gamedesign.tga", posX+X+UNIT2X+(DIV_X*UNIT), posY+Y,					 UNIT, UNIT, texX_R, texY_L, alpha)-- 오른쪽 위
	drawer:drawTextureA("UIData/gamedesign.tga", posX+X,					 posY+Y+UNIT2X+(DIV_Y*UNIT), UNIT, UNIT, texX_L, texY_R, alpha)-- 왼쪽 아래
	drawer:drawTextureA("UIData/gamedesign.tga", posX+X+UNIT2X+(DIV_X*UNIT), posY+Y+UNIT2X+(DIV_Y*UNIT), UNIT, UNIT, texX_R, texY_R, alpha)-- 오른쪽 아래
	
	-- 가로 라인
	for i=0, DIV_X do
		drawer:drawTextureA("UIData/gamedesign.tga", posX+X+UNIT+(i*UNIT), posY+Y,						UNIT, UNIT, texX_L+UNIT, texY_L, alpha)-- 윗라인
		drawer:drawTextureA("UIData/gamedesign.tga", posX+X+UNIT+(i*UNIT), posY+Y+UNIT2X+(DIV_Y*UNIT),	UNIT, UNIT, texX_L+UNIT, texY_R, alpha)-- 아래라인
		
		-- 가운데
		for j=0, DIV_Y do
			drawer:drawTextureA("UIData/gamedesign.tga", posX+X+UNIT+(i*UNIT), posY+Y+UNIT+(j*UNIT), UNIT, UNIT, texX_L+UNIT, texY_L+UNIT, alpha)
		end
	end
	
	-- 세로 라인
	for i=0, DIV_Y do
		drawer:drawTextureA("UIData/gamedesign.tga", posX+X,					 posY+Y+UNIT+(i*UNIT), UNIT, UNIT, texX_L, texY_L+UNIT, alpha)-- 왼쪽라인
		drawer:drawTextureA("UIData/gamedesign.tga", posX+X+UNIT2X+(DIV_X*UNIT), posY+Y+UNIT+(i*UNIT), UNIT, UNIT, texX_R, texY_L+UNIT, alpha)-- 오른쪽라인
	end
	
	
	-- 텍스트 그리기
	drawer:setTextColor(r,g,b,255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 14)
	drawer:drawText(real_str_chat, X+UNIT+2, Y+UNIT+textPosY)
end





local g_LevelupMoney = 0
------------------------------------------------
-- 레벨업 이벤트 보여준다.
------------------------------------------------
function ShowLevelUpEvent(LevelupMoney)
	g_LevelupMoney = LevelupMoney
	RegistEscEventInfo("LevelUpEventAlpha", "LevelUpEventButtonEvent")
	RegistEnterEventInfo("LevelUpEventAlpha", "LevelUpEventButtonEvent")
	Realroot:addChildWindow(winMgr:getWindow("LevelUpEventAlpha"))
	winMgr:getWindow("LevelUpEventAlpha"):setVisible(true)
	
end


function LevelUpEventRender(args)
	local drawer = CEGUI.toWindowEventArgs(args).window:getDrawer()
	
	local _left = DrawEachNumber("UIData/other001.tga", g_LevelupMoney, 8, 195, 34, 11, 683, 24, 33, 25, drawer)
	drawer:drawTexture("UIData/other001.tga", _left-25, 35, 30, 29, 266, 685)
	

end


function LevelUpEventButtonEvent()
	winMgr:getWindow("LevelUpEventAlpha"):setVisible(false)
end



-- 백그라운드 알파 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_questroom_alphaWindow")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
Realroot:addChildWindow(mywindow)


-- 팝업 바탕창
popupwindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_questroom_backWindow")
popupwindow:setTexture("Enabled", "UIData/popup001.tga", 0, 0)
popupwindow:setTexture("Disabled", "UIData/popup001.tga", 0, 0)
popupwindow:setProperty("FrameEnabled", "False")
popupwindow:setProperty("BackgroundEnabled", "False")
popupwindow:setWideType(6)
popupwindow:setPosition(338, 246)
popupwindow:setSize(346, 275)
popupwindow:setVisible(false)
popupwindow:setAlwaysOnTop(true)
popupwindow:setZOrderingEnabled(false)
Realroot:addChildWindow(popupwindow)

-- 파티 매치 ESC키 등록
RegistEscEventInfo("sj_questroom_backWindow", "CloseAdvantagePopup")

-- 팝업 내용창
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_questroom_descImage")
mywindow:setTexture("Enabled", "UIData/party003.tga", 383, 645)
mywindow:setTexture("Disabled", "UIData/party003.tga", 383, 645)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(11, 84)
mywindow:setSize(317, 106)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
popupwindow:addChildWindow(mywindow)

-- 팝업 내용
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_questroom_text")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont(g_STRING_FONT_DODUM, 115)
mywindow:setText("")
mywindow:setPosition(44, 120)
mywindow:setSize(250, 36)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
popupwindow:addChildWindow(mywindow)

-- 팝업 확인버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_questroom_okBtn")
mywindow:setTexture("Normal", "UIData/popup001.tga",693, 617)
mywindow:setTexture("Hover", "UIData/popup001.tga", 693, 646)
mywindow:setTexture("Pushed", "UIData/popup001.tga", 693, 675)
mywindow:setTexture("PushedOff", "UIData/popup001.tga", 693, 704)
mywindow:setPosition(4, 235)
mywindow:setSize(331, 29)
mywindow:setAlwaysOnTop(true)
mywindow:subscribeEvent("Clicked", "CloseAdvantagePopup")
popupwindow:addChildWindow(mywindow)


local tArcadeImage = {["err"]=0,
[1001] = "UIData/ItemUIData/Item/Arcade_Ticket_hotel.tga", 
[1002] = "UIData/ItemUIData/Item/Arcade_Ticket_park.tga", 
[1003] = "UIData/ItemUIData/Item/Arcade_Ticket_halem.tga", 
[1004] = "UIData/ItemUIData/Item/Arcade_Ticket_hroad.tga", 
[1005] = "UIData/ItemUIData/Item/Arcade_Ticket_Subway.TGA",
[1006] = "UIData/ItemUIData/Item/Arcade_Ticket_Grave_001.tga",
[1007] = "UIData/ItemUIData/Item/Arcade_Ticket_Grave_001.tga",
[1008] = "UIData/ItemUIData/Item/Arcade_Ticket_Grave_001.tga",
[1009] = "UIData/ItemUIData/Item/Arcade_Ticket_Grave_1_4.tga",							
[1011] = "UIData/ItemUIData/Item/Arcade_Ticket_Temple.TGA",
[1012] = "UIData/ItemUIData/Item/All_Arcade_Ticket.tga",
[1100] = "UIData/ItemUIData/Item/Hard_Arcade_Ticket.tga"}

function CallAdvantagePopup(type, message)
	DebugStr('CallAdvantagePopup')
	DebugStr('type:'..type)
	
	-- type == 0은 레벨 1 ~ 10으로 구성된 파티에서 공원, 호텔에서는 라이프가 소모되지 않는다.
	if type == 0 then
	
		winMgr:getWindow("sj_questroom_descImage"):setTexture("Enabled", "UIData/party003.tga", 383, 645)
		winMgr:getWindow("sj_questroom_descImage"):setTexture("Disabled", "UIData/party003.tga", 383, 645)
		winMgr:getWindow("sj_questroom_descImage"):setPosition(11, 84)
		winMgr:getWindow("sj_questroom_descImage"):setSize(317, 106)
		--winMgr:getWindow("sj_questroom_alphaWindow"):setVisible(true)
		winMgr:getWindow("sj_questroom_backWindow"):setVisible(true)
		winMgr:getWindow("sj_questroom_text"):clearTextExtends()
	
	-- type은 아케이드 번호, 아케이드 쿠폰이 없어서 입장하지 못한다고 뿌려준다.
	else
		DebugStr("아케이드  쿠폰이 모두 다른 경우")

		local PublicArcadeCouponType = 0;
		if 1001 <= type and type <= 1015 then
			PublicArcadeCouponType = 1012;
		elseif ARCADE_HARD_HOTEL <= type and type <= ARCADE_HARD_EVENT then
			PublicArcadeCouponType = ARCADE_HARD_ENTER;
		end	
		
		winMgr:getWindow("sj_questroom_descImage"):setTexture("Enabled", tArcadeImage[PublicArcadeCouponType], 0, 0)
		winMgr:getWindow("sj_questroom_descImage"):setTexture("Disabled", tArcadeImage[PublicArcadeCouponType], 0, 0)
		winMgr:getWindow("sj_questroom_descImage"):setPosition(120, 54)
		winMgr:getWindow("sj_questroom_descImage"):setSize(128, 128)			

		winMgr:getWindow("sj_questroom_alphaWindow"):setVisible(true)
		winMgr:getWindow("sj_questroom_backWindow"):setVisible(true)
		local strSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, message)
		winMgr:getWindow("sj_questroom_text"):clearTextExtends()
		winMgr:getWindow("sj_questroom_text"):setPosition(48, 180)
		winMgr:getWindow("sj_questroom_text"):setViewTextMode(1)
		winMgr:getWindow("sj_questroom_text"):setAlign(8)
		winMgr:getWindow("sj_questroom_text"):setLineSpacing(5)
		winMgr:getWindow("sj_questroom_text"):addTextExtends(message, g_STRING_FONT_GULIMCHE, 12, 255,255,255,255, 2, 0,0,0,255)

	end
	
	Realroot:addChildWindow(winMgr:getWindow("sj_questroom_alphaWindow"))
	Realroot:addChildWindow(winMgr:getWindow("sj_questroom_backWindow"))
end

function CloseAdvantagePopup()
	winMgr:getWindow("sj_questroom_alphaWindow"):setVisible(false)
	winMgr:getWindow("sj_questroom_backWindow"):setVisible(false)
	winMgr:getWindow("sj_questroom_text"):setText("")
end

function GetismyMaster()
	if IsPartyPlaying() > 1 then
		if g_PartyMasterIsMe then			
			WndQuestRoom_Ready()
		end
	else		
		WndQuestRoom_Ready()
	end
end



-- 초기 채팅창 설정
function SetChatInitQuestRoom()
	Chatting_SetChatWideType(6)
	Chatting_SetChatPosition(3, 462)
	Chatting_SetChatEditVisible(true)
	Chatting_SetChatEditEvent(2)
	winMgr:getWindow("doChatting"):deactivate()
	Chatting_SetChatTabDefault()
	winMgr:getWindow("ChatBackground"):setAlwaysOnTop(true)
end

