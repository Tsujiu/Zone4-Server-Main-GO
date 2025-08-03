function WndCreateCharacter_WndCreateCharacter()


-----------------------------------------
-- Script Entry Point
-----------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)


local g_STRING_INPUT_ID	= GetSStringInfo(LAN_LUA_CREATE_CHARACTER_1)	-- 캐릭터 이름을 입력해주세요!\n(한글: 2 ~ 6자, 영문: 4 ~ 12자)
local g_STRING_ERROR_ID	= GetSStringInfo(LAN_LUA_CREATE_CHARACTER_2)	-- 캐릭터 이름이 너무 깁니다!

local CutSceneCharacterName = ""

local selected_skill = 0
local TEST_MAS_MODE = false

--------------------------------------------------------------------

-- drawTexture(StartRender:시작시에 그리기)

--------------------------------------------------------------------
function WndCharMake_RenderBackImage()
	--drawer:drawTexture("UIData/channel_002.tga", 0, 0, 1024, 69, 0, 936, WIDETYPE_5)		-- 윗쪽 바
	--drawer:drawTexture("UIData/channel_002.tga", 355, 0, 314, 45, 493, 846, WIDETYPE_5)		-- Create Character
	
	drawer:drawTexture("UIData/CreateCharacter.tga", 342, 27, 340, 78, 0, 0, WIDETYPE_5)		-- Create Character
end



--------------------------------------------------------------------

-- 케릭터 선택 라디오 버튼 2

--------------------------------------------------------------------
alphaCharacterwindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_creaetcharacter_CharacterbackWindow_Alpha")
alphaCharacterwindow:setTexture("Enabled",  "UIData/invisible.tga", 0, 0)
alphaCharacterwindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
--alphaCharacterwindow:setTexture("Enabled",	"UIData/caretOn.tga",0,0)
--alphaCharacterwindow:setTexture("Disabled", "UIData/caretOn.tga",0,0)
alphaCharacterwindow:setProperty("FrameEnabled",	 "False")
alphaCharacterwindow:setProperty("BackgroundEnabled","False")
alphaCharacterwindow:setWideType(9010);--1
alphaCharacterwindow:setPosition(720, 126)
alphaCharacterwindow:setSize(274, 521)
alphaCharacterwindow:setZOrderingEnabled(false)
alphaCharacterwindow:setVisible(false)
alphaCharacterwindow:subscribeEvent("Shown", "OnShown_CharacterbackWindow_Alpha")
root:addChildWindow(alphaCharacterwindow)

function OnShown_CharacterbackWindow_Alpha(args)
	local bone = 0 -- 첫번째 캐릭터 버튼을 선택하기 위해
	winMgr:getWindow(bone.."sj_creaetcharacter_characterIndex"):setProperty("Selected", "true")
end

bonewindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_creaetcharacter_bonebackWindow")
--bonewindow:setTexture("Enabled",	"UIData/CreateCharacter.tga", 0, 0)
--bonewindow:setTexture("Disabled",	"UIData/CreateCharacter.tga", 0, 0)
bonewindow:setTexture("Enabled",	"UIData/frame/frame_001.tga", 0 , 0)
bonewindow:setTexture("Disabled",	"UIData/frame/frame_001.tga", 0 , 0)
bonewindow:setframeWindow(true)
bonewindow:setProperty("FrameEnabled", "False")
bonewindow:setProperty("BackgroundEnabled", "False")
--bonewindow:setPosition(30, 60)
--bonewindow:setPosition(740, 60)
bonewindow:setPosition(0, 0)
bonewindow:setSize(274, 485)
bonewindow:setZOrderingEnabled(false)
alphaCharacterwindow:addChildWindow(bonewindow)

--[[
bonewindow1 = winMgr:createWindow("TaharezLook/StaticImage", "sj_creaetcharacter_bone1backWindow")
--bonewindow1:setTexture("Enabled", "UIData/character_001.tga", 0, 358)
--bonewindow1:setTexture("Disabled", "UIData/character_001.tga", 0, 358)
bonewindow1:setTexture("Enabled",	"UIData/frame/frame_001.tga", 0 , 0)
bonewindow1:setTexture("Disabled",	"UIData/frame/frame_001.tga", 0 , 0)
bonewindow1:setframeWindow(true)
bonewindow1:setProperty("FrameEnabled", "False")
bonewindow1:setProperty("BackgroundEnabled", "False")
bonewindow1:setPosition(0, 0)
bonewindow1:setSize(274, 485)
--bonewindow1:setSize(256, 358)
bonewindow1:setZOrderingEnabled(false)
--]]
--[[
bonewindow1:addController("boneAlphaEvent", "boneAlphaEvent", "alpha", "Sine_EaseInOut", 0, 255,   4, true, true, 10)
bonewindow1:addController("boneAlphaEvent", "boneAlphaEvent", "alpha", "Sine_EaseInOut", 255, 255, 3, true, true, 10)
bonewindow1:addController("boneAlphaEvent", "boneAlphaEvent", "alpha", "Sine_EaseInOut", 255, 0,   4, true, true, 10)
bonewindow1:activeMotion("boneAlphaEvent")
--]]
--bonewindow:addChildWindow(bonewindow1)

-- 캐릭터 셀렉트 탑 이미지
characterSelectImage = winMgr:createWindow("TaharezLook/StaticImage", "sj_creaetcharacter_SelectCharacter_Top")
characterSelectImage:setTexture("Enabled", "UIData/CreateCharacter.tga", 260, 78)
characterSelectImage:setTexture("Disabled", "UIData/CreateCharacter.tga", 260, 78)
characterSelectImage:setProperty("FrameEnabled", "False")
characterSelectImage:setProperty("BackgroundEnabled", "False")
characterSelectImage:setPosition(7, 15)
characterSelectImage:setSize(260, 43)
characterSelectImage:setZOrderingEnabled(false)
bonewindow:addChildWindow(characterSelectImage)

-- 캐릭터 선택 아이콘( 얼굴 ) Character Selected Icon face
tCharacterTexX = { ["protectErr"]=0, [0]=520, 596, 672, 748, 824, 900 }
tCharacterPosX = { ["protectErr"]=0, [0]=19, 99, 179, 19, 99, 179 }
tCharacterPosY = { ["protectErr"]=0, [0]=63, 63, 63, 140, 140, 140 }

--[[
tCharacterInfoTexX = { ["protectErr"]=0, [0]=0, 0, 0, 256, 256, 256 }
tCharacterInfoTexY = { ["protectErr"]=0, [0]=0, 100, 200, 0, 100, 200 }
tCharacterInfoPosX = { ["protectErr"]=0, [0]=532, 532, 532, 770, 770, 770 }
tCharacterInfoPosY = { ["protectErr"]=0, [0]=72, 142, 212, 72, 142, 212 }
--]]

local reverseCreate = {["err"]=0, [0]=5,4,3,2,1,0}
for index=0, #tCharacterTexX do
	-- 케릭터 얼굴 이미지	
	local i = reverseCreate[index]
	characterWindow = winMgr:createWindow("TaharezLook/RadioButton", i.."sj_creaetcharacter_characterIndex")
	characterWindow:setTexture("Normal",			"UIData/CreateCharacter.tga", tCharacterTexX[i], 0)
	characterWindow:setTexture("Hover",				"UIData/CreateCharacter.tga", tCharacterTexX[i], 76)
	characterWindow:setTexture("Pushed",			"UIData/CreateCharacter.tga", tCharacterTexX[i], 152)
	characterWindow:setTexture("PushedOff",			"UIData/CreateCharacter.tga", tCharacterTexX[i], 0)
	characterWindow:setTexture("SelectedNormal",	"UIData/CreateCharacter.tga", tCharacterTexX[i], 228)
	characterWindow:setTexture("SelectedHover",		"UIData/CreateCharacter.tga", tCharacterTexX[i], 228)
	characterWindow:setTexture("SelectedPushed",	"UIData/CreateCharacter.tga", tCharacterTexX[i], 228)
	characterWindow:setTexture("SelectedPushedOff", "UIData/CreateCharacter.tga", tCharacterTexX[i], 228)
	characterWindow:setPosition(tCharacterPosX[i], tCharacterPosY[i])
	characterWindow:setSize(76, 76)
	characterWindow:setProperty("GroupID", 1600)
	characterWindow:setZOrderingEnabled(false)
	characterWindow:subscribeEvent("MouseEnter", "OnMouseEnter_character")
	characterWindow:subscribeEvent("MouseLeave", "OnMouseLeave_character")
	characterWindow:setUserString("characterNumber", i)
	characterWindow:subscribeEvent("SelectStateChanged", "OnChagnedSelectCharacter")
	bonewindow:addChildWindow(characterWindow)
end
--[[
infowindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_creaetcharacter_infoWindow")
infowindow:setTexture("Enabled",	"UIData/Character_002.tga", 0, 0)
infowindow:setTexture("Disabled",	"UIData/Character_002.tga", 0, 0)
infowindow:setProperty("FrameEnabled", "False")
infowindow:setProperty("BackgroundEnabled", "False")
infowindow:setPosition(0, 220)
infowindow:setSize(256, 100)
infowindow:setVisible(false)
infowindow:setZOrderingEnabled(false)
bonewindow:addChildWindow(infowindow)
]]
-- 케릭터를 변경할 경우
function OnChagnedSelectCharacter(args)
	local local_window = CEGUI.toWindowEventArgs(args).window
	if CEGUI.toRadioButton(local_window):isSelected() == true then
		local characterBone = local_window:getUserString("characterNumber")
		ChangedCharacter(tonumber(characterBone))
		
		--if winMgr:getWindow("sj_creaetcharacter_namebackWindow"):isVisible() == false then
		if winMgr:getWindow("sj_creaetcharacter_nameWindow_alpha"):isVisible() == false then
			winMgr:getWindow("sj_creaetcharacter_colorOKBtn"):setVisible(true)
		else
			winMgr:getWindow("sj_creaetcharacter_colorOKBtn"):setVisible(false)
		end
		
	end
	
	ResetAllSelectType()
	
	--EndAnimationView()
	--InitAnimationView(selected_skill)
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
			--winMgr:getWindow("sj_creaetcharacter_infoWindow"):setTexture("Enabled", "UIData/Character_002.tga", tCharacterInfoTexX[i], tCharacterInfoTexY[i])
		end
	end
