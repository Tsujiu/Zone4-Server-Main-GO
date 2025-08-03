function WndCreateCharacter_WndCreateCharacter()


-----------------------------------------
-- Script Entry Point
-----------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)


local g_STRING_INPUT_ID	= PreCreateString_1657		--GetSStringInfo(LAN_LUA_CREATE_CHARACTER_1)	-- 캐릭터 이름을 입력해주세요!\n(한글: 2 ~ 6자, 영문: 4 ~ 12자)
local g_STRING_ERROR_ID	= PreCreateString_1658		--GetSStringInfo(LAN_LUA_CREATE_CHARACTER_2)	-- 캐릭터 이름이 너무 깁니다!

local CutSceneCharacterName = ""

--------------------------------------------------------------------

-- drawTexture(StartRender:시작시에 그리기)

--------------------------------------------------------------------
function WndCharMake_RenderBackImage()
	drawer:drawTexture("UIData/channel_002.tga", 0, 0, 1024, 69, 0, 936, WIDETYPE_5)		-- 윗쪽 바
	drawer:drawTexture("UIData/channel_002.tga", 355, 0, 314, 45, 493, 846, WIDETYPE_5)		-- Create Character
end



--------------------------------------------------------------------

-- 케릭터 선택 라디오 버튼

--------------------------------------------------------------------
bonewindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_creaetcharacter_bonebackWindow")
bonewindow:setTexture("Enabled", "UIData/character_001.tga", 0, 0)
bonewindow:setTexture("Disabled", "UIData/character_001.tga", 0, 0)
bonewindow:setProperty("FrameEnabled", "False")
bonewindow:setProperty("BackgroundEnabled", "False")
bonewindow:setPosition(30, 60)
bonewindow:setSize(256, 358)
bonewindow:setZOrderingEnabled(false)
root:addChildWindow(bonewindow)

bonewindow1 = winMgr:createWindow("TaharezLook/StaticImage", "sj_creaetcharacter_bone1backWindow")
bonewindow1:setTexture("Enabled", "UIData/character_001.tga", 0, 358)
bonewindow1:setTexture("Disabled", "UIData/character_001.tga", 0, 358)
bonewindow1:setProperty("FrameEnabled", "False")
bonewindow1:setProperty("BackgroundEnabled", "False")
bonewindow1:setPosition(0, 0)
bonewindow1:setSize(256, 358)
bonewindow1:setZOrderingEnabled(false)
bonewindow1:addController("boneAlphaEvent", "boneAlphaEvent", "alpha", "Sine_EaseInOut", 0, 255,   4, true, true, 10)
bonewindow1:addController("boneAlphaEvent", "boneAlphaEvent", "alpha", "Sine_EaseInOut", 255, 255, 3, true, true, 10)
bonewindow1:addController("boneAlphaEvent", "boneAlphaEvent", "alpha", "Sine_EaseInOut", 255, 0,   4, true, true, 10)
bonewindow1:activeMotion("boneAlphaEvent")
bonewindow:addChildWindow(bonewindow1)

tCharacterTexX = { ["protectErr"]=0, [0]=508, 569, 630, 691, 752, 813 }
tCharacterPosX = { ["protectErr"]=0, [0]=15, 97, 179, 15, 97, 179 }
tCharacterPosY = { ["protectErr"]=0, [0]=35, 35, 35, 123, 123, 123 }
tCharacterInfoTexX = { ["protectErr"]=0, [0]=0, 0, 0, 256, 256, 256 }
tCharacterInfoTexY = { ["protectErr"]=0, [0]=0, 100, 200, 0, 100, 200 }
tCharacterInfoPosX = { ["protectErr"]=0, [0]=532, 532, 532, 770, 770, 770 }
tCharacterInfoPosY = { ["protectErr"]=0, [0]=72, 142, 212, 72, 142, 212 }
local reverseCreate = {["err"]=0, [0]=5,4,3,2,1,0}
for index=0, #tCharacterTexX do
	-- 케릭터 얼굴 이미지	
	local i = reverseCreate[index]
	characterWindow = winMgr:createWindow("TaharezLook/RadioButton", i.."sj_creaetcharacter_characterIndex")
	characterWindow:setTexture("Normal", "UIData/channel_001.tga", tCharacterTexX[i], 0)
	characterWindow:setTexture("Hover", "UIData/channel_001.tga", tCharacterTexX[i], 84)
	characterWindow:setTexture("Pushed", "UIData/channel_001.tga", tCharacterTexX[i], 168)
	characterWindow:setTexture("PushedOff", "UIData/channel_001.tga", tCharacterTexX[i], 168)
	characterWindow:setTexture("SelectedNormal", "UIData/channel_001.tga", tCharacterTexX[i], 168)
	characterWindow:setTexture("SelectedHover", "UIData/channel_001.tga", tCharacterTexX[i], 168)
	characterWindow:setTexture("SelectedPushed", "UIData/channel_001.tga", tCharacterTexX[i], 168)
	characterWindow:setTexture("SelectedPushedOff", "UIData/channel_001.tga", tCharacterTexX[i], 168)
	characterWindow:setPosition(tCharacterPosX[i], tCharacterPosY[i])
	characterWindow:setSize(61, 84)
	characterWindow:setProperty("GroupID", 1600)
	characterWindow:setZOrderingEnabled(false)
	characterWindow:subscribeEvent("MouseEnter", "OnMouseEnter_character")
	characterWindow:subscribeEvent("MouseLeave", "OnMouseLeave_character")
	characterWindow:setUserString("characterNumber", i)
	characterWindow:subscribeEvent("SelectStateChanged", "ChagnedSelectCharacter")
	bonewindow:addChildWindow(characterWindow)
