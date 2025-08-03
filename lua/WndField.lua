-----------------------------------------
-- Script Entry Point
-----------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)
root:activate()


local STATE_OBSERVER			= 0
local STATE_ENABLE_PLAY			= 1
local STATE_PLAYING				= 2
local STATE_PLAYING_OBSERVER	= 3
local g_myFieldState = STATE_OBSERVER


--------------------------------------------------------------------

-- 유령 그리기

--------------------------------------------------------------------
function WndField_StartGhost(downIndex, x, y, attackName1, attackName2)
	Common_StartGhost(downIndex, x, y, attackName1, attackName2)
end



function WndField_EndGhost(downIndex)
	Common_EndGhost(downIndex)
end



function WndField_RenderGhost(slot, x, y, deltaTime)
	Common_RenderGhost(slot, x, y, deltaTime)
end




--------------------------------------------------------------------

-- 케릭터에 관한정보 그리기(HP, SP ...)

--------------------------------------------------------------------
function WndField_RenderCharacter
			( deltatime
			, myslot
            , myteam
			, slot
			, team
			, friend
			, characterName
			, screenX
			, screenY
			, hp
			, sp
			, maxhp
			, maxsp
			, isPenalty
			, penaltyValue
			, showAllSP
			, showAllItem
			, _1stItemType
			, _2ndItemType
			, emblemKey
			, bPlaying
			)
	
	local MONSTER_RACING = false
	local FIELD = 3	-- 0:게임, 1:던전, 2:몬스터레이싱, 3:점령전, 4:점령전(옵저버)
	if bPlaying == 0 then
		FIELD = 4
	end
	
	local exceptE = 0
	local bArcadeEvent = 0
	Common_RenderCharacter(deltatime, myslot, myteam, slot, team, characterName, 
		screenX, screenY, hp, sp, maxhp, maxsp, friend, isPenalty, penaltyValue, 
		FIELD, showAllSP, showAllItem, _1stItemType, _2ndItemType, MONSTER_RACING, bArcadeEvent, exceptE)

	if emblemKey > 0 then
		if IsKoreanLanguage() then
			drawer:drawTexture(GetClubDirectory(GetLanguageType())..emblemKey..".tga", screenX-80, screenY, 32, 32, 0, 0)
		else
			drawer:drawTexture(GetClubDirectory(GetLanguageType())..emblemKey..".tga", screenX-74, screenY-6, 32, 32, 0, 0)
		end
	end
end






----------------------------------------------------------

-- 나의 왼쪽정보

----------------------------------------------------------
function WndField_RenderRank(slot, mybone, hp, sp, maxhp, maxsp, deltatime, RESPAWN_TIME, revivalTime, 
				level, characterName, isGameOver, lifeCount, transform, isPenalty, penaltyValue, m_bFieldStart)
	
	-- 다시 살아나기
--	Common_RenderReStart(deltatime, hp, RESPAWN_TIME, revivalTime, isGameOver, lifeCount, bFastRevive, rightRevive)
	
	-- 나에대한 정보 그리기
	local exceptE = 0
	local bArcadeEvent = 0
	local visibleHPSP = 1
	local bTournamentArcade = 0
	Common_RenderME(slot, mybone, hp, sp, maxhp, maxsp, deltatime, 
			RESPAWN_TIME, revivalTime, level, characterName, isGameOver, lifeCount, 0, transform, isPenalty, penaltyValue, bArcadeEvent, exceptE, visibleHPSP, bTournamentArcade)	
end




----------------------------------------------------------

-- 콤보효과 주기

----------------------------------------------------------
local tComboEffectTexY = { ["err"]=0, 0, 38, 76 }
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_WndField_Effect_combo")
mywindow:setWideType(6)
mywindow:setPosition(400, 190)
mywindow:setSize(237, 37)
mywindow:setScaleWidth(255)
mywindow:setScaleHeight(255)
mywindow:setVisible(false)
mywindow:setTexture("Enabled", "UIData/GameNewImage2.tga", 646, 0)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
root:addChildWindow(mywindow)

winMgr:getWindow("sj_WndField_Effect_combo"):addController("CommonAlertOkBoxCtrl0", "StampEffect", "xscale", "Quintic_EaseIn", 700, 255, 3, true, false, 10)
winMgr:getWindow("sj_WndField_Effect_combo"):addController("CommonAlertOkBoxCtrl0", "StampEffect", "yscale", "Quintic_EaseIn", 700, 255, 3, true, false, 10)
winMgr:getWindow("sj_WndField_Effect_combo"):addController("CommonAlertOkBoxCtrl0", "StampEffect", "xscale", "Elastic_EaseOut", 150, 255, 5, true, false, 10)
winMgr:getWindow("sj_WndField_Effect_combo"):addController("CommonAlertOkBoxCtrl0", "StampEffect", "yscale", "Elastic_EaseOut", 150, 255, 5, true, false, 10)
winMgr:getWindow("sj_WndField_Effect_combo"):setAlign(8)

local g_ComboEffectEnable = false
local g_ComboEffectAlpha = 255
local g_ComboEffectTime = 0
function WndField_ComboEffect(state)
	g_ComboEffectEnable = true
	g_ComboEffectAlpha = 255
	
	if state >= 3 then
		state = 3
	end
	winMgr:getWindow("sj_WndField_Effect_combo"):setTexture("Enabled", "UIData/GameNewImage2.tga", 646, tComboEffectTexY[state])
	winMgr:getWindow("sj_WndField_Effect_combo"):setVisible(true)
	winMgr:getWindow("sj_WndField_Effect_combo"):activeMotion("StampEffect")
end



----------------------------------------------------------

-- KO효과 주기

----------------------------------------------------------
-- 최대 64명까지 KO를 할수 있다고 생각해서 64명까지 생성
local g_KoEffectEnable = { ["err"]=0, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false
									, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false
									, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false
									, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false }
