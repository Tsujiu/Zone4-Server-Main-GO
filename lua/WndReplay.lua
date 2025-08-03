 --------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local schemeMgr = CEGUI.SchemeManager:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)
--guiSystem:setDefaultTooltip("TaharezLook/Tooltip")





--------------------------------------------------------------------

-- 리플레이 리스트창 띄우기

--------------------------------------------------------------------
function LoadReplayList()
	WndSelectChannel_LoadReplayFile()
	winMgr:getWindow("리플레이 알파창"):setVisible(true)
	winMgr:getWindow("리플레이 바탕창"):setVisible(true)
end




--------------------------------------------------------------------

-- 리플레이 바탕창 이미지

--------------------------------------------------------------------
-- 백그라운드 알파 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "리플레이 알파창")
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


-- 리플레이 바탕창
replaywindow = winMgr:createWindow("TaharezLook/StaticImage", "리플레이 바탕창")
replaywindow:setTexture("Enabled", "UIData/mainBG_Button001.tga", 0, 392)
replaywindow:setTexture("Enabled", "UIData/mainBG_Button001.tga", 0, 392)
replaywindow:setProperty("FrameEnabled", "False")
replaywindow:setProperty("BackgroundEnabled", "False")
replaywindow:setPosition(338, 246)
replaywindow:setSize(349, 276)
replaywindow:setVisible(false)
replaywindow:setAlwaysOnTop(true)
replaywindow:setZOrderingEnabled(false)
root:addChildWindow(replaywindow)


-- 리플레이 리스트 박스
mywindow = winMgr:createWindow("TaharezLook/Listbox", "리플레이 리스트박스")
mywindow:setPosition(25, 46)
mywindow:setSize(300, 180)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 114)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:subscribeEvent("MouseDoubleClicked", "WndReplay_SelectReplay")
replaywindow:addChildWindow(mywindow)






--------------------------------------------------------------------

-- 리플레이 리스트에 추가하기

--------------------------------------------------------------------
function WndReplay_AddReplayList(replayName)

	local cols	  = CEGUI.PropertyHelper:stringToColourRect("tl:AAAAFFAA tr:AAAAFFAA bl:AAAAFFAA br:AAAAFFAA")
	local newItem = CEGUI.createListboxTextItem(replayName, 0, nil, false, true)
	newItem:setSelectionBrushImage("TaharezLook", "MultiListSelectionBrush")
	newItem:setSelectionColours(cols)

	CEGUI.toListbox(winMgr:getWindow("리플레이 리스트박스")):addItem(newItem)
end






--------------------------------------------------------------------

-- 리플레이 파일을 선택한다.

--------------------------------------------------------------------
function WndReplay_SelectReplay()

	local sel = CEGUI.toListbox(winMgr:getWindow("리플레이 리스트박스")):getSelectedIndex()
	if sel >= 0 then
	
		local item = CEGUI.toListbox(winMgr:getWindow("리플레이 리스트박스")):getListboxItemFromIndex(sel)
		local text = item:getText()
		WndSelectChannel_GoReplay(text)
		
	end
end






--------------------------------------------------------------------

-- 리플레이 리스트 확인, 취소 버튼

--------------------------------------------------------------------
tChoiceReplayName  = { ["protecterr"]=0, "리플레이 선택 확인버튼", "리플레이 선택 취소버튼" }
tChoiceReplayTexX  = { ["protecterr"]=0, 349, 429 }
tChoiceReplayPosX  = { ["protecterr"]=0, 165, 248 }
tChoiceReplayEvent = { ["protecterr"]=0, "ChoiceReplay_OK", "ChoiceReplay_CANCEL" }


for i=1, 2 do
	mywindow = winMgr:createWindow("TaharezLook/Button", tChoiceReplayName[i])
	mywindow:setTexture("Normal", "UIData/mainBG_Button001.tga", tChoiceReplayTexX[i], 392)
	mywindow:setTexture("Hover", "UIData/mainBG_Button001.tga", tChoiceReplayTexX[i], 426)
	mywindow:setTexture("Pushed", "UIData/mainBG_Button001.tga", tChoiceReplayTexX[i], 460)
	mywindow:setTexture("PushedOff", "UIData/mainBG_Button001.tga", tChoiceReplayTexX[i], 494)
	mywindow:setPosition(tChoiceReplayPosX[i], 228)
	mywindow:setSize(80, 34)
	mywindow:setAlwaysOnTop(true)
	mywindow:subscribeEvent("Clicked", tChoiceReplayEvent[i])
	replaywindow:addChildWindow(mywindow)
end



function ChoiceReplay_OK()
	WndReplay_SelectReplay()
	ChoiceReplay_CANCEL()
end



function ChoiceReplay_CANCEL()
	
	if winMgr:getWindow("리플레이 알파창") then
		winMgr:getWindow("리플레이 알파창"):setVisible(false)
		winMgr:getWindow("리플레이 바탕창"):setVisible(false)
	end
	
	if winMgr:getWindow("리플레이 리스트박스") then
		CEGUI.toListbox(winMgr:getWindow("리플레이 리스트박스")):clearAllItem()
	end
end
