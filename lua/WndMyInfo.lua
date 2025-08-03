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
-- 내정보 로컬라이징
--------------------------------------------------------------------
local MyInfo_String_Use							= PreCreateString_1193	--GetSStringInfo(LAN_LUA_WND_MYINFO_1)			-- 사용
local MyInfo_String_Using_Item					= PreCreateString_1194	--GetSStringInfo(LAN_LUA_WND_MYINFO_2)			-- 현재 사용중인 아이템입니다.
local MyInfo_String_ExpiredItem					= PreCreateString_1195	--GetSStringInfo(LAN_LUA_WND_MYINFO_3)			-- 기간이 만료된 아이템입니다.
local MyInfo_String_Nick						= PreCreateString_1196	--GetSStringInfo(LAN_LUA_WND_MYINFO_4)			-- 칭호
local MyInfo_String_Select_Item					= PreCreateString_1197	--GetSStringInfo(LAN_LUA_WND_MYINFO_5)			-- 아이템을 선택해주세요.
local MyInfo_String_ExperienceSkill				= PreCreateString_1198	--GetSStringInfo(LAN_LUA_WND_MYINFO_6)			-- 체험스킬
local MyInfo_String_RandowItem					= PreCreateString_1199	--GetSStringInfo(LAN_LUA_WND_MYINFO_7)			-- 랜덤 아이템
local MyInfo_String_ExperienceSkillMsg			= PreCreateString_1200	--GetSStringInfo(LAN_LUA_WND_MYINFO_8)			-- %s을\n사용하면 현재 사용중인\n모든 스킬이 해제됩니다.\n정말로 사용하시겠습니까?
local MyInfo_String_Delete						= PreCreateString_1201	--GetSStringInfo(LAN_LUA_WND_MYINFO_9)			-- 삭제
local MyInfo_String_Not_Delete_UsingItem		= PreCreateString_1202	--GetSStringInfo(LAN_LUA_WND_MYINFO_10)			-- 현재 사용중인 아이템은\\n삭제할 수 없습니다.
local MyInfo_String_Release						= PreCreateString_1203	--GetSStringInfo(LAN_LUA_WND_MYINFO_11)			-- 해제
local MyInfo_String_Not_UsingItem				= PreCreateString_1204	--GetSStringInfo(LAN_LUA_WND_MYINFO_12)			-- 현재 사용중인 아이템이 아닙니다.
local MyInfo_String_TranslateItem				= PreCreateString_1205	--GetSStringInfo(LAN_LUA_WND_MYINFO_13)			-- 변신아이템
local MyInfo_String_ChanceJob_ExperienceSkill	= PreCreateString_1206	--GetSStringInfo(LAN_LUA_WND_MYINFO_14)			-- 전직스킬 체험권
local MyInfo_String_Use_Period					= PreCreateString_1207	--GetSStringInfo(LAN_LUA_WND_MYINFO_15)			-- 사용기간
local MyInfo_String_MyItem						= PreCreateString_1208	--GetSStringInfo(LAN_LUA_WND_MYINFO_16)			-- 내아이템
local MyInfo_String_Skill						= PreCreateString_1209	--GetSStringInfo(LAN_LUA_WND_MYINFO_17)			-- 스킬
local MyInfo_String_MySkill						= PreCreateString_1210	--GetSStringInfo(LAN_LUA_WND_MYINFO_18)			-- 내스킬
local MyInfo_String_Menu_Inventory				= PreCreateString_1211	--GetSStringInfo(LAN_LUA_WND_MYINFO_19)			-- 메뉴의\\n인벤토리
local MyInfo_String_Name						= PreCreateString_1214	--GetSStringInfo(LAN_LUA_WND_MYINFO_22)			-- 이    름
local MyInfo_String_Receive_Day					= PreCreateString_1215	--GetSStringInfo(LAN_LUA_WND_MYINFO_23)			-- 받 은 날
local MyInfo_String_Receive_Place				= PreCreateString_1216	--GetSStringInfo(LAN_LUA_WND_MYINFO_24)			-- 받 은 곳
local MyInfo_String_Use_OK						= PreCreateString_1217	--GetSStringInfo(LAN_LUA_WND_MYINFO_25)			-- %s 에서 사용 가능
local MyInfo_String_Present_Save_Day			= PreCreateString_1218	--GetSStringInfo(LAN_LUA_WND_MYINFO_26)			-- 선물 보관 일자가 %s남았습니다
local MyInfo_String_Remain						= PreCreateString_1219	--GetSStringInfo(LAN_LUA_WND_MYINFO_27)			-- 남음
local MyInfo_String_ReceiveRewardMsg			= PreCreateString_1221	--GetSStringInfo(LAN_LUA_WND_MYINFO_29)			-- 받은 보상은 %s에서 사용 가능합니다
local MyInfo_String_InvenItemGetMsg				= PreCreateString_1222	--GetSStringInfo(LAN_LUA_WND_MYINFO_30)			--%s %s \n아이템을 %s하시겠습니까?
local MyInfo_String_Input_CouponNumber			= PreCreateString_1223	--GetSStringInfo(LAN_LUA_WND_MYINFO_31)			-- 쿠폰번호 30자를 입력해주세요.
local MyInfo_String_Get_CouponItems				= PreCreateString_1224	--GetSStringInfo(LAN_LUA_WND_MYINFO_32)			-- %d개의 아이템을 획득 하셨습니다.\n\n※획득하신 아이템은 선물함에서\n확인할 수 있습니다
local MyInfo_String_Get_CouponItem				= PreCreateString_1225	--GetSStringInfo(LAN_LUA_WND_MYINFO_33)			-- 아이템을 획득 하셨습니다.\n\n※획득하신 아이템은 선물함에서\n확인할 수 있습니다
local MyInfo_String_Skill_Exchange_Coupon		= PreCreateString_1801	--GetSStringInfo(LAN_LUA_WND_MYINFO_34)			-- 스킬교환권
local MyInfo_String_Menu_Inventory2				= PreCreateString_1802	--GetSStringInfo(LAN_LUA_WND_MYINFO_35)			-- 메뉴의 인벤토리
local MyInfo_String_Fast_Alive					= PreCreateString_1807	--GetSStringInfo(LAN_LUA_WND_MYINFO_36)			-- 빠른부활
local MyInfo_String_Life						= PreCreateString_1808	--GetSStringInfo(LAN_LUA_WND_MYINFO_37)			-- 라이프
local MyInfo_String_SlotChanger					= PreCreateString_1809	--GetSStringInfo(LAN_LUA_WND_MYINFO_38)			-- 슬롯체인저
local MyInfo_String_PresentItemGetMsg			= PreCreateString_1821	--GetSStringInfo(LAN_LUA_WND_MYINFO_39)			--%s %s\n아이템을 받으시겠습니까?
local MyInfo_String_Day							= PreCreateString_1057	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_40)	-- 일
local MyInfo_String_Costum						= PreCreateString_1521	--GetSStringInfo(LAN_CPP_VILLAGE_9)				-- 코스튬


local	RECORD_TOTAL_EXP			= 1
local	RECORD_LADDER_EXP			= 2
local	RECORD_TOTAL_KO				= 3
local	RECORD_MVP					= 4
local	RECORD_TEAM					= 5
local	RECORD_DOUBLE				= 6
local	RECORD_PRIVATE_PLAYCOUNT	= 7
local	RECORD_PUBLIC_PLAYCOUNT		= 8
local	RECORD_KO_RATE				= 9
local	RECORD_PERFECT				= 10		-- perfect
local	RECORD_CONSECUTIVE_WIN		= 11		-- 연승
local	RECORD_CONSECUTIVE_WIN_BREAK= 12		-- 연승격파

	
local	RANK_TOTAL_EXP				= 1
local	RANK_LADDER					= 2
local	RANK_KO						= 3
local	RANK_MVP					= 4
local	RANK_TEAM_ATTACK			= 5
local	RANK_DOUBLE_ATTACK			= 6
local	RANK_PERFECT				= 7		-- perfect
local	RANK_CONSECUTIVE_WIN		= 8		-- 연승
local	RANK_CONSECUTIVE_WIN_BREAK	= 9		-- 연승격파


--------------------------------------------------------------------
-- 내정보 전역으로 쓸 변수.
--------------------------------------------------------------------
local g_InfoCharacterName = "";
local g_MyName			= "";
local g_TitleIndex		= 0

local tUserRank = {['protecterr'] = 0, }
local tUserRecord = {['protecterr'] = 0, }

--------------------------------------------------------------------

-- 내정보 윈도우들

--------------------------------------------------------------------
--------------------------------------------------------------------
-- 내정보 바탕 이미지
--------------------------------------------------------------------
myinfobackwindow = winMgr:createWindow("TaharezLook/StaticImage", "Myinfo_BackImage")
myinfobackwindow:setTexture("Enabled", "UIData/myinfo2.tga", 0, 0)
myinfobackwindow:setTexture("Disabled", "UIData/myinfo2.tga", 0, 0)
myinfobackwindow:setProperty("FrameEnabled", "False")
myinfobackwindow:setProperty("BackgroundEnabled", "False")
myinfobackwindow:setPosition((g_MAIN_WIN_SIZEX - 501) / 2, (g_MAIN_WIN_SIZEY - 475) / 2)
myinfobackwindow:setSize(501, 475)
myinfobackwindow:setVisible(false)
myinfobackwindow:setAlwaysOnTop(true)
myinfobackwindow:setZOrderingEnabled(true)
root:addChildWindow(myinfobackwindow)

-- 파티 매치 ESC키 등록
RegistEscEventInfo("Myinfo_BackImage", "CloseMyInfoButton")




