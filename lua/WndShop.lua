--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------

local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local Realroot		= winMgr:getWindow("DefaultWindow")
local drawer	= Realroot:getDrawer()
guiSystem:setGUISheet(Realroot)
Realroot:activate()

--------------------------------------------------------------------
-- ���̷� ���̵�� ����
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "root")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setWideType(6);
mywindow:setPosition(0, 0)
mywindow:setSize(1024, 768)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
Realroot:addChildWindow(mywindow)
local root = winMgr:getWindow("root")

root:setSubscribeEvent("MouseButtonUp", "OnRootMouseButtonUp")
root:setUserString("Shop_TotalPage", tostring(1))
root:setUserString("Shop_CurrentPage", tostring(1))

-- �ϴ� �޴�
-- ���� ���̷����� ������.
CurrentPos = 2

--winMgr:getWindow('BPM_ItemShopbtn'):setVisible(false)
--winMgr:getWindow('BPM_ItemShopbtn2'):setVisible(true)


--------------------------------------------------------------------
-- ä�� ���� ���� ���̱�
--------------------------------------------------------------------
root:addChildWindow(winMgr:getWindow('ChannelPositionBG'));
winMgr:getWindow('ChannelPositionBG'):setWideType(0);
winMgr:getWindow('ChannelPositionBG'):setPosition(800, 2);
winMgr:getWindow('NewMoveServerBtn'):setVisible(true)
winMgr:getWindow('NewMoveExitBtn'):setVisible(false)
ChangeChannelPosition('Shop')
--------------------------------------------------------------------
-- ���ڿ��� ���� ���� �޾ƿ´�
--------------------------------------------------------------------
local MR_String_1		= PreCreateString_1841	--GetSStringInfo(LAN_LUA_MYROOM_1)		-- ����
local MR_String_2		= PreCreateString_1842	--GetSStringInfo(LAN_LUA_MYROOM_2)		-- ����
local MR_String_3		= PreCreateString_1843	--GetSStringInfo(LAN_LUA_MYROOM_3)		-- �尩
local MR_String_4		= PreCreateString_1844	--GetSStringInfo(LAN_LUA_MYROOM_4)		-- �Ź�
local MR_String_5		= PreCreateString_1845	--GetSStringInfo(LAN_LUA_MYROOM_5)		-- ��
local MR_String_6		= PreCreateString_1846	--GetSStringInfo(LAN_LUA_MYROOM_6)		-- ���
local MR_String_7		= PreCreateString_1847	--GetSStringInfo(LAN_LUA_MYROOM_7)		-- ��
local MR_String_8		= PreCreateString_1848	--GetSStringInfo(LAN_LUA_MYROOM_8)		-- ���
local MR_String_9		= PreCreateString_1849	--GetSStringInfo(LAN_LUA_MYROOM_9)		-- ����
local MR_String_10		= PreCreateString_1850	--GetSStringInfo(LAN_LUA_MYROOM_10)		-- ��Ʈ
local MR_String_11		= PreCreateString_1852	--GetSStringInfo(LAN_LUA_MYROOM_11)		-- �ڽ�Ƭ ����
local MR_String_12		= PreCreateString_1853	--GetSStringInfo(LAN_LUA_MYROOM_12)		-- �Ⱓ
local MR_String_13		= PreCreateString_1195	--GetSStringInfo(LAN_LUA_WND_MYINFO_3)	-- �Ⱓ�� ����� �������Դϴ�.
local MR_String_14		= PreCreateString_1226	--GetSStringInfo(LAN_LUA_WND_MY_ITEM_1)	-- ������ �� ���� �������Դϴ�

local MR_String_16		= PreCreateString_1122	--GetSStringInfo(LAN_LUA_SHOP_COMMON_3)	-- Ÿ�ݰ���
local MR_String_18		= PreCreateString_1124	--GetSStringInfo(LAN_LUA_SHOP_COMMON_5)	-- ũ��Ƽ��
local MR_String_19		= PreCreateString_1125	--GetSStringInfo(LAN_LUA_SHOP_COMMON_6)	-- Ÿ�ݹ��
local MR_String_20		= PreCreateString_1126	--GetSStringInfo(LAN_LUA_SHOP_COMMON_7)	-- �����
local MR_String_21		= PreCreateString_1822	--GetSStringInfo(LAN_LUA_WND_MY_ITEM_5)	-- Ÿ��
local MR_String_22		= PreCreateString_1823	--GetSStringInfo(LAN_LUA_WND_MY_ITEM_6)	-- ���
local MR_String_23		= PreCreateString_1138	--GetSStringInfo(LAN_LUA_WND_COMMON_SHOP_2)	-- ����
local MR_String_24		= PreCreateString_1229	--GetSStringInfo(LAN_LUA_WND_MY_ITEM_4)	-- �⺻

local MR_String_47		= PreCreateString_1260	--GetSStringInfo(LAN_LUA_WND_MY_SKILL_31)	-- �뽬��
local MR_String_48		= PreCreateString_1261	--GetSStringInfo(LAN_LUA_WND_MY_SKILL_32)	-- ���̺���
local MR_String_49		= PreCreateString_1262	--GetSStringInfo(LAN_LUA_WND_MY_SKILL_33)	-- ������
local MR_String_50		= PreCreateString_1263	--GetSStringInfo(LAN_LUA_WND_MY_SKILL_34)	-- ���帰���
local MR_String_51		= PreCreateString_1264	--GetSStringInfo(LAN_LUA_WND_MY_SKILL_35)	-- ��������
local MR_String_52		= PreCreateString_1906	--GetSStringInfo(LAN_LUA_WND_MY_SKILL_39)	-- ����������
local MR_String_53		= PreCreateString_1265	--GetSStringInfo(LAN_LUA_WND_MY_SKILL_36)	-- 2�� �����̼�
local MR_String_55		= PreCreateString_1267	--GetSStringInfo(LAN_LUA_WND_MY_SKILL_38)	-- ���ݿ� ����

local Shop_String_1		= PreCreateString_1153	--GetSStringInfo(LAN_LUA_WND_ITEM_SHOP_2)	-- ����
local Shop_String_2		= PreCreateString_1154	--GetSStringInfo(LAN_LUA_WND_ITEM_SHOP_3)	-- ����
local Shop_String_3		= PreCreateString_1155	--GetSStringInfo(LAN_LUA_WND_ITEM_SHOP_4)	-- �ִ�
local Shop_String_4		= PreCreateString_1156	--GetSStringInfo(LAN_LUA_WND_ITEM_SHOP_5)	-- ����
local Shop_String_5		= PreCreateString_1157	--GetSStringInfo(LAN_LUA_WND_ITEM_SHOP_6)	-- ��Ű
local Shop_String_6		= PreCreateString_1158	--GetSStringInfo(LAN_LUA_WND_ITEM_SHOP_7)	-- ����
local Shop_String_7		= PreCreateString_1046	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_29)	-- ��Ʈ��Ʈ
local Shop_String_8		= PreCreateString_1047	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_30)	-- �±ǵ�
local Shop_String_9		= PreCreateString_1048	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_31)	-- ����
local Shop_String_10	= PreCreateString_1049	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_32)	-- ī������
local Shop_String_11	= PreCreateString_1050	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_33)	-- ����Ÿ��
local Shop_String_12	= PreCreateString_1051	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_34)	-- ����
local Shop_String_13	= PreCreateString_1052	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_35)	-- ����
local Shop_String_14	= PreCreateString_1053	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_36)	-- ���η�����
local Shop_String_15	= PreCreateString_1054	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_37)	-- �ձ⵵
local Shop_String_16	= PreCreateString_1055	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_38)	-- �ﺸ
local Shop_String_17	= PreCreateString_1998	--GetSStringInfo(LAN_LUA_SHOP_ATTACK_TYPE)		-- Ÿ�ݰ迭
local Shop_String_18	= PreCreateString_1999	--GetSStringInfo(LAN_LUA_SHOP_GRAB_TYPE)		-- ���迭
local Shop_String_19	= PreCreateString_1120	--GetSStringInfo(LAN_LUA_SHOP_COMMON_1)	-- �Ⱓ�� �������ּ���.
local Shop_String_20	= PreCreateString_1127	--GetSStringInfo(LAN_LUA_SHOP_COMMON_8)	-- �ɷ�ġ ����
local Shop_String_21	= PreCreateString_1828	--GetSStringInfo(LAN_LUA_WND_MY_ITEM_9)	-- �ɷ�ġ
local Shop_String_22	= PreCreateString_2456	--GetSStringInfo(LAN_CLASS_DIRTYX)		-- ��Ƽ����
local Shop_String_23	= PreCreateString_4694	--GetSStringInfo(LAN_ENUM_UI_ESPECIAL)	-- �����



local ShopCommon_String_Stat_No			= PreCreateString_1127	--GetSStringInfo(LAN_LUA_SHOP_COMMON_8)	-- ���ݾ���
local ShopCommon_String_Day				= PreCreateString_1057	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_40)	-- ��
local ShopCommon_String_Unlimited		= PreCreateString_1056	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_39)	-- �����ñ���
local ShopCommon_NotEnough_Gran			= PreCreateString_9		--GetSStringInfo(LAN_SHORT_MONEY)	-- �׶��� �����մϴ�
local ShopCommon_NotEnough_Cash			= PreCreateString_95	--GetSStringInfo(LAN_SHORT_CASH)	-- ĳ�ð� �����մϴ�
local ShopCommon_String_GRAN			= PreCreateString_200	--GetSStringInfo(LAN_GRAN)	-- �׶�
local ShopCommon_String_CASH			= PreCreateString_1955	--GetSStringInfo(LAN_CASH)	-- ĳ��
local ShopCommon_NeedSkill				= PreCreateString_2064	--GetSStringInfo(LAN_CAN_NOT_PURCHASE_SKILL)	-- ĳ��
 

TYPE_GRAN	= 25005		-- �׶� ����
TYPE_CASH	= 13001		-- ĳ�� ����


--------------------------------------------------------------------
-- �������� �� ����
--------------------------------------------------------------------
local	mywindow							-- �⺻ ����Ʈ ������
local	bCharacterInfoShow		= true		-- ĳ���� ���� ��ư�� ����������.
local	bRankInfoShow			= false		-- ��ŷ���� ��ư�� ����������.
local	bStatInfoShow			= true		-- �ɷ�ġ ������ ����������.
local	bEffectInfoShow			= false		-- Ư��ȿ�� ������ ����������.
local	PAGE_MAXITEM			= 8			-- ���������� ���� ������ ����.
local	PAGE_MAXSKILLTAB		= 8			-- ���������� ����ų���� ���� ����
local	MAX_COSTUM				= 10		-- �������� �ڽ�Ƭ������ �ִ밹��
local	bCharacterInfoReceive	= false		-- ĳ���� ������ �޾ƿԴ��� Ȯ��
local	bItemInfoReceive		= false		-- ������ ������ �޾ƿԴ��� Ȯ��
local	COSTUM_TYPE_COUNT		= 6			-- �ڽ�Ƭ Ÿ���� ����(����, ����....)
local	SKILL_TYPE_COUNT		= 18		-- ��ų Ÿ���� ����(��Ʈ, ����, �±�.....)
local	Selected_Window
local	TransformString			= ""		-- �԰��ִ� ���ž������� ��Ʈ���� ���´�
local	CurrentSelectTab		= 0
-- ����ٿ� �ڽ������� ����
local	Normal					= 1
local	NoClick					= 2
local	Hiden					= 3


--"����", "����", "�尩", "�Ź�", "��", "���", "��", "���", "����"}
local	tCostumKind = {['protecterr'] = 0, MR_String_1, MR_String_2, MR_String_3, MR_String_4, MR_String_5,
													MR_String_6, MR_String_7, MR_String_8, MR_String_9, MR_String_10}

local	tWearCostumIndex	= {['protecterr'] = 0, 2, 7, 3, 8, 6, 1, 5, 10, 9, 4 }		-- �������� �ڽ�Ƭ�� ����� �ε���
local	tSubFirstIcon_Name	= {['protecterr'] = 0, "Shop_CostumBtn_All", "Shop_SkillBtn_All", "Shop_EtcBtn_All", "Shop_PetBtn_All"}

local	MyStatTable			= {['protecterr'] = 0, }	-- �� ������������ ����� ���̺�
MyStatTable[1]	= {['protecterr'] = 0, }
MyStatTable[2]	= {['protecterr'] = 0, }
MyStatTable[3]	= {['protecterr'] = 0, }
MyStatTable[4]	= {['protecterr'] = 0, }
MyStatTable[5]	= {['protecterr'] = 0, }
MyStatTable[6]	= {['protecterr'] = 0, }
MyStatTable[7]	= {['protecterr'] = 0, }

local	MyinfoTable				= {['protecterr'] = 0, }	-- �� �⺻�������� ����� ���̺�
local	SelectSkillInfoTable	= {['protecterr'] = 0, 0, "", "", "", 0, 0, "", 0,0}	-- ���õ� ��ų�� ���� �������� ���� ���̺�
-- ������ ���� ��Ʈ�� ���̺�
local	tSkillStrTable			= {['protecterr']=0, Shop_String_7, Shop_String_12, Shop_String_8, Shop_String_13, Shop_String_9
												, Shop_String_14, Shop_String_10, Shop_String_15, Shop_String_11, Shop_String_16, "Dirty-X", "Dirty-X", PreCreateString_3462, PreCreateString_3462, PreCreateString_4344, PreCreateString_4344, PreCreateString_4920, PreCreateString_4920}
local	bSelectStat	= false

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
local	RECORD_CONSECUTIVE_WIN		= 11		-- ����
local	RECORD_CONSECUTIVE_WIN_BREAK= 12		-- ���°���
	
local	RANK_TOTAL_EXP				= 1
local	RANK_LADDER					= 2
local	RANK_KO						= 3
local	RANK_MVP					= 4
local	RANK_TEAM_ATTACK			= 5
local	RANK_DOUBLE_ATTACK			= 6
local	RANK_PERFECT				= 7		-- perfect
local	RANK_CONSECUTIVE_WIN		= 8		-- ����
local	RANK_CONSECUTIVE_WIN_BREAK	= 9		-- ���°���

--------------------------------------------------------------------

-- ���� ���� �������

--------------------------------------------------------------------
--------------------------------------------------------------------
-- �� Ÿ��Ʋ
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Shop_Title")
mywindow:setTexture("Enabled", "UIData/mainBG_Button001.tga", 0, 210)
mywindow:setTexture("Disabled", "UIData/mainBG_Button001.tga", 0, 210)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(30, 20)
mywindow:setSize(282, 48)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

--------------------------------------------------------------------
-- �� ���� ��ü ������ ����.
--------------------------------------------------------------------
local Shop_Mainwindow = winMgr:createWindow("TaharezLook/StaticImage", "Shop_AllBackImg")
Shop_Mainwindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
Shop_Mainwindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
Shop_Mainwindow:setProperty("FrameEnabled", "False")
Shop_Mainwindow:setProperty("BackgroundEnabled", "False")
Shop_Mainwindow:setPosition(0, 50)
Shop_Mainwindow:setSize(1024, 614)
Shop_Mainwindow:setVisible(true)
Shop_Mainwindow:setAlwaysOnTop(true)
Shop_Mainwindow:setZOrderingEnabled(false)
root:addChildWindow(Shop_Mainwindow)

local COSTUME_TAB	= 1
local SKILL_TAB		= 2
local STUFFITEM_TAB = 3
local PACKAGE_TAB	= 4
local PET_TAB		= 5
--------------------------------------------------------------------
-- �� ���� �ڽ�Ƭ, ��ų, ������ ��
--------------------------------------------------------------------

tShopTabBtn_Name	= {['protecterr']=0, "Shop_CostumeTab", "Shop_SkillTab", "Shop_ItemTab", "Shop_packageTab", "Shop_PetTab"}
tShopBtn_TexX		= {['protecterr']=0, 		429,				496,			563,			496,            563}
tShopBtn_TexY		= {['protecterr']=0, 		133,				133,			133,			238,            238}
tShopBtn_PosX		= {['protecterr']=0, 		587,				657,			727,			517,            797}
tShopBtn_PosXKor	= {['protecterr']=0, 		517,				787,			584,			651,            877}

