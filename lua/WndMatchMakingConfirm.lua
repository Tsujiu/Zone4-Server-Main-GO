-- --------------------------------------------------------------------

-- -- Script Entry Point

-- --------------------------------------------------------------------
-- local guiSystem = CEGUI.System:getSingleton()
-- local winMgr	= CEGUI.WindowManager:getSingleton()
-- local root	    = winMgr:getWindow("DefaultWindow")

-- guiSystem:setGUISheet(root)
-- root:activate();

-- --------------------------------------------------------------------
-- -- Sound When Click Confirm
-- --------------------------------------------------------------------
-- function OnConfirmButtonMouseEnterSound(args)
-- 	PlayWave('sound/Quickmenu01.wav')
-- end

-- function OnConfirmButtonMouseBtnUpSound(args)
-- 	PlayWave('sound/Top_popmenu.wav')
-- end
 
-- --------------------------------------------------------------------
-- -- Sound When Player Ready
-- --------------------------------------------------------------------
-- function OnPlayerReadySound(args)
-- 	PlayWave('sound/Quickmenu01.wav')
-- end

-- --------------------------------------------------------------------

-- -- Character Information

-- --------------------------------------------------------------------

-- local g_spacingX = 143
-- for i=0, 7 do
		
-- 	-- User Info Background
-- 	userbackwindow = winMgr:createWindow("TaharezLook/StaticImage", i.."sj_wndMatchMakingConfirm_userInfoBack")
-- 	userbackwindow:setTexture("Enabled", "UIData/Arcade_lobby.tga", 0, 432)
-- 	userbackwindow:setTexture("Disabled", "UIData/Arcade_lobby.tga", 0, 432)
-- 	userbackwindow:setProperty("FrameEnabled", "False")
-- 	userbackwindow:setProperty("BackgroundEnabled", "False")
-- 	-- userbackwindow:setPosition(10+(i*g_spacingX), 385) -- 432
--   if (i < 4) then
--     userbackwindow:setPosition(220+(i*g_spacingX), 200)
--   else
--     userbackwindow:setPosition(220+((i-4)*g_spacingX), 400)
--   end
-- 	userbackwindow:setSize(137, 78)
-- 	userbackwindow:setVisible(true)
-- 	userbackwindow:setEnabled(false)
-- 	userbackwindow:setZOrderingEnabled(false)
-- 	root:addChildWindow(userbackwindow)

--     if (i < 4) then
	
--         -- 1. User Level
--         mywindow = winMgr:createWindow("TaharezLook/StaticText", i.."sj_wndMatchMakingConfirm_userInfo_level")
--         mywindow:setProperty("FrameEnabled", "false")
--         mywindow:setProperty("BackgroundEnabled", "false")
--         mywindow:setTextColor(255, 255, 255, 255)
--         mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
--         mywindow:setPosition(10, -2)
--         mywindow:setSize(30, 36)
--         mywindow:setEnabled(false)
--         userbackwindow:addChildWindow(mywindow)
        
--         -- 2. Username
--         mywindow = winMgr:createWindow("TaharezLook/StaticText", i.."sj_wndMatchMakingConfirm_userInfo_name")
--         mywindow:setProperty("FrameEnabled", "false")
--         mywindow:setProperty("BackgroundEnabled", "false")
--         mywindow:setTextColor(255, 255, 255, 255)
--         mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
--         mywindow:setPosition(43, 59)
--         mywindow:setSize(50, 20)
--         mywindow:setEnabled(false)
--         userbackwindow:addChildWindow(mywindow)
            
--         -- 3. Job
--         mywindow = winMgr:createWindow("TaharezLook/StaticImage", i.."sj_wndMatchMakingConfirm_userInfo_style")
--         mywindow:setTexture("Enabled", "UIData/skillitem001.tga", 497, 0)
--         mywindow:setTexture("Disabled", "UIData/skillitem001.tga", 497, 0)
--         mywindow:setTexture("Layered", "UIData/skillitem001.tga", 497, 0)
--         mywindow:setProperty("FrameEnabled", "False")
--         mywindow:setProperty("BackgroundEnabled", "False")
--         mywindow:setPosition(56, -2)
--         mywindow:setSize(87, 35)
--         mywindow:setScaleWidth(210)
--         mywindow:setScaleHeight(210)
--         mywindow:setLayered(true)
--         mywindow:setEnabled(false)
--         mywindow:setZOrderingEnabled(false)
--         userbackwindow:addChildWindow(mywindow)
        
