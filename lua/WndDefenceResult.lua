-----------------------------------------
-- Script Entry Point
-----------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)
root:activate()



local WINDOW_WIDTH	= 1024
local WINDOW_HEIGHT	= 768
local width, height = GetWindowSize()

-- 알파 이미지
--"UIData/OnDLGBackImage.tga"
AlphaWindow = winMgr:createWindow("TaharezLook/StaticImage", "Defence_RewardBlackAlphaImage")
AlphaWindow:setTexture("Enabled", "UIData/blackfadein.tga", 0, 0)
AlphaWindow:setTexture("Disabled", "UIData/blackfadein.tga", 0, 0)
AlphaWindow:setProperty("BackgroundEnabled", "False")
AlphaWindow:setProperty("FrameEnabled", "False")
AlphaWindow:setPosition(0,0)
AlphaWindow:setSize(1920, 1200)
AlphaWindow:setWheelEventDisabled(true)
AlphaWindow:setZOrderingEnabled(false)
AlphaWindow:setVisible(false)
AlphaWindow:setAlpha(150)
AlphaWindow:setAlwaysOnTop(true)
root:addChildWindow(AlphaWindow)

-- 디펜스 결과창 투명
BackWindow = winMgr:createWindow("TaharezLook/StaticImage", "Defence_RewardBlackBackImage")
BackWindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
BackWindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
BackWindow:setProperty("BackgroundEnabled", "False")
BackWindow:setProperty("FrameEnabled", "False")
BackWindow:setPosition(-1920,0)
--BackWindow:setPosition(0,0)
BackWindow:setSize(1920, 1200)
BackWindow:setWheelEventDisabled(true)
BackWindow:setZOrderingEnabled(false)
BackWindow:setVisible(true)
BackWindow:addController("RewardMotion", "RewardMotion", "alpha", "Linear_EaseNone", 255,255 , 65, true, false, 10)
BackWindow:addController("RewardMotion", "RewardMotion", "alpha", "Linear_EaseNone", 255,0 , 10, true, false, 10)
BackWindow:setAlwaysOnTop(true)
root:addChildWindow(BackWindow)



-- 디펜스 결과창
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Defence_ResultBackImageTop")
mywindow:setTexture("Enabled", "UIData/zombiResult_003.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/zombiResult_003.tga", 0, 0)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(186, 107)
mywindow:setSize(702, 314)
mywindow:setWheelEventDisabled(true)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
BackWindow:addChildWindow(mywindow)

-- 디펜스 결과창 데코레이션2 
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Defence_ResultBackImageDeco2")
mywindow:setTexture("Enabled", "UIData/zombiResult_img_01.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/zombiResult_img_01.tga", 0, 0)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(50, 0)
mywindow:setSize(512, 512)
mywindow:setWheelEventDisabled(true)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
BackWindow:addChildWindow(mywindow)

-- 디펜스 결과창 데코레이션 
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Defence_ResultBackImageDeco")
mywindow:setTexture("Enabled", "UIData/zombiResult_003.tga", 838, 128)
mywindow:setTexture("Disabled", "UIData/zombiResult_003.tga", 838, 128)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(715, 81)
mywindow:setSize(186, 177)
mywindow:setWheelEventDisabled(true)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
BackWindow:addChildWindow(mywindow)

-- 라운드
for i = 1, 2 do
	subwindow = winMgr:createWindow("TaharezLook/StaticImage", "Defence_ResultRoundNumberTopImage"..i)
	subwindow:setTexture("Enabled", "UIData/zombiResult_003.tga", 0, 315)
	subwindow:setTexture("Disabled", "UIData/zombiResult_003.tga", 0, 315)
	subwindow:setProperty("BackgroundEnabled", "False")
	subwindow:setProperty("FrameEnabled", "False")
	subwindow:setPosition(528+(i*50)-50, 38)
	subwindow:setSize(56, 74)
	subwindow:setWheelEventDisabled(true)
	subwindow:setZOrderingEnabled(false)
	subwindow:setAlwaysOnTop(true)
	winMgr:getWindow('Defence_ResultBackImageTop'):addChildWindow(subwindow)
end

local Defence_ResultTimeNumberTopPosX  = {["err"]=0, 429, 450, 494, 515, 562, 583}

-- 시간
for i = 1, 6 do
	subwindow = winMgr:createWindow("TaharezLook/StaticImage", "Defence_ResultTimeNumberTopImage"..i)
	subwindow:setTexture("Enabled", "UIData/zombiResult_003.tga", 0, 389)
	subwindow:setTexture("Disabled", "UIData/zombiResult_003.tga", 0, 389)
	subwindow:setProperty("BackgroundEnabled", "False")
	subwindow:setProperty("FrameEnabled", "False")
	subwindow:setPosition(Defence_ResultTimeNumberTopPosX[i]-45, 105+10)
	subwindow:setSize(28, 37)
	subwindow:setWheelEventDisabled(true)
	subwindow:setZOrderingEnabled(false)
	subwindow:setAlwaysOnTop(true)
	winMgr:getWindow('Defence_ResultBackImageTop'):addChildWindow(subwindow)
