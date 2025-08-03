-----------------------------------------
-- Script Entry Point
-----------------------------------------
--[[
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
--]]
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local Realroot		= winMgr:getWindow("DefaultWindow")

guiSystem:setGUISheet(Realroot)
Realroot:activate()

--------------------------------------------------------------------
-- 마이룸 와이드용 백판
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
local g_QUESTRESULT_12= PreCreateString_2345	--GetSStringInfo(LAN_LUCKY_FIGHTER_CHALLENGE_AGAIN)	-- 다시 도전해 보세요!

------------------------------------------------------------

-- 배경 이미지

------------------------------------------------------------
local g_characterInfoWindowsPosY = 636
function WndQuestResult_RenderBackImage()
	drawer:drawTexture("UIData/ResultNewImage_2.tga", 66, g_characterInfoWindowsPosY, 892, 121, 4, 896)			-- 케릭터 정보창
	--drawer:drawTexture("UIData/ResultNewImage_2.tga", 235, g_characterInfoWindowsPosY+40, 100, 22, 245, 935)	-- 캐쉬자리에 코인을 넣기위해 뒷배경
	--drawer:drawTexture("UIData/DungeonResult.tga", 240, g_characterInfoWindowsPosY+41, 70, 22, 430, 549)		-- 캐쉬자리에 코인
	drawer:drawTexture("UIData/DungeonResult.tga", 470, g_characterInfoWindowsPosY+6, 440, 23, 426, 525)		-- 코인(획득코인)
	
--	local time = guiSystem:getGUISheet():getUserString("Time")
--	drawer:setTextColor(255,255,255,255)
--	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
--	drawer:drawText(time, 10, 10)
end




-- 럭키 카운트 창 뒷판
local TexXTable = {['err']=0, [0]=0, 517}
local AlphaTable = {['err']=0, [0]=255,0,0,255, 0,255,255,0}
for i=0, 1 do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_questResult_luckyCountTextBack"..i)
	mywindow:setTexture("Disabled", "UIData/event001.tga", TexXTable[i], 938)
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
--											bLuckyEvent, LuckyCount, LuckyRewardMoney, bEventOk,			-- 럭키이벤트 성공실패여부, 럭키카운트, 럭키이벤트 보상돈, 럭키이벤트중인지.
--											LuckyRewardItemName, LuckyRewardItemFileName)					-- 럭키이벤트보상 아이템이름, 럭키이벤트보상 아이템파일이름

	-- ★
	--0426KSG 변경
	--if IsEngLanguage() or IsKoreanLanguage() then
	if IsKoreanLanguage() then
		g_increaseExp = increaseExp
	else
		g_increaseExp = exp
	end
	
	g_levelTable  = levelTable
	
	local infoY = g_characterInfoWindowsPosY+17
	
	-- 레벨	
	drawer:setTextColor(255,205,86,255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	drawer:drawText("Lv." .. level, 150, infoY+4)
	
	-- 래더
	drawer:drawTexture("UIData/numberUi001.tga", 320, infoY+25, 47, 21, 113, 600+21*ladder)
	
	-- 이름
	drawer:setTextColor(97,230,255,255)
	local nameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(name))
	drawer:drawText(name, 190-nameSize/2, infoY+32)
	
	-- 스타일
	drawer:drawTexture("UIData/Skill_up2.tga", 310, infoY-14,  89, 35,  tAttributeImgTexXTable[style][attribute], tAttributeImgTexYTable[style][attribute])
	drawer:drawTexture("UIData/Skill_up2.tga", 310, infoY-14,  89, 35,  promotionImgTexXTable[style], promotionImgTexYTable[promotion])
		
	-- 경험치 %상태
	local percent = 0
	if g_levelTable > 0 then
		-- ★
		--0426KSG 변경
		--if IsEngLanguage() or IsKoreanLanguage() then
		if IsKoreanLanguage() then
			percent = increaseExp*100/levelTable
		else
			percent = exp*100/levelTable
		end
	
	end
	drawer:setTextColor(0,0,0,255)
	drawer:drawText(percent .. " %", 904, infoY+72)
		
	-- 경험치 게이지
	drawer:drawTexture("UIData/ResultNewImage_2.tga", 124, infoY+62, expPercent, 33, 62, 818)
		
	-- 경험치 상태글자
	drawer:setTextColor(255,255,255,255)
	
	-- ★
	local currentExpText
	
	--0426KSG 변경
	--if IsEngLanguage() or IsKoreanLanguage() then
	if IsKoreanLanguage() then
		currentExpText = increaseExp .. "  /  " ..  levelTable
	else
		currentExpText = exp .. "  /  " ..  levelTable
	end
	
	local currentExpSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(currentExpText))
	drawer:drawText(currentExpText, 520-currentExpSize/2, infoY+72)
		
	-- 그랑
	local szMyGran = CommatoMoneyStr64(gran)
	r,g,b = GetGranColor(gran)
	drawer:setTextColor(r,g,b,255)	
	local granSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, szMyGran)
	--drawer:drawText(szMyGran, 180-granSize/2, infoY+29)
	
	-- 코인
	drawer:setTextColor(255,255,255,255)
	local coinSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, currentCoin)
	--drawer:drawText(currentCoin, 344-coinSize/2, infoY+29)
	
	-- 실패할 경우 코인획득 실패를 알려줌
	--[[
	if g_successShow then
		if bSuccess == 0 then
			drawer:drawTexture("UIData/DungeonResult.tga", 70, 130, 269, 21, 426, 0)
		end
	end
	-]]	
	
	
	-- 버프
	
	if resultState < 6 then
		if buff_EXP > 0 then
			g_buffExpTime = g_buffExpTime + deltaTime
			g_buffExpTime = g_buffExpTime % 400
			if g_buffExpTime > 200 then
				drawer:drawTextureWithScale_Angle_Offset("UIData/mainBG_button002.tga", 774, 645+9, 32, 32, 320, 788, 200, 200, 255, 0, 8, 100, 0)
			else
				drawer:drawTextureWithScale_Angle_Offset("UIData/mainBG_button002.tga", 774, 645+12, 32, 32, 320, 788, 200, 200, 255, 0, 8, 100, 0)
			end
		end
		
		if buff_ZEN > 0 then
			g_buffZenTime = g_buffZenTime + deltaTime
			g_buffZenTime = g_buffZenTime % 400
			if g_buffZenTime > 200 then
				drawer:drawTextureWithScale_Angle_Offset("UIData/mainBG_button002.tga", 922, 645+9, 32, 32, 352, 788, 200, 200, 255, 0, 8, 100, 0)
			else
				drawer:drawTextureWithScale_Angle_Offset("UIData/mainBG_button002.tga", 922, 645+12, 32, 32, 352, 788, 200, 200, 255, 0, 8, 100, 0)
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
			common_DrawOutlineText1(drawer, g_QUESTRESULT_7, posX+140, posY+14, 140,140,140,255, 97,230,240,255)
			local String = string.format(g_QUESTRESULT_8, CommatoMoneyStr(LuckyCount))
			common_DrawOutlineText1(drawer, String, posX+90, posY+35, 0,0,0,255, 255,205,86,255)
			if LuckyRewardMoney > 0 then	-- 받는 아이템이 zen이다
				String = string.format(g_QUESTRESULT_9, CommatoMoneyStr(LuckyRewardMoney).." Zen")
				drawer:drawTextureSA("UIData/ItemUIData/item/Zen.tga", posX+8, posY+12, 120, 120, 0, 0, 148, 148, 255, 0, 0)		
			else							-- 일반 아이템을 받는다.
				String = string.format(g_QUESTRESULT_9, LuckyRewardItemName)
				drawer:drawTextureSA("UIData/ItemUIData/"..LuckyRewardItemFileName, posX+8, posY+12, 120, 120, 0, 0, 148, 148, 255, 0, 0)		
			end		
			common_DrawOutlineText1(drawer, String, posX+90, posY+56, 0,0,0,255, 255,205,86,255)
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
			common_DrawOutlineText1(drawer, g_QUESTRESULT_10, posX+72, posY+14, 140,140,140,255, 240,30,40,255)
			local String = string.format(g_QUESTRESULT_11, CommatoMoneyStr(LuckyCount))
			common_DrawOutlineText1(drawer, String, posX+16, posY+35, 0,0,0,255, 255,205,86,255)
			common_DrawOutlineText1(drawer, g_QUESTRESULT_12, posX+16, posY+55, 0,0,0,255, 255,205,86,255)
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
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_qeustResult_stampResult")
mywindow:setPosition(g_dungeonResultX, 200)
mywindow:setSize(430, 150)
mywindow:setVisible(false)
mywindow:setTexture("Enabled", "UIData/quest1.tga", 594, 159)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
root:addChildWindow(mywindow)

