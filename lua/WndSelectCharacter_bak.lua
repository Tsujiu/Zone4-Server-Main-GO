function WndSelectCharacter_WndSelectCharacter()


-----------------------------------------
-- Script Entry Point
-----------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()

local g_STRING_REPEAT_ID	= PreCreateString_1655	--GetSStringInfo(LAN_LUA_SELECT_CHANNEL_14)	-- 삭제할 아이디를 다시한번 입력해 주세요.
local g_STRING_DELETE_DESC	= PreCreateString_1656	--GetSStringInfo(LAN_LUA_SELECT_CHANNEL_15)	-- [!] 삭제시 친구목록도 모두 삭제됩니다.
local g_STRING_DELETE_DESC2	= PreCreateString_3496	--GetSStringInfo(LAN_CHARACTER_DEL_002)		-- 캐릭터 삭제는 1일 3회만 가능합니다.

local MAX_SLOT, POSSIBLE_SLOT = WndSelectCharacter_GetPossibleSlot()
local USER_INFO_X = 620
local USER_INFO_Y = 702

local g_CharaterName  = { ["err"]=0, [0] = "", [1] = "", [2] = "", [3] = "" , [4] = "" , [5] = "" , [6] = "" }
local g_CharaterLevel = { ["err"]=0, [0] = 0, [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0 }
local g_CharaterClass = { ["err"]=0, [0] = "", [1] = "", [2] = "", [3] = "" , [4] = "" , [5] = "" , [6] = "" }

local g_CharaterSlot		= 6
local g_SelectCharaterIndex = -1
local LanguageType			= GetLanguageType()

------------------------------------------------------------

-- 배경 이미지

------------------------------------------------------------
function WndSelectCharacter_RenderBackImage()
	drawer:drawTexture("UIData/channel_002.tga", 0, 0, 1024, 69, 0, 936, WIDETYPE_5)	-- 윗쪽 바
	--drawer:drawTexture("UIData/channel_002.tga", 355, 0, 314, 45, 493, 801, WIDETYPE_5)	-- Select Character
	drawer:drawTexture("UIData/channel_001.tga", 335, USER_INFO_Y-10, 354, 64, 508, 540, WIDETYPE_7)	-- 케릭터 이름바
end




------------------------------------------------------------

-- 입장하기

------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_SelectCharacter_CreateButton")
mywindow:setTexture("Normal", "UIData/channel_001.tga", 0, 988)
mywindow:setTexture("Hover", "UIData/channel_001.tga", 130, 988)
mywindow:setTexture("Pushed", "UIData/channel_001.tga", 260, 988)
mywindow:setTexture("PushedOff", "UIData/channel_001.tga", 0, 988)
mywindow:setWideType(7);
mywindow:setPosition(446, USER_INFO_Y-46)
mywindow:setSize(130, 36)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "WndSelectCharacter_EnterChannel")
root:addChildWindow(mywindow)


------------------------------------------------------------

-- 채널로 돌아가기

------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_SelectCharacter_GoChannelButton")
mywindow:setTexture("Normal", "UIData/channel_001.tga", 936, 676)
mywindow:setTexture("Hover", "UIData/channel_001.tga", 936, 701)
mywindow:setTexture("Pushed", "UIData/channel_001.tga", 936, 726)
mywindow:setTexture("PushedOff", "UIData/channel_001.tga", 936, 676)
mywindow:setWideType(2);
mywindow:setPosition(10, USER_INFO_Y+27)
mywindow:setSize(88, 25)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickedGoChannel")
root:addChildWindow(mywindow)

function ClickedGoChannel(args)
	BtnPageMove_GoToWndSelectChannel()
end


------------------------------------------------------------

-- 삭제하기 버튼

------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_SelectCharacter_DeleteButton")
mywindow:setTexture("Normal", "UIData/channel_001.tga", 936, 776)
mywindow:setTexture("Hover", "UIData/channel_001.tga", 936, 801)
mywindow:setTexture("Pushed", "UIData/channel_001.tga", 936, 826)
mywindow:setTexture("PushedOff", "UIData/channel_001.tga", 936, 776)
mywindow:setWideType(2);
mywindow:setPosition(105, USER_INFO_Y+27)
mywindow:setSize(88, 25)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "DeleteCharacter")
root:addChildWindow(mywindow)

