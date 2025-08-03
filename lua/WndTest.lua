local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)
root:activate()

local RecivingData;


function SetupConsole()

end

function Log(text)
	
end

function Log2(text, number)
	
end

function Start()
	xpcall(DoStart, errorHandler1)
end

function DebugAndCheckDeltaTime()
	debugTime = Text("wndtest_debug_time")
	debugTime:setText("currentTime: --")

	debugDeltaTime = Text("wndtest_debug_deltatime")
	debugDeltaTime:setPosition(10, 20)
	debugDeltaTime:setText("deltaTime: --")

	debugText = Text("wndtest_debug_text0")
	debugText:setPosition(10, 40)	

	debugText1 = Text("wndtest_debug_text1")
	debugText1:setPosition(10, 60)	

	debugText2 = Text("wndtest_debug_text2")
	debugText2:setText("")
	debugText2:setPosition(10, 80)

	debugText:setText("INIT ERROR")

	TestButton = Text("DebugButton")
	TestButton:setText("Debug Button: None")
	TestButton:setPosition(10, 100)
	--winMgr:getWindow("DebugButton"):setText("Debug Button: None")

	ExecuteLua("common")
	ExecuteLua("Rank")
	
	-- InitTest_WndMatchMaking()
	-- InitTest_WndGameResult()
	-- InitTest_WndMatchMakingReward()	
	debugText:setText("INIT OK")
end



function DoStart()

	DebugAndCheckDeltaTime()  -- P'Boss Script

	-- Bring Some code in WndMyInfo
	-- ExecuteLua("WndMyInfo")		

	-- Example StaticImage but using UIData/myinfo as image assest
	myinfobackwindow = winMgr:createWindow("TaharezLook/StaticImage", "Myinfo_BackImage")
	myinfobackwindow:setTexture("Enabled", "UIData/myinfo.tga", 0, 0)
	myinfobackwindow:setTexture("Disabled", "UIData/myinfo.tga", 0, 0)
	myinfobackwindow:setProperty("FrameEnabled", "False")
	myinfobackwindow:setProperty("BackgroundEnabled", "False")
	myinfobackwindow:setPosition((g_MAIN_WIN_SIZEX - 501) / 2, (g_MAIN_WIN_SIZEY - 475) / 2)
	myinfobackwindow:setSize(501, 475)
	myinfobackwindow:setVisible(true)
	--myinfobackwindow:setAlwaysOnTop(true)
	--myinfobackwindow:setZOrderingEnabled(true)
	root:addChildWindow(myinfobackwindow)	

	for i = 1, 10 do
		local myButton= winMgr:createWindow("TaharezLook/Button", "Option_ScreenDropDownBt" .. tostring(i))
		
		-- Set textures for different button states
		-- myButton:setTexture("Normal", "UIData/option2.tga", 634, 233) -- Find UI from some button in game
		-- myButton:setTexture("Hover", "UIData/option2.tga", 634, 253)
		-- myButton:setTexture("Pushed", "UIData/option2.tga", 634, 273)
		-- myButton:setTexture("PushedOff", "UIData/option2.tga", 634, 293)

		myButton:setTexture("Normal", "UIData/Plus20.img", 0, 0)
		
		-- Position each button with a 20px increment on the Y-axis
		local posY = 168 + (i - 1) * 20
		myButton:setPosition(450, posY)  -- 450px X-axis, variable Y-axis
	
		-- Set size, visibility, and other properties
		myButton:setSize(30,30)  -- 20px x 20px button
		myButton:setScaleHeight(160)
		myButton:setScaleWidth(160)	
		myButton:setVisible(true)
		myButton:setZOrderingEnabled(false)
		myButton:setAlwaysOnTop(true)		
	
		-- Subscribe to the "Clicked" event for each button
		myButton:subscribeEvent("Clicked", function()			
			TestButton:setText("Cannot RecivingData at button [" .. tostring(i) .. "] ");		

			-- local RecivingData = TestingFunction()
			-- winMgr:getWindow("DebugButton"):setText(RecivingData)

			local SendingData = EditStat(tostring(i))
			winMgr:getWindow("DebugButton"):setText(SendingData)
			

		end)
	
		-- Add the button to the root window
		root:addChildWindow(myButton)
	end	

	local NewButton= winMgr:createWindow("TaharezLook/Button", "ImportButton")

	
	NewButton:setTexture("Normal", "UIData/Plus20.img", 0, 0) -- Find UI from some button in game	
	NewButton:setPosition(400, 168)  -- 450px X-axis, variable Y-axis
	NewButton:setSize(30,30)  -- 20px x 20px button
	NewButton:setScaleHeight(160)
	NewButton:setScaleWidth(160)	
	NewButton:setAlwaysOnTop(true)
	NewButton:setVisible(true)
	NewButton:subscribeEvent("Clicked", function()
		print("Button  clicked!")
		TestButton:setText("Cannot RecivingData!")	
		-- winMgr:getWindow("DebugButton"):setText("Dragon Debug Button: Button number is clicked!")

		local RecivingData = GetSkillPoint()
		TestButton:setText("Reciving Data: " .. RecivingData)
	
		-- tolua_addStat("atk_hit", 1){}
	end)
	root:addChildWindow(NewButton)


