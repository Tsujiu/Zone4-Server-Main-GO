-----------------------------------------
-- Script Entry Point
-----------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()



local g_QUESTRESULT_1 = PreCreateString_1355	--GetSStringInfo(LAN_LUA_WND_QUEST_RESULT_1)	-- 체험스킬은 전직해야 사용할 수 있는 \n스킬을 미리 체험하게 해주는 아이템\n입니다.
local g_QUESTRESULT_2 = PreCreateString_1356	--GetSStringInfo(LAN_LUA_WND_QUEST_RESULT_2)	-- 코인 아이템은 광장 분수대옆에 있는\n아케이드상인 유키에게 가져다 주면\n여러 아이템들과 교환이 가능합니다.
local g_QUESTRESULT_4 = PreCreateString_1358	--GetSStringInfo(LAN_LUA_WND_QUEST_RESULT_4)	-- 선물함에서 확인하세요.
local g_QUESTRESULT_5 = PreCreateString_1359	--GetSStringInfo(LAN_LUA_WND_QUEST_RESULT_5)	-- 코인 아이템은 광장 분수대옆에 있는\n아케이드 상인 유키에게 가져다 주면\n여러 아이템들과 교환이 가능합니다.
local g_QUESTRESULT_6 = PreCreateString_1357	--GetSStringInfo(LAN_LUA_WND_QUEST_RESULT_3)	-- 클래스
local g_QUESTRESULT_7 = PreCreateString_2341	--GetSStringInfo(LAN_LUCKY_FIGHTER_SUCCESS)			-- 럭키 파이터 성공! 
local g_QUESTRESULT_8 = PreCreateString_2343	--GetSStringInfo(LAN_LUCKY_FIGHTER_ATTAINMENT)			-- %d번째 럭키 파이터가 되셨습니다 
local g_QUESTRESULT_9 = PreCreateString_2340	--GetSStringInfo(LAN_LUCKY_FIGHTER_REWARD)				-- "%s"가 지급됩니다 
local g_QUESTRESULT_10= PreCreateString_2342	--GetSStringInfo(LAN_LUCKY_FIGHTER_FAIL)				-- 럭키 파이터 실패! 
local g_QUESTRESULT_11= PreCreateString_2344	--GetSStringInfo(LAN_LUCKY_FIGHTER_COUNT_NOTIFY)		-- 당신의 럭키 카운트는 %d 입니다 
local g_QUESTRESULT_12= 
PreCreateString_2345	--GetSStringInfo(LAN_LUCKY_FIGHTER_CHALLENGE_AGAIN)	-- 다시 도전해 보세요!

------------------------------------------------------------

-- 배경 이미지

------------------------------------------------------------
local g_characterInfoWindowsPosY = 636
function WndQuestResult_RenderBackImage()
	drawer:drawTexture("UIData/ResultNewImage_2.tga", 66, g_characterInfoWindowsPosY, 892, 121, 4, 896, WIDETYPE_6 )			-- 케릭터 정보창
	--drawer:drawTexture("UIData/ResultNewImage_2.tga", 235, g_characterInfoWindowsPosY+40, 100, 22, 245, 935)	-- 캐쉬자리에 코인을 넣기위해 뒷배경
	--drawer:drawTexture("UIData/DungeonResult.tga", 240, g_characterInfoWindowsPosY+41, 70, 22, 430, 549)		-- 캐쉬자리에 코인
	drawer:drawTexture("UIData/DungeonResult.tga", 470, g_characterInfoWindowsPosY+6, 440, 23, 426, 525, WIDETYPE_6 )		-- 코인(획득코인)
end




-- 럭키 카운트 창 뒷판
local TexXTable = {['err']=0, [0]=0, 517}
local AlphaTable = {['err']=0, [0]=255,0,0,255, 0,255,255,0}
for i=0, 1 do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_questResult_luckyCountTextBack"..i)
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
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_questResult_luckyCountItemBack"..i)
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
local bLuckyCountEffectVisible = true


	
	
	
------------------------------------------------------------

-- 케릭터 정보 그리기

------------------------------------------------------------
tResultTime = { ["err"]=0, [0]=515, 550, 586, 622, 657, 693, 729, 766, 801, 836 }
local g_increaseExp = 0
local g_levelTable  = 0
local g_successShow = false
local g_buffExpTime = 0
local g_buffZenTime = 0