end


function OnMouseLeave_character(args)
	for i=0, #tCharacterTexX do
		local local_window = winMgr:getWindow(i.."sj_creaetcharacter_characterIndex")
		if CEGUI.toRadioButton(local_window):isSelected() == true then
			--winMgr:getWindow("sj_creaetcharacter_infoWindow"):setTexture("Enabled", "UIData/Character_002.tga", tCharacterInfoTexX[i], tCharacterInfoTexY[i])
		end
	end
end

--[[
-- 캐릭터 본 선택 OK버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_creaetcharacter_boneOKBtn")
mywindow:setTexture("Normal",	"UIData/CreateCharacter.tga", 256, 628)
mywindow:setTexture("Hover",	"UIData/CreateCharacter.tga", 256, 655)
mywindow:setTexture("Pushed",	"UIData/CreateCharacter.tga", 256, 682)
mywindow:setTexture("PushedOff","UIData/CreateCharacter.tga", 256, 628)
mywindow:setTexture("Enabled",	"UIData/CreateCharacter.tga", 256, 628)
mywindow:setTexture("Disabled", "UIData/CreateCharacter.tga", 256, 709)
mywindow:setPosition(0, 214)
mywindow:setSize(90, 27)
mywindow:setVisible(false)
--mywindow:subscribeEvent("Clicked", "ClickedBoneOK")
bonewindow:addChildWindow(mywindow)
--]]

--[[
function ClickedBoneOK(args)
	winMgr:getWindow("sj_creaetcharacter_boneOKBtn"):setVisible(false)
	winMgr:getWindow("sj_creaetcharacter_bone1backWindow"):setVisible(false)
	winMgr:getWindow("sj_creaetcharacter_bone1backWindow"):clearControllerEvent("boneAlphaEvent")
	winMgr:getWindow("sj_creaetcharacter_bone1backWindow"):clearActiveController()

	winMgr:getWindow("sj_creaetcharacter_colorbackWindow"):setVisible(true)
	--winMgr:getWindow("sj_creaetcharacter_color1backWindow"):activeMotion("colorAlphaEvent")
end
--]]



--------------------------------------------------------------------

-- 색상 설정 2.1

--------------------------------------------------------------------
colorwindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_creaetcharacter_colorbackWindow")
colorwindow:setTexture("Enabled",	"UIData/CreateCharacter.tga", 250, 667)
colorwindow:setTexture("Disabled",	"UIData/CreateCharacter.tga", 250, 667)
colorwindow:setProperty("FrameEnabled", "False")
colorwindow:setProperty("BackgroundEnabled", "False")
--colorwindow:setPosition(30, 420)
--colorwindow:setPosition(450, 400)
--colorwindow:setSize(256, 314)
colorwindow:setPosition(19, 225)
colorwindow:setSize(236, 241)
colorwindow:setZOrderingEnabled(false)
colorwindow:setVisible(true)
--root:addChildWindow(colorwindow)
bonewindow:addChildWindow(colorwindow)

--color1window = winMgr:createWindow("TaharezLook/StaticImage", "sj_creaetcharacter_color1backWindow")
--color1window:setTexture("Enabled", "UIData/CreateCharacter.tga", 250, 667)
--color1window:setTexture("Disabled", "UIData/CreateCharacter.tga", 250, 667)
--color1window:setProperty("FrameEnabled", "False")
--color1window:setProperty("BackgroundEnabled", "False")
--color1window:setPosition(5, 200)
--color1window:setSize(256, 314)
--color1window:setZOrderingEnabled(false)
--color1window:addController("colorAlphaEvent", "colorAlphaEvent", "alpha", "Sine_EaseInOut", 0, 255,  4, true, true, 10)
--color1window:addController("colorAlphaEvent", "colorAlphaEvent", "alpha", "Sine_EaseInOut", 255, 255,3, true, true, 10)
--color1window:addController("colorAlphaEvent", "colorAlphaEvent", "alpha", "Sine_EaseInOut", 255, 0,  4, true, true, 10)
--colorwindow:addChildWindow(color1window)



----------------------------------------
-- [!!] 다같이 쓰는 위치 배열 [!!]
----------------------------------------
tColorPosX						= {["err"]=0, [0]=115, 155, 195}
tLastStringList					= {["err"]=0, [0]="A","B","C","D","E"}
tStyleTextColor					= {["err"]=0, [0]=255, 195, 0, 255}

local MAX_PAGE_BTN				= 2
local VERTICAL_PITCH			= 30
local SPIN_BUTTON_FONT_SIZE		= 14
tCreateCharacterButtonTexX		= {["err"]=0, [0]= { [0]=340, 366, 392}, { [0]=418, 444, 470} }
--tCreateCharacterButtonPosX		= {["err"]=0, [0]= 73, 193 }
tCreateCharacterButtonPosX		= {["err"]=0, [0]= 0, 120 }

function SetCurrentButtonText( string, index )
	--local text = "Skin Style " .. tLastStringList[index];
	local text = "Style " .. tLastStringList[index];
	winMgr:getWindow(string):setText(text + "_Dragon_Test" + index)
end











----------------------------------------
-- 1. 헤어(갈색, 검은색, 금색) 감자
----------------------------------------
local MAX_HAIR		= 5
local m_nHairIndex	= 0;
tHairObjName		= {["err"]=0, [0]="sj_creaetcharacter_Hair_Prev" , "sj_creaetcharacter_Hair_Next" }
tHairEventFunc		= {["err"]=0, [0]="Event_SelectHair_Prev" , "Event_SelectHair_Next" }

-- 백판
color1window_alpha = winMgr:createWindow("TaharezLook/StaticImage", "sj_creaetcharacter_Hair_BackImage_alpha")
color1window_alpha:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
color1window_alpha:setProperty("FrameEnabled", "False")
color1window_alpha:setProperty("BackgroundEnabled", "False")
color1window_alpha:setPosition(73, 12+VERTICAL_PITCH*1)
color1window_alpha:setSize(146, 26)
color1window_alpha:setZOrderingEnabled(false)
colorwindow:addChildWindow(color1window_alpha)

-- 헤어 텍스트 백판
color1window = winMgr:createWindow("TaharezLook/StaticImage", "sj_creaetcharacter_Hair_BackImage")
color1window:setTexture("Enabled",	"UIData/CreateCharacter.tga", 340, 26)
color1window:setTexture("Disabled", "UIData/CreateCharacter.tga", 340, 26)
color1window:setProperty("FrameEnabled", "False")
color1window:setProperty("BackgroundEnabled", "False")
--color1window:setPosition(99, 12+VERTICAL_PITCH*1)
color1window:setPosition(26, 0)
color1window:setSize(94, 26)
color1window:setZOrderingEnabled(false)
--colorwindow:addChildWindow(color1window)
color1window_alpha:addChildWindow(color1window)

-- 헤어 버튼
for i=0, MAX_PAGE_BTN - 1 do
	mywindow = winMgr:createWindow("TaharezLook/Button", tHairObjName[i])
	mywindow:setTexture("Normal",			"UIData/CreateCharacter.tga", tCreateCharacterButtonTexX[i][0], 0)
	mywindow:setTexture("Hover",			"UIData/CreateCharacter.tga", tCreateCharacterButtonTexX[i][1], 0)
	mywindow:setTexture("Pushed",			"UIData/CreateCharacter.tga", tCreateCharacterButtonTexX[i][2], 0)
	mywindow:setTexture("PushedOff",		"UIData/CreateCharacter.tga", tCreateCharacterButtonTexX[i][0], 0)
	--mywindow:setPosition(tCreateCharacterButtonPosX[i], 12+VERTICAL_PITCH*1)
	mywindow:setPosition(tCreateCharacterButtonPosX[i], 0)
	mywindow:setSize(26, 26)
	mywindow:setProperty("GroupID", 8708)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", tHairEventFunc[i])
	--colorwindow:addChildWindow(mywindow)
	color1window_alpha:addChildWindow(mywindow)
end

-- 헤어 아이템 타이틀
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_creaetcharacter_Hair_Text")
mywindow:setTextColor(tStyleTextColor[0],tStyleTextColor[1],tStyleTextColor[2],tStyleTextColor[3])
mywindow:setFont(g_STRING_FONT_GULIMCHE, SPIN_BUTTON_FONT_SIZE)
mywindow:setText("Style A")
mywindow:setSize(3, 3)
mywindow:setPosition(20, 12)
mywindow:setVisible(true)
mywindow:setZOrderingEnabled(false)
color1window:addChildWindow(mywindow)

function Event_SelectHair_Prev() -- 이전
	DebugStr("Event_SelectHair_Prev")
	
	if m_nHairIndex > -1 then
		if m_nHairIndex == 0 then
			m_nHairIndex = 4;
			SetCurrentButtonText("sj_creaetcharacter_Hair_Text", m_nHairIndex);	
			SetSelectHair(m_nHairIndex);
			DebugStr("m_nHairIndex : " .. m_nHairIndex)
			return;
		end
		
		m_nHairIndex = m_nHairIndex - 1;
		SetSelectHair(m_nHairIndex);
		SetCurrentButtonText("sj_creaetcharacter_Hair_Text", m_nHairIndex);
		DebugStr("m_nHairIndex : " .. m_nHairIndex)
		end
end

function Event_SelectHair_Next() -- 다음
	DebugStr("Event_SelectHair_Next")
	
	if m_nHairIndex < MAX_HAIR then
		if m_nHairIndex == 4 then -- 0으로 돌아간다.
			m_nHairIndex = 0;
			SetSelectHair(m_nHairIndex);
			SetCurrentButtonText("sj_creaetcharacter_Hair_Text", m_nHairIndex);
			DebugStr("m_nHairIndex : " .. m_nHairIndex)
			return;
		end
		
		m_nHairIndex = m_nHairIndex + 1;
		SetSelectHair(m_nHairIndex);
		SetCurrentButtonText("sj_creaetcharacter_Hair_Text", m_nHairIndex);
		DebugStr("m_nHairIndex : " .. m_nHairIndex)
	end