function DeleteCharacter()
	winMgr:getWindow("sj_SelectCharacter_Del_AlphaWindow"):setVisible(true)
	winMgr:getWindow("sj_realDelete_showWindow"):setVisible(true)
	winMgr:getWindow("sj_realDelete_descWindow"):setPosition(84, 94)
	winMgr:getWindow("sj_realDelete_descWindow"):clearTextExtends()
	winMgr:getWindow("sj_realDelete_descWindow"):setViewTextMode(1)
	winMgr:getWindow("sj_realDelete_descWindow"):setAlign(8)
	winMgr:getWindow("sj_realDelete_descWindow"):setLineSpacing(5)
	winMgr:getWindow("sj_realDelete_descWindow"):addTextExtends(g_STRING_REPEAT_ID.."\n", g_STRING_FONT_GULIMCHE, 14, 255,255,255,255, 2, 0,0,0,255)
	winMgr:getWindow("sj_realDelete_descWindow"):addTextExtends(g_STRING_DELETE_DESC, g_STRING_FONT_GULIMCHE, 14, 255,200,80,255, 2, 0,0,0,255)
	
	if IsKoreanLanguage() then
		winMgr:getWindow("sj_realDelete_descWindow2"):setVisible(true)
		winMgr:getWindow("sj_realDelete_descWindow2"):setPosition(84, 190)
		winMgr:getWindow("sj_realDelete_descWindow2"):clearTextExtends()
		winMgr:getWindow("sj_realDelete_descWindow2"):setViewTextMode(1)
		winMgr:getWindow("sj_realDelete_descWindow2"):setAlign(8)
		winMgr:getWindow("sj_realDelete_descWindow2"):setLineSpacing(5)
		winMgr:getWindow("sj_realDelete_descWindow2"):addTextExtends(g_STRING_DELETE_DESC2, g_STRING_FONT_GULIMCHE, 14, 255,100,100,255, 2, 0,0,0,255)
	end
	winMgr:getWindow("sj_realDelete_editbox"):activate()
end

function DeleteCharacter_OK()
	local characterName = winMgr:getWindow("sj_realDelete_editbox"):getText()
	local characterNumber
	for i=0, POSSIBLE_SLOT-1 do
		if CEGUI.toRadioButton(winMgr:getWindow("sj_character_"..i)):isSelected() then
			characterNumber = winMgr:getWindow("sj_character_"..i):getUserString("characterNumber")
		end
	end
	WndSelectCharacter_DeleteCharacter(tonumber(characterNumber), tostring(characterName))
	
	DeleteCharacter_CANCEL()
end


function DeleteCharacter_CANCEL()
	winMgr:getWindow("sj_SelectCharacter_Del_AlphaWindow"):setVisible(false)
	winMgr:getWindow("sj_realDelete_showWindow"):setVisible(false)
	winMgr:getWindow("sj_realDelete_editbox"):setText("")
--	winMgr:getWindow("sj_realDelete_editbox"):deactivate()
end




------------------------------------------------------------

-- 왼쪽 케릭터 선택 라디오 버튼

------------------------------------------------------------
tCharacterTypeTexX = { ["err"]=0, [0]=0, 0, 0, 416, 416, 416 }
tCharacterTypeTexY = { ["err"]=0, [0]=676, 780, 884, 676, 780, 884 }
for i=0, MAX_SLOT-1 do
	slotwindow = winMgr:createWindow("TaharezLook/RadioButton", "sj_character_"..i)
	slotwindow:setTexture("Normal", "UIData/channel_001.tga", 748, 436)
	slotwindow:setTexture("Hover", "UIData/channel_001.tga", 748, 436)
	slotwindow:setTexture("Pushed", "UIData/channel_001.tga", 748, 436)
	slotwindow:setTexture("PushedOff", "UIData/channel_001.tga", 748, 436)
	slotwindow:setTexture("SelectedNormal", "UIData/channel_001.tga", 748, 436)
	slotwindow:setTexture("SelectedHover", "UIData/channel_001.tga", 748, 436)
	slotwindow:setTexture("SelectedPushed", "UIData/channel_001.tga", 748, 436)
	slotwindow:setTexture("SelectedPushedOff", "UIData/channel_001.tga", 748, 436)
	slotwindow:setTexture("Enabled", "UIData/channel_001.tga", 748, 436)
	slotwindow:setTexture("Disabled", "UIData/channel_001.tga", 748, 436)
	slotwindow:setWideType(5);
	slotwindow:setPosition(140+(i*106), 80)
	slotwindow:setSize(104, 104)
	slotwindow:setProperty("GroupID", 1501)
	slotwindow:setUserString("characterNumber", i)
	slotwindow:setZOrderingEnabled(false)
	slotwindow:subscribeEvent("SelectStateChanged", "ChangeSelectCharacter")
	root:addChildWindow(slotwindow)