--------------------------------------------------------------------
-- 제목 이미지. 
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Myinfo_TitleImage")
mywindow:setTexture("Enabled", "UIData/myinfo.tga", 810, 0)
mywindow:setTexture("Disabled", "UIData/myinfo.tga", 810, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition((501 - 86) / 2, 7)
mywindow:setSize(86, 29)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
myinfobackwindow:addChildWindow(mywindow)


--------------------------------------------------------------------
-- 타이틀바(마우스 따라 움직이게 하기)
--------------------------------------------------------------------
myinfotitlebarwindow = winMgr:createWindow("TaharezLook/Titlebar", "Myinfo_TitleBar")
myinfotitlebarwindow:setPosition(3, 1)
myinfotitlebarwindow:setSize(470, 45)
myinfobackwindow:addChildWindow(myinfotitlebarwindow)


--------------------------------------------------------------------
-- 내정보 Myinfo_Character, 내전적/랭킹 선택 라디오버튼
--------------------------------------------------------------------
local tMyinfoSelectName		= {['protecterr']=0, [0]="Myinfo_Character", "Myinfo_Rank", "Myinfo_TitleName" }
local tMyinfoSelectTexX		= {['protecterr']=0, [0]=	501,	641,	640}
local tMyinfoSelectTexY		= {['protecterr']=0, [0]=	69,		69,		905}
local tMyinfoSelectPosX		= {['protecterr']=0, [0]=	5,		151,	297}
local tMyinfoSelectEvent	= {['protecterr']=0, [0]="ShowCharacter", "ShowRankInfo", "ShowTitleInfo" }

for i=0, #tMyinfoSelectName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tMyinfoSelectName[i])
	mywindow:setTexture("Normal", "UIData/myinfo2.tga", tMyinfoSelectTexX[i], tMyinfoSelectTexY[i])
	mywindow:setTexture("Hover", "UIData/myinfo2.tga", tMyinfoSelectTexX[i], tMyinfoSelectTexY[i] + 35 )
	mywindow:setTexture("Pushed", "UIData/myinfo2.tga", tMyinfoSelectTexX[i], tMyinfoSelectTexY[i] + 70 )
	mywindow:setTexture("SelectedNormal", "UIData/myinfo2.tga", tMyinfoSelectTexX[i], tMyinfoSelectTexY[i] + 70 )
	mywindow:setTexture("SelectedHover", "UIData/myinfo2.tga", tMyinfoSelectTexX[i], tMyinfoSelectTexY[i] + 70 )
	mywindow:setTexture("SelectedPushed", "UIData/myinfo2.tga", tMyinfoSelectTexX[i], tMyinfoSelectTexY[i] + 70 )
	mywindow:setPosition(tMyinfoSelectPosX[i], 41)
	mywindow:setProperty("GroupID", 3200)	--??
	mywindow:setSize(140, 35)
	mywindow:setZOrderingEnabled(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:subscribeEvent("SelectStateChanged", tMyinfoSelectEvent[i])
	if i == 0 then
		mywindow:setProperty("Selected", "true")
	end
	myinfobackwindow:addChildWindow(mywindow)
end


--------------------------------------------------------------------
-- 캐릭터탭 선택시 보여주는 이미지.
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Myinfo_CharacterBackImg")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(6, 75)
mywindow:setSize(489, 348)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(true)
myinfobackwindow:addChildWindow(mywindow)


--------------------------------------------------------------------
-- 캐릭터 기본 베이스 이미지
--------------------------------------------------------------------
local tMyinfoBaseBackImgName	= {['protecterr']=0, "Myinfo_LT", "Myinfo_LB", "Myinfo_R" }
local tMyinfoBaseBackImgTexX	= {['protecterr']=0,	781,		501,			805}
local tMyinfoBaseBackImgTexY	= {['protecterr']=0,	732,		395,			395}
local tMyinfoBaseBackImgSizeX	= {['protecterr']=0,	243,		242,			219}
local tMyinfoBaseBackImgSizeY	= {['protecterr']=0,	278,		53,				337}
local tMyinfoBaseBackImgPosX	= {['protecterr']=0,	9,			9,				262}
local tMyinfoBaseBackImgPosY	= {['protecterr']=0,	5,			286,			4}


for i = 1, #tMyinfoBaseBackImgName do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", tMyinfoBaseBackImgName[i])
	mywindow:setTexture("Enabled", "UIData/myinfo2.tga", tMyinfoBaseBackImgTexX[i], tMyinfoBaseBackImgTexY[i])
	mywindow:setTexture("Disabled", "UIData/myinfo2.tga", tMyinfoBaseBackImgTexX[i], tMyinfoBaseBackImgTexY[i])
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(tMyinfoBaseBackImgPosX[i], tMyinfoBaseBackImgPosY[i])
	mywindow:setSize(tMyinfoBaseBackImgSizeX[i], tMyinfoBaseBackImgSizeY[i])
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("Myinfo_CharacterBackImg"):addChildWindow(mywindow)
end






--------------------------------------------------------------------
-- 능력치, 특수효과 선택 라디오버튼
--------------------------------------------------------------------
local tMyinfoSubSelectName	= {['protecterr']=0, "Myinfo_Stat", "Myinfo_SpecialEffect" }
local tMyinfoSubSelectTexX	= {['protecterr']=0, 	501,	563}
local tMyinfoSubSelectPosX	= {['protecterr']=0, 	269 - 6,	331 - 3 }
local tMyinfoSubSelectEvent	= {['protecterr']=0, "Show_MyStat", "Show_MySpecialEffect" }

for i = 1, #tMyinfoSubSelectName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tMyinfoSubSelectName[i])
	mywindow:setTexture("Normal", "UIData/myinfo2.tga", tMyinfoSubSelectTexX[i], 0)
	mywindow:setTexture("Hover", "UIData/myinfo2.tga", tMyinfoSubSelectTexX[i], 23)
	mywindow:setTexture("Pushed", "UIData/myinfo2.tga", tMyinfoSubSelectTexX[i], 46)
	mywindow:setTexture("SelectedNormal", "UIData/myinfo2.tga", tMyinfoSubSelectTexX[i], 46)
	mywindow:setTexture("SelectedHover", "UIData/myinfo2.tga", tMyinfoSubSelectTexX[i], 46)
	mywindow:setTexture("SelectedPushed", "UIData/myinfo2.tga", tMyinfoSubSelectTexX[i], 46)	
	mywindow:setPosition(tMyinfoSubSelectPosX[i], 133)
	mywindow:setProperty("GroupID", 3210)	--??
	mywindow:setSize(62, 23)
	mywindow:setZOrderingEnabled(true)
	mywindow:setAlwaysOnTop(false)
	mywindow:subscribeEvent("SelectStateChanged", tMyinfoSubSelectEvent[i])
	if i == 1 then
		mywindow:setProperty("Selected", "true")
	end
	winMgr:getWindow("Myinfo_CharacterBackImg"):addChildWindow(mywindow)
end


--------------------------------------------------------------------
-- 내정보에 맞는 캐릭터이미지
--------------------------------------------------------------------
tMyCharacterImageName		= {['protecterr']=0, [0]= "Wells", "Ray", "Joony", "Lilru", "Nicky", "Sera" }
tMyCharacterImagetTexX		= {['protecterr']=0, [0]=	8,	249, 490, 8, 249, 490 }
tMyCharacterImagetTexY		= {['protecterr']=0, [0]=	478, 478, 478, 751, 751, 751 }

for i=0, #tMyCharacterImageName do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", tMyCharacterImageName[i])
	mywindow:setTexture("Enabled", "UIData/myinfo.tga", tMyCharacterImagetTexX[i], tMyCharacterImagetTexY[i])
	mywindow:setTexture("Disabled", "UIData/myinfo.tga", tMyCharacterImagetTexX[i], tMyCharacterImagetTexY[i])
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(10, 9)
	mywindow:setSize(241, 273)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("Myinfo_CharacterBackImg"):addChildWindow(mywindow)
end




--------------------------------------------------------------------
-- 착용중인 아이템 보여주는 아이콘뒷판
--------------------------------------------------------------------
-- 아이템 보여주는 전체적인 뒷판
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "WearItemTotalBack")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0,0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0,0)
mywindow:setPosition(12, 75)
mywindow:setSize(236, 205)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("Myinfo_CharacterBackImg"):addChildWindow(mywindow)


local tTexX	= {['err']=0, 474, 515}
local tPosX	= {['err']=0, 0,  195}

for i=1, #tTexX do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "WearItem"..i)
	mywindow:setTexture("Enabled", "UIData/my_room.tga", tTexX[i], 409)
	mywindow:setTexture("Disabled", "UIData/my_room.tga", tTexX[i], 409)
	mywindow:setPosition(tPosX[i], 0)
	mywindow:setSize(41, 205)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("WearItemTotalBack"):addChildWindow(mywindow)
end

-- 내정보에 뿌려지는 착용중인장비의 현황 표시할 인덱스
local MyInfo_Hear	= 0	-- 헤어
local MyInfo_Face	= 1	-- 얼굴
local MyInfo_Upper	= 2	-- 상의
local MyInfo_Lower	= 3	-- 하의
local MyInfo_Hand	= 4	-- 손

local MyInfo_Hat	= 5	-- 모자(머리위)
local MyInfo_Foot	= 6	-- 신발
local MyInfo_Set	= 7	-- 세트
local MyInfo_Ring	= 8	-- 반지
local MyInfo_Back	= 9	-- 가방

local tItemWearTable = {['err'] = 0, [0]=MyInfo_Upper, MyInfo_Lower, MyInfo_Hand, MyInfo_Foot, MyInfo_Face,
											MyInfo_Hear, MyInfo_Back, MyInfo_Hat, MyInfo_Ring}

-- 아이템을 붙이는 부위별로 가지고있는다.
local tItemAttachName	  = {['err']=0, [0]= "My_Wear_Hear", "My_Wear_Face", "My_Wear_Upper", "My_Wear_Lower", "My_Wear_Hand", 
										"My_Wear_Hat", "My_Wear_Foot", "My_Wear_Set", "My_Wear_Ring", "My_Wear_Back"} 
local tItemAttachItemName = {['err']=0, [0]= "Hear_Item", "Face_Item", "Upper_Item", "Lower_Item", "Hand_Item", 
										"Hat_Item", "Foot_Item", "Set_Item", "Ring_Item", "Back_Item"}
local tItemAttachButtonName = {['err']=0, [0]= "Hear_Button", "Face_Button", "Upper_Button", "Lower_Button", "Hand_Button", 
										"Hat_Button", "Foot_Button", "Set_Button", "Ring_Button", "Back_Button"}
local tItemAttachPosX = {['err']=0, [0]= 0,0,0,0,0,195,195,195,195,195}
local tItemAttachPosY = {['err']=0, [0]= 0,41*1,41*2,41*3,41*4, 0,41*1,41*2,41*3,41*4 }