end

infowindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_creaetcharacter_infoWindow")
infowindow:setTexture("Enabled", "UIData/Character_002.tga", 0, 0)
infowindow:setTexture("Disabled", "UIData/Character_002.tga", 0, 0)
infowindow:setProperty("FrameEnabled", "False")
infowindow:setProperty("BackgroundEnabled", "False")
infowindow:setPosition(0, 220)
infowindow:setSize(256, 100)
infowindow:setZOrderingEnabled(false)
bonewindow:addChildWindow(infowindow)

-- 케릭터를 변경할 경우
function ChagnedSelectCharacter(args)
	local local_window = CEGUI.toWindowEventArgs(args).window
	if CEGUI.toRadioButton(local_window):isSelected() == true then
		local characterBone = local_window:getUserString("characterNumber")
		ChangedCharacter(tonumber(characterBone))
	end
end

function SelectedCharacter(bone)
	local local_window = winMgr:getWindow(bone.."sj_creaetcharacter_characterIndex")
	CEGUI.toRadioButton(local_window):setSelected(true)
end


function OnMouseEnter_character(args)
	local window = CEGUI.toWindowEventArgs(args).window
	if window:isVisible() then
		local szCharacterNumber = window:getUserString("characterNumber")
		if szCharacterNumber ~= "" then
			local i = tonumber(szCharacterNumber)
			winMgr:getWindow("sj_creaetcharacter_infoWindow"):setTexture("Enabled", "UIData/Character_002.tga", tCharacterInfoTexX[i], tCharacterInfoTexY[i])
		end
	end
end


function OnMouseLeave_character(args)
	for i=0, #tCharacterTexX do
		local local_window = winMgr:getWindow(i.."sj_creaetcharacter_characterIndex")
		if CEGUI.toRadioButton(local_window):isSelected() == true then
			winMgr:getWindow("sj_creaetcharacter_infoWindow"):setTexture("Enabled", "UIData/Character_002.tga", tCharacterInfoTexX[i], tCharacterInfoTexY[i])
		end
	end
end

-- 캐릭터 본 선택 OK버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_creaetcharacter_boneOKBtn")
mywindow:setTexture("Normal", "UIData/character_001.tga", 256, 628)
mywindow:setTexture("Hover", "UIData/character_001.tga", 256, 655)
mywindow:setTexture("Pushed", "UIData/character_001.tga", 256, 682)
mywindow:setTexture("PushedOff", "UIData/character_001.tga", 256, 628)
mywindow:setTexture("Enabled", "UIData/character_001.tga", 256, 628)
mywindow:setTexture("Disabled", "UIData/character_001.tga", 256, 709)
mywindow:setPosition(83, 314)
mywindow:setSize(90, 27)
mywindow:subscribeEvent("Clicked", "ClickedBoneOK")
bonewindow:addChildWindow(mywindow)

function ClickedBoneOK(args)
	winMgr:getWindow("sj_creaetcharacter_boneOKBtn"):setVisible(false)
	winMgr:getWindow("sj_creaetcharacter_bone1backWindow"):setVisible(false)
	winMgr:getWindow("sj_creaetcharacter_bone1backWindow"):clearControllerEvent("boneAlphaEvent")
	winMgr:getWindow("sj_creaetcharacter_bone1backWindow"):clearActiveController()

	winMgr:getWindow("sj_creaetcharacter_colorbackWindow"):setVisible(true)
	winMgr:getWindow("sj_creaetcharacter_color1backWindow"):activeMotion("colorAlphaEvent")
end



--------------------------------------------------------------------

-- 색상 설정

--------------------------------------------------------------------
colorwindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_creaetcharacter_colorbackWindow")
colorwindow:setTexture("Enabled", "UIData/character_001.tga", 256, 0)
colorwindow:setTexture("Disabled", "UIData/character_001.tga", 256, 0)
colorwindow:setProperty("FrameEnabled", "False")
colorwindow:setProperty("BackgroundEnabled", "False")
colorwindow:setPosition(30, 420)
colorwindow:setSize(256, 314)
colorwindow:setZOrderingEnabled(false)
colorwindow:setVisible(false)
root:addChildWindow(colorwindow)

color1window = winMgr:createWindow("TaharezLook/StaticImage", "sj_creaetcharacter_color1backWindow")
color1window:setTexture("Enabled", "UIData/character_001.tga", 256, 314)
color1window:setTexture("Disabled", "UIData/character_001.tga", 256, 314)
color1window:setProperty("FrameEnabled", "False")
color1window:setProperty("BackgroundEnabled", "False")
color1window:setPosition(0, 0)
color1window:setSize(256, 314)
color1window:setZOrderingEnabled(false)
color1window:addController("colorAlphaEvent", "colorAlphaEvent", "alpha", "Sine_EaseInOut", 0, 255,  4, true, true, 10)
color1window:addController("colorAlphaEvent", "colorAlphaEvent", "alpha", "Sine_EaseInOut", 255, 255,3, true, true, 10)
color1window:addController("colorAlphaEvent", "colorAlphaEvent", "alpha", "Sine_EaseInOut", 255, 0,  4, true, true, 10)
colorwindow:addChildWindow(color1window)

tColorPosX = {["err"]=0, [0]=115, 155, 195}