function WndQuestResult_RenderCharacterInfo(level, name, style, exp, expPercent, increaseExp, levelTable, gran, bSuccess, ladder, currentCoin,
											buff_EXP, buff_ZEN, icafe_EXP, icafe_ZEN, deltaTime, resultState, promotion, attribute)

	g_increaseExp = increaseExp
	g_levelTable  = levelTable
	
	local infoY = g_characterInfoWindowsPosY+17
	
	-- 레벨	
	drawer:setTextColor(255,205,86,255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	drawer:drawText("Lv." .. level, 150, infoY+4, WIDETYPE_6)
	
	-- 래더
	drawer:drawTexture("UIData/numberUi001.tga", 320, infoY+25, 47, 21, 113, 600+21*ladder, WIDETYPE_6)
	
	-- 이름
	drawer:setTextColor(97,230,255,255)
	local nameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(name))
	drawer:drawText(name, 190-nameSize/2, infoY+32, WIDETYPE_6)
	
	-- 스타일	
	drawer:drawTexture("UIData/Skill_up2.tga", 316, infoY-14,  89, 35,  tAttributeImgTexXTable[style][attribute], tAttributeImgTexYTable[style][attribute], WIDETYPE_6)
	drawer:drawTexture("UIData/Skill_up2.tga", 316, infoY-14,  89, 35,  promotionImgTexXTable[style], promotionImgTexYTable[promotion], WIDETYPE_6)
	
	-- 경험치 %상태
	local percent = 0
	if g_levelTable > 0 then
		percent = increaseExp*100/levelTable
	end
	drawer:setTextColor(0,0,0,255)
	drawer:drawText(percent .. " %", 904, infoY+72, WIDETYPE_6)
		
	-- 경험치 게이지
	drawer:drawTexture("UIData/ResultNewImage_2.tga", 124, infoY+62, expPercent, 33, 62, 818, WIDETYPE_6)
		
	-- 경험치 상태글자
	drawer:setTextColor(255,255,255,255)
	local currentExpText = increaseExp .. "  /  " ..  levelTable
	local currentExpSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(currentExpText))
	drawer:drawText(currentExpText, 520-currentExpSize/2, infoY+72, WIDETYPE_6)
		
	-- 그랑
	local szMyGran = CommatoMoneyStr(gran)
	r,g,b = GetGranColor(tonumber(gran))
	drawer:setTextColor(r,g,b,255)	
	local granSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, szMyGran)
	--drawer:drawText(szMyGran, 180-granSize/2, infoY+29)
	
	-- 코인
	drawer:setTextColor(255,255,255,255)
	local coinSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, currentCoin)
	--drawer:drawText(currentCoin, 344-coinSize/2, infoY+29)
	
	-- 버프
	
	if resultState < 6 then
		if buff_EXP > 0 then
			g_buffExpTime = g_buffExpTime + deltaTime
			g_buffExpTime = g_buffExpTime % 400
			if g_buffExpTime > 200 then
				drawer:drawTextureWithScale_Angle_Offset("UIData/mainBG_button002.tga", 774, 645+9, 32, 32, 320, 788, 200, 200, 255, 0, 8, 100, 0, WIDETYPE_6)
			else
				drawer:drawTextureWithScale_Angle_Offset("UIData/mainBG_button002.tga", 774, 645+12, 32, 32, 320, 788, 200, 200, 255, 0, 8, 100, 0, WIDETYPE_6)
			end
		end
		
		if buff_ZEN > 0 then
			g_buffZenTime = g_buffZenTime + deltaTime
			g_buffZenTime = g_buffZenTime % 400
			if g_buffZenTime > 200 then
				drawer:drawTextureWithScale_Angle_Offset("UIData/mainBG_button002.tga", 922, 645+9, 32, 32, 352, 788, 200, 200, 255, 0, 8, 100, 0, WIDETYPE_6)
			else
				drawer:drawTextureWithScale_Angle_Offset("UIData/mainBG_button002.tga", 922, 645+12, 32, 32, 352, 788, 200, 200, 255, 0, 8, 100, 0, WIDETYPE_6)
			end
		end
		
		
		-- I-CAFE
		if icafe_EXP > 0 then
		end
		
		if icafe_ZEN > 0 then
		end		
	end	
end


-- EndRender
function WndQuestResult_EndRender(bLuckyEvent, LuckyCount, LuckyRewardMoney, bEventOk,			-- 럭키이벤트 성공실패여부, 럭키카운트, 럭키이벤트 보상돈, 럭키이벤트 진행중인지
								LuckyRewardItemName, LuckyRewardItemFileName)								-- 럭키이벤트보상 아이템이름, 럭키이벤트보상 아이템파일이름
	-- 럭키 카운트 표시	==================================
	if bEventOk == 1 then
		local posY = 550
		if bLuckyEvent == 1 then		-- 럭키 이벤트에 당첨됐다
			local posX = 15--32	
			if bLuckyCountEffectOnce then
				for i=0, 1 do
					winMgr:getWindow("sj_questResult_luckyCountItemBack"..i):setPosition(posX, posY)
					winMgr:getWindow("sj_questResult_luckyCountItemBack"..i):setVisible(true)
					winMgr:getWindow("sj_questResult_luckyCountItemBack"..i):activeMotion("LuckyCountItemBackMotion")
					winMgr:getWindow("sj_questResult_luckyCountTextBack"..i):setPosition(posX+68, posY)
					winMgr:getWindow("sj_questResult_luckyCountTextBack"..i):setVisible(true)
					winMgr:getWindow("sj_questResult_luckyCountTextBack"..i):activeMotion("LuckyCountTextBackMotion")
				end
				bLuckyCountEffectOnce = false
			end
			drawer:setFont(g_STRING_FONT_GULIMCHE, 14)
			common_DrawOutlineText1(drawer, g_QUESTRESULT_7, posX+140, posY+14, 140,140,140,255, 97,230,240,255, WIDETYPE_6)
			local String = string.format(g_QUESTRESULT_8, CommatoMoneyStr(LuckyCount))
			common_DrawOutlineText1(drawer, String, posX+90, posY+35, 0,0,0,255, 255,205,86,255, WIDETYPE_6)
			if LuckyRewardMoney > 0 then	-- 받는 아이템이 zen이다
				String = string.format(g_QUESTRESULT_9, CommatoMoneyStr(LuckyRewardMoney).." Zen")
				drawer:drawTextureSA("UIData/ItemUIData/item/Zen.tga", posX+8, posY+12, 120, 120, 0, 0, 148, 148, 255, 0, 0, WIDETYPE_6)		
			else							-- 일반 아이템을 받는다.
				String = string.format(g_QUESTRESULT_9, LuckyRewardItemName)
				drawer:drawTextureSA("UIData/ItemUIData/"..LuckyRewardItemFileName, posX+8, posY+12, 120, 120, 0, 0, 148, 148, 255, 0, 0, WIDETYPE_6)		
			end		
			common_DrawOutlineText1(drawer, String, posX+90, posY+56, 0,0,0,255, 255,205,86,255, WIDETYPE_6)
		else
			local posX = 65--32
			if bLuckyCountEffectOnce then
				for i=0, 1 do
					winMgr:getWindow("sj_questResult_luckyCountTextBack"..i):setPosition(posX, posY)
					winMgr:getWindow("sj_questResult_luckyCountTextBack"..i):setVisible(true)
					winMgr:getWindow("sj_questResult_luckyCountTextBack"..i):activeMotion("LuckyCountTextBackMotion")
				end
				bLuckyCountEffectOnce = false
			end	
			drawer:setFont(g_STRING_FONT_GULIMCHE, 14)
			common_DrawOutlineText1(drawer, g_QUESTRESULT_10, posX+72, posY+14, 140,140,140,255, 240,30,40,255, WIDETYPE_6)
			local String = string.format(g_QUESTRESULT_11, CommatoMoneyStr(LuckyCount))
			common_DrawOutlineText1(drawer, String, posX+16, posY+35, 0,0,0,255, 255,205,86,255, WIDETYPE_6)
			common_DrawOutlineText1(drawer, g_QUESTRESULT_12, posX+16, posY+55, 0,0,0,255, 255,205,86,255, WIDETYPE_6)
		end
	end
	--==================================================	