for i = 1, #tShopTabBtn_Name do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tShopTabBtn_Name[i])
	mywindow:setTexture("Normal", "UIData/my_room.tga", tShopBtn_TexX[i], tShopBtn_TexY[i])
	mywindow:setTexture("Hover", "UIData/my_room.tga", tShopBtn_TexX[i], tShopBtn_TexY[i] + 35)
	mywindow:setTexture("Pushed", "UIData/my_room.tga", tShopBtn_TexX[i], tShopBtn_TexY[i] + 70)
	mywindow:setTexture("SelectedNormal", "UIData/my_room.tga", tShopBtn_TexX[i], tShopBtn_TexY[i] + 70)
	mywindow:setTexture("SelectedHover", "UIData/my_room.tga", tShopBtn_TexX[i], tShopBtn_TexY[i] + 70)
	mywindow:setTexture("SelectedPushed", "UIData/my_room.tga", tShopBtn_TexX[i], tShopBtn_TexY[i] + 70)
	mywindow:setProperty("GroupID", 24)	--??
	mywindow:setSize(67, 35)
	mywindow:setPosition(tShopBtn_PosX[i], 25)	
	mywindow:setVisible(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setAlwaysOnTop(false)
	mywindow:subscribeEvent("SelectStateChanged", "Shop_TabKindClick")

	if IsKoreanLanguage() then
		if i == COSTUME_TAB then
			mywindow:setProperty("Selected", "true")
		elseif i == SKILL_TAB then
			mywindow:setVisible(false)
		elseif i == PET_TAB then
			mywindow:setVisible(false)
		end
		mywindow:setPosition(tShopBtn_PosXKor[i], 25)
	else
		if i == PACKAGE_TAB then
			mywindow:setProperty("Selected", "true")
			mywindow:setPosition(tShopBtn_PosX[i], 25)
		end
	end
	
	if i == STUFFITEM_TAB then
		window = winMgr:createWindow("TaharezLook/StaticImage", "Shop_ItemTabEffect")
		window:setTexture("Enabled", "UIData/my_room.tga", 801, 983)
		window:setTexture("Disabled", "UIData/my_room.tga", 801, 983)
		window:setPosition(63, -15)
		window:setSize(34, 34)
		window:setVisible(true)
		window:setEnabled(false)
		window:setAlwaysOnTop(true)
		window:setZOrderingEnabled(false)
		winMgr:getWindow("Shop_ItemTab"):addChildWindow(window)
	end
	
	Shop_Mainwindow:addChildWindow(mywindow)
end

if CheckfacilityData(FACILITYCODE_PETSYSTEM) == 0 then
	winMgr:getWindow("Shop_PetTab"):setVisible(false)
end

local tLeftMainImgName	= {["protecterr"] = 0, "Shop_CharacterBackImg", "Shop_SkillBackImg", "Shop_CharacterBackImg", "Shop_CharacterBackImg", "Shop_CharacterBackImg"}

--------------------------------------------------------------------
-- �� ���� Ÿ��Ʋ
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Shop_MainTitle")
mywindow:setTexture("Enabled", "UIData/my_room2.tga", 0, 477)
mywindow:setTexture("Disabled", "UIData/my_room2.tga", 0, 477)
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(16, 17)
mywindow:setSize(491, 42)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
Shop_Mainwindow:addChildWindow(mywindow)


mywindow = winMgr:createWindow('TaharezLook/StaticText', 'Shop_MainTitleText');
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setPosition(0, 16);
mywindow:setSize(491, 25);
mywindow:setZOrderingEnabled(true)	
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
winMgr:getWindow("Shop_MainTitle"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- �� ���� ��ų ������ ����.
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Shop_SkillBackImg")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 13, 60)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 13, 60)
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(18, 60)
mywindow:setSize(487, 524)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("EndRender", "SkillBackRender")
Shop_Mainwindow:addChildWindow(mywindow)


--------------------------------------------------------------------
-- �� ���� �ɸ��� ������ ����.
--------------------------------------------------------------------
local Shop_CharacterBack = winMgr:createWindow("TaharezLook/StaticImage", "Shop_CharacterBackImg")
Shop_CharacterBack:setTexture("Enabled", "UIData/invisible.tga", 13, 60)
Shop_CharacterBack:setTexture("Disabled", "UIData/invisible.tga", 13, 60)
Shop_CharacterBack:setProperty("FrameEnabled", "False")
Shop_CharacterBack:setProperty("BackgroundEnabled", "False")
Shop_CharacterBack:setUserString('Info_Name',			"");				-- �̸�
Shop_CharacterBack:setUserString('Info_Club',			"");				-- Ŭ��
Shop_CharacterBack:setUserString('Info_Level',		tostring(0));		-- ����
Shop_CharacterBack:setUserString('Info_Exp',			tostring(0));		-- ����ġ
Shop_CharacterBack:setUserString('Info_LadderGrade',	tostring(0));		-- �������
Shop_CharacterBack:setUserString('Info_Title',		tostring(0));		-- Īȣ
Shop_CharacterBack:setUserString('Info_Promotion',	tostring(0));		-- ����
Shop_CharacterBack:setUserString('Info_StatAtkStr',	tostring(0));		-- ����(Ÿ�ݰ���)
Shop_CharacterBack:setUserString('Info_StatAtkGra',	tostring(0));		-- ����(������)
Shop_CharacterBack:setUserString('Info_StatCri',		tostring(0));		-- ����(ũ��)
Shop_CharacterBack:setUserString('Info_StatHp',		tostring(0));		-- ����(hp)
Shop_CharacterBack:setUserString('Info_StatSp',		tostring(0));		-- ����(sp)
Shop_CharacterBack:setUserString('Info_StatDefStr',	tostring(0));		-- ����(Ÿ�ݹ��)
Shop_CharacterBack:setUserString('Info_StatDefGra',	tostring(0));		-- ����(�����)
Shop_CharacterBack:setPosition(18, 60)
Shop_CharacterBack:setSize(487, 524)
Shop_CharacterBack:setVisible(true)
Shop_CharacterBack:setAlwaysOnTop(true)
Shop_CharacterBack:setZOrderingEnabled(false)
--Shop_CharacterBack:subscribeEvent("StartRender", "CharacterBackRender")
Shop_Mainwindow:addChildWindow(Shop_CharacterBack)

--------------------------------------------------------------------
-- �� ���� �ɸ��� ������ �����ؽ�ó.
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Shop_CharacterDisplay")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(0, 0)
mywindow:setSize(254, 449)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("Shop_CharacterBackImg"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- �� ���� �ڽ�Ƭ��, ��ų��, �������� ���� ������ ����.
--------------------------------------------------------------------
local tMainImgName	= {["protecterr"] = 0, "Shop_CostumeMainImg", "Shop_SKillMainImg", "Shop_ItemMainImg", "Shop_PackageMainImg", "Shop_PetMainImg"}

for i = 1, #tMainImgName do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", tMainImgName[i])
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 13, 60)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 13, 60)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(519, 60)
	mywindow:setSize(487, 448)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	Shop_Mainwindow:addChildWindow(mywindow)
end


--------------------------------------------------------------------
-- ��ü���� �������� �����ϴ� ������ ��ư
--------------------------------------------------------------------
ButtonName  = { ["protecterr"]=0, "Shop_PageLeft", "Shop_PageRight"}
ButtonTexX  = { ["protecterr"]=0,	987,	970}
ButtonPosX  = { ["protecterr"]=0,	700,	805}
ButtonEvent = { ["protecterr"]=0,	"Shop_PrevBt", "Shop_NextBt"}
for i=1, #ButtonName do
	mywindow = winMgr:createWindow("TaharezLook/Button", ButtonName[i])
	mywindow:setTexture("Normal", "UIData/myinfo.tga", ButtonTexX[i], 0)
	mywindow:setTexture("Hover", "UIData/myinfo.tga", ButtonTexX[i], 22)
	mywindow:setTexture("Pushed", "UIData/myinfo.tga", ButtonTexX[i], 44)
	mywindow:setTexture("PushedOff", "UIData/myinfo.tga", ButtonTexX[i], 44)
	mywindow:setPosition(ButtonPosX[i], 512)
	mywindow:setSize(17, 22)
	mywindow:setVisible(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", ButtonEvent[i])
	Shop_Mainwindow:addChildWindow(mywindow)
end


--------------------------------------------------------------------
-- ������ �ؽ�Ʈ
--------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticText', 'Shop_PageText');
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setPosition(717, 513);
mywindow:setSize(88, 20);
mywindow:setZOrderingEnabled(true)	
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
Shop_Mainwindow:addChildWindow(mywindow)


--------------------------------------------------------------------
-- �ڽ�Ƭ ����ī�װ��� ��ư�� �� ����(��ü���� ��Ȱ�� �̹���)
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Shop_CostumButtonBack")
mywindow:setTexture("Enabled", "UIData/my_room.tga", 323, 952)
mywindow:setTexture("Disabled", "UIData/my_room.tga", 323, 952)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(5, 4)
mywindow:setSize(477, 24)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("Shop_CostumeMainImg"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- �ڽ�Ƭ ����ī�װ��� ��ư(��ü, ���, ��, ����, �尩, ����, �Ź�, ����, ��Ʈ)
--------------------------------------------------------------------
tShopBtn_Name		= {['protecterr']=0, "Shop_CostumBtn_All", "Shop_CostumBtn_Hear", "Shop_CostumBtn_Face" 
											,"Shop_CostumBtn_Upper", "Shop_CostumBtn_Hand", "Shop_CostumBtn_Lower"
											,"Shop_CostumBtn_Foot", "Shop_CostumBtn_Deco", "Shop_CostumBtn_Set" }
tShopBtn_TexX		= {['protecterr']=0, 	325, 325 + (48 * 1), 325 + (48 * 2), 325 + (48 * 3), 325 + (48 * 4)
											,325 + (48 * 5), 325 + (48 * 6), 325 + (48 * 7), 325 + (48 * 8)}

for i = 1, #tShopBtn_Name do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tShopBtn_Name[i])
	mywindow:setTexture("Normal", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Hover", "UIData/my_room.tga", tShopBtn_TexX[i], 978)
	mywindow:setTexture("Pushed", "UIData/my_room.tga", tShopBtn_TexX[i], 1002)
	mywindow:setTexture("SelectedNormal", "UIData/my_room.tga", tShopBtn_TexX[i], 1002)
	mywindow:setTexture("SelectedHover", "UIData/my_room.tga", tShopBtn_TexX[i], 1002)
	mywindow:setTexture("SelectedPushed", "UIData/my_room.tga", tShopBtn_TexX[i], 1002)	
	mywindow:setPosition(2 + 48 * (i - 1), 2)
	mywindow:setProperty("GroupID", 25)
	mywindow:setSize(48, 20)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:setUserString("CategoryIndex", tostring(i))
	mywindow:subscribeEvent("SelectStateChanged", "Shop_SubTabKindClick")
	if i == 1 then
		mywindow:setProperty("Selected", "true")
	end
	winMgr:getWindow("Shop_CostumButtonBack"):addChildWindow(mywindow)
end


--------------------------------------------------------------------
-- ��ų ����ī�װ��� ��ư�� �� ����(��ü���� ��Ȱ�� �̹���)
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Shop_SkillButtonBack")
mywindow:setTexture("Enabled", "UIData/my_room2.tga", 2, 306)
mywindow:setTexture("Disabled", "UIData/my_room.tga", 2, 306)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(5, 4)
mywindow:setSize(477, 24)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("Shop_SKillMainImg"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- ��ų ����ī�װ��� ��ư(��ü, Ÿ��, ���, �ʻ��, ������, ��Ÿ)
--------------------------------------------------------------------
tShopBtn_Name		= {['protecterr']=0, "Shop_SkillBtn_All", "Shop_SkillBtn_Strike", "Shop_SkillBtn_Grab" 
											,"Shop_SkillBtn_Special", "Shop_SkillBtn_TeamDouble", "Shop_SkillBtn_Etc"}

tShopBtn_TexX		= {['protecterr']=0, 	4, 52, 100, 148, 196, 244}

for i = 1, #tShopBtn_Name do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tShopBtn_Name[i])
	mywindow:setTexture("Normal", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Hover", "UIData/my_room2.tga", tShopBtn_TexX[i], 330)
	mywindow:setTexture("Pushed", "UIData/my_room2.tga", tShopBtn_TexX[i], 354)
	mywindow:setTexture("SelectedNormal", "UIData/my_room2.tga", tShopBtn_TexX[i], 354)
	mywindow:setTexture("SelectedHover", "UIData/my_room2.tga", tShopBtn_TexX[i], 354)
	mywindow:setTexture("SelectedPushed", "UIData/my_room2.tga", tShopBtn_TexX[i], 354)	
	mywindow:setPosition(2 + 48 * (i - 1), 0)
	mywindow:setProperty("GroupID", 27)
	mywindow:setSize(48, 24)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:setUserString("CategoryIndex", tostring(i))
	mywindow:subscribeEvent("SelectStateChanged", "Shop_SubTabKindClick")
	if i == 1 then
		mywindow:setProperty("Selected", "true")
	end
	winMgr:getWindow("Shop_SkillButtonBack"):addChildWindow(mywindow)
end




--------------------------------------------------------------------
-- ��Ÿ������ ����ī�װ��� ��ư�� �� ����(��ü���� ��Ȱ�� �̹���)
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Shop_EtcButtonBack")
mywindow:setTexture("Enabled", "UIData/my_room.tga", 0, 337)
mywindow:setTexture("Disabled", "UIData/my_room.tga", 0, 337)
mywindow:setPosition(5, 4)
mywindow:setSize(477, 24)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("Shop_ItemMainImg"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- ��Ÿ������ ����ī�װ��� ��ư(��ü, egg, Up, ���ž�����, ����, �����̵�, ���, ��Ÿ)
--------------------------------------------------------------------
tShopBtn_Name		= {['protecterr']=0, "Shop_EtcBtn_All", "Shop_EtcBtn_Egg", "Shop_EtcBtn_Up", "Shop_EtcBtn_Transform"
											, "Shop_EtcBtn_PVP", "Shop_EtcBtn_Arcade", "Shop_EtcBtn_Deco", "Shop_EtcBtn_Etc"}

tShopBtn_TexX		= {['protecterr']=0, 	3, 62, 121, 180, 239, 298, 357, 416}

for i = 1, #tShopBtn_Name do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tShopBtn_Name[i])
	mywindow:setTexture("Normal", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Hover", "UIData/my_room.tga", tShopBtn_TexX[i], 361)
	mywindow:setTexture("Pushed", "UIData/my_room.tga", tShopBtn_TexX[i], 385)
	mywindow:setTexture("SelectedNormal", "UIData/my_room.tga", tShopBtn_TexX[i], 385)
	mywindow:setTexture("SelectedHover", "UIData/my_room.tga", tShopBtn_TexX[i], 385)
	mywindow:setTexture("SelectedPushed", "UIData/my_room.tga", tShopBtn_TexX[i], 385)	
	mywindow:setPosition(3 + 59 * (i - 1), 0)
	mywindow:setProperty("GroupID", 28)
	mywindow:setSize(59, 24)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:setUserString("CategoryIndex", tostring(i))
	mywindow:subscribeEvent("SelectStateChanged", "Shop_SubTabKindClick")
	if i == 1 then
		mywindow:setProperty("Selected", "true")
	end
	winMgr:getWindow("Shop_EtcButtonBack"):addChildWindow(mywindow)
end

--------------------------------------------------------------------
-- ��Ÿ������ ����ī�װ��� ��ư�� �� ����(��ü���� ��Ȱ�� �̹���)
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Shop_PetButtonBack")
mywindow:setTexture("Enabled", "UIData/my_room2.tga", 0, 664)
mywindow:setTexture("Disabled", "UIData/my_room2.tga", 0, 664)
mywindow:setPosition(5, 4)
mywindow:setSize(477, 24)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("Shop_PetMainImg"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- ��Ÿ������ ����ī�װ��� ��ư(��ü, egg, Up, ���ž�����, ����, �����̵�, ���, ��Ÿ)
--------------------------------------------------------------------
tShopBtn_Name		= {['protecterr']=0, "Shop_PetBtn_All", "Shop_PetBtn_Box", "Shop_PetBtn_Deco", "Shop_PetBtn_Etc" }

tShopBtn_TexX		= {['protecterr']=0,  2, 62, 122, 182}

for i = 1, #tShopBtn_Name do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tShopBtn_Name[i])
	mywindow:setTexture("Normal",			"UIData/invisible.tga",	0,					0)
	mywindow:setTexture("Hover",			"UIData/my_room2.tga",	tShopBtn_TexX[i], 690)
	mywindow:setTexture("Pushed",			"UIData/my_room2.tga",	tShopBtn_TexX[i], 714)
	mywindow:setTexture("SelectedNormal",	"UIData/my_room2.tga",	tShopBtn_TexX[i], 714)
	mywindow:setTexture("SelectedHover",	"UIData/my_room2.tga",	tShopBtn_TexX[i], 714)
	mywindow:setTexture("SelectedPushed",	"UIData/my_room2.tga",	tShopBtn_TexX[i], 714)
	mywindow:setPosition(3 + 60 * (i - 1), 2)
	mywindow:setProperty("GroupID", 15085)
	mywindow:setSize(60, 20)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:setUserString("CategoryIndex", tostring(i))
	mywindow:subscribeEvent("SelectStateChanged", "Shop_SubTabKindClick")
	if i == 1 then
		mywindow:setProperty("Selected", "true")
	end
	winMgr:getWindow("Shop_PetButtonBack"):addChildWindow(mywindow)
end


--------------------------------------------------------------------
-- �� ���� ĳ���� ȸ����ư
--------------------------------------------------------------------
tShopBtn_Name		= {['protecterr']=0, "Shop_CharacterLRotate", "Shop_CharacterRRotate" }
tShopBtn_TexX		= {['protecterr']=0, 	484,	535 }
tShopBtn_PosX		= {['protecterr']=0, 	10,		195 }
tShopBtn_Event	= {['protecterr']=0, "Shop_CharacterLRotateDownEvent", "Shop_CharacterRRotateDownEvent" }
tShopBtn_Event2	= {['protecterr']=0, "Shop_CharacterLRotateUpEvent", "Shop_CharacterRRotateUpEvent" }

for i = 1, #tShopBtn_Name do
	mywindow = winMgr:createWindow("TaharezLook/Button", tShopBtn_Name[i])
	mywindow:setTexture("Normal", "UIData/my_room2.tga", tShopBtn_TexX[i], 306)
	mywindow:setTexture("Hover", "UIData/my_room2.tga", tShopBtn_TexX[i], 353)
	mywindow:setTexture("Pushed", "UIData/my_room2.tga", tShopBtn_TexX[i], 400)
	mywindow:setTexture("PushedOff", "UIData/my_room2.tga", tShopBtn_TexX[i], 400)
	mywindow:setPosition(tShopBtn_PosX[i], 340)
	mywindow:setSize(51, 47)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:subscribeEvent("MouseButtonDown", tShopBtn_Event[i])
	mywindow:subscribeEvent("MouseButtonUp", tShopBtn_Event2[i])
	winMgr:getWindow("Shop_CharacterBackImg"):addChildWindow(mywindow)
end


-- �ǵ����� ��ư
mywindow = winMgr:createWindow("TaharezLook/Button", "Shop_RevertBtn")
mywindow:setTexture("Normal", "UIData/my_room2.tga", 638, 229)
mywindow:setTexture("Hover", "UIData/my_room2.tga", 638, 247)
mywindow:setTexture("Pushed", "UIData/my_room2.tga", 638, 265)
mywindow:setTexture("PushedOff", "UIData/my_room2.tga", 638, 265)
mywindow:setPosition(196, 413)
mywindow:setSize(55, 18)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:subscribeEvent("Clicked", "Shop_RevertBtnEvent")
winMgr:getWindow("Shop_CharacterBackImg"):addChildWindow(mywindow)

-- �ǵ����� ��ư �̺�Ʈ
function Shop_RevertBtnEvent()
	ToC_WearRevert()	
end

--------------------------------------------------------------------
-- �ڽ�Ƭ ����ī�װ��� ��ư(��ü, ���, ��, ����, �尩, ����, �Ź�, ����, ��Ʈ)
--------------------------------------------------------------------
tPackageBtn_Name		= {['protecterr']=0, "Shop_PackageBtn_All"}
tPackageBtn_TexX		= {['protecterr']=0, 0}

for i = 1, #tPackageBtn_Name do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tPackageBtn_Name[i])
	mywindow:setTexture("Normal", "UIData/my_room.tga", tPackageBtn_TexX[i], 409)
	mywindow:setPosition(5, 2)
	mywindow:setSize(476, 26)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	winMgr:getWindow("Shop_PackageMainImg"):addChildWindow(mywindow)
	
	-------------------------------------------------------------------------Text
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "Shop_PackageBtn_All_Test")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,198,0,255)
	mywindow:setFont(g_STRING_FONT_GULIM, 12)
	mywindow:setText(GetSStringInfo(LAN_MYSHOP_EVENT_NOTICE))
	mywindow:setPosition(10 + 48 * (i - 1), 2)
	mywindow:setSize(477, 26)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	winMgr:getWindow(tPackageBtn_Name[i]):addChildWindow(mywindow)	
	
end

--------------------------------------------------------------------
-- �� Empty�̹���(�������� �ִ°��� �ٸ� �̹���)-->���
--------------------------------------------------------------------
for i = 1, PAGE_MAXITEM do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Shop_EmptyOrItem"..i)
	mywindow:setTexture("Enabled", "UIData/my_room.tga", 817, 615)
	mywindow:setTexture("Disabled", "UIData/my_room.tga", 817, 615)
	mywindow:setPosition(5 + ((i - 1) % 4) * 120, 31 + ((i - 1) / 4) * 210)
	mywindow:setSize(116, 206)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(true)
if IsKoreanLanguage() then	
	winMgr:getWindow("Shop_CostumeMainImg"):addChildWindow(mywindow)
else
	winMgr:getWindow("Shop_PackageMainImg"):addChildWindow(mywindow)
end	
end


--------------------------------------------------------------------
-- �� ������ ������ư
--------------------------------------------------------------------
for i = 1, PAGE_MAXITEM do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", "Shop_Item"..i)
	mywindow:setTexture("Normal", "UIData/invisible.tga", 465, 615)
	mywindow:setTexture("Hover", "UIData/my_room.tga", 701, 615)
	mywindow:setTexture("Pushed", "UIData/my_room.tga", 584, 615)
	mywindow:setTexture("SelectedNormal", "UIData/my_room.tga", 584, 615)
	mywindow:setTexture("SelectedHover", "UIData/my_room.tga", 584, 615)
	mywindow:setTexture("SelectedPushed", "UIData/my_room.tga", 584, 615)
	mywindow:setPosition(5 + ((i - 1) % 4) * 120, 31 + ((i - 1) / 4) * 210)
	mywindow:setProperty("GroupID", 26)	--??
	mywindow:setSize(116, 206)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	
	mywindow:setUserString('ItemIndex',			tostring(0));		-- �����ִ� �������� �ε���
	mywindow:setUserString('ListIndex',			tostring(0));		-- ������ ����Ʈ�� ������ �ε���
	mywindow:setUserString('ItemNameFile',		"");				-- ������ ���� ���
	mywindow:setUserString('ItemNameFile2',		"");				-- ������ ���� ���
	
	mywindow:setUserString('RelationproductNo', tostring(0));		-- ���δ�Ʈ �ѹ�
	mywindow:setUserString('ItemNumber',		tostring(0));		-- ������ �ѹ�
	mywindow:setUserString('ItemName',			tostring(""));		-- ������ �̸�
	mywindow:setUserString('PricePoint',		tostring(0));		-- ������ ����
	mywindow:setUserString('Level',				tostring(0));		-- ������ ����
	mywindow:setUserString('attach',			tostring(0));		-- ������ ����
	mywindow:setUserString('strDesc',			tostring(""));		-- ������ ����
	mywindow:setUserString('boneType',			tostring(0));		-- ������ ��Ÿ��
	mywindow:setUserString('bWear',				tostring(0));		-- ������� ����������
	mywindow:setUserString('bSet',				tostring(0));		-- ��Ʈ����������
	mywindow:setUserString('ItemExpireTime',	tostring(""));		-- ������ ���ᳯ¥
	mywindow:setUserString('ExpiredCheck',		tostring(0));		-- ����üũ
	mywindow:setUserString('CostumeKind',		tostring(0));		-- �ڽ�Ƭ ����(ex. ����, ����)
	mywindow:setUserString('ItemKind',			tostring(0));		-- ������ ����
	mywindow:setUserString('TabKind',			tostring(0));		-- ������ ������(��ų, ������, �Һ�, ��ȭ)
	mywindow:setUserString('PayType',			tostring(0));					-- ���Ҽ���.
	mywindow:setUserString('Promotion',			tostring(0));				-- ��ų�� ���� ������� ���θ�� �ε���
	mywindow:setUserString('ItemStyle',			tostring(0));				-- ������ ��Ÿ��
	mywindow:setUserString('Possessed',			tostring(0));				-- ����������
	mywindow:setUserString('hot',				tostring(0));						-- �α��ǰ
	mywindow:setUserString('new',				tostring(0));						-- �Ż�
	mywindow:setUserString('forimagePromotion',	tostring(""));				-- ������ ����
	mywindow:setUserString('PropIndex',			tostring(0));				-- ������ �Ӽ� �ε���
	mywindow:setUserString('Condition',			tostring(0));				-- ������ �Ӽ� �ε���
	mywindow:setUserString('ItemState',			tostring(0));				-- ������ ����
	mywindow:setUserString('Pieces',			tostring(0));				-- ������ �ѹ��� ��� ������ ����
	mywindow:setUserString('ItemExperience',	tostring(0));				-- ������ �ѹ��� ��� ������ ����
	mywindow:setProperty("Selected", "false")
	mywindow:subscribeEvent("StartRender", "Shop_ItemRender")
	mywindow:subscribeEvent("SelectStateChanged", "Shop_CostumeSelectEvent")
	mywindow:subscribeEvent("MouseDoubleClicked", "Shop_ItemDoubleClickEvent");
	mywindow:setSubscribeEvent('MouseLeave', 'Shop_ItemMouseLeave');
	mywindow:setSubscribeEvent('MouseEnter', 'Shop_ItemMouseEnter');
if IsKoreanLanguage() then	
	winMgr:getWindow("Shop_CostumeMainImg"):addChildWindow(mywindow)
else
	winMgr:getWindow("Shop_PackageMainImg"):addChildWindow(mywindow)
end
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Shop_ItemDisable"..i)
	mywindow:setTexture("Enabled", "UIData/my_room2.tga", 846, 3)
	mywindow:setTexture("Disabled", "UIData/my_room2.tga", 846, 3)
	mywindow:setPosition(0, 0)
	mywindow:setSize(110, 206)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("Shop_Item"..i):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Shop_StateImage"..i)
	mywindow:setTexture("Enabled", "UIData/my_room.tga", 968, 815)
	mywindow:setTexture("Disabled", "UIData/my_room.tga", 968, 815)
	mywindow:setPosition(8, 48)
	mywindow:setSize(39, 17)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	mywindow:addController("stateMotion", "stateMotionEvent", "alpha", "Sine_EaseInOut", 255, 0, 8, true, true, 10)
	mywindow:addController("stateMotion", "stateMotionEvent", "alpha", "Sine_EaseInOut", 0, 255, 8, true, true, 10)
	winMgr:getWindow("Shop_Item"..i):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Shop_StateImage2"..i)
	mywindow:setTexture("Enabled", "UIData/my_room.tga", 968, 867)
	mywindow:setTexture("Disabled", "UIData/my_room.tga", 968, 867)
	mywindow:setPosition(8, 48)
	mywindow:setSize(39, 17)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	mywindow:addController("stateMotion", "stateMotionEvent2", "alpha", "Sine_EaseInOut", 0, 255, 8, true, true, 10)
	mywindow:addController("stateMotion", "stateMotionEvent2", "alpha", "Sine_EaseInOut", 255, 0, 8, true, true, 10)
	winMgr:getWindow("Shop_Item"..i):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Shop_SoldOutImage"..i)
	mywindow:setTexture("Enabled", "UIData/my_room.tga", 616, 486)
	mywindow:setTexture("Disabled", "UIData/my_room.tga", 616, 486)
	mywindow:setPosition(5, 52)
	mywindow:setSize(108, 87)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("Shop_Item"..i):addChildWindow(mywindow)
	
	-- ���� ������ ����
	mywindow = winMgr:createWindow("TaharezLook/Button", "Shop_DetailIInfoBtn"..i)
	mywindow:setTexture("Normal", "UIData/reward_item.tga", 0, 173)
	mywindow:setTexture("Hover", "UIData/reward_item.tga", 0, 193)
	mywindow:setTexture("Pushed", "UIData/reward_item.tga", 0, 213)
	mywindow:setTexture("PushedOff", "UIData/reward_item.tga", 0, 233)
	mywindow:setPosition(87, 120)
	mywindow:setSize(20, 20)
	mywindow:setVisible(false)
	mywindow:setSubscribeEvent("Clicked", "Shop_ShowRandomOpenItem")
	winMgr:getWindow("Shop_Item"..i):addChildWindow(mywindow)
	
	
	-- �����ϱ�
	mywindow = winMgr:createWindow("TaharezLook/Button", "Shop_PresentBtn"..i)
	mywindow:setTexture("Normal", "UIData/my_room.tga", 323, 780)
	mywindow:setTexture("Hover", "UIData/my_room.tga", 323, 798)
	mywindow:setTexture("Pushed", "UIData/my_room.tga", 323, 816)
	mywindow:setTexture("Disabled", "UIData/my_room.tga", 323, 834)
	mywindow:setTexture("Enabled", "UIData/my_room.tga", 323, 834)
	mywindow:setPosition(3, 185)
	mywindow:setSize(55, 18)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", "Shop_PresentBtnEvent")
	winMgr:getWindow("Shop_Item"..i):addChildWindow(mywindow)
	
	-- �����ϱ�
	mywindow = winMgr:createWindow("TaharezLook/Button", "Shop_PurchaseBtn"..i)
	mywindow:setTexture("Normal", "UIData/my_room2.tga", 638, 373)
	mywindow:setTexture("Hover", "UIData/my_room2.tga", 638, 391)
	mywindow:setTexture("Pushed", "UIData/my_room2.tga", 638, 409)
	mywindow:setTexture("Disabled", "UIData/my_room2.tga", 638, 427)
	mywindow:setPosition(58, 185)
	mywindow:setSize(55, 18)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:subscribeEvent("Clicked", "Shop_PurchaseBtnEvent")
	winMgr:getWindow("Shop_Item"..i):addChildWindow(mywindow)
	
end


--------------------------------------------------------------------
-- �������� �ڽ�Ƭ(�̹������� ����)->��Ҹ� �ϰԵŸ� ����� �̻��ϰԵż� �̷�������..
--------------------------------------------------------------------
for i = 1, MAX_COSTUM do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "WearItemImage"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 125, 956)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 125, 956)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(264 + ((i - 1) % 5) * 43, 425 + ((i - 1) / 5) * 43)
	mywindow:setSize(110, 110)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("EndRender", "WearItemImageRender")
	winMgr:getWindow("Shop_CharacterBackImg"):addChildWindow(mywindow)
end

--------------------------------------------------------------------
-- ������ ǥ�����ֱ�����
--------------------------------------------------------------------
for i = 1, MAX_COSTUM do
	mywindow = winMgr:createWindow("TaharezLook/Button", "WearItemButton"..i)
	mywindow:setTexture("Normal", "UIData/my_room.tga", 125, 956)
	mywindow:setTexture("Hover", "UIData/my_room.tga", 125, 956)
	mywindow:setTexture("Pushed", "UIData/my_room.tga", 125, 956)
	mywindow:setTexture("PushedOff", "UIData/my_room.tga", 125, 956)
	mywindow:setPosition(0, 0)
	mywindow:setSize(42, 41)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	winMgr:getWindow("WearItemImage"..i):addChildWindow(mywindow)
end


--------------------------------------------------------------------
-- �׶�, ����, ĳ��
--------------------------------------------------------------------
local tMyMoneyName	= {['protecterr']=0, "Shop_HaveGranText", "Shop_HaveCoinText", "Shop_HaveCashText"}
local tMyMoneyPosX	= {['protecterr']=0, 560, 718, 877}

for i = 1, #tMyMoneyName do
	mywindow = winMgr:createWindow("TaharezLook/StaticText", tMyMoneyName[i])
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(tMyMoneyPosX[i], 600)
	mywindow:setSize(120, 13)
	mywindow:setZOrderingEnabled(true)	
	mywindow:setViewTextMode(1)
	mywindow:setAlign(8)
	mywindow:setLineSpacing(2)
	root:addChildWindow(mywindow)

end



--------------------------------------------------------------------
-- ����ٿ� �ڽ� ���̽�
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ShopDropDownBase")
mywindow:setTexture("Enabled", "UIData/my_room2.tga", 693, 328)
mywindow:setTexture("Disabled", "UIData/my_room2.tga", 693, 328)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(882, 27)
mywindow:setSize(126, 28)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
--mywindow:subscribeEvent("MouseClick", "DropDownEvent")
Shop_Mainwindow:addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/StaticText", "ShopDropDownBaseText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setPosition(2, 6)
mywindow:setSize(102, 16)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)	
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
winMgr:getWindow("ShopDropDownBase"):addChildWindow(mywindow)

-- �̺�Ʈ�� ��ư
mywindow = winMgr:createWindow("TaharezLook/Button", "ShopDropDownBtn1")
mywindow:setTexture("Normal", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Hover", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Pushed", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("PushedOff", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(0, 0)
mywindow:setSize(103, 28)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:subscribeEvent("Clicked", "DropDownBtnEvent")
winMgr:getWindow("ShopDropDownBase"):addChildWindow(mywindow)

-- ����ٿ� ��ư
mywindow = winMgr:createWindow("TaharezLook/Button", "ShopDropDownBtn")
mywindow:setTexture("Normal", "UIData/my_room2.tga", 819, 328)
mywindow:setTexture("Hover", "UIData/my_room2.tga", 819, 343)
mywindow:setTexture("Pushed", "UIData/my_room2.tga", 819, 358)
mywindow:setTexture("PushedOff", "UIData/my_room2.tga", 819, 358)
mywindow:setPosition(103, 7)
mywindow:setSize(17, 15)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:subscribeEvent("Clicked", "DropDownBtnEvent")
winMgr:getWindow("ShopDropDownBase"):addChildWindow(mywindow)


-- ĳ���� ��Ÿ��
local tDropDownCostumList	= {['protecterr']=0, Shop_String_1, Shop_String_2, Shop_String_3, Shop_String_4, Shop_String_5, Shop_String_6 }
-- ������ ����ٿ����̺��� ����ִ� ��¥ �ε���(c���� ����ϴ� �ε���)
local tCostumListRealIndex	= {['protecterr']=0, 0, 1, 2, 3, 4, 5 }


-- ��ų ����(Shop_String_10, Shop_String_16)ī������ �ﺸ�� ?
local tDropDownSkillList	= {['protecterr']=0, Shop_String_17, Shop_String_7, Shop_String_8, Shop_String_9, Shop_String_11, Shop_String_10
												, Shop_String_18, Shop_String_12, Shop_String_13, Shop_String_14, Shop_String_15, Shop_String_16, Shop_String_23, Shop_String_22, PreCreateString_3462, "Kungfu", PreCreateString_4920, "SYSTEMA"}
-- ��ų ����ٿ����̺��� ����ִ� ��¥ �ε���(��Ÿ�ϰ� ���θ���� ������ �� �ִ� �ε�����.)
local tSkillListRealIndex	= {['protecterr']=0, -1, 0, 1, 2, 4, 3, -1, 10, 11, 12, 13, 14, -1, 5, 6, 17, 18, 19}
-- ��ų ���θ�� ī�װ����� Ŭ���� �ȵŴ� �κ�/ �������� �ϴ� �κ� ���̺�
local tDropDownSkillListShowType = {['protecterr']=0, NoClick, Normal, Normal, Normal, Normal, Normal, NoClick, Normal, Normal, Normal, Normal, Normal, NoClick, Normal, Normal, Normal, Normal, Normal}
local tDropDownSkillListFacility = {['protecterr']=0, 0, 0, FACILITYCODE_CC_TAEKWONDO, FACILITYCODE_CC_BOXING, FACILITYCODE_CC_MUAYTHAI, FACILITYCODE_CC_CAPOEIRA
													, 0, 0, FACILITYCODE_CC_JUDO, FACILITYCODE_CC_PROWRESTLING, FACILITYCODE_CC_HAPKIDO, FACILITYCODE_CC_SAMBO
													, 0, FACILITYCODE_CC_DIRTYX, FACILITYCODE_CC_SUMO, FACILITYCODE_CC_KUNGFU, FACILITYCODE_CC_NINJA, FACILITYCODE_CC_NINJA}
-- �ȵ��� �������� �����.
for i=1, #tDropDownSkillListFacility do
	if tDropDownSkillListFacility[i] ~= 0 then
		if CheckfacilityData(tDropDownSkillListFacility[i]) == 0 then
			tDropDownSkillListShowType[i] = Hiden
		end
	end
end


-- ������ ����ٿ� ����Ʈ
local tDropDownItemList		= {['protecterr']=0, }
local tItemListRealIndex	= {['protecterr']=0, }


local tDropDownListTable	= {['protecterr']=0, }
tDropDownListTable[1]	= tDropDownCostumList
tDropDownListTable[2]	= tDropDownSkillList
tDropDownListTable[3]	= tDropDownItemList
tDropDownListTable[4]	= tDropDownItemList
tDropDownListTable[5]	= tDropDownItemList


local tRealIndexTable	= {['protecterr']=0, }
tRealIndexTable[1]		= tCostumListRealIndex
tRealIndexTable[2]		= tSkillListRealIndex
tRealIndexTable[3]		= tItemListRealIndex
tRealIndexTable[4]		= tItemListRealIndex
tRealIndexTable[5]		= tItemListRealIndex

-- �ڽ�ƬŸ�� ����ٿ� �����̳�
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "DropDownContainer")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(882, 55)
mywindow:setSize(126, 28 * SKILL_TYPE_COUNT)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
Shop_Mainwindow:addChildWindow(mywindow)

for i = 1, SKILL_TYPE_COUNT do
	mywindow = winMgr:createWindow("TaharezLook/Button", "DropDownList"..i)
	mywindow:setTexture("Normal", "UIData/my_room2.tga", 693, 356)
	mywindow:setTexture("Hover", "UIData/my_room2.tga", 693, 412)
	mywindow:setTexture("Pushed", "UIData/my_room2.tga", 693, 412)
	mywindow:setTexture("PushedOff", "UIData/my_room2.tga", 693, 412)
	mywindow:setPosition(0, (i - 1) * 28)
	mywindow:setSize(126, 28)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:subscribeEvent("Clicked", "DropDownList_ClickEvent")
	winMgr:getWindow("DropDownContainer"):addChildWindow(mywindow)
	
	
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "DropDownListText"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(0, 6)
	mywindow:setSize(126, 16)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)	
	mywindow:setViewTextMode(1)
	mywindow:setAlign(8)
	mywindow:setLineSpacing(2)
	winMgr:getWindow("DropDownList"..i):addChildWindow(mywindow)
end
											



-- ����ٿ� ����Ʈ ����
function DropDownListSetting(TabIndex)
	
	winMgr:getWindow("DropDownContainer"):setVisible(false)
	
	for i = 1, SKILL_TYPE_COUNT do
		winMgr:getWindow("DropDownList"..i):setVisible(false)
		winMgr:getWindow("DropDownList"..i):setEnabled(true)
	end
	
	if TabIndex == COSTUME_TAB then		-- ��������
		winMgr:getWindow("ShopDropDownBase"):setVisible(true)
		winMgr:getWindow("DropDownContainer"):setSize(126, 28 * COSTUM_TYPE_COUNT)

		for i = 1, COSTUM_TYPE_COUNT do
			if i == COSTUM_TYPE_COUNT then
				winMgr:getWindow("DropDownList"..i):setTexture("Normal", "UIData/my_room2.tga", 693, 384)
			else
				winMgr:getWindow("DropDownList"..i):setTexture("Normal", "UIData/my_room2.tga", 693, 356)
			end
			winMgr:getWindow("DropDownList"..i):setPosition(0, (i - 1) * 28)		
			winMgr:getWindow("DropDownList"..i):setVisible(true)
			
			winMgr:getWindow("DropDownListText"..i):clearTextExtends()
			winMgr:getWindow("DropDownListText"..i):addTextExtends(tDropDownCostumList[i], g_STRING_FONT_GULIM, 14, 255, 255, 255, 255,  0, 255,255,255,255)
		end

	elseif TabIndex == SKILL_TAB then	-- ��ų��
		winMgr:getWindow("ShopDropDownBase"):setVisible(true)
		winMgr:getWindow("DropDownContainer"):setSize(126, 28 * SKILL_TYPE_COUNT)
		for i = 1, SKILL_TYPE_COUNT do
			if i == SKILL_TYPE_COUNT then
				winMgr:getWindow("DropDownList"..i):setTexture("Normal", "UIData/my_room2.tga", 693, 384)
			else
				winMgr:getWindow("DropDownList"..i):setTexture("Normal", "UIData/my_room2.tga", 693, 356)
			end
			winMgr:getWindow("DropDownList"..i):setPosition(0, (i - 1) * 28)
			winMgr:getWindow("DropDownList"..i):setVisible(true)
			
			local tColor	= {['protecterr'] = 0, 255, 255, 255}
			if i / 7 == 1 then
				tColor[1] = 255
				tColor[2] = 0
				tColor[3] = 0
			elseif i / 7 == 2 then
				tColor[1] = 222
				tColor[2] = 129
				tColor[3] = 211
			else
				tColor[1] = 7
				tColor[2] = 232
				tColor[3] = 232
			end
			
			local String	= tDropDownSkillList[i]
			if tDropDownSkillListShowType[i] == NoClick then
				winMgr:getWindow("DropDownList"..i):setTexture("Normal", "UIData/my_room2.tga", 693, 412)
				winMgr:getWindow("DropDownList"..i):setEnabled(false)
				tColor[1] = 255
				tColor[2] = 198
				tColor[3] = 30
			elseif tDropDownSkillListShowType[i] == Hiden then
				winMgr:getWindow("DropDownList"..i):setEnabled(false)
				tColor[1] = 125
				tColor[2] = 125
				tColor[3] = 125
				String = "New Job"
			end
			winMgr:getWindow("DropDownListText"..i):clearTextExtends()
			winMgr:getWindow("DropDownListText"..i):addTextExtends(String, g_STRING_FONT_GULIM, 14, tColor[1], tColor[2], tColor[3], 255,  0, tColor[1], tColor[2], tColor[3],255)			
		end
	else 
		winMgr:getWindow("ShopDropDownBase"):setVisible(false)
	end

	
end


-- ����ٿ� ��ư�� ���� �ؽ�Ʈ
function SetDropDownBaseText(TabIndex, Index)

	DebugStr(Index)
	local	String	= ""
	local tColor	= {['protecterr'] = 0, 7, 232, 232}
	for i = 1, #tRealIndexTable[TabIndex] do
		if tRealIndexTable[TabIndex][i] == Index then
			
			String = tDropDownListTable[TabIndex][i]
			if TabIndex == SKILL_TAB then
				if i / 7 == 1 then
					tColor[1] = 255
					tColor[2] = 0
					tColor[3] = 0
				elseif i / 7 == 2 then
					tColor[1] = 222
					tColor[2] = 129
					tColor[3] = 211
				else
					tColor[1] = 7
					tColor[2] = 232
					tColor[3] = 232
				end
			end
		end
	end	
	winMgr:getWindow("ShopDropDownBaseText"):clearTextExtends()
	winMgr:getWindow("ShopDropDownBaseText"):addTextExtends(String, g_STRING_FONT_GULIM, 14, tColor[1], tColor[2], tColor[3], 255,  2, 255, 255, 255,255)
end


function DropDownEvent()
	DropDownBtnEvent()
end


-- ����ٿ� ��ư �̺�Ʈ
function DropDownBtnEvent(args)
	if winMgr:getWindow("DropDownContainer"):isVisible() then
		winMgr:getWindow("DropDownContainer"):setVisible(false)
	else
		winMgr:getWindow("DropDownContainer"):setVisible(true)
	end
end


-- ����ٿ� ����Ʈ Ŭ�� �̺�Ʈ
function DropDownList_ClickEvent(args)
	winMgr:getWindow("DropDownContainer"):setVisible(false)
	local EventWindow	= CEGUI.toWindowEventArgs(args).window
	local WinName		= EventWindow:getName()

	for i = 1, SKILL_TYPE_COUNT do
		if "DropDownList"..i == WinName then
			Toc_SelectedDropDownCategory(tRealIndexTable[CurrentSelectTab + 1][i])
			if CurrentSelectTab < 3 then
				winMgr:getWindow(tSubFirstIcon_Name[CurrentSelectTab + 1]):setProperty("Selected", "true")		-- ù��° �������� �������ش�
			end
			
			-- ������ �����.
			if CurrentSelectTab == 1 then
				ToC_HidePreviewSkill()
				bSelectStat	= false
			end
			return
		end
	end
	

end


--------------------------------------------------------------------
-- �������� �ڽ�Ƭ �׷��ش�.
--------------------------------------------------------------------
function WearItemImageRender(args)
	local	local_window	= CEGUI.toWindowEventArgs(args).window
	local	_drawer			= local_window:getDrawer()
	local	FileName		= local_window:getUserString("FileName")
		
	_drawer:drawTextureSA("UIData/ItemUIData/"..FileName,			-- ���� �̸�
								 1, 1, 102, 102,	-- ��ġ, ����
								 0, 0,				-- �ؽ�ó ��ǥ
								 100, 100,			-- ������ XY
								 255, 0, 0);		-- ����, ����, ����
end


--------------------------------------------------------------------
-- �� �׶�, ����, ĳ���� �ҷ��´�.
--------------------------------------------------------------------
function MyPropertyList(Gran, Coin, Cash)
	local r, g, b	= GetGranColor(Gran)
	DebugStr(Gran)
	DebugStr(CommatoMoneyStr64(Gran))
	winMgr:getWindow("Shop_HaveGranText"):setTextExtends(CommatoMoneyStr64(Gran), g_STRING_FONT_GULIMCHE,12, r, g, b,255,  0,  0,0,0,255);
	r, g, b	= ColorToMoney(Coin)
	winMgr:getWindow("Shop_HaveCoinText"):setTextExtends(CommatoMoneyStr(Coin), g_STRING_FONT_GULIMCHE,12, r, g, b,255,  0,  0,0,0,255);
	r, g, b	= ColorToMoney(Cash)
	winMgr:getWindow("Shop_HaveCashText"):setTextExtends(CommatoMoneyStr(Cash), g_STRING_FONT_GULIMCHE,12, r, g, b,255,  0,  0,0,0,255);

	SetMyCharacterInfoZenQuest(Gran)
end

--------------------------------------------------------------------
-- �ɸ��̸�, �������, ����, ��ü����ġ, Ŭ����, Ŭ��, Īȣ 
--------------------------------------------------------------------
function Shop_MyBaseInfo(Name, Ladder, Level, Exp, Promotion, club, Title)
	
	
	
	

	local ExptoLevel	= GetExptoLevel(level);

end




--------------------------------------------------------------------

-- ������ ����ϴ� �Լ�

--------------------------------------------------------------------
--------------------------------------------------------------------
-- �� ����
--------------------------------------------------------------------
function InitShop(TypeIndex)
	if IsKoreanLanguage() then
		ToC_SelectedItemCategory(0)	
		ToC_SelectedSubCategory(0)
		KindTabEvent(COSTUME_TAB)
		DropDownListSetting(COSTUME_TAB)
		SetDropDownBaseText(COSTUME_TAB, TypeIndex)
		TitleTextEvent(COSTUME_TAB)
		winMgr:getWindow('BPM_MoveShopButton'):setEnabled(false)
	else
		KindTabEvent(PACKAGE_TAB)
		ToC_SelectedSubCategory(0)
		DropDownListSetting(PACKAGE_TAB)
		SetDropDownBaseText(PACKAGE_TAB, TypeIndex)
		TitleTextEvent(PACKAGE_TAB)
		winMgr:getWindow('BPM_MoveShopButton'):setEnabled(false)
	end	
end


--------------------------------------------------------------------
-- ���̸� ��������
--------------------------------------------------------------------
function Shop_Refresh(itemKind)
	-- Empty�̹��� ����
	for i = 1, PAGE_MAXITEM do
		local ItemWindow = "Shop_EmptyOrItem"..tostring(i)
		winMgr:getWindow(ItemWindow):setTexture("Enabled", "UIData/my_room.tga", 817, 615)
		winMgr:getWindow(ItemWindow):setTexture("Disabled", "UIData/my_room.tga", 817, 615)
		
		ItemWindow = "Shop_Item"..tostring(i)
		winMgr:getWindow(ItemWindow):setVisible(false)
		winMgr:getWindow(ItemWindow):setProperty("Selected", "false")
		
		
		-- �߰� 
		winMgr:getWindow("Shop_PresentBtn"..i):setEnabled(true)
		
	end
	
	for i = 1, MAX_COSTUM do
		winMgr:getWindow("WearItemImage"..i):setVisible(false)		-- �������� �ڽ�Ƭ
	end
end


local ButtonTexData					= {['protecterr']=0, }
ButtonTexData.tItemButtonInfo		= {['protecterr']=0, "UIData/my_room.tga",	701,	584,	615}
ButtonTexData.tSkillButtonInfo		= {['protecterr']=0, "UIData/my_room2.tga", 724,	602,	3}
ButtonTexData.tDisableButtonInfo	= {['protecterr']=0, "UIData/my_room2.tga", 846,	846,	3}


--------------------------------------------------------------------
-- ������ ���� ����, �����ۿ����� �ʱ�ȭ����
--------------------------------------------------------------------
function WndShop_DrawItemTexture(ItemIndex, RelationproductNo, ItemNumber, PricePoint, PayType, Level, attach, boneType, Promotion, ItemStyle, 
								possessed, hot, new, kind, ItemName, ItemFileName, ItemFileName2, Desc, forimagePromotion, PropIndex, Condition, ItemState, Pieces, ItemExperience)
								--Level, attach, strDesc, boneType, bWear, bSet, ItemExpireTime, ExpiredCheck, nCostumeKind, ItemKind, TabKind, Promotion)
	-- �������� �ֱ⋚���� Empty�̹��� �ٲ��ش�.
	local ItemWindow = "Shop_EmptyOrItem"..tostring(ItemIndex);
	local ItemRadioWindow = "Shop_Item"..tostring(ItemIndex);
	local MyButtonData	= {['protecterr']=0, }
	winMgr:getWindow("Shop_ItemDisable"..ItemIndex):setVisible(false)
	
	if kind == 1 then	-- ��ų
		winMgr:getWindow(ItemWindow):setTexture("Enabled", "UIData/my_room2.tga", 480, 3)
		winMgr:getWindow(ItemWindow):setTexture("Disabled", "UIData/my_room2.tga", 477, 0)
		MyButtonData = ButtonTexData.tSkillButtonInfo
	else					-- ������(�ڽ�Ƭ, ������)
		winMgr:getWindow(ItemWindow):setTexture("Enabled", "UIData/my_room.tga", 465, 615)
		winMgr:getWindow(ItemWindow):setTexture("Disabled", "UIData/my_room.tga", 465, 615)
		MyButtonData = ButtonTexData.tItemButtonInfo
	end
	winMgr:getWindow(ItemRadioWindow):setTexture("Normal", "UIData/invisible.tga", 465, 615)
	-- ����Ұ��� ������
	local DisabledImg	= false
	local _my_name, _money, _level, _promotion, _my_style, _type, _sp_point, _hp_point, _experience = GetMyInfo(false);
	
--	if CurrentSelectTab == 1 then
--		if forimagePromotion ~= _my_style then
--			if (_my_style % 2) ~= forimagePromotion then
--				DisabledImg = true
--			end
--		end		
--	end

	
	
	-- �Ⱓ ����� ������
	if DisabledImg == true then
		winMgr:getWindow("Shop_ItemDisable"..ItemIndex):setVisible(true)
	end
	
	-- ������ư������ �ؽ��ļ���
	winMgr:getWindow(ItemRadioWindow):setTexture("Hover", MyButtonData[1], MyButtonData[2], MyButtonData[4])
	winMgr:getWindow(ItemRadioWindow):setTexture("Pushed", MyButtonData[1], MyButtonData[3], MyButtonData[4])
	winMgr:getWindow(ItemRadioWindow):setTexture("SelectedNormal", MyButtonData[1], MyButtonData[3], MyButtonData[4])
	winMgr:getWindow(ItemRadioWindow):setTexture("SelectedHover", MyButtonData[1], MyButtonData[3], MyButtonData[4])
	winMgr:getWindow(ItemRadioWindow):setTexture("SelectedPushed", MyButtonData[1], MyButtonData[3], MyButtonData[4])
		
	-- ������ư Ȱ��ȭ
	ItemWindow = "Shop_Item"..tostring(ItemIndex)
	winMgr:getWindow(ItemWindow):setVisible(true)
	-- ������ư�ȿ� ������ ����
	local	Buttonwin		= winMgr:getWindow(ItemWindow);
	Buttonwin:setUserString('ItemIndex',		tostring(ItemIndex));				-- �����ִ� �������� �ε���
	Buttonwin:setUserString('RelationproductNo', tostring(RelationproductNo));		-- ���δ�Ʈ �ѹ�
	Buttonwin:setUserString('ItemNumber',		tostring(ItemNumber));				-- ������ �ѹ�
	Buttonwin:setUserString('PricePoint',		tostring(PricePoint));				-- ������ ����
	Buttonwin:setUserString('PayType',			tostring(PayType));					-- ���Ҽ���.
	Buttonwin:setUserString('Level',			tostring(Level));					-- ������ ����
	Buttonwin:setUserString('attach',			tostring(attach));					-- ������ ����
	Buttonwin:setUserString('boneType',			tostring(boneType));				-- ������ ��Ÿ��
	Buttonwin:setUserString('Promotion',		tostring(Promotion));				-- ��ų�� ���� ������� ���θ�� �ε���
	Buttonwin:setUserString('ItemStyle',		tostring(ItemStyle));				-- ������ ��Ÿ��
	Buttonwin:setUserString('Possessed',		tostring(possessed));				-- ����������
	Buttonwin:setUserString('hot',				tostring(hot));						-- �α��ǰ
	Buttonwin:setUserString('new',				tostring(new));						-- �Ż�
	Buttonwin:setUserString('ItemKind',			tostring(kind));					-- ������ ����
	Buttonwin:setUserString('ItemName',			tostring(ItemName));				-- ������ �̸�
	Buttonwin:setUserString('ItemNameFile',		tostring(ItemFileName));			-- ������ ���� �̸�
	Buttonwin:setUserString('ItemNameFile2',	tostring(ItemFileName2));			-- ������ ���� �̸�
	
	Buttonwin:setUserString('strDesc',			tostring(Desc));					-- ������ ����
	Buttonwin:setUserString('forimagePromotion',tostring(forimagePromotion));		-- ������ ����
	Buttonwin:setUserString('PropIndex',		tostring(PropIndex));				-- ������ �Ӽ� �ε���
	Buttonwin:setUserString('Condition',		tostring(Condition));				-- ���� ����
	Buttonwin:setUserString('ItemState',		tostring(ItemState));				-- ������ ����
	Buttonwin:setUserString('Pieces',			tostring(Pieces));					-- ������ �ѹ��� ��� ������ ����
	Buttonwin:setUserString('ItemExperience',	tostring(ItemExperience))

	--winMgr:getWindow("Shop_PresentBtn"..ItemIndex):setEnabled(false)
				
	-- ĳ�ø� �����ϱ�
--	if PayType	== TYPE_GRAN then
--		winMgr:getWindow("Shop_PresentBtn"..ItemIndex):setEnabled(false)
--	elseif PayType	== TYPE_CASH then
--		winMgr:getWindow("Shop_PresentBtn"..ItemIndex):setEnabled(true)
--	end
		
	if IsKoreanLanguage() then	
		if boneType ~= _type and kind == ITEMKIND_COSTUM then
			winMgr:getWindow("Shop_PurchaseBtn"..ItemIndex):setEnabled(false)
			winMgr:getWindow("Shop_ItemDisable"..ItemIndex):setVisible(true)
		else
			winMgr:getWindow("Shop_PurchaseBtn"..ItemIndex):setEnabled(true)
			winMgr:getWindow("Shop_ItemDisable"..ItemIndex):setVisible(false)
		end
		--winMgr:getWindow("Shop_PresentBtn"..ItemIndex):setEnabled(false)
	else
		-- �����̾���Ű���� ������ ���Ѵ�
		if kind == ITEMKIND_PREMIUM_PACKAGE then
			winMgr:getWindow("Shop_PresentBtn"..ItemIndex):setEnabled(false)
		else
			if ItemNumber == 11010301 or ItemNumber == 11010401 or ItemNumber == 11010501
				or ItemNumber == 11010601 or ItemNumber == 11010611 then
				winMgr:getWindow("Shop_PresentBtn"..ItemIndex):setEnabled(false)
			else	
				winMgr:getWindow("Shop_PresentBtn"..ItemIndex):setEnabled(true)
			end
		end
	end
	
	if PricePoint <= 0 then
		winMgr:getWindow("Shop_PresentBtn"..ItemIndex):setEnabled(false)
	end
	
	bItemInfoReceive	= true		-- ������������ �޾ƿԴ��� Ȯ��
	
	winMgr:getWindow("Shop_StateImage"..ItemIndex):setVisible(false)
	winMgr:getWindow("Shop_StateImage"..ItemIndex):clearActiveController()
	
	winMgr:getWindow("Shop_StateImage2"..ItemIndex):setVisible(false)
	winMgr:getWindow("Shop_StateImage2"..ItemIndex):clearActiveController()

	winMgr:getWindow("Shop_SoldOutImage"..ItemIndex):setVisible(false)

	if ToC_GetPurchaseState(RelationproductNo, PRODUCT_NEW) then
		winMgr:getWindow("Shop_StateImage"..ItemIndex):setTexture("Enabled", "UIData/my_room.tga", 968, 815)
		winMgr:getWindow("Shop_StateImage"..ItemIndex):setTexture("Disabled", "UIData/my_room.tga", 968, 815)
		winMgr:getWindow("Shop_StateImage"..ItemIndex):setVisible(true)
		winMgr:getWindow("Shop_StateImage"..ItemIndex):activeMotion("stateMotionEvent")
		
		winMgr:getWindow("Shop_StateImage2"..ItemIndex):setTexture("Enabled", "UIData/my_room.tga", 968, 867)
		winMgr:getWindow("Shop_StateImage2"..ItemIndex):setTexture("Disabled", "UIData/my_room.tga", 968, 867)
		winMgr:getWindow("Shop_StateImage2"..ItemIndex):setVisible(true)
		winMgr:getWindow("Shop_StateImage2"..ItemIndex):activeMotion("stateMotionEvent2")
		
	elseif ToC_GetPurchaseState(RelationproductNo, PRODUCT_HOT) then
		winMgr:getWindow("Shop_StateImage"..ItemIndex):setTexture("Enabled", "UIData/my_room.tga", 968, 832)
		winMgr:getWindow("Shop_StateImage"..ItemIndex):setTexture("Disabled", "UIData/my_room.tga", 968, 832)
		winMgr:getWindow("Shop_StateImage"..ItemIndex):setVisible(true)
		winMgr:getWindow("Shop_StateImage"..ItemIndex):activeMotion("stateMotionEvent")
		
		winMgr:getWindow("Shop_StateImage2"..ItemIndex):setTexture("Enabled", "UIData/my_room.tga", 968, 884)
		winMgr:getWindow("Shop_StateImage2"..ItemIndex):setTexture("Disabled", "UIData/my_room.tga", 968, 884)
		winMgr:getWindow("Shop_StateImage2"..ItemIndex):setVisible(true)
		winMgr:getWindow("Shop_StateImage2"..ItemIndex):activeMotion("stateMotionEvent2")
	elseif ToC_GetPurchaseState(RelationproductNo, PRODUCT_EVENT) then
		winMgr:getWindow("Shop_StateImage"..ItemIndex):setTexture("Enabled", "UIData/my_room.tga", 985, 950)
		winMgr:getWindow("Shop_StateImage"..ItemIndex):setTexture("Disabled", "UIData/my_room.tga", 985, 950)
		winMgr:getWindow("Shop_StateImage"..ItemIndex):setVisible(true)
		winMgr:getWindow("Shop_StateImage"..ItemIndex):activeMotion("stateMotionEvent")
		
		winMgr:getWindow("Shop_StateImage2"..ItemIndex):setTexture("Enabled", "UIData/my_room.tga", 985, 967)
		winMgr:getWindow("Shop_StateImage2"..ItemIndex):setTexture("Disabled", "UIData/my_room.tga", 985, 967)
		winMgr:getWindow("Shop_StateImage2"..ItemIndex):setVisible(true)
		winMgr:getWindow("Shop_StateImage2"..ItemIndex):activeMotion("stateMotionEvent2")	
	end
	
	if CheckDetailInfoBtn(ItemNumber) then
		winMgr:getWindow("Shop_DetailIInfoBtn"..ItemIndex):setVisible(true)
	else
		winMgr:getWindow("Shop_DetailIInfoBtn"..ItemIndex):setVisible(false)
	end
		
	
	if ToC_GetPurchaseState(RelationproductNo, PRODUCT_SOLD_OUT) then	-- ǰ��
		winMgr:getWindow("Shop_SoldOutImage"..ItemIndex):setVisible(true)
	end
end

--[[
--------------------------------------------------------------------
-- ��ųƮ�� refresh
--------------------------------------------------------------------
function SkillTreeRefresh(bwear, itemnumber)
	
	local SkillCount	= 0
	
	for i = 1, #tAllSkillTree do
		for j = 1, #tAllSkillTree[i] do
			for k = 1, tSkillCountTable[i][j] do
				local Skill_ItemNumber	= tonumber(winMgr:getWindow("SkillIcon"..i..j..k):getUserString("SkillItemNum"))
				local bCkeck	= ToC_SkillKindConfirm(Skill_ItemNumber % 100, itemnumber)		-- ������ ������ ��ų���� �˾ƿ´�.
				
				if bCkeck then
					if bwear == 1 then
						winMgr:getWindow("SkillIcon"..i..j..k):setUserString("SkillItemNum", tostring(itemnumber))
					else
						winMgr:getWindow("SkillIcon"..i..j..k):setUserString("SkillItemNum", tostring(tBaseSkillTable[SkillCount]))
					end					
					return
				end
				SkillCount = SkillCount + 1
			end
		end
	end
	
end
--]]

--------------------------------------------------------------------
-- �������� �ڽ�Ƭ����� �˾ƿ´�
--------------------------------------------------------------------
function GetWearCostumIndexList(index, level, Desc, FileName, ItemName)
	local MyWindow	= winMgr:getWindow("WearItemImage"..tWearCostumIndex[index])
	
	MyWindow:setUserString('level',		tostring(level));
	MyWindow:setUserString('strDesc',		tostring(Desc));
	MyWindow:setUserString('FileName',	tostring(FileName));
	MyWindow:setUserString('ItemName',	tostring(ItemName));
		
	MyWindow:setVisible(true)		-- �������� �ڽ�Ƭ
end

local itemImageChangeTime = 0

--------------------------------------------------------------------
-- ������ �����۵��� �����κ�
--------------------------------------------------------------------
function Shop_ItemRender(args)
	if bItemInfoReceive == false then		-- ������ ������ �ȹ޾ƿ� ���¶��
		return
	end
	local _drawer			= CEGUI.toWindowEventArgs(args).window:getDrawer()
	local local_window		= CEGUI.toWindowEventArgs(args).window

	local ItemIndex			= tonumber(local_window:getUserString("ItemIndex"))
	local ItemName			=  Common_GetItemName(local_window:getUserString("ItemNumber") )--local_window:getUserString("ItemName")
	local ItemFileName		= local_window:getUserString("ItemNameFile")
	local ItemFileName2		= local_window:getUserString("ItemNameFile2")
	
	local ItemLevel			= tonumber(local_window:getUserString("Level"))
	local ItemExpireTime	= local_window:getUserString("ItemExpireTime")
	local ItemKind			= tonumber(local_window:getUserString("ItemKind"))
	local strDesc			= Common_GetItemDescription( local_window:getUserString("ItemNumber") )--local_window:getUserString("strDesc")
	local bWear				= tonumber(local_window:getUserString("bWear"))
	local ExpiredCheck		= tonumber(local_window:getUserString("ExpiredCheck"))
	local RelationproductNo	= tonumber(local_window:getUserString("RelationproductNo"))		-- �κ��丮 ����� ������ ī��Ʈ����.
	local ItemKind			= tonumber(local_window:getUserString("ItemKind"))			-- �κ��丮 ����� ������ ī��Ʈ����.
	local Promotion			= tonumber(local_window:getUserString("forimagePromotion"))			-- ���θ�� �ε���
	local PricePoint		= tonumber(local_window:getUserString("PricePoint"))		-- ������ ����
	local PayType			= tonumber(local_window:getUserString("PayType"))		-- ������ ����
	local ItemNumber		= tonumber(local_window:getUserString("ItemNumber"))	-- ������ �ѹ�
	local Possessed			= tonumber(local_window:getUserString("Possessed"))	-- ������ �ѹ�
	local boneType			= tonumber(local_window:getUserString("boneType"))	-- ������ �ѹ�
	local ItemState			= tonumber(local_window:getUserString("ItemState"))	-- ������ �ѹ�
	local Pieces			= tonumber(local_window:getUserString("Pieces"))	-- �ѹ��� �Ĵ� �����۰���
	local ItemStyle			= tonumber(local_window:getUserString("ItemStyle"))	-- �������� ��Ÿ��
	
	ItemStyle = ItemStyle - 1
	
	-- �����ۿ� �̸��� ���ִٸ�
	if local_window  then
		if CurrentSelectTab == COSTUME_TAB-1 then	-- �ڽ�Ƭ
			-- �ڽ�Ƭ ����
			_drawer:setFont(g_STRING_FONT_GULIM, 111)
--			local CostumkindStr	= CostumKindString(CostumeKind)
--			Size = GetStringSize(g_STRING_FONT_GULIM, 11, CostumkindStr)
--			_drawer:drawText(CostumkindStr, (116 / 2) - (Size / 2) + 4, 148)
			
			_drawer:drawTexture(ItemFileName, 8, 42, 100, 100, 0, 0)			-- ������ �̹���
			if ItemFileName2 ~= "" then
				_drawer:drawTexture(ItemFileName2, 8, 42, 100, 100, 0, 0)			-- ������ �̹���
			end
			
--			ItemStatDisPlay(_drawer, ItemNumber)
		elseif CurrentSelectTab == SKILL_TAB-1 then	-- ��ų
			local	skillkind, desc = SkillDescDivide(strDesc)
			_drawer:setFont(g_STRING_FONT_GULIM, 10)
			skillkind = SummaryString(g_STRING_FONT_GULIM, 10, skillkind, 80)
			Size = GetStringSize(g_STRING_FONT_GULIM, 10, skillkind)
			_drawer:setTextColor(255,255,255,255)
			_drawer:drawText(skillkind, (116 / 2) - (Size / 2), 148)	
			_drawer:drawTexture(ItemFileName, 8, 42, 100, 100, 0, 0)			-- ������ �̹���
			if ItemFileName2 ~= "" then
				_drawer:drawTexture(ItemFileName2, 8, 42, 100, 100, 0, 0)			-- ������ �̹���
			end
			if ItemStyle >= 0 and ItemStyle < 3 then
				_drawer:drawTexture("UIData/Skill_up2.tga", 25, 110,  89, 35,  tAttributeImgTexXTable[ItemStyle][0], tAttributeImgTexYTable[ItemStyle][0])
				_drawer:drawTexture("UIData/Skill_up2.tga", 25, 110,  89, 35,  promotionImgTexXTable[Promotion % 2], promotionImgTexYTable[Promotion / 2])
			end
		elseif CurrentSelectTab == STUFFITEM_TAB-1 or CurrentSelectTab == PACKAGE_TAB-1 then
			_drawer:drawTexture(ItemFileName, 8, 42, 100, 100, 0, 0)			-- ������ �̹���
			if ItemFileName2 ~= "" then
				if ItemKind ~= ITEMKIND_ITEM_GENERATE then
					_drawer:drawTexture(ItemFileName2, 8, 42, 100, 100, 0, 0)			-- ������ �̹���
				end
			end

			LimitItemCount(_drawer, ItemIndex, ItemNumber)
			
			--[[
			if	ItemNumber == 12006001 then	 -- ��ǳ���� �ִϸ��̼� ȿ�� �����ֱ� ���ؼ� 
				if itemImageChangeTime < 100 then
					itemImageChangeTime = itemImageChangeTime + 1 
				else
					itemImageChangeTime = 0
				end
				
				if itemImageChangeTime < 50 then
					_drawer:drawTexture("UIData/ItemUIData/item/CASH_Chatbox_011.tga", 8, 42, 100, 100, 0, 0)	
				else
					_drawer:drawTexture("UIData/ItemUIData/item/CASH_Chatbox_011_1.tga", 8, 42, 100, 100, 0, 0)	
				end
			end
			--]]
		elseif CurrentSelectTab == PET_TAB -1 then
			_drawer:drawTexture(ItemFileName, 8, 42, 100, 100, 0, 0)			-- ������ �̹���
			if ItemFileName2 ~= "" then
				_drawer:drawTexture(ItemFileName2, 8, 42, 100, 100, 0, 0)			-- ������ �̹���
			end
		else
			--find
			-- ����,
		end
	
		local _my_name, _money, _level, _promotion, _my_style, _type, _sp_point, _hp_point, _experience = GetMyInfo(false);
		
		-- �������� ���ϴ� ������ �˾Ƴ���.
		local DisabledImg	= false
		
		-- 50% ����
		if ToC_GetPurchaseState(RelationproductNo, PRODUCT_SALE_50) then
			_drawer:drawTexture("UIData/my_room.tga", 13, 125, 90, 16, 934, 850)
		
		-- �����Ⱓ ����
		elseif ToC_GetPurchaseState(RelationproductNo, PRODUCT_LIMITED_TIME_SALE) then
			_drawer:drawTexture("UIData/my_room.tga", 10, 100, 93, 45, 841, 952)
		
		-- 30% ����
		elseif ToC_GetPurchaseState(RelationproductNo, PRODUCT_SALE_30) then
			_drawer:drawTexture("UIData/my_room.tga", 10, 123, 90, 17, 934, 1001)
	
		-- 80% ����
		elseif ToC_GetPurchaseState(RelationproductNo, PRODUCT_SALE_80) then
			DebugStr("ToC_GetPurchaseState 80")
			_drawer:drawTexture("UIData/my_room.tga", 10, 123, 90, 17, 934, 984)

		-- �Ϲ� ����	
		elseif ToC_GetPurchaseState(RelationproductNo, PRODUCT_SALE) then
			_drawer:drawTexture("UIData/my_room.tga", 60, -5, 52, 38, 483, 343)
			
			
		end
		
		-------------------
		-- ���ԺҰ�
		if DisabledImg == true then
			_drawer:drawTexture("UIData/my_room.tga", 41, 4, 76, 17, 167, 990)		
		else
			--������
			if Possessed == 1 then
				_drawer:drawTexture("UIData/my_room.tga", 41, 4, 76, 17, 246, 990)		
			end
		end	
		
		
		--������ ����-----------------------------
		local	StrLevel	= "Lv."..ItemLevel
		if _level < ItemLevel then
			_drawer:setTextColor(225,26,40,255)
			DisabledImg = true
		else
			_drawer:setTextColor(255,255,255,255)
		end
		
		if ItemLevel < 1 then
			StrLevel = " - "
		end
		_drawer:drawText(StrLevel, 5, 8)
		------------------------------------------
		
		-- ���Ҽ��� ����
		local String	= ""
		local my_money	= 0
		
		if PayType	== TYPE_GRAN then
			String		= ShopCommon_String_GRAN
			my_money	= GetMyMoney();
			_drawer:drawTexture("UIData/Itemshop001.tga",14, 163, 19, 19, 482, 788);
		elseif PayType	== TYPE_CASH then
			String		= ShopCommon_String_CASH
			my_money	= GetMyCash();
			--_drawer:drawTexture("UIData/Itemshop001.tga",14, 163, 19, 19, 462, 788);
		end
		
		-- �������� ����
		if my_money < PricePoint then
			_drawer:setTextColor(225,26,40,255)
			DisabledImg = true
		else
			if PayType	== TYPE_GRAN then
				_drawer:setTextColor(255,255,255,255)
			elseif PayType	== TYPE_CASH then
				_drawer:setTextColor(255,198,0,255)
			end			
		end
		
		local str_price = tostring(NumberStrToMoneyStr(PricePoint)).." "..String
		_drawer:setFont(g_STRING_FONT_GULIM, 111)
		_drawer:drawText(str_price, 40, 168)
		
		
		-- ������ �̸�
		if DisabledImg then
			_drawer:setTextColor(225,26,40,255)
		else
			_drawer:setTextColor(204,255,255,255)
		end
		_drawer:setFont(g_STRING_FONT_GULIM, 12)
		ItemName = SummaryString(g_STRING_FONT_GULIM, 12, ItemName, 75)
		local	Size = GetStringSize(g_STRING_FONT_GULIM, 12, ItemName)
		_drawer:drawText(ItemName, 116 / 2 - Size / 2, 28)
	end
end

function LimitItemCount(drawer, ItemIndex, ItemNumber)
	local nLimitCount = GetLimitItemCount(ItemNumber)
	local TempString = PreCreateString_4727	--GetSStringInfo(LAN_QUANTITY_COUNT)
	local Stat_String = ""

	if nLimitCount > 0 then
		Stat_String = TempString.." : "..nLimitCount
	elseif nLimitCount == 0 then
		winMgr:getWindow("Shop_SoldOutImage"..ItemIndex):setVisible(true)
		return
	else
		return
	end

	drawer:setTextColor(87,242,9,255)
	local str_stat_size = GetStringSize(g_STRING_FONT_GULIM, 10, Stat_String);
	local str_stat_ctrl_pos = (120 - str_stat_size)/2;
	
	drawer:setFont(g_STRING_FONT_GULIM, 10)
	drawer:drawText(Stat_String, str_stat_ctrl_pos, 146)
end

-------------------------------------------------------
-- ������ �ִ��� ������ ǥ�����ֱ����ؼ�
-------------------------------------------------------
function ItemStatDisPlay(drawer, ItemNumber)
	-- ���� ����
	local AtkStr, AtkGra, Cri, Hp, Sp, DefStr, DefGra,TeamA, DoubleA, SpecialA, TeamD, DoubleD, SpecialD, CriDmg = GetItemStat(ItemNumber);
	local tStat			= {['protecterr']=0, AtkStr, AtkGra, Cri, Hp, Sp, DefStr, DefGra}
	local tStatNameText = {['protecterr']=0, PreCreateString_1122, PreCreateString_1123, PreCreateString_1124, 
									"HP", "SP", PreCreateString_1125, PreCreateString_1126 }

	
	local Stat_String	= Shop_String_20	-- �ɷ�ġ ����
	drawer:setTextColor(255,255,255,255)
	
	for i = 1, #tStatNameText do
		if tStat[i] ~= 0 then
			if tStat[i] > 0 then
				Stat_String = "+ "..Shop_String_21
				drawer:setTextColor(87,242,9,255)
				break
			end				
		end
	end
	
	local str_stat_size = GetStringSize(g_STRING_FONT_GULIM, 111, Stat_String);
	local str_stat_ctrl_pos = (120 - str_stat_size)/2;
	
	drawer:setFont(g_STRING_FONT_GULIM, 111)
	drawer:drawText(Stat_String, str_stat_ctrl_pos, 146)

end



--------------------------------------------------------------------
-- �ڽ�Ƭ ���� ��Ʈ������
--------------------------------------------------------------------
function CostumKindString(KindIndex)
	local CostumString	= ""
	
	CostumString = tCostumKind[KindIndex]
	
	return MR_String_11.." : "..CostumString
end

--------------------------------------------------------------------
-- ��ų ��Ʈ�� �ɰ��� �����ش�.
--------------------------------------------------------------------
function SkillDescDivide(str)
	local _DescStart	= ""
	local _DescStart2	= ""
	local _DescEnd		= ""
	local _DescEnd2		= ""
	local _SkillKind = "";		--��ų����
	local _DetailDesc = "";		--��ų����
	
	_DescStart, _DescEnd = string.find(str, "%$");
	
	if _DescStart ~= nil then
		_SkillKind = string.sub(str, 1, _DescStart - 1);
		_DetailDesc = string.sub(str, _DescEnd + 1);
		_DescStart2, _DescEnd2 = string.find(_DetailDesc, "%$");
		if _DescStart2 ~= nil then
			_DetailDesc = string.sub(_DetailDesc, _DescEnd2 + 1);
		end
		
	end
	
	return _SkillKind, _DetailDesc
end


--------------------------------------------------------------------
-- ������ ������ ��ư(����)
--------------------------------------------------------------------
function Shop_PrevBt(args)
	local bSuccess	= ToC_PageSetting(0)
end


--------------------------------------------------------------------
-- ������ ������ ��ư(������)
--------------------------------------------------------------------
function Shop_NextBt(args)
	local bSuccess	= ToC_PageSetting(1)
end


--------------------------------------------------------------------
-- �� ���� ĳ���� ȸ����ư�̺�Ʈ(����)
--------------------------------------------------------------------
function Shop_CharacterLRotateDownEvent()
	CharRotateOn(0)
end
--------------------------------------------------------------------
-- �� ���� ĳ���� ȸ����ư�̺�Ʈ(������)
--------------------------------------------------------------------
function Shop_CharacterRRotateDownEvent()
	CharRotateOn(1)
end
--------------------------------------------------------------------
-- �� ���� ĳ���� ȸ����ư�̺�Ʈ(����)
--------------------------------------------------------------------
function Shop_CharacterLRotateUpEvent()
	CharRotateOff()
end
--------------------------------------------------------------------
-- �� ���� ĳ���� ȸ����ư�̺�Ʈ(������)
--------------------------------------------------------------------
function Shop_CharacterRRotateUpEvent()
	CharRotateOff()
end



-- ������ �Ҽ������� �ٲ۴�.
function GetDecimalPoint(value)
	local first	= value / 10
	local last	= value % 10
	
	return tostring(first).."."..tostring(last)
end




--------------------------------------------------------------------
-- ��ų�κ� ����
--------------------------------------------------------------------
function SkillBackRender(args)
	local local_window		= CEGUI.toWindowEventArgs(args).window
	local _drawer			= local_window:getDrawer()
--	SelectSkillInfoTable[1]	= Level
--	SelectSkillInfoTable[2]	= Name
--	SelectSkillInfoTable[3]	= PromotionStr
--	SelectSkillInfoTable[4]	= SkillKind
--	SelectSkillInfoTable[5]	= PayType
--	SelectSkillInfoTable[6]	= PricePoint
--	SelectSkillInfoTable[7]	= Desc	
-- SelectSkillInfoTable[8]	= PropIndex
	
	_drawer:drawTexture("UIData/my_room2.tga", 6, 374, 475, 145, 0, 519)
	
	if bSelectStat then
		_drawer:setTextColor(255,255,255,255)
		_drawer:setFont(g_STRING_FONT_GULIM, 12)
		
		ShowSkillCommand(_drawer, SelectSkillInfoTable[9], SelectSkillInfoTable[8], 200, 200, 115, 378, 25, 310)
		
		-- ����
		local	Size = GetStringSize(g_STRING_FONT_GULIM, 12, tostring(SelectSkillInfoTable[1]))
		_drawer:drawText(tostring(SelectSkillInfoTable[1]), 305 / 2 - Size / 2, 410)
		-- ��ų�̸�
		local	Size = GetStringSize(g_STRING_FONT_GULIM, 12, tostring(SelectSkillInfoTable[2]))
		_drawer:drawText(tostring(SelectSkillInfoTable[2]), 776 / 2 - Size / 2, 410)
		-- Ŭ����
		local	Size = GetStringSize(g_STRING_FONT_GULIM, 12, tostring(SelectSkillInfoTable[3]))
		_drawer:drawText(tostring(SelectSkillInfoTable[3]), 305 / 2 - Size / 2, 429)
		-- ��ų����
		local	Size = GetStringSize(g_STRING_FONT_GULIM, 12, tostring(SelectSkillInfoTable[4]))
		_drawer:drawText(tostring(SelectSkillInfoTable[4]), 776 / 2 - Size / 2, 429)
		-- ���Ҽ��� ������ �̹���
		local String	= ""
		
		if SelectSkillInfoTable[5] == TYPE_GRAN then			-- �׶� ����
			_drawer:drawTexture("UIData/Itemshop001.tga",110, 445, 19, 19, 482, 788)
			String		= ShopCommon_String_GRAN			
		elseif SelectSkillInfoTable[5] == TYPE_CASH then		-- ĳ��
			_drawer:drawTexture("UIData/Itemshop001.tga",110, 445, 19, 19, 462, 788)
			String		= ShopCommon_String_CASH
		end
		-- ����
		_drawer:drawText(tostring(NumberStrToMoneyStr(SelectSkillInfoTable[6])).." "..String, 140, 450)
		-- ����
		local Desc = AdjustString(g_STRING_FONT_GULIM, 12, SelectSkillInfoTable[7], 350)
		_drawer:drawText(Desc, 115, 480)
	
	end
end

local NONSKILL			= 0		-- ��ų ����(���߿� ������)
local STRIKE_NORMAL		= 1		-- �Ϲ�Ÿ��
local STRIKE_UP			= 2		-- ���Ÿ��
local STRIKE_MIDDLE		= 3		-- �ߴ�Ÿ��
local STRIKE_DOWN		= 4		-- �ϴ�Ÿ��
local STRIKE_DASH		= 5		-- �뽬Ÿ��
local STRIKE_SLIDING	= 6		-- �����̵�
local STRIKE_DIVING		= 7		-- ���̺�Ÿ��
local GRAB_NORMAL		= 8		-- �߸����
local GRAB_UP			= 9		-- ������
local GRAB_MIDDLE		= 10	-- �ߴ����
local GRAB_DOWN			= 11	-- �ϴ����
local GRAB_DASH			= 12	-- �뽬���
local GRAB_DIVING		= 13	-- ���̺����
local GRAB_LIEFRONT		= 14	-- �������
local GRAB_LIEBACK		= 15	-- ��������
local SPECIAL_Q1		= 16	-- �Ϲ��ʻ��
local SPECIAL_Q2		= 17	-- �ʻ����
local SPECIAL_W			= 18	-- �޺��ʻ��
local SPECIAL_E			= 19	-- ���ʻ��
local ATTACK_DOUBLE		= 20	-- ��������
local ATTACK_TEAM		= 21	-- ������
local COUNTERATTACK_UP	= 22	-- ���ߴ� �ݰݱ�
local COUNTERATTACK_DOWN= 23	-- �ϴܹݰݱ�

local SkillCommandInfoTable	= {["err"] = 0, }
--SkillCommandInfoTable[NONSKILL]
--[[
[NONSKILL]
SkillCommandInfoTable[STRIKE_NORMAL]
SkillCommandInfoTable[STRIKE_UP]
SkillCommandInfoTable[STRIKE_MIDDLE]
SkillCommandInfoTable[STRIKE_DOWN]
SkillCommandInfoTable[STRIKE_DASH]
SkillCommandInfoTable[STRIKE_SLIDING]
SkillCommandInfoTable[STRIKE_DIVING]
SkillCommandInfoTable[GRAB_NORMAL]
SkillCommandInfoTable[GRAB_UP]
SkillCommandInfoTable[GRAB_MIDDLE]
SkillCommandInfoTable[GRAB_DOWN]
SkillCommandInfoTable[GRAB_DASH]
SkillCommandInfoTable[GRAB_DIVING]
SkillCommandInfoTable[GRAB_LIEFRONT]
SkillCommandInfoTable[GRAB_LIEBACK]
SkillCommandInfoTable[SPECIAL_Q1]
SkillCommandInfoTable[SPECIAL_Q2]
SkillCommandInfoTable[SPECIAL_W]
SkillCommandInfoTable[SPECIAL_E]
SkillCommandInfoTable[ATTACK_DOUBLE]
SkillCommandInfoTable[ATTACK_TEAM]
SkillCommandInfoTable[COUNTERATTACK_UP]
SkillCommandInfoTable[COUNTERATTACK_DOWN]

--]]
local SkillKindIndex	= {["err"] = 0, 
[0] = STRIKE_NORMAL,	-- 0
STRIKE_NORMAL,			-- 1
STRIKE_UP,				-- 2
STRIKE_UP,				-- 3
STRIKE_MIDDLE,			-- 4
STRIKE_MIDDLE,			-- 5
STRIKE_DOWN,			-- 6
STRIKE_DOWN,			-- 7
STRIKE_DOWN,			-- 8
GRAB_UP,				-- 9
GRAB_UP,				-- 10
GRAB_UP,				-- 11
GRAB_MIDDLE,			-- 12
GRAB_MIDDLE,			-- 13
GRAB_MIDDLE,			-- 14
GRAB_DOWN,				-- 15
GRAB_DOWN,				-- 16
GRAB_DOWN,				-- 17
NONSKILL,				-- 18
NONSKILL,				-- 19
NONSKILL,				-- 20
NONSKILL,				-- 21
NONSKILL,				-- 22
NONSKILL,				-- 23
NONSKILL,				-- 24
NONSKILL,				-- 25
GRAB_LIEFRONT,			-- 26
GRAB_LIEFRONT,			-- 27
GRAB_LIEFRONT,			-- 28
GRAB_LIEFRONT,			-- 29
GRAB_LIEBACK,			-- 30
GRAB_LIEBACK,			-- 31
GRAB_LIEBACK,			-- 32
GRAB_LIEBACK,			-- 33
STRIKE_DASH,			-- 34
STRIKE_SLIDING,			-- 35
STRIKE_DIVING,			-- 36
GRAB_DIVING,			-- 37
NONSKILL,				-- 38
ATTACK_DOUBLE,			-- 39
NONSKILL,				-- 40
ATTACK_DOUBLE,			-- 41
ATTACK_TEAM,			-- 42
NONSKILL,				-- 43
ATTACK_TEAM,			-- 44
NONSKILL,				-- 45
SPECIAL_Q1,				-- 46
SPECIAL_Q2,				-- 47
SPECIAL_W,				-- 48
SPECIAL_E,				-- 49
GRAB_NORMAL,			-- 50
GRAB_NORMAL,			-- 51
COUNTERATTACK_UP,		-- 52
COUNTERATTACK_DOWN,		-- 53
NONSKILL,				-- 54
NONSKILL,				-- 55
NONSKILL,				-- 56
NONSKILL,				-- 57
NONSKILL,				-- 58
NONSKILL				-- 59
}


-- �Ӽ� �ε��� ������ �ѷ��ִ� Ŀ�ǵ带 ã�´�.
function GetSkillCommand(PropIndex)
	local	skillKind	= SkillKindIndex[PropIndex]
	
	

end


function SkillCommandInfo(bImage, bText, ImageCount)
	

end

--[[
--------------------------------------------------------------------
-- ĳ���� ���� ������ư Ŭ�� �̺�Ʈ
--------------------------------------------------------------------
function Shop_CharacterInfoShow()
	if CEGUI.toRadioButton(winMgr:getWindow("Shop_CharacterInfo")):isSelected() then
		bCharacterInfoShow	= true
		bRankInfoShow		= false
		bStatInfoShow		= true
--		winMgr:getWindow("Shop_RankImg"):setVisible(false)
		winMgr:getWindow("Shop_StatInfo"):setVisible(true)		-- �ɷ�ġ ��ư �����ش�
		winMgr:getWindow("Shop_EffectInfo"):setVisible(true)		-- Ư��ȿ����ư �����ش�.
		winMgr:getWindow("Shop_StatInfo"):setProperty("Selected", "true")		-- ���� ������ ����Ʈ �����ش�.
	end
end


--------------------------------------------------------------------
-- ���� / ��ŷ ������ư Ŭ�� �̺�Ʈ
--------------------------------------------------------------------
function Shop_RankInfoShow()
	if CEGUI.toRadioButton(winMgr:getWindow("Shop_RankInfo")):isSelected() then
		bCharacterInfoShow	= false
		bRankInfoShow		= true
		bStatInfoShow		= false
--		winMgr:getWindow("Shop_RankImg"):setVisible(true)
		winMgr:getWindow("Shop_StatInfo"):setVisible(false)		-- �ɷ�ġ ��ư �����ش�.
		winMgr:getWindow("Shop_EffectInfo"):setVisible(false)		-- Ư��ȿ����ư �����ش�.
		winMgr:getWindow("Shop_SpecialBackImg"):setVisible(false)

	end
end


--------------------------------------------------------------------
-- �ɷ�ġ ������ư Ŭ�� �̺�Ʈ
--------------------------------------------------------------------
function Shop_StatInfoShow()
	if CEGUI.toRadioButton(winMgr:getWindow("Shop_StatInfo")):isSelected() then
		winMgr:getWindow("Shop_SpecialBackImg"):setVisible(false)
		bStatInfoShow	= true
		bEffectInfoShow	= false
	end
end


--------------------------------------------------------------------
-- Ư��ȿ�� ������ư Ŭ�� �̺�Ʈ
--------------------------------------------------------------------
function Shop_EffectInfoShow()
	if CEGUI.toRadioButton(winMgr:getWindow("Shop_EffectInfo")):isSelected() then
		winMgr:getWindow("Shop_SpecialBackImg"):setVisible(true)		
		CommonShowMyBuff()
		bStatInfoShow	= false
		bEffectInfoShow	= true	
	end
end

--]]
--------------------------------------------------------------------
-- ������ư Ŭ���� �ʱ�ȭ ���ִ� �Լ�. 
--------------------------------------------------------------------
function KindTabEvent(Index)

	for i = 1, #tMainImgName do
		winMgr:getWindow(tMainImgName[i]):setVisible(false)
		winMgr:getWindow(tLeftMainImgName[i]):setVisible(false)
	end
	
	winMgr:getWindow(tMainImgName[Index]):setVisible(true)
	winMgr:getWindow(tLeftMainImgName[Index]):setVisible(true)	
	
	-- �ϴ��� �ڽ�Ƭ�� ��ų�� �������� �ֱ⶧���� 
	for i = 1, #tSubFirstIcon_Name do
		winMgr:getWindow(tSubFirstIcon_Name[i]):setProperty("Selected", "true")		-- ù��° �������� �������ش�
	end
	
end




--------------------------------------------------------------------
-- ������ ���� ī�װ��� ������ư Ŭ�� �̺�Ʈ(�߻��� �����ְ� �ѷ��ִ°� update_product)
--------------------------------------------------------------------
function Shop_TabKindClick(args)
	local EventWindow	= CEGUI.toWindowEventArgs(args).window

	if CEGUI.toRadioButton(EventWindow):isSelected() then
		for i = 1, #tShopTabBtn_Name do
			if tShopTabBtn_Name[i] == EventWindow:getName() then
				CurrentSelectTab = i - 1	-- ���� �� ����
				
				KindTabEvent(i)			-- ��ư�� ���� �����ְ����� �κи� �����ش�.(�ʱ�ȭ)
				DropDownListSetting(i)	-- ����ٿ� ����Ʈ�� �������ش�.
--				SetDropDownBaseText(i, TypeIndex)
				ToC_SelectedItemCategory(i - 1)		-- ���� ī�װ��� ������ ���ش�(c�� ������)
				 
				ToC_ClickItemKindTabEvent(i - 1)	-- ������ ���� ���� �������� �߻������ִ� �̺�Ʈ
				
				ToC_HidePreviewSkill()
				bSelectStat	= false
				
				if i == SKILL_TAB then		-- ��ų
					ToC_CharacterSetVisible(false)
				else
					ToC_CharacterSetVisible(true)
				end
				
				-- �θ������츦 �مR�ش�(�ǿ� �´� �̹����� ������ ������ �� �ո����� �ٿ�����Ѵ�.)
				for j = 1, PAGE_MAXITEM do
					winMgr:getWindow(tMainImgName[i]):addChildWindow("Shop_Item"..j)
					winMgr:getWindow(tMainImgName[i]):addChildWindow("Shop_EmptyOrItem"..j)
				end
				TitleTextEvent(i)
				
				break
			end
		end
	end
end


--------------------------------------------------------------------
-- ������ ����
--------------------------------------------------------------------
function Shop_PageSetting(CurrentPage, TotalPage)
	-- ������ ����.
	root:setUserString("Shop_TotalPage", tostring(TotalPage))
	root:setUserString("Shop_CurrentPage", tostring(CurrentPage))
	
	winMgr:getWindow("Shop_PageText"):clearTextExtends();
	winMgr:getWindow("Shop_PageText"):addTextExtends(tostring(CurrentPage)..' / '..tostring(TotalPage) , g_STRING_FONT_GULIMCHE, 18, 255,255,255,255, 0, 0,0,0,255);
end


--------------------------------------------------------------------
-- �� ������ ���ý� �̺�Ʈ
--------------------------------------------------------------------
function Shop_CostumeSelectEvent(args)
	if CEGUI.toRadioButton(CEGUI.toWindowEventArgs(args).window):isSelected() then
		NCS_Selected_Window	= CEGUI.toWindowEventArgs(args).window
		ToC_SelectedItem(CEGUI.toWindowEventArgs(args).window:getUserString('ItemNumber'));
		if CurrentSelectTab == 1 then
			local Level				= tonumber(NCS_Selected_Window:getUserString('Level'))
			local Name				= Common_GetItemName( NCS_Selected_Window:getUserString("ItemNumber") )			--������ �̸�
			local DescBuf			= Common_GetItemDescription( NCS_Selected_Window:getUserString("ItemNumber"))	--������ ����
			local PricePoint		= tonumber(NCS_Selected_Window:getUserString('PricePoint'))
			local PayType			= tonumber(NCS_Selected_Window:getUserString('PayType'))
			local Promotion			= tonumber(NCS_Selected_Window:getUserString('forimagePromotion'))
			local SkillKind, Desc 	= SkillDescDivide(DescBuf)
			local PromotionStr		= tSkillStrTable[Promotion + 1]
			local PropIndex			= tonumber(NCS_Selected_Window:getUserString("PropIndex"))
			local attach			= tonumber(NCS_Selected_Window:getUserString("attach"))
			
			DebugStr(Promotion)
			
			bSelectStat	= true
			SelectSkillInfoTable[1]	= Level
			SelectSkillInfoTable[2]	= Name
			SelectSkillInfoTable[3]	= PromotionStr
			SelectSkillInfoTable[4]	= SkillKind
			SelectSkillInfoTable[5]	= PayType
			SelectSkillInfoTable[6]	= PricePoint
			SelectSkillInfoTable[7]	= Desc
			SelectSkillInfoTable[8]	= PropIndex
			SelectSkillInfoTable[9]	= attach
		end
	end
end



--------------------------------------------------------------------
-- �� ������ ���Թ�ư �̺�Ʈ
--------------------------------------------------------------------
function Shop_PurchaseBtnEvent(args)
	local local_window = CEGUI.toWindowEventArgs(args).window;
	local mywindow	= local_window:getParent()		-- �θ� ������

	mywindow:setProperty("Selected", "true")		-- ���� �����ְ�

	-- �迭üũ
	local item_BoneType	= mywindow:getUserString('boneType');
	
	local ItemKind		= tonumber(mywindow:getUserString('ItemKind'))
	local Promotion		= tonumber(mywindow:getUserString('forimagePromotion'))
	local _my_name, _money, _level, _promotion, _my_style, _type, _sp_point, _hp_point, _experience = GetMyInfo(false);
	
	local ItemNumber	= 	tonumber(mywindow:getUserString('ItemNumber'))
	local ListIndex		= 	tonumber(mywindow:getUserString('ListIndex'))
	local RelationproductNo = tonumber(mywindow:getUserString('RelationproductNo'))
	
	if ToC_GetPurchaseState(RelationproductNo, PRODUCT_SOLD_OUT) then
		ShowNotifyOKMessage_Lua(PreCreateString_2384)	-- ��ǰ ǰ��	--GetSStringInfo(LAN_CAN_NOT_PURCHASE_ITEM_SOLD_OUT)
		return
	end	
	PurchaseContent(mywindow, Type_Purchase);
end


--------------------------------------------------------------------
-- �� ������ ����Ŭ�� �̺�Ʈ
--------------------------------------------------------------------
function Shop_ItemDoubleClickEvent(args)
	local mywindow = CEGUI.toWindowEventArgs(args).window;

--	mywindow:setProperty("Selected", "true")		-- ���� �����ְ�

	-- �迭üũ
	local item_BoneType	= tonumber(mywindow:getUserString('boneType'))
	local Item_Experience	= tonumber(mywindow:getUserString('ItemExperience'))
	
	local ItemKind		= tonumber(mywindow:getUserString('ItemKind'))
	local Promotion		= tonumber(mywindow:getUserString('forimagePromotion'))
	local _my_name, _money, _level, _promotion, _my_style, _type, _sp_point, _hp_point, _experience = GetMyInfo(false)
	
	-- Item_Experience �� 3�� ���� �� ���� ������
	if Item_Experience ~= 3 then
		if ItemKind == ITEMKIND_COSTUM then
			if item_BoneType ~= _type then
				return
			end		
		end
	end
	
	local ItemNumber	= 	tonumber(mywindow:getUserString('ItemNumber'))
	local ListIndex		= 	tonumber(mywindow:getUserString('ListIndex'))
	local RelationproductNo = tonumber(mywindow:getUserString('RelationproductNo'))
	
	if ToC_GetPurchaseState(RelationproductNo, PRODUCT_SOLD_OUT) then
		ShowNotifyOKMessage_Lua(PreCreateString_2384)	-- GetSStringInfo(LAN_CAN_NOT_PURCHASE_ITEM_SOLD_OUT)	��ǰ ǰ��
		return
	end	
	PurchaseContent(mywindow, Type_Purchase);
end

function Shop_PresentBtnEvent(args)
	local local_window = CEGUI.toWindowEventArgs(args).window;
	local mywindow	= local_window:getParent()		-- �θ� ������

	mywindow:setProperty("Selected", "true")		-- ���� �����ְ�
	
	local RelationproductNo = tonumber(mywindow:getUserString('RelationproductNo'))
	
	if ToC_GetPurchaseState(RelationproductNo, PRODUCT_SOLD_OUT) then
		ShowNotifyOKMessage_Lua(PreCreateString_2384)	-- GetSStringInfo(LAN_CAN_NOT_PURCHASE_ITEM_SOLD_OUT)	��ǰ ǰ��
		return
	end	
	PurchaseContent(mywindow, Type_Present);
end



function Shop_ShowRandomOpenItem(args)
	local local_window = CEGUI.toWindowEventArgs(args).window;
	local mywindow	= local_window:getParent()		-- �θ� ������
	local ItemNumber= tonumber(mywindow:getUserString('ItemNumber'))
	local x, y = GetBasicRootPoint(local_window)
	if x + 245 > g_CURRENT_WIN_SIZEX then
		x = x - 245
	end
	if y + 175 > g_CURRENT_WIN_SIZEY then
		y = y - 175
	end
	ShowRandomOpenItem(ItemNumber, x, y)
	

end






--[[

local	PurchaseWindow	= ""

function ExchangeSkillEvent(mywindow)
	PurchaseWindow	= mywindow
	ShowCommonAlertOkCancelBoxWithFunction(ItemName, "��\n�ٷ� �����Ͻðڽ��ϱ�?", "ExchangeSkillEventOk", "ExchangeSkillEventCancel")
end



function ExchangeSkillEventOk(args)


end


function ExchangeSkillEventCancel(args)


end

--]]
----------------------------------------------------------------------------------------------------------------------



--------------------------------------------------------------------
-- �ڽ�Ƭ, ��ų ī�װ����� ���� ������ư Ŭ�� �̺�Ʈ
--------------------------------------------------------------------
function Shop_SubTabKindClick(args)
	local local_window	= CEGUI.toWindowEventArgs(args).window
	
	if CEGUI.toRadioButton(local_window):isSelected() then
		local CategoryIndex		= tonumber(local_window:getUserString("CategoryIndex"))
		
		ToC_SelectedSubCategory(CategoryIndex - 1)
		
		if CurrentSelectTab == 1 then
			ToC_HidePreviewSkill()
			bSelectStat	= false
		end
		
	end
end








function Shop_ItemMouseEnter(args)
	local EnterWindow		= CEGUI.toWindowEventArgs(args).window
	local itemNumber		= EnterWindow:getUserString('ItemNumber');
	local ItemKind			= tonumber(EnterWindow:getUserString('ItemKind'))
	local ItemIndex			= tonumber(EnterWindow:getUserString("ItemIndex"))
	local RelationproductNo	= tonumber(EnterWindow:getUserString("RelationproductNo"))

	local kind = -1
	local type = TYPE_SHOP
	local slot = RelationproductNo
	local number = tonumber(itemNumber)
	
	DebugStr("itemNumber : " .. itemNumber)
	
	if ItemKind == ITEMKIND_COSTUM then
		kind = KIND_COSTUM
	elseif ItemKind == ITEMKIND_SKILL then
		kind = KIND_SKILL
	elseif ItemKind == ITEMKIND_HOTPICKS then
		kind = KIND_ORB
	else
		kind = KIND_ITEM
	end	
	local x, y = GetBasicRootPoint(EnterWindow)
	local tMove = {['err']=0, false, false, true, true, false, false, true, true}
	
	if tMove[ItemIndex] then
		x = x - 360
	end
	GetToolTipBaseInfo(x+120, y, type, kind, slot, number)	-- ������ ���� ������ �������ش�.
	SetShowToolTip(true)
	PlayWave('sound/listmenu_click.wav');
end



function Shop_ItemMouseLeave(args)
	SetShowToolTip(false)
end









--[[
Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 12, 47,   29, 29,   731, 719,   160, 160,   255, 0, 0);	--a
Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 12, 47,   29, 29,   761, 719,   160, 160,   255, 0, 0);	--s
Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 12, 47,   29, 29,   791, 719,   160, 160,   255, 0, 0);	--d
Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 12, 47,   29, 29,   821, 719,   160, 160,   255, 0, 0);	--��
Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 12, 47,   29, 29,   851, 719,   160, 160,   255, 0, 0);	--q
Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 12, 47,   29, 29,   881, 719,   160, 160,   255, 0, 0);	--w
Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 12, 47,   29, 29,   911, 719,   160, 160,   255, 0, 0);	--e

Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 12, 47,   29, 29,   731, 749,   160, 160,   255, 0, 0);	--+
Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 12, 47,   29, 29,   761, 749,   160, 160,   255, 0, 0);	--or
Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 12, 47,   29, 29,   791, 749,   160, 160,   255, 0, 0);	--��
Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 12, 47,   29, 29,   821, 749,   160, 160,   255, 0, 0);	--�Ʒ�
Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 12, 47,   29, 29,   851, 749,   160, 160,   255, 0, 0);	--����
Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 12, 47,   29, 29,   881, 749,   160, 160,   255, 0, 0);	--f
Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 12, 47,   29, 29,   911, 749,   160, 160,   255, 0, 0);	--...
--]]


