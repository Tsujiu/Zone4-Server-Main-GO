--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
guiSystem:setGUISheet(root)


-- 스트링
local String_Get_CouponItems			= PreCreateString_1224	--GetSStringInfo(LAN_LUA_WND_MYINFO_32)			-- %d개의 아이템을 획득 하셨습니다.\n\n※획득하신 아이템은 선물함에서\n확인할 수 있습니다
local String_Get_CouponItem				= PreCreateString_1225	--GetSStringInfo(LAN_LUA_WND_MYINFO_33)			-- 아이템을 획득 하셨습니다.\n\n※획득하신 아이템은 선물함에서\n확인할 수 있습니다
local String_Input_CouponNumber			= PreCreateString_1223	--GetSStringInfo(LAN_LUA_WND_MYINFO_31)			-- 쿠폰번호 30자를 입력해주세요.


local CommonRoom_Hear	= 0	-- 헤어
local CommonRoom_Upper= 1	-- 상의
local CommonRoom_Lower= 2	-- 하의
local CommonRoom_Hat	= 3	-- 모자(머리위)
local CommonRoom_Ring	= 4	-- 반지

local CommonRoom_Face	= 5	-- 얼굴
local CommonRoom_Hand	= 6	-- 손
local CommonRoom_Foot	= 7	-- 신발
local CommonRoom_Back	= 8	-- 가방
local CommonRoom_Set	= 9	-- 세트


local tItemWearTable = {['err'] = 0, [0]=CommonRoom_Upper, CommonRoom_Lower, CommonRoom_Hand, CommonRoom_Foot, CommonRoom_Face,
											CommonRoom_Hear, CommonRoom_Back, CommonRoom_Hat, CommonRoom_Ring}
											
											
											
local CharacterInfoBackName = GetEachBaseBackName()


-- 캐릭터 기본 정보 ==============
local CommonRoomCharacterBaseInfoWnd = winMgr:createWindow("TaharezLook/StaticImage", "CommonRoom_BaseInfoBack")
CommonRoomCharacterBaseInfoWnd:setTexture("Enabled", "UIData/myinfo.tga", 230, 364)
CommonRoomCharacterBaseInfoWnd:setPosition(2,450)
CommonRoomCharacterBaseInfoWnd:setSize(250, 70)
CommonRoomCharacterBaseInfoWnd:setVisible(true)
CommonRoomCharacterBaseInfoWnd:setAlwaysOnTop(true)
CommonRoomCharacterBaseInfoWnd:setZOrderingEnabled(false)
CharacterInfoBackName:addChildWindow(CommonRoomCharacterBaseInfoWnd)

mywindow = winMgr:createWindow("TaharezLook/StaticText", "CR_CharacterName")
mywindow:setPosition(60, 13)
mywindow:setSize(130, 15)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)	
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
CommonRoomCharacterBaseInfoWnd:addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticText", "CR_LevelText")
mywindow:setPosition(18, 46)
mywindow:setSize(20, 18)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)	
mywindow:setFont(g_STRING_FONT_GULIM, 12)
mywindow:setTextColor(255, 255, 255, 255)
CommonRoomCharacterBaseInfoWnd:addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CR_LadderImage")
mywindow:setTexture("Disabled", "UIData/numberUi001.tga", 113, 684)
mywindow:setPosition(60, 27)
mywindow:setSize(47, 21)
mywindow:setVisible(true)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
CommonRoomCharacterBaseInfoWnd:addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticText", "CR_LadderText")
mywindow:setPosition(100, 30)
mywindow:setSize(20, 18)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)	
mywindow:setFont(g_STRING_FONT_GULIM, 10)
mywindow:setTextColor(255, 255, 255, 255)
CommonRoomCharacterBaseInfoWnd:addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CR_ExpGauge")
mywindow:setTexture("Enabled", "UIData/myinfo.tga", 230, 434)
mywindow:setPosition(62, 50)
mywindow:setSize(144, 8)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
CommonRoomCharacterBaseInfoWnd:addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticText", "CR_ExpGaugeText")
mywindow:setPosition(62, 50)
mywindow:setSize(144, 10)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)	
CommonRoomCharacterBaseInfoWnd:addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticText", "CR_TransformText")
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setTextColor(87,242,9,255)
mywindow:setPosition(10, 432)
mywindow:setSize(20, 18)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
CharacterInfoBackName:addChildWindow(mywindow)


-- 변신했는지..
function CommonRoom_SetTransFormName(String)
	winMgr:getWindow("CR_TransformText"):setText(String)
end

-- 캐릭터 착용 장비

-- 캐릭터 착용장비 뒷판(일반/스페셜) ==============
local CommonRoomWearedItemMain = winMgr:createWindow("TaharezLook/StaticImage", "CommonRoom_WearedItemBack")
CommonRoomWearedItemMain:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
CommonRoomWearedItemMain:setPosition(254,10)
CommonRoomWearedItemMain:setSize(230, 150)
CommonRoomWearedItemMain:setVisible(true)
CommonRoomWearedItemMain:setAlwaysOnTop(true)
CommonRoomWearedItemMain:setZOrderingEnabled(false)
CharacterInfoBackName:addChildWindow(CommonRoomWearedItemMain)

-- 착용중인 아이템 이미지 윈도우
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CommonRoom_WearedItemWin")
mywindow:setTexture("Enabled", "UIData/myinfo.tga", 0, 364)
mywindow:setPosition(0, 19)
mywindow:setSize(230, 113)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
CommonRoomWearedItemMain:addChildWindow(mywindow)


-- 일반 착용 장비, 스페셜장비 선택 버튼
local SelectWearName	= {['protecterr']=0, [0]="CommonRoom_WearedItem_Normal", "CommonRoom_WearedItem_Special"}
local SelectWearTexX	= {['protecterr']=0, [0]=		505,	567}
local SelectWearPosX	= {['protecterr']=0, [0]=		1,		65}

for i=0, #SelectWearName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", SelectWearName[i])
	mywindow:setTexture("Normal", "UIData/myinfo3.tga", SelectWearTexX[i], 186)
	mywindow:setTexture("Hover", "UIData/myinfo3.tga", SelectWearTexX[i], 207 )
	mywindow:setTexture("Pushed", "UIData/myinfo3.tga", SelectWearTexX[i], 228 )
	mywindow:setTexture("SelectedNormal", "UIData/myinfo3.tga", SelectWearTexX[i], 228 )
	mywindow:setTexture("SelectedHover", "UIData/myinfo3.tga", SelectWearTexX[i], 228 )
	mywindow:setTexture("SelectedPushed", "UIData/myinfo3.tga", SelectWearTexX[i], 228 )
	mywindow:setPosition(SelectWearPosX[i], 0)
	mywindow:setProperty("GroupID", 16)
	mywindow:setSize(62, 21)
--	if i == 1 then
--		mywindow:setVisible(false)
--	end
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:setUserString("Index", tostring(i))
	mywindow:subscribeEvent("SelectStateChanged", "CommonRoom_SelectWearedItemType")
	CommonRoomWearedItemMain:addChildWindow(mywindow)
end



-- 아이템을 붙이는 부위별로 가지고있는다.
local tWearAttachName	  = {['err']=0, [0]= "CommonRoomWear_Hear", "CommonRoomWear_Upper", "CommonRoomWear_Lower"
											, "CommonRoomWear_Hat", "CommonRoomWear_Ring", "CommonRoomWear_Face"
											, "CommonRoomWear_Hand", "CommonRoomWear_Foot", "CommonRoomWear_Back", "CommonRoomWear_Set"} 
