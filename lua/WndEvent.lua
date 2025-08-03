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
function WndEvent_StartGhost(downIndex, x, y, attackName1, attackName2)
	Common_StartGhost(downIndex, x, y, attackName1, attackName2)
end



function WndEvent_EndGhost(downIndex)
	Common_EndGhost(downIndex)
end



function WndEvent_RenderGhost(slot, x, y, deltaTime)
	Common_RenderGhost(slot, x, y, deltaTime)
end




--------------------------------------------------------------------

-- 케릭터에 관한정보 그리기(HP, SP ...)

--------------------------------------------------------------------
function WndEvent_RenderCharacter
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
function WndEvent_RenderRank(slot, mybone, hp, sp, maxhp, maxsp, deltatime, RESPAWN_TIME, revivalTime, 
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
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_WndEvent_Effect_combo")
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

winMgr:getWindow("sj_WndEvent_Effect_combo"):addController("CommonAlertOkBoxCtrl0", "StampEffect", "xscale", "Quintic_EaseIn", 700, 255, 3, true, false, 10)
winMgr:getWindow("sj_WndEvent_Effect_combo"):addController("CommonAlertOkBoxCtrl0", "StampEffect", "yscale", "Quintic_EaseIn", 700, 255, 3, true, false, 10)
winMgr:getWindow("sj_WndEvent_Effect_combo"):addController("CommonAlertOkBoxCtrl0", "StampEffect", "xscale", "Elastic_EaseOut", 150, 255, 5, true, false, 10)
winMgr:getWindow("sj_WndEvent_Effect_combo"):addController("CommonAlertOkBoxCtrl0", "StampEffect", "yscale", "Elastic_EaseOut", 150, 255, 5, true, false, 10)
winMgr:getWindow("sj_WndEvent_Effect_combo"):setAlign(8)

local g_ComboEffectEnable = false
local g_ComboEffectAlpha = 255
local g_ComboEffectTime = 0
function WndEvent_ComboEffect(state)
	g_ComboEffectEnable = true
	g_ComboEffectAlpha = 255
	
	if state >= 3 then
		state = 3
	end
	winMgr:getWindow("sj_WndEvent_Effect_combo"):setTexture("Enabled", "UIData/GameNewImage2.tga", 646, tComboEffectTexY[state])
	winMgr:getWindow("sj_WndEvent_Effect_combo"):setVisible(true)
	winMgr:getWindow("sj_WndEvent_Effect_combo"):activeMotion("StampEffect")
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
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_WndEvent_Effect_ko"..i)
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

	winMgr:getWindow("sj_WndEvent_Effect_ko"..i):addController("CommonAlertOkBoxCtrl0", "StampEffect", "xscale", "Quintic_EaseIn", 700, 255, 3, true, false, 10)
	winMgr:getWindow("sj_WndEvent_Effect_ko"..i):addController("CommonAlertOkBoxCtrl0", "StampEffect", "yscale", "Quintic_EaseIn", 700, 255, 3, true, false, 10)
	winMgr:getWindow("sj_WndEvent_Effect_ko"..i):addController("CommonAlertOkBoxCtrl0", "StampEffect", "xscale", "Elastic_EaseOut", 150, 255, 5, true, false, 10)
	winMgr:getWindow("sj_WndEvent_Effect_ko"..i):addController("CommonAlertOkBoxCtrl0", "StampEffect", "yscale", "Elastic_EaseOut", 150, 255, 5, true, false, 10)
	winMgr:getWindow("sj_WndEvent_Effect_ko"..i):setAlign(8)
end

function WndEvent_KoEffect(koCount)
	if koCount <= 0 then
		return
	end
	
	-- 이전에 진행되는게 있다면 진행을 중지한다.
	for i=1, #g_KoEffectEnable do
		g_KoEffectEnable[i] = false
	end
	
	g_KoEffectEnable[koCount] = true
	g_KoEffectAlpha[koCount]  = 255
	
	winMgr:getWindow("sj_WndEvent_Effect_ko"..koCount):setTexture("Enabled", "UIData/GameNewImage2.tga", 0, g_KoEffectTexY[koCount])
	winMgr:getWindow("sj_WndEvent_Effect_ko"..koCount):setVisible(true)
	winMgr:getWindow("sj_WndEvent_Effect_ko"..koCount):activeMotion("StampEffect")
	
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
function WndEvent_RenderEffects(deltaTime)
	
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
				winMgr:getWindow("sj_WndEvent_Effect_combo"):setVisible(false)
			end
			winMgr:getWindow("sj_WndEvent_Effect_combo"):setAlpha(g_ComboEffectAlpha)
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
					
					if winMgr:getWindow("sj_WndEvent_Effect_ko"..i) then
						winMgr:getWindow("sj_WndEvent_Effect_ko"..i):setVisible(false)
					end
				end
				
				if winMgr:getWindow("sj_WndEvent_Effect_ko"..i) then
					winMgr:getWindow("sj_WndEvent_Effect_ko"..i):setAlpha(g_KoEffectAlpha[i])
				end
			end
		else
			g_KoEffectAlpha[i] = 0
			g_KoEffectTime[i]  = 0
			if winMgr:getWindow("sj_WndEvent_Effect_ko"..i) then
				winMgr:getWindow("sj_WndEvent_Effect_ko"..i):setVisible(false)
				winMgr:getWindow("sj_WndEvent_Effect_ko"..i):setAlpha(g_KoEffectAlpha[i])
			end
		end
	end
end





----------------------------------------------------------

-- 누가 누구를 죽였는지 확인

----------------------------------------------------------
function WndEvent_RenderKillAndDead(bTeam, killEnemyType, deadEnemyType, count, killName, deadName)
	
	local firstPosX = 800
	local firstPosY = 220+(count*30)
	local killPosX	= GetStringSize(g_STRING_FONT_GULIMCHE, 12, killName)
	local summaryDeadName = SummaryString(g_STRING_FONT_GULIMCHE, 12, deadName, 70)
	
	-- 가운데 주먹 이미지
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	drawer:drawTexture("UIData/GameNewImage.tga", firstPosX, firstPosY, 216, 38, 303, 79, WIDETYPE_1)

	-- 케릭터 이름
	if killEnemyType == 0 then
		common_DrawOutlineText1(drawer, killName, firstPosX+76-killPosX, firstPosY+12, 0,0,0,255, 199,199,199,255, WIDETYPE_1)
	else
		common_DrawOutlineText1(drawer, killName, firstPosX+76-killPosX, firstPosY+12, 0,0,0,255, 199,199,199,255, WIDETYPE_1)
	end
	
	if deadEnemyType == 0 then
		common_DrawOutlineText1(drawer, summaryDeadName, firstPosX+138, firstPosY+12, 0,0,0,255, 199,199,199,255, WIDETYPE_1)
	else
		common_DrawOutlineText1(drawer, summaryDeadName, firstPosX+138, firstPosY+12, 0,0,0,255, 199,199,199,255, WIDETYPE_1)
	end
end







----------------------------------------------------------

-- ready 그리기

----------------------------------------------------------
local g_readySound = true
local tReadyDelta = { ["err"]=0, -410 }
local tFightDelta = { ["err"]=0, 0, 255 }
function WndEvent_RenderBattleReady(deltaTime)
	
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
function WndEvent_RenderBattleFight(deltaTime)
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

function WndEvent_ComboAndDamage(deltaTime, isCombo, currentCombo, isAccumulate, accumDamage, 
							teamAttackCount, doubleAttackCount, isTeamAttack, isDoubleAttack, currentAttackCount)

	Common_ScrambleComboAndDamage(deltaTime, isCombo, currentCombo, isAccumulate, accumDamage, 
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
function WndEvent_RenderItem(itemType, myHP, myDiedTime, reviveTick, myFieldState)

	-- 클럽원 현황
	if myFieldState == STATE_PLAYING then
		--drawer:drawTexture("UIData/fightClub_010.tga", 3, 130, 118, 29, 277, 444)
		drawer:drawTexture("UIData/fightClub_010.tga", 33, 130, 72, 24, 518, 324)	
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
		DebugStr('GetSStringInfo를 실행하고 있습니다'..tItemDescEnum[itemType])
		drawer:drawText(szItemDesc, 146, 64)
	end
end



-- 임시
function WndEvent_TempStart()
	
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
function WndEvent_OnDrawBoolean(str_chat, px, py, chatBubbleType)
	
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

function WndEvent_InitLast1MinData()
	g_last1MinEffect= 0
	g_last1MinTime	= 0
	g_last1Min		= true
	g_last1MinPos	= 0
	g_last1MinSound	= true
end

function WndEvent_RenderLast1Min(deltaTime)

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
		WndEventEndLast1Min()
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

function WndEvent_InitLast10SecData()
	g_last10Effect	= 0
	g_last10SecTime	= 0
	g_last10Sec		= true
	g_last10SecPos	= 0
	g_last10SecSound= true
end

function WndEvent_RenderLast10Sec(deltaTime)

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
		WndEventEndLast10Sec()
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



local last10secEffectTime = 0
local g_redEffect = false
local g_blueEffect = false
local redEffectGauge = 0
local blueEffectGauge = 0
local g_redHP = GetCastleMaxHP()
local g_blueHP = GetCastleMaxHP()
local tHPTexY = {["err"]=0, [0]=182, 151, 120, 89, 58}
function WndEvent_RenderInfos(deltaTime, min, sec, realRedHP, realBlueHP, leftEmblem, RightEmblem, leftGuildName, rightGuildName, maxTowerHP)

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
	--drawer:drawTexture("UIData/fightClub_008.tga", CASTLE_POSX, 2, 513, 56, 0, 0, WIDETYPE_5)
	drawer:drawTexture("UIData/GameNewImage.tga", 495, 4, 34, 15, 738, 66, WIDETYPE_5)
	
	-- 분
	local ten = (min/10)
	local one = (min%10)
	drawer:drawTexture("UIData/GameNewImage.tga", CASTLE_POSX+200, 17, 20, 26, 77+(ten*20), 704, WIDETYPE_5)
	drawer:drawTexture("UIData/GameNewImage.tga", CASTLE_POSX+217, 17, 20, 26, 77+(one*20), 704, WIDETYPE_5)

	-- :
	drawer:drawTexture("UIData/GameNewImage.tga", CASTLE_POSX+233, 17, 20, 26, 277, 704, WIDETYPE_5)
	
	-- 초
	ten = (sec/10)
	one = (sec%10)
	drawer:drawTexture("UIData/GameNewImage.tga", CASTLE_POSX+247, 17, 20, 26, 77+(ten*20), 704, WIDETYPE_5)
	drawer:drawTexture("UIData/GameNewImage.tga", CASTLE_POSX+265, 17, 20, 26, 77+(one*20), 704, WIDETYPE_5)
	
end





----------------------------------------------------

-- 웨폰 주울수 있는지 알려주기

----------------------------------------------------
function WndEvent_NotifyPickupWeapon(weaponIndex, weaponPosX, weaponPosY)
	drawer:drawTexture("UIData/GameNewImage.tga", weaponPosX-40, weaponPosY-130, 84, 62, 474, 883)
end



function WndEvent_ShowEmblemKey(LeftEmblem, RightEmblem)
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

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_WndEvent_invisibleMinimap")
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

function WndEvent_RenderMinimap(mapName)
	if mapName == "scn_field_8vs8" then
		drawer:drawTextureA("UIData/fightClub_006.tga", MINIMAP_POSX, MINIMAP_POSY, 187, 118, 333, 195, 200, WIDETYPE_1)
	elseif mapName == "scn_field_test" then
		drawer:drawTextureA("UIData/fightClub_005.tga", MINIMAP_POSX, MINIMAP_POSY, 187, 118, 308, 0, 200, WIDETYPE_1)		
	elseif mapName == "scn_field_china" then
		drawer:drawTextureA("UIData/fightClub_006.tga", MINIMAP_POSX, MINIMAP_POSY, 187, 118, 650, 379, 200, WIDETYPE_1)
	end
end

function WndEvent_RenderCharacterPosToMap(characterIndex, bMy, myTeam, bMyTeam, x, y, angle, hp, bPlaying)
	
	if bPlaying == 1 then
		if bMyTeam == 0 then
			return
		end
	end
	
	local posX =  x+80
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
function WndEvent_DrawWatchingCharacter(team, characterName)
	
	drawer:drawTexture("UIData/fightClub_005.tga", 257, 160, 514, 41, 0, 220, WIDETYPE_5)
	
	drawer:setFont(g_STRING_FONT_GULIMCHE, 16)
	if team == 0 then
		drawer:setTextColor(199,199,199,255)
	else
		drawer:setTextColor(199,199,199,255)
	end
	
	local szName = string.format(WATCHING_WHO, characterName)
	local size = GetStringSize(g_STRING_FONT_GULIMCHE, 16, szName)
	drawer:drawText(szName, 512-size/2, 173, WIDETYPE_5)
end


local effectEnableEnterTime = 0
function WndEvent_DrawNotifyEnableEnter(deltaTime)
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
function WndEvent_RenderHelp(bHelp)

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
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_WndEvent_ShowClubUserInfoImage")
mywindow:setTexture("Enabled", "UIData/fightClub_009.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/fightClub_009.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(275, 142)
mywindow:setSize(474, 483)
mywindow:setZOrderingEnabled(false)
mywindow:setVisible(false)
root:addChildWindow(mywindow)

-- 현재 누구를 선택했는지 보여주는 라인
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_WndEvent_selectLine")
mywindow:setTexture("Enabled", "UIData/fightClub_008.tga", 536, 425)
mywindow:setTexture("Disabled", "UIData/fightClub_008.tga", 536, 425)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(12, 32)
mywindow:setSize(488, 23)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("sj_WndEvent_ShowClubUserInfoImage"):addChildWindow(mywindow)

local MAX_PLAYER_HALF = GetMaxGuildwarUser() / 2
for i=0, MAX_PLAYER_HALF-1 do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_WndEvent_ShowClubUserInfo_bg_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(12, 90+(i*24))
	mywindow:setSize(450, 20)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	winMgr:getWindow("sj_WndEvent_ShowClubUserInfoImage"):addChildWindow(mywindow)
	
	-- 레벨
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_WndEvent_ShowClubUserInfo_level_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(4, 0)
	mywindow:setSize(100, 20)
	mywindow:setZOrderingEnabled(false)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setTextColor(255, 255, 255, 255)
	winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_bg_"..i):addChildWindow(mywindow)
	
	-- 이름
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_WndEvent_ShowClubUserInfo_name_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(50, 0)
	mywindow:setSize(100, 20)
	mywindow:setZOrderingEnabled(false)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setTextColor(255, 255, 255, 255)
	winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_bg_"..i):addChildWindow(mywindow)
	
	-- hp 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_WndEvent_ShowClubUserInfo_hp1_"..i)
	mywindow:setTexture("Enabled", "UIData/fightClub_009.tga", 0, 523)
	mywindow:setTexture("Disabled", "UIData/fightClub_009.tga", 0, 523)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(180, 1)
	mywindow:setSize(123, 18)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_bg_"..i):addChildWindow(mywindow)
	
	-- hp 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_WndEvent_ShowClubUserInfo_hp2_"..i)
	mywindow:setTexture("Enabled", "UIData/fightClub_009.tga", 0, 541)
	mywindow:setTexture("Disabled", "UIData/fightClub_009.tga", 0, 541)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(180, 1)
	mywindow:setSize(123, 18)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_bg_"..i):addChildWindow(mywindow)
	
	-- 부활시간 텍스트
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_WndEvent_ShowClubUserInfo_reviveTime_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(236, 0)
	mywindow:setSize(100, 20)
	mywindow:setZOrderingEnabled(false)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setTextColor(255, 255, 255, 255)
	winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_bg_"..i):addChildWindow(mywindow)
	
	-- ko
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_WndEvent_ShowClubUserInfo_kodown_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(300, 0)
	mywindow:setSize(20, 20)
	mywindow:setZOrderingEnabled(false)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setTextColor(255, 255, 255, 255)
	winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_bg_"..i):addChildWindow(mywindow)
	
	-- 아이템 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_WndEvent_ShowClubUserInfo_item_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(360, 0)
	mywindow:setSize(54, 56)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_bg_"..i):addChildWindow(mywindow)
	
	-- 카메라 시점 버튼
	mywindow = winMgr:createWindow("TaharezLook/Button", "sj_WndEvent_ShowClubUserInfo_button_"..i)
	mywindow:setTexture("Normal", "UIData/fightClub_009.tga", 219, 523)
	mywindow:setTexture("Hover", "UIData/fightClub_009.tga", 219, 543)
	mywindow:setTexture("Pushed", "UIData/fightClub_009.tga", 219, 563)
	mywindow:setTexture("PushedOff", "UIData/fightClub_009.tga", 219, 523)
	mywindow:setPosition(410, 0)
	mywindow:setSize(20, 20)
	mywindow:setUserString("characterIndex", 0)
	mywindow:setSubscribeEvent("MouseButtonUp", "OnClickedChangeCameraView")
	winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_bg_"..i):addChildWindow(mywindow)
	
end

-- 클럽 마크 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_WndEvent_Emblem")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 819, 1010)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 819, 1010)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(15, 32)
mywindow:setSize(32, 32)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("sj_WndEvent_ShowClubUserInfoImage"):addChildWindow(mywindow)

-- 클럽 이름
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_WndEvent_guildName")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setPosition(60, 35)
mywindow:setSize(100, 20)
mywindow:setZOrderingEnabled(false)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 16)
mywindow:setTextColor(255, 255, 255, 255)
winMgr:getWindow("sj_WndEvent_ShowClubUserInfoImage"):addChildWindow(mywindow)

function WndEvent_ShowClubUserInfo(bPushTab, emblemKey, guildName, team)
	if bPushTab == 1 then
		
		winMgr:getWindow("sj_WndEvent_ShowClubUserInfoImage"):setVisible(true)
		winMgr:getWindow("sj_WndEvent_selectLine"):setVisible(false)
		if team == 0 then			
			winMgr:getWindow("sj_WndEvent_ShowClubUserInfoImage"):setTexture("Enabled", "UIData/fightClub_009.tga", 0, 0)
			winMgr:getWindow("sj_WndEvent_ShowClubUserInfoImage"):setTexture("Disabled", "UIData/fightClub_009.tga", 0, 0)
		else
			winMgr:getWindow("sj_WndEvent_ShowClubUserInfoImage"):setTexture("Enabled", "UIData/fightClub_009.tga", 474, 0)
			winMgr:getWindow("sj_WndEvent_ShowClubUserInfoImage"):setTexture("Disabled", "UIData/fightClub_009.tga", 474, 0)
		end
		
		for i=0, MAX_PLAYER_HALF-1 do
			winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_bg_"..i):setEnabled(false)
			winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_bg_"..i):setVisible(true)
			
			winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_level_"..i):setVisible(false)
			winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_name_"..i):setVisible(false)
			winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_hp1_"..i):setVisible(false)
			winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_hp2_"..i):setVisible(false)
			winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_reviveTime_"..i):setVisible(false)
			winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_kodown_"..i):setVisible(false)
			winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_item_"..i):setVisible(false)
			winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_button_"..i):setVisible(false)
		end
	else
		winMgr:getWindow("sj_WndEvent_ShowClubUserInfoImage"):setVisible(false)
		winMgr:getWindow("sj_WndEvent_selectLine"):setVisible(false)
		
		for i=0, MAX_PLAYER_HALF-1 do
			winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_bg_"..i):setEnabled(false)
			winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_bg_"..i):setVisible(false)
			
			winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_level_"..i):setVisible(false)
			winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_name_"..i):setVisible(false)
			winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_hp1_"..i):setVisible(false)
			winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_hp2_"..i):setVisible(false)
			winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_reviveTime_"..i):setVisible(false)
			winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_kodown_"..i):setVisible(false)
			winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_item_"..i):setVisible(false)
			winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_button_"..i):setVisible(false)
		end
	end
	
	if emblemKey > 0 then
		winMgr:getWindow("sj_WndEvent_Emblem"):setTexture('Enabled', GetClubDirectory(GetLanguageType())..emblemKey..".tga", 0, 0)
		winMgr:getWindow("sj_WndEvent_Emblem"):setTexture('Disabled', GetClubDirectory(GetLanguageType())..emblemKey..".tga", 0, 0)
	end
	
	if guildName ~= "" then
		winMgr:getWindow("sj_WndEvent_guildName"):setText(guildName)
	end
end


REVIVE_AFTER_SECONDS = PreCreateString_2432	--GetSStringInfo(LAN_GANGWAR_NOTIFY_1)		-- %02d 초 뒤 부활
function WndEvent_ClubUserInfo_Exist(count, characterIndex, level, name, hp, maxHP, reviveTime, ko, down, itemType, bEnableView, bCurrentView)
	if count >= MAX_PLAYER_HALF then
		return
	end
	
	winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_bg_"..count):setEnabled(true)
	
	local levelText = "Lv. "..level
	winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_level_"..count):setVisible(true)	
	winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_level_"..count):setText(levelText)

	local nameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, name)
	winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_name_"..count):setVisible(true)
	winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_name_"..count):setPosition(110-nameSize/2, 0)
	winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_name_"..count):setText(name)
	
	local HP_POSX = 180
	local HP_SIZE = 123
	local currHP = hp * HP_SIZE / maxHP
	winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_hp1_"..count):setVisible(true)
	winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_hp2_"..count):setVisible(true)
	winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_hp2_"..count):setPosition(HP_POSX, 1)
	winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_hp2_"..count):setSize(currHP, 18)
	
	if hp > 0 then
		winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_reviveTime_"..count):setVisible(false)
	else
		if reviveTime > 0 then
			winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_reviveTime_"..count):setVisible(true)
			winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_reviveTime_"..count):setText(reviveTime)
		end
	end

	local kodownText = ko
	local kodownSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, kodownText)
	winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_kodown_"..count):setVisible(true)
	winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_kodown_"..count):setPosition(328-kodownSize/2, 0)
	winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_kodown_"..count):setText(kodownText)
	
	if itemType >= 0 then
		winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_item_"..count):setVisible(true)
		winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_item_"..count):setScaleWidth(90)
		winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_item_"..count):setScaleHeight(90)
		winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_item_"..count):setTexture("Disabled", "UIData/fightClub_005.tga", tPropertyItemTexX[itemType], tPropertyItemTexY[itemType])
	end
	
	-- 현재 내가 다운되서 다른유저 카메라로 넘어갈 수 있을때만
	if bEnableView == 1 then
		winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_button_"..count):setVisible(true)
		winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_button_"..count):setUserString("characterIndex", characterIndex)
	else
		winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_button_"..count):setVisible(false)
	end
	
	if bCurrentView == 1 then
		winMgr:getWindow("sj_WndEvent_selectLine"):setVisible(true)
		winMgr:getWindow("sj_WndEvent_selectLine"):setPosition(12, 88+(count*24))
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
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_WndEvent_ShowClubUserInfoImage_observer")
mywindow:setTexture("Enabled", "UIData/fightClub_009.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/fightClub_009.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(38, 190)
mywindow:setSize(948, 483)
mywindow:setZOrderingEnabled(false)
mywindow:setVisible(false)
root:addChildWindow(mywindow)

-- 현재 누구를 선택했는지 보여주는 라인
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_WndEvent_selectLine_observer")
mywindow:setTexture("Enabled", "UIData/fightClub_008.tga", 536, 425)
mywindow:setTexture("Disabled", "UIData/fightClub_008.tga", 536, 425)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(12, 32)
mywindow:setSize(488, 23)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("sj_WndEvent_ShowClubUserInfoImage_observer"):addChildWindow(mywindow)

local MAX_PLAYER = GetMaxGuildwarUser()
for i=0, MAX_PLAYER-1 do
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_WndEvent_ShowClubUserInfo_bg_observer_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(12+(475*(i/MAX_PLAYER_HALF)), 90+((i%MAX_PLAYER_HALF)*24))
	mywindow:setSize(450, 20)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	winMgr:getWindow("sj_WndEvent_ShowClubUserInfoImage_observer"):addChildWindow(mywindow)
	
	-- 레벨
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_WndEvent_ShowClubUserInfo_level_observer_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(4, 0)
	mywindow:setSize(100, 20)
	mywindow:setZOrderingEnabled(false)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setTextColor(255, 255, 255, 255)
	winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_bg_observer_"..i):addChildWindow(mywindow)
	
	-- 이름
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_WndEvent_ShowClubUserInfo_name_observer_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(50, 0)
	mywindow:setSize(100, 20)
	mywindow:setZOrderingEnabled(false)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setTextColor(255, 255, 255, 255)
	winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_bg_observer_"..i):addChildWindow(mywindow)
	
	-- hp 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_WndEvent_ShowClubUserInfo_hp1_observer_"..i)
	mywindow:setTexture("Enabled", "UIData/fightClub_009.tga", 0, 523)
	mywindow:setTexture("Disabled", "UIData/fightClub_009.tga", 0, 523)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(180, 1)
	mywindow:setSize(123, 18)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_bg_observer_"..i):addChildWindow(mywindow)
	
	-- hp 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_WndEvent_ShowClubUserInfo_hp2_observer_"..i)
	mywindow:setTexture("Enabled", "UIData/fightClub_009.tga", 0, 541)
	mywindow:setTexture("Disabled", "UIData/fightClub_009.tga", 0, 541)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(180, 1)
	mywindow:setSize(123, 18)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_bg_observer_"..i):addChildWindow(mywindow)
	
	-- 부활시간 텍스트
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_WndEvent_ShowClubUserInfo_reviveTime_observer_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(236, 0)
	mywindow:setSize(100, 20)
	mywindow:setZOrderingEnabled(false)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setTextColor(255, 255, 255, 255)
	winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_bg_observer_"..i):addChildWindow(mywindow)
	
	-- ko
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_WndEvent_ShowClubUserInfo_kodown_observer_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(300, 0)
	mywindow:setSize(20, 20)
	mywindow:setZOrderingEnabled(false)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setTextColor(255, 255, 255, 255)
	winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_bg_observer_"..i):addChildWindow(mywindow)
	
	-- 아이템 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_WndEvent_ShowClubUserInfo_item_observer_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(360, 0)
	mywindow:setSize(54, 56)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_bg_observer_"..i):addChildWindow(mywindow)
	
	-- 카메라 시점 버튼
	mywindow = winMgr:createWindow("TaharezLook/Button", "sj_WndEvent_ShowClubUserInfo_button_observer_"..i)
	mywindow:setTexture("Normal", "UIData/fightClub_009.tga", 219, 523)
	mywindow:setTexture("Hover", "UIData/fightClub_009.tga", 219, 543)
	mywindow:setTexture("Pushed", "UIData/fightClub_009.tga", 219, 563)
	mywindow:setTexture("PushedOff", "UIData/fightClub_009.tga", 219, 523)
	mywindow:setPosition(410, 0)
	mywindow:setSize(20, 20)
	mywindow:setUserString("characterIndex", 0)
	mywindow:setSubscribeEvent("MouseButtonUp", "OnClickedChangeCameraViewObserver")
	winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_bg_observer_"..i):addChildWindow(mywindow)
end

-- 클럽 마크 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_WndEvent_Emblem_observer_L")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 819, 1010)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 819, 1010)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(12, 32)
mywindow:setSize(32, 32)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("sj_WndEvent_ShowClubUserInfoImage_observer"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_WndEvent_Emblem_observer_R")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 819, 1010)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 819, 1010)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(487, 32)
mywindow:setSize(32, 32)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("sj_WndEvent_ShowClubUserInfoImage_observer"):addChildWindow(mywindow)

-- 클럽 이름
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_WndEvent_guildName_observer_L")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setPosition(54, 35)
mywindow:setSize(100, 20)
mywindow:setZOrderingEnabled(false)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 16)
mywindow:setTextColor(255, 255, 255, 255)
winMgr:getWindow("sj_WndEvent_ShowClubUserInfoImage_observer"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_WndEvent_guildName_observer_R")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setPosition(529, 35)
mywindow:setSize(100, 20)
mywindow:setZOrderingEnabled(false)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 16)
mywindow:setTextColor(255, 255, 255, 255)
winMgr:getWindow("sj_WndEvent_ShowClubUserInfoImage_observer"):addChildWindow(mywindow)

-- 카메라 모드 변경
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_WndEvent_cameraMode")
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
local tCameraName  = {["err"]=0, [0]="sj_WndEvent_cameraMode_fix", "sj_WndEvent_cameraMode_free"}
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
	winMgr:getWindow("sj_WndEvent_cameraMode"):addChildWindow(mywindow)
end

function SelectCameraModeFix()
	if CEGUI.toRadioButton(winMgr:getWindow("sj_WndEvent_cameraMode_fix")):isSelected() then
		SetCameraViewMode(0)
	end
end

function SelectCameraModeFree()
	if CEGUI.toRadioButton(winMgr:getWindow("sj_WndEvent_cameraMode_free")):isSelected() then
		SetCameraViewMode(1)
	end
end

function SetInitCameraMode(mode)
	for i=0, #tCameraName do
		winMgr:getWindow(tCameraName[i]):setProperty("Selected", "False")
	end
	winMgr:getWindow("sj_WndEvent_cameraMode_fix"):setProperty("Selected", "True")
end


function WndEvent_ShowClubUserInfoToObserver(bPushTab, leftGuildMark, rightGuildMark, leftGuildName, rightGuildName)
	if bPushTab == 1 then
		winMgr:getWindow("sj_WndEvent_ShowClubUserInfoImage_observer"):setVisible(true)
		winMgr:getWindow("sj_WndEvent_cameraMode"):setVisible(true)
		winMgr:getWindow("sj_WndEvent_selectLine_observer"):setVisible(false)
		
		for i=0, MAX_PLAYER-1 do
			winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_bg_observer_"..i):setEnabled(false)
			winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_bg_observer_"..i):setVisible(true)
			
			winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_level_observer_"..i):setVisible(false)
			winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_name_observer_"..i):setVisible(false)
			winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_hp1_observer_"..i):setVisible(false)
			winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_hp2_observer_"..i):setVisible(false)
			winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_reviveTime_observer_"..i):setVisible(false)
			winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_kodown_observer_"..i):setVisible(false)
			winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_item_observer_"..i):setVisible(false)
			winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_button_observer_"..i):setVisible(false)
		end
	else
		winMgr:getWindow("sj_WndEvent_ShowClubUserInfoImage_observer"):setVisible(false)
		winMgr:getWindow("sj_WndEvent_cameraMode"):setVisible(false)
		winMgr:getWindow("sj_WndEvent_selectLine_observer"):setVisible(false)
		
		for i=0, MAX_PLAYER-1 do
			winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_bg_observer_"..i):setEnabled(false)
			winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_bg_observer_"..i):setVisible(false)
			
			winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_level_observer_"..i):setVisible(false)
			winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_name_observer_"..i):setVisible(false)
			winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_hp1_observer_"..i):setVisible(false)
			winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_hp2_observer_"..i):setVisible(false)
			winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_reviveTime_observer_"..i):setVisible(false)
			winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_kodown_observer_"..i):setVisible(false)
			winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_item_observer_"..i):setVisible(false)
			winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_button_observer_"..i):setVisible(false)
		end
	end
	
	if leftGuildMark > 0 then
		winMgr:getWindow("sj_WndEvent_Emblem_observer_L"):setTexture('Enabled', GetClubDirectory(GetLanguageType())..leftGuildMark..".tga", 0, 0)
		winMgr:getWindow("sj_WndEvent_Emblem_observer_L"):setTexture('Disabled', GetClubDirectory(GetLanguageType())..leftGuildMark..".tga", 0, 0)
	end
	
	if rightGuildMark > 0 then
		winMgr:getWindow("sj_WndEvent_Emblem_observer_R"):setTexture('Enabled', GetClubDirectory(GetLanguageType())..rightGuildMark..".tga", 0, 0)
		winMgr:getWindow("sj_WndEvent_Emblem_observer_R"):setTexture('Disabled', GetClubDirectory(GetLanguageType())..rightGuildMark..".tga", 0, 0)
	end
	
	if leftGuildName ~= "" then
		winMgr:getWindow("sj_WndEvent_guildName_observer_L"):setText(leftGuildName)
	end
	
	if rightGuildName ~= "" then
		winMgr:getWindow("sj_WndEvent_guildName_observer_R"):setText(rightGuildName)
	end
end


function WndEvent_ClubUserInfo_ExistToObserver(count_, characterIndex, level, name, hp, maxHP, reviveTime, ko, down, itemType, bCurrentView)
	
	count = count_
	--[[
	if characterIndex >= MAX_PLAYER_HALF then
		count = count_ + MAX_PLAYER_HALF
	end
	--]]

	if count >= MAX_PLAYER then
		return
	end

	winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_bg_observer_"..count):setEnabled(true)
	
	local levelText = "Lv. "..level
	winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_level_observer_"..count):setVisible(true)
	winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_level_observer_"..count):setText(levelText)

	local nameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, name)
	winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_name_observer_"..count):setVisible(true)
	winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_name_observer_"..count):setPosition(110-nameSize/2, 0)
	winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_name_observer_"..count):setText(name)
	
	local HP_POSX = 180
	local HP_SIZE = 123
	local currHP = hp * HP_SIZE / maxHP
	winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_hp1_observer_"..count):setVisible(true)
	winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_hp2_observer_"..count):setVisible(true)
	winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_hp2_observer_"..count):setPosition(HP_POSX, 1)
	winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_hp2_observer_"..count):setSize(currHP, 18)
	
	if hp > 0 then
		winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_reviveTime_observer_"..count):setVisible(false)
	else
		if reviveTime > 0 then
			winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_reviveTime_observer_"..count):setVisible(true)
			winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_reviveTime_observer_"..count):setText(reviveTime)
		end
	end

	local kodownText = ko
	local kodownSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, kodownText)
	winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_kodown_observer_"..count):setVisible(true)
	winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_kodown_observer_"..count):setPosition(328-kodownSize/2, 0)
	winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_kodown_observer_"..count):setText(kodownText)
	
	if itemType >= 0 then
		winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_item_observer_"..count):setVisible(true)
		winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_item_observer_"..count):setScaleWidth(90)
		winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_item_observer_"..count):setScaleHeight(90)
		winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_item_observer_"..count):setTexture("Disabled", "UIData/fightClub_005.tga", tPropertyItemTexX[itemType], tPropertyItemTexY[itemType])
	end
	
	winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_button_observer_"..count):setVisible(true)
	winMgr:getWindow("sj_WndEvent_ShowClubUserInfo_button_observer_"..count):setUserString("characterIndex", characterIndex)
	
	if bCurrentView == 1 then
		winMgr:getWindow("sj_WndEvent_selectLine_observer"):setVisible(true)
		winMgr:getWindow("sj_WndEvent_selectLine_observer"):setPosition(12+(475*(count/MAX_PLAYER_HALF)), 88+((count%MAX_PLAYER_HALF)*24))
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
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_WndEvent_leftWinStamp")
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

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_WndEvent_rightWinStamp")
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
function WndEvent_ShowResult_info1(deltaTime, winnerTeam, leftGuildName, rightGuildName, exitRemainTime, redEmblem, blueEmblem)
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
function WndEvent_ShowResult_info_red(bMy, i, deltaTime, level, name, awardExp, awardZen)
	if g_nextTime == false then
		return
	end
	
	--[[
	tArrTime[i] = tArrTime[i] + deltaTime
	if tArrTime[i] >= 500 then
		tArrTime[i] = 500
		return
	end
	--]]
	
	local posX = LEFT_TEAM_POSX
	local posY = TEAM_POSY + (i*24)
	
	
	-- 레벨
	drawer:setTextColor(255,255,255,255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	drawer:drawText(level, posX, posY, WIDETYPE_6)
	
	-- 이름
	local size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, name)
	drawer:drawText(name, posX+97-size/2, posY, WIDETYPE_6)
	
	-- 보상 경험치
	size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(awardExp))
	drawer:drawText(awardExp, posX+248-size, posY, WIDETYPE_6)
	
	-- 보상 젠
	size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(awardZen))
	drawer:drawText(awardZen, posX+356-size, posY, WIDETYPE_6)
	
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
function WndEvent_ShowResult_info_blue(bMy, i, deltaTime, level, name, awardExp, awardZen)
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
	drawer:drawText(level, posX, posY, WIDETYPE_6)
	
	-- 이름
	local size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, name)
	drawer:drawText(name, posX+97-size/2, posY, WIDETYPE_6)
	
	-- 보상 경험치
	size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(awardExp))
	drawer:drawText(awardExp, posX+248-size, posY, WIDETYPE_6)
	
	-- 보상 젠
	size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(awardZen))
	drawer:drawText(awardZen, posX+356-size, posY, WIDETYPE_6)
	
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
function WndEvent_NotifyEnableFight(min, sec)
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
mywindow:setTexture("Disabled", "UIData/fightClub_007.tga", 284, 904)
mywindow:setPosition(3, 184)
mywindow:setSize(140, 40)
mywindow:setVisible(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "WndEvent_ShowEnterScrambleMessageBox")
root:addChildWindow(mywindow)