-- 1. 헤어(갈색, 검은색, 금색)
tHairTexX = {["err"]=0, [0]=711, 682, 653}
local MAX_HAIR = 3
for i=0, MAX_HAIR-1 do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", i .. "sj_creaetcharacter_Hair")
	mywindow:setTexture("Normal", "UIData/channel_001.tga", tHairTexX[i], 336)
	mywindow:setTexture("Hover", "UIData/channel_001.tga", tHairTexX[i], 365)
	mywindow:setTexture("Pushed", "UIData/channel_001.tga", tHairTexX[i], 394)
	mywindow:setTexture("PushedOff", "UIData/channel_001.tga", tHairTexX[i], 394)
	mywindow:setTexture("SelectedNormal", "UIData/channel_001.tga", tHairTexX[i], 394)
	mywindow:setTexture("SelectedHover", "UIData/channel_001.tga", tHairTexX[i], 394)
	mywindow:setTexture("SelectedPushed", "UIData/channel_001.tga", tHairTexX[i], 394)
	mywindow:setTexture("SelectedPushedOff", "UIData/channel_001.tga", tHairTexX[i], 394)
	mywindow:setPosition(tColorPosX[i], 57)
	mywindow:setSize(29, 29)
	mywindow:setProperty("GroupID", 8700)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("HairIndex", i)
	mywindow:subscribeEvent("SelectStateChanged", "ChangedSelcetHair")
	colorwindow:addChildWindow(mywindow)
end

function ChangedSelcetHair(args)
	local local_window = CEGUI.toWindowEventArgs(args).window
	if CEGUI.toRadioButton(local_window):isSelected() == true then
		local HairIndex = local_window:getUserString("HairIndex")
		SetSelcetHair(tonumber(HairIndex))
	end
end

function SelectedHair(hair)
	local local_window = winMgr:getWindow(hair.."sj_creaetcharacter_Hair")
	CEGUI.toRadioButton(local_window):setSelected(true)
end


-- 2. 상의(하얀색, 검은색, 회색)
tUpperTexX = {["err"]=0, [0]=624, 682, 595}
local MAX_UPPER = 3
for i=0, MAX_UPPER-1 do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", i .. "sj_creaetcharacter_Upper")
	mywindow:setTexture("Normal", "UIData/channel_001.tga", tUpperTexX[i], 336)
	mywindow:setTexture("Hover", "UIData/channel_001.tga", tUpperTexX[i], 365)
	mywindow:setTexture("Pushed", "UIData/channel_001.tga", tUpperTexX[i], 394)
	mywindow:setTexture("PushedOff", "UIData/channel_001.tga", tUpperTexX[i], 394)
	mywindow:setTexture("SelectedNormal", "UIData/channel_001.tga", tUpperTexX[i], 394)
	mywindow:setTexture("SelectedHover", "UIData/channel_001.tga", tUpperTexX[i], 394)
	mywindow:setTexture("SelectedPushed", "UIData/channel_001.tga", tUpperTexX[i], 394)
	mywindow:setTexture("SelectedPushedOff", "UIData/channel_001.tga", tUpperTexX[i], 394)
	mywindow:setPosition(tColorPosX[i], 99)
	mywindow:setSize(29, 29)
	mywindow:setProperty("GroupID", 8701)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("UpperIndex", i)
	mywindow:subscribeEvent("SelectStateChanged", "ChangedSelcetUpper")
	colorwindow:addChildWindow(mywindow)
end

function ChangedSelcetUpper(args)
	local local_window = CEGUI.toWindowEventArgs(args).window
	if CEGUI.toRadioButton(local_window):isSelected() == true then
		local UpperIndex = local_window:getUserString("UpperIndex")
		SetSelcetUpper(tonumber(UpperIndex))
	end
end

function SelectedUpper(upper)
	local local_window = winMgr:getWindow(upper.."sj_creaetcharacter_Upper")
	CEGUI.toRadioButton(local_window):setSelected(true)
end


-- 3. 하의(곤색, 베이지색, 카키색)
tPantsTexX = {["err"]=0, [0]=740, 566, 537}
local MAX_PANTS = 3
for i=0, MAX_PANTS-1 do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", i .. "sj_creaetcharacter_Pants")
	mywindow:setTexture("Normal", "UIData/channel_001.tga", tPantsTexX[i], 336)
	mywindow:setTexture("Hover", "UIData/channel_001.tga", tPantsTexX[i], 365)
	mywindow:setTexture("Pushed", "UIData/channel_001.tga", tPantsTexX[i], 394)
	mywindow:setTexture("PushedOff", "UIData/channel_001.tga", tPantsTexX[i], 394)
	mywindow:setTexture("SelectedNormal", "UIData/channel_001.tga", tPantsTexX[i], 394)
	mywindow:setTexture("SelectedHover", "UIData/channel_001.tga", tPantsTexX[i], 394)
	mywindow:setTexture("SelectedPushed", "UIData/channel_001.tga", tPantsTexX[i], 394)
	mywindow:setTexture("SelectedPushedOff", "UIData/channel_001.tga", tPantsTexX[i], 394)
	mywindow:setPosition(tColorPosX[i], 141)
	mywindow:setSize(29, 29)
	mywindow:setProperty("GroupID", 8702)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("PantsIndex", i)
	mywindow:subscribeEvent("SelectStateChanged", "ChangedSelcetPants")
	colorwindow:addChildWindow(mywindow)
end

function ChangedSelcetPants(args)
	local local_window = CEGUI.toWindowEventArgs(args).window
	if CEGUI.toRadioButton(local_window):isSelected() == true then
		local PantsIndex = local_window:getUserString("PantsIndex")
		SetSelcetPants(tonumber(PantsIndex))
	end
end

function SelectedPants(pants)
	local local_window = winMgr:getWindow(pants.."sj_creaetcharacter_Pants")
	CEGUI.toRadioButton(local_window):setSelected(true)