local tWearAttachItemName = {['err']=0, [0]= "CommonRoom_Hear_Item", "CommonRoom_Upper_Item", "CommonRoom_Lower_Item"
											, "CommonRoom_Hat_Item", "CommonRoom_Ring_Item", "CommonRoom_Face_Item"
											, "CommonRoom_Hand_Item", "CommonRoom_Foot_Item", "CommonRoom_Back_Item", "CommonRoom_Set_Item"}
local tWearAttachButtonName = {['err']=0, [0]= "CommonRoom_Hear_Button", "CommonRoom_Upper_Button", "CommonRoom_Lower_Button"
											, "CommonRoom_Hat_Button", "CommonRoom_Ring_Button", "CommonRoom_Face_Button"
											, "CommonRoom_Hand_Button", "CommonRoom_Foot_Button", "CommonRoom_Back_Button", "CommonRoom_Set_Button"}
											
local tWearAttachPosX = {['err']=0, [0]= 0,41,82,136,177, 0,41,82,136,177}
local tWearAttachPosY = {['err']=0, [0]= 0,0,0,0,0, 41,41,41,41,41}

for i=0, #tWearAttachName do
	-- 이미지 위에 덮어쓰는 아이콘 이미지.
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", tWearAttachName[i])
	mywindow:setTexture("Enabled", "UIData/my_room.tga", 556,573)
	mywindow:setPosition(tWearAttachPosX[i] + 6, tWearAttachPosY[i] + 24)
	mywindow:setSize(41, 41)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	CommonRoomWearedItemMain:addChildWindow(mywindow)

	-- 아이템을 뿌려줄 투명이미지(요건 축소를 하는거라서 좀 크게 이미지를 잡아야한다.)
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", tWearAttachItemName[i])
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0,0)
	mywindow:setPosition(3,2)
	mywindow:setSize(110, 110)
	mywindow:setScaleHeight(90)	-- 축소해놓는다.
	mywindow:setScaleWidth(90)		-- 축소해놓는다.
	mywindow:setEnabled(false)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setLayered(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUseEventController(false)	-- 이벤트를 받지 않는다.
	winMgr:getWindow(tWearAttachName[i]):addChildWindow(mywindow)
	
	-- 스킬 등급
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", tWearAttachItemName[i].."_gradeImg")
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(tWearAttachPosX[i] + 16, tWearAttachPosY[i] + 26)
	mywindow:setSize(29, 16)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	CommonRoomWearedItemMain:addChildWindow(mywindow)
	
	-- 스킬레벨 + 글자
	mywindow = winMgr:createWindow("TaharezLook/StaticText", tWearAttachItemName[i].."_gradeText")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
	mywindow:setPosition(tWearAttachPosX[i] + 21, tWearAttachPosY[i] + 27)
	mywindow:setSize(40, 20)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	CommonRoomWearedItemMain:addChildWindow(mywindow)
	
	-- 마우스 들어온 효과위해 버튼
	mywindow = winMgr:createWindow("TaharezLook/Button", tWearAttachButtonName[i])
	mywindow:setTexture("Normal", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Hover", "UIData/my_room.tga", 597, 573)
	mywindow:setTexture("Pushed", "UIData/my_room.tga", 638, 573)
	mywindow:setTexture("PushedOff", "UIData/my_room.tga", 638, 573)
	mywindow:setTexture("Disabled", "UIData/my_room.tga", 556, 573)
	mywindow:setPosition(tWearAttachPosX[i] + 6, tWearAttachPosY[i] + 24)
	mywindow:setSize(41,41)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("Index", tostring(-1))
	mywindow:subscribeEvent("Clicked", "CommonRoom_Item_MouseClick")
	mywindow:subscribeEvent("MouseEnter", "CommonRoom_Item_MouseEnter")
	mywindow:subscribeEvent("MouseLeave", "CommonRoom_Item_MouseLeave")
	mywindow:subscribeEvent("MouseRButtonUp", "CommonRoom_Item_MouseRButtonUp")
	CommonRoomWearedItemMain:addChildWindow(mywindow)	
end

function CommonRoom_SelectWearedItemType(args)
	local EventWindow	= CEGUI.toWindowEventArgs(args).window 
	if CEGUI.toRadioButton(EventWindow):isSelected() then
		local Index = EventWindow:getUserString("Index")
			
		CommonRoomSelectedItemTypeItem(Index)		-- 변수 세팅해주고
		ShowCommonRoomWearItemSetting()
	end
end



function CommonRoom_Item_MouseEnter(args)
	local enterWindow	= CEGUI.toWindowEventArgs(args).window
	local x, y = GetBasicRootPoint(enterWindow)
	local ItemIndex = enterWindow:getUserString("Index")
	
	local itemNumber = GetCommonRoomTooltipInfo(ItemIndex)
	if itemNumber < 0 then
		return
	end
	GetToolTipBaseInfo(x + 43, y, 2, KIND_COSTUM, 0, itemNumber)
	SetShowToolTip(true)
end


function CommonRoom_Item_MouseLeave(args)
	SetShowToolTip(false)
end

function CommonRoom_Item_MouseClick(args)
	local enterWindow	= CEGUI.toWindowEventArgs(args).window

	local ItemIndex = enterWindow:getUserString("Index")
	CommonRoomUnWearItem(ItemIndex)
end

function CommonRoom_Item_MouseRButtonUp(args)
	local enterWindow	= CEGUI.toWindowEventArgs(args).window

	local ItemIndex = enterWindow:getUserString("Index")
	CommonRoomUnWearItem(ItemIndex)
end




mywindow = winMgr:createWindow("TaharezLook/Button", "CommonRoom_ShowSettingButton")
mywindow:setTexture("Normal", "UIData/myinfo.tga", 279, 622)
mywindow:setTexture("Hover", "UIData/myinfo.tga", 279, 640)
mywindow:setTexture("Pushed", "UIData/myinfo.tga", 279, 658)
mywindow:setTexture("PushedOff", "UIData/myinfo.tga", 279, 658)
mywindow:setTexture("Disabled", "UIData/myinfo.tga", 279, 676)
mywindow:setPosition(90, 108)
mywindow:setSize(108, 18)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "CommonRoom_ShowSettingButtonClick")
CommonRoomWearedItemMain:addChildWindow(mywindow)	


function CommonRoom_ShowSettingButtonClick()
	ShowShowPartInfowindow()
end

--[[
-- normal / special 체크박스
local tWearedItemTypeName	= {['protecterr'] = 0, [0]=	"CommonRoom_WearedItemNormal", "CommonRoom_WearedItemSpecial" }
local tWearedItemTypePosX	= {['protecterr'] = 0, [0]=		78,	152 }
local tWearedItemTypeEvent	= {['protecterr'] = 0, [0]=	"CommonRoom_WearedItemNormalCheckEvent", "CommonRoom_WearedItemSpecialCheckEvent" }

for i=0, #tWearedItemTypeName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tWearedItemTypeName[i])
	mywindow:setTexture("Normal", "UIData/popup001.tga", 441, 754)
	mywindow:setTexture("Hover", "UIData/popup001.tga", 441, 754)
	mywindow:setTexture("Pushed", "UIData/popup001.tga", 441, 773)
	mywindow:setTexture("PushedOff", "UIData/popup001.tga", 441, 754)
	mywindow:setTexture("SelectedNormal", "UIData/popup001.tga", 441, 773)
	mywindow:setTexture("SelectedHover", "UIData/popup001.tga", 441, 773)
	mywindow:setTexture("SelectedPushed", "UIData/popup001.tga", 441, 773)
	mywindow:setTexture("SelectedPushedOff", "UIData/popup001.tga", 441, 773)
	mywindow:setPosition(tWearedItemTypePosX[i], 109)
	mywindow:setSize(60, 17)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setProperty("GroupID", 17)
	mywindow:subscribeEvent("SelectStateChanged", tWearedItemTypeEvent[i])
	CommonRoomWearedItemMain:addChildWindow(mywindow)
end


function CommonRoom_WearedItemNormalCheckEvent(args)
	if CEGUI.toRadioButton(winMgr:getWindow("CommonRoom_WearedItemNormal")):isSelected() then
		SetWearedCostumeFlag(0)	
	end
end



function CommonRoom_WearedItemSpecialCheckEvent(args)
	if CEGUI.toRadioButton(winMgr:getWindow("CommonRoom_WearedItemSpecial")):isSelected() then
		SetWearedCostumeFlag(1)	
	end
end

-- 
function CommonRoom_ShowSelectEvent(flag)
	if CEGUI.toRadioButton(winMgr:getWindow(tWearedItemTypeName[flag])):isSelected() == false then
		winMgr:getWindow(tWearedItemTypeName[flag]):setProperty("Selected", "true")	
	end
end

--]]

-- 착용중인 장비를 보여준다()
function ShowCommonRoomWearItemSetting()
	if CharacterInfoBackName:isVisible() == false then
		return
	end
	for i = 0, #tWearAttachItemName do
		winMgr:getWindow(tWearAttachButtonName[i]):setUserString("Index", tostring(-1))		-- 내부 인덱스 초기화
		winMgr:getWindow(tWearAttachName[i]):setVisible(false)
		winMgr:getWindow(tWearAttachItemName[i]):setTexture("Enabled", "UIData/invisible.tga", 0,0)
		winMgr:getWindow(tWearAttachItemName[i]):setTexture("Disabled", "UIData/invisible.tga", 0,0)
		winMgr:getWindow(tWearAttachItemName[i]):setLayered(false)
		winMgr:getWindow(tWearAttachItemName[i].."_gradeImg"):setVisible(false)
		winMgr:getWindow(tWearAttachItemName[i].."_gradeText"):setText("")
		
	end

	for i = 0, #tItemWearTable do
		SetCommonRoomWearItem(i)
	end
end


-- 착용중인 장비 각각의 자리에 세팅해준다.
function ShowCommonRoomWearItem(AttachIndex, Index, fileName, fileName2, grade, FlagIndex)
	local wearIndex = tItemWearTable[AttachIndex]
	winMgr:getWindow(tWearAttachName[wearIndex]):setVisible(true)
	winMgr:getWindow(tWearAttachButtonName[wearIndex]):setUserString("Index", tostring(Index))		-- 내부 인덱스 초기화
	winMgr:getWindow(tWearAttachItemName[wearIndex]):setTexture("Enabled", fileName, 0,0)
	winMgr:getWindow(tWearAttachItemName[wearIndex]):setTexture("Disabled", fileName, 0,0)
	if fileName2 == "" then
		winMgr:getWindow(tWearAttachItemName[wearIndex]):setLayered(false)
	else
		winMgr:getWindow(tWearAttachItemName[wearIndex]):setLayered(true)
		winMgr:getWindow(tWearAttachItemName[wearIndex]):setTexture("Layered", fileName2, 0, 0)
	end
	
	
	if grade > 0 then
		winMgr:getWindow(tWearAttachItemName[wearIndex].."_gradeImg"):setVisible(true)
		winMgr:getWindow(tWearAttachItemName[wearIndex].."_gradeImg"):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[grade], 486)
		winMgr:getWindow(tWearAttachItemName[wearIndex].."_gradeText"):setTextColor(tGradeTextColorTable[grade][1], tGradeTextColorTable[grade][2], tGradeTextColorTable[grade][3], 255)
		winMgr:getWindow(tWearAttachItemName[wearIndex].."_gradeText"):setText("+"..grade)
	else
		winMgr:getWindow(tWearAttachItemName[wearIndex].."_gradeImg"):setVisible(false)
		winMgr:getWindow(tWearAttachItemName[wearIndex].."_gradeText"):setText("")
	end