--------------------------------------------------------------------
-- ������ Ŀ����Է�
--------------------------------------------------------------------
function InputCommand(Commanedrawer, ButtonIndex, Index)
	--Commanedrawer
	if ButtonIndex == 1	then	-- Ÿ��
		if Index == 1 then		-- �Ϲ�Ÿ��
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 12, 47,   29, 29,   791, 719,   160, 160,   255, 0, 0);
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 31, 47,   29, 29,   791, 719,   160, 160,   255, 0, 0);
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 50, 47,   29, 29,   791, 719,   160, 160,   255, 0, 0);
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 69, 47,   29, 29,   911, 749,   160, 160,   255, 0, 0);
			
		elseif Index == 2 then	-- ���Ÿ��
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 12, 47,   29, 29,   821, 719,   160, 160,   255, 0, 0);	--��
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 31, 47,   29, 29,   731, 749,   160, 160,   255, 0, 0);	--+
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 50, 47,   29, 29,   791, 719,   160, 160,   255, 0, 0);	--d
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 69, 47,   29, 29,   911, 749,   160, 160,   255, 0, 0);	--...
			
		elseif Index == 3 then	-- �ߴ�Ÿ��
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 12, 42,   29, 29,   791, 749,   160, 160,   255, 0, 0);	--��
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 12, 57,   29, 29,   761, 749,   160, 160,   255, 0, 0);	--��
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 12, 72,   29, 29,   851, 749,   160, 160,   255, 0, 0);	--��
			
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 31, 57,   29, 29,   731, 749,   160, 160,   255, 0, 0);	--+
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 50, 57,   29, 29,   791, 719,   160, 160,   255, 0, 0);	--d
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 69, 57,   29, 29,   911, 749,   160, 160,   255, 0, 0);	--...
		
		elseif Index == 4 then	-- �ϴ�Ÿ��
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 12, 47,   29, 29,   821, 749,   160, 160,   255, 0, 0);	--��
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 31, 47,   29, 29,   731, 749,   160, 160,   255, 0, 0);	--+
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 50, 47,   29, 29,   791, 719,   160, 160,   255, 0, 0);	--d
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 69, 47,   29, 29,   911, 749,   160, 160,   255, 0, 0);	--...
		elseif Index == 5 then	-- �뽬Ÿ��
			Commanedrawer:setTextColor(255,255,255,255)
			Commanedrawer:setFont(g_STRING_FONT_GULIMCHE, 12)
			Commanedrawer:drawText("("..MR_String_47..")", 12, 50)
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 67, 47,   29, 29,   791, 719,   160, 160,   255, 0, 0);
		elseif Index == 6 then	-- ���̺�Ÿ��		
			Commanedrawer:setTextColor(255,255,255,255)
			Commanedrawer:setFont(g_STRING_FONT_GULIMCHE, 12)
			Commanedrawer:drawText("("..MR_String_48..")", 5, 50)
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 71, 47,   29, 29,   791, 719,   160, 160,   255, 0, 0);
		elseif Index == 7 then	-- �����̵�
			Commanedrawer:setTextColor(255,255,255,255)
			Commanedrawer:setFont(g_STRING_FONT_GULIMCHE, 12)
			Commanedrawer:drawText("("..MR_String_47..")", 12, 50)
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 67, 47,   29, 29,   761, 719,   160, 160,   255, 0, 0);
		end
	elseif ButtonIndex == 2 then	-- ���
		if Index == 1 then
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 17, 47,   29, 29,   821, 719,   160, 160,   255, 0, 0);	--��
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 36, 47,   29, 29,   731, 749,   160, 160,   255, 0, 0);	--+
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 55, 47,   29, 29,   761, 719,   160, 160,   255, 0, 0);	--s
		elseif Index == 2 then
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 17, 42,   29, 29,   791, 749,   160, 160,   255, 0, 0);	--��
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 17, 57,   29, 29,   761, 749,   160, 160,   255, 0, 0);	--��
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 17, 72,   29, 29,   851, 749,   160, 160,   255, 0, 0);	--��
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 36, 57,   29, 29,   731, 749,   160, 160,   255, 0, 0);	--+
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 55, 57,   29, 29,   761, 719,   160, 160,   255, 0, 0);	--s
		elseif Index == 3 then
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 17, 47,   29, 29,   821, 749,   160, 160,   255, 0, 0);	--��
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 36, 47,   29, 29,   731, 749,   160, 160,   255, 0, 0);	--+
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 55, 47,   29, 29,   761, 719,   160, 160,   255, 0, 0);	--s
		elseif Index == 4 then
			Commanedrawer:setTextColor(255,255,255,255)
			Commanedrawer:setFont(g_STRING_FONT_GULIMCHE, 12)
			Commanedrawer:drawText("("..MR_String_48..")", 5, 50)
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 71, 47,   29, 29,   761, 719,   160, 160,   255, 0, 0);
		elseif Index == 5 then
			Commanedrawer:setTextColor(255,255,255,255)
			Commanedrawer:setFont(g_STRING_FONT_GULIMCHE, 12)
			Commanedrawer:drawText("("..MR_String_49..")", 5, 50)
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 71, 47,   29, 29,   761, 719,   160, 160,   255, 0, 0);
		elseif Index == 6 then
			Commanedrawer:setTextColor(255,255,255,255)
			Commanedrawer:setFont(g_STRING_FONT_GULIMCHE, 112)
			Commanedrawer:drawText("("..MR_String_50..")", 2, 50)
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 75, 47,   29, 29,   761, 719,   160, 160,   255, 0, 0);
		elseif Index == 7 then
			Commanedrawer:setTextColor(255,255,255,255)
			Commanedrawer:setFont(g_STRING_FONT_GULIMCHE, 12)
			Commanedrawer:drawText("("..MR_String_47..")", 12, 50)
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 67, 47,   29, 29,   761, 719,   160, 160,   255, 0, 0);
		end
	elseif ButtonIndex == 3 then	-- �ʻ��
		if Index == 1 then
			Commanedrawer:setTextColor(255,255,255,255)
			Commanedrawer:setFont(g_STRING_FONT_GULIMCHE, 112)
			Commanedrawer:drawText("("..MR_String_51..")", 8, 50)
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 71, 47,   29, 29,   851, 719,   160, 160,   255, 0, 0);
		elseif Index == 2 then
			Commanedrawer:setTextColor(255,255,255,255)
			Commanedrawer:setFont(g_STRING_FONT_GULIMCHE, 112)
			Commanedrawer:drawText("("..MR_String_52..")", 2, 50)
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 75, 47,   29, 29,   851, 719,   160, 160,   255, 0, 0);
		elseif Index == 3 then
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 38, 47,   29, 29,   881, 719,   160, 160,   255, 0, 0);
		elseif Index == 4 then
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 38, 47,   29, 29,   911, 719,   160, 160,   255, 0, 0);
		end
	elseif ButtonIndex == 4 then	-- ������
		if Index == 1 then
			Commanedrawer:setTextColor(255,255,255,255)
			Commanedrawer:setFont(g_STRING_FONT_GULIMCHE, 112)
			Commanedrawer:drawText("("..MR_String_53..")", 5, 47)
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 38, 63,   29, 29,   851, 719,   160, 160,   255, 0, 0);
		elseif Index == 2 then
			Commanedrawer:setTextColor(255,255,255,255)
			Commanedrawer:setFont(g_STRING_FONT_GULIMCHE, 112)
			Commanedrawer:drawText(PreCreateString_2706, 5, 47)
			--Commanedrawer:drawText("�� �Ʊ��� ����", 5, 64)
		end
	elseif ButtonIndex == 5 then	-- ��Ÿ
		if Index == 1 then
			Commanedrawer:setTextColor(255,255,255,255)
			Commanedrawer:setFont(g_STRING_FONT_GULIMCHE, 112)
			Commanedrawer:drawText("("..MR_String_55..")", 2, 50)
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 75, 47,   29, 29,   731, 719,   160, 160,   255, 0, 0);
		elseif Index == 2 then
			Commanedrawer:setTextColor(255,255,255,255)
			Commanedrawer:setFont(g_STRING_FONT_GULIMCHE, 112)
			Commanedrawer:drawText("("..MR_String_55..")", 2, 50)
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 75, 47,   29, 29,   731, 719,   160, 160,   255, 0, 0);
		end		
	else

	end