end

-- 럭키 카운트 이벤트 창을 숨긴다.
function WndQuestResult_LuckyCountHide()
	if bLuckyCountEffectVisible then
		for i=0, 1 do
			winMgr:getWindow("sj_questResult_luckyCountItemBack"..i):setVisible(false)
			winMgr:getWindow("sj_questResult_luckyCountTextBack"..i):setVisible(false)
		end
		bLuckyCountEffectVisible = false
	end
end




------------------------------------------------------------

-- 1. 배경그리기(점수, 보너스, 총점창)

------------------------------------------------------------
local g_dungeonResultX = 200

local g_backImageTime	= 0
local g_backImagePosX	= 1500
local g_backImagePosY	= 30
local g_backImageFlag	= 0
local g_backImageSound  = true
local g_resultStage		= 0
function WndQuestResult_Show1stBackImage(bSuccess, deltaTime, min, sec, milliSec)

	if deltaTime < 0 then
		return
	end
	
	g_backImageTime = g_backImageTime + deltaTime
	
	local show = 0
	if g_backImageTime >= 1500 then
		if g_backImageSound then
			PlaySound("sound/Dungeon/Dungeon_Result_Window.wav")
			g_backImageSound = false
		end
		g_backImagePosX, g_backImageFlag, show = Effect_Circular_EaseOut(g_backImageTime-1500, 1300, -1100, 300, 417, g_backImageFlag)
	end
	
	drawer:drawTexture("UIData/Tournament001.tga", g_backImagePosX, g_backImagePosY, 542, 594, 482, 0, WIDETYPE_6)
	
	if show == 1 then
		IncreaseStateCount()
		
	-- 스크린샷등으로 시간이 지연될경우 넘어가게 한다.
	elseif g_backImageTime >= 2000 then
		g_backImagePosX = 417
		IncreaseStateCount()
	end
end



local tResultTime_Large = { ["err"]=0, [0]=716, 744, 772, 800, 828, 856, 884, 912, 940, 968 }
function CalcTimeForLarge(time, startPos1, startPos2, timePosY)

	if time <= 0 then
		return
	end
	
	local min = (time / 1000) / 60;
	local sec = (time / 1000) % 60;
	local milliSec = (time % 1000) / 10;
	
	-- minute
	drawer:drawTexture("UIData/numberUi001.tga", g_backImagePosX+startPos1, timePosY, 28, 37, tResultTime_Large[min/10], 757, WIDETYPE_6)
	drawer:drawTexture("UIData/numberUi001.tga", g_backImagePosX+startPos2, timePosY, 28, 37, tResultTime_Large[min%10], 757, WIDETYPE_6)
	
	-- :
	drawer:drawTexture("UIData/numberUi001.tga", g_backImagePosX+startPos2+23, timePosY, 28, 37, 632, 757, WIDETYPE_6)
	
	-- second
	drawer:drawTexture("UIData/numberUi001.tga", g_backImagePosX+startPos1+72, timePosY, 28, 37, tResultTime_Large[sec/10], 757, WIDETYPE_6)
	drawer:drawTexture("UIData/numberUi001.tga", g_backImagePosX+startPos2+72, timePosY, 28, 37, tResultTime_Large[sec%10], 757, WIDETYPE_6)
	
	-- :
	drawer:drawTexture("UIData/numberUi001.tga", g_backImagePosX+startPos2+23+72, timePosY, 28, 37, 632, 757, WIDETYPE_6)
	
	-- milli second
	drawer:drawTexture("UIData/numberUi001.tga", g_backImagePosX+startPos1+140, timePosY, 28, 37, tResultTime_Large[milliSec/10], 757, WIDETYPE_6)
	drawer:drawTexture("UIData/numberUi001.tga", g_backImagePosX+startPos2+140, timePosY, 28, 37, tResultTime_Large[milliSec%10], 757, WIDETYPE_6)
end