end


-- 4. 신발(하얀색, 검은색, 곤색)
tShoesTexX = {["err"]=0, [0]=624, 682, 740}
local MAX_SHOES = 3
for i=0, MAX_SHOES-1 do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", i .. "sj_creaetcharacter_Shoes")
	mywindow:setTexture("Normal", "UIData/channel_001.tga", tShoesTexX[i], 336)
	mywindow:setTexture("Hover", "UIData/channel_001.tga", tShoesTexX[i], 365)
	mywindow:setTexture("Pushed", "UIData/channel_001.tga", tShoesTexX[i], 394)
	mywindow:setTexture("PushedOff", "UIData/channel_001.tga", tShoesTexX[i], 394)
	mywindow:setTexture("SelectedNormal", "UIData/channel_001.tga", tShoesTexX[i], 394)
	mywindow:setTexture("SelectedHover", "UIData/channel_001.tga", tShoesTexX[i], 394)
	mywindow:setTexture("SelectedPushed", "UIData/channel_001.tga", tShoesTexX[i], 394)
	mywindow:setTexture("SelectedPushedOff", "UIData/channel_001.tga", tShoesTexX[i], 394)
	mywindow:setPosition(tColorPosX[i], 184)
	mywindow:setSize(29, 29)
	mywindow:setProperty("GroupID", 8703)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("ShoesIndex", i)
	mywindow:subscribeEvent("SelectStateChanged", "ChangedSelcetShoes")
	colorwindow:addChildWindow(mywindow)
end

function ChangedSelcetShoes(args)
	local local_window = CEGUI.toWindowEventArgs(args).window
	if CEGUI.toRadioButton(local_window):isSelected() == true then
		local ShoesIndex = local_window:getUserString("ShoesIndex")
		SetSelcetShoes(tonumber(ShoesIndex))
	end
end

function SelectedShoes(shoes)
	local local_window = winMgr:getWindow(shoes.."sj_creaetcharacter_Shoes")
	CEGUI.toRadioButton(local_window):setSelected(true)
end


-- 5. 스킨(백인, 흑인)
tSkinTexX = {["err"]=0, [0]=566, 508}
local MAX_SKIN = 2
for i=0, MAX_SKIN-1 do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", i .. "sj_creaetcharacter_Skin")
	mywindow:setTexture("Normal", "UIData/channel_001.tga", tSkinTexX[i], 336)
	mywindow:setTexture("Hover", "UIData/channel_001.tga", tSkinTexX[i], 365)
	mywindow:setTexture("Pushed", "UIData/channel_001.tga", tSkinTexX[i], 394)
	mywindow:setTexture("PushedOff", "UIData/channel_001.tga", tSkinTexX[i], 394)
	mywindow:setTexture("SelectedNormal", "UIData/channel_001.tga", tSkinTexX[i], 394)
	mywindow:setTexture("SelectedHover", "UIData/channel_001.tga", tSkinTexX[i], 394)
	mywindow:setTexture("SelectedPushed", "UIData/channel_001.tga", tSkinTexX[i], 394)
	mywindow:setTexture("SelectedPushedOff", "UIData/channel_001.tga", tSkinTexX[i], 394)
	mywindow:setPosition(tColorPosX[i], 224)
	mywindow:setSize(29, 29)
	mywindow:setProperty("GroupID", 8704)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("SkinIndex", i)
	mywindow:subscribeEvent("SelectStateChanged", "ChangedSelcetSkin")
	colorwindow:addChildWindow(mywindow)
end

if CheckfacilityData(FACILITYCODE_BLACKSKIN) == 0 then
	winMgr:getWindow("1sj_creaetcharacter_Skin"):setVisible(false)
end

function ChangedSelcetSkin(args)
	local local_window = CEGUI.toWindowEventArgs(args).window
	if CEGUI.toRadioButton(local_window):isSelected() == true then
		local SkinIndex = local_window:getUserString("SkinIndex")
		SetSelcetSkin(tonumber(SkinIndex))
	end
end

function SelectedSkin(skin)
	local local_window = winMgr:getWindow(skin.."sj_creaetcharacter_Skin")
	CEGUI.toRadioButton(local_window):setSelected(true)
end


-- 캐릭터 칼라 선택 OK버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_creaetcharacter_colorOKBtn")
mywindow:setTexture("Normal", "UIData/character_001.tga", 256, 628)
mywindow:setTexture("Hover", "UIData/character_001.tga", 256, 655)
mywindow:setTexture("Pushed", "UIData/character_001.tga", 256, 682)
mywindow:setTexture("PushedOff", "UIData/character_001.tga", 256, 628)
mywindow:setTexture("Enabled", "UIData/character_001.tga", 256, 628)
mywindow:setTexture("Disabled", "UIData/character_001.tga", 256, 709)
mywindow:setPosition(83, 270)
mywindow:setSize(90, 27)
mywindow:subscribeEvent("Clicked", "ClickedColorOK")
colorwindow:addChildWindow(mywindow)

function ClickedColorOK(args)
	winMgr:getWindow("sj_creaetcharacter_colorOKBtn"):setVisible(false)
	winMgr:getWindow("sj_creaetcharacter_color1backWindow"):setVisible(false)
	winMgr:getWindow("sj_creaetcharacter_color1backWindow"):clearControllerEvent("colorAlphaEvent")
	winMgr:getWindow("sj_creaetcharacter_color1backWindow"):clearActiveController()

	winMgr:getWindow("sj_creaetcharacter_classbackWindow"):setVisible(true)
	winMgr:getWindow("sj_creaetcharacter_class1backWindow"):activeMotion("classAlphaEvent")