end





-- 캐릭터 능력치 특수효과

-- 캐릭터 스텟정보, 특수효과 ===========
local CharacterAdditionInfo = winMgr:createWindow("TaharezLook/StaticImage", "CommonRoom_CharacterAdditionInfoBack")
CharacterAdditionInfo:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
CharacterAdditionInfo:setPosition(254, 151)
CharacterAdditionInfo:setSize(235, 371)
CharacterAdditionInfo:setVisible(true)
CharacterAdditionInfo:setAlwaysOnTop(true)
CharacterAdditionInfo:setZOrderingEnabled(false)
CharacterInfoBackName:addChildWindow(CharacterAdditionInfo)


-- 캐릭터 스텟정보, 특수효과 선택
local BackWindowName	= {['protecterr']=0, [0]="CommonRoom_StatInfoBack", "CommonRoom_SpecialEffectBack"}
local SelectName	= {['protecterr']=0, [0]="CommonRoom_StatInfoBtn", "CommonRoom_SpecialEffect"}
local SelectTexX	= {['protecterr']=0, [0]=		737,	811}
local SelectPosX	= {['protecterr']=0, [0]=		1,		77}

for i=0, #SelectName do	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", BackWindowName[i])
	mywindow:setTexture("Enabled", "UIData/myinfo.tga", i * 230, 15)
	mywindow:setPosition(0, 20)
	mywindow:setSize(230, 349)
	if i == 1 then
		mywindow:setVisible(false)
	end
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	CharacterAdditionInfo:addChildWindow(mywindow)
	
end

for i=0, #SelectName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", SelectName[i])
	mywindow:setTexture("Normal", "UIData/myinfo.tga", SelectTexX[i], 488)
	mywindow:setTexture("Hover", "UIData/myinfo.tga", SelectTexX[i], 488 + 22 )
	mywindow:setTexture("Pushed", "UIData/myinfo.tga", SelectTexX[i], 488 + 44 )
	mywindow:setTexture("Disabled", "UIData/myinfo.tga", SelectTexX[i], 488)
	mywindow:setTexture("SelectedNormal", "UIData/myinfo.tga", SelectTexX[i], 488 + 44 )
	mywindow:setTexture("SelectedHover", "UIData/myinfo.tga", SelectTexX[i], 488 + 44 )
	mywindow:setTexture("SelectedPushed", "UIData/myinfo.tga", SelectTexX[i], 488 + 44 )
	mywindow:setPosition(SelectPosX[i], 0)
	mywindow:setProperty("GroupID", 17)
	mywindow:setUserString("index", i)
	mywindow:setSize(74, 22)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:subscribeEvent("SelectStateChanged", "CommonRoom_SelectAdditionInfo")
	
	if i == 0 then
		CharacterAdditionInfo:addChildWindow(mywindow)
	end
end	

local tUserStatInfoTextName  = {['err']=0, [0]="CR_A_Atk", "CR_A_Gra", "CR_A_Team", "CR_A_Double", "CR_A_Special"
												, "CR_D_Atk", "CR_D_Gra", "CR_D_Team", "CR_D_Double", "CR_D_Special"
												, "CR_N_Hp", "CR_N_Sp", "CR_N_Cri", "CR_N_CriDamage", "CR_MannerP"}