local tResultTime_Small = { ["err"]=0, [0]=324, 344, 364, 384, 404, 424, 444, 464, 484, 504 }
function CalcTimeForSmall(time, startPos1, startPos2, timePosY)
	
	if time <= 0 then
		return
	end
	
	local min = (time / 1000) / 60;
	local sec = (time / 1000) % 60;
	local milliSec = (time % 1000) / 10;
	
	-- minute
	drawer:drawTexture("UIData/numberUi001.tga", g_backImagePosX+startPos1, timePosY, 20, 27, tResultTime_Small[min/10], 419, WIDETYPE_6)
	drawer:drawTexture("UIData/numberUi001.tga", g_backImagePosX+startPos2, timePosY, 20, 27, tResultTime_Small[min%10], 419, WIDETYPE_6)
	
	-- :
	drawer:drawTexture("UIData/numberUi001.tga", g_backImagePosX+startPos2+16, timePosY, 20, 27, 284, 419, WIDETYPE_6)
	
	-- second
	drawer:drawTexture("UIData/numberUi001.tga", g_backImagePosX+startPos1+54, timePosY, 20, 27, tResultTime_Small[sec/10], 419, WIDETYPE_6)
	drawer:drawTexture("UIData/numberUi001.tga", g_backImagePosX+startPos2+54, timePosY, 20, 27, tResultTime_Small[sec%10], 419, WIDETYPE_6)
	
	-- :
	drawer:drawTexture("UIData/numberUi001.tga", g_backImagePosX+startPos2+16+54, timePosY, 20, 27, 284, 419, WIDETYPE_6)
	
	-- milli second
	drawer:drawTexture("UIData/numberUi001.tga", g_backImagePosX+startPos1+104, timePosY, 20, 27, tResultTime_Small[milliSec/10], 419, WIDETYPE_6)
	drawer:drawTexture("UIData/numberUi001.tga", g_backImagePosX+startPos2+104, timePosY, 20, 27, tResultTime_Small[milliSec%10], 419, WIDETYPE_6)
end


------------------------------------------------------------

-- 2. 점수 증가 그리기

------------------------------------------------------------
function WndQuestResult_TAInfo(todayStage, todayRank, todayTime, myBestStage, myBestRank, myBestTime,
							rankName1, rankName2, rankName3, rankName4, rankName5,
							rankStage1, rankStage2, rankStage3, rankStage4, rankStage5,
							rankTime1, rankTime2, rankTime3, rankTime4, rankTime5)
	
	-- 배경그리기(점수, 보너스, 총점창)
	drawer:drawTexture("UIData/Tournament001.tga", g_backImagePosX, g_backImagePosY, 542, 594, 482, 0, WIDETYPE_6)
	
	-- 스테이지
	g_resultStage = todayStage
	drawer:drawTexture("UIData/Tournament001.tga", g_backImagePosX-380, g_backImagePosY+4, 256, 55, 768, 655, WIDETYPE_6)
	DrawEachNumberWide("UIData/Tournament001.tga", g_resultStage, 1, g_backImagePosX-120, g_backImagePosY, 484, 594, 54, 61, 54, WIDETYPE_6)
	
	------------------
	-- 오늘 스코어
	------------------
	local startPos1	= 240
	local startPos2	= startPos1 + 26
	local timePosY	= g_backImagePosY+90
	DrawEachNumberWide("UIData/numberUi001.tga", todayStage, 8, g_backImagePosX+80, g_backImagePosY+90, 716, 757, 28, 37, 28, WIDETYPE_6)		-- 스테이지
--	DrawEachNumber("UIData/numberUi001.tga", todayRank, 8, g_backImagePosX+179, g_backImagePosY+90, 716, 757, 28, 37, 28)		-- 랭크	
	CalcTimeForLarge(todayTime, startPos1, startPos2, timePosY)
	
	
	------------------
	-- 나의 최고 스코어
	------------------
	DrawEachNumberWide("UIData/numberUi001.tga", myBestStage, 8, g_backImagePosX+80, g_backImagePosY+236,  716, 757, 28, 37, 28, WIDETYPE_6)	-- 스테이지