winMgr:getWindow("sj_qeustResult_stampResult"):addController("CommonAlertOkBoxCtrl0", "StampEffect", "xscale", "Quintic_EaseIn", 700, 255, 5, true, false, 10)
winMgr:getWindow("sj_qeustResult_stampResult"):addController("CommonAlertOkBoxCtrl0", "StampEffect", "yscale", "Quintic_EaseIn", 700, 255, 5, true, false, 10)
winMgr:getWindow("sj_qeustResult_stampResult"):addController("CommonAlertOkBoxCtrl0", "StampEffect", "xscale", "Elastic_EaseOut", 150, 255, 3, true, false, 10)
winMgr:getWindow("sj_qeustResult_stampResult"):addController("CommonAlertOkBoxCtrl0", "StampEffect", "yscale", "Elastic_EaseOut", 150, 255, 3, true, false, 10)
winMgr:getWindow("sj_qeustResult_stampResult"):setAlign(1)


local g_backImageTime	= 0
local g_backImagePosX	= 1920
local g_backImagePosY	= 30
local g_backImageFlag	= 0
local g_backImageSound  = true

local g_successState	= 0
local g_successSound	= true
tSuccessY = { ["err"]=0, [0]=159, 0}

local g_min			= 0
local g_sec			= 0
local g_milliSec	= 0
function WndQuestResult_Show1stBackImage(bSuccess, deltaTime, min, sec, milliSec)

	if deltaTime < 0 then
		return
	end
	
	g_backImageTime = g_backImageTime + deltaTime
	
	-- 성공 or 실패
	if g_successState == 0 then
		if g_backImageTime >= 1300 then
			if g_successSound then
				PlaySound("sound/Dungeon/Dungeon_Result_Grade.wav")
				g_successSound = false
				g_successShow  = true
			end
					
			winMgr:getWindow("sj_qeustResult_stampResult"):setTexture("Enabled", "UIData/quest1.tga", 594, tSuccessY[bSuccess])
			winMgr:getWindow("sj_qeustResult_stampResult"):setVisible(true)
			winMgr:getWindow("sj_qeustResult_stampResult"):activeMotion("StampEffect")
			
			if g_backImageTime >= 2200 then
				g_successState = 1
			end			
		end
	else
		winMgr:getWindow("sj_qeustResult_stampResult"):setVisible(false)
	end

	local show = 0
	if g_backImageTime >= 1500 then
		if g_backImageSound then
			PlaySound("sound/Dungeon/Dungeon_Result_Window.wav")
			g_backImageSound = false
		end
		g_backImagePosX, g_backImageFlag, show = Effect_Circular_EaseOut(g_backImageTime-1500, 1300, -1100, 300, 417, g_backImageFlag)
	end
	
	drawer:drawTexture("UIData/DungeonResult.tga", g_backImagePosX, g_backImagePosY, 607, 246, 417, 226)
																					 --607  402 417 71
	-- 클리어 타임
	g_min = min
	g_sec = sec
	g_milliSec = milliSec
	ShowClearTime(g_backImagePosX, g_min, g_sec, g_milliSec)
	
	if show == 1 then
		IncreaseStateCount()
		
	-- 스크린샷등으로 시간이 지연될경우 넘어가게 한다.
	elseif g_backImageTime >= 2000 then
		g_backImagePosX = 417
		IncreaseStateCount()
	end