end


-- 케릭터 이미지 위에 이름을 쓸려고 임시윈도우를 생성한다.
tempwindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_SelectCharacter_tempWindow")
tempwindow:setProperty("FrameEnabled", "False")
tempwindow:setProperty("BackgroundEnabled", "False")
tempwindow:setEnabled(false)
tempwindow:setVisible(true)
tempwindow:setZOrderingEnabled(false)
tempwindow:subscribeEvent("EndRender", "DrawSlotCharacterName")
root:addChildWindow(tempwindow)


-- 케릭터를 변경했을때
function ChangeSelectCharacter(args)	
	--DebugStr("캐릭터변경")
	local local_window = CEGUI.toWindowEventArgs(args).window
	if CEGUI.toRadioButton(local_window):isSelected() == true then
		local characterNumber = local_window:getUserString("characterNumber")
		--DebugStr("캐릭터 넘버 : " .. characterNumber)
		WndSelectCharacter_ChangeSelectCharacter(tonumber(characterNumber))
	end
end

-- 슬롯에 케릭터가 없을 때
function WndSelectCharacter_EmptyCharacter(i)
	winMgr:getWindow("sj_character_"..i):setEnabled(true)
	winMgr:getWindow("sj_character_"..i):setTexture("Normal", "UIData/channel_001.tga", 832, 676)
	winMgr:getWindow("sj_character_"..i):setTexture("Hover", "UIData/channel_001.tga", 832, 780)
	winMgr:getWindow("sj_character_"..i):setTexture("Pushed", "UIData/channel_001.tga", 832, 884)
	winMgr:getWindow("sj_character_"..i):setTexture("PushedOff", "UIData/channel_001.tga", 832, 676)
	winMgr:getWindow("sj_character_"..i):setTexture("SelectedNormal", "UIData/channel_001.tga", 832, 884)
	winMgr:getWindow("sj_character_"..i):setTexture("SelectedHover", "UIData/channel_001.tga", 832, 884)
	winMgr:getWindow("sj_character_"..i):setTexture("SelectedPushed", "UIData/channel_001.tga", 832, 884)
	winMgr:getWindow("sj_character_"..i):setTexture("SelectedPushedOff", "UIData/channel_001.tga", 832, 884)
	winMgr:getWindow("sj_character_"..i):setTexture("Enabled", "UIData/channel_001.tga", 832, 676)
end

-- 슬롯에 케릭터가 있을 때
function WndSelectCharacter_ExistCharacter(i, type, name)
	winMgr:getWindow("sj_character_"..i):setEnabled(true)
	winMgr:getWindow("sj_character_"..i):setTexture("Normal", "UIData/channel_001.tga", tCharacterTypeTexX[type], tCharacterTypeTexY[type])
	winMgr:getWindow("sj_character_"..i):setTexture("Hover", "UIData/channel_001.tga", tCharacterTypeTexX[type]+104, tCharacterTypeTexY[type])
	winMgr:getWindow("sj_character_"..i):setTexture("Pushed", "UIData/channel_001.tga", tCharacterTypeTexX[type]+208, tCharacterTypeTexY[type])
	winMgr:getWindow("sj_character_"..i):setTexture("PushedOff", "UIData/channel_001.tga", tCharacterTypeTexX[type], tCharacterTypeTexY[type])
	winMgr:getWindow("sj_character_"..i):setTexture("SelectedNormal", "UIData/channel_001.tga", tCharacterTypeTexX[type]+208, tCharacterTypeTexY[type])
	winMgr:getWindow("sj_character_"..i):setTexture("SelectedHover", "UIData/channel_001.tga", tCharacterTypeTexX[type]+208, tCharacterTypeTexY[type])
	winMgr:getWindow("sj_character_"..i):setTexture("SelectedPushed", "UIData/channel_001.tga", tCharacterTypeTexX[type]+208, tCharacterTypeTexY[type])
	winMgr:getWindow("sj_character_"..i):setTexture("SelectedPushedOff", "UIData/channel_001.tga", tCharacterTypeTexX[type]+208, tCharacterTypeTexY[type])
	winMgr:getWindow("sj_character_"..i):setTexture("Enabled", "UIData/channel_001.tga", tCharacterTypeTexX[type], tCharacterTypeTexY[type])