local g_KoEffectAlpha  = { ["err"]=0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
									, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
									, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
									, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
local g_KoEffectTime   = { ["err"]=0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
									, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
									, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
									, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
local g_KoEffectTexY   = { ["err"]=0, 0, 137, 274, 411, 411, 411, 411, 411, 411, 411, 411, 411, 411, 411, 411, 411
									, 411, 411, 411, 411, 411, 411, 411, 411, 411, 411, 411, 411, 411, 411, 411, 411
									, 411, 411, 411, 411, 411, 411, 411, 411, 411, 411, 411, 411, 411, 411, 411, 411
									, 411, 411, 411, 411, 411, 411, 411, 411, 411, 411, 411, 411, 411, 411, 411, 411 }
for i=1, #g_KoEffectEnable do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_WndField_Effect_ko"..i)
	mywindow:setWideType(6)
	mywindow:setPosition(190, 80)
	mywindow:setSize(646, 137)
	mywindow:setScaleWidth(255)
	mywindow:setScaleHeight(255)
	mywindow:setVisible(false)
	mywindow:setTexture("Enabled", "UIData/GameNewImage2.tga", 0, 0)
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setProperty("FrameEnabled", "False")
	root:addChildWindow(mywindow)

	winMgr:getWindow("sj_WndField_Effect_ko"..i):addController("CommonAlertOkBoxCtrl0", "StampEffect", "xscale", "Quintic_EaseIn", 700, 255, 3, true, false, 10)
	winMgr:getWindow("sj_WndField_Effect_ko"..i):addController("CommonAlertOkBoxCtrl0", "StampEffect", "yscale", "Quintic_EaseIn", 700, 255, 3, true, false, 10)
	winMgr:getWindow("sj_WndField_Effect_ko"..i):addController("CommonAlertOkBoxCtrl0", "StampEffect", "xscale", "Elastic_EaseOut", 150, 255, 5, true, false, 10)
	winMgr:getWindow("sj_WndField_Effect_ko"..i):addController("CommonAlertOkBoxCtrl0", "StampEffect", "yscale", "Elastic_EaseOut", 150, 255, 5, true, false, 10)
	winMgr:getWindow("sj_WndField_Effect_ko"..i):setAlign(8)
end

function WndField_KoEffect(koCount)
	if koCount <= 0 then
		return
	end
	
	-- 이전에 진행되는게 있다면 진행을 중지한다.
	for i=1, #g_KoEffectEnable do
		g_KoEffectEnable[i] = false
	end
	
	g_KoEffectEnable[koCount] = true
	g_KoEffectAlpha[koCount]  = 255
	
	winMgr:getWindow("sj_WndField_Effect_ko"..koCount):setTexture("Enabled", "UIData/GameNewImage2.tga", 0, g_KoEffectTexY[koCount])
	winMgr:getWindow("sj_WndField_Effect_ko"..koCount):setVisible(true)
	winMgr:getWindow("sj_WndField_Effect_ko"..koCount):activeMotion("StampEffect")
	
	if koCount == 1 then
		PlaySound('sound/System/System_KO.wav')
	elseif koCount == 2 then
		PlaySound('sound/System/System_DoubleKO.wav')
	elseif koCount == 3 then
		PlaySound('sound/System/System_TripleKO.wav')
	elseif koCount >= 4 then
		PlaySound('sound/System/System_FantasticKO.wav')
	end
end



----------------------------------------------------------

-- 현재상황(팀전, 블루팀 죽은횟수, 레드팀 죽은횟수, 나의 킬수, 나의 죽은횟수)

----------------------------------------------------------
local last10secEffectTime = 0
function WndField_RenderEffects(deltaTime)
	
	------------------------------------
	-- 위의 콤보효과 주기의 알파값 주기
	------------------------------------
	if g_ComboEffectEnable then
		g_ComboEffectTime = g_ComboEffectTime + deltaTime
		if g_ComboEffectTime >= 1200 then			
			g_ComboEffectAlpha = g_ComboEffectAlpha - deltaTime
			if g_ComboEffectAlpha <= 0 then
				g_ComboEffectTime = 0
				g_ComboEffectAlpha = 0
				g_ComboEffectEnable = false
				winMgr:getWindow("sj_WndField_Effect_combo"):setVisible(false)
			end
			winMgr:getWindow("sj_WndField_Effect_combo"):setAlpha(g_ComboEffectAlpha)
		end
	end
	
	
	
	------------------------------------
	-- KO효과
	------------------------------------
	for i=1, #g_KoEffectEnable do
		if g_KoEffectEnable[i] then
			g_KoEffectTime[i] = g_KoEffectTime[i] + deltaTime
			if g_KoEffectTime[i] >= 1200 then
				g_KoEffectAlpha[i] = g_KoEffectAlpha[i] - deltaTime
				if g_KoEffectAlpha[i] <= 0 then
					g_KoEffectEnable[i] = false
					g_KoEffectAlpha[i]  = 0
					g_KoEffectTime[i]   = 0
					
					if winMgr:getWindow("sj_WndField_Effect_ko"..i) then
						winMgr:getWindow("sj_WndField_Effect_ko"..i):setVisible(false)
					end
				end
				
				if winMgr:getWindow("sj_WndField_Effect_ko"..i) then
					winMgr:getWindow("sj_WndField_Effect_ko"..i):setAlpha(g_KoEffectAlpha[i])
				end
			end
		else
			g_KoEffectAlpha[i] = 0
			g_KoEffectTime[i]  = 0
			if winMgr:getWindow("sj_WndField_Effect_ko"..i) then
				winMgr:getWindow("sj_WndField_Effect_ko"..i):setVisible(false)
				winMgr:getWindow("sj_WndField_Effect_ko"..i):setAlpha(g_KoEffectAlpha[i])
			end
		end
	end
end





----------------------------------------------------------

-- 누가 누구를 죽였는지 확인

----------------------------------------------------------
function WndField_RenderKillAndDead(bTeam, killEnemyType, deadEnemyType, count, killName, deadName)
	
	local firstPosX = 800
	local firstPosY = 220+(count*30)
	local killPosX	= GetStringSize(g_STRING_FONT_GULIMCHE, 12, killName)
	local summaryDeadName = SummaryString(g_STRING_FONT_GULIMCHE, 12, deadName, 70)
	
	-- 가운데 주먹 이미지
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	drawer:drawTexture("UIData/GameNewImage.tga", firstPosX, firstPosY, 216, 38, 303, 79, WIDETYPE_1)

	-- 케릭터 이름
	if killEnemyType == 0 then
		common_DrawOutlineText1(drawer, killName, firstPosX+76-killPosX, firstPosY+12, 0,0,0,255, 254,87,87,255, WIDETYPE_1)
	else
		common_DrawOutlineText1(drawer, killName, firstPosX+76-killPosX, firstPosY+12, 0,0,0,255, 97,161,240,255, WIDETYPE_1)
	end
	
	if deadEnemyType == 0 then
		common_DrawOutlineText1(drawer, summaryDeadName, firstPosX+138, firstPosY+12, 0,0,0,255, 254,87,87,255, WIDETYPE_1)
	else
		common_DrawOutlineText1(drawer, summaryDeadName, firstPosX+138, firstPosY+12, 0,0,0,255, 97,161,240,255, WIDETYPE_1)
	end
end







----------------------------------------------------------

-- ready 그리기

----------------------------------------------------------
local g_readySound = true
local tReadyDelta = { ["err"]=0, -410 }
local tFightDelta = { ["err"]=0, 0, 255 }
function WndField_RenderBattleReady(deltaTime)
	
	tReadyDelta[1] = tReadyDelta[1] + deltaTime*3
	if tReadyDelta[1] >= 720 then
		drawer:drawTexture("UIData/GameNewImage.tga", 310, 200, 403, 89, 599, 406, WIDETYPE_5)
	else
		drawer:drawTexture("UIData/GameNewImage.tga", -410+tReadyDelta[1], 200, 403, 89, 599, 406, WIDETYPE_5)
	end
	
	-- 레디 사운드
	if g_readySound then
		g_readySound = false
		PlaySound('sound/System/System_READY.wav')
	end
	
	tFightDelta[1] = 0
	tFightDelta[2] = 255
end






----------------------------------------------------------

-- fight 그리기

----------------------------------------------------------
local g_fightSound = true
function WndField_RenderBattleFight(deltaTime)
	tFightDelta[1] = tFightDelta[1] + deltaTime
	if tFightDelta[1] >= 400 then
		
		tFightDelta[2] = tFightDelta[2] - deltaTime/2
		if tFightDelta[2] <= 0 then
			tFightDelta[2] = 0
			return
		end
	end
	
	-- 파이트 사운드
	if g_fightSound then
		g_fightSound = false
		PlaySound('sound/System/System_FIGHT.wav')
	end
	
	drawer:drawTextureA("UIData/GameNewImage.tga", 290, 201, 425, 88, 599, 317, tFightDelta[2], WIDETYPE_5)
	tReadyDelta[1] = -410
end




----------------------------------------------------------

-- 콤보, 데미지

----------------------------------------------------------

function WndField_ComboAndDamage(deltaTime, isCombo, currentCombo, isAccumulate, accumDamage, 
							teamAttackCount, doubleAttackCount, isTeamAttack, isDoubleAttack, currentAttackCount)

	Common_ComboAndDamage(deltaTime, isCombo, currentCombo, isAccumulate, accumDamage, 
			teamAttackCount, doubleAttackCount, isTeamAttack, isDoubleAttack, currentAttackCount)
end










----------------------------------------------------

-- 아이템

----------------------------------------------------
local tItemDescEnum = {["err"]=0, [0]=LAN_CLUBWAR_PLAY_ITEMEX1_SHIELD, LAN_CLUBWAR_PLAY_ITEMEX2_PWUP, LAN_CLUBWAR_PLAY_ITEMEX3_BLOW,
					LAN_CLUBWAR_PLAY_ITEMEX4_RECOVER, LAN_CLUBWAR_PLAY_ITEMEX5_METEO, LAN_CLUBWAR_PLAY_ITEMEX5_TOWER, 
					LAN_CLUBWAR_PLAY_ITEMEX8, LAN_CLUBWAR_PLAY_ITEMEX6, LAN_CLUBWAR_PLAY_ITEMEX7}

-- 아이템 그리기
tPropertyItemTexX = {["err"]=0, [0]=510, 510, 510, 510, 510, 510, 456, 456, 456}
tPropertyItemTexY = {["err"]=0, [0]=560, 616, 672, 728, 784, 840, 672, 560, 616}
function WndField_RenderItem(itemType, myHP, myDiedTime, reviveTick, myFieldState)

	-- 클럽원 현황
	if myFieldState == STATE_PLAYING then
		drawer:drawTexture("UIData/fightClub_005.tga", 3, 130, 118, 29, 277, 444)
	end

	-- 아이템 그리기
	if myHP <= 0 then
		if myDiedTime > 0 then
			--drawer:drawTexture("UIData/fightClub_005.tga", 100, 64, 167, 62, 705, 0)
			
			--[[
			drawer:setFont(g_STRING_FONT_GULIMCHE, 14)
			drawer:setTextColor(255,255,255,255)
			local reviveText = string.format(REVIVE_AFTER_SECONDS, reviveTick)
			local size = GetStringSize(g_STRING_FONT_GULIMCHE, 14, reviveText)
			drawer:drawText(reviveText, 184-size/2, 86)
			--]]
			
			-- 캐릭터 부활 남은 시간
			DrawEachNumberAS("UIData/GameNewImage.tga", reviveTick, 8, 38, 60, 0, 299, 41, 54, 41, 255, 200, 200, WIDETYPE_0)
			
			-- 캐릭터 전환
			--drawer:drawTexture("UIData/fightClub_005.tga", 3, 160, 118, 29, 395, 444)
		else
			--drawer:drawTexture("UIData/fightClub_005.tga", 100, 64, 60, 62, 541, 0)
			--drawer:drawTexture("UIData/fightClub_005.tga", 164, 64, 104, 62, 601, 0)
		end
	end
	
	drawer:drawTexture("UIData/fightClub_005.tga", 77, 60, 60, 62, 541, 0)
	drawer:drawTexture("UIData/fightClub_005.tga", 141, 60, 104, 62, 601, 0)
	
	if itemType >= 0 then
		drawer:drawTexture("UIData/fightClub_005.tga", 80, 63, 54, 56, tPropertyItemTexX[itemType], tPropertyItemTexY[itemType])
		
		-- 아이템 설명
		drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
		drawer:setTextColor(255,255,255,255)
		local szItemDesc = GetSStringInfo(tItemDescEnum[itemType])
		--DebugStr('GetSStringInfo를 실행하고 있습니다'..tItemDescEnum[itemType])
		drawer:drawText(szItemDesc, 146, 64)
	end
end



-- 임시
function WndField_TempStart()
	
	-- 캐릭터 전환
	drawer:drawTexture("UIData/fightClub_005.tga", 3, 160, 118, 29, 395, 444)
end




-- 채팅창  초기  설정
function SetChatInitField()
	Chatting_SetChatWideType(2)
	Chatting_SetChatPosition(3, 527)
	Chatting_SetChatEditEvent(3)
	Chatting_SetChatTab(CHATTYPE_ALL, CHATTYPE_TEAM, CHATTYPE_GANG)
	Chatting_SetChatPopup(CHATTYPE_ALL, CHATTYPE_PRIVATE, CHATTYPE_TEAM, CHATTYPE_GANG)
end



------------------------------------------------

--	말풍선 그리기

------------------------------------------------
function WndField_OnDrawBoolean(str_chat, px, py, chatBubbleType)
	
	local real_str_chat = str_chat;
	if string.len(real_str_chat) <= 0 then
		return
	end
		
	if 0 > chatBubbleType or chatBubbleType > MAX_CHAT_BUBBLE_NUM then
		return
	end
	
	local alpha  = 255
	local UNIT   = 18		-- 1edge당 사이즈
	local UNIT2X = UNIT*2								-- 1edge당 사이즈 * 2
	local texX_L = tChatBubbleTexX[chatBubbleType]		-- 텍스처 왼쪽 x위치
	local texY_L = tChatBubbleTexY[chatBubbleType]		-- 텍스처 왼쪽 y위치
	local texX_R = texX_L+(UNIT*2)						-- 텍스처 오른쪽 x위치
	local texY_R = texY_L+(UNIT*2)						-- 텍스처 오른쪽 y위치
	local r,g,b  = GetChatBubbleColor(chatBubbleType)	-- 텍스트 색상(0:흰색, 1:검은색)
	local posX	 = 0	-- 말풍선 x위치
	local posY	 = tChatBubblePosY[chatBubbleType]		-- 말풍선 y위치
	local tailTexX = tChatBubbleTailTexX[chatBubbleType]
	local tailTexY = tChatBubbleTailTexY[chatBubbleType]
	local tailSizX = 18
	local tailSizY = 18
	
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
	drawer = root:getDrawer()
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
	
	-- 말풍선 꼬리 그리기
	if chatBubbleType == 0 then
		drawer:drawTextureA("UIData/gamedesign.tga", posX+X+(UNIT+(DIV_X*UNIT)/2), posY+Y+UNIT2X+(DIV_Y*UNIT)+tailPosY, tailSizX, tailSizY, tailTexX, tailTexY, alpha)
	else
		drawer:drawTextureA("UIData/gamedesign.tga", posX+X+UNIT+(DIV_X*UNIT), posY+Y+UNIT2X+(DIV_Y*UNIT)+tailPosY, tailSizX, tailSizY, tailTexX, tailTexY, alpha)
	end
	
	-- 텍스트 그리기
	drawer:setTextColor(r,g,b,255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 14)
	drawer:drawText(real_str_chat, X+UNIT+2, Y+UNIT+textPosY)
end






----------------------------------------------------

-- Last 1분

----------------------------------------------------
local g_last1MinEffect  = 0
local g_last1MinTime	= 0
local g_last1Min		= true
local g_last1MinPos		= 0
local g_last1MinSound	= true

function WndField_InitLast1MinData()
	g_last1MinEffect= 0
	g_last1MinTime	= 0
	g_last1Min		= true
	g_last1MinPos	= 0
	g_last1MinSound	= true
end

function WndField_RenderLast1Min(deltaTime)

	if g_last1Min == false then
		return
	end
	
	if g_last1MinSound then
		PlaySound("sound/siren.wav")
		g_last1MinSound = false
	end
	
	
	g_last1MinTime = g_last1MinTime + deltaTime
		
	-- 1500까지는 가운데로 간다.
	if 0 <= g_last1MinTime and g_last1MinTime <= 1500 then
		g_last1MinPos = Effect_Elastic_EaseOut(g_last1MinTime, -600, 860, 1500, 0, 0)
			
	-- 그후에 800이 되면 사라진다.
	elseif 1500 < g_last1MinTime and g_last1MinTime <= 2300 then
		g_last1MinPos = Effect_Back_EaseIn(g_last1MinTime-1500, 250, 1600, 800, 0)
	
	-- 2300이 넘으면 사라짐
	else
		g_last1MinTime	= 2400
		g_last1Min		= false
		g_last1MinPos	= 2000
		WndFieldEndLast1Min()
		return
	end
	
	-- 사이렌
	g_last1MinEffect = g_last1MinEffect + deltaTime
	g_last1MinEffect = g_last1MinEffect % 200
	if g_last1MinEffect < 100 then
		drawer:drawTexture("UIData/GameNewImage.tga", g_last1MinPos, 270, 87, 88, 640, 498, WIDETYPE_5)
	else
		drawer:drawTexture("UIData/GameNewImage.tga", g_last1MinPos, 270, 87, 88, 640, 586, WIDETYPE_5)
	end

	-- LAST
	drawer:drawTexture("UIData/GameNewImage.tga", g_last1MinPos+90, 270, 302, 88, 0, 739, WIDETYPE_5)
	
	-- 1분
	drawer:drawTexture("UIData/GameNewImage.tga", g_last1MinPos+400, 270, 208, 93, 252, 827, WIDETYPE_5)

end





----------------------------------------------------

-- Last 10초

----------------------------------------------------
local g_last10Effect	= 0
local g_last10SecTime	= 0
local g_last10Sec		= true
local g_last10SecPos	= 0
local g_last10SecSound	= true

function WndField_InitLast10SecData()
	g_last10Effect	= 0
	g_last10SecTime	= 0
	g_last10Sec		= true
	g_last10SecPos	= 0
	g_last10SecSound= true
end

function WndField_RenderLast10Sec(deltaTime)

	if g_last10Sec == false then
		return
	end
	
	if g_last10SecSound then
		PlaySound("sound/siren.wav")
		g_last10SecSound = false
	end
	
	g_last10SecTime = g_last10SecTime + deltaTime
	
	-- 1500까지는 가운데로 간다.
	if 0 <= g_last10SecTime and g_last10SecTime <= 1500 then
		g_last10SecPos = Effect_Elastic_EaseOut(g_last10SecTime, -600, 800, 1500, 0, 0)
	
	-- 그후에 800이 되면 사라진다.
	elseif 1500 < g_last10SecTime and g_last10SecTime <= 2300 then
		g_last10SecPos = Effect_Back_EaseIn(g_last10SecTime-1500, 190, 1600, 800, 0)
	
	-- 2300이 넘으면 사라짐
	else
		g_last10SecTime = 2400
		g_last10Sec		= false
		g_last10SecPos	= 2000
		WndFieldEndLast10Sec()
		return
	end	
	
	-- 사이렌
	g_last10Effect = g_last10Effect + deltaTime
	g_last10Effect = g_last10Effect % 200
	if g_last10Effect < 100 then
		drawer:drawTexture("UIData/GameNewImage.tga", g_last10SecPos, 270, 87, 88, 640, 498, WIDETYPE_5)
	else
		drawer:drawTexture("UIData/GameNewImage.tga", g_last10SecPos, 270, 87, 88, 640, 586, WIDETYPE_5)
	end

	-- LAST 10초
	drawer:drawTexture("UIData/GameNewImage.tga", g_last10SecPos+90, 270, 600, 88, 0, 739, WIDETYPE_5)

end

local g_SubTowerAccumTime = 0;
local g_BrokenTowerIdx = 0;

function WndField_Render_Noty_SubTowerBroken(BrokenTowerIdx, bisOurTowerBroken, deltaTime)
	if g_SubTowerAccumTime < 2500 then
		local posX = (1024 - 513) / 2;
		posY = (768 - 36) / 2;
		if bisOurTowerBroken == 1 then
			drawer:drawTexture("UIData/fightClub_008.tga", posX, posY, 511, 53, 513, 36, WIDETYPE_5)
		else
			drawer:drawTexture("UIData/fightClub_008.tga", posX, posY, 511, 53, 513, 89, WIDETYPE_5)
		end
	else
		g_SubTowerAccumTime = 0;
		OnEndRendedSubTowerBroken();
	end
	g_SubTowerAccumTime = g_SubTowerAccumTime + deltaTime;
end

local g_RedTowerBrokenable = 0;
function WndField_Render_Noty_RED_TowerDestroyable(isOurTeamTowerDestroyable, deltaTime)
	DebugStr("WndField_Render_Noty_RED_TowerDestroyable1")

	if g_RedTowerBrokenable < 2500 then
		local posX = (1024 - 513) / 2;
		posY = (768 - 36) / 2 + 53;--sub tower broken 밑에출력
		if isOurTeamTowerDestroyable == 1 then
			drawer:drawTexture("UIData/fightClub_008.tga", posX, posY, 511, 53, 513, 89 + 53, WIDETYPE_5)
			DebugStr("WndField_Render_Noty_RED_TowerDestroyable2")	
		else
			drawer:drawTexture("UIData/fightClub_008.tga", posX, posY, 511, 53, 513, 142 + 53, WIDETYPE_5)
			DebugStr("WndField_Render_Noty_RED_TowerDestroyable3")
		end
	else
		g_RedTowerBrokenable = 0;
		OnEndRendedNotyRedTowerDestroyable();
	end
	DebugStr("WndField_Render_Noty_RED_TowerDestroyable4")
	g_RedTowerBrokenable = g_RedTowerBrokenable + deltaTime;
end

local g_BlueTowerBrokenable = 0;
function WndField_Render_Noty_BLUE_TowerDestroyable(isOurTeamTowerDestroyable, deltaTime)
	DebugStr("WndField_Render_Noty_BLUE_TowerDestroyable1")
	if g_BlueTowerBrokenable < 2500 then
		local posX = (1024 - 513) / 2;
		posY = (768 - 36) / 2 + 53;--sub tower broken 밑에출력
		if isOurTeamTowerDestroyable == 1 then
			drawer:drawTexture("UIData/fightClub_008.tga", posX, posY, 511, 53, 513, 89 + 53, WIDETYPE_5)
			DebugStr("WndField_Render_Noty_BLUE_TowerDestroyable2")
		else
			drawer:drawTexture("UIData/fightClub_008.tga", posX, posY, 511, 53, 513, 142 + 53, WIDETYPE_5)
			DebugStr("WndField_Render_Noty_BLUE_TowerDestroyable3")
	
		end
	else
			DebugStr("WndField_Render_Noty_BLUE_TowerDestroyable4")
		g_BlueTowerBrokenable = 0;
		OnEndRendedNotyBlueTowerDestroyable();
	end
	
	g_BlueTowerBrokenable = g_BlueTowerBrokenable + deltaTime;
	DebugStr("WndField_Render_Noty_BLUE_TowerDestroyable3")
	
end



local last10secEffectTime = 0
local g_redEffect = false
local g_blueEffect = false
local redEffectGauge = 0
local blueEffectGauge = 0
local g_redHP = GetCastleMaxHP()
local g_blueHP = GetCastleMaxHP()
local tHPTexY = {["err"]=0, [0]=182, 151, 120, 89, 58}
function WndField_RenderInfos(deltaTime, min, sec, realRedHP, realBlueHP, drawMaxHP, redDrawHP, redDrawHPRate, blueDrawHP, blueDrawHPRate, leftEmblem, RightEmblem, leftGuildName, rightGuildName, 
									maxTowerHP, RedMainTowerDestroyable, BlueMainTowerDestroyable)

	MAX_CASTLE_HP = maxTowerHP / 5
	if g_redHP >= maxTowerHP then
		g_redHP = maxTowerHP
	end
	
	if g_blueHP >= maxTowerHP then
		g_blueHP = maxTowerHP
	end

	-- 기본바탕
	local CASTLE_SIZE = 196
	local CASTLE_POSX = 270
	drawer:drawTexture("UIData/fightClub_008.tga", CASTLE_POSX, 2, 513, 56, 0, 0, WIDETYPE_5)
	
	-- 레드팀 캐슬 HP
	if g_redHP ~= realRedHP then
		g_redEffect = true 
		g_redHP = realRedHP
	end
	if g_redEffect then
		redEffectGauge = redEffectGauge + deltaTime
		if redEffectGauge >= 400 then
			g_redEffect = false
			redEffectGauge = 0
		end
	end
	
	-- 총5번을 돌면서 0 <= hp < 100000, 100000 <= hp < 200000 이런식으로 5번을 체크해야 한다.
	-- remain+(divide-i)을 하게되면 항상 0 ~ 100000사이의 값이 나오게 된다	
	local redRemain = realRedHP % MAX_CASTLE_HP
	local redDivide = realRedHP / MAX_CASTLE_HP
	local redHPRate = redRemain / MAX_CASTLE_HP
	local redTempHP = 0
	if redRemain == 0 then
		blueTempHP = MAX_CASTLE_HP
	else
		blueTempHP = redRemain 
	end
		
	local redHPRate = redTempHP / MAX_CASTLE_HP
	
	for i=0, 4 do
		if redDivide-i >= 0 then
			if redDivide-i == 0 then
				local _redEffectGauge = redEffectGauge % 60
				if _redEffectGauge < 30 then
					local currentHP = ( CASTLE_SIZE * redDrawHPRate ) / 100
					local currentX = CASTLE_SIZE - currentHP
					
					drawer:drawTexture("UIData/fightClub_008.tga", (CASTLE_POSX+3)+currentX, 15, currentHP, 31, currentX, tHPTexY[i], WIDETYPE_5)
				else
					local currentHP = ( CASTLE_SIZE * redDrawHPRate ) / 100
					local currentX = CASTLE_SIZE - currentHP
					
					-- 마지막은 한번더 그린다(뒤에 배경이 어두워서 효과가 잘 나오지 않아서)
					if redDivide == 0 then
						drawer:drawTexture("UIData/fightClub_008.tga", (CASTLE_POSX+3)+currentX, 15, currentHP, 31, currentX, tHPTexY[i], WIDETYPE_5)
					end
					
					drawer:drawTextureA("UIData/fightClub_008.tga", (CASTLE_POSX+3)+currentX, 15, currentHP, 31, currentX, 213, 150, WIDETYPE_5)
				end
			else
				drawer:drawTexture("UIData/fightClub_008.tga", (CASTLE_POSX+3), 15, CASTLE_SIZE, 31, 0, tHPTexY[i], WIDETYPE_5)
			end
		end
	end
	
	if CheckfacilityData(FACILITYCODE_TOWERHP) == 1 then
		DrawEachNumberAdvancedWide("UIData/dungeonmsg.tga", realRedHP, 2, CASTLE_POSX+CASTLE_SIZE-30, 23, 516, 224, 12, 14, 15, WIDETYPE_5)
	end
	
	if RedMainTowerDestroyable == 0 then
		drawer:drawTexture("UIData/fightClub_008.tga",  (CASTLE_POSX+3), 15, 196, 31, 0, 244, WIDETYPE_5)
	end
	
	-- 블루팀 캐슬 HP
	if g_blueHP ~= realBlueHP then
		g_blueEffect = true 
		g_blueHP = realBlueHP
	end
	if g_blueEffect then
		blueEffectGauge = blueEffectGauge + deltaTime
		if blueEffectGauge >= 400 then
			g_blueEffect = false
			blueEffectGauge = 0
		end
	end
		
	-- 총5번을 돌면서 0 <= hp < 100000, 100000 <= hp < 200000 이런식으로 5번을 체크해야 한다.
	-- remain+(divide-i)을 하게되면 항상 0 ~ 100000사이의 값이 나오게 된다
	local blueRemain = realBlueHP % MAX_CASTLE_HP
	local blueDivide = realBlueHP / MAX_CASTLE_HP
	local blueTempHP = 0
	if blueRemain == 0 then
		blueTempHP = MAX_CASTLE_HP
	else
		blueTempHP = blueRemain 
	end
		
	local blueHPRate = blueTempHP / MAX_CASTLE_HP
	
	for i=0, 4 do
		if blueDivide-i >= 0 then
			if blueDivide-i == 0 then
				local _blueEffectGauge = blueEffectGauge % 60
				if _blueEffectGauge < 30 then
					local currentHP = ( CASTLE_SIZE * blueDrawHPRate ) / 100
					local currentX = CASTLE_SIZE - currentHP
					
					drawer:drawTexture("UIData/fightClub_008.tga", CASTLE_POSX+314, 15, currentHP, 31, 196, tHPTexY[i], WIDETYPE_5)
				else
					local currentHP = ( CASTLE_SIZE * blueDrawHPRate ) / 100
					local currentX = CASTLE_SIZE - currentHP
					
					-- 마지막은 한번더 그린다(뒤에 배경이 어두워서 효과가 잘 나오지 않아서)
					if blueDivide == 0 then
						drawer:drawTexture("UIData/fightClub_008.tga", CASTLE_POSX+314, 15, currentHP, 31, 196, tHPTexY[i], WIDETYPE_5)
					end
					
					drawer:drawTextureA("UIData/fightClub_008.tga", CASTLE_POSX+314, 15, currentHP, 31, 196, 213, 150, WIDETYPE_5)
				end
			else
				local currentHP = ( CASTLE_SIZE * blueDrawHPRate ) / 100 + ( (blueDivide-i) * CASTLE_SIZE )
				local currentX = CASTLE_SIZE - currentHP
					
				currentHP = math.min(197, currentHP);
				--if currentHP > 197 then 
				--	currentHP = 197;
				--end
				drawer:drawTexture("UIData/fightClub_008.tga", CASTLE_POSX+314, 15, currentHP, 31, 196, tHPTexY[i], WIDETYPE_5)
			end
		end
	end
	
	if CheckfacilityData(FACILITYCODE_TOWERHP) == 1 then
		DrawEachNumberAdvancedWide("UIData/dungeonmsg.tga", realBlueHP, 1, CASTLE_POSX+336, 23, 516, 224, 12, 14, 15, WIDETYPE_5)
	end
	if BlueMainTowerDestroyable == 0 then
		drawer:drawTexture("UIData/fightClub_008.tga",  (CASTLE_POSX+314), 15, 196, 31, 196, 244, WIDETYPE_5)
	end
	-- 분
	local ten = (min/10)
	local one = (min%10)
	drawer:drawTexture("UIData/GameNewImage.tga", CASTLE_POSX+213, 17, 20, 26, 77+(ten*20), 704, WIDETYPE_5)
	drawer:drawTexture("UIData/GameNewImage.tga", CASTLE_POSX+231, 17, 20, 26, 77+(one*20), 704, WIDETYPE_5)

	-- :
	drawer:drawTexture("UIData/GameNewImage.tga", CASTLE_POSX+247, 17, 20, 26, 277, 704, WIDETYPE_5)
	
	-- 초
	ten = (sec/10)
	one = (sec%10)
	drawer:drawTexture("UIData/GameNewImage.tga", CASTLE_POSX+261, 17, 20, 26, 77+(ten*20), 704, WIDETYPE_5)
	drawer:drawTexture("UIData/GameNewImage.tga", CASTLE_POSX+279, 17, 20, 26, 77+(one*20), 704, WIDETYPE_5)
	
	------------------------
	-- 클럽 엠블렘 이미지
	------------------------
	if leftEmblem > 0 then 
		--DebugStr('leftEmblem:'..leftEmblem)
		drawer:drawTextureSA(GetClubDirectory(GetLanguageType())..leftEmblem..".tga", 455, 5, 32, 32, 0, 0, 210, 210, 255, 0, 0, WIDETYPE_5)	
	end

	if RightEmblem > 0 then 
		--DebugStr('RightEmblem:'..RightEmblem)
		drawer:drawTextureSA(GetClubDirectory(GetLanguageType())..RightEmblem..".tga", 572, 5, 32, 32, 0, 0, 210, 210, 255, 0, 0, WIDETYPE_5)	
	end
	
	------------------------
	-- 클럽 이름
	------------------------
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	drawer:setTextColor(255,255,255,255)
	
	if leftGuildName ~= "" then
		local size1 = GetStringSize(g_STRING_FONT_GULIMCHE, 12, leftGuildName)
		drawer:drawText(leftGuildName, 370-size1/2, 54, WIDETYPE_5)
	end
	
	if rightGuildName ~= "" then
		local size2 = GetStringSize(g_STRING_FONT_GULIMCHE, 12, rightGuildName)
		drawer:drawText(rightGuildName, 670-size2/2, 54, WIDETYPE_5)
	end
	
	--drawer:drawText(realRedHP, 370, 24, WIDETYPE_5)
	--drawer:drawText(realBlueHP, 680, 24, WIDETYPE_5)
	


end

local StartX = 100;
local StartY = 100;
function SubTower_HP_Render(SubTowerIndex, Rate)

	
	local TeamSide = SubTowerIndex / 4;		-- 어느팀의 타워인가?
	local TowerIndex = SubTowerIndex % 4;	-- 몇번째 타워인가
	
	local CurrRedPos = 392 + ( TeamSide * 86 );
	local HPRate = 0;
	if TeamSide == 1 then 
		HPRate = (86 * (Rate / 100)) / 100;
		drawer:drawTexture("UIData/fightClub_008.tga", 289 + TeamSide * ( 240) + ((TowerIndex -1) * 74 ), 
		50 , HPRate, 17, 0 + ( TeamSide * 86 ), 275 + (TowerIndex -1 ) * 17, WIDETYPE_5);
	else
		HPRate = 86 - (86 * (Rate / 100)) / 100;
		drawer:drawTexture("UIData/fightClub_008.tga", 289 + TeamSide * ( 240) + ((TowerIndex -1) * 74 ) + HPRate, 
		50 , 86 - HPRate, 17, 0 + ( TeamSide * 86 ) + HPRate, 275 + (TowerIndex -1 ) * 17, WIDETYPE_5);
	end
--280, 45
end

function SubTower_HP_BackGround()
	--SubTower BackGroud
	drawer:drawTexture("UIData/fightClub_008.tga", 281, 44, 489, 35, 513, 0, WIDETYPE_5);
end




----------------------------------------------------

-- 웨폰 주울수 있는지 알려주기

----------------------------------------------------
function WndField_NotifyPickupWeapon(weaponIndex, weaponPosX, weaponPosY)
	drawer:drawTexture("UIData/GameNewImage.tga", weaponPosX-40, weaponPosY-130, 84, 62, 474, 883)
end



function WndField_ShowEmblemKey(LeftEmblem, RightEmblem)
	if LeftEmblem > 0 then
		drawer:drawTextureSA(GetClubDirectory(GetLanguageType())..LeftEmblem..".tga", 310 , 12, 32, 32, 0, 0, 350, 350, 255, 0, 0)
	end
	
	if RightEmblem > 0 then
		drawer:drawTextureSA(GetClubDirectory(GetLanguageType())..RightEmblem..".tga", 670 , 12 , 32, 32, 0, 0, 350, 350, 255, 0, 0)
	end
end




----------------------------------------------------

-- 미니맵

----------------------------------------------------
local g_PlayerAngle = 0
local g_PlayerX = 0
local g_PlayerY = 0
local MINIMAP_POSX = 830
local MINIMAP_POSY = 10
local MINIMAP_SIZEX = 187
local MINIMAP_SIZEY = 118

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_wndField_invisibleMinimap")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 308, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 308, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(1);
mywindow:setPosition(MINIMAP_POSX, MINIMAP_POSY)
mywindow:setSize(MINIMAP_SIZEX, MINIMAP_SIZEY)
mywindow:setZOrderingEnabled(false)
mywindow:setSubscribeEvent("MouseButtonUp", "OnMouseLButtonUpInMinimap")
root:addChildWindow(mywindow)

function OnMouseLButtonUpInMinimap(args)
	local window = CEGUI.toWindowEventArgs(args).window
	local position = window:getPosition()
	local posX = CEGUI.toMouseEventArgs(args).position.x - position.x.offset - (MINIMAP_SIZEX/2) + 4
	local posY = CEGUI.toMouseEventArgs(args).position.y - position.y.offset - (MINIMAP_SIZEY/2)
	
	SetCameraMoveToMinimap(posX, posY)
end

function WndField_RenderMinimap(mapName)
	if mapName == "scn_field_8vs8" then
		drawer:drawTextureA("UIData/fightClub_006.tga", MINIMAP_POSX, MINIMAP_POSY, 187, 118, 333, 195, 200, WIDETYPE_1)
	elseif mapName == "scn_field_test" then
		drawer:drawTextureA("UIData/fightClub_006.tga", MINIMAP_POSX, MINIMAP_POSY, 187, 118, 463, 379, 200, WIDETYPE_1)		
	elseif mapName == "scn_field_china" then
		drawer:drawTextureA("UIData/fightClub_006.tga", MINIMAP_POSX, MINIMAP_POSY, 187, 118, 650, 379, 200, WIDETYPE_1)
	end
end
function WndField_Minimap_RenderTowerHP(TowerIndex, PosX, PosY, HPRate)
	--HPRate = 10000 ~ 0
	local TeamSide = TowerIndex / 4;		-- 어느팀의 타워인가?
	local TowerIndex = TowerIndex % 4;	-- 몇번째 타워인가

	local isMain = false;							-- 메인 타워인가?
	if TowerIndex == 0 then
		isMain = true;
	end
	if isMain == true then 
		drawer:drawTexture("UIData/fightClub_006.tga", MINIMAP_POSX + PosX+86, MINIMAP_POSY - PosY+52, 15, 16,  463, 363, WIDETYPE_1);
		local Adjust = (16 * HPRate) / 10000;
		drawer:drawTexture("UIData/fightClub_006.tga", MINIMAP_POSX + PosX+86, MINIMAP_POSY - PosY+52 + 16 - Adjust, 15, 16 - (16 - Adjust),  463 + (15 * (TeamSide+1)), 363 + 16 - Adjust, WIDETYPE_1);
	else
		drawer:drawTexture("UIData/fightClub_006.tga", MINIMAP_POSX + PosX+88, MINIMAP_POSY - PosY+52, 10, 12,  508, 367, WIDETYPE_1);
		local Adjust = (12 * HPRate) / 10000;
		drawer:drawTexture("UIData/fightClub_006.tga", MINIMAP_POSX + PosX+88, MINIMAP_POSY - PosY+52 + 12 - Adjust, 10, 12 - (12 - Adjust),  508 + (10 * (TeamSide+1)), 367 + 12 - Adjust, WIDETYPE_1);
	end		
end
function WndField_RenderCharacterPosToMap(characterIndex, bMy, myTeam, bMyTeam, x, y, angle, hp, bPlaying)
	
	if bPlaying == 1 then
		if bMyTeam == 0 then
			return
		end
	end
	
	local posX =  x+94
	local posY = -y+59
	local texX = 497
	local texY = 0
	local sizeX = 24
	local sizeY = 20
	if bMy == 1 then
		if myTeam == 0 then
			texX = 469
			texY = 127
		else
			texX = 435
			texY = 127
		end
		sizeX = 22
		sizeY = 26
		
		drawer:drawTextureWithScale_Angle_Offset("UIData/fightClub_005.tga", MINIMAP_POSX+posX, MINIMAP_POSY+posY, sizeX, sizeY, texX, texY, 160, 160, 180, angle, 8, 0, 0, WIDETYPE_1);
	else
		if hp > 0 then
			if bMyTeam == 1 then
				if myTeam == 0 then
					texX = 447
					texY = 156
				else
					texX = 435
					texY = 156
				end
			else
				if myTeam == 0 then
					texX = 435
					texY = 156
				else
					texX = 447
					texY = 156
				end
			end
		else
			texX = 459
			texY = 156
		end
		sizeX = 12
		sizeY = 12
		
		drawer:drawTextureWithScale_Angle_Offset("UIData/fightClub_005.tga", MINIMAP_POSX+posX, MINIMAP_POSY+posY, sizeX, sizeY, texX, texY, 180, 180, 180, angle, 8, 0, 0, WIDETYPE_1);
	end		
end



--------------------------------------------------------------------

-- 점령전 정보

--------------------------------------------------------------------
local WATCHING_WHO = PreCreateString_2488	--GetSStringInfo(LAN_CLUBWAR_PLAY_OBSERVER)	-- %s 관전중
function WndField_DrawWatchingCharacter(team, characterName)
	
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


local effectEnableEnterTime = 0
function WndField_DrawNotifyEnableEnter(deltaTime)
	drawer:drawTexture("UIData/fightClub_005.tga", 257, 116, 514, 41, 0, 220, WIDETYPE_5)
	
	effectEnableEnterTime = effectEnableEnterTime + deltaTime
	effectEnableEnterTime = effectEnableEnterTime % 400
	if effectEnableEnterTime < 200 then
		drawer:drawTexture("UIData/fightClub_005.tga", 257, 116, 514, 41, 0, 261, WIDETYPE_5)
	end
end




----------------------------------------------------

-- 도움말

----------------------------------------------------
function WndField_RenderHelp(bHelp)

	-- 도움말 버튼
	--drawer:drawTexture("UIData/GameNewImage.tga", 274, 5, 87, 21, 307, 122)
	
	-- 도움말 상세정보
	if bHelp == 1 then
		drawer:drawTexture("UIData/F1-Help.tga", 0, 0, 1024, 768, 0, 0, WIDETYPE_6)
	end	
end





--------------------------------------------------------------------

-- 클럽원 현황보기

--------------------------------------------------------------------
--  클럽원 현황보기알파창
alphaWindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_ShowClubUserInfo_Alpha")
alphaWindow:setTexture("Enabled",	"UIData/invisible.tga", 0, 0)
alphaWindow:setTexture("Disabled",	"UIData/invisible.tga", 0, 0)
alphaWindow:setProperty("FrameEnabled",		"False")
alphaWindow:setProperty("BackgroundEnabled","False")
alphaWindow:setWideType(6)
alphaWindow:setPosition((1024 - 474) / 2, 130)
alphaWindow:setSize(474, 483)
alphaWindow:setVisible(false)
alphaWindow:setAlwaysOnTop(true)
root:addChildWindow(alphaWindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_wndField_ShowClubUserInfoImage")
mywindow:setTexture("Enabled", "UIData/fightClub_009.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/fightClub_009.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 0)
mywindow:setSize(474, 483)
mywindow:setZOrderingEnabled(false)
mywindow:setVisible(true)
alphaWindow:addChildWindow(mywindow)

-- 현재 누구를 선택했는지 보여주는 라인
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_wndField_selectLine")
mywindow:setTexture("Enabled", "UIData/fightClub_008.tga", 536, 425)
mywindow:setTexture("Disabled", "UIData/fightClub_008.tga", 536, 425)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(12, 32)
mywindow:setSize(488, 23)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("sj_wndField_ShowClubUserInfoImage"):addChildWindow(mywindow)

local MAX_PLAYER_HALF = GetMaxGuildwarUser() / 2
for i=0, MAX_PLAYER_HALF-1 do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_wndField_ShowClubUserInfo_bg_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(12, 90+(i*24))
	mywindow:setSize(450, 20)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	winMgr:getWindow("sj_wndField_ShowClubUserInfoImage"):addChildWindow(mywindow)
	
	-- 레벨
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_wndField_ShowClubUserInfo_level_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(4, 0)
	mywindow:setSize(100, 20)
	mywindow:setZOrderingEnabled(false)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setTextColor(255, 255, 255, 255)
	winMgr:getWindow("sj_wndField_ShowClubUserInfo_bg_"..i):addChildWindow(mywindow)
	
	-- 이름
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_wndField_ShowClubUserInfo_name_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(50, 0)
	mywindow:setSize(100, 20)
	mywindow:setZOrderingEnabled(false)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setTextColor(255, 255, 255, 255)
	winMgr:getWindow("sj_wndField_ShowClubUserInfo_bg_"..i):addChildWindow(mywindow)
	
	-- hp 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_wndField_ShowClubUserInfo_hp1_"..i)
	mywindow:setTexture("Enabled", "UIData/fightClub_009.tga", 0, 523)
	mywindow:setTexture("Disabled", "UIData/fightClub_009.tga", 0, 523)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(180, 1)
	mywindow:setSize(123, 18)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_wndField_ShowClubUserInfo_bg_"..i):addChildWindow(mywindow)
	
	-- hp 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_wndField_ShowClubUserInfo_hp2_"..i)
	mywindow:setTexture("Enabled", "UIData/fightClub_009.tga", 0, 541)
	mywindow:setTexture("Disabled", "UIData/fightClub_009.tga", 0, 541)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(180, 1)
	mywindow:setSize(123, 18)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_wndField_ShowClubUserInfo_bg_"..i):addChildWindow(mywindow)
	
	-- 부활시간 텍스트
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_wndField_ShowClubUserInfo_reviveTime_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(236, 0)
	mywindow:setSize(100, 20)
	mywindow:setZOrderingEnabled(false)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setTextColor(255, 255, 255, 255)
	winMgr:getWindow("sj_wndField_ShowClubUserInfo_bg_"..i):addChildWindow(mywindow)
	
	-- ko
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_wndField_ShowClubUserInfo_kodown_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(300, 0)
	mywindow:setSize(20, 20)
	mywindow:setZOrderingEnabled(false)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setTextColor(255, 255, 255, 255)
	winMgr:getWindow("sj_wndField_ShowClubUserInfo_bg_"..i):addChildWindow(mywindow)
	
	-- 아이템 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_wndField_ShowClubUserInfo_item_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(360, 0)
	mywindow:setSize(54, 56)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_wndField_ShowClubUserInfo_bg_"..i):addChildWindow(mywindow)
	
	-- 카메라 시점 버튼
	mywindow = winMgr:createWindow("TaharezLook/Button", "sj_wndField_ShowClubUserInfo_button_"..i)
	mywindow:setTexture("Normal", "UIData/fightClub_009.tga", 219, 523)
	mywindow:setTexture("Hover", "UIData/fightClub_009.tga", 219, 543)
	mywindow:setTexture("Pushed", "UIData/fightClub_009.tga", 219, 563)
	mywindow:setTexture("PushedOff", "UIData/fightClub_009.tga", 219, 523)
	mywindow:setPosition(410, 0)
	mywindow:setSize(20, 20)
	mywindow:setUserString("characterIndex", 0)
	mywindow:setSubscribeEvent("MouseButtonUp", "OnClickedChangeCameraView")
	winMgr:getWindow("sj_wndField_ShowClubUserInfo_bg_"..i):addChildWindow(mywindow)
	
end

-- 클럽 마크 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_wndField_Emblem")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 819, 1010)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 819, 1010)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(15, 32)
mywindow:setSize(32, 32)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("sj_wndField_ShowClubUserInfoImage"):addChildWindow(mywindow)

-- 클럽 이름
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_wndField_guildName")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setPosition(60, 35)
mywindow:setSize(100, 20)
mywindow:setZOrderingEnabled(false)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 16)
mywindow:setTextColor(255, 255, 255, 255)
winMgr:getWindow("sj_wndField_ShowClubUserInfoImage"):addChildWindow(mywindow)

function WndField_ShowClubUserInfo(bPushTab, emblemKey, guildName, team)
	if bPushTab == 1 then
		winMgr:getWindow("sj_ShowClubUserInfo_Alpha"):setVisible(true)
		winMgr:getWindow("sj_wndField_ShowClubUserInfoImage"):setVisible(true)
		
		winMgr:getWindow("sj_wndField_selectLine"):setVisible(false)	
		if team == 0 then			
			winMgr:getWindow("sj_wndField_ShowClubUserInfoImage"):setTexture("Enabled", "UIData/fightClub_009.tga", 0, 0)
			winMgr:getWindow("sj_wndField_ShowClubUserInfoImage"):setTexture("Disabled", "UIData/fightClub_009.tga", 0, 0)
		else
			winMgr:getWindow("sj_wndField_ShowClubUserInfoImage"):setTexture("Enabled", "UIData/fightClub_009.tga", 474, 0)
			winMgr:getWindow("sj_wndField_ShowClubUserInfoImage"):setTexture("Disabled", "UIData/fightClub_009.tga", 474, 0)
		end
		
		for i=0, MAX_PLAYER_HALF-1 do
			winMgr:getWindow("sj_wndField_ShowClubUserInfo_bg_"..i):setEnabled(false)
			winMgr:getWindow("sj_wndField_ShowClubUserInfo_bg_"..i):setVisible(true)
			
			winMgr:getWindow("sj_wndField_ShowClubUserInfo_level_"..i):setVisible(false)
			winMgr:getWindow("sj_wndField_ShowClubUserInfo_name_"..i):setVisible(false)
			winMgr:getWindow("sj_wndField_ShowClubUserInfo_hp1_"..i):setVisible(false)
			winMgr:getWindow("sj_wndField_ShowClubUserInfo_hp2_"..i):setVisible(false)
			winMgr:getWindow("sj_wndField_ShowClubUserInfo_reviveTime_"..i):setVisible(false)
			winMgr:getWindow("sj_wndField_ShowClubUserInfo_kodown_"..i):setVisible(false)
			winMgr:getWindow("sj_wndField_ShowClubUserInfo_item_"..i):setVisible(false)
			winMgr:getWindow("sj_wndField_ShowClubUserInfo_button_"..i):setVisible(false)
		end
	else
		winMgr:getWindow("sj_ShowClubUserInfo_Alpha"):setVisible(false)
		winMgr:getWindow("sj_wndField_selectLine"):setVisible(false)
		
		for i=0, MAX_PLAYER_HALF-1 do
			winMgr:getWindow("sj_wndField_ShowClubUserInfo_bg_"..i):setEnabled(false)
			winMgr:getWindow("sj_wndField_ShowClubUserInfo_bg_"..i):setVisible(false)
			
			winMgr:getWindow("sj_wndField_ShowClubUserInfo_level_"..i):setVisible(false)
			winMgr:getWindow("sj_wndField_ShowClubUserInfo_name_"..i):setVisible(false)
			winMgr:getWindow("sj_wndField_ShowClubUserInfo_hp1_"..i):setVisible(false)
			winMgr:getWindow("sj_wndField_ShowClubUserInfo_hp2_"..i):setVisible(false)
			winMgr:getWindow("sj_wndField_ShowClubUserInfo_reviveTime_"..i):setVisible(false)
			winMgr:getWindow("sj_wndField_ShowClubUserInfo_kodown_"..i):setVisible(false)
			winMgr:getWindow("sj_wndField_ShowClubUserInfo_item_"..i):setVisible(false)
			winMgr:getWindow("sj_wndField_ShowClubUserInfo_button_"..i):setVisible(false)
		end
	end
	
	if emblemKey > 0 then
		winMgr:getWindow("sj_wndField_Emblem"):setTexture('Enabled', GetClubDirectory(GetLanguageType())..emblemKey..".tga", 0, 0)
		winMgr:getWindow("sj_wndField_Emblem"):setTexture('Disabled', GetClubDirectory(GetLanguageType())..emblemKey..".tga", 0, 0)
	end
	
	if guildName ~= "" then
		winMgr:getWindow("sj_wndField_guildName"):setText(guildName)
	end
end


REVIVE_AFTER_SECONDS = PreCreateString_2432	--GetSStringInfo(LAN_GANGWAR_NOTIFY_1)		-- %02d 초 뒤 부활
function WndField_ClubUserInfo_Exist(count, characterIndex, level, name, hp, maxHP, reviveTime, ko, down, itemType, bEnableView, bCurrentView)
	if count >= MAX_PLAYER_HALF then
		return
	end
	
	winMgr:getWindow("sj_wndField_ShowClubUserInfo_bg_"..count):setEnabled(true)
	
	local levelText = "Lv. "..level
	winMgr:getWindow("sj_wndField_ShowClubUserInfo_level_"..count):setVisible(true)	
	winMgr:getWindow("sj_wndField_ShowClubUserInfo_level_"..count):setText(levelText)

	local nameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, name)
	winMgr:getWindow("sj_wndField_ShowClubUserInfo_name_"..count):setVisible(true)
	winMgr:getWindow("sj_wndField_ShowClubUserInfo_name_"..count):setPosition(110-nameSize/2, 0)
	winMgr:getWindow("sj_wndField_ShowClubUserInfo_name_"..count):setText(name)
	
	local HP_POSX = 180
	local HP_SIZE = 123
	local currHP = hp * HP_SIZE / maxHP
	winMgr:getWindow("sj_wndField_ShowClubUserInfo_hp1_"..count):setVisible(true)
	winMgr:getWindow("sj_wndField_ShowClubUserInfo_hp2_"..count):setVisible(true)
	winMgr:getWindow("sj_wndField_ShowClubUserInfo_hp2_"..count):setPosition(HP_POSX, 1)
	winMgr:getWindow("sj_wndField_ShowClubUserInfo_hp2_"..count):setSize(currHP, 18)
	
	if hp > 0 then
		winMgr:getWindow("sj_wndField_ShowClubUserInfo_reviveTime_"..count):setVisible(false)
	else
		if reviveTime > 0 then
			winMgr:getWindow("sj_wndField_ShowClubUserInfo_reviveTime_"..count):setVisible(true)
			winMgr:getWindow("sj_wndField_ShowClubUserInfo_reviveTime_"..count):setText(reviveTime)
		end
	end

	local kodownText = ko.." / "..down
	local kodownSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, kodownText)
	winMgr:getWindow("sj_wndField_ShowClubUserInfo_kodown_"..count):setVisible(true)
	winMgr:getWindow("sj_wndField_ShowClubUserInfo_kodown_"..count):setPosition(328-kodownSize/2, 0)
	winMgr:getWindow("sj_wndField_ShowClubUserInfo_kodown_"..count):setText(kodownText)
	
	if itemType >= 0 then
		winMgr:getWindow("sj_wndField_ShowClubUserInfo_item_"..count):setVisible(true)
		winMgr:getWindow("sj_wndField_ShowClubUserInfo_item_"..count):setScaleWidth(90)
		winMgr:getWindow("sj_wndField_ShowClubUserInfo_item_"..count):setScaleHeight(90)
		winMgr:getWindow("sj_wndField_ShowClubUserInfo_item_"..count):setTexture("Disabled", "UIData/fightClub_005.tga", tPropertyItemTexX[itemType], tPropertyItemTexY[itemType])
	end
	
	-- 현재 내가 다운되서 다른유저 카메라로 넘어갈 수 있을때만
	if bEnableView == 1 then
		winMgr:getWindow("sj_wndField_ShowClubUserInfo_button_"..count):setVisible(true)
		winMgr:getWindow("sj_wndField_ShowClubUserInfo_button_"..count):setUserString("characterIndex", characterIndex)
	else
		winMgr:getWindow("sj_wndField_ShowClubUserInfo_button_"..count):setVisible(false)
	end
	
	if bCurrentView == 1 then
		winMgr:getWindow("sj_wndField_selectLine"):setVisible(true)
		winMgr:getWindow("sj_wndField_selectLine"):setPosition(12, 88+(count*24))
	end
end


function OnClickedChangeCameraView(args)
	local local_window = CEGUI.toWindowEventArgs(args).window
	local characterNumber = local_window:getUserString("characterIndex")
	SetDrawCharacterIndexToPlay(characterNumber)
end




----------------------------------------------------

-- 점령전 유저 정보(관전자 전용)

----------------------------------------------------
local scaleX			= 948;
local scaleY			= 483;
	
-- 채널 선택 루트 알파창
alphaWindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_ShowClubUserInfoImage_observer_Alpha")
alphaWindow:setTexture("Enabled",	"UIData/invisible.tga", 0, 0)
alphaWindow:setTexture("Disabled",	"UIData/invisible.tga", 0, 0)
alphaWindow:setProperty("FrameEnabled",		"False")
alphaWindow:setProperty("BackgroundEnabled","False")
alphaWindow:setWideType(6)
alphaWindow:setPosition(38, 130)
alphaWindow:setSize(scaleX, scaleY+31)
alphaWindow:setVisible(false)
alphaWindow:setAlwaysOnTop(true)
root:addChildWindow(alphaWindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_wndField_ShowClubUserInfoImage_observer")
mywindow:setTexture("Enabled", "UIData/fightClub_009.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/fightClub_009.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 0)
mywindow:setSize(948, 483)
mywindow:setZOrderingEnabled(false)
mywindow:setVisible(true)
alphaWindow:addChildWindow(mywindow)

-- 현재 누구를 선택했는지 보여주는 라인
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_wndField_selectLine_observer")
mywindow:setTexture("Enabled", "UIData/fightClub_008.tga", 536, 425)
mywindow:setTexture("Disabled", "UIData/fightClub_008.tga", 536, 425)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(12, 32)
mywindow:setSize(488, 23)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("sj_wndField_ShowClubUserInfoImage_observer"):addChildWindow(mywindow)

local MAX_PLAYER = GetMaxGuildwarUser()
for i=0, MAX_PLAYER-1 do
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_wndField_ShowClubUserInfo_bg_observer_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(12+(475*(i/MAX_PLAYER_HALF)), 90+((i%MAX_PLAYER_HALF)*24))
	mywindow:setSize(450, 20)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	winMgr:getWindow("sj_wndField_ShowClubUserInfoImage_observer"):addChildWindow(mywindow)
	
	-- 레벨
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_wndField_ShowClubUserInfo_level_observer_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(4, 0)
	mywindow:setSize(100, 20)
	mywindow:setZOrderingEnabled(false)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setTextColor(255, 255, 255, 255)
	winMgr:getWindow("sj_wndField_ShowClubUserInfo_bg_observer_"..i):addChildWindow(mywindow)
	
	-- 이름
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_wndField_ShowClubUserInfo_name_observer_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(50, 0)
	mywindow:setSize(100, 20)
	mywindow:setZOrderingEnabled(false)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setTextColor(255, 255, 255, 255)
	winMgr:getWindow("sj_wndField_ShowClubUserInfo_bg_observer_"..i):addChildWindow(mywindow)
	
	-- hp 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_wndField_ShowClubUserInfo_hp1_observer_"..i)
	mywindow:setTexture("Enabled", "UIData/fightClub_009.tga", 0, 523)
	mywindow:setTexture("Disabled", "UIData/fightClub_009.tga", 0, 523)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(180, 1)
	mywindow:setSize(123, 18)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_wndField_ShowClubUserInfo_bg_observer_"..i):addChildWindow(mywindow)
	
	-- hp 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_wndField_ShowClubUserInfo_hp2_observer_"..i)
	mywindow:setTexture("Enabled", "UIData/fightClub_009.tga", 0, 541)
	mywindow:setTexture("Disabled", "UIData/fightClub_009.tga", 0, 541)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(180, 1)
	mywindow:setSize(123, 18)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_wndField_ShowClubUserInfo_bg_observer_"..i):addChildWindow(mywindow)
	
	-- 부활시간 텍스트
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_wndField_ShowClubUserInfo_reviveTime_observer_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(236, 0)
	mywindow:setSize(100, 20)
	mywindow:setZOrderingEnabled(false)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setTextColor(255, 255, 255, 255)
	winMgr:getWindow("sj_wndField_ShowClubUserInfo_bg_observer_"..i):addChildWindow(mywindow)
	
	-- ko
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_wndField_ShowClubUserInfo_kodown_observer_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(300, 0)
	mywindow:setSize(20, 20)
	mywindow:setZOrderingEnabled(false)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setTextColor(255, 255, 255, 255)
	winMgr:getWindow("sj_wndField_ShowClubUserInfo_bg_observer_"..i):addChildWindow(mywindow)
	
	-- 아이템 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_wndField_ShowClubUserInfo_item_observer_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(360, 0)
	mywindow:setSize(54, 56)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_wndField_ShowClubUserInfo_bg_observer_"..i):addChildWindow(mywindow)
	
	-- 카메라 시점 버튼
	mywindow = winMgr:createWindow("TaharezLook/Button", "sj_wndField_ShowClubUserInfo_button_observer_"..i)
	mywindow:setTexture("Normal", "UIData/fightClub_009.tga", 219, 523)
	mywindow:setTexture("Hover", "UIData/fightClub_009.tga", 219, 543)
	mywindow:setTexture("Pushed", "UIData/fightClub_009.tga", 219, 563)
	mywindow:setTexture("PushedOff", "UIData/fightClub_009.tga", 219, 523)
	mywindow:setPosition(410, 0)
	mywindow:setSize(20, 20)
	mywindow:setUserString("characterIndex", 0)
	mywindow:setSubscribeEvent("MouseButtonUp", "OnClickedChangeCameraViewObserver")
	winMgr:getWindow("sj_wndField_ShowClubUserInfo_bg_observer_"..i):addChildWindow(mywindow)
end

-- 클럽 마크 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_wndField_Emblem_observer_L")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 819, 1010)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 819, 1010)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(12, 32)
mywindow:setSize(32, 32)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("sj_wndField_ShowClubUserInfoImage_observer"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_wndField_Emblem_observer_R")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 819, 1010)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 819, 1010)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(487, 32)
mywindow:setSize(32, 32)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("sj_wndField_ShowClubUserInfoImage_observer"):addChildWindow(mywindow)

-- 클럽 이름
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_wndField_guildName_observer_L")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setPosition(54, 35)
mywindow:setSize(100, 20)
mywindow:setZOrderingEnabled(false)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 16)
mywindow:setTextColor(255, 255, 255, 255)
winMgr:getWindow("sj_wndField_ShowClubUserInfoImage_observer"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_wndField_guildName_observer_R")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setPosition(529, 35)
mywindow:setSize(100, 20)
mywindow:setZOrderingEnabled(false)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 16)
mywindow:setTextColor(255, 255, 255, 255)
winMgr:getWindow("sj_wndField_ShowClubUserInfoImage_observer"):addChildWindow(mywindow)

-- 카메라 모드 변경
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_wndField_cameraMode")
mywindow:setTexture("Enabled", "UIData/fightClub_009.tga", 239, 523)
mywindow:setTexture("Disabled", "UIData/fightClub_009.tga", 239, 523)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
--mywindow:setPosition(385, 670)
mywindow:setPosition(500, 670)
mywindow:setSize(254, 86)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

-- 카메라 고정 시점
local tCameraName  = {["err"]=0, [0]="sj_wndField_cameraMode_fix", "sj_wndField_cameraMode_free"}
local tCameraPosX  = {["err"]=0, [0]=10, 136}
local tCameraEvent = {["err"]=0, [0]="SelectCameraModeFix", "SelectCameraModeFree"}
for i=0, #tCameraName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tCameraName[i])
	mywindow:setTexture("Normal", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Hover", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Pushed", "UIData/fightClub_009.tga", 493, 523)
	mywindow:setTexture("PushedOff", "UIData/invisible.tga", 514, 1002)
	mywindow:setTexture("SelectedNormal", "UIData/fightClub_009.tga", 493, 523)
	mywindow:setTexture("SelectedHover", "UIData/fightClub_009.tga", 493, 523)
	mywindow:setTexture("SelectedPushed", "UIData/fightClub_009.tga", 493, 523)
	mywindow:setTexture("SelectedPushedOff", "UIData/fightClub_009.tga", 493, 523)
	mywindow:setSize(36, 36)
	mywindow:setPosition(tCameraPosX[i], 20)
	mywindow:setProperty("GroupID", 1833)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("SelectStateChanged", tCameraEvent[i])
	winMgr:getWindow("sj_wndField_cameraMode"):addChildWindow(mywindow)
end

function SelectCameraModeFix()
	if CEGUI.toRadioButton(winMgr:getWindow("sj_wndField_cameraMode_fix")):isSelected() then
		SetCameraViewMode(0)
	end
end

function SelectCameraModeFree()
	if CEGUI.toRadioButton(winMgr:getWindow("sj_wndField_cameraMode_free")):isSelected() then
		SetCameraViewMode(1)
	end
end

function SetInitCameraMode(mode)
	for i=0, #tCameraName do
		winMgr:getWindow(tCameraName[i]):setProperty("Selected", "False")
	end
	winMgr:getWindow("sj_wndField_cameraMode_fix"):setProperty("Selected", "True")
end


function WndField_ShowClubUserInfoToObserver(bPushTab, leftGuildMark, rightGuildMark, leftGuildName, rightGuildName)
	if bPushTab == 1 then
		winMgr:getWindow("sj_ShowClubUserInfoImage_observer_Alpha"):setVisible(true)
		winMgr:getWindow("sj_wndField_cameraMode"):setVisible(true)
		winMgr:getWindow("sj_wndField_selectLine_observer"):setVisible(false)
		
		for i=0, MAX_PLAYER-1 do
			winMgr:getWindow("sj_wndField_ShowClubUserInfo_bg_observer_"..i):setEnabled(false)
			winMgr:getWindow("sj_wndField_ShowClubUserInfo_bg_observer_"..i):setVisible(true)
			
			winMgr:getWindow("sj_wndField_ShowClubUserInfo_level_observer_"..i):setVisible(false)
			winMgr:getWindow("sj_wndField_ShowClubUserInfo_name_observer_"..i):setVisible(false)
			winMgr:getWindow("sj_wndField_ShowClubUserInfo_hp1_observer_"..i):setVisible(false)
			winMgr:getWindow("sj_wndField_ShowClubUserInfo_hp2_observer_"..i):setVisible(false)
			winMgr:getWindow("sj_wndField_ShowClubUserInfo_reviveTime_observer_"..i):setVisible(false)
			winMgr:getWindow("sj_wndField_ShowClubUserInfo_kodown_observer_"..i):setVisible(false)
			winMgr:getWindow("sj_wndField_ShowClubUserInfo_item_observer_"..i):setVisible(false)
			winMgr:getWindow("sj_wndField_ShowClubUserInfo_button_observer_"..i):setVisible(false)
		end
	else
		winMgr:getWindow("sj_ShowClubUserInfoImage_observer_Alpha"):setVisible(false)
		winMgr:getWindow("sj_wndField_cameraMode"):setVisible(false)
		winMgr:getWindow("sj_wndField_selectLine_observer"):setVisible(false)
		
		for i=0, MAX_PLAYER-1 do
			winMgr:getWindow("sj_wndField_ShowClubUserInfo_bg_observer_"..i):setEnabled(false)
			winMgr:getWindow("sj_wndField_ShowClubUserInfo_bg_observer_"..i):setVisible(false)
			
			winMgr:getWindow("sj_wndField_ShowClubUserInfo_level_observer_"..i):setVisible(false)
			winMgr:getWindow("sj_wndField_ShowClubUserInfo_name_observer_"..i):setVisible(false)
			winMgr:getWindow("sj_wndField_ShowClubUserInfo_hp1_observer_"..i):setVisible(false)
			winMgr:getWindow("sj_wndField_ShowClubUserInfo_hp2_observer_"..i):setVisible(false)
			winMgr:getWindow("sj_wndField_ShowClubUserInfo_reviveTime_observer_"..i):setVisible(false)
			winMgr:getWindow("sj_wndField_ShowClubUserInfo_kodown_observer_"..i):setVisible(false)
			winMgr:getWindow("sj_wndField_ShowClubUserInfo_item_observer_"..i):setVisible(false)
			winMgr:getWindow("sj_wndField_ShowClubUserInfo_button_observer_"..i):setVisible(false)
		end
	end
	
	if leftGuildMark > 0 then
		winMgr:getWindow("sj_wndField_Emblem_observer_L"):setTexture('Enabled', GetClubDirectory(GetLanguageType())..leftGuildMark..".tga", 0, 0)
		winMgr:getWindow("sj_wndField_Emblem_observer_L"):setTexture('Disabled', GetClubDirectory(GetLanguageType())..leftGuildMark..".tga", 0, 0)
	end
	
	if rightGuildMark > 0 then
		winMgr:getWindow("sj_wndField_Emblem_observer_R"):setTexture('Enabled', GetClubDirectory(GetLanguageType())..rightGuildMark..".tga", 0, 0)
		winMgr:getWindow("sj_wndField_Emblem_observer_R"):setTexture('Disabled', GetClubDirectory(GetLanguageType())..rightGuildMark..".tga", 0, 0)
	end
	
	if leftGuildName ~= "" then
		winMgr:getWindow("sj_wndField_guildName_observer_L"):setText(leftGuildName)
	end
	
	if rightGuildName ~= "" then
		winMgr:getWindow("sj_wndField_guildName_observer_R"):setText(rightGuildName)
	end
end


function WndField_ClubUserInfo_ExistToObserver(count_, characterIndex, level, name, hp, maxHP, reviveTime, ko, down, itemType, bCurrentView)
	
	count = count_
	if characterIndex >= MAX_PLAYER_HALF then
		count = count_ + MAX_PLAYER_HALF
	end

	if count >= MAX_PLAYER then
		return
	end

	winMgr:getWindow("sj_wndField_ShowClubUserInfo_bg_observer_"..count):setEnabled(true)
	
	local levelText = "Lv. "..level
	winMgr:getWindow("sj_wndField_ShowClubUserInfo_level_observer_"..count):setVisible(true)
	winMgr:getWindow("sj_wndField_ShowClubUserInfo_level_observer_"..count):setText(levelText)

	local nameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, name)
	winMgr:getWindow("sj_wndField_ShowClubUserInfo_name_observer_"..count):setVisible(true)
	winMgr:getWindow("sj_wndField_ShowClubUserInfo_name_observer_"..count):setPosition(110-nameSize/2, 0)
	winMgr:getWindow("sj_wndField_ShowClubUserInfo_name_observer_"..count):setText(name)
	
	local HP_POSX = 180
	local HP_SIZE = 123
	local currHP = hp * HP_SIZE / maxHP
	winMgr:getWindow("sj_wndField_ShowClubUserInfo_hp1_observer_"..count):setVisible(true)
	winMgr:getWindow("sj_wndField_ShowClubUserInfo_hp2_observer_"..count):setVisible(true)
	winMgr:getWindow("sj_wndField_ShowClubUserInfo_hp2_observer_"..count):setPosition(HP_POSX, 1)
	winMgr:getWindow("sj_wndField_ShowClubUserInfo_hp2_observer_"..count):setSize(currHP, 18)
	
	if hp > 0 then
		winMgr:getWindow("sj_wndField_ShowClubUserInfo_reviveTime_observer_"..count):setVisible(false)
	else
		if reviveTime > 0 then
			winMgr:getWindow("sj_wndField_ShowClubUserInfo_reviveTime_observer_"..count):setVisible(true)
			winMgr:getWindow("sj_wndField_ShowClubUserInfo_reviveTime_observer_"..count):setText(reviveTime)
		end
	end

	local kodownText = ko.." / "..down
	local kodownSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, kodownText)
	winMgr:getWindow("sj_wndField_ShowClubUserInfo_kodown_observer_"..count):setVisible(true)
	winMgr:getWindow("sj_wndField_ShowClubUserInfo_kodown_observer_"..count):setPosition(328-kodownSize/2, 0)
	winMgr:getWindow("sj_wndField_ShowClubUserInfo_kodown_observer_"..count):setText(kodownText)
	
	if itemType >= 0 then
		winMgr:getWindow("sj_wndField_ShowClubUserInfo_item_observer_"..count):setVisible(true)
		winMgr:getWindow("sj_wndField_ShowClubUserInfo_item_observer_"..count):setScaleWidth(90)
		winMgr:getWindow("sj_wndField_ShowClubUserInfo_item_observer_"..count):setScaleHeight(90)
		winMgr:getWindow("sj_wndField_ShowClubUserInfo_item_observer_"..count):setTexture("Disabled", "UIData/fightClub_005.tga", tPropertyItemTexX[itemType], tPropertyItemTexY[itemType])
	end
	
	winMgr:getWindow("sj_wndField_ShowClubUserInfo_button_observer_"..count):setVisible(true)
	winMgr:getWindow("sj_wndField_ShowClubUserInfo_button_observer_"..count):setUserString("characterIndex", characterIndex)
	
	if bCurrentView == 1 then
		winMgr:getWindow("sj_wndField_selectLine_observer"):setVisible(true)
		winMgr:getWindow("sj_wndField_selectLine_observer"):setPosition(12+(475*(count/MAX_PLAYER_HALF)), 88+((count%MAX_PLAYER_HALF)*24))
	end
end


function OnClickedChangeCameraViewObserver(args)
	local local_window = CEGUI.toWindowEventArgs(args).window
	local characterNumber = local_window:getUserString("characterIndex")
	SetDrawCharacterIndexToObserver(characterNumber)
end



----------------------------------------------------

-- 점령전 결과창

----------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_wndField_leftWinStamp")
mywindow:setTexture("Enabled", "UIData/fightClub_005.tga", 0, 518)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setWideType(6)
mywindow:setPosition(12, 80)
mywindow:setSize(238, 70)
mywindow:setVisible(false)
mywindow:addController("winstamp_left", "winstamp_left", "xscale", "Quintic_EaseIn", 700, 255, 5, true, false, 10)
mywindow:addController("winstamp_left", "winstamp_left", "yscale", "Quintic_EaseIn", 700, 255, 5, true, false, 10)
mywindow:addController("winstamp_left", "winstamp_left", "xscale", "Elastic_EaseOut", 150, 255, 3, true, false, 10)
mywindow:addController("winstamp_left", "winstamp_left", "yscale", "Elastic_EaseOut", 150, 255, 3, true, false, 10)
mywindow:setAlign(8)
root:addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_wndField_rightWinStamp")
mywindow:setTexture("Enabled", "UIData/fightClub_005.tga", 0, 518)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setWideType(6)
mywindow:setPosition(788, 80)
mywindow:setSize(238, 70)
mywindow:setVisible(false)
mywindow:addController("winstamp_right", "winstamp_right", "xscale", "Quintic_EaseIn", 700, 255, 5, true, false, 10)
mywindow:addController("winstamp_right", "winstamp_right", "yscale", "Quintic_EaseIn", 700, 255, 5, true, false, 10)
mywindow:addController("winstamp_right", "winstamp_right", "xscale", "Elastic_EaseOut", 150, 255, 3, true, false, 10)
mywindow:addController("winstamp_right", "winstamp_right", "yscale", "Elastic_EaseOut", 150, 255, 3, true, false, 10)
mywindow:setAlign(8)
root:addChildWindow(mywindow)

local g_nextTime = false
local g_result1_time = 0
local g_imageAlpha = 0
local g_stampEffect = true
local g_result2_time = 0
function WndField_ShowResult_info1(deltaTime, winnerTeam, leftGuildName, rightGuildName, exitRemainTime, redEmblem, blueEmblem)

	g_result1_time = g_result1_time + deltaTime * 2	
	if g_result1_time >= 1020 then
		g_result1_time = 1020
		g_nextTime = true
	end
		
	g_imageAlpha = g_result1_time / 4
	if g_imageAlpha >= 230 then
		g_imageAlpha = 230
	end
	
	if g_nextTime and g_imageAlpha >= 255 then
		g_result2_time = g_result2_time + deltaTime
		if g_result2_time >= 1500 then
			g_result2_time = 1500
		end
	end
	
	drawer:drawTextureA("UIData/nm1.tga", 0, 0, 1024, 768, 0, 0, 230-g_imageAlpha, WIDETYPE_6)
	
	drawer:drawTextureA("UIData/OnDLGBackImage.tga", 0, 0, 1920, 1200, 0, 0, 0, WIDETYPE_6)
	drawer:drawTextureA("UIData/fightClub_005.tga", 251, 0, 522, 99, 497, 62, g_imageAlpha, WIDETYPE_6)	
	drawer:drawTextureA("UIData/fightClub_008.tga", 0, 100, 1024, 576, 0, 448, g_imageAlpha, WIDETYPE_6)
	
	local redTeamTextSize = GetStringSize(g_STRING_FONT_GULIMCHE, 20, leftGuildName, WIDETYPE_6)
	local blueTeamTextSize = GetStringSize(g_STRING_FONT_GULIMCHE, 20, rightGuildName, WIDETYPE_6)
	local _redTextPosX = 286-redTeamTextSize/2
	local _blueTextPosX = 774-blueTeamTextSize/2
	if g_nextTime then
		drawer:setFont(g_STRING_FONT_GULIMCHE, 20)
		drawer:setTextColor(254,87,87,g_imageAlpha)
		drawer:drawText(leftGuildName, _redTextPosX, 166, WIDETYPE_6)
		
		drawer:setTextColor(120,200,255,g_imageAlpha)
		drawer:drawText(rightGuildName, _blueTextPosX, 166, WIDETYPE_6)
	end

	local winnerText = ""
	if winnerTeam == 0 then
	
		if leftGuildName ~= "" then
			winnerText = leftGuildName.."  WIN !!"
		else
			winnerText = "RED WIN !!"
		end
		
		if g_nextTime and g_stampEffect then
			g_stampEffect = false
			PlaySound("sound/Dungeon/Dungeon_Result_Grade.wav")
			winMgr:getWindow("sj_wndField_leftWinStamp"):setTexture("Enabled", "UIData/fightClub_005.tga", 0, 518)
			winMgr:getWindow("sj_wndField_leftWinStamp"):setPosition(12, 80)
			winMgr:getWindow("sj_wndField_leftWinStamp"):setVisible(true)
			winMgr:getWindow("sj_wndField_leftWinStamp"):activeMotion("winstamp_left")
			
			winMgr:getWindow("sj_wndField_rightWinStamp"):setTexture("Enabled", "UIData/fightClub_005.tga", 0, 448)
			winMgr:getWindow("sj_wndField_rightWinStamp"):setPosition(760, 80)
			winMgr:getWindow("sj_wndField_rightWinStamp"):setVisible(true)
			winMgr:getWindow("sj_wndField_rightWinStamp"):activeMotion("winstamp_right")
		end
		
		local cupAlpha = g_result2_time/6
		if cupAlpha >= 200 then
			cupAlpha = 200
		end
	--	drawer:drawTextureA("UIData/fightClub_008.tga", 180, 320, 197, 170, 827, 255, cupAlpha)

	else
		if rightGuildName ~= "" then
			winnerText = rightGuildName.."  WIN !!"
		else
			winnerText = "BLUE WIN !!"
		end
		
		if g_nextTime and g_stampEffect then
			g_stampEffect = false
			PlaySound("sound/Dungeon/Dungeon_Result_Grade.wav")
			winMgr:getWindow("sj_wndField_leftWinStamp"):setTexture("Enabled", "UIData/fightClub_005.tga", 0, 448)
			winMgr:getWindow("sj_wndField_leftWinStamp"):setPosition(20, 80)
			winMgr:getWindow("sj_wndField_leftWinStamp"):setVisible(true)
			winMgr:getWindow("sj_wndField_leftWinStamp"):activeMotion("winstamp_left")
			
			winMgr:getWindow("sj_wndField_rightWinStamp"):setTexture("Enabled", "UIData/fightClub_005.tga", 0, 518)
			winMgr:getWindow("sj_wndField_rightWinStamp"):setPosition(788, 80)
			winMgr:getWindow("sj_wndField_rightWinStamp"):setVisible(true)
			winMgr:getWindow("sj_wndField_rightWinStamp"):activeMotion("winstamp_right")
		end
		
		local cupAlpha = g_result2_time/6
		if cupAlpha >= 200 then
			cupAlpha = 200
		end
	--	drawer:drawTextureA("UIData/fightClub_008.tga", 670, 320, 197, 170, 827, 255, cupAlpha)
	end
	
	if redEmblem > 0 then
		drawer:drawTexture(GetClubDirectory(GetLanguageType())..redEmblem..".tga", _redTextPosX-40, 160, 32, 32, 0, 0, WIDETYPE_6)
	end
	
	if blueEmblem > 0 then
		drawer:drawTexture(GetClubDirectory(GetLanguageType())..blueEmblem..".tga", _blueTextPosX-40, 160, 32, 32, 0, 0, WIDETYPE_6)
	end
	
	drawer:setFont(g_STRING_FONT_GULIMCHE, 24)
	drawer:setTextColor(250,200,80,g_imageAlpha)
	local size = GetStringSize(g_STRING_FONT_GULIMCHE, 24, winnerText)
	drawer:drawText(winnerText, 512-size/2, 36, WIDETYPE_6)
	
	-- 점령전 나가는 시간
	--DrawEachNumberA("UIData/numberUi001.tga", exitRemainTime, 8, 850, 650, 0, 0, 80, 100, 80, g_imageAlpha)	-- 카운트 다운	
	DrawEachNumberWide("UIData/numberUi001.tga", exitRemainTime, 8, 850, 650, 0, 0, 80, 100, 80, WIDETYPE_6)
end


local g_arr = 32
local tArrTime = {["err"]=0, }
local tArrShow = {["err"]=0, }
for i=0, g_arr-1 do
	tArrTime[i] = 0
	tArrShow[i] = false
end


local LEFT_TEAM_POSX = 104
local TEAM_POSY = 227
function WndField_ShowResult_info_red(bMy, i, deltaTime, level, name, kill, death, toweratk)
	if g_nextTime == false then
		return
	end
	
	--[[
	tArrTime[i] = tArrTime[i] + deltaTime
	if tArrTime[i] >= 500 then
		tArrTime[i] = 500
	else
		return
	end
	--]]
	
	local posX = LEFT_TEAM_POSX
	local posY = TEAM_POSY + (i*24)
	
	
	-- 레벨
	drawer:setTextColor(255,255,255,255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	drawer:drawText(level, posX-30, posY, WIDETYPE_6)
	
	-- 이름
	local size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, name)
	drawer:drawText(name, posX+97-size/2, posY, WIDETYPE_6)
	
	-- Kill
	size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, kill)
	drawer:drawText(kill, posX+208-size, posY, WIDETYPE_6)

	-- Death
	size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, death)
	drawer:drawText(death, posX+268-size, posY, WIDETYPE_6)
	
	-- Tower ATK
	size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, toweratk)
	drawer:drawText(toweratk, posX+366-size, posY, WIDETYPE_6)
	
	-- 마스터
	--[[
	if i == 0 or i == 20 then
		drawer:drawTexture("UIData/fightClub_005.tga", posX-55, posY, 444, 18, 0, 597)
	end
	--]]
	
	if bMy == 1 then
		drawer:drawTextureA("UIData/fightClub_008.tga", posX-78, posY-6, 488, 23, 536, 425, g_imageAlpha, WIDETYPE_6)
	end