end




function ShowClearTime(g_backImagePosX, min, sec, milliSec)

	-- 클리어 시간
	local startPos1	= 226
	local startPos2	= startPos1 + 22
	local timePosY	= g_backImagePosY+550
	
	drawer:drawTexture("UIData/DungeonResult.tga", g_backImagePosX+30, g_backImagePosY+548, 163, 41, 16, 156)	-- 클리어 타임
	
	-- minute
	drawer:drawTexture("UIData/dungeonmsg.tga", g_backImagePosX+startPos1, timePosY, 38, 26, tResultTime[min/10], 192)
	drawer:drawTexture("UIData/dungeonmsg.tga", g_backImagePosX+startPos2, timePosY, 38, 26, tResultTime[min%10], 192)
	
	-- ' 과 :
	drawer:drawTexture("UIData/dungeonmsg.tga", g_backImagePosX+startPos2+23, timePosY, 16, 26, 891, 192)
	drawer:drawTexture("UIData/dungeonmsg.tga", g_backImagePosX+startPos2+30, timePosY, 16, 26, 870, 192)
	
	
	-- second
	drawer:drawTexture("UIData/dungeonmsg.tga", g_backImagePosX+startPos1+65, timePosY, 38, 26, tResultTime[sec/10], 192)
	drawer:drawTexture("UIData/dungeonmsg.tga", g_backImagePosX+startPos2+65, timePosY, 38, 26, tResultTime[sec%10], 192)
	
	-- ' 과 .
	drawer:drawTexture("UIData/dungeonmsg.tga", g_backImagePosX+startPos2+23+65, timePosY, 16, 26, 891, 192)
	drawer:drawTexture("UIData/dungeonmsg.tga", g_backImagePosX+startPos2+30+65, timePosY+13, 16, 13, 870, 205)
	
	
	-- milli second
	drawer:drawTexture("UIData/dungeonmsg.tga", g_backImagePosX+startPos1+130, timePosY, 38, 26, tResultTime[milliSec/10], 192)
	drawer:drawTexture("UIData/dungeonmsg.tga", g_backImagePosX+startPos2+130, timePosY, 38, 26, tResultTime[milliSec%10], 192)
	
	-- "
	drawer:drawTexture("UIData/dungeonmsg.tga", g_backImagePosX+startPos2+24+130, timePosY, 16, 26, 911, 192)
end




------------------------------------------------------------

-- 2. 점수 증가 그리기

------------------------------------------------------------
local g_doubleAtk	= 0
local g_teamAtk		= 0
local g_evade		= 0
local g_damaged		= 0
function WndQuestResult_ShowIncreaseScore(doubleAtk, teamAtk, evade, damaged)

	-- 1. 배경그리기(점수, 보너스, 총점창)
	drawer:drawTexture("UIData/DungeonResult.tga", g_backImagePosX, g_backImagePosY, 607, 246, 417, 226)
	
	-- 클리어 시간
	ShowClearTime(g_backImagePosX, g_min, g_sec, g_milliSec)
		
	-- 다음을 위해 정보를 저장하고 있는다.
	g_doubleAtk		= doubleAtk
	g_teamAtk		= teamAtk
	g_evade			= evade
	g_damaged		= damaged
	
	local _infoX = g_backImagePosX + 144
	local _left, _right
				
	-- 더블어택
	--DrawEachNumber("UIData/dungeonmsg.tga", doubleAtk, 8, _infoX, g_backImagePosY+57, 498, 281, 13, 15, 16)
	
	-- 팀어택
	--DrawEachNumber("UIData/dungeonmsg.tga", teamAtk, 8, _infoX, g_backImagePosY+98, 498, 281, 13, 15, 16)
		
	-- 회피
	--DrawEachNumber("UIData/dungeonmsg.tga", evade, 8, _infoX+150, g_backImagePosY+57, 498, 281, 13, 15, 16)
		
	-- 피격
	--_left, _right = DrawEachNumber("UIData/dungeonmsg.tga", damaged, 8, _infoX+149, g_backImagePosY+98, 498, 262, 13, 15, 16)
--	drawer:drawTexture("UIData/dungeonmsg.tga", _left-13, g_backImagePosY+94, 20, 22, 690, 251)
end





mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_qeustResult_stampGrade")
mywindow:setTexture("Enabled", "UIData/DungeonResult.tga", 8, 530)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setPosition(637, g_backImagePosY+159) --314
mywindow:setSize(208, 243)
mywindow:setVisible(false)
mywindow:addController("CommonAlertOkBoxCtrl0", "StampEffect", "xscale", "Quintic_EaseIn", 700, 255, 5, true, false, 10)
mywindow:addController("CommonAlertOkBoxCtrl0", "StampEffect", "yscale", "Quintic_EaseIn", 700, 255, 5, true, false, 10)
mywindow:addController("CommonAlertOkBoxCtrl0", "StampEffect", "xscale", "Elastic_EaseOut", 150, 255, 3, true, false, 10)
mywindow:addController("CommonAlertOkBoxCtrl0", "StampEffect", "yscale", "Elastic_EaseOut", 150, 255, 3, true, false, 10)
mywindow:setAlign(8)
root:addChildWindow(mywindow)
------------------------------------------------------------

-- 3. 등급 그리기