local tUserStatInfoTextPosX  = {['err']=0, [0]=	135,135,135,135,135,135,135,135,135,135  ,120,120,120,120,120,120}
local tUserStatInfoTextPosY  = {['err']=0, [0]=	12+18*0, 12+18*1, 12+18*2, 12+18*3, 12+18*4, 
												21+18*5, 21+18*6, 21+18*7, 21+18*8, 21+18*9, 
												211, 211+18*1, 211+18*2, 211+18*3, 211+18*4}

local tCommonRoomBaseStatValue  = {['err']=0, [0]=0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
local tCommonRoomTotalStatValue = {['err']=0, [0]=0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
local tCommonRoomPlusStatValue  = {['err']=0, [0]=0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}

for i=0, #tUserStatInfoTextName do
	mywindow = winMgr:createWindow("TaharezLook/StaticText", tUserStatInfoTextName[i])
	mywindow:setPosition(tUserStatInfoTextPosX[i],tUserStatInfoTextPosY[i])
	mywindow:setSize(80, 18)
	mywindow:setZOrderingEnabled(false)	
	mywindow:setViewTextMode(1)
	mywindow:setAlign(8)
	mywindow:setLineSpacing(2)
	winMgr:getWindow("CommonRoom_StatInfoBack"):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "Total_"..tUserStatInfoTextName[i])
	mywindow:setPosition(tUserStatInfoTextPosX[i],tUserStatInfoTextPosY[i])
	mywindow:setSize(40, 18)
	mywindow:setZOrderingEnabled(false)	
	mywindow:setViewTextMode(1)
	mywindow:setAlign(6)
	mywindow:setLineSpacing(2)
	winMgr:getWindow("CommonRoom_StatInfoBack"):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "Plus_"..tUserStatInfoTextName[i])
	mywindow:setPosition(tUserStatInfoTextPosX[i] + 40,tUserStatInfoTextPosY[i])
	mywindow:setSize(40, 18)
	mywindow:setZOrderingEnabled(false)	
	mywindow:setViewTextMode(1)
	mywindow:setAlign(0)
	mywindow:setLineSpacing(2)
	winMgr:getWindow("CommonRoom_StatInfoBack"):addChildWindow(mywindow)
end


-- 부가정보(능력치, 특수효과) 선택 이벤트
function CommonRoom_SelectAdditionInfo(args)
	local EventWindow	= CEGUI.toWindowEventArgs(args).window 
	local index = tonumber(EventWindow:getUserString("index"))
	if CEGUI.toRadioButton(EventWindow):isSelected() then		
		if index == 1 then
			ShowCommonRoomBuff()
		end
		winMgr:getWindow(BackWindowName[index]):setVisible(true)
	else
		winMgr:getWindow(BackWindowName[index]):setVisible(false)
	end
end




-- 캐릭터의 전체 스텟정보를 세팅해주다.
function SettingCommonRoomTotalStatInfo(A_Atk, A_Gra, A_Team, A_Double, A_Special, D_Atk, D_Gra, D_Team, D_Double, D_Special
							, N_Hp, N_Sp, N_Cri, N_CriDamage, mannerP)
	tCommonRoomBaseStatValue = {['err']=0, [0]=A_Atk, A_Gra, A_Team, A_Double, A_Special, D_Atk, D_Gra, D_Team, D_Double, D_Special
							, N_Hp, N_Sp, N_Cri, N_CriDamage, mannerP}
end


-- 캐릭터의 아이템 / 칭호로 올라가는 스텟의 정보를 세팅해준다.
function SettingCommonRoomItemStatInfo(A_Atk, A_Gra, A_Team, A_Double, A_Special, D_Atk, D_Gra, D_Team, D_Double, D_Special
							, N_Hp, N_Sp, N_Cri, N_CriDamage, mannerP)
	tCommonRoomPlusStatValue = {['err']=0, [0]=A_Atk, A_Gra, A_Team, A_Double, A_Special, D_Atk, D_Gra, D_Team, D_Double, D_Special
							, N_Hp, N_Sp, N_Cri, N_CriDamage, mannerP}
end


-- 캐릭터 스텟 적용
function SettingCommonRoomStatApplication()
	for i=0, #tCommonRoomPlusStatValue do
		local baseString = tostring(tCommonRoomBaseStatValue[i])
		local plusString = tostring(tCommonRoomPlusStatValue[i])
		if i == 12 or i == 13 then
			baseString = tostring(tCommonRoomBaseStatValue[i]/10).."."..tostring(tCommonRoomBaseStatValue[i]%10).."%"--plusString.."%"
			plusString = tostring(tCommonRoomPlusStatValue[i]/10).."."..tostring(tCommonRoomPlusStatValue[i]%10).."%"--plusString.."%"
		end
		if tCommonRoomPlusStatValue[i] < 0 then		-- 아이템 스텟이 깍였을때.
			winMgr:getWindow(tUserStatInfoTextName[i]):clearTextExtends()
			winMgr:getWindow("Total_"..tUserStatInfoTextName[i]):setTextExtends(baseString, g_STRING_FONT_GULIM,11, 230,50,50,255,  0,  0,0,0,255);
			winMgr:getWindow("Plus_"..tUserStatInfoTextName[i]):setTextExtends("("..plusString..")", g_STRING_FONT_GULIM,11, 255,0,255,255,  0,  0,0,0,255);
		elseif tCommonRoomPlusStatValue[i] == 0 then	-- 아이엩 스텟이 없을때.
			winMgr:getWindow(tUserStatInfoTextName[i]):setTextExtends(baseString, g_STRING_FONT_GULIM,11, 255,255,255,255,  0,  0,0,0,255);
			winMgr:getWindow("Total_"..tUserStatInfoTextName[i]):clearTextExtends()
			winMgr:getWindow("Plus_"..tUserStatInfoTextName[i]):clearTextExtends()
		else								-- 아이템 스텟 가지고 있을떄.
			winMgr:getWindow(tUserStatInfoTextName[i]):clearTextExtends()
			winMgr:getWindow("Total_"..tUserStatInfoTextName[i]):setTextExtends(baseString, g_STRING_FONT_GULIM,11, 0,230,0,255,  0,  0,0,0,255);
			winMgr:getWindow("Plus_"..tUserStatInfoTextName[i]):setTextExtends("(+"..plusString..")", g_STRING_FONT_GULIM,11, 0,255,255,255,  0,  0,0,0,255);			
		end	
	end	
end



--------------------------------------------------------------------
-- 버프 뒷판
--------------------------------------------------------------------
local MAX_HEIGHT_COUNT	= 8
local BUF_SIZE			= 32
--local tBuffBooleanInfo = {['err'] = 0, false, 0, 0, "", ""}