end





----------------------------------------
-- 2. 얼굴 5종
----------------------------------------
local m_nFaceIndex	= 0;
local MAX_FACE		= 5
tFaceObjName		= {["err"]=0, [0]="sj_creaetcharacter_Face_Prev" , "sj_creaetcharacter_Face_Next" }
tFaceEventFunc		= {["err"]=0, [0]="Event_SelectFace_Prev"		 , "Event_SelectFace_Next" }

-- 백판
color1window_alpha = winMgr:createWindow("TaharezLook/StaticImage", "sj_creaetcharacter_Face_BackImage_alpha")
color1window_alpha:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
color1window_alpha:setProperty("FrameEnabled", "False")
color1window_alpha:setProperty("BackgroundEnabled", "False")
color1window_alpha:setPosition(73, 12+VERTICAL_PITCH*2)
color1window_alpha:setSize(146, 26)
color1window_alpha:setZOrderingEnabled(false)
colorwindow:addChildWindow(color1window_alpha)

-- 얼굴 텍스트 백판
color1window = winMgr:createWindow("TaharezLook/StaticImage", "sj_creaetcharacter_Face_BackImage")
color1window:setTexture("Enabled",	"UIData/CreateCharacter.tga", 340, 26)
color1window:setTexture("Disabled", "UIData/CreateCharacter.tga", 340, 26)
color1window:setProperty("FrameEnabled", "False")
color1window:setProperty("BackgroundEnabled", "False")
--color1window:setPosition(99, 12+VERTICAL_PITCH*2)
color1window:setPosition(26, 0)
color1window:setSize(94, 26)
color1window:setZOrderingEnabled(false)
--colorwindow:addChildWindow(color1window)
color1window_alpha:addChildWindow(color1window)

-- 버튼
for i=0, MAX_PAGE_BTN - 1 do
	mywindow = winMgr:createWindow("TaharezLook/Button", tFaceObjName[i])
	mywindow:setTexture("Normal",			"UIData/CreateCharacter.tga", tCreateCharacterButtonTexX[i][0], 0)
	mywindow:setTexture("Hover",			"UIData/CreateCharacter.tga", tCreateCharacterButtonTexX[i][1], 0)
	mywindow:setTexture("Pushed",			"UIData/CreateCharacter.tga", tCreateCharacterButtonTexX[i][2], 0)
	mywindow:setTexture("PushedOff",		"UIData/CreateCharacter.tga", tCreateCharacterButtonTexX[i][0], 0)
	--mywindow:setPosition(tCreateCharacterButtonPosX[i], 12+VERTICAL_PITCH*2)
	mywindow:setPosition(tCreateCharacterButtonPosX[i], 0)
	mywindow:setSize(26, 26)
	mywindow:setProperty("GroupID", 8710)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", tFaceEventFunc[i])
	--colorwindow:addChildWindow(mywindow)
	color1window_alpha:addChildWindow(mywindow)
end

-- 얼굴 아이템 타이틀
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_creaetcharacter_Face_Text")
mywindow:setTextColor(tStyleTextColor[0],tStyleTextColor[1],tStyleTextColor[2],tStyleTextColor[3])
mywindow:setFont(g_STRING_FONT_GULIMCHE, SPIN_BUTTON_FONT_SIZE)
mywindow:setText("Style A")
mywindow:setSize(3, 3)
mywindow:setPosition(20, 12)
mywindow:setVisible(true)
mywindow:setZOrderingEnabled(false)
color1window:addChildWindow(mywindow)

function Event_SelectFace_Prev() -- 이전
	DebugStr("Event_SelectFace_Prev")
	
	if m_nFaceIndex > -1 then
		if m_nFaceIndex == 0 then
			m_nFaceIndex = 4;
			SetCurrentButtonText("sj_creaetcharacter_Face_Text", m_nFaceIndex);	
			SetSelectFace(m_nFaceIndex);
			DebugStr("m_nFaceIndex : " .. m_nFaceIndex)
			return;
		end
		
		m_nFaceIndex = m_nFaceIndex - 1;
		SetSelectFace(m_nFaceIndex);
		SetCurrentButtonText("sj_creaetcharacter_Face_Text", m_nFaceIndex);
		DebugStr("m_nFaceIndex : " .. m_nFaceIndex)
	end
end

function Event_SelectFace_Next() -- 다음
	DebugStr("Event_SelectFace_Next")
	
	if m_nFaceIndex < MAX_FACE then
		if m_nFaceIndex == 4 then -- 0으로 돌아간다.
			m_nFaceIndex = 0;
			SetSelectFace(m_nFaceIndex);
			SetCurrentButtonText("sj_creaetcharacter_Face_Text", m_nFaceIndex);
			DebugStr("m_nFaceIndex : " .. m_nFaceIndex)
			return;
		end
		
		m_nFaceIndex = m_nFaceIndex + 1;
		SetSelectFace(m_nFaceIndex);
		SetCurrentButtonText("sj_creaetcharacter_Face_Text", m_nFaceIndex);
		DebugStr("m_nFaceIndex : " .. m_nFaceIndex)
	end
end



----------------------------------------
-- 3. 상의 5종
----------------------------------------
local m_nUpperIndex	= 0;
local MAX_UPPER		= 5
tUpperObjName		= {["err"]=0, [0]="sj_creaetcharacter_Uppere_Prev" , "sj_creaetcharacter_Upper_Next" }
tUpperEventFunc		= {["err"]=0, [0]="Event_SelectUpper_Prev"		 , "Event_SelectUpper_Next" }

-- 백판
color1window_alpha = winMgr:createWindow("TaharezLook/StaticImage", "sj_creaetcharacter_Upper_BackImage_alpha")
color1window_alpha:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
color1window_alpha:setProperty("FrameEnabled", "False")
color1window_alpha:setProperty("BackgroundEnabled", "False")
color1window_alpha:setPosition(73, 12+VERTICAL_PITCH*3)
color1window_alpha:setSize(146, 26)
color1window_alpha:setZOrderingEnabled(false)
colorwindow:addChildWindow(color1window_alpha)

-- 상의 텍스트 백판
color1window = winMgr:createWindow("TaharezLook/StaticImage", "sj_creaetcharacter_Upper_BackImage")
color1window:setTexture("Enabled",	"UIData/CreateCharacter.tga", 340, 26)
color1window:setTexture("Disabled", "UIData/CreateCharacter.tga", 340, 26)
color1window:setProperty("FrameEnabled", "False")
color1window:setProperty("BackgroundEnabled", "False")
--color1window:setPosition(99, 12+VERTICAL_PITCH*3)
color1window:setPosition(26, 0)
color1window:setSize(94, 26)
color1window:setZOrderingEnabled(false)
--colorwindow:addChildWindow(color1window)
color1window_alpha:addChildWindow(color1window)

-- 버튼
for i=0, MAX_PAGE_BTN - 1 do
	mywindow = winMgr:createWindow("TaharezLook/Button", tUpperObjName[i])
	mywindow:setTexture("Normal",			"UIData/CreateCharacter.tga", tCreateCharacterButtonTexX[i][0], 0)
	mywindow:setTexture("Hover",			"UIData/CreateCharacter.tga", tCreateCharacterButtonTexX[i][1], 0)
	mywindow:setTexture("Pushed",			"UIData/CreateCharacter.tga", tCreateCharacterButtonTexX[i][2], 0)
	mywindow:setTexture("PushedOff",		"UIData/CreateCharacter.tga", tCreateCharacterButtonTexX[i][0], 0)
	--mywindow:setPosition(tCreateCharacterButtonPosX[i], 12+VERTICAL_PITCH*3)
	mywindow:setPosition(tCreateCharacterButtonPosX[i], 0)
	mywindow:setSize(26, 26)
	mywindow:setProperty("GroupID", 8712)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", tUpperEventFunc[i])
	--colorwindow:addChildWindow(mywindow)
	color1window_alpha:addChildWindow(mywindow)
end

-- 아이템 타이틀
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_creaetcharacter_Upper_Text")
mywindow:setTextColor(tStyleTextColor[0],tStyleTextColor[1],tStyleTextColor[2],tStyleTextColor[3])
mywindow:setFont(g_STRING_FONT_GULIMCHE, SPIN_BUTTON_FONT_SIZE)
mywindow:setText("Style A")
mywindow:setSize(3, 3)
mywindow:setPosition(20, 12)
mywindow:setVisible(true)
mywindow:setZOrderingEnabled(false)
color1window:addChildWindow(mywindow)

function Event_SelectUpper_Prev() -- 이전
	
	if m_nUpperIndex > -1 then
		if m_nUpperIndex == 0 then
			m_nUpperIndex = 4;
			SetCurrentButtonText("sj_creaetcharacter_Upper_Text", m_nUpperIndex);	
			SetSelectUpper(m_nUpperIndex);
			return;
		end
		
		m_nUpperIndex = m_nUpperIndex - 1;
		SetSelectUpper(m_nUpperIndex);
		SetCurrentButtonText("sj_creaetcharacter_Upper_Text", m_nUpperIndex);
	end
	
end

function Event_SelectUpper_Next() -- 다음

	if m_nUpperIndex < MAX_UPPER then
		if m_nUpperIndex == 4 then -- 0으로 돌아간다.
			m_nUpperIndex = 0;
			SetSelectUpper(m_nUpperIndex);
			SetCurrentButtonText("sj_creaetcharacter_Upper_Text", m_nUpperIndex);
			return;
		end
		
		m_nUpperIndex = m_nUpperIndex + 1;
		SetSelectUpper(m_nUpperIndex);
		SetCurrentButtonText("sj_creaetcharacter_Upper_Text", m_nUpperIndex);
	end
	
end




----------------------------------------
-- 4. 하의 5종
----------------------------------------
local m_nDownIndex	= 0;
local MAX_DOWN		= 5
tDownObjName		= {["err"]=0, [0]="sj_creaetcharacter_Down_Prev" , "sj_creaetcharacter_Down_Next" }
tDownEventFunc		= {["err"]=0, [0]="Event_SelectDown_Prev"		 , "Event_SelectDown_Next" }

