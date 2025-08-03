local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)
root:activate()

g_GAME_WIN_SIZEX, g_GAME_WIN_SIZEY = GetCurrentResolution()
screenOffsetX = (1920 - g_GAME_WIN_SIZEX) / 2
screenOffsetY = (1080 - g_GAME_WIN_SIZEY) / 2
-- screenOffsetX = (g_MAIN_WIN_SIZEX - 1024) / 2
-- screenOffsetY = (g_MAIN_WIN_SIZEY - 768) / 2

bgWindow = winMgr:createWindow("TaharezLook/StaticImage", "rank_reward_bg")
bgWindow:setTexture("Enabled", "UIData/rank_reward_bg.tga", screenOffsetX, screenOffsetY)
bgWindow:setPosition(0, 0)
bgWindow:setSize(g_GAME_WIN_SIZEX, g_GAME_WIN_SIZEY)
bgWindow:setVisible(true)
bgWindow:setEnabled(true)
bgWindow:setAlwaysOnTop(true)
bgWindow:setZOrderingEnabled(false)
bgWindow:setSubscribeEvent("MouseWheel", "MouseWheelEvent")
root:addChildWindow(bgWindow)

mainWindow = winMgr:createWindow("TaharezLook/StaticImage", "rank_reward_window")
mainWindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
-- mainWindow:setWideType(6)
mainWindow:setPosition(0, 0)
mainWindow:setSize(g_GAME_WIN_SIZEX, g_GAME_WIN_SIZEY)
mainWindow:setVisible(true)
mainWindow:setEnabled(true)
mainWindow:setAlwaysOnTop(true)
mainWindow:setZOrderingEnabled(false)
mainWindow:setSubscribeEvent("MouseWheel", "MouseWheelEvent")
root:addChildWindow(mainWindow)

-- COMMING SOON
mywindow = winMgr:createWindow("TaharezLook/StaticText", name)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont("tahoma", 22)
-- mywindow:setFont(g_STRING_FONT_GULIMCHE, 12);
-- mywindow:setText(tostring(screenOffsetX) .. "x" .. tostring(screenOffsetY))
mywindow:setText("Coming soon...")
mywindow:setWideType(6)
mywindow:setPosition(700, 360)
mywindow:setSize(85, 36)
mywindow:setAlwaysOnTop(true)
mainWindow:addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/Button", "NewRankRewardExitBtn")
mywindow:setTexture("Normal", "UIData/rank_reward_texture.tga", 0, 0)
mywindow:setTexture("Hover", "UIData/rank_reward_texture.tga", 162, 0)
mywindow:setTexture("Pushed", "UIData/rank_reward_texture.tga", 0, 0)
mywindow:setTexture("PushedOff", "UIData/rank_reward_texture.tga", 0, 0)
mywindow:setTexture("Enabled", "UIData/rank_reward_texture.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/rank_reward_texture.tga", 0, 0)
mywindow:setWideType(6)
mywindow:setPosition(1024-162, 0)
mywindow:setSize(162, 32)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "DoOnclickLeaveRankReward")
mainWindow:addChildWindow(mywindow)

function DoOnclickLeaveRankReward()
	PlayWave("sound/button_click.wav");
	WndMatchMakingReward_Toggle(false)
end

bannerWindow = winMgr:createWindow("TaharezLook/StaticImage", "rank_reward_banner")
bannerWindow:setTexture("Enabled", "UIData/rank_reward_banner1.tga", 1, 1)
-- bannerWindow:setPosition(screenOffsetX, screenOffsetY)
bannerWindow:setWideType(6)
bannerWindow:setPosition(0, 0)
bannerWindow:setSize(512, 768)
bannerWindow:setVisible(true)
mainWindow:addChildWindow(bannerWindow)

panelWindow = winMgr:createWindow("TaharezLook/StaticImage", "rank_reward_panel")
panelWindow:setTexture("Enabled", "UIData/invisible.tga", 242, 837)
panelWindow:setProperty("FrameEnabled", "True")
panelWindow:setProperty("BackgroundEnabled", "True")
panelWindow:setWideType(6)
panelWindow:setPosition(0, 0)
panelWindow:setSize(151, 93)
panelWindow:setVisible(false)
mainWindow:addChildWindow(panelWindow)

function DoClaimReward(args)
	local	local_window = CEGUI.toWindowEventArgs(args).window;
	index = tonumber(local_window:getUserString("DoClaimRewardIndex"))
end

