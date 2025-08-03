-----------------------------------------
-- Script Entry Point
-----------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)
root:activate()

local width, height = GetWindowSize()

-- 데미지
local DAMAGECOUNT	= 0
local DAMAGE		= {["err"]=0, }
local SCREENX		= {["err"]=0, }
local SCREENY		= {["err"]=0, }
local DELTATIME		= {["err"]=0, }
local ALPHAVALUE	= {["err"]=0, }
local CRITICAL		= {["err"]=0, }
local OUTPUTCOUNT	= {["err"]=0, }

-- 포인트
local POINTCOUNT		= 0
local POINTNUM			= {["err"]=0, }
local POINTSCREENX		= {["err"]=0, }
local POINTSCREENY		= {["err"]=0, }
local POINTDELTATIME	= {["err"]=0, }
local POINTALPHAVALUE	= {["err"]=0, }

local	MyCharacterPosX = 0
local	MyCharacterPosY = 0

--------------------------------------------------------------------------------
-- Damage Setting
--------------------------------------------------------------------------------
function WndDefence_StartDamage(Damage, ScreenX, ScreenY, DeltaTime, bCritical)
	table.insert(DAMAGE,		DAMAGECOUNT,	Damage)
	table.insert(SCREENX,		DAMAGECOUNT,	ScreenX)
	table.insert(SCREENY,		DAMAGECOUNT,	ScreenY)
	table.insert(DELTATIME,		DAMAGECOUNT,	DeltaTime)
	table.insert(ALPHAVALUE,	DAMAGECOUNT,	255)
	table.insert(CRITICAL,		DAMAGECOUNT,	bCritical)
	table.insert(OUTPUTCOUNT,	DAMAGECOUNT,	0)
	
	DAMAGECOUNT = DAMAGECOUNT + 1
	
	if DAMAGECOUNT == 100 then
		DAMAGECOUNT = 0
	end
end

--------------------------------------------------------------------------------
-- Point Setting
--------------------------------------------------------------------------------
function WndDefence_StartPoint(PointNum, ScreenX, ScreenY, DeltaTime)
	table.insert(POINTNUM,			POINTCOUNT,	PointNum)
	table.insert(POINTSCREENX,		POINTCOUNT,	ScreenX)
	table.insert(POINTSCREENY,		POINTCOUNT,	ScreenY)
	table.insert(POINTDELTATIME,	POINTCOUNT,	DeltaTime)
	table.insert(POINTALPHAVALUE,		POINTCOUNT,	255)
	
	POINTCOUNT = POINTCOUNT + 1
	
	if POINTCOUNT == 100 then
		POINTCOUNT = 0
	end
end

--------------------------------------------------------------------------------
-- 좀비 미니 게이지 출력
--------------------------------------------------------------------------------
function WndDefence_MiniGageOutPut(Hp, MaxHp, ScreenX, ScreenY)
	local drawer = CEGUI.WindowManager:getSingleton():getWindow("DefaultWindow"):getDrawer()
	
	computedOldHPrealwidth = Hp * 84 / MaxHp
	
	drawer:drawTexture("UIData/GameNewImage.tga", ScreenX, ScreenY, 86, 7, 603, 699)
	drawer:drawTexture("UIData/GameNewImage.tga", ScreenX + 2, ScreenY + 2, computedOldHPrealwidth, 8, 605, 721)
end

--------------------------------------------------------------------------------
-- Video Top Image
--------------------------------------------------------------------------------
local window = winMgr:createWindow("TaharezLook/StaticImage", "WndDefence_Top_Image")
window:setTexture("Enabled", "UIData/Black.dds", 0, 0)
window:setTexture("Disabled","UIData/Black.dds", 0, 0)
window:setProperty("FrameEnabled",		"False")
window:setProperty("BackgroundEnabled", "False")
window:setSize(1920, 150)
window:setPosition(0 , -150)
window:setAlwaysOnTop(true)
window:setZOrderingEnabled(false)
window:setVisible(true)
root:addChildWindow(window)

--------------------------------------------------------------------------------
-- Video Bottom Image
--------------------------------------------------------------------------------
local window = winMgr:createWindow("TaharezLook/StaticImage", "WndDefence_Bottom_Image")
window:setTexture("Enabled", "UIData/Black.dds", 0, 0)
window:setTexture("Disabled","UIData/Black.dds", 0, 0)
window:setProperty("FrameEnabled",		"False")
window:setProperty("BackgroundEnabled", "False")
window:setSize(1920, 160)
window:setPosition(0 , height)
window:setAlwaysOnTop(true)
window:setZOrderingEnabled(false)
window:setVisible(false)
root:addChildWindow(window)