-- 백판
color1window_alpha = winMgr:createWindow("TaharezLook/StaticImage", "sj_creaetcharacter_Down_BackImage_alpha")
color1window_alpha:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
color1window_alpha:setProperty("FrameEnabled", "False")
color1window_alpha:setProperty("BackgroundEnabled", "False")
color1window_alpha:setPosition(73, 12+VERTICAL_PITCH*4)
color1window_alpha:setSize(146, 26)
color1window_alpha:setZOrderingEnabled(false)
colorwindow:addChildWindow(color1window_alpha)

-- 하의 텍스트 백판
color1window = winMgr:createWindow("TaharezLook/StaticImage", "sj_creaetcharacter_Down_BackImage")
color1window:setTexture("Enabled",	"UIData/CreateCharacter.tga", 340, 26)
color1window:setTexture("Disabled", "UIData/CreateCharacter.tga", 340, 26)
color1window:setProperty("FrameEnabled", "False")
color1window:setProperty("BackgroundEnabled", "False")
--color1window:setPosition(99, 12+VERTICAL_PITCH*4)
color1window:setPosition(26, 0)
color1window:setSize(94, 26)
color1window:setZOrderingEnabled(false)
--colorwindow:addChildWindow(color1window)
color1window_alpha:addChildWindow(color1window)

-- 버튼
for i=0, MAX_PAGE_BTN - 1 do
	mywindow = winMgr:createWindow("TaharezLook/Button", tDownObjName[i])
	mywindow:setTexture("Normal",			"UIData/CreateCharacter.tga", tCreateCharacterButtonTexX[i][0], 0)
	mywindow:setTexture("Hover",			"UIData/CreateCharacter.tga", tCreateCharacterButtonTexX[i][1], 0)
	mywindow:setTexture("Pushed",			"UIData/CreateCharacter.tga", tCreateCharacterButtonTexX[i][2], 0)
	mywindow:setTexture("PushedOff",		"UIData/CreateCharacter.tga", tCreateCharacterButtonTexX[i][0], 0)
	--mywindow:setPosition(tCreateCharacterButtonPosX[i], 12+VERTICAL_PITCH*4)
	mywindow:setPosition(tCreateCharacterButtonPosX[i], 0)
	mywindow:setSize(26, 26)
	mywindow:setProperty("GroupID", 8712)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", tDownEventFunc[i])
	--colorwindow:addChildWindow(mywindow)
	color1window_alpha:addChildWindow(mywindow)
end

-- 아이템 타이틀
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_creaetcharacter_Down_Text")
mywindow:setTextColor(tStyleTextColor[0],tStyleTextColor[1],tStyleTextColor[2],tStyleTextColor[3])
mywindow:setFont(g_STRING_FONT_GULIMCHE, SPIN_BUTTON_FONT_SIZE)
mywindow:setText("Style A")
mywindow:setSize(3, 3)
mywindow:setPosition(20, 12)
mywindow:setVisible(true)
mywindow:setZOrderingEnabled(false)
color1window:addChildWindow(mywindow)

function Event_SelectDown_Prev() -- 이전

	if m_nDownIndex > -1 then
		if m_nDownIndex == 0 then
			m_nDownIndex = 4;
			SetCurrentButtonText("sj_creaetcharacter_Down_Text", m_nDownIndex);	
			SetSelectPants(m_nFaceIndex);
			return;
		end
		
		m_nDownIndex = m_nDownIndex - 1;
		SetSelectPants(m_nDownIndex);
		SetCurrentButtonText("sj_creaetcharacter_Down_Text", m_nDownIndex);
	end
end

function Event_SelectDown_Next() -- 다음
	
	if m_nDownIndex < MAX_DOWN then
		if m_nDownIndex == 4 then -- 0으로 돌아간다.
			m_nDownIndex = 0;
			SetSelectPants(m_nDownIndex);
			SetCurrentButtonText("sj_creaetcharacter_Down_Text", m_nDownIndex);
			return;
		end
		
		m_nDownIndex = m_nDownIndex + 1;
		SetSelectPants(m_nDownIndex);
		SetCurrentButtonText("sj_creaetcharacter_Down_Text", m_nDownIndex);
	end
end


----------------------------------------
-- 5. 신발 5종
----------------------------------------
local m_nShoesIndex	= 0;
local MAX_SHOES		= 5
tShoesObjName		= {["err"]=0, [0]="sj_creaetcharacter_Shoes_Prev" , "sj_creaetcharacter_Shoes_Next" }
tShoesEventFunc		= {["err"]=0, [0]="Event_SelectShoes_Prev"		 , "Event_SelectShoes_Next" }

-- 백판
color1window_alpha = winMgr:createWindow("TaharezLook/StaticImage", "sj_creaetcharacter_Shoes_BackImage_alpha")
color1window_alpha:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
color1window_alpha:setProperty("FrameEnabled", "False")
color1window_alpha:setProperty("BackgroundEnabled", "False")
color1window_alpha:setPosition(73, 12+VERTICAL_PITCH*5)
color1window_alpha:setSize(146, 26)
color1window_alpha:setZOrderingEnabled(false)
colorwindow:addChildWindow(color1window_alpha)

-- 신발 텍스트 백판
color1window = winMgr:createWindow("TaharezLook/StaticImage", "sj_creaetcharacter_Shoes_BackImage")
color1window:setTexture("Enabled",	"UIData/CreateCharacter.tga", 340, 26)
color1window:setTexture("Disabled", "UIData/CreateCharacter.tga", 340, 26)
color1window:setProperty("FrameEnabled", "False")
color1window:setProperty("BackgroundEnabled", "False")
--color1window:setPosition(99, 12+VERTICAL_PITCH*5)
color1window:setPosition(26, 0)
color1window:setSize(94, 26)
color1window:setZOrderingEnabled(false)
--colorwindow:addChildWindow(color1window)
color1window_alpha:addChildWindow(color1window)

-- 버튼
for i=0, MAX_PAGE_BTN - 1 do
	mywindow = winMgr:createWindow("TaharezLook/Button", tShoesObjName[i])
	mywindow:setTexture("Normal",			"UIData/CreateCharacter.tga", tCreateCharacterButtonTexX[i][0], 0)
	mywindow:setTexture("Hover",			"UIData/CreateCharacter.tga", tCreateCharacterButtonTexX[i][1], 0)
	mywindow:setTexture("Pushed",			"UIData/CreateCharacter.tga", tCreateCharacterButtonTexX[i][2], 0)
	mywindow:setTexture("PushedOff",		"UIData/CreateCharacter.tga", tCreateCharacterButtonTexX[i][0], 0)
	--mywindow:setPosition(tCreateCharacterButtonPosX[i], 12+VERTICAL_PITCH*5)
	mywindow:setPosition(tCreateCharacterButtonPosX[i], 0)
	mywindow:setSize(26, 26)
	mywindow:setProperty("GroupID", 8710)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", tShoesEventFunc[i])
	--colorwindow:addChildWindow(mywindow)
	color1window_alpha:addChildWindow(mywindow)
end

-- zeustw {
-- todo : add hand ?
-- zeustw }

-- 아이템 타이틀
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_creaetcharacter_Shoes_Text")
mywindow:setTextColor(tStyleTextColor[0],tStyleTextColor[1],tStyleTextColor[2],tStyleTextColor[3])
mywindow:setFont(g_STRING_FONT_GULIMCHE, SPIN_BUTTON_FONT_SIZE)
mywindow:setText("Style A")
mywindow:setSize(3, 3)
mywindow:setPosition(20, 12)
mywindow:setVisible(true)
mywindow:setZOrderingEnabled(false)
color1window:addChildWindow(mywindow)

function Event_SelectShoes_Prev() -- 이전
	
	if m_nShoesIndex > -1 then
		if m_nShoesIndex == 0 then
			m_nShoesIndex = 4;
			SetCurrentButtonText("sj_creaetcharacter_Shoes_Text", m_nShoesIndex);	
			SetSelectShoes(m_nShoesIndex);
			return;
		end
		
		m_nShoesIndex = m_nShoesIndex - 1;
		SetSelectShoes(m_nShoesIndex);
		SetCurrentButtonText("sj_creaetcharacter_Shoes_Text", m_nShoesIndex);
	end
end

function Event_SelectShoes_Next() -- 다음
	
	if m_nShoesIndex < MAX_SHOES then
		if m_nShoesIndex == 4 then -- 0으로 돌아간다.
			m_nShoesIndex = 0;
			SetSelectShoes(m_nShoesIndex);
			SetCurrentButtonText("sj_creaetcharacter_Shoes_Text", m_nShoesIndex);
			return;
		end
		
		m_nShoesIndex = m_nShoesIndex + 1;
		SetSelectShoes(m_nShoesIndex);
		SetCurrentButtonText("sj_creaetcharacter_Shoes_Text", m_nShoesIndex);
	end
end


-- 캐릭터 reset 버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_creaetcharacter_Reset_Btn")
mywindow:setTexture("Normal",		"UIData/CreateCharacter.tga", 0, 630)
mywindow:setTexture("Hover",		"UIData/CreateCharacter.tga", 0, 664)
mywindow:setTexture("Pushed",		"UIData/CreateCharacter.tga", 0, 698)
mywindow:setTexture("PushedOff",	"UIData/CreateCharacter.tga", 0, 630)
--mywindow:setTexture("Enabled",		"UIData/CreateCharacter.tga", 0, 698)
--mywindow:setTexture("Disabled",		"UIData/CreateCharacter.tga", 0, 698)
mywindow:setPosition(29, 195)
mywindow:setSize(87, 34)
mywindow:subscribeEvent("Clicked", "Event_ClickResetBtn")
colorwindow:addChildWindow(mywindow)