function WndEvent_UpdateEnterBTState(isEnable)
	winMgr:getWindow("sj_questroom_enableEnterBtn"):setVisible(true)
	winMgr:getWindow("sj_questroom_enableEnterBtn"):setEnabled(isEnable)
end

function WndEvent_ShowEnterScrambleMessageBox()
	local EntryFee = string.format(PreCreateString_5409, GetScrambleEntryfee());
	DebugStr(EntryFee)
	winMgr:getWindow("ScrambleCheck_PopupText"):clearTextExtends()
	winMgr:getWindow("ScrambleCheck_PopupText"):addTextExtends(EntryFee, g_STRING_FONT_DODUMCHE, 115,255,255,255,255,    2, 0,0,0,255);	
	winMgr:getWindow("ScrambleCheck_PopupAlpha"):setVisible(true)
end

-- 현재 상태에 따라 여러가지 설정을 해준다.
function WndEvent_SetEnableFieldPlay(myState)
	
	-------------------------------------------
	-- 현재 점령전 상태에 따라 설정을 해준다.
	-------------------------------------------
	g_myFieldState = myState
	
	DebugStr("FieldState  :  " .. myState)
	
	-- 1. 관전상태일 경우
	if myState == STATE_OBSERVER then
		winMgr:getWindow("sj_questroom_enableEnterBtn"):setVisible(true)
		winMgr:getWindow("sj_questroom_enableEnterBtn"):setEnabled(false)
		
		Chatting_SetChatTab(CHATTYPE_ALL, CHATTYPE_TEAM, CHATTYPE_GANG, CHATTYPE_OBSERVER)
		winMgr:getWindow("chat_tab_allChat"):setEnabled(false)
		winMgr:getWindow("chat_tab_team"):setEnabled(false)
		winMgr:getWindow("chat_tab_gang"):setEnabled(false)
		Chatting_SelectTab(CHATTYPE_OBSERVER)
		Chatting_SetChatPopup(CHATTYPE_ALL, CHATTYPE_PRIVATE)
	
	-- 2. 난입 가능한 상태일 경우
	elseif myState == STATE_ENABLE_PLAY then
		winMgr:getWindow("sj_questroom_enableEnterBtn"):setVisible(true)
		winMgr:getWindow("sj_questroom_enableEnterBtn"):setEnabled(true)
		
		Chatting_SetChatTab(CHATTYPE_ALL, CHATTYPE_TEAM, CHATTYPE_GANG, CHATTYPE_OBSERVER)
		winMgr:getWindow("chat_tab_allChat"):setEnabled(false)
		winMgr:getWindow("chat_tab_team"):setEnabled(false)
		winMgr:getWindow("chat_tab_gang"):setEnabled(false)
		Chatting_SelectTab(CHATTYPE_OBSERVER)
		Chatting_SetChatPopup(CHATTYPE_ALL, CHATTYPE_PRIVATE)
	
	-- 3. 현재 게임중인 상태일 경우
	elseif myState == STATE_PLAYING then
		winMgr:getWindow("sj_questroom_enableEnterBtn"):setVisible(false)
		winMgr:getWindow("sj_questroom_enableEnterBtn"):setEnabled(false)
		
		Chatting_SetChatTab(CHATTYPE_ALL, CHATTYPE_TEAM, CHATTYPE_GANG)
		Chatting_SetChatPopup(CHATTYPE_ALL, CHATTYPE_PRIVATE, CHATTYPE_TEAM, CHATTYPE_GANG)
	
	end