end

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Defence_ResultRankBackImage")
mywindow:setTexture("Enabled", "UIData/zombiResult_003.tga", 644, 315)
mywindow:setTexture("Disabled", "UIData/zombiResult_003.tga", 644, 315)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setPosition(273, 186)
mywindow:setSize(380, 108)
mywindow:setWheelEventDisabled(true)
mywindow:setZOrderingEnabled(false)
mywindow:setVisible(false)
mywindow:setAlign(8)
mywindow:addController("RankNumberEffect", "RankNumberEffect", "xscale", "Quintic_EaseIn", 700, 255, 5, true, false, 10)
mywindow:addController("RankNumberEffect", "RankNumberEffect", "yscale", "Quintic_EaseIn", 700, 255, 5, true, false, 10)
mywindow:addController("RankNumberEffect", "RankNumberEffect", "xscale", "Elastic_EaseOut", 150, 255, 3, true, false, 10)
mywindow:addController("RankNumberEffect", "RankNumberEffect", "yscale", "Elastic_EaseOut", 150, 255, 3, true, false, 10)
--mywindow:setAlwaysOnTop(true)
winMgr:getWindow('Defence_ResultBackImageTop'):addChildWindow(mywindow)

-- 랭킹
for i = 1, 2 do
	subwindow = winMgr:createWindow("TaharezLook/StaticImage", "Defence_ResultRankNumberTopImage"..i)
	subwindow:setTexture("Enabled", "UIData/invisible.tga", 0, 426)
	subwindow:setTexture("Disabled", "UIData/invisible.tga", 0, 426)
	subwindow:setProperty("BackgroundEnabled", "False")
	subwindow:setProperty("FrameEnabled", "False")
	subwindow:setSize(61, 79)
	subwindow:setWheelEventDisabled(true)
	subwindow:setZOrderingEnabled(false)
	subwindow:setAlwaysOnTop(true)
	subwindow:setPosition(260+(i*54)-54, 15)
	winMgr:getWindow('Defence_ResultRankBackImage'):addChildWindow(subwindow)
end
	
-- 디펜스 결과창
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Defence_ResultBackImageBottom")
mywindow:setTexture("Enabled", "UIData/zombiResult_003.tga", 0, 706)
mywindow:setTexture("Disabled", "UIData/zombiResult_003.tga", 0, 706)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(108, 403)
mywindow:setSize(896, 747)
mywindow:setWheelEventDisabled(true)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
BackWindow:addChildWindow(mywindow)

ResultNamePosX = {["err"]=0, 0, 130, 0, 130}
ResultNamePosY = {["err"]=0, 0, 0, 20, 20}
--- 캐릭터 이름--------------------
for i = 1, 5 do 
	for j = 1 , 4 do 
		subwindow = winMgr:createWindow("TaharezLook/StaticText", "Defence_ResultNameText"..i..j)
		subwindow:setProperty("FrameEnabled", "false")
		subwindow:setProperty("BackgroundEnabled", "false")
		subwindow:setTextColor(255,255,255,255)
		subwindow:setFont(g_STRING_FONT_GULIMCHE, 11)
		subwindow:setPosition(140+ResultNamePosX[j], 80+(i*46)-46+ ResultNamePosY[j])
		subwindow:setSize(80, 20)
		subwindow:setViewTextMode(1)
		subwindow:setAlign(8)
		subwindow:setLineSpacing(2)
		subwindow:clearTextExtends()
		subwindow:setZOrderingEnabled(false)
		subwindow:setTextExtends("Name yo", g_STRING_FONT_GULIM, 13, 255,255,255,255,   0, 255,255,255,255)
		mywindow:addChildWindow(subwindow)
	end
end


--- 라운드 --------------------
for i = 1, 5 do 
	for j = 1, 2 do
		subwindow = winMgr:createWindow("TaharezLook/StaticImage", "Defence_ResultRoundNumberImage"..i..j)
		subwindow:setTexture("Enabled", "UIData/zombiResult_003.tga", 0, 635)
		subwindow:setTexture("Disabled", "UIData/zombiResult_003.tga", 0, 635)
		subwindow:setProperty("BackgroundEnabled", "False")
		subwindow:setProperty("FrameEnabled", "False")
		subwindow:setPosition(510+(j*15)-15, 86+(i*45)-45)
		subwindow:setSize(20, 26)
		subwindow:setWheelEventDisabled(true)
		subwindow:setZOrderingEnabled(false)
		subwindow:setAlwaysOnTop(true)
		mywindow:addChildWindow(subwindow)
	end
end

local Defence_ResultTimeNumberPosX  = {["err"]=0, 600, 615, 643, 658, 685, 700}