function ResetAllSelectType()
	--m_nSkinIndex  = 0;
	m_nHairIndex  = 0;
	m_nFaceIndex  = 0;
	m_nUpperIndex = 0;
	m_nDownIndex  = 0;
	m_nShoesIndex = 0;
	
	local Text = "Style A"
	--winMgr:getWindow("sj_creaetcharacter_Skin_Text"):setText(Text);
	winMgr:getWindow("sj_creaetcharacter_Hair_Text"):setText(Text);
	winMgr:getWindow("sj_creaetcharacter_Face_Text"):setText(Text);
	winMgr:getWindow("sj_creaetcharacter_Upper_Text"):setText(Text);
	winMgr:getWindow("sj_creaetcharacter_Down_Text"):setText(Text);
	winMgr:getWindow("sj_creaetcharacter_Shoes_Text"):setText(Text);
	
	SetSelectSkin(m_nSkinIndex);
	SetSelectHair(m_nHairIndex);
	SetSelectFace(m_nFaceIndex);
	SetSelectUpper(m_nUpperIndex);
	SetSelectPants(m_nDownIndex);
	SetSelectShoes(m_nShoesIndex);
end


function Event_ClickResetBtn()
	ResetAllSelectType()
end

-- 캐릭터 random 버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_creaetcharacter_Random_Btn")
mywindow:setTexture("Normal",		"UIData/CreateCharacter.tga", 0, 732)
mywindow:setTexture("Hover",		"UIData/CreateCharacter.tga", 0, 766)
mywindow:setTexture("Pushed",		"UIData/CreateCharacter.tga", 0, 800)
mywindow:setTexture("PushedOff",	"UIData/CreateCharacter.tga", 0, 732)
--mywindow:setTexture("Enabled",		"UIData/CreateCharacter.tga", 0, 800)
--mywindow:setTexture("Disabled",		"UIData/CreateCharacter.tga", 0, 800)
mywindow:setPosition(120, 195)
mywindow:setSize(87, 34)
mywindow:subscribeEvent("Clicked", "Event_ClickRandomBtn")
colorwindow:addChildWindow(mywindow)


local tVoidNameList      = { ['err']=0, }

local tTempValueNameList = { ['err']=0, [0]="sj_creaetcharacter_Hair_Text","sj_creaetcharacter_Face_Text",
											"sj_creaetcharacter_Upper_Text","sj_creaetcharacter_Down_Text","sj_creaetcharacter_Shoes_Text" }

function Event_ClickRandomBtn()
	--local skinIndex  = GetRandomValue(0,MAX_SKIN - 1);--랜덤	
	
	--if (IsThaiLanguage() == false and IsEngLanguage() == false) or TEST_MAS_MODE == true then
	--	skinIndex = 0		
	--end
	
	--SetSelectSkin(skinIndex);
	--SetCurrentButtonText("sj_creaetcharacter_Skin_Text",  skinIndex);
	--DebugStr("skinIndex : " .. skinIndex)
	
	local OtherIndex = -1;
	for i = 0 , #tTempValueNameList do
		OtherIndex = GetRandomValue(0,4);
		
		SetCurrentButtonText(tTempValueNameList[i],  OtherIndex)
		
		table.insert(tVoidNameList, i, OtherIndex)
	end
	
	SetSelectHair(tVoidNameList[0]);
	SetSelectFace(tVoidNameList[1]);
	SetSelectUpper(tVoidNameList[2]);
	SetSelectPants(tVoidNameList[3]);
	SetSelectShoes(tVoidNameList[4]);
	
	m_nSkinIndex = skinIndex;
	m_nHairIndex = tVoidNameList[0];
	m_nFaceIndex = tVoidNameList[1];
	m_nUpperIndex = tVoidNameList[2];
	m_nDownIndex = tVoidNameList[3];
	m_nShoesIndex = tVoidNameList[4];

end




-- 캐릭터 칼라 선택 OK버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_creaetcharacter_colorOKBtn")
mywindow:setTexture("Normal",		"UIData/CreateCharacter.tga", 87, 705)
mywindow:setTexture("Hover",		"UIData/CreateCharacter.tga", 87, 741)
mywindow:setTexture("Pushed",		"UIData/CreateCharacter.tga", 87, 777)
mywindow:setTexture("PushedOff",	"UIData/CreateCharacter.tga", 87, 705)
--mywindow:setTexture("Enabled",		"UIData/CreateCharacter.tga", 87, 777)
--mywindow:setTexture("Disabled",		"UIData/CreateCharacter.tga", 87, 777)
mywindow:setPosition(173, 474)
mywindow:setSize(98, 36)
mywindow:setVisible(false)
mywindow:subscribeEvent("Shown", "OnShown_CharacterConfirm")
mywindow:subscribeEvent("Hidden", "OnHidden_CharacterConfirm")
mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_CharacterConfirm")
mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_CharacterConfirm")
mywindow:subscribeEvent("Clicked", "OnClicked_CharacterConfirm")

--mywindow:addController("CharacterConfirmAlphaEvent", "CharacterConfirmAlphaEvent", "alpha", "Sine_EaseInOut", 100, 255,   2, true, true, 10)
--mywindow:addController("CharacterConfirmAlphaEvent", "CharacterConfirmAlphaEvent", "alpha", "Sine_EaseInOut", 255, 255, 7, true, true, 10)
--mywindow:addController("CharacterConfirmAlphaEvent", "CharacterConfirmAlphaEvent", "alpha", "Sine_EaseInOut", 255, 100,   2, true, true, 10)
--mywindow:activeMotion("CharacterConfirmAlphaEvent")

--colorwindow:addChildWindow(mywindow)
alphaCharacterwindow:addChildWindow(mywindow)

function activateMotionCharacterConfirm()
	local window = winMgr:getWindow("sj_creaetcharacter_colorOKBtn")
	window:addController("CharacterConfirmAlphaEvent", "CharacterConfirmAlphaEvent", "alpha", "Sine_EaseInOut", 100, 255,   2, true, true, 10)
	window:addController("CharacterConfirmAlphaEvent", "CharacterConfirmAlphaEvent", "alpha", "Sine_EaseInOut", 255, 255, 7, true, true, 10)
	window:addController("CharacterConfirmAlphaEvent", "CharacterConfirmAlphaEvent", "alpha", "Sine_EaseInOut", 255, 100,   2, true, true, 10)
	window:activeMotion("CharacterConfirmAlphaEvent")
end

function deactivateMotionCharacterConfirm()
	local window = winMgr:getWindow("sj_creaetcharacter_colorOKBtn")
	window:clearControllerEvent("CharacterConfirmAlphaEvent")
	window:clearActiveController()
	window:setAlphaWithChild(255)
end

function OnShown_CharacterConfirm(args)
	activateMotionCharacterConfirm()
end

function OnHidden_CharacterConfirm(args)
	deactivateMotionCharacterConfirm()
end

function OnMouseEnter_CharacterConfirm(args)
	deactivateMotionCharacterConfirm()
end

function OnMouseLeave_CharacterConfirm(args)
	activateMotionCharacterConfirm()
end

function OnClicked_CharacterConfirm(args) -- rkawk
	--winMgr:getWindow("sj_creaetcharacter_colorOKBtn"):setVisible(false)
	--winMgr:getWindow("sj_creaetcharacter_color1backWindow"):setVisible(false)
	--winMgr:getWindow("sj_creaetcharacter_color1backWindow"):clearControllerEvent("colorAlphaEvent")
	--winMgr:getWindow("sj_creaetcharacter_color1backWindow"):clearActiveController()

	--winMgr:getWindow("sj_creaetcharacter_classbackWindow"):setVisible(true)
	
	
	
	winMgr:getWindow("sj_creaetcharacter_decisionBtn"):setVisible(true)
	winMgr:getWindow("sj_creaetcharacter_colorOKBtn"):setVisible(false)
	--winMgr:getWindow("sj_creaetcharacter_namebackWindow"):setVisible(true)
	winMgr:getWindow("sj_creaetcharacter_nameWindow_alpha"):setVisible(true)
	winMgr:getWindow("sj_creaetcharacter_name1backWindow"):setVisible(true)
	
	
	winMgr:getWindow("IDEditbox"):setVisible(true)
end







--------------------------------------------------------------------

-- 스트리트, 러쉬 선택 라디오 버튼 1

--------------------------------------------------------------------
alphaclasswindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_creaetcharacter_classbackWindow_Alpha")
alphaclasswindow:setTexture("Enabled",  "UIData/invisible.tga", 0, 0)
alphaclasswindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
alphaclasswindow:setProperty("FrameEnabled",	 "False")
alphaclasswindow:setProperty("BackgroundEnabled","False")
alphaclasswindow:setWideType(9010)
alphaclasswindow:setPosition(30, 126)
alphaclasswindow:setSize(274, 521)
alphaclasswindow:setZOrderingEnabled(false)
alphaclasswindow:setVisible(true)
root:addChildWindow(alphaclasswindow)


classwindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_creaetcharacter_classbackWindow")
classwindow:setTexture("Enabled",	"UIData/frame/frame_001.tga", 0 , 0)
classwindow:setTexture("Disabled",  "UIData/frame/frame_001.tga", 0 , 0)
classwindow:setframeWindow(true)
classwindow:setProperty("FrameEnabled",			"False")
classwindow:setProperty("BackgroundEnabled",	"False")
classwindow:setPosition(0, 0)
classwindow:setSize(274, 485)
classwindow:setZOrderingEnabled(false)
classwindow:setVisible(true)
alphaclasswindow:addChildWindow(classwindow)

-- Class Select 이미지
classTitle = winMgr:createWindow("TaharezLook/StaticImage", "sj_creaetcharacter_Class_Title")
classTitle:setTexture("Enabled",	"UIData/CreateCharacter.tga", 0, 78)
classTitle:setTexture("Disabled",	"UIData/CreateCharacter.tga", 0, 78)
classTitle:setProperty("FrameEnabled", "False")
classTitle:setProperty("BackgroundEnabled", "False")
classTitle:setPosition(7,15)
--classTitle:setPosition((274/2)-(260/2), 5)
classTitle:setSize(260, 43)
classTitle:setVisible(true)
classTitle:setZOrderingEnabled(false)
classwindow:addChildWindow(classTitle)