------------------------------------------------------------
local tGradeX = { ["err"] = 0, [0]=5, 213, 470, 767, 8, 7 }
local tGradeY = { ["err"] = 0, [0]=773, 773, 773, 773, 530, 287 }
local tGradeScaleX = { ["err"] = 0, [0]=208, 230, 230, 230, 247, 247 }
local gradeAlpha  = 0
local gradeAngle  = 0
local gradeEffect = 0
local g_grade	  = 0
local g_gradeTime = 0
local g_gradeSound= true
local g_isHiddenMode = 0
function WndQuestResult_ShowGradeEffect(deltaTime, grade, isHiddenMode)
	
	-- 2. 점수 증가 그리기
	WndQuestResult_ShowIncreaseScore(g_doubleAtk, g_teamAtk, g_evade, g_damaged)
	
	g_grade = grade	
	g_isHiddenMode = isHiddenMode

	if gradeEffect == 0 then
		if g_gradeSound then
			PlaySound("sound/Dungeon/Dungeon_Result_Grade.wav")
			g_gradeSound = false
		end
		
		-- 현재 히든모드가 아니고 S등급을 받을경우
		if isHiddenMode == 0 then
			if grade == 0 and IsIdnLanguage() == false then
				winMgr:getWindow("sj_qeustResult_stampGrade"):setTexture("Enabled", "UIData/quest1.tga", 645, 311)
				winMgr:getWindow("sj_qeustResult_stampGrade"):setSize(379, 216)
				winMgr:getWindow("sj_qeustResult_stampGrade"):setPosition(537, g_backImagePosY+175) --330
			else
				winMgr:getWindow("sj_qeustResult_stampGrade"):setTexture("Enabled", "UIData/DungeonResult.tga", tGradeX[grade], tGradeY[grade])
				winMgr:getWindow("sj_qeustResult_stampGrade"):setSize(tGradeScaleX[grade], 244)
				winMgr:getWindow("sj_qeustResult_stampGrade"):setPosition(637, g_backImagePosY+159) --314
			end
		else
			winMgr:getWindow("sj_qeustResult_stampGrade"):setTexture("Enabled", "UIData/DungeonResult.tga", tGradeX[grade], tGradeY[grade])
			winMgr:getWindow("sj_qeustResult_stampGrade"):setSize(tGradeScaleX[grade], 244)
			winMgr:getWindow("sj_qeustResult_stampGrade"):setPosition(637, g_backImagePosY+159) --314
		end
		
		
		winMgr:getWindow("sj_qeustResult_stampGrade"):setVisible(true)
		winMgr:getWindow("sj_qeustResult_stampGrade"):activeMotion("StampEffect")
		
		g_gradeTime = g_gradeTime + deltaTime
		if g_gradeTime >= 800 then
			IncreaseStateCount()
			gradeEffect = 1
			g_gradeTime = 0
		end
	else
		winMgr:getWindow("sj_qeustResult_stampGrade"):setVisible(false)
		
		if isHiddenMode == 0 then
			if grade == 0 and IsIdnLanguage() == false then
				drawer:drawTexture("UIData/quest1.tga", g_backImagePosX+120, g_backImagePosY+175, 379, 216, 645, 311)
			else
				drawer:drawTexture("UIData/DungeonResult.tga", g_backImagePosX+220, g_backImagePosY+159, tGradeScaleX[grade], 244, tGradeX[grade], tGradeY[grade])
			end
		else
			drawer:drawTexture("UIData/DungeonResult.tga", g_backImagePosX+220, g_backImagePosY+159, tGradeScaleX[grade], 244, tGradeX[grade], tGradeY[grade])
		end
	end
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

	-- 3. 등급 그리기
	WndQuestResult_ShowGradeEffect(deltaTime, g_grade, g_isHiddenMode)
	
	-- 다음을 위해 정보를 저장한다.
	g_totalScore	= totalScore
	g_gainExp		= gainExp
	g_gainPoint		= gainPoint
	g_gainCoin		= gainCoin
	g_currentLife	= currentLife

	local _infoY = g_characterInfoWindowsPosY + 38
	local _left, _right
	
	
	-- 총점(오른쪽 위로 올라감)
	if totalScore <= 0 then
		totalScore = 0
	end
--	_left, _right = DrawEachNumber("UIData/dungeonmsg.tga", totalScore, 8, g_backImagePosX+428, 124, 286, 779, 18, 26, 29)	-- 총점
--	drawer:drawTexture("UIData/dungeonmsg.tga", _right+24, _infoY, 26, 26, 576, 779)							-- "점"


	-- 경험치
	if gainExp <= 0 then
		gainExp = 0
	end
	DrawEachNumber("UIData/dungeonmsg.tga", gainExp, 2, 818, _infoY-1, 286, 751, 16, 26, 27, drawer)		-- 경험치
	drawer:drawTexture("UIData/dungeonmsg.tga", 838, _infoY, 19, 26, 582, 751)	-- /
	
	
	-- 그랑
	if gainPoint <= 0 then
		gainPoint = 0
	end
	DrawEachNumber("UIData/dungeonmsg.tga", gainPoint, 1, 860, _infoY-1, 286, 751, 16, 26, 27, drawer)		-- 그랑
	
	
	-- 획득 코인
	if gainCoin <= 0 then
		gainCoin = 0
	end
	_left, _right = DrawEachNumber("UIData/dungeonmsg.tga", gainCoin, 8, 695, _infoY+3, 727, 675, 20, 22, 27, drawer)	-- 코인
	drawer:drawTexture("UIData/dungeonmsg.tga", _left-45, _infoY-8, 33, 41, 643, 670)	-- 코인 이미지
	drawer:drawTexture("UIData/dungeonmsg.tga", _left-20, _infoY+4, 27, 22, 700, 675)	-- x
	
	
	-- 현재 라이프
	if currentLife <= 0 then
		currentLife = 0
	end
	_left, _right = DrawEachNumber("UIData/dungeonmsg.tga", currentLife, 8, 522, _infoY+3, 727, 675, 20, 22, 27, drawer)-- 라이프
	drawer:drawTexture("UIData/quest.tga", _left-60, _infoY-11, 62, 38, 77, 898)	-- 라이프 이미지
	
end





------------------------------------------------------------

-- 5. 보너스 그리기