end


function WndSelectCharacter_DisableCharacterSlot(i)
	winMgr:getWindow("sj_character_"..i):setEnabled(false)
end


-- 현재 케릭터 선택
function WndSelectCharacter_CurrentCharacter(i)
	winMgr:getWindow("sj_character_"..i):setProperty("Selected", "true")
end


-- 삭제를 한후엔 모든 선택 초기화
function WndSelectCharacter_InitCharacterSlot()
	for i=0, POSSIBLE_SLOT-1 do
		winMgr:getWindow("sj_character_"..i):setProperty("Selected", "false")
	end
end


-- 슬롯에 있는 케릭터 이름 그리기
function DrawSlotCharacterName()
	for i=0, POSSIBLE_SLOT-1 do
		local currentIndex, name = WndSelectCharacter_DrawCharacterSlotName(i)

		drawer:setTextColor(255, 255, 255, 255)
		drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
		local strSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, name)
		if currentIndex then
			common_DrawOutlineText1(drawer, name, 126+(i*106)+66-(strSize/2), 166, 0,0,0,255, 255,205,86,255, WIDETYPE_5)
		else
			common_DrawOutlineText1(drawer, name, 126+(i*106)+66-(strSize/2), 166, 0,0,0,255, 255,255,255,255, WIDETYPE_5)
		end
	end
end







------------------------------------------------------------

-- C에서 오는 케릭터 정보 그리기

------------------------------------------------------------
function WndSelectCharacter_RenderCharacterInfo(level, expPercent, currExp, levelTable, name, istyle, ladder, promotion, attribute)
	
	-- 레벨
	drawer:setTextColor(255,205,86,255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 14)
	drawer:drawText("Lv." .. level, 360, USER_INFO_Y, WIDETYPE_7)
	
	-- 래더
	drawer:drawTexture("UIData/numberUi001.tga", 400, USER_INFO_Y-4, 47, 21, 113, 600+21*ladder, WIDETYPE_7)
	
	-- 이름
	drawer:setTextColor(97,230,255,255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 14)
	local nameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 14, tostring(name))
	drawer:drawText(name, 512-nameSize/2, USER_INFO_Y, WIDETYPE_7)
	
	-- 스타일
	drawer:drawTexture("UIData/Skill_up2.tga", 600, USER_INFO_Y-10,  89, 35,  tAttributeImgTexXTable[istyle][attribute], tAttributeImgTexYTable[istyle][attribute], WIDETYPE_7)
	drawer:drawTexture("UIData/Skill_up2.tga", 600, USER_INFO_Y-10,  89, 35,  promotionImgTexXTable[istyle], promotionImgTexYTable[promotion], WIDETYPE_7)

	-- 경험치 퍼센트
	drawer:setTextColor(255,205,86,255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	drawer:drawText(expPercent .. " %", 644, USER_INFO_Y+32, WIDETYPE_7)
	
	-- 경험치 이미지
	if expPercent > 100 then
		expPercent = 100
	end
	drawer:drawTexture("UIData/channel_001.tga", 389, USER_INFO_Y+31, expPercent*240/100, 13, 508, 527, WIDETYPE_7)	
	
	-- 경험치 상태글자
	drawer:setTextColor(255,255,255,255)
	local currentExpText = currExp .. " / " ..  levelTable
	local currentExpSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(currentExpText))
	drawer:drawText(currentExpText, 512-currentExpSize/2, USER_INFO_Y+33, WIDETYPE_7)
	
end

---------------------------------------------------------------------------------------

-- 휴면 유저

