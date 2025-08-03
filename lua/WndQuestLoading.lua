 --------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)
root:activate()

g_Loading_WIN_SIZEX, g_Loading_WIN_SIZEY = GetCurrentResolution()

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "WndQuestLoadingBackImage")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setPosition(0, 0)
mywindow:setSize(g_Loading_WIN_SIZEX, g_Loading_WIN_SIZEY)
mywindow:setVisible(false)
root:addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "WndQuestLoadingImage")
mywindow:setTexture("Enabled", "UIData/Arcade_lobby.tga", 491, 496)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setPosition( ( g_Loading_WIN_SIZEX / 2 ) - ( 533 / 2 ), ( g_Loading_WIN_SIZEY / 2 ) - ( 250 / 2 ) )
mywindow:setSize(533, 250)
mywindow:setVisible(true)
winMgr:getWindow("WndQuestLoadingBackImage"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticText", "WndQuestLoadingText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont(LAN_FONT_HY_HEADLINE, 24)
mywindow:setText("")
mywindow:setPosition(0, 0)
mywindow:setSize(100, 50)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("WndQuestLoadingImage"):addChildWindow(mywindow)



--------------------------------------------------------------------

-- 로딩 배경 이미지

--------------------------------------------------------------------
function WndQuestLoading_RenderBackImage(loadingText)
	winMgr:getWindow('NewMoveExitBtn'):setVisible(false)
	winMgr:getWindow("WndQuestLoadingBackImage"):setVisible(true)

	local size = GetStringSize(LAN_FONT_HY_HEADLINE, 24, loadingText)
	winMgr:getWindow("WndQuestLoadingText"):setPosition((513 / 2) - (size / 2), 146);
	winMgr:getWindow("WndQuestLoadingText"):setText(loadingText)
	
end

function WndQuestLoading_EndImage()
	winMgr:getWindow('NewMoveExitBtn'):setVisible(true)
	winMgr:getWindow("WndQuestLoadingText"):setText("")
	winMgr:getWindow("WndQuestLoadingBackImage"):setVisible(false)
end







--------------------------------------------------------------------

-- 로딩 배경 이미지

--------------------------------------------------------------------
function WndQuestLoading_RenderCharacter(count, slot, mySlot, type, level, name, percent, transform)

--[[
	local spacing = 145

	-- SD케릭터
--	drawer:drawTexture("UIData/GameImage.tga", 26+(count*spacing), 606, 87, 123, 348, 0+(type*123))	-- 흑백
--	local currImage = 123*(100-percent)/100	-- 아래서부터 차기 위해선 100-percent
--	drawer:drawTexture("UIData/GameImage.tga", 36+(count*spacing), 606+currImage, 87, 123*percent/100, 257, 0+(type*123)+currImage)

	-- 선택된 케릭터 정보창
	drawer:drawTexture("UIData/quest1.tga", 26+(count*spacing), 620, 104, 142, 0, 664)
	
	-- 케릭터 얼굴 이미지
	if transform <= 0 then	
		drawer:drawTexture("UIData/GameImage.tga", 26+(count*spacing)+13, 623, 78, 96, 0, type*98)
	else
		drawer:drawTexture("UIData/characterNewImage.tga", 26+(count*spacing)+13, 623, 78, 96, tTransformBigTexX[transform], tTransformBigTexY[transform])
	end

	drawer:setTextColor(255, 255, 255, 255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
		
	local info = "Lv." .. level .. " " .. name
	local size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, info)
	if slot == mySlot then
		drawer:setTextColor(255,205,86,255)
		common_DrawOutlineText1(drawer, info, 78-size/2+(count*spacing), 598, 0,0,0,255, 255,205,86,255)
	else
		common_DrawOutlineText1(drawer, info, 78-size/2+(count*spacing), 598, 0,0,0,255, 255,255,255,255)
	end
		
	-- 퍼센트
	drawer:setFont("Times new roman", 24)
	info = percent .. "%"
	size = GetStringSize("Times new roman", 24, info)
	drawer:drawText(info, 80-size/2+(count*spacing), 738)
--]]
end