--- 시간 --------------------
for i = 1, 5 do 
	for j = 1, 6 do
		subwindow = winMgr:createWindow("TaharezLook/StaticImage", "Defence_ResultTimeNumberImage"..i..j)
		subwindow:setTexture("Enabled", "UIData/zombiResult_003.tga", 0, 635)
		subwindow:setTexture("Disabled", "UIData/zombiResult_003.tga", 0, 635)
		subwindow:setProperty("BackgroundEnabled", "False")
		subwindow:setProperty("FrameEnabled", "False")
		subwindow:setPosition(Defence_ResultTimeNumberPosX[j], 86+(i*45)-45)
		subwindow:setSize(20, 26)
		subwindow:setWheelEventDisabled(true)
		subwindow:setZOrderingEnabled(false)
		subwindow:setAlwaysOnTop(true)
		mywindow:addChildWindow(subwindow)
	end
end




function SettingDefenceResult(Round, Time, Rank)
	
	root:addChildWindow(winMgr:getWindow("Defence_RewardBlackBackImage2"))	
	root:addChildWindow(winMgr:getWindow("Defence_RewardBlackBackImage"))
	winMgr:getWindow("Defence_RewardBlackAlphaImage"):setVisible(true)
	
	-- 시간계산
	local resultValue = Time
	local Hour =  (resultValue/3600)
	local HourTen =  (Hour/10)
	local HourOne =  (Hour%10)
	
	resultValue = resultValue - (Hour * 3600)
	
	local Minute =  (resultValue/60)
	local MinuteTen =  (Minute/10)
	local MinuteOne =  (Minute%10)
	resultValue = resultValue - (Minute * 60)
	
	local SecondTen =  (resultValue/10)
	local SecondOne =  (resultValue%10)
	

	if SecondTen == 1 then
		winMgr:getWindow("Defence_ResultBackImageDeco2"):setTexture("Enabled", "UIData/zombiResult_img_01.tga", 0, 0)
	elseif SecondTen == 2 then
		winMgr:getWindow("Defence_ResultBackImageDeco2"):setTexture("Enabled", "UIData/zombiResult_img_02.tga", 0, 0)
	elseif SecondTen == 3 then
		winMgr:getWindow("Defence_ResultBackImageDeco2"):setTexture("Enabled", "UIData/zombiResult_img_03.tga", 0, 0)
	elseif SecondTen == 4 then
		winMgr:getWindow("Defence_ResultBackImageDeco2"):setTexture("Enabled", "UIData/zombiResult_img_04.tga", 0, 0)
	elseif SecondTen == 5 then
		winMgr:getWindow("Defence_ResultBackImageDeco2"):setTexture("Enabled", "UIData/zombiResult_img_05.tga", 0, 0)
	else 
		winMgr:getWindow("Defence_ResultBackImageDeco2"):setTexture("Enabled", "UIData/zombiResult_img_06.tga", 0, 0)
	end
	
	winMgr:getWindow("Defence_ResultTimeNumberTopImage"..1):setTexture("Enabled", "UIData/zombiResult_003.tga", (HourTen*28), 389)
	winMgr:getWindow("Defence_ResultTimeNumberTopImage"..2):setTexture("Enabled", "UIData/zombiResult_003.tga", (HourOne*28), 389)
	winMgr:getWindow("Defence_ResultTimeNumberTopImage"..3):setTexture("Enabled", "UIData/zombiResult_003.tga", (MinuteTen*28), 389)
	winMgr:getWindow("Defence_ResultTimeNumberTopImage"..4):setTexture("Enabled", "UIData/zombiResult_003.tga", (MinuteOne*28), 389)
	winMgr:getWindow("Defence_ResultTimeNumberTopImage"..5):setTexture("Enabled", "UIData/zombiResult_003.tga", (SecondTen*28), 389)
	winMgr:getWindow("Defence_ResultTimeNumberTopImage"..6):setTexture("Enabled", "UIData/zombiResult_003.tga", (SecondOne*28), 389)
	

	local Rten = (Round/10)
	local Rone = (Round%10)
	
	winMgr:getWindow("Defence_ResultRoundNumberTopImage"..1):setTexture("Enabled", "UIData/zombiResult_003.tga", 0+(56*Rten), 315)
	winMgr:getWindow("Defence_ResultRoundNumberTopImage"..2):setTexture("Enabled", "UIData/zombiResult_003.tga", 0+(56*Rone), 315)
	
	
	if Rank < 100 then
		local Rankten = (Rank/10)
		local Rankone = (Rank%10)
		
		winMgr:getWindow("Defence_ResultRankNumberTopImage"..1):setTexture("Enabled", "UIData/zombiResult_003.tga", 0+(61*Rankten), 426)
		winMgr:getWindow("Defence_ResultRankNumberTopImage"..2):setTexture("Enabled", "UIData/zombiResult_003.tga", 0+(61*Rankone), 426)
		
		winMgr:getWindow("Defence_ResultRankBackImage"):setTexture("Enabled", "UIData/zombiResult_003.tga", 644, 423)
	else
		winMgr:getWindow("Defence_ResultRankBackImage"):setTexture("Enabled", "UIData/zombiResult_003.tga", 644, 315)
	end
end