for i = 0, MAX_HEIGHT_COUNT - 1 do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CommonRoom_Buf"..i)
	mywindow:setTexture("Enabled", "UIData/mainBG_button002.tga", 0, 788)
	mywindow:setTexture("Disabled", "UIData/mainBG_button002.tga", 0, 788)
	mywindow:setPosition(7, 7 + (BUF_SIZE + 7) * i) 
	mywindow:setSize(BUF_SIZE, BUF_SIZE)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("CommonRoom_SpecialEffectBack"):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "CommonRoom_BufTextDesc"..i)
	mywindow:setPosition(47, 8 + (BUF_SIZE + 7) * i) 
	mywindow:setSize(80, 18)
	mywindow:setZOrderingEnabled(false)
	mywindow:setFont(g_STRING_FONT_GULIM, 11)
	mywindow:setTextColor(230,0,230, 255)
	winMgr:getWindow("CommonRoom_SpecialEffectBack"):addChildWindow(mywindow)	
	
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "CommonRoom_BufTextTime"..i)
	mywindow:setPosition(47, 23 + (BUF_SIZE + 7) * i) 
	mywindow:setSize(80, 18)
	mywindow:setZOrderingEnabled(false)
	mywindow:setFont(g_STRING_FONT_GULIM, 11)
	mywindow:setTextColor(255, 255, 255, 255)
	winMgr:getWindow("CommonRoom_SpecialEffectBack"):addChildWindow(mywindow)
end




-- 버프 정보를 보여준다.
function ShowCommonRoomBuff()
	for i = 0, MAX_HEIGHT_COUNT - 1 do
		winMgr:getWindow("CommonRoom_Buf"..i):setTexture("Enabled", "UIData/mainBG_button002.tga", 0, 788)
		winMgr:getWindow("CommonRoom_BufTextDesc"..i):setText("")
		winMgr:getWindow("CommonRoom_BufTextTime"..i):setText("")
	end
	
	-- 칭호 정보
	local Count = 0
	-- 만약에 1페이짐면 해주는..
	local title = GetUserinfoTitleIndex()
	if title ~= 0 then
		TitleString = GetTitleEffectString(title)
		TitleString	= AdjustString(g_STRING_FONT_GULIM, 11, TitleString, 160)
		winMgr:getWindow("CommonRoom_Buf"..Count):setTexture("Enabled", "UIData/numberUi001.tga", 0, 992)
		winMgr:getWindow("CommonRoom_BufTextDesc"..Count):setText(TitleString)
		winMgr:getWindow("CommonRoom_BufTextTime"..Count):setText("")
		Count = Count + 1
	end
	
	
	local Max_count = GetMaxBufItem()
	for i = 0, Max_count-1 do
		local use, type	= GetUseBufItem(i)
		local desc = GetBuffDesc(i)
		local time = GetBuffRemainTime(i)
		local timestr = string.format(PreCreateString_2154, time)
										--GetSStringInfo(LAN_LUA_MYBUFF_REMAINTIME)
		
		if use then
			local TexXIndex = i % 20
			local TexYIndex = i / 20
			winMgr:getWindow("CommonRoom_Buf"..Count):setTexture("Enabled", "UIData/mainBG_button002.tga", 32+(TexXIndex*32), 788 + TexYIndex*32)
			winMgr:getWindow("CommonRoom_BufTextDesc"..Count):setText(desc)
			winMgr:getWindow("CommonRoom_BufTextTime"..Count):setText(timestr)
			Count = Count + 1
		end
	end		
end


-- 캐릭터 기본 정보를 보여준다.
function CommonRoomShowCharacterBaseInfo(characterName, clubTitleName, boneType, titleIndex, promotionIndex, level, exp, maxExp, laddergrade, ladderExp, wearTypeIndex)
	
	winMgr:getWindow("CR_CharacterName"):setTextExtends(characterName, g_STRING_FONT_GULIM,12, 255,255,255,255,  1,  0,0,0,255);
	
	-- 레벨
	winMgr:getWindow("CR_LevelText"):setText("Lv."..level)
	-- 래더
	winMgr:getWindow("CR_LadderImage"):setTexture("Disabled", "UIData/numberUi001.tga", 113, 600 + 21 * laddergrade)
	winMgr:getWindow("CR_LadderImage"):setScaleWidth(200)
	winMgr:getWindow("CR_LadderImage"):setScaleHeight(200)
	winMgr:getWindow("CR_LadderText"):setText("( "..ladderExp.." )")
	
	-- 직업 아이콘
--	winMgr:getWindow("UserInfoClassImage"):setTexture("Disabled", "UIData/skillitem001.tga", 497 + (promotionIndex % 2) * 88, 35 * (promotionIndex / 2))
--	winMgr:getWindow("UserInfoClassImage"):setScaleWidth(200)
--	winMgr:getWindow("UserInfoClassImage"):setScaleHeight(200)

	local GaugePersent = 0
	if maxExp > 0 then
		GaugePersent = exp * 100 / maxExp
		if GaugePersent > 100 then
			GaugePersent = 100
		end
	else
		exp = 0
	end 
	winMgr:getWindow("CR_ExpGauge"):setSize(144 * GaugePersent / 100, 8)
	local expText = tostring(exp).." / "..maxExp.." ("..GaugePersent.."%)"
	winMgr:getWindow("CR_ExpGaugeText"):setTextExtends(expText, g_STRING_FONT_GULIM,10, 255,198,0,255,  1,  0,0,0,255);
	
	local flag = GetShowFlag()
	
--	if CEGUI.toRadioButton(winMgr:getWindow(tWearedItemTypeName[flag])):isSelected() == false then
--		winMgr:getWindow(tWearedItemTypeName[flag]):setProperty("Selected", "true")	
--	end
	
	if CEGUI.toRadioButton(winMgr:getWindow(SelectWearName[wearTypeIndex])):isSelected() == false then
		winMgr:getWindow(SelectWearName[wearTypeIndex]):setProperty("Selected", "true")	
	end

	CharacterAdditionInfo:setVisible(true)		-- 스텟, 특수효과 윈도우
	if CEGUI.toRadioButton(winMgr:getWindow("CommonRoom_StatInfoBtn")):isSelected() == false then
		winMgr:getWindow("CommonRoom_StatInfoBtn"):setProperty("Selected", "true")	
	end

end




--------------------------------------------------------------------

-- 쿠폰 윈도우들

--------------------------------------------------------------------
--------------------------------------------------------------------
-- 쿠폰 바탕 이미지
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CommonRoom_CouponBackAlpha")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CommonRoom_CouponBackImg")
mywindow:setTexture("Enabled", "UIData/ranking.tga", 0, 455)
mywindow:setTexture("Disabled", "UIData/ranking.tga", 0, 455)
mywindow:setWideType(6)
mywindow:setPosition(302, 239)
mywindow:setSize(420, 238)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("CommonRoom_CouponBackAlpha"):addChildWindow(mywindow)


-- 쿠폰 팝업바탕 ESC키, ENTER키 등록
RegistEscEventInfo("CommonRoom_CouponBackAlpha", "CouponCancelButton")
RegistEnterEventInfo("CommonRoom_CouponBackAlpha", "CouponOKButton")


--------------------------------------------------------------------
-- 쿠폰 에디트 박스
--------------------------------------------------------------------
if IsKoreanLanguage() then
	tCouponEditName	= {['protecterr'] = 0, "CouponEdit1", "CouponEdit2", "CouponEdit3", "CouponEdit4", "CouponEdit5", "CouponEdit6" }
	tCouponEditPosX	= {['protecterr'] = 0,		25,			 25 + 64,	  25 + 64 * 2,	 25 + 64 * 3,	25 + 64 * 4,	25 + 64 * 5}
	tCouponEditEvent= {['protecterr'] = 0, "NextCouponEdit2", "NextCouponEdit3", "NextCouponEdit4", "NextCouponEdit5", "NextCouponEdit6", "NextCouponEdit1" }
