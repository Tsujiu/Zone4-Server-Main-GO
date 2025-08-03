--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)
root:activate()


local GAMEMODE_DEATHMATCH = 0
local GAMEMODE_MONSTER_RACING = 6
local GAMEMODE_FIELD = 7
local GAMEMODE_DUALMATCH = 8
local GAMEMODE_SINGLEMATCH = 9
local GAMEMODE_COINMATCH = 11


local String_Lucky_1 = PreCreateString_2341	--GetSStringInfo(LAN_LUCKY_FIGHTER_SUCCESS)			-- 럭키 파이터 성공! 
local String_Lucky_2 = PreCreateString_2343	--GetSStringInfo(LAN_LUCKY_FIGHTER_ATTAINMENT)			-- %d번째 럭키 파이터가 되셨습니다 
local String_Lucky_3 = PreCreateString_2340	--GetSStringInfo(LAN_LUCKY_FIGHTER_REWARD)				-- "%s"가 지급됩니다 
local String_Lucky_4 = PreCreateString_2342	--GetSStringInfo(LAN_LUCKY_FIGHTER_FAIL)				-- 럭키 파이터 실패! 
local String_Lucky_5 = PreCreateString_2344	--GetSStringInfo(LAN_LUCKY_FIGHTER_COUNT_NOTIFY)		-- 당신의 럭키 카운트는 %d 입니다 
local String_Lucky_6 = PreCreateString_2345	--GetSStringInfo(LAN_LUCKY_FIGHTER_CHALLENGE_AGAIN)	-- 다시 도전해 보세요!

local tMyRankPos	= { ["protectErr"]=0, 1100, 460, 2000 }
local tMyRankDescX	= { ["protectErr"]=0, 0, 193, 386, 579, 0, 193, 386, 579 }
local tMyRankDescY	= { ["protectErr"]=0, 157, 157, 157, 157, 274, 274, 274, 274 }

-- 인덱스 0은 변화위치, 1는 중간위치, 2은 최종위치

-- 위쪽 결과
local tRedWins		= { ["err"]=0, [0]=-690, 180, 1920 }
local tBlueWins		= { ["err"]=0, [0]=-783, 140, 1920 }
local tDrawGame		= { ["err"]=0, [0]=-870,  90, 1920 }
local tYouWin		= { ["err"]=0, [0]=-594, 230, 1920 }
local tYouLose		= { ["err"]=0, [0]=-835, 150, 1920 }
local tYouWin_R		= { ["err"]=0, [0]=-582, 220, 1920 }
local tYouLose_R	= { ["err"]=0, [0]=-730, 160, 1920 }
local tYouWin_B		= { ["err"]=0, [0]=-582, 220, 1920 }
local tYouLose_B	= { ["err"]=0, [0]=-730, 160, 1920 }
local tResultTemp	= { ["err"]=0, [0]=0, 0, 0 }

-- 가운데 미션
local tMission			= { ["err"]=0, [0]=-1000, 20, -1000 }
local tMission_Result	= { ["err"]=0, [0]=1030, 0, -1000 }
local g_missionEffect	= 0
local g_koRateTime = 0

-- 아래쪽 상태바
local tStateBarX	= { ["err"]=0, [0]=66}
local tStateBarY	= { ["err"]=0, [0]=768+85, 620, 768+85+500 }

local tLevelupY	= { ["err"]=0, [0]=600, 150 }
local g_levelupEffect_Star	= 0
local g_levelupAlpha		= 350
local g_incEffect = 0
local g_resultSound = true
--local g_currentClubBattle = WndGameResult_IsClubBattle()

-- 아케이드 쿠폰
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_gameResult_stampArcadeTicket")
mywindow:setWideType(6);
mywindow:setPosition(734, 404)
mywindow:setSize(256, 256)
mywindow:setVisible(false)
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:addController("arcadeTicketController", "ArcadeTicketEffect", "xscale", "Elastic_EaseOut", 1, 300, 9, true, true, 10)
mywindow:addController("arcadeTicketController", "ArcadeTicketEffect", "yscale", "Elastic_EaseOut", 1, 300, 9, true, true, 10)
mywindow:setAlign(8)
root:addChildWindow(mywindow)
local bArcadeTicketEffectOnce = true
local g_ArcadeTicketSound = true
local g_ArcadeTicketSoundTime = 0


-- 보상 아이템 종류가 여러가지임
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_gameResult_stampRewardItem")
mywindow:setWideType(6);
mywindow:setPosition(734, 224)
mywindow:setSize(256, 256)
mywindow:setVisible(false)
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:addController("RewardItemController", "RewardItemEffect", "xscale", "Elastic_EaseOut", 1, 300, 9, true, true, 10)
mywindow:addController("RewardItemController", "RewardItemEffect", "yscale", "Elastic_EaseOut", 1, 300, 9, true, true, 10)
mywindow:setAlign(8)
root:addChildWindow(mywindow)
local bRewardItemEffectOnce = true
local g_RewardItemSound = true
local g_RewardItemSoundTime = 0


-- 
local TexXTable = {['err']=0, [0]=0, 517}
local AlphaTable = {['err']=0, [0]=255,0,0,255, 0,255,255,0}
for i=0, 1 do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_gameResult_luckyCountTextBack"..i)
	mywindow:setTexture("Disabled", "UIData/event001.tga", TexXTable[i], 938)
	mywindow:setWideType(6);
	mywindow:setPosition(0, 0)
	mywindow:setSize(361, 86)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	mywindow:addController("LuckyCountController", "LuckyCountTextBackMotion", "alpha", "Linear_EaseNone", AlphaTable[4*i], AlphaTable[4*i+1], 2, true, true, 10)
	mywindow:addController("LuckyCountController", "LuckyCountTextBackMotion", "alpha", "Linear_EaseNone", AlphaTable[4*i+2], AlphaTable[4*i+3], 2, true, true, 10)
	root:addChildWindow(mywindow)
end

TexXTable = {['err']=0, [0]=431, 878}
for i=0, 1 do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_gameResult_luckyCountItemBack"..i)
	mywindow:setTexture("Disabled", "UIData/event001.tga", TexXTable[i], 938)
	mywindow:setWideType(6);
	mywindow:setPosition(0, 0)
	mywindow:setSize(86, 86)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	mywindow:addController("LuckyCountController", "LuckyCountItemBackMotion", "alpha", "Linear_EaseNone", AlphaTable[4*i], AlphaTable[4*i+1], 2, true, true, 10)
	mywindow:addController("LuckyCountController", "LuckyCountItemBackMotion", "alpha", "Linear_EaseNone", AlphaTable[4*i+2], AlphaTable[4*i+3], 2, true, true, 10)
	root:addChildWindow(mywindow)
end
local bLuckyCountEffectOnce = true


local g_newMRRecord = false
local g_newMRRecordEffect = 0
local g_newMRRank = 0
local g_newMRMin = 0
local g_newMRSec = 0
local g_newMRMilliSec = 0
local g_newMRKillCount = 0
local g_tnewMRTime = { ["err"]=0, [0]=822, 838, 854, 870, 886, 902, 918, 934, 950, 966 }
function SetNewMRRecord(rank, min, sec, milliSec, killCount)
	g_newMRRecord = true
	g_newMRRank = rank
	g_newMRMin = min
	g_newMRSec = sec
	g_newMRMilliSec = milliSec
	g_newMRKillCount = killCount
end


--------------------------------------------------------------------

-- 처음 4초간은 클로즈업 된 케릭터를 보여준다