--         -- 4. Network
--         mywindow = winMgr:createWindow("TaharezLook/StaticImage", i .. "sj_wndMatchMakingConfirm_userInfo_networkImage")
--         mywindow:setTexture("Enabled", "UIData/battleroom001.tga", 0, 1017)
--         mywindow:setTexture("Disabled", "UIData/battleroom001.tga", 0, 1017)
--         mywindow:setProperty("FrameEnabled", "False")
--         mywindow:setProperty("BackgroundEnabled", "False")
--         mywindow:setPosition(8, 24)
--         mywindow:setSize(120, 5)
--         mywindow:setZOrderingEnabled(false)
--         mywindow:setEnabled(false)
--         userbackwindow:addChildWindow(mywindow)
        
--         -- 5. Info Title
--         mywindow = winMgr:createWindow("TaharezLook/StaticImage", i.."sj_wndMatchMakingConfirm_userInfo_title")
--         mywindow:setTexture("Enabled", "UIData/numberUi001.tga", 0, 201)
--         mywindow:setTexture("Disabled", "UIData/numberUi001.tga", 0, 201)
--         mywindow:setProperty("FrameEnabled", "False")
--         mywindow:setProperty("BackgroundEnabled", "False")
--         mywindow:setPosition(2, 34)
--         mywindow:setSize(107, 18)
--         mywindow:setEnabled(false)
--         mywindow:setZOrderingEnabled(false)
--         userbackwindow:addChildWindow(mywindow)
        
--         -- 6. Rank
--         -- mywindow = winMgr:createWindow("TaharezLook/StaticImage", i.."sj_wndMatchMakingConfirm_userInfo_ladder")
--         -- mywindow:setTexture("Enabled", "UIData/numberUi001.tga", 113, 600)
--         -- mywindow:setTexture("Disabled", "UIData/numberUi001.tga", 113, 600)
--         -- mywindow:setProperty("FrameEnabled", "False")
--         -- mywindow:setProperty("BackgroundEnabled", "False")
--         -- mywindow:setPosition(-2, 54)
--         -- mywindow:setSize(47, 21)
--         -- mywindow:setEnabled(false)
--         -- mywindow:setZOrderingEnabled(false)
--         -- userbackwindow:addChildWindow(mywindow)
--     end
-- end

-- --------------------------------------------------------------------

-- -- Ready Button

-- --------------------------------------------------------------------

-- mywindow = winMgr:createWindow("TaharezLook/Button", "sj_wndMatchMakingConfirm_startAndReadyBtn")
-- mywindow:setTexture("Normal", "UIData/Arcade_rank.tga", 0, 103)
-- mywindow:setTexture("Hover", "UIData/Arcade_rank.tga", 0, 186)
-- mywindow:setTexture("Pushed", "UIData/Arcade_rank.tga", 0, 269)
-- mywindow:setTexture("PushedOff", "UIData/Arcade_rank.tga", 0, 103)
-- mywindow:setTexture("Disabled", "UIData/Arcade_rank.tga", 0, 352)
-- mywindow:setPosition(400, 300)
-- mywindow:setSize(237, 73)
-- mywindow:setZOrderingEnabled(false)
-- mywindow:subscribeEvent("Clicked", "MatchMakingPrepare_Ready")
-- root:addChildWindow(mywindow)

-- --------------------------------------------------------------------

-- -- GetInfo

-- --------------------------------------------------------------------




-- function wndMatchMakingConfirm_RenderCharacterInfo(slot, mySlot, level, name, bone, style, network, titleNumber, ladderGrade
--   , partyOwner, life, coin, HardCoupon, icafe , EmblemKey, promotion, AniTitleTick, attribute)

-- winMgr:getWindow(slot.."sj_wndMatchMakingConfirm_userInfoBack"):setVisible(true)
-- -- winMgr:getWindow(slot.."sj_wndMatchMakingConfirm_userInfo_master"):setVisible(true)
-- --winMgr:getWindow(slot.."sj_wndMatchMakingConfirm_userInfo_clubEmbleImage"):setVisible(true)
-- winMgr:getWindow(slot.."sj_wndMatchMakingConfirm_userInfo_style"):setScaleWidth(210)
-- winMgr:getWindow(slot.."sj_wndMatchMakingConfirm_userInfo_style"):setScaleHeight(210)