--	DrawEachNumber("UIData/numberUi001.tga", myBestRank, 8, g_backImagePosX+179, g_backImagePosY+236, 716, 757, 28, 37, 28)		-- 랭크

	timePosY = g_backImagePosY+236
	CalcTimeForLarge(myBestTime, startPos1, startPos2, timePosY)
	
	
	------------------
	-- 1 ~ 5위 랭커 스코어
	------------------
	local RANK1_Y = 396
	local RANK2_Y = 436
	local RANK3_Y = 476
	local RANK4_Y = 516
	local RANK5_Y = 556
	local RANK_X = 23
	drawer:drawTexture("UIData/numberUi001.tga", g_backImagePosX+RANK_X, RANK1_Y, 20, 27, 344, 419, WIDETYPE_6)
	drawer:drawTexture("UIData/numberUi001.tga", g_backImagePosX+RANK_X, RANK2_Y, 20, 27, 364, 419, WIDETYPE_6)
	drawer:drawTexture("UIData/numberUi001.tga", g_backImagePosX+RANK_X, RANK3_Y, 20, 27, 384, 419, WIDETYPE_6)
	drawer:drawTexture("UIData/numberUi001.tga", g_backImagePosX+RANK_X, RANK4_Y, 20, 27, 404, 419, WIDETYPE_6)
	drawer:drawTexture("UIData/numberUi001.tga", g_backImagePosX+RANK_X, RANK5_Y, 20, 27, 424, 419, WIDETYPE_6)
	
	drawer:setFont(g_STRING_FONT_GULIMCHE, 20)
	drawer:setTextColor(255,255,255,255)
	
	RANK_X = 70
	if rankTime1 > 0 then	drawer:drawText(rankName1, g_backImagePosX+RANK_X, RANK1_Y+3, WIDETYPE_6)	end
	if rankTime2 > 0 then	drawer:drawText(rankName2, g_backImagePosX+RANK_X, RANK2_Y+3, WIDETYPE_6)	end
	if rankTime3 > 0 then	drawer:drawText(rankName3, g_backImagePosX+RANK_X, RANK3_Y+3, WIDETYPE_6)	end
	if rankTime4 > 0 then	drawer:drawText(rankName4, g_backImagePosX+RANK_X, RANK4_Y+3, WIDETYPE_6)	end
	if rankTime5 > 0 then	drawer:drawText(rankName5, g_backImagePosX+RANK_X, RANK5_Y+3, WIDETYPE_6)	end
	
	RANK_X = 290
	if rankTime1 > 0 then	DrawEachNumberWide("UIData/numberUi001.tga", rankStage1, 1, g_backImagePosX+RANK_X, RANK1_Y, 324, 419, 18, 27, 20, WIDETYPE_6)	end
	if rankTime2 > 0 then	DrawEachNumberWide("UIData/numberUi001.tga", rankStage2, 1, g_backImagePosX+RANK_X, RANK2_Y, 324, 419, 18, 27, 20, WIDETYPE_6)	end
	if rankTime3 > 0 then	DrawEachNumberWide("UIData/numberUi001.tga", rankStage3, 1, g_backImagePosX+RANK_X, RANK3_Y, 324, 419, 18, 27, 20, WIDETYPE_6)	end
	if rankTime4 > 0 then	DrawEachNumberWide("UIData/numberUi001.tga", rankStage4, 1, g_backImagePosX+RANK_X, RANK4_Y, 324, 419, 18, 27, 20, WIDETYPE_6)	end
	if rankTime5 > 0 then	DrawEachNumberWide("UIData/numberUi001.tga", rankStage5, 1, g_backImagePosX+RANK_X, RANK5_Y, 324, 419, 18, 27, 20, WIDETYPE_6)	end
	
	startPos1	= 360
	startPos2	= startPos1 + 18
	if rankTime1 > 0 then	CalcTimeForSmall(rankTime1, startPos1, startPos2, RANK1_Y)	end
	if rankTime2 > 0 then	CalcTimeForSmall(rankTime2, startPos1, startPos2, RANK2_Y)	end
	if rankTime3 > 0 then	CalcTimeForSmall(rankTime3, startPos1, startPos2, RANK3_Y)	end
	if rankTime4 > 0 then	CalcTimeForSmall(rankTime4, startPos1, startPos2, RANK4_Y)	end
	if rankTime5 > 0 then	CalcTimeForSmall(rankTime5, startPos1, startPos2, RANK5_Y)	end
end




------------------------------------------------------------

-- 3. 등급 그리기

------------------------------------------------------------
function WndQuestResult_ShowGradeEffect(deltaTime, grade, isHiddenMode)
	drawer:drawTexture("UIData/Tournament001.tga", g_backImagePosX, g_backImagePosY, 542, 594, 482, 0, WIDETYPE_6)
	
	-- 스테이지
	drawer:drawTexture("UIData/Tournament001.tga", g_backImagePosX-260, g_backImagePosY+6, 256, 55, 768, 655, WIDETYPE_6)
	DrawEachNumberWide("UIData/Tournament001.tga", g_resultStage, 1, g_backImagePosX-380, g_backImagePosY, 484, 594, 54, 61, 54, WIDETYPE_6)
end






------------------------------------------------------------

-- 4. 총점, 경험치, 포인트 그리기

------------------------------------------------------------
local g_totalScore	= 0
local g_gainExp		= 0
local g_gainPoint	= 0
local g_gainCoin	= 0
local g_currentLife	= 0
function WndQuestResult_ShowTotalScore(deltaTime, totalScore, gainExp, gainPoint, gainCoin, currentLife)

	-- 다음을 위해 정보를 저장한다.
	g_totalScore	= totalScore
	g_gainExp		= gainExp
	g_gainPoint		= gainPoint
	g_gainCoin		= gainCoin
	g_currentLife	= currentLife

	local _infoY = g_characterInfoWindowsPosY + 38
	local _left, _right
	

	-- 경험치
	if gainExp <= 0 then
		gainExp = 0
	end
	DrawEachNumberWide("UIData/dungeonmsg.tga", gainExp, 2, 818, _infoY-1, 286, 751, 16, 26, 27, WIDETYPE_6)		-- 경험치
	drawer:drawTexture("UIData/dungeonmsg.tga", 838, _infoY, 19, 26, 582, 751, WIDETYPE_6)	-- /
	
	
	-- 그랑
	if gainPoint <= 0 then
		gainPoint = 0
	end
	DrawEachNumberWide("UIData/dungeonmsg.tga", gainPoint, 1, 860, _infoY-1, 286, 751, 16, 26, 27, WIDETYPE_6)		-- 그랑
	
	
	-- 획득 코인
	if gainCoin <= 0 then
		gainCoin = 0
	end
	_left, _right = DrawEachNumberWide("UIData/dungeonmsg.tga", gainCoin, 8, 695, _infoY+3, 727, 675, 20, 22, 27, WIDETYPE_6)	-- 코인
	drawer:drawTexture("UIData/dungeonmsg.tga", _left-45, _infoY-8, 33, 41, 643, 670, WIDETYPE_6)	-- 코인 이미지
	drawer:drawTexture("UIData/dungeonmsg.tga", _left-20, _infoY+4, 27, 22, 700, 675, WIDETYPE_6)	-- x
	
	
	-- 현재 라이프
	if currentLife <= 0 then
		currentLife = 0
	end
	_left, _right = DrawEachNumberWide("UIData/dungeonmsg.tga", currentLife, 8, 522, _infoY+3, 727, 675, 20, 22, 27, WIDETYPE_6)-- 라이프
	drawer:drawTexture("UIData/quest.tga", _left-60, _infoY-11, 62, 38, 77, 898, WIDETYPE_6)	-- 라이프 이미지
	