--------------------------------------------------------------------
local PLAYMODE = 0
local lastDrawState = 0
function WndGameResult_RenderResult(deltaTime, drawState, bTeam, myTeam, myResult,
			missionSuccess, mission0_result, mission1_result, mission0_desc, mission1_desc,
			myName, myStyle, myPoint, myCash,
			totalPoint, gainedExp, addGainedExp, addGainedPoint,				-- 얻은 포인트, 얻은 경험치, 얻은 +경험치
			myLevel, currentExp, levelTable, increaseExp, 						-- 현재 레벨, 현재 경험치, 경험치 테이블, 증가 경험치
			leftPercent, rightPercent, bMyLevelup, ladder,						-- 현재 경험치 퍼센트, 증가경험치 퍼센트, 나의 레벨업 유무, 래더등급
			_oldPreDPoint, _oldAfterDPoint1, _oldAfterDPoint2,					-- 이전 KO률 소수점 앞 2자리, 이전 KO률 소수점 뒤 2자리
			_curPreDPoint, _curAfterDPoint1, _curAfterDPoint2, _bIncrease,		-- 현재 KO률 소수점 앞 2자리, 현재 KO률 소수점 뒤 2자리, KO률 증가했는지
			currentUserNum, bPerfectGame, playMode,	myKill, missionExp,			-- 현재유저수, 퍼펙트 게임인지, 플레이모드, 나의 킬수, 미션추가경험치
			missionZen, myRank, promotion, attribute)							-- 미션추가ZEN, 나의랭킹, 직업, 캐릭터 속성

	PLAYMODE = playMode
	
	----------------------------------------------------
		
	-- 위쪽 결과 그리기
	
	----------------------------------------------------
	if bTeam == 1 then
		if		myTeam == 0 and myResult == 0 then	for i=0, 2 do tResultTemp[i] = tYouWin_R[i]	 end	-- 내가 레드고 이김
		elseif	myTeam == 0 and myResult == 1 then	for i=0, 2 do tResultTemp[i] = tYouLose_R[i] end	-- 내가 레드고 짐
		elseif	myTeam == 0 and myResult == 2 then	for i=0, 2 do tResultTemp[i] = tDrawGame[i]  end	-- 내가 레드고 비김
		elseif	myTeam == 1 and myResult == 0 then	for i=0, 2 do tResultTemp[i] = tYouWin_B[i]  end	-- 내가 블루고 이김
		elseif	myTeam == 1 and myResult == 1 then	for i=0, 2 do tResultTemp[i] = tYouLose_B[i] end	-- 내가 블루고 짐
		elseif	myTeam == 1 and myResult == 2 then	for i=0, 2 do tResultTemp[i] = tDrawGame[i]  end	-- 내가 블루고 비김
		end
	else
		if		myResult == 0 then	for i=0, 2 do tResultTemp[i] = tYouWin[i] end		-- 개인 윈
		elseif	myResult == 1 then	for i=0, 2 do tResultTemp[i] = tYouLose[i] end		-- 개인 로즈
		elseif	myResult == 2 then	for i=0, 2 do tResultTemp[i] = tDrawGame[i] end		-- 개인 비김
		end	
	end

	tResultTemp[0] = tResultTemp[0] + (deltaTime*3)
	if drawState == 0 then	
		if tResultTemp[0] >= tResultTemp[1] then
			tResultTemp[0] = tResultTemp[1]
		end
	else
		if bPerfectGame == 1 then
			tResultTemp[0] = 1100
		else		
			if tResultTemp[0] >= tResultTemp[1] then
				tResultTemp[0] = tResultTemp[1]
			end
		end
	end
	
	
	-- 팀전 결과(0이면 레드팀 승, 1이면 블루팀 승, 2이면 무승부)
	if bTeam == 1 then
	
		-- WIN
		if myResult == 0 then
		
			if g_resultSound then
				g_resultSound = false
				PlaySound('sound/System/System_Win.wav')
			end
		
			-- 내가 레드팀일때(레드팀 승리)
			if myTeam == 0 then
				drawer:drawTexture("UIData/ResultNewImage_2.tga", tResultTemp[0], 18, 588, 105, 0, 670, WIDETYPE_6)
			
			-- 내가 블루팀일때(블루팀 승리)
			else
				drawer:drawTexture("UIData/ResultNewImage_2.tga", tResultTemp[0], 18, 588, 105, 0, 557, WIDETYPE_6)				
			end
		
		-- LOSE
		elseif myResult == 1 then
		
			if g_resultSound then
				g_resultSound = false
				PlaySound('sound/System/System_Lose.wav')
			end
			
			-- 내가 레드팀일때(레드팀 패배)
			if myTeam == 0 then
				drawer:drawTexture("UIData/ResultNewImage_2.tga", tResultTemp[0], 18, 329, 107, 0, 670, WIDETYPE_6)
				drawer:drawTexture("UIData/ResultNewImage_2.tga", tResultTemp[0]+320, 18, 404, 107, 600, 670, WIDETYPE_6)
				
			-- 내가 블루팀일때(블루팀 패배)
			else
				drawer:drawTexture("UIData/ResultNewImage_2.tga", tResultTemp[0], 18, 329, 107, 0, 557, WIDETYPE_6)
				drawer:drawTexture("UIData/ResultNewImage_2.tga", tResultTemp[0]+320, 18, 404, 107, 600, 557, WIDETYPE_6)				
			end
		
		-- DRAW
		elseif myResult == 2 then
		
			drawer:drawTexture("UIData/ResultNewImage_1.tga", tResultTemp[0], 18, 860, 107, 0, 526, WIDETYPE_6)		
		
		end
		
	-- 개인전 결과(0이면 Win, 1이면 Lose, 2이면 무승부)
	else
		if myResult == 0 then
			if g_resultSound then
				g_resultSound = false
				PlaySound('sound/System/System_Win.wav')
			end
			drawer:drawTexture("UIData/ResultNewImage_2.tga", tResultTemp[0], 18, 588, 105, 0, 670, WIDETYPE_6)
			
		elseif myResult == 1 then
			if g_resultSound then
				g_resultSound = false
				PlaySound('sound/System/System_Lose.wav')
			end
			drawer:drawTexture("UIData/ResultNewImage_2.tga", tResultTemp[0], 18, 329, 107, 0, 557, WIDETYPE_6)
			drawer:drawTexture("UIData/ResultNewImage_2.tga", tResultTemp[0]+320, 18, 404, 107, 600, 557, WIDETYPE_6)
			
		elseif myResult == 2 then
			drawer:drawTexture("UIData/ResultNewImage_1.tga", tResultTemp[0], 18, 860, 107, 0, 526, WIDETYPE_6)
		end
	end
	
	
	if bTeam == 1 then	
		if		myTeam == 0 and myResult == 0 then	for i=0, 2 do tYouWin_R[i]	= tResultTemp[i] end	-- 내가 레드고 이김
		elseif	myTeam == 0 and myResult == 1 then	for i=0, 2 do tYouLose_R[i]	= tResultTemp[i] end	-- 내가 레드고 짐
		elseif	myTeam == 0 and myResult == 2 then	for i=0, 2 do tDrawGame[i]	= tResultTemp[i] end	-- 내가 레드고 비김
		elseif	myTeam == 1 and myResult == 0 then	for i=0, 2 do tYouWin_B[i]	= tResultTemp[i] end	-- 내가 블루고 이김
		elseif	myTeam == 1 and myResult == 1 then	for i=0, 2 do tYouLose_B[i]	= tResultTemp[i] end	-- 내가 블루고 짐
		elseif	myTeam == 1 and myResult == 2 then	for i=0, 2 do tDrawGame[i]	= tResultTemp[i] end	-- 내가 블루고 비김
		end
	else
		if		myResult == 0 then	for i=0, 2 do tYouWin[i]   = tResultTemp[i] end
		elseif	myResult == 1 then	for i=0, 2 do tYouLose[i]  = tResultTemp[i] end
		elseif	myResult == 2 then	for i=0, 2 do tDrawGame[i] = tResultTemp[i] end
		end
	end
	
		
	
	----------------------------------------------------
		
	-- 미션 결과 그리기 (3명부터 보이기)
	
	----------------------------------------------------
	if PLAYMODE == GAMEMODE_DEATHMATCH then
		--[[
		if currentUserNum >= 3 then
			if drawState == 0 then
				tMission[0] = tMission[0] + deltaTime*2
				if tMission[0] >= tMission[1] then
					tMission[0] = tMission[1]
					
					tMission_Result[0] = tMission_Result[0] - (deltaTime*6)	
					if tMission_Result[0] <= tMission_Result[1] then
						tMission_Result[0] = tMission_Result[1]
					end
				end		
			else
				tMission[0] = tMission[0] - deltaTime
				if tMission[0] <= tMission[2] then
					tMission[0] = tMission[2]
				end
				
				tMission_Result[0] = tMission_Result[0] - deltaTime
				if tMission_Result[0] <= tMission_Result[2] then
					tMission_Result[0] = tMission_Result[2]
				end
			end
			
			drawer:setFont(g_STRING_FONT_DODUMCHE, 16)
			drawer:setTextColor(255, 255, 255, 255)
			
			local missionSuccessY	= 160
			local mission0_posY		= 220
			local mission1_posY		= 260
			
			-- 미션 내용
			common_DrawOutlineText1(drawer, mission0_desc, tMission[0]+80, mission0_posY, 0,0,0,255, 255,255,255,255, WIDETYPE_6)
			common_DrawOutlineText1(drawer, mission1_desc, tMission[0]+80, mission1_posY, 0,0,0,255, 255,255,255,255, WIDETYPE_6)
			
			-- 미션 결과
			if mission0_result == 1 then
				drawer:drawTexture("UIData/GameNewImage.tga", tMission[0], mission0_posY-12, 59, 38, 880, 182, WIDETYPE_6)	-- success
			else
				drawer:drawTexture("UIData/GameNewImage.tga", tMission[0], mission0_posY-11, 59, 38, 880, 142, WIDETYPE_6)	-- miss
			end
			
			if mission1_result == 1 then
				drawer:drawTexture("UIData/GameNewImage.tga", tMission[0], mission1_posY-12, 59, 38, 880, 182, WIDETYPE_6)	-- success
			else
				drawer:drawTexture("UIData/GameNewImage.tga", tMission[0], mission1_posY-11, 59, 38, 880, 142, WIDETYPE_6)	-- miss
			end
			
			
			-- 미션 성공여부
			g_missionEffect = g_missionEffect + deltaTime
			g_missionEffect = g_missionEffect % 400
			drawer:drawTexture("UIData/ResultNewImage_1.tga", tMission_Result[0], missionSuccessY-19, 473, 69, 0, 852, WIDETYPE_6)
			if missionSuccess == 1 then
				if g_missionEffect < 200 then
					drawer:drawTexture("UIData/ResultNewImage_1.tga", tMission_Result[0]+100, missionSuccessY, 190, 27, 700, 738, WIDETYPE_6)	-- 미션 성공
				else
					drawer:drawTexture("UIData/ResultNewImage_1.tga", tMission_Result[0]+100, missionSuccessY, 190, 27, 700, 770, WIDETYPE_6)	-- 미션 성공
				end
			else
				if g_missionEffect < 200 then
					drawer:drawTexture("UIData/ResultNewImage_1.tga", tMission_Result[0]+100, missionSuccessY, 190, 27, 700, 802, WIDETYPE_6)	-- 미션 실패
				else
					drawer:drawTexture("UIData/ResultNewImage_1.tga", tMission_Result[0]+100, missionSuccessY, 190, 27, 700, 834, WIDETYPE_6)	-- 미션 실패
				end
			end
		end		
		--]]
	-- 몬스터 레이싱
	elseif PLAYMODE == GAMEMODE_MONSTER_RACING then
		--[[
		if drawState == 0 then
			tMission[0] = tMission[0] + deltaTime*2
			if tMission[0] >= tMission[1] then
				tMission[0] = tMission[1]
				
				tMission_Result[0] = tMission_Result[0] - (deltaTime*6)	
				if tMission_Result[0] <= tMission_Result[1] then
					tMission_Result[0] = tMission_Result[1]
				end
			end		
		else
			tMission[0] = tMission[0] - deltaTime
			if tMission[0] <= tMission[2] then
				tMission[0] = tMission[2]
			end
			
			tMission_Result[0] = tMission_Result[0] - deltaTime
			if tMission_Result[0] <= tMission_Result[2] then
				tMission_Result[0] = tMission_Result[2]
			end
		end
		--]]
		
		-- 나의 몬스터 NEW RECORD
		if g_newMRRecord then
			g_newMRRecordEffect = g_newMRRecordEffect + deltaTime
			g_newMRRecordEffect = g_newMRRecordEffect % 200
			if g_newMRRecordEffect < 100 then
				drawer:drawTexture("UIData/ResultNewImage_3.tga", tMission[0]+50, 275, 206, 89, 0, 0, WIDETYPE_6)
			else
				drawer:drawTexture("UIData/ResultNewImage_3.tga", tMission[0]+50, 275, 206, 89, 206, 0, WIDETYPE_6)
			end
			
			local startPos1	= tMission[0]+70
			local startPos2	= tMission[0]+86
			local startPosY = 300
			
			-- 랭크
			local m_ten = (g_newMRRank-1) / 10
			local m_one = (g_newMRRank-1) % 10			
			drawer:drawTexture("UIData/ResultNewImage_3.tga", startPos1-12, startPosY+13, 64, 33, m_one*64, 89+(m_ten*33), WIDETYPE_6)

			-- 킬수
			local _l, _r = DrawEachNumberWide("UIData/match001.tga", g_newMRKillCount, 8, startPos1+100, startPosY+30, 822, 914, 16, 22, 16, WIDETYPE_6)
			drawer:drawTexture("UIData/ResultNewImage_3.tga", _r+10, startPosY+26, 60, 33, 618, 0, WIDETYPE_6)
			
			-- minute
			drawer:drawTexture("UIData/match001.tga", startPos1+56, startPosY+4, 16, 22, g_tnewMRTime[g_newMRMin/10], 914, WIDETYPE_6)
			drawer:drawTexture("UIData/match001.tga", startPos2+56, startPosY+4, 16, 22, g_tnewMRTime[g_newMRMin%10], 914, WIDETYPE_6)
			
			-- :
			drawer:drawTexture("UIData/match001.tga", startPos2+70, startPosY+4, 16, 21, 982, 914, WIDETYPE_6)
			
			-- second
			drawer:drawTexture("UIData/match001.tga", startPos1+100, startPosY+4, 16, 22, g_tnewMRTime[g_newMRSec/10], 914, WIDETYPE_6)
			drawer:drawTexture("UIData/match001.tga", startPos2+100, startPosY+4, 16, 22, g_tnewMRTime[g_newMRSec%10], 914, WIDETYPE_6)
			
			-- :
			drawer:drawTexture("UIData/match001.tga", startPos2+23+92, startPosY+4, 16, 21, 982, 914, WIDETYPE_6)
			
			-- milli second
			drawer:drawTexture("UIData/match001.tga", startPos1+146, startPosY+4, 16, 22, g_tnewMRTime[g_newMRMilliSec/10], 914, WIDETYPE_6)
			drawer:drawTexture("UIData/match001.tga", startPos2+146, startPosY+4, 16, 22, g_tnewMRTime[g_newMRMilliSec%10], 914, WIDETYPE_6)

		end
		
		drawer:drawTexture("UIData/ResultNewImage_1.tga", tMission[0]+50, 170, 206, 90, 777, 643, WIDETYPE_6)
		
		local _left, _right = DrawEachNumberWide("UIData/ResultNewImage_1.tga", myKill, 2, tMission[0]+190, 196, 833, 870, 17, 20, 17, WIDETYPE_6)
	--	drawer:drawTexture("UIData/ResultNewImage_1.tga", _left-16, 226, 17, 20, 799, 870)
		
		_left, _right = DrawEachNumberWide("UIData/match001.tga", missionExp, 2, tMission[0]+190, 216, 580, 499, 13, 19, 13, WIDETYPE_6)
	--	drawer:drawTexture("UIData/ResultNewImage_1.tga", tMission[0]+50, 200, 206, 90, 777, 643)
		
		_left, _right = DrawEachNumberWide("UIData/match001.tga", missionZen, 2, tMission[0]+190, 235, 580, 480, 13, 19, 13, WIDETYPE_6)
	--	drawer:drawTexture("UIData/ResultNewImage_1.tga", tMission[0]+50, 200, 206, 90, 777, 643)
	end
	
	
	if PLAYMODE ~= GAMEMODE_DUALMATCH and PLAYMODE ~= GAMEMODE_SINGLEMATCH then
		-- 나의 랭킹 이미지
		if myRank > 0 then
			if drawState == 0 then
				tMyRankPos[1] = tMyRankPos[1] - deltaTime
				if tMyRankPos[1] <= tMyRankPos[2] then
					tMyRankPos[1] = tMyRankPos[2]
				end			
			else
				tMyRankPos[1] = tMyRankPos[1] + (deltaTime*2)
				
				if tMyRankPos[1] >= tMyRankPos[3] then
					tMyRankPos[1] = tMyRankPos[3]
				end
			end
			drawer:drawTexture("UIData/ResultNewImage_2.tga", tMyRankPos[1], 130, 193, 117, tMyRankDescX[myRank], tMyRankDescY[myRank], WIDETYPE_6)
		end
	end
	
	----------------------------------------------------
	
	-- 나의 상태 그리기
	
	----------------------------------------------------
	if drawState == 0 then
		tStateBarY[0] = tStateBarY[0] - deltaTime/2
		if tStateBarY[0] <= tStateBarY[1] then
			tStateBarY[0] = tStateBarY[1]
		end	
	else
		tStateBarY[0] = tStateBarY[0] + deltaTime/2
		if tStateBarY[0] > tStateBarY[2] then
			tStateBarY[0] = tStateBarY[2]
		end
	end
	
	
	-- 아래쪽 상태바
	drawer:drawTexture("UIData/ResultNewImage_2.tga", tStateBarX[0], tStateBarY[0], 892, 121, 4, 896, WIDETYPE_6)
	
	-- 상태바 가운데 줄
	drawer:drawTexture("UIData/ResultNewImage_1.tga", tStateBarX[0]+350, tStateBarY[0]+36, 266, 1, 0, 282, WIDETYPE_6)
		
	-- 레벨
	drawer:setTextColor(255,205,86,255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	drawer:drawText("Lv." .. myLevel, tStateBarX[0]+92, tStateBarY[0]+19, WIDETYPE_6)
	
	-- 래더
	drawer:drawTexture("UIData/numberUi001.tga", tStateBarX[0]+243, tStateBarY[0]+44, 47, 21, 113, 600+21*ladder, WIDETYPE_6)
			
	-- 이름
	drawer:setTextColor(97,230,255,255)
	local nameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(myName))
	drawer:drawText(myName, (tStateBarX[0]+106)-nameSize/2, tStateBarY[0]+50, WIDETYPE_6)
		
	-- 스타일
	drawer:drawTexture("UIData/Skill_up2.tga", (tStateBarX[0]+235), tStateBarY[0]+3,  89, 35,  tAttributeImgTexXTable[myStyle][attribute], tAttributeImgTexYTable[myStyle][attribute], WIDETYPE_6)
	drawer:drawTexture("UIData/Skill_up2.tga", (tStateBarX[0]+235), tStateBarY[0]+3,  89, 35,  promotionImgTexXTable[myStyle], promotionImgTexYTable[promotion], WIDETYPE_6)	
	
	-- 나의 포인트
	local szMyPoint = CommatoMoneyStr(myPoint)
	local r,g,b = GetGranColor(tonumber(myPoint))
	drawer:setTextColor(r,g,b,255)
	local pointSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, szMyPoint)
	--drawer:drawText(szMyPoint, tStateBarX[0]+122-pointSize/2, tStateBarY[0]+46)
	
	
	-- 나의 캐쉬
	local szMyCash = CommatoMoneyStr(myCash)
	r,g,b = GetGranColor(tonumber(myCash))
	drawer:setTextColor(r,g,b,255)
	local cashSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, szMyCash)
	--drawer:drawText(szMyCash, tStateBarX[0]+280-cashSize/2, tStateBarY[0]+46)
	

	-- 나의 경험치 숫자
	drawer:setTextColor(255,198,0,255)
	local percent_a = 0
	if levelTable > 0 then
		percent_a = increaseExp*100/levelTable
	end
	drawer:drawText(percent_a .. " %", tStateBarX[0]+837, tStateBarY[0]+89, WIDETYPE_6)


	-- 경험치 게이지
	drawer:drawTexture("UIData/ResultNewImage_2.tga", tStateBarX[0]+59, tStateBarY[0]+79, rightPercent, 33, 62, 818, WIDETYPE_6)
	
	
	-- 증가하는 경험치 위치 3조정
	g_incEffect = g_incEffect + deltaTime
	g_incEffect = g_incEffect % 150
	if g_incEffect > 75 then
		drawer:drawTexture("UIData/ResultNewImage_2.tga", tStateBarX[0]+59+leftPercent, tStateBarY[0]+79, rightPercent-leftPercent, 33, 62+leftPercent, 851, WIDETYPE_6)
	end
	
	
	-- 경험치 상태글자
	drawer:setTextColor(255,255,255,255)
	local currentExpText = increaseExp .. " / " ..  levelTable
	local currentExpSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(currentExpText))
	drawer:drawText(currentExpText, (tStateBarX[0]+454)-currentExpSize/2, tStateBarY[0]+89, WIDETYPE_6)
	
	
	drawer:setTextColor(255,255,255,255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	
	local _left, _right
	local _left1, _right1
	
	if PLAYMODE == GAMEMODE_DEATHMATCH then
		if IsKoreanLanguage() == false then
		
			-- KO률 바탕 이미지
			drawer:drawTexture("UIData/ResultNewImage_2.tga", tStateBarX[0]+628, tStateBarY[0]+8, 251, 59, 773, 231, WIDETYPE_6)
		
			-- 이전 KO률
			local OLDX = 660
			if _oldPreDPoint == 100 then
				OLDX = 666
			end
			_left, _right = DrawEachNumberWide("UIData/numberUi001.tga", _oldPreDPoint, 2, tStateBarX[0]+OLDX, tStateBarY[0]+42, 709, 108, 15, 19, 16, WIDETYPE_6)
			drawer:drawTexture("UIData/numberUi001.tga", tStateBarX[0]+OLDX+16, tStateBarY[0]+43, 9, 18, 869, 109, WIDETYPE_6)	-- .
			_left, _right = DrawEachNumberWide("UIData/numberUi001.tga", _oldAfterDPoint1, 1, tStateBarX[0]+OLDX+26, tStateBarY[0]+42, 709, 108, 15, 19, 16, WIDETYPE_6)
			_left1, _right1 = DrawEachNumberWide("UIData/numberUi001.tga", _oldAfterDPoint2, 1, _right+14, tStateBarY[0]+42, 709, 108, 15, 19, 16, WIDETYPE_6)
			drawer:drawTexture("UIData/numberUi001.tga", _right1+16, tStateBarY[0]+43, 21, 19, 879, 108, WIDETYPE_6)	-- %
			
			
			-- 현재 KO률	
			local CURX = 790
			if _curPreDPoint == 100 then
				CURX = 794
			end
			if _bIncrease == 1 then
				g_koRateTime = g_koRateTime + deltaTime
				g_koRateTime = g_koRateTime % 400
				if g_koRateTime < 200 then
					_left, _right = DrawEachNumberWide("UIData/numberUi001.tga", _curPreDPoint, 2, tStateBarX[0]+CURX, tStateBarY[0]+42, 709, 108, 15, 19, 16, WIDETYPE_6)
					drawer:drawTexture("UIData/numberUi001.tga", tStateBarX[0]+CURX+16, tStateBarY[0]+43, 9, 18, 869, 109, WIDETYPE_6)	-- .
					_left, _right = DrawEachNumberWide("UIData/numberUi001.tga", _curAfterDPoint1, 1, tStateBarX[0]+CURX+26, tStateBarY[0]+42, 709, 108, 15, 19, 16, WIDETYPE_6)
					_left1, _right1 = DrawEachNumberWide("UIData/numberUi001.tga", _curAfterDPoint2, 1, _right+14, tStateBarY[0]+42, 709, 108, 15, 19, 16, WIDETYPE_6)
					drawer:drawTexture("UIData/numberUi001.tga", _right1+16, tStateBarY[0]+43, 21, 19, 879, 108, WIDETYPE_6)	-- %
				end
			else
				_left, _right = DrawEachNumberWide("UIData/numberUi001.tga", _curPreDPoint, 2, tStateBarX[0]+CURX, tStateBarY[0]+42, 709, 108, 15, 19, 16, WIDETYPE_6)
				drawer:drawTexture("UIData/numberUi001.tga", tStateBarX[0]+CURX+16, tStateBarY[0]+43, 9, 18, 869, 109, WIDETYPE_6)	-- .
				_left, _right = DrawEachNumberWide("UIData/numberUi001.tga", _curAfterDPoint1, 1, tStateBarX[0]+CURX+26, tStateBarY[0]+42, 709, 108, 15, 19, 16, WIDETYPE_6)
				_left1, _right1 = DrawEachNumberWide("UIData/numberUi001.tga", _curAfterDPoint2, 1, _right+14, tStateBarY[0]+42, 709, 108, 15, 19, 16, WIDETYPE_6)
				drawer:drawTexture("UIData/numberUi001.tga", _right1+16, tStateBarY[0]+43, 21, 19, 879, 108, WIDETYPE_6)	-- %
			end
		end
	end
	
	
	
	-- 경험치(보너스), 그랑(보너스) 글자
	drawer:drawTexture("UIData/ResultNewImage_2.tga", tStateBarX[0]+342, tStateBarY[0]+4, 111, 28, 800, 191, WIDETYPE_6)	-- 경험치(보너스)
	drawer:drawTexture("UIData/ResultNewImage_2.tga", tStateBarX[0]+346, tStateBarY[0]+38, 96, 28, 928, 191, WIDETYPE_6)	-- 그랑(보너스)
	
	
	-- 경험치(보너스) 글자
	_left, _right = DrawEachNumberWide("UIData/dungeonmsg.tga", gainedExp, 2, tStateBarX[0]+510, tStateBarY[0]+7, 286, 751, 16, 26, 27, WIDETYPE_6)	-- 경험치
	drawer:drawTexture("UIData/dungeonmsg.tga", _right+16, tStateBarY[0]+8, 13, 25, 240, 673, WIDETYPE_6)	-- (
--	drawer:drawTexture("UIData/dungeonmsg.tga", _right+24, tStateBarY[0]+9, 20, 25, 553, 673)	-- +
	_left, _right = DrawEachNumberWide("UIData/dungeonmsg.tga", addGainedExp, 1, tStateBarX[0]+538, tStateBarY[0]+7, 286, 672, 16, 26, 27, WIDETYPE_6)	-- +경험치
	drawer:drawTexture("UIData/dungeonmsg.tga", _right+16, tStateBarY[0]+8, 13, 25, 262, 673, WIDETYPE_6)	-- )
	
	-- 그랑(보너스) 글자
	_left, _right = DrawEachNumberWide("UIData/dungeonmsg.tga", totalPoint, 2, tStateBarX[0]+510, tStateBarY[0]+40, 286, 751, 16, 26, 27, WIDETYPE_6)	-- 포인트
	if tonumber(totalPoint) < 0 then	-- -일경우 이미지를 붙여준다.
		drawer:drawTexture("UIData/dungeonmsg.tga", _left-16, tStateBarY[0]+41, 16, 25, 605, 752, WIDETYPE_6)	-- -
	end
	drawer:drawTexture("UIData/dungeonmsg.tga", _right+16, tStateBarY[0]+41, 13, 25, 240, 673, WIDETYPE_6)	-- (
--	drawer:drawTexture("UIData/dungeonmsg.tga", _right+24, tStateBarY[0]+41, 20, 25, 553, 673)	-- +
	_left, _right = DrawEachNumberWide("UIData/dungeonmsg.tga", addGainedPoint, 1, tStateBarX[0]+538, tStateBarY[0]+40, 286, 672, 16, 26, 27, WIDETYPE_6)	-- +포인트
	drawer:drawTexture("UIData/dungeonmsg.tga", _right+16, tStateBarY[0]+41, 13, 25, 262, 673, WIDETYPE_6)	-- )
	
	
	-- 레벨업 글자
	if bMyLevelup == 1 then
		tLevelupY[0] = tLevelupY[0] - 3
		if tLevelupY[0] <= tLevelupY[1] then
			tLevelupY[0] = tLevelupY[1]
			g_levelupAlpha = 0
		else
			g_levelupAlpha = g_levelupAlpha - 3
			if g_levelupAlpha > 255 then
				g_levelupAlpha = 255
			elseif g_levelupAlpha <= 0 then
				g_levelupAlpha = 0
			end
			
			g_levelupEffect_Star = g_levelupEffect_Star + deltaTime
			g_levelupEffect_Star = g_levelupEffect_Star % 100
						
			if g_levelupEffect_Star < 50 then
				-- 별
				drawer:drawTextureA("UIData/ResultNewImage_2.tga", 430, tLevelupY[0]-20, 23, 22, 281, 0, g_levelupAlpha, WIDETYPE_6)
				drawer:drawTextureA("UIData/ResultNewImage_2.tga", 600, tLevelupY[0]-10, 23, 22, 281, 0, g_levelupAlpha, WIDETYPE_6)
				drawer:drawTextureA("UIData/ResultNewImage_2.tga", 380, tLevelupY[0]+30, 23, 22, 281, 0, g_levelupAlpha, WIDETYPE_6)
				drawer:drawTextureA("UIData/ResultNewImage_2.tga", 540, tLevelupY[0]+80, 23, 22, 281, 0, g_levelupAlpha, WIDETYPE_6)
			end
			
			-- 레벨업 글자
			drawer:drawTextureA("UIData/ResultNewImage_2.tga", 400, tLevelupY[0], 280, 85, 0, 0, g_levelupAlpha, WIDETYPE_6)
		end
	end	
end






----------------------------------------------------

-- 대전 보상 창(현재는 3개까지만 적용함)

----------------------------------------------------
local MAX_BATTELREWARD_COUNT = 3
local tImageSequence = {["err"]=0, [0]=197, 304, 411, 518, 625, 732, 839}
local tRewardStartTime = {["err"]=0, }
local tRewardBoxTime = {["err"]=0, }

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_RewardboxParentWindow")
mywindow:setWideType(6)
mywindow:setPosition(10, 340)
mywindow:setSize(336, 197)
mywindow:setVisible(true)
mywindow:setZOrderingEnabled(false)
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
root:addChildWindow(mywindow)

for i=0, MAX_BATTELREWARD_COUNT-1 do
	tRewardStartTime[i] = 0
	tRewardBoxTime[i] = 0
	
	-- 보상백판
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_battelRewardBoxBack_"..i)
	mywindow:setPosition(0, 0)
	mywindow:setSize(336, 197)
	mywindow:setVisible(false)
	mywindow:setZOrderingEnabled(false)
	mywindow:setTexture("Enabled", "UIData/ResultNewImage_3.tga", 688, 0)
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setAlign(8)
	winMgr:getWindow("sj_RewardboxParentWindow"):addChildWindow(mywindow)

	-- 보상 박스(애니메이션)
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_battelRewardBox_"..i)
	mywindow:setTexture("Enabled", "UIData/ResultNewImage_3.tga", 810, 197)
	mywindow:setTexture("Disabled", "UIData/ResultNewImage_3.tga", 810, 197)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(63, 44)
	mywindow:setSize(215, 107)
	mywindow:setVisible(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_RewardboxParentWindow"):addChildWindow(mywindow)

	-- 보상 아이템 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_battelRewardItemImage_"..i)
	mywindow:setPosition(112, 45)
	mywindow:setSize(128, 128)
	mywindow:setVisible(false)
	mywindow:setZOrderingEnabled(false)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setAlign(8)
	mywindow:setUserString("count", 0)
	mywindow:setSubscribeEvent("EndRender", "EndRenderRewardCount")
	winMgr:getWindow("sj_RewardboxParentWindow"):addChildWindow(mywindow)

	-- 보상 설명 텍스트
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_battelRewardItemText_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont(g_STRING_FONT_GULIM, 12)
	mywindow:setVisible(false)
	mywindow:setText("")
	mywindow:setPosition(0, 0)
	mywindow:setSize(100, 20)
	winMgr:getWindow("sj_battelRewardBox_"..i):addChildWindow(mywindow)
end

-- 보상 받는 아이템 갯수 이미지로 보여주기 위해
function EndRenderRewardCount(args)
	local window = CEGUI.toWindowEventArgs(args).window
	if window:isVisible() == true then
		local count  = tonumber(window:getUserString("count"))
		local parentWindow = window:getParent()
		local parentPos = parentWindow:getPosition()
		local position = window:getPosition()

		if count > 0 then
			local _left, _right = DrawEachNumberWide("UIData/match001.tga", count, 2, position.x.offset+144, position.y.offset+410, 822, 914, 16, 22, 16, WIDETYPE_6)
			drawer:drawTexture("UIData/match001.tga", _left-15, position.y.offset+410, 16, 22, 804, 914, WIDETYPE_6)		-- +
		end
	end
end


function WndResult_ShowPvpRewardItem(deltaTime, drawState, maxRewardCount, i, rewardType, rewardCount, rewardFileName, rewardDesc)
	if drawState == 0 then
		if rewardFileName ~= "" then
		
			-- 위치 설정(가로로 최대 3개)
			local LIMIT_X = 3
			local x = ((LIMIT_X-maxRewardCount) * 170) + (i*336)
			
			winMgr:getWindow("sj_battelRewardBoxBack_"..i):setVisible(true)
			winMgr:getWindow("sj_battelRewardBoxBack_"..i):setPosition(x, 0)
			if rewardType == 0 then
				winMgr:getWindow("sj_battelRewardBoxBack_"..i):setTexture("Enabled", "UIData/ResultNewImage_3.tga", 688, 0)
			elseif rewardType == 1 then
				winMgr:getWindow("sj_battelRewardBoxBack_"..i):setTexture("Enabled", "UIData/ResultNewImage_3.tga", 474, 827)
			else
				winMgr:getWindow("sj_battelRewardBoxBack_"..i):setTexture("Enabled", "UIData/ResultNewImage_3.tga", 688, 0)
			end
			
			winMgr:getWindow("sj_battelRewardBox_"..i):setVisible(true)
			winMgr:getWindow("sj_battelRewardBox_"..i):setPosition(x+63, 44)
			
			if tRewardStartTime[i] >= 0 then
				tRewardStartTime[i] = tRewardStartTime[i] + deltaTime
				if tRewardStartTime[i] >= 1500 then
					tRewardBoxTime[i] = tRewardBoxTime[i] + deltaTime
					local imageIndex = tRewardBoxTime[i] / 40
					if imageIndex <= #tImageSequence then
						winMgr:getWindow("sj_battelRewardBox_"..i):setTexture("Enabled", "UIData/ResultNewImage_3.tga", 810, tImageSequence[imageIndex])
						winMgr:getWindow("sj_battelRewardBox_"..i):setTexture("Disabled", "UIData/ResultNewImage_3.tga", 810, tImageSequence[imageIndex])
					else
						tRewardBoxTime[i] = 0
						tRewardStartTime[i] = -1

						winMgr:getWindow("sj_battelRewardItemImage_"..i):setVisible(true)
						winMgr:getWindow("sj_battelRewardItemImage_"..i):setTexture("Enabled", rewardFileName, 0, 0)
						winMgr:getWindow("sj_battelRewardItemImage_"..i):setPosition(x+113, 45)
						winMgr:getWindow("sj_battelRewardItemImage_"..i):setScaleWidth(200)
						winMgr:getWindow("sj_battelRewardItemImage_"..i):setScaleHeight(200)
						winMgr:getWindow("sj_battelRewardItemImage_"..i):setUserString("count", rewardCount)
						
						local textSize = GetStringSize(g_STRING_FONT_GULIM, 12, rewardItemDesc)
						winMgr:getWindow("sj_battelRewardItemText_"..i):setVisible(true)
						winMgr:getWindow("sj_battelRewardItemText_"..i):setPosition(45+textSize/2, 112)
						winMgr:getWindow("sj_battelRewardItemText_"..i):setText(rewardDesc)
					end
				end
			end
		end
	else
		winMgr:getWindow("sj_battelRewardBoxBack_"..i):setVisible(false)
		winMgr:getWindow("sj_battelRewardBox_"..i):setVisible(false)
		winMgr:getWindow("sj_battelRewardItemImage_"..i):setVisible(false)
		winMgr:getWindow("sj_battelRewardItemText_"..i):setVisible(false)
		winMgr:getWindow("sj_battelRewardItemText_"..i):setText("")
	end
end





-- EndRender
function WndGameResult_EndRender(bLuckyEvent, LuckyCount, LuckyRewardMoney, bEventOk,			-- 럭키이벤트 성공실패여부, 럭키카운트, 럭키이벤트 보상돈, 럭키이벤트 진행중인지
								LuckyRewardItemName, LuckyRewardItemFileName)					-- 럭키이벤트보상 아이템이름, 럭키이벤트보상 아이템파일이름
	-- 럭키 카운트 표시	==================================
	if bEventOk == 1 then
		local posX = 72--32
		local posY = 392
		if bLuckyEvent == 1 then		-- 럭키 이벤트에 당첨됐다
			if bLuckyCountEffectOnce then
				for i=0, 1 do
					winMgr:getWindow("sj_gameResult_luckyCountItemBack"..i):setPosition(posX, posY)
					winMgr:getWindow("sj_gameResult_luckyCountItemBack"..i):setVisible(true)
					winMgr:getWindow("sj_gameResult_luckyCountItemBack"..i):activeMotion("LuckyCountItemBackMotion")
					winMgr:getWindow("sj_gameResult_luckyCountTextBack"..i):setPosition(posX+68, posY)
					winMgr:getWindow("sj_gameResult_luckyCountTextBack"..i):setVisible(true)
					winMgr:getWindow("sj_gameResult_luckyCountTextBack"..i):activeMotion("LuckyCountTextBackMotion")
				end
				bLuckyCountEffectOnce = false
			end
			drawer:setFont(g_STRING_FONT_GULIMCHE, 14)
			common_DrawOutlineText1(drawer, String_Lucky_1, posX+150, posY+14, 140,140,140,255, 97,230,240,255, WIDETYPE_6)
			local String = string.format(String_Lucky_2, CommatoMoneyStr(LuckyCount))
			common_DrawOutlineText1(drawer, String, posX+90, posY+35, 0,0,0,255, 255,205,86,255, WIDETYPE_6)
			if LuckyRewardMoney > 0 then	-- 받는 아이템이 zen이다
				String = string.format(String_Lucky_3, CommatoMoneyStr(LuckyRewardMoney).." Zen")
				drawer:drawTextureSA("UIData/ItemUIData/item/Zen.tga", posX+8, posY+12, 120, 120, 0, 0, 148, 148, 255, 0, 0, WIDETYPE_6)		
			else							-- 일반 아이템을 받는다.
				String = string.format(String_Lucky_3, LuckyRewardItemName)
				drawer:drawTextureSA("UIData/ItemUIData/"..LuckyRewardItemFileName, posX+8, posY+12, 120, 120, 0, 0, 148, 148, 255, 0, 0, WIDETYPE_6)		
			end		
			common_DrawOutlineText1(drawer, String, posX+90, posY+56, 0,0,0,255, 255,205,86,255, WIDETYPE_6)
		else
			if bLuckyCountEffectOnce then
				for i=0, 1 do
					winMgr:getWindow("sj_gameResult_luckyCountTextBack"..i):setPosition(posX, posY)
					winMgr:getWindow("sj_gameResult_luckyCountTextBack"..i):setVisible(true)
					winMgr:getWindow("sj_gameResult_luckyCountTextBack"..i):activeMotion("LuckyCountTextBackMotion")
				end
				bLuckyCountEffectOnce = false
			end
			drawer:setFont(g_STRING_FONT_GULIMCHE, 14)
			common_DrawOutlineText1(drawer, String_Lucky_4, posX+82, posY+14, 140,140,140,255, 240,30,40,255, WIDETYPE_6)
			local String = string.format(String_Lucky_5, CommatoMoneyStr(LuckyCount))
			common_DrawOutlineText1(drawer, String, posX+16, posY+35, 0,0,0,255, 255,205,86,255, WIDETYPE_6)
			common_DrawOutlineText1(drawer, String_Lucky_6, posX+16, posY+55, 0,0,0,255, 255,205,86,255, WIDETYPE_6)
		end
	end
	--==================================================
end

-- 익스트림 1
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_gameResult_extremeImage1")
mywindow:setTexture("Enabled", "UIData/ResultNewImage_1.tga", 585, 282)
mywindow:setTexture("Disabled", "UIData/ResultNewImage_1.tga", 585, 282)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(440, 500)
mywindow:setSize(202, 114)
mywindow:setZOrderingEnabled(false)
mywindow:setEnabled(false)
mywindow:setVisible(false)
mywindow:addController("motion", "extremeAlphaMotion1", "alpha", "Sine_EaseInOut", 255, 0, 5, true, true, 10)
mywindow:addController("motion", "extremeAlphaMotion1", "alpha", "Sine_EaseInOut", 0, 255, 5, true, true, 10)
root:addChildWindow(mywindow)

-- 익스트림 2
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_gameResult_extremeImage2")
mywindow:setTexture("Enabled", "UIData/ResultNewImage_1.tga", 585, 396)
mywindow:setTexture("Disabled", "UIData/ResultNewImage_1.tga", 585, 396)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(440, 500)
mywindow:setSize(202, 114)
mywindow:setZOrderingEnabled(false)
mywindow:setEnabled(false)
mywindow:setVisible(false)
mywindow:addController("motion", "extremeAlphaMotion2", "alpha", "Sine_EaseInOut", 0, 255, 5, true, true, 10)
mywindow:addController("motion", "extremeAlphaMotion2", "alpha", "Sine_EaseInOut", 255, 0, 5, true, true, 10)
root:addChildWindow(mywindow)


function WndGameResult_MyExtremePoint(drawState, extremeZen)

	if drawState == 1 then
		winMgr:getWindow("sj_gameResult_extremeImage1"):setVisible(false)
		winMgr:getWindow("sj_gameResult_extremeImage2"):setVisible(false)
		return
	end

	-- 익스트림 모드 결과값
	if extremeZen ~= 0 then
		winMgr:getWindow("sj_gameResult_extremeImage1"):setVisible(true)
		winMgr:getWindow("sj_gameResult_extremeImage1"):activeMotion("extremeAlphaMotion1")
		winMgr:getWindow("sj_gameResult_extremeImage2"):setVisible(true)
		winMgr:getWindow("sj_gameResult_extremeImage2"):activeMotion("extremeAlphaMotion2")
	
		if extremeZen > 0 then
			_left, _right = DrawEachNumberWide("UIData/numberUi001.tga", extremeZen, 2, 560, 572, 848, 0, 16, 22, 16, WIDETYPE_6)
			drawer:drawTexture("UIData/numberUi001.tga", _left-15, 572, 16, 22, 832, 0, WIDETYPE_6)		-- +
		
		elseif extremeZen < 0 then
			_left, _right = DrawEachNumberWide("UIData/numberUi001.tga", extremeZen, 2, 560, 572, 848, 22, 16, 22, 16, WIDETYPE_6)
			drawer:drawTexture("UIData/numberUi001.tga", _left-16, 574, 16, 22, 832, 22, WIDETYPE_6)	-- -
		end
	else
		winMgr:getWindow("sj_gameResult_extremeImage1"):setVisible(false)
		winMgr:getWindow("sj_gameResult_extremeImage2"):setVisible(false)
	end
end





g_bInit	= false
tRankInfo = { ["protectErr"]=0 , 
				index		= { ["protectErr"]=0, -1, -1, -1, -1, -1, -1, -1, -1 },
				rank		= { ["protectErr"]=0, 1, 2, 3, 4, 5, 6, 7, 8 },
				enemyType	= { ["protectErr"]=0, -1, -1, -1, -1, -1, -1, -1, -1 },
				level		= { ["protectErr"]=0, -1, -1, -1, -1, -1, -1, -1, -1 },
				name		= { ["protectErr"]=0, -1, -1, -1, -1, -1, -1, -1, -1 },
				ko			= { ["protectErr"]=0, -1, -1, -1, -1, -1, -1, -1, -1 },
				down		= { ["protectErr"]=0, -1, -1, -1, -1, -1, -1, -1, -1 },
				exp			= { ["protectErr"]=0, -1, -1, -1, -1, -1, -1, -1, -1 },
				addExp		= { ["protectErr"]=0, -1, -1, -1, -1, -1, -1, -1, -1 },
				point		= { ["protectErr"]=0, -1, -1, -1, -1, -1, -1, -1, -1 },
				addPoint	= { ["protectErr"]=0, -1, -1, -1, -1, -1, -1, -1, -1 },
				levelUp		= { ["protectErr"]=0, -1, -1, -1, -1, -1, -1, -1, -1 },
				mission		= { ["protectErr"]=0, -1, -1, -1, -1, -1, -1, -1, -1 },
				disconnected= { ["protectErr"]=0, -1, -1, -1, -1, -1, -1, -1, -1 },
				wherePCRoom	= { ["protectErr"]=0, -1, -1, -1, -1, -1, -1, -1, -1 },
				event		= { ["protectErr"]=0, -1, -1, -1, -1, -1, -1, -1, -1 },
				costume		= { ["protectErr"]=0, -1, -1, -1, -1, -1, -1, -1, -1 },
				ladder		= { ["protectErr"]=0, -1, -1, -1, -1, -1, -1, -1, -1 },
				buff_EXP	= { ["protectErr"]=0, -1, -1, -1, -1, -1, -1, -1, -1 },
				buff_ZEN	= { ["protectErr"]=0, -1, -1, -1, -1, -1, -1, -1, -1 },
				icafe		= { ["protectErr"]=0, -1, -1, -1, -1, -1, -1, -1, -1 },
				extreme_ZEN	= { ["protectErr"]=0, -1, -1, -1, -1, -1, -1, -1, -1 },
				mmZp		= { ["protectErr"]=0, -1, -1, -1, -1, -1, -1, -1, -1 },
				mmLevel		= { ["protectErr"]=0, -1, -1, -1, -1, -1, -1, -1, -1 }
			}


--------------------------------------------------------------------

-- 게임 결과를 초기화한다.(랭크에 맞게 저장) 폭탄전용

--------------------------------------------------------------------
function WndGameResult_InitBombResultInfo(slot, enemyType, rank, level, name,
						ko, down, exp, addExp, point, addPoint, bLevelUp, bMission, disconnected, bWherePCRoom, bEvent, bCostume, ladder,
						buff_EXP, buff_ZEN, icafe, extreme_ZEN, gameMode)

	slot = slot + 1
	tRankInfo.index[slot]			= slot
	tRankInfo.rank[slot]			= rank
	tRankInfo.enemyType[slot]		= enemyType
	tRankInfo.level[slot]			= level
	tRankInfo.name[slot]			= name
	tRankInfo.ko[slot]				= ko
	tRankInfo.down[slot]			= down
	tRankInfo.exp[slot]				= exp
	tRankInfo.addExp[slot]			= addExp
	tRankInfo.point[slot]			= point
	tRankInfo.addPoint[slot]		= addPoint
	tRankInfo.levelUp[slot]			= bLevelUp
	tRankInfo.mission[slot]			= bMission
	tRankInfo.disconnected[slot]	= disconnected
	tRankInfo.wherePCRoom[slot]		= bWherePCRoom
	tRankInfo.event[slot]			= bEvent
	tRankInfo.costume[slot]			= bCostume
	tRankInfo.ladder[slot]			= ladder
	tRankInfo.buff_EXP[slot]		= buff_EXP
	tRankInfo.buff_ZEN[slot]		= buff_ZEN
	tRankInfo.icafe[slot]			= icafe
	tRankInfo.extreme_ZEN[slot]		= extreme_ZEN
	g_bInit	= true
end

--------------------------------------------------------------------

-- 게임 결과를 초기화한다.(랭크에 맞게 저장)

--------------------------------------------------------------------
function WndGameResult_InitResultInfo(slot, enemyType, rank, level, name,
						ko, down, exp, addExp, point, addPoint, bLevelUp, bMission, disconnected, bWherePCRoom, bEvent, bCostume, ladder,
						buff_EXP, buff_ZEN, icafe, extreme_ZEN, gameMode)
	
	if gameMode == GAMEMODE_DUALMATCH or gameMode == GAMEMODE_SINGLEMATCH then
		
		-- 듀얼모드, 일대일 대결은 인덱스로 저장한다.
		slot = slot + 1
		tRankInfo.index[slot]			= slot
		tRankInfo.rank[slot]			= rank
		tRankInfo.enemyType[slot]		= enemyType
		tRankInfo.level[slot]			= level
		tRankInfo.name[slot]			= name
		tRankInfo.ko[slot]				= ko
		tRankInfo.down[slot]			= down
		tRankInfo.exp[slot]				= exp
		tRankInfo.addExp[slot]			= addExp
		tRankInfo.point[slot]			= point
		tRankInfo.addPoint[slot]		= addPoint
		tRankInfo.levelUp[slot]			= bLevelUp
		tRankInfo.mission[slot]			= bMission
		tRankInfo.disconnected[slot]	= disconnected
		tRankInfo.wherePCRoom[slot]		= bWherePCRoom
		tRankInfo.event[slot]			= bEvent
		tRankInfo.costume[slot]			= bCostume
		tRankInfo.ladder[slot]			= ladder
		tRankInfo.buff_EXP[slot]		= buff_EXP
		tRankInfo.buff_ZEN[slot]		= buff_ZEN
		tRankInfo.icafe[slot]			= icafe
		tRankInfo.extreme_ZEN[slot]		= extreme_ZEN
		g_bInit	= true
	else
	
		-- 랭크별로 저장한다.
		tRankInfo.index[rank]			= slot
		tRankInfo.rank[rank]			= rank
		tRankInfo.enemyType[rank]		= enemyType
		tRankInfo.level[rank]			= level
		tRankInfo.name[rank]			= name
		tRankInfo.ko[rank]				= ko
		tRankInfo.down[rank]			= down
		tRankInfo.exp[rank]				= exp
		tRankInfo.addExp[rank]			= addExp
		tRankInfo.point[rank]			= point
		tRankInfo.addPoint[rank]		= addPoint
		tRankInfo.levelUp[rank]			= bLevelUp
		tRankInfo.mission[rank]			= bMission
		tRankInfo.disconnected[rank]	= disconnected
		tRankInfo.wherePCRoom[rank]		= bWherePCRoom
		tRankInfo.event[rank]			= bEvent
		tRankInfo.costume[rank]			= bCostume
		tRankInfo.ladder[rank]			= ladder
		tRankInfo.buff_EXP[rank]		= buff_EXP
		tRankInfo.buff_ZEN[rank]		= buff_ZEN
		tRankInfo.icafe[rank]			= icafe
		tRankInfo.extreme_ZEN[rank]		= extreme_ZEN
		g_bInit	= true
	end	
end






-- mvp 도장효과를 위해...
local MVP_IMAGE_POSX = 680
local MVP_IMAGE_POSY = 130
local g_mvpSoundEffect = true
local g_mvpStampEffect = true
local g_mvpEffectTime  = 0
local g_mvpTextAlpha   = 0
local g_mvpTextTime	   = 0
mvpwindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_wndGameResult_mvpImage")
mvpwindow:setWideType(6)
mvpwindow:setPosition(MVP_IMAGE_POSX, MVP_IMAGE_POSY)
mvpwindow:setSize(323, 155)
mvpwindow:setVisible(false)
mvpwindow:setTexture("Enabled", "UIData/ResultNewImage_2.tga", 324, 0)
mvpwindow:setProperty("BackgroundEnabled", "False")
mvpwindow:setProperty("FrameEnabled", "False")
root:addChildWindow(mvpwindow)


winMgr:getWindow("sj_wndGameResult_mvpImage"):addController("CommonAlertOkBoxCtrl0", "StampEffect", "xscale", "Quintic_EaseIn", 700, 255, 5, true, false, 10)
winMgr:getWindow("sj_wndGameResult_mvpImage"):addController("CommonAlertOkBoxCtrl0", "StampEffect", "yscale", "Quintic_EaseIn", 700, 255, 5, true, false, 10)
winMgr:getWindow("sj_wndGameResult_mvpImage"):addController("CommonAlertOkBoxCtrl0", "StampEffect", "xscale", "Elastic_EaseOut", 150, 255, 3, true, false, 10)
winMgr:getWindow("sj_wndGameResult_mvpImage"):addController("CommonAlertOkBoxCtrl0", "StampEffect", "yscale", "Elastic_EaseOut", 150, 255, 3, true, false, 10)
winMgr:getWindow("sj_wndGameResult_mvpImage"):setAlign(8)


g_effect		= false
descPosX		= 1030
MvpEffectTime	= 0
tLevelUpEffectTime	= { ["protectErr"]=0, 0, 0, 0, 0, 0, 0, 0, 0 }
tRankPosX			= { ["protectErr"]=0, 1230, 1430, 1630, 1830, 2030, 2230, 2430, 2630 }
tRankPosY			= { ["protectErr"]=0, 520, 550, 580, 610, 640, 670, 700, 730 }
tGoodDesc			= { ["protectErr"]=0, -850, 100 }
tBadDesc			= { ["protectErr"]=0, -750, 150 }
tMyRank				= { ["protectErr"]=0, -400, 50 }
tbuffExpTime		= { ["protectErr"]=0, 0, 0, 0, 0, 0, 0, 0, 0 }
tbuffZenTime		= { ["protectErr"]=0, 0, 0, 0, 0, 0, 0, 0, 0 }
tRankPosY_dual		= { ["protectErr"]=0, 505, 533, 563, 592, 629, 659, 688, 716 }

-- mvp점수 움직이는 시간
local MOVETIME		= 200
local g_mvpMoveTime = MOVETIME
local g_totalBonusCalc = true
local g_totalBonusExp = 0
local g_totalBonusGran = 0
local g_mvpTwinkle = false
local g_mvpShine = -1030
local g_mvpShineSound = true
local g_mvpAddBonusStart = false
local g_extremeTime = 0

-- 퍼펙트 게임
local g_perfectCount = 0
local g_perfectTime = 0
local g_perfectSound = true

-- 연승
local g_continueWinTime = 0

tTime = { ["err"]=0, [0]=515, 550, 586, 622, 657, 693, 729, 766, 801, 836 }
--------------------------------------------------------------------

-- 2번째 결과내용을 보여준다

--------------------------------------------------------------------
function WndGameResult_DrawResult(deltaTime, drawState, mySlot, bTeam, userNum, myResult, myRank, mvp, mvpExp, mvpPoint, redKill, blueKill, 
			mvpName, currentUserNum, extremeMode, bPerfectGame, continueWinTeam, oldContinueWin, continueWin, continueWinReward, 
			redTeamSceneNumber, blueTeamSceneNumber, min, sec, milliSec, winTeam)
	
	if g_bInit == false then
		return
	end
	
	if drawState == 0 then
		return
	end
	
	-- 아케이드 이용권 안보이게 하기
	winMgr:getWindow("sj_gameResult_stampArcadeTicket"):setVisible(false)
	
	-- 곡괭이 아이템 안보이게 하기
	winMgr:getWindow("sj_gameResult_stampRewardItem"):setVisible(false)

	-- 팀전 결과표기
	if bTeam == 1 then
		if PLAYMODE == GAMEMODE_MONSTER_RACING then
			local _left, _right = DrawEachNumberWide("UIData/numberUi001.tga", redTeamSceneNumber, 2, 440, 150, 270, 393, 26, 26, 27, WIDETYPE_6)	-- 레드팀 라운드
			drawer:drawTexture("UIData/numberUi001.tga", _left-114, 150, 101, 23, 270, 369, WIDETYPE_6)	-- ROUND
			
			DrawEachNumberWide("UIData/numberUi001.tga", blueTeamSceneNumber, 1, 650, 150, 270, 393, 26, 26, 27, WIDETYPE_6)	-- 블루팀 라운드
			drawer:drawTexture("UIData/numberUi001.tga", 540, 150, 101, 23, 270, 369, WIDETYPE_6)		-- ROUND
		end
		
		DrawEachNumberWide("UIData/numberUi001.tga", redKill, 2, 400, 180, 274, 521, 74, 66, 75, WIDETYPE_6)	-- 레드팀 킬수
		drawer:drawTexture("UIData/GameNewImage.tga", 494, 192, 19, 46, 561, 512, WIDETYPE_6)				-- :
		DrawEachNumberWide("UIData/numberUi001.tga", blueKill, 1, 528, 180, 274, 455, 74, 66, 75, WIDETYPE_6)	-- 블루팀 킬수
	end
	
	-- 몬스터 레이싱 시간표시
	if PLAYMODE == GAMEMODE_MONSTER_RACING then

		local startPos1	= 80
		local startPos2	= 102
		local startPosY = 310

		-- 뒷판 그리기
		drawer:drawTexture("UIData/ResultNewImage_3.tga", startPos1-6, startPosY-35, 206, 89, 412, 0, WIDETYPE_6)
		
		-- minute
		drawer:drawTexture("UIData/dungeonmsg.tga", startPos1, startPosY+4, 38, 26, tTime[min/10], 192, WIDETYPE_6)
		drawer:drawTexture("UIData/dungeonmsg.tga", startPos2, startPosY+4, 38, 26, tTime[min%10], 192, WIDETYPE_6)
		
		-- ' 과 :
		drawer:drawTexture("UIData/dungeonmsg.tga", startPos2+23, startPosY+4, 16, 26, 891, 192, WIDETYPE_6)
		drawer:drawTexture("UIData/dungeonmsg.tga", startPos2+30, startPosY+4, 16, 26, 870, 192, WIDETYPE_6)
		
		
		-- second
		drawer:drawTexture("UIData/dungeonmsg.tga", startPos1+65, startPosY+4, 38, 26, tTime[sec/10], 192, WIDETYPE_6)
		drawer:drawTexture("UIData/dungeonmsg.tga", startPos2+65, startPosY+4, 38, 26, tTime[sec%10], 192, WIDETYPE_6)
		
		-- ' 과 .
		drawer:drawTexture("UIData/dungeonmsg.tga", startPos2+23+65, startPosY+4, 16, 26, 891, 192, WIDETYPE_6)
		drawer:drawTexture("UIData/dungeonmsg.tga", startPos2+30+65, startPosY+17, 16, 13, 870, 205, WIDETYPE_6)
		
		
		-- milli second
		drawer:drawTexture("UIData/dungeonmsg.tga", startPos1+130, startPosY+4, 38, 26, tTime[milliSec/10], 192, WIDETYPE_6)
		drawer:drawTexture("UIData/dungeonmsg.tga", startPos2+130, startPosY+4, 38, 26, tTime[milliSec%10], 192, WIDETYPE_6)
		
		-- "
		drawer:drawTexture("UIData/dungeonmsg.tga", startPos2+24+130, startPosY+4, 16, 26, 911, 192, WIDETYPE_6)
	end

	
	-- 나의 랭킹 이미지
	if myRank > 0 then
		tMyRank[1] = tMyRank[1] + (deltaTime)
		if tMyRank[1] >= tMyRank[2] then
			tMyRank[1] = tMyRank[2]
			g_effect = true
		end
	end

	
	-- 결과창 정의
	local descPosY = 478
	local lastDescPosX = 80	
	descPosX = descPosX - (deltaTime*3)
	if descPosX <= lastDescPosX then
		descPosX = lastDescPosX
	end
	
	if PLAYMODE == GAMEMODE_DUALMATCH or PLAYMODE == GAMEMODE_SINGLEMATCH then
		drawer:drawTexture("UIData/GameImage_dual.tga", descPosX-81, descPosY-14, 1024, 295, 0, 729, WIDETYPE_6)
		
		if winTeam == 0 then
			drawer:drawTexture("UIData/GameImage_dual.tga", descPosX-81, descPosY+22, 1024, 124, 0, 481, WIDETYPE_6)
			drawer:drawTexture("UIData/GameImage_dual.tga", descPosX-81, descPosY+146, 1024, 124, 0, 605, WIDETYPE_6)
		else
			drawer:drawTexture("UIData/GameImage_dual.tga", descPosX-81, descPosY+22, 1024, 124, 0, 605, WIDETYPE_6)
			drawer:drawTexture("UIData/GameImage_dual.tga", descPosX-81, descPosY+146, 1024, 124, 0, 481, WIDETYPE_6)
		end
	else
		drawer:drawTexture("UIData/ResultNewImage_1.tga", descPosX-4, descPosY, 929, 280, 0, 0, WIDETYPE_6)	
		if PLAYMODE == GAMEMODE_COINMATCH then
		
			drawer:drawTexture("UIData/ResultNewImage_1.tga", descPosX-4+ 291, descPosY + 7, 99, 33, 925, 0, WIDETYPE_6)		
		
		
		end
		
	end
		
	if PLAYMODE ~= GAMEMODE_DUALMATCH and PLAYMODE ~= GAMEMODE_SINGLEMATCH then
		-- 익스트림 시간
		if extremeMode == BATTLETYPE_EXTREME then
			drawer:drawTexture("UIData/ResultNewImage_1.tga", descPosX+656, descPosY+9, 78, 22, 699, 711, WIDETYPE_6)
			g_extremeTime = g_extremeTime + deltaTime
			g_extremeTime = g_extremeTime % 200
		end
		
		-- 퍼펙트 불꽃효과
		if bPerfectGame == 1 then
			if g_perfectSound then
				g_perfectSound = false
				PlaySound("sound/System/System_Perfect.wav")
			end
			drawer:drawTexture("UIData/Perfect.tga", 200, 20, 622, 101, 0, g_perfectCount*101, WIDETYPE_6)
			drawer:drawTexture("UIData/Perfect.tga", 310, 126, 294, 75, 622, g_perfectCount*75, WIDETYPE_6)
			g_perfectTime = g_perfectTime + deltaTime
			if g_perfectTime >= 100 then
				g_perfectCount = g_perfectCount + 1
				if g_perfectCount >= 9 then
					g_perfectCount = 0
				end
			end
		end
	end
	
	-- 연승이냐 연승격파냐;;
	if continueWin >= 2 or oldContinueWin >= 2 then
		
		-- 연승바탕 이미지
		g_continueWinTime = g_continueWinTime + deltaTime
		g_continueWinTime = g_continueWinTime % 200
		if g_continueWinTime < 100 then
			drawer:drawTexture("UIData/match001.tga", descPosX+444, 434, 453, 39, 257, 768, WIDETYPE_6)
		else
			drawer:drawTexture("UIData/match001.tga", descPosX+444, 434, 453, 39, 257, 865, WIDETYPE_6)
		end
		
		-- 어느팀인지
		if continueWinTeam == 0 then
			drawer:drawTexture("UIData/match001.tga", descPosX+455, 444, 60, 19, 789, 941, WIDETYPE_6)
		elseif continueWinTeam == 1 then
			drawer:drawTexture("UIData/match001.tga", descPosX+455, 444, 60, 19, 849, 941, WIDETYPE_6)
		end
		
		-- 몇연승중이냐
		if continueWin > oldContinueWin then
			DrawEachNumberWide("UIData/match001.tga", continueWin, 2, descPosX+618, 442, 822, 914, 15, 22, 16, WIDETYPE_6)		-- 몇연승
			drawer:drawTexture("UIData/match001.tga", descPosX+633, 438, 130, 29, 580, 807, WIDETYPE_6)	-- 연승중
		
		-- 몇연승격파냐
		elseif continueWin < oldContinueWin then
			DrawEachNumberWide("UIData/match001.tga", oldContinueWin, 2, descPosX+618, 442, 822, 914, 15, 22, 16, WIDETYPE_6)	-- 몇연승
			drawer:drawTexture("UIData/match001.tga", descPosX+633, 438, 130, 29, 580, 836, WIDETYPE_6)	-- 연승격파
		end
		
		-- 연승보상
		drawer:drawTexture("UIData/match001.tga", descPosX+794, 442, 16, 22, 806, 914, WIDETYPE_6)	-- +
		DrawEachNumberWide("UIData/match001.tga", continueWinReward, 1, descPosX+808, 442, 822, 914, 15, 22, 16, WIDETYPE_6)		
	end
	
	-- 플레이어의 결과창
	if PLAYMODE == GAMEMODE_DUALMATCH or PLAYMODE == GAMEMODE_SINGLEMATCH then
		userNum = 8 -- 듀얼매치는 모두
	end
	local lastPosX = 82
	for i=1, userNum do
		if PLAYMODE ~= GAMEMODE_DUALMATCH and PLAYMODE ~= GAMEMODE_SINGLEMATCH then
			if tRankInfo.rank[i] >= 0 then
				tRankPosX[i] = tRankPosX[i] - (deltaTime*2)
				if tRankPosX[i] <= lastPosX then
					tRankPosX[i] = lastPosX
				end
			
				-------------------------
				-- 배경바
				-------------------------
				if bTeam == 0 then
					drawer:drawTexture("UIData/ResultNewImage_2.tga", tRankPosX[i], tRankPosY[tRankInfo.rank[i]]-2, 924, 26, 9, 422, WIDETYPE_6)
				else
					if tRankInfo.enemyType[i] == 0 then
						drawer:drawTexture("UIData/ResultNewImage_2.tga", tRankPosX[i], tRankPosY[tRankInfo.rank[i]]-2, 924, 24, 9, 453, WIDETYPE_6)
					else
						drawer:drawTexture("UIData/ResultNewImage_2.tga", tRankPosX[i], tRankPosY[tRankInfo.rank[i]]-2, 924, 24, 9, 484, WIDETYPE_6)
					end
				end
				
				-------------------------
				-- 순위
				-------------------------
				DrawEachNumberWide("UIData/numberUi001.tga", i-1, 1, tRankPosX[i]+10, tRankPosY[tRankInfo.rank[i]]-1, 307, 110, 23, 23, 23, WIDETYPE_6)
		
				-------------------------
				-- 케릭터(레벨, 래더), 한국은 제외
				-------------------------
				drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
				drawer:setTextColor(255,255,255,255)
				local levelText
				if tRankInfo.level[i] < 10 then
					levelText = "Lv. "
				else
					levelText = "Lv."
				end
				-- 레벨
				if tRankInfo.index[i] == mySlot then
					common_DrawOutlineText1(drawer, levelText .. tRankInfo.level[i], tRankPosX[i]+48, tRankPosY[tRankInfo.rank[i]]+5, 0,0,0,255, 255,205,86,255, WIDETYPE_6)
				else
					drawer:drawText(levelText .. tRankInfo.level[i], tRankPosX[i]+48, tRankPosY[tRankInfo.rank[i]]+5, WIDETYPE_6)
				end
				
				-- 래더
				drawer:drawTexture("UIData/numberUi001.tga", tRankPosX[i]+118, tRankPosY[tRankInfo.rank[i]]-1, 47, 21, 113, 600+21*tRankInfo.ladder[i], WIDETYPE_6)
				
				-- 이름
				local nameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(tRankInfo.name[i]))
				if tRankInfo.index[i] == mySlot then
					common_DrawOutlineText1(drawer, tRankInfo.name[i], tRankPosX[i]+222-nameSize/2, tRankPosY[tRankInfo.rank[i]]+5, 0,0,0,255, 255,205,86,255, WIDETYPE_6)
				else
					drawer:drawText(tRankInfo.name[i], tRankPosX[i]+222-nameSize/2, tRankPosY[tRankInfo.rank[i]]+5, WIDETYPE_6)
				end
				
				-------------------------
				-- KO/DOWN, disconnected
				-------------------------
				
				if PLAYMODE == GAMEMODE_COINMATCH then
		
		
					-- KO(오른쪽 정렬)
					local size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(tRankInfo.ko[i]))
					if tRankInfo.index[i] == mySlot then
						common_DrawOutlineText1(drawer, tRankInfo.ko[i], tRankPosX[i]+326-size+ 20, tRankPosY[tRankInfo.rank[i]]+5, 0,0,0,255, 255,205,86,255, WIDETYPE_6)
					else
						drawer:drawText(tRankInfo.ko[i], tRankPosX[i]+326-size, tRankPosY[tRankInfo.rank[i]]+5, WIDETYPE_6)
					end
					
				
					
		
		
				else
				
					-- KO(오른쪽 정렬)
					local size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(tRankInfo.ko[i]))
					if tRankInfo.index[i] == mySlot then
						common_DrawOutlineText1(drawer, tRankInfo.ko[i], tRankPosX[i]+326-size, tRankPosY[tRankInfo.rank[i]]+5, 0,0,0,255, 255,205,86,255, WIDETYPE_6)
					else
						drawer:drawText(tRankInfo.ko[i], tRankPosX[i]+326-size, tRankPosY[tRankInfo.rank[i]]+5, WIDETYPE_6)
					end
					
					-- DOWN(왼쪽 정렬)
					if tRankInfo.index[i] == mySlot then
						common_DrawOutlineText1(drawer, tRankInfo.down[i], tRankPosX[i]+356, tRankPosY[tRankInfo.rank[i]]+5, 0,0,0,255, 255,205,86,255, WIDETYPE_6)
					else
						drawer:drawText(tRankInfo.down[i], tRankPosX[i]+356, tRankPosY[tRankInfo.rank[i]]+5, WIDETYPE_6)
					end
					
					
				
				end
		
			
				
				-- disconnected
				if tRankInfo.disconnected[i] == 1 then
					drawer:drawTexture("UIData/GameNewImage.tga", tRankPosX[i]+302, tRankPosY[tRankInfo.rank[i]]+2, 74, 14, 2, 190, WIDETYPE_6)
				end


				-- MVP 추가 보너스를 +한다.
				if g_totalBonusCalc then
					g_totalBonusCalc = false
					
					if mvp > 0 then
						g_totalBonusExp  = tRankInfo.addExp[mvp]+mvpExp
						g_totalBonusGran = tRankInfo.addPoint[mvp]+mvpPoint
					end
				end
				
				if g_mvpAddBonusStart then
					if mvp > 0 then
						tRankInfo.addExp[mvp] = tRankInfo.addExp[mvp] + 1
						if tRankInfo.addExp[mvp] >= g_totalBonusExp then
							tRankInfo.addExp[mvp] = g_totalBonusExp
						end
						
						tRankInfo.addPoint[mvp] = tRankInfo.addPoint[mvp] + 1
						if tRankInfo.addPoint[mvp] >= g_totalBonusGran then
							tRankInfo.addPoint[mvp] = g_totalBonusGran
						end
					end
				end				
			
				-------------------------
				-- 버프(경험치, ZEN)
				-------------------------
				if tRankInfo.buff_EXP[i] > 0 then
					tbuffExpTime[i] = tbuffExpTime[i] + deltaTime
					tbuffExpTime[i] = tbuffExpTime[i] % 400
					if tbuffExpTime[i] > 200 then
						drawer:drawTextureWithScale_Angle_Offset("UIData/mainBG_button002.tga", tRankPosX[i]+504, tRankPosY[tRankInfo.rank[i]]+9, 32, 32, 320, 788, 190, 190, 255, 0, 8, 100, 0, WIDETYPE_6)
					else
						drawer:drawTextureWithScale_Angle_Offset("UIData/mainBG_button002.tga", tRankPosX[i]+504, tRankPosY[tRankInfo.rank[i]]+12, 32, 32, 320, 788, 190, 190, 255, 0, 8, 100, 0, WIDETYPE_6)
					end
				end
				
				if tRankInfo.buff_ZEN[i] > 0 then
					tbuffZenTime[i] = tbuffZenTime[i] + deltaTime
					tbuffZenTime[i] = tbuffZenTime[i] % 400
					if tbuffZenTime[i] > 200 then
						drawer:drawTextureWithScale_Angle_Offset("UIData/mainBG_button002.tga", tRankPosX[i]+622, tRankPosY[tRankInfo.rank[i]]+9, 32, 32, 352, 788, 190, 190, 255, 0, 8, 100, 0, WIDETYPE_6)
					else
						drawer:drawTextureWithScale_Angle_Offset("UIData/mainBG_button002.tga", tRankPosX[i]+622, tRankPosY[tRankInfo.rank[i]]+12, 32, 32, 352, 788, 190, 190, 255, 0, 8, 100, 0, WIDETYPE_6)
					end
				end	
			
				-------------------------
				-- 경험치
				-------------------------
				local _curExp = tRankInfo.exp[i]
				local _curExpSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, _curExp)
				local _addExp = "("..tRankInfo.addExp[i]..")"
				
				-------------------------
				-- 포인트
				-------------------------
				local _curGran = tRankInfo.point[i]
				local _curGranSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, _curGran)
				local _addGran = "("..tRankInfo.addPoint[i]..")"
				
				
				if tRankInfo.index[i] == mySlot then
					-- 경험치
					common_DrawOutlineText1(drawer, _curExp, tRankPosX[i]+446-_curExpSize, tRankPosY[tRankInfo.rank[i]]+5, 0,0,0,255, 255,205,86,255, WIDETYPE_6)
					common_DrawOutlineText1(drawer, _addExp, tRankPosX[i]+448, tRankPosY[tRankInfo.rank[i]]+5, 0,0,0,255, 0,255,0,255, WIDETYPE_6)
					
					-- 그랑
					common_DrawOutlineText1(drawer, _curGran, tRankPosX[i]+564-_curGranSize, tRankPosY[tRankInfo.rank[i]]+5, 0,0,0,255, 255,205,86,255, WIDETYPE_6)
					common_DrawOutlineText1(drawer, _addGran, tRankPosX[i]+566, tRankPosY[tRankInfo.rank[i]]+5, 0,0,0,255, 0,255,0,255, WIDETYPE_6)
				else
					drawer:drawText(tRankInfo.exp[i], tRankPosX[i]+446-_curExpSize, tRankPosY[tRankInfo.rank[i]]+5, WIDETYPE_6)	-- 경험치
					drawer:drawText(_curGran, tRankPosX[i]+564-_curGranSize, tRankPosY[tRankInfo.rank[i]]+5, WIDETYPE_6)		-- 그랑
					
					drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
					drawer:setTextColor(0,255,0,255)
					drawer:drawText(_addExp, tRankPosX[i]+448, tRankPosY[tRankInfo.rank[i]]+5, WIDETYPE_6)	-- 보너스 경험치				
					drawer:drawText(_addGran, tRankPosX[i]+566, tRankPosY[tRankInfo.rank[i]]+5, WIDETYPE_6)	-- 보너스 그랑
				end
			
			
				local BONUS_X = 646
				drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
				drawer:setTextColor(255,255,255,255)
				-------------------------
				-- 보너스(미션, 아이템, PC방, 이벤트)
				-------------------------
				drawer:drawTexture("UIData/ResultNewImage_2.tga", tRankPosX[i]+BONUS_X+120, tRankPosY[tRankInfo.rank[i]]-3, 45, 27, 795, 83, WIDETYPE_6)
				drawer:drawTexture("UIData/ResultNewImage_2.tga", tRankPosX[i]+BONUS_X+158, tRankPosY[tRankInfo.rank[i]]-3, 52, 27, 840, 83, WIDETYPE_6)
				drawer:drawTexture("UIData/ResultNewImage_2.tga", tRankPosX[i]+BONUS_X+200, tRankPosY[tRankInfo.rank[i]]-3, 48, 27, 976, 83, WIDETYPE_6)
			--	drawer:drawTexture("UIData/ResultNewImage_2.tga", tRankPosX[i]+BONUS_X+107, tRankPosY[tRankInfo.rank[i]]-3, 84, 27, 892, 83) -- PC방
			--	drawer:drawTextureSA("UIData/LobbyImage_new.tga", tRankPosX[i]+BONUS_X+146, tRankPosY[tRankInfo.rank[i]]-2, 64, 45, 793, 235, 128, 128, 255, 0, 0) -- icafe
				
				-- 몬스터 레이싱일 경우
				if PLAYMODE == GAMEMODE_MONSTER_RACING then
					drawer:drawTexture("UIData/ResultNewImage_2.tga", tRankPosX[i]+BONUS_X+68, tRankPosY[tRankInfo.rank[i]]-4, 55, 26, 909, 57, WIDETYPE_6)
				end 
				
				if IsKoreanLanguage() then
					-- 미션
					if tRankInfo.mission[i] == 1 then
						drawer:drawTexture("UIData/ResultNewImage_2.tga", tRankPosX[i]+BONUS_X+118, tRankPosY[tRankInfo.rank[i]]-4, 45, 27, 795, 56, WIDETYPE_6)
					end
					
					-- 아이템
					if tRankInfo.costume[i] == 1 or tRankInfo.buff_EXP[i] > 0 or tRankInfo.buff_ZEN[i] > 0 then
						drawer:drawTexture("UIData/ResultNewImage_2.tga", tRankPosX[i]+BONUS_X+156, tRankPosY[tRankInfo.rank[i]]-4, 52, 27, 840, 56, WIDETYPE_6)
					end
					
					-- 이벤트
					if tRankInfo.event[i] == 1 then
						drawer:drawTexture("UIData/ResultNewImage_2.tga", tRankPosX[i]+BONUS_X+198, tRankPosY[tRankInfo.rank[i]]-4, 48, 27, 976, 56, WIDETYPE_6)
					end
				else
						-- 미션
					if tRankInfo.mission[i] == 1 then
						drawer:drawTexture("UIData/ResultNewImage_2.tga", tRankPosX[i]+BONUS_X+120, tRankPosY[tRankInfo.rank[i]]-4, 45, 27, 795, 56, WIDETYPE_6)
					end
					
					-- 아이템
					if tRankInfo.costume[i] == 1 or tRankInfo.buff_EXP[i] > 0 or tRankInfo.buff_ZEN[i] > 0 then
						drawer:drawTexture("UIData/ResultNewImage_2.tga", tRankPosX[i]+BONUS_X+158, tRankPosY[tRankInfo.rank[i]]-4, 52, 27, 840, 56, WIDETYPE_6)
					end
					
					-- 이벤트
					if tRankInfo.event[i] == 1 then
						drawer:drawTexture("UIData/ResultNewImage_2.tga", tRankPosX[i]+BONUS_X+200, tRankPosY[tRankInfo.rank[i]]-4, 48, 27, 976, 56, WIDETYPE_6)
					end
				end
				
				-- PC방
				--if tRankInfo.wherePCRoom[i] == 1 then
				--	drawer:drawTexture("UIData/ResultNewImage_2.tga", tRankPosX[i]+BONUS_X+107, tRankPosY[tRankInfo.rank[i]]-4, 84, 27, 892, 56)
				--end
				
				-- icafe
				if tRankInfo.icafe[i] == 1 then
					drawer:drawTextureSA("UIData/LobbyImage_new.tga", tRankPosX[i]+BONUS_X+242, tRankPosY[tRankInfo.rank[i]]-2, 64, 45, 729, 235, 128, 128, 255, 0, 0, WIDETYPE_6)
					
				elseif tRankInfo.icafe[i] == 2 then
					drawer:drawTextureSA("UIData/LobbyImage_new.tga", tRankPosX[i]+BONUS_X+242, tRankPosY[tRankInfo.rank[i]]-2, 64, 45, 665, 235, 128, 128, 255, 0, 0, WIDETYPE_6)
				end	


				-- 익스트림 모드일 경우
				drawer:setFont(g_STRING_FONT_GULIMCHE, 14)
				if extremeMode == BATTLETYPE_EXTREME then
					if g_extremeTime < 100 then
						if tRankInfo.extreme_ZEN[i] > 0 then
							_left, _right = DrawEachNumberWide("UIData/dungeonmsg.tga", tRankInfo.extreme_ZEN[i], 8, tRankPosX[i]+680, tRankPosY[tRankInfo.rank[i]]+2, 28, 666, 12, 15, 14, WIDETYPE_6)
							drawer:drawTexture("UIData/dungeonmsg.tga", _left-15, tRankPosY[tRankInfo.rank[i]]+3, 14, 15, 0, 666, WIDETYPE_6)	-- +
							
						elseif tRankInfo.extreme_ZEN[i] < 0 then
							_left, _right = DrawEachNumberWide("UIData/dungeonmsg.tga", tRankInfo.extreme_ZEN[i], 8, tRankPosX[i]+680, tRankPosY[tRankInfo.rank[i]]+2, 28, 681, 12, 15, 14, WIDETYPE_6)
							drawer:drawTexture("UIData/dungeonmsg.tga", _left-15, tRankPosY[tRankInfo.rank[i]]+2, 14, 15, 14, 681, WIDETYPE_6)	-- -
						end
					else
						if tRankInfo.extreme_ZEN[i] > 0 then
							_left, _right = DrawEachNumberWide("UIData/dungeonmsg.tga", tRankInfo.extreme_ZEN[i], 8, tRankPosX[i]+680, tRankPosY[tRankInfo.rank[i]]+2, 28, 696, 12, 15, 14, WIDETYPE_6)
							drawer:drawTexture("UIData/dungeonmsg.tga", _left-15, tRankPosY[tRankInfo.rank[i]]+3, 14, 15, 0, 696, WIDETYPE_6)	-- +
							
						elseif tRankInfo.extreme_ZEN[i] < 0 then
							_left, _right = DrawEachNumberWide("UIData/dungeonmsg.tga", tRankInfo.extreme_ZEN[i], 8, tRankPosX[i]+680, tRankPosY[tRankInfo.rank[i]]+2, 28, 681, 12, 15, 14, WIDETYPE_6)
							drawer:drawTexture("UIData/dungeonmsg.tga", _left-15, tRankPosY[tRankInfo.rank[i]]+2, 14, 15, 14, 681, WIDETYPE_6)	-- -
						end
					end
				end
								
				-------------------------------
				-- 나를 구분하기 위한 테두리
				-------------------------------
				if tRankInfo.index[i] == mySlot then
					drawer:drawTexture("UIData/ResultNewImage_2.tga", tRankPosX[i], tRankPosY[myRank]-6, 924, 32, 8, 515, WIDETYPE_6)
				end
				
			end
		else
			lastPosX = 104
			if tRankInfo.index[i] >= 0 then
				tRankPosX[i] = tRankPosX[i] - (deltaTime*2)
				if tRankPosX[i] <= lastPosX then
					tRankPosX[i] = lastPosX
				end
				
				-------------------------
				-- 케릭터(레벨, 이름)
				-------------------------
				drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
				drawer:setTextColor(255,255,255,255)
				local levelText
				if tRankInfo.level[i] < 10 then
					levelText = "Lv. "
				else
					levelText = "Lv."
				end
				-- 레벨
				if tRankInfo.index[i] == mySlot+1 then
					common_DrawOutlineText1(drawer, levelText .. tRankInfo.level[i], tRankPosX[i]+48, tRankPosY_dual[i]+7, 0,0,0,255, 255,205,86,255, WIDETYPE_6)
				else
					drawer:drawText(levelText .. tRankInfo.level[i], tRankPosX[i]+48, tRankPosY_dual[i]+7, WIDETYPE_6)
				end
				
				-- 래더
				drawer:drawTexture("UIData/numberUi001.tga", tRankPosX[i]+98, tRankPosY_dual[i]-1, 47, 21, 113, 600+21*tRankInfo.ladder[i], WIDETYPE_6)
					
				-- 이름
				local nameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(tRankInfo.name[i]))
				if tRankInfo.index[i] == mySlot+1 then
					common_DrawOutlineText1(drawer, tRankInfo.name[i], tRankPosX[i]+238-nameSize/2, tRankPosY_dual[i]+7, 0,0,0,255, 255,205,86,255, WIDETYPE_6)
				else
					drawer:drawText(tRankInfo.name[i], tRankPosX[i]+238-nameSize/2, tRankPosY_dual[i]+7, WIDETYPE_6)
				end
				
				-------------------------
				-- KO/DOWN, disconnected
				-------------------------
				-- KO(오른쪽 정렬)
				local size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(tRankInfo.ko[i]))
				if tRankInfo.index[i] == mySlot+1 then
					common_DrawOutlineText1(drawer, tRankInfo.ko[i], tRankPosX[i]+356-size, tRankPosY_dual[i]+7, 0,0,0,255, 255,205,86,255, WIDETYPE_6)
				else
					drawer:drawText(tRankInfo.ko[i], tRankPosX[i]+356-size, tRankPosY_dual[i]+7, WIDETYPE_6)
				end
				
				-- disconnected
				if tRankInfo.disconnected[i] == 1 then
					drawer:drawTexture("UIData/GameNewImage.tga", tRankPosX[i]+202, tRankPosY_dual[i]+4, 74, 14, 2, 190, WIDETYPE_6)
				end
			
				-------------------------
				-- 버프(경험치, ZEN)
				-------------------------
				if tRankInfo.buff_EXP[i] > 0 then
					tbuffExpTime[i] = tbuffExpTime[i] + deltaTime
					tbuffExpTime[i] = tbuffExpTime[i] % 400
					if tbuffExpTime[i] > 200 then
						drawer:drawTextureWithScale_Angle_Offset("UIData/mainBG_button002.tga", tRankPosX[i]+504, tRankPosY_dual[i]+9, 32, 32, 320, 788, 190, 190, 255, 0, 8, 100, 0, WIDETYPE_6)
					else
						drawer:drawTextureWithScale_Angle_Offset("UIData/mainBG_button002.tga", tRankPosX[i]+504, tRankPosY_dual[i]+12, 32, 32, 320, 788, 190, 190, 255, 0, 8, 100, 0, WIDETYPE_6)
					end
				end
				
				if tRankInfo.buff_ZEN[i] > 0 then
					tbuffZenTime[i] = tbuffZenTime[i] + deltaTime
					tbuffZenTime[i] = tbuffZenTime[i] % 400
					if tbuffZenTime[i] > 200 then
						drawer:drawTextureWithScale_Angle_Offset("UIData/mainBG_button002.tga", tRankPosX[i]+618, tRankPosY_dual[i]+9, 32, 32, 352, 788, 190, 190, 255, 0, 8, 100, 0, WIDETYPE_6)
					else
						drawer:drawTextureWithScale_Angle_Offset("UIData/mainBG_button002.tga", tRankPosX[i]+618, tRankPosY_dual[i]+12, 32, 32, 352, 788, 190, 190, 255, 0, 8, 100, 0, WIDETYPE_6)
					end
				end	
			
				-------------------------
				-- 경험치
				-------------------------
				local _curExp = tRankInfo.exp[i]
				local _curExpSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, _curExp)
				local _addExp = "("..tRankInfo.addExp[i]..")"
				
				-------------------------
				-- 포인트
				-------------------------
				local _curGran = tRankInfo.point[i]
				local _curGranSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, _curGran)
				local _addGran = "("..tRankInfo.addPoint[i]..")"
				
				
				if tRankInfo.index[i] == mySlot+1 then
					-- 경험치
					common_DrawOutlineText1(drawer, _curExp, tRankPosX[i]+446-_curExpSize, tRankPosY_dual[i]+7, 0,0,0,255, 255,205,86,255, WIDETYPE_6)
					common_DrawOutlineText1(drawer, _addExp, tRankPosX[i]+448, tRankPosY_dual[i]+7, 0,0,0,255, 0,255,0,255, WIDETYPE_6)
					
					-- 그랑
					common_DrawOutlineText1(drawer, _curGran, tRankPosX[i]+564-_curGranSize, tRankPosY_dual[i]+7, 0,0,0,255, 255,205,86,255, WIDETYPE_6)
					common_DrawOutlineText1(drawer, _addGran, tRankPosX[i]+566, tRankPosY_dual[i]+7, 0,0,0,255, 0,255,0,255, WIDETYPE_6)
				else
					drawer:drawText(tRankInfo.exp[i], tRankPosX[i]+446-_curExpSize, tRankPosY_dual[i]+7, WIDETYPE_6)	-- 경험치
					drawer:drawText(_curGran, tRankPosX[i]+564-_curGranSize, tRankPosY_dual[i]+7, WIDETYPE_6)		-- 그랑
					
					drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
					drawer:setTextColor(0,255,0,255)
					drawer:drawText(_addExp, tRankPosX[i]+448, tRankPosY_dual[i]+7, WIDETYPE_6)	-- 보너스 경험치				
					drawer:drawText(_addGran, tRankPosX[i]+566, tRankPosY_dual[i]+7, WIDETYPE_6)	-- 보너스 그랑
				end
				
				local BONUS_X = 550
				drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
				drawer:setTextColor(255,255,255,255)
				-------------------------
				-- 보너스(미션, 아이템, PC방, 이벤트)
				-------------------------
				drawer:drawTexture("UIData/GameImage_dual.tga", tRankPosX[i]+BONUS_X+85, tRankPosY_dual[i], 55, 24, 165, 415, WIDETYPE_6)
				drawer:drawTexture("UIData/GameImage_dual.tga", tRankPosX[i]+BONUS_X+140, tRankPosY_dual[i], 55, 24, 55, 415, WIDETYPE_6)
				drawer:drawTexture("UIData/GameImage_dual.tga", tRankPosX[i]+BONUS_X+195, tRankPosY_dual[i], 55, 24, 110, 415, WIDETYPE_6)
			--	drawer:drawTexture("UIData/GameImage_dual.tga", tRankPosX[i]+BONUS_X+250, tRankPosY_dual[i], 55, 24, 0, 415, WIDETYPE_6) -- PC방
			--	drawer:drawTextureSA("UIData/GameImage_dual.tga", tRankPosX[i]+BONUS_X+146, tRankPosY_dual[i], 64, 45, 793, 235, 128, 128, 255, 0, 0) -- icafe

				-- 미션
				if tRankInfo.mission[i] == 1 then
					drawer:drawTexture("UIData/GameImage_dual.tga", tRankPosX[i]+BONUS_X+85, tRankPosY_dual[i], 55, 24, 165, 391, WIDETYPE_6)
				end
				
				-- 아이템
				if tRankInfo.costume[i] == 1 or tRankInfo.buff_EXP[i] > 0 or tRankInfo.buff_ZEN[i] > 0 then
					drawer:drawTexture("UIData/GameImage_dual.tga", tRankPosX[i]+BONUS_X+140, tRankPosY_dual[i], 55, 24, 55, 391, WIDETYPE_6)
				end
				
				-- 이벤트
				if tRankInfo.event[i] == 1 then
					drawer:drawTexture("UIData/GameImage_dual.tga", tRankPosX[i]+BONUS_X+195, tRankPosY_dual[i], 55, 24, 110, 391, WIDETYPE_6)
				end
			
				-- PC방
				--if tRankInfo.wherePCRoom[i] == 1 then
				--	drawer:drawTexture("UIData/GameImage_dual.tga", tRankPosX[i]+BONUS_X+250, tRankPosY_dual[i], 55, 24, 0, 391, WIDETYPE_6)
				--end
				
				-- icafe
				if tRankInfo.icafe[i] == 1 then
					drawer:drawTextureSA("UIData/LobbyImage_new.tga", tRankPosX[i]+BONUS_X+260, tRankPosY_dual[i]+1, 64, 45, 729, 235, 128, 128, 255, 0, 0, WIDETYPE_6)
					
				elseif tRankInfo.icafe[i] == 2 then
					drawer:drawTextureSA("UIData/LobbyImage_new.tga", tRankPosX[i]+BONUS_X+260, tRankPosY_dual[i]+1, 64, 45, 665, 235, 128, 128, 255, 0, 0, WIDETYPE_6)
				end
				
				-------------------------------
				-- 나를 구분하기 위한 테두리
				-------------------------------
				if tRankInfo.index[i] == mySlot+1 then
					drawer:drawTexture("UIData/ResultNewImage_2.tga", tRankPosX[i]-40, tRankPosY_dual[i]-4, 924, 32, 8, 515, WIDETYPE_6)
				end
			end
			
			if PLAYMODE == GAMEMODE_DUALMATCH or PLAYMODE == GAMEMODE_SINGLEMATCH then
				if winTeam == 0 then
					-- win, lose
					drawer:drawTexture("UIData/GameImage_dual.tga", descPosX-78, descPosY+20, 152, 42, 234, 439, WIDETYPE_6)
					drawer:drawTexture("UIData/GameImage_dual.tga", descPosX-78, descPosY+144, 152, 42, 385, 397, WIDETYPE_6)
				else
					-- win, lose
					drawer:drawTexture("UIData/GameImage_dual.tga", descPosX-78, descPosY+20, 152, 42, 234, 397, WIDETYPE_6)
					drawer:drawTexture("UIData/GameImage_dual.tga", descPosX-78, descPosY+144, 152, 42, 385, 439, WIDETYPE_6)
				end
			end
		end
	end
		
	if PLAYMODE ~= GAMEMODE_DUALMATCH and PLAYMODE ~= GAMEMODE_SINGLEMATCH then
	
		if g_effect then	
			-- MVP는 5명부터 적용된다.
			local MVPCOUNT = 5
			if IsKoreanLanguage() then
				if GetIsAutoMatch() == 1 then
					MVPCOUNT = 4
				end
			end
			if currentUserNum >= MVPCOUNT then
				if mvp > 0 then
					if g_mvpSoundEffect then
						PlaySound("sound/GameResult_MVP.wav")
						g_mvpSoundEffect = false
					end
					
					if g_mvpStampEffect then
						winMgr:getWindow("sj_wndGameResult_mvpImage"):setVisible(true)
						winMgr:getWindow("sj_wndGameResult_mvpImage"):activeMotion("StampEffect")

						g_mvpEffectTime = g_mvpEffectTime + deltaTime
						if g_mvpEffectTime >= 800 then
							g_mvpEffectTime  = 0
							g_mvpStampEffect = false
						end
					else

						-- 오른쪽 큰 MVP 밑바탕
						winMgr:getWindow("sj_wndGameResult_mvpImage"):setVisible(false)
						drawer:drawTexture("UIData/ResultNewImage_2.tga", MVP_IMAGE_POSX, MVP_IMAGE_POSY, 323, 155, 324, 0, WIDETYPE_6)
						
						-- 오른쪽 큰 MVP 케릭터 이름
						g_mvpTextTime = g_mvpTextTime + deltaTime
						g_mvpTextAlpha = g_mvpTextTime * 255 / 100
						if g_mvpTextAlpha >= 255 then
							g_mvpTextAlpha = 255
						end
						
						-- mvp보너스 점수 움직이기
						local nMvpMoveX = 0
						local nMvpMoveY = 0
						if g_mvpTextTime >= 2000 then
							
							g_mvpMoveTime = g_mvpMoveTime - deltaTime/2
							if g_mvpMoveTime <= 0 then
								g_mvpMoveTime = 0
							end
							
							if g_mvpMoveTime > 0 then
								nMvpMoveX = (((tRankPosX[mvp] - 64)*(MOVETIME-g_mvpMoveTime))/MOVETIME) + (((MVP_IMAGE_POSX+170)*g_mvpMoveTime)/MOVETIME)
								nMvpMoveY = (((tRankPosY[mvp] - 14)*(MOVETIME-g_mvpMoveTime))/MOVETIME) + (((MVP_IMAGE_POSY+30)*g_mvpMoveTime)/MOVETIME)
							
							elseif g_mvpMoveTime == 0 then
								nMvpMoveX = tRankPosX[mvp] - 64
								nMvpMoveY = tRankPosY[mvp] - 14
								g_mvpTwinkle = true
							end
						else
							nMvpMoveX = MVP_IMAGE_POSX+170
							nMvpMoveY = MVP_IMAGE_POSY+30
						end
						
						
						-- MVP 이름
						drawer:setFont(g_STRING_FONT_GULIMCHE, 16)
						drawer:setTextColor(0,0,0,255)
						local nameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 16, mvpName)
						common_DrawOutlineText1(drawer, mvpName, (MVP_IMAGE_POSX+210)-nameSize/2, MVP_IMAGE_POSY+68, 0,0,0,g_mvpTextAlpha, 97,230,255,g_mvpTextAlpha, WIDETYPE_6)
						
						
						-- MVP 보너스(경험치, 그랑)
						drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
						drawer:setTextColor(255,255,255,255)
						common_DrawOutlineText1(drawer, "+"..mvpExp, (MVP_IMAGE_POSX+176), MVP_IMAGE_POSY+95, 0,0,0,g_mvpTextAlpha, 0,255,0,g_mvpTextAlpha, WIDETYPE_6)
						common_DrawOutlineText1(drawer, "+"..mvpPoint, (MVP_IMAGE_POSX+252), MVP_IMAGE_POSY+95, 0,0,0,g_mvpTextAlpha, 0,255,0,g_mvpTextAlpha, WIDETYPE_6)

						-- 작은 mvp 깜빡거리기
						if g_mvpTwinkle then
							MvpEffectTime = MvpEffectTime + deltaTime
							MvpEffectTime = MvpEffectTime % 600
							if MvpEffectTime < 300 then
								drawer:drawTexture("UIData/ResultNewImage_2.tga", nMvpMoveX, nMvpMoveY, 78, 49, 888, 0, WIDETYPE_6)
							end
							
							-- MVP 지나갈 때
							g_mvpShine = g_mvpShine + deltaTime*2
							if g_mvpShine >= 1900 then
								g_mvpShine = 1900
								g_mvpAddBonusStart = true
							end
							
							-- 사운드
							if g_mvpShineSound then
								g_mvpShineSound = false
								PlaySound('sound/LevelUP01.WAV')
							end
							drawer:drawTexture("UIData/ResultNewImage_1.tga", g_mvpShine, tRankPosY[mvp]-9, 1024, 48, 0, 958, WIDETYPE_6)
							
						else
							drawer:drawTexture("UIData/ResultNewImage_2.tga", nMvpMoveX, nMvpMoveY, 78, 49, 888, 0, WIDETYPE_6)
						end
					end
				end
			end
		end
	end
	
	
	-- 레벨업
	if PLAYMODE ~= GAMEMODE_DUALMATCH and PLAYMODE ~= GAMEMODE_SINGLEMATCH then
		for i=1, userNum do
			if tRankInfo.levelUp[i] == 1 then
				tLevelUpEffectTime[i] = tLevelUpEffectTime[i] + deltaTime
				tLevelUpEffectTime[i] = tLevelUpEffectTime[i] % 400
				
				if IsKoreanLanguage() then
					if tLevelUpEffectTime[i] < 200 then
						drawer:drawTexture("UIData/ResultNewImage_2.tga", tRankPosX[i]+60, tRankPosY[tRankInfo.rank[i]]-3, 40, 26, 975, 9, WIDETYPE_6)
					else
						drawer:drawTexture("UIData/ResultNewImage_2.tga", tRankPosX[i]+60, tRankPosY[tRankInfo.rank[i]]-6, 40, 26, 975, 9, WIDETYPE_6)
					end
				else
					if tLevelUpEffectTime[i] < 200 then
						drawer:drawTexture("UIData/ResultNewImage_2.tga", tRankPosX[i]+80, tRankPosY[tRankInfo.rank[i]]-3, 40, 26, 975, 9, WIDETYPE_6)
					else
						drawer:drawTexture("UIData/ResultNewImage_2.tga", tRankPosX[i]+80, tRankPosY[tRankInfo.rank[i]]-6, 40, 26, 975, 9, WIDETYPE_6)
					end
				end
			end
		end
	else
		for i=1, userNum do
			if tRankInfo.levelUp[i] == 1 then
				tLevelUpEffectTime[i] = tLevelUpEffectTime[i] + deltaTime
				tLevelUpEffectTime[i] = tLevelUpEffectTime[i] % 400
				
				if tLevelUpEffectTime[i] < 200 then
					drawer:drawTexture("UIData/ResultNewImage_2.tga", tRankPosX[i]+68, tRankPosY[i]-13, 40, 26, 975, 9, WIDETYPE_6)
				else
					drawer:drawTexture("UIData/ResultNewImage_2.tga", tRankPosX[i]+68, tRankPosY[i]-16, 40, 26, 975, 9, WIDETYPE_6)
				end
			end
		end
	end
