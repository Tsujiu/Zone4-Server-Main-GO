-----------------------------------------
-- Script Entry Point
-----------------------------------------
--[[
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)
root:activate()
--]]

--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------

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


local g_bSetup = false
local g_enterCount = 0
local g_admissionFee = 0
function WndQuestRoom_SetTournamentArcadeInfo(enterCount, admissionFee)
	g_bSetup = true
	g_enterCount = enterCount
	g_admissionFee = admissionFee
end


--------------------------------------------------------------------

-- drawTexture(StartRender:시작시에 그리기)

--------------------------------------------------------------------
function WndQuestRoom_RenderBackImages()
	
	-- 금일 입장 횟수
	drawer:drawTexture("UIData/Tournament001.tga", 406, 400, 213, 79, 0, 0)
	
	-- 입장료
	drawer:drawTexture("UIData/Tournament001.tga", 406, 486, 213, 106, 0, 79)
	
	-- 설명
	if CheckfacilityData(FACILITYCODE_TOURNAMENTEXPLAIN) == 1 then
		drawer:drawTexture("UIData/Tournament001.tga", 198, 620, 628, 72, 396, 952)
	end
	
	if g_bSetup then
		DrawEachNumber("UIData/dungeonmsg.tga", g_enterCount, 8, 500, 436, 727, 675, 20, 22, 27, drawer)
		DrawEachNumber("UIData/dungeonmsg.tga", g_admissionFee, 8, 500, 520, 727, 675, 20, 22, 27, drawer)
	end
end


-- 입장하기, 취소
tTA_Btn_Name  = {["err"]=0, "sj_TA_gotoMyRoomBtn", "sj_TA_ExitRoomBtn"}
tTA_Btn_TexX  = {["err"]=0, 0, 69}
tTA_Btn_PosX  = {["err"]=0, 436, 520}
tTA_Btn_Event = {["err"]=0, "GotoMyDungeon", "ExitDungeon"}

for i=1, #tTA_Btn_Name do
	mywindow = winMgr:createWindow("TaharezLook/Button",	tTA_Btn_Name[i])
	mywindow:setTexture("Normal", "UIData/Tournament001.tga",	tTA_Btn_TexX[i], 185)
	mywindow:setTexture("Hover", "UIData/Tournament001.tga",	tTA_Btn_TexX[i], 207)
	mywindow:setTexture("Pushed", "UIData/Tournament001.tga",	tTA_Btn_TexX[i], 229)
	mywindow:setTexture("PushedOff", "UIData/Tournament001.tga", tTA_Btn_TexX[i], 185)
	mywindow:setPosition(tTA_Btn_PosX[i], 563)
	mywindow:setSize(69, 22)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", tTA_Btn_Event[i])
	root:addChildWindow(mywindow)
end

function GotoMyDungeon()
	WndQuestRoom_Ready()
end


function ExitDungeon()
	GotoWndVillage()
end



local g_LevelupMoney = 0
------------------------------------------------
-- 레벨업 이벤트 보여준다.
------------------------------------------------
function ShowLevelUpEvent(LevelupMoney)
	g_LevelupMoney = LevelupMoney
	RegistEscEventInfo("LevelUpEventAlpha", "LevelUpEventButtonEvent")
	RegistEnterEventInfo("LevelUpEventAlpha", "LevelUpEventButtonEvent")
	root:addChildWindow(winMgr:getWindow("LevelUpEventAlpha"))
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
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_TA_error_alphaWindow")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

-- 에러 보일창
errorwindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_TA_error_backWindow")
errorwindow:setTexture("Enabled", "UIData/popup001.tga", 0, 0)
errorwindow:setTexture("Disabled", "UIData/popup001.tga", 0, 0)
errorwindow:setProperty("FrameEnabled", "False")
errorwindow:setProperty("BackgroundEnabled", "False")
errorwindow:setPosition(338, 246)
errorwindow:setSize(346, 275)
errorwindow:setVisible(false)
errorwindow:setAlwaysOnTop(true)
errorwindow:setZOrderingEnabled(false)
root:addChildWindow(errorwindow)


-- 에러 내용창
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_TA_error_descWindow")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setPosition(0, 126)
mywindow:setSize(349, 100)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:clearTextExtends()
mywindow:setAlwaysOnTop(true)
errorwindow:addChildWindow(mywindow)

-- 에러 확인버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_TA_error_okBtn")
mywindow:setTexture("Normal", "UIData/popup001.tga",693, 617)
mywindow:setTexture("Hover", "UIData/popup001.tga", 693, 646)
mywindow:setTexture("Pushed", "UIData/popup001.tga", 693, 675)
mywindow:setTexture("PushedOff", "UIData/popup001.tga", 693, 704)
mywindow:setPosition(4, 235)
mywindow:setSize(331, 29)
mywindow:setAlwaysOnTop(true)
mywindow:subscribeEvent("Clicked", "ClickedWndTA_OKBtn")
errorwindow:addChildWindow(mywindow)

function WndTA_ErrorMessage(msg)
	winMgr:getWindow("sj_TA_error_alphaWindow"):setVisible(true)
	winMgr:getWindow("sj_TA_error_backWindow"):setVisible(true)
	winMgr:getWindow("sj_TA_error_descWindow"):setTextExtends(msg, g_STRING_FONT_GULIMCHE, 14, 255,255,255,255,  0, 0,0,0,255)
end


function ClickedWndTA_OKBtn()
	winMgr:getWindow("sj_TA_error_alphaWindow"):setVisible(false)
	winMgr:getWindow("sj_TA_error_backWindow"):setVisible(false)
	winMgr:getWindow("sj_TA_error_descWindow"):setTextExtends("", g_STRING_FONT_GULIMCHE, 14, 255,255,255,255,  0, 0,0,0,255)
end


-- 파티 매치 ESC키 등록
RegistEscEventInfo("sj_TA_error_backWindow", "ClickedWndTA_OKBtn")
RegistEnterEventInfo("sj_TA_error_backWindow", "ClickedWndTA_OKBtn")