function SettingDefenceResultRank(i, name1, name2, name3, name4 , round, time)
	
	-- 랭커 이름 설정
	DebugStr('i:'..i)
	DebugStr('name1:'..name1)
	DebugStr('name2:'..name2)
	DebugStr('name3:'..name3)
	DebugStr('name4:'..name4)
	DebugStr('rount:'..round)
	DebugStr('time:'..time)

	
	winMgr:getWindow("Defence_ResultNameText"..i..1):setTextExtends(name1, g_STRING_FONT_GULIM, 12, 255,255,255,255,   0, 255,255,255,255)
	winMgr:getWindow("Defence_ResultNameText"..i..2):setTextExtends(name2, g_STRING_FONT_GULIM, 12, 255,255,255,255,   0, 255,255,255,255)
	winMgr:getWindow("Defence_ResultNameText"..i..3):setTextExtends(name3, g_STRING_FONT_GULIM, 12, 255,255,255,255,   0, 255,255,255,255)
	winMgr:getWindow("Defence_ResultNameText"..i..4):setTextExtends(name4, g_STRING_FONT_GULIM, 12, 255,255,255,255,   0, 255,255,255,255)
	
	-- 랭커 라운드 설정
	
	local roundten = round / 10
	local roundone = round % 10
	
	DebugStr('roundten:'..roundten)
	DebugStr('roundone:'..roundone)
	winMgr:getWindow("Defence_ResultRoundNumberImage"..i..1):setTexture("Enabled", "UIData/zombiResult_003.tga", roundten*20 , 635)
	winMgr:getWindow("Defence_ResultRoundNumberImage"..i..2):setTexture("Enabled", "UIData/zombiResult_003.tga", roundone*20 , 635)
	
	
	-- 시간계산
	local resultValue = time
	local Hour =  (resultValue/3600)
	local HourTen =  (Hour/10)
	local HourOne =  (Hour%10)
	
	resultValue = resultValue - (Hour * 3600)
	
	local Minute =  (resultValue/60)
	local MinuteTen =  (Minute/10)
	local MinuteOne =  (Minute%10)
	resultValue = resultValue - (Minute * 60)
	
	local SecondTen =  (resultValue/10)
	local SecondOne =  (resultValue%10)
	
	
	-- 랭커 시간 설정
	winMgr:getWindow("Defence_ResultTimeNumberImage"..i..1):setTexture("Enabled", "UIData/zombiResult_003.tga", HourTen*20, 635)
	winMgr:getWindow("Defence_ResultTimeNumberImage"..i..2):setTexture("Enabled", "UIData/zombiResult_003.tga", HourOne*20, 635)
	winMgr:getWindow("Defence_ResultTimeNumberImage"..i..3):setTexture("Enabled", "UIData/zombiResult_003.tga", MinuteTen*20, 635)
	winMgr:getWindow("Defence_ResultTimeNumberImage"..i..4):setTexture("Enabled", "UIData/zombiResult_003.tga", MinuteOne*20, 635)
	winMgr:getWindow("Defence_ResultTimeNumberImage"..i..5):setTexture("Enabled", "UIData/zombiResult_003.tga", SecondTen*20, 635)
	winMgr:getWindow("Defence_ResultTimeNumberImage"..i..6):setTexture("Enabled", "UIData/zombiResult_003.tga", SecondOne*20, 635)
	
	
end












-- 디펜스 보상창
--
BackWindow2 = winMgr:createWindow("TaharezLook/StaticImage", "Defence_RewardBlackBackImage2")
BackWindow2:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
BackWindow2:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
BackWindow2:setProperty("BackgroundEnabled", "False")
BackWindow2:setProperty("FrameEnabled", "False")
BackWindow2:setPosition(0,0)
BackWindow2:setSize(1920, 1200)
BackWindow2:setAlpha(0)
BackWindow2:setWheelEventDisabled(true)
BackWindow2:setZOrderingEnabled(false)
BackWindow2:setVisible(false)
BackWindow2:addController("RewardMotion", "RewardMotion", "alpha", "Linear_EaseNone", 0, 0 , 80, true, false, 10)
BackWindow2:addController("RewardMotion", "RewardMotion", "alpha", "Linear_EaseNone", 0, 255 , 10, true, false, 10)
BackWindow2:setAlwaysOnTop(true)
root:addChildWindow(BackWindow2)

-- 디펜스 보상창
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Defence_RewardBackImage")
mywindow:setTexture("Enabled", "UIData/zombiResult_001.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/zombiResult_001.tga", 0, 0)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setWideType(5);
mywindow:setPosition(70,30)
mywindow:setSize(896, 747)
mywindow:setWheelEventDisabled(true)
mywindow:setZOrderingEnabled(false)
--mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
BackWindow2:addChildWindow(mywindow)
--root:addChildWindow(mywindow)

-- 경험치 
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Defence_RewardExpBackImage")
mywindow:setTexture("Enabled", "UIData/zombiResult_001.tga", 0, 865)
mywindow:setTexture("Disabled", "UIData/zombiResult_001.tga", 0, 865)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setPosition(60, 630)
mywindow:setSize(773, 75)
mywindow:setWheelEventDisabled(true)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
winMgr:getWindow('Defence_RewardBackImage'):addChildWindow(mywindow)