end

function WndEvent_SetVisibleEnableEnterBtn(bShow)

	winMgr:getWindow("sj_questroom_enableEnterBtn"):setVisible(bShow)
	winMgr:getWindow("sj_WndEvent_ShowClubUserInfoImage"):setVisible(bShow)
	winMgr:getWindow("sj_WndEvent_ShowClubUserInfoImage_observer"):setVisible(bShow)
	winMgr:getWindow("sj_WndEvent_cameraMode"):setVisible(bShow)
end

function WndEvent_ClickedEnableEnter(args)
	ClickedEnableEnter()
	winMgr:getWindow("doChatting"):activate()
end


----------------------------------------------------

-- 점령전 종료창

----------------------------------------------------
quitwindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_WndEvent_exitBackWindow")
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

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_WndEvent_exitDescWindow")
mywindow:setTexture("Enabled", "UIData/fightClub_010.tga", 0, 618)
mywindow:setTexture("Disabled", "UIData/fightClub_010.tga", 0, 618)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(340, 4)
mywindow:setSize(364, 75)
mywindow:setAlpha(0)
quitwindow:addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/Button", "sj_WndEvent_exitOkBtn")
mywindow:setTexture("Normal", "UIData/quest.tga", 644, 564)
mywindow:setTexture("Hover", "UIData/quest.tga", 439, 760)
mywindow:setTexture("Pushed", "UIData/quest.tga", 439, 825)
mywindow:setTexture("PushedOff", "UIData/quest.tga", 644, 564)
mywindow:setPosition(340, 90)
mywindow:setSize(153, 65)
mywindow:setAlpha(0)
mywindow:subscribeEvent("Clicked", "WndEvent_QuitOK")
quitwindow:addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/Button", "sj_WndEvent_exitCancelBtn")
mywindow:setTexture("Normal", "UIData/quest.tga", 842, 564)
mywindow:setTexture("Hover", "UIData/quest.tga", 439, 890)
mywindow:setTexture("Pushed", "UIData/quest.tga", 439, 955)
mywindow:setTexture("PushedOff", "UIData/quest.tga", 842, 564)
mywindow:setPosition(538, 90)
mywindow:setSize(153, 65)
mywindow:setAlpha(0)
mywindow:subscribeEvent("Clicked", "WndEvent_QuitCancel")
quitwindow:addChildWindow(mywindow)