end


local RIGHT_TEAM_POSX = 594
function WndField_ShowResult_info_blue(bMy, i, deltaTime, level, name, kill, death, toweratk)
	if g_nextTime == false then
		return
	end
	
	--[[
	tArrTime[i] = tArrTime[i] + deltaTime
	if tArrTime[i] >= 500 then
		tArrTime[i] = 500
	else
		return
	end
	--]]
	
	local posX = RIGHT_TEAM_POSX
	local j = i % (g_arr/2)
	local posY = TEAM_POSY + (j*24)
	
	-- 레벨
	drawer:setTextColor(255,255,255,255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	drawer:drawText(level, posX-30, posY, WIDETYPE_6)
	
	-- 이름
	local size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, name)
	drawer:drawText(name, posX+97-size/2, posY, WIDETYPE_6)
	
	-- Kill
	size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, kill)
	drawer:drawText(kill, posX+208-size, posY, WIDETYPE_6)

	-- Death
	size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, death)
	drawer:drawText(death, posX+268-size, posY, WIDETYPE_6)
	
	-- Tower ATK
	size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, toweratk)
	drawer:drawText(toweratk, posX+366-size, posY, WIDETYPE_6)
	
	-- 마스터
	--[[
	if i == 0 or i == 20 then
		drawer:drawTexture("UIData/fightClub_005.tga", posX-55, posY, 444, 18, 0, 597)
	end
	--]]
	
	if bMy == 1 then
		drawer:drawTextureA("UIData/fightClub_008.tga", posX-78, posY-6, 488, 23, 536, 425, g_imageAlpha, WIDETYPE_6)
	end