else
	tCouponEditName	= {['protecterr'] = 0, "CouponEdit1", "CouponEdit2", "CouponEdit3", "CouponEdit4", "CouponEdit5" }
	tCouponEditPosX	= {['protecterr'] = 0,		25,			 25 + 80,	  25 + 80 * 2,	 25 + 80 * 3,	25 + 80 * 4}
	tCouponEditEvent= {['protecterr'] = 0, "NextCouponEdit2", "NextCouponEdit3", "NextCouponEdit4", "NextCouponEdit5", "NextCouponEdit1" }
end



for i = 1, #tCouponEditName do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CouponEditImage"..i)
	mywindow:setTexture("Enabled", "UIData/ranking.tga", 1, 693)
	mywindow:setTexture("Disabled", "UIData/ranking.tga", 1, 693)
	mywindow:setPosition(tCouponEditPosX[i] - 4, 124)
	mywindow:setSize(58, 27)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("CommonRoom_CouponBackImg"):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/Editbox", tCouponEditName[i])
	mywindow:setText("")
	mywindow:setPosition(tCouponEditPosX[i], 125)
	mywindow:setSize(50, 27)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 13)
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setAlphaWithChild(0)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(true)
	mywindow:setUseEventController(false)
	winMgr:getWindow("CommonRoom_CouponBackImg"):addChildWindow(mywindow);

	CEGUI.toEditbox(winMgr:getWindow(tCouponEditName[i])):setMaxTextLength(5)
	CEGUI.toEditbox(winMgr:getWindow(tCouponEditName[i])):subscribeEvent("EditboxFull", "CouponEditFull")
	CEGUI.toEditbox(winMgr:getWindow(tCouponEditName[i])):subscribeEvent("MouseClick", "CouponEditMouseClick");
	CEGUI.toEditbox(winMgr:getWindow(tCouponEditName[i])):subscribeEvent("TextAcceptedOnlyTab", tCouponEditEvent[i])
	CEGUI.toEditbox(winMgr:getWindow(tCouponEditName[i])):subscribeEvent("TextAccepted" , "CouponOKButton")
	CEGUI.toEditbox(winMgr:getWindow(tCouponEditName[i])):setUpper(true)	-- 소문자는 대문자로 바꿔준다

end

--------------------------------------------------------------------
-- 쿠폰 확인버튼
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "CommonRoom_CouponOKButton")
mywindow:setTexture("Normal", "UIData/ranking.tga", 420, 530)
mywindow:setTexture("Hover", "UIData/ranking.tga", 420, 571)
mywindow:setTexture("Pushed", "UIData/ranking.tga", 420, 612)
mywindow:setTexture("PushedOff", "UIData/ranking.tga", 420, 653)
mywindow:setPosition(150, 182)
mywindow:setSize(121, 41)
mywindow:setZOrderingEnabled(false)
mywindow:setVisible(true)
mywindow:subscribeEvent("Clicked", "CouponOKButton")
winMgr:getWindow("CommonRoom_CouponBackImg"):addChildWindow(mywindow)

--------------------------------------------------------------------
-- 쿠폰 취소버튼
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "CommonRoom_CouponCancelButton")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setPosition(388, 9)
mywindow:setSize(23, 23)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:subscribeEvent("Clicked", "CouponCancelButton")
winMgr:getWindow("CommonRoom_CouponBackImg"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- 쿠폰 붙여넣기 버튼
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "CommonRoom_CouponPasteButton")
mywindow:setTexture("Normal", "UIData/ranking.tga", 420, 530)
mywindow:setTexture("Hover", "UIData/ranking.tga", 420, 571)
mywindow:setTexture("Pushed", "UIData/ranking.tga", 420, 612)
mywindow:setTexture("PushedOff", "UIData/ranking.tga", 420, 653)
mywindow:setPosition(20, 182)
mywindow:setSize(121, 41)
mywindow:setZOrderingEnabled(false)
mywindow:setVisible(false)
mywindow:subscribeEvent("Clicked", "CouponPasteButton")
winMgr:getWindow("CommonRoom_CouponBackImg"):addChildWindow(mywindow)


--------------------------------------------------------------------

-- 쿠폰 함수들

--------------------------------------------------------------------
--------------------------------------------------------------------
-- 쿠폰창을 보여준다.
--------------------------------------------------------------------
function CouponShow()
	SetHanEnglishMode(0)	-- 영문모드로 설정
	winMgr:getWindow("CommonRoom_CouponBackAlpha"):setVisible(true)
	winMgr:getWindow("CouponEdit1"):activate();

end


--------------------------------------------------------------------
-- TAB을 눌렀을 때 반응하는 이벤트(엔터랑 겹쳐서 일단 빼놓음)
--------------------------------------------------------------------
function NextCouponEdit2()
	winMgr:getWindow("CouponEdit2"):setText("")
	winMgr:getWindow("CouponEdit2"):activate()
end

function NextCouponEdit3()
	winMgr:getWindow("CouponEdit3"):setText("")
	winMgr:getWindow("CouponEdit3"):activate()
end

function NextCouponEdit4()
	winMgr:getWindow("CouponEdit4"):setText("")
	winMgr:getWindow("CouponEdit4"):activate()
end

function NextCouponEdit5()
	winMgr:getWindow("CouponEdit5"):setText("")
	winMgr:getWindow("CouponEdit5"):activate()
end

function NextCouponEdit6()
	winMgr:getWindow("CouponEdit6"):setText("")
	winMgr:getWindow("CouponEdit6"):activate()
end

function NextCouponEdit1()
	winMgr:getWindow("CouponEdit1"):setText("")
	winMgr:getWindow("CouponEdit1"):activate()
end


--------------------------------------------------------------------
-- 숫자를 다 채우면 다음 박스로 이동시킨다.
--------------------------------------------------------------------
function CouponEditFull(args)
	DebugStr('aaaaaa')
	for i = 1, #tCouponEditName-1 do
		if winMgr:getWindow(tCouponEditName[i]):isActive() then
			winMgr:getWindow(tCouponEditName[i]):deactivate();
			if i ~= table.getn(tCouponEditName) then
				winMgr:getWindow(tCouponEditName[i + 1]):activate();
				winMgr:getWindow(tCouponEditName[i + 1]):setText("")
				return;
			end
		
		end
	end
end


--------------------------------------------------------------------
-- 클릭하면 내용을 다 지워버린다.
--------------------------------------------------------------------
function CouponEditMouseClick(args)
	for i = 1, #tCouponEditName do
		if winMgr:getWindow(tCouponEditName[i]):isActive() then
			winMgr:getWindow(tCouponEditName[i]):setText("")			
		end
	end
end


--------------------------------------------------------------------
-- 확인버튼을 눌렀을경우 발생하는 이벤트
--------------------------------------------------------------------
function CouponOKButton()
	local NumberText = ""
	
	for i = 1, #tCouponEditName do
		local Buf = winMgr:getWindow(tCouponEditName[i]):getText()
		if string.len(Buf) ~= 5 then
			ShowNotifyOKMessage_Lua(String_Input_CouponNumber)
			return;
		end
		NumberText = NumberText..Buf;
	end
	
	SendCouponNum(NumberText);		-- 쿠폰번호를 서버로 넘겨준다.
	
	for i = 1, #tCouponEditName do
		winMgr:getWindow(tCouponEditName[i]):setText("")
		--winMgr:getWindow(tCouponEditName[i]):deactivate()				
	end
	winMgr:getWindow("CommonRoom_CouponBackAlpha"):setVisible(false)
	SetHanEnglishMode(1)	-- 한글모드로 돌아가기