------------------------------------------------------------
-- 텍스쳐 관련
local tBonusTextX = { ["err"]=0, [0]=30, 278, 30, 278, 30 }
local tBonusTextY = { ["err"]=0, [0]=31, 31, 61, 61, 91 }
local tBonusPosX  = { ["err"]=0, [0]=0, 0, 0, 0, 0 }
local tBonusPosY  = { ["err"]=0, [0]=0, 0, 0, 0, 0 }

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
	
	-- 초기화
	-- 보너스 텍스쳐
	tBonusPosX[0] = g_backImagePosX+16
	tBonusPosX[1] = g_backImagePosX+264
	tBonusPosX[2] = g_backImagePosX+16
	tBonusPosX[3] = g_backImagePosX+264
	tBonusPosX[4] = g_backImagePosX+16
	
	tBonusPosY[0] = g_backImagePosY+205 -155 
	tBonusPosY[1] = g_backImagePosY+205 -155
	tBonusPosY[2] = g_backImagePosY+235 -155
	tBonusPosY[3] = g_backImagePosY+235 -155
	tBonusPosY[4] = g_backImagePosY+265 -155
	
	-- 경험치/그랑 숫자
	tExpPosX[0] = g_backImagePosX+154
	tExpPosX[1] = g_backImagePosX+405
	tExpPosX[2] = g_backImagePosX+154
	tExpPosX[3] = g_backImagePosX+405
	tExpPosX[4] = g_backImagePosX+154
	
	tExpPosY[0] = g_backImagePosY+208 -155
	tExpPosY[1] = g_backImagePosY+208 -155
	tExpPosY[2] = g_backImagePosY+238 -155
	tExpPosY[3] = g_backImagePosY+238 -155
	tExpPosY[4] = g_backImagePosY+268 -155
	
	
	-- 다음을 위한 정보저장
	tExpValue[0] = exp0
	tExpValue[1] = exp1
	tExpValue[2] = exp2
	tExpValue[3] = exp3
	tExpValue[4] = exp4
	tBonusValue[0] = bonus0
	tBonusValue[1] = bonus1
	tBonusValue[2] = bonus2
	tBonusValue[3] = bonus3
	tBonusValue[4] = bonus4
			
	for i=0, #tBonusTextX do
		if tEableBonus[i] == 1 then
		
			-- icafe 보너스일 경우
			if i == 1 then
				if IsKoreanLanguage() then
					if icafe >= 1 then
						drawer:drawTexture("UIData/DungeonResult.tga", tBonusPosX[i], tBonusPosY[i], 98, 29, tBonusTextX[i], tBonusTextY[i])
					end
				else
					if icafe == 1 then		-- 골드
					drawer:drawTextureSA("UIData/LobbyImage_new.tga", tBonusPosX[i]+20, tBonusPosY[i]+10, 64, 45, 729, 235, 128, 128, 255, 0, 0)	-- 골드
				
					elseif icafe == 2 then	-- 프리미엄
						drawer:drawTextureSA("UIData/LobbyImage_new.tga", tBonusPosX[i]+20, tBonusPosY[i]+10, 64, 45, 665, 235, 128, 128, 255, 0, 0)	-- 프리미엄
					end
				end
				
			-- 다른 보너스
			else
				drawer:drawTexture("UIData/DungeonResult.tga", tBonusPosX[i], tBonusPosY[i], 98, 29, tBonusTextX[i], tBonusTextY[i])
			end
			
			-- 앞쪽 경험치는 뒷정렬하고, 뒷쪽 포인트는 앞정렬(기본)을 한다.
			if i ~=3 then
				DrawEachNumber("UIData/dungeonmsg.tga", tExpValue[i], 2, tExpPosX[i], tExpPosY[i], 727, 224, 16, 22, 29, drawer)		-- 경험치
				drawer:drawTexture("UIData/dungeonmsg.tga", tExpPosX[i]+24, tExpPosY[i], 20, 22, 707, 224)						-- /
				DrawEachNumber("UIData/dungeonmsg.tga", tBonusValue[i], 1, tExpPosX[i]+46, tExpPosY[i], 727, 224, 16, 22, 29, drawer)	-- 포인트
			end
		end		
	end
	
	
	-- 약간 커지면서 사라지는 이펙트
	for i=0, #tBonusTextX do
		if i ~= 3 then
			if tEableBonus[i] == 1 then
			
				tBonusEffectScaleX[i] = tBonusEffectScaleX[i] + deltaTime/5
				if tBonusEffectScaleX[i] >= 765 then
					tBonusEffectScaleX[i] = 765
				end
				
				tBonusEffectScaleY[i] = tBonusEffectScaleY[i] + deltaTime/5
				if tBonusEffectScaleY[i] >= 765 then
					tBonusEffectScaleY[i] = 765
				end
				
				-- icafe 보너스일 경우
				if i == 1 then
				
					tBonusEffectAlpha[i] = tBonusEffectAlpha[i] - deltaTime/4
					if tBonusEffectAlpha[i] <= 0 then
						tBonusEffectAlpha[i] = 0
					end
					
					if IsKoreanLanguage() then
						if icafe >= 1 then
							drawer:drawTextureWithScale_Angle_Offset("UIData/DungeonResult.tga", tBonusPosX[i]+50, tBonusPosY[i]+14, 98, 29, tBonusTextX[i], tBonusTextY[i],
																	tBonusEffectScaleX[i], tBonusEffectScaleY[i], tBonusEffectAlpha[i], 0, 8,0,0)
						end
					else
						if icafe == 1 then		-- 골드
							drawer:drawTextureWithScale_Angle_Offset("UIData/LobbyImage_new.tga", tBonusPosX[i]+50, tBonusPosY[i]+10, 64, 45, 729, 235,
																		tBonusEffectScaleX[i], tBonusEffectScaleY[i], tBonusEffectAlpha[i], 0, 8,0,0)
						elseif icafe == 2 then	-- 프리미엄
							drawer:drawTextureWithScale_Angle_Offset("UIData/LobbyImage_new.tga", tBonusPosX[i]+50, tBonusPosY[i]+10, 64, 45, 665, 235,
																		tBonusEffectScaleX[i], tBonusEffectScaleY[i], tBonusEffectAlpha[i], 0, 8,0,0)
						end
					end
					
				-- 다른 보너스
				else
					tBonusEffectAlpha[i] = tBonusEffectAlpha[i] - deltaTime/6
					if tBonusEffectAlpha[i] <= 0 then
						tBonusEffectAlpha[i] = 0
					end
									
					drawer:drawTextureWithScale_Angle_Offset("UIData/DungeonResult.tga", tBonusPosX[i]+50, tBonusPosY[i]+14, 98, 29, tBonusTextX[i], tBonusTextY[i],
																	tBonusEffectScaleX[i], tBonusEffectScaleY[i], tBonusEffectAlpha[i], 0, 8,0,0)
				end
			end
		end
	end

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
				drawer:drawTextureA("UIData/ResultNewImage_2.tga", 100, tLevelupY[0]-20, 23, 22, 281, 0, g_levelupAlpha)
				drawer:drawTextureA("UIData/ResultNewImage_2.tga", 270, tLevelupY[0]-10, 23, 22, 281, 0, g_levelupAlpha)
				drawer:drawTextureA("UIData/ResultNewImage_2.tga",  50, tLevelupY[0]+30, 23, 22, 281, 0, g_levelupAlpha)
				drawer:drawTextureA("UIData/ResultNewImage_2.tga", 210, tLevelupY[0]+80, 23, 22, 281, 0, g_levelupAlpha)
			end
			
			-- 레벨업 글자
			drawer:drawTextureA("UIData/ResultNewImage_2.tga", 70, tLevelupY[0], 280, 85, 0, 0, g_levelupAlpha)
		end
	end
	
	
	-- 경험치, 포인트 + 올라가는 효과
	if bUpEffect == 1 then
		
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
		drawer:drawTexture("UIData/ResultNewImage_2.tga", 124+leftPercent, g_characterInfoWindowsPosY+79, rightPercent-leftPercent, 33, 62+leftPercent, 851)
	end

																
	-- 경험치 상태글자
	drawer:setTextColor(255,255,255,255)
	local currentExpText = g_increaseExp .. "  /  " ..  g_levelTable
	local currentExpSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(currentExpText))
	drawer:drawText(currentExpText, 520-currentExpSize/2, g_characterInfoWindowsPosY+89)
		