-- 편법을 사용하여 알파로 나타났을 경우 버튼 이미지들이 나오고 기존 이미지는 그리지 않는다;;
local g_escapeAlpha = 0
function WndEvent_Escape(bFlag, deltaTime)
		
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
	
	winMgr:getWindow("sj_WndEvent_exitBackWindow"):setAlpha(g_escapeAlpha)
	winMgr:getWindow("sj_WndEvent_exitDescWindow"):setAlpha(g_escapeAlpha)
	winMgr:getWindow("sj_WndEvent_exitOkBtn"):setAlpha(g_escapeAlpha)
	winMgr:getWindow("sj_WndEvent_exitCancelBtn"):setAlpha(g_escapeAlpha)
end

-------------------------------------------------------------------------
--랭크
-------------------------------------------------------------------------
local tRankOffsetX	= { ["err"]=0, 805, 805, 805, 805, 805, 805, 805, 805 }
local tRankOffsetY	= { ["err"]=0, 26, 26, 26, 26, 26, 26, 26, 26 }

-- 현재 나의 랭크로 사이즈를 정한다.
function WndEvent_BeforeRenderRank(myRank)
	-- 초기화
	for i=1, 8 do
		tRankOffsetX[i] = 805--42
		tRankOffsetY[i] = 20
	end
	
	-- 8위는 다음랭크가 없으므로 조심스럽게 x좌표만 ^^
	if myRank ~= 8 then
		tRankOffsetX[myRank]	= 767--4
		tRankOffsetY[myRank+1]	= 26
	else
		tRankOffsetX[myRank]	= 767--4
	end