--------------------------------------------------------------------------------------
if IsThaiLanguage() or IsEngLanguage() or IsGSPLanguage() then----0421KSG
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "QuiescenceEvent_AlphaWindow")
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

	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "QuiescenceEvent_BackImage")
	mywindow:setTexture("Enabled",	"UIData/frame/frame_001.tga", 0 , 0)
	mywindow:setTexture("Disabled", "UIData/frame/frame_001.tga", 0 , 0)
	mywindow:setframeWindow(true)
	mywindow:setWideType(6)
	mywindow:setPosition(218 , 165)
	mywindow:setSize(620, 540)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(true)
	winMgr:getWindow("QuiescenceEvent_AlphaWindow"):addChildWindow(mywindow)

	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "QuiescenceEvent_MainImage")
	mywindow:setTexture("Enabled", "UIData/Event_QuiescenceEvent.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/Event_QuiescenceEvent.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(16, 16)
	mywindow:setSize(588, 508)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("QuiescenceEvent_BackImage"):addChildWindow(mywindow)

	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "QuiescenceEvent_DropMainImage")
	mywindow:setTexture("Enabled", "UIData/Event_QuiescenceEvent.tga", 0, 508)
	mywindow:setTexture("Disabled", "UIData/Event_QuiescenceEvent.tga", 0, 508)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(46, 365)
	mywindow:setSize(490, 35)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("QuiescenceEvent_MainImage"):addChildWindow(mywindow)

	mywindow = winMgr:createWindow("TaharezLook/Button", "QuiescenceEvent_DropButton")
	mywindow:setTexture("Normal", "UIData/Event_QuiescenceEvent.tga", 490, 508)
	mywindow:setTexture("Hover", "UIData/Event_QuiescenceEvent.tga", 490, 539)
	mywindow:setTexture("Pushed", "UIData/Event_QuiescenceEvent.tga", 490, 570)
	mywindow:setTexture("PushedOff", "UIData/Event_QuiescenceEvent.tga", 490, 601)
	mywindow:setPosition(503, 367)
	mywindow:setSize(31, 31)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(true)
	mywindow:subscribeEvent("Clicked", "QuiescenceEventSelectDropOpen")
	winMgr:getWindow("QuiescenceEvent_MainImage"):addChildWindow(mywindow)

	mywindow = winMgr:createWindow("TaharezLook/Button", "QuiescenceEvent_OkButton")
	mywindow:setTexture("Normal", "UIData/Event_QuiescenceEvent.tga", 588, 0)
	mywindow:setTexture("Hover", "UIData/Event_QuiescenceEvent.tga", 588, 48)
	mywindow:setTexture("Pushed", "UIData/Event_QuiescenceEvent.tga", 588, 96)
	mywindow:setTexture("PushedOff", "UIData/Event_QuiescenceEvent.tga", 588, 144)
	mywindow:setPosition(217, 440)
	mywindow:setSize(128, 48)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(true)
	mywindow:subscribeEvent("Clicked", "QuiescenceEventOKButton")
	winMgr:getWindow("QuiescenceEvent_MainImage"):addChildWindow(mywindow)

	mywindow = winMgr:createWindow("TaharezLook/StaticText", "QuiescenceEvent_DropName")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
	mywindow:setText(PreCreateString_4353)
	mywindow:setPosition(98, 0)
	mywindow:setSize(170, 36)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	winMgr:getWindow("QuiescenceEvent_DropMainImage"):addChildWindow(mywindow)


	for i = 0, g_CharaterSlot do
		mywindow = winMgr:createWindow("TaharezLook/RadioButton", "QuiescenceEvent_CharaterNameButton"..i)
		mywindow:setTexture("Normal", "UIData/Event_QuiescenceEvent.tga", 0, 543)
		mywindow:setTexture("Hover", "UIData/Event_QuiescenceEvent.tga", 0, 571)
		mywindow:setTexture("Pushed", "UIData/Event_QuiescenceEvent.tga", 0, 571)
		mywindow:setTexture("SelectedNormal", "UIData/Event_QuiescenceEvent.tga", 0, 571)
		mywindow:setTexture("SelectedHover", "UIData/Event_QuiescenceEvent.tga", 0, 571)
		mywindow:setTexture("SelectedPushed", "UIData/Event_QuiescenceEvent.tga", 0, 571)
		mywindow:setWideType(6)
		mywindow:setSize(490, 28)
		mywindow:setPosition(279, 585 + (i * 30) )
		mywindow:setUserString("Index", i)
		mywindow:setProperty("GroupID", 11255)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:setVisible(false)
		mywindow:setSubscribeEvent("SelectStateChanged", "QuiescenceEventSelectDropClose")
		mywindow:setSubscribeEvent("MouseButtonDown",	 "QuiescenceEventSelectCharater")
		winMgr:getWindow("QuiescenceEvent_AlphaWindow"):addChildWindow(mywindow)
		
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "QuiescenceEvent_CharaterName"..i)
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(255, 255, 255, 255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 15)
		mywindow:setText("")
		mywindow:setPosition(30, 0)
		mywindow:setSize(490, 28)
		mywindow:setAlwaysOnTop(false)
		mywindow:setEnabled(false)
		winMgr:getWindow("QuiescenceEvent_CharaterNameButton"..i):addChildWindow(mywindow)
		
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "QuiescenceEvent_CharaterLevel"..i)
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(255, 255, 255, 255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 15)
		mywindow:setText("")
		mywindow:setPosition(185, 0)
		mywindow:setSize(490, 28)
		mywindow:setAlwaysOnTop(false)
		mywindow:setEnabled(false)
		winMgr:getWindow("QuiescenceEvent_CharaterNameButton"..i):addChildWindow(mywindow)
		
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "QuiescenceEvent_CharaterClass"..i)
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setTextColor(255, 255, 255, 255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 15)
		mywindow:setText("")
		mywindow:setPosition(300, 0)
		mywindow:setSize(490, 28)
		mywindow:setAlwaysOnTop(false)
		mywindow:setEnabled(false)
		winMgr:getWindow("QuiescenceEvent_CharaterNameButton"..i):addChildWindow(mywindow)
	end