for i=0, #tItemAttachName do
	-- 이미지 위에 덮어쓰는 아이콘 이미지.
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", tItemAttachName[i])
	mywindow:setTexture("Enabled", "UIData/my_room.tga", 556,573)
	mywindow:setTexture("Disabled", "UIData/my_room.tga", 556,573)
	mywindow:setPosition(tItemAttachPosX[i], tItemAttachPosY[i])
	mywindow:setSize(41, 41)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("WearItemTotalBack"):addChildWindow(mywindow)
	
	-- 아이템을 뿌려줄 투명이미지(요건 축소를 하는거라서 좀 크게 이미지를 잡아야한다.)
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", tItemAttachItemName[i])
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0,0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0,0)
	mywindow:setPosition(3,2)
	mywindow:setSize(110, 110)
	mywindow:setScaleHeight(90)	-- 축소해놓는다.
	mywindow:setScaleWidth(90)		-- 축소해놓는다.
	mywindow:setEnabled(false)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUseEventController(false)	-- 이벤트를 받지 않는다.
	winMgr:getWindow(tItemAttachName[i]):addChildWindow(mywindow)
	
	-- 마우스 들어온 효과위해 버튼
	mywindow = winMgr:createWindow("TaharezLook/Button", tItemAttachButtonName[i])
	mywindow:setTexture("Normal", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Hover", "UIData/my_room.tga", 597, 573)
	mywindow:setTexture("Pushed", "UIData/my_room.tga", 638, 573)
	mywindow:setTexture("PushedOff", "UIData/my_room.tga", 638, 573)
	mywindow:setTexture("Disabled", "UIData/my_room.tga", 556, 573)
	mywindow:setPosition(tItemAttachPosX[i], tItemAttachPosY[i])
	mywindow:setSize(41,41)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("Index", tostring(-1))
	mywindow:subscribeEvent("MouseEnter", "Myinfo_Item_MouseEnter")
	mywindow:subscribeEvent("MouseLeave", "Myinfo_Item_MouseLeave")
	mywindow:subscribeEvent("MouseRButtonUp", "Myinfo_Item_MouseRButtonUp")
	winMgr:getWindow("WearItemTotalBack"):addChildWindow(mywindow)	
	
end


-- 마우스가 들어왔다
function Myinfo_Item_MouseEnter(args)
	local enterWindow	= CEGUI.toWindowEventArgs(args).window
	
	local x, y = GetBasicRootPoint(enterWindow)
	local ItemIndex = enterWindow:getUserString("Index")
	local itemNumber = ToC_GetMyinfoTooltipInfo(ItemIndex)
	if itemNumber < 0 then
		return
	end
	GetToolTipBaseInfo(x + 43, y, 2, KIND_COSTUM, -1, itemNumber)	-- 툴팁에 관한 정보를 세팅해준다.
	SetShowToolTip(true)
end

-- 마우스가 나갔다.
function Myinfo_Item_MouseLeave(args)
	SetShowToolTip(false)

end

function Myinfo_Item_MouseRButtonUp(args)
	local enterWindow	= CEGUI.toWindowEventArgs(args).window
	local ItemIndex = enterWindow:getUserString("Index")
	ToC_MyinfoUnWearItem(ItemIndex)
end



--------------------------------------------------------------------
-- 내정보에 맞는 캐릭터기본 정보 (레벨, 캐릭명, 직업) Text
--------------------------------------------------------------------
tMyCharacterBasicInfoName		= {['protecterr']=0, [0]= "InfoLevel", "InfoName", "InfoGuild", "InfoTitleText"}
tMyCharacterBasicInfoPosX		= {['protecterr']=0, [0]=	21 - 6, 62 - 6, 322 - 6, 322 - 6}
tMyCharacterBasicInfoPosY		= {['protecterr']=0, [0]=	392 - 75, 368 - 75, 124 - 75, 158 - 75}
tMyCharacterBasicInfoSizeX		= {['protecterr']=0, [0]=	40, 100, 145, 145}

for i = 0, #tMyCharacterBasicInfoName do
	mywindow = winMgr:createWindow("TaharezLook/StaticText", tMyCharacterBasicInfoName[i])
	mywindow:setPosition(tMyCharacterBasicInfoPosX[i], tMyCharacterBasicInfoPosY[i])
	mywindow:setSize(tMyCharacterBasicInfoSizeX[i], 20)
	mywindow:setZOrderingEnabled(false)	
	mywindow:setViewTextMode(1)
	mywindow:setAlign(8)
	mywindow:setLineSpacing(2)
	winMgr:getWindow("Myinfo_CharacterBackImg"):addChildWindow(mywindow)

end


tBasicInfoImageName			= {['protecterr']=0, [0]= "InfoPromotion", "InfoGrade", "InfoTitle"}
tBasicInfoImagetPosX		= {['protecterr']=0, [0]=	355 - 6, 203 - 6, 338 - 6 }
tBasicInfoImagetPosY		= {['protecterr']=0, [0]=	4, 290, 84 }
tBasicInfoImagetSizeX		= {['protecterr']=0, [0]=	87, 47, 112 }
tBasicInfoImagetSizeY		= {['protecterr']=0, [0]=	35, 21, 18 }

for i=0, #tBasicInfoImageName do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", tBasicInfoImageName[i])
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(tBasicInfoImagetPosX[i], tBasicInfoImagetPosY[i])
	mywindow:setSize(tBasicInfoImagetSizeX[i], tBasicInfoImagetSizeY[i])
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("Myinfo_CharacterBackImg"):addChildWindow(mywindow)
end




local tSpecialTexture		= {['err'] = 0, {['err'] = 0, 501, 175}, {['err'] = 0, 538, 175} }
local SpecialCurrentPage	= 1
local SpecialTotalPage		= 1
--------------------------------------------------------------------
-- 특수효과 설명 뒷판.
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyInfo_SpecialBackImg")
mywindow:setTexture("Enabled", "UIData/myinfo2.tga", 575, 175)
mywindow:setTexture("Disabled", "UIData/myinfo2.tga", 575, 175)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(273 - 6, 231 - 75)
mywindow:setSize(206, 181)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("Myinfo_CharacterBackImg"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- 특수효과 설명 부가 이미지.
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyInfo_SpecialNameImg")
mywindow:setTexture("Enabled", "UIData/myinfo2.tga", 501, 175)
mywindow:setTexture("Disabled", "UIData/myinfo2.tga", 501, 175)
mywindow:setPosition(3, 3)
mywindow:setSize(36, 30)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("MyInfo_SpecialBackImg"):addChildWindow(mywindow)






--------------------------------------------------------------------

-- 버프 띄워주기

--------------------------------------------------------------------
local BUFF_SUPER_OWNER				= 0		-- 슈퍼방장
local BUFF_ENEMY_SHOW_SP			= 1		-- 상대팀 SP보기
local BUFF_ENEMY_SHOW_ITEM			= 2		-- 상대팀 아이템 보기
local BUFF_PREMIER_COUPON_PARK		= 3		-- 아케이드 프리이엄 입장권(공원)
local BUFF_PREMIER_COUPON_HOTEL		= 4 	-- 아케이드 프리이엄 입장권(호텔)
local BUFF_PREMIER_COUPON_HALEM		= 5 	-- 아케이드 프리이엄 입장권(할렘)
local BUFF_PREMIER_COUPON_HROAD		= 6		-- 아케이드 프리이엄 입장권(H로드)	
local BUFF_NPC_TRANSFORM			= 7		-- NPC 변신 쿠폰
local BUFF_FAST_REVIVE				= 8		-- 빠른부활		
local BUFF_GET_EXP_INCREASE			= 9		-- 경험치 획득량 증가
local BUFF_GET_ZEN_INCREASE			= 10	-- ZEN 획득량 증가
local BUFF_EXCHANGE_NAME_COLOR		= 11	-- 케릭터 이름색 변경
local BUFF_SPECIAL_MYSHOP			= 12	-- 스페샬 마이샵
local BUFF_DIG_PICKAXE				= 13	-- 곡괭이
local BUFF_DIG_DRILL				= 14	-- 드릴
local BUFF_CHAT_BUBBLE				= 15	-- 말풍선 변경 1
local BUFF_PREMIER_COUPON_SUBWAY	= 16	-- 아케이드 프리이엄 입장권(서브웨이)
local BUFF_SHOW_USERINFO_INROOM		= 17	-- 배틀룸 안에 있는 유저정보 보기
local MAX_BUFF_COUNT				= 18	-- max


--------------------------------------------------------------------
-- 버프 뒷판
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyInfo_BufMainImg")
mywindow:setTexture("Enabled", "UIData/mainBG_button002.tga", 250, 650)
mywindow:setTexture("Disabled", "UIData/mainBG_button002.tga", 250, 650)
mywindow:setPosition(2, 27)
mywindow:setSize(206, 138)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("EndRender", "MyInfo_BuffBooleanRender")
winMgr:getWindow("MyInfo_SpecialBackImg"):addChildWindow(mywindow)


local MAX_WIDTH_COUNT	= 6
local MAX_HEIGHT_COUNT	= 4
local BUF_SIZE			= 32
local tBuffBooleanInfo = {['err'] = 0, false, 0, 0, "", ""}

for i = 0, MAX_HEIGHT_COUNT - 1 do
	for j = 0, MAX_WIDTH_COUNT - 1 do
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyInfo_Buf"..i..j)
		mywindow:setTexture("Enabled", "UIData/mainBG_button002.tga", 0, 788)
		mywindow:setTexture("Disabled", "UIData/mainBG_button002.tga", 0, 788)
		mywindow:setPosition(2 + (BUF_SIZE + 2) * j, 2 + (BUF_SIZE + 2) * i) 
		mywindow:setSize(BUF_SIZE, BUF_SIZE)
		mywindow:setVisible(true)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:setUserString("BuffIndex", tostring(-1))
		mywindow:subscribeEvent("MouseLeave", "BufMouseLeave");
		mywindow:subscribeEvent("MouseEnter", "BufMouseEnter");
		winMgr:getWindow("MyInfo_BufMainImg"):addChildWindow(mywindow)
	end
end


-- 버프아이콘에 마우스 들어왔을때.
function BufMouseEnter(args)
	local local_window	= CEGUI.toWindowEventArgs(args).window
	local Index	= tonumber(local_window:getUserString("BuffIndex"))
	if Index == -1 then
		return
	end

	local _drawer = root:getDrawer()
	local Desc	= GetBuffDesc(Index)
	local Time	= GetBuffRemainTime(Index)
	local Timestr = string.format(GetSStringInfo(LAN_LUA_MYBUFF_REMAINTIME), Time)
	local x, y = GetBasicRootPoint(local_window)
	tBuffBooleanInfo[1] = true
	tBuffBooleanInfo[2] = x + 15
	tBuffBooleanInfo[3] = y + 30
	tBuffBooleanInfo[4] = Desc
	tBuffBooleanInfo[5] = Timestr
end

-- 마우스 떠났을때.
function BufMouseLeave(args)
	tBuffBooleanInfo[1] = false

end


-- 버프아이콘 설명 말풍선을 랜더해준다.
function MyInfo_BuffBooleanRender(args)
	if tBuffBooleanInfo[1] then		
		local _drawer = root:getDrawer()		
		--local x, y = GetBasicRootPoint(local_window)
		RenderBuffTooltip(_drawer, tBuffBooleanInfo[2], tBuffBooleanInfo[3], tBuffBooleanInfo[4], tBuffBooleanInfo[5])
	end
end


--------------------------------------------------------------------
-- 특수효과 
--------------------------------------------------------------------
local tSpecialButtonName	= {['protecterr'] = 0, "MyInfo_SpecialLeftButton", "MyInfo_SpecialRightButton"}
local tSpecialButtonTexX	= {['protecterr'] = 0, 634,	625}
local tSpecialButtonPosX	= {['protecterr'] = 0, 75, 130}
local tSpecialButtonEvent	= {['protecterr'] = 0, "SpecialPageButtonLeftEvent", "SpecialPageButtonRightEvent"}

for i = 1, #tSpecialButtonName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tSpecialButtonName[i])
	mywindow:setTexture("Normal", "UIData/myinfo2.tga", tSpecialButtonTexX[i], 0)
	mywindow:setTexture("Hover", "UIData/myinfo2.tga", tSpecialButtonTexX[i], 13)
	mywindow:setTexture("Pushed", "UIData/myinfo2.tga", tSpecialButtonTexX[i], 26)
	mywindow:setTexture("PushedOff", "UIData/myinfo2.tga", tSpecialButtonTexX[i], 26)
	mywindow:setPosition(tSpecialButtonPosX[i], 166)
	mywindow:setSize(9, 13)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", tSpecialButtonEvent[i])
	winMgr:getWindow("MyInfo_SpecialBackImg"):addChildWindow(mywindow)
end

-- 특수효과 페이지
mywindow = winMgr:createWindow("TaharezLook/StaticText", "SpecialEffectPaage")
mywindow:setPosition(95, 165)
mywindow:setSize(35, 20)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setText(tostring(SpecialCurrentPage).." / "..SpecialTotalPage)
mywindow:setZOrderingEnabled(false)	
winMgr:getWindow("MyInfo_SpecialBackImg"):addChildWindow(mywindow)



mywindow = winMgr:createWindow("TaharezLook/StaticText", "TitleEffectString")
mywindow:setPosition(48, 1)
mywindow:setSize(35, 20)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
mywindow:setTextColor(87, 242, 9, 255)
mywindow:setText("aaaaaaaa")
mywindow:setZOrderingEnabled(false)	
winMgr:getWindow("MyInfo_SpecialBackImg"):addChildWindow(mywindow)



-- 특수효과 왼쪽 버튼
function SpecialPageButtonLeftEvent(args)
	if SpecialCurrentPage == 1 then
		return
	end
	SpecialCurrentPage	= SpecialCurrentPage - 1
	winMgr:getWindow("SpecialEffectPaage"):setText(tostring(SpecialCurrentPage).." / "..SpecialTotalPage)
end


-- 특수효과 오른쪽 버튼
function SpecialPageButtonRightEvent(args)
	if SpecialCurrentPage == SpecialTotalPage then
		return
	end
	SpecialCurrentPage	= SpecialCurrentPage + 1
	winMgr:getWindow("SpecialEffectPaage"):setText(tostring(SpecialCurrentPage).." / "..SpecialTotalPage)

end





--------------------------------------------------------------------
-- 내정보에 맞는 ExpGauge
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyInfo_RemainEXPBar")
mywindow:setTexture("Enabled", "UIData/myinfo.tga", 817, 41)
mywindow:setTexture("Disabled", "UIData/myinfo.tga", 817, 41)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(52, 392 - 75)
mywindow:setSize(143, 15)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("Myinfo_CharacterBackImg"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- 내정보에 맞는 경험치 숫자로 표현
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyInfo_EXPText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setPosition(52, 318)
mywindow:setSize(150, 20)
mywindow:setZOrderingEnabled(true)	
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
winMgr:getWindow("Myinfo_CharacterBackImg"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- 내정보에 맞는 경험치 퍼센트로 표현
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyInfo_EXPPersent")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setPosition(210 - 6, 392 - 75)
mywindow:setSize(40, 20)
mywindow:setZOrderingEnabled(true)	
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
winMgr:getWindow("Myinfo_CharacterBackImg"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- 내정보 스텟 text
--------------------------------------------------------------------
tMyStatName		= {['protecterr']=0, [0]= "ATK_STRInfo", "ATK_GRAInfo", "DEF_STRInfo", "DEF_GRAInfo", "CRIInfo", "HPInfo", "SPInfo"}
tMyPlusStatName	= {['protecterr']=0, [0]= "PlusATK_STRInfo", "PlusATK_GRAInfo", "PlusDEF_STRInfo", "PlusDEF_GRAInfo", "PlusCRIInfo", "PlusHPInfo", "PlusSPInfo"}

for i = 0, #tMyStatName do
	mywindow = winMgr:createWindow("TaharezLook/StaticText", tMyStatName[i])
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(376 - 6, 160 + i * 26)
	mywindow:setSize(100, 20)
	mywindow:setZOrderingEnabled(false)	
	mywindow:setViewTextMode(1)
	mywindow:setAlign(0)
	mywindow:setLineSpacing(2)
	winMgr:getWindow("Myinfo_CharacterBackImg"):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticText", tMyPlusStatName[i])
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(423 - 6, 164 + i * 26)
	mywindow:setSize(10, 20)
	mywindow:setZOrderingEnabled(false)	
	mywindow:setViewTextMode(1)
	mywindow:setAlign(1)
	mywindow:setLineSpacing(2)
	winMgr:getWindow("Myinfo_CharacterBackImg"):addChildWindow(mywindow)

end


--------------------------------------------------------------------
-- 내정보 세부 전적 윈도우
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyInfo_DetailRecordWindow")
mywindow:setTexture("Enabled", "UIData/myinfo2.tga", 781, 0)
mywindow:setTexture("Disabled", "UIData/myinfo2.tga", 781, 0)
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(269 - 6, 5)
mywindow:setSize(217, 335)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("EndRender", "MyInfoRankRender")
winMgr:getWindow("Myinfo_CharacterBackImg"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- 내정보 포인트, 캐쉬 이미지.
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "My_GranCashImage")
mywindow:setTexture("Enabled", "UIData/myinfo2.tga", 501, 355)
mywindow:setTexture("Disabled", "UIData/myinfo2.tga", 501, 355)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(5, 429)
mywindow:setSize(492, 40)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
myinfobackwindow:addChildWindow(mywindow)


--------------------------------------------------------------------
-- 내정보 포인트, 캐쉬 내용 text
--------------------------------------------------------------------
tMyMoneyName	= {['protecterr']=0, [0]= "My_HaveGranText", "My_HaveCoinText", "My_HaveCashText"}--, "My_HaveLifeText"}
tMyMoneyPosX	= {['protecterr']=0, [0]= 55, 215, 375}--, 416}

for i = 0, #tMyMoneyName do
	mywindow = winMgr:createWindow("TaharezLook/StaticText", tMyMoneyName[i])
	mywindow:setPosition(tMyMoneyPosX[i], 14)
	mywindow:setSize(105, 13)
	mywindow:setZOrderingEnabled(true)	
	mywindow:setViewTextMode(1)
	mywindow:setAlign(8)
	mywindow:setLineSpacing(2)
	winMgr:getWindow("My_GranCashImage"):addChildWindow(mywindow)

end


--------------------------------------------------------------------
-- 내정보 닫기 버튼
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "My_CloseButton")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setPosition(472, 6)
mywindow:setSize(23, 23)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "CloseMyInfoButton")
myinfobackwindow:addChildWindow(mywindow)



--------------------------------------------------------------------

-- 내정보관련 함수들

--------------------------------------------------------------------
--------------------------------------------------------------------
-- 유저 랭킹정보를 받아온다.
--------------------------------------------------------------------
function GetUserRanking(TotalExp, TotalExpRank, laddeRank, KoRank, MVPRank, TeamAttackRank, DoubleAttackRank, 
						Perfect, ConsecutiveWin, ConsecutiveWinBreak)
	tUserRecord[RECORD_TOTAL_EXP]	= TotalExp			-- 전체 누적 경험치
	tUserRank[RANK_TOTAL_EXP]		= TotalExpRank		-- 누적 경험치 랭킹
	tUserRank[RANK_LADDER]			= laddeRank			-- 래더 랭킹
	tUserRank[RANK_KO]				= KoRank			-- KO 랭킹
	tUserRank[RANK_MVP]				= MVPRank			-- MVP 랭킹
	tUserRank[RANK_TEAM_ATTACK]		= TeamAttackRank	-- 팀어택 랭킹
	tUserRank[RANK_DOUBLE_ATTACK]	= DoubleAttackRank	-- 더블어택 랭킹
	tUserRank[RANK_PERFECT]			= Perfect			-- 퍼펙트
	tUserRank[RANK_CONSECUTIVE_WIN]	= ConsecutiveWin	-- 연승
	tUserRank[RANK_CONSECUTIVE_WIN_BREAK]	= ConsecutiveWinBreak	-- 연승격파		
end



--------------------------------------------------------------------
-- 유저 전적정보를 텍스트로 뿌려준다.
--------------------------------------------------------------------
function GetUserRecord(privatePlayCount, publicPlayCount, KORate, totalKO, QuestClear, LadderExp, MVP, Team, Double, Perfect, Consecutivewin, ConsecutivewinBreak)
	
	--privatePlayCount, publicPlayCount, KORate나머지 3개	
	-- 유저 미션 
	tUserRecord[RECORD_LADDER_EXP]			= LadderExp
	tUserRecord[RECORD_TOTAL_KO]			= totalKO
	tUserRecord[RECORD_MVP]					= MVP
	tUserRecord[RECORD_TEAM]				= Team
	tUserRecord[RECORD_DOUBLE]				= Double
	tUserRecord[RECORD_PRIVATE_PLAYCOUNT]	= privatePlayCount
	tUserRecord[RECORD_PUBLIC_PLAYCOUNT]	= publicPlayCount
	tUserRecord[RECORD_KO_RATE]				= KORate
	tUserRecord[RECORD_PERFECT]				= Perfect
	tUserRecord[RECORD_CONSECUTIVE_WIN]		= Consecutivewin
	tUserRecord[RECORD_CONSECUTIVE_WIN_BREAK]= ConsecutivewinBreak

end		


--------------------------------------------------------------------
-- 유저 총스텟(기본 + 착용 아이템)
--------------------------------------------------------------------
function GetUserTotalStat(statATK_STR, statATK_GRA, statDEF_STR, statDEF_GRA, statCRI, HP, SP, statDEX, statDEF, statATK)
	
	tMyTotalStat = {['protecterr']=0, [0]=	statATK_STR, statATK_GRA, statDEF_STR, statDEF_GRA, statCRI, HP, SP}; --총 스텟

end


--------------------------------------------------------------------
-- 캐릭터 스텟 정보 보여주기
--------------------------------------------------------------------
function GetUserStat(StatATK_STR, StatATK_GRA, StatDEF_STR, StatDEF_GRA, StatCRI, hp, sp)
		
	tItemStat = {['protecterr']=0, [0]=	StatATK_STR, StatATK_GRA, StatDEF_STR, StatDEF_GRA, StatCRI, hp, sp}--statCRI, statATK, statDEF, hp_point, sp_point}	--상대포함/
	
	
	-- tMyStatName == 4 면 크리율
	
	-- 아이템 스텟이 없는부분은 하얗게, 있으면 녹색으로 아이템 스텟까지 보여준다.
	for i = 0, #tMyStatName do
		local Stat1	= ""	-- totalstat
		local Stat2	= ""	-- itemstat
		if i == 4 then
			Stat1	= GetDecimalPoint(tMyTotalStat[i]).."%"	-- totalstat
			Stat2	= GetDecimalPoint(tItemStat[i])	-- itemstat
		else
			Stat1	= tostring(tMyTotalStat[i])	-- totalstat
			Stat2	= tostring(tItemStat[i])	-- itemstat
		end
		
		if tItemStat[i] == 0 then
			winMgr:getWindow(tMyStatName[i]):setPosition(370, 238 + i * 26 - 75)
			winMgr:getWindow(tMyStatName[i]):setAlign(8)
			winMgr:getWindow(tMyStatName[i]):clearTextExtends();
			winMgr:getWindow(tMyStatName[i]):addTextExtends(Stat1, g_STRING_FONT_GULIM,112, 255,255,255,255,  0,  0,0,0,255);
			winMgr:getWindow(tMyPlusStatName[i]):clearTextExtends();

		else
			local _StatSize = GetStringSize(g_STRING_FONT_GULIM, 13, Stat1);
			-- 총 스텟
			winMgr:getWindow(tMyStatName[i]):clearTextExtends();
			winMgr:getWindow(tMyStatName[i]):setAlign(0)
			winMgr:getWindow(tMyStatName[i]):setPosition(409 - _StatSize + 10, 239 + i * 26 - 75);
			-- +되는 스텟
			winMgr:getWindow(tMyPlusStatName[i]):clearTextExtends();
			if tItemStat[i] < 0 then
				winMgr:getWindow(tMyStatName[i]):addTextExtends(Stat1, g_STRING_FONT_GULIM,112, 231,32,20,255,  3,  0,0,0,255);
				winMgr:getWindow(tMyPlusStatName[i]):addTextExtends(" ("..Stat2..")", g_STRING_FONT_GULIM, 112, 231,32,20,255,  3,  0,0,0,255);
			else
				winMgr:getWindow(tMyStatName[i]):addTextExtends(Stat1, g_STRING_FONT_GULIM,112, 0,255,0,255,  3,  0,0,0,255);
				winMgr:getWindow(tMyPlusStatName[i]):addTextExtends(" (+"..Stat2..")", g_STRING_FONT_GULIM, 112, 0,255,0,255,  3,  0,0,0,255);
			end
		end
	end