end



--------------------------------------------------------------------

-- 2번째 결과내용을 보여준다( 폭탄전용)

--------------------------------------------------------------------
function WndGameResult_DrawBombResult(deltaTime, drawState, mySlot, bTeam, userNum, myResult, myRank, mvp, mvpExp, mvpPoint, redKill, blueKill, 
			mvpName, currentUserNum, extremeMode, bPerfectGame, continueWinTeam, oldContinueWin, continueWin, continueWinReward, 
			redTeamSceneNumber, blueTeamSceneNumber, min, sec, milliSec, winTeam,  bombRedPoint, bombBluePoint, playType)
	
	if g_bInit == false then
		return
	end
	
	if drawState == 0 then
		return
	end
	
	if playType == 3 then  -- 폭탄전
		redKill = bombRedPoint
		blueKill = bombBluePoint
	end
	
	bTeam = 1
	-- 아케이드 이용권 안보이게 하기
	winMgr:getWindow("sj_gameResult_stampArcadeTicket"):setVisible(false)
	
	-- 곡괭이 아이템 안보이게 하기
	winMgr:getWindow("sj_gameResult_stampRewardItem"):setVisible(false)

	-- 팀전 결과표기
	if bTeam == 1 then
		DrawEachNumberWide("UIData/numberUi001.tga", redKill, 2, 400, 180, 274, 521, 74, 66, 75, WIDETYPE_6)	-- 레드팀 킬수
		drawer:drawTexture("UIData/GameNewImage.tga", 494, 192, 19, 46, 561, 512, WIDETYPE_6)				-- :
		DrawEachNumberWide("UIData/numberUi001.tga", blueKill, 1, 528, 180, 274, 455, 74, 66, 75, WIDETYPE_6)	-- 블루팀 킬수
	end
	
	
	-- 나의 랭킹 이미지
	if myRank > 0 then
		tMyRank[1] = tMyRank[1] + (deltaTime)
		if tMyRank[1] >= tMyRank[2] then
			tMyRank[1] = tMyRank[2]
			g_effect = true
		end
	end

	
	-- 결과창 정의
	local descPosY = 478
	local lastDescPosX = 80	
	descPosX = descPosX - (deltaTime*3)
	if descPosX <= lastDescPosX then
		descPosX = lastDescPosX
	end

	drawer:drawTexture("UIData/bumbmode_result.tga", descPosX-81, descPosY-14, 1024, 294, 0, 729, WIDETYPE_6)
	
	if winTeam == 0 then
		drawer:drawTexture("UIData/GameImage_dual.tga", descPosX-81, descPosY+22, 1024, 124, 0, 481, WIDETYPE_6)
		drawer:drawTexture("UIData/GameImage_dual.tga", descPosX-81, descPosY+146, 1024, 124, 0, 605, WIDETYPE_6)
	else
		drawer:drawTexture("UIData/GameImage_dual.tga", descPosX-81, descPosY+22, 1024, 124, 0, 605, WIDETYPE_6)
		drawer:drawTexture("UIData/GameImage_dual.tga", descPosX-81, descPosY+146, 1024, 124, 0, 481, WIDETYPE_6)
	end


	-- 플레이어의 결과창
	userNum = 8 -- 듀얼매치는 모두
	local lastPosX = 82
	for i=1, userNum do
		lastPosX = 104
		if tRankInfo.index[i] >= 0 then
			tRankPosX[i] = tRankPosX[i] - (deltaTime*2)
			if tRankPosX[i] <= lastPosX then
				tRankPosX[i] = lastPosX
			end
			
			-------------------------
			-- 케릭터(레벨, 이름)
			-------------------------
			drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
			drawer:setTextColor(255,255,255,255)
			local levelText
			if tRankInfo.level[i] < 10 then
				levelText = "Lv. "
			else
				levelText = "Lv."
			end
			-- 레벨
			if tRankInfo.index[i] == mySlot+1 then
				common_DrawOutlineText1(drawer, levelText .. tRankInfo.level[i], tRankPosX[i]+48, tRankPosY_dual[i]+7, 0,0,0,255, 255,205,86,255, WIDETYPE_6)
			else
				drawer:drawText(levelText .. tRankInfo.level[i], tRankPosX[i]+48, tRankPosY_dual[i]+7, WIDETYPE_6)
			end
			
			-- 래더
			drawer:drawTexture("UIData/numberUi001.tga", tRankPosX[i]+98, tRankPosY_dual[i]-1, 47, 21, 113, 600+21*tRankInfo.ladder[i], WIDETYPE_6)
				
			-- 이름
			local nameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(tRankInfo.name[i]))
			if tRankInfo.index[i] == mySlot+1 then
				common_DrawOutlineText1(drawer, tRankInfo.name[i], tRankPosX[i]+273-nameSize/2, tRankPosY_dual[i]+7, 0,0,0,255, 255,205,86,255, WIDETYPE_6)
			else
				drawer:drawText(tRankInfo.name[i], tRankPosX[i]+273-nameSize/2, tRankPosY_dual[i]+7, WIDETYPE_6)
			end
			
			-------------------------
			-- KO/DOWN, disconnected
			-------------------------
			-- KO(오른쪽 정렬)
			--[[
			local size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(tRankInfo.ko[i]))
			if tRankInfo.index[i] == mySlot+1 then
				common_DrawOutlineText1(drawer, tRankInfo.ko[i], tRankPosX[i]+356-size, tRankPosY_dual[i]+7, 0,0,0,255, 255,205,86,255, WIDETYPE_6)
			else
				drawer:drawText(tRankInfo.ko[i], tRankPosX[i]+356-size, tRankPosY_dual[i]+7, WIDETYPE_6)
			end
			--]]
			-- disconnected
			if tRankInfo.disconnected[i] == 1 then
				drawer:drawTexture("UIData/GameNewImage.tga", tRankPosX[i]+222, tRankPosY_dual[i]+4, 74, 14, 2, 190, WIDETYPE_6)
			end
		
			-------------------------
			-- 버프(경험치, ZEN)
			-------------------------
			if tRankInfo.buff_EXP[i] > 0 then
				tbuffExpTime[i] = tbuffExpTime[i] + deltaTime
				tbuffExpTime[i] = tbuffExpTime[i] % 400
				if tbuffExpTime[i] > 200 then
					drawer:drawTextureWithScale_Angle_Offset("UIData/mainBG_button002.tga", tRankPosX[i]+504, tRankPosY_dual[i]+9, 32, 32, 320, 788, 190, 190, 255, 0, 8, 100, 0, WIDETYPE_6)
				else
					drawer:drawTextureWithScale_Angle_Offset("UIData/mainBG_button002.tga", tRankPosX[i]+504, tRankPosY_dual[i]+12, 32, 32, 320, 788, 190, 190, 255, 0, 8, 100, 0, WIDETYPE_6)
				end
			end
			
			if tRankInfo.buff_ZEN[i] > 0 then
				tbuffZenTime[i] = tbuffZenTime[i] + deltaTime
				tbuffZenTime[i] = tbuffZenTime[i] % 400
				if tbuffZenTime[i] > 200 then
					drawer:drawTextureWithScale_Angle_Offset("UIData/mainBG_button002.tga", tRankPosX[i]+618, tRankPosY_dual[i]+9, 32, 32, 352, 788, 190, 190, 255, 0, 8, 100, 0, WIDETYPE_6)
				else
					drawer:drawTextureWithScale_Angle_Offset("UIData/mainBG_button002.tga", tRankPosX[i]+618, tRankPosY_dual[i]+12, 32, 32, 352, 788, 190, 190, 255, 0, 8, 100, 0, WIDETYPE_6)
				end
			end	
		
			-------------------------
			-- 경험치
			-------------------------
			local _curExp = tRankInfo.exp[i]
			local _curExpSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, _curExp)
			local _addExp = "("..tRankInfo.addExp[i]..")"
			
			-------------------------
			-- 포인트
			-------------------------
			local _curGran = tRankInfo.point[i]
			local _curGranSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, _curGran)
			local _addGran = "("..tRankInfo.addPoint[i]..")"
			
			
			if tRankInfo.index[i] == mySlot+1 then
				-- 경험치
				common_DrawOutlineText1(drawer, _curExp, tRankPosX[i]+446-_curExpSize, tRankPosY_dual[i]+7, 0,0,0,255, 255,205,86,255, WIDETYPE_6)
				common_DrawOutlineText1(drawer, _addExp, tRankPosX[i]+448, tRankPosY_dual[i]+7, 0,0,0,255, 0,255,0,255, WIDETYPE_6)
				
				-- 그랑
				common_DrawOutlineText1(drawer, _curGran, tRankPosX[i]+564-_curGranSize, tRankPosY_dual[i]+7, 0,0,0,255, 255,205,86,255, WIDETYPE_6)
				common_DrawOutlineText1(drawer, _addGran, tRankPosX[i]+566, tRankPosY_dual[i]+7, 0,0,0,255, 0,255,0,255, WIDETYPE_6)
			else
				drawer:drawText(tRankInfo.exp[i], tRankPosX[i]+446-_curExpSize, tRankPosY_dual[i]+7, WIDETYPE_6)	-- 경험치
				drawer:drawText(_curGran, tRankPosX[i]+564-_curGranSize, tRankPosY_dual[i]+7, WIDETYPE_6)		-- 그랑
				
				drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
				drawer:setTextColor(0,255,0,255)
				drawer:drawText(_addExp, tRankPosX[i]+448, tRankPosY_dual[i]+7, WIDETYPE_6)	-- 보너스 경험치				
				drawer:drawText(_addGran, tRankPosX[i]+566, tRankPosY_dual[i]+7, WIDETYPE_6)	-- 보너스 그랑
			end
			
			local BONUS_X = 550
			drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
			drawer:setTextColor(255,255,255,255)
			-------------------------
			-- 보너스(미션, 아이템, PC방, 이벤트)
			-------------------------
			drawer:drawTexture("UIData/GameImage_dual.tga", tRankPosX[i]+BONUS_X+85, tRankPosY_dual[i], 55, 24, 165, 415, WIDETYPE_6)
			drawer:drawTexture("UIData/GameImage_dual.tga", tRankPosX[i]+BONUS_X+140, tRankPosY_dual[i], 55, 24, 55, 415, WIDETYPE_6)
			drawer:drawTexture("UIData/GameImage_dual.tga", tRankPosX[i]+BONUS_X+195, tRankPosY_dual[i], 55, 24, 110, 415, WIDETYPE_6)
		--	drawer:drawTexture("UIData/GameImage_dual.tga", tRankPosX[i]+BONUS_X+250, tRankPosY_dual[i], 55, 24, 0, 415, WIDETYPE_6) -- PC방
		--	drawer:drawTextureSA("UIData/GameImage_dual.tga", tRankPosX[i]+BONUS_X+146, tRankPosY_dual[i], 64, 45, 793, 235, 128, 128, 255, 0, 0) -- icafe

			-- 미션
			if tRankInfo.mission[i] == 1 then
				drawer:drawTexture("UIData/GameImage_dual.tga", tRankPosX[i]+BONUS_X+85, tRankPosY_dual[i], 55, 24, 165, 391, WIDETYPE_6)
			end
			
			-- 아이템
			if tRankInfo.costume[i] == 1 or tRankInfo.buff_EXP[i] > 0 or tRankInfo.buff_ZEN[i] > 0 then
				drawer:drawTexture("UIData/GameImage_dual.tga", tRankPosX[i]+BONUS_X+140, tRankPosY_dual[i], 55, 24, 55, 391, WIDETYPE_6)
			end
			
			-- 이벤트
			if tRankInfo.event[i] == 1 then
				drawer:drawTexture("UIData/GameImage_dual.tga", tRankPosX[i]+BONUS_X+195, tRankPosY_dual[i], 55, 24, 110, 391, WIDETYPE_6)
			end
		
			-- PC방
			--if tRankInfo.wherePCRoom[i] == 1 then
			--	drawer:drawTexture("UIData/GameImage_dual.tga", tRankPosX[i]+BONUS_X+250, tRankPosY_dual[i], 55, 24, 0, 391, WIDETYPE_6)
			--end
			
			-- icafe
			if tRankInfo.icafe[i] == 1 then
				drawer:drawTextureSA("UIData/LobbyImage_new.tga", tRankPosX[i]+BONUS_X+260, tRankPosY_dual[i]+1, 64, 45, 729, 235, 128, 128, 255, 0, 0, WIDETYPE_6)
				
			elseif tRankInfo.icafe[i] == 2 then
				drawer:drawTextureSA("UIData/LobbyImage_new.tga", tRankPosX[i]+BONUS_X+260, tRankPosY_dual[i]+1, 64, 45, 665, 235, 128, 128, 255, 0, 0, WIDETYPE_6)
			end
			
			-------------------------------
			-- 나를 구분하기 위한 테두리
			-------------------------------
			if tRankInfo.index[i] == mySlot+1 then
				drawer:drawTexture("UIData/ResultNewImage_2.tga", tRankPosX[i]-40, tRankPosY_dual[i]-4, 924, 32, 8, 515, WIDETYPE_6)
			end
		end
		
		if winTeam == 0 then
			-- win, lose
			drawer:drawTexture("UIData/GameImage_dual.tga", descPosX-78, descPosY+20, 152, 42, 234, 439, WIDETYPE_6)
			drawer:drawTexture("UIData/GameImage_dual.tga", descPosX-78, descPosY+144, 152, 42, 385, 397, WIDETYPE_6)
		else
			-- win, lose
			drawer:drawTexture("UIData/GameImage_dual.tga", descPosX-78, descPosY+20, 152, 42, 234, 397, WIDETYPE_6)
			drawer:drawTexture("UIData/GameImage_dual.tga", descPosX-78, descPosY+144, 152, 42, 385, 439, WIDETYPE_6)
		end
	end	
	
	-- 레벨업
	for i=1, userNum do
		if tRankInfo.levelUp[i] == 1 then
			tLevelUpEffectTime[i] = tLevelUpEffectTime[i] + deltaTime
			tLevelUpEffectTime[i] = tLevelUpEffectTime[i] % 400
			
			if tLevelUpEffectTime[i] < 200 then
				drawer:drawTexture("UIData/ResultNewImage_2.tga", tRankPosX[i]+68, tRankPosY[i]-13, 40, 26, 975, 9, WIDETYPE_6)
			else
				drawer:drawTexture("UIData/ResultNewImage_2.tga", tRankPosX[i]+68, tRankPosY[i]-16, 40, 26, 975, 9, WIDETYPE_6)
			end
		end
	end