end

--------------------------------------------------------------------
-- ��ų ��Ʈ�� �ɰ��� �����ش�.
--------------------------------------------------------------------
function SkillDescDivide(str)
	local _DescStart	= ""
	local _DescStart2	= ""
	local _DescEnd		= ""
	local _DescEnd2		= ""
	local _SkillKind = "";		--��ų����
	local _DetailDesc = str		--��ų����
	
	_DescStart, _DescEnd = string.find(str, "%$");
	
	if _DescStart ~= nil then
		_SkillKind = string.sub(str, 1, _DescStart - 1);
		_DetailDesc = string.sub(str, _DescEnd + 1);
		_DescStart2, _DescEnd2 = string.find(_DetailDesc, "%$");
		if _DescStart2 ~= nil then
			_DetailDesc = string.sub(_DetailDesc, _DescEnd2 + 1);
		end
		
	end
	
	return _SkillKind, _DetailDesc
end

--------------------------------------------------------------------
-- Ÿ��Ʋ �ؽ�Ʈ ��ȯ
--------------------------------------------------------------------
function TitleTextEvent(Index)
	winMgr:getWindow("Shop_MainTitleText"):clearTextExtends();
	local String	= ""
	if Index == 2 then		-- ��ų
		String	= "Skill Info"
	else
		String = "Character Info"
	end
	winMgr:getWindow("Shop_MainTitleText"):addTextExtends(String, g_STRING_FONT_GULIMCHE, 18, 255,198,30,255, 0,255,255,255,255);
end



function OnRootMouseButtonUp(args)
	winMgr:getWindow("DropDownContainer"):setVisible(false)
end



-- ���� ĳ���� ���� ���� �̹��� �����츦 ���´�.
function GetEachBaseBackName()
	return Shop_CharacterBack
end




mywindow = winMgr:createWindow("TaharezLook/Button", "ShopRefreshCashBtn")
mywindow:setTexture("Normal", "UIData/my_room.tga", 1006, 0)
mywindow:setTexture("Hover", "UIData/my_room.tga", 1006, 18)
mywindow:setTexture("Pushed", "UIData/my_room.tga", 1006, 36)
mywindow:setTexture("PushedOff", "UIData/my_room.tga", 1006, 36)
mywindow:setPosition(972, 547)
mywindow:setSize(18, 18)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:subscribeEvent("Clicked", "RefreshCashBtnClick")
winMgr:getWindow("Shop_AllBackImg"):addChildWindow(mywindow)



function RefreshCashBtnClick()
	RefreshCash()
	LOG("uuuuuuuuuuuuuuuuuuuuuu")
	LOG("ttttttttttt"..tostring(96/100))
end