end

-- 현재 랭크의 간격을 더해서 y위치의 좌표를 리턴한다.
function GetCurrentRankPosY(rank)
	local rankPos = 99---14--120
	for i=1, rank do
		rankPos = rankPos + tRankOffsetY[i]
	end
	return rankPos
end

---MY INFO----------------------------------------------------------
local TESTPOSX =0
local TESTPOSY =0

function SetMyRankTen(Rank)
	if Rank == 0 then
		return
	end
	drawer:drawTexture("UIData/GameSlotItem.tga", 840 + TESTPOSX, 20 + TESTPOSY, 41, 63, 0 + 41 * Rank, 900, WIDETYPE_1)
end

function SetMyRankOne(Rank)
	drawer:drawTexture("UIData/GameSlotItem.tga", 881 + TESTPOSX, 20 + TESTPOSY, 41, 63, 0 + 41 * Rank, 900, WIDETYPE_1)
	drawer:drawTexture("UIData/fightClub_010.tga", 925 + TESTPOSX, 40 + TESTPOSY, 32, 43, 992, 46, WIDETYPE_1)
end



function SetCurUserCntTen(UserCnt)
	if UserCnt == 0 then
		return
	end
	drawer:drawTexture("UIData/fightClub_010.tga", 952 + TESTPOSX, 47 + TESTPOSY, 31, 37, 518 + UserCnt * 31, 87, WIDETYPE_1)
