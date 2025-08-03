--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------

local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)
root:activate()


--------------------------------------------------------------------
-- πÆ¿⁄ø≠ø° ¥Î«— ¡§∫∏ πﬁæ∆ø¬¥Ÿ
--------------------------------------------------------------------



--------------------------------------------------------------------
-- ±§¿Â∏  ¿¸ø™¿∏∑Œ æµ ∫Øºˆ.
--------------------------------------------------------------------
local PlayerAngle = 0
local PlayerX = 0
local PlayerY = 0
local tPartyMemberPx = {['protecterr'] = 0,	1000, 1000, 1000 }
local tPartyMemberPy = {['protecterr'] = 0,	1000, 1000, 1000 }

local tCharacterTooltipInfo = {['err']= 0, false, 0,0,"",0}


--------------------------------------------------------------------
-- ±§¿Â∏  µﬁ∆«
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MaxMapContainer")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setWideType(6);
mywindow:setPosition((g_MAIN_WIN_SIZEX - 781) / 2, (g_MAIN_WIN_SIZEY - 632) / 2)
mywindow:setSize(733, 625)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

RegistEscEventInfo("MaxMapContainer", "MaxMapClose")

--------------------------------------------------------------------
-- ±§¿Â∏  ∏ﬁ¿Œ ¿ÃπÃ¡ˆ
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MaxMapMainImg")
mywindow:setTexture("Enabled", "UIData/mini_map1.tga", 50, 50)
mywindow:setTexture("Disabled", "UIData/mini_map1.tga", 50, 50)
mywindow:setPosition(26, 68)
mywindow:setSize(681, 532)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setSubscribeEvent('EndRender', 'MaxMap_EndRender');
winMgr:getWindow("MaxMapContainer"):addChildWindow(mywindow)



