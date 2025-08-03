local guiSystem = CEGUI.System:getSingleton()
local winMgr = CEGUI.WindowManager:getSingleton()
local root = winMgr:getWindow("DefaultWindow")
local drawer = root:getDrawer()
guiSystem:setGUISheet(root)
root:activate()

local RecivingData;
CounterText = winMgr:createWindow("TaharezLook/StaticText", name)

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

    -- TestButton = Text("DebugButton")
    -- TestButton:setText("Debug Button: None")
    -- TestButton:setPosition(10, 100)
    -- --winMgr:getWindow("DebugButton"):setText("Debug Button: None")

    -- ExecuteLua("common")
    -- ExecuteLua("Rank")

    -- -- InitTest_WndMatchMaking()
    -- -- InitTest_WndGameResult()
    -- -- InitTest_WndMatchMakingReward()	
    debugText:setText("INIT OK")
end

function DoStart()

    -- DebugAndCheckDeltaTime()

    -- Background image
    BackgroundIMG = winMgr:createWindow("TaharezLook/StaticImage", "BackgroundIMG")
    BackgroundIMG:setTexture("Enabled", "UIData/BackGroundWide002.img", 0, 0)
    BackgroundIMG:setTexture("Disabled", "UIData/myinfo.tga", 0, 0)
    BackgroundIMG:setProperty("FrameEnabled", "False")
    BackgroundIMG:setProperty("BackgroundEnabled", "False")
    BackgroundIMG:setPosition(0, 0)
    BackgroundIMG:setSize(2048, 2048)
    BackgroundIMG:setVisible(true)
    BackgroundIMG:setAlwaysOnTop(false)
    BackgroundIMG:setZOrderingEnabled(false)
    root:addChildWindow(BackgroundIMG)

    -- Grid Ref position
    -- GridBackground = winMgr:createWindow("TaharezLook/StaticImage", "GridBackground")
    -- GridBackground:setTexture("Enabled", "UIData/Grid.png", 0, 0)
    -- GridBackground:setTexture("Disabled", "UIData/myinfo.tga", 0, 0)
    -- GridBackground:setProperty("FrameEnabled", "False")
    -- GridBackground:setProperty("BackgroundEnabled", "False")	
    -- GridBackground:setPosition(0, 0)
    -- GridBackground:setSize(1024, 1024)
    -- GridBackground:setVisible(true)
    -- GridBackground:setAlwaysOnTop(true)
    -- GridBackground:setZOrderingEnabled(true)
    -- BackgroundIMG:addChildWindow(GridBackground)    

    -- Blue Team
    for i = 1, 4 do
        -- Calculate base position
        local baseX = 17 + (i - 1) * 100 -- Horizontal positioning for each column
        local baseY = (g_MAIN_WIN_SIZEY - 200) / 2 -- Center vertical positioning

        -- Character BackgroundIcon
        local iconName = "LBackgroundIcon" .. i
        local BlueBackgroundIcon = winMgr:createWindow("TaharezLook/Button", iconName)
        BlueBackgroundIcon:setTexture("Normal", "UIData/Character_Match_Making.png", 0, 818)
        BlueBackgroundIcon:setSize(87, 87) -- Base on figma
        BlueBackgroundIcon:setPosition(baseX - 5, baseY - 75 - 5) -- Icon above panel
        BlueBackgroundIcon:setAlwaysOnTop(true)
        BackgroundIMG:addChildWindow(BlueBackgroundIcon)

        -- Character Icon
        local iconName = "LIcon" .. i
        local BlueIcon = winMgr:createWindow("TaharezLook/Button", iconName)
        BlueIcon:setTexture("Normal", "UIData/Character_Match_Making.png", 337, 658)
        BlueIcon:setTexture("Enabled", "UIData/Character_Match_Making.png", 337, 658)
        BlueIcon:setTexture("Disabled", "UIData/Character_Match_Making.png", 0, 818)
        BlueIcon:setSize(79, 79) -- Base on figma
        BlueIcon:setPosition(baseX, baseY - 70) -- Icon above panel with 5px padding
        BlueIcon:setAlwaysOnTop(true)
        BackgroundIMG:addChildWindow(BlueIcon)

        -- Character Panal
        local panalName = "LPanal" .. i
        local BluePanal = winMgr:createWindow("TaharezLook/Button", panalName)
        BluePanal:setTexture("Normal", "UIData/Character_Match_Making.png", 552, 225)
        BluePanal:setTexture("Enabled", "UIData/Character_Match_Making.png", 552, 225)
        BluePanal:setTexture("Disabled", "UIData/Character_Match_Making.png", 4, 440)
        BluePanal:setSize(90, 200) -- Base on figma
        BluePanal:setPosition(baseX - 5, baseY + 15) -- Panel position
        BluePanal:setEnabled(false)
        BluePanal:setAlwaysOnTop(true)
        BackgroundIMG:addChildWindow(BluePanal)
    end

    -- Red Team
    for i = 1, 4 do
        -- Calculate base position
        -- Calculate base position
        local baseX = 1000 - (i - 1) * 100 -- Decrease X position by 100px for each iteration
        local baseY = (g_MAIN_WIN_SIZEY - 200) / 2 -- Center vertical positioning

        -- Character BackgroundIcon
        local iconName = "RBackgroundIcon" .. i
        local RedBackgroundIcon = winMgr:createWindow("TaharezLook/Button", iconName)
        RedBackgroundIcon:setTexture("Normal", "UIData/Character_Match_Making.png", 0, 915)
        RedBackgroundIcon:setSize(87, 87) -- Base on figma
        RedBackgroundIcon:setPosition(baseX - 80, baseY - 79) -- Icon above panel
        RedBackgroundIcon:setAlwaysOnTop(true)
        BackgroundIMG:addChildWindow(RedBackgroundIcon)

        -- Character Icon                                                                                                                                                                                                                                                                                                          
        local iconName = "RIcon" .. i
        local RedIcon = winMgr:createWindow("TaharezLook/Button", iconName)
        RedIcon:setTexture("Normal", "UIData/Character_Match_Making.png", 337, 658)
        RedIcon:setSize(79, 79) -- Base on figma
        RedIcon:setPosition(baseX - 79, baseY - 70) -- Icon above panel
        RedIcon:setAlwaysOnTop(true)
        BackgroundIMG:addChildWindow(RedIcon)

        -- Character Panal
        local panalName = "RPanal" .. i
        local BluePanal = winMgr:createWindow("TaharezLook/Button", panalName)
        BluePanal:setTexture("Normal", "UIData/Character_Match_Making.png", 552, 10)
        BluePanal:setTexture("Enabled", "UIData/Character_Match_Making.png", 552, 10)
        BluePanal:setTexture("Disabled", "UIData/Character_Match_Making.png", 4, 440)
        BluePanal:setSize(90, 200) -- Base on figma
        BluePanal:setPosition(baseX - 80, baseY + 15) -- Panel position
        BluePanal:setEnabled(false)
        BluePanal:setAlwaysOnTop(true)
        BackgroundIMG:addChildWindow(BluePanal)
    end

    -- Vs 
    VSText = winMgr:createWindow("TaharezLook/Button", "VSText")
    VSText:setTexture("Normal", "UIData/Character_Match_Making.png", 644, 308)
    VSText:setSize(55, 69) -- Base on figma
    VSText:setPosition(((g_MAIN_WIN_SIZEY - 55) / 2) + 125, (g_MAIN_WIN_SIZEY - 69) / 2)
    VSText:setAlwaysOnTop(true)
    BackgroundIMG:addChildWindow(VSText)

    -- Submit button
    StartButton = winMgr:createWindow("TaharezLook/Button", "StartButton")
    StartButton:setTexture("Normal", "UIData/WndRankingTabbar.png", 17, 233)
    StartButton:setTexture("Hover", "UIData/WndRankingTabbar.png", 322, 233)
    StartButton:setTexture("Pushed", "UIData/WndRankingTabbar.png", 17, 233)
    StartButton:setTexture("Disabled", "UIData/WndRankingTabbar.png", 322, 233)
    StartButton:setPosition(((g_MAIN_WIN_SIZEY - 150) / 2) + 125, 550)
    StartButton:setSize(250, 75)
    StartButton:subscribeEvent("Clicked", "StartButtonClicked")
    root:addChildWindow(StartButton)

	function StartButtonClicked()
		SendReadyTCP()  
	end

    -- Logo backdrop
    Backdrop = winMgr:createWindow("TaharezLook/Button", "Backdrop")
    Backdrop:setTexture("Normal", "UIData/Character_Match_Making.png", 376, 818)
    Backdrop:setSize(356, 54) -- Base on figma
    Backdrop:setPosition(20, 700)
    Backdrop:setAlwaysOnTop(true)
    BackgroundIMG:addChildWindow(Backdrop)

    -- -- Ranking Map Logo (Map Name)
    MapLogo = winMgr:createWindow("TaharezLook/Button", "MapLogo")
    MapLogo:setTexture("Normal", "UIData/Character_Match_Making.png", 508, 510)
    MapLogo:setSize(309, 48) -- Base on figma
    MapLogo:setPosition(30, 50)
    MapLogo:setAlwaysOnTop(true)
    BackgroundIMG:addChildWindow(MapLogo)

    -- Ranking Map Logo2 (Ranking)
    MapLogo2 = winMgr:createWindow("TaharezLook/Button", "MapLogo2")
    MapLogo2:setTexture("Normal", "UIData/Character_Match_Making.png", 508, 550)
    MapLogo2:setSize(309, 48) -- Base on figma
    MapLogo2:setPosition(-60, 10)
    MapLogo2:setAlwaysOnTop(true)
    BackgroundIMG:addChildWindow(MapLogo2)

    -- Counting Text
    CounterText:setTextColor(0, 0, 0, 255)
    CounterText:setFont("tahoma", 30)
    CounterText:setText(tostring(30))
    CounterText:setPosition(((g_MAIN_WIN_SIZEX - 250) / 2) + 105, -350)
    CounterText:setAlwaysOnTop(true)
    root:addChildWindow(CounterText)

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

local IsCountDown = false

function DoUpdate()
    currentTime = _currentTime
    deltaTime = _deltaTime

    if (IsCountDown) then
        CounterText:setText(currentTime)
    end

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

    -- LOG("Test currentTime:" .. _currentTime)
    -- LOG("Test deltaTime:" .. _deltaTime)

end

function LateUpdate(currentTime, deltaTime)

    TestX:setText("Test currentTime: " .. currentTime)
    root:addChildWindow(TestX)

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

-- ////////////////////////////////////////////////////////////////////////////////
luaTime = 0
playerIndex = 0

rankIndex = 0

function errorHandler1(err)
    mywindow = winMgr:getWindow("wndtest_debug_text0")
    mywindow:setText(err)
end

function errorHandler2(err)
    mywindow = winMgr:getWindow("wndtest_debug_text2")
    mywindow:setText(err)
end

-- Set start counting time when entrance the scene
function SetTimer(num)
    CounterText:setText(num)
end

--------------------------------------------------------