end


function SetCurUserCntOne(UserCnt)
	drawer:drawTexture("UIData/fightClub_010.tga", 975 + TESTPOSX, 47 + TESTPOSY, 31, 37, 518 + UserCnt * 31, 87, WIDETYPE_1)
end

function WndEvent_DrawRankBack()
	drawer:drawTexture("UIData/fightClub_010.tga", 760 + TESTPOSX, 70 + TESTPOSY, 276, 134, 640, 124, WIDETYPE_1)
end

local spacingPosX = 20
function WndEvent_DrawRank(slot, myslot, 
									rank, CurrentZen, disconnected, 
									network, characterName)
	--DebugStr("----------WndEvent_DrawRank : " .. rank)
	drawer:setTextColor(255, 255, 255, 255)
	drawer:setFont("Arial", 22)

-----------------------------------------------
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	local userRankPosY = GetCurrentRankPosY(rank)
	-- 순위
	drawer:setTextColor(255,255,0,255)
	local summaryName = SummaryString(g_STRING_FONT_GULIMCHE, 12, characterName, 90)
	local strSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, summaryName)
	local PosX = 880-(strSize/2)-spacingPosX;
	local PosY = userRankPosY+8;
	drawer:drawText(summaryName,PosX ,PosY,WIDETYPE_1)
	
	local Test = CommatoMoneyStr64(CurrentZen)
	local r,g,b = GetGranColor(ZenCount)	
	local ZenStrsize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(Test))
	--DebugStr("Test : " .. Test .. " R : " .. r .. " G : " .. g .. " B : " .. b)		
	
	drawer:setTextColor(r,g,b,255)
	local ZenCount = Test;
	local ZenPosX = 920 -spacingPosX +75 - ZenStrsize;
	drawer:drawText(ZenCount, ZenPosX,PosY,WIDETYPE_1)