-- 경험치이동백판 
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Defence_RewardExpMoveBackImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 865)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 865)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setPosition(60, 630)
mywindow:setSize(773, 75)
mywindow:setWheelEventDisabled(true)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
winMgr:getWindow('Defence_RewardBackImage'):addChildWindow(mywindow)

-- EXP 글자 이미지 
subwindow = winMgr:createWindow("TaharezLook/StaticImage", "Defence_RewardExpTextImage")
subwindow:setTexture("Enabled", "UIData/zombiResult_001.tga", 0, 940)
subwindow:setTexture("Disabled", "UIData/zombiResult_001.tga", 0, 940)
subwindow:setProperty("BackgroundEnabled", "False")
subwindow:setProperty("FrameEnabled", "False")
subwindow:setPosition(30, 10)
subwindow:setSize(111, 51)
subwindow:setWheelEventDisabled(true)
subwindow:setZOrderingEnabled(false)
subwindow:setAlwaysOnTop(true)
mywindow:addChildWindow(subwindow)

-- 경험치 백만까지 자리생성
for i = 1, 7 do
	subwindow = winMgr:createWindow("TaharezLook/StaticImage", "Defence_RewardExpNumberImage"..i)
	subwindow:setTexture("Enabled", "UIData/zombiResult_001.tga", 111, 940)
	subwindow:setTexture("Disabled", "UIData/zombiResult_001.tga", 111, 940)
	subwindow:setProperty("BackgroundEnabled", "False")
	subwindow:setProperty("FrameEnabled", "False")
	subwindow:setPosition(154+(i*35)-35, 10)
	subwindow:setSize(43, 51)
	subwindow:setWheelEventDisabled(true)
	subwindow:setZOrderingEnabled(false)
	subwindow:setAlwaysOnTop(true)
	subwindow:setVisible(false)
	mywindow:addChildWindow(subwindow)
end

-- ZEN 글자 이미지 
subwindow = winMgr:createWindow("TaharezLook/StaticImage", "Defence_RewardZenTextImage")
subwindow:setTexture("Enabled", "UIData/zombiResult_001.tga", 541, 940)
subwindow:setTexture("Disabled", "UIData/zombiResult_001.tga", 541, 940)
subwindow:setProperty("BackgroundEnabled", "False")
subwindow:setProperty("FrameEnabled", "False")
subwindow:setPosition(380, 10)
subwindow:setSize(111, 51)
subwindow:setWheelEventDisabled(true)
subwindow:setZOrderingEnabled(false)
subwindow:setAlwaysOnTop(true)
mywindow:addChildWindow(subwindow)

-- ZEN 십만까지 자리생성
for i = 1, 6 do
	subwindow = winMgr:createWindow("TaharezLook/StaticImage", "Defence_RewardZenNumberImage"..i)
	subwindow:setTexture("Enabled", "UIData/zombiResult_001.tga", 111, 940)
	subwindow:setTexture("Disabled", "UIData/zombiResult_001.tga", 111, 940)
	subwindow:setProperty("BackgroundEnabled", "False")
	subwindow:setProperty("FrameEnabled", "False")
	subwindow:setPosition(554+(i*35)-35, 10)
	subwindow:setSize(43, 51)
	subwindow:setWheelEventDisabled(true)
	subwindow:setZOrderingEnabled(false)
	subwindow:setAlwaysOnTop(true)
	subwindow:setVisible(false)
	mywindow:addChildWindow(subwindow)
end

-- 파티 경험치  
subwindow = winMgr:createWindow("TaharezLook/StaticImage", "Defence_RewardPartTyImage")
subwindow:setTexture("Enabled", "UIData/zombiResult_001.tga", 370, 747)
subwindow:setTexture("Disabled", "UIData/zombiResult_001.tga", 370, 747)
subwindow:setProperty("BackgroundEnabled", "False")
subwindow:setProperty("FrameEnabled", "False")
subwindow:setPosition(690, -20)
subwindow:setSize(167, 102)
subwindow:setWheelEventDisabled(true)
subwindow:setZOrderingEnabled(false)
subwindow:setAlwaysOnTop(true)
subwindow:setVisible(false)
mywindow:addChildWindow(subwindow)