--------------------------------------------------------------------
-- ±§¿Â∏  ¿ßø° πŸ 
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MaxMapBar_Top")
mywindow:setTexture("Enabled", "UIData/mini_map1.tga", 287, 929)
mywindow:setTexture("Disabled", "UIData/mini_map1.tga", 287, 929)
mywindow:setPosition(25, 0)
mywindow:setSize(683, 69)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("MaxMapContainer"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- ±§¿Â∏  ∏ﬁ¿Œ ¿ÃπÃ¡ˆ
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MaxMapInfomation")
mywindow:setTexture("Enabled", "UIData/mini_map1.tga", 781, 0)
mywindow:setTexture("Disabled", "UIData/mini_map1.tga", 781, 0)
mywindow:setPosition(30, 50)
mywindow:setSize(96, 200)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("MaxMapContainer"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- ±§¿Â ¿Ã∏ß
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MaxMapTownName")
mywindow:setTexture("Enabled", "UIData/mini_map1.tga", 781, 175)
mywindow:setTexture("Disabled", "UIData/mini_map1.tga", 781, 175)
mywindow:setPosition(297, 28)
mywindow:setSize(139, 27)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("MaxMapContainer"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- ±§¿Â∏  øﬁ¬  πŸ
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MaxMapBar_Left")
mywindow:setTexture("Enabled", "UIData/mini_map1.tga", 970, 419)
mywindow:setTexture("Disabled", "UIData/mini_map1.tga", 970, 419)
mywindow:setPosition(0, 20)
mywindow:setSize(27, 605)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("MaxMapContainer"):addChildWindow(mywindow)

--------------------------------------------------------------------
-- ±§¿Â∏  ø¿∏•¬  πŸ
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MaxMapBar_Right")
mywindow:setTexture("Enabled", "UIData/mini_map1.tga", 997, 419)
mywindow:setTexture("Disabled", "UIData/mini_map1.tga", 997, 419)
mywindow:setPosition(706, 20)
mywindow:setSize(27, 605)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("MaxMapContainer"):addChildWindow(mywindow)

--------------------------------------------------------------------
-- ±§¿Â∏  æ∆∑° πŸ
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MaxMapBar_Bottom")
mywindow:setTexture("Enabled", "UIData/mini_map1.tga", 287, 998)
mywindow:setTexture("Disabled", "UIData/mini_map1.tga", 287, 998)
mywindow:setPosition(25, 599)
mywindow:setSize(683, 26)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("MaxMapContainer"):addChildWindow(mywindow)

--------------------------------------------------------------------
-- ±§¿Â∏  ≈∏¿Ã∆≤πŸ(øÚ¡˜¿Ã∞‘)
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Titlebar", "MaxMapTitleBar")
mywindow:setPosition(0, 0)
mywindow:setSize(580, 33)
winMgr:getWindow("MaxMapContainer"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- ±§¿Â∏  ¥›±‚πˆ∆∞
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "Map_CloseButton")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setPosition(702, 27)
mywindow:setSize(23, 23)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:subscribeEvent("Clicked", "MaxMapClose")
winMgr:getWindow("MaxMapContainer"):addChildWindow(mywindow)



-- ¿¸√º∏  æÀ∆ƒ¿ÃπÃ¡ˆ ESC≈∞, ENTER≈∞ µÓ∑œ
RegistEscEventInfo("MaxMapMainImg", "MaxMapClose")
RegistEnterEventInfo("MaxMapMainImg", "MaxMapClose")


mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'MyPosImage');
mywindow:setTexture('Enabled', 'UIData/village.tga', 244, 390);
mywindow:setTexture('Disabled', 'UIData/village.tga', 244, 390);
mywindow:setPosition(0, 0);
mywindow:setSize(21, 21);
mywindow:setAlign(8)
mywindow:setAngle(0)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:clearControllerEvent('MyPosEffect');
mywindow:addController("AlphaFireController", "MyPosEffect", "xscale", "Elastic_EaseOut", 0, 250, 10, true, true, 10)
mywindow:addController("AlphaFireController", "MyPosEffect", "yscale", "Elastic_EaseOut", 0, 250, 10, true, true, 10)
mywindow:activeMotion('MyPosEffect');
winMgr:getWindow("MaxMapMainImg"):addChildWindow(mywindow)




-- / 4«ÿµµ ±◊∏Æ ≈©∞‘ πÆ¡¶∞° ¿÷¡ˆ¥¬ æ ¡ˆ∏∏ ¬…±› ªﬂ∂‘æÓ¡Æ ∫∏¿œ ºˆ ¿÷±‚ãöπÆø°
-- ∞¢µµ 2000¿Ã ¿©µµøÏ∑Œ¥¬ 510
tMyWindowAngle	= {['protecterr'] = 0, }

tMyWindowAngle[0]		= 0
tMyWindowAngle[250]		= 64
tMyWindowAngle[500]		= 127
tMyWindowAngle[750]		= 191
tMyWindowAngle[1000]	= 255
tMyWindowAngle[1250]	= 319
tMyWindowAngle[1500]	= 382
tMyWindowAngle[1750]	= 447

------------------------------------------------
-- ¿¸√º∏  ∑£¥ı
------------------------------------------------
function MaxMap_EndRender(args)
	local drawer = winMgr:getWindow("MaxMapMainImg"):getDrawer();
	
	if tCharacterTooltipInfo[1] then
		RenderBuffTooltip(drawer, tCharacterTooltipInfo[2], tCharacterTooltipInfo[3], tCharacterTooltipInfo[4])
		--tCharacterTooltipInfo[1] = false
	end
	
--	drawer:drawTexture("UIData/mini_map2.tga", 508, 5, 94, 175, 734, 0);
--	drawer:drawTextureWithScale_Angle_Offset("UIData/mini_map2.tga", 6, 0, 491, 6, 1, 0, 255, 255, 255, 500, 0, 0, 0);	--øﬁ¬ 
--	drawer:drawTextureWithScale_Angle_Offset("UIData/mini_map2.tga", 610, 0, 491, 6, 1, 0, 255, 255, 255, 500, 0, 0, 0);--ø¿∏•¬ 
--	drawer:drawTextureWithScale_Angle_Offset("UIData/mini_map2.tga", 0, 491, 610, 6, 1, 0, 255, 255, 255, 0, 0, 0, 0);	--¿ß
end
--610, 487)


--------------------------------------------------------------------
-- ∏ ¿ª ∫∏ø©¡ÿ¥Ÿ.
--------------------------------------------------------------------
function ShowMap()
	if winMgr:getWindow("MaxMapContainer"):isVisible(true) then
		winMgr:getWindow("MaxMapContainer"):setVisible(false);		
		--OnClicked_MiniMapCloseButton()
	else
		root:addChildWindow(winMgr:getWindow("MaxMapContainer")); 
		winMgr:getWindow("MaxMapContainer"):setVisible(true);
		--OnClicked_MiniMapOpenButton()
--		winMgr:getWindow("MaxMap"):addChildWindow(winMgr:getWindow("MyPosImage"))
	end	
end

--------------------------------------------------------------------
-- ∏  ¥›¥¬¥Ÿ.
--------------------------------------------------------------------
function MaxMapClose(args)
	winMgr:getWindow("MaxMapContainer"):setVisible(false);
	OnClicked_MiniMapCloseButton()
	tCharacterTooltipInfo[1] = false
	tCharacterTooltipInfo[2] = 0
	tCharacterTooltipInfo[3] = 0
	tCharacterTooltipInfo[4] = ""
	tCharacterTooltipInfo[5] = 0
end


function EnterCharacterSetting(key, Name)
	if winMgr:getWindow("CharacterPosImage"..key) then
		return	
	else
		mywindow = winMgr:createWindow('TaharezLook/StaticImage', "CharacterPosImage"..key);
		mywindow:setTexture('Enabled', 'UIData/mainBG_Button001.tga', 196, 980);
		mywindow:setTexture('Disabled', 'UIData/mainBG_Button001.tga', 196, 980);
		mywindow:setPosition(0, 0);
		mywindow:setSize(11, 11);
		mywindow:setVisible(true)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:setUserString("Name", Name)
		mywindow:setUserString("Key", key)
		mywindow:setSubscribeEvent('MouseEnter', 'MouseEnterCharactertoMap');
		mywindow:setSubscribeEvent('MouseLeave', 'MouseLeaveCharactertoMap');
		winMgr:getWindow("MaxMapMainImg"):addChildWindow(mywindow)
		
	end	
end


function MouseEnterCharactertoMap(args)
	local local_window	= CEGUI.toWindowEventArgs(args).window
	local windowpos	= local_window:getPosition()
	tCharacterTooltipInfo[1] = true
	tCharacterTooltipInfo[2] = windowpos.x.offset+4
	tCharacterTooltipInfo[3] = windowpos.y.offset+30 
	tCharacterTooltipInfo[4] = local_window:getUserString("Name")
	tCharacterTooltipInfo[5] = tonumber(local_window:getUserString("Key"))
end


function MouseLeaveCharactertoMap(args)
	tCharacterTooltipInfo[1] = false
end

function ClearLeaveBoolean(key)
	if tCharacterTooltipInfo[5] == key then
		tCharacterTooltipInfo[1] = false
	end	
end

local CharacterPosX = 247
local CharacterPosY = 318

--local CharacterPosX = 320
--local CharacterPosY = 293

function RenderCharactertoMap(key, bMy, bParty, bClub, px, py, angle)
	if bMy == 1 then
		if winMgr:getWindow("MyPosImage") then
			winMgr:getWindow("MyPosImage"):setPosition(px + CharacterPosX, -py + CharacterPosY);
			winMgr:getWindow("MyPosImage"):setAngle(tMyWindowAngle[angle])
			return
		end
	end
	if winMgr:getWindow("CharacterPosImage"..key) then
		if bParty == 1 then
			winMgr:getWindow("CharacterPosImage"..key):setTexture('Enabled', 'UIData/mainBG_Button001.tga', 196, 980);
			winMgr:getWindow("CharacterPosImage"..key):setTexture('Disabled', 'UIData/mainBG_Button001.tga', 196, 980);
		elseif bClub == 1 then
			winMgr:getWindow("CharacterPosImage"..key):setTexture('Enabled', 'UIData/mainBG_Button001.tga', 208, 980);
			winMgr:getWindow("CharacterPosImage"..key):setTexture('Disabled', 'UIData/mainBG_Button001.tga', 208, 980);
		else
			winMgr:getWindow("CharacterPosImage"..key):setTexture('Enabled', 'UIData/mainBG_Button001.tga', 196, 991);
			winMgr:getWindow("CharacterPosImage"..key):setTexture('Disabled', 'UIData/mainBG_Button001.tga', 196, 991);
		end
		winMgr:getWindow("CharacterPosImage"..key):setPosition(px + CharacterPosX + 5, -py + CharacterPosY + 5)
		if tCharacterTooltipInfo[5] == key then
			tCharacterTooltipInfo[2] = px + CharacterPosX + 9
			tCharacterTooltipInfo[3] = -py + CharacterPosY + 35
		end
	end
end



local tZoneType = {['protecterr'] = 0, "UIData/mini_map1.tga", "UIData/mini_map3.tga"}
local tCharacterPosX = {['protecterr'] = 0, 320, 324}
local tCharacterPosY = {['protecterr'] = 0, 250, 343}
-- ±§¿Âø° µ˚∂Û ∏ ¿ª º≥¡§«—¥Ÿ.
function SettingTownTypeMap(townType)
	if 0 >= townType and townType > #tZoneType then
		return
	end
	
	local Path = tZoneType[townType]
	-- 
	CharacterPosX = tCharacterPosX[townType]
	CharacterPosY = tCharacterPosY[townType]
	
	-- ±§¿Â æ»≥ª «•Ω√	
	winMgr:getWindow("MaxMapInfomation"):setTexture("Enabled", Path, 781, 0)
	winMgr:getWindow("MaxMapInfomation"):setTexture("Disabled", Path, 781, 0)
	-- ±§¿Â ¿Ã∏ß
	winMgr:getWindow("MaxMapTownName"):setTexture("Enabled", Path, 877, 0)
	winMgr:getWindow("MaxMapTownName"):setTexture("Disabled", Path, 877, 0)
	-- ±§¿Â ¿ÃπÃ¡ˆ
	winMgr:getWindow("MaxMapMainImg"):setTexture("Enabled", Path, 50, 50)
	winMgr:getWindow("MaxMapMainImg"):setTexture("Disabled", Path, 50, 50)

end