end



----------------------------------------------------

-- 5분동안 대기시간

----------------------------------------------------
function WndField_NotifyEnableFight(min, sec)
	drawer:drawTextureA("UIData/fightClub_007.tga", 0, 460, 1024, 109, 0, 492, 200, WIDETYPE_6)
	
	local _tenMin = min / 10
	local _tenSec = sec / 10
	local _oneSec = sec % 10
	DrawEachNumberWide("UIData/slot.tga", _tenMin, 8, 450, 506, 601, 769, 34 ,48, 34, WIDETYPE_6)
	DrawEachNumberWide("UIData/slot.tga", min, 8, 480, 506, 601, 769, 34 ,48, 34, WIDETYPE_6)
	drawer:drawTexture("UIData/slot.tga", 505, 506, 34, 48, 567, 769, WIDETYPE_6)
	DrawEachNumberWide("UIData/slot.tga", _tenSec, 8, 526, 506, 601, 769, 34 ,48, 34, WIDETYPE_6)
	DrawEachNumberWide("UIData/slot.tga", _oneSec, 8, 555, 506, 601, 769, 34 ,48, 34, WIDETYPE_6)
end




----------------------------------------------------

-- 난입 가능 버튼

----------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_questroom_enableEnterBtn")
mywindow:setTexture("Normal", "UIData/fightClub_007.tga", 284, 744)
mywindow:setTexture("Hover", "UIData/fightClub_007.tga", 284, 784)
mywindow:setTexture("Pushed", "UIData/fightClub_007.tga", 284, 824)
mywindow:setTexture("PushedOff", "UIData/fightClub_007.tga", 284, 744)
mywindow:setTexture("Disabled", "UIData/fightClub_007.tga", 284, 864)
mywindow:setPosition(3, 184)
mywindow:setSize(140, 40)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "WndField_ClickedEnableEnter")
root:addChildWindow(mywindow)