for j=0, 7 do
	itemWindow = winMgr:createWindow("TaharezLook/StaticImage", "rank_reward_item" .. j)
	itemWindow:setTexture("Enabled", "UIData/MatchMakingRoom1.png", 242, 837)
	itemWindow:setProperty("FrameEnabled", "True")
	itemWindow:setProperty("BackgroundEnabled", "True")
	itemWindow:setPosition(500, 110 * j)
	itemWindow:setSize(151, 93)
	itemWindow:setVisible(true)
	panelWindow:addChildWindow(itemWindow)

	mywindow = winMgr:createWindow("TaharezLook/Button", "NewMatchMakingExitBtn" .. j)
	mywindow:setTexture("Normal", "UIData/MatchMakingRoom1.tga", 1, 405)
	mywindow:setTexture("Hover", "UIData/MatchMakingRoom1.tga", 202, 405)
	mywindow:setPosition(300, 30)
	mywindow:setSize(199, 35)
	mywindow:setEnabled(true)
	mywindow:setVisible(true)
	mywindow:setUserString("DoClaimRewardIndex", j)
	mywindow:subscribeEvent("Clicked", "DoClaimReward")
	itemWindow:addChildWindow(mywindow)

	for i=0, 3 do
		rewardWindow = winMgr:createWindow("TaharezLook/RadioButton", "MyStorage_ItemList_Button_".. j .. "_" .. i)
		rewardWindow:setTexture("Normal", "UIData/invisible.tga", 0, 0)
		rewardWindow:setTexture("Hover", "UIData/Match002.tga", 667, 694)
		rewardWindow:setTexture("Pushed", "UIData/Match002.tga", 667, 742)
		rewardWindow:setTexture("PushedOff", "UIData/Match002.tga", 667, 26)
		rewardWindow:setTexture("SelectedNormal", "UIData/invisible.tga", 0, 0)
		rewardWindow:setTexture("SelectedHover", "UIData/Match002.tga", 667, 694)
		rewardWindow:setTexture("SelectedPushed", "UIData/Match002.tga", 667, 742)
		rewardWindow:setTexture("SelectedPushedOff", "UIData/Match002.tga", 667, 742)
		rewardWindow:setPosition(70 * i, 15)
		rewardWindow:setSize(100, 100)
		rewardWindow:setScaleWidth(160)
		rewardWindow:setScaleHeight(160)
		rewardWindow:setVisible(true)
		-- rewardWindow:setUserString("Index", tostring(i))
		-- rewardWindow:subscribeEvent("MouseDoubleClicked", "MyStorage_ItemdoubleClick")
		-- rewardWindow:subscribeEvent("MouseEnter", "MyStorage_ItemMouseEnter")
		-- rewardWindow:subscribeEvent("MouseLeave", "MyStorage_ItemMouseLeave")
		itemWindow:addChildWindow(rewardWindow)

		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ItemListContainer_Image_".. j .. "_" .. i)
		mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
		mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		mywindow:setPosition(0, 0)
		mywindow:setSize(100, 100)
		mywindow:setVisible(true)
		rewardWindow:addChildWindow(mywindow)

		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ItemListContainer_Image_Back_".. j .. "_" .. i)
		mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
		mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		mywindow:setPosition(0, 0)
		mywindow:setSize(100, 100)
		mywindow:setVisible(true)
		rewardWindow:addChildWindow(mywindow)

		SetAvatarIconS("ItemListContainer_Image_" , "ItemListContainer_Image_", "ItemListContainer_Image_Back_" , j .. "_" .. i , 1000 , 0)
	end
end

scrollSpeed = 40
scrollPosition = -1
function MouseWheelEvent(args)

	local delta = CEGUI.toMouseEventArgs(args).wheelChange
	scrollPosition = scrollPosition + (delta * scrollSpeed)

	if scrollPosition > -1 then
		scrollPosition = -1
	end

end

currentScrollPosition = -1
function WndMatchMakingReward_Render()
	
	-- mywindow = winMgr:getWindow("rank_reward_debug1")
	-- mywindow:setText("value: " .. tostring(scrollPosition))

	currentScrollPosition = currentScrollPosition + ((scrollPosition - currentScrollPosition)/8)
	if currentScrollPosition > -1 then
		currentScrollPosition = -1
	end

	mywindow = winMgr:getWindow("rank_reward_panel")
	mywindow:setPosition(0, currentScrollPosition)

end

function WndMatchMakingReward_Toggle(isEnabled)
	bgWindow = winMgr:getWindow("rank_reward_bg")
	bgWindow:setVisible(isEnabled)
	bgWindow:setEnabled(isEnabled)

	mainWindow = winMgr:getWindow("rank_reward_window")
	mainWindow:setVisible(isEnabled)
	mainWindow:setEnabled(isEnabled)
end

WndMatchMakingReward_Toggle(false)

-- GetCoin01 hit_low - ready
-- resurrection ItemUse_SP - open season reward page
-- Item_Skill_Shop basic_Ori - reward bg sound
-- countDown - time countdown - not ready
-- Top_popmenu - time countdown - ready
-- Time_Extension - click get reward

-- Battle_Sword_14 Battle_Sword_19 Battle_Spear_10 Battle_Spear_2 - matched
-- Boss_gi - game start
-- 