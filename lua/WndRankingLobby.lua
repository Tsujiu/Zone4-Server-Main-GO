IsHost = false
MyLobbyIndex = 1;


function WndRankingLobby_WndRankingLobby()

    -----------------------------------------
    -- Script Entry Point
    -----------------------------------------
    local guiSystem = CEGUI.System:getSingleton()
    local winMgr = CEGUI.WindowManager:getSingleton()
    local root = winMgr:getWindow("DefaultWindow")
    local drawer = root:getDrawer()

    local GUITool = require("GUITools")
    local ImGUI = require("ImGuiDebug")

    root:activate()

    local MAX_PLAYER_TEAM = ReturnMaxPlayerTeam()
    local USER_INFO_X = 620
    local USER_INFO_Y = 702
    local MAX_WIDTH_SCREEN = ReturnMaxWidthScreen()
    local MAX_HEIGHT_SCREEN = ReturnMaxHeightScreen()
    local nReduceWidth = 0
    local nReduceHeight = 0
    local defaultHeight = 800
    local defaultWidth = 1024
 
    if MAX_WIDTH_SCREEN <= 1024 then
        nReduceWidth = 0
    else
        nReduceWidth = (defaultWidth - MAX_WIDTH_SCREEN) / 2
    end

    if MAX_HEIGHT_SCREEN <= 800 then
        nReduceHeight = 0
    else
        nReduceHeight = defaultHeight - MAX_HEIGHT_SCREEN
    end

    CounterText = winMgr:createWindow("TaharezLook/StaticText", "CounterText")

    local function getWindowSafe(name)
        if winMgr:isWindowPresent(name) then
            return winMgr:getWindow(name)
        else
            return nil
        end
    end

    -- Render Background image.
    function RenderBackgroundBlue()
    --     drawer:drawTexture("UIData/rank_top_bar_blue.png", nReduceWidth, 0, MAX_WIDTH_SCREEN, 56, 0, 65, WIDETYPE_5) -- top
    --     drawer:drawTexture("UIData/ranking_set.png", 152, nReduceHeight + 62, 165, 14, 65, 174, WIDETYPE_7) -- Street fight
    --     drawer:drawTexture("UIData/ranking_set.png", 0, nReduceHeight + 3, 136, 136, 735, 149, WIDETYPE_7) -- bottom
    end
    function RenderBackgroundRed()
        --drawer:drawTexture("UIData/rank_top_bar_red.png", nReduceWidth, 0, MAX_WIDTH_SCREEN, 56, 0, 0, WIDETYPE_5) -- top
        -- drawer:drawTexture("UIData/ranking_set.png", 152, nReduceHeight + 62, 165, 14, 65, 174, WIDETYPE_7) -- Street fight
        --drawer:drawTexture("UIData/ranking_set.png", 0, nReduceHeight + 3, 136, 136, 735, 149, WIDETYPE_7) -- bottom
    end

    function QuiescenceEventInit()
        winMgr:getWindow("QuiescenceEvent_AlphaWindow"):setVisible(true)

        g_CharaterName[0], g_CharaterName[1], g_CharaterName[2], g_CharaterName[3], g_CharaterName[4], g_CharaterName[5], g_CharaterName[6] =
            CharaterNameSetting()

        g_CharaterLevel[0], g_CharaterLevel[1], g_CharaterLevel[2], g_CharaterLevel[3], g_CharaterLevel[4], g_CharaterLevel[5], g_CharaterLevel[6] =
            CharaterLevelSetting()

        g_CharaterClass[0], g_CharaterClass[1], g_CharaterClass[2], g_CharaterClass[3], g_CharaterClass[4], g_CharaterClass[5], g_CharaterClass[6] =
            CharaterClassSetting()

        for i = 0, g_CharaterSlot do
            if g_CharaterName[i] ~= "" then
                winMgr:getWindow("QuiescenceEvent_CharaterName" .. i):setText("Name : " .. g_CharaterName[i])
                winMgr:getWindow("QuiescenceEvent_CharaterLevel" .. i):setText("Level : " .. g_CharaterLevel[i])
                winMgr:getWindow("QuiescenceEvent_CharaterClass" .. i):setText("Class : " .. g_CharaterClass[i])
            end
        end
    end

    ---------------------------------------------------------------
    -- Check if currently transforming
    ---------------------------------------------------------------
    function CurrentTransform(description)
        drawer:setTextColor(255, 255, 255, 255)
        drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
        local size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, description)
        common_DrawOutlineText1(drawer, description, 512 - size / 2, USER_INFO_Y - 60, 0, 0, 0, 255, 255, 200, 80, 255,
            WIDETYPE_6)
    end

    -- Parent Object for Top Panal 
    local BGMainRankLobbyWindow = winMgr:createWindow("TaharezLook/StaticImage", "BGMainRankLobbyWindow")
    BGMainRankLobbyWindow:setTexture("Enabled", "UIData/WndMainPanalBackground.png", 0, 0)            
    BGMainRankLobbyWindow:setSize(1024, 768)  
    BGMainRankLobbyWindow:setMousePassThroughEnabled(true) 
    local GetSizeImg = BGMainRankLobbyWindow:getSize()    
    GUITool.AnchorMiddle(BGMainRankLobbyWindow)
    BGMainRankLobbyWindow:setPosition(-(GetSizeImg.x:asAbsolute(1)/2), -(GetSizeImg.y:asAbsolute(1)/2))  
    BGMainRankLobbyWindow:setAlpha(50)

    -- Parent Object for Top Panal 
    local MainRankLobbyWindow = winMgr:createWindow("TaharezLook/StaticImage", "MainRankLobbyWindow")
    MainRankLobbyWindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
    MainRankLobbyWindow:setVisible(true)
    MainRankLobbyWindow:setAlwaysOnTop(false)
    -- MainRankLobbyWindow:setMousePassThroughEnabled(true)
    GUITool.AnchorMiddle(MainRankLobbyWindow)
    MainRankLobbyWindow:setPosition(-(1024/2),-(728/2))


    --RankSlotPanal
    local RankIconHole = winMgr:createWindow("TaharezLook/Button", "RankIconHole")    
    RankIconHole:setTexture("Normal", "UIData/ranking_set.png", 735, 149)         
    RankIconHole:setPosition(0, 0)
    RankIconHole:setSize(136, 136)
    RankIconHole:setAlwaysOnTop(true)
    RankIconHole:setZOrderingEnabled(false)    
    RankIconHole:setMousePassThroughEnabled(true)
    MainRankLobbyWindow:addChildWindow(RankIconHole)

   
    ---------------------------------------------------------------
    -- Start Game Button
    ---------------------------------------------------------------
    StartButton = winMgr:createWindow("TaharezLook/Button", "StartButton")
    StartButton:setTexture("Normal", "UIData/WndRankingTabbar.png", 17, 233)
    StartButton:setTexture("Hover", "UIData/WndRankingTabbar.png", 322, 233)
    StartButton:setTexture("Pushed", "UIData/WndRankingTabbar.png", 17, 233)
    StartButton:setTexture("Disabled", "UIData/WndRankingTabbar.png", 322, 233)
    StartButton:setPosition(10, USER_INFO_Y - 20)
    -- StartButton:setPosition(500, 500)
    StartButton:setSize(250, 75)
    StartButton:setVisible(false)
    StartButton:setZOrderingEnabled(true)
    StartButton:setAlwaysOnTop(true)
    StartButton:setframeWindow(true)
    StartButton:setClippedByParent(false)
    -- StartButton:setMousePassThroughEnabled(false) 
    -- StartButton:subscribeEvent("Clicked", "StartGame")
    StartButton:subscribeEvent("Clicked", function()  	    
        StartButton:setVisible(false)
        ReadyButton:setVisible(false)
        CancelButton:setVisible(true)
        PlayerStart(MyLobbyIndex)         

        -- LOG("StartButton clicked. Triggering countdown.")
        ToggleCountUp(1)   -- Toggle off countdown in lua   
        StartCountUp(1)

        SetTimer(125)         -- Updates text display to "2:05"
        Text_to_IMG(125)      -- Updates textures for "2:05"
    end) 

    -- StartButton:setPosition(-(1024/2), -(728/2))
    MainRankLobbyWindow:addChildWindow(StartButton)
    

    ReadyButton = winMgr:createWindow("TaharezLook/Button", "ReadyButton")
    ReadyButton:setTexture("Normal", "UIData/WndRankingTabbar.png", 322, 338)
    --ReadyButton:setTexture("Hover", "UIData/WndRankingTabbar.png", 322, 233)
    ReadyButton:setTexture("Pushed", "UIData/WndRankingTabbar.png", 627, 338)
    ReadyButton:setVisible(false)
    -- ReadyButton:setPosition(10, USER_INFO_Y - 20)
    ReadyButton:setSize(250, 75)
    ReadyButton:setAlwaysOnTop(true)
    ReadyButton:setZOrderingEnabled(true)
   
    ReadyButton:setClippedByParent(false)
    -- ReadyButton:subscribeEvent("Clicked", "StartGame")
    ReadyButton:subscribeEvent("Clicked", function()  	    
        StartButton:setVisible(false)
        ReadyButton:setVisible(false)
        CancelButton:setVisible(true)
        PlayerReady(MyLobbyIndex)        
    end) 
    MainRankLobbyWindow:addChildWindow(ReadyButton)

    CancelButton = winMgr:createWindow("TaharezLook/Button", "CancelButton")
    CancelButton:setTexture("Normal", "UIData/WndRankingTabbar.png", 627, 232)    
    CancelButton:setVisible(false)
    CancelButton:setClippedByParent(false)
    CancelButton:setPosition(10, USER_INFO_Y - 20)
    CancelButton:setSize(250, 75)
    -- CancelButton:setZOrderingEnabled(true)
    -- CancelButton:setAlwaysOnTop(true)
    -- CancelButton:setMousePassThroughEnabled(false)
    -- CancelButton:setAlwaysOnTop(true)

    CancelButton:subscribeEvent("Clicked", function()  	    
        StartButton:setVisible(false)
        ReadyButton:setVisible(false)
        CancelButton:setVisible(false)                
        if IsHost == "true" then
            local StartButton = winMgr:getWindow("StartButton")
            StartButton:setVisible(true)
        end
        if IsHost == "false" then            
      
            winMgr:getWindow("ReadyButton"):setVisible(true)
        end
        PlayerReady(MyLobbyIndex)  

        ToggleCountUp(0) -- Reset the countdown in Lua and C++
        StartCountUp(0) -- Reset the count-up in C++
        CounterText:setText("0:00") -- Reset the timer text in the Lua UI

        SetTimer(0)         -- Updates text display to "2:05"
        Text_to_IMG(0)      -- Updates textures for "2:05"
        
    end) 
    MainRankLobbyWindow:addChildWindow(CancelButton)

    

    -- Just testing
    -- LOG("===================== Dragon's _G.RankPersonalData =====================")
    -- LOG(_G.RankPersonalData)
    -- LOG(_G.PersonalData)
    -- LOG(_G.PersonalBoneType)
    -- LOG("===================== Dragon's _G.RankPersonalData =====================")

    function SetRankBadge(base_rank)

        IconRank = winMgr:createWindow("TaharezLook/StaticImage", "IconRankPicture")
        IconRank:setAlwaysOnTop(true)
        IconRank:setMousePassThroughEnabled(true)

        if base_rank == "Rookie" then
            IconRank:setTexture("Enabled", "UIData/Raking_Badge.png", 54, 36)
            IconRank:setPosition(31, 25)
            IconRank:setSize(220, 220)
            IconRank:setScaleHeight(125)
            IconRank:setScaleWidth(125)

        elseif base_rank == "Bronze" then
            IconRank:setTexture("Enabled", "UIData/Raking_Badge.png", 70, 246)
            IconRank:setScaleHeight(125)
            IconRank:setScaleWidth(125)
            IconRank:setPosition(40, 20)
            IconRank:setSize(220, 220)

        elseif base_rank == "Iron" then
            IconRank:setTexture("Enabled", "UIData/Raking_Badge.png", 70, 440)
            IconRank:setScaleHeight(125)
            IconRank:setScaleWidth(125)
            IconRank:setPosition(40, 20)
            IconRank:setSize(220, 220)

        elseif base_rank == "Silver" then
            IconRank:setTexture("Enabled", "UIData/Raking_Badge.png", 45, 650)
            IconRank:setScaleHeight(125)
            IconRank:setScaleWidth(125)
            IconRank:setPosition(26, 15)
            IconRank:setSize(300, 220)

        elseif base_rank == "Gold" then
            IconRank:setTexture("Enabled", "UIData/Raking_Badge.png", 45, 870)
            IconRank:setScaleHeight(125)
            IconRank:setScaleWidth(125)
            IconRank:setPosition(25, 13)
            IconRank:setSize(300, 220)

        elseif base_rank == "Platinum" then
            IconRank:setTexture("Enabled", "UIData/Raking_Badge.png", 45, 1075)
            IconRank:setScaleHeight(125)
            IconRank:setScaleWidth(125)
            IconRank:setPosition(27, 10)
            IconRank:setSize(300, 220)

        elseif base_rank == "Diamond" then
            IconRank:setTexture("Enabled", "UIData/Raking_Badge.png", 30, 1285)
            IconRank:setScaleHeight(125)
            IconRank:setScaleWidth(125)
            IconRank:setPosition(18, 5)
            IconRank:setSize(350, 220)

        elseif base_rank == "Master" then
            IconRank:setTexture("Enabled", "UIData/Raking_Badge.png", 45, 1520)
            IconRank:setScaleHeight(125)
            IconRank:setScaleWidth(125)
            IconRank:setPosition(25, 5)
            IconRank:setSize(350, 220)

        elseif base_rank == "GrandMaster" then
            IconRank:setTexture("Enabled", "UIData/Raking_Badge.png", 25, 1800)
            IconRank:setScaleHeight(100)
            IconRank:setScaleWidth(100)
            IconRank:setPosition(25, 30)
            IconRank:setSize(380, 220)

        elseif base_rank == "Close" then
            IconRank:setVisible(false)
        else
            print("Unknown rank: " .. IconRank)
        end
        IconRank:setMousePassThroughEnabled(true) 
        MainRankLobbyWindow:addChildWindow(IconRank)
    end

    function setRankBadgeLevel(Level)
        -- Create the DebugRankBadge window
        local RankLevel = winMgr:createWindow("TaharezLook/StaticText", "RankLevel_")
        RankLevel:setVisible(true)
        RankLevel:setTextColor(255, 255, 255, 255)
        if Level == "I" then
            RankLevel:setText("I")
            RankLevel:setFont(g_STRING_FONT_GULIMCHE, 30)
            RankLevel:setSize(80, 40)
            RankLevel:setPosition(61, 40)
            RankLevel:setAlwaysOnTop(true)
        elseif Level == "II" then
            RankLevel:setText("II")
            RankLevel:setFont(g_STRING_FONT_GULIMCHE, 30)
            RankLevel:setSize(80, 40)
            RankLevel:setPosition(55, 40)
            RankLevel:setAlwaysOnTop(true)
        elseif Level == "III" then
            RankLevel:setText("III")
            RankLevel:setFont(g_STRING_FONT_GULIMCHE, 30)
            RankLevel:setSize(80, 40)
            RankLevel:setPosition(50, 40)
            RankLevel:setAlwaysOnTop(true)
        elseif Level == "IV" then
            RankLevel:setText("IV")
            RankLevel:setFont(g_STRING_FONT_GULIMCHE, 30)
            RankLevel:setSize(80, 40)
            RankLevel:setPosition(53, 40)
            RankLevel:setAlwaysOnTop(true)
        elseif Level == "V" then
            RankLevel:setText("V")
            RankLevel:setFont(g_STRING_FONT_GULIMCHE, 30)
            RankLevel:setSize(80, 40)
            RankLevel:setPosition(58, 44)
            RankLevel:setAlwaysOnTop(true)
        elseif Level == "Close" then
            RankLevel:setVisible(false)
        end

        RankLevel:setMousePassThroughEnabled(true) 
        MainRankLobbyWindow:addChildWindow(RankLevel)
    end

    function GetRankIcon(RankInfo)

        -- Using for set AllowingClaim in RankSeasonal
        SetAllowingClaim(RankInfo)

        -- Find the second element (rank name) in the comma-separated string
        local rank_name_with_level = RankInfo:match("^[^,]+,([^,]+),")
        if not rank_name_with_level then
            return nil, nil -- Return nil if no match is found
        end

        -- Split the rank name into name and level
         local rank_name, rank_level = rank_name_with_level:match("^(.-)_(.-)$")
         if not rank_name or not rank_level or rank_name == "" or rank_level == "" then
            rank_name = rank_name_with_level
            rank_level = nil -- Return nil if no valid rank name or level is found
        end

        -- LOG("===================== Dragon's Split Function in RankLobby =====================")
        -- LOG(rank_name)
        -- LOG(rank_level)
        -- LOG("===================== Dragon's Split Function =====================")

        -- Set the rank badge (assuming this is defined elsewhere)
        SetRankBadge(rank_name)
        if rank_level then
            setRankBadgeLevel(rank_level)
        end
    end

    GetRankIcon(_G.RankPersonalData)

    ---------------------------------------------------------------
    -- Back to Village
    ---------------------------------------------------------------
    mywindow = winMgr:createWindow("TaharezLook/Button", "To_Village_btn")
    mywindow:setTexture("Normal", "UIData/ranking_set.png", 436, 289)
    mywindow:setTexture("Hover", "UIData/ranking_set.png", 436, 328)
    mywindow:setTexture("Pushed", "UIData/ranking_set.png", 436, 367)
    mywindow:setTexture("PushedOff", "UIData/ranking_set.png", 436, 289)
    mywindow:setPosition(900, 700)
    mywindow:setSize(38, 38)
    mywindow:setAlwaysOnTop(true)
    mywindow:setZOrderingEnabled(true)
    mywindow:subscribeEvent("Clicked", "Back_to_menu")
    mywindow:setClippedByParent(false)
    
    MainRankLobbyWindow:addChildWindow(mywindow)

    function Back_to_menu()
        ChangeSceneToVillage()
    end

    ---------------------------------------------------------------
    -- Invite Friend Button
    ---------------------------------------------------------------
    mywindow = winMgr:createWindow("TaharezLook/Button", "invite_friend_btn")
    mywindow:setTexture("Normal", "UIData/ranking_set.png", 436, 289)
    mywindow:setTexture("Hover", "UIData/ranking_set.png", 436, 328)
    mywindow:setTexture("Pushed", "UIData/ranking_set.png", 436, 367)
    mywindow:setTexture("PushedOff", "UIData/ranking_set.png", 436, 289)
    mywindow:setPosition(940, 700)
    mywindow:setSize(38, 38)
    mywindow:setZOrderingEnabled(true)
    mywindow:subscribeEvent("Clicked", "OpenMessenger_Popup")
    mywindow:setClippedByParent(false)
    MainRankLobbyWindow:addChildWindow(mywindow)

    
    --Dragon's Close friend panal    
    CloseFriendPanal = winMgr:createWindow("TaharezLook/Button", "CloseFriendPanal")
    CloseFriendPanal:setTexture("Normal", "UIData/battleroom001.png", 770, 655)
    CloseFriendPanal:setTexture("Hover", "UIData/battleroom001.png", 770, 671)
    CloseFriendPanal:setTexture("Pushed", "UIData/battleroom001.png", 770, 687)    
    CloseFriendPanal:setPosition(305, 7)
    CloseFriendPanal:setSize(16, 16)
    CloseFriendPanal:setAlwaysOnTop(true)
    CloseFriendPanal:setZOrderingEnabled(true)
    CloseFriendPanal:setClippedByParent(false)
    CloseFriendPanal:subscribeEvent("Clicked", "OpenMessenger_Popup")
    winMgr:getWindow("rankingLobbyInviteFrame"):addChildWindow(CloseFriendPanal)

    -- Define a global variable to track the visibility state
    if not _G.areFriendWindowsVisible then
        _G.areFriendWindowsVisible = false
    end

    function OpenMessenger_Popup()

        InviteUserListMode()

        -- Toggle the visibility state
        _G.areFriendWindowsVisible = not _G.areFriendWindowsVisible

        -- Access the global table and set visibility based on the state
        for index, window in pairs(FriendNameWindows) do
            window:setVisible(_G.areFriendWindowsVisible)
        end
    end

    ---------------------------------------------------------------
    -- Setting Button
    ---------------------------------------------------------------
    local IsOpenOption = false
    mywindow = winMgr:createWindow("TaharezLook/Button", "setting_btn")
    mywindow:setTexture("Normal", "UIData/ranking_set.png", 387, 289)
    mywindow:setTexture("Hover", "UIData/ranking_set.png", 387, 328)
    mywindow:setTexture("Pushed", "UIData/ranking_set.png", 387, 367)
    mywindow:setTexture("PushedOff", "UIData/ranking_set.png", 387, 289)
    mywindow:setPosition(978, 700)
    mywindow:setSize(38, 38)
    mywindow:setZOrderingEnabled(true)
    mywindow:subscribeEvent("Clicked", "OpenSetting_Popup_Overall")
    mywindow:setClippedByParent(false)
    MainRankLobbyWindow:addChildWindow(mywindow)
    function OpenSetting_Popup_Overall()
        -- CallPopupOption()
        -- ToggleRankingOverallPanal()                
        if IsOpenOption == false then
            IsOpenOption = true
            GetTSCharacter() 
            MainPanal()                       
        else
            CloseMainPanal()
            IsOpenOption = false
        end
        -- ToggleRankingOverallPanal() 
        -- ToggleRankingHistory(1)
    end

    function SetChatInitRankingLobby()
        Chatting_SetChatWideType(6)
        Chatting_SetChatPosition(10, USER_INFO_Y - 20)
        Chatting_SetChatEditVisible(true)
        Chatting_SetChatEditEvent(2)
        winMgr:getWindow("doChatting"):deactivate()
        Chatting_SetChatTabDefault()
        winMgr:getWindow("ChatBackground"):setAlwaysOnTop(true)
    end

    function InviteUserListMode()
        if winMgr:getWindow("rankingLobbyInviteFrame"):isVisible() == true then
            winMgr:getWindow("rankingLobbyInviteFrame"):setVisible(false)
            winMgr:getWindow("rankingLobbyInvite"):setVisible(false)
        else
            winMgr:getWindow("rankingLobbyInviteFrame"):setVisible(true)
            winMgr:getWindow("rankingLobbyInvite"):setVisible(true)
            GetInviteUserList()
        end
    end

    function OnRootKeyUp(args)
        local keyEvent = CEGUI.toKeyEventArgs(args);
        -- if b_pushCtrl == 1 then
        DebugStr('keyEvent.scancode:' .. keyEvent.scancode)
        if CheckBlockInput() then
            return
        end
    
        if keyEvent.scancode == 77 then -- Press M Messenger
            CallPopupMessenger()
            return
        elseif keyEvent.scancode == 67 then -- Press C Character
            CallPopupMyInfo()
            return
        elseif keyEvent.scancode == 80 then -- Press P Profile
            ShowProfileUi()
            return
        elseif keyEvent.scancode == 73 then -- Press I Inventory
            if winMgr:getWindow("RentalSkill_Main"):isVisible() == true then
                return
            end
    
            if IsKoreanLanguage() == false then
                if winMgr:getWindow("Costume_Change_MainWindow"):isVisible() == false and
                    winMgr:getWindow("Costume_Visual_Main"):isVisible() == false and
                    winMgr:getWindow("CostumeItemList"):isVisible() == false and
                    winMgr:getWindow("MailWriteImage"):isVisible() == false then
                    DebugStr("占싸븝옙占쏙옙占쏙옙")
                    CallPopupInven()
                end
            else
                CallPopupInven()
            end
    
            return
        end
    end
    root:subscribeEvent("KeyUp", "RootKeyUp")
    
    -- For Loop create Ready Status Image
    local MAX_PLAYER = 4
    GapX_interval = 200
    
    for index = 1, MAX_PLAYER do

        local charScreenPosX, charScreenPosY = GetCharacterScreenPos(index - 1)
        local mainX,mainY = GUITool.GetAbsoluteWindowPosition(MainRankLobbyWindow)

        local ReadyStatusIMG = winMgr:createWindow("TaharezLook/StaticImage", "ReadyStatusIMG" .. index)
        ReadyStatusIMG:setTexture("Enabled", "UIData/battleroom001.tga", 137, 866)
        ReadyStatusIMG:setTexture("Disabled", "UIData/battleroom001.tga", 137, 897)
        ReadyStatusIMG:setSize(67, 29)
        ReadyStatusIMG:setPosition(charScreenPosX - 20, mainY + 100)
        ReadyStatusIMG:setVisible(false)
        ReadyStatusIMG:setEnabled(false)
        ReadyStatusIMG:setAlwaysOnTop(false)

        root:addChildWindow(ReadyStatusIMG)
        -- MainRankLobbyWindow:addChildWindow(ReadyStatusIMG)

        local MasterIMG = winMgr:createWindow("TaharezLook/StaticImage", "MasterIMG" .. index)
        MasterIMG:setTexture("Enabled", "UIData/battleroom001.tga", 136, 837)
        MasterIMG:setTexture("Disabled", "UIData/invisible.tga", 700, 200)

        -- local mainSize = MainRankLobbyWindow:getHeight()

        -- LOG("mainPos.y.offset = " .. mainPos.y:asAbsolute(1.0))
        
        MasterIMG:setSize(75, 26)
        MasterIMG:setPosition(charScreenPosX - 20, mainY + 100)
        MasterIMG:setVisible(false)
        MasterIMG:setEnabled(false)
        MasterIMG:setAlwaysOnTop(false)
        MasterIMG:setMousePassThroughEnabled(true)
        root:addChildWindow(MasterIMG)
    
        local ProfileLobbyButton = winMgr:createWindow("TaharezLook/Button", "ProfileLobbyButton" .. index)
        ProfileLobbyButton:setTexture("Normal", "UIData/myinfo(Update).img", 738, 405)
        ProfileLobbyButton:setTexture("Hover", "UIData/myinfo(Update).img", 738, 426)
        ProfileLobbyButton:setTexture("Pushed", "UIData/myinfo(Update).img", 738, 449)
        ProfileLobbyButton:setTexture("Disabled", "UIData/myinfo(Update).img", 738, 468)
        ProfileLobbyButton:setSize(114, 19)
        -- ProfileLobbyButton:setPosition((GapX_interval * index) - 5, ((g_MAIN_WIN_SIZEY - 29) / 2) + 265)
        
        ProfileLobbyButton:setPosition(charScreenPosX - (114 / 2), charScreenPosY + 20)

        ProfileLobbyButton:setVisible(false)
        ProfileLobbyButton:setEnabled(false)
        ProfileLobbyButton:setAlwaysOnTop(false)
        ProfileLobbyButton:setClippedByParent(false)
        ProfileLobbyButton:subscribeEvent("Clicked", function()
    
            -- LOG("Test ProfileLobbyButton: " .. index)
            
            -- CloseMainPanal()
            -- IsOpenOption = false	    
            
            GetTSCharacter(index)       
            MainPanal()
        end) 
        root:addChildWindow(ProfileLobbyButton)
    end
    
    function ToggleProfileLobbyButton(PlayerIndex)
        local ProfileLobbyButton = winMgr:getWindow("ProfileLobbyButton" .. PlayerIndex)
    
        if(ProfileLobbyButton:isVisible() == false) then
            ProfileLobbyButton:setVisible(true)
            ProfileLobbyButton:setEnabled(true)
        else
            ProfileLobbyButton:setVisible(false)
            ProfileLobbyButton:setEnabled(false)
        end
    
    end
    
    function SetLobbyPlayerName(UserName,PlayerIndex)
        local CheckLobbyPlayerName = winMgr:createWindow("TaharezLook/StaticText", "CheckLobbyPlayerName" .. PlayerIndex + 1)        
        local charScreenPosX, charScreenPosY = GetCharacterScreenPos(PlayerIndex)

        local mainX,mainY = GUITool.GetAbsoluteWindowPosition(MainRankLobbyWindow)
        
        ImGUI.AddWindow(CheckLobbyPlayerName)
        
        CheckLobbyPlayerName:setPosition(charScreenPosX, mainY + 125)
        CheckLobbyPlayerName:setSize(50, 50)
        CheckLobbyPlayerName:setText(UserName)
        CheckLobbyPlayerName:setAlwaysOnTop(false)
        CheckLobbyPlayerName:setTextColor(255, 255, 255, 255)
        CheckLobbyPlayerName:setFont("tahoma", 15)
        CheckLobbyPlayerName:setZOrderingEnabled(false) -- Prevent Clicked to shift to top
        root:addChildWindow(CheckLobbyPlayerName)
    end
    
    function SetLobbyPlayerLevel(Level,PlayerIndex)
        local SetLobbyPlayerLevel = winMgr:createWindow("TaharezLook/StaticText", "SetLobbyPlayerLevel" .. PlayerIndex + 1)
        -- SetLobbyPlayerLevel:setPosition((GapX_interval * PlayerIndex) , ((g_MAIN_WIN_SIZEY - 50) / 2) - 170)

        local charScreenPosX, charScreenPosY = GetCharacterScreenPos(PlayerIndex)
        local mainX,mainY = GUITool.GetAbsoluteWindowPosition(MainRankLobbyWindow)


        SetLobbyPlayerLevel:setPosition(charScreenPosX - 245, mainY + 125)
        SetLobbyPlayerLevel:setSize(50, 50)
        SetLobbyPlayerLevel:setText("[" .. Level .. "]")
        SetLobbyPlayerLevel:setAlwaysOnTop(false)
        SetLobbyPlayerLevel:setTextColor(255, 255, 255, 255)
        SetLobbyPlayerLevel:setFont("tahoma", 15)
        SetLobbyPlayerLevel:setZOrderingEnabled(false) -- Prevent Clicked to shift to top
        -- MainRankLobbyWindow:addChildWindow(SetLobbyPlayerLevel)
        root:addChildWindow(SetLobbyPlayerLevel)
        
        ImGUI.AddWindow(SetLobbyPlayerLevel)


    end
    
    function SetLobbyRankBadge(Path,X,Y,PlayerIndex)

        local LobbyRankBadge = winMgr:createWindow("TaharezLook/StaticImage", "LobbyRankBadge" .. (PlayerIndex + 1))

        local charScreenPosX, charScreenPosY = GetCharacterScreenPos(PlayerIndex)
        local mainX,mainY = GUITool.GetAbsoluteWindowPosition(MainRankLobbyWindow)

        ImGUI.AddWindow(LobbyRankBadge)
        
        LobbyRankBadge:setTexture("Enabled", "UIData/Raking_Badge.png", X, Y)
        LobbyRankBadge:setTexture("Disabled", "UIData/invisible.tga", 700, 200)

        LobbyRankBadge:setSize(300, 220)
        LobbyRankBadge:setScaleHeight(75)
        LobbyRankBadge:setScaleWidth(75)
        LobbyRankBadge:setPosition(charScreenPosX - 90, mainY + 125)
        -- LobbyRankBadge:setPosition((GapX_interval * (PlayerIndex + 1))-50, ((g_MAIN_WIN_SIZEY - 29) / 2) -185)
        LobbyRankBadge:setVisible(true) 
        LobbyRankBadge:setAlwaysOnTop(false)
        root:addChildWindow(LobbyRankBadge)
    end

    -- Toggle Visible Ready Image
    function ToggleLobbyMasterIconImg(PlayerIndex,state)                       
        if state == 1 then
            winMgr:getWindow("MasterIMG" .. PlayerIndex):setVisible(true)
            winMgr:getWindow("MasterIMG" .. PlayerIndex):setEnabled(true)
            SetInvisibleReadyStatus(PlayerIndex)
        end
        if state == 0 then
            winMgr:getWindow("MasterIMG" .. PlayerIndex):setVisible(false)
            winMgr:getWindow("MasterIMG" .. PlayerIndex):setEnabled(false)
            SetVisibleReadyStatus(PlayerIndex)
        end             
    end 
    
    function DestroyPlayerName(PlayerIndex)
        winMgr:destroyWindow("CheckLobbyPlayerName" .. PlayerIndex)       
    end
    
    function DestroyPlayerLevel(PlayerIndex)
        winMgr:destroyWindow("SetLobbyPlayerLevel" .. PlayerIndex)       
    end
    
    function DestroyLobbyRankBadge(PlayerIndex)
        winMgr:destroyWindow("LobbyRankBadge" .. PlayerIndex)       
    end       
    
    -- Set Visible Ready Image when Player Join the room
    function SetVisibleReadyStatus(PlayerIndex)
        local ReadyStatusIMG = winMgr:getWindow("ReadyStatusIMG" .. PlayerIndex)
        ReadyStatusIMG:setVisible(true)
        ReadyStatusIMG:setEnabled(false)
        
    end
    
    -- Set Visible Ready Image when Player Join the room
    function SetInvisibleReadyStatus(PlayerIndex)
        local ReadyStatusIMG = winMgr:getWindow("ReadyStatusIMG" .. PlayerIndex)
        ReadyStatusIMG:setVisible(false)
        ReadyStatusIMG:setEnabled(false)
    end
    
    -- Toggle Visible Ready Image
    function ToggleReadyStatusIMG(PlayerIndex,state)               
        if state == 1 then
            winMgr:getWindow("ReadyStatusIMG" .. PlayerIndex):setEnabled(true)         
        end
        if state == 0 then
            winMgr:getWindow("ReadyStatusIMG" .. PlayerIndex):setEnabled(false)
        end         
    end

    function ToggleStartButton(state)
        if state == 1 then
            winMgr:getWindow("StartButton"):setEnabled(true)         
        end
        if state == 0 then
            winMgr:getWindow("StartButton"):setEnabled(false) 
        end    
    end
    
     -- Using as Host Checking system (True = Host, False = Member)
    function CheckHostStatus(HostStatus)      
        
        if tostring(HostStatus) == "true"  then
                    local StartButton = winMgr:getWindow("StartButton")
            StartButton:setVisible(true)
            IsHost = "true"        

            ToggleLobbyMasterIconImg(MyLobbyIndex,1) -- Set MasterStatus Icon visible
            ToggleReadyStatusIMG(MyLobbyIndex,0) -- Set Normal ReadyStatus to off
    
            -- -- For Destroy ReadyStatus and Replace it with Master Icon
            -- local ReadyStatusIMG = winMgr:getWindow("ReadyStatusIMG" .. MyLobbyIndex)
            
        else if tostring(HostStatus) == "false" then
            local ReadyButton = winMgr:getWindow("ReadyButton")
            ReadyButton:setVisible(true)
            IsHost = "false"
            ToggleLobbyMasterIconImg(MyLobbyIndex,0) -- Set MasterStatus Icon Disabled
        end
            
        end
        
    end
    
    function SetMyLobbyIndex(PlayerIndex)
        MyLobbyIndex = PlayerIndex
    end
    
    -- Dragon 's Counter Text in Lua part 
    -- Counting Text RankingLobby
    -- CounterText:setTextColor(255, 255, 255, 255)
    -- CounterText:setFont("tahoma", 30)		
    -- CounterText:setText("0:00")
    -- CounterText:setPosition(500,-240)	
    -- CounterText:setAlwaysOnTop(true)
    -- root:addChildWindow(CounterText)	

    -- Img time to text

    -- Img Position Note 
    -- Second2_IMG:setTexture("Enabled", "UIData/MatchMaking_Number.png", 18, 946)  -- 0
    -- Second2_IMG:setTexture("Enabled", "UIData/MatchMaking_Number.png", 104, 946) -- 1
    -- Second2_IMG:setTexture("Enabled", "UIData/MatchMaking_Number.png", 183, 946) -- 2
    -- Second2_IMG:setTexture("Enabled", "UIData/MatchMaking_Number.png", 266, 944) -- 3
    -- Second2_IMG:setTexture("Enabled", "UIData/MatchMaking_Number.png", 349, 945) -- 4
    -- Second2_IMG:setTexture("Enabled", "UIData/MatchMaking_Number.png", 432, 946) -- 5
    -- Second2_IMG:setTexture("Enabled", "UIData/MatchMaking_Number.png", 515, 945) -- 6
    -- Second2_IMG:setTexture("Enabled", "UIData/MatchMaking_Number.png", 599, 946) -- 7
    -- Second2_IMG:setTexture("Enabled", "UIData/MatchMaking_Number.png", 679, 946) -- 8
    -- Second2_IMG:setTexture("Enabled", "UIData/MatchMaking_Number.png", 764, 945) -- 9

    TimePanal = winMgr:createWindow("TaharezLook/StaticImage", "TimePanal")
    TimePanal:setTexture("Enabled", "UIData/invisible.tga", 700, 200)    
    TimePanal:setSize(20, 20)   
    TimePanal:setPosition(20, -30)
    TimePanal:setVisible(false)
    MainRankLobbyWindow:addChildWindow(TimePanal)  

    Min1_IMG = winMgr:createWindow("TaharezLook/StaticImage", "Min1_IMG")
    Min1_IMG:setTexture("Enabled", "UIData/MatchMaking_Number.png", 18, 946)
    Min1_IMG:setTexture("Disabled", "UIData/invisible.tga", 700, 200)
    Min1_IMG:setSize(44, 49)   
    Min1_IMG:setPosition(420, 120)
    Min1_IMG:setVisible(true) 
    Min1_IMG:setEnabled(true) 
    Min1_IMG:setAlwaysOnTop(true)
    Min1_IMG:setScaleHeight(200)
    Min1_IMG:setScaleWidth(200)
    TimePanal:addChildWindow(Min1_IMG)  

    Min2_IMG = winMgr:createWindow("TaharezLook/StaticImage", "Min2_IMG")
    Min2_IMG:setTexture("Enabled", "UIData/MatchMaking_Number.png", 18, 946)
    Min2_IMG:setTexture("Disabled", "UIData/invisible.tga", 700, 200)
    Min2_IMG:setSize(44, 49)   
    Min2_IMG:setPosition(460, 120)
    Min2_IMG:setVisible(true) 
    Min2_IMG:setEnabled(true) 
    Min2_IMG:setAlwaysOnTop(true)
    Min2_IMG:setScaleHeight(200)
    Min2_IMG:setScaleWidth(200)
    TimePanal:addChildWindow(Min2_IMG)  

    SpliterImg = winMgr:createWindow("TaharezLook/StaticImage", "SpliterImg")
    SpliterImg:setTexture("Enabled", "UIData/MatchMaking_Number.png", 848, 946)
    SpliterImg:setTexture("Disabled", "UIData/invisible.tga", 700, 200)
    SpliterImg:setSize(18, 48)   
    SpliterImg:setPosition(500, 120)
    SpliterImg:setVisible(true) 
    SpliterImg:setEnabled(true) 
    SpliterImg:setAlwaysOnTop(true)
    SpliterImg:setScaleHeight(200)
    SpliterImg:setScaleWidth(200)
    TimePanal:addChildWindow(SpliterImg)

    Second1_IMG = winMgr:createWindow("TaharezLook/StaticImage", "Second1_IMG")
    Second1_IMG:setTexture("Enabled", "UIData/MatchMaking_Number.png", 18, 946)
    Second1_IMG:setTexture("Disabled", "UIData/invisible.tga", 700, 200)
    Second1_IMG:setSize(44, 49)   
    Second1_IMG:setPosition(520, 120)
    Second1_IMG:setVisible(true) 
    Second1_IMG:setEnabled(true) 
    Second1_IMG:setAlwaysOnTop(true)
    Second1_IMG:setScaleHeight(200)
    Second1_IMG:setScaleWidth(200)
    TimePanal:addChildWindow(Second1_IMG)  
    
    Second2_IMG = winMgr:createWindow("TaharezLook/StaticImage", "Second2_IMG")
    Second2_IMG:setTexture("Enabled", "UIData/MatchMaking_Number.png", 18, 946)
    Second2_IMG:setTexture("Disabled", "UIData/invisible.tga", 700, 200)
    Second2_IMG:setSize(44, 49)   
    Second2_IMG:setPosition(560, 120)
    Second2_IMG:setVisible(true) 
    Second2_IMG:setEnabled(true) 
    Second2_IMG:setAlwaysOnTop(true)
    Second2_IMG:setScaleHeight(200)
    Second2_IMG:setScaleWidth(200)
    TimePanal:addChildWindow(Second2_IMG)    

    
    -- Table mapping digits to xOffsets
    local digitToXOffset = {
        [0] = 18,
        [1] = 104,
        [2] = 183,
        [3] = 266,
        [4] = 349,
        [5] = 432,
        [6] = 515,
        [7] = 599,
        [8] = 681,
        [9] = 764
    }

    -- Function to get the xOffset for a digit
    function getTextureCoords(digit)
        local xOffset = digitToXOffset[digit]
        local yOffset = 946 -- Assuming yOffset is always 946 for all digits
        return xOffset, yOffset
    end
        
    -- Function to update the images based on the given time
    function Text_to_IMG(timeInSeconds)

        local minutes = math.floor(timeInSeconds / 60)
        local seconds = timeInSeconds % 60

        -- Extract digits for minutes and seconds
        local minDigit1 = math.floor(minutes / 10) -- First digit of minutes
        local minDigit2 = minutes % 10            -- Second digit of minutes
        local secDigit1 = math.floor(seconds / 10) -- First digit of seconds
        local secDigit2 = seconds % 10            -- Second digit of seconds

        -- Update the textures for each digit
        local x, y

        -- First minute digit
        x, y = getTextureCoords(minDigit1)
        Min1_IMG:setTexture("Enabled", "UIData/MatchMaking_Number.png", x, y)

        -- Second minute digit
        x, y = getTextureCoords(minDigit2)
        Min2_IMG:setTexture("Enabled", "UIData/MatchMaking_Number.png", x, y)

        -- First second digit
        x, y = getTextureCoords(secDigit1)
        Second1_IMG:setTexture("Enabled", "UIData/MatchMaking_Number.png", x, y)

        -- Second second digit
        x, y = getTextureCoords(secDigit2)
        Second2_IMG:setTexture("Enabled", "UIData/MatchMaking_Number.png", x, y)
    end    

    -- Testing Img to text area
    -- Example usage

    local IsCountUp = false -- Tracks timer state
    -- Timer Update Logic
    function Update(currentTime, deltaTime)
        -- if IsCountingUp then
        --     -- Calculate elapsed time
        --     local elapsedTime = os.time() - TimerStartTime
        --     local minutes = math.floor(elapsedTime / 60)
        --     local seconds = elapsedTime % 60
        --     CounterText:setText(string.format("%d:%02d", minutes, seconds)) -- Update timer
        -- end
    end   

    -- Function to toggle the timer
    function ToggleCountUp(Signal)
        if Signal == 1 then
            -- TimerStartTime = os.time() -- Record the starting time
            IsCountingUp = true
            TimePanal:setVisible(true)

        else
            IsCountingUp = false
            CounterText:setText("0:00") -- Reset timer text to 0:00
            TimePanal:setVisible(false)
        end
    end
    
    -- Set start counting time when entrance the scene
    function SetTimer(num)
        local minutes = math.floor(num / 60)
        local seconds = num % 60
        CounterText:setText(string.format("%d:%02d", minutes, seconds)) -- Display as "min:sec"
        Text_to_IMG(num)
    end

    --  New Top Panal       

    local BGTopPanal = winMgr:createWindow("TaharezLook/Button", "BGTopPanal")
    BGTopPanal:setTexture("Normal", "UIData/NewPanalRankLobby.png", 0, 235)         
    BGTopPanal:setPosition(0, 0)    
    BGTopPanal:setSize(1024, 70)
    BGTopPanal:setAlwaysOnTop(false)
    BGTopPanal:setZOrderingEnabled(false)    
    BGTopPanal:setMousePassThroughEnabled(true) 
    MainRankLobbyWindow:addChildWindow(BGTopPanal)

  
          

    
    local SeasonalButton =winMgr:createWindow("TaharezLook/Button", "SeasonalButton")
    SeasonalButton:setTexture("Normal", "UIData/NewPanalRankLobby.png", 26, 320)
    -- SeasonalButton:setTexture("Hover", "UIData/NewPanalRankLobby.png", 26, 123)   
    SeasonalButton:setPosition(182, -3)
    SeasonalButton:setSize(180, 70)
    SeasonalButton:setAlwaysOnTop(true)
    SeasonalButton:setZOrderingEnabled(true)
    SeasonalButton:setClippedByParent(false)
    -- SeasonalButton:subscribeEvent("Clicked", "StartGame")
    SeasonalButton:subscribeEvent("Clicked", "OpenSetting_Popup")    
    function OpenSetting_Popup()                  
        if IsOpenOption == false then
            IsOpenOption = true
            -- MainPanal()
            -- GetTSCharacter()   
            MainSeasonalPanal()
            SeasonalButton:setTexture("Normal", "UIData/NewPanalRankLobby.png", 26, 123) 
        else
            -- CloseMainPanal()
            CloseMainSeasonalPanal()
            IsOpenOption = false
            SeasonalButton:setTexture("Normal", "UIData/NewPanalRankLobby.png", 26, 320)
        end
      
    end
    MainRankLobbyWindow:addChildWindow(SeasonalButton) 

    local IsCareerOpen = false

    local CareerButton =winMgr:createWindow("TaharezLook/Button", "CareerButton")
    CareerButton:setTexture("Normal", "UIData/NewPanalRankLobby.png", 386, 320)
    -- CareerButton:setTexture("Hover", "UIData/NewPanalRankLobby.png", 386, 123)       
    CareerButton:setPosition(364, -3)
    CareerButton:setSize(180, 70)
    CareerButton:setAlwaysOnTop(true)
    CareerButton:setZOrderingEnabled(true)
    CareerButton:setClippedByParent(false)
    CareerButton:subscribeEvent("Clicked", "OpenCharacter_Popup")

    function OpenCharacter_Popup()       
        CallPopupMyInfo()
        if IsCareerOpen == false then
            IsCareerOpen = true               
            
            CareerButton:setTexture("Normal", "UIData/NewPanalRankLobby.png", 386, 123) 
        else         
            IsCareerOpen = false     
            CareerButton:setTexture("Normal", "UIData/NewPanalRankLobby.png", 386, 320)
        end
    end
    MainRankLobbyWindow:addChildWindow(CareerButton)


    local IsInventorOpen = false

    local InventoryButton =winMgr:createWindow("TaharezLook/Button", "InventoryButton")
    InventoryButton:setTexture("Normal", "UIData/NewPanalRankLobby.png", 206, 320)
    -- InventoryButton:setTexture("Hover", "UIData/NewPanalRankLobby.png", 206, 123)       
    InventoryButton:setPosition(544, -3)
    InventoryButton:setSize(180, 70)
    InventoryButton:setAlwaysOnTop(true)
    InventoryButton:setZOrderingEnabled(true)   
    InventoryButton:setClippedByParent(false)
    InventoryButton:subscribeEvent("Clicked", "OpenInventory_Popup")       

    function OpenInventory_Popup()       
        CallPopupInven()     
        if IsInventorOpen == false then
            IsInventorOpen = true           
                   
            InventoryButton:setTexture("Normal", "UIData/NewPanalRankLobby.png", 206, 123) 
        else         
            IsInventorOpen = false     
            InventoryButton:setTexture("Normal", "UIData/NewPanalRankLobby.png", 206, 320)
        end
    end

    MainRankLobbyWindow:addChildWindow(InventoryButton)

    local ItemShopButton =winMgr:createWindow("TaharezLook/Button", "ItemShopButton")
    ItemShopButton:setTexture("Normal", "UIData/NewPanalRankLobby.png", 565, 320)
     -- ItemShopButton:setTexture("Hover", "UIData/NewPanalRankLobby.png", 565, 123)       
    ItemShopButton:setPosition(734, -3)
    ItemShopButton:setSize(180, 70)
    ItemShopButton:setAlwaysOnTop(true)
    ItemShopButton:setZOrderingEnabled(true)
    ItemShopButton:setClippedByParent(false)
    ItemShopButton:subscribeEvent("Clicked", "ItemShop_Page")
    function ItemShop_Page()        
        ChangeSceneToShop()
    end
    MainRankLobbyWindow:addChildWindow(ItemShopButton)  


    
end