-- 현재 상태에 따라 여러가지 설정을 해준다.
function WndField_SetEnableFieldPlay(myState)
	
	-------------------------------------------
	-- 현재 점령전 상태에 따라 설정을 해준다.
	-------------------------------------------
	g_myFieldState = myState
	
	DebugStr("FieldState  :  " .. myState)
	
	-- 1. 관전상태일 경우
	if myState == STATE_OBSERVER then
		winMgr:getWindow("sj_questroom_enableEnterBtn"):setVisible(false)
		
		Chatting_SetChatTab(CHATTYPE_ALL, CHATTYPE_TEAM, CHATTYPE_GANG, CHATTYPE_OBSERVER)
		winMgr:getWindow("chat_tab_allChat"):setEnabled(false)
		winMgr:getWindow("chat_tab_team"):setEnabled(false)
		winMgr:getWindow("chat_tab_gang"):setEnabled(false)
		Chatting_SelectTab(CHATTYPE_OBSERVER)
		Chatting_SetChatPopup(CHATTYPE_ALL, CHATTYPE_PRIVATE)
	
	-- 2. 난입 가능한 상태일 경우
	elseif myState == STATE_ENABLE_PLAY then
		winMgr:getWindow("sj_questroom_enableEnterBtn"):setVisible(true)
		
		Chatting_SetChatTab(CHATTYPE_ALL, CHATTYPE_TEAM, CHATTYPE_GANG, CHATTYPE_OBSERVER)
		winMgr:getWindow("chat_tab_allChat"):setEnabled(false)
		winMgr:getWindow("chat_tab_team"):setEnabled(false)
		winMgr:getWindow("chat_tab_gang"):setEnabled(false)
		Chatting_SelectTab(CHATTYPE_OBSERVER)
		Chatting_SetChatPopup(CHATTYPE_ALL, CHATTYPE_PRIVATE)
	
	-- 3. 현재 게임중인 상태일 경우
	elseif myState == STATE_PLAYING then
		winMgr:getWindow("sj_questroom_enableEnterBtn"):setVisible(false)
		
		Chatting_SetChatTab(CHATTYPE_ALL, CHATTYPE_TEAM, CHATTYPE_GANG)
		Chatting_SetChatPopup(CHATTYPE_ALL, CHATTYPE_PRIVATE, CHATTYPE_TEAM, CHATTYPE_GANG)
	
	end