end

function WndEvent_DrawMYINFO(slot, myslot, 
									rank, CurrentZen, MaxUserCnt, 
									network, characterName)
	SetMyRankTen(rank / 10)
	SetMyRankOne(rank % 10)

	SetCurUserCntTen(MaxUserCnt / 10)
	SetCurUserCntOne(MaxUserCnt % 10)
	
	drawer:setTextColor(255, 255, 255, 255)
	drawer:setFont("Arial", 22)
-----------------------------------------------
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	-- 순위
	if slot == myslot then
		drawer:setTextColor(255,0,0,255)
		local ZenCount = CommatoMoneyStr64(CurrentZen);
		local ZenStrsize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(ZenCount))
		local ZenPosX = 920 - spacingPosX +70 - ZenStrsize;

		drawer:drawText(ZenCount, ZenPosX,90,WIDETYPE_1)
	end
end

--------------------------------------------------------------------------------------
---------------------ScrambleMap
--------------------------------------------------------------------------------------
function ShowDownscaleScrambleMap()
          if winMgr:getWindow("DownscaleScrambleMapBG"):isVisible(true) then
                  winMgr:getWindow("DownscaleScrambleMapBG"):setVisible(false);
         else
                   root:addChildWindow(winMgr:getWindow("DownscaleScrambleMapBG"));
                   winMgr:getWindow("DownscaleScrambleMapBG"):setVisible(true);
          end     
end

--------------------------------------------------------------------
-- 맵 닫는다.
--------------------------------------------------------------------
function CloseDownscaleScrambleMap (args)
    winMgr:getWindow("DownscaleScrambleMapBG"):setVisible(false);
end

--------------------------------------------------------------------
-- 쟁탈전맵 뒷판
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "DownscaleScrambleMapBG")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setWideType(6);
mywindow:setPosition((g_MAIN_WIN_SIZEX - 781) / 2, (g_MAIN_WIN_SIZEY - 632) / 2)
mywindow:setSize(733, 625)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

RegistEscEventInfo("DownscaleScrambleMapBG", "CloseDownscaleScrambleMap")
--------------------------------------------------------------------
-- 쟁탈전맵 메인 이미지
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ScrambleMap")
mywindow:setTexture("Enabled", "UIData/mini_map4.tga", 50, 50)
mywindow:setTexture("Disabled", "UIData/mini_map4.tga", 50, 50)
mywindow:setPosition(26, 68)
mywindow:setSize(681, 532)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("DownscaleScrambleMapBG"):addChildWindow(mywindow)

--------------------------------------------------------------------
-- 쟁탈전에 위치를 표시하기
--------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'MinePositionMarker');
mywindow:setTexture('Enabled', 'UIData/mini_map4.tga',  960, 0);
mywindow:setTexture('Disabled', 'UIData/mini_map4.tga',  960, 0);
mywindow:setPosition(0, 0);
mywindow:setSize(32, 32);
mywindow:setAlign(8)
mywindow:setAngle(0)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)

winMgr:getWindow("DownscaleScrambleMapBG"):addChildWindow(mywindow)

function OnEnterCharacter(Index, Name)
	if winMgr:getWindow("OtherPositionMarker"..Index) then
		--DebugStr("OnEnterCharacter---------winMgrgetWindow(OtherPositionMarker)setVisible(true)" .. Index)
		winMgr:getWindow("OtherPositionMarker"..Index):setVisible(true)
		return	
	else
		mywindow = winMgr:createWindow('TaharezLook/StaticImage', "OtherPositionMarker"..Index);
		mywindow:setTexture('Enabled', 'UIData/mini_map4.tga', 992, 0);
		mywindow:setTexture('Disabled', 'UIData/mini_map4.tga', 992, 0);
		mywindow:setPosition(0, 0);
		mywindow:setSize(32, 32);
		mywindow:setVisible(true)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:setUserString("Name", Name)
		mywindow:setUserString("Key", Index)
		mywindow:setSubscribeEvent('MouseEnter', 'MouseEnterCharactertoMap');
		mywindow:setSubscribeEvent('MouseLeave', 'MouseLeaveCharactertoMap');
		winMgr:getWindow("DownscaleScrambleMapBG"):addChildWindow(mywindow)
	end	