end


-- 정수를 소수점으로 바꾼다.
function GetDecimalPoint(value)
	local first	= value / 10
	local last	= value % 10
	
	return tostring(first).."."..tostring(last)
end

--------------------------------------------------------------------
-- 내정보 보여주기(라디오버튼 이벤트)
--------------------------------------------------------------------
function ShowCharacter()
	if CEGUI.toRadioButton(winMgr:getWindow("Myinfo_Character")):isSelected() then
		winMgr:getWindow("MyInfo_DetailRecordWindow"):setVisible(false)
		winMgr:getWindow("Myinfo_CharacterBackImg"):setVisible(true)
		winMgr:getWindow("Myinfo_R"):setVisible(true)
		winMgr:getWindow("Myinfo_TitleBackImg"):setVisible(false)	
		
--		GetCharacterInfo(g_InfoCharacterName, g_TitleIndex);
--		winMgr:getWindow("InvenMainImg"):setVisible(false);
	end
end


--------------------------------------------------------------------
-- 내 랭킹정보 보여주기(라디오버튼 이벤트)
--------------------------------------------------------------------
function ShowRankInfo()
	if CEGUI.toRadioButton(winMgr:getWindow("Myinfo_Rank")):isSelected() then
		winMgr:getWindow("Myinfo_CharacterBackImg"):setVisible(true)
		winMgr:getWindow("MyInfo_DetailRecordWindow"):setVisible(true)
		winMgr:getWindow("Myinfo_R"):setVisible(false)
		winMgr:getWindow("Myinfo_TitleBackImg"):setVisible(false)	

	end
end


--------------------------------------------------------------------
-- 내 칭호정보 보여주기(라디오버튼 이벤트)
--------------------------------------------------------------------
function ShowTitleInfo()
	if CEGUI.toRadioButton(winMgr:getWindow("Myinfo_TitleName")):isSelected() then
		winMgr:getWindow("Myinfo_CharacterBackImg"):setVisible(false)
		winMgr:getWindow("MyInfo_DetailRecordWindow"):setVisible(false)
		winMgr:getWindow("Myinfo_TitleBackImg"):setVisible(true)
		ToC_RefreshTitleList(1)
		winMgr:getWindow("TitleButton1"):setProperty("Selected", "true")

	end
end




--------------------------------------------------------------------
-- 내 스텟 보여주기(라디오버튼 이벤트)
--------------------------------------------------------------------
function Show_MyStat(args)
	if CEGUI.toRadioButton(winMgr:getWindow("Myinfo_Stat")):isSelected() then
		winMgr:getWindow("MyInfo_SpecialBackImg"):setVisible(false)
	end
end



--------------------------------------------------------------------
-- 내 특수효과 보여주기(라디오버튼 이벤트)
--------------------------------------------------------------------
function Show_MySpecialEffect(args)
	if CEGUI.toRadioButton(winMgr:getWindow("Myinfo_SpecialEffect")):isSelected() then
		-- clear
		ShowMyBuff()
		winMgr:getWindow("MyInfo_SpecialBackImg"):setVisible(true)		
	end
end


--------------------------------------------------------------------
-- 버프를 보여준다.
--------------------------------------------------------------------
function ShowMyBuff()
	for i = 0, MAX_HEIGHT_COUNT - 1 do
		for j = 0, MAX_WIDTH_COUNT - 1 do				
			winMgr:getWindow("MyInfo_Buf"..i..j):setTexture("Enabled", "UIData/mainBG_button002.tga", 0, 788)
		end
	end
	
	local Count = 0
	for i = 0, MAX_BUFF_COUNT do
		local use, type	= GetUseBufItem(i)
				
		if use then
			local first	= Count / MAX_WIDTH_COUNT
			local second= Count % MAX_WIDTH_COUNT
			
			winMgr:getWindow("MyInfo_Buf"..first..second):setTexture("Enabled", "UIData/mainBG_button002.tga", 32 * (i + 1), 788)
			winMgr:getWindow("MyInfo_Buf"..first..second):setUserString("BuffIndex", tostring(i))
			Count = Count + 1
		end
	end		
end


--------------------------------------------------------------------
-- 캐릭터에 따른 이미지 보여줌
--------------------------------------------------------------------
function GetMyCharacterImage(type, life)
	for i = 0, #tMyCharacterImageName do
		winMgr:getWindow(tMyCharacterImageName[i]):setVisible(false);
	end
	for i = 0, #tMyCharacterImageName do
		if type == i then
			winMgr:getWindow(tMyCharacterImageName[i]):setVisible(true);
		end
	end
end


--------------------------------------------------------------------
-- 기본 레벨, 이름, 직업 text
--------------------------------------------------------------------
function GetMyCharacterBasicInfo(level, name, style, promotion, grade, guild, MyTitle, Clubtitle)
	--레벨
	winMgr:getWindow("InfoLevel"):setAlign(1);
	winMgr:getWindow("InfoLevel"):clearTextExtends();
	winMgr:getWindow("InfoLevel"):addTextExtends('Lv.'..level ,g_STRING_FONT_GULIM, 12, 255,205,86,255,  3,  20,20,20,255);
	
	--이름
	winMgr:getWindow("InfoName"):clearTextExtends();
	winMgr:getWindow("InfoName"):addTextExtends(tostring(name),g_STRING_FONT_GULIMCHE,12, 120,230,120,255,  3,  20,20,20,255);
	winMgr:getWindow("InfoName"):setText(tostring(name))
	
	--직업
	if style == 'chr_strike' then
		winMgr:getWindow("InfoPromotion"):setTexture("Enabled", "UIData/skillitem001.tga", 497, 35 * promotion)
		winMgr:getWindow("InfoPromotion"):setTexture("Disabled", "UIData/skillitem001.tga", 497, 35 * promotion)
	else
		winMgr:getWindow("InfoPromotion"):setTexture("Enabled", "UIData/skillitem001.tga", 585, 35 * promotion)
		winMgr:getWindow("InfoPromotion"):setTexture("Disabled", "UIData/skillitem001.tga", 585, 35 * promotion)		
	end
	-- 등급
	winMgr:getWindow("InfoGrade"):setTexture("Enabled", "UIData/numberUi001.tga", 113, 600 + 21 * grade)
	winMgr:getWindow("InfoGrade"):setTexture("Disabled", "UIData/numberUi001.tga", 113, 600 + 21 * grade)
	
	-- 길드