end





----------------------------------------------------

-- 채팅

----------------------------------------------------
-- 채팅 엔터쳤을 때
function WndGameResult_RootKeyDown(args)

	window = winMgr:getWindow("doChatting"):activate()
	
end
root:subscribeEvent("KeyDown", "WndGameResult_RootKeyDown")




-- 채팅 입력후 엔터쳤을 때
function OnTextAccepted(args)

	SendPublicChatMsg(winMgr:getWindow("doChatting"):getText())
	winMgr:getWindow("doChatting"):setText("")
	winMgr:getWindow("doChatting"):setVisible(false)
	
	winMgr:getWindow("sj_gameResult_inputChatWindow"):setVisible(false)
	
end




-- 채팅 입력창
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_gameResult_inputChatWindow")
mywindow:setTexture("Enabled", "UIData/LobbyImage_new.tga", 664, 396)
mywindow:setTexture("Disabled", "UIData/LobbyImage_new.tga", 664, 396)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(2);
mywindow:setPosition(5, 740)
mywindow:setSize(360, 22)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)



-- 채팅 에디트 박스
mywindow = winMgr:createWindow("TaharezLook/Editbox", "doChatting")
mywindow:setWideType(2);
mywindow:setPosition(10, 740)
mywindow:setSize(320, 24)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setAlphaWithChild(0)
mywindow:setUseEventController(false)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:activate()
mywindow:subscribeEvent("TextAccepted", "OnTextAccepted")
root:addChildWindow(mywindow)
CEGUI.toEditbox(winMgr:getWindow("doChatting")):setMaxTextLength(64)
CEGUI.toEditbox(winMgr:getWindow("doChatting")):subscribeEvent("EditboxFull", "OnEditBoxFull")