-- -- User Info
-- if slot == mySlot then
-- winMgr:getWindow(slot.."sj_wndMatchMakingConfirm_userInfo_level"):setTextColor(255, 205, 86, 255)
-- winMgr:getWindow(slot.."sj_wndMatchMakingConfirm_userInfo_name"):setTextColor(255, 205, 86, 255)
-- else
-- winMgr:getWindow(slot.."sj_wndMatchMakingConfirm_userInfo_level"):setTextColor(255, 255, 255, 255)
-- winMgr:getWindow(slot.."sj_wndMatchMakingConfirm_userInfo_name"):setTextColor(255, 255, 255, 255)
-- end

-- -- Level
-- winMgr:getWindow(slot.."sj_wndMatchMakingConfirm_userInfo_level"):setText("Lv."..level)

-- -- Name
-- local summaryName = SummaryString(g_STRING_FONT_GULIMCHE, 12, name, 70)
-- local nameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, summaryName)
-- winMgr:getWindow(slot.."sj_wndMatchMakingConfirm_userInfo_name"):setPosition(90-nameSize/2, 57)
-- winMgr:getWindow(slot.."sj_wndMatchMakingConfirm_userInfo_name"):setText(summaryName)

-- -- Style
-- winMgr:getWindow(slot.."sj_wndMatchMakingConfirm_userInfo_style"):setTexture("Disabled", "UIData/Skill_up2.tga", tAttributeImgTexXTable[style][attribute], tAttributeImgTexYTable[style][attribute])
-- winMgr:getWindow(slot.."sj_wndMatchMakingConfirm_userInfo_style"):setTexture("Layered", "UIData/Skill_up2.tga", promotionImgTexXTable[style], promotionImgTexYTable[promotion])

-- -- Network
-- local offset = 0
-- if		 0 <= network and network <= 20 then	offset = 120
-- elseif	20 <  network and network <= 40 then	offset = 96
-- elseif	40 <  network and network <= 60 then	offset = 72
-- elseif	60 <  network and network <= 80 then	offset = 48
-- elseif	80 <  network and network <= 100 then	offset = 24
-- else											offset = 24
-- end	
-- winMgr:getWindow(slot.."sj_wndMatchMakingConfirm_userInfo_networkImage"):setSize(offset, 5)

-- -- title
-- if titleNumber <= 0 or titleNumber == 26 then
-- winMgr:getWindow(slot.."sj_wndMatchMakingConfirm_userInfo_title"):setTexture("Disabled", "UIData/invisible.tga", 0, 201+21*(titleNumber-1))
-- elseif titleNumber > 0 and #tTitleFilName >= titleNumber then
-- winMgr:getWindow(slot.."sj_wndMatchMakingConfirm_userInfo_title"):setTexture("Disabled", "UIData/"..tTitleFilName[titleNumber], tTitleTexX[titleNumber], tTitleTexY[titleNumber])
-- elseif titleNumber >= 10001 then	-- �ִ� Īȣ
-- winMgr:getWindow(slot.."sj_wndMatchMakingConfirm_userInfo_title"):setSize(110, 18)
-- winMgr:getWindow(slot.."sj_wndMatchMakingConfirm_userInfo_title"):setPosition(13, 32)
-- winMgr:getWindow(slot.."sj_wndMatchMakingConfirm_userInfo_title"):setTexture("Disabled", "UIData/"..tAniTitleFilName[titleNumber - 10001], tAniTitleTexX[titleNumber - 10001], 18 * AniTitleTick)
-- else
-- winMgr:getWindow(slot.."sj_wndMatchMakingConfirm_userInfo_title"):setTexture("Disabled", "UIData/invisible.tga", 0, 201+21*(titleNumber-1))
-- end	

-- -- Rank
-- -- winMgr:getWindow(slot.."sj_wndMatchMakingConfirm_userInfo_ladder"):setTexture("Disabled", "UIData/numberUi001.tga", 113, 600+21*ladderGrade)

-- -- Life
-- -- local lifeText = CommatoMoneyStr(life)
-- -- winMgr:getWindow(slot.."sj_wndMatchMakingConfirm_userInfo_lifeImage"):setVisible(true)
-- -- winMgr:getWindow(slot.."sj_wndMatchMakingConfirm_userInfo_lifeNum"):setVisible(true)
-- -- winMgr:getWindow(slot.."sj_wndMatchMakingConfirm_userInfo_lifeNum"):setText("x "..lifeText)

-- -- Coin
-- -- --if slot == mySlot then		
-- -- winMgr:getWindow(slot.."sj_wndMatchMakingConfirm_userInfo_coinImage"):setVisible(true)
-- -- winMgr:getWindow(slot.."sj_wndMatchMakingConfirm_userInfo_coinNum"):setVisible(true)