end





------------------------------------------------------------

-- 5. 보너스 그리기

------------------------------------------------------------
-- 정보 관련
local tEableBonus = { ["err"]=0, [0]=0, 0, 0, 0, 0 }
local tExpValue	  = { ["err"]=0, [0]=0, 0, 0, 0, 0 }
local tBonusValue = { ["err"]=0, [0]=0, 0, 0, 0, 0 }
local tExpPosX	  = { ["err"]=0, [0]=0, 0, 0, 0, 0 }
local tExpPosY	  = { ["err"]=0, [0]=0, 0, 0, 0, 0 }
local tBonusEffectScaleX = { ["err"]=0, [0]=255, 255, 255, 255, 255 }
local tBonusEffectScaleY = { ["err"]=0, [0]=255, 255, 255, 255, 255 }
local tBonusEffectAlpha	 = { ["err"]=0, [0]=255, 255, 255, 255, 255 }

function WndQuestResult_IsVisibleBonusData(index, bVisible)
	tEableBonus[index] = bVisible
end

function WndQuestResult_ShowIncreaseBonus(deltaTime,
						exp0, exp1, exp2, exp3, exp4, bonus0, bonus1, bonus2, bonus3, bonus4, addExp, addPoint, icafe)

	-- 4. 총점, 경험치, 포인트 그리기
	WndQuestResult_ShowTotalScore(deltaTime, g_totalScore, addExp, addPoint, g_gainCoin, g_currentLife)
end







------------------------------------------------------------

-- 6. 나의 경험치, 포인트로 +된다

------------------------------------------------------------
local g_bLevelup			= false
local tLevelupY				= { ["protectErr"]=0, [0]=450, 150 }
local g_levelupEffect_Star	= 0
local g_levelupAlpha		= 350

function WndQuestResult_ShowLevelupEffect()
	g_bLevelup = true
end



function WndQuestResult_AddMyExpAndPoint(deltaTime, gainExp, gainPoint, bUpEffect)

	g_gainExp	= gainExp
	g_gainPoint = gainPoint
	
	-- 5. 보너스 그리기
	WndQuestResult_ShowIncreaseBonus(deltaTime,
						tExpValue[0], tExpValue[1], tExpValue[2], tExpValue[3], tExpValue[4], 
						tBonusValue[0], tBonusValue[1], tBonusValue[2], tBonusValue[3], tBonusValue[4], gainExp, gainPoint)
						

	-- 레벨업 글자
	if g_bLevelup then
		tLevelupY[0] = tLevelupY[0] - 1
		if tLevelupY[0] <= tLevelupY[1] then
			tLevelupY[0] = tLevelupY[1]
			g_levelupAlpha = 0
		else
			g_levelupAlpha = g_levelupAlpha - 1
			if g_levelupAlpha > 255 then
				g_levelupAlpha = 255
			elseif g_levelupAlpha <= 0 then
				g_levelupAlpha = 0
			end
			
			g_levelupEffect_Star = g_levelupEffect_Star + deltaTime
			g_levelupEffect_Star = g_levelupEffect_Star % 100
						
			if g_levelupEffect_Star < 50 then
				-- 별
				drawer:drawTextureA("UIData/ResultNewImage_2.tga", 100, tLevelupY[0]-20, 23, 22, 281, 0, g_levelupAlpha, WIDETYPE_6)
				drawer:drawTextureA("UIData/ResultNewImage_2.tga", 270, tLevelupY[0]-10, 23, 22, 281, 0, g_levelupAlpha, WIDETYPE_6)
				drawer:drawTextureA("UIData/ResultNewImage_2.tga",  50, tLevelupY[0]+30, 23, 22, 281, 0, g_levelupAlpha, WIDETYPE_6)
				drawer:drawTextureA("UIData/ResultNewImage_2.tga", 210, tLevelupY[0]+80, 23, 22, 281, 0, g_levelupAlpha, WIDETYPE_6)
			end
			
			-- 레벨업 글자
			drawer:drawTextureA("UIData/ResultNewImage_2.tga", 70, tLevelupY[0], 280, 85, 0, 0, g_levelupAlpha, WIDETYPE_6)
		end
	end	
end




local g_incEffect = 0
local g_leftPercent = 0
local g_rightPercent = 0
local g_bSuccess = false
function WndQuestResult_ShowIncreaseExpEffect(deltaTime, bSuccess, leftPercent, rightPercent)
	
	g_bSuccess		= bSuccess
	g_leftPercent	= leftPercent
	g_rightPercent	= rightPercent
	
--	if bSuccess == 0 then
--		return
--	end
	
	g_incEffect = g_incEffect + deltaTime
	g_incEffect = g_incEffect % 150
	
	
	if g_incEffect > 75 then
		drawer:drawTexture("UIData/ResultNewImage_2.tga", 124+leftPercent, g_characterInfoWindowsPosY+79, rightPercent-leftPercent, 33, 62+leftPercent, 851, WIDETYPE_6)
	end


	-- 경험치 상태글자
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	drawer:setTextColor(255,255,255,255)
	local currentExpText = g_increaseExp .. "  /  " ..  g_levelTable
	local currentExpSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(currentExpText))
	drawer:drawText(currentExpText, 520-currentExpSize/2, g_characterInfoWindowsPosY+89, WIDETYPE_6)
		