function OnEditBoxFull(args)
	PlaySound('sound/FullEdit.wav')
end


-- 15초후 채팅 초기화
local tShowText		 = { ["protectErr"]=0 }
local tShowTextColor = { ["protectErr"]=0 }
local tShowTextType = { ["protectErr"]=0 }

function WndGameResult_ClearChatting()

	for i=1, table.getn(tShowText) do
		table.remove(tShowText,  i)		-- 채팅내용
		table.remove(tShowTextColor, i)	-- 채팅색상
		table.remove(tShowTextType, i)	-- 채팅색상
		
	end
	
end



function WndGameResult_RenderChatting(bChat, hanMode)

	if IsKoreanLanguage() then
		drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	else
		drawer:setFont(g_STRING_FONT_GULIMCHE, 14)
	end
	drawer:setTextColor(255, 255, 255, 255)
	
	if bChat then
		if hanMode then
			drawer:drawTexture("UIData/GameNewImage.tga", 345, 742, 16, 17, 404, 964, WIDETYPE_2);
		else
			drawer:drawTexture("UIData/GameNewImage.tga", 345, 742, 16, 17, 404, 981, WIDETYPE_2);
		end	
	end
	
	y = 286
	count = 0
		
	for i=1, table.getn(tShowText) do
		count = count + 1
		
		-- 1: 자신(흰색)
		if tShowTextColor[i] == -1 then
			common_DrawOutlineText1(drawer, tostring(tShowText[i]), 22, y, 0,0,0,255, ChatMySelfFontData[3],ChatMySelfFontData[4],ChatMySelfFontData[5],255, WIDETYPE_2)
		
		-- 0: 불법채팅(빨강)
		elseif tShowTextColor[i] == 0 then
			common_DrawOutlineText1(drawer, tostring(tShowText[i]), 22, y, 0,0,0,255, ChatWarnningFontData[3],ChatWarnningFontData[4],ChatWarnningFontData[5],255, WIDETYPE_2)
		
		-- 1:일반채팅(흰색)
		elseif tShowTextColor[i] == 1 then
			common_DrawOutlineText1(drawer, tostring(tShowText[i]), 22, y, 0,0,0,255, ChatNormalFontData[3],ChatNormalFontData[4],ChatNormalFontData[5],255, WIDETYPE_2)
			
		-- 2:파티채팅(파란색)
		elseif tShowTextColor[i] == 2 then
			common_DrawOutlineText1(drawer, tostring(tShowText[i]), 22, y, 0,0,0,255, ChatPartyFontData[3],ChatPartyFontData[4],ChatPartyFontData[5],255, WIDETYPE_2)
			
		-- 3:귓속말(녹색)
		elseif tShowTextColor[i] == 3 then
			local fontData = ChatWhisperFontData
			if tShowTextType[i] == 1 then
				fontData = SpecialZMFontData
			elseif tShowTextType[i] == 2 then
				fontData = SpecialSultanFontData
			end	
			common_DrawOutlineText1(drawer, tostring(tShowText[i]), 22, y, 0,0,0,255, fontData[3],fontData[4],fontData[5],255, WIDETYPE_2)
			
		-- 4:팀채팅(파란색)
		elseif tShowTextColor[i] == 4 then
			common_DrawOutlineText1(drawer, tostring(tShowText[i]), 22, y, 0,0,0,255, ChatTeamFontData[3],ChatTeamFontData[4],ChatTeamFontData[5],255, WIDETYPE_2)
		
		-- 5:시스템채팅(지정색)
		elseif tShowTextColor[i] == 5 then
			common_DrawOutlineText1(drawer, tostring(tShowText[i]), 22, y, 0,0,0,255, ChatSystemFontData[3],ChatSystemFontData[4],ChatSystemFontData[5],255, WIDETYPE_2)
		
		-- 6:시스템 메세지2(금색)
		elseif tShowTextColor[i] == 6 then
			common_DrawOutlineText1(drawer, tostring(tShowText[i]), 22, y, 0,0,0,255, ChatSystem2FontData[3],ChatSystem2FontData[4],ChatSystem2FontData[5],255, WIDETYPE_2)
		
		-- 7:갱채팅(연보라색)
		elseif tShowTextColor[i] == 7 then
			common_DrawOutlineText1(drawer, tostring(tShowText[i]), 22, y, 0,0,0,255, ChatGangFontData[3],ChatGangFontData[4],ChatGangFontData[5],255, WIDETYPE_2)
		end

		y = y + 16
		if count >= 12 then
			return
		end
	end
	
