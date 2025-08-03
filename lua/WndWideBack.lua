-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()

guiSystem:setGUISheet(root)
root:activate()

local CurrentPosIndex = MP_GetMPCurrentPos()
local tMP_OutputPosX		= {['err']=0, 925, 925 , 925, 920, 925, 925,925, 925,925, 925}
local tMP_OutputPosY		= {['err']=0, 615, 465 ,565, 415,565, 565,565, 565,565, 565}

local WINDOW_NAMES			= {['err']=0, "EscrowButton", "ShowTourBoardBtn", "StartFishingTest", "DigItemButton", "ViewItemButton", "VIPButton"}

DebugStr('CurrentPosIndex:'..CurrentPosIndex)

--CurrentPosIndex = 1 광장 2 대전
----------------------------------------------------------------------------------
-- 기능 버튼 모음 백판( 메가폰, 드릴, 아이템뷰, 낚시, 이펙트 등
----------------------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Wide_funtion_BackImage")	
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 315)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 315)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(4);
--mywindow:setPosition(tMP_OutputPosX[CurrentPosIndex] , tMP_OutputPosY[CurrentPosIndex])
mywindow:setPosition(934 , 0)
mywindow:setSize(86, 679)
mywindow:setVisible(true)
mywindow:setEnabled(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)
mywindow:moveToBack()


for i = 1, #WINDOW_NAMES do
	local window = winMgr:getWindow(WINDOW_NAMES[i])
	if window then
		window:subscribeEvent	("Shown", "RefreshWideFuntionBtn")
		window:subscribeEvent	("Hidden", "RefreshWideFuntionBtn")
		mywindow:addChildWindow( window )
	end
end
mywindow:addChildWindow( winMgr:getWindow("ViewItemButton"))
mywindow:addChildWindow( winMgr:getWindow("DigItemButton"))
mywindow:addChildWindow( winMgr:getWindow("VIPButton"))
--mywindow:addChildWindow( winMgr:getWindow("MP_UseIconButton"))
--mywindow:removeChildWindow( winMgr:getWindow("ShowTourBoardBtn"))
mywindow:addChildWindow( winMgr:getWindow("ShowTourBoardBtn"))
mywindow:removeChildWindow( winMgr:getWindow("EscrowButton"))
--mywindow:addChildWindow( winMgr:getWindow("UseEffectItemBtn"))
--mywindow:addChildWindow( winMgr:getWindow("ShowEffectItemBtn"))


function RefreshWideFuntionBtn()

	local pos = 647
	
	for i = 1, #WINDOW_NAMES do
		local window = winMgr:getWindow(WINDOW_NAMES[i])
		if window then
			if winMgr:getWindow(WINDOW_NAMES[i]):isVisible() then
				winMgr:getWindow(WINDOW_NAMES[i]):setPosition(0, pos)
				pos = pos - 32
			end
		end	
	end
	
end