-- 디펜스 보상 서브 창
for i= 1, 4 do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Defence_RewardBackSubImage"..i)
	if i == 1 then
		mywindow:setTexture("Enabled", "UIData/zombiResult_002.tga", 0, 0)
		mywindow:setTexture("Disabled", "UIData/zombiResult_002.tga", 0, 0)
	else
		mywindow:setTexture("Enabled", "UIData/zombiResult_002.tga", 197, 0)
		mywindow:setTexture("Disabled", "UIData/zombiResult_002.tga", 197, 0)
	end
	
	mywindow:setVisible(false)
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setPosition(48+(i*200)-200, 134)
	mywindow:setSize(197, 478)
	mywindow:setWheelEventDisabled(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setAlwaysOnTop(true)
	winMgr:getWindow('Defence_RewardBackImage'):addChildWindow(mywindow)
	
	--- 캐릭터 이름--------------------
	subwindow = winMgr:createWindow("TaharezLook/StaticText", "Defence_RewardCharacterNameText"..i)
	subwindow:setProperty("FrameEnabled", "false")
	subwindow:setProperty("BackgroundEnabled", "false")
	subwindow:setTextColor(255,255,255,255)
	subwindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	subwindow:setPosition(70, 15)
	subwindow:setSize(80, 20)
	subwindow:setViewTextMode(1)
	subwindow:setAlign(8)
	subwindow:setLineSpacing(2)
	subwindow:clearTextExtends()
	subwindow:setZOrderingEnabled(false)
	subwindow:setTextExtends("my name is", g_STRING_FONT_GULIM, 12, 255,255,255,255,   0, 255,255,255,255)
	mywindow:addChildWindow(subwindow)
	
		
	-- 디펜스 일반 아이템 보상
	for j= 0, 6 do
		-- 커버 이미지
		CoverWindow = winMgr:createWindow("TaharezLook/StaticImage", "Defence_Coverwindow"..i..j)
		CoverWindow:setTexture("Enabled", "UIData/zombiresult_002.tga", 664, 0)
		CoverWindow:setTexture("Disabled", "UIData/zombiresult_002.tga", 664, 0)
		CoverWindow:setAlign(8)
		CoverWindow:setPosition(8, 132+(j*57)-57)
		if j == 0 then
			CoverWindow:setPosition(7, 62)
			CoverWindow:setTexture("Enabled", "UIData/zombiresult_002.tga", 664, 378)
			CoverWindow:setTexture("Disabled", "UIData/zombiresult_002.tga", 664, 378)
		end
		CoverWindow:setSize(180, 54)
		CoverWindow:setAlwaysOnTop(true)
		CoverWindow:setZOrderingEnabled(true)
		mywindow:addChildWindow(CoverWindow)
		
		-- 아이템 이미지
		subwindow = winMgr:createWindow("TaharezLook/StaticImage", "Defence_RewardSubItemImage"..i..j)
		subwindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
		subwindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		subwindow:setProperty("BackgroundEnabled", "False")
		subwindow:setProperty("FrameEnabled", "False")
		subwindow:setPosition(16, 138+(j*57)-57)
		if j == 0 then
			subwindow:setPosition(14, 69)
		end
		subwindow:setSize(128, 128)
		subwindow:setScaleWidth(80)
		subwindow:setScaleHeight(80)
		subwindow:setWheelEventDisabled(true)
		subwindow:setZOrderingEnabled(false)
		subwindow:setAlwaysOnTop(true)
		subwindow:setVisible(false)
		mywindow:addChildWindow(subwindow)
		
		
		--- 아이템 이름--------------------
		subwindow = winMgr:createWindow("TaharezLook/StaticText", "Defence_RewardSubItemText"..i..j)
		subwindow:setProperty("FrameEnabled", "false")
		subwindow:setProperty("BackgroundEnabled", "false")
		subwindow:setTextColor(255,255,255,255)
		subwindow:setFont(g_STRING_FONT_GULIMCHE, 12)
		subwindow:setPosition(80, 149+(j*57)-57)
		if j == 0 then
			subwindow:setPosition(80, 85)
		end
		subwindow:setSize(80, 20)
		subwindow:setViewTextMode(1)
		subwindow:setAlign(8)
		subwindow:setLineSpacing(2)
		subwindow:clearTextExtends()
		subwindow:setAlwaysOnTop(true)
		subwindow:setVisible(false)
		subwindow:setZOrderingEnabled(false)
		mywindow:addChildWindow(subwindow)
	end
	
	
	
end

-- 디펜스 보상 초기화

function ClearDefenceReward()
	for i =1 , 4 do
		winMgr:getWindow("Defence_RewardCharacterNameText"..i):clearTextExtends()
		
		for j= 0, 6 do
			winMgr:getWindow("Defence_RewardSubItemText"..i..j):clearTextExtends()
			winMgr:getWindow("Defence_RewardSubItemImage"..i..j):setTexture("Enabled","UIData/invisible.tga" , 0, 0)
		end
		
	end
end

local bCheckExpCount = { ["err"]=0,  1000000, 100000, 10000, 1000, 100, 10, 0}
local bCheckZenCount = { ["err"]=0,  100000, 10000, 1000, 100, 10, 0}

function SettingDefenceRewardExp(expPoint, ZenPoint)
	

	-- 경험치 자리수 계산
	local resultValue = expPoint
	local seven =  (resultValue/1000000)
	resultValue = resultValue - (seven * 1000000)
	local six =  (resultValue/100000)
	resultValue = resultValue - (six * 100000)
	local five =  (resultValue/10000)
	resultValue = resultValue - (five * 10000)
	local four =  (resultValue/1000)
	resultValue = resultValue - (four * 1000)
	local three = (resultValue/100)
	resultValue = resultValue - (three * 100)
	local two = (resultValue/10)
	resultValue = resultValue - (two * 10)
	local one = (resultValue%10)
	
	winMgr:getWindow("Defence_RewardExpNumberImage"..1):setTexture("Enabled","UIData/zombiResult_001.tga" , 111+(43*seven), 940)
	winMgr:getWindow("Defence_RewardExpNumberImage"..2):setTexture("Enabled","UIData/zombiResult_001.tga" , 111+(43*six), 940)
	winMgr:getWindow("Defence_RewardExpNumberImage"..3):setTexture("Enabled","UIData/zombiResult_001.tga" , 111+(43*five), 940)
	winMgr:getWindow("Defence_RewardExpNumberImage"..4):setTexture("Enabled","UIData/zombiResult_001.tga" , 111+(43*four), 940)
	winMgr:getWindow("Defence_RewardExpNumberImage"..5):setTexture("Enabled","UIData/zombiResult_001.tga" , 111+(43*three), 940)
	winMgr:getWindow("Defence_RewardExpNumberImage"..6):setTexture("Enabled","UIData/zombiResult_001.tga" , 111+(43*two), 940)
	winMgr:getWindow("Defence_RewardExpNumberImage"..7):setTexture("Enabled","UIData/zombiResult_001.tga" , 111+(43*one), 940)

	local ExpPos = 0
	for i = 1 , 7 do
		if expPoint >= bCheckExpCount[i] then
			winMgr:getWindow("Defence_RewardExpNumberImage"..i):setVisible(true)
			ExpPos = ExpPos + 30
		end
	end
	
	for i = 1 , 7 do
		winMgr:getWindow("Defence_RewardExpNumberImage"..i):setPosition((i*30)-100+ExpPos, 10)
	end
	
	
	-- 경험치 자리수 계산
	resultValue = ZenPoint
	six =  (resultValue/100000)
	resultValue = resultValue - (six * 100000)
	five =  (resultValue/10000)
	resultValue = resultValue - (five * 10000)
	four =  (resultValue/1000)
	resultValue = resultValue - (four * 1000)
	three = (resultValue/100)
	resultValue = resultValue - (three * 100)
	two = (resultValue/10)
	resultValue = resultValue - (two * 10)
	one = (resultValue%10)
	
	winMgr:getWindow("Defence_RewardZenNumberImage"..1):setTexture("Enabled","UIData/zombiResult_001.tga" , 111+(43*six), 940)
	winMgr:getWindow("Defence_RewardZenNumberImage"..2):setTexture("Enabled","UIData/zombiResult_001.tga" , 111+(43*five), 940)
	winMgr:getWindow("Defence_RewardZenNumberImage"..3):setTexture("Enabled","UIData/zombiResult_001.tga" , 111+(43*four), 940)
	winMgr:getWindow("Defence_RewardZenNumberImage"..4):setTexture("Enabled","UIData/zombiResult_001.tga" , 111+(43*three), 940)
	winMgr:getWindow("Defence_RewardZenNumberImage"..5):setTexture("Enabled","UIData/zombiResult_001.tga" , 111+(43*two), 940)
	winMgr:getWindow("Defence_RewardZenNumberImage"..6):setTexture("Enabled","UIData/zombiResult_001.tga" , 111+(43*one), 940)

	local ZenPos = 0
	
	for i = 1 , 6 do
		if ZenPoint >= bCheckZenCount[i] then
			winMgr:getWindow("Defence_RewardZenNumberImage"..i):setVisible(true)
			ZenPos = ZenPos + 30
		end
	end
	
	for i = 1 , 6 do
		winMgr:getWindow("Defence_RewardZenNumberImage"..i):setPosition(280+(i*30)+ZenPos, 10)
	end

end


local bHaveReward = { ["err"]=0, [0] = 0, 0, 0, 0, 0, 0, 0}

-- 디펜스 보상출력
function SettingDefenceReward(i, j , name , itemName , itemPath, myname)
	
	if name ~= "" then
		winMgr:getWindow("Defence_RewardBackSubImage"..i):setVisible(true)
		
		if myname == name then
			winMgr:getWindow("Defence_RewardBackSubImage"..i):setTexture("Enabled", "UIData/zombiResult_002.tga", 0, 0)
			winMgr:getWindow("Defence_RewardBackSubImage"..i):setTexture("Disabled", "UIData/zombiResult_002.tga", 0, 0)
		else
			winMgr:getWindow("Defence_RewardBackSubImage"..i):setTexture("Enabled", "UIData/zombiResult_002.tga", 197, 0)
			winMgr:getWindow("Defence_RewardBackSubImage"..i):setTexture("Disabled", "UIData/zombiResult_002.tga", 197, 0)
		end
		
		if i > 1 then
			winMgr:getWindow("Defence_RewardPartTyImage"):setVisible(true)
		end
	end
	
	local Message = CheckRewardLine(g_STRING_FONT_GULIM, 12, itemName, 110)
	
	-- 이름 입력
	winMgr:getWindow("Defence_RewardCharacterNameText"..i):setTextExtends(name, g_STRING_FONT_GULIM, 12, 255,255,255,255,   0, 255,255,255,255)
	
	if itemName ~= "" then
		bHaveReward[j] = 1
	end

		-- 아이템 이름 입력
	winMgr:getWindow("Defence_RewardSubItemText"..i..j):setTextExtends(Message, g_STRING_FONT_GULIM, 12, 255,255,255,255,   0, 255,255,255,255)
		
		-- 아이템 이미지 입력
	winMgr:getWindow("Defence_RewardSubItemImage"..i..j):setTexture("Enabled", itemPath, 0, 0)
	
	
end


		
local tBlackImage = { ["err"]=0, -1920, false}
local bShowResult = false

local bChangeCover = { ["err"]=0, 0, 0, 0, 0, 0, 0}
local bChangeTexY  = { ["err"]=0, 54, 108, 162, 216, 270, 324}
local bCoverTime   = { ["err"]=0, 10000, 10050, 10100, 10150, 10200, 10250}
local bBonusTime   = { ["err"]=0, [0] = 500, 1000, 1500, 2000, 2500, 3000, 3500}

local bCoverShowTime   = { ["err"]=0, [0] = 10750, 11250, 11750, 12250, 12750, 13250, 13750}
local ResultTime = 0
local DefaultCoverPosY = { ["err"]=0, [0] = 378, 0,0,0,0,0,0}
function DefenceResultMove(deltaTime)
	ResultTime = ResultTime + deltaTime
	
	if tBlackImage[1] >= 0 then
		tBlackImage[1] = 0
		winMgr:getWindow("Defence_RewardBlackBackImage"):setPosition(tBlackImage[1], 0)
		if bShowResult == false then
			bShowResult = true
			winMgr:getWindow("Defence_RewardBlackBackImage"):activeMotion("RewardMotion")
			winMgr:getWindow("Defence_RewardBlackBackImage2"):activeMotion("RewardMotion")
			winMgr:getWindow("Defence_RewardBlackBackImage2"):setVisible(true)
			
			winMgr:getWindow("Defence_ResultRankBackImage"):setVisible(true)
			winMgr:getWindow("Defence_ResultRankBackImage"):clearActiveController();
			winMgr:getWindow("Defence_ResultRankBackImage"):activeMotion('RankNumberEffect')
		end
	else	
		tBlackImage[1] = tBlackImage[1] + (deltaTime*3)
		if tBlackImage[1] >= 0 then
			tBlackImage[1] = 0
		end
		winMgr:getWindow("Defence_RewardBlackBackImage"):setPosition(tBlackImage[1], 0)
	end
	

	-- 컨트롤러 시작
	for k = 1, 6 do 
		for j = 0, 6 do
			
			if bChangeCover[j] ~=  k then
				if ResultTime > bCoverTime[k] + bBonusTime[j] then
					if bHaveReward[j] == 1 then
						for i = 1, 4 do
							winMgr:getWindow("Defence_Coverwindow"..i..j):setTexture("Enabled", "UIData/zombiresult_002.tga", 664, bChangeTexY[k]+DefaultCoverPosY[j])
							bChangeCover[j] = k
						end
					end
				end
			end
			
		end
	end
	
	-- 이펙트 시간 끝나면 아이템 이름 보여주기
	for j = 0, 6 do
		if ResultTime > bCoverShowTime[j] then
			for i = 1, 4 do 
				winMgr:getWindow("Defence_RewardSubItemImage"..i..j):setVisible(true)
				winMgr:getWindow("Defence_RewardSubItemText"..i..j):setVisible(true)
			end
		end
	end
		
end





--[[
--------------------------------------------------------------------
-- 광장 테스트 버튼 2
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "Test_Start_CutBtn111")
mywindow:setTexture("Normal", "UIData/channel_001.tga", 936, 676)
mywindow:setTexture("Hover", "UIData/channel_001.tga", 936, 701)
mywindow:setTexture("Pushed", "UIData/channel_001.tga", 936, 726)
mywindow:setTexture("PushedOff", "UIData/channel_001.tga", 936, 676)
mywindow:setWideType(0);
mywindow:setPosition(10, 430)
mywindow:setSize(88, 25)
mywindow:setAlwaysOnTop(true)
mywindow:setVisible(true)
mywindow:subscribeEvent("Clicked", "aaaaa")
root:addChildWindow(mywindow)

function aaaaa()
	winMgr:getWindow("Defence_ResultRankBackImage"):setVisible(true)
	winMgr:getWindow("Defence_ResultRankBackImage"):clearActiveController();
	winMgr:getWindow("Defence_ResultRankBackImage"):activeMotion('RankNumberEffect')
	--winMgr:getWindow("Defence_ResultRankNumberTopImage"..2):clearActiveController();
	--winMgr:getWindow("Defence_ResultRankNumberTopImage"..2):activeMotion('RankNumberEffect')
end
--]]