end





--------------------------------------------------------------------

-- 스트리트, 러쉬 선택 라디오 버튼

--------------------------------------------------------------------
classwindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_creaetcharacter_classbackWindow")
classwindow:setTexture("Enabled", "UIData/character_001.tga", 512, 0)
classwindow:setTexture("Disabled", "UIData/character_001.tga", 512, 0)
classwindow:setProperty("FrameEnabled", "False")
classwindow:setProperty("BackgroundEnabled", "False")
classwindow:setWideType(1);
classwindow:setPosition(740, 60)
classwindow:setSize(256, 679)
classwindow:setZOrderingEnabled(false)
classwindow:setVisible(false)
root:addChildWindow(classwindow)

class1window = winMgr:createWindow("TaharezLook/StaticImage", "sj_creaetcharacter_class1backWindow")
class1window:setTexture("Enabled", "UIData/character_001.tga", 768, 0)
class1window:setTexture("Disabled", "UIData/character_001.tga", 768, 0)
class1window:setProperty("FrameEnabled", "False")
class1window:setProperty("BackgroundEnabled", "False")
class1window:setPosition(0, 0)
class1window:setSize(256, 679)
class1window:setZOrderingEnabled(false)
class1window:addController("classAlphaEvent", "classAlphaEvent", "alpha", "Sine_EaseInOut", 0, 255,   4, true, true, 10)
class1window:addController("classAlphaEvent", "classAlphaEvent", "alpha", "Sine_EaseInOut", 255, 255, 3, true, true, 10)
class1window:addController("classAlphaEvent", "classAlphaEvent", "alpha", "Sine_EaseInOut", 255, 0,   4, true, true, 10)
classwindow:addChildWindow(class1window)

tCharacterStyleTexY = { ["protectErr"]=0, [0]=0, 156 }
tCharacterStylePosX = { ["protectErr"]=0, [0]=12, 130 }
for i=0, #tCharacterStyleTexY do
	styleWindow = winMgr:createWindow("TaharezLook/RadioButton", i .. "sj_creaetcharacter_characterStyle")
	styleWindow:setTexture("Normal", "UIData/channel_001.tga", 874, tCharacterStyleTexY[i])
	styleWindow:setTexture("Hover", "UIData/channel_001.tga", 874, tCharacterStyleTexY[i]+39)
	styleWindow:setTexture("Pushed", "UIData/channel_001.tga", 874, tCharacterStyleTexY[i]+78)
	styleWindow:setTexture("PushedOff", "UIData/channel_001.tga", 874, tCharacterStyleTexY[i]+78)
	styleWindow:setTexture("SelectedNormal", "UIData/channel_001.tga", 874, tCharacterStyleTexY[i]+78)
	styleWindow:setTexture("SelectedHover", "UIData/channel_001.tga", 874, tCharacterStyleTexY[i]+78)
	styleWindow:setTexture("SelectedPushed", "UIData/channel_001.tga", 874, tCharacterStyleTexY[i]+78)
	styleWindow:setTexture("SelectedPushedOff", "UIData/channel_001.tga", 874, tCharacterStyleTexY[i]+78)
	styleWindow:setPosition(tCharacterStylePosX[i], 40)
	styleWindow:setSize(114, 39)
	styleWindow:setProperty("GroupID", 1601)
	styleWindow:setZOrderingEnabled(false)
	styleWindow:setUserString("characterStyle", i)
	styleWindow:subscribeEvent("SelectStateChanged", "ChangedSelcetStyle")
	styleWindow:subscribeEvent("MouseEnter", "OnMouseEnter_style")
	styleWindow:subscribeEvent("MouseLeave", "OnMouseLeave_style")
	classwindow:addChildWindow(styleWindow)

end

tCharacterStyleInfoTexX = { ["protectErr"]=0, [0]=0, 256 }
styleinfowindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_creaetcharacter_styleInfoWindow")
styleinfowindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
styleinfowindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
styleinfowindow:setProperty("FrameEnabled", "False")
styleinfowindow:setProperty("BackgroundEnabled", "False")
styleinfowindow:setPosition(0, 80)
styleinfowindow:setSize(256, 100)
styleinfowindow:setZOrderingEnabled(false)
classwindow:addChildWindow(styleinfowindow)

tCharacterStyle1InfoTexX = { ["protectErr"]=0, [0]=768, 512 }
styleinfowindow1 = winMgr:createWindow("TaharezLook/StaticImage", "sj_creaetcharacter_style1InfoWindow")
styleinfowindow1:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
styleinfowindow1:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
styleinfowindow1:setProperty("FrameEnabled", "False")
styleinfowindow1:setProperty("BackgroundEnabled", "False")
styleinfowindow1:setPosition(0, 200)
styleinfowindow1:setSize(256, 237)
styleinfowindow1:setZOrderingEnabled(false)
classwindow:addChildWindow(styleinfowindow1)


-- 스타일은 변경할 경우(다음으로 넘어가는 버튼생김)
function ChangedSelcetStyle(args)
	local local_window = CEGUI.toWindowEventArgs(args).window
	if CEGUI.toRadioButton(local_window):isSelected() == true then
	
		if winMgr:getWindow("sj_creaetcharacter_namebackWindow"):isVisible() == false then
			winMgr:getWindow("sj_creaetcharacter_classOKBtn"):setVisible(true)
		end
		
		local characterStyle = local_window:getUserString("characterStyle")
		SetStyleIndex(tonumber(characterStyle))
	end
end