--	winMgr:getWindow("InfoGuild"):clearTextExtends();
--	winMgr:getWindow("InfoGuild"):addTextExtends(guild, g_STRING_FONT_GULIM,12, 255,205,86,255,  1,  0,0,0,255);
	
	-- 칭호
	local	TitleString	= ""
	if MyTitle == 0 then
		winMgr:getWindow("InfoTitle"):setVisible(false)
		winMgr:getWindow("InfoTitleText"):setTextExtends("-", g_STRING_FONT_GULIM,12, 255,255,255,255,  3,  0,0,0,255);
	elseif MyTitle == 26 then
		winMgr:getWindow("InfoTitle"):setVisible(false)
		winMgr:getWindow("InfoTitleText"):setTextExtends(Clubtitle, g_STRING_FONT_GULIM,12, 120,200,255,255, 1, 0,0,0,255)
	else
		winMgr:getWindow("InfoTitleText"):clearTextExtends();
		winMgr:getWindow("InfoTitle"):setVisible(true)
		winMgr:getWindow("InfoTitle"):setTexture("Enabled", "UIData/numberUi001.tga", 0, 201+21*(MyTitle-1))
		winMgr:getWindow("InfoTitle"):setTexture("Disabled", "UIData/numberUi001.tga", 0, 201+21*(MyTitle-1))
		TitleString = ToC_GetTitleEffectString(MyTitle)
		TitleString	= AdjustString(g_STRING_FONT_GULIM, 11, TitleString, 150)
	end
	local _DescStart, _DescEnd = string.find(TitleString, "%\n");
	if _DescStart ~= nil then
		winMgr:getWindow("TitleEffectString"):setPosition(48, 1)
	else
		winMgr:getWindow("TitleEffectString"):setPosition(48, 6)
	end
	winMgr:getWindow("TitleEffectString"):setFont(g_STRING_FONT_GULIMCHE, 11)
	winMgr:getWindow("TitleEffectString"):setText(TitleString)
	
end


-- 클럽이름 세팅
function GetCharacterClubName(Name)
	winMgr:getWindow("InfoGuild"):clearTextExtends();
	winMgr:getWindow("InfoGuild"):addTextExtends(Name, g_STRING_FONT_GULIM,12, 255,205,86,255,  1,  0,0,0,255);
end


--------------------------------------------------------------------
-- 경험치 퍼센트로 계산 게이지바 퍼센트로 뿌려줌
--------------------------------------------------------------------
function GetMyExpGauge(exp, exptoLevel)

	local GaugePersent = 0
	if exptoLevel > 0 then
		GaugePersent = exp * 100 / exptoLevel
	else
		exp = 0
	end 
	
	winMgr:getWindow("MyInfo_RemainEXPBar"):setSize((143 * GaugePersent / 100), 15);
	winMgr:getWindow("MyInfo_RemainEXPBar"):setVisible(true);
	winMgr:getWindow("MyInfo_EXPText"):clearTextExtends();
	winMgr:getWindow("MyInfo_EXPText"):addTextExtends(tostring(exp).." / "..tostring(exptoLevel), g_STRING_FONT_GULIM,111, 255,255,255,255,  0,  0,0,0,255);
	winMgr:getWindow("MyInfo_EXPPersent"):clearTextExtends();
	winMgr:getWindow("MyInfo_EXPPersent"):addTextExtends(tostring(GaugePersent).."%", g_STRING_FONT_GULIM,112, 255,255,255,255,  1,  0,0,0,255);
	
	print(tostring(GaugePersent).."%")
end


--------------------------------------------------------------------
-- 머니 현황
--------------------------------------------------------------------
function GetMyInfoMoney(Point)--Point(Point, Coin, Cash)--, Life)
	winMgr:getWindow("My_HaveGranText"):clearTextExtends();
	local r, g, b	= ColorToMoney(Point)
	winMgr:getWindow("My_HaveGranText"):addTextExtends(CommatoMoneyStr(Point), g_STRING_FONT_GULIMCHE,12, r, g, b,255,  0,  0,0,0,255);
end


function GetMyInfoCoin(coin)	--코인을 리프레쉬
	winMgr:getWindow("My_HaveCoinText"):clearTextExtends();
	local r, g, b	= ColorToMoney(coin)
	winMgr:getWindow("My_HaveCoinText"):addTextExtends(CommatoMoneyStr(coin), g_STRING_FONT_GULIMCHE,12, r, g, b,255,  0,  0,0,0,255);
end


function GetMyInfoCash(Cash)	--캐시을 리프레쉬
	winMgr:getWindow("My_HaveCashText"):clearTextExtends();
	local r, g, b	= ColorToMoney(Cash)
	winMgr:getWindow("My_HaveCashText"):addTextExtends(CommatoMoneyStr(Cash), g_STRING_FONT_GULIMCHE,12, r, g, b,255,  0,  0,0,0,255);
end



--------------------------------------------------------------------
-- 유저 랭킹정보 랜더
--------------------------------------------------------------------
function MyInfoRankRender(args)
	local FirstPosY = 123
	local Term		= 24
	local _drawer = CEGUI.toWindowEventArgs(args).window:getDrawer();
	
	-- 개인전대전	
	_drawer:setFont(g_STRING_FONT_GULIM, 14)
	Size = GetStringSize(g_STRING_FONT_GULIM, 14, tUserRecord[RECORD_PRIVATE_PLAYCOUNT])
	common_DrawOutlineText1(_drawer, tUserRecord[RECORD_PRIVATE_PLAYCOUNT], 76 - (Size / 2), 11, 0,0,0,255, 255,255,255,255);
	-- 팀전대전
	Size = GetStringSize(g_STRING_FONT_GULIM, 14, tUserRecord[RECORD_PUBLIC_PLAYCOUNT])
	common_DrawOutlineText1(_drawer, tUserRecord[RECORD_PUBLIC_PLAYCOUNT], 76 - (Size / 2), 46, 0,0,0,255, 255,255,255,255);
	-- KO률
	_drawer:setFont(g_STRING_FONT_GULIM, 25)
	Size = GetStringSize(g_STRING_FONT_GULIM, 25, tUserRecord[RECORD_KO_RATE])
	common_DrawOutlineText1(_drawer, tUserRecord[RECORD_KO_RATE], 162 - (Size / 2), 35, 243,16,0,255, 255,255,255,255);
	
	-- Exp
	_drawer:setFont(g_STRING_FONT_GULIM, 14)
	Size = GetStringSize(g_STRING_FONT_GULIM, 14, tUserRecord[RECORD_TOTAL_EXP])
	common_DrawOutlineText1(_drawer, tUserRecord[RECORD_TOTAL_EXP], 128 - Size, FirstPosY, 243,16,0,255, 255,255,255,255);
	
	-- ExpRanking
	_drawer:setFont(g_STRING_FONT_GULIM, 14)
	Size = GetStringSize(g_STRING_FONT_GULIM, 14, tUserRank[RANK_TOTAL_EXP])
	common_DrawOutlineText1(_drawer, tUserRank[RANK_TOTAL_EXP], 195 - Size, FirstPosY, 243,16,0,255, 255,255,255,255);
	
	-- LadderExp
	_drawer:setFont(g_STRING_FONT_GULIM, 14)
	Size = GetStringSize(g_STRING_FONT_GULIM, 14, tUserRecord[RECORD_LADDER_EXP])
	common_DrawOutlineText1(_drawer, tUserRecord[RECORD_LADDER_EXP], 128 - Size, FirstPosY + Term, 243,93,0,255, 255,255,255,255);
	
	-- LadderExpRanking
	_drawer:setFont(g_STRING_FONT_GULIM, 14)
	Size = GetStringSize(g_STRING_FONT_GULIM, 14, tUserRank[RANK_LADDER])
	common_DrawOutlineText1(_drawer, tUserRank[RANK_LADDER], 195 - Size, FirstPosY + Term, 243,93,0,255, 255,255,255,255);
	
	-- KO
	_drawer:setFont(g_STRING_FONT_GULIM, 14)
	Size = GetStringSize(g_STRING_FONT_GULIM, 14, tUserRecord[RECORD_TOTAL_KO])
	common_DrawOutlineText1(_drawer, tUserRecord[RECORD_TOTAL_KO], 128 - Size, FirstPosY + Term*2, 243,178,0,255, 255,255,255,255);
	
	-- KORank
	_drawer:setFont(g_STRING_FONT_GULIM, 14)
	Size = GetStringSize(g_STRING_FONT_GULIM, 14, tUserRank[RANK_KO])
	common_DrawOutlineText1(_drawer, tUserRank[RANK_KO], 195 - Size, FirstPosY + Term*2, 243,178,0,255, 255,255,255,255);

	-- MVP
	_drawer:setFont(g_STRING_FONT_GULIM, 14)
	Size = GetStringSize(g_STRING_FONT_GULIM, 14, tUserRecord[RECORD_MVP])
	common_DrawOutlineText1(_drawer, tUserRecord[RECORD_MVP], 128 - Size, FirstPosY + Term*3, 84,191,52,255, 255,255,255,255);
	
	-- MVPRank
	_drawer:setFont(g_STRING_FONT_GULIM, 14)
	Size = GetStringSize(g_STRING_FONT_GULIM, 14, tUserRank[RANK_MVP])
	common_DrawOutlineText1(_drawer, tUserRank[RANK_MVP], 195 - Size, FirstPosY + Term*3, 84,191,52,255, 255,255,255,255);

	-- Team
	_drawer:setFont(g_STRING_FONT_GULIM, 14)
	Size = GetStringSize(g_STRING_FONT_GULIM, 14, tUserRecord[RECORD_TEAM])
	common_DrawOutlineText1(_drawer, tUserRecord[RECORD_TEAM], 128 - Size, FirstPosY + Term*4, 52,160,191,255, 255,255,255,255);

	-- TeamRank
	_drawer:setFont(g_STRING_FONT_GULIM, 14)
	Size = GetStringSize(g_STRING_FONT_GULIM, 14, tUserRank[RANK_TEAM_ATTACK])
	common_DrawOutlineText1(_drawer, tUserRank[RANK_TEAM_ATTACK], 195 - Size, FirstPosY + Term*4, 52,160,191,255, 255,255,255,255);
		
	-- Double
	_drawer:setFont(g_STRING_FONT_GULIM, 14)
	Size = GetStringSize(g_STRING_FONT_GULIM, 14, tUserRecord[RECORD_DOUBLE])
	common_DrawOutlineText1(_drawer, tUserRecord[RECORD_DOUBLE], 128 - Size, FirstPosY + Term*5, 42,74,115,255, 255,255,255,255);
	
	-- DoubleRank
	_drawer:setFont(g_STRING_FONT_GULIM, 14)
	Size = GetStringSize(g_STRING_FONT_GULIM, 14, tUserRank[RANK_DOUBLE_ATTACK])
	common_DrawOutlineText1(_drawer, tUserRank[RANK_DOUBLE_ATTACK], 195 - Size, FirstPosY + Term*5, 42,74,115,255, 255,255,255,255);

	-- Perfect
	_drawer:setFont(g_STRING_FONT_GULIM, 14)
	Size = GetStringSize(g_STRING_FONT_GULIM, 14, tUserRecord[RECORD_PERFECT])
	common_DrawOutlineText1(_drawer, tUserRecord[RECORD_PERFECT], 128 - Size, FirstPosY + Term*6, 52,86,191,255, 255,255,255,255);
	
	-- PerfectRank
	_drawer:setFont(g_STRING_FONT_GULIM, 14)
	Size = GetStringSize(g_STRING_FONT_GULIM, 14, tUserRank[RANK_PERFECT])
	common_DrawOutlineText1(_drawer, tUserRank[RANK_PERFECT], 195 - Size, FirstPosY + Term*6, 52,86,191,255, 255,255,255,255);
	
	-- CONSECUTIVE_WIN
	_drawer:setFont(g_STRING_FONT_GULIM, 14)
	Size = GetStringSize(g_STRING_FONT_GULIM, 14, tUserRecord[RECORD_CONSECUTIVE_WIN])
	common_DrawOutlineText1(_drawer, tUserRecord[RECORD_CONSECUTIVE_WIN], 128 - Size, FirstPosY + Term*7, 0,157,59,255, 255,255,255,255);
	
	-- CONSECUTIVE_WINRank
	_drawer:setFont(g_STRING_FONT_GULIM, 14)
	Size = GetStringSize(g_STRING_FONT_GULIM, 14, tUserRank[RANK_CONSECUTIVE_WIN])
	common_DrawOutlineText1(_drawer, tUserRank[RANK_CONSECUTIVE_WIN], 195 - Size, FirstPosY + Term*7, 0,157,59,255, 255,255,255,255);
	
	-- RECORD_CONSECUTIVE_WIN_BREAK
	_drawer:setFont(g_STRING_FONT_GULIM, 14)
	Size = GetStringSize(g_STRING_FONT_GULIM, 14, tUserRecord[RECORD_CONSECUTIVE_WIN_BREAK])
	common_DrawOutlineText1(_drawer, tUserRecord[RECORD_CONSECUTIVE_WIN_BREAK], 128 - Size, FirstPosY + Term*8, 153,0,157,255, 255,255,255,255);
	
	-- RECORD_CONSECUTIVE_WIN_BREAKRank
	_drawer:setFont(g_STRING_FONT_GULIM, 14)
	Size = GetStringSize(g_STRING_FONT_GULIM, 14, tUserRank[RANK_CONSECUTIVE_WIN_BREAK])
	common_DrawOutlineText1(_drawer, tUserRank[RANK_CONSECUTIVE_WIN_BREAK], 195 - Size, FirstPosY + Term*8, 153,0,157,255, 255,255,255,255);