end

function QuiescenceEventInit()
	winMgr:getWindow("QuiescenceEvent_AlphaWindow"):setVisible(true)
	
	g_CharaterName[0], g_CharaterName[1], g_CharaterName[2], g_CharaterName[3] , g_CharaterName[4], g_CharaterName[5]
	, g_CharaterName[6] = CharaterNameSetting()
	
	g_CharaterLevel[0], g_CharaterLevel[1], g_CharaterLevel[2], g_CharaterLevel[3] , g_CharaterLevel[4], g_CharaterLevel[5]
	, g_CharaterLevel[6] = CharaterLevelSetting()
	
	g_CharaterClass[0], g_CharaterClass[1], g_CharaterClass[2], g_CharaterClass[3] , g_CharaterClass[4], g_CharaterClass[5]
	, g_CharaterClass[6] = CharaterClassSetting()
		
	
	for i = 0, g_CharaterSlot do
		if g_CharaterName[i] ~= "" then
			winMgr:getWindow("QuiescenceEvent_CharaterName"..i):setText("Name : "..g_CharaterName[i])
			winMgr:getWindow("QuiescenceEvent_CharaterLevel"..i):setText("Level : "..g_CharaterLevel[i])
			winMgr:getWindow("QuiescenceEvent_CharaterClass"..i):setText("Class : "..g_CharaterClass[i])
		end
	end
end

function QuiescenceEventSelectCharater(args)
	local EnterWindow		= CEGUI.toWindowEventArgs(args).window:getUserString("Index")
	g_SelectCharaterIndex	= tonumber(EnterWindow)
	
	winMgr:getWindow("QuiescenceEvent_DropName"):setText("Name : "..g_CharaterName[g_SelectCharaterIndex]..
				"    Level : "..g_CharaterLevel[g_SelectCharaterIndex].."    Class : "..g_CharaterClass[g_SelectCharaterIndex])
end

function QuiescenceEventSelectDropClose()
	for i = 0, g_CharaterSlot do
		winMgr:getWindow("QuiescenceEvent_CharaterNameButton"..i):setVisible(false)
	end
end

function QuiescenceEventSelectDropOpen()
	if winMgr:getWindow("QuiescenceEvent_CharaterNameButton0"):isVisible() then
		QuiescenceEventSelectDropClose()
		return
	end
	
	DebugStr(g_CharaterName[0])
	
	for i = 0, g_CharaterSlot do
		if g_CharaterName[i] ~= "" then
			winMgr:getWindow("QuiescenceEvent_CharaterNameButton"..i):setVisible(true)
		end
	end