-- 스트리트 , 러시 선택 버튼 (Selected Street or Rush Class)
tCharacterStyleTexX = { ["protectErr"]=0, [0]=0, 125 }
tCharacterStyleTexY = { ["protectErr"]=0, [0]=121, 125 }
tCharacterStylePosX = { ["protectErr"]=0, [0]=12, 137 }
for i=0, #tCharacterStyleTexY do
	styleWindow = winMgr:createWindow("TaharezLook/RadioButton", i .. "sj_creaetcharacter_characterStyle")
	styleWindow:setTexture("Normal",			"UIData/CreateCharacter.tga", tCharacterStyleTexX[i], 121)
	styleWindow:setTexture("Hover",				"UIData/CreateCharacter.tga", tCharacterStyleTexX[i], 225)
	styleWindow:setTexture("Pushed",			"UIData/CreateCharacter.tga", tCharacterStyleTexX[i], 329)
	styleWindow:setTexture("PushedOff",			"UIData/CreateCharacter.tga", tCharacterStyleTexX[i], 121)
	styleWindow:setTexture("SelectedNormal",	"UIData/CreateCharacter.tga", tCharacterStyleTexX[i], 433)
	styleWindow:setTexture("SelectedHover",		"UIData/CreateCharacter.tga", tCharacterStyleTexX[i], 433)
	styleWindow:setTexture("SelectedPushed",	"UIData/CreateCharacter.tga", tCharacterStyleTexX[i], 433)
	styleWindow:setTexture("SelectedPushedOff", "UIData/CreateCharacter.tga", tCharacterStyleTexX[i], 433)
	styleWindow:setPosition(tCharacterStylePosX[i], 67)
	styleWindow:setSize(125, 104)
	styleWindow:setProperty("GroupID", 1601)
	styleWindow:setZOrderingEnabled(false)
	styleWindow:setUserString("characterStyle", i)
	styleWindow:subscribeEvent("SelectStateChanged", "OnChangedSelectStyle")
	styleWindow:subscribeEvent("MouseEnter", "OnMouseEnter_style")
	styleWindow:subscribeEvent("MouseLeave", "OnMouseLeave_style")
	classwindow:addChildWindow(styleWindow)
end

function OnChangedSelectStyle(args)
	local local_window = CEGUI.toWindowEventArgs(args).window
	
	if CEGUI.toRadioButton(local_window):isSelected() == true then
		if winMgr:getWindow("sj_creaetcharacter_CharacterbackWindow_Alpha"):isVisible() == false then
			winMgr:getWindow("sj_creaetcharacter_classOKBtn"):setVisible(true)
		else
			winMgr:getWindow("sj_creaetcharacter_classOKBtn"):setVisible(false)
		end
		local characterStyle = local_window:getUserString("characterStyle")
		SetStyleIndex(tonumber(characterStyle))
		
		for i = 0 , #tCharacterStyle_Street_PosX do
			winMgr:getWindow("Creaetcharacter_characterStyle_Street_"..i):setVisible(false);
			winMgr:getWindow("Creaetcharacter_characterStyle_Rush_"..i):setVisible(false);
			winMgr:getWindow("PreviewWindowFrame"):setVisible(false);
		end
		local styleIndex = tonumber(characterStyle);
		if styleIndex == 0 then
			for i = 0 , #tCharacterStyle_Street_PosX do
				winMgr:getWindow("Creaetcharacter_characterStyle_Street_"..i):setVisible(true);
			end
		elseif styleIndex == 1 then
			for i = 0 , #tCharacterStyle_Rush_PosX do
				winMgr:getWindow("Creaetcharacter_characterStyle_Rush_"..i):setVisible(true);
			end
		end
		winMgr:getWindow("PreviewWindowFrame"):setVisible(true);
		
		SelectFirstCategory(styleIndex);
		
		--g_PositionX , y = GetBasicRootPoint(winMgr:getWindow("Creaetcharacter_characterStyle_Street_0"))
		--g_PositionX , y = GetBasicRootPoint(winMgr:getWindow("Creaetcharacter_characterStyle_Street_0"))
		--g_PositionX = g_PositionX + 10;
	end
	
	MuteSound(true)
end


-- 클래스 설명 0
tCharacterStyleInfoTexY = { ["protectErr"]=0, [0]=121, 189 }
styleinfowindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_creaetcharacter_styleInfoWindow")
styleinfowindow:setTexture("Enabled",	"UIData/invisible.tga", 0, 0)
styleinfowindow:setTexture("Disabled",	"UIData/invisible.tga", 0, 0)
styleinfowindow:setProperty("FrameEnabled", "False")
styleinfowindow:setProperty("BackgroundEnabled", "False")
styleinfowindow:setPosition(12, 171)
styleinfowindow:setSize(250, 68)
styleinfowindow:setZOrderingEnabled(false)
classwindow:addChildWindow(styleinfowindow)



--------------------------------------------------------------------

-- 1. 태권도.복싱,무에타이,카포에라

--------------------------------------------------------------------
tCharacterStyle_Street_TexX  = { ["protectErr"]=0, [0]=250, 313, 372, 431 }
tCharacterStyle_Street_PosX  = { ["protectErr"]=0, [0]=15, 78, 137, 196 }
tCharacterStyle_Street_SizeX = { ["protectErr"]=0, [0]=63, 59, 59, 63     }
tCharacterStyle_Street_Skill = { ["protectErr"]=0, [0]=812048, 822048, 832048, 842048 }

for i=0, #tCharacterStyle_Street_PosX do
	local styleWindow = winMgr:createWindow("TaharezLook/RadioButton", "Creaetcharacter_characterStyle_Street_" .. i)
	styleWindow:setTexture("Normal",			"UIData/CreateCharacter.tga", tCharacterStyle_Street_TexX[i], 257)
	styleWindow:setTexture("Hover",				"UIData/CreateCharacter.tga", tCharacterStyle_Street_TexX[i], 257)
	styleWindow:setTexture("Pushed",			"UIData/CreateCharacter.tga", tCharacterStyle_Street_TexX[i], 306)
	styleWindow:setTexture("PushedOff",			"UIData/CreateCharacter.tga", tCharacterStyle_Street_TexX[i], 257)
	styleWindow:setTexture("SelectedNormal",	"UIData/CreateCharacter.tga", tCharacterStyle_Street_TexX[i], 306)
	styleWindow:setTexture("SelectedHover",		"UIData/CreateCharacter.tga", tCharacterStyle_Street_TexX[i], 306)
	styleWindow:setTexture("SelectedPushed",	"UIData/CreateCharacter.tga", tCharacterStyle_Street_TexX[i], 306)
	styleWindow:setTexture("SelectedPushedOff", "UIData/CreateCharacter.tga", tCharacterStyle_Street_TexX[i], 306)
	styleWindow:setPosition( tCharacterStyle_Street_PosX[i] , 244 )
	styleWindow:setSize(tCharacterStyle_Street_SizeX[i], 49)
	styleWindow:setProperty("GroupID", 1101)
	styleWindow:setZOrderingEnabled(false)
	styleWindow:setUserString("characterStyle_Street", i)
	styleWindow:setUserString("characterStyle_Street_Skill", tCharacterStyle_Street_Skill[i])
	styleWindow:setVisible(false)
	styleWindow:subscribeEvent("SelectStateChanged", "OnChangedSelectStreet")
	styleWindow:subscribeEvent("MouseEnter", "OnMouseEnter_characterStyle_Street")
	styleWindow:subscribeEvent("MouseLeave", "OnMouseLeave_characterStyle_Street")
	winMgr:getWindow("sj_creaetcharacter_classbackWindow_Alpha"):addChildWindow(styleWindow)
end

function InitAnimationView(skill_num)
	local PreviewWindow	= winMgr:getWindow("SkillViewerDisplay")
	local Rect = PreviewWindow:getPixelRect()
	
	--EndAnimationView()
	
	ReadAnimation(skill_num, 0)
	--[[
	SettingAnimationRect(Rect.top,
						 600,--Rect.left,
						 Rect.right-Rect.left,
						 Rect.bottom-Rect.top)
	--]]					 
	UpdateAnimationViewCharacter()
end

function EndAnimationView()
	ClearAnimation()
end

function ResetAnimationView()
	InitAnimationView(selected_skill)
end

function OnChangedSelectStreet(args)
	local local_window = CEGUI.toWindowEventArgs(args).window
	
	if CEGUI.toRadioButton(local_window):isSelected() == true then
		local Street_Index = local_window:getUserString("characterStyle_Street")
		local x,y = GetBasicRootPoint(local_window)
		
		--if g_PositionX ~= -1 then
			--SelectedSkillContent(912049)
			--SettingPreviewSkillRect(x, 420, 222, 154); -- left, top, width, height
			--SettingPreviewSkillRect(g_PositionX, 420, 222, 154); -- left, top, width, height
		--end
		
	end
	
	selected_skill = local_window:getUserString("characterStyle_Street_Skill");
	InitAnimationView(selected_skill)
end

function OnMouseEnter_characterStyle_Street(args)
	local eventWindow = CEGUI.toWindowEventArgs(args).window
	local skill_num = eventWindow:getUserString("characterStyle_Street_Skill");
	
	--InitAnimationView(skill_num)
	eventWindow:setProperty("Selected", "true");
	
	MuteSound(false)
end

function OnMouseLeave_characterStyle_Street(args)
	--InitAnimationView(selected_skill)
	MuteSound(true)
end


--------------------------------------------------------------------

-- 2. 프로레슬링,유도,합기도,삼보

--------------------------------------------------------------------
tCharacterStyle_Rush_TexX  = { ["protectErr"]=0, [0]=250, 313, 372, 431 }
tCharacterStyle_Rush_PosX  = { ["protectErr"]=0, [0]=15, 78, 137, 196 }
tCharacterStyle_Rush_SizeX = { ["protectErr"]=0, [0]=63, 59, 59, 63 }
tCharacterStyle_Rush_Skill = { ["protectErr"]=0, [0]=912048, 922048, 932048, 942048 }