end



--local tRewardWindowPosX		= { ["err"]=0, [0]=10, 265, 520, 775 }
--local tRewardWindowPosX		= { ["err"]=0, [0]=28, 238, 448 }
local tRewardWindowPosX		= { ["err"]=0, [0]=33, 243, 453 }
local tSelectCharacterPosX	= { ["err"]=0, [0]=79, 334, 589, 844 }
local g_SelectBoxUIPosY = -200
local g_FadeOutDeltaTime = -1
local g_FadeOutRemainTime = -1
function WndQuestResult_FadeOutOldInfo(deltaTime, remainTime)
	
	-- 이전 정보는 사라진다.
	winMgr:getWindow("sj_qeustResult_stampResult"):setVisible(false)
	
	if g_characterInfoWindowsPosY <= 1200 then
		g_characterInfoWindowsPosY = g_characterInfoWindowsPosY + deltaTime
	end
	
	if g_backImagePosX >= -2000 then
		g_backImagePosX = g_backImagePosX - (deltaTime*3)
	end	
	
	WndQuestResult_AddMyExpAndPoint(deltaTime, g_gainExp, g_gainPoint, 1)
	WndQuestResult_ShowIncreaseExpEffect(deltaTime, g_bSuccess, g_leftPercent, g_rightPercent)
	
	-- 새로운 정보는 나타난다.	
	if g_SelectBoxUIPosY <= 80 then
		g_SelectBoxUIPosY = g_SelectBoxUIPosY + deltaTime
	end
	drawer:drawTexture("UIData/quest1.tga", 0, g_SelectBoxUIPosY, 1024, 92, 0, 932)	-- 원하시는 금고를..
	
	-- 남은시간
	if remainTime > 0 then
		
		if g_FadeOutRemainTime ~= remainTime then
			g_FadeOutDeltaTime = 0
			g_FadeOutRemainTime = remainTime
		end
		
		g_FadeOutDeltaTime = g_FadeOutDeltaTime + deltaTime
		local diff = g_FadeOutDeltaTime
		local scale = 340 - (diff/10)
		
		DrawEachNumberAS("UIData/Arcade_reward.tga", remainTime-1, 8, 515+(diff/1000), 255+(diff/1000), 0, 282, 130, 148, 130, 255, scale, scale, 0, drawer)
	--	DrawEachNumber("UIData/Arcade_reward.tga", remainTime-1, 8, 447, 184, 0, 282, 130, 150, 130, drawer)
	end
	
	-- SpecialCard
	DrawEachNumber("UIData/Arcade_reward.tga", 0, 8, 894, 295, 0, 432, 16, 26, 16, drawer)
	
	winMgr:getWindow("QuestResultCardBackground"):setVisible(true)
end



-- 카드
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "QuestResultCardBackground")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setSize(1024, 768)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "QuestResultCardFrame1")
mywindow:setTexture("Enabled", "UIData/frame/frame_013.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/frame/frame_013.tga", 0, 0)
mywindow:setframeWindow(true)
mywindow:setPosition(38, 359)
mywindow:setSize(670, 320)
mywindow:setVisible(true)
--mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("QuestResultCardBackground"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "QuestResultCardFrame2")
mywindow:setTexture("Enabled", "UIData/frame/frame_013.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/frame/frame_013.tga", 0, 0)
mywindow:setframeWindow(true)
mywindow:setPosition(746, 359)
mywindow:setSize(240, 320)
mywindow:setVisible(true)
--mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("QuestResultCardBackground"):addChildWindow(mywindow)


local g_bCardSelected = false
local g_selectedCard = 0