--	_drawer:drawText(CostumkindStr, )

end
--------------------------------------------------------------------
-- 특수효과 텍스트
--------------------------------------------------------------------
function GetSpecialEffect(EffectText_Nick, EffectText_Hair, EffectText_Face, EffectText_Upper, EffectText_Lower, 
		EffectText_Foot, EffectText_Hand, EffectText_Set, EffectText_Tatoo, EffectText_Ring, EffectText_Accesori)
	
	tEffectTextTable = {['protecterr'] = 0, EffectText_Nick, EffectText_Hair, EffectText_Face, EffectText_Upper, EffectText_Lower, 
		EffectText_Foot, EffectText_Hand, EffectText_Set, EffectText_Tatoo, EffectText_Ring, EffectText_Accesori}
	
end
--------------------------------------------------------------------
-- 캐릭터 리프레쉬
--------------------------------------------------------------------
function CharacterRefresh(experience, coin, level, money, promotion, type, life, privatePlayCount, publicPlayCount, KORate, totalKO,
			statATK_STR, statATK_GRA, statDEF_STR, statDEF_GRA, statCRI, HP, SP, statDEX, statDEF, statATK, name, style, LadderExp, 
			MVP, Team, Double, Perfect, Consecutivewin, ConsecutivewinBreak, Grade, Cash, guild, MyTitle, Clubtitle)

	local _my_name, _money, _level, _promotion, _my_style, _type, _sp_point, _hp_point, _experience = GetMyInfo(false);
	g_MyName			= _my_name;
	g_InfoCharacterName = name;	
	g_TitleIndex		= MyTitle
	
	local _ExptoLevel	= GetExptoLevel(level);
	GetMyInfoMoney(money)--, coin, Cash)--, life);					-- 돈을 리프레쉬
	GetMyInfoCoin(coin)--, coin, Cash)--, life);					-- 돈을 리프레쉬
	GetMyInfoCash(Cash)--, coin, Cash)--, life);					-- 돈을 리프레쉬
	
	GetMyCharacterImage(type, life);			-- 케릭터 이미지 띄워줌.
	GetMyCharacterBasicInfo(level, name, style, promotion, Grade, guild, MyTitle, Clubtitle);
	GetMyExpGauge(experience, _ExptoLevel);
	GetUserStat(statATK_STR, statATK_GRA, statDEF_STR, statDEF_GRA, statCRI, HP, SP);
	GetUserRecord(privatePlayCount, publicPlayCount, KORate, totalKO, QuestClear, LadderExp, MVP, 
					Team, Double, Perfect, Consecutivewin, ConsecutivewinBreak)
	--GetUserRecord(privatePlayCount, publicPlayCount, totalDown, totalKO, QuestClear, MVP, Team, Double);
	
end


--------------------------------------------------------------------
-- 내 정보 / 상대 정보 보여주기(메인.)
--------------------------------------------------------------------
function MyinfoShow()
	if g_InfoCharacterName == g_MyName then
		winMgr:getWindow("My_GranCashImage"):setVisible(true);
		winMgr:getWindow("Myinfo_TitleImage"):setTexture("Enabled", "UIData/myinfo.tga", 810, 0)
		winMgr:getWindow("Myinfo_TitleImage"):setTexture("Disabled", "UIData/myinfo.tga", 810, 0)
		winMgr:getWindow("Myinfo_TitleImage"):setSize(86, 29)
		winMgr:getWindow("MyInfo_DetailRecordWindow"):setVisible(false)
--		winMgr:getWindow("Myinfo_Rank"):setEnabled(true)		
		winMgr:getWindow("Myinfo_TitleName"):setEnabled(true)
		winMgr:getWindow("Myinfo_SpecialEffect"):setEnabled(true)
		
		
	
	else
		winMgr:getWindow("Myinfo_TitleImage"):setTexture("Enabled", "UIData/myinfo.tga", 845, 0)
		winMgr:getWindow("Myinfo_TitleImage"):setTexture("Disabled", "UIData/myinfo.tga", 845, 0)
		winMgr:getWindow("Myinfo_TitleImage"):setSize(105, 29)
		winMgr:getWindow("My_GranCashImage"):setVisible(false)
		winMgr:getWindow("MyInfo_DetailRecordWindow"):setVisible(false)
		--if RankShowEnable == false then
--		winMgr:getWindow("Myinfo_Rank"):setEnabled(false)		-- 나중에 상대 전적 볼 수 있게해주는건 캐쉬아이템
		winMgr:getWindow("Myinfo_TitleName"):setEnabled(false)
		winMgr:getWindow("Myinfo_SpecialEffect"):setEnabled(false)
		--end
	end
	winMgr:getWindow("Myinfo_Character"):setProperty("Selected", "true")	-- 라디오버튼 초기화
	winMgr:getWindow("Myinfo_Stat"):setProperty("Selected", "true")		
	
	winMgr:getWindow("Myinfo_BackImage"):setVisible(true)
	winMgr:getWindow("MyInfo_SpecialBackImg"):setVisible(false)
	root:addChildWindow(winMgr:getWindow("Myinfo_BackImage"));
	
end


-- 아이템 정보를 
function ShowWearItemSetting()
	for i = 0, #tItemAttachItemName do
		winMgr:getWindow(tItemAttachButtonName[i]):setUserString("Index", tostring(-1))		-- 내부 인덱스 초기화
		winMgr:getWindow(tItemAttachName[i]):setVisible(false)
		winMgr:getWindow(tItemAttachItemName[i]):setTexture("Enabled", "UIData/invisible.tga", 0,0)
		winMgr:getWindow(tItemAttachItemName[i]):setTexture("Disabled", "UIData/invisible.tga", 0,0)
	end

	for i = 0, #tItemWearTable do
		ToC_SetMyinfoWearItem(i)
	end
end

											
function ShowMyinfoWearItem(AttachIndex, Index, fileName)
	
	local wearIndex = tItemWearTable[AttachIndex]
	local FileName = "UIData/ItemUIData/"..fileName
	
	winMgr:getWindow(tItemAttachName[wearIndex]):setVisible(true)
	winMgr:getWindow(tItemAttachButtonName[wearIndex]):setUserString("Index", tostring(Index))		-- 내부 인덱스 초기화
	winMgr:getWindow(tItemAttachItemName[wearIndex]):setTexture("Enabled", FileName, 0,0)
	winMgr:getWindow(tItemAttachItemName[wearIndex]):setTexture("Disabled", FileName, 0,0)

end

--------------------------------------------------------------------
-- 내정보 닫기.
--------------------------------------------------------------------
function CloseMyInfoButton()
	--캐릭 이미지 false로
	for i = 0, #tMyCharacterImageName do
		winMgr:getWindow(tMyCharacterImageName[i]):setVisible(false);
	end
	winMgr:getWindow("Myinfo_BackImage"):setVisible(false)
	winMgr:getWindow("MyInfo_DetailRecordWindow"):setVisible(false)
end



----------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------

-- 칭호부분

--------------------------------------------------------------------
--------------------------------------------------------------------
-- 칭호탭 선택시 보여주는 이미지.
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Myinfo_TitleBackImg")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(6, 75)
mywindow:setSize(489, 348)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(true)
myinfobackwindow:addChildWindow(mywindow)


--------------------------------------------------------------------
-- 칭호리스트 보여줄 바탕 이미지
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Myinfo_TitleListBackImg")
mywindow:setTexture("Enabled", "UIData/myinfo.tga", 504, 133)
mywindow:setTexture("Disabled", "UIData/myinfo.tga", 504, 133)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(8, 10)
mywindow:setSize(220, 307)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("Myinfo_TitleBackImg"):addChildWindow(mywindow)


local	MaxTitleCount	= 10
local	First_PosY		= 33
local	Term			= 27