end


local BUTTON_NORMAL = 0		-- 기본 박스
local BUTTON_CLICK  = 1		-- 박스 클릭했을 때
local BUTTON_SELECT = 2		-- 박스가 선택되었을 때
g_currentSelectBoxCount = 0
g_enableSelectBoxCount = 8
local g_onceSet = false
local tSelectBtnClick = {["err"]=0, 0, 0, 0, 0, 0, 0, 0, 0}
local tSelectBtnTime  = {["err"]=0, 0, 0, 0, 0, 0, 0, 0, 0}
local tSelectBtnPosX  = {["err"]=0, 60, 290, 520, 750, 60, 290, 520, 750}
local tSelectBtnPosY  = {["err"]=0, 480, 480, 480, 480, 600, 600, 600, 600}
for i=1, 8 do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_TA_SelectBox_"..i)
	mywindow:setTexture("Enabled", "UIData/Tournament001.tga", 213, 0)
	mywindow:setTexture("Disabled", "UIData/Tournament001.tga", 213, 0)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setWideType(6);
	mywindow:setPosition(tSelectBtnPosX[i], tSelectBtnPosY[i])
	mywindow:setSize(215, 107)
	mywindow:setUserString("boxIndex", tostring(i))
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_RewardInfo")
	mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_RewardInfo")
	mywindow:subscribeEvent("MouseButtonDown", "OnMMouseButtonDown_RewardInfo")
	root:addChildWindow(mywindow)
end

-- 박스 hover
function OnMouseEnter_RewardInfo(args)
	local window = CEGUI.toWindowEventArgs(args).window
	if window ~= nil then
		local szBoxIndex = CEGUI.toWindowEventArgs(args).window:getUserString("boxIndex")
		if szBoxIndex ~= "" then
			local boxIndex = tonumber(szBoxIndex)
			if tSelectBtnClick[boxIndex] == BUTTON_NORMAL then
				window:setTexture("Enabled", "UIData/Tournament001.tga", 213, 107)
				window:setTexture("Disabled", "UIData/Tournament001.tga", 213, 107)
			end
		end
	end
end

-- 박스 떠나갈때
function OnMouseLeave_RewardInfo(args)
	local window = CEGUI.toWindowEventArgs(args).window
	if window ~= nil then
		local szBoxIndex = CEGUI.toWindowEventArgs(args).window:getUserString("boxIndex")
		if szBoxIndex ~= "" then
			local boxIndex = tonumber(szBoxIndex)
			if tSelectBtnClick[boxIndex] == BUTTON_NORMAL then
				window:setTexture("Enabled", "UIData/Tournament001.tga", 213, 0)
				window:setTexture("Disabled", "UIData/Tournament001.tga", 213, 0)
			end
		end
	end
end

-- 박스 선택
function OnMMouseButtonDown_RewardInfo(args)
	local szBoxIndex = CEGUI.toWindowEventArgs(args).window:getUserString("boxIndex")
	if szBoxIndex ~= "" then
		local boxIndex = tonumber(szBoxIndex)
		
		if g_currentSelectBoxCount < g_enableSelectBoxCount then
			g_currentSelectBoxCount = g_currentSelectBoxCount + 1
			
			if tSelectBtnClick[boxIndex] == BUTTON_NORMAL then
				tSelectBtnClick[boxIndex] = BUTTON_CLICK
				tSelectBtnTime[boxIndex] = 0
				
				SelectedRewardBox(boxIndex)
				SetCurrentEnableCount(g_currentSelectBoxCount)
				
				if g_currentSelectBoxCount == g_enableSelectBoxCount then
					for i=1, 8 do
						if tSelectBtnClick[i] == BUTTON_NORMAL then
							tSelectBtnClick[i] = BUTTON_SELECT
							winMgr:getWindow("sj_TA_SelectBox_"..i):setTexture("Disabled", "UIData/Tournament001.tga", 213, 0)
						end
					end
				end
			end
		end
	end
end



-- 박스 제시간에 선택안해서 강제적으로 선택될때 호출
function ClickedSelectRewardBtn_toC(boxIndex)

	if g_currentSelectBoxCount < g_enableSelectBoxCount then
		g_currentSelectBoxCount = g_currentSelectBoxCount + 1
		
		if tSelectBtnClick[boxIndex] == BUTTON_NORMAL then
			tSelectBtnClick[boxIndex] = BUTTON_CLICK
			tSelectBtnTime[boxIndex] = 0
		
			SetCurrentEnableCount(g_currentSelectBoxCount)
			
			if g_currentSelectBoxCount == g_enableSelectBoxCount then
				for i=1, 8 do
					if tSelectBtnClick[i] == BUTTON_NORMAL then
						tSelectBtnClick[i] = BUTTON_SELECT
						winMgr:getWindow("sj_TA_SelectBox_"..i):setTexture("Disabled", "UIData/Tournament001.tga", 213, 0)
					end
				end
			end
		end
	end
end