end

function QuiescenceEventOKButton()
	if g_SelectCharaterIndex < 0 then
		ShowNotifyOKMessage_Lua(PreCreateString_4353)
								--GetSStringInfo(LAN_Vacation_Event_Reward_001)
		return
	end
	
	ComeBackUserReQuest(g_SelectCharaterIndex)
	g_SelectCharaterIndex = -1
	winMgr:getWindow("QuiescenceEvent_AlphaWindow"):setVisible(false)
end


----------------------------------------------------------------

-- 정말로 삭제 하시겠습니까? 확인, 취소버튼

----------------------------------------------------------------
tDeleteCharacterName  = { ["protecterr"]=0, "sj_realDelete_OK_btn", "sj_realDelete_CANCEL_btn" }
tDeleteCharacterTexX  = { ["protecterr"]=0, 693, 858}
tDeleteCharacterPosX  = { ["protecterr"]=0, 4, 169}
tDeleteCharacterEvent = { ["protecterr"]=0, "DeleteCharacter_OK", "DeleteCharacter_CANCEL" }

-- 삭제 알파창
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_SelectCharacter_Del_AlphaWindow")
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

-- 파티 매치 ESC키 등록
RegistEscEventInfo("sj_SelectCharacter_Del_AlphaWindow", "DeleteCharacter_CANCEL")

-- 삭제 보일창
deletewindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_realDelete_showWindow")
deletewindow:setTexture("Enabled", "UIData/popup001.tga", 0, 0)
deletewindow:setTexture("Disabled", "UIData/popup001.tga", 0, 0)
deletewindow:setProperty("FrameEnabled", "False")
deletewindow:setProperty("BackgroundEnabled", "False")
deletewindow:setWideType(6);
deletewindow:setPosition(338, 246)
deletewindow:setSize(346, 275)
deletewindow:setVisible(false)
deletewindow:setAlwaysOnTop(true)
deletewindow:setZOrderingEnabled(false)
root:addChildWindow(deletewindow)


-- 삭제 아이디 에디트 박스
mywindow = winMgr:createWindow("TaharezLook/Editbox", "sj_realDelete_editbox")
mywindow:setText("")
mywindow:setPosition(80, 180)
mywindow:setSize(180, 24)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 15)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:subscribeEvent("TextAccepted", "DeleteCharacter_OK")
deletewindow:addChildWindow(mywindow)
CEGUI.toEditbox(winMgr:getWindow("sj_realDelete_editbox")):setMaxTextLength(12)


-- 삭제 내용창
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_realDelete_descWindow")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setText("")
mywindow:setPosition(30, 100)
mywindow:setSize(170, 36)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
deletewindow:addChildWindow(mywindow)

-- 삭제 내용창
mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_realDelete_descWindow2")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setText("")
mywindow:setPosition(30, 130)
mywindow:setSize(170, 36)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
deletewindow:addChildWindow(mywindow)

for i=1, 2 do
	mywindow = winMgr:createWindow("TaharezLook/Button", tDeleteCharacterName[i])
	mywindow:setTexture("Normal", "UIData/popup001.tga", tDeleteCharacterTexX[i], 849)
	mywindow:setTexture("Hover", "UIData/popup001.tga", tDeleteCharacterTexX[i], 878)
	mywindow:setTexture("Pushed", "UIData/popup001.tga", tDeleteCharacterTexX[i], 907)
	mywindow:setTexture("PushedOff", "UIData/popup001.tga", tDeleteCharacterTexX[i], 849)
	mywindow:setPosition(tDeleteCharacterPosX[i], 235)
	mywindow:setSize(166, 29)
	mywindow:setAlwaysOnTop(true)
	mywindow:subscribeEvent("Clicked", tDeleteCharacterEvent[i])
	deletewindow:addChildWindow(mywindow)
end



---------------------------------------------------------------

-- 현재 변신 중인지 체크

---------------------------------------------------------------
function WndSelectCharacter_CurrentTransform(description)

	drawer:setTextColor(255,255,255,255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	local size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, description)
	common_DrawOutlineText1(drawer, description, 512-size/2, USER_INFO_Y-60, 0,0,0,255, 255,200,80,255,WIDETYPE_6)
end

end