end




-- 채팅 테이블에 입력
-- 현재 chatType (0: 불법채팅(빨강), 1:일반채팅(흰색), 2:팀채팅(파란색), 3:귓속말(녹색))
function WndGameResult_OnChatPublic(message, chatType, specialType)

	if table.getn(tShowText) >= 12 then
		table.remove(tShowText,  1)
		table.remove(tShowTextColor, 1)
		table.remove(tShowTextType, 1)
	end

	table.insert(tShowText, tostring(message))			-- 채팅내용
	table.insert(tShowTextColor, tonumber(chatType))	-- 채팅색상
	table.insert(tShowTextType, tonumber(specialType))	-- 채팅타입
	
end


-- 게임시에 남아있던 채팅정보들 저장
function SetBeforeGameChat(chat, chatColor)
	table.insert(tShowText, tostring(chat))				-- 채팅내용
	table.insert(tShowTextColor, tonumber(chatColor))	-- 채팅색상
	table.insert(tShowTextType, tonumber(0))			-- 

end

function Result_ShowEmblemKey(LeftEmblem, RightEmblem)

end


--------------------------------------------------------------------
-- Rungsimun @ GameInside - Go MatchMaking Button
--------------------------------------------------------------------
function WndGameResult_InitMatchMakingInfo(slot, zp, level)
	--slot = slot + 1
	tRankInfo.mmZp[slot]			= zp
	tRankInfo.mmLevel[slot]			= level