function SelectedStyle(style)
	if style >= 0 then
		local local_window = winMgr:getWindow(style.."sj_creaetcharacter_characterStyle")
		CEGUI.toRadioButton(local_window):setSelected(true)
	end
end


function OnMouseEnter_style(args)
	local window = CEGUI.toWindowEventArgs(args).window
	if window:isVisible() then
		local szCharacterStyle = window:getUserString("characterStyle")
		if szCharacterStyle ~= "" then
			local i = tonumber(szCharacterStyle)
			winMgr:getWindow("sj_creaetcharacter_styleInfoWindow"):setVisible(true)
			winMgr:getWindow("sj_creaetcharacter_styleInfoWindow"):setTexture("Enabled", "UIData/Character_002.tga", tCharacterStyleInfoTexX[i], 300)
			
			winMgr:getWindow("sj_creaetcharacter_style1InfoWindow"):setVisible(true)
			winMgr:getWindow("sj_creaetcharacter_style1InfoWindow"):setTexture("Enabled", "UIData/Character_001.tga", tCharacterStyle1InfoTexX[i], 679)
		end
	end
end


function OnMouseLeave_style(args)
	winMgr:getWindow("sj_creaetcharacter_styleInfoWindow"):setVisible(false)
	winMgr:getWindow("sj_creaetcharacter_style1InfoWindow"):setVisible(false)
	for i=0, #tCharacterStyleTexY do
		local local_window = winMgr:getWindow(i.."sj_creaetcharacter_characterStyle")
		if CEGUI.toRadioButton(local_window):isSelected() == true then
			winMgr:getWindow("sj_creaetcharacter_styleInfoWindow"):setVisible(true)
			winMgr:getWindow("sj_creaetcharacter_styleInfoWindow"):setTexture("Enabled", "UIData/Character_002.tga", tCharacterStyleInfoTexX[i], 300)
			
			winMgr:getWindow("sj_creaetcharacter_style1InfoWindow"):setVisible(true)
			winMgr:getWindow("sj_creaetcharacter_style1InfoWindow"):setTexture("Enabled", "UIData/Character_001.tga", tCharacterStyle1InfoTexX[i], 679)
		end
	end
end

-- 캐릭터 클래스 선택 OK버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_creaetcharacter_classOKBtn")
mywindow:setTexture("Normal", "UIData/character_001.tga", 256, 628)
mywindow:setTexture("Hover", "UIData/character_001.tga", 256, 655)
mywindow:setTexture("Pushed", "UIData/character_001.tga", 256, 682)
mywindow:setTexture("PushedOff", "UIData/character_001.tga", 256, 628)
mywindow:setTexture("Enabled", "UIData/character_001.tga", 256, 628)
mywindow:setTexture("Disabled", "UIData/character_001.tga", 256, 709)
mywindow:setPosition(83, 630)
mywindow:setSize(90, 27)
mywindow:setVisible(false)
mywindow:subscribeEvent("Clicked", "ClickedClassOK")
classwindow:addChildWindow(mywindow)

function ClickedClassOK(args)
	winMgr:getWindow("sj_creaetcharacter_classOKBtn"):setVisible(false)
	winMgr:getWindow("sj_creaetcharacter_class1backWindow"):setVisible(false)
	winMgr:getWindow("sj_creaetcharacter_class1backWindow"):clearControllerEvent("colorAlphaEvent")
	winMgr:getWindow("sj_creaetcharacter_class1backWindow"):clearActiveController()

	winMgr:getWindow("sj_creaetcharacter_decisionBtn"):setVisible(true)
	winMgr:getWindow("sj_creaetcharacter_namebackWindow"):setVisible(true)
	winMgr:getWindow("sj_creaetcharacter_name1backWindow"):activeMotion("nameAlphaEvent")
end




--------------------------------------------------------------------

-- 에러 메세지 창
-- 아이디 입력하지 않았을때 에러 메세지, 케릭터 생성시 에러 메세지

--------------------------------------------------------------------
-- 이름이 없을 경우 호출
function ErrorMessage_EmptyID(error)

	ShowNotifyOKMessage_Lua(error, 8, 5, 50, 116)
	winMgr:getWindow("IDEditbox"):setText("")
	winMgr:getWindow("IDEditbox"):activate()
	
end


-- 케릭터 생성이 실패할 경우(C에서 호출)
function ErrorMessage_CreateCharacterFailed(failedMessage, flag)

	ShowNotifyOKMessage_Lua(failedMessage)
	if flag == 0 then
		winMgr:getWindow("IDEditbox"):setText("")
		winMgr:getWindow("IDEditbox"):activate()
	end
	
end



--------------------------------------------------------------------

-- 결정 버튼

--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_creaetcharacter_decisionBtn")
mywindow:setTexture("Normal", "UIData/channel_001.tga", 874, 312)
mywindow:setTexture("Hover", "UIData/channel_001.tga", 874, 348)
mywindow:setTexture("Pushed", "UIData/channel_001.tga", 874, 384)
mywindow:setTexture("PushedOff", "UIData/channel_001.tga", 874, 384)
mywindow:setWideType(6)
mywindow:setPosition(447, 700)
mywindow:setSize(130, 36)
mywindow:setVisible(false)
mywindow:subscribeEvent("Clicked", "CreationButtonClick")
root:addChildWindow(mywindow)

function CreationButtonClick()
	local name = winMgr:getWindow("IDEditbox"):getText()
	local len  = string.len(name)
	
	if len > 0 and len <= 12 then
		Creation(name)
	elseif len <= 0 then
		ErrorMessage_EmptyID(g_STRING_INPUT_ID)
	elseif len > 13 then
		ErrorMessage_EmptyID(g_STRING_ERROR_ID)
	end
	
	CutSceneCharacterName  = name 