for i=0, #tCharacterStyle_Rush_PosX do
	local styleWindow2 = winMgr:createWindow("TaharezLook/RadioButton", "Creaetcharacter_characterStyle_Rush_" .. i)
	styleWindow2:setTexture("Normal",			"UIData/CreateCharacter.tga", tCharacterStyle_Rush_TexX[i], 355)
	styleWindow2:setTexture("Hover",			"UIData/CreateCharacter.tga", tCharacterStyle_Rush_TexX[i], 355)
	styleWindow2:setTexture("Pushed",			"UIData/CreateCharacter.tga", tCharacterStyle_Rush_TexX[i], 404)
	styleWindow2:setTexture("PushedOff",		"UIData/CreateCharacter.tga", tCharacterStyle_Rush_TexX[i], 355)
	styleWindow2:setTexture("SelectedNormal",	"UIData/CreateCharacter.tga", tCharacterStyle_Rush_TexX[i], 404)
	styleWindow2:setTexture("SelectedHover",	"UIData/CreateCharacter.tga", tCharacterStyle_Rush_TexX[i], 404)
	styleWindow2:setTexture("SelectedPushed",	"UIData/CreateCharacter.tga", tCharacterStyle_Rush_TexX[i], 404)
	styleWindow2:setTexture("SelectedPushedOff","UIData/CreateCharacter.tga", tCharacterStyle_Rush_TexX[i], 404)
	styleWindow2:setPosition( tCharacterStyle_Rush_PosX[i] , 244)
	styleWindow2:setSize(tCharacterStyle_Rush_SizeX[i], 49)
	styleWindow2:setProperty("GroupID", 1101)
	styleWindow2:setZOrderingEnabled(false)
	styleWindow2:setUserString("characterStyle_Rush", i)
	styleWindow2:setUserString("characterStyle_Rush_Skill", tCharacterStyle_Rush_Skill[i])
	styleWindow2:setVisible(false)
	styleWindow2:subscribeEvent("SelectStateChanged", "OnChangedSelectRush")
	styleWindow2:subscribeEvent("MouseEnter", "OnMouseEnter_characterStyle_Rush")
	styleWindow2:subscribeEvent("MouseLeave", "OnMouseLeave_characterStyle_Rush")
	winMgr:getWindow("sj_creaetcharacter_classbackWindow_Alpha"):addChildWindow(styleWindow2)
end

function OnChangedSelectRush(args)
	local local_window = CEGUI.toWindowEventArgs(args).window
	
	if CEGUI.toRadioButton(local_window):isSelected() == true then
		local Rush_Index = local_window:getUserString("characterStyle_Rush")
		local x,y = GetBasicRootPoint(local_window)
		
		if g_PositionX ~= -1 then
			--SelectedSkillContent(912050)
			--SettingPreviewSkillRect(g_PositionX, 420, 222, 154); -- left, top, width, height
		end
		
	end
	
	selected_skill = local_window:getUserString("characterStyle_Rush_Skill");
	InitAnimationView(selected_skill)
end

function OnMouseEnter_characterStyle_Rush(args)
	local eventWindow = CEGUI.toWindowEventArgs(args).window
	local skill_num = eventWindow:getUserString("characterStyle_Rush_Skill");
	
	--InitAnimationView(skill_num)
	eventWindow:setProperty("Selected", "true");
	
	MuteSound(false)
end

function OnMouseLeave_characterStyle_Rush(args)
	--InitAnimationView(selected_skill)	
	MuteSound(true)
end

--------------------------------------------------------------------

-- 3. Preview Window Frame 

--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PreviewWindowFrame")
mywindow:setTexture("Enabled",	"UIData/CreateCharacter.tga", 250, 502)
mywindow:setTexture("Disabled",	"UIData/CreateCharacter.tga", 250, 502)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(15, 293)
mywindow:setSize(244, 165)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Shown", "OnShown_PreviewWindowFrame")
classwindow:addChildWindow(mywindow)

function OnShown_PreviewWindowFrame(args)
	AttachRenderTexture()
end

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SkillViewerDisplay")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(7, 0)
--mywindow:setPosition(100, -570)--test
mywindow:setSize(230, 157)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("PreviewWindowFrame"):addChildWindow(mywindow)

g_PositionX = -1;



function UpdateSkillViewerDisplay(texture)
	local window = winMgr:getWindow("SkillViewerDisplay")
	if window then
		window:setTexture("Enabled", texture, 0, 0)
		window:setSize(234, 155)
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
			winMgr:getWindow("sj_creaetcharacter_styleInfoWindow"):setTexture("Enabled", "UIData/CreateCharacter.tga", 250, tCharacterStyleInfoTexY[i])
			
			
		end
	end
end


function OnMouseLeave_style(args)
	winMgr:getWindow("sj_creaetcharacter_styleInfoWindow"):setVisible(false)
	
	for i=0, #tCharacterStyleTexY do
		local local_window = winMgr:getWindow(i.."sj_creaetcharacter_characterStyle")
		if CEGUI.toRadioButton(local_window):isSelected() == true then
			winMgr:getWindow("sj_creaetcharacter_styleInfoWindow"):setVisible(true)
			winMgr:getWindow("sj_creaetcharacter_styleInfoWindow"):setTexture("Enabled", "UIData/CreateCharacter.tga", 250, tCharacterStyleInfoTexY[i])
			
			
		end
	end
end

-- 캐릭터 스타일 선택이 변경되었을 때 첫번째 클래스 탭을 기본 선택해준다
function SelectFirstCategory(style)
	if style == 0 then
		winMgr:getWindow("Creaetcharacter_characterStyle_Street_0"):setProperty("Selected", "true")
	else
		winMgr:getWindow("Creaetcharacter_characterStyle_Rush_0"):setProperty("Selected", "true")
	end
end

-- 캐릭터 클래스 선택 OK버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_creaetcharacter_classOKBtn")
mywindow:setTexture("Normal",	"UIData/CreateCharacter.tga", 87, 705)
mywindow:setTexture("Hover",	"UIData/CreateCharacter.tga", 87, 741)
mywindow:setTexture("Pushed",	"UIData/CreateCharacter.tga", 87, 777)
mywindow:setTexture("PushedOff","UIData/CreateCharacter.tga", 87, 705)
mywindow:setTexture("Enabled",	"UIData/CreateCharacter.tga", 87, 777)
mywindow:setTexture("Disabled", "UIData/CreateCharacter.tga", 87, 777)
mywindow:setPosition(173, 474)
mywindow:setSize(98, 36)
mywindow:setVisible(false)
mywindow:subscribeEvent("Shown", "OnShown_ClassConfirm")
mywindow:subscribeEvent("Hidden", "OnHidden_ClassConfirm")
mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_ClassConfirm")
mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_ClassConfirm")
mywindow:subscribeEvent("Clicked", "OnClicked_ClassConfirm")

--mywindow:addController("ClassConfirmAlphaEvent", "ClassConfirmAlphaEvent", "alpha", "Sine_EaseInOut", 100, 255,   2, true, true, 10)
--mywindow:addController("ClassConfirmAlphaEvent", "ClassConfirmAlphaEvent", "alpha", "Sine_EaseInOut", 255, 255, 7, true, true, 10)
--mywindow:addController("ClassConfirmAlphaEvent", "ClassConfirmAlphaEvent", "alpha", "Sine_EaseInOut", 255, 100,   2, true, true, 10)

alphaclasswindow:addChildWindow(mywindow)

function activateMotionClassConfirm()
	local window = winMgr:getWindow("sj_creaetcharacter_classOKBtn")
	window:addController("ClassConfirmAlphaEvent", "ClassConfirmAlphaEvent", "alpha", "Sine_EaseInOut", 100, 255,   2, true, true, 10)
	window:addController("ClassConfirmAlphaEvent", "ClassConfirmAlphaEvent", "alpha", "Sine_EaseInOut", 255, 255, 7, true, true, 10)
	window:addController("ClassConfirmAlphaEvent", "ClassConfirmAlphaEvent", "alpha", "Sine_EaseInOut", 255, 100,   2, true, true, 10)
	window:activeMotion("ClassConfirmAlphaEvent")
end

function deactivateMotionClassConfirm()
	local window = winMgr:getWindow("sj_creaetcharacter_classOKBtn")
	window:clearActiveController("ClassConfirmAlphaEvent")
	window:clearActiveController()
	window:setAlphaWithChild(255)
end

function OnShown_ClassConfirm(args)
	activateMotionClassConfirm()
end

function OnHidden_ClassConfirm(args)
	deactivateMotionClassConfirm()
end

function OnMouseEnter_ClassConfirm(args)
	deactivateMotionClassConfirm()
end

function OnMouseLeave_ClassConfirm(args)
	activateMotionClassConfirm()
end

function OnClicked_ClassConfirm(args)
	winMgr:getWindow("sj_creaetcharacter_classOKBtn"):setVisible(false)
	
	-- 말레이시아가 아닐 경우 기본 설정 상태로 visible되고
	-- 말레이시아일 경우에만 설정 값을 변경하여 보여준다.
	-- 윈도우가 닫혔다가 다시 뜨거나 실행중에 말레이시아에서
	-- 그 외 국가로 변경될 경우가 없기때문에 덮어쓴 값을 기본설정 값으로
	-- 복구하도록 고려되지 않았다.
	--if (IsThaiLanguage() == false and IsEngLanguage() == false) or TEST_MAS_MODE then
		VERTICAL_PITCH = 33
		
		--winMgr:getWindow("sj_creaetcharacter_Skin_BackImage_alpha"):setVisible(false)
		winMgr:getWindow("sj_creaetcharacter_Hair_BackImage_alpha"):setPosition(73, 21+VERTICAL_PITCH*0)
		winMgr:getWindow("sj_creaetcharacter_Face_BackImage_alpha"):setPosition(73, 21+VERTICAL_PITCH*1)
		winMgr:getWindow("sj_creaetcharacter_Upper_BackImage_alpha"):setPosition(73, 21+VERTICAL_PITCH*2)
		winMgr:getWindow("sj_creaetcharacter_Down_BackImage_alpha"):setPosition(73, 21+VERTICAL_PITCH*3)
		winMgr:getWindow("sj_creaetcharacter_Shoes_BackImage_alpha"):setPosition(73, 21+VERTICAL_PITCH*4)
		
		winMgr:getWindow("sj_creaetcharacter_Reset_Btn"):setPosition(29, 189)
		winMgr:getWindow("sj_creaetcharacter_Random_Btn"):setPosition(120, 189)
	--end
	
	alphaCharacterwindow:setVisible(true)
	
	--[[
	winMgr:getWindow("sj_creaetcharacter_classOKBtn"):setVisible(false)
	winMgr:getWindow("sj_creaetcharacter_decisionBtn"):setVisible(true)
	winMgr:getWindow("sj_creaetcharacter_namebackWindow"):setVisible(true)
	winMgr:getWindow("sj_creaetcharacter_name1backWindow"):activeMotion("nameAlphaEvent")
	]]--
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