function WndQuestResult_SelectCard( index )
	
	local window = winMgr:getWindow("QuestResultCard" .. index)
	
	g_selectedCard = index - 1
	
	window:clearActiveController()
	winMgr:getWindow("QuestResultWhite"):activeMotion("QuestResult_Effect_Show");
	
	window:setTexture("Enabled", "UIData/Arcade_reward.tga", 196, 0)
	window:setTexture("Disabled", "UIData/Arcade_reward.tga", 196, 0)
	
	window:setPosition(58 + ((index-1)*210) - 10, 378 - 14)
	window:setScaleWidth(280)
	window:setScaleHeight(280)
	
	g_bCardSelected = true
	SelectDungeonReward(index)
end

function OnClickedCard( args )

	if g_bCardSelected == true then
		return
	end

	local btnWindow = CEGUI.toWindowEventArgs(args).window	
	local index  = tonumber(btnWindow:getUserString("index"))
	
	WndQuestResult_SelectCard( index )
end

function OnMouseEnterCard( args )

	if g_bCardSelected == true then
		return
	end

	local btnWindow = CEGUI.toWindowEventArgs(args).window	
	local index  = tonumber(btnWindow:getUserString("index"))
	local window = winMgr:getWindow("QuestResultCard" .. index)
	
	window:activeMotion("effectMouseEnter")
end

function OnMouseLeaveCard( args )

	if g_bCardSelected == true then
		return
	end
	
	local btnWindow = CEGUI.toWindowEventArgs(args).window	
	local index  = tonumber(btnWindow:getUserString("index"))
	local window = winMgr:getWindow("QuestResultCard" .. index)
	
	window:clearActiveController()
	window:setPosition(58 + ((index-1)*210), 378)
	window:setScaleWidth(255)
	window:setScaleHeight(255)
end