local tImageSequence = {["err"]=0, [0]=273, 380, 487, 594, 701, 808, 915}
local g_SelectBoxUIPosY = -200
function WndQuestResult_FadeOutOldInfo(deltaTime, remainTime, todayStage, enableCount)
		
	if g_characterInfoWindowsPosY <= 1200 then
		g_characterInfoWindowsPosY = g_characterInfoWindowsPosY + deltaTime
	end
	
	-- 2번째 박스선택 씬일때
	if g_backImagePosX >= -2000 then
		g_backImagePosX = g_backImagePosX - (deltaTime*3)
		
		-- 토너먼트 아케이드 선물상자 초반 1번만 세팅
		if g_onceSet == false then
			g_onceSet = true
			
			-- 1개도 선택이 안될경우 모두 
			if enableCount <= 0 then
				for i=1, 8 do
					tSelectBtnClick[i] = BUTTON_SELECT
					winMgr:getWindow("sj_TA_SelectBox_"..i):setTexture("Disabled", "UIData/Tournament001.tga", 213, 0)
					winMgr:getWindow("sj_TA_SelectBox_"..i):setVisible(true)
				end
			else
				
				for i=1, 8 do
					tSelectBtnClick[i] = BUTTON_NORMAL
					winMgr:getWindow("sj_TA_SelectBox_"..i):setTexture("Disabled", "UIData/Tournament001.tga", 213, 0)
					winMgr:getWindow("sj_TA_SelectBox_"..i):setVisible(true)
				end
			end
			
			g_enableSelectBoxCount = enableCount
		end
	end
	
	-- 토너먼트 아케이드 박스 애니메이션
	for i=1, 8 do
		if tSelectBtnClick[i] == BUTTON_CLICK then
			tSelectBtnTime[i] = tSelectBtnTime[i] + deltaTime
			local imageIndex = tSelectBtnTime[i] / 30
			if imageIndex <= #tImageSequence then
				winMgr:getWindow("sj_TA_SelectBox_"..i):setTexture("Enabled", "UIData/Tournament001.tga", 0, tImageSequence[imageIndex])
				winMgr:getWindow("sj_TA_SelectBox_"..i):setTexture("Disabled", "UIData/Tournament001.tga", 0, tImageSequence[imageIndex])
			else
				tSelectBtnClick[i] = BUTTON_SELECT
				tSelectBtnTime[i] = 0
			end			
		end
	end
	
	WndQuestResult_AddMyExpAndPoint(deltaTime, g_gainExp, g_gainPoint, 1)
	WndQuestResult_ShowIncreaseExpEffect(deltaTime, g_bSuccess, g_leftPercent, g_rightPercent)
	
	-- 새로운 정보는 나타난다.	
	if g_SelectBoxUIPosY <= 60 then
		g_SelectBoxUIPosY = g_SelectBoxUIPosY + deltaTime
	end
	
	-- 남은시간
	if remainTime > 0 then
		DrawEachNumberWide("UIData/DungeonResult.tga", remainTime-1, 8, 850, 44, 385, 605, 126, 153, 126, WIDETYPE_6)
	end
	
	-- 스테이지
	drawer:drawTexture("UIData/Tournament001.tga", 512-200, g_SelectBoxUIPosY+5, 256, 55, 768, 655, WIDETYPE_6)
	DrawEachNumberWide("UIData/Tournament001.tga", todayStage, 1, 512+100, g_SelectBoxUIPosY, 484, 594, 54, 61, 54, WIDETYPE_6)
	
	-- 선택 가능한 박스 숫자
	drawer:drawTexture("UIData/Tournament001.tga", 318, 250, 388, 45, 636, 749, WIDETYPE_6)
	DrawEachNumberWide("UIData/numberUi001.tga", g_enableSelectBoxCount, 8, 480, 300, 134, 140, 89, 85, 89, WIDETYPE_6)
end


-- 보상받는 정보
function WndQuestResult_RewardInfo(deltaTime, positionIndex, rewardType, rewardCount, rewardFileName, rewardItemName)

	if 1 > positionIndex and positionIndex > #tSelectBtnPosY then
		return
	end
	
	if tSelectBtnClick[positionIndex] ~= BUTTON_SELECT then
		return
	end
	
	
	local posY = tSelectBtnPosY[positionIndex]
	local alpha = 255
		
	if rewardCount > 0 then
		
		if rewardFileName ~= "" then
			-- 아이템 이미지
			if rewardType == 1 then
				-- 코인
				drawer:drawTextureSA(rewardFileName, tSelectBtnPosX[positionIndex]+76, posY+8, 98, 91, 490, 842, 160, 160, 255, 0, 0, WIDETYPE_6)
			else		
				drawer:drawTextureSA(rewardFileName, tSelectBtnPosX[positionIndex]+76, posY+12, 128, 128, 0, 0, 140, 140, alpha, 0, 0, WIDETYPE_6)
			end
		end
	        
		-- 아이템 수량
		drawer:setTextColor(255,255,255,255)
		drawer:setFont(g_STRING_FONT_GULIMCHE, 14)
		drawer:drawText("x "..rewardCount, tSelectBtnPosX[positionIndex]+146, posY+32, WIDETYPE_6)
	
		-- 아이템 이름
		if rewardItemName ~= "" then
			drawer:setTextColor(97,230,255,255)
			drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
			local size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, rewardItemName)
			drawer:drawText(rewardItemName, tSelectBtnPosX[positionIndex]+108-size/2, posY+77, WIDETYPE_6)
		end
	else
		if rewardFileName ~= "" then
			drawer:drawTextureSA("UIData/quest1.tga", tSelectBtnPosX[positionIndex]+4, posY+5, 235, 97, 729, 535, 222, 252, alpha, 0, 0, WIDETYPE_6)	-- 아이템 꽉 찼다는 이미지
		end
	end	
end