end


-- function TestRecivingData(MockText)

-- 	local RecivingData = MockText;
-- end








function RequestChangeTeam()

	ChangeTeamSize(4)
	

end

_currentTime = 0
_deltaTime = 0
function Update(currentTime, deltaTime)
	_currentTime = currentTime
	_deltaTime = deltaTime
	xpcall(DoUpdate, errorHandler2)
end

drawState = 0
luaTime = 0;
function DoUpdate()
	currentTime = _currentTime
	deltaTime = _deltaTime

	-- winMgr:getWindow("DebugButton"):setText("Debug Button: None")

	if currentTime > 100 then
		winMgr:getWindow("wndtest_debug_text2"):setText("ERROR")

		if winMgr:getWindow("wndtest_debug_text1") then
			winMgr:getWindow("wndtest_debug_text1"):setText("PLAY")
		end

		if winMgr:getWindow("wndtest_debug_time") then
			winMgr:getWindow("wndtest_debug_time"):setText("currentTime: " .. tostring(currentTime))
		end

		if winMgr:getWindow("wndtest_debug_deltatime") then
			winMgr:getWindow("wndtest_debug_deltatime"):setText("deltaTime: " .. tostring(deltaTime))
		end

		-- Test_WndMatchMaking(currentTime, deltaTime)
		-- Test_WndGameResult(currentTime, deltaTime)
		-- Test_WndMatchMakingReward(currentTime, deltaTime)

		winMgr:getWindow("wndtest_debug_text2"):setText("OK")
	end
end

function LateUpdate(currentTime, deltaTime)
	
end

function Destroy()

end

-- ////////////////////////////////////////////////////////////////////////////////
function Text(name)
	mywindow = winMgr:createWindow("TaharezLook/StaticText", name)
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont("tahoma", 16)
	-- mywindow:setFont(g_STRING_FONT_GULIMCHE, 12);
	mywindow:setText("")
	mywindow:setPosition(10, 0)
	mywindow:setSize(250, 36)
	mywindow:setAlwaysOnTop(true)
	root:addChildWindow(mywindow)
	return mywindow
end

function GetIsAutoMatch()
	text = Text("wndtest_GetIsAutoMatch")
	text:setText("GetIsAutoMatch")
	text:setPosition(200,200)
	return 0
end

function WndGameResult_IsClubBattle()
	text = Text("wndtest_WndGameResult_IsClubBattle")
	text:setText("WndGameResult_IsClubBattle")
	text:setPosition(200,220)
	return 0
end

function GetCurrentChannelBattleMode()
	return 0
end

function WndMatchMaking_IsTeamBattle()
	return 0
end

function WndMatchMaking_IsClubBattle()
	return 0
end

function WndMatchMaking_IsMaster()
	return 1
end

function WndMatchMaking_GetReady(slot)
	return 1
end

function WndMatchMaking_ChangeTeamMode(mode)
end

function CheckfacilityData(a)
	return 0
end

function CheckIsGM()
	return 0
end
-- ////////////////////////////////////////////////////////////////////////////////
luaTime = 0
playerIndex = 0
function InitTest_WndMatchMaking()
	ExecuteLua("WndMatchMaking")

	ExecuteLua("ItemClone")
	ExecuteLua("MyStorage")
	ExecuteLua("WndMatchMakingReward")

	WndMatchMaking_UpdateUserInfo(0, 0, 0, 0, 0, 1, 50, "Test01", 1, 0, 0, 0, 32, 20, 0, 0, 0, 0, 0, 0, "ClubTitle", 0, 1, 0, 0, 0)

	WndMatchMaking_UpdateUserInfo(1, 0, 4, 0, 0, 1, 50, "Test02", 1, 0, 0, 0, 32, 20, 0, 0, 0, 0, 0, 0, "ClubTitle", 0, 2, 0, 0, 0)

	WndMatchMaking_UpdateUserInfo(2, 0, 1, 0, 0, 1, 50, "Test03", 1, 0, 0, 0, 32, 20, 0, 0, 0, 0, 0, 0, "ClubTitle", 0, 3, 0, 0, 0)

	WndMatchMaking_UpdateUserInfo(3, 0, 5, 0, 0, 1, 50, "Test04", 1, 0, 0, 0, 32, 20, 0, 0, 0, 0, 0, 0, "ClubTitle", 0, 4, 0, 0, 0)

	WndMatchMaking_ShowMatchStatus(2)
	WndMatchMaking_ShowMatchFound()
	for i = 0, 7 do
		WndMatchMaking_Ready_SetReadyInfo(i, 5, 1)
	end
	WndMatchMaking_Ready_RenderPlayer()