-- 돌아가기

--------------------------------------------------------------------
alphaCancelBtn = winMgr:createWindow("TaharezLook/StaticImage", "sj_creaetcharacter_CancelBtn_Alpha")
alphaCancelBtn:setTexture("Enabled",  "UIData/invisible.tga", 0, 0)
alphaCancelBtn:setProperty("FrameEnabled",	 "False")
alphaCancelBtn:setProperty("BackgroundEnabled","False")
alphaCancelBtn:setWideType(9011)--1
alphaCancelBtn:setPosition(29, 707)
--alphaCancelBtn:setSize(274, 521)
alphaCancelBtn:setSize(274, 31)
alphaCancelBtn:setZOrderingEnabled(false)
alphaCancelBtn:setVisible(true)
root:addChildWindow(alphaCancelBtn)


mywindow = winMgr:createWindow("TaharezLook/Button", "sj_creaetcharacter_cancelBtn")
mywindow:setTexture("Normal",		"UIData/CreateCharacter.tga", 0, 537)
mywindow:setTexture("Hover",		"UIData/CreateCharacter.tga", 0, 568)
mywindow:setTexture("Pushed",		"UIData/CreateCharacter.tga", 0, 599)
mywindow:setTexture("PushedOff",	"UIData/CreateCharacter.tga", 0, 537)
mywindow:setWideType(0);
--mywindow:setPosition(29, 707)
mywindow:setPosition(0, 0)
mywindow:setSize(87, 31)
mywindow:subscribeEvent("Clicked", "WndCreateCharacter_GotoWndSelectChannel")
alphaCancelBtn:addChildWindow(mywindow)


function WndCreateCharacter_Restoration()
	Restoration()
	ChangeGauge()
end

function SetStageBackButton(flag)	
	winMgr:getWindow("sj_creaetcharacter_cancelBtn"):setEnabled(flag)
	winMgr:getWindow("sj_creaetcharacter_cancelBtn"):setVisible(flag)
end








--------------------------------------------------------------------

-- EditBox Window

--------------------------------------------------------------------
namewindow_alpha = winMgr:createWindow("TaharezLook/StaticImage", "sj_creaetcharacter_nameWindow_alpha")
namewindow_alpha:setTexture("Enabled",  "UIData/invisible.tga", 0, 0)
namewindow_alpha:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
namewindow_alpha:setProperty("FrameEnabled",	 "False")
namewindow_alpha:setProperty("BackgroundEnabled","False")
namewindow_alpha:setWideType(9011);
namewindow_alpha:setPosition(394, 626)
namewindow_alpha:setSize(236, 114)
namewindow_alpha:setZOrderingEnabled(false)
namewindow_alpha:setVisible(false)
root:addChildWindow(namewindow_alpha)

namewindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_creaetcharacter_namebackWindow")
namewindow:setTexture("Enabled",	"UIData/CreateCharacter.tga", 494, 304)
--namewindow:setTexture("Disabled",	"UIData/CreateCharacter.tga", 494, 304)
--namewindow:setTexture("Enabled",	"UIData/frame/frame_001.tga", 0 , 0)
--namewindow:setTexture("Disabled",	"UIData/frame/frame_001.tga", 0 , 0)
--namewindow:setframeWindow(true)
namewindow:setProperty("FrameEnabled",		"False")
namewindow:setProperty("BackgroundEnabled", "False")
namewindow:setWideType(0)
--namewindow:setPosition(394, 626)
namewindow:setPosition(0, 0)
--namewindow:setSize(204, 38)
--namewindow:setScaleWidth(295)
--namewindow:setScaleHeight(484)
namewindow:setSize(236, 72)
namewindow:setZOrderingEnabled(false)
--namewindow:setVisible(false)
namewindow_alpha:addChildWindow(namewindow)

name2window = winMgr:createWindow("TaharezLook/StaticImage", "sj_creaetcharacter_name1backWindow")
name2window:setTexture("Enabled",  "UIData/CreateCharacter.tga", 0, 834)
name2window:setProperty("FrameEnabled", "False")
name2window:setProperty("BackgroundEnabled", "False")
name2window:setWideType(0)
--name2window:setPosition(16, 14)
name2window:setPosition(16, 15)
--name2window:setPosition(394+16, 626+14)
name2window:setSize(204, 38)
name2window:setZOrderingEnabled(false)
--name2window:addController("nameAlphaEvent", "nameAlphaEvent", "alpha", "Sine_EaseInOut", 0, 255,   4, true, true, 10)
--name2window:addController("nameAlphaEvent", "nameAlphaEvent", "alpha", "Sine_EaseInOut", 255, 255, 3, true, true, 10)
--name2window:addController("nameAlphaEvent", "nameAlphaEvent", "alpha", "Sine_EaseInOut", 255, 0,   4, true, true, 10)
--name2window:setVisible(false)

name2window:subscribeEvent("MouseClick", "OnMouseClick_name1backWindow")
namewindow:addChildWindow(name2window)
--root:addChildWindow(name2window)

-- sj_creaetcharacter_name1backWindow 와 IDEditbox의 위치와 크기차이를
-- 보정하기위해 sj_creaetcharacter_name1backWindow에서도 클릭이벤트를
-- 처리하여 IDEditbox가 동작할 수 있도록 해준다.
-- IDEditbox의 setAlphaWithChild(0)설정 부분을 주석처리하여 실행해보면
-- 차이를 볼수있다.
-- 에디트박스의 text 정렬 관련기능을 지원하지 않는것같다.
function OnMouseClick_name1backWindow(args)
	winMgr:getWindow("IDEditbox"):activate()
end

-- 아이디 입력 에디트박스
mywindow = winMgr:createWindow("TaharezLook/Editbox", "IDEditbox")
mywindow:setWideType(0)
mywindow:setAlphaWithChild(0)
--mywindow:setPosition(6, 19)
--mywindow:setPosition(394+16+3, 626+14+7)
mywindow:setPosition(16+3, 14+7)
--mywindow:setPosition(394+16+3, 626+14+7)
mywindow:setSize(198, 26)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 15)
mywindow:setTextColor(72, 64, 58, 255)
mywindow:setText("      Character Name")
--mywindow:setVisible(false)
--mywindow:activate()
namewindow:addChildWindow(mywindow)
--root:addChildWindow(mywindow)
CEGUI.toEditbox(winMgr:getWindow("IDEditbox")):setMaxTextLength(32)
CEGUI.toEditbox(winMgr:getWindow("IDEditbox")):subscribeEvent("Activated", "OnActivated_IDEditbox")
CEGUI.toEditbox(winMgr:getWindow("IDEditbox")):subscribeEvent("Deactivated", "OnDeactivated_IDEditbox")
--CEGUI.toEditbox(winMgr:getWindow("IDEditbox")):subscribeEvent("CharacterKey", "OnCharacterKey_IDEditbox")

local isFirstChangeActive = true

function OnActivated_IDEditbox(args)
	if isFirstChangeActive then
		isFirstChangeActive = false
		winMgr:getWindow("IDEditbox"):setTextColor(0, 0, 0, 255)
		winMgr:getWindow("IDEditbox"):setText("")
		winMgr:getWindow("IDEditbox"):setMaxTextLength(12)
		
		winMgr:getWindow("sj_creaetcharacter_decisionBtn"):setEnabled(true)
	end
	name2window:setTexture("Enabled",  "UIData/CreateCharacter.tga", 0, 872)
end

function OnDeactivated_IDEditbox(args)
	name2window:setTexture("Enabled",  "UIData/CreateCharacter.tga", 0, 834)
end

--[[
function OnCharacterKey_IDEditbox(args)
	local name = winMgr:getWindow("IDEditbox"):getText()
	local len  = string.len(name)
	
	DebugStr("len.."..len)
	
	if len >= 4 then
		winMgr:getWindow("sj_creaetcharacter_decisionBtn"):setEnabled(true)
	else
		winMgr:getWindow("sj_creaetcharacter_decisionBtn"):setEnabled(false)
	end
end
--]]



--------------------------------------------------------------------

-- 결정 버튼

--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_creaetcharacter_decisionBtn")
mywindow:setTexture("Normal",	"UIData/CreateCharacter.tga", 87, 537)
mywindow:setTexture("Hover",	"UIData/CreateCharacter.tga", 87, 579)
mywindow:setTexture("Pushed",	"UIData/CreateCharacter.tga", 87, 621)
mywindow:setTexture("PushedOff","UIData/CreateCharacter.tga", 87, 537)
mywindow:setTexture("Disabled",	"UIData/CreateCharacter.tga", 87, 663)
mywindow:setEnabled(false)
--mywindow:setWideType(0)
--mywindow:setPosition(466, 698)
mywindow:setPosition(72, 72)
mywindow:setSize(92, 42)
--mywindow:setVisible(false)
mywindow:subscribeEvent("Clicked", "CreationButtonClick")
namewindow_alpha:addChildWindow(mywindow)
--root:addChildWindow(mywindow)

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
	
	winMgr:getWindow("sj_creaetcharacter_decisionBtn"):setVisible(false)
	winMgr:getWindow("sj_creaetcharacter_cancelBtn"):setVisible(false)
	--winMgr:getWindow("sj_creaetcharacter_namebackWindow"):setVisible(false)
	winMgr:getWindow("sj_creaetcharacter_nameWindow_alpha"):setVisible(false)
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


-----------------------------------------------------------------------
--테스트 용
-----------------------------------------------------------------------
--[
root:subscribeEvent("KeyUp", "OnKeyUp_Root");

function OnKeyUp_Root(args)
	local keyEvent = CEGUI.toKeyEventArgs(args);
	
	if keyEvent.scancode == 122 then
		EndAnimationView()
		--winMgr:destroyWindow("SkillViewerDisplay")
		CallPopupOption()
		--InitAnimationView(selected_skill)
		return
	end
end
--]]


end