end

function EndCutSceneCreate()
	EndCutScene()
	return
end


--------------------------------------------------------------------

-- 돌아가기

--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_creaetcharacter_cancelBtn")
mywindow:setTexture("Normal", "UIData/channel_001.tga", 936, 676)
mywindow:setTexture("Hover", "UIData/channel_001.tga", 936, 701)
mywindow:setTexture("Pushed", "UIData/channel_001.tga", 936, 726)
mywindow:setTexture("PushedOff", "UIData/channel_001.tga", 936, 676)
mywindow:setWideType(2);
mywindow:setPosition(10, 740)
mywindow:setSize(88, 25)
mywindow:subscribeEvent("Clicked", "WndCreateCharacter_GotoWndSelectChannel")
root:addChildWindow(mywindow)


function WndCreateCharacter_Restoration()
	Restoration()
	ChangeGauge()
end








--------------------------------------------------------------------

-- EditBox Window

--------------------------------------------------------------------
namewindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_creaetcharacter_namebackWindow")
namewindow:setTexture("Enabled", "UIData/character_001.tga", 1, 717)
namewindow:setTexture("Disabled", "UIData/character_001.tga", 1, 717)
namewindow:setProperty("FrameEnabled", "False")
namewindow:setProperty("BackgroundEnabled", "False")
namewindow:setWideType(6)
namewindow:setPosition(384, 618)
namewindow:setSize(256, 80)
namewindow:setZOrderingEnabled(false)
namewindow:setVisible(false)
root:addChildWindow(namewindow)

name1window = winMgr:createWindow("TaharezLook/StaticImage", "sj_creaetcharacter_name1backWindow")
name1window:setTexture("Enabled", "UIData/character_001.tga", 1, 796)
name1window:setTexture("Disabled", "UIData/character_001.tga", 1, 796)
name1window:setProperty("FrameEnabled", "False")
name1window:setProperty("BackgroundEnabled", "False")
name1window:setPosition(0, -1)
name1window:setSize(256, 80)
name1window:setZOrderingEnabled(false)
name1window:addController("nameAlphaEvent", "nameAlphaEvent", "alpha", "Sine_EaseInOut", 0, 255,   4, true, true, 10)
name1window:addController("nameAlphaEvent", "nameAlphaEvent", "alpha", "Sine_EaseInOut", 255, 255, 3, true, true, 10)
name1window:addController("nameAlphaEvent", "nameAlphaEvent", "alpha", "Sine_EaseInOut", 255, 0,   4, true, true, 10)
namewindow:addChildWindow(name1window)


-- 아이디 입력 에디트박스
mywindow = winMgr:createWindow("TaharezLook/Editbox", "IDEditbox")
mywindow:setPosition(24, 22)
mywindow:setSize(210, 32)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 20)
mywindow:activate()
namewindow:addChildWindow(mywindow)
CEGUI.toEditbox(winMgr:getWindow("IDEditbox")):setMaxTextLength(12)


--------------------------------------------------------------------
-- 컷신 시작버튼 (연습용)
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "Start_CutBtn")
mywindow:setTexture("Normal", "UIData/channel_001.tga", 936, 676)
mywindow:setTexture("Hover", "UIData/channel_001.tga", 936, 701)
mywindow:setTexture("Pushed", "UIData/channel_001.tga", 936, 726)
mywindow:setTexture("PushedOff", "UIData/channel_001.tga", 936, 676)
mywindow:setWideType(2);
mywindow:setPosition(10, 700)
mywindow:setSize(88, 25)
mywindow:setAlwaysOnTop(true)
mywindow:setVisible(false)
mywindow:subscribeEvent("Clicked", "StartCut")
root:addChildWindow(mywindow)

function StartCut()
	HideCreateCharacterUI()
	StartCutScene()
	winMgr:getWindow("cut_scene_text"):setText(CutSceneCharacterName)
end

function HideCreateCharacterUI()
	winMgr:getWindow("sj_creaetcharacter_classbackWindow"):setVisible(false)
	winMgr:getWindow("sj_creaetcharacter_class1backWindow"):setVisible(false)
	winMgr:getWindow("sj_creaetcharacter_decisionBtn"):setVisible(false)
	winMgr:getWindow("sj_creaetcharacter_cancelBtn"):setVisible(false)
	winMgr:getWindow("sj_creaetcharacter_namebackWindow"):setVisible(false)
	winMgr:getWindow("sj_creaetcharacter_bonebackWindow"):setVisible(false)
	winMgr:getWindow("sj_creaetcharacter_colorbackWindow"):setVisible(false)
end

startCutSceneText = false 

function RenderCutSceneText(time)

	drawer:setFont(g_STRING_FONT_GULIMCHE, 28)
	if time > 30 and time < 60 then
		local nameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 28, CutSceneCharacterName)
		drawer:setTextColor(255,234,0,255)	
		drawer:drawText(CutSceneCharacterName, 530-nameSize, 310, WIDETYPE_6)
		drawer:setTextColor(235,235,235,255)	
		drawer:drawText("FFC24 출전", 540, 310, WIDETYPE_6)
		
	end
	
	if time > 150 then
		if startCutSceneText == false then
			ActiveCutSceneText()
		end
	end
	--[[
	if time > 440 then
		--drawer:drawTextureA("UIData/black.tga", 0, 0, 1920, 1200, 0, 0, (time-200))-- 오른쪽 아래
	end
	--]]
end