end


--------------------------------------------------------------------
-- 취소버튼을 눌렀을 경우
--------------------------------------------------------------------
function CouponCancelButton()
	for i = 1, #tCouponEditName do
		winMgr:getWindow(tCouponEditName[i]):setText("")			
	end
	winMgr:getWindow("CommonRoom_CouponBackAlpha"):setVisible(false)
	SetHanEnglishMode(1)	-- 한글모드로 돌아가기
	
end


--------------------------------------------------------------------
-- 붙여넣기버튼을 눌렀을 경우
--------------------------------------------------------------------
function CouponPasteButton()
	local couponStr;
	
	for i = 1, #tCouponEditName do
		couponStr = GetClipboardCouponNumber(i-1)
		
		if couponStr == -1 then
			return
		end
		
		winMgr:getWindow(tCouponEditName[i]):setText(couponStr)
	end
end


--------------------------------------------------------------------
-- 쿠폰을 입력하고 서버로부터 오는 리턴 값
--------------------------------------------------------------------
function CouponItemReturn(ItemName, Count)
	if Count > 1 then
		local String	= string.format(String_Get_CouponItems, tostring(Count))
		ShowNotifyOKMessage_Lua(String)
	else
		local String	= string.format(String_Get_CouponItem, ItemName)
		ShowNotifyOKMessage_Lua(String)		
	end
end






-- 상점이라면..
if winMgr:getWindow("Shop_AllBackImg") then


--------------------------------------------------------------------
-- 캐시 임시 보관함
--------------------------------------------------------------------
local Max_TemporaryCount = 10	-- 한페이지에 들어가는 아이템 갯수


--캐시 임시 보관함 뒷판
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CashTemporaryBack")
mywindow:setTexture("Enabled", "UIData/myinfo.tga", 0,863)
mywindow:setPosition(0,0)
mywindow:setSize(229, 141)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("Shop_AllBackImg"):addChildWindow(mywindow)


for i=0, Max_TemporaryCount-1 do
	-- 이미지 위에 덮어쓰는 아이콘 이미지.
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CashTemporaryItemBack_"..i)
	mywindow:setTexture("Enabled", "UIData/my_room.tga", 556,573)
	mywindow:setPosition((i%5)*41 + 6, (i/5)*41 + 24)
	mywindow:setSize(41, 41)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("CashTemporaryBack"):addChildWindow(mywindow)

	-- 아이템을 뿌려줄 투명이미지(요건 축소를 하는거라서 좀 크게 이미지를 잡아야한다.)
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CashTemporaryItemImg_"..i)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0,0)
	mywindow:setTexture("Layered", "UIData/invisible.tga", 0,0)
	mywindow:setPosition(3,2)
	mywindow:setSize(100, 100)
	mywindow:setScaleHeight(90)	-- 축소해놓는다.
	mywindow:setScaleWidth(90)		-- 축소해놓는다.
	mywindow:setEnabled(false)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setLayered(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUseEventController(false)	-- 이벤트를 받지 않는다.
	winMgr:getWindow("CashTemporaryItemBack_"..i):addChildWindow(mywindow)
	
	-- 아이템의 버튼(아이템 자체적인 버튼)
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", "CashTemporaryItemButton_"..i)
	mywindow:setTexture("Normal", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Hover", "UIData/Match002.tga", 667, 694)
	mywindow:setTexture("Pushed", "UIData/Match002.tga", 667, 742)
	mywindow:setTexture("PushedOff", "UIData/Match002.tga", 667, 26)
	mywindow:setTexture("SelectedNormal", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("SelectedHover", "UIData/Match002.tga", 667, 694)
	mywindow:setTexture("SelectedPushed", "UIData/Match002.tga", 667, 742)
	mywindow:setTexture("SelectedPushedOff", "UIData/Match002.tga", 667, 742)
	mywindow:setPosition((i%5)*41 + 6, (i/5)*41 + 24)
	mywindow:setSize(41, 41)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("Index", tostring(i))
	mywindow:subscribeEvent("MouseDoubleClicked", "CashTemporary_ItemdoubleClick")
	mywindow:subscribeEvent("MouseRButtonUp", "CashTemporary_MouseRButtonUp")
	mywindow:subscribeEvent("MouseEnter", "CashTemporary_ItemMouseEnter")
	mywindow:subscribeEvent("MouseLeave", "CashTemporary_ItemMouseLeave")
	winMgr:getWindow("CashTemporaryBack"):addChildWindow(mywindow)
	
	-- 랜덤 아이템 정보
	mywindow = winMgr:createWindow("TaharezLook/Button", "CashTemporary_DetailIInfoBtn_"..i)
	mywindow:setTexture("Normal", "UIData/reward_item.tga", 0, 173)
	mywindow:setTexture("Hover", "UIData/reward_item.tga", 0, 193)
	mywindow:setTexture("Pushed", "UIData/reward_item.tga", 0, 213)
	mywindow:setTexture("PushedOff", "UIData/reward_item.tga", 0, 233)
	mywindow:setPosition(30, 30)
	mywindow:setSize(20, 20)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("Index", tostring(i))
	mywindow:setSubscribeEvent("Clicked", "CashTemporary_ShowRandomOpenItem")
	winMgr:getWindow("CashTemporaryItemBack_"..i):addChildWindow(mywindow)
	
	
	-- 아이템 갯수 카운트
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "CashTemporaryItemCount_"..i)
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
	mywindow:setPosition(2, 2)
	mywindow:setSize(45, 20)
	mywindow:setAlign(6)
	mywindow:setLineSpacing(2)
	mywindow:setViewTextMode(1)
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(false)
	winMgr:getWindow("CashTemporaryItemBack_"..i):addChildWindow(mywindow)
end


-- 마우스의 오른쪽 버튼이 눌려졌을 때
function CashTemporary_MouseRButtonUp(args)
	

end



-- 마우스가 아이템에 들어왔을 때
function CashTemporary_ItemMouseEnter(args)


end


-- 포인터가 아이템에서 나갈 때
function CashTemporary_ItemMouseLeave(args)


end


-- 캐시 보관함을 세팅해준다.
function SettingCashTemporary(index, itemFileName, itemFileName2, itemQuantity, itemNumber)
	-- 아이템 이미지 경로
	winMgr:getWindow("CashTemporaryItemImg_"..index):setTexture("Disabled", itemFileName, 0,0)
	if itemFileName2 ~= "" then
		winMgr:getWindow("CashTemporaryItemImg_"..index):setLayered(true)
		winMgr:getWindow("CashTemporaryItemImg_"..index):setTexture("Layered", itemFileName2, 0,0)
	else
		winMgr:getWindow("CashTemporaryItemImg_"..index):setLayered(false)
	end

	-- 아이템 수량
	winMgr:getWindow("CashTemporaryItemCount_"..index):setTextExtends("x "..itemQuantity, g_STRING_FONT_DODUMCHE, 10,255,255,255,255,    2, 0,0,0,255)
	-- 아이템 종류에 따라 랜덤 아이템 내부 보는 버튼 추가
	if CheckDetailInfoBtn(itemNumber) then
		winMgr:getWindow("CashTemporary_DetailIInfoBtn_"..i):setVisible(true)
	end

end


-- 캐시 임시 보관함을 클리어해준다.
function ClearCashTemporary()
	-- 아이템 이미지 경로
	for i=0, Max_TemporaryCount-1 do
		winMgr:getWindow("CashTemporaryItemBack_"..i):setVisible(false)
		winMgr:getWindow("CashTemporaryItemButton_"..i):setVisible(false)
		winMgr:getWindow("CashTemporaryItemCount_"..i):setTextExtends("", g_STRING_FONT_DODUMCHE, 10,255,255,255,255,    2, 0,0,0,255)
		winMgr:getWindow("CashTemporary_DetailIInfoBtn_"..i):setVisible(false)		
	end
	
end


-- 랜덤 아이템 정보보는 버튼을 눌렀을때
function CashTemporary_ShowRandomOpenItem(args)
	local local_window = CEGUI.toWindowEventArgs(args).window;
	local index	= tonumber(local_window:getUserString('Index'))
	local x, y = GetBasicRootPoint(local_window)
	
	if x + 245 > g_MAIN_WIN_SIZEX then
		x = x - 245
	end
	if y + 175 > g_MAIN_WIN_SIZEY then
		y = y - 175
	end
	local itemNumber = ToC_GetCashTempRandomOpenItemNumber(index)
	ShowRandomOpenItem(itemNumber, x, y)
end



-- 캐시 보관함을 보여준다
function ShowCashTemporaryWindow()
	root:addChildWindow(winMgr:getWindow("CashTemporaryBack"))
	winMgr:getWindow("CashTemporaryBack"):setVisible(true)
end


-- 캐시보관함을 닫아준다.
function CloseCashTemporaryWindow()
	winMgr:getWindow("CashTemporaryBack"):setVisible(false)	
end










-- 오른쪽 클릭시 나오는 버튼-----------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CashTemporary_functionWindow")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(0,0)
mywindow:setSize(80, 40)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setUseEventController(false)
mywindow:setUserString("index", tostring(-1))
root:addChildWindow(mywindow)

RegistEscEventInfo("CashTemporary_functionWindow", "HideCashTemporaryfunctionWindow")


function HideCashTemporaryfunctionWindow()
	winMgr:getWindow('CashTemporary_functionWindow'):setVisible(false)	
end


mywindow = winMgr:createWindow("TaharezLook/Button", "CashTemporary_functionTakeOutBtn")
mywindow:setTexture("Normal", "UIData/Match002.tga", 510, 497)
mywindow:setTexture("Hover", "UIData/Match002.tga", 510, 517)
mywindow:setTexture("Pushed", "UIData/Match002.tga", 510, 537)
mywindow:setTexture("PushedOff", "UIData/Match002.tga", 510, 537)
mywindow:setTexture("Disabled", "UIData/Match002.tga", 510, 557)
mywindow:setPosition(0, 0)
mywindow:setSize(80, 20)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "functionTakeOutBtnEvent")
winMgr:getWindow('CashTemporary_functionWindow'):addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/Button", "CashTemporary_functionRefundBtn")
mywindow:setTexture("Normal", "UIData/Match002.tga", 590, 497)
mywindow:setTexture("Hover", "UIData/Match002.tga", 590, 517)
mywindow:setTexture("Pushed", "UIData/Match002.tga", 590, 537)
mywindow:setTexture("PushedOff", "UIData/Match002.tga", 590, 537)
mywindow:setTexture("Disabled", "UIData/Match002.tga", 590, 557)
mywindow:setPosition(0, 18)
mywindow:setSize(80, 20)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "functionRefundBtnEvent")
winMgr:getWindow('CashTemporary_functionWindow'):addChildWindow(mywindow)