for i=1, 3 do

	local posX = 58 + ((i-1)*210)
	local posY = 378

	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "QuestResultCard" .. i)
	mywindow:setTexture("Enabled", "UIData/Arcade_reward.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/Arcade_reward.tga", 0, 0)
	mywindow:setPosition(posX, posY)
	mywindow:setSize(196, 282)
	mywindow:setUserString("index", i)
	mywindow:setEnabled(false)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:addController("controllerMouseEnter", "effectMouseEnter", "xscale", "Sine_EaseIn", 255, 280, 1, true, false, 7)
	mywindow:addController("controllerMouseEnter", "effectMouseEnter", "yscale", "Sine_EaseIn", 255, 280, 1, true, false, 7)
	mywindow:addController("controllerMouseEnter", "effectMouseEnter", "x", "Sine_EaseIn", posX, posX-10, 1, true, false, 7)
	mywindow:addController("controllerMouseEnter", "effectMouseEnter", "y", "Sine_EaseIn", posY, posY-14, 1, true, false, 7)
	winMgr:getWindow("QuestResultCardBackground"):addChildWindow(mywindow)

	mywindow = winMgr:createWindow("TaharezLook/Button", "QuestResultCardBtn" .. i)
	mywindow:setTexture("Normal", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Hover", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Pushed", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("PushedOff", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(posX, posY)
	mywindow:setSize(196, 282)
	mywindow:setUserString("index", i)
	mywindow:setEnabled(true)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", "OnClickedCard")
	mywindow:subscribeEvent("MouseEnter", "OnMouseEnterCard")
	mywindow:subscribeEvent("MouseLeave", "OnMouseLeaveCard")
	winMgr:getWindow("QuestResultCardBackground"):addChildWindow(mywindow)
end


local g_bSpecialCardSelected = false

function WndQuestResult_SelectSpecialCard()
	
	local window = winMgr:getWindow("QuestResultSpecialCard")
	
	window:clearActiveController()
	winMgr:getWindow("QuestResultWhite"):activeMotion("QuestResult_Effect_Show");
	
	window:setTexture("Enabled", "UIData/Arcade_reward.tga", 588, 0)
	window:setTexture("Disabled", "UIData/Arcade_reward.tga", 588, 0)
	
	window:setPosition(768 - 10, 378 - 14)
	window:setScaleWidth(280)
	window:setScaleHeight(280)
	
	g_bSpecialCardSelected = true
	SelectDungeonSpecialReward()
end

function OnClickedSpecialCard( args )

	if g_bSpecialCardSelected == true then
		return
	end
	
	WndQuestResult_SelectSpecialCard()
end

function OnMouseEnterSpecialCard( args )

	if g_bSpecialCardSelected == true then
		return
	end

	local window = winMgr:getWindow("QuestResultSpecialCard")
	
	window:activeMotion("effectMouseEnter")
end

function OnMouseLeaveSpecialCard( args )

	if g_bSpecialCardSelected == true then
		return
	end
	
	local window = winMgr:getWindow("QuestResultSpecialCard")
	
	window:clearActiveController()
	window:setPosition(768, 378)
	window:setScaleWidth(255)
	window:setScaleHeight(255)
end


mywindow = winMgr:createWindow("TaharezLook/StaticImage", "QuestResultSpecialCard")

if IsSpecialCardEnabled() == true then
	mywindow:setTexture("Enabled", "UIData/Arcade_reward.tga", 392, 0)
	mywindow:setTexture("Disabled", "UIData/Arcade_reward.tga", 392, 0)
else
	mywindow:setTexture("Enabled", "UIData/Arcade_reward.tga", 784, 0)
	mywindow:setTexture("Disabled", "UIData/Arcade_reward.tga", 784, 0)
end

mywindow:setPosition(768, 378)
mywindow:setSize(196, 282)
mywindow:setEnabled(false)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:addController("controllerMouseEnter", "effectMouseEnter", "xscale", "Sine_EaseIn", 255, 280, 1, true, false, 7)
mywindow:addController("controllerMouseEnter", "effectMouseEnter", "yscale", "Sine_EaseIn", 255, 280, 1, true, false, 7)
mywindow:addController("controllerMouseEnter", "effectMouseEnter", "x", "Sine_EaseIn", 768, 768-10, 1, true, false, 7)
mywindow:addController("controllerMouseEnter", "effectMouseEnter", "y", "Sine_EaseIn", 378, 378-14, 1, true, false, 7)
winMgr:getWindow("QuestResultCardBackground"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/Button", "QuestResultSpecialCardBtn")
mywindow:setTexture("Normal", "UIData/invisible.tga", 0, 0) -- 588
mywindow:setTexture("Hover", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Pushed", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("PushedOff", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(768, 378)
mywindow:setSize(196, 282)

if IsSpecialCardEnabled() == true then
	mywindow:setEnabled(true)
else
	mywindow:setEnabled(false)
end

mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnClickedSpecialCard")
mywindow:subscribeEvent("MouseEnter", "OnMouseEnterSpecialCard")
mywindow:subscribeEvent("MouseLeave", "OnMouseLeaveSpecialCard")
winMgr:getWindow("QuestResultCardBackground"):addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/StaticImage", "QuestResultSpecialCardCount")
mywindow:setTexture("Enabled", "UIData/Arcade_reward.tga", 811, 300)
mywindow:setTexture("Disabled", "UIData/Arcade_reward.tga", 811, 300)
mywindow:setPosition(795, 274)
mywindow:setSize(143, 81)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("QuestResultCardBackground"):addChildWindow(mywindow)


-- 플래시 이펙트
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "QuestResultWhite")
mywindow:setEnabled(false)
mywindow:setTexture('Enabled', "UIData/blwhite.tga", 0, 0)
mywindow:setTexture('Disabled', "UIData/blwhite.tga", 0, 0)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setPosition(0, 0);
mywindow:setSize(1920, 1200);
mywindow:setZOrderingEnabled(true)
mywindow:setUseEventController(false)
mywindow:clearControllerEvent("RPSgameWhite_Effect_Show")
mywindow:clearControllerEvent("RPSgameWhite_Effect_Hide")
mywindow:clearActiveController()
--mywindow:addController("QuestResult_Controller_Show", "QuestResult_Effect_Show", "alpha", "Sine_EaseInOut", 0, 255, 8, true, false, 15)
mywindow:addController("QuestResult_Controller_Show", "QuestResult_Effect_Show", "alpha", "Sine_EaseInOut", 255, 0, 8, true, false, 8)
mywindow:setAlphaWithChild(0)
Realroot:addChildWindow(mywindow)





tRewardUseDesc = { ["protectErr"]=0, [0]=g_QUESTRESULT_1, g_QUESTRESULT_2}
for i=0, 4 do
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i.."sj_qeustResult_rewardItemDesc")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont(g_STRING_FONT_GULIM, 14)
	mywindow:setText("")
	mywindow:setPosition(0, 0)
	mywindow:setSize(300, 60)
	mywindow:setAlwaysOnTop(true)
	root:addChildWindow(mywindow)
end


local tRewardAlpha = { ["err"]=0, [0]=0, 0, 0, 0 }
function WndQuestResult_RewardInfo(deltaTime, clickIndex, myBone, transform, myLevel, rewardType, rewardItem, bMy, SecondRewardCount,
							SecondRewardFileName, rewardFileName, rewardItemName, rewardClass, rewardDesc, rewardPeriod, myName, userHP)

	if g_selectedCard < 0 then
		return
	end
	
	tRewardAlpha[g_selectedCard] = tRewardAlpha[g_selectedCard] + deltaTime/2
	if tRewardAlpha[g_selectedCard] >= 255 then
		tRewardAlpha[g_selectedCard] = 255
	end
	local alpha = tRewardAlpha[g_selectedCard]

	-- 보상(스킬 강화권)
	if SecondRewardCount ~= 0 then		-- 0개 받을때도 표시해달라그래서.
		drawer:drawTextureSA("UIData/itemUIData/Special_Line.tga", tRewardWindowPosX[g_selectedCard]+69, 463, 128, 128, 0, 0, 280, 300, alpha, 0, 0, drawer)-- 스킬강화권 이미지
		drawer:drawTextureSA("UIData/itemUIData/"..SecondRewardFileName, tRewardWindowPosX[g_selectedCard]+69, 463, 128, 128, 0, 0, 280, 300, alpha, 0, 0, drawer)-- 스킬강화권 이미지
	else
		if SecondRewardFileName ~= "" then
			drawer:drawTextureSA("UIData/itemUIData/Special_Line.tga", tRewardWindowPosX[g_selectedCard]+69, 463, 128, 128, 0, 0, 280, 300, alpha, 0, 0)-- 스킬강화권 이미지
			drawer:drawTextureSA("UIData/itemUIData/"..SecondRewardFileName, tRewardWindowPosX[g_selectedCard]+69, 463, 128, 128, 0, 0, 280, 300, alpha, 0, 0)-- 스킬강화권 이미지
		else
			drawer:drawTextureA("UIData/Arcade_reward.tga", tRewardWindowPosX[g_selectedCard]+25, 378, 196, 282, 0, 458, alpha)	-- 아이템 꽉 찼다는 이미지
		--	drawer:drawTextureA("UIData/quest1.tga", tRewardWindowPosX[g_selectedCard]+4, posY+146, 235, 97, 729, 535, alpha)	-- 아이템 꽉 찼다는 이미지
		--	drawer:drawTextureA("UIData/quest1.tga", tRewardWindowPosX[g_selectedCard]+4, posY+146, 235, 97, 243, 352, alpha)	-- Empty 아이템 슬롯
		end
	end

end

function WndQuestResult_SpecialRewardInfo(rewardFileName)

	-- 보상
	if rewardFileName ~= "" then
		drawer:drawTextureSA("UIData/itemUIData/Special_Line.tga", 823, 475, 128, 128, 0, 0, 220, 240, 255, 0, 0)
		drawer:drawTextureSA("UIData/itemUIData/"..rewardFileName, 823, 475, 128, 128, 0, 0, 220, 240, 255, 0, 0)
	end
end