end

function OnExitCharacter(Index, MyIndex)
	if Index == MyIndex then
		winMgr:getWindow("MinePositionMarker"):setVisible(false)
		--DebugStr("OnExitCharacter---------winMgrgetWindow(MinePositionMarker)setVisible(false)" .. Index)
		if winMgr:getWindow("OtherPositionMarker"..MyIndex) then
			--DebugStr("OtherPositionMarkerMyIndex----------winMgrgetWindow(OtherPositionMarker)setVisible(false)" .. MyIndex)
			winMgr:getWindow("OtherPositionMarker"..MyIndex):setVisible(false)
		end
		return
	end

	if winMgr:getWindow("OtherPositionMarker"..Index) then
		--DebugStr("OnExitCharacter----------winMgrgetWindow(OtherPositionMarker)setVisible(false)" .. Index)
		winMgr:getWindow("OtherPositionMarker"..Index):setVisible(false)
	end
	
end

tMyWindowAngle	= {['protecterr'] = 0, }
tMyWindowAngle[0]		= 0
tMyWindowAngle[250]		= 64
tMyWindowAngle[500]		= 127
tMyWindowAngle[750]		= 191
tMyWindowAngle[1000]	= 255
tMyWindowAngle[1250]	= 319
tMyWindowAngle[1500]	= 382
tMyWindowAngle[1750]	= 447

local CharacterPosX = 336
local CharacterPosY = 317

function OnVisibleScrambleMap(CharacterIndex, MyIndex, px, py, angle, scale, CurZen)
	if CharacterIndex == MyIndex then
		if winMgr:getWindow("MinePositionMarker") then
			--DebugStr("OnVisibleScrambleMap---------winMgrgetWindow(MinePositionMarker)setVisible(true)".. CharacterIndex )
			if CurZen <= 0 then
				winMgr:getWindow("MinePositionMarker"):setVisible(false)
				return;
			end
			winMgr:getWindow("MinePositionMarker"):setVisible(true)
			winMgr:getWindow("MinePositionMarker"):setScaleHeight(scale)
			winMgr:getWindow("MinePositionMarker"):setScaleWidth(scale)	
			winMgr:getWindow("MinePositionMarker"):setPosition(px + CharacterPosX + 5, -py + CharacterPosY);
		end
		return;
	end
	if winMgr:getWindow("OtherPositionMarker"..CharacterIndex) then
		winMgr:getWindow("OtherPositionMarker"..CharacterIndex):setTexture('Enabled', 'UIData/mini_map4.tga', 992, 0);
		winMgr:getWindow("OtherPositionMarker"..CharacterIndex):setTexture('Disabled', 'UIData/mini_map4.tga', 992, 0);
		winMgr:getWindow("OtherPositionMarker"..CharacterIndex):setScaleHeight(scale)		-- 축소해놓는다.
		winMgr:getWindow("OtherPositionMarker"..CharacterIndex):setScaleWidth(scale)		-- 축소해놓는다.
		winMgr:getWindow("OtherPositionMarker"..CharacterIndex):setPosition(px + CharacterPosX + 5, -py + CharacterPosY + 5)
	end
end


function CreateEnterScrambleCheckMessageBox ()
	--------------------------------------------------------------------
	-- BuyScrambleAttend Confirm 알파.
	--------------------------------------------------------------------
	mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'ScrambleCheck_PopupAlpha');
	mywindow:setTexture('Enabled', 'UIData/OnDLGBackImage.tga', 0, 0);
	mywindow:setTexture('Disabled', 'UIData/OnDLGBackImage.tga', 0, 0);
	mywindow:setPosition(0,0);
	mywindow:setSize(1920, 1200)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	root:addChildWindow(mywindow);

	RegistEscEventInfo("ScrambleCheck_PopupAlpha", "ScrambleCheckPopupEscEvent")
	RegistEnterEventInfo("ScrambleCheck_PopupAlpha", "ScrambleCheckPopupEnterEvent")

	--------------------------------------------------------------------
	-- BuyScrambleAttend Confirm 뒷판.
	--------------------------------------------------------------------
	mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'ScrambleCheck_PopupImage');
	mywindow:setTexture('Enabled', 'UIData/popup001.tga', 0, 0);
	mywindow:setTexture('Disabled', 'UIData/popup001.tga', 0, 0);
	mywindow:setWideType(6)
	mywindow:setPosition((g_MAIN_WIN_SIZEX - 340) / 2, (g_MAIN_WIN_SIZEY - 268) / 2);
	mywindow:setSize(340, 268);
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow('ScrambleCheck_PopupAlpha'):addChildWindow(mywindow);

	--------------------------------------------------------------------
	-- BuyScrambleAttend Confirm 텍스트
	--------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "ScrambleCheck_PopupText");
	mywindow:setPosition(3, 45);
	mywindow:setSize(340, 180);
	mywindow:setAlign(7);
	mywindow:setLineSpacing(2);
	mywindow:setViewTextMode(1);
	mywindow:setEnabled(false)
	mywindow:clearTextExtends();
	local String = GetSStringInfo(LAN_SCRAMBLE_NOTIFY_3)
	mywindow:addTextExtends(String, g_STRING_FONT_DODUMCHE, 115,255,255,255,255,    2, 0,0,0,255);	
	winMgr:getWindow('ScrambleCheck_PopupImage'):addChildWindow(mywindow);
			

	--------------------------------------------------------------------
	-- BuyScrambleAttend Confirm 버튼 (확인, 취소)
	--------------------------------------------------------------------
	local ButtonName	= {['protecterr']=0, "ScrambleCheck_PopupOKButton", "ScrambleCheck_PopupCancelButton"}
	local ButtonTexX	= {['protecterr']=0,			693,					858}
	local ButtonPosX	= {['protecterr']=0,			4,						169}		
	local ButtonEvent	= {['protecterr']=0, "ScrambleCheckPopupEnterEvent", "ScrambleCheckPopupEscEvent"}

	for i=1, #ButtonName do
		mywindow = winMgr:createWindow("TaharezLook/Button", ButtonName[i])
		mywindow:setTexture("Normal", "UIData/popup001.tga", ButtonTexX[i], 849)
		mywindow:setTexture("Hover", "UIData/popup001.tga", ButtonTexX[i], 878)
		mywindow:setTexture("Pushed", "UIData/popup001.tga", ButtonTexX[i], 907)
		mywindow:setTexture("Disabled", "UIData/popup001.tga", ButtonTexX[i], 849)
		mywindow:setPosition(ButtonPosX[i], 235)
		mywindow:setSize(166, 29)
		mywindow:setVisible(true)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(true)
		mywindow:setUserString("index", 0)
		mywindow:subscribeEvent("Clicked", ButtonEvent[i])
		winMgr:getWindow('ScrambleCheck_PopupImage'):addChildWindow(mywindow)
	end


	-- 입장 여부의 cancel 이벤트
	function ScrambleCheckPopupEscEvent()
		winMgr:getWindow("ScrambleCheck_PopupAlpha"):setVisible(false)
	end



	-- 입장 여부의 enter 이벤트
	function ScrambleCheckPopupEnterEvent()
		winMgr:getWindow("ScrambleCheck_PopupAlpha"):setVisible(false)
		WndEvent_ClickedEnableEnter();
	end
end

CreateEnterScrambleCheckMessageBox();