for i = 1, MaxTitleCount do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", "TitleButton"..i)
	mywindow:setTexture("Normal", "UIData/invisible.tga", 0, 882)
	mywindow:setTexture("Hover", "UIData/myinfo.tga", 504, 86)
	mywindow:setTexture("Pushed", "UIData/myinfo.tga", 504, 86)
	mywindow:setTexture("SelectedNormal", "UIData/myinfo.tga", 504, 110)
	mywindow:setTexture("SelectedHover", "UIData/myinfo.tga", 504, 110)
	mywindow:setTexture("SelectedPushed", "UIData/myinfo.tga", 504, 110)
	mywindow:setTexture("Disabled",	"UIData/invisible.tga", 0, 0)
	mywindow:setProperty("GroupID", 151)
	mywindow:setPosition(0, First_PosY + (i - 1) * Term)
	mywindow:setSize(220, 22)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("TitleIndex", tostring(i))
	mywindow:setSubscribeEvent("SelectStateChanged", "TitleClickEvent")
	mywindow:subscribeEvent("MouseButtonDown", "TitleButtonMouseDown");
	mywindow:subscribeEvent("MouseButtonUp", "TitleButtonMouseUp");
	mywindow:subscribeEvent("MouseLeave", "TitleButtonMouseLeave");
	mywindow:subscribeEvent("MouseEnter", "TitleButtonMouseEnter");
	mywindow:subscribeEvent("MouseDoubleClicked", "TitleButtonDoubleClick");
	winMgr:getWindow("Myinfo_TitleListBackImg"):addChildWindow(mywindow)
	
	
	--------------------------------------------------------------------
	-- 칭호 장착버튼
	--------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/Button", "My_TitleUseButton"..i)
	mywindow:setTexture("Normal", "UIData/myinfo2.tga", 671, 833)
	mywindow:setTexture("Hover", "UIData/myinfo2.tga", 671, 851)
	mywindow:setTexture("Pushed", "UIData/myinfo2.tga", 671, 869)
	mywindow:setTexture("PushedOff", "UIData/myinfo2.tga", 671, 869)
	mywindow:setTexture("Disabled", "UIData/myinfo2.tga", 671, 887)
	mywindow:setPosition(160, 2)
	mywindow:setSize(55, 18)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", "My_TitleUseButtonEvent")
	winMgr:getWindow("TitleButton"..i):addChildWindow(mywindow)
	
	--------------------------------------------------------------------
	-- 칭호 해제버튼
	--------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/Button", "My_TitleReleaseButton"..i)
	mywindow:setTexture("Normal", "UIData/myinfo2.tga", 726, 833)
	mywindow:setTexture("Hover", "UIData/myinfo2.tga", 726, 851)
	mywindow:setTexture("Pushed", "UIData/myinfo2.tga", 726, 869)
	mywindow:setTexture("PushedOff", "UIData/myinfo2.tga", 726, 869)
	mywindow:setTexture("Disabled", "UIData/myinfo2.tga", 726, 887)
	mywindow:setPosition(160, 2)
	mywindow:setSize(55, 18)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", "My_TitleReleaseButtonEvent")
	winMgr:getWindow("TitleButton"..i):addChildWindow(mywindow)
	
	
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "My_TitleWithoutText"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(160, 5)
	mywindow:setSize(55, 18)
	mywindow:setZOrderingEnabled(false)	
	mywindow:setViewTextMode(1)
	mywindow:setAlign(8)
	mywindow:setLineSpacing(3)
	mywindow:setEnabled(false)
	winMgr:getWindow("TitleButton"..i):addChildWindow(mywindow)

	mywindow = winMgr:createWindow("TaharezLook/StaticText", "My_TitleNameText"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(7, 3)
	mywindow:setSize(150, 18)
	mywindow:setZOrderingEnabled(false)	
	mywindow:setFont(g_STRING_FONT_GULIM, 12)
	mywindow:setTextColor(80, 80, 80, 255)
	mywindow:setEnabled(false)
	winMgr:getWindow("TitleButton"..i):addChildWindow(mywindow)
		
end


-- 페이지 설정 텍스트
mywindow = winMgr:createWindow("TaharezLook/StaticText", "My_TitlePageText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setPosition(76, 325)
mywindow:setSize(70, 18)
mywindow:setZOrderingEnabled(false)	
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(1)
mywindow:setEnabled(false)
winMgr:getWindow("Myinfo_TitleBackImg"):addChildWindow(mywindow)

winMgr:getWindow("My_TitlePageText"):clearTextExtends();
winMgr:getWindow("My_TitlePageText"):addTextExtends("1 / 1" ,g_STRING_FONT_GULIM, 15, 255,255,255,255,  0,  20,20,20,255);
	
----------------------------------------------------------------------------------
-- 페이지 좌, 우 버튼
----------------------------------------------------------------------------------
local tTitle_PageButtonName		= {['err']=0, "Title_Left", "Title_Right" }
local tTitle_PageButtonPosX		= {['err']=0, 65, 140 }
local tTitle_PageButtonTexX		= {['err']=0, 987,	970}
local tTitle_PageButtonEvent	= {['err']=0, "Title_LeftButtonEvent", "Title_RightButtonEvent" }

for i = 1, #tTitle_PageButtonName do

	mywindow = winMgr:createWindow("TaharezLook/Button", tTitle_PageButtonName[i])
	mywindow:setTexture("Normal", "UIData/myinfo.tga", tTitle_PageButtonTexX[i] , 0)
	mywindow:setTexture("Hover", "UIData/myinfo.tga",  tTitle_PageButtonTexX[i], 22)
	mywindow:setTexture("Pushed", "UIData/myinfo.tga",  tTitle_PageButtonTexX[i], 44)
	mywindow:setTexture("PushedOff", "UIData/myinfo.tga", tTitle_PageButtonTexX[i], 44)
	mywindow:setPosition(tTitle_PageButtonPosX[i], 322)
	mywindow:setSize(17, 22)
	mywindow:subscribeEvent("Clicked", tTitle_PageButtonEvent[i])
	winMgr:getWindow("Myinfo_TitleBackImg"):addChildWindow(mywindow)
end

local NOT_POSSESION	= 0
local POSSESION		= 1
local USE			= 2
local SELECTED		= 3

local tPossesionColor	= {['err']=0, 255, 187, 0}		-- 노랑(보유)
local tSelectColor		= {['err']=0, 255, 255, 255}	-- 흰색(선택)
local tBaseColor		= {['err']=0, 170, 170, 170}		-- 회색(기본)
local tUseColor			= {['err']=0, 87, 242, 9}		-- 녹색(착용)

local tTitleColorOldTable	= {['err']=0, }
local tTitleStateTable	= {['err']=0, tBaseColor, tPossesionColor, tUseColor, tSelectColor}
local tSetTitleColor	= {['err']=0, }

-- 칭호 사용 버튼
function My_TitleUseButtonEvent(args)
	local EventWindow	= CEGUI.toWindowEventArgs(args).window
	local mywindow		= EventWindow:getParent()		-- 부모 윈도우
	
	local Index			= tonumber(mywindow:getUserString("TitleIndex"))
	winMgr:getWindow("TitleButton"..Index):setProperty("Selected", "true")
	
	Toc_UseTitle(false, true, Index - 1)		-- 더블클릭인지 버튼(true)인지, 해제인지 사용(true)인지, 칭호리스트 인덱스
	--EventWindow:getparent

end


-- 칭호 해제 버튼
function My_TitleReleaseButtonEvent(args)
	local EventWindow	= CEGUI.toWindowEventArgs(args).window
	local mywindow		= EventWindow:getParent()		-- 부모 윈도우

	local Index			= tonumber(mywindow:getUserString("TitleIndex"))
	winMgr:getWindow("TitleButton"..Index):setProperty("Selected", "true")
	
	Toc_UseTitle(false, false, Index - 1)		-- 더블클릭인지 버튼(true)인지, 해제인지 사용(true)인지, 칭호리스트 인덱스
end

-- 칭호 사용후
function UseRefreshTitleList(page)

	ToC_RefreshTitleList(page)

end

-- 칭호 왼쪽 페이지버튼 이벤트
function Title_LeftButtonEvent(args)

	local bOK, CurrentPage	= Toc_Title_LeftButtonClick()
	if bOK then
		ToC_RefreshTitleList(CurrentPage)
		winMgr:getWindow("TitleButton1"):setProperty("Selected", "true")
--		tTitleColorOldTable[1]	= tSetTitleColor[1]
		tSetTitleColor[1]		= SELECTED + 1
		
		local Name, Desc, Effect = ToC_SelectTitle(1)
		Desc	= AdjustString(g_STRING_FONT_GULIM, 12, Desc, 200)
		Effect	= AdjustString(g_STRING_FONT_GULIM, 12, Effect, 200)
		TitleTextRefresh(Name, Desc, Effect)		
	end

end


-- 칭호 오른쪽 페이지버튼 이벤트
function Title_RightButtonEvent(args)
	
	local bOK, CurrentPage	= Toc_Title_RightButtonClick()
	if bOK then
		ToC_RefreshTitleList(CurrentPage)
		winMgr:getWindow("TitleButton1"):setProperty("Selected", "true")
--		tTitleColorOldTable[1]	= tSetTitleColor[1]
		tSetTitleColor[1]		= SELECTED + 1
		
		local Name, Desc, Effect = ToC_SelectTitle(1)
		Desc	= AdjustString(g_STRING_FONT_GULIM, 12, Desc, 200)
		Effect	= AdjustString(g_STRING_FONT_GULIM, 12, Effect, 200)
		TitleTextRefresh(Name, Desc, Effect)		

	end
	
end




-- 칭호의 페이지를 세팅해준다
function SetTextTitleTotalPage(CurrentPage)
	totalpage	= ToC_GetTitleTotalPage()
	winMgr:getWindow("My_TitlePageText"):clearTextExtends();
	winMgr:getWindow("My_TitlePageText"):addTextExtends(tostring(CurrentPage).." / "..tostring(totalpage), g_STRING_FONT_GULIM, 15, 255,255,255,255,  0,  20,20,20,255);
end


-- 라디오버튼 이름 초기화
function ResetNameText()
	for i = 1, MaxTitleCount do
		winMgr:getWindow("My_TitleNameText"..i):setText("")
		winMgr:getWindow("TitleButton"..i):setVisible(false)
		winMgr:getWindow("TitleButton"..i):setEnabled(false)
	end
end


-- 리스트 리프레쉬
function TitleListTextRefresh(Index, State, Name)
	local	tableBuf	= tTitleStateTable[State + 1]
	tSetTitleColor[Index]		= State + 1
	tTitleColorOldTable[Index]	= State + 1
	winMgr:getWindow("TitleButton"..Index):setVisible(true)
	winMgr:getWindow("TitleButton"..Index):setEnabled(true)
	winMgr:getWindow("My_TitleNameText"..Index):setTextColor(tableBuf[1], tableBuf[2], tableBuf[3], 255)
	winMgr:getWindow("My_TitleNameText"..Index):setText(Name)
	
	if State == NOT_POSSESION then
		winMgr:getWindow("My_TitleUseButton"..Index):setVisible(false)
		winMgr:getWindow("My_TitleReleaseButton"..Index):setVisible(false)
		winMgr:getWindow("My_TitleWithoutText"..Index):setVisible(true)	
	elseif State == POSSESION then
		winMgr:getWindow("My_TitleUseButton"..Index):setVisible(true)
		winMgr:getWindow("My_TitleReleaseButton"..Index):setVisible(false)
		winMgr:getWindow("My_TitleWithoutText"..Index):setVisible(false)		
	elseif State == USE then
		winMgr:getWindow("My_TitleUseButton"..Index):setVisible(false)
		winMgr:getWindow("My_TitleReleaseButton"..Index):setVisible(true)
		winMgr:getWindow("My_TitleWithoutText"..Index):setVisible(false)				
	end	
end

function TitleTextRefresh(Name, Desc, Effect)
	
	winMgr:getWindow("Title_NameText"):clearTextExtends();
	winMgr:getWindow("Title_NameText"):addTextExtends(Name ,g_STRING_FONT_GULIM, 13, 255,205,86,255,  0,  255,255,255,255);

	winMgr:getWindow("Title_DescText"):clearTextExtends();
	winMgr:getWindow("Title_DescText"):addTextExtends(Desc, g_STRING_FONT_GULIM, 12, 200,200,200,255,  0,  20,20,20,255);

	winMgr:getWindow("Title_EffectText"):clearTextExtends();
	winMgr:getWindow("Title_EffectText"):addTextExtends(Effect ,g_STRING_FONT_GULIM, 12, 87,242,9,255,  0,  20,20,20,255);


end


-- 칭호버튼 더블클릭 이벤트
function TitleButtonDoubleClick(args)
	local EventWindow	= CEGUI.toWindowEventArgs(args).window
	local Index			= tonumber(EventWindow:getUserString("TitleIndex"))
	tTitleColorOldTable[Index]		= NOT_POSSESION + 1
	Toc_UseTitle(true, false, Index - 1)		-- 더블클릭인지 버튼(true)인지, 해제인지 사용(true)인지, 칭호리스트 인덱스
end

-- 칭호 버튼 클릭 이벤트
function TitleClickEvent(args)
	local EventWindow	= CEGUI.toWindowEventArgs(args).window
	local Index			= tonumber(EventWindow:getUserString("TitleIndex"))
	local ColorIndex	= 0
	
	if CEGUI.toRadioButton(EventWindow):isSelected() then		
		tTitleColorOldTable[Index]	= tSetTitleColor[Index]
		tSetTitleColor[Index]		= SELECTED + 1
		
		local Name, Desc, Effect = ToC_SelectTitle(Index)
		Desc	= AdjustString(g_STRING_FONT_GULIM, 12, Desc, 220)
		Effect	= AdjustString(g_STRING_FONT_GULIM, 12, Effect, 220)
		TitleTextRefresh(Name, Desc, Effect)		
		
	else
		tSetTitleColor[Index]	= tTitleColorOldTable[Index]
	end
	ColorIndex	= tSetTitleColor[Index]
	winMgr:getWindow("My_TitleNameText"..Index):setTextColor(tTitleStateTable[ColorIndex][1], tTitleStateTable[ColorIndex][2], tTitleStateTable[ColorIndex][3], 255)
end

-- 칭호 라디오버튼 마우스 들어왔을때
function TitleButtonMouseEnter(args)
	local MyWindow	= CEGUI.toMouseEventArgs(args).window;
	local Index		= tonumber(MyWindow:getUserString("TitleIndex"))
	
	winMgr:getWindow("My_TitleNameText"..Index):setTextColor(255, 255, 255, 255)
	--winMgr:getWindow("My_TitleNameText"..Index):setPosition(7, 5)

end

-- 칭호 라디오버튼 마우스 떠났을때
function TitleButtonMouseLeave(args)
	local MyWindow	= CEGUI.toMouseEventArgs(args).window;
	local Index		= tonumber(MyWindow:getUserString("TitleIndex"))
	local tableBuf	= tTitleStateTable[tSetTitleColor[Index]]
	
	winMgr:getWindow("My_TitleNameText"..Index):setTextColor(tableBuf[1], tableBuf[2], tableBuf[3], 255)
end



-- 칭호 라디오 버튼에 마우스 다운시 이벤트
function TitleButtonMouseDown(args)
	local MyWindow	= CEGUI.toMouseEventArgs(args).window;
	local Index		= tonumber(MyWindow:getUserString("TitleIndex"))
	
	winMgr:getWindow("My_TitleNameText"..Index):setPosition(9, 5)

end

-- 칭호 라디오 버튼에 마우스 업 이벤트
function TitleButtonMouseUp(args)
	local MyWindow	= CEGUI.toMouseEventArgs(args).window;
	local Index		= tonumber(MyWindow:getUserString("TitleIndex"))
	
	winMgr:getWindow("My_TitleNameText"..Index):setPosition(7, 3)

end

--------------------------------------------------------------------
-- 칭호정보 보여줄 바탕 이미지
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Myinfo_TitleInfoBackImg")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(240, 10)
mywindow:setSize(243, 307)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("Myinfo_TitleBackImg"):addChildWindow(mywindow)

--------------------------------------------------------------------
-- 타이틀 이미지
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Myinfo_TitleInfoHeaderImg")
mywindow:setTexture("Enabled", "UIData/myinfo.tga", 504, 440)
mywindow:setTexture("Disabled", "UIData/myinfo.tga", 504, 440)
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(6, 1)
mywindow:setSize(74, 22)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("Myinfo_TitleInfoBackImg"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- 칭호정보에 들어가는 라인 이미지
--------------------------------------------------------------------
for i = 1, 2 do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Myinfo_TitleLineImg"..i)
	mywindow:setTexture("Enabled", "UIData/myinfo2.tga", 501, 448)
	mywindow:setTexture("Disabled", "UIData/myinfo2.tga", 501, 448)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(0, 23 + (187 * (i - 1)))
	mywindow:setSize(243, 3)
	mywindow:setVisible(true)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("Myinfo_TitleInfoBackImg"):addChildWindow(mywindow)
end

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Myinfo_TitleLineImg3")
mywindow:setTexture("Enabled", "UIData/myinfo2.tga", 1000, 52)
mywindow:setTexture("Disabled", "UIData/myinfo2.tga", 1000, 52)
mywindow:setPosition(0, 10)
mywindow:setSize(3, 283)
mywindow:setVisible(true)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("Myinfo_TitleInfoBackImg"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- 칭호 이름, 설명, 효과 text
--------------------------------------------------------------------
local	tTitleTextName	= {['err']=0, "Title_NameText", "Title_DescText", "Title_EffectText"}
local	tTitleTextPosY	= {['err']=0,		34,					58,				225}
local	tTitleTextsizeY	= {['err']=0,		17,					150,			50}


for i = 1, #tTitleTextName do
	mywindow = winMgr:createWindow("TaharezLook/StaticText", tTitleTextName[i])
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(12, tTitleTextPosY[i])
	mywindow:setSize(220, tTitleTextsizeY[i])
	mywindow:setZOrderingEnabled(false)	
	mywindow:setViewTextMode(1)
	mywindow:setAlign(1)
	mywindow:setLineSpacing(3)
	winMgr:getWindow("Myinfo_TitleInfoBackImg"):addChildWindow(mywindow)

end
----------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------

-- 내정보에 자신의 아이템 띄워주기.

--------------------------------------------------------------------



g_SelectedPresentSlotNum = -1;
--local tDirectWearItemInfo = {['protecterr']=0, -1, -1, -1, ""}
--[[
--------------------------------------------------------------------
-- 선물함 팝업창 이벤트 함수.
--------------------------------------------------------------------
--선물함 선물받기 OK
function OnClickPresentUseOk()
     DebugStr('OnClickPresentUseOk()호출');
	local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "OnClickPresentUseOk" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- 초기화를 해야함
	
	local local_window = winMgr:getWindow("My_PresentItem"..tostring(g_SelectedPresentSlotNum));
	local PresentKey = local_window:getUserString("ItemKey");
	local keyNumber = tonumber(PresentKey);
	
	PresentReceive(keyNumber);	-- 선물을 받았다고 메세지 보내준다.
	InvenListRequest();			-- 인벤토리 리스트를 다시 요청한다.
	MyItemRefresh();			-- 내아이템 리스트, 내스킬 리스트 다시 요청
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
	local_window:removeChildWindow("InvisibleBackImage");						-- 팝업창에 붙여줬던 이미지를 제거해준다.
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
	local_window:setVisible(false)
end


--선물함 선물받기 Cancle
function OnClickPresentUseCancel()
    
	local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
	if nofunc ~= "OnClickPresentUseCancel" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- 초기화를 해야함
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
	local_window:removeChildWindow("InvisibleBackImage");						-- 팝업창에 붙여줬던 이미지를 제거해준다.
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
	local_window:setVisible(false)
	
end
--]]

--[[

function OnDirectlyWearOk()
	local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "OnDirectlyWearOk" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- 초기화를 해야함
	
	DirectPresentWear(tDirectWearItemInfo[1], tDirectWearItemInfo[2])--, tDirectWearItemInfo[3])--, tDirectWearItemInfo[4])			-- 바로 착용해주게 함수를 호출해준다.
	MyItemRefresh();			-- 내아이템 리스트, 내스킬 리스트 다시 요청
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
	local_window:removeChildWindow("InvisibleBackImage");						-- 팝업창에 붙여줬던 이미지를 제거해준다.
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
	local_window:setVisible(false)

end

function OnDirectlyWearCancel()
	local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
	if nofunc ~= "OnDirectlyWearCancel" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- 초기화를 해야함
	
	--RequestPresentInven();		-- 선물함 리스트를 다시 요청한다.
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
	local_window:removeChildWindow("InvisibleBackImage");						-- 팝업창에 붙여줬던 이미지를 제거해준다.
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
	local_window:setVisible(false)

end


--------------------------------------------------------------------
-- 선물함 받기 즉시착용할때 에러 메세지 확인버튼 클릭 함수.
--------------------------------------------------------------------
function OnDirectlyWearErrorOK()
	
	--RequestPresentInven();		-- 선물함 리스트를 다시 요청한다.

end

--]]

--------------------------------------------------------------------
-- 이미지
--------------------------------------------------------------------
-- 선물함, 인벤토리 팝업창에 쓸 투명한 이미지.
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "InvisibleBackImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 0);
mywindow:setSize(349, 222)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:subscribeEvent("EndRender", "InvisibleRender")


--------------------------------------------------------------------
-- 아이템 뒷판 이미지.
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "itemBackImgage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 524, 110)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 524, 110)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(11, 59)
mywindow:setSize(118, 101)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('InvisibleBackImage'):addChildWindow(mywindow)


tPopupTextName = {['protecterr'] = 0,'Text1', 'Text2', 'Text3'}
tPopupTextSizeX = {['protecterr'] = 0, 170, 300, 170}
tPopupTextSizeY = {['protecterr'] = 0, 100, 40, 100}
tPopupTextPosX = {['protecterr'] = 0, 135, 20, 135}
tPopupTextPosY = {['protecterr'] = 0, 87, 174, 107}

for i=1, #tPopupTextName do
	local mywindow = winMgr:createWindow("TaharezLook/StaticText", tPopupTextName[i]);
	mywindow:setProperty("FrameEnabled", "false");
	mywindow:setProperty("BackgroundEnabled", "false");
	mywindow:setVisible(true);
	mywindow:setPosition(tPopupTextPosX[i], tPopupTextPosY[i]);
	mywindow:setSize(tPopupTextSizeX[i], tPopupTextSizeY[i]);
	mywindow:setViewTextMode(1);
	mywindow:setAlign(1);
	mywindow:setLineSpacing(13);
	winMgr:getWindow('InvisibleBackImage'):addChildWindow(mywindow);
end


--local tImageSetting = {['protecterr'] = 0, 0,0,0,0}	-- sizeX, sizeY, PosX, PosY
--local tText1Setting = {['protecterr'] = 0, 0,0,0,0}
--local tText2Setting = {['protecterr'] = 0, 0,0,0,0}


function InvisibleRender()
	local _drawer = winMgr:getWindow("InvisibleBackImage"):getDrawer();
	
	winMgr:getWindow("itemBackImgage"):setPosition(11, 59)
	for i=1, #tPopupTextName do
		if i == 1 then
			winMgr:getWindow(tPopupTextName[i]):setLineSpacing(13);
			winMgr:getWindow(tPopupTextName[i]):setAlign(3);
			winMgr:getWindow(tPopupTextName[i]):setVisible(true)
			winMgr:getWindow(tPopupTextName[i]):clearTextExtends()

			local String	= string.format(MyInfo_String_PresentItemGetMsg, g_tPresentPopupInfo[2], g_tPresentPopupInfo[3])
			winMgr:getWindow(tPopupTextName[i]):addTextExtends(String, g_STRING_FONT_DODUM,13, 255,255,255,255, 1, 0,0,0,255);

		elseif i == 2 then
			winMgr:getWindow(tPopupTextName[i]):setLineSpacing(4);
			winMgr:getWindow(tPopupTextName[i]):setAlign(7);
			winMgr:getWindow(tPopupTextName[i]):setVisible(true)
			winMgr:getWindow(tPopupTextName[i]):clearTextExtends()
			--winMgr:getWindow(tPopupTextName[i]):addTextExtends("[!] ", g_STRING_FONT_DODUM,13, 255,205,86,255, 1, 0,0,0,255);
			--local String	= string.format(MyInfo_String_ReceiveRewardMsg, g_tPresentPopupInfo[4])
			--local String = "첨부된 Coin: %s Gran: %s"
			--winMgr:getWindow(tPopupTextName[i]):addTextExtends(String, g_STRING_FONT_DODUM,13, 255,255,255,255, 1, 0,0,0,255);
		elseif i == 3 then
			winMgr:getWindow(tPopupTextName[i]):setLineSpacing(13);
			winMgr:getWindow(tPopupTextName[i]):setVisible(false)
		end
	end
	
	if g_tPresentPopupInfo[3] == MyInfo_String_Nick or g_tPresentPopupInfo[3] == " " then
		_drawer:drawTexture(g_tPresentPopupInfo[1], 12, 60, 243, 108, 0, 0);		
	else
		_drawer:drawTexture(g_tPresentPopupInfo[1], 20, 60, 243, 108, 0, 0);
	end
	if g_tPresentPopupInfo[5] ~= "" then
		_drawer:drawTexture(g_tPresentPopupInfo[5], 12, 60, 243, 108, 0, 0);
	end
end

--------------------------------------------------------------------
-- 쿠폰관련 전역으로 쓸 변수.
--------------------------------------------------------------------


--------------------------------------------------------------------

-- 쿠폰 윈도우들

--------------------------------------------------------------------
--------------------------------------------------------------------
-- 쿠폰 바탕 이미지
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyInfo_CouponBackAlpha")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyInfo_CouponBackImg")
mywindow:setTexture("Enabled", "UIData/ranking.tga", 0, 455)
mywindow:setTexture("Disabled", "UIData/ranking.tga", 0, 455)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(302, 239)
mywindow:setSize(420, 238)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("MyInfo_CouponBackAlpha"):addChildWindow(mywindow)


-- 쿠폰 팝업바탕 ESC키, ENTER키 등록
RegistEscEventInfo("MyInfo_CouponBackAlpha", "CouponCancelButton")
RegistEnterEventInfo("MyInfo_CouponBackAlpha", "CouponOKButton")


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
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(tCouponEditPosX[i] - 4, 124)
	mywindow:setSize(58, 27)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("MyInfo_CouponBackImg"):addChildWindow(mywindow)
	
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
	winMgr:getWindow("MyInfo_CouponBackImg"):addChildWindow(mywindow);

	CEGUI.toEditbox(winMgr:getWindow(tCouponEditName[i])):setMaxTextLength(5)
	CEGUI.toEditbox(winMgr:getWindow(tCouponEditName[i])):subscribeEvent("EditboxFull", "CouponEditFull")
	CEGUI.toEditbox(winMgr:getWindow(tCouponEditName[i])):subscribeEvent("MouseClick", "CouponEditMouseClick");
	CEGUI.toEditbox(winMgr:getWindow(tCouponEditName[i])):subscribeEvent("TextAcceptedOnlyTab", tCouponEditEvent[i])
	CEGUI.toEditbox(winMgr:getWindow(tCouponEditName[i])):setUpper(true)	-- 소문자는 대문자로 바꿔준다

end

--------------------------------------------------------------------
-- 쿠폰 확인버튼
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "MyInfo_CouponOKButton")
mywindow:setTexture("Normal", "UIData/ranking.tga", 420, 530)
mywindow:setTexture("Hover", "UIData/ranking.tga", 420, 571)
mywindow:setTexture("Pushed", "UIData/ranking.tga", 420, 612)
mywindow:setTexture("PushedOff", "UIData/ranking.tga", 420, 653)
mywindow:setPosition(150, 182)
mywindow:setSize(121, 41)
mywindow:setZOrderingEnabled(false)
mywindow:setVisible(true)
mywindow:subscribeEvent("Clicked", "CouponOKButton")
winMgr:getWindow("MyInfo_CouponBackImg"):addChildWindow(mywindow)

