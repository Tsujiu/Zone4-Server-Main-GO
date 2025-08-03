-----------------------------------------
-- Script Entry Point
-----------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)
root:activate()


g_GAME_WIN_SIZEX, g_GAME_WIN_SIZEY = GetCurrentResolution()



-- 채팅창  초기  설정
function SetChatInitGame()
	Chatting_SetChatWideType(2)
	Chatting_SetChatPosition(3, 527)
	Chatting_SetChatEditEvent(3)
	Chatting_SetChatTabDefault()
	Chatting_SetUsePartyAsTeam(true)
end


root:setSubscribeEvent("MouseButtonUp", "OnRootMouseButtonUp")
function OnRootMouseButtonUp(args)
	root:removeChildWindow(winMgr:getWindow('pu_btnContainer'))
end
--------------------------------------------------------------------

-- 흡혈장갑일 경우 +HP 표시하기(MAX_COMBO : 32개)

--------------------------------------------------------------------
local tGainHPPosX		= { ["e"]=0, [0]={["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,} }
local tGainHPPosY		= { ["e"]=0, [0]={["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,} }
local tGainHPDamage		= { ["e"]=0, [0]={["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,} }
local tGainHPTime		= { ["e"]=0, [0]={["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,} }
local tDecreaseAlphaHP	= { ["e"]=0, [0]={["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,} }

function WndGame_StartEffectGainHP(characterIndex, comboIndex, x, y, damage)
	if characterIndex < 0 and characterIndex >= #tGainHPPosX then
		return
	end
	tGainHPPosX[characterIndex][comboIndex]			= x
	tGainHPPosY[characterIndex][comboIndex]			= y
	tGainHPDamage[characterIndex][comboIndex]		= damage
	tGainHPTime[characterIndex][comboIndex]			= 0
	tDecreaseAlphaHP[characterIndex][comboIndex]	= 255
end


function WndGame_EndEffectGainHP(characterIndex, comboIndex)
	if characterIndex < 0 and characterIndex >= #tGainHPPosX then
		return
	end
	tGainHPPosX[characterIndex][comboIndex]			= 0
	tGainHPPosY[characterIndex][comboIndex]			= 0
	tGainHPDamage[characterIndex][comboIndex]		= 0
	tGainHPTime[characterIndex][comboIndex]			= 0
	tDecreaseAlphaHP[characterIndex][comboIndex]	= 0	
end


function WndGame_RenderEffectGainHP(characterIndex, comboIndex, deltaTime)
	if characterIndex < 0 and characterIndex >= #tGainHPPosX then
		return
	end
	
	if tGainHPTime[characterIndex][comboIndex] == nil then
		return
	end
	
	if tDecreaseAlphaHP[characterIndex][comboIndex] <= 0 then
		return
	end
	
	tGainHPTime[characterIndex][comboIndex] = tGainHPTime[characterIndex][comboIndex] + deltaTime
	local gainTime = tGainHPTime[characterIndex][comboIndex] / 15
	
	if tDecreaseAlphaHP[characterIndex][comboIndex] > 0 then
		tDecreaseAlphaHP[characterIndex][comboIndex] = tDecreaseAlphaHP[characterIndex][comboIndex] - 3
	else
		tDecreaseAlphaHP[characterIndex][comboIndex] = 0
	end
		
	local x = tGainHPPosX[characterIndex][comboIndex] - 8
	local y = tGainHPPosY[characterIndex][comboIndex] - gainTime
	local damage = tGainHPDamage[characterIndex][comboIndex]
	local alpha  = tDecreaseAlphaHP[characterIndex][comboIndex]
		
	local _left, _right = DrawEachNumberA("UIData/GameNewImage.tga", damage, 8, x, y, 721, 693, 19, 25, 19, alpha)
	drawer:drawTextureA("UIData/GameNewImage.tga", _left-19, y+3, 16, 17, 699, 697, alpha)
end





--------------------------------------------------------------------

-- 데미지반사일 경우 -HP 표시하기(데미지를 가할때마다 -데미지를 보여줌)

--------------------------------------------------------------------
local tReflectDamagePosX	= { ["e"]=0, [0]={["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,} }
local tReflectDamagePosY	= { ["e"]=0, [0]={["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,} }
local tReflectDamageHp		= { ["e"]=0, [0]={["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,} }
local tReflectDamageTime	= { ["e"]=0, [0]={["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,} }
local tReflectDamageAlpha	= { ["e"]=0, [0]={["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,} }

function WndGame_StartEffectReflectDamage(characterIndex, comboIndex, x, y, damage)
	if characterIndex < 0 and characterIndex >= #tReflectDamagePosX then
		return
	end
	tReflectDamagePosX[characterIndex][comboIndex]	= x
	tReflectDamagePosY[characterIndex][comboIndex]	= y
	tReflectDamageHp[characterIndex][comboIndex]	= damage
	tReflectDamageTime[characterIndex][comboIndex]	= 0
	tReflectDamageAlpha[characterIndex][comboIndex]	= 255
end


function WndGame_EndEffectReflectDamage(characterIndex, comboIndex)
	if characterIndex < 0 and characterIndex >= #tReflectDamagePosX then
		return
	end
	tReflectDamagePosX[characterIndex][comboIndex]	= 0
	tReflectDamagePosY[characterIndex][comboIndex]	= 0
	tReflectDamageHp[characterIndex][comboIndex]	= 0
	tReflectDamageTime[characterIndex][comboIndex]	= 0
	tReflectDamageAlpha[characterIndex][comboIndex]	= 0
end


function WndGame_RenderEffectReflectDamage(characterIndex, comboIndex, deltaTime)
	if characterIndex < 0 and characterIndex >= #tReflectDamagePosX then
		return
	end
	
	if tReflectDamageTime[characterIndex][comboIndex] == nil then
		return
	end
	
	if tReflectDamageAlpha[characterIndex][comboIndex] <= 0 then
		return
	end
	
	tReflectDamageTime[characterIndex][comboIndex] = tReflectDamageTime[characterIndex][comboIndex] + deltaTime
	local gainTime = tReflectDamageTime[characterIndex][comboIndex] / 15
	
	if tReflectDamageAlpha[characterIndex][comboIndex] > 0 then
		tReflectDamageAlpha[characterIndex][comboIndex] = tReflectDamageAlpha[characterIndex][comboIndex] - 3
	else
		tReflectDamageAlpha[characterIndex][comboIndex] = 0
	end
		
	local x = tReflectDamagePosX[characterIndex][comboIndex] - 8
	local y = tReflectDamagePosY[characterIndex][comboIndex] - gainTime
	local damage = tReflectDamageHp[characterIndex][comboIndex]
	local alpha  = tReflectDamageAlpha[characterIndex][comboIndex]
	
	local _left, _right = DrawEachNumberA("UIData/GameNewImage.tga", damage, 8, x, y, 32, 837, 19, 25, 19, alpha)
	drawer:drawTextureA("UIData/GameNewImage.tga", _left-19, y+2, 17, 17, 10, 841, alpha)
end





--------------------------------------------------------------------

-- SP장갑일 경우 +SP 표시하기(MAX_COMBO : 32개)

--------------------------------------------------------------------
local tGainSPPosX		= { ["e"]=0, [0]={["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,} }
local tGainSPPosY		= { ["e"]=0, [0]={["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,} }
local tGainSPDamage		= { ["e"]=0, [0]={["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,} }
local tGainSPTime		= { ["e"]=0, [0]={["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,} }
local tDecreaseAlphaSP	= { ["e"]=0, [0]={["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,} }

function WndGame_StartEffectGainSP(characterIndex, comboIndex, x, y, damage)
	if characterIndex < 0 and characterIndex >= #tGainSPPosX then
		return
	end
	tGainSPPosX[characterIndex][comboIndex]			= x
	tGainSPPosY[characterIndex][comboIndex]			= y
	tGainSPDamage[characterIndex][comboIndex]		= damage
	tGainSPTime[characterIndex][comboIndex]			= 0
	tDecreaseAlphaSP[characterIndex][comboIndex]	= 255
end


function WndGame_EndEffectGainSP(characterIndex, comboIndex)
	if characterIndex < 0 and characterIndex >= #tGainSPPosX then
		return
	end
	tGainSPPosX[characterIndex][comboIndex]			= 0
	tGainSPPosY[characterIndex][comboIndex]			= 0
	tGainSPDamage[characterIndex][comboIndex]		= 0
	tGainSPTime[characterIndex][comboIndex]			= 0
	tDecreaseAlphaSP[characterIndex][comboIndex]	= 0	
end


function WndGame_RenderEffectGainSP(characterIndex, comboIndex, deltaTime)
	if characterIndex < 0 and characterIndex >= #tGainSPPosX then
		return
	end
	
	if tGainSPTime[characterIndex][comboIndex] == nil then
		return
	end
	
	if tDecreaseAlphaSP[characterIndex][comboIndex] <= 0 then
		return
	end
	
	tGainSPTime[characterIndex][comboIndex] = tGainSPTime[characterIndex][comboIndex] + deltaTime
	local gainTime = tGainSPTime[characterIndex][comboIndex] / 15
	
	if tDecreaseAlphaSP[characterIndex][comboIndex] > 0 then
		tDecreaseAlphaSP[characterIndex][comboIndex] = tDecreaseAlphaSP[characterIndex][comboIndex] - 3
	else
		tDecreaseAlphaSP[characterIndex][comboIndex] = 0
	end
		
	local x = tGainSPPosX[characterIndex][comboIndex] - 8
	local y = tGainSPPosY[characterIndex][comboIndex] - gainTime
	local damage = tGainSPDamage[characterIndex][comboIndex]
	local alpha  = tDecreaseAlphaSP[characterIndex][comboIndex]
		
	local _left, _right = DrawEachNumberA("UIData/GameNewImage.tga", damage, 8, x, y, 33, 867, 19, 25, 19, alpha)
	drawer:drawTextureA("UIData/GameNewImage.tga", _left-19, y+3, 19, 25, 9, 867, alpha)
end





--------------------------------------------------------------------

-- 포이즌 이펙트(1초에 한번씩 나오는거라 그전에 사라지고 다시 보여주고를 반복함)

--------------------------------------------------------------------
local tPoisonY		= { ["err"]=0, [0]=0, 0, 0, 0, 0, 0, 0, 0 }
local tPoisonAlpha	= { ["err"]=0, [0]=255, 255, 255, 255, 255, 255, 255, 255 }
function WndGame_InitPoisonEffect(index)
	if index < 0 and index >= #tPoisonY then
		return
	end
	
	tPoisonY[index]		= 0
	tPoisonAlpha[index] = 255
end


function WndGame_RenderPoisonEffect(index, x, y, damage, passTick)
	
	if index < 0 and index >= 8 then
		return
	end
	
	-- passTick 은 최종 58이 넘어옴
	local delay = 13
	if passTick > delay then
	
		tPoisonAlpha[index] = 255 - ((passTick-delay)*5)
		tPoisonY[index]		= (passTick-delay) * 2
		
		local _left, _right = DrawEachNumberA("UIData/GameNewImage.tga", damage, 8, x, y-tPoisonY[index], 32, 837, 19, 25, 19, tPoisonAlpha[index])
		drawer:drawTextureA("UIData/GameNewImage.tga", _left-19, y+2-tPoisonY[index], 17, 17, 10, 841, tPoisonAlpha[index])
	end
	
end





--------------------------------------------------------------------

-- 유령 그리기

--------------------------------------------------------------------
function WndGame_StartGhost(downIndex, x, y, attackName1, attackName2)
	Common_StartGhost(downIndex, x, y, attackName1, attackName2)
end



function WndGame_EndGhost(downIndex)
	Common_EndGhost(downIndex)
end



function WndGame_RenderGhost(slot, x, y, deltaTime)
	Common_RenderGhost(slot, x, y, deltaTime)
end




--------------------------------------------------------------------

-- 케릭터에 관한정보 그리기(HP, SP ...)

--------------------------------------------------------------------
function WndGame_RenderCharacter
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
			, exceptE
			, strongMode
			)
	
	local MONSTER_RACING = false
	local BATTLE = 0	-- 0:게임, 1:던전, 2:몬스터레이싱, 3:점령전, 4:점령전(옵저버)
	local bArcadeEvent = 0
	if strongMode > 0 then
		bArcadeEvent = 1
	end
	Common_RenderCharacter(deltatime, myslot, myteam, slot, team, characterName, 
		screenX, screenY, hp, sp, maxhp, maxsp, friend, isPenalty, penaltyValue, 
		BATTLE, showAllSP, showAllItem, _1stItemType, _2ndItemType, MONSTER_RACING, bArcadeEvent, exceptE)
end





--------------------------------------------------------------------

-- 팀 HP 게이지

--------------------------------------------------------------------
function WndGame_RenderTeamGauge(slot, team, myteam, characterName, hp, maxhp, teamNum, team0, team1, team2)
	--[[
	
	if maxhp <= 0 then
		return
	end
	
	local teamRealWidth		= 83
	local teamHPWidth		= hp * teamRealWidth / maxhp
	local teamOldHPWidth	= lasthp[slot] * teamRealWidth / maxhp
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	drawer:setTextColor(255,255,255,255)

	local drawPos = 40
	if teamNum >= 2 then
		if myteam == team then
		
			if slot == team0 then
				drawer:drawTexture("UIData/GameNewImage.tga", 4, 96+drawPos, 180, 19, 692, 724)
				local summaryName = SummaryString(g_STRING_FONT_GULIMCHE, 12, characterName, 70)
				local nameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, summaryName)
				drawer:drawText(summaryName, 50-nameSize/2, 100+drawPos)
				drawer:drawTexture("UIData/GameNewImage.tga", 98, 102+drawPos, teamOldHPWidth, 7, 607, 686)
				drawer:drawTexture("UIData/GameNewImage.tga", 98, 102+drawPos, teamHPWidth, 7, 607, 677)

			elseif slot == team1 then
				drawer:drawTexture("UIData/GameNewImage.tga", 4, 113+drawPos, 180, 19, 692, 724)
				local summaryName = SummaryString(g_STRING_FONT_GULIMCHE, 12, characterName, 70)
				local nameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, summaryName)
				drawer:drawText(summaryName, 50-nameSize/2, 117+drawPos)
				drawer:drawTexture("UIData/GameNewImage.tga", 98, 119+drawPos, teamOldHPWidth, 7, 607, 686)
				drawer:drawTexture("UIData/GameNewImage.tga", 98, 119+drawPos, teamHPWidth, 7, 607, 677)
				
			elseif slot == team2 then
				drawer:drawTexture("UIData/GameNewImage.tga", 4, 130+drawPos, 180, 19, 692, 724)
				local summaryName = SummaryString(g_STRING_FONT_GULIMCHE, 12, characterName, 70)
				local nameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, summaryName)
				drawer:drawText(summaryName, 50-nameSize/2, 134+drawPos)
				drawer:drawTexture("UIData/GameNewImage.tga", 98, 136+drawPos, teamOldHPWidth, 7, 607, 686)
				drawer:drawTexture("UIData/GameNewImage.tga", 98, 136+drawPos, teamHPWidth, 7, 607, 677)
			end
		end
	end
	--]]
end






-------------------------------------------------------------------------

--	랭킹 부분

-------------------------------------------------------------------------
local tRankOffsetX	= { ["err"]=0, 805, 805, 805, 805, 805, 805, 805, 805 }
--local tRankOffsetX	= { ["err"]=0, 42, 42, 42, 42, 42, 42, 42, 42 }
local tRankOffsetY	= { ["err"]=0, 20, 20, 20, 20, 20, 20, 20, 20 }

-- 현재 나의 랭크로 사이즈를 정한다.
function WndGame_BeforeRenderRank(myRank)

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
	local rankPos = -14--120
	
	for i=1, rank do
		rankPos = rankPos + tRankOffsetY[i]
	end
	
	return rankPos
end




local spacingPosX = 20
local g_mvpEffectTime = 0
local tPropertyItemTexY = {["err"]=0, [0]=560, 616, 672, 728, 784, 840}
function WndGame_RenderRank(slot, myslot, mybone, bTeam, team, rank, killCount, deadCount, 
				disconnected, relay, network, INFINITE_PING, hp, sp, maxhp, maxsp, deltatime, RESPAWN_TIME, revivalTime, 
				level, characterName, isGameOver, lifeCount, mvpIndex, transform, isPenalty, penaltyValue, currentUserNum,
				bFastRevive, rightRevive, itemType, exceptE, strongMode, isAutoMatch, bChampionShip)

	if slot == myslot then
		-- 다시 살아나기
		Common_RenderReStart(deltatime, hp, RESPAWN_TIME, revivalTime, isGameOver, lifeCount, bFastRevive, rightRevive)
		
		-- 나에대한 정보 그리기
		local visibleHPSP = 1
		local bArcadeEvent = 0
		if strongMode > 0 then
			bArcadeEvent = 1
		end
		local bTournamentArcade = 0
		Common_RenderME(slot, mybone, hp, sp, maxhp, maxsp, deltatime, 
				RESPAWN_TIME, revivalTime, level, characterName, isGameOver, lifeCount, 0, transform, isPenalty, penaltyValue, bArcadeEvent, exceptE, visibleHPSP, bTournamentArcade)
	
		if isPenalty == 1 then
			drawer:setTextColor(255, 255, 255, 255)
			drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
			common_DrawOutlineText1(drawer, "(HP - "..penaltyValue.."%)", 7, 70, 255,0,0,255, 255,255,255,255)
		end
	 end
	
	---------------------------------------------

	-- 오른쪽 랭킹정보

	---------------------------------------------
	-- 자기 랭킹
	drawer:setTextColor(255, 255, 255, 255)
	drawer:setFont("Arial", 22)

	
	-- 레드, 블루팀 배경 이미지
	if slot == myslot then
		if bTeam == 1 then
			if team == 0 then
				drawer:drawTexture("UIData/GameNewImage.tga", tRankOffsetX[rank]-18, GetCurrentRankPosY(rank), 254, 23, 267, 184, WIDETYPE_1)
			else
				drawer:drawTexture("UIData/GameNewImage.tga", tRankOffsetX[rank]-18, GetCurrentRankPosY(rank), 254, 23, 267, 209, WIDETYPE_1)
			end
		else
			drawer:drawTexture("UIData/GameNewImage.tga", tRankOffsetX[rank]-18, GetCurrentRankPosY(rank), 254, 23, 267, 184, WIDETYPE_1)
		end
	else
		if bTeam == 1 then
			if team == 0 then
				drawer:drawTexture("UIData/GameNewImage.tga", tRankOffsetX[rank]-spacingPosX-18, GetCurrentRankPosY(rank), 240, 17, 0, 149, WIDETYPE_1)
			else
				drawer:drawTexture("UIData/GameNewImage.tga", tRankOffsetX[rank]-spacingPosX-18, GetCurrentRankPosY(rank), 240, 17, 0, 168, WIDETYPE_1)
			end
		else
			drawer:drawTexture("UIData/GameNewImage.tga", tRankOffsetX[rank]-spacingPosX-18, GetCurrentRankPosY(rank), 240, 17, 0, 130, WIDETYPE_1)
		end
	end
	
	
	-- 네트워크
	if disconnected == 0 then
		local myPosY = 0
		if slot == myslot then
			myPosY = GetCurrentRankPosY(rank)+5
		else
			myPosY = GetCurrentRankPosY(rank)+1
		end
		
		-- 네트워크가 완전히 안될때
		if network == INFINITE_PING then
			drawer:drawTexture("UIData/GameNewImage.tga", 970-spacingPosX, myPosY, 24, 14, 149, 65, WIDETYPE_1)
		
		else		
			--통신속도 표시해주기
			local offset = 0
			local texX = 227
			if disconnected == 0 then
				if		 0 <= network and network <= 20 then	offset = 24;	texX = 227;
				elseif	20 <  network and network <= 40 then	offset = 19;	texX = 227;
				elseif	40 <  network and network <= 60 then	offset = 14;	texX = 175;
				elseif	60 <  network and network <= 80 then	offset = 9;		texX = 175;
				elseif	80 <  network and network <= 100 then	offset = 4;		texX = 201;
				else											offset = 4;		texX = 201;
				end
				drawer:drawTexture("UIData/GameNewImage.tga", 970-spacingPosX, myPosY, offset, 14, texX, 65, WIDETYPE_1)
			end
		end
	end

	drawer:setTextColor(255, 255, 255, 255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)

	if disconnected == 0 then
		if slot == myslot then
			drawer:setTextColor(255,205,86,255)
		else
			drawer:setTextColor(255, 255, 255, 255)
		end
	else
		drawer:setTextColor(255, 100, 30, 255)
	end
	
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	local userRankPosY = GetCurrentRankPosY(rank)
	if slot == myslot then
		drawer:setFont(g_STRING_FONT_GULIMCHE, 14)
		userRankPosY = userRankPosY + 3
	else
		userRankPosY = userRankPosY + 1
	end


	-- 순위
	if slot == myslot then
		drawer:drawTexture("UIData/GameNewImage.tga", 765-spacingPosX, userRankPosY-3, 50, 22, 50*(rank-1), 646, WIDETYPE_1)
	else
		if disconnected == 0 then 
			if IsKoreanLanguage() then
				drawer:drawText(rank.."위", 790-spacingPosX, userRankPosY+2, WIDETYPE_1)
			else
				local rankText = "th"
				if rank == 1 then
					rankText = "st"
				elseif rank == 2 then
					rankText = "nd"
				elseif rank == 3 then
					rankText = "rd"
				end
				
				drawer:drawText(rank..rankText, 790-spacingPosX, userRankPosY+2, WIDETYPE_1)
			end
		end
	end
	
	
	-- 이름
	if slot == myslot then
		local summaryName = SummaryString(g_STRING_FONT_GULIMCHE, 12, characterName, 80)
		local strSize = GetStringSize(g_STRING_FONT_GULIMCHE, 14, summaryName)
		common_DrawOutlineText1(drawer, summaryName, 864-(strSize/2)-spacingPosX, userRankPosY+2, 0,0,0,255, 255,205,86,255, WIDETYPE_1)
	else
		local summaryName = SummaryString(g_STRING_FONT_GULIMCHE, 12, characterName, 90)
		local strSize = GetStringSize(g_STRING_FONT_GULIMCHE, 112, summaryName)
		drawer:drawText(summaryName, 866-(strSize/2)-spacingPosX, userRankPosY+2, WIDETYPE_1)
	end
	
	

	-- 킬
	local killPos = 925
	local tenPos  = -7
	local hunPos  = -14
	local perPos  = 12
	local deadPos = 24
	local itemPos = -20
	
	if slot == myslot then
		killPos = 923
		tenPos  = -7
		hunPos  = -14
		perPos  = 15
		deadPos = 29
	end
	
	
	if slot == myslot then
	
		local koPos
		if 0 <= killCount and killCount < 10 then
			koPos = killPos
		elseif 10 <= killCount and killCount < 100 then
			koPos = killPos+tenPos
		else
			koPos = killPos+hunPos
		end
		
		common_DrawOutlineText1(drawer, killCount, koPos-spacingPosX, userRankPosY+2, 0,0,0,255, 255,205,86,255, WIDETYPE_1)
		
	else
	
		local koPos
		if 0 <= killCount and killCount < 10 then
			koPos = killPos
		elseif 10 <= killCount and killCount < 100 then
			koPos = killPos+tenPos
		else
			koPos = killPos+hunPos
		end
		
		drawer:drawText(killCount, koPos-spacingPosX, userRankPosY+2, WIDETYPE_1)
				
	end

	-- /
	if slot == myslot then
		common_DrawOutlineText1(drawer, "/", killPos+perPos-spacingPosX, userRankPosY+2, 0,0,0,255, 255,205,86,255, WIDETYPE_1)
	else
		drawer:drawText("/", killPos+perPos-spacingPosX, userRankPosY+2, WIDETYPE_1)
	end
	
	
	-- 데스
	if slot == myslot then
		common_DrawOutlineText1(drawer, deadCount, killPos+deadPos-spacingPosX, userRankPosY+2, 0,0,0,255, 255,205,86,255,  WIDETYPE_1)
	else
		drawer:drawText(deadCount, killPos+deadPos-spacingPosX, userRankPosY+2, WIDETYPE_1)
	end
	
	
	if disconnected == 1 then
		drawer:drawTexture("UIData/GameNewImage.tga", 915-spacingPosX, userRankPosY, 74, 14, 2, 190, WIDETYPE_1)
	end
	
	
	-- mvp(5명부터 적용)
	local MVPCOUNT = 5
	if IsKoreanLanguage() then
		if isAutoMatch == 1 then
			MVPCOUNT = 4
		end
	end
	
	
	if IsKoreanLanguage() then
		if bChampionShip then
			MVPCOUNT = 4
		end
	end
	
	
	if currentUserNum >= MVPCOUNT then
		if mvpIndex >= 0 then
			if slot == mvpIndex then
				g_mvpEffectTime = g_mvpEffectTime + deltatime
				g_mvpEffectTime = g_mvpEffectTime % 400
				
				if g_mvpEffectTime < 200 then
					drawer:drawTexture("UIData/GameNewImage.tga", 993-spacingPosX, userRankPosY-6, 50, 26, 500, 644, WIDETYPE_1)
				end
			end
		end
	end
	
	if slot == myslot then
		if itemType >= 0 then
			drawer:drawTextureWithScale_Angle_Offset("UIData/fightClub_005.tga", 802, userRankPosY+9, 54, 56, 510, tPropertyItemTexY[itemType], 
												80, 80, 255, 0, 8, 100, 0, WIDETYPE_1)
		end
	else
		if itemType >= 0 then
			drawer:drawTextureWithScale_Angle_Offset("UIData/fightClub_005.tga", 802, userRankPosY+7, 54, 56, 510, tPropertyItemTexY[itemType], 
												80, 80, 255, 0, 8, 100, 0, WIDETYPE_1)
		end
	end
	
	-- 복수대상
--	if rank == revengeRank then
--		drawer:drawTexture("UIData/myinfo2.tga", 764-spacingPosX, userRankPosY-7, 27, 27, 602, 475)
--	end
	
end



function WndCoinMatchGame_RenderRank(slot, myslot, mybone, bTeam, team, rank, killCount, deadCount, 
				disconnected, relay, network, INFINITE_PING, hp, sp, maxhp, maxsp, deltatime, RESPAWN_TIME, revivalTime, 
				level, characterName, isGameOver, lifeCount, mvpIndex, transform, isPenalty, penaltyValue, currentUserNum,
				bFastRevive, rightRevive, itemType, exceptE, strongMode, isAutoMatch, bChampionShip)

	if slot == myslot then
		-- 다시 살아나기
		Common_RenderReStart(deltatime, hp, RESPAWN_TIME, revivalTime, isGameOver, lifeCount, bFastRevive, rightRevive)
		
		-- 나에대한 정보 그리기
		local visibleHPSP = 1
		local bArcadeEvent = 0
		if strongMode > 0 then
			bArcadeEvent = 1
		end
		local bTournamentArcade = 0
		Common_RenderME(slot, mybone, hp, sp, maxhp, maxsp, deltatime, 
				RESPAWN_TIME, revivalTime, level, characterName, isGameOver, lifeCount, 0, transform, isPenalty, penaltyValue, bArcadeEvent, exceptE, visibleHPSP, bTournamentArcade)
	
		if isPenalty == 1 then
			drawer:setTextColor(255, 255, 255, 255)
			drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
			common_DrawOutlineText1(drawer, "(HP - "..penaltyValue.."%)", 7, 70, 255,0,0,255, 255,255,255,255)
		end
	 end
	
	---------------------------------------------

	-- 오른쪽 랭킹정보

	---------------------------------------------
	-- 자기 랭킹
	drawer:setTextColor(255, 255, 255, 255)
	drawer:setFont("Arial", 22)

	
	-- 레드, 블루팀 배경 이미지
	if slot == myslot then
		if bTeam == 1 then
			if team == 0 then
				drawer:drawTexture("UIData/GameNewImage.tga", tRankOffsetX[rank]-18, GetCurrentRankPosY(rank), 254, 23, 267, 184, WIDETYPE_1)
			else
				drawer:drawTexture("UIData/GameNewImage.tga", tRankOffsetX[rank]-18, GetCurrentRankPosY(rank), 254, 23, 267, 209, WIDETYPE_1)
			end
		else
			drawer:drawTexture("UIData/GameNewImage.tga", tRankOffsetX[rank]-18, GetCurrentRankPosY(rank), 254, 23, 267, 184, WIDETYPE_1)
		end
	else
		if bTeam == 1 then
			if team == 0 then
				drawer:drawTexture("UIData/GameNewImage.tga", tRankOffsetX[rank]-spacingPosX-18, GetCurrentRankPosY(rank), 240, 17, 0, 149, WIDETYPE_1)
			else
				drawer:drawTexture("UIData/GameNewImage.tga", tRankOffsetX[rank]-spacingPosX-18, GetCurrentRankPosY(rank), 240, 17, 0, 168, WIDETYPE_1)
			end
		else
			drawer:drawTexture("UIData/GameNewImage.tga", tRankOffsetX[rank]-spacingPosX-18, GetCurrentRankPosY(rank), 240, 17, 0, 130, WIDETYPE_1)
		end
	end
	
	
	-- 네트워크
	if disconnected == 0 then
		local myPosY = 0
		if slot == myslot then
			myPosY = GetCurrentRankPosY(rank)+5
		else
			myPosY = GetCurrentRankPosY(rank)+1
		end
		
		-- 네트워크가 완전히 안될때
		if network == INFINITE_PING then
			drawer:drawTexture("UIData/GameNewImage.tga", 970-spacingPosX, myPosY, 24, 14, 149, 65, WIDETYPE_1)
		
		else		
			--통신속도 표시해주기
			local offset = 0
			local texX = 227
			if disconnected == 0 then
				if		 0 <= network and network <= 20 then	offset = 24;	texX = 227;
				elseif	20 <  network and network <= 40 then	offset = 19;	texX = 227;
				elseif	40 <  network and network <= 60 then	offset = 14;	texX = 175;
				elseif	60 <  network and network <= 80 then	offset = 9;		texX = 175;
				elseif	80 <  network and network <= 100 then	offset = 4;		texX = 201;
				else											offset = 4;		texX = 201;
				end
				drawer:drawTexture("UIData/GameNewImage.tga", 970-spacingPosX, myPosY, offset, 14, texX, 65, WIDETYPE_1)
			end
		end
	end

	drawer:setTextColor(255, 255, 255, 255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)

	if disconnected == 0 then
		if slot == myslot then
			drawer:setTextColor(255,205,86,255)
		else
			drawer:setTextColor(255, 255, 255, 255)
		end
	else
		drawer:setTextColor(255, 100, 30, 255)
	end
	
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	local userRankPosY = GetCurrentRankPosY(rank)
	if slot == myslot then
		drawer:setFont(g_STRING_FONT_GULIMCHE, 14)
		userRankPosY = userRankPosY + 3
	else
		userRankPosY = userRankPosY + 1
	end


	-- 순위
	if slot == myslot then
		drawer:drawTexture("UIData/GameNewImage.tga", 765-spacingPosX, userRankPosY-3, 50, 22, 50*(rank-1), 646, WIDETYPE_1)
	else
		if disconnected == 0 then 
			if IsKoreanLanguage() then
				drawer:drawText(rank.."위", 790-spacingPosX, userRankPosY+2, WIDETYPE_1)
			else
				local rankText = "th"
				if rank == 1 then
					rankText = "st"
				elseif rank == 2 then
					rankText = "nd"
				elseif rank == 3 then
					rankText = "rd"
				end
				
				drawer:drawText(rank..rankText, 790-spacingPosX, userRankPosY+2, WIDETYPE_1)
			end
		end
	end
	
	
	-- 이름
	if slot == myslot then
		local summaryName = SummaryString(g_STRING_FONT_GULIMCHE, 12, characterName, 80)
		local strSize = GetStringSize(g_STRING_FONT_GULIMCHE, 14, summaryName)
		common_DrawOutlineText1(drawer, summaryName, 864-(strSize/2)-spacingPosX, userRankPosY+2, 0,0,0,255, 255,205,86,255, WIDETYPE_1)
	else
		local summaryName = SummaryString(g_STRING_FONT_GULIMCHE, 12, characterName, 90)
		local strSize = GetStringSize(g_STRING_FONT_GULIMCHE, 112, summaryName)
		drawer:drawText(summaryName, 866-(strSize/2)-spacingPosX, userRankPosY+2, WIDETYPE_1)
	end
	
	

	-- 킬
	local killPos = 925
	local tenPos  = -7
	local hunPos  = -14
	local thouPos  = -21
	local perPos  = 12
	local deadPos = 24
	local itemPos = -20
	
	if slot == myslot then
		killPos = 923
		tenPos  = -7
		hunPos  = -14
		perPos  = 15
		deadPos = 29
	end
	
	
	if slot == myslot then
	
		local koPos
		if 0 <= killCount and killCount < 10 then
			koPos = killPos
		elseif 10 <= killCount and killCount < 100 then
			koPos = killPos+tenPos
		elseif 100 <= killCount and killCount < 1000 then
			koPos = killPos+hunPos
		else
			koPos = killPos+thouPos
		end
		
		common_DrawOutlineText1(drawer, killCount, koPos-spacingPosX, userRankPosY+2, 0,0,0,255, 255,205,86,255, WIDETYPE_1)
		
	else
	
		local koPos
		if 0 <= killCount and killCount < 10 then
			koPos = killPos
		elseif 10 <= killCount and killCount < 100 then
			koPos = killPos+tenPos
		elseif 100 <= killCount and killCount < 1000 then
			koPos = killPos+hunPos
		else
			koPos = killPos+thouPos
		end
		
		drawer:drawText(killCount, koPos-spacingPosX, userRankPosY+2, WIDETYPE_1)
				
	end

	-- /
	--if slot == myslot then
	--	common_DrawOutlineText1(drawer, "/", killPos+perPos-spacingPosX, userRankPosY+2, 0,0,0,255, 255,205,86,255, WIDETYPE_1)
	--else
	--	drawer:drawText("/", killPos+perPos-spacingPosX, userRankPosY+2, WIDETYPE_1)
	--end
	
	
	-- 데스
	--if slot == myslot then
	--	common_DrawOutlineText1(drawer, deadCount, killPos+deadPos-spacingPosX, userRankPosY+2, 0,0,0,255, 255,205,86,255,  WIDETYPE_1)
	--else
	--	drawer:drawText(deadCount, killPos+deadPos-spacingPosX, userRankPosY+2, WIDETYPE_1)
	--end
	
	
	if disconnected == 1 then
		drawer:drawTexture("UIData/GameNewImage.tga", 915-spacingPosX, userRankPosY, 74, 14, 2, 190, WIDETYPE_1)
	end
	
	
	-- mvp(5명부터 적용)
	local MVPCOUNT = 5
	if IsKoreanLanguage() then
		if isAutoMatch == 1 then
			MVPCOUNT = 4
		end
	end
	
	
	if IsKoreanLanguage() then
		if bChampionShip then
			MVPCOUNT = 4
		end
	end
	
	
	if currentUserNum >= MVPCOUNT then
		if mvpIndex >= 0 then
			if slot == mvpIndex then
				g_mvpEffectTime = g_mvpEffectTime + deltatime
				g_mvpEffectTime = g_mvpEffectTime % 400
				
				if g_mvpEffectTime < 200 then
					drawer:drawTexture("UIData/GameNewImage.tga", 993-spacingPosX, userRankPosY-6, 50, 26, 500, 644, WIDETYPE_1)
				end
			end
		end
	end
	
	if slot == myslot then
		if itemType >= 0 then
			drawer:drawTextureWithScale_Angle_Offset("UIData/fightClub_005.tga", 802, userRankPosY+9, 54, 56, 510, tPropertyItemTexY[itemType], 
												80, 80, 255, 0, 8, 100, 0, WIDETYPE_1)
		end
	else
		if itemType >= 0 then
			drawer:drawTextureWithScale_Angle_Offset("UIData/fightClub_005.tga", 802, userRankPosY+7, 54, 56, 510, tPropertyItemTexY[itemType], 
												80, 80, 255, 0, 8, 100, 0, WIDETYPE_1)
		end
	end
	
	-- 복수대상
--	if rank == revengeRank then
--		drawer:drawTexture("UIData/myinfo2.tga", 764-spacingPosX, userRankPosY-7, 27, 27, 602, 475)
--	end
	
end




----------------------------------------------------------

-- 콤보효과 주기

----------------------------------------------------------
local tComboEffectTexY = { ["err"]=0, 0, 38, 76 }
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_wndGame_Effect_combo")
mywindow:setWideType(5)
mywindow:setPosition(400, 190)
mywindow:setSize(237, 37)
mywindow:setScaleWidth(255)
mywindow:setScaleHeight(255)
mywindow:setVisible(false)
mywindow:setTexture("Enabled", "UIData/GameNewImage2.tga", 646, 0)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
root:addChildWindow(mywindow)

winMgr:getWindow("sj_wndGame_Effect_combo"):addController("CommonAlertOkBoxCtrl0", "StampEffect", "xscale", "Quintic_EaseIn", 700, 255, 3, true, false, 10)
winMgr:getWindow("sj_wndGame_Effect_combo"):addController("CommonAlertOkBoxCtrl0", "StampEffect", "yscale", "Quintic_EaseIn", 700, 255, 3, true, false, 10)
winMgr:getWindow("sj_wndGame_Effect_combo"):addController("CommonAlertOkBoxCtrl0", "StampEffect", "xscale", "Elastic_EaseOut", 150, 255, 5, true, false, 10)
winMgr:getWindow("sj_wndGame_Effect_combo"):addController("CommonAlertOkBoxCtrl0", "StampEffect", "yscale", "Elastic_EaseOut", 150, 255, 5, true, false, 10)
winMgr:getWindow("sj_wndGame_Effect_combo"):setAlign(8)

local g_ComboEffectEnable = false
local g_ComboEffectAlpha = 255
local g_ComboEffectTime = 0
function WndGame_ComboEffect(state)
	g_ComboEffectEnable = true
	g_ComboEffectAlpha = 255
	
	if state >= 3 then
		state = 3
	end
	winMgr:getWindow("sj_wndGame_Effect_combo"):setTexture("Enabled", "UIData/GameNewImage2.tga", 646, tComboEffectTexY[state])
	winMgr:getWindow("sj_wndGame_Effect_combo"):setVisible(true)
	winMgr:getWindow("sj_wndGame_Effect_combo"):activeMotion("StampEffect")
end



----------------------------------------------------------

-- KO효과 주기

----------------------------------------------------------
-- 최대 32명까지 KO를 할수 있다고 생각해서 32명까지 생성
local g_KoEffectEnable = { ["err"]=0, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false
									, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false }
local g_KoEffectAlpha  = { ["err"]=0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
									, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
local g_KoEffectTime   = { ["err"]=0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
									, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
local g_KoEffectTexY   = { ["err"]=0, 0, 137, 274, 411, 411, 411, 411, 411, 411, 411, 411, 411, 411, 411, 411, 411
									, 411, 411, 411, 411, 411, 411, 411, 411, 411, 411, 411, 411, 411, 411, 411, 411 }
for i=1, #g_KoEffectEnable do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_wndGame_Effect_ko"..i)
	mywindow:setWideType(5);
	mywindow:setPosition(190, 80)
	mywindow:setSize(646, 137)
	mywindow:setScaleWidth(255)
	mywindow:setScaleHeight(255)
	mywindow:setVisible(false)
	mywindow:setTexture("Enabled", "UIData/GameNewImage2.tga", 0, 0)
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setProperty("FrameEnabled", "False")
	root:addChildWindow(mywindow)

	winMgr:getWindow("sj_wndGame_Effect_ko"..i):addController("CommonAlertOkBoxCtrl0", "StampEffect", "xscale", "Quintic_EaseIn", 700, 255, 3, true, false, 10)
	winMgr:getWindow("sj_wndGame_Effect_ko"..i):addController("CommonAlertOkBoxCtrl0", "StampEffect", "yscale", "Quintic_EaseIn", 700, 255, 3, true, false, 10)
	winMgr:getWindow("sj_wndGame_Effect_ko"..i):addController("CommonAlertOkBoxCtrl0", "StampEffect", "xscale", "Elastic_EaseOut", 150, 255, 5, true, false, 10)
	winMgr:getWindow("sj_wndGame_Effect_ko"..i):addController("CommonAlertOkBoxCtrl0", "StampEffect", "yscale", "Elastic_EaseOut", 150, 255, 5, true, false, 10)
	winMgr:getWindow("sj_wndGame_Effect_ko"..i):setAlign(8)
end

function WndGame_KoEffect(koCount)
	if koCount <= 0 then
		return
	end
		
	-- 이전에 진행되는게 있다면 진행을 중지한다.
	for i=1, #g_KoEffectEnable do
		g_KoEffectEnable[i] = false
	end
	
	if koCount >= #g_KoEffectEnable then
		return
	end
	
	g_KoEffectEnable[koCount] = true
	g_KoEffectAlpha[koCount]  = 255
	
	winMgr:getWindow("sj_wndGame_Effect_ko"..koCount):setTexture("Enabled", "UIData/GameNewImage2.tga", 0, g_KoEffectTexY[koCount])
	winMgr:getWindow("sj_wndGame_Effect_ko"..koCount):setVisible(true)
	winMgr:getWindow("sj_wndGame_Effect_ko"..koCount):activeMotion("StampEffect")
	
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
function WndGame_RenderScore(deltaTime, bTeam, bItem, time, killCount, min, sec, redKillCount, blueKillCount, myKillCount, myDieCount)
	
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
				winMgr:getWindow("sj_wndGame_Effect_combo"):setVisible(false)
			end
			winMgr:getWindow("sj_wndGame_Effect_combo"):setAlpha(g_ComboEffectAlpha)
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
					
					if winMgr:getWindow("sj_wndGame_Effect_ko"..i) then
						winMgr:getWindow("sj_wndGame_Effect_ko"..i):setVisible(false)
					end
				end
				
				if winMgr:getWindow("sj_wndGame_Effect_ko"..i) then
					winMgr:getWindow("sj_wndGame_Effect_ko"..i):setAlpha(g_KoEffectAlpha[i])
				end
			end
		else
			g_KoEffectAlpha[i] = 0
			g_KoEffectTime[i]  = 0
			if winMgr:getWindow("sj_wndGame_Effect_ko"..i) then
				winMgr:getWindow("sj_wndGame_Effect_ko"..i):setVisible(false)
				winMgr:getWindow("sj_wndGame_Effect_ko"..i):setAlpha(g_KoEffectAlpha[i])
			end
		end
	end
	
	
	
	
	------------------------------------
	-- time
	------------------------------------
	drawer:drawTexture("UIData/GameNewImage.tga", 495, 4, 34, 15, 738, 66, WIDETYPE_5)


	-- 시간(무제한)
	if time == 0 then
	
		drawer:drawTexture("UIData/GameNewImage.tga", 484, 14, 57, 30, 9, 704, WIDETYPE_5)	-- 무제한
	
	-- 시간제( 3:00, 5:00 )
	else
		
		-- 마지막 10초 남았을 경우
		if min >= 0 then
			if min == 0 and sec <= 9 then
				
				-- 깜빡거리면서 시간 보이기
				last10secEffectTime = last10secEffectTime + deltaTime
				last10secEffectTime = last10secEffectTime % 100
							
				if last10secEffectTime < 50 then
					drawer:drawTexture("UIData/GameNewImage.tga", 492, 14, 41, 54, sec*41, 241, WIDETYPE_5)
				else
					drawer:drawTexture("UIData/GameNewImage.tga", 492, 14, 41, 54, sec*41, 299, WIDETYPE_5)
				end
				
			else
				
			--	drawer:drawTexture("UIData/GameNewImage.tga", 475, 0, 74, 54, 451, 241)		-- 평상시 VS
				
				-- 분
				drawer:drawTexture("UIData/GameNewImage.tga", 462, 22, 20, 26, 77, 704, WIDETYPE_5)
				drawer:drawTexture("UIData/GameNewImage.tga", 483, 22, 20, 26, 77+(min*20), 704, WIDETYPE_5)
			
				-- :
				drawer:drawTexture("UIData/GameNewImage.tga", 502, 22, 20, 26, 277, 704, WIDETYPE_5)
				
				-- 초
				local ten = (sec/10)
				local one = (sec%10)
				drawer:drawTexture("UIData/GameNewImage.tga", 522, 22, 20, 26, 77+(ten*20), 704, WIDETYPE_5)
				drawer:drawTexture("UIData/GameNewImage.tga", 542, 22, 20, 26, 77+(one*20), 704, WIDETYPE_5)
			end	
		else
		
			-- 깜빡거리면서 시간 보이기
			last10secEffectTime = last10secEffectTime + deltaTime
			last10secEffectTime = last10secEffectTime % 100

			if last10secEffectTime < 50 then
				drawer:drawTexture("UIData/GameNewImage.tga", 492, 14, 41, 54, 41, 241, WIDETYPE_5)
			else
				drawer:drawTexture("UIData/GameNewImage.tga", 492, 14, 41, 54, 41, 299, WIDETYPE_5)
			end
			
		end
	end
	
	
	
	
	--[[
	-- 목표킬수(3, 5, 7, 10, 15, 20)
	if killCount < 10 then
		drawer:drawTexture("UIData/GameImage_new.tga", 488, 55, 29, 40, 610+(killCount*29), 194)
	else
		local ten = (killCount/10)
		local one = (killCount%10)
		drawer:drawTexture("UIData/GameImage_new.tga", 473, 55, 29, 40, 610+(ten*29), 194)
		drawer:drawTexture("UIData/GameImage_new.tga", 502, 55, 29, 40, 610+(one*29), 194)
	end
	--]]
	
	
	
	if bTeam == 1 then
		-- 레드팀 킬수(반대로 블루팀 죽은횟수)
		if redKillCount < 10 then
			drawer:drawTexture("UIData/GameNewImage.tga", 402, 0, 51, 70, redKillCount*51, 496, WIDETYPE_5)
		elseif  redKillCount < 100 then
			local ten = (redKillCount/10)
			local one = (redKillCount%10)
			if ten == 1 then
				drawer:drawTexture("UIData/GameNewImage.tga", 368, 0, 51, 70, 510, 496, WIDETYPE_5)
				drawer:drawTexture("UIData/GameNewImage.tga", 402, 0, 51, 70, one*51, 496, WIDETYPE_5)
			else
				drawer:drawTexture("UIData/GameNewImage.tga", 354, 0, 51, 70, ten*51, 496, WIDETYPE_5)
				drawer:drawTexture("UIData/GameNewImage.tga", 402, 0, 51, 70, one*51, 496, WIDETYPE_5)
			end
		elseif  redKillCount < 1000 then
			local hund = (redKillCount/100) %10
			local ten = (redKillCount/10) % 10
			local one = (redKillCount%10)
			--if ten == 1 then
			--	drawer:drawTexture("UIData/GameNewImage.tga", 368, 0, 51, 70, 510, 496, WIDETYPE_5)
			--	drawer:drawTexture("UIData/GameNewImage.tga", 368, 0, 51, 70, 510, 496, WIDETYPE_5)
			--	drawer:drawTexture("UIData/GameNewImage.tga", 402, 0, 51, 70, one*51, 496, WIDETYPE_5)
				
			--else
				drawer:drawTexture("UIData/GameNewImage.tga", 306, 0, 51, 70, hund*51, 496, WIDETYPE_5)
				drawer:drawTexture("UIData/GameNewImage.tga", 354, 0, 51, 70, ten*51, 496, WIDETYPE_5)				
				drawer:drawTexture("UIData/GameNewImage.tga", 402, 0, 51, 70, one*51, 496, WIDETYPE_5)
			--end
			
		elseif  redKillCount < 10000 then
			local thou = (redKillCount/1000) %10
			local hund = (redKillCount/100) %10
			local ten = (redKillCount/10) % 10
			local one = (redKillCount%10)
			--if ten == 1 then
			--	drawer:drawTexture("UIData/GameNewImage.tga", 368, 0, 51, 70, 510, 496, WIDETYPE_5)
			--	drawer:drawTexture("UIData/GameNewImage.tga", 368, 0, 51, 70, 510, 496, WIDETYPE_5)
			--	drawer:drawTexture("UIData/GameNewImage.tga", 402, 0, 51, 70, one*51, 496, WIDETYPE_5)
				
			--else
				drawer:drawTexture("UIData/GameNewImage.tga", 258, 0, 51, 70, thou*51, 496, WIDETYPE_5)
				drawer:drawTexture("UIData/GameNewImage.tga", 306, 0, 51, 70, hund*51, 496, WIDETYPE_5)
				drawer:drawTexture("UIData/GameNewImage.tga", 354, 0, 51, 70, ten*51, 496, WIDETYPE_5)				
				drawer:drawTexture("UIData/GameNewImage.tga", 402, 0, 51, 70, one*51, 496, WIDETYPE_5)
			--end
			
		end
		
		-- 블루팀 킬수(반대로 레드팀 죽은횟수)
		if blueKillCount < 10 then
			drawer:drawTexture("UIData/GameNewImage.tga", 571, 0, 51, 70, blueKillCount*51, 569, WIDETYPE_5)
		elseif  blueKillCount < 100 then
			local ten = (blueKillCount/10)
			local one = (blueKillCount%10)
			if ten == 1 then
				drawer:drawTexture("UIData/GameNewImage.tga", 568, 0, 51, 70, 510, 569, WIDETYPE_5)
				drawer:drawTexture("UIData/GameNewImage.tga", 602, 0, 51, 70, one*51, 569, WIDETYPE_5)
			else
				drawer:drawTexture("UIData/GameNewImage.tga", 570, 0, 51, 70, ten*51, 569, WIDETYPE_5)
				drawer:drawTexture("UIData/GameNewImage.tga", 618, 0, 51, 70, one*51, 569, WIDETYPE_5)
			end
		elseif  blueKillCount < 1000 then
			local thou = (blueKillCount/1000) %10 
			local hund = (blueKillCount/100) %10			
			local ten = (blueKillCount/10) %10
			local one = (blueKillCount%10)
			--if ten == 1 then
			--	drawer:drawTexture("UIData/GameNewImage.tga", 568, 0, 51, 70, 510, 569, WIDETYPE_5)
			--	drawer:drawTexture("UIData/GameNewImage.tga", 602, 0, 51, 70, one*51, 569, WIDETYPE_5)
			--else
				drawer:drawTexture("UIData/GameNewImage.tga", 570, 0, 51, 70, hund*51, 569, WIDETYPE_5)
				drawer:drawTexture("UIData/GameNewImage.tga", 618, 0, 51, 70, ten*51, 569, WIDETYPE_5)
				drawer:drawTexture("UIData/GameNewImage.tga", 666, 0, 51, 70, one*51, 569, WIDETYPE_5)
			--end
		
		
		elseif  blueKillCount < 10000 then
			local thou = (blueKillCount/1000) %10 
			local hund = (blueKillCount/100) %10			
			local ten = (blueKillCount/10) %10
			local one = (blueKillCount%10)
			--if ten == 1 then
			--	drawer:drawTexture("UIData/GameNewImage.tga", 568, 0, 51, 70, 510, 569, WIDETYPE_5)
			--	drawer:drawTexture("UIData/GameNewImage.tga", 602, 0, 51, 70, one*51, 569, WIDETYPE_5)
			--else
				drawer:drawTexture("UIData/GameNewImage.tga", 570, 0, 51, 70, thou*51, 569, WIDETYPE_5)
				drawer:drawTexture("UIData/GameNewImage.tga", 618, 0, 51, 70, hund*51, 569, WIDETYPE_5)
				drawer:drawTexture("UIData/GameNewImage.tga", 666, 0, 51, 70, ten*51, 569, WIDETYPE_5)
				drawer:drawTexture("UIData/GameNewImage.tga", 714, 0, 51, 70, one*51, 569, WIDETYPE_5)
			--end		
		
		end
	
	end
	
end





----------------------------------------------------------

-- 누가 누구를 죽였는지 확인

----------------------------------------------------------
function WndGame_RenderKillAndDead(bTeam, killEnemyType, deadEnemyType, count, killName, deadName)
	--[[
	local firstPosX = 800
	local firstPosY = 10+(count*28)
	local killPosX	= GetStringSize(g_STRING_FONT_GULIMCHE, 12, killName)
	local summaryDeadName = SummaryString(g_STRING_FONT_GULIMCHE, 12, deadName, 70)
	
	-- 가운데 주먹 이미지
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	drawer:drawTexture("UIData/GameNewImage.tga", firstPosX, firstPosY, 216, 38, 303, 79, WIDETYPE_1)


	-- 케릭터 이름
	if bTeam == 0 then
		common_DrawOutlineText1(drawer, killName, firstPosX+76-killPosX, firstPosY+12, 0,0,0,255, 102,204,102,255, WIDETYPE_1)
		common_DrawOutlineText1(drawer, summaryDeadName, firstPosX+138, firstPosY+12, 0,0,0,255, 200,200,200,255, WIDETYPE_1)
	else
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
	--]]
	
	local firstPosX = 800
	local firstPosY = 220+(count*30)--200+(count*38)
	local killPosX	= GetStringSize(g_STRING_FONT_GULIMCHE, 12, killName)
	local summaryDeadName = SummaryString(g_STRING_FONT_GULIMCHE, 12, deadName, 70)
	
	-- 가운데 주먹 이미지
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	drawer:drawTexture("UIData/GameNewImage.tga", firstPosX, firstPosY, 216, 38, 303, 79, WIDETYPE_1)


	-- 케릭터 이름
	if bTeam == 0 then
		common_DrawOutlineText1(drawer, killName, firstPosX+76-killPosX, firstPosY+12, 0,0,0,255, 102,204,102,255, WIDETYPE_1)
		common_DrawOutlineText1(drawer, summaryDeadName, firstPosX+138, firstPosY+12, 0,0,0,255, 200,200,200,255, WIDETYPE_1)
	else
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
end





----------------------------------------------------------

-- 미션 그리기 (3명부터 보이기)

----------------------------------------------------------
--[[
local tMissionDesc = { ["err"]=0, [0]=-300, -300 }
local tMissionSucc = { ["err"]=0, [0]=-100, -100 }
local g_MissionEffectTime0 = 0
local g_MissionEffectTime1 = 0
local g_missionSound0 = true
local g_missionSound1 = true
local g_missionCompleteSound = true
function WndGame_RenderMission(deltaTime, ready, fight, bComplete, bSuccess0, bSuccess1, contents0, contents1, bLast1Min)
	
	drawer:setTextColor(255, 255, 255, 255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	
	-- 미션 배경창
	drawer:drawTexture("UIData/GameNewImage.tga", 632, 716, 387, 48, 632, 256, WIDETYPE_4)

	-- 미션 설정값
	local mission0_size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, contents0)
	local mission1_size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, contents1)
	local rightEmptyLine0 = 985 - mission0_size
	local rightEmptyLine1 = 985 - mission1_size
	local successPos0 = 990 - mission0_size - 80
	local successPos1 = 990 - mission1_size - 80
	
	-- 미션 내용
	if ready == 0 and fight == 0 then
	
		-- 미션 0번 내용
		if rightEmptyLine0 <= tMissionDesc[0] then
			tMissionDesc[0] = rightEmptyLine0
			
			if bSuccess0 == 1 then
				drawer:setTextColor(102, 153, 102, 255)
				common_DrawOutlineText1(drawer, contents0, tMissionDesc[0], 723, 0,0,0,255, 102,204,102, 255, WIDETYPE_4)
			else
				if bLast1Min == 1 then
					g_MissionEffectTime0 = g_MissionEffectTime0 + deltaTime
					g_MissionEffectTime0 = g_MissionEffectTime0 % 400
								
					if g_MissionEffectTime0 < 200 then
						drawer:setTextColor(255, 255, 255, 255)
						drawer:drawText(contents0, tMissionDesc[0], 723, WIDETYPE_4)
					end
				else
					drawer:setTextColor(255, 255, 255, 255)
					drawer:drawText(contents0, tMissionDesc[0], 723, WIDETYPE_4)
				end
			end
			
		else
			drawer:setTextColor(255, 255, 255, 255)			
			drawer:drawText(contents0, tMissionDesc[0], 723, WIDETYPE_4)
		end
		
		-- 미션 1번 내용
		if rightEmptyLine1 <= tMissionDesc[1] then
			tMissionDesc[1] = rightEmptyLine1
			
			if bSuccess1 == 1 then
				drawer:setTextColor(102, 153, 102, 255)
				common_DrawOutlineText1(drawer, contents1, tMissionDesc[1], 746, 0,0,0,255, 102,204,102,255, WIDETYPE_4)
			else
				if bLast1Min == 1 then
					g_MissionEffectTime1 = g_MissionEffectTime1 + deltaTime
					g_MissionEffectTime1 = g_MissionEffectTime1 % 400
								
					if g_MissionEffectTime1 < 200 then
						drawer:setTextColor(255, 255, 255, 255)
						drawer:drawText(contents1, tMissionDesc[1], 746, WIDETYPE_4)
					end
				else
					drawer:setTextColor(255, 255, 255, 255)
					drawer:drawText(contents1, tMissionDesc[1], 746, WIDETYPE_4)
				end	
			end
			
		else
			drawer:setTextColor(255, 255, 255, 255)
			drawer:drawText(contents1, tMissionDesc[1], 746, WIDETYPE_4)
		end
		
		tMissionDesc[0] = tMissionDesc[0] + (deltaTime*4)
		tMissionDesc[1] = tMissionDesc[1] + (deltaTime*4)
		
	end
	
	
	-- 미션 Complete
	if bComplete == 1 then
		if g_missionCompleteSound then
			g_missionCompleteSound = false
			PlaySound('sound/System/System_Complete.wav')
		end
		drawer:drawTexture("UIData/GameNewImage.tga", 850, 693, 169, 23, 761, 233, WIDETYPE_4)
	else
		drawer:drawTexture("UIData/GameNewImage.tga", 934, 693, 85, 23, 934, 233, WIDETYPE_4)
	end
	
	
	
	-- 1번 미션 성공
	if bSuccess0 == 1 then
	
		if bComplete == 0 then
			if g_missionSound0 then
				g_missionSound0 = false
				PlaySound('sound/System/System_Succes.wav')
			end
		end
		
		drawer:drawTexture("UIData/GameNewImage.tga", 995, 718, 22, 21, 995, 187, WIDETYPE_4)
		
		if successPos0 <= tMissionSucc[0] then
			tMissionSucc[0] = successPos0
			drawer:drawTexture("UIData/GameNewImage.tga", tMissionSucc[0], 710, 59, 38, 880, 182, WIDETYPE_4)	-- success
		else
			drawer:drawTexture("UIData/GameNewImage.tga", tMissionSucc[0], 710, 59, 38, 880, 182, WIDETYPE_4)	-- success
		end
		
		tMissionSucc[0] = tMissionSucc[0] + (deltaTime*4)
	end
	
	
	
	-- 2번 미션 성공
	if bSuccess1 == 1 then
	
		if bComplete == 0 then
			if g_missionSound1 then
				g_missionSound1 = false
				PlaySound('sound/System/System_Succes.wav')
			end
		end
		
		drawer:drawTexture("UIData/GameNewImage.tga", 995, 741, 22, 21, 995, 210, WIDETYPE_4)
		
		if successPos1 <= tMissionSucc[1] then
			tMissionSucc[1] = successPos1
			drawer:drawTexture("UIData/GameNewImage.tga", tMissionSucc[1], 733, 59, 38, 880, 182, WIDETYPE_4)	-- success
		else
			drawer:drawTexture("UIData/GameNewImage.tga", tMissionSucc[1], 733, 59, 38, 880, 182, WIDETYPE_4)	-- success
		end
		
		tMissionSucc[1] = tMissionSucc[1] + (deltaTime*4)
	end	
	
end
--]]





----------------------------------------------------------

-- ready 그리기

----------------------------------------------------------
local g_readySound = true
local tReadyDelta = { ["err"]=0, -410 }
local tFightDelta = { ["err"]=0, 0, 255 }
function WndGame_RenderBattleReady(deltaTime)
	
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
local g_fightTime = 0
local g_fightAlpha = 0
function WndGame_CallFight()
	 g_fightTime = 0
	 g_fightAlpha = 255
end

function WndGame_RenderBattleFight(deltaTime)
	--[[
	tFightDelta[1] = tFightDelta[1] + deltaTime
	if tFightDelta[1] >= 400 then
		
		tFightDelta[2] = tFightDelta[2] - deltaTime/2
		if tFightDelta[2] <= 0 then
			tFightDelta[2] = 0
		end
	end
	--]]
	
	g_fightTime = g_fightTime + deltaTime
	local scale = Effect_Linear_EaseNone(g_fightTime, 0, 240-g_fightTime, 20)
	if scale < 0 then
		scale = 0
	end
	
	g_fightAlpha = g_fightAlpha - (deltaTime/6)
	if g_fightAlpha <= 0 then
		g_fightAlpha = 0
	end
		
	drawer:drawTextureWithScale_Angle_Offset("UIData/GameNewImage.tga", 520, 230, 425, 88, 599, 317,
										scale+255, scale+255, g_fightAlpha, 0, 8, 100, 0, WIDETYPE_5)
											
	-- 파이트 사운드
	if g_fightSound then
		g_fightSound = false
		PlaySound('sound/System/System_FIGHT.wav')
	end
	
	--drawer:drawTextureA("UIData/GameNewImage.tga", 290, 201, 425, 88, 599, 317, tFightDelta[2], WIDETYPE_5)
	--tReadyDelta[1] = -410
end



----------------------------------------------------------

-- 발렌타인 이벤트 이미지

----------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_wndGame_eventImage")
mywindow:setTexture("Enabled", "UIData/Event_Valentine_villagePopup.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/Event_Valentine_villagePopup.tga", 0, 0)
mywindow:setWideType(5);
mywindow:setPosition(0, 60)
mywindow:setSize(1024, 132)
mywindow:setVisible(false)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:addController("gameEvent", "gameEvent", "alpha", "Sine_EaseInOut", 0, 255, 10, false, false, 10)
mywindow:addController("gameEvent", "gameEvent", "alpha", "Sine_EaseInOut", 255, 255, 30, false, false, 10)
mywindow:addController("gameEvent", "gameEvent", "alpha", "Sine_EaseInOut", 255, 0, 10, false, false, 10)
root:addChildWindow(mywindow)

function StartValentineEvent()
	winMgr:getWindow("sj_wndGame_eventImage"):setVisible(true)
	winMgr:getWindow("sj_wndGame_eventImage"):activeMotion("gameEvent")
end


----------------------------------------------------------

-- 콤보, 데미지

----------------------------------------------------------
function WndGame_ComboAndDamage(deltaTime, isCombo, currentCombo, isAccumulate, accumDamage, 
							teamAttackCount, doubleAttackCount, isTeamAttack, isDoubleAttack, currentAttackCount)
	Common_ComboAndDamage(deltaTime, isCombo, currentCombo, isAccumulate, accumDamage, 
			teamAttackCount, doubleAttackCount, isTeamAttack, isDoubleAttack, currentAttackCount)
end





----------------------------------------------------------

-- 분노모드

----------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_wndGame_strong")
mywindow:setTexture("Enabled", "UIData/Notice_up.tga", 0, 0)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
--mywindow:setAlign(8)
--mywindow:setWideType(6)
mywindow:setPosition(-1500, 250)
mywindow:setSize(589, 152)
mywindow:setVisible(false)
mywindow:addController("strongEffect", "strongEffect", "x", "Sine_EaseIn", -1500, g_GAME_WIN_SIZEX/2-294, 5, true, false, 10)
mywindow:addController("strongEffect", "strongEffect", "x", "Sine_EaseIn", g_GAME_WIN_SIZEX/2-294, g_GAME_WIN_SIZEX/2-294, 15, true, false, 10)
mywindow:addController("strongEffect", "strongEffect", "alpha", "Sine_EaseInOut", 255,255, 25, true, false, 10)
--mywindow:addController("strongEffect", "strongEffect", "alpha", "Sine_EaseInOut", 255,0 , 2, true, false, 10)
--mywindow:addController("strongEffect", "strongEffect", "alpha", "Sine_EaseInOut", 0, 255, 2, true, false, 10)
--mywindow:addController("strongEffect", "strongEffect", "alpha", "Sine_EaseInOut", 255,0 , 2, true, false, 10)
--mywindow:addController("strongEffect", "strongEffect", "alpha", "Sine_EaseInOut", 0, 255, 2, true, false, 10)
--mywindow:addController("strongEffect", "strongEffect", "alpha", "Sine_EaseInOut", 255,0 , 2, true, false, 10)
--mywindow:addController("strongEffect", "strongEffect", "alpha", "Sine_EaseInOut", 0, 255, 2, true, false, 10)
--mywindow:addController("strongEffect", "strongEffect", "alpha", "Sine_EaseInOut", 255,0 , 2, true, false, 10)
--mywindow:addController("strongEffect", "strongEffect", "alpha", "Sine_EaseInOut", 0, 255, 2, true, false, 10)
mywindow:addController("strongEffect", "strongEffect", "x", "Sine_EaseIn", g_GAME_WIN_SIZEX/2-294, 2000, 5, true, false, 10)
root:addChildWindow(mywindow)

tCount = {["err"]=0, 0, 75, 150, 225, 300}
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_wndGame_strongCount")
mywindow:setTexture("Enabled", "UIData/Notice_up.tga", 300, 923)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
--mywindow:setAlign(8)
mywindow:setWideType(6)
mywindow:setPosition(474, 500)
mywindow:setSize(75, 101)
mywindow:setVisible(false)
root:addChildWindow(mywindow)

function StartStrongMode()
	winMgr:getWindow('sj_wndGame_strong'):setTexture("Enabled", "UIData/Notice_up.tga", 0, 0)
	winMgr:getWindow('sj_wndGame_strong'):setPosition(-1500, 250)
	--winMgr:getWindow('sj_wndGame_strong'):clearActiveController()
	winMgr:getWindow('sj_wndGame_strong'):activeMotion('strongEffect')
	winMgr:getWindow('sj_wndGame_strong'):setVisible(true)
end

function EndStrongMode()
	winMgr:getWindow('sj_wndGame_strong'):setTexture("Enabled", "UIData/Notice_up.tga", 0, 152)
	winMgr:getWindow('sj_wndGame_strong'):setPosition(-1500, 250)
	winMgr:getWindow('sj_wndGame_strong'):clearActiveController()
	winMgr:getWindow('sj_wndGame_strong'):activeMotion('strongEffect')
	winMgr:getWindow('sj_wndGame_strong'):setVisible(true)
end


function CountStrongMode(count)
	
	if count > 0 then
		winMgr:getWindow('sj_wndGame_strongCount'):setTexture("Enabled", "UIData/Notice_up.tga", tCount[count], 923)
		winMgr:getWindow('sj_wndGame_strongCount'):setVisible(true)
	else
		winMgr:getWindow('sj_wndGame_strongCount'):setVisible(false)
	end
end




----------------------------------------------------

-- 아이템

----------------------------------------------------

-- 아이템 슬롯 바탕이미지 그리기

local ITEMSLOT_0	= 92
local ITEMSLOT_1	= 143
local ITEMSCALE_0	= 150
local ITEMSCALE_1	= 150
local g_itemSlotX_0 = ITEMSLOT_0
local g_itemSlotX_1 = ITEMSLOT_1
local g_itemScale_0 = ITEMSCALE_0
local g_itemScale_1 = ITEMSCALE_1
local g_itemSlotX_2 = 220
local g_itemSlotY	= 73
local g_itemEffectSlotX_0 = ITEMSLOT_0
local g_itemEffectSlotX_1 = ITEMSLOT_1
function WndGame_RenderStartItemSlot(bSlot0, bSlot1, bSlot2)

	drawer:drawTexture("UIData/mainBG_button004.tga", 75, 55, 85, 35, 0, 331)
	--[[
	if bSlot0 == 1 then
		drawer:drawTextureWithScale_Angle_Offset("UIData/GameNewImage.tga", g_itemSlotX_0, g_itemSlotY, 49, 51, 550, 104, 
														g_itemScale_0, g_itemScale_0, 255, 0, 8, 100, 0)
	else
		drawer:drawTextureWithScale_Angle_Offset("UIData/GameNewImage.tga", g_itemSlotX_0, g_itemSlotY, 49, 51, 604, 104, 
														g_itemScale_0, g_itemScale_0, 255, 0, 8, 100, 0)
	end
	
	if bSlot1 == 1 then
		drawer:drawTextureWithScale_Angle_Offset("UIData/GameNewImage.tga", g_itemSlotX_1, g_itemSlotY, 49, 51, 550, 104, 
														g_itemScale_1, g_itemScale_1, 255, 0, 8, 0, 0)
	else
		drawer:drawTextureWithScale_Angle_Offset("UIData/GameNewImage.tga", g_itemSlotX_1, g_itemSlotY, 49, 51, 604, 104, 
														g_itemScale_1, g_itemScale_1, 255, 0, 8, 0, 0)
	end
	--]]
	--[[
	if bSlot2 == 1 then
		drawer:drawTexture("UIData/GameNewImage.tga", g_itemSlotX_2, g_itemSlotY, 49, 51, 550, 104)
	else
		drawer:drawTexture("UIData/GameNewImage.tga", g_itemSlotX_2, g_itemSlotY, 49, 51, 604, 104)
	end
	--]]
end




-- 아이템 그리기
function WndGame_RenderItem(bChanged, itemType_0, itemType_1, tick, CHANGED_TICK)

	if CHANGED_TICK == 0 then
		return
	end
	
	-- 슬롯을 변경할 경우
	if bChanged == 1 then
		local spacing = 60 / CHANGED_TICK
		
		-- 슬롯 0번째
		if g_itemSlotX_0 + (tick * spacing) >= ITEMSLOT_1 then
			g_itemSlotX_0 = ITEMSLOT_1
			g_itemScale_0 = ITEMSCALE_1
		else
			g_itemSlotX_0 = g_itemSlotX_0 + (tick * spacing)
			g_itemScale_0 = g_itemScale_0 - (tick * spacing)
		end
			
		-- 슬롯 1번째
		if g_itemSlotX_1 - (tick * spacing) <= ITEMSLOT_0 then
			g_itemSlotX_1 = ITEMSLOT_0
			g_itemScale_1 = ITEMSCALE_0
		else
			g_itemSlotX_1 = g_itemSlotX_1 - (tick * spacing)
			g_itemScale_1 = g_itemScale_1 + (tick * spacing)
		end
		
		g_itemEffectSlotX_0 = g_itemSlotX_0
		g_itemEffectSlotX_1 = g_itemSlotX_1
		
	else
		-- 슬롯 변경이 완료되거나, 변경하지 않을 경우 원래 위치로 그려준다.
		g_itemSlotX_0 = ITEMSLOT_0
		g_itemSlotX_1 = ITEMSLOT_1
		
		g_itemScale_0 = ITEMSCALE_0
		g_itemScale_1 = ITEMSCALE_1
		
	end
	
	
	-- 아이템 그리기
	if itemType_0 >= 0 then
		drawer:drawTextureWithScale_Angle_Offset("UIData/GameSlotItem.tga", g_itemSlotX_0, g_itemSlotY, 43, 44, itemType_0*47, 0,
														g_itemScale_0, g_itemScale_0, 255, 0, 8, 100, 0)
	end
	
	if itemType_1 >= 0 then
		drawer:drawTextureWithScale_Angle_Offset("UIData/GameSlotItem.tga", g_itemSlotX_1, g_itemSlotY, 43, 44, itemType_1*47, 0,
														g_itemScale_1, g_itemScale_1, 255, 0, 8, 0, 0)
	end	
end



-- 아이템 먹었을 때 효과 그리기
function WndGame_RenderEffectGetItem(slot, state)

	local itemPosX = 0
	if slot == 0 then
		itemPosX = g_itemEffectSlotX_0
		drawer:drawTextureWithScale_Angle_Offset("UIData/GameNewImage.tga", ITEMSLOT_0, g_itemSlotY, 41, 45, 554+(state*46), 162,
														ITEMSCALE_0, ITEMSCALE_0, 255, 0, 8, 100, 0)
	elseif slot == 1 then
		itemPosX = g_itemEffectSlotX_1
		drawer:drawTextureWithScale_Angle_Offset("UIData/GameNewImage.tga", ITEMSLOT_1, g_itemSlotY, 41, 45, 554+(state*46), 162,
														ITEMSCALE_1, ITEMSCALE_1, 255, 0, 8, 100, 0)
	end	
end



-- 평소때, 슬롯변경이 완료되었을 경우 위치 초기화
function WndGame_InitEffectGetItem()

	g_itemEffectSlotX_0 = ITEMSLOT_0
	g_itemEffectSlotX_1 = ITEMSLOT_1

end



-- 아이템 선택 이미지(현재는 0번슬롯 테두리)
function WndGame_RenderEndItemSlot()

	--drawer:drawTextureWithScale_Angle_Offset("UIData/GameNewImage.tga", ITEMSLOT_0, g_itemSlotY, 57, 59, 658, 100,
	--													330, 330, 255, 0, 8, 100, 0)
end


-- 아이템 체인지 가능한 수
function WndGame_RenderSlotChangeCount(slotChangeCount)
	-- shift 이미지
	--drawer:drawTexture("UIData/GameNewImage.tga", 164, g_itemSlotY-28, 49, 37, 611, 0)
	drawer:drawTexture("UIData/GameSlotItem.tga", 100, g_itemSlotY+15, 10, 11, 15, 261)	-- X
	DrawEachNumber("UIData/GameSlotItem.tga", slotChangeCount, 1, 110, g_itemSlotY+16, 28, 261, 12, 14, 15)
end



-- 아이템을 사용했을 때 보여주기
function WndGame_ItemUseEffect(type, tick)

	local alpha
	if 0 <= tick and tick <= 60 then
		alpha = 255
	elseif 60 < tick and tick < 89 then
		alpha = 255 - ((tick-60)*8)
	elseif tick <= 90 then
		alpha = 0
	end
	
	local y = 200
	
	-- 사용할 때 주변효과 그리기
	if tick <= 20 then
		local _tick = tick/5
		if _tick == 0 then
			drawer:drawTextureWithScale_Angle_Offset("UIData/GameSlotItem.tga", 516, y, 47, 49, 60, 139, 510, 510, alpha, 0, 8, 100, 0, WIDETYPE_5)
		elseif _tick == 1 then
			drawer:drawTextureWithScale_Angle_Offset("UIData/GameSlotItem.tga", 516, y, 71, 73, 110, 127, 510, 510, alpha, 0, 8, 100, 0, WIDETYPE_5)
		elseif _tick == 2 then
			drawer:drawTextureWithScale_Angle_Offset("UIData/GameSlotItem.tga", 519, y, 107, 109, 179, 109, 510, 510, alpha, 0, 8, 100, 0, WIDETYPE_5)
		elseif _tick == 3 then
			drawer:drawTextureWithScale_Angle_Offset("UIData/GameSlotItem.tga", 516, y, 39, 41, 296, 141, 510, 510, alpha, 0, 8, 100, 0, WIDETYPE_5)
		end
	end
	
	-- 사용되는 아이템 그리기
	drawer:drawTextureWithScale_Angle_Offset("UIData/GameSlotItem.tga", 516, y, 43, 44, type*47, 0,
														350, 350, alpha, 0, 8, 100, 0, WIDETYPE_5)
	
	-- 사용되는 아이템 이름
	drawer:drawTextureA("UIData/GameSlotItem.tga", 450, y+30, 128, 19, 399, 142+(type*19), alpha, WIDETYPE_5)
end



-- 아이템 누가 사용했는지 표시하기
--[[
local MAX_ITEM_USED = WndGame_MaxItemUsed()
for i=0, MAX_ITEM_USED-1 do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_wndGame_ItemUsed_backImage_"..i)
	mywindow:setTexture("Enabled", "UIData/numberUi001.tga", 548, 418)
	mywindow:setTexture("Disabled", "UIData/numberUi001.tga", 548, 418)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(840, 526+(i*33))
	mywindow:setSize(154, 32)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	root:addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_wndGame_ItemUsed_itemImage_"..i)
	mywindow:setTexture("Enabled", "UIData/GameSlotItem.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/GameSlotItem.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(5, 5)
	mywindow:setSize(43, 44)
	mywindow:setScaleWidth(128)
	mywindow:setScaleHeight(128)
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(false)
	winMgr:getWindow("sj_wndGame_ItemUsed_backImage_"..i):addChildWindow(mywindow)

	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_wndGame_ItemUsed_characterName_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setText("")
	mywindow:setPosition(32, 6)
	mywindow:setSize(100, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_wndGame_ItemUsed_backImage_"..i):addChildWindow(mywindow)
end


function WndGame_InitItemUsedEffect()
	for i=0, MAX_ITEM_USED-1 do
		winMgr:getWindow("sj_wndGame_ItemUsed_backImage_"..i):setVisible(false)
	end
end


function WndGame_ItemUsedEffect(count, itemType, characterName, team)
	winMgr:getWindow("sj_wndGame_ItemUsed_backImage_"..count):setVisible(true)
	
	winMgr:getWindow("sj_wndGame_ItemUsed_itemImage_"..count):setTexture("Enabled", "UIData/GameSlotItem.tga", itemType*47, 0)
	winMgr:getWindow("sj_wndGame_ItemUsed_itemImage_"..count):setTexture("Disabled", "UIData/GameSlotItem.tga", itemType*47, 0)
	winMgr:getWindow("sj_wndGame_ItemUsed_itemImage_"..count):setScaleWidth(128)
	winMgr:getWindow("sj_wndGame_ItemUsed_itemImage_"..count):setScaleHeight(128)
	
	if team == 0 then
		winMgr:getWindow("sj_wndGame_ItemUsed_characterName_"..count):setTextColor(254, 87, 87, 255)
	elseif team == 1 then
		winMgr:getWindow("sj_wndGame_ItemUsed_characterName_"..count):setTextColor(97, 161, 240, 255)
	end
	winMgr:getWindow("sj_wndGame_ItemUsed_characterName_"..count):setText(characterName)
end
--]]




----------------------------------------------------

-- 속성 아이템

----------------------------------------------------
local tItemDescEnum = {["err"]=0, [0]=LAN_CLUBWAR_PLAY_ITEMEX1_SHIELD, LAN_CLUBWAR_PLAY_ITEMEX2_PWUP, LAN_CLUBWAR_PLAY_ITEMEX3_BLOW,
					LAN_CLUBWAR_PLAY_ITEMEX4_RECOVER, LAN_CLUBWAR_PLAY_ITEMEX5_METEO, LAN_CLUBWAR_PLAY_ITEMEX5_TOWER}

-- 아이템 그리기
function WndGame_RenderPropertyItem(itemType, myHP, myDiedTime)

	-- 아이템 그리기
	if myHP <= 0 then
		if myDiedTime > 0 then
			drawer:drawTexture("UIData/fightClub_005.tga", 100, 64, 167, 62, 705, 0)			
		else
			drawer:drawTexture("UIData/fightClub_005.tga", 100, 64, 60, 62, 541, 0)
			drawer:drawTexture("UIData/fightClub_005.tga", 164, 64, 104, 62, 601, 0)
		end
	end
	
	drawer:drawTexture("UIData/fightClub_005.tga", 100, 64, 60, 62, 541, 0)
	drawer:drawTexture("UIData/fightClub_005.tga", 164, 64, 104, 62, 601, 0)
	
	if itemType >= 0 then
		drawer:drawTexture("UIData/fightClub_005.tga", 103, 67, 54, 56, 510, tPropertyItemTexY[itemType])
		
		-- 아이템 설명
		drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
		drawer:setTextColor(255,255,255,255)
		local szItemDesc = GetSStringInfo(tItemDescEnum[itemType])
		DebugStr('GetSStringInfo를 실행하고 있습니다'..tItemDescEnum[itemType])
		drawer:drawText(szItemDesc, 169, 68)
	end
end




----------------------------------------------------------

-- 게임중 어드밴티지 적용효과

----------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "WndGame_EffectAdvantage")
mywindow:setTexture("Enabled", "UIData/LobbyImage_new002.tga", 838, 108)
mywindow:setTexture("Disabled", "UIData/LobbyImage_new002.tga", 838, 108)
mywindow:setPosition(474, 220)
mywindow:setSize(84, 42)
mywindow:setEnabled(false)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
mywindow:setAlign(8)
mywindow:addController("effectAdvantage", "effectAdvantage", "alpha", "Sine_EaseInOut", 0, 255, 2, true, false, 10)
mywindow:addController("effectAdvantage", "effectAdvantage", "xscale", "Quintic_EaseIn", 0, 1024, 2, true, false, 10)
mywindow:addController("effectAdvantage", "effectAdvantage", "yscale", "Quintic_EaseIn", 0, 1024, 2, true, false, 10)
mywindow:addController("effectAdvantage", "effectAdvantage", "xscale", "Quintic_EaseIn", 1024, 400, 2, true, false, 10)
mywindow:addController("effectAdvantage", "effectAdvantage", "yscale", "Quintic_EaseIn", 1024, 400, 2, true, false, 10)
mywindow:addController("effectAdvantage", "effectAdvantage", "xscale", "Quintic_EaseIn", 400, 400, 11, true, false, 10)
mywindow:addController("effectAdvantage", "effectAdvantage", "yscale", "Quintic_EaseIn", 400, 400, 11, true, false, 10)
mywindow:addController("effectAdvantage", "effectAdvantage", "xscale", "Sine_EaseIn", 400, 255, 3, true, false, 10)
mywindow:addController("effectAdvantage", "effectAdvantage", "yscale", "Sine_EaseIn", 400, 255, 3, true, false, 10)
mywindow:addController("effectAdvantage", "effectAdvantage", "x", "Sine_EaseIn", g_GAME_WIN_SIZEX/2-40, g_GAME_WIN_SIZEX/2-40, 15, true, false, 10)
mywindow:addController("effectAdvantage", "effectAdvantage", "x", "Sine_EaseIn", g_GAME_WIN_SIZEX/2-40, 2, 3, true, false, 10)
mywindow:addController("effectAdvantage", "effectAdvantage", "y", "Sine_EaseIn", 220, 220, 15, true, false, 10)
mywindow:addController("effectAdvantage", "effectAdvantage", "y", "Sine_EaseIn", 220, 90, 3, true, false, 10)
--mywindow:addController("effectAdvantage", "effectAdvantage", "alpha", "Sine_EaseInOut", 255, 255, 18, true, false, 10)
--mywindow:addController("effectAdvantage", "effectAdvantage", "alpha", "Sine_EaseInOut", 255, 0, 2, true, true, 10)
--mywindow:addController("effectAdvantage", "effectAdvantage", "alpha", "Sine_EaseInOut", 0, 255, 2, true, true, 10)
root:addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/StaticImage", "WndGame_notifyAdvantage")
mywindow:setTexture("Enabled", "UIData/LobbyImage_new002.tga", 0, 589)
mywindow:setTexture("Disabled", "UIData/LobbyImage_new002.tga", 0, 589)
mywindow:setWideType(5)
mywindow:setPosition(170, 150)
mywindow:setSize(684, 46)
mywindow:setEnabled(false)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
mywindow:addController("notifyAdvantage", "notifyAdvantage", "alpha", "Sine_EaseInOut", 0, 255, 3, true, false, 10)
mywindow:addController("notifyAdvantage", "notifyAdvantage", "alpha", "Sine_EaseInOut", 255, 255, 14, true, false, 10)
mywindow:addController("notifyAdvantage", "notifyAdvantage", "alpha", "Sine_EaseInOut", 255, 0, 3, true, false, 10)
root:addChildWindow(mywindow)

function WndGame_ShowAdvantage(advantage)
	winMgr:getWindow("WndGame_notifyAdvantage"):setVisible(true)	
	winMgr:getWindow("WndGame_EffectAdvantage"):setVisible(true)
	
	if advantage == 30 then
		winMgr:getWindow("WndGame_notifyAdvantage"):setTexture("Enabled", "UIData/LobbyImage_new002.tga", 0, 589)
		winMgr:getWindow("WndGame_notifyAdvantage"):setTexture("Disabled", "UIData/LobbyImage_new002.tga", 0, 589)
		winMgr:getWindow("WndGame_EffectAdvantage"):setTexture("Enabled", "UIData/LobbyImage_new002.tga", 838, 108)
		winMgr:getWindow("WndGame_EffectAdvantage"):setTexture("Disabled", "UIData/LobbyImage_new002.tga", 838, 108)
	elseif advantage == 60 then
		winMgr:getWindow("WndGame_notifyAdvantage"):setTexture("Enabled", "UIData/LobbyImage_new002.tga", 0, 635)
		winMgr:getWindow("WndGame_notifyAdvantage"):setTexture("Disabled", "UIData/LobbyImage_new002.tga", 0, 635)
		winMgr:getWindow("WndGame_EffectAdvantage"):setTexture("Enabled", "UIData/LobbyImage_new002.tga", 838, 150)
		winMgr:getWindow("WndGame_EffectAdvantage"):setTexture("Disabled", "UIData/LobbyImage_new002.tga", 838, 150)
	elseif advantage == 90 then
		winMgr:getWindow("WndGame_notifyAdvantage"):setTexture("Enabled", "UIData/LobbyImage_new002.tga", 0, 681)
		winMgr:getWindow("WndGame_notifyAdvantage"):setTexture("Disabled", "UIData/LobbyImage_new002.tga", 0, 681)
		winMgr:getWindow("WndGame_EffectAdvantage"):setTexture("Enabled", "UIData/LobbyImage_new002.tga", 838, 192)
		winMgr:getWindow("WndGame_EffectAdvantage"):setTexture("Disabled", "UIData/LobbyImage_new002.tga", 838, 192)
	end
	
	winMgr:getWindow("WndGame_notifyAdvantage"):activeMotion("notifyAdvantage")
	winMgr:getWindow("WndGame_EffectAdvantage"):activeMotion("effectAdvantage")
end



----------------------------------------------------------

-- 게임이 더이상 진행 불가능 하다는 알림

----------------------------------------------------------
function WndGame_ShowNotifyEscape()
	winMgr:getWindow("WndGame_notifyAdvantage"):setVisible(true)
	winMgr:getWindow("WndGame_notifyAdvantage"):setTexture("Enabled", "UIData/LobbyImage_new002.tga", 0, 543)
	winMgr:getWindow("WndGame_notifyAdvantage"):setTexture("Disabled", "UIData/LobbyImage_new002.tga", 0, 543)
	winMgr:getWindow("WndGame_notifyAdvantage"):activeMotion("notifyAdvantage")
	
end



----------------------------------------------------------

-- 게임오버 그리기

----------------------------------------------------------
local g_gameoverSound = true
local tBlackImage = { ["err"]=0, -85 }
function WndGame_RenderGameOver(deltaTime)
	
	-- GAMEOVER 이미지
	if tBlackImage[1] >= 300 then
		tBlackImage[1] = 300
		drawer:drawTexture("UIData/GameNewImage2.tga", 189, tBlackImage[1], 650, 77, 11, 590, WIDETYPE_5)
	else
		tBlackImage[1] = tBlackImage[1] + (deltaTime/2)
		drawer:drawTexture("UIData/GameNewImage2.tga", 189, tBlackImage[1], 650, 77, 11, 590, WIDETYPE_5)
		
		if g_gameoverSound then
			g_gameoverSound = false
			PlaySound('sound/System/System_GAMEOVER.wav')
		end
	end
end




----------------------------------------------------------

-- E 필살기 제외 알려주기

----------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_wndGame_NotifyExceptE")
mywindow:setTexture("Enabled", "UIData/LobbyImage_new.tga", 998, 369)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setWideType(5);
mywindow:setPosition(494, 226)
mywindow:setSize(26, 26)
mywindow:setVisible(false)
root:addChildWindow(mywindow)

function WndGame_ShowExceptE()
	winMgr:getWindow("sj_wndGame_NotifyExceptE"):setVisible(true)
	winMgr:getWindow("sj_wndGame_NotifyExceptE"):setScaleWidth(400)
	winMgr:getWindow("sj_wndGame_NotifyExceptE"):setScaleHeight(400)
	winMgr:getWindow("sj_wndGame_NotifyExceptE"):clearControllerEvent("notifyExceptE")
	winMgr:getWindow("sj_wndGame_NotifyExceptE"):addController("notifyExceptE", "notifyExceptE", "alpha", "Sine_EaseInOut", 255, 0, 10, false, false, 10)
	winMgr:getWindow("sj_wndGame_NotifyExceptE"):activeMotion("notifyExceptE")
end

function WndGame_HideExceptE()
	winMgr:getWindow("sj_wndGame_NotifyExceptE"):setVisible(false)
end

-- 15초후 채팅 초기화
local tShowText		 = { ["err"]=0 }
local tShowTextColor = { ["err"]=0 }
local tShowTextType  = { ["err"]=0 }

function WndGame_ClearChatting()

	for i=1, table.getn(tShowText) do
		table.remove(tShowText,  i)		-- 채팅내용
		table.remove(tShowTextColor, i)	-- 채팅색상
		table.remove(tShowTextType, i)	-- 채팅타입
		
	end
	
end


-- 게임중 채팅내용 저장
function GetUserChat()
	for i=1, table.getn(tShowText) do
		WndGame_UserChattingSave(tShowText[i], tShowTextColor[i])
	end
end






------------------------------------------------

--	말풍선 그리기

------------------------------------------------
function WndGame_OnDrawBoolean(str_chat, px, py, chatBubbleType)
	
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
	local posX	 = 0		-- 말풍선 x위치
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






--[[
----------------------------------------------------

-- Last 3

----------------------------------------------------
tLast3 = { ["protectErr"]=0, -425 }
function WndGame_RenderLast3(deltaTime, effect, section)
	if section == 0 then
		if tLast3[1] >= 330 then
			tLast3[1] = 330
		else
			tLast3[1] = tLast3[1] + deltaTime*2
		end
	elseif section == 1 then
		tLast3[1] = 330
	else
		tLast3[1] = tLast3[1] + deltaTime*2
	end
	
	if effect == 0 then
		drawer:drawTexture("UIData/GameImage_new.tga", tLast3[1], 270, 91, 88, 599, 676)
	else
		drawer:drawTexture("UIData/GameImage_new.tga", tLast3[1], 270, 91, 88, 599, 764)
	end
	
	drawer:drawTexture("UIData/GameImage_new.tga", tLast3[1]+91, 270, 334, 88, 690, 764)
end



----------------------------------------------------

-- Last 1

----------------------------------------------------
tLast1 = { ["protectErr"]=0, -425 }
function WndGame_RenderLast1(deltaTime, effect, section)
	if section == 0 then
		if tLast1[1] >= 330 then
			tLast1[1] = 330
		else
			tLast1[1] = tLast1[1] + deltaTime*2
		end
	elseif section == 1 then
		tLast1[1] = 330
	else
		tLast1[1] = tLast1[1] + deltaTime*2
	end
	
	if effect == 0 then
		drawer:drawTexture("UIData/GameImage_new.tga", tLast1[1], 270, 91, 88, 599, 676)
	else
		drawer:drawTexture("UIData/GameImage_new.tga", tLast1[1], 270, 91, 88, 599, 764)
	end
	
	drawer:drawTexture("UIData/GameImage_new.tga", tLast1[1]+91, 270, 334, 88, 690, 676)
end
--]]





----------------------------------------------------

-- Last 1분

----------------------------------------------------
local g_last1MinEffect  = 0
local g_last1MinTime	= 0
local g_last1Min		= true
local g_last1MinPos		= 0
local g_last1MinSound	= true

function WndGame_InitLast1MinData()
	g_last1MinEffect= 0
	g_last1MinTime	= 0
	g_last1Min		= true
	g_last1MinPos	= 0
	g_last1MinSound	= true
end

function WndGame_RenderLast1Min(deltaTime)

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
		EndLast1Min()
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

function WndGame_InitLast10SecData()
	g_last10Effect	= 0
	g_last10SecTime	= 0
	g_last10Sec		= true
	g_last10SecPos	= 0
	g_last10SecSound= true
end

function WndGame_RenderLast10Sec(deltaTime)

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
		EndLast10Sec()
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





----------------------------------------------------

-- 플레이어 정보들(베스트 플레이어 정보들)

----------------------------------------------------
local IMAGE_POSX = 211
local IMAGE_POSY = 140
function WndGame_UserBattleInfo_bestPlayer(bMe1, bMe2, bMe3, bMe4, bMe5, bMe6, bMe7, bMe8, 
										attack, grab, doubleAtk, teamAtk, evade, superE, combo, itemUse)

	drawer:setTextColor(255, 255, 255, 255)
	drawer:setFont(g_STRING_FONT_DODUMCHE, 12)
		
	-- 배경
	drawer:drawTexture("UIData/myinfo2.tga", IMAGE_POSX, IMAGE_POSY, 602, 528, 0, 475)
	
	-- 타격짱
	if bMe1 == 1 then	drawer:setTextColor(255, 200, 80, 255)
	else				drawer:setTextColor(255, 255, 255, 255)
	end
	local size = GetStringSize(g_STRING_FONT_DODUMCHE, 112, attack)
	drawer:drawText(attack, IMAGE_POSX+216-size/2, IMAGE_POSY+376)
	
	-- 잡기짱
	if bMe2 == 1 then	drawer:setTextColor(255, 200, 80, 255)
	else				drawer:setTextColor(255, 255, 255, 255)
	end
	size = GetStringSize(g_STRING_FONT_DODUMCHE, 112, grab)
	drawer:drawText(grab, IMAGE_POSX+216-size/2, IMAGE_POSY+406)
	
	-- 더블어택짱
	if bMe3 == 1 then	drawer:setTextColor(255, 200, 80, 255)
	else				drawer:setTextColor(255, 255, 255, 255)
	end
	size = GetStringSize(g_STRING_FONT_DODUMCHE, 112, doubleAtk)
	drawer:drawText(doubleAtk, IMAGE_POSX+216-size/2, IMAGE_POSY+436)
	
	-- 팀어택짱
	if bMe4 == 1 then	drawer:setTextColor(255, 200, 80, 255)
	else				drawer:setTextColor(255, 255, 255, 255)
	end
	size = GetStringSize(g_STRING_FONT_DODUMCHE, 112, teamAtk)
	drawer:drawText(teamAtk, IMAGE_POSX+216-size/2, IMAGE_POSY+466)
	
	-- 반격짱
	if bMe5 == 1 then	drawer:setTextColor(255, 200, 80, 255)
	else				drawer:setTextColor(255, 255, 255, 255)
	end
	size = GetStringSize(g_STRING_FONT_DODUMCHE, 112, evade)
	drawer:drawText(evade, IMAGE_POSX+490-size/2, IMAGE_POSY+376)
	
	-- E필살기짱
	if bMe6 == 1 then	drawer:setTextColor(255, 200, 80, 255)
	else				drawer:setTextColor(255, 255, 255, 255)
	end
	size = GetStringSize(g_STRING_FONT_DODUMCHE, 112, superE)
	drawer:drawText(superE, IMAGE_POSX+490-size/2, IMAGE_POSY+406)
	
	-- 콤보짱
	if bMe7 == 1 then	drawer:setTextColor(255, 200, 80, 255)
	else				drawer:setTextColor(255, 255, 255, 255)
	end
	size = GetStringSize(g_STRING_FONT_DODUMCHE, 112, combo)
	drawer:drawText(combo, IMAGE_POSX+490-size/2, IMAGE_POSY+436)
	
	-- 아이템짱
	if bMe8 == 1 then	drawer:setTextColor(255, 200, 80, 255)
	else				drawer:setTextColor(255, 255, 255, 255)
	end
	size = GetStringSize(g_STRING_FONT_DODUMCHE, 112, itemUse)
	drawer:drawText(itemUse, IMAGE_POSX+490-size/2, IMAGE_POSY+466)
end




----------------------------------------------------

-- 플레이어 정보들(나를 KO시킨 유저 정보들)

----------------------------------------------------
tUserPosY = {["err"]=0, [0]=80, 110, 140, 170, 200, 210, 240, 270}

function WndGame_UserBattleInfo_whoMeDown(index, clubImageName, level, ladder, name, style, koNum, showRevenge, promotion, attribute)
	
	if 0 > index then
		return
	end
	
	if index >= 8 then
		return
	end
	
	drawer:setTextColor(255, 255, 255, 255)
	drawer:setFont(g_STRING_FONT_DODUMCHE, 12)
	
	-- 클럽
	--drawer:drawTexture("UIData/myinfo2.tga", IMAGE_POSX+105, IMAGE_POSY+tUserPosY[index], 24, 24, 689, 475)
	if clubImageName > 0 then
		drawer:drawTextureSA(GetClubDirectory(GetLanguageType())..clubImageName..".tga", IMAGE_POSX+105, IMAGE_POSY+tUserPosY[index], 32, 32, 0, 0, 183, 183, 255, 0, 0)
	end
	-- 레벨
	if index == 0 then
		common_DrawOutlineText1(drawer, "Lv."..level, IMAGE_POSX+149, IMAGE_POSY+tUserPosY[index]+5, 220,0,0,255, 255,255,255,255)
	else	
		drawer:drawText("Lv."..level, IMAGE_POSX+149, IMAGE_POSY+tUserPosY[index]+5)
	end
	
	-- 래더
	drawer:drawTexture("UIData/numberUi001.tga", IMAGE_POSX+190, IMAGE_POSY+tUserPosY[index], 47, 21, 113, 600+21*ladder)
	
	-- 이름	
	if index == 0 then		
		local size = GetStringSize(g_STRING_FONT_DODUMCHE, 112, name)
		common_DrawOutlineText1(drawer, name, IMAGE_POSX+302-size/2, IMAGE_POSY+tUserPosY[index]+5, 220,0,0,255, 255,255,255,255)
	else	
		local size = GetStringSize(g_STRING_FONT_DODUMCHE, 112, name)
		drawer:drawText(name, IMAGE_POSX+302-size/2, IMAGE_POSY+tUserPosY[index]+5)
	end
		
	-- 클래스
	drawer:drawTexture("UIData/Skill_up2.tga", IMAGE_POSX+370, IMAGE_POSY+tUserPosY[index]-10,  89, 35,  tAttributeImgTexXTable[style][attribute], tAttributeImgTexYTable[style][attribute])
	drawer:drawTexture("UIData/Skill_up2.tga", IMAGE_POSX+370, IMAGE_POSY+tUserPosY[index]-10,  89, 35,  promotionImgTexXTable[style], promotionImgTexYTable[promotion])
	
	-- KO당한 횟수
	if index == 0 then
		size = GetStringSize(g_STRING_FONT_DODUMCHE, 112, tostring(koNum))
		common_DrawOutlineText1(drawer, tostring(koNum), IMAGE_POSX+512-size/2, IMAGE_POSY+tUserPosY[index]+5, 220,0,0,255, 255,255,255,255)
	else
		size = GetStringSize(g_STRING_FONT_DODUMCHE, 112, tostring(koNum))
		drawer:drawText(tostring(koNum), IMAGE_POSX+512-size/2, IMAGE_POSY+tUserPosY[index]+5)
	end
	
	if showRevenge == 1 then
		if index == 0 then
			-- 복수대상 이미지
			drawer:drawTexture("UIData/myinfo2.tga", IMAGE_POSX+14, IMAGE_POSY+tUserPosY[index]-3, 86, 27, 602, 475)
		end
	end
end





----------------------------------------------------

-- 도움말

----------------------------------------------------
function WndGame_RenderHelp(bHelp)

	-- 도움말 버튼
	--drawer:drawTexture("UIData/bunhae_002.tga", 274, 5, 110, 27, 0, 82)
	
	-- 도움말 상세정보
	--[[
	if bHelp == 1 then
		drawer:drawTexture("UIData/other001.tga", 4, 132, 565, 306, 0, 0)
	end
	--]]
	
	--[[
	local Y = 220
	local SPACE = 30
	local firstPosX = 800
	killName = "QQQQQQQQQQQQ"
	deadName = "QQQQQQQQQQQQ"
	local killPosX	= GetStringSize(g_STRING_FONT_GULIMCHE, 12, killName)
	local summaryDeadName = GetStringSize(g_STRING_FONT_GULIMCHE, 12, deadName, 70)
	
	drawer:drawTexture("UIData/GameNewImage.tga", firstPosX, Y+SPACE*0, 216, 38, 303, 79, WIDETYPE_1)
	drawer:drawTexture("UIData/GameNewImage.tga", firstPosX, Y+SPACE*1, 216, 38, 303, 79, WIDETYPE_1)
	drawer:drawTexture("UIData/GameNewImage.tga", firstPosX, Y+SPACE*2, 216, 38, 303, 79, WIDETYPE_1)
	drawer:drawTexture("UIData/GameNewImage.tga", firstPosX, Y+SPACE*3, 216, 38, 303, 79, WIDETYPE_1)
	drawer:drawTexture("UIData/GameNewImage.tga", firstPosX, Y+SPACE*4, 216, 38, 303, 79, WIDETYPE_1)

	common_DrawOutlineText1(drawer, killName, firstPosX+76-killPosX, Y+SPACE*0+12, 0,0,0,255, 254,87,87,255, WIDETYPE_1)
	common_DrawOutlineText1(drawer, killName, firstPosX+76-killPosX, Y+SPACE*1+12, 0,0,0,255, 254,87,87,255, WIDETYPE_1)
	common_DrawOutlineText1(drawer, killName, firstPosX+76-killPosX, Y+SPACE*2+12, 0,0,0,255, 254,87,87,255, WIDETYPE_1)
	common_DrawOutlineText1(drawer, killName, firstPosX+76-killPosX, Y+SPACE*3+12, 0,0,0,255, 254,87,87,255, WIDETYPE_1)
	common_DrawOutlineText1(drawer, killName, firstPosX+76-killPosX, Y+SPACE*4+12, 0,0,0,255, 254,87,87,255, WIDETYPE_1)

	common_DrawOutlineText1(drawer, deadName, firstPosX+138, Y+SPACE*0+12, 0,0,0,255, 97,161,240,255, WIDETYPE_1)
	common_DrawOutlineText1(drawer, deadName, firstPosX+138, Y+SPACE*1+12, 0,0,0,255, 97,161,240,255, WIDETYPE_1)
	common_DrawOutlineText1(drawer, deadName, firstPosX+138, Y+SPACE*2+12, 0,0,0,255, 97,161,240,255, WIDETYPE_1)
	common_DrawOutlineText1(drawer, deadName, firstPosX+138, Y+SPACE*3+12, 0,0,0,255, 97,161,240,255, WIDETYPE_1)
	common_DrawOutlineText1(drawer, deadName, firstPosX+138, Y+SPACE*4+12, 0,0,0,255, 97,161,240,255, WIDETYPE_1)
	--]]
end





----------------------------------------------------

-- 웨폰 주울수 있는지 알려주기

----------------------------------------------------
function WndGame_NotifyPickupWeapon(weaponIndex, weaponPosX, weaponPosY)
	if weaponIndex >= 0 then
		drawer:drawTexture("UIData/GameNewImage.tga", weaponPosX-40, weaponPosY-80, 84, 62, 474, 883)
	end
end


----------------------------------------------------

-- 속성 아이템 주울수 있는지 알려주기

----------------------------------------------------
function WndGame_NotifyPickupPropertyItem(weaponIndex, weaponPosX, weaponPosY)
	drawer:drawTexture("UIData/GameNewImage.tga", weaponPosX-40, weaponPosY-130, 84, 62, 474, 883)
end



----------------------------------------------------

-- 대전시간 연장 알리미

----------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_game_battletimeExtendNotify")
mywindow:setTexture("Enabled", "UIData/GameNewImage2.tga", 841, 136)
mywindow:setTexture("Disabled", "UIData/GameNewImage2.tga", 841, 136)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(5);
mywindow:setPosition(431, 60)
mywindow:setSize(183, 101)
mywindow:setZOrderingEnabled(false)
mywindow:setEnabled(false)
mywindow:setVisible(false)
mywindow:setAlign(8);
root:addChildWindow(mywindow)

-- 대전시간 연장 아이템이 있는 유저만 보임
function SetBattletimeExtendAction(bVisible)
	local mywindow = winMgr:getWindow("sj_game_battletimeExtendNotify")
	if mywindow then
		mywindow:setVisible(bVisible)
		if bVisible then
			mywindow:addController("notifyController", "notifyAction", "xscale", "Elastic_EaseOut", 1, 260, 9, true, true, 10)
			mywindow:addController("notifyController", "notifyAction", "yscale", "Elastic_EaseOut", 1, 260, 9, true, true, 10)
			mywindow:activeMotion("notifyAction")
		else
			mywindow:clearControllerEvent("notifyAction")
			mywindow:clearActiveController()
		end
	end	
end

local BT_EXTEND_STATE_IN = 0
local BT_EXTEND_STATE_NOTIFY = 1
local BT_EXTEND_STATE_OUT = 2
local BT_EXTEND_STATE_END = 3
local g_battleTimeExtendState = BT_EXTEND_STATE_END
local g_battleTimeExtendPosX = -1100
local g_battletimeExtendTime = 0

-- 대전시간 연장을 사용할 경우
function SetBattleTimeExtendNotify()
	g_battleTimeExtendState = BT_EXTEND_STATE_IN
	g_battleTimeExtendPosX = -1100
	g_battletimeExtendTime = 0
end

-- 누군가 대전시간 연장 아이템을 사용할 경우 모든 캐릭터에게 알려준다.
function ShowBattleTimeExtendNotify(deltaTime, notifyMsg)

	-- 왼쪽에서 나온다.
	if g_battleTimeExtendState == BT_EXTEND_STATE_IN then
		g_battleTimeExtendPosX = g_battleTimeExtendPosX + (deltaTime * 3)
		if g_battleTimeExtendPosX >= 0 then
			g_battleTimeExtendPosX = 0
			g_battleTimeExtendState = BT_EXTEND_STATE_NOTIFY
		end
	
	-- 가운데서 알려준다.
	elseif g_battleTimeExtendState == BT_EXTEND_STATE_NOTIFY then
		g_battletimeExtendTime = g_battletimeExtendTime + deltaTime
		if g_battletimeExtendTime >= 5000 then
			g_battletimeExtendTime = 5000
			g_battleTimeExtendState = BT_EXTEND_STATE_OUT
		end
	
	-- 오른쪽으로 들어간다.
	elseif g_battleTimeExtendState == BT_EXTEND_STATE_OUT then
		g_battleTimeExtendPosX = g_battleTimeExtendPosX + (deltaTime * 3)
		if g_battleTimeExtendPosX >= 1100 then
			g_battleTimeExtendPosX = 1100
			g_battleTimeExtendState = BT_EXTEND_STATE_END
		end
		
	-- 끝
	elseif g_battleTimeExtendState == BT_EXTEND_STATE_END then
		return
	end
	
	drawer:drawTexture("UIData/GameNewImage2.tga", g_battleTimeExtendPosX, 200, 1024, 112, 0, 803, WIDETYPE_5)
	
	drawer:setTextColor(255, 255, 255, 255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 22)
	local msgSize = GetStringSize(g_STRING_FONT_GULIMCHE, 22, notifyMsg)
	
	local visibleTime = g_battletimeExtendTime % 200
	if visibleTime < 100 then
		drawer:drawText(notifyMsg, g_battleTimeExtendPosX+512-msgSize/2, 246, WIDETYPE_5)
	end
	
end




----------------------------------------------------

-- 디버그

----------------------------------------------------
function WndGame_Debug(i, count, hp, name, myIndex)
					
--	drawer:setTextColor(255, 255, 0, 255)
--	drawer:setFont(g_STRING_FONT_GULIMCHE, 14)
--	drawer:drawText(i.." : "..name, 280, 100+(count*18))
	
--	if i == myIndex then
--		drawer:drawText("myIndex : "..myIndex, 430, 100+(count*18))
--	end
--	DrawEachNumber("UIData/dungeonmsg.tga", hp, 1, 380, 100+(count*18), 516, 224, 12, 14, 15)
end



-- 디버그 2
function WndGame_Debug2(i, name, atkDamage, grabDamage, superEDamage, doubleAtkCount, teamAtkCount, evadeCount, comboCount, itemUseCount, whoMeDown)
	drawer:setTextColor(255, 255, 0, 255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	--[[
	local TEX_X = 190
	local TEX_Y = 660
	local text = "닉네임         타격     잡기    E필살기    더블어택    팀어택    반격    콤보    아템사용    나를KO횟수"
	drawer:drawText(text, TEX_X, TEX_Y-20)
	
	drawer:drawText(tostring(name), TEX_X, TEX_Y+i*15)
	drawer:drawText(tostring(atkDamage), TEX_X+90, TEX_Y+i*15)
	drawer:drawText(tostring(grabDamage), TEX_X+146, TEX_Y+i*15)
	drawer:drawText(tostring(superEDamage), TEX_X+193, TEX_Y+i*15)
	drawer:drawText(tostring(doubleAtkCount), TEX_X+260, TEX_Y+i*15)
	drawer:drawText(tostring(teamAtkCount), TEX_X+332, TEX_Y+i*15)
	drawer:drawText(tostring(evadeCount), TEX_X+392, TEX_Y+i*15)
	drawer:drawText(tostring(comboCount), TEX_X+440, TEX_Y+i*15)
	drawer:drawText(tostring(itemUseCount), TEX_X+488, TEX_Y+i*15)
	drawer:drawText(tostring(whoMeDown), TEX_X+560, TEX_Y+i*15)
	--]]
end





function WndGame_ShowEmblemKey(LeftEmblem, RightEmblem)
	if LeftEmblem > 0 then 
		drawer:drawTextureSA(GetClubDirectory(GetLanguageType())..LeftEmblem..".tga", 310 , 12, 32, 32, 0, 0, 350, 350, 255, 0, 0, WIDETYPE_5)
		--DebugStr('LeftEmblem:'..LeftEmblem)
	end
	
	if RightEmblem > 0 then
		drawer:drawTextureSA(GetClubDirectory(GetLanguageType())..RightEmblem..".tga", 670 , 12 , 32, 32, 0, 0, 350, 350, 255, 0, 0, WIDETYPE_5)
		--DebugStr('RightEmblem:'..RightEmblem)
	end
end





----------------------------------------------------

-- 게임 종료창

----------------------------------------------------
quitwindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_WndGame_exitBackWindow")
quitwindow:setTexture("Enabled", "UIData/LobbyImage_new002.tga", 515, 311)
quitwindow:setTexture("Disabled", "UIData/LobbyImage_new002.tga", 515, 311)
quitwindow:setProperty("FrameEnabled", "False")
quitwindow:setProperty("BackgroundEnabled", "False")
quitwindow:setWideType(5)
quitwindow:setPosition(342, 314)
quitwindow:setSize(340, 141)
quitwindow:setAlpha(0)
quitwindow:setZOrderingEnabled(true)
quitwindow:setVisible(false)
root:addChildWindow(quitwindow)

mywindow = winMgr:createWindow("TaharezLook/Button", "sj_WndGame_exitOkBtn")
mywindow:setTexture("Normal", "UIData/LobbyImage_new002.tga", 838, 0)
mywindow:setTexture("Hover", "UIData/LobbyImage_new002.tga", 838, 27)
mywindow:setTexture("Pushed", "UIData/LobbyImage_new002.tga", 838, 54)
mywindow:setTexture("PushedOff", "UIData/LobbyImage_new002.tga", 839, 0)
mywindow:setPosition(50, 100)
mywindow:setSize(90, 27)
mywindow:setAlpha(0)
mywindow:subscribeEvent("Clicked", "WndGame_QuitOK")
quitwindow:addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/Button", "sj_WndGame_exitCancelBtn")
mywindow:setTexture("Normal", "UIData/LobbyImage_new002.tga", 928, 0)
mywindow:setTexture("Hover", "UIData/LobbyImage_new002.tga", 928, 27)
mywindow:setTexture("Pushed", "UIData/LobbyImage_new002.tga", 928, 54)
mywindow:setTexture("PushedOff", "UIData/LobbyImage_new002.tga", 928, 0)
mywindow:setPosition(200, 100)
mywindow:setSize(90, 27)
mywindow:setAlpha(0)
mywindow:subscribeEvent("Clicked", "WndGame_QuitCancel")
quitwindow:addChildWindow(mywindow)


function WndGame_SetEscape(before30sec)
	if before30sec == 1 then
		quitwindow:setTexture("Enabled", "UIData/LobbyImage_new002.tga", 684, 677)
		quitwindow:setTexture("Disabled", "UIData/LobbyImage_new002.tga", 684, 677)
	elseif before30sec == 2 then
		quitwindow:setTexture("Enabled", "UIData/LobbyImage_new002.tga", 684, 536)
		quitwindow:setTexture("Disabled", "UIData/LobbyImage_new002.tga", 684, 536)
	end
	
	if before30sec == 3 then
		quitwindow:setTexture("Enabled", "UIData/LobbyImage_new002.tga", 0, 884)
		quitwindow:setTexture("Disabled", "UIData/LobbyImage_new002.tga", 0, 884)
	end
end

-- 편법을 사용하여 알파로 나타났을 경우 버튼 이미지들이 나오고 기존 이미지는 그리지 않는다;;
local g_escapeAlpha = 0
function WndGame_Escape(bFlag, deltaTime)
	
	if bFlag > 0 then
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
		end
	end
	
	winMgr:getWindow("sj_WndGame_exitBackWindow"):setAlpha(g_escapeAlpha)
	winMgr:getWindow("sj_WndGame_exitOkBtn"):setAlpha(g_escapeAlpha)
	winMgr:getWindow("sj_WndGame_exitCancelBtn"):setAlpha(g_escapeAlpha)
end

root:subscribeEvent("KeyUp", "OnGameKeyUp");
function OnGameKeyUp(args)	
	local keyEvent = CEGUI.toKeyEventArgs(args);
	if keyEvent.scancode == 40 or keyEvent.scancode == 39 or keyEvent.scancode == 38 or keyEvent.scancode == 37 then 
		if winMgr:getWindow('doChatting'):isActive() == true or winMgr:getWindow('PrivateChatting'):isActive() == true then
			winMgr:getWindow("doChatting"):setText("")
			Chatting_SetChatEditVisible(false)
			return
		end
	end
end

local WATCHING_WHO = PreCreateString_2488	--GetSStringInfo(LAN_CLUBWAR_PLAY_OBSERVER)	-- %s 관전중

function WndGame_DrawObserverInfo(characterName)
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
	drawer:drawTexture("UIData/quest.tga", 450, 220, 206, 36, 0, 607, WIDETYPE_5)
end