end

function WndGameResult_RenderMatchMaking(zp, oldZp, newZP, level)
	if lastDrawState == 1 then
		return
	end

	adder = ""
	if zp >= 0 then
		adder = "+"
	end

	local String1 = string.format("%s", adder .. CommatoMoneyStr(zp))
	local String2 = string.format("%s -> %s", CommatoMoneyStr(oldZp), CommatoMoneyStr(newZP))
	local String3 = string.format("%d", level+1)

	if zp >= 0 then
		drawer:drawTexture("UIData/MatchMakingGameResult.tga", 797, 532, 160, 77, 1, 111, WIDETYPE_6)
		drawer:drawTexture("UIData/MatchMakingGameResult.tga", 840, 532, 24, 24, 55, 1, WIDETYPE_6)
	elseif zp < 0 then
		drawer:drawTexture("UIData/MatchMakingGameResult.tga", 797, 532, 160, 77, 1, 32, WIDETYPE_6)
		drawer:drawTexture("UIData/MatchMakingGameResult.tga", 840, 532, 24, 24, 30, 1, WIDETYPE_6)
	end

	drawRank(math.fmod(level, 36), 797+10, 532+12, 240)
-- 782  15
	drawer:setFont(g_STRING_FONT_GULIMCHE, 14)
	drawer:setTextColor(0,0,0,255)
	drawer:drawText(String1, 900, 584, WIDETYPE_6)
	-- drawer:drawText(String2, 880, 424, WIDETYPE_6)
	-- drawer:drawText(String3, 880, 448, WIDETYPE_6)

	if zp >= 0 then
		drawer:setTextColor(0,255,0,255)
	else
		drawer:setTextColor(255,0,0,255)
	end
	drawer:drawText(String1, 900-1, 584-1, WIDETYPE_6)

	drawer:setFont(g_STRING_FONT_GULIMCHE, 18)
	drawer:setTextColor(255, 206, 81, 255)
	drawer:drawText(String3, 930, 557, WIDETYPE_6)
	-- drawer:drawText(String2, 880-2, 424-2, WIDETYPE_6)
	-- drawer:drawText(String3, 880-2, 448-2, WIDETYPE_6)