--------------------------------------------------------------------
-- 쿠폰 취소버튼
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "MyInfo_CouponCancelButton")
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
winMgr:getWindow("MyInfo_CouponBackImg"):addChildWindow(mywindow)


--------------------------------------------------------------------

-- 쿠폰 함수들

--------------------------------------------------------------------
--------------------------------------------------------------------
-- 쿠폰창을 보여준다.
--------------------------------------------------------------------
function CouponShow()
	SetHanEnglishMode(0)	-- 영문모드로 설정
	winMgr:getWindow("MyInfo_CouponBackAlpha"):setVisible(true)
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
	for i = 1, #tCouponEditName do
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
			ShowNotifyOKMessage_Lua(MyInfo_String_Input_CouponNumber)
			return;
		end
		NumberText = NumberText..Buf;
	end
	
	SendCouponNum(NumberText);		-- 쿠폰번호를 서버로 넘겨준다.
	
	for i = 1, #tCouponEditName do
		winMgr:getWindow(tCouponEditName[i]):setText("")			
	end
	winMgr:getWindow("MyInfo_CouponBackAlpha"):setVisible(false)
	SetHanEnglishMode(1)	-- 한글모드로 돌아가기
end


--------------------------------------------------------------------
-- 취소버튼을 눌렀을 경우
--------------------------------------------------------------------
function CouponCancelButton()
	for i = 1, #tCouponEditName do
		winMgr:getWindow(tCouponEditName[i]):setText("")			
	end
	winMgr:getWindow("MyInfo_CouponBackAlpha"):setVisible(false)
	SetHanEnglishMode(1)	-- 한글모드로 돌아가기
end


--------------------------------------------------------------------
-- 쿠폰을 입력하고 서버로부터 오는 리턴 값
--------------------------------------------------------------------
function CouponItemReturn(ItemName, Count)
	if Count > 1 then
		local String	= string.format(MyInfo_String_Get_CouponItems, tostring(Count))
		ShowNotifyOKMessage_Lua(String)
	else
		local String	= string.format(MyInfo_String_Get_CouponItem, ItemName)
		ShowNotifyOKMessage_Lua(String)		
	end
end

--[[
----------------------------------------------------------------------
-- 프로필 호출버튼(MyInfo)
----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "ShowProfileBtn")
mywindow:setTexture("Normal", "UIData/my_room.tga", 555,416)
mywindow:setTexture("Hover", "UIData/my_room.tga", 555,445)
mywindow:setTexture("Pushed", "UIData/my_room.tga", 555,474)
mywindow:setTexture("PushedOff", "UIData/my_room.tga", 555,416)
mywindow:setPosition(205, 5)
mywindow:setSize(41, 29)
myinfobackwindow:setAlwaysOnTop(true)
mywindow:setSubscribeEvent("Clicked", "OnClickShowProfile")
winMgr:getWindow("Myinfo_CharacterBackImg"):addChildWindow(mywindow)


function OnClickShowProfile()
	local RequestProfileName = winMgr:getWindow("InfoName"):getText()
	DebugStr('RequestProfileName:'..RequestProfileName)
	if RequestProfileName == "" then
		return
	end
	ShowProfileRequest(RequestProfileName)
end
--]]