--------------------------------------------------------------------
-- 컷신배경
--------------------------------------------------------------------
cutbackwindow = winMgr:createWindow("TaharezLook/StaticImage", "cut_scene_back_image")
cutbackwindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
cutbackwindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
cutbackwindow:setProperty("FrameEnabled", "False")
cutbackwindow:setProperty("BackgroundEnabled", "False")
cutbackwindow:setWideType(2)
cutbackwindow:setPosition(0, 650)
cutbackwindow:setSize(200, 60)
cutbackwindow:addController("CutSceneeffectAlpha", "CutSceneeffectAlpha", "alpha", "Sine_EaseInOut", 255, 255, 30, true, false, 10)
cutbackwindow:subscribeEvent("MotionEventEnd", "EndCutSceneEffect")
cutbackwindow:setVisible(false)
cutbackwindow:setZOrderingEnabled(false)
root:addChildWindow(cutbackwindow)

--------------------------------------------------------------------
-- 컷신배경2
--------------------------------------------------------------------
cutbackwindow = winMgr:createWindow("TaharezLook/StaticImage", "cut_scene_back_image2")
cutbackwindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
cutbackwindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
cutbackwindow:setProperty("FrameEnabled", "False")
cutbackwindow:setProperty("BackgroundEnabled", "False")
cutbackwindow:setWideType(4)
cutbackwindow:setPosition(768, 650)
cutbackwindow:setSize(200, 60)
cutbackwindow:addController("CutSceneeffectAlpha2", "CutSceneeffectAlpha2", "alpha", "Sine_EaseInOut", 255, 255, 30, true, false, 10)
cutbackwindow:setVisible(false)
cutbackwindow:setZOrderingEnabled(false)
root:addChildWindow(cutbackwindow)

--------------------------------------------------------------------
-- 컷신 텍스트 배경1
--------------------------------------------------------------------
cutbackwindow = winMgr:createWindow("TaharezLook/StaticImage", "cut_scene_text_image")
cutbackwindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
cutbackwindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
cutbackwindow:setProperty("FrameEnabled", "False")
cutbackwindow:setProperty("BackgroundEnabled", "False")
cutbackwindow:setPosition(-100, 0)
cutbackwindow:setSize(200, 60)
cutbackwindow:addController("CutSceneeffect", "CutSceneeffect", "x", "Quintic_EaseIn", -100, 200 , 5, true, false, 10)
cutbackwindow:setZOrderingEnabled(false)
winMgr:getWindow("cut_scene_back_image"):addChildWindow(cutbackwindow)

--------------------------------------------------------------------
-- 컷신 텍스트 배경2
--------------------------------------------------------------------
cutbackwindow = winMgr:createWindow("TaharezLook/StaticImage", "cut_scene_text_image2")
cutbackwindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
cutbackwindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
cutbackwindow:setProperty("FrameEnabled", "False")
cutbackwindow:setProperty("BackgroundEnabled", "False")
cutbackwindow:setPosition(200, 0)
cutbackwindow:setSize(200, 60)
cutbackwindow:addController("CutSceneeffect2", "CutSceneeffect2", "x", "Quintic_EaseIn", 200, -100 , 5, true, false, 10)
cutbackwindow:setZOrderingEnabled(false)
winMgr:getWindow("cut_scene_back_image2"):addChildWindow(cutbackwindow)

--[[
--------------------------------------------------------------------
-- 컷신 텍스트 배경3
--------------------------------------------------------------------
cutbackwindow = winMgr:createWindow("TaharezLook/StaticImage", "cut_scene_text_image3")
cutbackwindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
cutbackwindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
cutbackwindow:setProperty("FrameEnabled", "False")
cutbackwindow:setProperty("BackgroundEnabled", "False")
cutbackwindow:setPosition(500, 500)
cutbackwindow:setSize(200, 60)
cutbackwindow:setZOrderingEnabled(false)
root:addChildWindow(cutbackwindow)
--]]

function EndCutSceneEffect()
	winMgr:getWindow("cut_scene_back_image"):setVisible(false)
	winMgr:getWindow("cut_scene_back_image2"):setVisible(false)
end

mywindow = winMgr:createWindow("TaharezLook/StaticText", "cut_scene_text")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setFont(g_STRING_FONT_GULIMCHE, 28)
mywindow:setTextColor(255,255,255,255)
mywindow:setEnabled(false)
mywindow:setPosition(0, 0)
mywindow:setSize(220, 10)
mywindow:setText("CharacterName")
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("cut_scene_text_image"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticText", "cut_scene_text2")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255, 255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 28)
mywindow:setEnabled(false)
mywindow:setPosition(0, 0)
mywindow:setSize(220, 10)
mywindow:setText("스컹크 머핀")
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("cut_scene_text_image2"):addChildWindow(mywindow)

--[[
mywindow = winMgr:createWindow("TaharezLook/StaticText", "cut_scene_text3")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255, 255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 28)
mywindow:setEnabled(false)
mywindow:setPosition(0, 0)
mywindow:setSize(220, 10)
mywindow:setText("FFC24 출전")
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("cut_scene_text_image3"):addChildWindow(mywindow)
--]]



function ActiveCutSceneText()
	DebugStr('ActiveCutSceneText()')
	startCutSceneText = true
	winMgr:getWindow("cut_scene_back_image"):setVisible(true)
	winMgr:getWindow("cut_scene_back_image2"):setVisible(true)
	winMgr:getWindow("cut_scene_back_image"):activeMotion("CutSceneeffectAlpha")
	winMgr:getWindow("cut_scene_text_image"):activeMotion("CutSceneeffect")
	winMgr:getWindow("cut_scene_text_image2"):activeMotion("CutSceneeffect2")
end


end