-- -- local coinText = CommatoMoneyStr(coin)
-- -- local r,g,b = GetGranColor(tonumber(coin))		
-- -- winMgr:getWindow(slot.."sj_wndMatchMakingConfirm_userInfo_coinNum"):setText("x "..coinText)
-- -- winMgr:getWindow(slot.."sj_wndMatchMakingConfirm_userInfo_coinNum"):setTextColor(255,255,255,255)

-- -- Hard Arcade Ticket
-- -- winMgr:getWindow(slot.."sj_wndMatchMakingConfirm_userInfo_HardArcadeImage"):setVisible(true)
-- -- winMgr:getWindow(slot.."sj_wndMatchMakingConfirm_userInfo_HardArcadeNum"):setVisible(true)

-- -- local coinText = CommatoMoneyStr(HardCoupon)
-- -- local r,g,b = GetGranColor(tonumber(HardCoupon))		
-- -- winMgr:getWindow(slot.."sj_wndMatchMakingConfirm_userInfo_HardArcadeNum"):setText("x "..HardCoupon)
-- -- winMgr:getWindow(slot.."sj_wndMatchMakingConfirm_userInfo_HardArcadeNum"):setTextColor(255,255,255,255)
-- -- --end


-- -- Start and Ready Button
-- -- if mySlot == partyOwner then
-- -- g_PartyMasterIsMe = true
-- -- winMgr:getWindow("sj_questroom_startAndReadyBtn"):setEnabled(true)		

-- -- else
-- -- g_PartyMasterIsMe = false
-- -- winMgr:getWindow("sj_questroom_startAndReadyBtn"):setEnabled(false)		
-- -- end


-- -- -- Party Owner
-- -- if slot == partyOwner then
-- -- winMgr:getWindow(slot.."sj_wndMatchMakingConfirm_userInfo_master"):setTexture("Disabled", "UIData/Arcade_lobby.tga", 137, 0)
-- -- else
-- -- winMgr:getWindow(slot.."sj_wndMatchMakingConfirm_userInfo_master"):setTexture("Disabled", "UIData/Arcade_lobby.tga", 137, 25)
-- -- end


-- -- -- icafe
-- -- local window = winMgr:getWindow(slot .. "sj_wndMatchMakingConfirm_userInfo_icafeImage")
-- -- if icafe == 1 then
-- -- window:setVisible(true)
-- -- window:setTexture("Enabled", "UIData/LobbyImage_new.tga", 729, 235)
-- -- window:setTexture("Disabled", "UIData/LobbyImage_new.tga", 729, 235)
-- -- window:setScaleWidth(160)
-- -- window:setScaleHeight(160)

-- -- elseif icafe == 2 then
-- -- window:setVisible(true)
-- -- window:setTexture("Enabled", "UIData/LobbyImage_new.tga", 665, 235)
-- -- window:setTexture("Disabled", "UIData/LobbyImage_new.tga", 665, 235)
-- -- window:setScaleWidth(160)
-- -- window:setScaleHeight(160)
-- -- end

-- --gang
-- --local window = winMgr:getWindow(slot .. "sj_wndMatchMakingConfirm_userInfo_clubEmbleImage")
-- --winMgr:getWindow(slot .. "sj_wndMatchMakingConfirm_userInfo_clubEmbleImage"):setScaleWidth(200)
-- --winMgr:getWindow(slot .. "sj_wndMatchMakingConfirm_userInfo_clubEmbleImage"):setScaleHeight(200)
-- --if EmblemKey > 0 then
-- --	window:setVisible(true) 
-- --	window:setTexture('Enabled', GetClubDirectory(GetLanguageType())..EmblemKey..".tga", 0, 0)
-- --	window:setTexture('Disabled',GetClubDirectory(GetLanguageType())..EmblemKey..".tga", 0, 0)
-- --else
-- --	window:setVisible(false)
-- --	window:setTexture('Enabled', 'UIData/invisible.tga', 0, 0)
-- --	window:setTexture('Disabled', 'UIData/invisible.tga', 0, 0)
-- --end

-- end

-- wndMatchMakingConfirm_RenderCharacterInfo(1,1,10,'CAP',3,2,20,0,0,0,0,0,0,0,0,0,0,0)
-- wndMatchMakingConfirm_RenderCharacterInfo(2,1,10,'CAP',3,1,150,0,0,0,0,0,0,0,0,0,0,0)