end
function Test_WndMatchMaking(currentTime, deltaTime)
	WndMatchMaking_UpdateUserRank(0, 11)
	WndMatchMaking_UpdateUserRank(1, 22)
	WndMatchMaking_UpdateUserRank(2, 33)
	WndMatchMaking_UpdateUserRank(3, 27)

	WndMatchMaking_Ready_RenderTime(50-math.floor(currentTime / 1000))

	if luaTime > 500 then 
		if playerIndex < 8 then
			WndMatchMaking_Ready_SetReady(playerIndex)
			playerIndex = playerIndex + 1
		end
		luaTime = 0
	end
	luaTime = luaTime + deltaTime
end

rankIndex = 0
function InitTest_WndGameResult()
	ExecuteLua("WndGameResult")
	for i = 0, 8 do
		WndGameResult_InitResultInfo(i, 0, i, 1, "Test"..i, 
		100,1, 1000, 100, 1000, 100, 1, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0)
		WndGameResult_InitMatchMakingInfo(i, 160 - (i*40), 13 - i)
	end
end
function Test_WndGameResult(currentTime, deltaTime)
	
	-- if isStart == false then
	-- 	PlayWave("sound/button_click.wav");
	-- 	isStart = true
	-- end

	

	-- drawState = 0
	mySlot = 1
	bTeam = 1
	userNum = 8

	WndResult_ShowPvpRewardItem(deltaTime, drawState, 1, 0, 0, 1, "UIData/PvpReward/Insignia_Gold.tga", "You got 1.5 BTC !")

	-- WndGameResult_MyExtremePoint(drawState, 100000)

	WndGameResult_RenderMatchMaking(0, 1000, 1150, 27)

	WndGameResult_DrawResult(deltaTime, drawState, mySlot, bTeam, userNum, 0, 1, 0, 0, 0, 0, 0, 
		"Test1", 2, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0
	)

	WndGameResult_DrawMatchMakingResult(deltaTime, mySlot, userNum)

	WndGameResult_RenderResult(deltaTime, drawState, 1, 0, 0,
	0, 0, 0, "", "",
	"Test1", 1, 1000, 1000,
	1000, 1000, 100, 100,				
	50, 1000, 9000000, 3750000, 						
	0, 200, 700, 0,						
	100, 0, 0,					
	200, 0, 0, 1,		
	userNum, 1, 0, 20, 2000,	
	2000, 1, 0, 0)

	-- drawRank(math.fmod(rankIndex, 36), 797+10, 532+12, 240)

	
	-- drawer:drawTexture("UIData/match001.tga", 0, 0, 1024, 70, 0, 0, WIDETYPE_6)	
	-- drawer = root:getDrawer()
	-- drawer:setFont(g_STRING_FONT_GULIMCHE, 24)
	-- drawer:setTextColor(255, 255, 255,255)
	-- drawer:drawText("KUY YAW YAW", 200, 200, WIDETYPE_6)


	if luaTime > 3000 then 
		drawState = 1
	end

	-- if luaTime > 3000 then 
	-- 	-- luaTime = 101
	-- 	-- drawState = 1
	-- 	luaTime = 0
	-- 	rankIndex = rankIndex + 1
	-- end

	-- if luaTime > 10000 then
	-- 	luaTime = 0
	-- 	drawState = 0
	-- end
	luaTime = luaTime + deltaTime
end

function errorHandler1(err)
	mywindow = winMgr:getWindow("wndtest_debug_text0")
	mywindow:setText(err)
end

function errorHandler2(err)
	mywindow = winMgr:getWindow("wndtest_debug_text2")
	mywindow:setText(err)
end

function GetOnePageMaxCount()
	return 5
end

function GetCEGUIWindowRect()
	return 1024
end

function IsInitialized()
	return true
end

function PlayWave(str)
end

function GetVisualAvatarName(id)
	return "Item/Event_Songkran_03.tga"	
end

function InitTest_WndMatchMakingReward()
	ExecuteLua("ItemClone")
	ExecuteLua("MyStorage")
	ExecuteLua("WndMatchMakingReward")

	-- ExecuteLua("ItemListContainer")

	
	-- mywindow = winMgr:getWindow("ItemListContainer_BackImage")
	-- mywindow:setVisible(true)
end

isInit = false
function Test_WndMatchMakingReward(currentTime, deltaTime)
	if currentTime > 100 and isInit == false then

		isInit = true
	end

	if currentTime > 100 then
		WndMatchMakingReward_Render()
	end
end

debug1 = Text("wndtest_debug1")
debug1:setPosition(10, 120)
debug2 = Text("wndtest_debug2")
debug2:setPosition(10, 140)

function ABC()

	-- mywindow = winMgr:createWindow("TaharezLook/StaticText", "232323232")
	-- mywindow:setTextColor(255, 255, 255, 255)
	-- mywindow:setFont("tahoma", 16)
	-- mywindow:setText("TEST")
	-- mywindow:setPosition(400, 400)
	-- mywindow:setSize(250, 36)
	-- mywindow:setAlwaysOnTop(true)
	-- root:addChildWindow(mywindow)

	

end