end

function WndField_SetVisibleEnableEnterBtn(bShow)
	--[[
	winMgr:getWindow("sj_questroom_enableEnterBtn"):setEnabled(bShow)
	winMgr:getWindow("sj_wndField_ShowClubUserInfoImage"):setEnabled(bShow)
	winMgr:getWindow("sj_wndField_ShowClubUserInfoImage_observer"):setEnabled(bShow)
	winMgr:getWindow("sj_wndField_cameraMode"):setEnabled(bShow)
	--]]
	
	winMgr:getWindow("sj_questroom_enableEnterBtn"):setVisible(bShow)
	winMgr:getWindow("sj_wndField_ShowClubUserInfoImage"):setVisible(bShow)
	winMgr:getWindow("sj_wndField_ShowClubUserInfoImage_observer"):setVisible(bShow)
	winMgr:getWindow("sj_wndField_cameraMode"):setVisible(bShow)
end

function WndField_ClickedEnableEnter(args)
	ClickedEnableEnter()
	winMgr:getWindow("doChatting"):activate()
end


----------------------------------------------------

-- 점령전 종료창

----------------------------------------------------
quitwindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_wndField_exitBackWindow")
quitwindow:setTexture("Enabled", "UIData/dungeonmsg.tga", 0, 509)
quitwindow:setTexture("Disabled", "UIData/dungeonmsg.tga", 0, 509)
quitwindow:setProperty("FrameEnabled", "False")
quitwindow:setProperty("BackgroundEnabled", "False")
quitwindow:setWideType(6);
quitwindow:setPosition(0, 300)
quitwindow:setSize(1024, 157)
quitwindow:setAlpha(0)
quitwindow:setZOrderingEnabled(true)
quitwindow:setVisible(false)
root:addChildWindow(quitwindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_wndField_exitDescWindow")
mywindow:setTexture("Enabled", "UIData/quest1.tga", 0, 160)
mywindow:setTexture("Disabled", "UIData/quest1.tga", 0, 160)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(273, 4)
mywindow:setSize(478, 95)
mywindow:setAlpha(0)
quitwindow:addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/Button", "sj_wndField_exitOkBtn")
mywindow:setTexture("Normal", "UIData/quest.tga", 644, 564)
mywindow:setTexture("Hover", "UIData/quest.tga", 439, 760)
mywindow:setTexture("Pushed", "UIData/quest.tga", 439, 825)
mywindow:setTexture("PushedOff", "UIData/quest.tga", 644, 564)
mywindow:setPosition(340, 90)
mywindow:setSize(153, 65)
mywindow:setAlpha(0)
mywindow:subscribeEvent("Clicked", "WndField_QuitOK")
quitwindow:addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/Button", "sj_wndField_exitCancelBtn")
mywindow:setTexture("Normal", "UIData/quest.tga", 842, 564)
mywindow:setTexture("Hover", "UIData/quest.tga", 439, 890)
mywindow:setTexture("Pushed", "UIData/quest.tga", 439, 955)
mywindow:setTexture("PushedOff", "UIData/quest.tga", 842, 564)
mywindow:setPosition(538, 90)
mywindow:setSize(153, 65)
mywindow:setAlpha(0)
mywindow:subscribeEvent("Clicked", "WndField_QuitCancel")
quitwindow:addChildWindow(mywindow)


-- 편법을 사용하여 알파로 나타났을 경우 버튼 이미지들이 나오고 기존 이미지는 그리지 않는다;;
local g_escapeAlpha = 0
function WndField_Escape(bFlag, deltaTime)
		
	if bFlag == 1 then
		quitwindow:setVisible(true)		
		g_escapeAlpha = g_escapeAlpha + deltaTime
		if g_escapeAlpha >= 255 then
			g_escapeAlpha = 255
			
		end
		
	else
		g_escapeAlpha = g_escapeAlpha - deltaTime
		if g_escapeAlpha <= 0 then
			g_escapeAlpha = 0
			quitwindow:setVisible(false)
		else
		end	
	end
	
	winMgr:getWindow("sj_wndField_exitBackWindow"):setAlpha(g_escapeAlpha)
	winMgr:getWindow("sj_wndField_exitDescWindow"):setAlpha(g_escapeAlpha)
	winMgr:getWindow("sj_wndField_exitOkBtn"):setAlpha(g_escapeAlpha)
	winMgr:getWindow("sj_wndField_exitCancelBtn"):setAlpha(g_escapeAlpha)
end