function WndDefence_FinishVideoUI(DeltaTime, StartTime)
	local NowTick = DeltaTime - StartTime
	
	winMgr:getWindow("WndDefence_MiniMapLineBG"):setVisible(false)
	winMgr:getWindow("WndDefence_NewMoveExitBtn"):setVisible(false)
	
	if NowTick <= 5500 and NowTick >= 4000 then
		winMgr:getWindow("WndDefence_Top_Image"):setPosition(0, -150 + ((NowTick - 4000) / 10))
		winMgr:getWindow("WndDefence_Bottom_Image"):setVisible(true)
		winMgr:getWindow("WndDefence_Bottom_Image"):setPosition(0, (height - 20) - ((NowTick - 4000) / 10))
	end
end

--------------------------------------------------------------------------------
-- 미니맵, 나가기 버튼 보여주기
--------------------------------------------------------------------------------
function WndDefence_MapExitBtnSetUp()
	winMgr:getWindow("WndDefence_MiniMapLineBG"):setVisible(true)
	winMgr:getWindow("WndDefence_NewMoveExitBtn"):setVisible(true)
end

--------------------------------------------------------------------------------
-- common 루아에 인자값이 잘못 된 부분이 있어서 다시 만들어 줌
--------------------------------------------------------------------------------
function WndDefence_DrawEachNumberAS(fileName, number, align, posX, posY, startX, startY, sizeX, sizeY, spacing, alpha, scaleX, scaleY, widetype)
	local drawer = CEGUI.WindowManager:getSingleton():getWindow("DefaultWindow"):getDrawer()
	
	local angle = 0
	
	if number < 0 then
		number = number * -1
	end
	
	local mil = number/1000000
	local hth = (number - (mil*1000000))/100000
	local myr = (number - (mil*1000000 + hth*100000))/10000
	local tho = (number - (mil*1000000 + hth*100000 + myr*10000))/1000
	local hun = (number - (mil*1000000 + hth*100000 + myr*10000 + tho*1000))/100
	local ten = (number - (mil*1000000 + hth*100000 + myr*10000 + tho*1000 + hun*100))/10
	local one = number%10
	
	local _left, _right
	local _1st, _2nd, _3rd, _4th, _5th, _6th, _7th
	
	-- 가운데 정렬(8)	
	if align == 8 then
		if number >= 1000000 then
			_1st = posX-spacing-spacing-spacing
			_2nd = posX-spacing-spacing
			_3rd = posX-spacing
			_4th = posX
			_5th = posX+spacing
			_6th = posX+spacing+spacing
			_7th = posX+spacing+spacing+spacing
			
		elseif 100000 <= number and number < 1000000 then
			_1st = posX - (spacing/2)-spacing-spacing
			_2nd = posX - (spacing/2)-spacing
			_3rd = posX - (spacing/2)
			_4th = posX + (spacing/2)
			_5th = posX + (spacing/2)+spacing
			_6th = posX + (spacing/2)+spacing+spacing
		
		elseif 10000 <= number and number < 100000 then
			_1st = posX-spacing-spacing
			_2nd = posX-spacing
			_3rd = posX
			_4th = posX+spacing
			_5th = posX+spacing+spacing
			
		elseif 1000 <= number and number < 10000 then
			_1st = posX - (spacing/2)-spacing
			_2nd = posX - (spacing/2)
			_3rd = posX + (spacing/2)
			_4th = posX + (spacing/2)+spacing
			
		elseif 100 <= number and number < 1000 then
			_1st = posX-spacing
			_2nd = posX
			_3rd = posX+spacing
			
		elseif 10 <= number and number < 100 then
			_1st = posX - (spacing/2)
			_2nd = posX + (spacing/2)
			
		elseif 0 <= number and number < 10 then
			_1st = posX
		end
	end
	
	-- 숫자 그리기
	if number >= 1000000 then
		drawer:drawTextureWithScale_Angle_Offset(fileName, _1st, posY, sizeX, sizeY, startX, startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
		drawer:drawTextureWithScale_Angle_Offset(fileName, _2nd, posY, sizeX, sizeY, startX, startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
		drawer:drawTextureWithScale_Angle_Offset(fileName, _3rd, posY, sizeX, sizeY, startX+(myr*sizeX), startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
		drawer:drawTextureWithScale_Angle_Offset(fileName, _4th, posY, sizeX, sizeY, startX+(tho*sizeX), startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
		drawer:drawTextureWithScale_Angle_Offset(fileName, _5th, posY, sizeX, sizeY, startX+(hun*sizeX), startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
		drawer:drawTextureWithScale_Angle_Offset(fileName, _6th, posY, sizeX, sizeY, startX+(ten*sizeX), startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
		drawer:drawTextureWithScale_Angle_Offset(fileName, _7th, posY, sizeX, sizeY, startX+(one*sizeX), startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
	elseif 100000 <= number and number < 1000000 then
		drawer:drawTextureWithScale_Angle_Offset(fileName, _1st, posY, sizeX, sizeY, startX+(hth*sizeX), startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
		drawer:drawTextureWithScale_Angle_Offset(fileName, _2nd, posY, sizeX, sizeY, startX+(myr*sizeX), startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
		drawer:drawTextureWithScale_Angle_Offset(fileName, _3rd, posY, sizeX, sizeY, startX+(tho*sizeX), startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
		drawer:drawTextureWithScale_Angle_Offset(fileName, _4th, posY, sizeX, sizeY, startX+(hun*sizeX), startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
		drawer:drawTextureWithScale_Angle_Offset(fileName, _5th, posY, sizeX, sizeY, startX+(ten*sizeX), startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
		drawer:drawTextureWithScale_Angle_Offset(fileName, _6th, posY, sizeX, sizeY, startX+(one*sizeX), startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
	elseif 10000 <= number and number < 100000 then
		drawer:drawTextureWithScale_Angle_Offset(fileName, _1st, posY, sizeX, sizeY, startX+(myr*sizeX), startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
		drawer:drawTextureWithScale_Angle_Offset(fileName, _2nd, posY, sizeX, sizeY, startX+(tho*sizeX), startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
		drawer:drawTextureWithScale_Angle_Offset(fileName, _3rd, posY, sizeX, sizeY, startX+(hun*sizeX), startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
		drawer:drawTextureWithScale_Angle_Offset(fileName, _4th, posY, sizeX, sizeY, startX+(ten*sizeX), startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
		drawer:drawTextureWithScale_Angle_Offset(fileName, _5th, posY, sizeX, sizeY, startX+(one*sizeX), startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
	elseif 1000 <= number and number < 10000 then
		drawer:drawTextureWithScale_Angle_Offset(fileName, _1st, posY, sizeX, sizeY, startX+(tho*sizeX), startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
		drawer:drawTextureWithScale_Angle_Offset(fileName, _2nd, posY, sizeX, sizeY, startX+(hun*sizeX), startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
		drawer:drawTextureWithScale_Angle_Offset(fileName, _3rd, posY, sizeX, sizeY, startX+(ten*sizeX), startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
		drawer:drawTextureWithScale_Angle_Offset(fileName, _4th, posY, sizeX, sizeY, startX+(one*sizeX), startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
	elseif 100 <= number and number < 1000 then
		drawer:drawTextureWithScale_Angle_Offset(fileName, _1st, posY, sizeX, sizeY, startX+(hun*sizeX), startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
		drawer:drawTextureWithScale_Angle_Offset(fileName, _2nd, posY, sizeX, sizeY, startX+(ten*sizeX), startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
		drawer:drawTextureWithScale_Angle_Offset(fileName, _3rd, posY, sizeX, sizeY, startX+(one*sizeX), startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
	elseif 10 <= number and number < 100 then
		drawer:drawTextureWithScale_Angle_Offset(fileName, _1st, posY, sizeX, sizeY, startX+(ten*sizeX), startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
		drawer:drawTextureWithScale_Angle_Offset(fileName, _2nd, posY, sizeX, sizeY, startX+(one*sizeX), startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
	elseif 0 <= number and number < 10 then
		drawer:drawTextureWithScale_Angle_Offset(fileName, _1st, posY, sizeX, sizeY, startX+(one*sizeX), startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
	end
end

--------------------------------------------------------------------------------
-- 좀비 용으로 따로 만들어 줌
--------------------------------------------------------------------------------
function WndDefence_DrawEachNumber(fileName, number, align, posX, posY, startX, startY, sizeX, sizeY, spacing, alpha, scaleX, scaleY, widetype)
	local drawer = CEGUI.WindowManager:getSingleton():getWindow("DefaultWindow"):getDrawer()
	
	local angle = 0
	
	if number < 0 then
		number = number * -1
	end
	
	local mil = number/1000000
	local hth = (number - (mil*1000000))/100000
	local myr = (number - (mil*1000000 + hth*100000))/10000
	local tho = (number - (mil*1000000 + hth*100000 + myr*10000))/1000
	local hun = (number - (mil*1000000 + hth*100000 + myr*10000 + tho*1000))/100
	local ten = (number - (mil*1000000 + hth*100000 + myr*10000 + tho*1000 + hun*100))/10
	local one = number%10
	
	local _left, _right
	local _Plus, _1st, _2nd, _3rd, _4th, _5th, _6th, _7th
	
	-- 가운데 정렬(8)	
	if align == 8 then
		if number >= 1000000 then
			_Plus	= posX	- (spacing/2)-spacing-spacing-spacing
			_1st	= posX	- (spacing/2)-spacing-spacing
			_2nd	= posX	- (spacing/2)-spacing
			_3rd	= posX	- (spacing/2)
			_4th	= posX	+ (spacing/2)
			_5th	= posX	+ (spacing/2)+spacing
			_6th	= posX	+ (spacing/2)+spacing+spacing
			_7th	= posX	+ (spacing/2)+spacing+spacing+spacing
			
		elseif 100000 <= number and number < 1000000 then
			_Plus	= posX-spacing-spacing-spacing-spacing
			_1st	= posX-spacing-spacing-spacing
			_2nd	= posX-spacing
			_3rd	= posX
			_4th	= posX+spacing
			_5th	= posX+spacing+spacing
			_6th	= posX+spacing+spacing+spacing
		
		elseif 10000 <= number and number < 100000 then
			_Plus	= posX	- (spacing/2)-spacing-spacing
			_1st	= posX	- (spacing/2)-spacing
			_2nd	= posX	- (spacing/2)
			_3rd	= posX	+ (spacing/2)
			_4th	= posX	+ (spacing/2)+spacing
			_5th	= posX	+ (spacing/2)+spacing+spacing
			
		elseif 1000 <= number and number < 10000 then
			_Plus	= posX-spacing-spacing
			_1st	= posX-spacing
			_2nd	= posX
			_3rd	= posX+spacing
			_4th	= posX+spacing+spacing
			
		elseif 100 <= number and number < 1000 then
			_Plus	= posX	- (spacing/2)-spacing
			_1st	= posX	- (spacing/2)
			_2nd	= posX	+ (spacing/2)
			_3rd	= posX	+ (spacing/2)+spacing
			
		elseif 10 <= number and number < 100 then
			_Plus	= posX-spacing
			_1st	= posX
			_2nd	= posX+spacing
			
		elseif 0 <= number and number < 10 then
			_Plus	= posX	- (spacing/2)
			_1st	= posX	+ (spacing/2)
		end
	end
	
	-- 숫자 그리기
	if number >= 1000000 then
		drawer:drawTextureWithScale_Angle_Offset(fileName, _Plus, posY, sizeX, sizeY, 698, 693, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
		drawer:drawTextureWithScale_Angle_Offset(fileName, _1st, posY, sizeX, sizeY, startX, startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
		drawer:drawTextureWithScale_Angle_Offset(fileName, _2nd, posY, sizeX, sizeY, startX, startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
		drawer:drawTextureWithScale_Angle_Offset(fileName, _3rd, posY, sizeX, sizeY, startX+(myr*sizeX), startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
		drawer:drawTextureWithScale_Angle_Offset(fileName, _4th, posY, sizeX, sizeY, startX+(tho*sizeX), startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
		drawer:drawTextureWithScale_Angle_Offset(fileName, _5th, posY, sizeX, sizeY, startX+(hun*sizeX), startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
		drawer:drawTextureWithScale_Angle_Offset(fileName, _6th, posY, sizeX, sizeY, startX+(ten*sizeX), startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
		drawer:drawTextureWithScale_Angle_Offset(fileName, _7th, posY, sizeX, sizeY, startX+(one*sizeX), startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
	elseif 100000 <= number and number < 1000000 then
		drawer:drawTextureWithScale_Angle_Offset(fileName, _Plus, posY, sizeX, sizeY, 698, 693, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
		drawer:drawTextureWithScale_Angle_Offset(fileName, _1st, posY, sizeX, sizeY, startX+(hth*sizeX), startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
		drawer:drawTextureWithScale_Angle_Offset(fileName, _2nd, posY, sizeX, sizeY, startX+(myr*sizeX), startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
		drawer:drawTextureWithScale_Angle_Offset(fileName, _3rd, posY, sizeX, sizeY, startX+(tho*sizeX), startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
		drawer:drawTextureWithScale_Angle_Offset(fileName, _4th, posY, sizeX, sizeY, startX+(hun*sizeX), startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
		drawer:drawTextureWithScale_Angle_Offset(fileName, _5th, posY, sizeX, sizeY, startX+(ten*sizeX), startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
		drawer:drawTextureWithScale_Angle_Offset(fileName, _6th, posY, sizeX, sizeY, startX+(one*sizeX), startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
	elseif 10000 <= number and number < 100000 then
		drawer:drawTextureWithScale_Angle_Offset(fileName, _Plus, posY, sizeX, sizeY, 698, 693, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
		drawer:drawTextureWithScale_Angle_Offset(fileName, _1st, posY, sizeX, sizeY, startX+(myr*sizeX), startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
		drawer:drawTextureWithScale_Angle_Offset(fileName, _2nd, posY, sizeX, sizeY, startX+(tho*sizeX), startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
		drawer:drawTextureWithScale_Angle_Offset(fileName, _3rd, posY, sizeX, sizeY, startX+(hun*sizeX), startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
		drawer:drawTextureWithScale_Angle_Offset(fileName, _4th, posY, sizeX, sizeY, startX+(ten*sizeX), startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
		drawer:drawTextureWithScale_Angle_Offset(fileName, _5th, posY, sizeX, sizeY, startX+(one*sizeX), startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
	elseif 1000 <= number and number < 10000 then
		drawer:drawTextureWithScale_Angle_Offset(fileName, _Plus, posY, sizeX, sizeY, 698, 693, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
		drawer:drawTextureWithScale_Angle_Offset(fileName, _1st, posY, sizeX, sizeY, startX+(tho*sizeX), startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
		drawer:drawTextureWithScale_Angle_Offset(fileName, _2nd, posY, sizeX, sizeY, startX+(hun*sizeX), startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
		drawer:drawTextureWithScale_Angle_Offset(fileName, _3rd, posY, sizeX, sizeY, startX+(ten*sizeX), startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
		drawer:drawTextureWithScale_Angle_Offset(fileName, _4th, posY, sizeX, sizeY, startX+(one*sizeX), startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
	elseif 100 <= number and number < 1000 then
		drawer:drawTextureWithScale_Angle_Offset(fileName, _Plus, posY, sizeX, sizeY, 698, 693, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
		drawer:drawTextureWithScale_Angle_Offset(fileName, _1st, posY, sizeX, sizeY, startX+(hun*sizeX), startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
		drawer:drawTextureWithScale_Angle_Offset(fileName, _2nd, posY, sizeX, sizeY, startX+(ten*sizeX), startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
		drawer:drawTextureWithScale_Angle_Offset(fileName, _3rd, posY, sizeX, sizeY, startX+(one*sizeX), startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
	elseif 10 <= number and number < 100 then
		drawer:drawTextureWithScale_Angle_Offset(fileName, _Plus, posY, sizeX, sizeY, 698, 693, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
		drawer:drawTextureWithScale_Angle_Offset(fileName, _1st, posY, sizeX, sizeY, startX+(ten*sizeX), startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
		drawer:drawTextureWithScale_Angle_Offset(fileName, _2nd, posY, sizeX, sizeY, startX+(one*sizeX), startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
	elseif 0 <= number and number < 10 then
		drawer:drawTextureWithScale_Angle_Offset(fileName, _Plus, posY, sizeX, sizeY, 698, 693, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
		drawer:drawTextureWithScale_Angle_Offset(fileName, _1st, posY, sizeX, sizeY, startX+(one*sizeX), startY, scaleX, scaleY, alpha, 0, 8, 100, 0, widetype)
	end
end

--------------------------------------------------------------------------------
-- 데미지 출력
--------------------------------------------------------------------------------
function WndDefence_DamageOutPut(DeltaTime)
	for i=0, DAMAGECOUNT-1 do
		local NowTime		= DeltaTime- DELTATIME[i]
	
		ALPHAVALUE[i] = ALPHAVALUE[i] - (NowTime / 20)
		
		if ALPHAVALUE[i] < 0 then
			ALPHAVALUE[i] = 0
		else
			if CRITICAL[i] > 0 then
				WndDefence_DrawEachNumberAS("UIData/GameSlotItem.tga", DAMAGE[i], 8, SCREENX[i], SCREENY[i] - (NowTime / 4), 
					704, 896, 32, 32, 32, ALPHAVALUE[i], 255, 255, WIDETYPE_0)
			else
				WndDefence_DrawEachNumberAS("UIData/GameSlotItem.tga", DAMAGE[i], 8, SCREENX[i], SCREENY[i] - (NowTime / 7), 
					704, 928, 32, 32, 20, ALPHAVALUE[i], 150, 150, WIDETYPE_0)
			end
		end
		
		OUTPUTCOUNT[i] = OUTPUTCOUNT[i] + 1
	end
end

--------------------------------------------------------------------------------
-- 포인트 출력
--------------------------------------------------------------------------------
function WndDefence_PointOutPut(DeltaTime)
	for i=0, POINTCOUNT-1 do
		local NowTime		= DeltaTime- POINTDELTATIME[i]
	
		POINTALPHAVALUE[i] = POINTALPHAVALUE[i] - (NowTime / 20)
		
		if POINTALPHAVALUE[i] < 0 then
			POINTALPHAVALUE[i] = 0
		else
			WndDefence_DrawEachNumber("UIData/GameNewImage.tga", POINTNUM[i], 8, POINTSCREENX[i], POINTSCREENY[i] - (NowTime / 7), 
					721, 693, 19, 25, 25, POINTALPHAVALUE[i], 255, 255, WIDETYPE_0)
		end
	end
end

--------------------------------------------------------------------------------
-- 좀비 디펜스의 경우 로딩 배틀룸을 강제로 로딩화면으로 바꿔 주기 위해서
--------------------------------------------------------------------------------
function Defence_LoadingImg(image)
	local drawer = CEGUI.WindowManager:getSingleton():getWindow("DefaultWindow"):getDrawer()
	
	drawer:drawTextureBackImage("UIData/gameLoadingW_zombie.dds", 0, 0, 1920, 1200, 0, 0)
end

--------------------------------------------------------------------------------
-- 미니맵 백그라운드
--------------------------------------------------------------------------------
local mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'WndDefence_MiniMapLineBG')
mywindow:setTexture('Enabled', 'UIData/mainBG_Button004.tga', 288, 277)
mywindow:setTexture("Disabled","UIData/mainBG_Button004.tga", 288, 277)
mywindow:setProperty('BackgroundEnabled',	'False')
mywindow:setProperty('FrameEnabled',		'False')
mywindow:setWideType(1)
mywindow:setPosition(800, 38)
mywindow:setSize(224, 138)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(false)
mywindow:setVisible(false)
root:addChildWindow(mywindow)

--------------------------------------------------------------------------------
-- 미니맵 이미지
--------------------------------------------------------------------------------
local mywindow = winMgr:createWindow('TaharezLook/StaticImage', "WndDefence_MyMiniMapImage")
mywindow:setTexture('Enabled', 'UIData/mainBG_Button001.tga', 196, 980)
mywindow:setTexture('Disabled', 'UIData/mainBG_Button001.tga', 196, 980)
mywindow:setPosition(105, 58)
mywindow:setSize(11, 11)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("WndDefence_MiniMapLineBG"):addChildWindow(mywindow)

--------------------------------------------------------------------------------
-- 미니맵을 자신의 위치에 맞게 뿌려줌
--------------------------------------------------------------------------------
function WndDefence_MiniMapOutPut(MyPosX, MyPosY)
	MyCharacterPosX = MyPosX / 13
	MyCharacterPosY = MyPosY / 13

	drawer:drawTexture('UIData/Zombi_Minimap.tga', 805, 43, 214, 128, 155 + MyCharacterPosX, 200 - MyCharacterPosY, WIDETYPE_1)
end

--------------------------------------------------------------------------------
-- 미니맵에 좀비를 뿌려줌
--------------------------------------------------------------------------------
function WndDefence_MiniMapZombieOutPut(PosX, PosY)
	local RealPosX = PosX / 16
	local RealPosY = PosY / 15
	
	local OutPutPosX = RealPosX - MyCharacterPosX
	local OutPutPosY = RealPosY - MyCharacterPosY
	
	if OutPutPosX < 107 and OutPutPosX > -107 and OutPutPosY < 64 and OutPutPosY > -64 then
		drawer:drawTextureWithScale_Angle_Offset("UIData/hunting_001.tga", 910 + OutPutPosX, 106 - OutPutPosY, 10, 10, 567, 598, 255, 255, 255, 10, 8, 0, 0, WIDETYPE_1)
	end
end

--------------------------------------------------------------------------------
-- 미니맵에 파티원을 뿌려줌
--------------------------------------------------------------------------------
function WndDefence_MiniMapPartyOutPut(PosX, PosY, hp)
	local RealPosX = PosX / 16
	local RealPosY = PosY / 15
	
	local OutPutPosX = RealPosX - MyCharacterPosX
	local OutPutPosY = RealPosY - MyCharacterPosY
	
	if OutPutPosX < 107 and OutPutPosX > -107 and OutPutPosY < 64 and OutPutPosY > -64 then
		if hp > 0 then
			drawer:drawTextureWithScale_Angle_Offset("UIData/hunting_001.tga", 910 + OutPutPosX, 106 - OutPutPosY, 10, 10, 567 ,581, 255, 255, 255, 10, 8, 0, 0, WIDETYPE_1)
		end
	end
end

--------------------------------------------------------------------------------
-- 킬수, 네트워크 속도를 뿌려줌
--------------------------------------------------------------------------------
function WndDefence_GameInfoList(nIndex, MyIndex, PartNum, Name, nKille, NetworkSpeed, Disconnected)

	if Disconnected == 1 then
		return
	end
	
	local PartPosY = 72 * PartNum

	if MyIndex == nIndex then
		drawer:drawTexture("UIData/Zombi001.tga", 160, 65, 16, 16, 979, 408, WIDETYPE_0)
		drawer:setFont(g_STRING_FONT_GULIMCHE, 14)
		common_DrawOutlineText1(drawer, nKille, 185, 67, 0, 0, 0 ,255, 255,255,0,255, WIDETYPE_0)
	else
		drawer:drawTexture("UIData/Zombi001.tga", 115, 87 + PartPosY, 16, 16, 979, 408, WIDETYPE_0)
		drawer:setFont(g_STRING_FONT_GULIMCHE, 13)
		common_DrawOutlineText1(drawer, nKille, 138, 90 + PartPosY, 0, 0, 0 ,255, 255,255,255,255, WIDETYPE_0)
	end
	
	if NetworkSpeed == 999 then
		if MyIndex == nIndex then
			drawer:drawTexture("UIData/GameNewImage.tga", 255, 7, 24, 14, 149, 65, WIDETYPE_0)
		else
			drawer:drawTexture("UIData/GameNewImage.tga", 155, 63 + PartPosY, 24, 14, 149, 65, WIDETYPE_0)
		end
	else		
		--통신속도 표시해주기
		local offset = 0
		local texX = 227
		
		if		 0 <= NetworkSpeed and NetworkSpeed <= 20 then	offset = 24;	texX = 227;
		elseif	20 <  NetworkSpeed and NetworkSpeed <= 40 then	offset = 19;	texX = 227;
		elseif	40 <  NetworkSpeed and NetworkSpeed <= 60 then	offset = 14;	texX = 175;
		elseif	60 <  NetworkSpeed and NetworkSpeed <= 80 then	offset = 9;		texX = 175;
		elseif	80 <  NetworkSpeed and NetworkSpeed <= 100 then	offset = 4;		texX = 201;
		else													offset = 4;		texX = 201;
		end
		
		if MyIndex == nIndex then
			drawer:drawTexture("UIData/GameNewImage.tga", 255, 7, offset, 14, texX, 65, WIDETYPE_0)
		else
			drawer:drawTexture("UIData/GameNewImage.tga", 155, 63 + PartPosY, offset, 14, texX, 65, WIDETYPE_0)
		end
	end
end

--------------------------------------------------------------------------------
-- 게임 나가기 버튼
--------------------------------------------------------------------------------
local mywindow = winMgr:createWindow("TaharezLook/Button", "WndDefence_NewMoveExitBtn")
mywindow:setTexture("Normal", "UIData/mainBG_Button003.tga", 802, 616)
mywindow:setTexture("Hover", "UIData/mainBG_Button003.tga", 802, 652)
mywindow:setTexture("Pushed", "UIData/mainBG_Button003.tga", 802, 688)
mywindow:setTexture("PushedOff", "UIData/mainBG_Button003.tga", 802, 616)
mywindow:setTexture("Enabled", "UIData/mainBG_Button003.tga", 802, 616)
mywindow:setTexture("Disabled", "UIData/mainBG_Button003.tga", 802, 616)
mywindow:setWideType(1)
mywindow:setPosition(800, 3)
mywindow:setSize(222, 36)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setVisible(false)
mywindow:subscribeEvent("Clicked", "WndDefence_GameExitOpen")
root:addChildWindow(mywindow)

--------------------------------------------------------------------------------
-- 게임 나가기 확인 창
--------------------------------------------------------------------------------
local mywindow = winMgr:createWindow("TaharezLook/StaticImage", "WndDefence_AlphaBackImg")
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

local mywindow = winMgr:createWindow("TaharezLook/StaticImage", "WndDefence_ExitBackWindow")
mywindow:setTexture("Enabled", "UIData/LobbyImage_new002.tga", 684, 818)
mywindow:setTexture("Disabled", "UIData/LobbyImage_new002.tga", 684, 818)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(width/2 - 180, height/2 - 120)
mywindow:setSize(340, 141)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:setVisible(false)
root:addChildWindow(mywindow)

RegistEscEventInfo("WndDefence_ExitBackWindow", "WndGame_GameExitCancel")
RegistEnterEventInfo("WndDefence_AlphaBackImg", "Defence_Quit")

local mywindow = winMgr:createWindow("TaharezLook/Button", "WndDefence_ExitOkBtn")
mywindow:setTexture("Normal", "UIData/LobbyImage_new002.tga", 838, 0)
mywindow:setTexture("Hover", "UIData/LobbyImage_new002.tga", 838, 27)
mywindow:setTexture("Pushed", "UIData/LobbyImage_new002.tga", 838, 54)
mywindow:setTexture("PushedOff", "UIData/LobbyImage_new002.tga", 839, 0)
mywindow:setPosition(50, 100)
mywindow:setSize(90, 27)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:setVisible(true)
mywindow:subscribeEvent("Clicked", "Defence_Quit")
winMgr:getWindow("WndDefence_ExitBackWindow"):addChildWindow(mywindow)

local mywindow = winMgr:createWindow("TaharezLook/Button", "WndDefence_ExitCancelBtn")
mywindow:setTexture("Normal", "UIData/LobbyImage_new002.tga", 928, 0)
mywindow:setTexture("Hover", "UIData/LobbyImage_new002.tga", 928, 27)
mywindow:setTexture("Pushed", "UIData/LobbyImage_new002.tga", 928, 54)
mywindow:setTexture("PushedOff", "UIData/LobbyImage_new002.tga", 928, 0)
mywindow:setPosition(200, 100)
mywindow:setSize(90, 27)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:setVisible(true)
mywindow:subscribeEvent("Clicked", "WndGame_GameExitCancel")
winMgr:getWindow("WndDefence_ExitBackWindow"):addChildWindow(mywindow)

--------------------------------------------------------------------------------
-- 게임 나가기
--------------------------------------------------------------------------------
function Defence_Quit()
	Defence_ExitGame()
end

--------------------------------------------------------------------------------
-- 게임 나가기 확인 창 출력
--------------------------------------------------------------------------------
function WndDefence_GameExitOpen(args)
	winMgr:getWindow("WndDefence_AlphaBackImg"):setVisible(true)
	winMgr:getWindow("WndDefence_ExitBackWindow"):setVisible(true)
end

--------------------------------------------------------------------------------
-- 게임 나가기 확인 창 닫기
--------------------------------------------------------------------------------
function WndGame_GameExitCancel(args)
	winMgr:getWindow("WndDefence_AlphaBackImg"):setVisible(false)
	winMgr:getWindow("WndDefence_ExitBackWindow"):setVisible(false)
end