end

function WndGameResult_DrawMatchMakingResult(deltaTime, slot, userNum)
	drawer:drawTexture("UIData/ResultNewImage_1.tga", descPosX+632, 478+7, 130, 32, 0, 300, WIDETYPE_6)
	-- drawer:drawTexture("UIData/ResultNewImage_1.tga", descPosX+632+80, y+478+7, 0, 300, 130, 32, WIDETYPE_6)

	for i=1, userNum do
		drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
		adder = ""
		if tRankInfo.mmZp[i] >= 0 then
			adder = "+"
			drawer:setTextColor(0,255,0,255)
		else
			drawer:setTextColor(255,0,0,255)
		end
		-- drawer:setTextColor(255,255,255,255)
		local sx = GetStringSize(g_STRING_FONT_GULIMCHE, 12, adder .. tostring(tRankInfo.mmZp[i]))
		drawer:drawText(adder .. tostring(tRankInfo.mmZp[i]), tRankPosX[i]+775-80 - (sx / 2), tRankPosY[i]+5, WIDETYPE_6)
		-- drawer:drawText(tRankInfo.mmZp[i], descPosX+768 - (sx / 2), tRankPosY[i]+5, WIDETYPE_6)
	end
end

-- mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_gameResult_matchmaking_zp")
-- mywindow:setTexture("Enabled", "UIData/ResultNewImage_1.tga", 0, 300)
-- mywindow:setTexture("Disabled", "UIData/ResultNewImage_1.tga", 0, 300)
-- mywindow:setProperty("FrameEnabled", "False")
-- mywindow:setProperty("BackgroundEnabled", "False")
-- mywindow:setWideType(2);
-- mywindow:setPosition(632+80, 478+7)
-- mywindow:setSize(130, 32)
-- mywindow:setVisible(false)
-- mywindow:setAlwaysOnTop(true)
-- mywindow:setZOrderingEnabled(false)
-- root:addChildWindow(mywindow)