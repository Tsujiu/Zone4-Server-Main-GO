-----------------------------------------
-- Script Entry Point
-----------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)
root:activate()





--------------------------------------------------------------------

-- SP장갑일 경우 +SP 표시하기(MAX_COMBO : 32개)

--------------------------------------------------------------------
local tGainSPPosX		= { ["e"]=0, [0]={["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,} }
local tGainSPPosY		= { ["e"]=0, [0]={["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,} }
local tGainSPDamage		= { ["e"]=0, [0]={["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,} }
local tGainSPTime		= { ["e"]=0, [0]={["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,} }
local tDecreaseAlphaSP	= { ["e"]=0, [0]={["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,} }

function WndMRGame_StartEffectGainSP(characterIndex, comboIndex, x, y, damage)
	tGainSPPosX[characterIndex][comboIndex]			= x
	tGainSPPosY[characterIndex][comboIndex]			= y
	tGainSPDamage[characterIndex][comboIndex]		= damage
	tGainSPTime[characterIndex][comboIndex]			= 0
	tDecreaseAlphaSP[characterIndex][comboIndex]	= 255
end


function WndMRGame_EndEffectGainSP(characterIndex, comboIndex)
	tGainSPPosX[characterIndex][comboIndex]			= 0
	tGainSPPosY[characterIndex][comboIndex]			= 0
	tGainSPDamage[characterIndex][comboIndex]		= 0
	tGainSPTime[characterIndex][comboIndex]			= 0
	tDecreaseAlphaSP[characterIndex][comboIndex]	= 0	
end


function WndMRGame_RenderEffectGainSP(characterIndex, comboIndex, deltaTime)
	
	if tGainSPTime[characterIndex][comboIndex] == nil then
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
	drawer:drawTextureA("UIData/GameNewImage.tga", _left-19, y+3, 19, 25, 223, 867, alpha)
end



--------------------------------------------------------------------

-- 케릭터에 관한정보 그리기(HP, SP ...)

--------------------------------------------------------------------
function WndMRGame_RenderCharacter
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
			, isHideHP
			)
	
	if isHideHP == 1 then
		return
	end
	
	local MONSTER_RACING = true
	local SURVIVAL = 2	-- 0:게임, 1:던전, 2:몬스터레이싱, 3:점령전, 4:점령전(옵저버)
	local exceptE = 0
	local bArcadeEvent = 0
	Common_RenderCharacter(deltatime, myslot, myteam, slot, team, characterName, 
		screenX, screenY, hp, sp, maxhp, maxsp, friend, isPenalty, penaltyValue, 
		SURVIVAL, showAllSP, showAllItem, _1stItemType, _2ndItemType, MONSTER_RACING, bArcadeEvent, exceptE)
end








-------------------------------------------------------------------------

--	랭킹 부분

-------------------------------------------------------------------------
local tRankPos		= { ["err"]=0, 8, 27, 46, 65, 84, 103, 122, 141 }
local tRankOffsetX	= { ["err"]=0, 805, 805, 805, 805, 805, 805, 805, 805 }
local tRankOffsetY	= { ["err"]=0, 20, 20, 20, 20, 20, 20, 20, 20 }

-- 현재 나의 랭크로 사이즈를 정한다.
function WndMRGame_BeforeRenderRank(myRank)

	-- 초기화
	for i=1, 8 do
		tRankOffsetX[i] = 805
		tRankOffsetY[i] = 20
	end
	
	-- 8위는 다음랭크가 없으므로 조심스럽게 x좌표만 ^^
	if myRank ~= 8 then
		tRankOffsetX[myRank]	= 767
		tRankOffsetY[myRank+1]	= 26
	else
		tRankOffsetX[myRank]	= 767
	end
	
end



-- 현재 랭크의 간격을 더해서 y위치의 좌표를 리턴한다.
function GetCurrentRankPosY(rank)
	local rankPos = -14
	
	for i=1, rank do
		rankPos = rankPos + tRankOffsetY[i]
	end
	
	return rankPos
end




local spacingPosX = 20
local g_mvpEffectTime = 0
local tPropertyItemTexY = {["err"]=0, [0]=560, 616, 672, 728, 784, 840}
function WndMRGame_RenderRank(slot, myslot, mybone, bTeam, team, rank, killCount, deadCount, 
				disconnected, relay, network, INFINITE_PING, hp, sp, maxhp, maxsp, deltatime, RESPAWN_TIME, revivalTime, 
				level, characterName, isGameOver, lifeCount, mvpIndex, transform, isPenalty, penaltyValue, currentUserNum, 
				bFastRevive, rightRevive, itemType)

	if slot == myslot then
		-- 다시 살아나기
		Common_RenderReStart(deltatime, hp, RESPAWN_TIME, revivalTime, isGameOver, lifeCount, bFastRevive, rightRevive)
		
		-- 나에대한 정보 그리기
		local exceptE = 0
		local bArcadeEvent = 0
		local visibleHPSP = 1
		local bTournamentArcade = 0
		Common_RenderME(slot, mybone, hp, sp, maxhp, maxsp, deltatime, 
				RESPAWN_TIME, revivalTime, level, characterName, isGameOver, lifeCount, 0, transform, isPenalty, penaltyValue, bArcadeEvent, exceptE, visibleHPSP, bTournamentArcade)
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
				drawer:drawTexture("UIData/GameNewImage.tga", tRankOffsetX[rank], GetCurrentRankPosY(rank), 254, 23, 267, 184, WIDETYPE_1)
			else
				drawer:drawTexture("UIData/GameNewImage.tga", tRankOffsetX[rank], GetCurrentRankPosY(rank), 254, 23, 267, 209, WIDETYPE_1)
			end
		else
			drawer:drawTexture("UIData/GameNewImage.tga", tRankOffsetX[rank], GetCurrentRankPosY(rank), 254, 23, 267, 184, WIDETYPE_1)
		end
	else
		if bTeam == 1 then
			if team == 0 then
				drawer:drawTexture("UIData/GameNewImage.tga", tRankOffsetX[rank]-spacingPosX, GetCurrentRankPosY(rank), 240, 17, 0, 149, WIDETYPE_1)
			else
				drawer:drawTexture("UIData/GameNewImage.tga", tRankOffsetX[rank]-spacingPosX, GetCurrentRankPosY(rank), 240, 17, 0, 168, WIDETYPE_1)
			end
		else
			drawer:drawTexture("UIData/GameNewImage.tga", tRankOffsetX[rank]-spacingPosX, GetCurrentRankPosY(rank), 240, 17, 0, 130, WIDETYPE_1)
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
	drawer:setFont(g_STRING_FONT_GULIMCHE, 112)

	if disconnected == 0 then
		if slot == myslot then
			drawer:setTextColor(255,205,86,255)
		else
			drawer:setTextColor(255, 255, 255, 255)
		end
	else
		drawer:setTextColor(255, 100, 30, 255)
	end
	
	drawer:setFont(g_STRING_FONT_GULIMCHE, 112)
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
		common_DrawOutlineText1(drawer, deadCount, killPos+deadPos-spacingPosX, userRankPosY+2, 0,0,0,255, 255,205,86,255, WIDETYPE_1)
	else
		drawer:drawText(deadCount, killPos+deadPos-spacingPosX, userRankPosY+2, WIDETYPE_1)
	end
	
	
	if disconnected == 1 then
		drawer:drawTexture("UIData/GameNewImage.tga", 915-spacingPosX, userRankPosY, 74, 14, 2, 190, WIDETYPE_1)
	end
	
	
	-- mvp(5명부터 적용)
	if currentUserNum >= 5 then
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
end



----------------------------------------------------------

-- KILL 효과 주기

----------------------------------------------------------
g_totalCount = 0
local g_KoEffectEnable = { ["err"]=0, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false
									, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false }
local g_KoEffectAlpha  = { ["err"]=0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
									, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
local g_KoEffectTime   = { ["err"]=0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
									, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
									

for i=1, #g_KoEffectEnable do
	
	-- 백자리 킬수
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_wndMRGame_Effect_ko_hun"..i)
	mywindow:setWideType(6);
	mywindow:setPosition(348, 100)
	mywindow:setSize(54, 54)
	mywindow:setScaleWidth(255)
	mywindow:setScaleHeight(255)
	mywindow:setVisible(false)
	mywindow:setTexture("Enabled", "UIData/numberUi001.tga", 162, 311)
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:addController("tenNumber", "StampEffect", "xscale", "Quintic_EaseIn", 700, 255, 3, true, false, 10)
	mywindow:addController("tenNumber", "StampEffect", "yscale", "Quintic_EaseIn", 700, 255, 3, true, false, 10)
	mywindow:addController("tenNumber", "StampEffect", "xscale", "Elastic_EaseOut", 150, 255, 5, true, false, 10)
	mywindow:addController("tenNumber", "StampEffect", "yscale", "Elastic_EaseOut", 150, 255, 5, true, false, 10)
	mywindow:setAlign(8)
	root:addChildWindow(mywindow)
	
	-- 십자리 킬수
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_wndMRGame_Effect_ko_ten"..i)
	mywindow:setWideType(6);
	mywindow:setPosition(394, 100)
	mywindow:setSize(54, 54)
	mywindow:setScaleWidth(255)
	mywindow:setScaleHeight(255)
	mywindow:setVisible(false)
	mywindow:setTexture("Enabled", "UIData/numberUi001.tga", 162, 311)
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:addController("tenNumber", "StampEffect", "xscale", "Quintic_EaseIn", 700, 255, 3, true, false, 10)
	mywindow:addController("tenNumber", "StampEffect", "yscale", "Quintic_EaseIn", 700, 255, 3, true, false, 10)
	mywindow:addController("tenNumber", "StampEffect", "xscale", "Elastic_EaseOut", 150, 255, 5, true, false, 10)
	mywindow:addController("tenNumber", "StampEffect", "yscale", "Elastic_EaseOut", 150, 255, 5, true, false, 10)
	mywindow:setAlign(8)
	root:addChildWindow(mywindow)

	-- 일자리 킬수
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_wndMRGame_Effect_ko_one"..i)
	mywindow:setWideType(6);
	mywindow:setPosition(440, 100)
	mywindow:setSize(54, 54)
	mywindow:setScaleWidth(255)
	mywindow:setScaleHeight(255)
	mywindow:setVisible(false)
	mywindow:setTexture("Enabled", "UIData/numberUi001.tga", 162, 311)
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:addController("oneNumber", "StampEffect", "xscale", "Quintic_EaseIn", 700, 255, 3, true, false, 10)
	mywindow:addController("oneNumber", "StampEffect", "yscale", "Quintic_EaseIn", 700, 255, 3, true, false, 10)
	mywindow:addController("oneNumber", "StampEffect", "xscale", "Elastic_EaseOut", 150, 255, 5, true, false, 10)
	mywindow:addController("oneNumber", "StampEffect", "yscale", "Elastic_EaseOut", 150, 255, 5, true, false, 10)
	mywindow:setAlign(8)
	root:addChildWindow(mywindow)

	-- KILL 글자
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_wndMRGame_Effect_ko_KILL"..i)
	mywindow:setWideType(6);
	mywindow:setPosition(500, 104)
	mywindow:setSize(140, 53)
	mywindow:setScaleWidth(255)
	mywindow:setScaleHeight(255)
	mywindow:setVisible(false)
	mywindow:setTexture("Enabled", "UIData/numberUi001.tga", 562, 365)
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:addController("killImage", "StampEffect", "xscale", "Quintic_EaseIn", 700, 255, 3, true, false, 10)
	mywindow:addController("killImage", "StampEffect", "yscale", "Quintic_EaseIn", 700, 255, 3, true, false, 10)
	mywindow:addController("killImage", "StampEffect", "xscale", "Elastic_EaseOut", 150, 255, 5, true, false, 10)
	mywindow:addController("killImage", "StampEffect", "yscale", "Elastic_EaseOut", 150, 255, 5, true, false, 10)
	mywindow:setAlign(8)
	root:addChildWindow(mywindow)
end

function WndMRGame_KoEffect(koCount)
	if koCount <= 0 then
		return
	end
	
	g_totalCount = g_totalCount + 1
	if g_totalCount > #g_KoEffectEnable then
		return
	end
	
	g_KoEffectEnable[g_totalCount] = true
	g_KoEffectAlpha[g_totalCount]  = 255
	
	local hun = koCount / 100	
	if hun > 0  then
		winMgr:getWindow("sj_wndMRGame_Effect_ko_hun"..g_totalCount):setTexture("Enabled", "UIData/numberUi001.tga", 162+(hun*54), 311)
		winMgr:getWindow("sj_wndMRGame_Effect_ko_hun"..g_totalCount):setVisible(true)
		winMgr:getWindow("sj_wndMRGame_Effect_ko_hun"..g_totalCount):activeMotion("StampEffect")
	end

	local ten = koCount / 10
	if ten > 0 then
		ten = ten % 10
		winMgr:getWindow("sj_wndMRGame_Effect_ko_ten"..g_totalCount):setTexture("Enabled", "UIData/numberUi001.tga", 162+(ten*54), 311)
		winMgr:getWindow("sj_wndMRGame_Effect_ko_ten"..g_totalCount):setVisible(true)
		winMgr:getWindow("sj_wndMRGame_Effect_ko_ten"..g_totalCount):activeMotion("StampEffect")
		
		local one = koCount % 10
		winMgr:getWindow("sj_wndMRGame_Effect_ko_one"..g_totalCount):setTexture("Enabled", "UIData/numberUi001.tga", 162+(one*54), 311)
		winMgr:getWindow("sj_wndMRGame_Effect_ko_one"..g_totalCount):setVisible(true)
		winMgr:getWindow("sj_wndMRGame_Effect_ko_one"..g_totalCount):activeMotion("StampEffect")
	else
		winMgr:getWindow("sj_wndMRGame_Effect_ko_one"..g_totalCount):setTexture("Enabled", "UIData/numberUi001.tga", 162+(koCount*54), 311)
		winMgr:getWindow("sj_wndMRGame_Effect_ko_one"..g_totalCount):setVisible(true)
		winMgr:getWindow("sj_wndMRGame_Effect_ko_one"..g_totalCount):activeMotion("StampEffect")
	end
	
	winMgr:getWindow("sj_wndMRGame_Effect_ko_KILL"..g_totalCount):setVisible(true)
	winMgr:getWindow("sj_wndMRGame_Effect_ko_KILL"..g_totalCount):activeMotion("StampEffect")
	
	-- 킬 사운드
	--[[
	if koCount == 1 then
		PlaySound('sound/System/System_KO.wav')
	elseif koCount == 2 then
		PlaySound('sound/System/System_DoubleKO.wav')
	elseif koCount == 3 then
		PlaySound('sound/System/System_TripleKO.wav')
	elseif koCount >= 4 then
		PlaySound('sound/System/System_FantasticKO.wav')
	end
	--]]
	PlaySound('sound/System/System_KO.wav')
end




function WndMRGame_ExecuteKoEffect(deltaTime)
	
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
					
					if winMgr:getWindow("sj_wndMRGame_Effect_ko_hun"..i) then
						winMgr:getWindow("sj_wndMRGame_Effect_ko_hun"..i):setVisible(false)
					end
					if winMgr:getWindow("sj_wndMRGame_Effect_ko_ten"..i) then
						winMgr:getWindow("sj_wndMRGame_Effect_ko_ten"..i):setVisible(false)
					end
					if winMgr:getWindow("sj_wndMRGame_Effect_ko_one"..i) then
						winMgr:getWindow("sj_wndMRGame_Effect_ko_one"..i):setVisible(false)
					end
					if winMgr:getWindow("sj_wndMRGame_Effect_ko_KILL"..i) then
						winMgr:getWindow("sj_wndMRGame_Effect_ko_KILL"..i):setVisible(false)
					end
				end
				
				if winMgr:getWindow("sj_wndMRGame_Effect_ko_hun"..i) then
					winMgr:getWindow("sj_wndMRGame_Effect_ko_hun"..i):setAlpha(g_KoEffectAlpha[i])
				end
				if winMgr:getWindow("sj_wndMRGame_Effect_ko_ten"..i) then
					winMgr:getWindow("sj_wndMRGame_Effect_ko_ten"..i):setAlpha(g_KoEffectAlpha[i])
				end
				if winMgr:getWindow("sj_wndMRGame_Effect_ko_one"..i) then
					winMgr:getWindow("sj_wndMRGame_Effect_ko_one"..i):setAlpha(g_KoEffectAlpha[i])
				end
				if winMgr:getWindow("sj_wndMRGame_Effect_ko_KILL"..i) then
					winMgr:getWindow("sj_wndMRGame_Effect_ko_KILL"..i):setAlpha(g_KoEffectAlpha[i])
				end
			end
		else
			g_KoEffectAlpha[i] = 0
			g_KoEffectTime[i]  = 0
			if winMgr:getWindow("sj_wndMRGame_Effect_ko_hun"..i) then
				winMgr:getWindow("sj_wndMRGame_Effect_ko_hun"..i):setVisible(false)
				winMgr:getWindow("sj_wndMRGame_Effect_ko_hun"..i):setAlpha(g_KoEffectAlpha[i])
			end
			if winMgr:getWindow("sj_wndMRGame_Effect_ko_ten"..i) then
				winMgr:getWindow("sj_wndMRGame_Effect_ko_ten"..i):setVisible(false)
				winMgr:getWindow("sj_wndMRGame_Effect_ko_ten"..i):setAlpha(g_KoEffectAlpha[i])
			end
			if winMgr:getWindow("sj_wndMRGame_Effect_ko_one"..i) then
				winMgr:getWindow("sj_wndMRGame_Effect_ko_one"..i):setVisible(false)
				winMgr:getWindow("sj_wndMRGame_Effect_ko_one"..i):setAlpha(g_KoEffectAlpha[i])
			end
			if winMgr:getWindow("sj_wndMRGame_Effect_ko_KILL"..i) then
				winMgr:getWindow("sj_wndMRGame_Effect_ko_KILL"..i):setVisible(false)
				winMgr:getWindow("sj_wndMRGame_Effect_ko_KILL"..i):setAlpha(g_KoEffectAlpha[i])
			end
		end
	end
	
	local bResult = false
	for i=1, #g_KoEffectEnable do
		if g_KoEffectEnable[i] then
			bResult = true
		end
	end
	
	if bResult == false then
		g_totalCount = 0
	end
end




----------------------------------------------------------

-- 현재상황(팀전, 레드팀 스테이지, 블루팀 스테이지)

----------------------------------------------------------
local myPostionY = 62
local ROUND_POS_WIDTH = 325
local ROUND_POS_START_X = 339

function WndMRGame_SetRenderScore()
end


function WndMRGame_RenderScore(myTeam, bTeam, redStage, blueStage, totalStage, totalNpcCount, redTeamKillCount, blueTeamKillCount)
	if totalStage == 1 then
		 totalStage = 2
	end
	
	if bTeam == 1 then
		local ROUND_POS_SCORE_X = 474
		
		-- 몬스터 레이싱 스코어 바탕
		drawer:drawTexture("UIData/match001.tga", 320, 0, 384, 69, 326, 411, WIDETYPE_5)

		DrawEachNumberWide("UIData/match001.tga", redStage, 8, ROUND_POS_SCORE_X, 28, 580, 499, 13, 19, 13, WIDETYPE_5)			-- 레드팀 스테이지
		DrawEachNumberWide("UIData/match001.tga", blueStage, 8, ROUND_POS_SCORE_X+127, 28, 580, 480, 13, 19, 13, WIDETYPE_5)	-- 블루팀 스테이지

		local RED_POS = (redTeamKillCount*100/totalNpcCount)*ROUND_POS_WIDTH/100
		local BLUE_POS = (blueTeamKillCount*100/totalNpcCount)*ROUND_POS_WIDTH/100

		-- 내가 레드팀이면 블루팀 윈도우 부터 생성
		if myTeam == 0 then
			drawer:drawTexture("UIData/match001.tga", ROUND_POS_START_X+BLUE_POS, myPostionY, 22, 22, 494, 389, WIDETYPE_5)
			drawer:drawTexture("UIData/match001.tga", ROUND_POS_START_X+RED_POS, myPostionY, 22, 22, 472, 389, WIDETYPE_5)
			
		-- 내가 블루팀이면 레드팀 윈도우 부터 생성
		elseif myTeam == 1 then
			drawer:drawTexture("UIData/match001.tga", ROUND_POS_START_X+RED_POS, myPostionY, 22, 22, 472, 389, WIDETYPE_5)
			drawer:drawTexture("UIData/match001.tga", ROUND_POS_START_X+BLUE_POS, myPostionY, 22, 22, 494, 389, WIDETYPE_5)
		end
	end	
end





----------------------------------------------------------

-- 스테이지 그리기

----------------------------------------------------------
local g_stageTime	= 0
local g_stagePos	= 0
local g_bstage		= true
function WndMRGame_RenderStage(deltaTime, currentCut)

	local START_TICK = 0	
	g_stageTime = g_stageTime + deltaTime
	
	if g_stageTime >= START_TICK then
	
		if g_bstage then
			PlaySound("sound/Dungeon/Dungeon_Start.wav")
			g_bstage = false
		end
		
		local startTime = g_stageTime - START_TICK
		
		-- 1500까지는 가운데로 간다.
		if 0 <= startTime and startTime <= 1500 then
			g_stagePos = Effect_Elastic_EaseOut(startTime, -600, 900, 1500, 0, 0)
		
		-- 그후에 800이 되면 사라진다.
		elseif 1500 < startTime and startTime <= 2300 then
			g_stagePos = Effect_Back_EaseIn(startTime-1500, 290, 1600, 800, 0)
			
		-- 2300이 넘으면 사라짐
		elseif startTime > 2300 then
			g_stageTime = 2400
			g_stagePos	= 2000
			return
		end	
		
		-- 스타트
		drawer:drawTexture("UIData/numberUi001.tga", g_stagePos+30, 217, 290, 63, 731, 242, WIDETYPE_6)
		DrawEachNumberWide("UIData/numberUi001.tga", currentCut, 1, g_stagePos+360, 200, 134, 140, 89, 85, 89, WIDETYPE_6)
	end
end

function WndMRGame_InitStage()
	g_stageTime	= 0
	g_stagePos	= 0
	g_bstage	= true
end


----------------------------------------------------------

-- 콤보, 데미지

----------------------------------------------------------
function WndMRGame_ComboAndDamage(deltaTime, isCombo, currentCombo, isAccumulate, accumDamage, 
							teamAttackCount, doubleAttackCount, isTeamAttack, isDoubleAttack, currentAttackCount)
	Common_ComboAndDamage(deltaTime, isCombo, currentCombo, isAccumulate, accumDamage, 
			teamAttackCount, doubleAttackCount, isTeamAttack, isDoubleAttack, currentAttackCount)
end




----------------------------------------------------------

-- 게임중 어드밴티지 적용효과

----------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "WndMRGame_EffectAdvantage")
mywindow:setTexture("Enabled", "UIData/LobbyImage_new002.tga", 838, 108)
mywindow:setTexture("Disabled", "UIData/LobbyImage_new002.tga", 838, 108)
mywindow:setWideType(5)
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
mywindow:addController("effectAdvantage", "effectAdvantage", "x", "Sine_EaseIn", 474, 474, 15, true, false, 10)
mywindow:addController("effectAdvantage", "effectAdvantage", "x", "Sine_EaseIn", 474, 2, 3, true, false, 10)
mywindow:addController("effectAdvantage", "effectAdvantage", "y", "Sine_EaseIn", 220, 220, 15, true, false, 10)
mywindow:addController("effectAdvantage", "effectAdvantage", "y", "Sine_EaseIn", 220, 190, 3, true, false, 10)
--mywindow:addController("effectAdvantage", "effectAdvantage", "alpha", "Sine_EaseInOut", 255, 255, 18, true, false, 10)
--mywindow:addController("effectAdvantage", "effectAdvantage", "alpha", "Sine_EaseInOut", 255, 0, 2, true, true, 10)
--mywindow:addController("effectAdvantage", "effectAdvantage", "alpha", "Sine_EaseInOut", 0, 255, 2, true, true, 10)
root:addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/StaticImage", "WndMRGame_notifyAdvantage")
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

function WndMRGame_ShowAdvantage(advantage)
	winMgr:getWindow("WndMRGame_notifyAdvantage"):setVisible(true)	
	winMgr:getWindow("WndMRGame_EffectAdvantage"):setVisible(true)
	
	if advantage == 30 then
		winMgr:getWindow("WndMRGame_notifyAdvantage"):setTexture("Enabled", "UIData/LobbyImage_new002.tga", 0, 589)
		winMgr:getWindow("WndMRGame_notifyAdvantage"):setTexture("Disabled", "UIData/LobbyImage_new002.tga", 0, 589)
		winMgr:getWindow("WndMRGame_EffectAdvantage"):setTexture("Enabled", "UIData/LobbyImage_new002.tga", 838, 108)
		winMgr:getWindow("WndMRGame_EffectAdvantage"):setTexture("Disabled", "UIData/LobbyImage_new002.tga", 838, 108)
	elseif advantage == 60 then
		winMgr:getWindow("WndMRGame_notifyAdvantage"):setTexture("Enabled", "UIData/LobbyImage_new002.tga", 0, 635)
		winMgr:getWindow("WndMRGame_notifyAdvantage"):setTexture("Disabled", "UIData/LobbyImage_new002.tga", 0, 635)
		winMgr:getWindow("WndMRGame_EffectAdvantage"):setTexture("Enabled", "UIData/LobbyImage_new002.tga", 838, 150)
		winMgr:getWindow("WndMRGame_EffectAdvantage"):setTexture("Disabled", "UIData/LobbyImage_new002.tga", 838, 150)
	elseif advantage == 90 then
		winMgr:getWindow("WndMRGame_notifyAdvantage"):setTexture("Enabled", "UIData/LobbyImage_new002.tga", 0, 681)
		winMgr:getWindow("WndMRGame_notifyAdvantage"):setTexture("Disabled", "UIData/LobbyImage_new002.tga", 0, 681)
		winMgr:getWindow("WndMRGame_EffectAdvantage"):setTexture("Enabled", "UIData/LobbyImage_new002.tga", 838, 192)
		winMgr:getWindow("WndMRGame_EffectAdvantage"):setTexture("Disabled", "UIData/LobbyImage_new002.tga", 838, 192)
	end
	
	winMgr:getWindow("WndMRGame_notifyAdvantage"):activeMotion("notifyAdvantage")
	winMgr:getWindow("WndMRGame_EffectAdvantage"):activeMotion("effectAdvantage")
end


----------------------------------------------------------

-- 게임이 더이상 진행 불가능 하다는 알림

----------------------------------------------------------
function WndMRGame_ShowNotifyEscape()
	winMgr:getWindow("WndMRGame_notifyAdvantage"):setVisible(true)
	winMgr:getWindow("WndMRGame_notifyAdvantage"):setTexture("Enabled", "UIData/LobbyImage_new002.tga", 0, 543)
	winMgr:getWindow("WndMRGame_notifyAdvantage"):setTexture("Disabled", "UIData/LobbyImage_new002.tga", 0, 543)
	winMgr:getWindow("WndMRGame_notifyAdvantage"):activeMotion("notifyAdvantage")
	
end



----------------------------------------------------------

-- 게임오버 그리기

----------------------------------------------------------
local g_gameoverSound = true
local tBlackImage = { ["err"]=0, -85 }
function WndMRGame_RenderGameOver(deltaTime, myTeam, winTeam)
	
	-- GAMEOVER 이미지
	if tBlackImage[1] >= 260 then
		tBlackImage[1] = 260
	else
		tBlackImage[1] = tBlackImage[1] + (deltaTime/2)		
	end
	
	if winTeam == 0 then
		drawer:drawTexture("UIData/numberUi001.tga", 262, tBlackImage[1], 503, 85, 521, 672, WIDETYPE_6)
	elseif winTeam == 1 then
		drawer:drawTexture("UIData/numberUi001.tga", 223, tBlackImage[1], 578, 85, 446, 587, WIDETYPE_6)
	end
	
	if g_gameoverSound then
		g_gameoverSound = false
		
		if myTeam == winTeam then
			PlaySound('sound/System/System_Win.wav')
		else
			PlaySound('sound/System/System_Lose.wav')
		end
	end
end




----------------------------------------------------

-- 몬스터 레이싱 버전 보여주기

----------------------------------------------------
function WndMRGame_ShowMRVersion(version)
	DrawEachNumberWide("UIData/dungeonmsg.tga", version, 1, 980, 750, 516, 224, 12, 14, 15, WIDETYPE_4)
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
function WndMRGame_RenderStartItemSlot(bSlot0, bSlot1, bSlot2)

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
function WndMRGame_RenderItem(bChanged, itemType_0, itemType_1, tick, CHANGED_TICK)

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
		drawer:drawTextureWithScale_Angle_Offset("UIData/GameSlotItem.tga", g_itemSlotX_0, g_itemSlotY, 43, 44, itemType_0*47, 60,
														g_itemScale_0, g_itemScale_0, 255, 0, 8, 100, 0)
	end
	
	if itemType_1 >= 0 then
		drawer:drawTextureWithScale_Angle_Offset("UIData/GameSlotItem.tga", g_itemSlotX_1, g_itemSlotY, 43, 44, itemType_1*47, 60,
														g_itemScale_1, g_itemScale_1, 255, 0, 8, 0, 0)
	end	
	
end



-- 아이템 먹었을 때 효과 그리기
function WndMRGame_RenderEffectGetItem(slot, state)

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
function WndMRGame_InitEffectGetItem()

	g_itemEffectSlotX_0 = ITEMSLOT_0
	g_itemEffectSlotX_1 = ITEMSLOT_1

end



-- 아이템 선택 이미지(현재는 0번슬롯 테두리)
function WndMRGame_RenderEndItemSlot()

	--drawer:drawTextureWithScale_Angle_Offset("UIData/GameNewImage.tga", ITEMSLOT_0, g_itemSlotY, 57, 59, 658, 100,
														--330, 330, 255, 0, 8, 100, 0)
end


-- 아이템 체인지 가능한 수
function WndMRGame_RenderSlotChangeCount(slotChangeCount)
	-- shift 이미지
	--drawer:drawTexture("UIData/GameNewImage.tga", 164, g_itemSlotY-28, 49, 37, 611, 0)
	drawer:drawTexture("UIData/GameSlotItem.tga", 93, g_itemSlotY+15, 10, 11, 15, 261)	-- X
	DrawEachNumber("UIData/GameSlotItem.tga", slotChangeCount, 8, 120, g_itemSlotY+16, 28, 261, 12, 14, 15)
end



-- 아이템을 사용했을 때 보여주기
function WndMRGame_ItemUseEffect(type, tick)

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
			drawer:drawTextureWithScale_Angle_Offset("UIData/GameSlotItem.tga", 516, y, 47, 49, 60, 139, 510, 510, alpha, 0, 8, 100, 0, WIDETYPE_6)
		elseif _tick == 1 then
			drawer:drawTextureWithScale_Angle_Offset("UIData/GameSlotItem.tga", 516, y, 71, 73, 110, 127, 510, 510, alpha, 0, 8, 100, 0, WIDETYPE_6)
		elseif _tick == 2 then
			drawer:drawTextureWithScale_Angle_Offset("UIData/GameSlotItem.tga", 519, y, 107, 109, 179, 109, 510, 510, alpha, 0, 8, 100, 0, WIDETYPE_6)
		elseif _tick == 3 then
			drawer:drawTextureWithScale_Angle_Offset("UIData/GameSlotItem.tga", 516, y, 39, 41, 296, 141, 510, 510, alpha, 0, 8, 100, 0, WIDETYPE_6)
		end
	end
	
	-- 사용되는 아이템 그리기
	drawer:drawTextureWithScale_Angle_Offset("UIData/GameSlotItem.tga", 516, y, 43, 44, type*47, 60,
														350, 350, alpha, 0, 8, 100, 0, WIDETYPE_6)
	
	-- 사용되는 아이템 이름
	drawer:drawTextureA("UIData/GameSlotItem.tga", 432, y+30, 160, 18, 224, 219+(type*19), alpha, WIDETYPE_6)
end



-- 아이템 누가 사용했는지 표시하기
local MAX_ITEM_USED = WndMRGame_MaxItemUsed()
for i=0, MAX_ITEM_USED-1 do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_wndMRGame_ItemUsed_backImage_"..i)
	mywindow:setTexture("Enabled", "UIData/numberUi001.tga", 548, 418)
	mywindow:setTexture("Disabled", "UIData/numberUi001.tga", 548, 418)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setWideType(4);
	mywindow:setPosition(840, 526+(i*33))
	mywindow:setSize(154, 32)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(false)
	root:addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_wndMRGame_ItemUsed_itemImage_"..i)
	mywindow:setTexture("Enabled", "UIData/GameSlotItem.tga", 0, 60)
	mywindow:setTexture("Disabled", "UIData/GameSlotItem.tga", 0, 60)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(5, 5)
	mywindow:setSize(43, 44)
	mywindow:setScaleWidth(128)
	mywindow:setScaleHeight(128)
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(false)
	winMgr:getWindow("sj_wndMRGame_ItemUsed_backImage_"..i):addChildWindow(mywindow)

	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_wndMRGame_ItemUsed_characterName_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setText("")
	mywindow:setPosition(32, 6)
	mywindow:setSize(100, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_wndMRGame_ItemUsed_backImage_"..i):addChildWindow(mywindow)
end


function WndMRGame_InitItemUsedEffect()
	for i=0, MAX_ITEM_USED-1 do
		winMgr:getWindow("sj_wndMRGame_ItemUsed_backImage_"..i):setVisible(false)
	end
end


function WndMRGame_ItemUsedEffect(count, itemType, characterName, team)
	winMgr:getWindow("sj_wndMRGame_ItemUsed_backImage_"..count):setVisible(true)
	
	winMgr:getWindow("sj_wndMRGame_ItemUsed_itemImage_"..count):setTexture("Enabled", "UIData/GameSlotItem.tga", itemType*47, 60)
	winMgr:getWindow("sj_wndMRGame_ItemUsed_itemImage_"..count):setTexture("Disabled", "UIData/GameSlotItem.tga", itemType*47, 60)
	winMgr:getWindow("sj_wndMRGame_ItemUsed_itemImage_"..count):setScaleWidth(128)
	winMgr:getWindow("sj_wndMRGame_ItemUsed_itemImage_"..count):setScaleHeight(128)
	
	if team == 0 then
		winMgr:getWindow("sj_wndMRGame_ItemUsed_characterName_"..count):setTextColor(254, 87, 87, 255)
	elseif team == 1 then
		winMgr:getWindow("sj_wndMRGame_ItemUsed_characterName_"..count):setTextColor(97, 161, 240, 255)
	end
	winMgr:getWindow("sj_wndMRGame_ItemUsed_characterName_"..count):setText(characterName)
end




----------------------------------------------------

-- 속성 아이템

----------------------------------------------------
local tItemDescEnum = {["err"]=0, [0]=LAN_CLUBWAR_PLAY_ITEMEX1_SHIELD, LAN_CLUBWAR_PLAY_ITEMEX2_PWUP, LAN_CLUBWAR_PLAY_ITEMEX3_BLOW,
					LAN_CLUBWAR_PLAY_ITEMEX4_RECOVER, LAN_CLUBWAR_PLAY_ITEMEX5_METEO, LAN_CLUBWAR_PLAY_ITEMEX5_TOWER}

-- 아이템 그리기
function WndMRGame_RenderPropertyItem(itemType, myHP, myDiedTime)

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




----------------------------------------------------

-- 채팅

----------------------------------------------------
-- 채팅 엔터쳤을 때
--[[
function WndMRGame_RootKeyDown(args)
	winMgr:getWindow("doChatting"):activate()
end
root:subscribeEvent("KeyDown", "WndMRGame_RootKeyDown")
]]--


-- 15초후 채팅 초기화
local tShowText		 = { ["err"]=0 }
local tShowTextColor = { ["err"]=0 }
local tShowTextType  = { ["err"]=0 }

function WndMRGame_ClearChatting()

	for i=1, table.getn(tShowText) do
		table.remove(tShowText,  i)		-- 채팅내용
		table.remove(tShowTextColor, i)	-- 채팅색상
		table.remove(tShowTextType, i)	-- 채팅타입(일반, 스페셜)
	end
	
end

-- 게임중 채팅내용 저장
function GetUserChat()
	for i=1, table.getn(tShowText) do
		WndMRGame_UserChattingSave(tShowText[i], tShowTextColor[i])
	end
end






------------------------------------------------

--	말풍선 그리기

------------------------------------------------
function WndMRGame_OnDrawBoolean(str_chat, px, py, chatBubbleType)
	
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







--------------------------------------------------------------------

-- 시간 그리기

--------------------------------------------------------------------
tTime = { ["err"]=0, [0]=515, 550, 586, 622, 657, 693, 729, 766, 801, 836 }
function WndMRGame_RenderTime(min, sec, milliSec)

	local startPos1	= 40
	local startPos2	= 62
	local startPosY = 130

	-- 뒷판 그리기
	drawer:drawTexture("UIData/dungeonmsg.tga", startPos1-36, startPosY, 262, 32, 276, 820)	
	
	-- minute
	drawer:drawTexture("UIData/dungeonmsg.tga", startPos1, startPosY+4, 38, 26, tTime[min/10], 192)
	drawer:drawTexture("UIData/dungeonmsg.tga", startPos2, startPosY+4, 38, 26, tTime[min%10], 192)
	
	-- ' 과 :
	drawer:drawTexture("UIData/dungeonmsg.tga", startPos2+23, startPosY+4, 16, 26, 891, 192)
	drawer:drawTexture("UIData/dungeonmsg.tga", startPos2+30, startPosY+4, 16, 26, 870, 192)
	
	
	-- second
	drawer:drawTexture("UIData/dungeonmsg.tga", startPos1+65, startPosY+4, 38, 26, tTime[sec/10], 192)
	drawer:drawTexture("UIData/dungeonmsg.tga", startPos2+65, startPosY+4, 38, 26, tTime[sec%10], 192)
	
	-- ' 과 .
	drawer:drawTexture("UIData/dungeonmsg.tga", startPos2+23+65, startPosY+4, 16, 26, 891, 192)
	drawer:drawTexture("UIData/dungeonmsg.tga", startPos2+30+65, startPosY+17, 16, 13, 870, 205)
	
	
	-- milli second
	drawer:drawTexture("UIData/dungeonmsg.tga", startPos1+130, startPosY+4, 38, 26, tTime[milliSec/10], 192)
	drawer:drawTexture("UIData/dungeonmsg.tga", startPos2+130, startPosY+4, 38, 26, tTime[milliSec%10], 192)
	
	-- "
	drawer:drawTexture("UIData/dungeonmsg.tga", startPos2+24+130, startPosY+4, 16, 26, 911, 192)
	
end






----------------------------------------------------

-- 도움말

----------------------------------------------------
function WndMRGame_RenderHelp(bHelp)
--[[
	drawer:drawTexture("UIData/bunhae_002.tga", 4, 198, 60, 27, 0, 82)
	
	-- 도움말 상세정보
	if bHelp == 1 then
		drawer:drawTexture("UIData/other001.tga", 4, 132, 565, 306, 0, 0)
	end	]]
end





----------------------------------------------------

-- 웨폰 주울수 있는지 알려주기

----------------------------------------------------
function WndMRGame_NotifyPickupWeapon(weaponIndex, weaponPosX, weaponPosY)
	if weaponIndex >= 0 then
	--	drawer:drawTexture("UIData/GameNewImage.tga", weaponPosX-30, weaponPosY-100, 77, 46, 478, 831)
		drawer:drawTexture("UIData/GameNewImage.tga", weaponPosX-40, weaponPosY-80, 84, 62, 474, 883)
	end
end


----------------------------------------------------

-- 속성 아이템 주울수 있는지 알려주기

----------------------------------------------------
function WndMRGame_NotifyPickupPropertyItem(weaponIndex, weaponPosX, weaponPosY)
	drawer:drawTexture("UIData/GameNewImage.tga", weaponPosX-40, weaponPosY-130, 84, 62, 474, 883)
end



-- 몬스터 레이싱 디버그 확인
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_wndMRGame_ErrorNotify")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setText("ERROR SCENE")
mywindow:setPosition(860, 750)
mywindow:setSize(100, 20)
mywindow:setVisible(false)
root:addChildWindow(mywindow)
function WndMRGame_ErrorNotify()
	winMgr:getWindow("sj_wndMRGame_ErrorNotify"):setVisible(true)
end



----------------------------------------------------

-- 디버그

----------------------------------------------------
function WndMRGame_Debug(i, count, hp, name, myIndex)
	
--	drawer:setTextColor(255, 255, 0, 255)
--	drawer:setFont(g_STRING_FONT_GULIMCHE, 14)
--	drawer:drawText(i.." : "..name, 280, 100+(count*18))
	
--	if i == myIndex then
--		drawer:drawText("myIndex : "..myIndex, 430, 100+(count*18))
--	end
--	DrawEachNumber("UIData/dungeonmsg.tga", hp, 1, 380, 100+(count*18), 516, 224, 12, 14, 15)
end



-- 디버그 2
function WndMRGame_Debug2(i, name, atkDamage, grabDamage, superEDamage, doubleAtkCount, teamAtkCount, evadeCount, comboCount, itemUseCount, whoMeDown)
	drawer:setTextColor(255, 255, 0, 255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 112)
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







function WndMRGame_ShowEmblemKey(LeftEmblem, RightEmblem)
	if LeftEmblem > 0 then 
		drawer:drawTextureSA(GetClubDirectory(GetLanguageType())..LeftEmblem..".tga", 310 , 12, 32, 32, 0, 0, 350, 350, 255, 0, 0)
		--DebugStr('LeftEmblem:'..LeftEmblem)
	end
	
	if RightEmblem > 0 then
		drawer:drawTextureSA(GetClubDirectory(GetLanguageType())..RightEmblem..".tga", 670 , 12 , 32, 32, 0, 0, 350, 350, 255, 0, 0)
		--DebugStr('RightEmblem:'..RightEmblem)
	end
end




--------------------------------------------------------------------

-- 서바이벌 랭킹정보 버튼

--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_WndMRGame_mrRankingInfoBtn")
mywindow:setTexture("Normal", "UIData/match001.tga", 257, 508)
mywindow:setTexture("Hover", "UIData/match001.tga", 257, 538)
mywindow:setTexture("Pushed", "UIData/match001.tga", 257, 569)
mywindow:setTexture("PushedOff", "UIData/match001.tga", 257, 508)
mywindow:setSize(79, 30)
mywindow:setPosition(5, 164)
mywindow:setVisible(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickedMRRankInfoWindow")
root:addChildWindow(mywindow)

function ClickedMRRankInfoWindow()
	ClickTabToMRRankInfo()
end

-- 랭킹정보 바탕
mrrankwindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_WndMRGame_mr_rankInfo_backImage")
mrrankwindow:setTexture("Enabled", "UIData/match002.tga", 0, 0)
mrrankwindow:setTexture("Disabled", "UIData/match002.tga", 0, 0)
mrrankwindow:setProperty("FrameEnabled", "False")
mrrankwindow:setProperty("BackgroundEnabled", "False")
mrrankwindow:setWideType(6);
mrrankwindow:setPosition(257, 95)
mrrankwindow:setSize(510, 577)
--mrrankwindow:setAlwaysOnTop(true)
mrrankwindow:setZOrderingEnabled(false)
mrrankwindow:setVisible(false)
root:addChildWindow(mrrankwindow)

-- 닫기버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_WndMRGame_mr_rankInfo_cancelBtn")
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
	winMgr:getWindow("sj_WndMRGame_mr_rankInfo_backImage"):setVisible(false)
end

-- 맵이름
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_WndMRGame_mr_rankInfo_MapName")
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

-- 1 ~ 20위 순위정보
for i=0, MAX_MR_RANK-1 do
	for j=0, #tMRRankInfoName do
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_WndMRGame_mr_rankInfo_"..i..tMRRankInfoName[j])
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

function WndMRGame_SetMRRankInfo(i, rank, name, time, kill)
	local size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, rank)
	winMgr:getWindow("sj_WndMRGame_mr_rankInfo_"..i..tMRRankInfoName[0]):setPosition(tMRRankInfoPosX[0]-size, 135+(i*21))
	winMgr:getWindow("sj_WndMRGame_mr_rankInfo_"..i..tMRRankInfoName[0]):setText(rank)
	
	size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, name)
	winMgr:getWindow("sj_WndMRGame_mr_rankInfo_"..i..tMRRankInfoName[1]):setPosition(tMRRankInfoPosX[1]-size/2, 135+(i*21))
	winMgr:getWindow("sj_WndMRGame_mr_rankInfo_"..i..tMRRankInfoName[1]):setText(name)
	
	winMgr:getWindow("sj_WndMRGame_mr_rankInfo_"..i..tMRRankInfoName[2]):setText(time)
	
	size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, kill)
	winMgr:getWindow("sj_WndMRGame_mr_rankInfo_"..i..tMRRankInfoName[3]):setPosition(tMRRankInfoPosX[3]-size/2, 135+(i*21))
	winMgr:getWindow("sj_WndMRGame_mr_rankInfo_"..i..tMRRankInfoName[3]):setText(tostring(kill))
end

function WndMRGame_InitMRRankInfo()
	for i=0, MAX_MR_RANK-1 do
		for j=0, #tMRRankInfoName do
			winMgr:getWindow("sj_WndMRGame_mr_rankInfo_"..i..tMRRankInfoName[j]):setText("")
		end
	end
end

function ClickTabToMRRankInfo()
	if winMgr:getWindow("sj_WndMRGame_mr_rankInfo_backImage") then
		if winMgr:getWindow("sj_WndMRGame_mr_rankInfo_backImage"):isVisible() then
			winMgr:getWindow("sj_WndMRGame_mr_rankInfo_backImage"):setVisible(false)
			winMgr:getWindow("sj_WndMRGame_mr_rankInfo_MapName"):setText("")
		else
			winMgr:getWindow("sj_WndMRGame_mr_rankInfo_backImage"):setVisible(true)
			
			local mapName = GetCurrentMapName()
			local size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, mapName)
			winMgr:getWindow("sj_WndMRGame_mr_rankInfo_MapName"):setPosition(256-size/2, 62)
			winMgr:getWindow("sj_WndMRGame_mr_rankInfo_MapName"):setText(mapName)
			
			WndMRGame_RequestMRRank()
		end
	end
end

function ClickEscToMRRankInfo()
	if winMgr:getWindow("sj_WndMRGame_mr_rankInfo_backImage") then
		if winMgr:getWindow("sj_WndMRGame_mr_rankInfo_backImage"):isVisible() then
			winMgr:getWindow("sj_WndMRGame_mr_rankInfo_backImage"):setVisible(false)
			winMgr:getWindow("sj_WndMRGame_mr_rankInfo_MapName"):setText("")
		end
	end
end

--RegistEscEventInfo("sj_WndMRGame_mr_rankInfo_backImage", "HideMRRanking")




----------------------------------------------------

-- 게임 종료창

----------------------------------------------------
quitwindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_WndMRGame_exitBackWindow")
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

mywindow = winMgr:createWindow("TaharezLook/Button", "sj_WndMRGame_exitOkBtn")
mywindow:setTexture("Normal", "UIData/LobbyImage_new002.tga", 838, 0)
mywindow:setTexture("Hover", "UIData/LobbyImage_new002.tga", 838, 27)
mywindow:setTexture("Pushed", "UIData/LobbyImage_new002.tga", 838, 54)
mywindow:setTexture("PushedOff", "UIData/LobbyImage_new002.tga", 839, 0)
mywindow:setPosition(50, 100)
mywindow:setSize(90, 27)
mywindow:setAlpha(0)
mywindow:subscribeEvent("Clicked", "WndMRGame_QuitOK")
quitwindow:addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/Button", "sj_WndMRGame_exitCancelBtn")
mywindow:setTexture("Normal", "UIData/LobbyImage_new002.tga", 928, 0)
mywindow:setTexture("Hover", "UIData/LobbyImage_new002.tga", 928, 27)
mywindow:setTexture("Pushed", "UIData/LobbyImage_new002.tga", 928, 54)
mywindow:setTexture("PushedOff", "UIData/LobbyImage_new002.tga", 928, 0)
mywindow:setPosition(200, 100)
mywindow:setSize(90, 27)
mywindow:setAlpha(0)
mywindow:subscribeEvent("Clicked", "WndMRGame_QuitCancel")
quitwindow:addChildWindow(mywindow)


function WndMRGame_SetEscape(before30sec)
	if before30sec == 1 then
		quitwindow:setTexture("Enabled", "UIData/LobbyImage_new002.tga", 684, 677)
		quitwindow:setTexture("Disabled", "UIData/LobbyImage_new002.tga", 684, 677)
	elseif before30sec == 2 then
		quitwindow:setTexture("Enabled", "UIData/LobbyImage_new002.tga", 684, 536)
		quitwindow:setTexture("Disabled", "UIData/LobbyImage_new002.tga", 684, 536)
	end
end

-- 편법을 사용하여 알파로 나타났을 경우 버튼 이미지들이 나오고 기존 이미지는 그리지 않는다;;
local g_escapeAlpha = 0
function WndMRGame_Escape(bFlag, deltaTime)
	
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
	
	winMgr:getWindow("sj_WndMRGame_exitBackWindow"):setAlpha(g_escapeAlpha)
	winMgr:getWindow("sj_WndMRGame_exitOkBtn"):setAlpha(g_escapeAlpha)
	winMgr:getWindow("sj_WndMRGame_exitCancelBtn"):setAlpha(g_escapeAlpha)
end


-- 채팅창  초기  설정
function SetChatInitMRGame()
	Chatting_SetChatWideType(2)
	Chatting_SetChatPosition(3, 527)
	Chatting_SetChatEditEvent(3)
	Chatting_SetChatTabDefault()
	Chatting_SetUsePartyAsTeam(true)
end