-- 삭제 확인창
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'CashTemporary_PopupAlpha');
mywindow:setTexture('Enabled', 'UIData/OnDLGBackImage.tga', 0, 0);
mywindow:setTexture('Disabled', 'UIData/OnDLGBackImage.tga', 0, 0);
mywindow:setPosition(0,0);
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow);

RegistEscEventInfo("CashTemporary_PopupAlpha", "CashTemporary_ConfirmPopupCancelEvent")
RegistEnterEventInfo("CashTemporary_PopupAlpha", "CashTemporary_ConfirmPopupOkEvent")

mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'CashTemporary_ConfirmImage');
mywindow:setTexture('Enabled', 'UIData/popup001.tga', 0, 0);
mywindow:setTexture('Disabled', 'UIData/popup001.tga', 0, 0);
mywindow:setPosition((1024 - 340) / 2, (768 - 268) / 2);
mywindow:setSize(340, 268);
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow('CashTemporary_PopupAlpha'):addChildWindow(mywindow);

mywindow = winMgr:createWindow("TaharezLook/StaticText", "CashTemporary_ConfirmPopupText");
mywindow:setPosition(3, 45);
mywindow:setSize(340, 180);
mywindow:setAlign(7);
mywindow:setLineSpacing(2);
mywindow:setViewTextMode(1);
mywindow:setEnabled(false)
mywindow:setTextExtends(PreCreateString_2537, g_STRING_FONT_DODUMCHE, 115,255,255,255,255,    2, 0,0,0,255);	
winMgr:getWindow('CashTemporary_ConfirmImage'):addChildWindow(mywindow);

-- ok버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "CashTemporary_ConfirmPopupOKButton")
mywindow:setTexture("Normal", "UIData/popup001.tga", 693, 849)
mywindow:setTexture("Hover", "UIData/popup001.tga", 693, 878)
mywindow:setTexture("Pushed", "UIData/popup001.tga", 693, 907)
mywindow:setTexture("Disabled", "UIData/popup001.tga", 693, 849)
mywindow:setPosition(4, 235)
mywindow:setSize(166, 29)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:subscribeEvent("Clicked", "CashTemporary_ConfirmPopupOkEvent")
winMgr:getWindow('CashTemporary_ConfirmImage'):addChildWindow(mywindow)

-- cancel 버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "CashTemporary_ConfirmPopupCancelButton")
mywindow:setTexture("Normal", "UIData/popup001.tga", 858, 849)
mywindow:setTexture("Hover", "UIData/popup001.tga", 858, 878)
mywindow:setTexture("Pushed", "UIData/popup001.tga", 858, 907)
mywindow:setTexture("Disabled", "UIData/popup001.tga", 858, 849)
mywindow:setPosition(169, 235)
mywindow:setSize(166, 29)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:subscribeEvent("Clicked", "CashTemporary_ConfirmPopupCancelEvent")
winMgr:getWindow('CashTemporary_ConfirmImage'):addChildWindow(mywindow)


-- 삭제 ok버튼 이벤트
function CashTemporary_ConfirmPopupOkEvent(args)
	winMgr:getWindow("CashTemporary_PopupAlpha"):setVisible(false)
	local index = tonumber(winMgr:getWindow("CashTemporary_functionWindow"):getUserString("index"))
	winMgr:getWindow("CashTemporary_functionWindow"):setUserString("index", tostring(-1))


end


-- 삭제 cancel버튼 이벤트
function CashTemporary_ConfirmPopupCancelEvent(args)
	winMgr:getWindow("CashTemporary_PopupAlpha"):setVisible(false)
	winMgr:getWindow("CashTemporary_functionWindow"):setUserString("index", tostring(-1))

end


-- 아이템을 가져오는 버튼이 눌려졌을 때
function functionTakeOutBtnEvent(args)


end


-- 아이템 환불하기 원할 때
function functionRefundBtnEvent(args)


end

winMgr:getWindow("CommonRoom_SpecialEffect"):setVisible(false)
end