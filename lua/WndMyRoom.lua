--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------

local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local Realroot	= winMgr:getWindow("DefaultWindow")
local drawer	= Realroot:getDrawer()
guiSystem:setGUISheet(Realroot)
Realroot:activate()

--------------------------------------------------------------------
-- 마이룸 와이드용 백판
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

root:setUserString("MyRoom_TotalPage", tostring(1))
root:setUserString("MyRoom_CurrentPage", tostring(1))

-- 현재 마이룸인지 샵인지.
CurrentPos = 1

-- 하단 메뉴
--
--winMgr:getWindow('BPM_MyItemMovebtn'):setVisible(false)
--winMgr:getWindow('BPM_MyItemMovebtn2'):setVisible(true)

--------------------------------------------------------------------
-- 채널 정보 백판 붙이기
--------------------------------------------------------------------
root:addChildWindow(winMgr:getWindow('ChannelPositionBG'));
winMgr:getWindow('ChannelPositionBG'):setWideType(0);
winMgr:getWindow('ChannelPositionBG'):setPosition(800, 2);
winMgr:getWindow('NewMoveServerBtn'):setVisible(true)
winMgr:getWindow('NewMoveExitBtn'):setVisible(false)
ChangeChannelPosition('MyRoom')

--------------------------------------------------------------------
-- 문자열에 대한 정보 받아온다
--------------------------------------------------------------------
MR_String_1		= PreCreateString_1841		--GetSStringInfo(LAN_LUA_MYROOM_1)		-- 상의
MR_String_2		= PreCreateString_1842		--GetSStringInfo(LAN_LUA_MYROOM_2)		-- 하의
MR_String_3		= PreCreateString_1843		--GetSStringInfo(LAN_LUA_MYROOM_3)		-- 장갑
MR_String_4		= PreCreateString_1844		--GetSStringInfo(LAN_LUA_MYROOM_4)		-- 신발
MR_String_5		= PreCreateString_1845		--GetSStringInfo(LAN_LUA_MYROOM_5)		-- 얼굴
MR_String_6		= PreCreateString_1846		--GetSStringInfo(LAN_LUA_MYROOM_6)		-- 헤어
MR_String_7		= PreCreateString_1847		--GetSStringInfo(LAN_LUA_MYROOM_7)		-- 등
MR_String_8		= PreCreateString_1848		--GetSStringInfo(LAN_LUA_MYROOM_8)		-- 장식
MR_String_9		= PreCreateString_1849		--GetSStringInfo(LAN_LUA_MYROOM_9)		-- 반지
MR_String_10		= PreCreateString_1850		--GetSStringInfo(LAN_LUA_MYROOM_10)		-- 세트
MR_String_11		= PreCreateString_1852		--GetSStringInfo(LAN_LUA_MYROOM_11)		-- 코스튬 종류
MR_String_12		= PreCreateString_1853		--GetSStringInfo(LAN_LUA_MYROOM_12)		-- 기간
MR_String_13		= PreCreateString_1195		--GetSStringInfo(LAN_LUA_WND_MYINFO_3)	-- 기간이 만료된 아이템입니다.
MR_String_14		= PreCreateString_1226		--GetSStringInfo(LAN_LUA_WND_MY_ITEM_1)	-- 착용할 수 없는 아이템입니다
MR_String_15		= PreCreateString_1228		--GetSStringInfo(LAN_LUA_WND_MY_ITEM_3)	-- 아이템을 삭제하시겠습니까?

MR_String_16		= PreCreateString_1122		--GetSStringInfo(LAN_LUA_SHOP_COMMON_3)	-- 타격공격
MR_String_18		= PreCreateString_1124		--GetSStringInfo(LAN_LUA_SHOP_COMMON_5)	-- 크리티컬
MR_String_19		= PreCreateString_1125		--GetSStringInfo(LAN_LUA_SHOP_COMMON_6)	-- 타격방어
MR_String_20		= PreCreateString_1126		--GetSStringInfo(LAN_LUA_SHOP_COMMON_7)	-- 잡기방어
MR_String_21		= PreCreateString_1822		--GetSStringInfo(LAN_LUA_WND_MY_ITEM_5)	-- 타격
MR_String_22		= PreCreateString_1823		--GetSStringInfo(LAN_LUA_WND_MY_ITEM_6)	-- 잡기
MR_String_23		= PreCreateString_1138		--GetSStringInfo(LAN_LUA_WND_COMMON_SHOP_2)	-- 레벨
MR_String_24		= PreCreateString_1229		--GetSStringInfo(LAN_LUA_WND_MY_ITEM_4)	-- 기본


MR_String_25		= PreCreateString_1237		--GetSStringInfo(LAN_LUA_WND_MY_SKILL_8)	-- 일반타격
MR_String_26		= PreCreateString_1238		--GetSStringInfo(LAN_LUA_WND_MY_SKILL_9)	-- 상단타격
MR_String_27		= PreCreateString_1239		--GetSStringInfo(LAN_LUA_WND_MY_SKILL_10)	-- 중단타격
MR_String_28		= PreCreateString_1240		--GetSStringInfo(LAN_LUA_WND_MY_SKILL_11)	-- 하단타격
MR_String_29		= PreCreateString_1242		--GetSStringInfo(LAN_LUA_WND_MY_SKILL_13)	-- 대쉬타격
MR_String_30		= PreCreateString_1244		--GetSStringInfo(LAN_LUA_WND_MY_SKILL_15)	-- 다이빙타격
MR_String_31		= PreCreateString_1243		--GetSStringInfo(LAN_LUA_WND_MY_SKILL_14)	-- 슬라이딩

MR_String_32		= PreCreateString_1245		--GetSStringInfo(LAN_LUA_WND_MY_SKILL_16)	-- 상단잡기
MR_String_33		= PreCreateString_1246		--GetSStringInfo(LAN_LUA_WND_MY_SKILL_17)	-- 중단잡기
MR_String_34		= PreCreateString_1247		--GetSStringInfo(LAN_LUA_WND_MY_SKILL_18)	-- 하단잡기
MR_String_35		= PreCreateString_1241		--GetSStringInfo(LAN_LUA_WND_MY_SKILL_12)	-- 다이빙잡기
MR_String_36		= PreCreateString_1248		--GetSStringInfo(LAN_LUA_WND_MY_SKILL_19)	-- 누워잡기
MR_String_37		= PreCreateString_1249		--GetSStringInfo(LAN_LUA_WND_MY_SKILL_20)	-- 엎드려잡기
MR_String_38		= PreCreateString_1907		--GetSStringInfo(LAN_LUA_WND_MY_SKILL_40)	-- 대쉬잡기			====

MR_String_39		= PreCreateString_1250		--GetSStringInfo(LAN_LUA_WND_MY_SKILL_21)	-- 일반필살기
MR_String_40		= PreCreateString_1251		--GetSStringInfo(LAN_LUA_WND_MY_SKILL_22)	-- 다운필살기
MR_String_41		= PreCreateString_1252		--GetSStringInfo(LAN_LUA_WND_MY_SKILL_23)	-- 콤보필살기
MR_String_42		= PreCreateString_1253		--GetSStringInfo(LAN_LUA_WND_MY_SKILL_24)	-- 초필살기

MR_String_43		= PreCreateString_1254		--GetSStringInfo(LAN_LUA_WND_MY_SKILL_25)	-- 더블어택
MR_String_44		= PreCreateString_1255		--GetSStringInfo(LAN_LUA_WND_MY_SKILL_26)	-- 팀어택

MR_String_45		= PreCreateString_1257		--GetSStringInfo(LAN_LUA_WND_MY_SKILL_28)	-- 상중단반격기
MR_String_46		= PreCreateString_1258		--GetSStringInfo(LAN_LUA_WND_MY_SKILL_29)	-- 하단반격기
MR_String_47		= PreCreateString_1260		--GetSStringInfo(LAN_LUA_WND_MY_SKILL_31)	-- 대쉬중
MR_String_48		= PreCreateString_1261		--GetSStringInfo(LAN_LUA_WND_MY_SKILL_32)	-- 다이빙중
MR_String_49		= PreCreateString_1262		--GetSStringInfo(LAN_LUA_WND_MY_SKILL_33)	-- 누운상대
MR_String_50		= PreCreateString_1263		--GetSStringInfo(LAN_LUA_WND_MY_SKILL_34)	-- 엎드린상대
MR_String_51		= PreCreateString_1264		--GetSStringInfo(LAN_LUA_WND_MY_SKILL_35)	-- 서있을때
MR_String_52		= PreCreateString_1906		--GetSStringInfo(LAN_LUA_WND_MY_SKILL_39)	-- 누워있을때
MR_String_53		= PreCreateString_1265		--GetSStringInfo(LAN_LUA_WND_MY_SKILL_36)	-- 2명 가까이서
MR_String_54		= PreCreateString_1266		--GetSStringInfo(LAN_LUA_WND_MY_SKILL_37)	-- 팀어택 표시가\n뜬 아군에 접근
MR_String_55		= PreCreateString_1267		--GetSStringInfo(LAN_LUA_WND_MY_SKILL_38)	-- 공격에 맞춰

MR_String_56		= PreCreateString_2008		--GetSStringInfo(LAN_REGISTER_STRENGTHEN_SKILL)	-- 강화시킬 스킬을 등록하세요
MR_String_57		= PreCreateString_2009		--GetSStringInfo(LAN_REGISTER_TICKET)		-- 스킬강화권을 등록하세요 
MR_String_58		= PreCreateString_2010		--GetSStringInfo(LAN_UPGRADE_SKILL_DESC)	-- +2 이상의 강화에서는 실패하면 강화등급이 한단계 떨어집니다 
MR_String_59		= PreCreateString_2011		--GetSStringInfo(LAN_SUCCESS_UPGRADE_SKILL)	-- 강화 성공시 스킬 변화 
MR_String_61		= PreCreateString_2012		--GetSStringInfo(LAN_UPGRADE_SKILL_FEE)		-- 강화수수료
MR_String_62		= PreCreateString_2013		--GetSStringInfo(LAN_UPGRADE_SKILL_SUCCESS)	-- 강화가 성공하였습니다 
MR_String_63		= PreCreateString_2014		--GetSStringInfo(LAN_UPGRADE_SKILL_FAIL)	-- 강화가 실패하였습니다 
MR_String_64		= PreCreateString_2015		--GetSStringInfo(LAN_SKILL_GRADE_NOCHANGE)	-- 스킬 등급에 아무런 변화가 없습니다
MR_String_65		= PreCreateString_2016		--GetSStringInfo(LAN_SKILL_GRADE_UP)		-- 스킬 등급이 한단계 상승하였습니다 
MR_String_66		= PreCreateString_2017		--GetSStringInfo(LAN_SKILL_GRADE_DOWN )		-- 스킬 등급이 한단계 떨어졌습니다 
MR_String_67		= PreCreateString_2040		--GetSStringInfo(LAN_CAN_NOT_UPGRADE_HOTFIX)	-- 핫픽스가 부족하여 핫픽스 업그레이드가 불가능합니다 
MR_String_68		= PreCreateString_2048		--GetSStringInfo(LAN_UPGRADE_HOTFIX_DOUBLECLICK)	-- 업그레이드 하려는 5개 이상의 핫픽스를 더블클릭하세요.
MR_String_69		= PreCreateString_2054		--GetSStringInfo(LAN_SELECT_HOTFIX_FOR_UPGRADE)		-- 리폼하려는 코스튬을 더블클릭하세요 
MR_String_70		= PreCreateString_2079		--GetSStringInfo(LAN_DOUBLECLICK_REFORM_HOTFIX)		-- 리폼하려는 핫픽스를 더블클릭하세요  
MR_String_71		= PreCreateString_2080		--GetSStringInfo(LAN_ENABLE_REFORM_COUNT)			-- 리폼 가능횟수
MR_String_72		= AdjustString(g_STRING_FONT_GULIM, 14, PreCreateString_2114, 126)	-- GetSStringInfo(LAN_COMPLETE_COSTUM_REFORM)	코스튬 리폼이 완료되었습니다.
MR_String_73		= PreCreateString_2117		--GetSStringInfo(LAN_COSTUM_REFORM_WARNING)			-- 리폼 가능횟수
MR_String_74		= PreCreateString_2118		--GetSStringInfo(LAN_HOTFIX_REGIST_SELECT)
MR_String_75		= PreCreateString_2139		--GetSStringInfo(LAN_CAN_NOT_REFORM)		-- 리폼불가
MR_String_76		= PreCreateString_2142		--GetSStringInfo(LAN_USE_TRANSFORM_WARNING)		-- 리폼불가
MR_String_77		= PreCreateString_2153		--GetSStringInfo(LAN_USE_KORATE_REASET)			-- KO
MR_String_78		= PreCreateString_2155		--GetSStringInfo(LAN_ADD_SKILL_DAMAGE)			-- 추가 스킬데미지 
MR_String_79		= PreCreateString_2147		--GetSStringInfo(LAN_LUA_USE_ITEM)				-- 아이템을 사용하시겠습니까?
MR_String_80		= PreCreateString_7			--GetSStringInfo(LAN_CLUB_NOT_ACCEPT_EMBLEM)	-- 엠블렘을 등록해주세요
MR_String_81		= PreCreateString_2319		--GetSStringInfo(LAN_INCREASE_CLUB_MAX_MEMBER)	-- 클럽의 최대인원이 %d명으로 증가되었습니다
MR_String_82		= PreCreateString_2055		--GetSStringInfo(LAN_PURCHASE_SKILL_FAIL)		-- 스킬트리 확인
MR_String_83		= PreCreateString_1273		--GetSStringInfo(LAN_LUA_WND_POPUP_2)			-- 준비중입니다.
MR_String_84		= PreCreateString_2521		--GetSStringInfo(LAN_WANT_TO_RESET_CLASS)		-- 클래스를 초기화 하시겠습니까?
MR_String_85		= PreCreateString_2523		--GetSStringInfo(LAN_CAN_NOT_RESET_CLASS)		-- 클래스를 초기화 하시겠습니까?
MR_String_86		= PreCreateString_2641		--GetSStringInfo(LAN_INVEN_FULL_SAVING_MAILBOX) -- 인벤토리가 가득차면 메일함에 저장됩니다
MR_String_87		= PreCreateString_2689		--GetSStringInfo(LAN_CHARACTER_SKIN_CHANGE) -- 캐릭터 스킨을 변경하시겠습니까?



local tStatNameText = {['protecterr']=0, PreCreateString_1122, PreCreateString_1123, PreCreateString_1124, 
									"HP", "SP", PreCreateString_1125, PreCreateString_1126, PreCreateString_2646 ,PreCreateString_2648 , 
									PreCreateString_2650, PreCreateString_2647,PreCreateString_2649, PreCreateString_2651 , PreCreateString_2652}
									
local nStreetSkillNum = {["protecterr"] = 0,
[0] = 
-- 타격
800000,--0
800001,--1
800002,--2
800003,--3
800004,--4
800005,--5
800006,--6
800007,--7
800034,--8
800036,--9
800035,--10

--잡기
801009,--11
801010,--12
801012,--13
801013,--14
801015,--15
801016,--16
801037,--17
0,--18
801026,--19
801027,--20
801028,--21
801029,--22
801030,--23
801031,--24
801032,--25
801033,--26
--0,--800035,--27

--필살기
802046,--28
802047,--29
802048,--30
802049,--31

--팀더블
803039,--32
803041,--33
803042,--34
803043,--35

-- 기타
804060,--36
804061 --37
}



local nRushSkillNum = {['protecterr'] = 0,
[0] = 
-- 타격
900000,--0
900001,--1
900002,--2
900003,--3
900004,--4
900005,--5
900006,--6
900007,--7
900034,--8
900036,--9
900035,--10

--잡기
901009,--11
901010,--12
901012,--13
901013,--14
901015,--15
901016,--16
901037,--17
0,--18
901026,--19
901027,--20
901028,--21
901029,--22
901030,--23
901031,--24
901032,--25
901033,--26
--0,--900035,--27

--필살기
902046,--28
902047,--29
902048,--30
902049,--31

--팀더블
903039,--32
903041,--33
903042,--34
903043,--35
-- 기타
904060,--36
904061 --37
}

--------------------------------------------------------------------
-- 전역으로 쓸 변수
--------------------------------------------------------------------
----- 현재 선택된 카테고리를 설정해주는 변수-----
TAB_CHARACTER		= 1
TAB_MY_SKILL		= 2
TAB_HOTFIX			= 3
TAB_UPGRADE_SKILL	= 4
g_SelectedMainTab	= TAB_CHARACTER

g_CostumeType	= -10
g_Attach		= -10
g_IsImpossible	= -10
-------------------------------------------------

local	mywindow							-- 기본 디폴트 윈도우
local	bCharacterInfoShow		= true		-- 캐릭터 정보 버튼이 뉼려졌는지.
local	bRankInfoShow			= false		-- 랭킹정보 버튼이 눌려졌는지.
local	bStatInfoShow			= true		-- 능력치 정보가 눌려졌는지.
local	bEffectInfoShow			= false		-- 특수효과 정보가 눌려졌는지.
local	PAGE_MAXITEM			= 8			-- 한페이지에 들어가는 아이템 갯수.
local	PAGE_MAXSKILLTAB		= 8			-- 한페이지에 내스킬관련 종류 갯수
local	MAX_COSTUM				= 10		-- 착용중인 코스튬에대한 최대갯수
local	bCharacterInfoReceive	= false		-- 캐릭터 정보를 받아왔는지 확인
local	bItemInfoReceive		= false		-- 아이템 정보를 받아왔는지 확인
local	bDoubleClickUpgrade		= false		-- 강화 상태에서 아이템을 더블클릭했는지 버튼을 눌렀는지 확인
local	TransformString			= ""		-- 입고있는 변신아이템의 스트링

--"상의", "하의", "장갑", "신발", "얼굴", "헤어", "등", "장식", "반지"}
local	tCostumKind = {['protecterr'] = 0, PreCreateString_1841, MR_String_2, MR_String_3, MR_String_4, MR_String_5,
													MR_String_6, MR_String_7, MR_String_8, MR_String_9, MR_String_10}

local	tWearCostumIndex	= {['protecterr'] = 0, 2, 7, 3, 8, 6, 1, 5, 10, 9, 4 }		-- 착용중인 코스튬에 담겨진 인덱스
local	tSubFirstIcon_Name	= {['protecterr'] = 0, "MyRoom_CostumBtn_All", "MyRoom_SkillBtn_All", "MyRoom_EtcBtn_All", "", "MyRoom_CostumBtn_All"}

-- 스킬 갯수에대한 테이블
local	tSkillCountTable	= {["protecterr"] = 0, {["protecterr"] = 0, }, {["protecterr"] = 0, }, 
									{["protecterr"] = 0, }, {["protecterr"] = 0, }, {["protecterr"] = 0, }}
local	tBaseSkillTable		= {["protecterr"] = 0, }		-- 기본스킬에대한 테이블

local	MyStatTable			= {['protecterr'] = 0, }	-- 내 스텟정보들이 담겨질 테이블
MyStatTable[1]	= {['protecterr'] = 0, }
MyStatTable[2]	= {['protecterr'] = 0, }
MyStatTable[3]	= {['protecterr'] = 0, }
MyStatTable[4]	= {['protecterr'] = 0, }
MyStatTable[5]	= {['protecterr'] = 0, }
MyStatTable[6]	= {['protecterr'] = 0, }
MyStatTable[7]	= {['protecterr'] = 0, }


local	SkillUpGradeIndexTable	= {['protecterr'] = 0, -1, -1}

local	SKILL_UP_CURRENT_SKILL	= 1
local	SKILL_UP_TICKET			= 2

local	SkillUpGradeFee			= 0
local	SkillUpGradeFeeBuf		= 0
local	SkillUpGradeEventTick	= 0


-- 이름, 파일이름, 스킬종류 스트링, 만료날짜, 프로모션 인덱스, 스킬 등급, 아이템 리스트 인덱스
local	SkillUpGradeInfoTable1		= {['protecterr'] = 0, "", "", "", "", -1, -1, -1, -1, 0, ""}
local	SkillUpGradeInfoTable2		= {['protecterr'] = 0, "", "", "", "", -1, -1, -1, -1, 0, ""}
local	SkillUpGradeInfoTableList	= {['protecterr'] = 0, }
SkillUpGradeInfoTableList[SKILL_UP_CURRENT_SKILL]	= SkillUpGradeInfoTable1
SkillUpGradeInfoTableList[SKILL_UP_TICKET]			= SkillUpGradeInfoTable2


local tSkillUpResult	= {['err'] = 0, -1, "", "", -1, "", "", -1, -1, false, ""}		-- 스킬 업그레이드 결과에 나오는 

local tUpSuccessString	= {['err'] = 0, MR_String_62, MR_String_65}		-- 스킬강화 성공 스트링 테이블
local tUpFailDownString	= {['err'] = 0, MR_String_63, MR_String_66}		-- 스킬강화 실패 등급다운 스트링 테이블
local tUpFailNonString	= {['err'] = 0, MR_String_63, MR_String_64}		-- 스킬강화 실패 등급변화 없음 스트링 테이블

local tGradeChangeStringTable	= {['err'] = 0, tUpFailDownString, tUpFailNonString, tUpSuccessString }

local	tEffectTexX		= {['err'] = 0, [0] = 609, 673, 737, 801, 865, 929}
local	tEffectTexX2	= {['err'] = 0, [0] = 929, 865, 801, 737, 673, 609}
local	tEffectAngle	= {['err'] = 0, [0] = 0, 340, 680, 1020, 1360, 1700 }	-- 핫픽스 업그레이드 이펙트위해 각도를 돌려준다.
local	tEffectScale	= {['err'] = 0, 450, 450, 255}
local	SkillAniTick	= 0

-- 라인을 따라가는 별모양 애니메이션 의한 변수 테이블
local	MAXPOINT		= 4
local	tArriveTable	= {['err'] = 0, false, false, false, false}		-- 마지막 도착하는 위치부터 넣어준다.
local	tPointPosTable	= {['err'] = 0, {['err'] = 0, }, {['err'] = 0, }, {['err'] = 0, }, {['err'] = 0, }}
local	tCurrentPointPos	= {['err'] = 0, {['err'] = 0, }, {['err'] = 0, }}		-- 스킬강화 별모양 애니메이션 현재 위치

--tGradeferPersent	= {['err'] = 0, 1,2,3,5,7,9,14,20,27,35}	-- 스킬 그레이드에따른 추가데미지 테이블


-- 마지막 위치
tPointPosTable[1][1]	= 211
tPointPosTable[1][2]	= 296
tPointPosTable[1][3]	= 211
tPointPosTable[1][4]	= 296
-- 세번째 위치
tPointPosTable[2][1]	= 211
tPointPosTable[2][2]	= 190
tPointPosTable[2][3]	= 211
tPointPosTable[2][4]	= 190
-- 두번째 위치
tPointPosTable[3][1]	= 99
tPointPosTable[3][2]	= 190
tPointPosTable[3][3]	= 321
tPointPosTable[3][4]	= 190
-- 첫번째 위치
tPointPosTable[4][1]	= 99
tPointPosTable[4][2]	= 180
tPointPosTable[4][3]	= 321
tPointPosTable[4][4]	= 180


tCurrentPointPos[1][1]		= 99
tCurrentPointPos[1][2]		= 180
tCurrentPointPos[2][1]		= 321
tCurrentPointPos[2][2]		= 180

local	NONE	= 0
local	STAR	= 1
local	BOOM	= 2
local	SkillAniKind	= NONE





HitfixItemNumber	= -1;
HitfixItemIndex		= -1;


local tHotFixUpgradeInfo	= {['err'] = 0, "", 0, 0, ""}	-- 핫픽스 업그레이드할 정보(파일이름, 남은 갯수)가 담긴다.
local Max_HotUpgradeCount	= 5	
local tHotFixImgAngle		= {['err'] = 0, [0] = 0, 500, 1000, 1500 }	-- 핫픽스 업그레이드 이펙트위해 각도를 돌려준다.

local tHotFixPos1		= {['err'] = 0, 63	, 326, false, 0, true}	-- x좌표, y좌표, 이동중인놈인지. 몇번째 지점인지, 보여주는놈인지
local tHotFixPos2		= {['err'] = 0, 154	, 326, false, 0, true}
local tHotFixPos3		= {['err'] = 0, 245	, 326, false, 0, true}
local tHotFixPos4		= {['err'] = 0, 336	, 326, false, 0, true}
local tHotFixPos5		= {['err'] = 0, 427	, 326, false, 0, true}

local tHotFixEndPos		= {['err'] = 0, 245	, 402}

local tHotFixPosTable	= {['err'] = 0, tHotFixPos1, tHotFixPos2, tHotFixPos3, tHotFixPos4, tHotFixPos5 }
local HotFixUpButtonOK	= false
local HotfixUpCount			= 0
local HotfixScale			= 150

local REFORM_COSTUM		= 1
local REFORM_HOTFIX		= 2
local REFORM_ATTACH		= 3
-- 이름, 파일이름, 어태치값, 아이템 리스트인덱스, 스텟 7개
local	CostumReformInfoTable1		= {['err'] = 0, "", "", -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1}
local	CostumReformInfoTable2		= {['err'] = 0, "", "", -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1}
local	CostumReformList	= {['err'] = 0, {['err'] = 0, }, {['err'] = 0, }}
local	CostumHotfixStat		= {['err'] = 0, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1}   -- 14개

-- From Jiyuu
local	HotfixNumber = 0

CostumReformList[REFORM_COSTUM]		= CostumReformInfoTable1
CostumReformList[REFORM_HOTFIX]		= CostumReformInfoTable2

COSTUM_UPPER	= 1
COSTUM_LOWER	= 2
COSTUM_HAND		= 4
COSTUM_FOOT		= 8
COSTUM_FACE		= 16
COSTUM_HAIR		= 32
COSTUM_BACK		= 64
COSTUM_HAT		= 128
COSTUM_RING		= 256
local tCostumAttach			= {['err'] = 0, false, false, false, false, false, false, false, false, false }		-- 리폼할 코스튬 어태치를 확인해준다
local tCostumAttachTable	= {['err'] = 0, COSTUM_UPPER, COSTUM_LOWER, COSTUM_HAND, COSTUM_FOOT, COSTUM_FACE, COSTUM_HAIR, COSTUM_BACK, COSTUM_HAT, COSTUM_RING }		-- 리폼할 코스튬 어태치를 확인해준다


local tCostumReformInfoTable	= {['err'] = 0, -1,-1,-1}		-- 서버로 넘겨줄 코스튬 리폼에 관련된 정보를 얻어온다.
--"상의", "하의", "장갑", "신발", "얼굴", "헤어", "등", "장식", "반지"}


-- 레벨, 아이템 이름, 이미지경로, 코스튬 종류, 기간,
local tCostumReformResultInfo	= {['err'] = 0, -1, "", "", -1, ""}			-- 코스튬 업그레이드 결과에 나오는 정보
local tCostumReformResultStat	= {['err'] = 0, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1}	-- 코스튬 업그레이드 결과에 나오는 스텟

local	MyinfoTable			= {['protecterr'] = 0, }	-- 내 기본정보들이 담겨질 테이블

local	tMyRank		= {['protecterr'] = 0, }
local	tMyRecord	= {['protecterr'] = 0, }

RECORD_TOTAL_EXP			= 1
RECORD_LADDER_EXP			= 2
RECORD_TOTAL_KO				= 3
RECORD_MVP					= 4
RECORD_TEAM					= 5
RECORD_DOUBLE				= 6
RECORD_PRIVATE_PLAYCOUNT	= 7
RECORD_PUBLIC_PLAYCOUNT		= 8
RECORD_KO_RATE				= 9
RECORD_PERFECT				= 10		-- perfect
RECORD_CONSECUTIVE_WIN		= 11		-- 연승
RECORD_CONSECUTIVE_WIN_BREAK= 12		-- 연승격파
	
RANK_TOTAL_EXP				= 1
RANK_LADDER					= 2
RANK_KO						= 3
RANK_MVP					= 4
RANK_TEAM_ATTACK			= 5
RANK_DOUBLE_ATTACK			= 6
RANK_PERFECT				= 7		-- perfect
RANK_CONSECUTIVE_WIN		= 8		-- 연승
RANK_CONSECUTIVE_WIN_BREAK	= 9		-- 연승격파


local	Mystyle = GetMyCharacterStyle()		-- 내 스타일

if Mystyle == "chr_strike" then
	tBaseSkillTable = nStreetSkillNum
else
	tBaseSkillTable = nRushSkillNum
end

										
-- 스킬 갯수
-- 타격
tSkillCountTable[1][1] = 2
tSkillCountTable[1][2] = 2
tSkillCountTable[1][3] = 2
tSkillCountTable[1][4] = 2
tSkillCountTable[1][5] = 1
tSkillCountTable[1][6] = 1
tSkillCountTable[1][7] = 1

-- 잡기
tSkillCountTable[2][1] = 2
tSkillCountTable[2][2] = 2
tSkillCountTable[2][3] = 2
tSkillCountTable[2][4] = 2
tSkillCountTable[2][5] = 4
tSkillCountTable[2][6] = 4
--tSkillCountTable[2][7] = 1

--필살기
tSkillCountTable[3][1] = 1
tSkillCountTable[3][2] = 1
tSkillCountTable[3][3] = 1
tSkillCountTable[3][4] = 1

-- 팀더블
tSkillCountTable[4][1] = 2
tSkillCountTable[4][2] = 2

-- 기타
tSkillCountTable[5][1] = 1
tSkillCountTable[5][2] = 1


local MegaphoneMsg = ""



--------------------------------------------------------------------

-- 마이름에 들어가는 윈도우들

--------------------------------------------------------------------
--------------------------------------------------------------------
-- 마이룸 타이틀
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyRoom_Title")
mywindow:setTexture("Enabled", "UIData/mainBG_Button001.tga", 0, 394)
mywindow:setTexture("Disabled", "UIData/mainBG_Button001.tga", 0, 394)
mywindow:setPosition(30, 20)
mywindow:setSize(281, 46)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

--------------------------------------------------------------------
-- 마이룸 관련 전체 윈도우 뒷판.
--------------------------------------------------------------------
Myroom_Mainwindow = winMgr:createWindow("TaharezLook/StaticImage", "MyRoom_AllBackImg")
Myroom_Mainwindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
Myroom_Mainwindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
Myroom_Mainwindow:setPosition(0, 50)
Myroom_Mainwindow:setSize(1024, 614)
Myroom_Mainwindow:setVisible(true)
Myroom_Mainwindow:setAlwaysOnTop(true)
Myroom_Mainwindow:setZOrderingEnabled(false)
root:addChildWindow(Myroom_Mainwindow)

--------------------------------------------------------------------
-- 마이룸 관련 케릭터, 스킬 라디오버튼.
--------------------------------------------------------------------
tMyRoomBtn_Name	= {['protecterr']=0, "MyRoom_Character", "MyRoom_Skill", "MyRoom_Hotfix", "MyRoom_SkillUpgrade" }
tMyRoomBtn_TexY	= {['protecterr']=0, 		780,				885,			510,				510}
tMyRoomBtn_TexX	= {['protecterr']=0, 		223,				223,			924,				824}
tMyRoomBtn_PosX	= {['protecterr']=0, 		16,					120,			224,				328}
tMyRoomBtn_Event	= {['protecterr']=0, "MyRoom_CharacterShow", "MyRoom_SkillShow",  "MyRoom_HotfixShow", "MyRoom_SkillUpgradeShow"}

--tMyRoomBtn_Name	= {['protecterr']=0, "MyRoom_Character", "MyRoom_Skill", "MyRoom_Hotfix" }
--tMyRoomBtn_TexY	= {['protecterr']=0, 		780,				885,			510}
--tMyRoomBtn_TexX	= {['protecterr']=0, 		223,				223,			924}
--tMyRoomBtn_PosX	= {['protecterr']=0, 		16,					120,			224}
--tMyRoomBtn_Event	= {['protecterr']=0, "MyRoom_CharacterShow", "MyRoom_SkillShow",  "MyRoom_HotfixShow"}

for i = 1, #tMyRoomBtn_Name do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tMyRoomBtn_Name[i])
	mywindow:setTexture("Normal", "UIData/my_room.tga", tMyRoomBtn_TexX[i], tMyRoomBtn_TexY[i])
	mywindow:setTexture("Hover", "UIData/my_room.tga", tMyRoomBtn_TexX[i], tMyRoomBtn_TexY[i] + 35)
	mywindow:setTexture("Pushed", "UIData/my_room.tga", tMyRoomBtn_TexX[i], tMyRoomBtn_TexY[i] + 70)
	mywindow:setTexture("SelectedNormal", "UIData/my_room.tga", tMyRoomBtn_TexX[i], tMyRoomBtn_TexY[i] + 70)
	mywindow:setTexture("SelectedHover", "UIData/my_room.tga", tMyRoomBtn_TexX[i], tMyRoomBtn_TexY[i] + 70)
	mywindow:setTexture("SelectedPushed", "UIData/my_room.tga", tMyRoomBtn_TexX[i], tMyRoomBtn_TexY[i] + 70)	
	mywindow:setTexture("Disabled", "UIData/my_room.tga", tMyRoomBtn_TexX[i], tMyRoomBtn_TexY[i] + 105)	
	mywindow:setPosition(tMyRoomBtn_PosX[i], 25)
	mywindow:setProperty("GroupID", 21)	--??
	mywindow:setSize(100, 35)
--	if i >= 3 then
--		mywindow:setVisible(false)
--	else
		mywindow:setVisible(true)
--	end	
	mywindow:setZOrderingEnabled(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:subscribeEvent("SelectStateChanged", tMyRoomBtn_Event[i])
	if i == 1 then
		mywindow:setProperty("Selected", "true")
	end
	Myroom_Mainwindow:addChildWindow(mywindow)
end

if CheckfacilityData(FACILITYCODE_ORB_UPGRADE) == 0 then
	winMgr:getWindow("MyRoom_Hotfix"):setVisible(false)
end

if CheckfacilityData(FACILITYCODE_SKILL_UPGRADE) == 0 then
	winMgr:getWindow("MyRoom_SkillUpgrade"):setVisible(false)
end

--------------------------------------------------------------------
-- 마이룸 관련 코스튬, 스킬, 기타, 스페셜 탭
--------------------------------------------------------------------
tMyRoomTabBtn_Name	= {['protecterr']=0, "MyRoom_CostumeTab", "MyRoom_SkillTab", "MyRoom_EtcTab", "MyRoom_SpecialTab", "MyRoom_CashTab" }
tMyRoomBtn_TexX		= {['protecterr']=0, 		429,				496,			563,				630,			764}
tMyRoomBtn_PosX		= {['protecterr']=0, 		517,				587,			657,				727,			797}
-- 위에 사용되는 "MyRoom_CharacterShow", "MyRoom_SkillShow"를 사용하는 이유는 버튼 하나 눌렀을때 같은 이벤트를 내기 위해서

for i = 1, #tMyRoomTabBtn_Name do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tMyRoomTabBtn_Name[i])
	mywindow:setTexture("Normal", "UIData/my_room.tga", tMyRoomBtn_TexX[i], 133)
	mywindow:setTexture("Hover", "UIData/my_room.tga", tMyRoomBtn_TexX[i], 168)
	mywindow:setTexture("Pushed", "UIData/my_room.tga", tMyRoomBtn_TexX[i], 203)
	mywindow:setTexture("SelectedNormal", "UIData/my_room.tga", tMyRoomBtn_TexX[i], 203)
	mywindow:setTexture("SelectedHover", "UIData/my_room.tga", tMyRoomBtn_TexX[i], 203)
	mywindow:setTexture("SelectedPushed", "UIData/my_room.tga", tMyRoomBtn_TexX[i], 203)
	mywindow:setPosition(tMyRoomBtn_PosX[i], 25)
	mywindow:setProperty("GroupID", 24)	--??
	mywindow:setSize(67, 35)
	mywindow:setVisible(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setAlwaysOnTop(false)
	mywindow:subscribeEvent("SelectStateChanged", "MyRoom_TabKindClick")
	if i == 1 then
		--mywindow:setSelected(true)
		CEGUI.toRadioButton(mywindow):setSelected(true)
--		mywindow:setProperty("Selected", "true")
	end
	Myroom_Mainwindow:addChildWindow(mywindow)
end


--------------------------------------------------------------------
-- 마이룸 관련 스킬 윈도우 뒷판.
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyRoom_SkillPossesionBackImg")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 13, 60)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 13, 60)
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(18, 60)
mywindow:setSize(487, 524)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
Myroom_Mainwindow:addChildWindow(mywindow)



--------------------------------------------------------------------
-- 스킬 세부탭 버튼뒷판
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyRoom_SkillDetailTabBack")
mywindow:setTexture("Enabled", "UIData/my_room2.tga", 0, 134)
mywindow:setTexture("Disabled", "UIData/my_room2.tga", 0, 134)
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(6, 6)
mywindow:setSize(475, 67)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("MyRoom_SkillPossesionBackImg"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- 마이룸 관련 스킬 종류 라디오버튼
--------------------------------------------------------------------
tMyRoomSkillKindTabBtn_Name = {["producterr"] = 0, "MyRoom_SkillDetailTab_Strike", "MyRoom_SkillDetailTab_Grab", "MyRoom_SkillDetailTab_Special"
												, "MyRoom_SkillDetailTab_Team", "MyRoom_SkillDetailTab_Etc"}
tMyRoomSkillKindTabBtn_PosX = {["producterr"] = 0, 0, 95, 190, 285, 380 }

for i = 1, #tMyRoomSkillKindTabBtn_Name do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tMyRoomSkillKindTabBtn_Name[i])
	mywindow:setTexture("Normal", "UIData/invisible.tga", 0 + (i - 1) * 95, 0 + 67 * 2)
	mywindow:setTexture("Hover", "UIData/my_room2.tga", 0 + (i - 1) * 95, 0 + 67)
	mywindow:setTexture("Pushed", "UIData/my_room2.tga", 0 + (i - 1) * 95, 0)
	mywindow:setTexture("SelectedNormal", "UIData/my_room2.tga", 0 + (i - 1) * 95, 0)
	mywindow:setTexture("SelectedHover", "UIData/my_room2.tga", 0 + (i - 1) * 95, 0)
	mywindow:setTexture("SelectedPushed", "UIData/my_room2.tga", 0 + (i - 1) * 95, 0)
	mywindow:setPosition(tMyRoomSkillKindTabBtn_PosX[i], 0)
	mywindow:setProperty("GroupID", 28)	
	mywindow:setSize(95, 67)
	mywindow:setVisible(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setUserString("Index", tostring(i))
	mywindow:subscribeEvent("SelectStateChanged", "MyRoom_SkillKindTabClick")
	mywindow:setProperty("Selected", "false")
	winMgr:getWindow("MyRoom_SkillDetailTabBack"):addChildWindow(mywindow)
end



--------------------------------------------------------------------
-- 스킬쪽 Empty이미지(아이템이 있는경우는 다른 이미지)-->토글
--------------------------------------------------------------------
local tStrikeSkillTable			= {["producterr"] = 0, MR_String_25, MR_String_26, MR_String_27, MR_String_28, MR_String_29, MR_String_30, MR_String_31}
local tGrabSkillTable			= {["producterr"] = 0, MR_String_32, MR_String_33, MR_String_34, MR_String_35, MR_String_36, MR_String_37}--, MR_String_38}
local tSpecialSkillTable		= {["producterr"] = 0, MR_String_39, MR_String_40, MR_String_41, MR_String_42}
local tTeamDoubleSkillTable		= {["producterr"] = 0, MR_String_43, MR_String_44}
local tEtcSkillTable			= {["producterr"] = 0, MR_String_45, MR_String_46}

local tAllSkillTree				= {["producterr"] = 0, tStrikeSkillTable, tGrabSkillTable, tSpecialSkillTable, tTeamDoubleSkillTable, tEtcSkillTable }
local SkillCount = 0

for i = 1, #tAllSkillTree do
	for j = 1, #tAllSkillTree[i] do
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyRoom_EmptyOrSkill"..i..j)
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")
		if i == 2 and j == 5 then 
			mywindow:setTexture("Enabled", "UIData/my_room2.tga", 0, 378)
			mywindow:setTexture("Disabled", "UIData/my_room2.tga", 0, 378)
			mywindow:setSize(483, 99)			
		elseif i == 2 and j == 6 then
			mywindow:setTexture("Enabled", "UIData/my_room2.tga", 0, 378)
			mywindow:setTexture("Disabled", "UIData/my_room2.tga", 0, 378)
			mywindow:setSize(483, 99)			
		else
			mywindow:setTexture("Enabled", "UIData/my_room2.tga", 2, 204)
			mywindow:setTexture("Disabled", "UIData/my_room2.tga", 2, 204)
			mywindow:setSize(240, 99)
		end
		--mywindow:setPosition(2 + ((i - 1) % 2) * 243, 80 + ((i - 1) / 2) * 101)
		mywindow:setPosition(0, 0)
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(false)
		mywindow:setZOrderingEnabled(true)
		mywindow:setUserString("ImgIndex", tostring(j))
		mywindow:setUserString("SkillCount", tostring(tSkillCountTable[i][j]))		-- 띄워줄 스킬 갯수
		mywindow:subscribeEvent("EndRender", "PossessionSkillRender")
		winMgr:getWindow("MyRoom_SkillPossesionBackImg"):addChildWindow(mywindow)
		
		-- 안에 들어가는 스킬아이콘의 이미지.
		for k = 1, tSkillCountTable[i][j] do
			mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SkillIcon"..i..j..k)
			mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
			mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
			mywindow:setProperty("FrameEnabled", "false")
			mywindow:setProperty("BackgroundEnabled", "False")
			mywindow:setPosition(98 + (k - 1) * 73, 8)
			mywindow:setSize(100, 100)
			mywindow:setVisible(true)
			mywindow:setAlwaysOnTop(false)
			mywindow:setZOrderingEnabled(true)
			mywindow:subscribeEvent("EndRender", "SkillIconRender")
			mywindow:setUserString("SkillItemNum", tostring(tBaseSkillTable[SkillCount]))		-- 스킬번호
			mywindow:setUserString("SkillItemIndex", tostring(-1))		-- 스킬번호
			mywindow:setUserString("ItemName", "")		-- 아이템이름
			mywindow:setUserString("FileName", "")		-- 파일경로
			mywindow:setUserString("ItemDesc", "")		-- 아이템설명
			mywindow:setUserString("Promotion", tostring(-1))	-- 아이템 직업
			SkillCount = SkillCount + 1		-- 카운트 ++시켜준다.
			winMgr:getWindow("MyRoom_EmptyOrSkill"..i..j):addChildWindow(mywindow)
			
			
			mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SkillIconOver"..i..j..k)
			mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
			mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
			mywindow:setProperty("FrameEnabled", "False")
			mywindow:setProperty("BackgroundEnabled", "False")
			mywindow:setPosition(-5, -5)
			mywindow:setSize(71, 71)
			mywindow:setVisible(true)
			mywindow:setAlwaysOnTop(true)
			mywindow:setZOrderingEnabled(true)
			mywindow:setSubscribeEvent('MouseLeave', 'MyRoom_MiniSkillMouseLeave');
			mywindow:setSubscribeEvent('MouseEnter', 'MyRoom_MiniSkillMouseEnter');
			winMgr:getWindow("SkillIcon"..i..j..k):addChildWindow(mywindow)
			
		end

	end
end



for i = 1, PAGE_MAXSKILLTAB do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyRoom_SkillEmpty"..i)
	mywindow:setTexture("Enabled", "UIData/my_room2.tga", 693, 229)
	mywindow:setTexture("Disabled", "UIData/my_room2.tga", 693, 229)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(2 + ((i - 1) % 2) * 243, 80 + ((i - 1) / 2) * 101)
	mywindow:setSize(240, 99)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(true)
	winMgr:getWindow("MyRoom_SkillPossesionBackImg"):addChildWindow(mywindow)
end





--------------------------------------------------------------------
-- 마이룸 관련 케릭터 윈도우 뒷판.
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyRoom_CharacterBackImg")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 13, 60)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 13, 60)
mywindow:setPosition(18, 60)
mywindow:setSize(487, 524)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
Myroom_Mainwindow:addChildWindow(mywindow)


--------------------------------------------------------------------
-- 마이룸 관련 케릭터 윈도우 렌더텍스처.
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyRoom_CharacterDisplay")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(0, 0)
mywindow:setSize(254, 449)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("MyRoom_CharacterBackImg"):addChildWindow(mywindow)



--------------------------------------------------------------------
-- 마이룸 관련 코스튬탭, 스킬탭, 기타탭, 스페셜탭 메인 윈도우 뒷판.
--------------------------------------------------------------------
local tMainImgName	= {["protecterr"] = 0, "MyRoom_CostumeMainImg", "MyRoom_SKillMainImg", "MyRoom_EtcMainImg", "MyRoom_SpecialMainImg"}

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
	Myroom_Mainwindow:addChildWindow(mywindow)
end


--------------------------------------------------------------------
-- 전체적인 페이지를 관리하는 페이지 버튼
--------------------------------------------------------------------
ButtonName  = { ["protecterr"]=0, "MyRoom_PageLeft", "MyRoom_PageRight"}
ButtonTexX  = { ["protecterr"]=0,	987,	970}
ButtonPosX  = { ["protecterr"]=0,	700,	805}
ButtonEvent = { ["protecterr"]=0,	"MyRoom_PrevBt", "MyRoom_NextBt"}
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
	Myroom_Mainwindow:addChildWindow(mywindow)
end


--------------------------------------------------------------------
-- 페이지 텍스트
--------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticText', 'MyRoom_PageText');
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setPosition(717, 513);
mywindow:setSize(88, 20);
mywindow:setZOrderingEnabled(true)	
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
Myroom_Mainwindow:addChildWindow(mywindow)


--------------------------------------------------------------------
-- 코스튬 하위카테고리 버튼이 들어갈 뒷판(전체적인 비활성 이미지)
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyRoom_CostumButtonBack")
mywindow:setTexture("Enabled", "UIData/my_room.tga", 323, 952)
mywindow:setTexture("Disabled", "UIData/my_room.tga", 323, 952)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(5, 4)
mywindow:setSize(477, 24)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("MyRoom_CostumeMainImg"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- 코스튬 하위카테고리 버튼(전체, 헤어, 얼굴, 상의, 장갑, 하의, 신발, 데코, 세트)
--------------------------------------------------------------------
tMyRoomBtn_Name		= {['protecterr']=0, "MyRoom_CostumBtn_All", "MyRoom_CostumBtn_Hear", "MyRoom_CostumBtn_Face" 
											,"MyRoom_CostumBtn_Upper", "MyRoom_CostumBtn_Hand", "MyRoom_CostumBtn_Lower"
											,"MyRoom_CostumBtn_Foot", "MyRoom_CostumBtn_Deco", "MyRoom_CostumBtn_Set" }
tMyRoomBtn_TexX		= {['protecterr']=0, 	325, 325 + (48 * 1), 325 + (48 * 2), 325 + (48 * 3), 325 + (48 * 4)
											,325 + (48 * 5), 325 + (48 * 6), 325 + (48 * 7), 325 + (48 * 8)}

for i = 1, #tMyRoomBtn_Name do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tMyRoomBtn_Name[i])
	mywindow:setTexture("Normal", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Hover", "UIData/my_room.tga", tMyRoomBtn_TexX[i], 978)
	mywindow:setTexture("Pushed", "UIData/my_room.tga", tMyRoomBtn_TexX[i], 1002)
	mywindow:setTexture("SelectedNormal", "UIData/my_room.tga", tMyRoomBtn_TexX[i], 1002)
	mywindow:setTexture("SelectedHover", "UIData/my_room.tga", tMyRoomBtn_TexX[i], 1002)
	mywindow:setTexture("SelectedPushed", "UIData/my_room.tga", tMyRoomBtn_TexX[i], 1002)	
	mywindow:setPosition(2 + 48 * (i - 1), 2)
	mywindow:setProperty("GroupID", 25)
	mywindow:setSize(48, 20)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:setUserString("CategoryIndex", tostring(i))
	mywindow:subscribeEvent("SelectStateChanged", "MyRoom_SubTabKindClick")
	if i == 1 then
		mywindow:setProperty("Selected", "true")
	end
	winMgr:getWindow("MyRoom_CostumButtonBack"):addChildWindow(mywindow)
end


--------------------------------------------------------------------
-- 스킬 하위카테고리 버튼이 들어갈 뒷판(전체적인 비활성 이미지)
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyRoom_SkillButtonBack")
mywindow:setTexture("Enabled", "UIData/my_room2.tga", 2, 306)
mywindow:setTexture("Disabled", "UIData/my_room.tga", 2, 306)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(5, 4)
mywindow:setSize(477, 24)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("MyRoom_SKillMainImg"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- 스킬 하위카테고리 버튼(전체, 타격, 잡기, 필살기, 팀더블, 기타)
--------------------------------------------------------------------
tMyRoomBtn_Name		= {['protecterr']=0, "MyRoom_SkillBtn_All", "MyRoom_SkillBtn_Strike", "MyRoom_SkillBtn_Grab" 
											,"MyRoom_SkillBtn_Special", "MyRoom_SkillBtn_TeamDouble", "MyRoom_SkillBtn_Etc"}

tMyRoomBtn_TexX		= {['protecterr']=0, 	4, 52, 100, 148, 196, 244}

for i = 1, #tMyRoomBtn_Name do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tMyRoomBtn_Name[i])
	mywindow:setTexture("Normal", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Hover", "UIData/my_room2.tga", tMyRoomBtn_TexX[i], 330)
	mywindow:setTexture("Pushed", "UIData/my_room2.tga", tMyRoomBtn_TexX[i], 354)
	mywindow:setTexture("SelectedNormal", "UIData/my_room2.tga", tMyRoomBtn_TexX[i], 354)
	mywindow:setTexture("SelectedHover", "UIData/my_room2.tga", tMyRoomBtn_TexX[i], 354)
	mywindow:setTexture("SelectedPushed", "UIData/my_room2.tga", tMyRoomBtn_TexX[i], 354)	
	mywindow:setPosition(2 + 48 * (i - 1), 0)
	mywindow:setProperty("GroupID", 27)
	mywindow:setSize(48, 24)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:setUserString("CategoryIndex", tostring(i))
	mywindow:subscribeEvent("SelectStateChanged", "MyRoom_SubTabKindClick")
	if i == 1 then
		mywindow:setProperty("Selected", "true")
	end
	winMgr:getWindow("MyRoom_SkillButtonBack"):addChildWindow(mywindow)
end




--------------------------------------------------------------------
-- 기타아이템 하위카테고리 버튼이 들어갈 뒷판(전체적인 비활성 이미지)
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyRoom_EtcButtonBack")
mywindow:setTexture("Enabled", "UIData/my_room.tga", 0, 337)
mywindow:setTexture("Disabled", "UIData/my_room.tga", 0, 337)
mywindow:setPosition(5, 4)
mywindow:setSize(477, 24)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("MyRoom_EtcMainImg"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- 기타아이템 하위카테고리 버튼(전체, egg, Up, 변신아이템, 대전, 아케이드, 장식, 기타)
--------------------------------------------------------------------
tMyRoomBtn_Name		= {['protecterr']=0, "MyRoom_EtcBtn_All", "MyRoom_EtcBtn_Egg", "MyRoom_EtcBtn_Up", "MyRoom_EtcBtn_Transform"
											, "MyRoom_EtcBtn_PVP", "MyRoom_EtcBtn_Arcade", "MyRoom_EtcBtn_Deco", "MyRoom_EtcBtn_Etc"}

tMyRoomBtn_TexX		= {['protecterr']=0, 	3, 62, 121, 180, 239, 298, 357, 416}

for i = 1, #tMyRoomBtn_Name do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tMyRoomBtn_Name[i])
	mywindow:setTexture("Normal", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Hover", "UIData/my_room.tga", tMyRoomBtn_TexX[i], 361)
	mywindow:setTexture("Pushed", "UIData/my_room.tga", tMyRoomBtn_TexX[i], 385)
	mywindow:setTexture("SelectedNormal", "UIData/my_room.tga", tMyRoomBtn_TexX[i], 385)
	mywindow:setTexture("SelectedHover", "UIData/my_room.tga", tMyRoomBtn_TexX[i], 385)
	mywindow:setTexture("SelectedPushed", "UIData/my_room.tga", tMyRoomBtn_TexX[i], 385)	
	mywindow:setPosition(3 + 59 * (i - 1), 0)
	mywindow:setProperty("GroupID", 28)
	mywindow:setSize(59, 24)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:setUserString("CategoryIndex", tostring(i))
	mywindow:subscribeEvent("SelectStateChanged", "MyRoom_SubTabKindClick")
	if i == 1 then
		mywindow:setProperty("Selected", "true")
	end
	winMgr:getWindow("MyRoom_EtcButtonBack"):addChildWindow(mywindow)
end


--------------------------------------------------------------------
-- 마이룸 관련 캐릭터 회전버튼
--------------------------------------------------------------------
tMyRoomBtn_Name		= {['protecterr']=0, "MyRoom_CharacterLRotate", "MyRoom_CharacterRRotate" }
tMyRoomBtn_TexX		= {['protecterr']=0, 	484,	535 }
tMyRoomBtn_PosX		= {['protecterr']=0, 	10,		195 }
tMyRoomBtn_Event	= {['protecterr']=0, "MyRoom_CharacterLRotateDownEvent", "MyRoom_CharacterRRotateDownEvent" }
tMyRoomBtn_Event2	= {['protecterr']=0, "MyRoom_CharacterLRotateUpEvent", "MyRoom_CharacterRRotateUpEvent" }

for i = 1, #tMyRoomBtn_Name do
	mywindow = winMgr:createWindow("TaharezLook/Button", tMyRoomBtn_Name[i])
	mywindow:setTexture("Normal",	 "UIData/my_room2.tga", tMyRoomBtn_TexX[i], 306)
	mywindow:setTexture("Hover",	 "UIData/my_room2.tga", tMyRoomBtn_TexX[i], 353)
	mywindow:setTexture("Pushed",	 "UIData/my_room2.tga", tMyRoomBtn_TexX[i], 400)
	mywindow:setTexture("PushedOff", "UIData/my_room2.tga", tMyRoomBtn_TexX[i], 400)
	mywindow:setPosition(tMyRoomBtn_PosX[i], 340)
	mywindow:setSize(51, 47)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:subscribeEvent("MouseButtonDown", tMyRoomBtn_Event[i])
	mywindow:subscribeEvent("MouseButtonUp", tMyRoomBtn_Event2[i])
	winMgr:getWindow("MyRoom_CharacterBackImg"):addChildWindow(mywindow)
end

-- 되돌리기 버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "MyRoom_RevertBtn")
mywindow:setTexture("Normal", "UIData/my_room2.tga", 638, 229)
mywindow:setTexture("Hover", "UIData/my_room2.tga", 638, 247)
mywindow:setTexture("Pushed", "UIData/my_room2.tga", 638, 265)
mywindow:setTexture("PushedOff", "UIData/my_room2.tga", 638, 265)
mywindow:setPosition(196, 413)
mywindow:setSize(55, 18)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:subscribeEvent("Clicked", "MyRoom_RevertBtnEvent")
winMgr:getWindow("MyRoom_CharacterBackImg"):addChildWindow(mywindow)

-- 되돌리기 버튼 이벤트
function MyRoom_RevertBtnEvent()
	ToC_MyRoomWearRevert()	
end


--------------------------------------------------------------------
-- 마이룸 Empty이미지(아이템이 있는경우는 다른 이미지)-->토글
--------------------------------------------------------------------
for i = 1, PAGE_MAXITEM do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyRoom_EmptyOrItem"..i)
	mywindow:setTexture("Enabled", "UIData/my_room.tga", 817, 615)
	mywindow:setTexture("Disabled", "UIData/my_room.tga", 817, 615)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(5 + ((i - 1) % 4) * 120, 31 + ((i - 1) / 4) * 210)
	mywindow:setSize(116, 206)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(true)
	
	winMgr:getWindow("MyRoom_CostumeMainImg"):addChildWindow(mywindow)
end


--------------------------------------------------------------------
-- 마이룸 아이템 라디오버튼
--------------------------------------------------------------------
for i = 1, PAGE_MAXITEM do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", "MyRoom_Item"..i)
	mywindow:setTexture("Normal",			"UIData/invisible.tga", 465, 615)
	mywindow:setTexture("Hover",			"UIData/my_room.tga", 701, 615)
	mywindow:setTexture("Pushed",			"UIData/my_room.tga", 584, 615)
	mywindow:setTexture("SelectedNormal",	"UIData/my_room.tga", 584, 615)
	mywindow:setTexture("SelectedHover",	"UIData/my_room.tga", 584, 615)
	mywindow:setTexture("SelectedPushed",	"UIData/my_room.tga", 584, 615)
	
	mywindow:setPosition(5 + ((i - 1) % 4) * 120, 31 + ((i - 1) / 4) * 210)
	mywindow:setProperty("GroupID", 26)
	mywindow:setSize(116, 206)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	
	mywindow:setUserString('ItemIndex',			tostring(0));		-- 보여주는 아이템의 인덱스
	mywindow:setUserString('ListIndex',			tostring(0));		-- 아이템 리스트의 아이템 인덱스
	mywindow:setUserString('ItemNameFile',		"");				-- 아이템 파일 경로
	mywindow:setUserString('ItemNameFile2',		"");				-- 아이템 파일 경로	
	mywindow:setUserString('RelationproductNo', tostring(0));		-- 프로덕트 넘버
	mywindow:setUserString('ItemNumber',		tostring(0));		-- 아이템 넘버
	mywindow:setUserString('ItemName',			tostring(""));		-- 아이템 이름
	mywindow:setUserString('Locked',			tostring(0));		-- 아이템 가격
	mywindow:setUserString('Level',				tostring(0));		-- 아이템 레벨
	mywindow:setUserString('attach',			tostring(0));		-- 아이템 부위
	mywindow:setUserString('Name2',				tostring(""));		-- 아이템 설명
	mywindow:setUserString('boneType',			tostring(0));		-- 아이템 본타입
	mywindow:setUserString('bWear',				tostring(0));		-- 사용중인 아이템인지
	mywindow:setUserString('bSet',				tostring(0));		-- 세트아이템인지
	mywindow:setUserString('ItemExpireTime',	tostring(""));		-- 아이템 만료날짜
	mywindow:setUserString('ExpiredCheck',		tostring(0));		-- 만료체크
	mywindow:setUserString('CostumeKind',		tostring(0));		-- 코스튬 종류(ex. 상의, 하의)
	mywindow:setUserString('ItemKind',			tostring(0));		-- 아이템 종류
	mywindow:setUserString('TabKind',			tostring(0));		-- 선택한 탭종류(스킬, 아이템, 소비, 강화)
	mywindow:setUserString('Attach',			tostring(0));		-- 붙이는 부위
	mywindow:setUserString('Promotion',			tostring(0));		-- 스킬을 위해 사용해줄 프로모션 인덱스
	mywindow:setUserString('ItemGrade',			tostring(0));		-- 스킬을 위해 사용해줄 스킬 업그레이드 레벨
	mywindow:setUserString('PayType',			tostring(0));		-- 지불수단(인벤토리는 스텟 종류)
	mywindow:setUserString('bUse',				tostring(0));		-- 사용할 수 있는 아이템인지.
	mywindow:setUserString('attribute',			tostring(0));		-- 사용할 수 있는 아이템인지.
	mywindow:setUserString('CostumeType',		tostring(0));		-- 코스튬 아바타 유무
	mywindow:setUserString('Attach',			tostring(0));		-- 코스튬 아바타 어탯치 읽기
	mywindow:setUserString('nRental',			tostring(0));		-- 랜탈 스킬 유무
--	mywindow:setUserString('HotfixStat',		tostring(0));		-- 핫픽스의 경우 스텟
		
	mywindow:setProperty("Selected", "false")
	mywindow:subscribeEvent("StartRender", "MyRoom_ItemRender")
	mywindow:subscribeEvent("SelectStateChanged", "MyRoom_CostumeSelectEvent")
	mywindow:subscribeEvent("MouseDoubleClicked", "MyRoom_ItemDoubleClickEvent");
	mywindow:setSubscribeEvent('MouseLeave', 'MyRoom_ItemMouseLeave');
	mywindow:setSubscribeEvent('MouseEnter', 'MyRoom_ItemMouseEnter');
	winMgr:getWindow("MyRoom_CostumeMainImg"):addChildWindow(mywindow)
	
	-- 아이템
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyRoom_ItemDisable"..i)
	mywindow:setTexture("Enabled", "UIData/my_room2.tga", 846, 3)
	mywindow:setTexture("Disabled", "UIData/my_room2.tga", 846, 3)
	mywindow:setPosition(0, 0)
	mywindow:setSize(110, 206)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("MyRoom_Item"..i):addChildWindow(mywindow)
	
	-- 랜덤 아이템 정보
	mywindow = winMgr:createWindow("TaharezLook/Button", "MyRoom_DetailIInfoBtn"..i)
	mywindow:setTexture("Normal", "UIData/reward_item.tga", 0, 173)
	mywindow:setTexture("Hover", "UIData/reward_item.tga", 0, 193)
	mywindow:setTexture("Pushed", "UIData/reward_item.tga", 0, 213)
	mywindow:setTexture("PushedOff", "UIData/reward_item.tga", 0, 233)
	mywindow:setPosition(87, 120)
	mywindow:setSize(20, 20)
	mywindow:setSubscribeEvent("Clicked", "MyRoom_ShowRandomOpenItem")
	winMgr:getWindow("MyRoom_Item"..i):addChildWindow(mywindow)
	
	
	-- 삭제버튼
	--mywindow = winMgr:createWindow("TaharezLook/Button", "MyRoom_DeleteBtn"..i)
	--mywindow:setTexture("Normal", "UIData/my_room.tga", 378, 852)
	--mywindow:setTexture("Hover", "UIData/my_room.tga", 378, 870)
	--mywindow:setTexture("Pushed", "UIData/my_room.tga", 378, 888)
	--mywindow:setTexture("Disabled", "UIData/my_room.tga", 378, 906)
	--mywindow:setPosition(3, 185 )
	--mywindow:setSize(55, 18)
	--mywindow:setVisible(true)
	--mywindow:setAlwaysOnTop(true)
	--mywindow:setZOrderingEnabled(true)
	--mywindow:subscribeEvent("Clicked", "MyRoom_DeleteBtnEvent")
	--winMgr:getWindow("MyRoom_Item"..i):addChildWindow(mywindow)

	
	-- 착용버튼
	mywindow = winMgr:createWindow("TaharezLook/Button", "MyRoom_UseBtn"..i)
	mywindow:setTexture("Normal", "UIData/my_room.tga", 378, 780)
	mywindow:setTexture("Hover", "UIData/my_room.tga", 378, 798)
	mywindow:setTexture("Pushed", "UIData/my_room.tga", 378, 816)
	mywindow:setTexture("Disabled", "UIData/my_room.tga", 378, 834)
	mywindow:setPosition(58, 185)
	mywindow:setSize(55, 18)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:subscribeEvent("Clicked", "MyRoom_UseBtnEvent")
	winMgr:getWindow("MyRoom_Item"..i):addChildWindow(mywindow)
	
	-- 해제버튼
	mywindow = winMgr:createWindow("TaharezLook/Button", "MyRoom_ReleaseBtn"..i)
	mywindow:setTexture("Normal", "UIData/my_room.tga", 323, 852)
	mywindow:setTexture("Hover", "UIData/my_room.tga", 323, 870)
	mywindow:setTexture("Pushed", "UIData/my_room.tga", 323, 888)
	mywindow:setTexture("Disabled", "UIData/my_room.tga", 323, 906)
	mywindow:setPosition(58, 185)
	mywindow:setSize(55, 18)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:subscribeEvent("Clicked", "MyRoom_ReleaseBtnEvent")
	winMgr:getWindow("MyRoom_Item"..i):addChildWindow(mywindow)
	
	-- 기간연장버튼
	mywindow = winMgr:createWindow("TaharezLook/Button", "MyRoom_PeriodExtentionBtn"..i)
	mywindow:setTexture("Normal", "UIData/my_room2.tga", 638, 301)
	mywindow:setTexture("Hover", "UIData/my_room2.tga", 638, 319)
	mywindow:setTexture("Pushed", "UIData/my_room2.tga", 638, 337)
	mywindow:setTexture("Disabled", "UIData/my_room2.tga", 638, 355)
	mywindow:setPosition(58, 185)
	mywindow:setSize(55, 18)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:subscribeEvent("Clicked", "MyRoom_PeriodExtentionBtnEvent")
	winMgr:getWindow("MyRoom_Item"..i):addChildWindow(mywindow)
	
	-- 등록버튼
	mywindow = winMgr:createWindow("TaharezLook/Button", "MyRoom_RegistBtn"..i)
	mywindow:setTexture("Normal", "UIData/my_room2.tga", 934, 229)
	mywindow:setTexture("Hover", "UIData/my_room2.tga", 934, 247)
	mywindow:setTexture("Pushed", "UIData/my_room2.tga", 934, 265)
	mywindow:setTexture("Disabled", "UIData/my_room2.tga", 934, 283)
	mywindow:setPosition(58, 185)
	mywindow:setSize(55, 18)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:subscribeEvent("Clicked", "MyRoom_RegistBtnEvent")
	winMgr:getWindow("MyRoom_Item"..i):addChildWindow(mywindow)
	
end


--------------------------------------------------------------------
-- 그랑, 코인, 캐쉬
--------------------------------------------------------------------
local tMyMoneyName	= {['protecterr']=0, "MyRoom_HaveGranText", "MyRoom_HaveCoinText", "MyRoom_HaveCashText"}
local tMyMoneyPosX	= {['protecterr']=0, 560, 718, 876}

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
-- 스킬아이템 툴팁이미지.
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SkillToolTipFrame")
mywindow:setTexture("Enabled", "UIData/skillitem001.tga", 757, 551)
mywindow:setTexture("Disabled", "UIData/skillitem001.tga", 757, 551)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 0)
mywindow:setSize(235, 310)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:setUserString("SkillToolTipIndex", "")
mywindow:setUserString("SkillToolTipLevel", "")
mywindow:setUserString("SkillToolTipGrade", "")
mywindow:subscribeEvent("EndRender", "SkillToolTipRender")
Realroot:addChildWindow(mywindow)




--=============================================스킬강화====================================================

--------------------------------------------------------------------
-- 마이룸 관련 스킬강화 윈도우 뒷판.
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyRoom_SkillUpGradeBackImg")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 13, 60)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 13, 60)
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(18, 60)
mywindow:setSize(487, 524)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("EndRender", "SkillUpGradeBackRender")
Myroom_Mainwindow:addChildWindow(mywindow)



--------------------------------------------------------------------
-- 마이룸 관련 스킬 윈도우에 강화하기 버튼
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "MyRoom_SkillUpGradeBtn")
mywindow:setTexture("Normal", "UIData/powerup.tga", 296, 182)
mywindow:setTexture("Hover", "UIData/powerup.tga", 296, 232)
mywindow:setTexture("Pushed", "UIData/powerup.tga", 296, 282)
mywindow:setTexture("PushedOff", "UIData/powerup.tga", 296, 282)
mywindow:setTexture("Disabled", "UIData/powerup.tga", 296, 332)
mywindow:setPosition(320, 466)
mywindow:setSize(147, 50)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "MyRoom_SkillUpGradeBtnEvent")
winMgr:getWindow("MyRoom_SkillUpGradeBackImg"):addChildWindow(mywindow)





--------------------------------------------------------------------
-- 스킬강화 결과(파괴) 팝업창
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SkillDestroyBackAlphaImg")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)

RegistEscEventInfo("SkillDestroyBackAlphaImg", "SkillDestroyResultOKButtonEvent")		-- Esc이벤트
RegistEnterEventInfo("SkillDestroyBackAlphaImg", "SkillDestroyResultOKButtonEvent")		-- Enter이벤트

-- 스킬강화 메인 백 이미지.
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SkillDestroyResultMainImg")
mywindow:setTexture("Enabled", "UIData/powerup2.tga", 0, 0)
mywindow:setPosition((g_MAIN_WIN_SIZEX - 332) / 2, (g_MAIN_WIN_SIZEY - 180) / 2)
mywindow:setSize(332, 180)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("SkillDestroyBackAlphaImg"):addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/StaticText", "SkillDestroyResultText")
mywindow:setPosition(0, 70)
mywindow:setSize(332, 16)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)	
winMgr:getWindow("SkillDestroyResultMainImg"):addChildWindow(mywindow)


-- 확인버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "SkillDestroyResultOKButton")
mywindow:setTexture("Normal", "UIData/powerup2.tga", 0, 180)
mywindow:setTexture("Hover", "UIData/powerup2.tga", 0, 211)
mywindow:setTexture("Pushed", "UIData/powerup2.tga", 0, 242)
mywindow:setTexture("PushedOff", "UIData/powerup2.tga", 0, 242)
mywindow:setPosition((332 - 73)/2, 130)
mywindow:setSize(73, 31)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:subscribeEvent("Clicked", "SkillDestroyResultOKButtonEvent")
winMgr:getWindow("SkillDestroyResultMainImg"):addChildWindow(mywindow)



--------------------------------------------------------------------
-- 스킬강화 결과 팝업창
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SkillUpBackAlphaImg")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)

RegistEscEventInfo("SkillUpBackAlphaImg", "SkillUpResultOKButtonEvent")		-- Esc이벤트
RegistEnterEventInfo("SkillUpBackAlphaImg", "SkillUpResultOKButtonEvent")		-- Enter이벤트

-- 스킬강화 메인 백 이미지.
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SkillUpResultMainImg")
mywindow:setTexture("Enabled", "UIData/powerup.tga", 0, 182)
mywindow:setTexture("Disabled", "UIData/powerup.tga", 0, 182)
mywindow:setPosition((g_MAIN_WIN_SIZEX - 296) / 2, (g_MAIN_WIN_SIZEY - 300) / 2)
mywindow:setSize(296, 283)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:subscribeEvent("EndRender", "SkillUpgradeResultRender")
winMgr:getWindow("SkillUpBackAlphaImg"):addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/Button", "SkillUpResultOKButton")
mywindow:setTexture("Normal", "UIData/deal.tga", 590, 684)
mywindow:setTexture("Hover", "UIData/deal.tga", 590, 713)
mywindow:setTexture("Pushed", "UIData/deal.tga", 590, 742)
mywindow:setTexture("PushedOff", "UIData/deal.tga", 590, 742)
mywindow:setPosition(5, 249)
mywindow:setSize(286, 29)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:subscribeEvent("Clicked", "SkillUpResultOKButtonEvent")
winMgr:getWindow("SkillUpResultMainImg"):addChildWindow(mywindow)


--------------------------------------------------------------------
-- 스킬 강화결과팝업에 사용하는 랜더
--------------------------------------------------------------------
function SkillUpgradeResultRender(args)
	local local_window		= CEGUI.toWindowEventArgs(args).window
	local _drawer			= local_window:getDrawer()
	if tSkillUpResult[9] == false then
		return
	end
	if tSkillUpResult[7] == 4 then	-- 파괴
	
		return
	end
	_drawer:setTextColor(255,255,255,255)
	_drawer:setFont(g_STRING_FONT_GULIM, 11)
	_drawer:drawText("Lv."..tSkillUpResult[8], 22, 61)		-- 레벨

	local skillname = SummaryString(g_STRING_FONT_GULIM, 11, tSkillUpResult[2], 75)
	local Size = GetStringSize(g_STRING_FONT_GULIM, 11, skillname)
	_drawer:drawText(skillname, 70 - Size / 2, 80)		-- 스킬이름
	
	_drawer:drawTexture(tSkillUpResult[3], 21, 96, 100, 100, 0, 0)		-- 스킬 이미지
	_drawer:drawTexture(tSkillUpResult[11], 21, 96, 100, 100, 0, 0)		-- 스킬 이미지
	
	-- 스킬 종류
	_drawer:setFont(g_STRING_FONT_GULIM, 10)
	local skillkind = SummaryString(g_STRING_FONT_GULIM, 10, tSkillUpResult[5], 75)
	local Size = GetStringSize(g_STRING_FONT_GULIM, 10, skillkind)	
	_drawer:drawText(skillkind, 67 - (Size / 2) + 4, 202)	
	
	-- 기간
	_drawer:setFont(g_STRING_FONT_GULIM, 11)
	Size = GetStringSize(g_STRING_FONT_GULIM, 11, MR_String_12.." : "..tSkillUpResult[6])	
	_drawer:drawText(MR_String_12.." : "..tSkillUpResult[6], 66 - (Size / 2) + 4, 220)	
	
	-- 직업 아이콘 이미지
	--_drawer:drawTexture("UIData/skillitem001.tga", 45, 163,  87, 35,   497 + (tSkillUpResult[4] % 2) * 88, 35 * (tSkillUpResult[4] / 2));
	
	_drawer:drawTexture("UIData/Skill_up2.tga", 45, 163,  89, 35,  tAttributeImgTexXTable[tSkillUpResult[4] % 2][tSkillUpResult[10]], tAttributeImgTexYTable[tSkillUpResult[4] % 2][tSkillUpResult[10]])
	_drawer:drawTexture("UIData/Skill_up2.tga", 45, 163,  89, 35,  promotionImgTexXTable[tSkillUpResult[4] % 2], promotionImgTexYTable[tSkillUpResult[4] / 2])
	
	-- 등급
	ItemGrade	= tSkillUpResult[1]
	if ItemGrade ~= 0 then
		_drawer:drawTexture("UIData/powerup.tga", 91, 98, 29, 16, tGradeTexTable[ItemGrade], 486)			-- 아이템 이미지
		_drawer:setTextColor(tGradeTextColorTable[ItemGrade][1],
							tGradeTextColorTable[ItemGrade][2],
							tGradeTextColorTable[ItemGrade][3], 255)
		local Size = GetStringSize(g_STRING_FONT_GULIM, 11, "+"..ItemGrade)
		_drawer:drawText("+"..ItemGrade, 105 - Size / 2, 102)
				
		-- 추가 스킬데미지
		_drawer:setTextColor(87,242,9,255)
		_drawer:setFont(g_STRING_FONT_GULIMCHE, 11)
		local String	= string.format(MR_String_78, tGradeferPersent[ItemGrade])
		_drawer:drawText("[PvP Mode]", 138, 175)
		_drawer:drawText(String.."%", 136, 190)
		
		String	= string.format(MR_String_78, tGradeferPersent[ItemGrade] * 10)
		_drawer:drawText("[Arcade Mode]", 138, 210)
		_drawer:drawText(String.."%", 136, 225)
		
	end
	
	local StringTable	= tGradeChangeStringTable[tSkillUpResult[7]]
	_drawer:setTextColor(255,198,30,255)
	_drawer:setFont(g_STRING_FONT_GULIM, 14)
	local String = AdjustString(g_STRING_FONT_GULIM, 14, StringTable[1], 126)
	_drawer:drawText(String, 143, 60)		-- 성공인지 실패인지
	
	_drawer:setTextColor(255,255,255,255)
	String = AdjustString(g_STRING_FONT_GULIM, 13, StringTable[2], 126)
	_drawer:drawText(String, 143, 115)		-- 등급이 떨어졌는지
end


local	FirstEvent	= false
--------------------------------------------------------------------
-- 스킬 강화결과팝업 확인버튼 이벤트
--------------------------------------------------------------------
function SkillUpResultOKButtonEvent(args)
	FirstEvent	= false
	winMgr:getWindow("SkillUpBackAlphaImg"):setVisible(false)
	RefreshSkillLevel(tSkillUpResult[1])
	tSkillUpResult	= {['err'] = 0, -1, "", "", -1, "", "", -1, -1, false, 0}
	SkillAniKind	= NONE
	ToC_SkillUpdateButtonClick()	-- 아이템 리스트 업데이트
end


function SkillDestroyResultOKButtonEvent(args)
	FirstEvent	= false
	winMgr:getWindow("SkillDestroyBackAlphaImg"):setVisible(false)
	RefreshSkill()
	tSkillUpResult	= {['err'] = 0, -1, "", "", -1, "", "", -1, -1, false, 0}
	SkillAniKind	= NONE
	ToC_SkillUpdateButtonClick()	-- 아이템 리스트 업데이트
end



--------------------------------------------------------------------
-- 마이름 스킬강화 라다오버튼 클릭시.
--------------------------------------------------------------------
function MyRoom_SkillUpgradeShow()
	if CEGUI.toRadioButton(winMgr:getWindow("MyRoom_SkillUpgrade")):isSelected() then
		g_SelectedMainTab	= TAB_UPGRADE_SKILL
		ToC_CurrentItemRefresh()			-- 아이템 리프레쉬
		ToC_CleaarUpgradeSkillList()		-- 스킬강화하는 변수를 초기화
		SkillUpGradeFee	= SkillUpGradeFeeBuf
		Myroom_Mainwindow:addChildWindow(winMgr:getWindow("MyRoom_SkillUpGradeBackImg"))
		winMgr:getWindow("MyRoom_CharacterBackImg"):setVisible(false)
		winMgr:getWindow("MyRoom_SkillPossesionBackImg"):setVisible(false)
		winMgr:getWindow("MyRoom_SkillUpGradeBackImg"):setVisible(true)
		winMgr:getWindow("MyRoom_HotfixMainBackImg"):setVisible(false)

		if CEGUI.toRadioButton(winMgr:getWindow("MyRoom_SpecialTab")):isSelected() == false then	-- 만약 강화 탭이 선택이 안되었다면 선택해준다
			CEGUI.toRadioButton(winMgr:getWindow("MyRoom_SpecialTab")):setSelected(true)			
		end
		ToC_CharacterSetVisible(false)
		ToC_SetMainCategory(3)
		
		-- 초기화
		SkillUpGradeEventTick = 0
		for i = 1, #tArriveTable do
			tArriveTable[i]		= false
		end
		SkillAniKind	= NONE
		winMgr:getWindow("MyRoom_SkillUpGradeBtn"):setEnabled(true)
		
	end
end


-- 스킬 강화시 별이미지 애니메이션
function SkillUpStarMoveAni()
	for i = 1, #tArriveTable do
		if tArriveTable[i] then
			if i ~= 1 then
				tCurrentPointPos[1][1], tCurrentPointPos[1][2]	= ToC_SkillUpAniMovePos(tCurrentPointPos[1][1], tPointPosTable[i - 1][1], tCurrentPointPos[1][2], tPointPosTable[i - 1][2], 6)
				tCurrentPointPos[2][1], tCurrentPointPos[2][2]	= ToC_SkillUpAniMovePos(tCurrentPointPos[2][1], tPointPosTable[i - 1][3], tCurrentPointPos[2][2], tPointPosTable[i - 1][4], 6)
				
				if tCurrentPointPos[1][1] == tPointPosTable[i - 1][1] and tCurrentPointPos[1][2] == tPointPosTable[i - 1][2] then
					tArriveTable[i - 1]	= true
					if i == 2 then						
						PlayWave('sound/SkillUP_Result.wav');
					end
 					tArriveTable[i]		= false
				end
				break
			else
				tCurrentPointPos[1][1]	= 99
				tCurrentPointPos[1][2]	= 180
				tCurrentPointPos[2][1]	= 321
				tCurrentPointPos[2][2]	= 180
				SkillAniKind			= BOOM
				SkillAniTick			= 0
				tArriveTable[i]			= false				
			end
		end
	end
end


--------------------------------------------------------------------
-- 스킬강화 메인 이미지 랜더부분
--------------------------------------------------------------------
function SkillUpGradeBackRender(args)
	
	local local_window		= CEGUI.toWindowEventArgs(args).window
	local _drawer			= local_window:getDrawer()
	_drawer:setTextColor(255,198,30,255)
	_drawer:setFont(g_STRING_FONT_GULIM, 12)

	-- 강화시킬 스킬을 등록하세요
	local	Size = GetStringSize(g_STRING_FONT_GULIM, 12, "# "..MR_String_56)
	_drawer:drawText("# "..MR_String_56, 260 / 2 - Size / 2, 10)

	-- 스킬강화권을 등록하세요
	Size = GetStringSize(g_STRING_FONT_GULIM, 12, "# "..MR_String_57)
	_drawer:drawText("# "..MR_String_57, 720 / 2 - Size / 2, 10)

	-- +2 이상의 강화에서는 실패하면 강화등급이 한단계 떨어집니다 
	--local String = AdjustString(g_STRING_FONT_GULIM, 12, "# "..MR_String_58, 160)
	_drawer:drawText("# "..MR_String_58, 790 / 2 - 160 / 2, 330)
		
	-- 강화 성공시 스킬 변화
	_drawer:setTextColor(0, 211, 233,255)	
	Size = GetStringSize(g_STRING_FONT_GULIM, 12, "# "..MR_String_59)
	_drawer:drawText("# "..MR_String_59, 470 / 2 - Size / 2, 425)


	-- 강화수수료
	_drawer:setTextColor(255,198,30,255)
	_drawer:setFont(g_STRING_FONT_GULIM, 16)
	_drawer:drawText(MR_String_61, 18, 484)
	
	_drawer:drawTexture("UIData/powerup2.tga",4, 244, 173, 167, 332, 0);	-- 업그레이드 정보.
	
	_drawer:drawTexture("UIData/powerup.tga",155, 477, 148, 28, 609, 64)			-- 수수료 뿌려줄 이미지
	_drawer:drawTexture("UIData/Itemshop001.tga",162, 482, 19, 19, 482, 788);	-- 수수료의 PayType의 이미지(Cash, ...)
	
	-- 수수료를 뿌려준다.
	local Fee	= CommatoMoneyStr(SkillUpGradeFee)
	_drawer:setTextColor(255,255,255,255)
	_drawer:setFont(g_STRING_FONT_GULIM, 15)
	Size = GetStringSize(g_STRING_FONT_GULIM, 15, Fee)
	_drawer:drawText(Fee, 287 - Size, 485)
	
	
	-- 하얀선
	_drawer:drawTexture("UIData/powerup.tga",11, 455, 465, 1, 0, 181)
--SKILL_UP_CURRENT_SKILL	= 1
--SKILL_UP_TICKET			= 2
	
	_drawer:drawTexture("UIData/powerup.tga",131, 205, 225, 38, 609, 130)		-- 강화시키는 조건 충족
	
	local SkillTable	= SkillUpGradeInfoTableList[SKILL_UP_CURRENT_SKILL]
	local TicketTable	= SkillUpGradeInfoTableList[SKILL_UP_TICKET]
	local	bEnterSkill		= false		-- 스킬 들어갔나
	local	bEnterTicket	= false		-- 티켓 들어갔나
	local	bUpgradeOK		= false
	
	-- 스킬 들어갔는지.
	if SkillTable[1] ~= "" then
		bEnterSkill		= true
	end
	
	-- 티켓 들어갔는지.
	if TicketTable[1] ~= "" then
		bEnterTicket	= true
	end
	
	-- 스킬이 들어왔는지 확인후 이미지 띄워준다
	if bEnterSkill then
		_drawer:drawTexture("UIData/powerup.tga",67, 30, 128, 181, 128, 0)			-- 스킬 들어왔을때 이미지
	
		if bEnterTicket then		-- 티켓과 스킬이 다 들어왔을때
			bUpgradeOK	= true			
		end
		
		------------------------------------ 업그레이드 할 스킬을 세팅해준다.------------------------------------
		_drawer:drawTexture(SkillTable[2], 80, 68, 100, 100, 0, 0)		-- 스킬 이미지
		_drawer:drawTexture(SkillTable[10], 80, 68, 100, 100, 0, 0)		-- 스킬 이미지
		
		-- 스킬 종류
		_drawer:setTextColor(255,255,255,255)
		_drawer:setFont(g_STRING_FONT_GULIM, 10)
		local skillkind = SummaryString(g_STRING_FONT_GULIM, 10, SkillTable[3], 80)
		local Size = GetStringSize(g_STRING_FONT_GULIM, 10, skillkind)	
		_drawer:drawText(skillkind, (254 / 2) - (Size / 2) + 4, 174)	
		
		-- 기간
		_drawer:setFont(g_STRING_FONT_GULIM, 11)
		Size = GetStringSize(g_STRING_FONT_GULIM, 11, MR_String_12.." : "..SkillTable[4])	
		_drawer:drawText(MR_String_12.." : "..SkillTable[4], (254 / 2) - (Size / 2) + 4, 190)	
		
		-- 직업 아이콘 이미지
		--_drawer:drawTexture("UIData/skillitem001.tga", 100, 137,  87, 35,   497 + (SkillTable[5] % 2) * 88, 35 * (SkillTable[5] / 2));
		_drawer:drawTexture("UIData/Skill_up2.tga", 100, 137,  89, 35,  tAttributeImgTexXTable[SkillTable[5] % 2][SkillTable[9]], tAttributeImgTexYTable[SkillTable[5] % 2][SkillTable[9]])
		_drawer:drawTexture("UIData/Skill_up2.tga", 100, 137,  89, 35,  promotionImgTexXTable[SkillTable[5] % 2], promotionImgTexYTable[SkillTable[5] / 2])

		-- 등급
		ItemGrade	= SkillTable[6]
		if ItemGrade ~= 0 then
			_drawer:drawTexture("UIData/powerup.tga", 151, 72, 29, 16, tGradeTexTable[ItemGrade], 486)			-- 아이템 이미지
			_drawer:setTextColor(tGradeTextColorTable[ItemGrade][1],
								tGradeTextColorTable[ItemGrade][2],
								tGradeTextColorTable[ItemGrade][3], 255)
			local Size = GetStringSize(g_STRING_FONT_GULIM, 11, "+"..ItemGrade)
			_drawer:drawText("+"..ItemGrade, 164 - Size / 2, 76)
		end
		
		-- 아이템 이름
		_drawer:setFont(g_STRING_FONT_GULIM, 11)
		local skillname = SummaryString(g_STRING_FONT_GULIM, 11, SkillTable[1], 75)
		local	Size = GetStringSize(g_STRING_FONT_GULIM, 11, skillname)
		common_DrawOutlineText2(_drawer, skillname, 260 / 2 - Size / 2, 56, 60,60,60,255, 204,255,255,255);
		
		-- 레벨
		_drawer:setTextColor(255,255,255,255)
		_drawer:drawText("Lv. "..SkillTable[8], 80, 43)
		
		
		local damage, downdamage, nextgrade, downgrade, bDestroy = ToC_GetSkillUpgradeInfo(ItemGrade)
		if bDestroy then
			_drawer:drawTexture("UIData/powerup2.tga",4, 380, 173, 31, 332, 167);	-- 업그레이드 정보.
		end
		if nextgrade > 0 then
			_drawer:setTextColor(255,255,255,255)
			_drawer:drawText("+"..ItemGrade.." -> ".."+"..nextgrade, 80, 290)
			_drawer:drawText("Damage : "..damage.."%", 80, 310)
		else
			_drawer:setTextColor(255,255,255,255)
			_drawer:drawText("-", 120, 300)
		end
		if downgrade > 0 then
			_drawer:setTextColor(255,255,255,255)
			_drawer:drawText("+"..ItemGrade.." -> ".."+"..downgrade, 80, 340)
			_drawer:drawText("Damage : "..downdamage.."%", 80, 360)
		else
			_drawer:setTextColor(255,255,255,255)
			_drawer:drawText("-", 120, 350)
		end
		
		-----------------------------------------------------------------------------------------------------------
	else
		_drawer:drawTexture("UIData/powerup.tga",67, 30, 128, 181, 0, 0)			-- 스킬 Empty 이미지
	end

		
	-- 티켓이 들어왔는지 확인한다.
	if bEnterTicket and TicketTable[6] > 0 then
		_drawer:drawTexture("UIData/powerup.tga",287, 30, 128, 181, 128, 0)			-- 강화권 들어왔을때 이미지
		_drawer:drawTextureSA(TicketTable[2], 310, 70, 100, 100, 0, 0,225, 255,   255, 0, 0)		-- 스킬 이미지
		
		----------------------------------------- 교환권을 세팅해준다.------------------------------------------
		-- 아이템 이름
		_drawer:setFont(g_STRING_FONT_GULIM, 11)
		local ticketName = SummaryString(g_STRING_FONT_GULIM, 11, TicketTable[1], 75)
		local	Size = GetStringSize(g_STRING_FONT_GULIM, 11, ticketName)
		common_DrawOutlineText2(_drawer, ticketName, 260 / 2 - Size / 2 + 221, 56, 60,60,60,255, 204,255,255,255);
		
		-- 갯수
		_drawer:setTextColor(255,255,255,255)
		Size = GetStringSize(g_STRING_FONT_GULIM, 11, "x "..TicketTable[6])
		_drawer:drawText("x "..TicketTable[6], 400 - Size, 76)
		
		-- 기간
		Size = GetStringSize(g_STRING_FONT_GULIM, 11, MR_String_12.." : "..TicketTable[4])	
		_drawer:drawText(MR_String_12.." : "..TicketTable[4], (254 / 2) - (Size / 2) + 225, 190)
		
		
		--------------------------------------------------------------------------------------------------------
	else		
		_drawer:drawTexture("UIData/powerup.tga",287, 30, 128, 181, 0, 0)			-- 강화권 Empty 이미지
	end
	

	-- 강화 시키는 조건이 만족했는지 확인한다.
	if bUpgradeOK then
		if tSkillUpResult[9] then
			if tSkillUpResult[1] ~= -1 then
				_drawer:drawTexture("UIData/powerup.tga",179, 236, 128, 181, 256, 0)		-- 강화성공 이미지
				
				------------------------------------ 업그레이드 될 스킬을 세팅해준다.------------------------------------
				_drawer:drawTexture(tSkillUpResult[3], 192, 274, 100, 100, 0, 0)		-- 스킬 이미지
				_drawer:drawTexture(tSkillUpResult[11], 192, 274, 100, 100, 0, 0)		-- 스킬 이미지
				
				-- 스킬 종류
				_drawer:setTextColor(255,255,255,255)
				_drawer:setFont(g_STRING_FONT_GULIM, 10)
				local skillkind = SummaryString(g_STRING_FONT_GULIM, 10, tSkillUpResult[5], 80)
				local Size = GetStringSize(g_STRING_FONT_GULIM, 10, skillkind)	
				_drawer:drawText(skillkind, 243 - (Size / 2), 380)	
				
				-- 기간
				_drawer:setFont(g_STRING_FONT_GULIM, 11)
				Size = GetStringSize(g_STRING_FONT_GULIM, 11, MR_String_12.." : "..tSkillUpResult[6])	
				_drawer:drawText(MR_String_12.." : "..tSkillUpResult[6], 243 - (Size / 2), 396)	
				
				-- 직업 아이콘 이미지
				--_drawer:drawTexture("UIData/skillitem001.tga", 212, 343,  87, 35,   497 + (tSkillUpResult[4] % 2) * 88, 35 * (tSkillUpResult[4] / 2));
				local style = tSkillUpResult[4] % 2
				local promotion = tSkillUpResult[4] / 2
				_drawer:drawTexture("UIData/Skill_up2.tga", 212, 343,  89, 35,  tAttributeImgTexXTable[style][tSkillUpResult[10]], tAttributeImgTexYTable[style][tSkillUpResult[10]])
				_drawer:drawTexture("UIData/Skill_up2.tga", 212, 343,  89, 35,  promotionImgTexXTable[style], promotionImgTexYTable[promotion])
				
				
				
				-- 등급
				ItemGrade	= tSkillUpResult[1]
				if ItemGrade ~= 0 then
					_drawer:drawTexture("UIData/powerup.tga", 263, 278, 29, 16, tGradeTexTable[ItemGrade], 486)			-- 아이템 이미지
					_drawer:setTextColor(tGradeTextColorTable[ItemGrade][1],
										tGradeTextColorTable[ItemGrade][2],
										tGradeTextColorTable[ItemGrade][3], 255)
					local Size = GetStringSize(g_STRING_FONT_GULIM, 11, "+"..ItemGrade)
					_drawer:drawText("+"..ItemGrade, 276 - Size / 2, 282)
				end
				
				-- 아이템 이름
				_drawer:setFont(g_STRING_FONT_GULIM, 11)
				local skillname = SummaryString(g_STRING_FONT_GULIM, 11, tSkillUpResult[2], 75)
				local	Size = GetStringSize(g_STRING_FONT_GULIM, 11, skillname)
				common_DrawOutlineText2(_drawer, skillname, 242 - Size / 2, 262, 60,60,60,255, 204,255,255,255);
				
				-- 레벨
				_drawer:setTextColor(255,255,255,255)
				_drawer:drawText("Lv. "..tSkillUpResult[8], 192, 249)
			end	
		end
		if SkillAniKind == NONE then
			_drawer:drawTexture("UIData/powerup.tga",179, 236, 128, 181, 384, 0)			-- 강화성공 Empty 이미지
		end
			-----------------------------------------------------------------------------------------------------------
		
	else
		_drawer:drawTexture("UIData/powerup.tga",179, 236, 128, 181, 384, 0)			-- 강화성공 Empty 이미지
	end
	local	StarTick	= SkillAniTick % 6
	if SkillAniKind == STAR then
		_drawer:drawTexture("UIData/powerup.tga",179, 236, 128, 181, 384, 0)			-- 강화성공 Empty 이미지
		-- 왼쪽별
		_drawer:drawTexture("UIData/powerup.tga",tCurrentPointPos[1][1], tCurrentPointPos[1][2], 64, 64, tEffectTexX2[StarTick], 0)
		_drawer:drawTextureWithScale_Angle_Offset("UIData/powerup.tga",tCurrentPointPos[1][1] + 32, tCurrentPointPos[1][2] + 32, 64, 64, tEffectTexX[StarTick], 0,   255, 255, 255, tEffectAngle[StarTick], 8, 0,0)
		
		--오른쪽별
		_drawer:drawTexture("UIData/powerup.tga",tCurrentPointPos[2][1], tCurrentPointPos[2][2], 64, 64, tEffectTexX2[StarTick], 0)
		_drawer:drawTextureWithScale_Angle_Offset("UIData/powerup.tga",tCurrentPointPos[2][1] + 32, tCurrentPointPos[2][2] + 32, 64, 64, tEffectTexX[StarTick], 0,   255, 255, 255, tEffectAngle[StarTick], 8, 0,0)
		
	elseif SkillAniKind == BOOM then
		--DebugStr("BOOM")
		if FirstEvent == false then
			if SkillAniTick * 10 > 255 then
				FirstEvent	= true
				ToC_MouseEvent(false)
				
				winMgr:getWindow("MyRoom_SkillUpGradeBtn"):setEnabled(true)		-- 버튼 활성화
				if tSkillUpResult[7] == 4 then
					-- 아이템 이름 SkillTable[1]   스킬등급 SkillTable[6]	파괴되었다고 띄워준다.
					local destroyString	= string.format(PreCreateString_2695, SkillTable[6], SkillTable[1])		-- GetSStringInfo(SKILL_DESTROY_MSG)
					winMgr:getWindow("SkillDestroyResultText"):setTextExtends(destroyString, g_STRING_FONT_GULIMCHE,12, 235, 50, 9, 255,  0,  0,0,0,255);	
					root:addChildWindow(winMgr:getWindow("SkillDestroyBackAlphaImg"))
					winMgr:getWindow("SkillDestroyBackAlphaImg"):setVisible(true)
				else
					root:addChildWindow(winMgr:getWindow("SkillUpBackAlphaImg"))
					winMgr:getWindow("SkillUpBackAlphaImg"):setVisible(true)
				end
				return
			end
		
			_drawer:drawTextureSA("UIData/powerup.tga",179, 236, 128, 181, 384, 0,   255, 255,   tEffectScale[3] - SkillAniTick * 10, 0, 0);-- 강화성공 Empty 이미지
			
			-- 폭팔 이미지 애니메이션
			_drawer:drawTextureWithScale_Angle_Offset("UIData/powerup.tga",245, 330, 154, 152, 816, 476, tEffectScale[1] + SkillAniTick * 10, tEffectScale[2] + SkillAniTick * 10, tEffectScale[3] - SkillAniTick * 10, 0, 8, 0,0)	 
		end
	end

end



-- 스킬강화에 관한 정보를 띄워준다.
function RenderSkillUpgradeInfo(grade, bDestroy)
	if bDestroy then
		
	else
		
	end
	
	-- 현재 등급이 1이면 실패시 grade 가 떨어지지 않는다.
	
	
	
	

end




--------------------------------------------------------------------
-- 스킬업그레이드 틱
--------------------------------------------------------------------
function GetEnableSkillUpTick(time)
	SkillAniTick = SkillAniTick + 1
	SkillUpGradeEventTick	= time
	--DebugStr("SkillUpGradeEventTick: " .. SkillUpGradeEventTick)
	--DebugStr("SkillAniTick : " .. SkillAniTick)
end


-- 스킬업그레이드 성공 팝업창
function SkillUpgradeResult(SkillGrade, ItemName, ItemFileName, ItemFileName2, Itempromotion, Desc, period, GradeChange, Level, attribute)

	local	skillkind, desc = SkillDescDivide(Desc)
	tSkillUpResult[1]	= SkillGrade
	tSkillUpResult[2]	= ItemName
	tSkillUpResult[3]	= ItemFileName
	tSkillUpResult[4]	= Itempromotion
	tSkillUpResult[5]	= skillkind
	tSkillUpResult[6]	= period
	tSkillUpResult[7]	= GradeChange
	tSkillUpResult[8]	= Level
	tSkillUpResult[9]	= true
	tSkillUpResult[10]	= attribute	
	tSkillUpResult[11]	= ItemFileName2

end




--------------------------------------------------------------------
-- 스킬업그레이드 관련 변수를 Update해준다
--------------------------------------------------------------------
function UpdateSkillUpGradeList(Index, ItemName, ItemFileName, skillkind, ItemExpireTime, Promotion, ItemGrade, ListIndex, ItemLevel, attribute, ItemFileName2)
	
	if Index == 0 then
		return
	end
	-- 루아에 저장 시켜준다.
	SkillUpGradeInfoTableList[Index][1]	= ItemName
	SkillUpGradeInfoTableList[Index][2]	= ItemFileName
	SkillUpGradeInfoTableList[Index][3]	= skillkind
	SkillUpGradeInfoTableList[Index][4]	= ItemExpireTime
	SkillUpGradeInfoTableList[Index][5]	= Promotion
	SkillUpGradeInfoTableList[Index][6]	= ItemGrade
	SkillUpGradeInfoTableList[Index][7]	= ListIndex
	SkillUpGradeInfoTableList[Index][8]	= ItemLevel
	SkillUpGradeInfoTableList[Index][9]	= attribute
	SkillUpGradeInfoTableList[Index][10]= ItemFileName2

end


--------------------------------------------------------------------
-- 스킬업그레이드 결과후 스킬을 리프레쉬 해준다.
--------------------------------------------------------------------
function RefreshSkillLevel(itemGrade)
	SkillUpGradeFee	= SkillUpGradeFeeBuf
	SkillUpGradeInfoTableList[SKILL_UP_CURRENT_SKILL][6]	= itemGrade
	SkillUpGradeInfoTableList[SKILL_UP_TICKET][6]			= SkillUpGradeInfoTableList[SKILL_UP_TICKET][6] - 1
	if SkillUpGradeInfoTableList[SKILL_UP_TICKET][6] <= 0 then
		SkillUpGradeInfoTableList[SKILL_UP_TICKET][1]	= ""
	end
end

-- 
function RefreshSkill()
	SkillUpGradeFee	= 0
	
	SkillUpGradeInfoTableList[SKILL_UP_CURRENT_SKILL][1]	= ""
	SkillUpGradeInfoTableList[SKILL_UP_CURRENT_SKILL][2]	= ""
	SkillUpGradeInfoTableList[SKILL_UP_CURRENT_SKILL][3]	= ""
	SkillUpGradeInfoTableList[SKILL_UP_CURRENT_SKILL][4]	= ""
	SkillUpGradeInfoTableList[SKILL_UP_CURRENT_SKILL][5]	= 0
	SkillUpGradeInfoTableList[SKILL_UP_CURRENT_SKILL][6]	= 0
	SkillUpGradeInfoTableList[SKILL_UP_CURRENT_SKILL][7]	= 0
	SkillUpGradeInfoTableList[SKILL_UP_CURRENT_SKILL][8]	= 0
	SkillUpGradeInfoTableList[SKILL_UP_CURRENT_SKILL][9]	= 0

	SkillUpGradeInfoTableList[SKILL_UP_TICKET][6]			= SkillUpGradeInfoTableList[SKILL_UP_TICKET][6] - 1
	if SkillUpGradeInfoTableList[SKILL_UP_TICKET][6] <= 0 then
		SkillUpGradeInfoTableList[SKILL_UP_TICKET][1]	= ""
	end
end




--------------------------------------------------------------------
-- 스킬업그레이드 수수료를 업데이트 한다.
--------------------------------------------------------------------
function UpdateSkillUpgradeFee(Fee)
	SkillUpGradeFeeBuf	= Fee
end


--------------------------------------------------------------------
-- 스킬 강화하기 버튼이 눌려졌다.
--------------------------------------------------------------------
function MyRoom_SkillUpGradeBtnEvent(args)
	if SkillUpGradeInfoTableList[SKILL_UP_TICKET][1] == "" then
		ShowNotifyOKMessage_Lua(PreCreateString_2009)		-- GetSStringInfo(LAN_REGISTER_TICKET)
		return
	end
		
	local Check	= ToC_RequestSkillUpGrade()
--[[
	if Check then	-- 모든 조건이 만족됐다면
	
		tArriveTable[4]	= true
		SkillAniKind	= STAR
		SkillAniTick	= 0
		winMgr:getWindow("MyRoom_SkillUpGradeBtn"):setEnabled(false)
		PlayWave('sound/SkillUP_Move.wav');
	end
--]]
end

function MyRoom_SkillUpGradeOkReturnEvent(check)
	if check == 1 then
		tArriveTable[4]	= true
		SkillAniKind	= STAR
		SkillAniTick	= 0
		winMgr:getWindow("MyRoom_SkillUpGradeBtn"):setEnabled(false)
		PlayWave('sound/SkillUP_Move.wav');
	else
		ToC_MouseEvent(false)
	end	
end
--=========================================================================================================






--=============================================핫픽스======================================================

local	HotfixAni	= false
--------------------------------------------------------------------
-- 마이룸 관련 핫픽스 윈도우 뒷판.
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyRoom_HotfixMainBackImg")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 13, 60)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 13, 60)
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(18, 60)
mywindow:setSize(487, 524)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("StartRender", "HotfixMainBackRender")
Myroom_Mainwindow:addChildWindow(mywindow)


--------------------------------------------------------------------
-- 마이룸 관련 핫픽스에 리폼하기, 핫픽스 업그레이드하기 버튼
--------------------------------------------------------------------
local ButtonText	= {['err'] = 0, "MyRoom_ReformBtn", "MyRoom_HotfixUpBtn"}
local ButtonPosY	= {['err'] = 0,			187,			445}
local ButtonTexY	= {['err'] = 0,			738,			874}
local ButtonEvent	= {['err'] = 0, "MyRoom_ReformBtnEvent", "MyRoom_HotfixUpBtnEvent"}

for i = 1, #ButtonText do
	mywindow = winMgr:createWindow("TaharezLook/Button", ButtonText[i])
	mywindow:setTexture("Normal", "UIData/powerup.tga", 474, ButtonTexY[i])
	mywindow:setTexture("Hover", "UIData/powerup.tga", 474, ButtonTexY[i] + 34)
	mywindow:setTexture("Pushed", "UIData/powerup.tga", 474, ButtonTexY[i] + 34 * 2)
	mywindow:setTexture("PushedOff", "UIData/powerup.tga", 474, ButtonTexY[i] + 34 * 2)
	mywindow:setTexture("Disabled", "UIData/powerup.tga", 474, ButtonTexY[i] + 34 * 3)
	mywindow:setPosition(18, ButtonPosY[i])
	mywindow:setSize(451, 34)
	mywindow:setVisible(true)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", ButtonEvent[i])
	winMgr:getWindow("MyRoom_HotfixMainBackImg"):addChildWindow(mywindow)
end


--------------------------------------------------------------------
-- 핫픽스업그레이드 결과 효과주기위한 이미지
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyRoom_HotfixResultIcon")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 13, 60)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 13, 60)
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(18, 60)
mywindow:setSize(100, 100)
mywindow:setVisible(false)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setAlign(8);
mywindow:setScaleWidth(10);
mywindow:setScaleHeight(10);
mywindow:addController("HotfixIconController", "IconResult", "xscale", "Elastic_EaseOut", 500, 150, 14, true, false, 10)
mywindow:addController("HotfixIconController", "IconResult", "yscale", "Elastic_EaseOut", 500, 150, 14, true, false, 10)
winMgr:getWindow("MyRoom_HotfixMainBackImg"):addChildWindow(mywindow)

-- 핫픽스업그레이드 결과 성공 실패 이미지
local HotfixResultEffectImgName	= {['err'] = 0, "HotfixResultFailImg", "HotfixResultSuccessImg"}

--for i = 1, #HotfixResultEffectImgName do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "HotfixResultImg")
	mywindow:setTexture("Enabled", "UIData/powerup.tga", 531, 382 + 20)
	mywindow:setTexture("Disabled", "UIData/powerup.tga", 531, 382 + 20)
	mywindow:setPosition(208, 386)
	mywindow:setSize(71, 20)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setAlign(8);
	mywindow:setScaleWidth(2000);
	mywindow:setScaleHeight(2000);
	mywindow:addController("HotfixIconController", "SuccessResult", "xscale", "Sine_EaseInOut", 2000, 255, 6, true, false, 10)
	mywindow:addController("HotfixIconController", "SuccessResult", "yscale", "Sine_EaseInOut", 2000, 255, 6, true, false, 10)
	mywindow:addController("HotfixIconController", "SuccessResult", "angle", "Sine_EaseIn", 0, 4000, 6, true, false, 10)
	mywindow:subscribeEvent("MotionEventEnd", "IconResultEventEnd");
	--mywindow:subscribeEvent("MotionEventEnd", "IconResultEventEnd");
	winMgr:getWindow("MyRoom_HotfixMainBackImg"):addChildWindow(mywindow)
--end


--------------------------------------------------------------------
-- 핫픽스 드랍다운 박스 베이스
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "HotfixDropDownBase")
mywindow:setTexture("Enabled", "UIData/powerup.tga", 816, 631)
mywindow:setTexture("Disabled", "UIData/powerup.tga", 816, 631)
mywindow:setPosition(361, 139)
mywindow:setSize(109, 25)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("MyRoom_HotfixMainBackImg"):addChildWindow(mywindow)
-- 
mywindow = winMgr:createWindow("TaharezLook/StaticText", "HotfixDropDownBaseText")
--mywindow:setTexture("Enabled", "UIData/powerup.tga", 0, 0)
--mywindow:setTexture("Disabled", "UIData/powerup.tga", 0, 0)
mywindow:setPosition(2, 7)
mywindow:setSize(82, 16)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)	
winMgr:getWindow("HotfixDropDownBase"):addChildWindow(mywindow)

winMgr:getWindow("HotfixDropDownBaseText"):clearTextExtends();
winMgr:getWindow("HotfixDropDownBaseText"):addTextExtends("Select Part", g_STRING_FONT_GULIMCHE,12, 87, 242, 9, 255,  0,  0,0,0,255);	
		
-- 이벤트용 버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "HotfixDropDownBtn1")
mywindow:setTexture("Normal", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Hover", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Pushed", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("PushedOff", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(0, 0)
mywindow:setSize(84, 28)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:subscribeEvent("Clicked", "HotfixDropDownBtnEvent")
winMgr:getWindow("HotfixDropDownBase"):addChildWindow(mywindow)

-- 드랍다운 버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "HotfixDropDownBtn")
mywindow:setTexture("Normal", "UIData/my_room2.tga", 819, 328)
mywindow:setTexture("Hover", "UIData/my_room2.tga", 819, 343)
mywindow:setTexture("Pushed", "UIData/my_room2.tga", 819, 358)
mywindow:setTexture("PushedOff", "UIData/my_room2.tga", 819, 358)
mywindow:setPosition(88, 7)
mywindow:setSize(17, 15)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:subscribeEvent("Clicked", "HotfixDropDownBtnEvent")
winMgr:getWindow("HotfixDropDownBase"):addChildWindow(mywindow)


local HotfixDropDownList	= {['err'] = 0, PreCreateString_1841, MR_String_2, MR_String_3, MR_String_4, MR_String_5, MR_String_6, MR_String_7, MR_String_8, MR_String_9}

-- 드랍다운버튼 이벤트
function HotfixDropDownBtnEvent(args)
	if winMgr:getWindow("HotfixDropDownContainer"):isVisible() then
		winMgr:getWindow("HotfixDropDownContainer"):setVisible(false)
	else
		winMgr:getWindow("HotfixDropDownContainer"):setVisible(true)
	end
end


-- 코스튬타입 드랍다운 컨테이너
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "HotfixDropDownContainer")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(361, 164)
mywindow:setSize(109, 25 * #HotfixDropDownList)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("MyRoom_HotfixMainBackImg"):addChildWindow(mywindow)


for i = 1, #HotfixDropDownList do
	mywindow = winMgr:createWindow("TaharezLook/Button", "HotfixDropDownList"..i)
	if i == #HotfixDropDownList then
		mywindow:setTexture("Normal", "UIData/powerup.tga", 816, 685)
	else
		mywindow:setTexture("Normal", "UIData/powerup.tga", 816, 658)
	end	
	mywindow:setTexture("Hover", "UIData/powerup.tga", 816, 712)
	mywindow:setTexture("Pushed", "UIData/powerup.tga", 816, 712)
	mywindow:setTexture("PushedOff", "UIData/powerup.tga", 816, 712)
	mywindow:setPosition(0, (i - 1) * 25)
	mywindow:setSize(109, 25)
	mywindow:setUserString("Index", tostring(i))
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:subscribeEvent("Clicked", "HotfixDropDownList_ClickEvent")
	winMgr:getWindow("HotfixDropDownContainer"):addChildWindow(mywindow)
	
	
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "HotfixDropDownListText"..i)
	mywindow:setPosition(0, 6)
	mywindow:setSize(109, 16)
	mywindow:setViewTextMode(1)
	mywindow:setAlign(8)
	mywindow:setLineSpacing(2)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)	
	winMgr:getWindow("HotfixDropDownList"..i):addChildWindow(mywindow)

	winMgr:getWindow("HotfixDropDownListText"..i):clearTextExtends();
	winMgr:getWindow("HotfixDropDownListText"..i):addTextExtends(HotfixDropDownList[i], g_STRING_FONT_GULIMCHE,12, 255, 255, 255, 255,  0,  0,0,0,255);	
end

					
function HotfixDropDownList_ClickEvent(args)
	local local_window	= CEGUI.toWindowEventArgs(args).window
	local Index			= tonumber(local_window:getUserString("Index"))
	
	winMgr:getWindow("HotfixDropDownBaseText"):clearTextExtends();
	winMgr:getWindow("HotfixDropDownBaseText"):addTextExtends(HotfixDropDownList[Index], g_STRING_FONT_GULIMCHE,12, 87, 242, 9, 255,  0,  0,0,0,255);	

	tCostumReformInfoTable[REFORM_ATTACH]	= Index
	
	winMgr:getWindow("HotfixDropDownContainer"):setVisible(false)
	
end



--------------------------------------------------------------------
-- 코스튬강화 결과 팝업창
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CostumUpBackAlphaImg")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)

RegistEscEventInfo("CostumUpBackAlphaImg", "CostumUpResultOKButtonEvent")		-- Esc이벤트
RegistEnterEventInfo("CostumUpBackAlphaImg", "CostumUpResultOKButtonEvent")		-- Enter이벤트

-- 스킬강화 메인 백 이미지.
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CostumUpResultMainImg")
mywindow:setTexture("Enabled", "UIData/powerup.tga", 0, 182)
mywindow:setTexture("Disabled", "UIData/powerup.tga", 0, 182)
mywindow:setPosition((g_MAIN_WIN_SIZEX - 296) / 2, (g_MAIN_WIN_SIZEY - 300) / 2)
mywindow:setSize(296, 283)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:subscribeEvent("EndRender", "CostumUpgradeResultRender")
winMgr:getWindow("CostumUpBackAlphaImg"):addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/Button", "CostumUpResultOKButton")
mywindow:setTexture("Normal", "UIData/deal.tga", 590, 684)
mywindow:setTexture("Hover", "UIData/deal.tga", 590, 713)
mywindow:setTexture("Pushed", "UIData/deal.tga", 590, 742)
mywindow:setTexture("PushedOff", "UIData/deal.tga", 590, 742)
mywindow:setPosition(5, 249)
mywindow:setSize(286, 29)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:subscribeEvent("Clicked", "CostumUpResultOKButtonEvent")
winMgr:getWindow("CostumUpResultMainImg"):addChildWindow(mywindow)

		

--------------------------------------------------------------------
-- 핫픽스 업그레이드 결과 팝업창
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "HotfixUpgradeResultAlpha")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)

RegistEscEventInfo("HotfixUpgradeResultAlpha", "CloseHotfixUpgradeResultAlpha")		-- Esc이벤트
RegistEnterEventInfo("HotfixUpgradeResultAlpha", "CloseHotfixUpgradeResultAlpha")		-- Enter이벤트


-- 핫픽스 업그레이드 결과창 메인페이지.
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "HotfixUpgradeResultMainImg")
mywindow:setTexture("Enabled", "UIData/powerup.tga", 474, 455)
mywindow:setTexture("Disabled", "UIData/powerup.tga", 474, 455)
mywindow:setPosition((g_MAIN_WIN_SIZEX - 296) / 2, (g_MAIN_WIN_SIZEY - 300) / 2)
mywindow:setSize(342, 283)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:subscribeEvent("EndRender", "HotfixUpgradeResultRender")
winMgr:getWindow("HotfixUpgradeResultAlpha"):addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/Button", "HotfixUpgradeResultOKButton")
mywindow:setTexture("Normal", "UIData/popup001.tga", 693, 617)
mywindow:setTexture("Hover", "UIData/popup001.tga", 693, 646)
mywindow:setTexture("Pushed", "UIData/popup001.tga", 693, 675)
mywindow:setTexture("PushedOff", "UIData/popup001.tga", 693, 675)
mywindow:setPosition(5, 249)
mywindow:setSize(331, 29)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:subscribeEvent("Clicked", "CloseHotfixUpgradeResultAlpha")
winMgr:getWindow("HotfixUpgradeResultMainImg"):addChildWindow(mywindow)



for i = 1, 2 do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "HotfixUpgradeResultImg"..i)
	mywindow:setTexture("Enabled", "UIData/powerup.tga", 738, 298)
	mywindow:setTexture("Disabled", "UIData/powerup.tga", 738, 298)
	mywindow:setPosition(25 + (i - 1) * 190, 115)
	mywindow:setSize(103, 99)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	winMgr:getWindow("HotfixUpgradeResultMainImg"):addChildWindow(mywindow)
end

-- 핫픽스 업그레이드 결과창 화살표
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "HotfixUpgradeResultArrow")
mywindow:setTexture("Enabled", "UIData/powerup.tga", 738, 397)
mywindow:setTexture("Disabled", "UIData/powerup.tga", 738, 397)
mywindow:setPosition(120, 134)
mywindow:setSize(103, 57)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("HotfixUpgradeResultMainImg"):addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/StaticImage", "HotfixUpgradeResultMsg")
mywindow:setTexture("Enabled", "UIData/powerup.tga", 531, 382)
mywindow:setTexture("Disabled", "UIData/powerup.tga", 531, 402)
mywindow:setPosition(132, 56)
mywindow:setSize(70, 20)
mywindow:setVisible(true)
mywindow:setEnabled(false)
mywindow:setScaleWidth(300)
mywindow:setScaleHeight(300)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("HotfixUpgradeResultMainImg"):addChildWindow(mywindow)

tHotfixResultWindow = {['err'] = 0, "", "", "", ""}
--
function ShowHotfixResult(Name, FileName, Index)
	if Index == 1 then	-- 실패
		-- 화살표
		winMgr:getWindow("HotfixUpgradeResultArrow"):setTexture("Enabled", "UIData/powerup.tga", 841, 397)
		winMgr:getWindow("HotfixUpgradeResultArrow"):setTexture("Disabled", "UIData/powerup.tga", 841, 397)
		-- 메세지
		winMgr:getWindow("HotfixUpgradeResultMsg"):setTexture("Enabled", "UIData/powerup.tga", 531, 382)
		winMgr:getWindow("HotfixUpgradeResultMsg"):setTexture("Disabled", "UIData/powerup.tga", 531, 382)
		
		
	elseif Index == 2 then	-- 성공
		-- 화살표
		winMgr:getWindow("HotfixUpgradeResultArrow"):setTexture("Enabled", "UIData/powerup.tga", 738, 397)
		winMgr:getWindow("HotfixUpgradeResultArrow"):setTexture("Disabled", "UIData/powerup.tga", 738, 397)
		-- 메세지
		winMgr:getWindow("HotfixUpgradeResultMsg"):setTexture("Enabled", "UIData/powerup.tga", 531, 402)
		winMgr:getWindow("HotfixUpgradeResultMsg"):setTexture("Disabled", "UIData/powerup.tga", 531, 402)
	end
	tHotfixResultWindow[3] = Name
	tHotfixResultWindow[4] = FileName	
end


function HotfixUpgradeResultRender(args)
	local local_window	= CEGUI.toWindowEventArgs(args).window
	local _drawer		= local_window:getDrawer()
	
	-- 전
	_drawer:setTextColor(255,198,30,255)
	_drawer:setFont(g_STRING_FONT_GULIM, 12)
	local Size = GetStringSize(g_STRING_FONT_GULIM, 12, tHotfixResultWindow[1])
	_drawer:drawText(tHotfixResultWindow[1], 76 - Size / 2, 97)		-- 레벨
	
	_drawer:setTextColor(255,255,255,255)
	_drawer:drawText("x 5", 104, 120)		-- 레벨

	_drawer:drawTexture("UIData/ItemUIData/"..tHotfixResultWindow[2], 28, 115, 100, 100, 0, 0)		-- 아이템 이미지

	-- 후
	_drawer:setTextColor(255,198,30,255)
	Size = GetStringSize(g_STRING_FONT_GULIM, 12, tHotfixResultWindow[3])
	_drawer:drawText(tHotfixResultWindow[3], 265 - Size / 2, 97)		-- 레벨

	_drawer:setTextColor(255,255,255,255)
	_drawer:drawText("x 1", 295, 120)		-- 레벨
	
	_drawer:drawTexture("UIData/ItemUIData/"..tHotfixResultWindow[4], 217, 115, 100, 100, 0, 0)		-- 아이템 이미지

end


-- 닫기
function CloseHotfixUpgradeResultAlpha()
	winMgr:getWindow("HotfixUpgradeResultAlpha"):setVisible(false)
end



-- 코스튬 업그레이드 결과 아이템 정보 받아온다.
function CostumUpgradeResult(level, name, filename, kind, time, stat1, stat2, stat3, stat4, stat5, stat6, stat7,  stat8, stat9, stat10, stat11, stat12, stat13, stat14)

	tCostumReformResultInfo[1]	= level	-- 아이템 레벨
	tCostumReformResultInfo[2]	= name	-- 아이템 이름
	tCostumReformResultInfo[3]	= filename	-- 아이템 파일 경로
	tCostumReformResultInfo[4]	= kind	-- 아이템 코스튬 종류 인덱스
	tCostumReformResultInfo[5]	= time	-- 아이템 사용기간.
	
	-- 스텟 관련 정보
	tCostumReformResultStat[1]	= stat1	-- 아이템 사용기간.
	tCostumReformResultStat[2]	= stat2	-- 아이템 사용기간.
	tCostumReformResultStat[3]	= stat3	-- 아이템 사용기간.
	tCostumReformResultStat[4]	= stat4	-- 아이템 사용기간.
	tCostumReformResultStat[5]	= stat5	-- 아이템 사용기간.
	tCostumReformResultStat[6]	= stat6	-- 아이템 사용기간.
	tCostumReformResultStat[7]	= stat7	-- 아이템 사용기간.
	
	tCostumReformResultStat[8]	= stat8	-- 아이템 사용기간.
	tCostumReformResultStat[9]	= stat9	-- 아이템 사용기간.
	tCostumReformResultStat[10]	= stat10	-- 아이템 사용기간.
	tCostumReformResultStat[11]	= stat11	-- 아이템 사용기간.
	tCostumReformResultStat[12]	= stat12	-- 아이템 사용기간.
	tCostumReformResultStat[13]	= stat13	-- 아이템 사용기간.
	tCostumReformResultStat[14]	= stat14	-- 아이템 사용기간.
	
	winMgr:getWindow("CostumUpBackAlphaImg"):setVisible(true)
	
end

-- 코스튬 업그레이드 결과 랜더부분
function CostumUpgradeResultRender(args)
	local local_window		= CEGUI.toWindowEventArgs(args).window
	local _drawer			= local_window:getDrawer()
	
	_drawer:setTextColor(255,255,255,255)
	_drawer:setFont(g_STRING_FONT_GULIM, 11)
	_drawer:drawText("Lv."..tCostumReformResultInfo[1], 22, 61)		-- 레벨

	local Size = GetStringSize(g_STRING_FONT_GULIM, 11, tCostumReformResultInfo[2])
	_drawer:drawText(tCostumReformResultInfo[2], 70 - Size / 2, 80)		-- 아이템 이름
	
	_drawer:drawTexture("UIData/ItemUIData/"..tCostumReformResultInfo[3], 21, 96, 100, 100, 0, 0)		-- 아이템 이미지
	
	-- 아이템 종류
	local CostumkindStr	= CostumKindString(tCostumReformResultInfo[4])
	_drawer:setFont(g_STRING_FONT_GULIM, 10)
	local Size = GetStringSize(g_STRING_FONT_GULIM, 10, CostumkindStr)	
	_drawer:drawText(CostumkindStr, 67 - (Size / 2) + 4, 202)	
	
	-- 기간
	_drawer:setFont(g_STRING_FONT_GULIM, 11)
	Size = GetStringSize(g_STRING_FONT_GULIM, 11, MR_String_12.." : "..tCostumReformResultInfo[5])	
	_drawer:drawText(MR_String_12.." : "..tCostumReformResultInfo[5], 66 - (Size / 2) + 4, 220)	


	-- 스텟

	_drawer:setTextColor(255,198,30,255)
	_drawer:setFont(g_STRING_FONT_GULIM, 14)
	_drawer:drawText(MR_String_72, 143, 60)		-- 성공인지 실패인지
	
	
	local Stat_count	= 0
	local String		= ""
	
	local Stat1	= ""
	local	aa	= 0
	local	bb	= 0
	
	_drawer:setTextColor(87,242,14,255)
	_drawer:setFont(g_STRING_FONT_GULIM, 12)
	
	for i = 1, #tCostumReformResultStat do
		if tCostumReformResultStat[i] ~= 0 then
			if i == 3 or i == 14 then
				aa	= tCostumReformResultStat[i] / 10
				bb	= tCostumReformResultStat[i] % 10
				Stat1 = tostring(aa).."."..bb				
			else				
				Stat1 = tostring(tCostumReformResultStat[i])				
			end
			
			local SignString = ""
			if tCostumReformResultStat[i] > 0 then
				SignString = "+"
				String = tStatNameText[i].." "..SignString..Stat1
			else
				String = tStatNameText[i].." "..SignString..Stat1
			end
			
			_drawer:drawText(String, 143, 130 + (Stat_count - 1) * 20)
			
			Stat_count	= Stat_count + 1
		end
	end
end


-- 코스튬 업그레이드 결과 확인버튼 이벤트
function CostumUpResultOKButtonEvent(args)
	winMgr:getWindow("CostumUpBackAlphaImg"):setVisible(false)

	tHotFixUpgradeInfo	= {['err'] = 0, "", 0, 0, ""}
	
	ToC_HotfixClear()				-- 핫픽스 클리어
	ToC_ClearCostumReformInfo(0)		-- 코스튬 정보 
	ToC_CostumUpdateButtonClick()	-- 아이템 리스트 업데이트

	winMgr:getWindow("MyRoom_ReformBtn"):setEnabled(false)
end



local	bShowResultIcon	= false

-- 핫픽스 결과 아이콘을 띄워준다.
function ShowHotfixResultIcon()
	if bShowResultIcon then
		return
	end
	local Index, ItemNumber	= ToC_GetHotfixResult()
	if Index == 0 then
		ToC_MouseEvent(false)
		HotFixUpButtonOK		= false
		HotfixUpCount			= 0
		HotfixScale				= 150
		bShowResultIcon			= false
		return
	end
	tHotFixUpgradeInfo[2]	= 0
	bShowResultIcon = true
	winMgr:getWindow("MyRoom_HotfixResultIcon"):setTexture("Enabled", tHotFixUpgradeInfo[1], 0, 0)
	winMgr:getWindow("MyRoom_HotfixResultIcon"):setTexture("Disabled", tHotFixUpgradeInfo[1], 0, 0)
	winMgr:getWindow("MyRoom_HotfixResultIcon"):setPosition(195, 350)
	winMgr:getWindow("MyRoom_HotfixResultIcon"):setVisible(true)
	winMgr:getWindow("MyRoom_HotfixMainBackImg"):addChildWindow(winMgr:getWindow("MyRoom_HotfixResultIcon"))
	winMgr:getWindow("MyRoom_HotfixResultIcon"):activeMotion('IconResult')
	
	winMgr:getWindow("MyRoom_HotfixMainBackImg"):addChildWindow(winMgr:getWindow("HotfixResultImg"))

	winMgr:getWindow("HotfixResultImg"):setTexture("Enabled", "UIData/powerup.tga", 531, 382 + (Index - 1) * 20)
	winMgr:getWindow("HotfixResultImg"):setTexture("Disabled", "UIData/powerup.tga", 531,  382 + (Index - 1) * 20)
	winMgr:getWindow("HotfixResultImg"):setVisible(true)
	winMgr:getWindow("HotfixResultImg"):activeMotion('SuccessResult')
	PlayWave('sound/ORB_Result.wav');
	ToC_MouseEvent(false)
	
	local Number = 0
	
	if Index == 1 then	-- 실패
		Number = ItemNumber
	elseif Index == 2 then	-- 성공
		Number = ItemNumber - 1
	end
	
	--후
	local FileName	= MyRoom_GetItemFileName(ItemNumber)
	local Name		= MyRoom_GetItemName(ItemNumber)
	-- 전
	tHotfixResultWindow[1] = MyRoom_GetItemName(Number)
	tHotfixResultWindow[2] = MyRoom_GetItemFileName(Number)
	ShowHotfixResult(Name, FileName, Index)
end




function IconResultEventEnd()
	ToC_GetMyItemList()
	HotFixUpButtonOK	= false
	winMgr:getWindow("HotfixUpgradeResultAlpha"):setVisible(true)
	--winMgr:getWindow("MyRoom_HotfixUpBtn"):setEnabled(true)
	--winMgr:getWindow("MyRoom_ReformBtn"):setEnabled(true)
	
--	Myroom_Mainwindow:addChildWindow(winMgr:getWindow("HotfixResultSuccessImg"))
--	winMgr:getWindow("HotfixResultSuccessImg"):setVisible(true)
--	winMgr:getWindow("HotfixResultSuccessImg"):activeMotion('SuccessResult')
	


end


--------------------------------------------------------------------
-- 마이름 핫픽스 라다오버튼 클릭시.
--------------------------------------------------------------------
function MyRoom_HotfixShow()
	if CEGUI.toRadioButton(winMgr:getWindow("MyRoom_Hotfix")):isSelected() then
		g_SelectedMainTab	= TAB_HOTFIX
		HotFixUpButtonOK	= false
		ToC_CurrentItemRefresh()		--아이템 리프레쉬
		winMgr:getWindow("MyRoom_CharacterBackImg"):setVisible(false)
		winMgr:getWindow("MyRoom_SkillPossesionBackImg"):setVisible(false)
		winMgr:getWindow("MyRoom_SkillUpGradeBackImg"):setVisible(false)
		winMgr:getWindow("MyRoom_HotfixMainBackImg"):setVisible(true)
		
		if winMgr:getWindow("HotfixDropDownContainer") ~= nil then
			winMgr:getWindow("HotfixDropDownContainer"):setVisible(false)
		end
		if CEGUI.toRadioButton(winMgr:getWindow("MyRoom_SpecialTab")):isSelected() == false then	-- 만약 강화 탭이 선택이 안되었다면 선택해준다
			winMgr:getWindow("MyRoom_SpecialTab"):setProperty("Selected", "true")
		end
		ToC_CharacterSetVisible(false)
		ToC_SetMainCategory(2)
		ToC_HotfixClear()	-- 변수 초기화
		tHotFixUpgradeInfo[2]	= 0
		
	end
end




--------------------------------------------------------------------
-- 핫픽스 랜더부분
--------------------------------------------------------------------
function HotfixMainBackRender(args)
	if bItemInfoReceive == false then		-- 아이템 정보를 안받아온 상태라면
		return
	end
	
	local local_window		= CEGUI.toWindowEventArgs(args).window
	local _drawer			= local_window:getDrawer()
	
	_drawer:drawTexture("UIData/powerup.tga",6, 0, 474, 503, 0, 521)			-- 바탕 이미지
	
	
	--============================================ 핫픽스 업그레이드==========================================
	if tHotFixUpgradeInfo[2] ~= 0 then		-- 핫픽스 갯수가 들어있다면
		_drawer:setFont(g_STRING_FONT_GULIM, 13)
		_drawer:setTextColor(87,242,9,255)
		_drawer:drawText(tHotFixUpgradeInfo[4], 35, 275)
		
		for i = 1, tHotFixUpgradeInfo[2] do
			--_drawer:drawTextureWithScale_Angle_Offset(tHotFixUpgradeInfo[1], 33 + (i - 1) * 91, 300, 128, 128, 0, 0,   110, 110, 255, tHotFixImgAngle[tHotFixUpgradeInfo[3]], 8, 164,64)
			if HotFixUpButtonOK then
			
			end
			if tHotFixPosTable[i][5] == true then
				if tHotFixPosTable[i][3] == true then	-- 이미지가 이동중인 놈이면
					if tHotFixPosTable[i][4] == 10 then
						tHotFixPosTable[i][3]	= false
						tHotFixPosTable[i][5]	= false
						HotfixUpCount	= HotfixUpCount + 1
						
						if i ~= 5 then
							tHotFixPosTable[i + 1][3]	= true
							PlayWave('sound/ORB_Move.wav');
						end
					end
					local x, y = GetAniPos(tHotFixPosTable[i], tHotFixEndPos)
					tHotFixPosTable[i][4] = tHotFixPosTable[i][4] + 1
					
					_drawer:drawTextureWithScale_Angle_Offset(tHotFixUpgradeInfo[1], x, y, 100, 100, 0, 0,   150, 150, 255, tHotFixImgAngle[tHotFixUpgradeInfo[3]], 8, 0,0)
				else
					_drawer:drawTexture("UIData/powerup.tga", 24 + (i - 1) * 91, 289, 75, 73, 381, 382)			-- 강화 아이콘 들어갈 이미지
					_drawer:drawTextureWithScale_Angle_Offset(tHotFixUpgradeInfo[1], tHotFixPosTable[i][1], tHotFixPosTable[i][2], 100, 100, 0, 0,   150, 150, 255, tHotFixImgAngle[tHotFixUpgradeInfo[3]], 8, 0,0)
				end
			end
			if i == 5 then
				break
			end			
		end
		-- 핫픽스가 되는 대상
		if HotfixUpCount == 5 then
			if HotfixScale > 0 then
				_drawer:drawTextureWithScale_Angle_Offset(tHotFixUpgradeInfo[1], tHotFixEndPos[1], tHotFixEndPos[2], 100, 100, 0, 0,   HotfixScale, HotfixScale, 255, tHotFixImgAngle[tHotFixUpgradeInfo[3]], 8, 0,0)
				HotfixScale	= HotfixScale - 2
			else	-- 업그레되는 대상의 이미지가 사라져 버리면
				ShowHotfixResultIcon()
				--bShowResultIcon = true
			end
		elseif HotfixUpCount > 0 then
			_drawer:drawTextureWithScale_Angle_Offset(tHotFixUpgradeInfo[1], tHotFixEndPos[1], tHotFixEndPos[2], 100, 100, 0, 0,   150, 150, 255, tHotFixImgAngle[tHotFixUpgradeInfo[3]], 8, 0,0)
			_drawer:setFont(g_STRING_FONT_GULIM, 12)
			_drawer:setTextColor(255,255,255,255)
			_drawer:drawText("x "..HotfixUpCount, tHotFixEndPos[1] + 12 , tHotFixEndPos[2] + 20)
		end		
	else	-- 핫픽스 갯수가 없으면
		_drawer:setFont(g_STRING_FONT_GULIM, 13)
		_drawer:setTextColor(255,255,255,255)
		_drawer:drawText(MR_String_68, 35, 275)
	
	end
	--========================================================================================================
	
	--===========================================코스튬 리폼==================================================
	
	
	_drawer:drawTexture("UIData/powerup.tga", 19, 45, 85, 85, 296, 382)				-- 강화할 코스튬이미지 들어갈 부분
	_drawer:drawTexture("UIData/powerup.tga", 283, 48, 75, 73, 456, 382)			-- 강화 아이콘 들어갈 이미지
		
	------------------------------------
	-- 코스튬 리폼(코스튬 부분)
	------------------------------------	
	if CostumReformList[REFORM_COSTUM][2] ~= "" then  -- 파일경로
		if g_IsImpossible == 0 then	-- 등록 가능한 아이템 == 0 ★
			
			-- 코스튬 아바타 등록 ★
			DrawORB_CostumeAvatarIcons(_drawer , "UIData/ItemUIData/"..CostumReformList[REFORM_COSTUM][2] , g_CostumeType , g_Attach)
			
			-- 코스튬 이름
			_drawer:setFont(g_STRING_FONT_GULIM, 12)
			_drawer:setTextColor(255,205,86,255)
			local Size = GetStringSize(g_STRING_FONT_GULIM, 12, CostumReformList[REFORM_COSTUM][1])
			_drawer:drawText(CostumReformList[REFORM_COSTUM][1], 62 - Size / 2, 36)

			local StatString	= ""
			local Count			= 0
			
			_drawer:setFont(g_STRING_FONT_GULIM, 12)
			_drawer:setTextColor(87, 242, 9, 255)
			
			-- 확인차 뿌려줌
			--[[
			for i = 5, 15 do
				local Statstring = tostring(CostumHotfixStat[i-4])
				DebugStr('Statstring:'..Statstring)
			end
			--]]
			
			for i = 5, 11 do
				local Stat	= CostumHotfixStat[i-4]
				local Statstring = tostring(CostumReformList[REFORM_COSTUM][i])
				--DebugStr('Statstring:'..Statstring)
				if CostumReformList[REFORM_COSTUM][i] + Stat ~= 0 then
					Count	= Count + 1
				end
			end
			
			if Count ~= 0 then
				StartPos	= (186 - Count * 16) / 2
				Count = 0
					
				for i = 5, 11 do
				
					local Stat	= CostumHotfixStat[i-4]
					if CostumReformList[REFORM_COSTUM][i] + Stat ~= 0 then
						local resultstat = CostumReformList[REFORM_COSTUM][i] + Stat
						local orbStat = tostring(Stat)
						--DebugStr('orbStat:'..orbStat)
						if i == 7 or i == 17 then
							resultstat = GetDecimalPoint(resultstat)
						end					
						if Stat == 0 then	-- 핫픽스 스텟이 없을경우
							StatString = tStatNameText[i - 4].." +"..CostumReformList[REFORM_COSTUM][i]			
						else
							if i == 7 or i == 17 then
								orbStat = GetDecimalPoint(Stat)
							end	
							StatString = tStatNameText[i - 4].." +"..tostring(resultstat).." (orb +"..orbStat..")"
						end
						--StatString = tStatNameText[i - 4].." +"..CostumReformList[REFORM_COSTUM][i]			
						_drawer:drawText(StatString, 112, StartPos + Count * 16)
						Count	= Count + 1
					end
				end
			end
			
			
			-- 코스튬 리폼 가능횟수
			_drawer:setFont(g_STRING_FONT_GULIM, 12)
			_drawer:setTextColor(255,255,255,255)
			local	String	= MR_String_71.."( "..CostumReformList[REFORM_COSTUM][12].." / "..CostumReformList[REFORM_COSTUM][3].." )"
			local	Size = GetStringSize(g_STRING_FONT_GULIM, 12, String)
			_drawer:drawText(String, 126 - Size / 2, 152)
			
		else
			_drawer:drawTextureWithScale_Angle_Offset("UIData/my_room.tga" , 63, 88, 100, 100, 817, 615,   180, 180, 255, 0, 8, 0,0)
			
			-- 강화할 코스튬을 더블클릭하세요
			_drawer:setFont(g_STRING_FONT_GULIM, 12)
			_drawer:setTextColor(255,255,255,255)
			_drawer:drawText(MR_String_69, 114, 62)
		end
		
	end
	
	------------------------------------
	-- 코스튬 리폼(핫픽스 부분)
	------------------------------------	
	if CostumReformList[REFORM_HOTFIX][2] ~= "" then
		_drawer:drawTextureWithScale_Angle_Offset("UIData/ItemUIData/"..CostumReformList[REFORM_HOTFIX][2], 322, 85, 100, 100, 0, 0,   180, 180, 255, 0, 8, 0,0)
		
		_drawer:setFont(g_STRING_FONT_GULIM, 12)
		_drawer:setTextColor(255,205,86,255)
		_drawer:drawText(CostumReformList[REFORM_HOTFIX][1], 289, 36)
		
		-- 핫픽스 스텟
		-- Jiyuu : 핫픽스의 기본 스탯만 가져온다.
		_drawer:setFont(g_STRING_FONT_GULIM, 12)
		_drawer:setTextColor(87, 242, 9, 255)
		
		local BaseHotfixStatInfo = {['err'] = 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
		
		BaseHotfixStatInfo[1], BaseHotfixStatInfo[2], BaseHotfixStatInfo[3], BaseHotfixStatInfo[4], 
		BaseHotfixStatInfo[5], BaseHotfixStatInfo[6], BaseHotfixStatInfo[7],BaseHotfixStatInfo[8], BaseHotfixStatInfo[9], 
		BaseHotfixStatInfo[10], BaseHotfixStatInfo[11], BaseHotfixStatInfo[12], BaseHotfixStatInfo[13], BaseHotfixStatInfo[14] = ToC_GetItemStatInfo( HotfixNumber )
		
		local StatString	= ""
		local count = 0
		
		for i = #BaseHotfixStatInfo, 1, -1 do
			if BaseHotfixStatInfo[i] ~= 0 then
					local orbStat = tostring(BaseHotfixStatInfo[i])
					if i == 3 or i == 14 then  -- 크리티컬 확률이나 크리티컬 데미지 일시 
						orbStat = GetDecimalPoint(BaseHotfixStatInfo[i])
					end		
					
					StatString = tStatNameText[i].." +"..orbStat
					_drawer:drawText(StatString, 358, 73 + ( count )*20)	
					count = count + 1;
			end
		end
		
		
	else	-- 등록된 핫픽스가 없을때.
		-- 강화할 을 더블클릭하세요
		_drawer:setFont(g_STRING_FONT_GULIM, 12)
		_drawer:setTextColor(255,255,255,255)
		_drawer:drawText(MR_String_70, 362, 62)
	end
end



function GetAniPos(tStartPosTable, tEndPosTable)
	local	PosX, PosY	= ToC_HotfixAniMovePos(tStartPosTable[1], tEndPosTable[1], tStartPosTable[2], tEndPosTable[2], tStartPosTable[4])
		
	return PosX, PosY
end

-- 코스튬 리폼하기 버튼이벤트
function MyRoom_ReformBtnEvent(args)
	-- 샵쪽에서 쓰는 팝업창은 공통으로 쓰기위해====
	local ButtonName	= {['protecterr']=0, "NCS_WearOKButton", "NCS_WearCancelButton"}
	local ButtonEvent	= {['protecterr']=0, "MyRoom_ClickItemReformOk", "MyRoom_ClickItemReformCancel"}
	
	for i=1, #ButtonName do
		winMgr:getWindow(ButtonName[i]):subscribeEvent("Clicked", ButtonEvent[i])
	end
	
	winMgr:getWindow('NCS_WearConfirmImage'):setUserString("noFunction", "MyRoom_ClickItemReformCancel")
	winMgr:getWindow('NCS_WearConfirmImage'):setUserString("okFunction", "MyRoom_ClickItemReformOk")
	--=============================================

	winMgr:getWindow('NCS_WearConfirmText'):clearTextExtends();
	winMgr:getWindow('NCS_WearConfirmText'):addTextExtends(MR_String_73, g_STRING_FONT_DODUMCHE, 115,255,255,255,255,    2, 0,0,0,255);	

	Realroot:addChildWindow(winMgr:getWindow('NCS_WearConfirmAlphaImage'));
	winMgr:getWindow('NCS_WearConfirmAlphaImage'):setVisible(true)
end


function MyRoom_ClickItemReformOk()
	local okfunc = winMgr:getWindow('NCS_WearConfirmImage'):getUserString("okFunction")
	if okfunc ~= "MyRoom_ClickItemReformOk" then
		return
	end
	winMgr:getWindow('NCS_WearConfirmImage'):setUserString("okFunction", "")
	winMgr:getWindow('NCS_WearConfirmAlphaImage'):setVisible(false)
	ToC_CostumUpgradeButtonClick(tCostumReformInfoTable[REFORM_COSTUM], tCostumReformInfoTable[REFORM_HOTFIX], tCostumReformInfoTable[REFORM_ATTACH])
end


function MyRoom_ClickItemReformCancel()
	local nofunc = winMgr:getWindow('NCS_WearConfirmImage'):getUserString("noFunction")
	if nofunc ~= "MyRoom_ClickItemReformCancel" then
		return
	end
	winMgr:getWindow('NCS_WearConfirmImage'):setUserString("noFunction", "")
	winMgr:getWindow('NCS_WearConfirmAlphaImage'):setVisible(false)

end


-- 핫픽스 업그레이드 버튼이벤트
function MyRoom_HotfixUpBtnEvent(args)
	if tHotFixUpgradeInfo[2] >= Max_HotUpgradeCount then
		
		HotFixUpButtonOK		= true
		winMgr:getWindow("MyRoom_ReformBtn"):setEnabled(false)
		winMgr:getWindow("MyRoom_HotfixUpBtn"):setEnabled(false)
		
		for i = 1, #tHotFixPosTable do
			if i == 1 then
				tHotFixPosTable[i][3]	= true
			else
				tHotFixPosTable[i][3]	= false
			end
			
		end
		ToC_HotfixUpgradeButtonClick()
		ToC_ClearCostumReformInfo(1)		-- 코스튬 정보 
		PlayWave('sound/ORB_Move.wav');
		ToC_MouseEvent(true)
	else
		-- 핫픽스가 모지랍니다.
		ShowNotifyOKMessage_Lua(MR_String_67)		
	end
end



--------------------------------------------------------------------
-- 핫픽스 업그레이드할 정보를 업데이트 시켜준다
--------------------------------------------------------------------
function HotfixUpgradeRegist(FileName, RemainCount, ItemName)
	tHotFixUpgradeInfo[1]	= "UIData/ItemUIData/"..FileName
	tHotFixUpgradeInfo[2]	= RemainCount
	tHotFixUpgradeInfo[4]	= ItemName
	
	for i = 1, #tHotFixPosTable do
		tHotFixPosTable[i][3]	= false
		tHotFixPosTable[i][4]	= 0
		tHotFixPosTable[i][5]	= true
	end
	
end


--------------------------------------------------------------------
-- 핫픽스 애니메이션을 돌려준다.
--------------------------------------------------------------------
function HotfixAnimation(Tick, a)
	if HotFixUpButtonOK then
		tHotFixUpgradeInfo[3]	= Tick		
	end
end





--------------------------------------------------------------------

-- 핫픽스 어디에 사용할 건지 물어보는 창

--------------------------------------------------------------------
--------------------------------------------------------------------
-- 핫픽스 어디에 사용할 건지 물어보는 뒷판
--------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'Hotfix_WhereAlphaImage');
mywindow:setTexture('Enabled', 'UIData/OnDLGBackImage.tga', 0, 0);
mywindow:setTexture('Disnabled', 'UIData/OnDLGBackImage.tga', 0, 0);
mywindow:setPosition(0,0);
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow);


--------------------------------------------------------------------
-- 핫픽스 어디에 사용할 건지 물어보는 메인창
--------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'Hotfix_WhereImage');
mywindow:setTexture('Enabled', 'UIData/popup001.tga', 0, 0);
mywindow:setTexture('Disnabled', 'UIData/popup001.tga', 0, 0);
mywindow:setPosition((1024 - 340) / 2, (768 - 268) / 2);
mywindow:setSize(340, 268);
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow('Hotfix_WhereAlphaImage'):addChildWindow(mywindow);

--------------------------------------------------------------------
-- 핫픽스 어디에 사용할 건지 물어보는 텍스트
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "Hotfix_WhereText");
mywindow:setVisible(true);
mywindow:setEnabled(false)
mywindow:setPosition(3, 45);
mywindow:setSize(340, 180);
mywindow:setViewTextMode(1);
mywindow:setAlign(7);
mywindow:setLineSpacing(2);
winMgr:getWindow('Hotfix_WhereImage'):addChildWindow(mywindow);
mywindow:clearTextExtends();
mywindow:addTextExtends(MR_String_74, g_STRING_FONT_DODUMCHE, 115,255,255,255,255,    2, 0,0,0,255);	


--------------------------------------------------------------------
-- 버튼 (확인, 취소)
--------------------------------------------------------------------
ButtonName	= {['protecterr']=0, "Hotfix_CostumReform", "Hotfix_HotfixUpgrade"}
ButtonTexX	= {['protecterr']=0,		693,			858}
ButtonPosX	= {['protecterr']=0,		4,				169}		
ButtonEvent	= {['protecterr']=0, "Hotfix_CostumReformEvent", "Hotfix_HotfixUpgradeEvent"}

for i=1, #ButtonName do
	mywindow = winMgr:createWindow("TaharezLook/Button", ButtonName[i])
	mywindow:setTexture("Normal", "UIData/popup001.tga", ButtonTexX[i], 0)
	mywindow:setTexture("Hover", "UIData/popup001.tga", ButtonTexX[i], 29)
	mywindow:setTexture("Pushed", "UIData/popup001.tga", ButtonTexX[i], 58)
	mywindow:setTexture("Disabled", "UIData/popup001.tga", ButtonTexX[i], 87)
	mywindow:setPosition(ButtonPosX[i], 235)
	mywindow:setSize(166, 29)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:subscribeEvent("Clicked", ButtonEvent[i])
	winMgr:getWindow('Hotfix_WhereImage'):addChildWindow(mywindow)
end

function Hotfix_CostumReformEvent()
	-- 둘다 등록이 됐는지 확인하는 함수
	--DebugStr("ToC_SetCostumReformInfo2\nToC_SetCostumReformInfo2") -- 오브 선택할때 들어온다
	g_IsImpossible = ToC_SetCostumReformInfo(HotfixItemNumber, HotfixItemIndex)
	--DebugStr("오브 g_IsImpossible : " .. tostring(g_IsImpossible)) -- 오브 선택할때 들어온다
	
	winMgr:getWindow("MyRoom_CostumeTab"):setProperty("Selected", "true")	-- 코스튬탭 선택한다.
	
	-- 버튼이 활성화돼는지 확인한다
	local Check		= ToC_ConfirmEnableReformCheck()
	
	if Check == 1 and g_IsImpossible == 0 then
		winMgr:getWindow("MyRoom_ReformBtn"):setEnabled(true)
		--DebugStr("3053 Line 의 버튼 이네이블")
	else
		winMgr:getWindow("MyRoom_ReformBtn"):setEnabled(false)
	end
	winMgr:getWindow("Hotfix_WhereAlphaImage"):setVisible(false)
	
end


function Hotfix_HotfixUpgradeEvent()
	local Success	= ToC_HotfixRegist(HotfixItemNumber, HotfixItemIndex)
	
	if Success then
		HotFixUpButtonOK		= false
		HotfixUpCount			= 0
		HotfixScale				= 150
		bShowResultIcon			= false
		winMgr:getWindow("MyRoom_HotfixResultIcon"):setVisible(false)
		winMgr:getWindow("HotfixResultImg"):setVisible(false)			
		winMgr:getWindow("MyRoom_HotfixUpBtn"):setEnabled(true)		
		
		-- 버튼이 활성화돼는지 확인한다
		local Check		= ToC_ConfirmEnableReformCheck()
		if Check then
			winMgr:getWindow("MyRoom_ReformBtn"):setEnabled(true)
			--DebugStr("3078 Line 의 버튼 이네이블")
		else
			winMgr:getWindow("MyRoom_ReformBtn"):setEnabled(false)
		end
		winMgr:getWindow("Hotfix_WhereAlphaImage"):setVisible(false)
	end
	
end


--=========================================================================================================









--------------------------------------------------------------------

-- 마이룸에서 사용하는 함수

--------------------------------------------------------------------

--------------------------------------------------------------------
-- 내 그랑, 코인, 캐쉬를 불러온다.
--------------------------------------------------------------------
function MyPropertyList(Gran, Coin, Cash)
	local r, g, b	= GetGranColor(Gran)
	winMgr:getWindow("MyRoom_HaveGranText"):setTextExtends(CommatoMoneyStr64(Gran), g_STRING_FONT_GULIMCHE,12, r, g, b, 255,  0,  0,0,0,255);
	r, g, b	= ColorToMoney(Coin)
	winMgr:getWindow("MyRoom_HaveCoinText"):setTextExtends(CommatoMoneyStr(Coin), g_STRING_FONT_GULIMCHE,12, r, g, b, 255,  0,  0,0,0,255);
	r, g, b	= ColorToMoney(Cash)
	winMgr:getWindow("MyRoom_HaveCashText"):setTextExtends(CommatoMoneyStr(Cash), g_STRING_FONT_GULIMCHE,12, r, g, b, 255,  0,  0,0,0,255);

end

--------------------------------------------------------------------
-- 케릭이름, 래더등급, 레벨, 전체경험치, 클래스, 클럽, 칭호 
--------------------------------------------------------------------
function MyRoom_MyBaseInfo(Name, Ladder, Level, Exp, Promotion, club, Title)
	
	
	
	

	local ExptoLevel	= GetExptoLevel(level);

end


--------------------------------------------------------------------
-- 마이룸 시작
--------------------------------------------------------------------
function InitMyRoom()
	-- 아이콘에 스킬정보들 저장
	for i = 1, #tAllSkillTree do
		for j = 1, #tAllSkillTree[i] do
			for k = 1, tSkillCountTable[i][j] do
				local ItemNumber	= tonumber(winMgr:getWindow("SkillIcon"..i..j..k):getUserString("SkillItemNum"))
				local index			= tonumber(winMgr:getWindow("SkillIcon"..i..j..k):getUserString("SkillItemIndex"))
				if ItemNumber ~= 0 then				
					local ItemName, FileName, ItemDesc, Promotion, Grade, level, attribute = ToC_GetItemInfo(ItemNumber, index)
					winMgr:getWindow("SkillIcon"..i..j..k):setUserString("ItemName", tostring(ItemName))		-- 아이템이름
					winMgr:getWindow("SkillIcon"..i..j..k):setUserString("FileName", tostring(FileName))		-- 파일경로
					winMgr:getWindow("SkillIcon"..i..j..k):setUserString("ItemDesc", tostring(ItemDesc))		-- 아이템설명
					winMgr:getWindow("SkillIcon"..i..j..k):setUserString("Promotion", tostring(Promotion))	-- 아이템 직업
				else
					winMgr:getWindow("SkillIcon"..i..j..k):setVisible(false)
				end
			end
		end
	end
	KindTabEvent(1)
	winMgr:getWindow('BPM_MoveMyroomButton'):setEnabled(false)
end


--------------------------------------------------------------------
-- 마이름 리프레쉬
--------------------------------------------------------------------
function MyRoom_Refresh(itemKind)
	-- Empty이미지 셋팅
	
	for i = 1, PAGE_MAXITEM do
		local ItemWindow = "MyRoom_EmptyOrItem"..tostring(i)
		winMgr:getWindow(ItemWindow):setTexture("Enabled", "UIData/my_room.tga", 817, 615)
		winMgr:getWindow(ItemWindow):setTexture("Disabled", "UIData/my_room.tga", 817, 615)
		
		ItemWindow = "MyRoom_Item"..tostring(i)
		winMgr:getWindow(ItemWindow):setVisible(false)
		winMgr:getWindow(ItemWindow):setProperty("Selected", "false")
	end
	-- 페이지 셋팅
	local	CurrentPage, TotalPage	= ToC_GetPageNumber()
	MyRoom_PageSetting(CurrentPage, TotalPage)
end

local ButtonTexData					= {['protecterr']=0, }
ButtonTexData.tItemButtonInfo		= {['protecterr']=0, "UIData/my_room.tga",	701,	584,	615}
ButtonTexData.tSkillButtonInfo		= {['protecterr']=0, "UIData/my_room2.tga", 724,	602,	3}
ButtonTexData.tDisableButtonInfo	= {['protecterr']=0, "UIData/my_room2.tga", 846,	846,	3}


--------------------------------------------------------------------
-- 아이템 정보 저장, 아이템에따라 초기화설정
--------------------------------------------------------------------
function WndMyRoom_DrawItemTexture(ItemIndex,	ListIndex,	sItemNameFile,	sItemNameFile2, RelationproductNo,	ItemNumber,		ItemName,		Locked,		Level,	 attach,
								   Name2,		boneType,	bWear,			bSet,			ItemExpireTime,		ExpiredCheck,	nCostumeKind,	ItemKind,	TabKind, Promotion, 
								   -- From Jiyuu : 핫픽스 능력치 2개에 따른 내용 변경
								   --itemGrade,	PayType,	bUse,			attribute,		avatarCostumeType,	HotFixStatKind, HotFixStat,		IsCash,		nRentalSkill ) -- 인자 : 29개
								   itemGrade,	PayType,	bUse,			attribute,		avatarCostumeType,	HotFixStatKind, HotFixStat,		HotFixStatKind2, HotFixStat2, 
								   IsCash,		nRentalSkill ) -- 인자 : 31개
								   
	-- 아이템이 있기떄문에 Empty이미지 바꿔준다.
	local ItemWindow = "MyRoom_EmptyOrItem"..tostring(ItemIndex);
	local ItemRadioWindow = "MyRoom_Item"..tostring(ItemIndex);
	local MyButtonData	= {['protecterr']=0, }
	winMgr:getWindow("MyRoom_ItemDisable"..ItemIndex):setVisible(false)
	
	if TabKind == 1 then	-- 스킬
		winMgr:getWindow(ItemWindow):setTexture("Enabled", "UIData/my_room2.tga", 480, 3)
		winMgr:getWindow(ItemWindow):setTexture("Disabled", "UIData/my_room2.tga", 477, 0)
		MyButtonData = ButtonTexData.tSkillButtonInfo
		--SkillTreeRefresh(bWear, ItemNumber)		-- 스킬 리프레쉬 해준다.(c에서 해주는걸로 바꿈)
		
	else					-- 나머지(코스튬, 인벤토리 아이템)
		winMgr:getWindow(ItemWindow):setTexture("Enabled", "UIData/my_room.tga", 465, 615)
		winMgr:getWindow(ItemWindow):setTexture("Disabled", "UIData/my_room.tga", 465, 615)
		MyButtonData = ButtonTexData.tItemButtonInfo	
		
	end
	
	winMgr:getWindow(ItemRadioWindow):setTexture("Normal", "UIData/invisible.tga", 465, 615)
	
	-- 기간 만료된 아이템
	if ExpiredCheck == 1 then
		winMgr:getWindow("MyRoom_ItemDisable"..ItemIndex):setVisible(true)
	end

	local _my_name, _money, _level, _promotion, _my_style, _type, _sp_point, _hp_point, _experience = GetMyInfo(false);
	if TabKind == 0 then
		if _type ~= boneType or Level > _level then
			winMgr:getWindow("MyRoom_ItemDisable"..ItemIndex):setVisible(true)
		end		
	elseif TabKind == 1 then
		if bUse == 0 then	-- 착용할 수 없다
			winMgr:getWindow("MyRoom_ItemDisable"..ItemIndex):setVisible(true)			
		end			
	end
	
	-- 라디오버튼에대한 텍스쳐설정
	winMgr:getWindow(ItemRadioWindow):setTexture("Hover", MyButtonData[1], MyButtonData[2], MyButtonData[4])
	winMgr:getWindow(ItemRadioWindow):setTexture("Pushed", MyButtonData[1], MyButtonData[3], MyButtonData[4])
	winMgr:getWindow(ItemRadioWindow):setTexture("SelectedNormal", MyButtonData[1], MyButtonData[3], MyButtonData[4])
	winMgr:getWindow(ItemRadioWindow):setTexture("SelectedHover", MyButtonData[1], MyButtonData[3], MyButtonData[4])
	winMgr:getWindow(ItemRadioWindow):setTexture("SelectedPushed", MyButtonData[1], MyButtonData[3], MyButtonData[4])
		
	-- 라디오버튼 활성화
	ItemWindow = "MyRoom_Item"..tostring(ItemIndex)
	winMgr:getWindow(ItemWindow):setVisible(true)
	
	-- 라디오버튼안에 정보들 저장
	local	Buttonwin		= winMgr:getWindow(ItemWindow);
	
	Buttonwin:setUserString('ItemIndex',		tostring(ItemIndex));				-- 보여주는 아이템의 인덱스
	Buttonwin:setUserString('ListIndex',		tostring(ListIndex));				-- 아이템 리스트의 아이템 인덱스
	Buttonwin:setUserString('ItemNameFile',		sItemNameFile);						-- 아이템 파일 경로
	Buttonwin:setUserString('ItemNameFile2',	sItemNameFile2);					-- 아이템 파일 경로	
	Buttonwin:setUserString('RelationproductNo',tostring(RelationproductNo));		-- 프로덕트 넘버
	Buttonwin:setUserString('ItemNumber',		tostring(ItemNumber));				-- 아이템 넘버
	Buttonwin:setUserString('ItemName',			tostring(ItemName));				-- 아이템 이름
	Buttonwin:setUserString('Locked',			tostring(Locked));					-- 아이템 가격
	Buttonwin:setUserString('Level',			tostring(Level));					-- 아이템 레벨
	Buttonwin:setUserString('attach',			tostring(attach));					-- 아이템 부위
	Buttonwin:setUserString('Name2',			tostring(Name2));					-- 아이템 설명
	Buttonwin:setUserString('boneType',			tostring(boneType));				-- 아이템 본타입
	Buttonwin:setUserString('bWear',			tostring(bWear));					-- 사용중인 아이템인지
	Buttonwin:setUserString('bSet',				tostring(bSet));					-- 세트아이템인지
	Buttonwin:setUserString('ItemExpireTime',	tostring(ItemExpireTime));			-- 아이템 만료날짜
	Buttonwin:setUserString('ExpiredCheck',		tostring(ExpiredCheck));			-- 만료체크
	Buttonwin:setUserString('CostumeKind',		tostring(nCostumeKind));			-- 코스튬 종류(ex. 상의, 하의)
	Buttonwin:setUserString('ItemKind',			tostring(ItemKind));				-- 아이템 종류
	Buttonwin:setUserString('TabKind',			tostring(TabKind));					-- 선택한 탭종류(스킬, 아이템, 소비, 강화)
	Buttonwin:setUserString('Promotion',		tostring(Promotion));				-- 스킬을 위해 사용해줄 프로모션 인덱스
	Buttonwin:setUserString('ItemGrade',		tostring(itemGrade));				-- 스킬을 위해 사용해줄 스킬 업그레이드 레벨
	Buttonwin:setUserString('PayType',			tostring(PayType));					-- 지불수단(인벤토리는 스텟 종류)
	Buttonwin:setUserString('bUse',				tostring(bUse));					-- 붙이는 부위(인벤토리는 스텟)
	Buttonwin:setUserString('attribute',		tostring(attribute));				-- 속성
	Buttonwin:setUserString('CostumeType',		tostring(avatarCostumeType));		-- 코스튬 아바타 유무
	Buttonwin:setUserString('nRental',			tostring(nRentalSkill));			-- 랜탈 스킬 유무
	
	MainButtonSetting(bWear, ItemIndex, ItemNumber, ItemKind, nCostumeKind, avatarCostumeType) -- 버튼을 설정해준다.
	bItemInfoReceive = true -- 아이템정보를 받아왔는지 확인
	
	if CheckDetailInfoBtn(ItemNumber) then
		winMgr:getWindow("MyRoom_DetailIInfoBtn"..ItemIndex):setVisible(true)
	else
		winMgr:getWindow("MyRoom_DetailIInfoBtn"..ItemIndex):setVisible(false)
	end	
	
	
end



-- 탭에따라 아이템에 맞는 버튼을 띄워준다.
function MainButtonSetting(bWear, ItemIndex, ItemNumber, ItemKind, nCostumeKind, nAvatarType)
	
	local	tButtonVisible	= {['err'] = 0, true, true, true, true}	-- 등록, 착용, 해제, 삭제
	local	tButtonEnable	= {['err'] = 0, true, true, true, true}
	
	if ItemNumber <= 36 then
		tButtonEnable[3]	= false		-- 기본아이템이면 해제버튼 Enable false
		tButtonEnable[4]	= false		-- 기본아이템이면 삭제버튼 Enable false
	end
		
	if g_SelectedMainTab == TAB_CHARACTER then
		tButtonVisible[1]	= false	
		if bWear == 0 then					-- 착용했는지
			tButtonVisible[3] = false		-- 착용안했으면 해제버튼 false
		else
			tButtonVisible[2] = false		-- 착용했으면 착용버튼 false
		end
				
		
		if nCostumeKind == 0 then
			--DebugStr(" 1  nCostumeKind : " .. nCostumeKind)
			tButtonEnable[2] = false
			tButtonEnable[3] = false
		end
		
	elseif g_SelectedMainTab == TAB_MY_SKILL then
		tButtonVisible[1] = false
		
		if bWear == 0 then					-- 착용했는지
			tButtonVisible[3] = false		-- 착용안했으면 해제버튼 false
		else
			tButtonVisible[2] = false		-- 착용했으면 착용버튼 false
		end
		
		if ItemKind ~= 1 and nCostumeKind == 0 then -- 스킬이 아니고 따른거일떄
			
			tButtonEnable[2]	= false
			tButtonEnable[3]	= false
		end
		
	elseif g_SelectedMainTab == TAB_HOTFIX then
		tButtonVisible[2] = false
		tButtonVisible[3] = false
		
		if ItemKind == 0 or ItemKind == 24 then
			
		else
			tButtonEnable[1] = false
		end
		
	elseif g_SelectedMainTab == TAB_UPGRADE_SKILL then
		tButtonVisible[2] = false
		tButtonVisible[3] = false
		if ItemKind == 1 or ItemKind == 25 then
			
		else
			tButtonEnable[1] = false
		end
	end



	-- Set Visible
	winMgr:getWindow("MyRoom_RegistBtn"..ItemIndex):setVisible(tButtonVisible[1])	-- 등록버튼
	winMgr:getWindow("MyRoom_UseBtn"..ItemIndex):setVisible(tButtonVisible[2])		-- 착용버튼
	winMgr:getWindow("MyRoom_ReleaseBtn"..ItemIndex):setVisible(tButtonVisible[3])	-- 해제버튼
	--winMgr:getWindow("MyRoom_DeleteBtn"..ItemIndex):setVisible(tButtonVisible[4])	-- 삭제버튼
	
	-- Set Enable
	winMgr:getWindow("MyRoom_RegistBtn"..ItemIndex):setEnabled(tButtonEnable[1])	-- 등록버튼
	winMgr:getWindow("MyRoom_UseBtn"..ItemIndex):setEnabled(tButtonEnable[2])		-- 착용버튼
	winMgr:getWindow("MyRoom_ReleaseBtn"..ItemIndex):setEnabled(tButtonEnable[3])	-- 해제버튼
	--winMgr:getWindow("MyRoom_DeleteBtn"..ItemIndex):setEnabled(tButtonEnable[4])	-- 삭제버튼
	
	if tButtonEnable[2] == true then
		--DebugStr("참 : " .. ItemIndex)
	else
		--DebugStr("거짓 : " .. ItemIndex)
	end


	-- 탭에 관계없이 비쥬얼 아바타와 오염된 아바타는 버튼을 없앤다★
	if nAvatarType == -3 or nAvatarType == -2 then
		winMgr:getWindow("MyRoom_RegistBtn"..ItemIndex):setEnabled(false)	-- 등록버튼
		winMgr:getWindow("MyRoom_UseBtn"..ItemIndex):setEnabled(false)		-- 착용버튼
		winMgr:getWindow("MyRoom_ReleaseBtn"..ItemIndex):setEnabled(false)	-- 해제버튼
		--winMgr:getWindow("MyRoom_DeleteBtn"..ItemIndex):setEnabled(false)	-- 삭제버튼
		
		return
	end
	
	-- 탭에 관계없이 외형이 설정된 클론 아바타는 버튼을 없앤다 ★
	if nAvatarType > 0 then
		winMgr:getWindow("MyRoom_RegistBtn"..ItemIndex):setVisible(false)	-- 등록버튼
		winMgr:getWindow("MyRoom_UseBtn"..ItemIndex):setVisible(tButtonVisible[2])		-- 착용버튼
		winMgr:getWindow("MyRoom_ReleaseBtn"..ItemIndex):setVisible(tButtonVisible[3])	-- 해제버튼
		--winMgr:getWindow("MyRoom_DeleteBtn"..ItemIndex):setVisible(tButtonVisible[4])	-- 삭제버튼
	
		--winMgr:getWindow("MyRoom_DeleteBtn"..ItemIndex):setEnabled(false)	-- 삭제버튼
		winMgr:getWindow("MyRoom_UseBtn"..ItemIndex):setEnabled(tButtonEnable[2])		-- 착용버튼
		winMgr:getWindow("MyRoom_ReleaseBtn"..ItemIndex):setEnabled(tButtonEnable[3])	-- 해제버튼
		
		return
	end
end


--------------------------------------------------------------------
-- 스킬트리 refresh
--------------------------------------------------------------------
function SkillTreeRefresh(bwear, itemnumber, itemIndex)
	
	local SkillCount	= 0
	
	for i = 1, #tAllSkillTree do
		for j = 1, #tAllSkillTree[i] do
			for k = 1, tSkillCountTable[i][j] do
				local Skill_ItemNumber	= tonumber(winMgr:getWindow("SkillIcon"..i..j..k):getUserString("SkillItemNum"))
				local bCkeck	= ToC_SkillKindConfirm(Skill_ItemNumber % 100, itemnumber)		-- 동일한 종류의 스킬인지 알아온다.

				if bCkeck then
					if bwear == 1 then
						winMgr:getWindow("SkillIcon"..i..j..k):setUserString("SkillItemNum", tostring(itemnumber))
						winMgr:getWindow("SkillIcon"..i..j..k):setUserString("SkillItemIndex", tostring(itemIndex))
					else
						winMgr:getWindow("SkillIcon"..i..j..k):setUserString("SkillItemNum", tostring(tBaseSkillTable[SkillCount]))
						winMgr:getWindow("SkillIcon"..i..j..k):setUserString("SkillItemIndex", tostring(-1))
					end					
					return
				end
				SkillCount = SkillCount + 1
			end
		end
	end
	
end

--[[
--------------------------------------------------------------------
-- 착용중인 코스튬목록을 알아온다
--------------------------------------------------------------------
function GetWearCostumIndexList(index, level, Desc, FileName, ItemName)
	local MyWindow	= winMgr:getWindow("WearItemImage"..tWearCostumIndex[index])
	
	MyWindow:setUserString('level',		tostring(level));
	MyWindow:setUserString('Desc',		tostring(Desc));
	MyWindow:setUserString('FileName',	tostring(FileName));
	MyWindow:setUserString('ItemName',	tostring(ItemName));
		
	MyWindow:setVisible(true)		-- 착용중인 코스튬
end
--]]
--------------------------------------------------------------------
-- 각각의 아이템들의 랜더부분
--------------------------------------------------------------------
function MyRoom_ItemRender(args)
	if bItemInfoReceive == false then		-- 아이템 정보를 안받아온 상태라면
		return
	end
	local _drawer			= CEGUI.toWindowEventArgs(args).window:getDrawer()
	local local_window		= CEGUI.toWindowEventArgs(args).window

	local ItemName			=  MyRoom_GetItemName(local_window:getUserString("ItemNumber") )--local_window:getUserString("ItemName")
	local ItemFileName		= local_window:getUserString("ItemNameFile")
	local ItemFileName2		= local_window:getUserString("ItemNameFile2")
	
	local ItemLevel			= tonumber(local_window:getUserString("Level"))
	local CostumeKind		= tonumber(local_window:getUserString("CostumeKind"))
	local ItemExpireTime	= local_window:getUserString("ItemExpireTime")
	local TabKind			= tonumber(local_window:getUserString("TabKind"))
	local strDesc			= MyRoom_GetItemDescription( local_window:getUserString("ItemNumber") )--local_window:getUserString("strDesc")
	local bWear				= tonumber(local_window:getUserString("bWear"))
	local ExpiredCheck		= tonumber(local_window:getUserString("ExpiredCheck"))
	local RelationproductNo	= tonumber(local_window:getUserString("RelationproductNo"))		-- 인벤토리 목록은 아이템 카운트숫자.
	local ItemKind			= tonumber(local_window:getUserString("ItemKind"))			-- 아이템 카인드
	local Promotion			= tonumber(local_window:getUserString("Promotion"))			-- 프로모션 인덱스
	local ItemGrade			= tonumber(local_window:getUserString("ItemGrade"))			-- 스킬 등급
	local Locked			= tonumber(local_window:getUserString("Locked"))			-- 스킬 등급
	local Name2				= local_window:getUserString("Name2")						-- 아이템 두번째 이름(기간)
	local attribute			= tonumber(local_window:getUserString("attribute"))			-- 속성
	local CostumeType		= tonumber(local_window:getUserString("CostumeType"))		-- 코스튬 아바타 유무 ★
	local attach			= tonumber(local_window:getUserString("attach"))			-- 코스튬 아바타 어탯치 읽기 ★
	local IsRentalSkill		= tonumber(local_window:getUserString("nRental"))			-- 랜탈 스킬인가?
	
	if ItemKind == ITEMKIND_ITEM_GENERATE then
		ItemName = Name2.." "..ItemName
		strDesc  = strDesc..Name2
	end
	
	-- 아이템에 이름이 들어가있다면
	if local_window  then
		if TabKind == 0 or TabKind == 4 then	-- 코스튬
			-- 코스튬 종류
			_drawer:setFont(g_STRING_FONT_GULIM, 111)
			local CostumkindStr	= CostumKindString(CostumeKind)
			Size = GetStringSize(g_STRING_FONT_GULIM, 11, CostumkindStr)
			_drawer:drawText(CostumkindStr, 53 - (Size / 2) + 4, 148)

			-- 코스튬 아바타 ★
			DrawCostumeAvatarIcons(_drawer, ItemFileName, CostumeType, attach)	
				
			if ItemFileName2 ~= "" then
				_drawer:drawTexture(ItemFileName2, 8, 42, 100, 100, 0, 0)			-- 아이템 이미지
			end
			ItemName = Name2.." "..ItemName	
			
			-- 스킬등급을 뿌려준다.
			if ItemGrade ~= 0 then
				_drawer:drawTexture("UIData/powerup.tga", 79, 46, 29, 16, tGradeTexTable[ItemGrade], 486)			-- 아이템 이미지
				_drawer:setTextColor(tGradeTextColorTable[ItemGrade][1],
									tGradeTextColorTable[ItemGrade][2],
									tGradeTextColorTable[ItemGrade][3], 255)
				_drawer:setFont(g_STRING_FONT_GULIM, 11)
				Size = GetStringSize(g_STRING_FONT_GULIM, 11, "+"..ItemGrade)
				_drawer:drawText("+"..ItemGrade, 93 - Size / 2, 50)
			end		
			
		elseif TabKind == 1 then	-- 스킬
			local	skillkind, desc = SkillDescDivide(strDesc)
			_drawer:setFont(g_STRING_FONT_GULIM, 10)
			skillkind = SummaryString(g_STRING_FONT_GULIM, 10, skillkind, 80)
			Size = GetStringSize(g_STRING_FONT_GULIM, 10, skillkind)
			_drawer:drawText(skillkind, (110 / 2) - (Size / 2) + 4, 148)	
			_drawer:drawTexture(ItemFileName, 8, 42, 100, 100, 0, 0)			-- 아이템 이미지
			if ItemFileName2 ~= "" then
				_drawer:drawTexture(ItemFileName2, 8, 42, 100, 100, 0, 0)			-- 아이템 이미지
			end

			--_drawer:drawTextureSA("UIData/skillitem001.tga", 45, 115,  87, 35,   497 + (Promotion % 2) * 88, 35 * (Promotion / 2), 200, 200,   255, 0, 0);
			local item_promotion = Promotion / 2
			local item_style	 = Promotion % 2
			_drawer:drawTextureSA("UIData/Skill_up2.tga", 45, 115,  89, 35,  tAttributeImgTexXTable[item_style][attribute], tAttributeImgTexYTable[item_style][attribute], 200, 200,   255, 0, 0)
			_drawer:drawTextureSA("UIData/Skill_up2.tga", 45, 115,  89, 35,  promotionImgTexXTable[item_style], promotionImgTexYTable[item_promotion], 200, 200,   255, 0, 0)
				
				
			if ExpiredCheck ~= 2 then	-- 무제한이 아니면
				--_drawer:drawTexture("UIData/my_room.tga", 13, 75, 90, 25, 934, 790)			-- 
			end 
			
			-- 스킬등급을 뿌려준다.
			if ItemGrade ~= 0 then
				_drawer:drawTexture("UIData/powerup.tga", 79, 46, 29, 16, tGradeTexTable[ItemGrade], 486)			-- 아이템 이미지
				_drawer:setTextColor(tGradeTextColorTable[ItemGrade][1],
									tGradeTextColorTable[ItemGrade][2],
									tGradeTextColorTable[ItemGrade][3], 255)
				_drawer:setFont(g_STRING_FONT_GULIM, 11)
				Size = GetStringSize(g_STRING_FONT_GULIM, 11, "+"..ItemGrade)
				_drawer:drawText("+"..ItemGrade, 93 - Size / 2, 50)
			end
			
			-- 랜탈 스킬이라면
			if IsRentalSkill == 1 then
				_drawer:drawTexture("UIData/ItemUIData/Insert/Time.tga", 8, 42, 100, 100, 0, 0)
			end
			
		elseif TabKind == 2 or TabKind == 3 then
			_drawer:drawTexture(ItemFileName, 8, 42, 100, 100, 0, 0)			-- 아이템 이미지
			if ItemFileName2 ~= "" then
				_drawer:drawTexture(ItemFileName2, 8, 42, 100, 100, 0, 0)			-- 아이템 이미지
			end
			if RelationproductNo ~= 0 then		-- 칭호나 변신아이템이 아니면 수량을 적어준다.
				_drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
				Size = GetStringSize(g_STRING_FONT_GULIM, 12, "x "..tostring(RelationproductNo))
				common_DrawOutlineText1(_drawer, "x "..tostring(RelationproductNo), 102 - Size, 47, 60,60,60,255, 255,255,255,255);
			end
		else
			
			-- 없다,
		end
		
		-- 아이템 이미지 그려준다.
		if Locked == 1 then
			_drawer:drawTexture("UIData/myinfo.tga", 6, 46, 101, 97, 923, 560)			-- 아이템 이미지
		end
		
		-- 아이템 이름
		_drawer:setFont(g_STRING_FONT_GULIM, 12)
		ItemName = SummaryString(g_STRING_FONT_GULIM, 12, ItemName, 75)
		local	Size = GetStringSize(g_STRING_FONT_GULIM, 12, ItemName)
		common_DrawOutlineText2(_drawer, ItemName, 116 / 2 - Size / 2, 28, 60,60,60,255, 204,255,255,255);
		
		--아이템 레벨
		local	StrLevel	= "Lv."..ItemLevel
		
		if ItemLevel < 1 then
			StrLevel = " - "
		end
		common_DrawOutlineText2(_drawer, StrLevel, 5 , 10, 60,60,60,255, 255,255,255,255);
		-- 사용중, 
		if bWear == 1 then
			_drawer:drawTexture("UIData/my_room.tga", 44, 4, 76, 17, 246, 1007)		
		end
		-- 기간 만료
		if ExpiredCheck == 1 then
			_drawer:drawTexture("UIData/my_room.tga", 36, 4, 76, 17, 167, 1007)		
		end
		
		-- 기간
		_drawer:setFont(g_STRING_FONT_GULIM, 111)
		_drawer:drawText(MR_String_12.." : "..ItemExpireTime, 11, 168)
		
	end
end

--------------------------------------------------------------------
-- 코스튬 종류 스트링으로
--------------------------------------------------------------------
function CostumKindString(KindIndex)
	local CostumString	= ""
	if 1 <= KindIndex and KindIndex <= 10 then
		CostumString = tCostumKind[KindIndex]
	else
		CostumString = ""
	end
	
	return MR_String_11.." : "..CostumString
end

--------------------------------------------------------------------
-- 스킬 스트링 쪼개서 보여준다.
--------------------------------------------------------------------
function SkillDescDivide(str)
	local _DescStart	= ""
	local _DescStart2	= ""
	local _DescEnd		= ""
	local _DescEnd2		= ""
	local _SkillKind = "";		--스킬종류
	local _DetailDesc = "";		--스킬설명
	
	_DescStart, _DescEnd = string.find(str, "%$");
	
	if _DescStart ~= nil then
		_SkillKind = string.sub(str, 1, _DescStart - 1);
		_DetailDesc = string.sub(str, _DescEnd + 1);
		_DescStart2, _DescEnd2 = string.find(_DetailDesc, "%$");
		if _DescStart2 ~= nil then
			_DetailDesc = string.sub(_DetailDesc, _DescEnd2 + 1);
		end
	else
		_DetailDesc = str
	end
	
	return _SkillKind, _DetailDesc
end


--------------------------------------------------------------------
-- 아이템 페이지 버튼(왼쪽)
--------------------------------------------------------------------
function MyRoom_PrevBt(args)
	local bSuccess	= ToC_PageSetting(0)
	if bSuccess then
		--페이지 세팅
		local	CurrentPage, TotalPage	= ToC_GetPageNumber()
		MyRoom_PageSetting(CurrentPage, TotalPage)
	end
end


--------------------------------------------------------------------
-- 아이템 페이지 버튼(오른쪽)
--------------------------------------------------------------------
function MyRoom_NextBt(args)
	local bSuccess	= ToC_PageSetting(1)
	if bSuccess then
		--페이지 세팅
		local	CurrentPage, TotalPage	= ToC_GetPageNumber()
		MyRoom_PageSetting(CurrentPage, TotalPage)
	end
end


--------------------------------------------------------------------
-- 마이룸 관련 캐릭터 회전버튼이벤트(왼쪽)
--------------------------------------------------------------------
function MyRoom_CharacterLRotateDownEvent()
	CharRotateOn(0)
end
--------------------------------------------------------------------
-- 마이룸 관련 캐릭터 회전버튼이벤트(오른쪽)
--------------------------------------------------------------------
function MyRoom_CharacterRRotateDownEvent()
	CharRotateOn(1)
end
--------------------------------------------------------------------
-- 마이룸 관련 캐릭터 회전버튼이벤트(왼쪽)
--------------------------------------------------------------------
function MyRoom_CharacterLRotateUpEvent()
	CharRotateOff()
end
--------------------------------------------------------------------
-- 마이룸 관련 캐릭터 회전버튼이벤트(오른쪽)
--------------------------------------------------------------------
function MyRoom_CharacterRRotateUpEvent()
	CharRotateOff()
end


--------------------------------------------------------------------
-- 마이름 캐릭터 라다오버튼 클릭시.
--------------------------------------------------------------------
function MyRoom_CharacterShow()
	if CEGUI.toRadioButton(winMgr:getWindow("MyRoom_Character")):isSelected() then
		g_SelectedMainTab	= TAB_CHARACTER
		ToC_CurrentItemRefresh()		-- 아이템 리프레쉬
		Myroom_Mainwindow:addChildWindow(winMgr:getWindow("MyRoom_CharacterBackImg"))
		winMgr:getWindow("MyRoom_CharacterBackImg"):setVisible(true)
		winMgr:getWindow("MyRoom_SkillPossesionBackImg"):setVisible(false)
		winMgr:getWindow("MyRoom_SkillUpGradeBackImg"):setVisible(false)
		winMgr:getWindow("MyRoom_HotfixMainBackImg"):setVisible(false)
		
		if CEGUI.toRadioButton(winMgr:getWindow("MyRoom_SkillTab")):isSelected() then				
			winMgr:getWindow("MyRoom_CostumeTab"):setProperty("Selected", "true")
		end
		ToC_CharacterSetVisible(true)
		ToC_SetMainCategory(0)
		
	end	
end


--------------------------------------------------------------------
-- 마이름 보유스킬 라다오버튼 클릭시.
--------------------------------------------------------------------
function MyRoom_SkillShow()
	if CEGUI.toRadioButton(winMgr:getWindow("MyRoom_Skill")):isSelected() then
		g_SelectedMainTab	= TAB_MY_SKILL
		ToC_CurrentItemRefresh()		-- 아이템 리프레쉬
		Myroom_Mainwindow:addChildWindow(winMgr:getWindow("MyRoom_SkillPossesionBackImg"))
		winMgr:getWindow("MyRoom_CharacterBackImg"):setVisible(false)
		winMgr:getWindow("MyRoom_SkillPossesionBackImg"):setVisible(true)
		winMgr:getWindow("MyRoom_SkillUpGradeBackImg"):setVisible(false)
		winMgr:getWindow("MyRoom_HotfixMainBackImg"):setVisible(false)
		
		winMgr:getWindow("MyRoom_SkillDetailTab_Strike"):setProperty("Selected", "true")	-- 보유스킬 첫번째 탭 선택시켜줌
		--for i = 1, PAGE_MAXITEM do
		--	winMgr:getWindow("MyRoom_SkillMainImg"):addChildWindow("MyRoom_Item"..i)
		--end
		if CEGUI.toRadioButton(winMgr:getWindow("MyRoom_SkillTab")):isSelected() == false then	-- 만약 스킬 탭이 선택이 안되었다면 선택해준다
			winMgr:getWindow("MyRoom_SkillTab"):setProperty("Selected", "true")
		end
		ToC_CharacterSetVisible(false)
		ToC_SetMainCategory(1)
		
	end
end



-- 정수를 소수점으로 바꾼다.
function GetDecimalPoint(value)
	local first	= value / 10
	local last	= value % 10
	
	return tostring(first).."."..tostring(last)
end

-- 옆 스킬에서 마우스 나갈때
function MyRoom_MiniSkillMouseLeave(args)
	local local_window	= CEGUI.toWindowEventArgs(args).window
	local mywindow	= local_window:getParent()		-- 부모 윈도우
	
	local_window:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	local_window:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	
	winMgr:getWindow("SkillToolTipFrame"):setVisible(false)
	ToC_HidePreviewSkill()
end


-- 옆 스킬에 마우스 들어올때,
function MyRoom_MiniSkillMouseEnter(args)
	local local_window	= CEGUI.toWindowEventArgs(args).window
	local mywindow		= local_window:getParent()		-- 부모 윈도우
	local ParentWindow	= mywindow:getParent()	
	local ItemNumber	= mywindow:getUserString("SkillItemNum")
	local ItemIndex		= mywindow:getUserString("SkillItemIndex")
	
	local ItemName, FileName, ItemDesc, Promotion, Grade, level, attribute = ToC_GetItemInfo(ItemNumber, ItemIndex)
	
	
	local_window:setTexture("Enabled", "UIData/my_room2.tga", 313, 231)
	local_window:setTexture("Disabled", "UIData/my_room2.tga", 313, 231)
		
	winMgr:getWindow("SkillToolTipFrame"):setUserString("SkillToolTipIndex", tostring(ItemNumber))
	winMgr:getWindow("SkillToolTipFrame"):setUserString("SkillToolTipLevel", tostring(level))
	winMgr:getWindow("SkillToolTipFrame"):setUserString("SkillToolTipGrade", tostring(Grade))

	local x, y = GetBasicRootPoint(local_window)
	local ParentWindowPos	= ParentWindow:getPosition();
	local mywindowPos		= mywindow:getPosition();
	local _x				= ParentWindowPos.x.offset + mywindowPos.x.offset
	local _y				= ParentWindowPos.y.offset + mywindowPos.y.offset
	
	winMgr:getWindow("SkillToolTipFrame"):setPosition(x + 80, y)
	local Pos		= winMgr:getWindow("SkillToolTipFrame"):getPosition();
	
	-- 동영상 플레이
	ToC_SettingPreviewSkillRect(Pos.x.offset+8, Pos.y.offset + 50, 217, 164);
	ToC_SelectedSkillContent(ItemNumber)
	
	winMgr:getWindow("SkillToolTipFrame"):setVisible(true)
	Realroot:addChildWindow(winMgr:getWindow("SkillToolTipFrame"))
end


-- 스킬툴팁 랜더부분
function SkillToolTipRender(args)
	local local_window	= CEGUI.toWindowEventArgs(args).window
	local _drawer		= local_window:getDrawer()
	
	local Index	= tonumber(local_window:getUserString("SkillToolTipIndex"))
	local level	= tonumber(local_window:getUserString("SkillToolTipLevel"))
	local Grade	= tonumber(local_window:getUserString("SkillToolTipGrade"))

	local	ItemName	= MyRoom_GetItemName(Index)	-- 아이템 이름
	local	strDesc		= MyRoom_GetItemDescription(Index)	-- 설명

	local Pos		= winMgr:getWindow("SkillToolTipFrame"):getPosition();

	-- 아이템 레벨
	_drawer:setTextColor(255,255,255,255)
	_drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	_drawer:drawText("Lv."..level, 11, 21)
	
	-- 아이템 이름
	_drawer:setFont(g_STRING_FONT_GULIMCHE, 13)
	local Size = GetStringSize(g_STRING_FONT_GULIMCHE, 13, ItemName)
	common_DrawOutlineText2(_drawer, ItemName, 125 - (Size / 2), 20, 60,60,60,255, 204,255,255,255);
	ItemGrade	= Grade
	if ItemGrade > 0 then
		_drawer:drawTexture("UIData/powerup.tga", 195, 17, 29, 16, tGradeTexTable[ItemGrade], 486)			-- 아이템 이미지
		_drawer:setTextColor(tGradeTextColorTable[ItemGrade][1],
							tGradeTextColorTable[ItemGrade][2],
							tGradeTextColorTable[ItemGrade][3], 255)
		local Size = GetStringSize(g_STRING_FONT_GULIM, 11, "+"..ItemGrade)
		_drawer:setFont(g_STRING_FONT_GULIMCHE, 11)
		_drawer:drawText("+"..ItemGrade, 210 - Size / 2, 21)
		
		-- 추가 스킬데미지
		_drawer:setTextColor(87,242,9,255)
		_drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
		local String	= string.format(MR_String_78, tGradeferPersent[ItemGrade])
		String	= "[PvP] "..String.."%"
		_drawer:drawText(String, 8, 274)
		
		local String	= string.format(MR_String_78, tGradeferPersent[ItemGrade] * 10)
		String	= "[Arcade] "..String.."%"
		_drawer:drawText(String, 8, 290)
		
	end
	
	
	-- 아이템 설몀
	_drawer:setTextColor(255,255,255,255)
	_drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	local	skillkind, desc = SkillDescDivide(strDesc)
	desc = AdjustString(g_STRING_FONT_GULIMCHE, 12, desc, 200)
	_drawer:drawText(desc, 14, 227)
			
end



--------------------------------------------------------------------
-- 코스튬, 
--------------------------------------------------------------------
function KindTabEvent(Index)
	if Index == 5 then
		Index = 1
	end
	for i = 1, #tMainImgName do
		winMgr:getWindow(tMainImgName[i]):setVisible(false)
	end
	winMgr:getWindow(tMainImgName[Index]):setVisible(true)
	if Index < 3 then
		winMgr:getWindow(tSubFirstIcon_Name[Index]):setProperty("Selected", "true")		-- 첫번째 서브탭을 선택해준다
	end
end



--===============================================================================================
----------------------		코스튬, 스킬, 기타, 스페셜 카테고리 이벤트		---------------------
--===============================================================================================
--------------------------------------------------------------------
-- 아이템 종류 카테고리 라디오버튼 클릭 이벤트
--------------------------------------------------------------------
function MyRoom_TabKindClick(args)
	if CEGUI.toRadioButton(CEGUI.toWindowEventArgs(args).window):isSelected() then
		local EventWindow	= CEGUI.toWindowEventArgs(args).window
		
		for i = 1, #tMyRoomTabBtn_Name do
			if tMyRoomTabBtn_Name[i] == EventWindow:getName() then
				SkillAniTick	= 0		-- 스킬 애니매이션 초기화
				KindTabEvent(i)
				
				-- 선택했을때 먼저 바꿔주고.
				ToC_SelectedItemCategory(i - 1)				
				
				ToC_ClickItemKindTabEvent(i - 1)	-- 아이템 종류 탭을 눌렀을때 발생시켜주는 이벤트
				local newIndex = i
				if i == 5 then
					newIndex = 1
				end
				-- 부모윈도우를 바꿘준다.
				for j = 1, PAGE_MAXITEM do
					winMgr:getWindow(tMainImgName[newIndex]):addChildWindow("MyRoom_Item"..j)
					winMgr:getWindow(tMainImgName[newIndex]):addChildWindow("MyRoom_EmptyOrItem"..j)
				end
				
				--페이지 세팅
				local	CurrentPage, TotalPage	= ToC_GetPageNumber()
				MyRoom_PageSetting(CurrentPage, TotalPage)
								
				-- 캐릭터와 동영상을 같이 띄워주면 안됨
				if newIndex == 2 then		-- 스킬탭이면
					if CEGUI.toRadioButton(winMgr:getWindow("MyRoom_Character")):isSelected() then
						winMgr:getWindow("MyRoom_Skill"):setProperty("Selected", "true")
					end
				end
				
				break
			end
		end
	end
	
end

--===============================================================================================
---------------------	  코스튬, 스킬, 기타, 스페셜 카테고리 이벤트 END	---------------------
--===============================================================================================

--------------------------------------------------------------------
-- 페이지 셋팅
--------------------------------------------------------------------
function MyRoom_PageSetting(CurrentPage, TotalPage)
	-- 바탕에 저장.
	root:setUserString("MyRoom_TotalPage", tostring(TotalPage))
	root:setUserString("MyRoom_CurrentPage", tostring(CurrentPage))
	
	winMgr:getWindow("MyRoom_PageText"):clearTextExtends();
	winMgr:getWindow("MyRoom_PageText"):addTextExtends(tostring(CurrentPage)..' / '..tostring(TotalPage) , g_STRING_FONT_GULIMCHE, 18, 255,255,255,255, 0, 0,0,0,255);
end


--------------------------------------------------------------------
-- 마이룸 아이템 선택시 이벤트
--------------------------------------------------------------------
function MyRoom_CostumeSelectEvent(args)
	if CEGUI.toRadioButton(CEGUI.toWindowEventArgs(args).window):isSelected() then
		
		NCS_Selected_Window	= CEGUI.toWindowEventArgs(args).window
		
		local AvatarType = tonumber(NCS_Selected_Window:getUserString("CostumeType"))
		--DebugStr("클릭할떄 아바타 타이프 : " .. AvatarType)
		
		if AvatarType == -1 then
			-- 장착하지 않는다... 비쥬얼이 설정 되지 않았기 때문에..
		elseif AvatarType > 0 then
			-- 비쥬얼이 설정 된 상태
			local itemNumber = LuaGetVisualNumber(NCS_Selected_Window:getUserString('ItemNumber'))
			
			if itemNumber == 0 then
				itemNumber = NCS_Selected_Window:getUserString('ItemNumber');
			end
			
			ToC_SelectedItem(itemNumber , NCS_Selected_Window:getUserString('ListIndex'));
		else
			ToC_SelectedItem(NCS_Selected_Window:getUserString('ItemNumber') , NCS_Selected_Window:getUserString('ListIndex'));
		end
	end
end

RegistEscEventInfo("NCS_WearConfirmAlphaImage", "MyRoom_ClickItemDestroyCancel")
RegistEnterEventInfo("NCS_WearConfirmAlphaImage", "MyRoom_ClickFakeItemDestroyOk")



function MyRoom_ShowRandomOpenItem(args)
	local local_window = CEGUI.toWindowEventArgs(args).window;
	local mywindow	= local_window:getParent()		-- 부모 윈도우
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



--------------------------------------------------------------------
-- 마이룸 아이템 삭제버튼 이벤트
--------------------------------------------------------------------
function MyRoom_DeleteBtnEvent(args)
	local local_window = CEGUI.toWindowEventArgs(args).window;
	local mywindow	= local_window:getParent()		-- 부모 윈도우
	mywindow:setProperty("Selected", "true")
	
	local ItemNumber	= 	tonumber(mywindow:getUserString('ItemNumber'))
	local ItemName		=	MyRoom_GetItemName( ItemNumber )
	
	-- 샵쪽에서 쓰는 팝업창은 공통으로 쓰기위해====
	local ButtonName	= {['protecterr']=0, "NCS_WearOKButton", "NCS_WearCancelButton"}
	local ButtonEvent	= {['protecterr']=0, "MyRoom_ClickItemDestroyOk", "MyRoom_ClickItemDestroyCancel"}
	
	for i=1, #ButtonName do
		winMgr:getWindow(ButtonName[i]):subscribeEvent("Clicked", ButtonEvent[i])
	end
	
	winMgr:getWindow('NCS_WearConfirmImage'):setUserString("noFunction", "MyRoom_ClickItemDestroyCancel")
	winMgr:getWindow('NCS_WearConfirmImage'):setUserString("okFunction", "MyRoom_ClickFakeItemDestroyOk")
	--=============================================
	
	local String	= string.format(MR_String_15, ItemName)
	
	winMgr:getWindow('NCS_WearConfirmText'):clearTextExtends();
	winMgr:getWindow('NCS_WearConfirmText'):addTextExtends(String, g_STRING_FONT_DODUMCHE, 115,255,255,255,255,    2, 0,0,0,255);	

	Realroot:addChildWindow(winMgr:getWindow('NCS_WearConfirmAlphaImage'));
	winMgr:getWindow('NCS_WearConfirmAlphaImage'):setVisible(true)
	
	--ShowCommonAlertOkCancelBoxWithFunction2("["..ItemName.."]".."\n", MR_String_15, 'MyRoom_ClickItemDestroyOk', 'MyRoom_ClickItemDestroyCancel');
end


--------------------------------------------------------------------
-- 아이템 삭제 ok버튼을 클릭했다.
--------------------------------------------------------------------
function MyRoom_ClickItemDestroyOk(args)
	local mywindow
	
	for i = 1, PAGE_MAXITEM do
		if CEGUI.toRadioButton(winMgr:getWindow("MyRoom_Item"..i)):isSelected() then
			mywindow = winMgr:getWindow("MyRoom_Item"..i)
			break
		end
	end
	
	winMgr:getWindow('NCS_WearConfirmAlphaImage'):setVisible(false)
	
	local ItemNumber	= 	tonumber(mywindow:getUserString('ItemNumber'))
	local ListIndex		= 	tonumber(mywindow:getUserString('ListIndex'))
	local ItemKind		= 	tonumber(mywindow:getUserString('ItemKind'))
	
	ToC_ClickedUnWearButton(ItemNumber, ListIndex, ItemKind)	
	ToC_ClickedItemDestroy(ListIndex)
	ToC_GetMyCharacterInfo();
	ToC_GetMyItemList()
end


function MyRoom_ClickFakeItemDestroyOk()
	local okfunc = winMgr:getWindow('NCS_WearConfirmImage'):getUserString("okFunction")
	if okfunc ~= "MyRoom_ClickFakeItemDestroyOk" then
		return
	end
	winMgr:getWindow('NCS_WearConfirmImage'):setUserString("okFunction", "")
	
end
--------------------------------------------------------------------
-- 아이템 삭제 cancel버튼을 눌렀다.
--------------------------------------------------------------------
function MyRoom_ClickItemDestroyCancel(args)
	winMgr:getWindow('NCS_WearConfirmAlphaImage'):setVisible(false)
end



--------------------------------------------------------------------
-- 마이룸 아이템 사용버튼 이벤트
--------------------------------------------------------------------
function MyRoom_UseBtnEvent(args)
	DebugStr('MyRoom_UseBtnEvent')
	local local_window = CEGUI.toWindowEventArgs(args).window;
	local mywindow	= local_window:getParent()		-- 부모 윈도우
	mywindow:setProperty("Selected", "true")		-- 선택 시켜주고

	
	-- 기간 만료 됐는지 체크
	local item_ExpiredCheck = mywindow:getUserString('ExpiredCheck')
	if item_ExpiredCheck == "1" then
		ShowNotifyOKMessage_Lua(MR_String_13)
		return;
	end
	
	
	-- 계열체크
	local item_BoneType	= mywindow:getUserString('boneType');
	local ItemKind		= tonumber(mywindow:getUserString('ItemKind'))
	local Promotion		= tonumber(mywindow:getUserString('Promotion'))
	local ItemNumber	= tonumber(mywindow:getUserString('ItemNumber'))
	local ListIndex		= tonumber(mywindow:getUserString('ListIndex'))
	local Locked		= tonumber(mywindow:getUserString("Locked"))
	local Level			= tonumber(mywindow:getUserString("Level"))
	local ExpiredCheck	= tonumber(mywindow:getUserString("ExpiredCheck"))
	local bUse			= tonumber(mywindow:getUserString("bUse"))
	local AvatarType	= tonumber(mywindow:getUserString("CostumeType"))
	local bNowWear		= tonumber(mywindow:getUserString("bWear"))
	
	local _my_name, _money, _level, _promotion, _my_style, _type, _sp_point, _hp_point, _experience = GetMyInfo(false);

	-- 코스튬
	if ItemKind == ITEMKIND_COSTUM then
		if tonumber(item_BoneType) ~= _type then
			ShowNotifyOKMessage_Lua(MR_String_14) -- 착용할수 없습니다.
			return;
		end
		
		if Level > _level then
			ShowNotifyOKMessage_Lua(MR_String_14) -- 착용할수 없습니다.
			return;
		end
	
	-- 스킬
	elseif ItemKind == ITEMKIND_SKILL then
		if ExpiredCheck == 2 then
			if Level > _level then
				ShowNotifyOKMessage_Lua(MR_String_14) -- 착용할수 없습니다.
				return;
			end
			
			-- 선행스킬의 유무 체크
			if ToC_SkillUseRestriction(ItemNumber) == false then
				ShowNotifyOKMessage_Lua(MR_String_82) -- 선행 스킬이 없습니다 ...
				return;
			end
		end
		
		if bUse == 0 then
			ShowNotifyOKMessage_Lua(MR_String_14) -- 착용할수 없습니다.
			return
		end
		
	elseif ItemKind == ITEMKIND_RESET_PLAY_RECORD then			UseItemConsume(ITEMKIND_RESET_PLAY_RECORD, 0)	return	-- 전적초기화
	elseif ItemKind == ITEMKIND_CHANGE_CHARACTER_NAME then		UseItemConsume(ITEMKIND_CHANGE_CHARACTER_NAME, 0) return-- 캐릭터 이름변경
	elseif ItemKind == ITEMKIND_CAPSULE then					UseItemConsume(ITEMKIND_CAPSULE, 0)	return				-- 캡슐
	elseif ItemKind == ITEMKIND_ITEM_GENERATE then				UseItemConsume(ITEMKIND_ITEM_GENERATE, Locked)	return	-- 보스변신아이템
	elseif ItemKind == ITEMKIND_DETACH_ORB then					ShowHotfixReleaseWindow(ListIndex)	return				-- 핫픽스 해제아이템
	elseif ItemKind == ITEMKIND_CHANGE_EMBLEM then				ShowChangeAmblemWin() return							-- 엠블럼 교체 아이템 
	elseif ItemKind == ITEMKIND_MEGA_PHONE then					ShowMegaPhoneMsgInput()	return							-- 메가폰
	elseif ItemKind == ITEMKIND_CHARACTER_COSTUME_SWITCH then	ShowAdapterWindow() return								-- 어뎁터
	elseif ItemKind == ITEMKIND_INCREASE_NAX_GUILD_MEMBER then  UseItemConsume(ITEMKIND_INCREASE_NAX_GUILD_MEMBER, 0)	return
	elseif ItemKind == ITEMKIND_COSTUME_RANDOM_BOX then			UseItemConsume(ITEMKIND_COSTUME_RANDOM_BOX, 0)	return	-- 코스튬 랜덤박스
	elseif ItemKind == ITEMKIND_REGIST_PROFILE_PHOTO then		ShowChangeProfileWin() return							-- 프로필 사진등록
	elseif ItemKind == ITEMKIND_BEST_FRIEND_EXTEND then			ShowBestFriendExtendWin() return						-- 절친확장
	elseif ItemKind == ITEMKIND_DIRTYX_CHANGECLASS_VISION then	UseItemConsume(ITEMKIND_DIRTYX_CHANGECLASS_VISION, 0) return -- 프로필 사진등록
	
	elseif ItemKind == ITEMKIND_RESET_CLASS then
		if ItemNumber ~= 10005005 then													-- 클래스 초기화
			if _promotion <= 0 then
				DebugStr('초기화 진행 불가')
				ShowNotifyOKMessage_Lua(MR_String_85)	-- 초기화 할 수 없다.
				return
			end
		end
		
		if ToC_CheckEnableResetClass() then
			ShowNotifyOKMessage_Lua(PreCreateString_2663, 8, 5, 53, 85)		-- GetSStringInfo(LAN_RESETCLASS_NOTICE )
			return
		end
		
		UseItemConsume(ITEMKIND_RESET_CLASS, 0) 
		return 
		
	elseif ItemKind == ITEMKIND_STORAGE_EXTEND then				UseItemConsume(ITEMKIND_STORAGE_EXTEND, 0)			return	-- 상점 연장권
	elseif ItemKind == ITEMKIND_CHANGE_CHARACTER_COLOR then		UseItemConsume(ITEMKIND_CHANGE_CHARACTER_COLOR, 0)	return	-- 캐릭터 피부 색 변경
	elseif ItemKind == ITEMKIND_SELECT_RANDOMBOX then			UseItemConsume(ITEMKIND_SELECT_RANDOMBOX, 0)		return
	elseif ItemKind == ITEMKIND_AUTOTAKE_RENTAL_SKILL then		UseItemConsume(ITEMKIND_AUTOTAKE_RENTAL_SKILL, 0)	return
	
	elseif ItemKind == ITEMKIND_UPGRADE_STAT_RESET then			UseItemConsume(ITEMKIND_UPGRADE_STAT_RESET, 0)		return
	elseif ItemKind == ITEMKIND_PREMIUM_PACKAGE then			UseItemConsume(ITEMKIND_PREMIUM_PACKAGE, 0)			return
	elseif ItemKind == ITEMKIND_CHARACTER_STAT_PLUS then		UseItemConsume(ITEMKIND_CHARACTER_STAT_PLUS, 0)		return
	
	elseif ItemKind == ITEMKIND_AVATAR_CLEANUP then				ShowNotifyOKMessage_Lua(PreCreateString_4191) return	-- 정화 사용				-- GetSStringInfo(LAN_INJECTOR_002)
	elseif ItemKind == ITEMKIND_DETACH_AVATAR then				ShowNotifyOKMessage_Lua(PreCreateString_4191) return	-- 분리 사용				-- GetSStringInfo(LAN_INJECTOR_002)
	elseif ItemKind == ITEMKIND_UNMAKE_AVATAR then				ShowNotifyOKMessage_Lua(PreCreateString_4191) return	-- 일반으로 변환 사용		-- GetSStringInfo(LAN_INJECTOR_002)
	
	elseif ItemKind == ITEMKIND_USE_INJECTER then				ShowNotifyOKMessage_Lua(PreCreateString_4191) return	-- 인젝터 사용				-- GetSStringInfo(LAN_INJECTOR_002)
	elseif ItemKind == ITEMKIND_USE_EXP_BOTTLE then				ShowNotifyOKMessage_Lua(PreCreateString_4191) return	-- EXP 병 사용				-- GetSStringInfo(LAN_INJECTOR_002)
	else
	end
	
	
	
	--==============================
	-- 클론 아바타 입기 제한
	--==============================
	if AvatarType == -1 then
		
		ToC_ClickedWearButton(ItemNumber, ListIndex, ItemKind,0)
		ToC_GetMyCharacterInfo();
	else
		
		ToC_ClickedWearButton(ItemNumber, ListIndex, ItemKind,0)
		ToC_GetMyCharacterInfo();
	end		
	
end

--------------------------------------------------------------------
-- 마이룸 아이템 더블클릭 이벤트
--------------------------------------------------------------------
function MyRoom_ItemDoubleClickEvent(args)
	DebugStr("더블 클릭 이벤트,")
	
	local mywindow		= CEGUI.toWindowEventArgs(args).window;
	local ItemIndex		= mywindow:getUserString('ItemIndex')
	local AvatarType	= tonumber(mywindow:getUserString("CostumeType"))
	
	--========================================================================
	-- 핫픽스에선 비쥬얼 아바타/오염된 아바타/외형 설정된 아바타는 등록불가 ★
	--========================================================================
	if g_SelectedMainTab == TAB_HOTFIX then
		if AvatarType > 0 or AvatarType == -2 or AvatarType == -3 then
			DebugStr("더블 클릭 이벤트를 벗어남 리턴2")
			return
		end
	end
	
	if g_SelectedMainTab == TAB_HOTFIX or g_SelectedMainTab == TAB_UPGRADE_SKILL then
		bDoubleClickUpgrade = true
		MyRoom_RegistBtnEvent(args)
		return
	end

	-- 기간 만료 체크
	local item_ExpiredCheck = mywindow:getUserString('ExpiredCheck')
	if item_ExpiredCheck == "1" then
		ShowNotifyOKMessage_Lua(MR_String_13)
		return;
	end
	
	-- 계열체크
	local item_BoneType = mywindow:getUserString('boneType');
	local bWear			= tonumber(mywindow:getUserString('bWear'))
	local ItemKind		= tonumber(mywindow:getUserString('ItemKind'))
	local Promotion		= tonumber(mywindow:getUserString('Promotion'))
	local ItemNumber	= tonumber(mywindow:getUserString('ItemNumber'))
	local ListIndex		= tonumber(mywindow:getUserString('ListIndex'))
	local attach		= tonumber(mywindow:getUserString('attach'))
	local Locked		= tonumber(mywindow:getUserString("Locked"))
	local Level			= tonumber(mywindow:getUserString("Level"))
	local ExpiredCheck	= tonumber(mywindow:getUserString("ExpiredCheck"))
	local bUse			= tonumber(mywindow:getUserString("bUse"))

	DebugStr(ItemNumber)

	--===================================================
	-- 비쥬얼 아바타(-3) / 오염된 아바타(-2) 사용 금지 ★
	--===================================================
	if AvatarType == -3 or AvatarType == -2 then
		DebugStr("비쥬얼 아바타 / 오염된 아바타 사용 금지")
		return
	end
	
	local _my_name, _money, _level, _promotion, _my_style, _type, _sp_point, _hp_point, _experience = GetMyInfo(false);
	
	if ItemKind == ITEMKIND_COSTUM then -- 코스튬
		if tonumber(item_BoneType) ~= _type then
			ShowNotifyOKMessage_Lua(MR_String_14)			
			return;
		end
		if Level > _level then
			ShowNotifyOKMessage_Lua(MR_String_14)			
			return;
		end
	elseif ItemKind == ITEMKIND_SKILL then	-- 스킬
		if ExpiredCheck == 2 then
			if Level > _level then
				ShowNotifyOKMessage_Lua(MR_String_14)			
				return;
			end			
			if ToC_SkillUseRestriction(ItemNumber) == false then
				ShowNotifyOKMessage_Lua(MR_String_82)			
				return;
			end
		end
		if bUse == 0 then
			ShowNotifyOKMessage_Lua(MR_String_14)	-- 직업이 맞지 않습니다로..		
			return
		end	
	elseif ItemKind == ITEMKIND_RESET_PLAY_RECORD then		UseItemConsume(ITEMKIND_RESET_PLAY_RECORD, 0)	return		-- 전적초기화
	elseif ItemKind == ITEMKIND_CHANGE_CHARACTER_NAME then	UseItemConsume(ITEMKIND_CHANGE_CHARACTER_NAME, 0)	return	-- 캐릭터 이름변경
	elseif ItemKind == ITEMKIND_CAPSULE then				UseItemConsume(ITEMKIND_CAPSULE, 0)	return					-- 캡슐
	elseif ItemKind == ITEMKIND_ITEM_GENERATE then			UseItemConsume(ITEMKIND_ITEM_GENERATE, Locked)	return		-- 보스변신아이템
	elseif ItemKind == ITEMKIND_DETACH_ORB then				ShowHotfixReleaseWindow(ListIndex) return					-- 핫픽스 해제아이템
	elseif ItemKind == ITEMKIND_CHANGE_EMBLEM then			ShowChangeAmblemWin() return		-- 엠블럼 교체 아이템 
	elseif ItemKind == ITEMKIND_MEGA_PHONE then				ShowMegaPhoneMsgInput()	return		-- 메가폰
	elseif ItemKind == ITEMKIND_CHARACTER_COSTUME_SWITCH then ShowAdapterWindow() return		-- 어뎁터
	elseif ItemKind == ITEMKIND_INCREASE_NAX_GUILD_MEMBER then  UseItemConsume(ITEMKIND_INCREASE_NAX_GUILD_MEMBER, 0)	return
	elseif ItemKind == ITEMKIND_COSTUME_RANDOM_BOX then		UseItemConsume(ITEMKIND_COSTUME_RANDOM_BOX, 0)	return		-- 코스튬 랜덤박스
	elseif ItemKind == ITEMKIND_REGIST_PROFILE_PHOTO then	ShowChangeProfileWin() return								-- 프로필 사진등록
	elseif ItemKind == ITEMKIND_BEST_FRIEND_EXTEND then		 ShowBestFriendExtendWin() return							-- 절친확장
	elseif ItemKind == ITEMKIND_DIRTYX_CHANGECLASS_VISION then	UseItemConsume(ITEMKIND_DIRTYX_CHANGECLASS_VISION, 0) return -- 프로필 사진등록
	elseif ItemKind == ITEMKIND_RESET_CLASS then -- 클래스 초기화

		if ItemNumber ~= 10005005 then													-- 클래스 초기화
			if _promotion <= 0 then
				DebugStr('초기화 진행 불가')
				ShowNotifyOKMessage_Lua(MR_String_85)	-- 초기화 할 수 없다.
				return
			end
		end

		if ToC_CheckEnableResetClass() then
			ShowNotifyOKMessage_Lua(PreCreateString_2663, 8, 5, 53, 85)			-- GetSStringInfo(LAN_RESETCLASS_NOTICE )
			return
		end
		UseItemConsume(ITEMKIND_RESET_CLASS, 0) 
		return
--	elseif ItemKind == ITEMKIND_CHANGE_PROFILE_SKIN then	ShowChangeProfileWin() return -- 프로필 스킨변경
--	elseif ItemKind == ITEMKIND_GANG_WAR_LETTER then		 return -- 점령전 추천서
	elseif ItemKind == ITEMKIND_STORAGE_EXTEND then				UseItemConsume(ITEMKIND_STORAGE_EXTEND, 0)			return
	elseif ItemKind == ITEMKIND_CHANGE_CHARACTER_COLOR then		UseItemConsume(ITEMKIND_CHANGE_CHARACTER_COLOR, 0)	return
	elseif ItemKind == ITEMKIND_SELECT_RANDOMBOX then			UseItemConsume(ITEMKIND_SELECT_RANDOMBOX, 0)		return
	elseif ItemKind == ITEMKIND_AUTOTAKE_RENTAL_SKILL then		UseItemConsume(ITEMKIND_AUTOTAKE_RENTAL_SKILL, 0)	return
	
	elseif ItemKind == ITEMKIND_UPGRADE_STAT_RESET then		UseItemConsume(ITEMKIND_UPGRADE_STAT_RESET, 0)	return
	elseif ItemKind == ITEMKIND_PREMIUM_PACKAGE then		UseItemConsume(ITEMKIND_PREMIUM_PACKAGE, 0)	return
	elseif ItemKind == ITEMKIND_CHARACTER_STAT_PLUS then	UseItemConsume(ITEMKIND_CHARACTER_STAT_PLUS, 0)	return
	
	elseif ItemKind == ITEMKIND_AVATAR_CLEANUP then			ShowNotifyOKMessage_Lua(PreCreateString_4191) return	-- 정화 사용			-- GetSStringInfo(LAN_INJECTOR_002)
	elseif ItemKind == ITEMKIND_DETACH_AVATAR then			ShowNotifyOKMessage_Lua(PreCreateString_4191) return	-- 분리 사용			-- GetSStringInfo(LAN_INJECTOR_002)
	elseif ItemKind == ITEMKIND_UNMAKE_AVATAR then			ShowNotifyOKMessage_Lua(PreCreateString_4191) return	-- 일반으로 변환 사용	-- GetSStringInfo(LAN_INJECTOR_002)
	
	elseif ItemKind == ITEMKIND_USE_INJECTER then			ShowNotifyOKMessage_Lua(PreCreateString_4191) return	-- 인젝터 사용			-- GetSStringInfo(LAN_INJECTOR_002)
	elseif ItemKind == ITEMKIND_USE_EXP_BOTTLE then			ShowNotifyOKMessage_Lua(PreCreateString_4191) return	-- EXP병 사용			-- GetSStringInfo(LAN_INJECTOR_002)
	else

	end
	
	
	--==============================
	-- 클론 아바타 입기 제한
	--==============================
	
	if bWear == 1 then		-- 착용중이면
		ToC_ClickedUnWearButton(ItemNumber, ListIndex, ItemKind)	
		ToC_GetMyCharacterInfo();
		ToC_GetMyItemList()		
	else					-- 착용중이지 않으면
		ToC_ClickedWearButton(ItemNumber, ListIndex, ItemKind, 0)	
		ToC_GetMyCharacterInfo();
	end
end

--------------------------------------------------------------------
-- 마이룸 아이템 해제버튼 이벤트
--------------------------------------------------------------------
function MyRoom_ReleaseBtnEvent(args)
	local local_window = CEGUI.toWindowEventArgs(args).window;
	local mywindow	= local_window:getParent()		-- 부모 윈도우

	local ItemNumber	= 	tonumber(mywindow:getUserString('ItemNumber'))
	local ListIndex		= 	tonumber(mywindow:getUserString('ListIndex'))
	local ItemKind		= 	tonumber(mywindow:getUserString('ItemKind'))
	mywindow:setProperty("Selected", "true")		-- 선택 시켜주고
	
	ToC_ClickedUnWearButton(ItemNumber, ListIndex, ItemKind)	
	ToC_GetMyCharacterInfo();
	ToC_GetMyItemList()
	
end


--------------------------------------------------------------------
-- 마이룸 아이템 기간연장버튼 이벤트
--------------------------------------------------------------------
function MyRoom_PeriodExtentionBtnEvent(args)
	local local_window = CEGUI.toWindowEventArgs(args).window;
	local mywindow	= local_window:getParent()		-- 부모 윈도우

	mywindow:setProperty("Selected", "true")		-- 선택 시켜주고
	mywindow:setUserString('ItemName',	MyRoom_GetItemName( mywindow:getUserString("ItemNumber") ));
	PurchaseContent(mywindow);
end



--------------------------------------------------------------------
-- 등록하기 버튼
--------------------------------------------------------------------
function MyRoom_RegistBtnEvent(args)
	local local_window, mywindow
	
	if bDoubleClickUpgrade then
		mywindow = CEGUI.toWindowEventArgs(args).window;
	else		
		local_window = CEGUI.toWindowEventArgs(args).window
		mywindow	= local_window:getParent()		-- 부모 윈도우
	end
	
	bDoubleClickUpgrade		= false
	local ItemName			= MyRoom_GetItemName( mywindow:getUserString("ItemNumber") )
	local ItemFileName		= mywindow:getUserString("ItemNameFile")
	local ItemFileName2		= mywindow:getUserString("ItemNameFile2")
	local strDesc			= MyRoom_GetItemDescription( mywindow:getUserString("ItemNumber") )
	local ItemExpireTime	= mywindow:getUserString("ItemExpireTime")
	local Promotion			= tonumber(mywindow:getUserString("Promotion"))			-- 프로모션 인덱스
	local ListIndex			= tonumber(mywindow:getUserString('ListIndex'))
	
	local ItemKind			= tonumber(mywindow:getUserString('ItemKind'))
	local ItemGrade			= tonumber(mywindow:getUserString('ItemGrade'))
	local ItemLevel			= tonumber(mywindow:getUserString('Level'))
	local ExpiredCheck		= tonumber(mywindow:getUserString("ExpiredCheck"))
	local Attach			= tonumber(mywindow:getUserString("attach"))
	local ItemNumber		= tonumber(mywindow:getUserString('ItemNumber'))
	local attribute			= tonumber(mywindow:getUserString('attribute'))
	local CostumeType		= tonumber(mywindow:getUserString('CostumeType'))
	
	
	-- 젠,캐시 탭을 클릭할때만 전역변수에 값을 저장한다
	if ItemKind == 0 or ItemKind == 4 then
		g_CostumeType	= CostumeType
		g_Attach		= Attach	
	end
	
	-- 등록이 안돼는 것들을 골라내준다.
	local skillkind, desc = SkillDescDivide(strDesc)
	local Index	= 0
	
	--***********************
	-- 핫픽스탭에 있다면
	--***********************
	if g_SelectedMainTab == TAB_HOTFIX then
		if HotFixUpButtonOK then
			return
		end
		
		-- 핫픽스 스텟정보 초기화
		for i = 1 , #CostumHotfixStat do
			CostumHotfixStat[i] = 0
		end
		
		if ItemKind == 0 then
			CostumHotfixStat[1], CostumHotfixStat[2], CostumHotfixStat[3], CostumHotfixStat[4], 
			CostumHotfixStat[5], CostumHotfixStat[6], CostumHotfixStat[7], CostumHotfixStat[8] ,CostumHotfixStat[9], CostumHotfixStat[10], CostumHotfixStat[11], CostumHotfixStat[12] ,
			CostumHotfixStat[13], CostumHotfixStat[14],ableCount, totalCount = ToC_GetHotfixStat(ItemNumber, ListIndex)
			
			g_IsImpossible = ToC_SetCostumReformInfo(ItemNumber, ListIndex)
		
		elseif ItemKind == 24 then -- # 핫픽스
			root:addChildWindow(winMgr:getWindow("Hotfix_WhereAlphaImage"))
			winMgr:getWindow("Hotfix_WhereAlphaImage"):setVisible(true)
			
			HotfixItemNumber	= ItemNumber
			HotfixItemIndex		= ListIndex
		else
			return
		end

		-- 버튼이 활성화돼는지 확인한다
		local Check = ToC_ConfirmEnableReformCheck()
		
		-- 사용할수 있는 아이템이 아니면 버튼을 비활성화 시킨다
		if Check == 1 and g_IsImpossible == 0 then
			winMgr:getWindow("MyRoom_ReformBtn"):setEnabled(true)
		else
			winMgr:getWindow("MyRoom_ReformBtn"):setEnabled(false)
			return
		end
	elseif g_SelectedMainTab == TAB_UPGRADE_SKILL then	-- 스킬강화탭에 있다면
		if SkillAniKind	~= NONE then
			return
		end
		
		if ItemKind == 1 then			-- 스킬
			if ExpiredCheck ~= 2 then	-- 체험스킬은 강화할 수 없습니다.
				-- DebugStr("WndMyRoom::4403줄에서 리턴됨")
				-- 메세지 띄워줌
				ShowNotifyOKMessage(PreCreateString_2116)			-- GetSStringInfo(LAN_UPGRADE_IMPOSSIBLE)
				return
			end
			
			Index	= SKILL_UP_CURRENT_SKILL
			
		elseif ItemKind == 25 then		-- 스킬 강화권
			Index	= SKILL_UP_TICKET
		else
			DebugStr("WndMyRoom::4403줄에서 리턴됨")
			return
		end
	
		-- c에 저장 시켜준다.
		ToC_ClickedRegistButton(ItemKind, ItemName, ItemFileName, skillkind, ItemExpireTime, Promotion, ItemGrade, ListIndex, ItemLevel, attribute, ItemFileName2)
		
		-- 루아에 저장.
		UpdateSkillUpGradeList(Index, ItemName, ItemFileName, skillkind, ItemExpireTime, Promotion, ItemGrade, ListIndex, ItemLevel, attribute, ItemFileName2)
		SkillUpGradeFee	= SkillUpGradeFeeBuf
	end
end

RegistEscEventInfo("NCS_WearConfirmAlphaImage", "MyRoom_ClickConsumeItemCancel")
RegistEnterEventInfo("NCS_WearConfirmAlphaImage", "MyRoom_ClickConsumeItemOk")

--------------------------------------------------------------
-- 소비되는 아이템을 사용했을대(변신아이템, 전적초기화)
--------------------------------------------------------------
function UseItemConsume(Index, locked)
	-- 샵쪽에서 쓰는 팝업창은 공통으로 쓰기위해====
	local ButtonName	= {['protecterr']=0, "NCS_WearOKButton", "NCS_WearCancelButton"}
	local ButtonEvent	= {['protecterr']=0, "MyRoom_ClickConsumeItemOk", "MyRoom_ClickConsumeItemCancel"}
	
	for i=1, #ButtonName do
		winMgr:getWindow(ButtonName[i]):subscribeEvent("Clicked", ButtonEvent[i])
	end
	
	winMgr:getWindow('NCS_WearConfirmImage'):setUserString("noFunction", "MyRoom_ClickConsumeItemCancel")
	winMgr:getWindow('NCS_WearConfirmImage'):setUserString("okFunction", "MyRoom_ClickConsumeItemOk")
	--=============================================
	
	local String	= ""

	if Index == ITEMKIND_RESET_PLAY_RECORD then			-- ko률 초기화
		String	= MR_String_77
	elseif Index == ITEMKIND_CHANGE_CHARACTER_NAME then	-- 캐릭터 이름변경
		String	= MR_String_79
	elseif Index == ITEMKIND_CAPSULE then				-- 캡슐 아이템
		String	= MR_String_79		
	elseif Index == ITEMKIND_ITEM_GENERATE then	
		if locked == 0 then		String	= MR_String_79	-- 일반 캐시아이템
		else					String	= MR_String_76	-- 변신아이템
		end
	elseif Index == ITEMKIND_INCREASE_NAX_GUILD_MEMBER then	
		String	= MR_String_79
	elseif Index == ITEMKIND_RESET_CLASS then	
		String	= MR_String_84
	elseif Index == ITEMKIND_CHANGE_CHARACTER_COLOR then -- 캐릭터 색깔 변경
		String	= MR_String_87
	else
		String	= MR_String_79
	end
	
	winMgr:getWindow('NCS_WearConfirmText'):clearTextExtends();
	winMgr:getWindow('NCS_WearConfirmText'):addTextExtends(String, g_STRING_FONT_DODUMCHE, 115,255,255,255,255,    2, 0,0,0,255);	

	Realroot:addChildWindow(winMgr:getWindow('NCS_WearConfirmAlphaImage'));
	winMgr:getWindow('NCS_WearConfirmAlphaImage'):setVisible(true)
end

------------------------------------------------------------------------
-- MyRoom_ClickConsumeItemOk : 사용 OK버튼 클릭시 Event 함수.
------------------------------------------------------------------------
function MyRoom_ClickConsumeItemOk()
	local okfunc = winMgr:getWindow('NCS_WearConfirmImage'):getUserString("okFunction")
	if okfunc ~= "MyRoom_ClickConsumeItemOk" then
		return
	end
	winMgr:getWindow('NCS_WearConfirmImage'):setUserString("okFunction", "")
	
	winMgr:getWindow('NCS_WearConfirmAlphaImage'):setVisible(false)
	for i = 1, PAGE_MAXITEM do
		if CEGUI.toRadioButton(winMgr:getWindow("MyRoom_Item"..i)):isSelected() then
			mywindow = winMgr:getWindow("MyRoom_Item"..i)
			break
		end
	end
	local ItemNumber	= 	tonumber(mywindow:getUserString('ItemNumber'))
	local ListIndex		= 	tonumber(mywindow:getUserString('ListIndex'))
	local ItemKind		= 	tonumber(mywindow:getUserString('ItemKind'))
	local Itemattach	= 	tonumber(mywindow:getUserString('attach'))
	
	
	if ItemKind == ITEMKIND_CHANGE_CHARACTER_NAME then
		winMgr:getWindow('MyRoom_ChangeNameAlpha'):setVisible(true)
		return
	elseif		ItemKind == ITEMKIND_COSTUME_RANDOM_BOX 
		  or	ItemKind == ITEMKIND_STORAGE_EXTEND 
		  or	ItemKind == ITEMKIND_CHANGE_CHARACTER_COLOR 
		  or	ItemKind == ITEMKIND_SELECT_RANDOMBOX 
		  or	ItemKind == ITEMKIND_UPGRADE_STAT_RESET 
		  or	ItemKind == ITEMKIND_PREMIUM_PACKAGE 
		  or	ItemKind == ITEMKIND_AUTOTAKE_RENTAL_SKILL 
		  or	ItemKind == ITEMKIND_CHARACTER_STAT_PLUS then
		  
		SetInventoryTab(2)	-- 인벤토리 탭을 알아온다(스터프 아이템일 경우는 다른 코스로~)
		SetSelectedItemIndex(ListIndex)
		UseMyinvenItem()
		return
	end
	
	
	ToC_ClickedWearButton(ItemNumber, ListIndex, ItemKind, Itemattach)
end


function MyRoom_ClickConsumeItemCancel()
	local nofunc = winMgr:getWindow('NCS_WearConfirmImage'):getUserString("noFunction")
	if nofunc ~= "MyRoom_ClickConsumeItemCancel" then
		return
	end
	winMgr:getWindow('NCS_WearConfirmImage'):setUserString("noFunction", "")
	winMgr:getWindow('NCS_WearConfirmAlphaImage'):setVisible(false)
end


--------------------------------------------------------------------
-- 코스튬리폼 정보
--------------------------------------------------------------------
function UpdateCostumReformList(Index, ItemName, ItemFileName, ListIndex, Atkstr, Atkgra, Cri, Hp, Sp, Defstr, Defgra, 
								AtkTeam, AtkTouble, AtkSpecial, DefTeam, DefDouble, DefSpecial, CriDamage, Attach, ReformCount, ListNumber )
	DebugStr('UpdateCostumReformList')
	DebugStr('ItemName:'..ItemName)
	DebugStr('Cri:'..Cri)
	DebugStr('Atkgra:'..Atkgra)
	DebugStr('AtkTeam:'..AtkTeam)
	DebugStr('Defgra:'..Defgra)
	DebugStr('CriDamage:'..CriDamage)
	DebugStr('Attach:'..Attach)
	
	if Index == 0 then
		return
	end
	
	HotfixNumber = ListNumber
	
	-- 루아에 저장 시켜준다.
	--이름, 파일이름, 어태치값, 아이템 리스트인덱스, 스텟 7개
	if Index == REFORM_COSTUM then
		CostumReformList[Index][1]	= SummaryString(g_STRING_FONT_GULIM, 13, ItemName, 60)		-- 아이템 이름 정리해서 넣어줌
	else
		CostumReformList[Index][1]	= ItemName		-- 아이템 이름 정리해서 넣어줌
	end
	
	
	CostumReformList[Index][2]	= ItemFileName
	CostumReformList[Index][3]	= Attach
	CostumReformList[Index][4]	= ListIndex
	CostumReformList[Index][5]	= Atkstr
	CostumReformList[Index][6]	= Atkgra
	CostumReformList[Index][7]	= Cri
	CostumReformList[Index][8]	= Hp
	CostumReformList[Index][9]	= Sp
	CostumReformList[Index][10]	= Defstr
	CostumReformList[Index][11]	= Defgra
	CostumReformList[Index][12]	= AtkTeam
	CostumReformList[Index][13]	= AtkTouble
	CostumReformList[Index][14]	= AtkSpecial
	CostumReformList[Index][15]	= DefTeam
	CostumReformList[Index][16]	= DefDouble
	CostumReformList[Index][17]	= DefSpecial
	CostumReformList[Index][18]	= CriDamage
	CostumReformList[Index][19]	= ReformCount
	
	tCostumReformInfoTable[Index]	= ListIndex		-- - 전역변수에 저장시켜준다.
	-- 아이템이 아니면 어태치를 확인할 필요가 없다.
	if Index ~= 1 then
		return
	end
	
	local	Aattach	= ToC_GetCostumReformPos()		-- 코스튬 어태치값을 알아온다.
	local	SelectedPart	= -1
	-- 선택한 코스튬의 어태치에 따라 불값을 설정해준다.
	for i = #tCostumAttachTable, 1, -1 do
		if Aattach >= tCostumAttachTable[i] then
			tCostumAttach[i]	= true
			Aattach				= Aattach - tCostumAttachTable[i]
			winMgr:getWindow("HotfixDropDownListText"..i):clearTextExtends();
			winMgr:getWindow("HotfixDropDownListText"..i):addTextExtends(HotfixDropDownList[i], g_STRING_FONT_GULIMCHE,12, 255, 255, 255, 255,  0,  0,0,0,255);	
			winMgr:getWindow("HotfixDropDownList"..i):setEnabled(true)
			SelectedPart	= i		
		else
			tCostumAttach[i]	= false
			winMgr:getWindow("HotfixDropDownListText"..i):clearTextExtends();
			winMgr:getWindow("HotfixDropDownListText"..i):addTextExtends(HotfixDropDownList[i], g_STRING_FONT_GULIMCHE,12, 120, 120, 120, 255,  0,  0,0,0,255);	
			winMgr:getWindow("HotfixDropDownList"..i):setEnabled(false)
		end
	end
	
	-- 기본으로 파트를 선택해주기위해서
	if SelectedPart ~= -1 then
		winMgr:getWindow("HotfixDropDownBaseText"):clearTextExtends();
		winMgr:getWindow("HotfixDropDownBaseText"):addTextExtends(HotfixDropDownList[SelectedPart], g_STRING_FONT_GULIMCHE,12, 87, 242, 9, 255,  0,  0,0,0,255);	
		tCostumReformInfoTable[REFORM_ATTACH]	= SelectedPart
	end
	
	
end


--------------------------------------------------------------------
-- 코스튬리폼 정보 클리어
--------------------------------------------------------------------
function ClearCostumReformList(Index)
	CostumReformList[Index][1]	= ""
	CostumReformList[Index][2]	= ""
	--[[
	for i = 3 , 18 do 
		CostumReformList[Index][i] == 0 
	end
	--]]
	CostumReformList[Index][3]	= 0
	CostumReformList[Index][4]	= 0
	CostumReformList[Index][5]	= 0
	CostumReformList[Index][6]	= 0
	CostumReformList[Index][7]	= 0
	CostumReformList[Index][8]	= 0
	CostumReformList[Index][9]	= 0
	CostumReformList[Index][10]	= 0
	CostumReformList[Index][11]	= 0
	CostumReformList[Index][12]	= 0
	CostumReformList[Index][13]	= 0
	CostumReformList[Index][14]	= 0
	CostumReformList[Index][15]	= 0
	CostumReformList[Index][16]	= 0
	CostumReformList[Index][17]	= 0
	CostumReformList[Index][18]	= 0
	CostumReformList[Index][19]	= 0
	
	if Index == 1 then
		winMgr:getWindow("HotfixDropDownBaseText"):clearTextExtends();
		winMgr:getWindow("HotfixDropDownBaseText"):addTextExtends("Select Part", g_STRING_FONT_GULIMCHE,12, 87, 242, 9, 255,  0,  0,0,0,255);	
	end
end


--------------------------------------------------------------------
-- 코스튬, 스킬 카테고리에 부위 라디오버튼 클릭 이벤트
--------------------------------------------------------------------
function MyRoom_SubTabKindClick(args)
	local local_window	= CEGUI.toWindowEventArgs(args).window
	if CEGUI.toRadioButton(CEGUI.toWindowEventArgs(args).window):isSelected() then
--	if window:isSelected() then
		local CategoryIndex		= tonumber(local_window:getUserString("CategoryIndex"))
		ToC_SelectedSubCategory(CategoryIndex - 1)		
	end
end




function MyRoom_ItemMouseEnter(args)
	local EnterWindow		= CEGUI.toWindowEventArgs(args).window
	local item_Level		= EnterWindow:getUserString('Level');			--레벨
	local item_Name			= MyRoom_GetItemName( EnterWindow:getUserString("ItemNumber") )		--아이탬 이름
	local item_Desc			= MyRoom_GetItemDescription( EnterWindow:getUserString("ItemNumber") )		--아이탬 설명
	local RelationproductNo = EnterWindow:getUserString("RelationproductNo");	-- 
	local itemNumber		= EnterWindow:getUserString('ItemNumber');
	local item_ExpireTime	= EnterWindow:getUserString('ItemExpireTime');
	local ItemKind			= tonumber(EnterWindow:getUserString('ItemKind'));
	local PayType			= tonumber(EnterWindow:getUserString("PayType"))		-- 핫픽스일때 스텟 종류
	local Attach			= tonumber(EnterWindow:getUserString("Attach"))			-- 핫픽스일대 스텟
	local ListIndex			= tonumber(EnterWindow:getUserString("ListIndex"))			-- 핫픽스일대 스텟
	local Name2				= EnterWindow:getUserString("Name2")					-- 아이템 두번째 이름(기간)
	local ExpiredCheck		= tonumber(EnterWindow:getUserString("ExpiredCheck"))
	local ItemIndex			= tonumber(EnterWindow:getUserString("ItemIndex"))			-- 핫픽스일대 스텟
	
	local kind = -1
	local type = TYPE_ROOM
	local slot = ListIndex
	local number = tonumber(itemNumber)
	
	local tMove = {['err']=0, false, false, true, true, false, false, true, true}
	if ItemKind == ITEMKIND_COSTUM then
		kind = KIND_COSTUM
	elseif ItemKind == ITEMKIND_SKILL then
		kind = KIND_SKILL
		local x, y = GetBasicRootPoint(EnterWindow)
		
		if tMove[ItemIndex] then
			x = x - 360
		end
		GetToolTipBaseInfo(x+120, y, type, kind, slot, number)	-- 툴팁에 괜한 정보를 세팅해준다.
		SetShowToolTip(true)
		local x1, y1 = GetBasicRootPoint(winMgr:getWindow("Common_ToolTip"))
		
		ToC_SettingPreviewSkillRect(x+120 + 5,  y1+137, 222, 154);
		ToC_SelectedSkillContent(itemNumber)
		return
	elseif ItemKind == ITEMKIND_HOTPICKS then
		kind = KIND_ORB
	else
		kind = KIND_ITEM
	end	
	local x, y = GetBasicRootPoint(EnterWindow)
	if tMove[ItemIndex] then
		x = x - 360
	end

	GetToolTipBaseInfo(x+120, y, type, kind, slot, number)	-- 툴팁에 괜한 정보를 세팅해준다.
	SetShowToolTip(true)
	PlayWave('sound/listmenu_click.wav');	
end



function MyRoom_ItemMouseLeave(args)
	local EnterWindow		= CEGUI.toWindowEventArgs(args).window
	local item_Level		= EnterWindow:getUserString('Level');			--레벨
	local item_Name			= EnterWindow:getUserString("ItemName")			--아이탬 이름
	local RelationproductNo = EnterWindow:getUserString("RelationproductNo");	-- 
	local itemNumber		= EnterWindow:getUserString('ItemNumber');
	local item_ExpireTime	= EnterWindow:getUserString('ItemExpireTime');
	local ItemKind			= tonumber(EnterWindow:getUserString('ItemKind'));
	
	SetShowToolTip(false)
	
	if ItemKind == 1 then
		winMgr:getWindow("SkillToolTipFrame"):setVisible(false)
		ToC_HidePreviewSkill()
		return
	end
	YSizeVariableToolTipClose("MyRoom_ItemToolTip")

end









--------------------------------------------------------------------
-- 스킬트리의 특정 탭에대해 전체 페이지를 구해준다.
--------------------------------------------------------------------
function  MyRoom_GetSkillTreeTotalPage(CurrentPage, Index)
	-- 일단 다 true시켜준다. & 위치 셋팅
	for i = 1, #tAllSkillTree[Index] do
		winMgr:getWindow("MyRoom_EmptyOrSkill"..Index..i):setVisible(true)
		winMgr:getWindow("MyRoom_SkillEmpty"..i):setVisible(false)
		if (Index == 2 and i == 5) or (Index == 2 and i == 6) then
			winMgr:getWindow("MyRoom_EmptyOrSkill"..Index..i):setPosition(2, 80 + (i / 2) * 101)
			winMgr:getWindow("MyRoom_SkillEmpty"..(i + 2)):setVisible(false)
		else
			winMgr:getWindow("MyRoom_EmptyOrSkill"..Index..i):setPosition(2 + ((i - 1) % 2) * 243, 80 + ((i - 1) / 2) * 101)
		end
		
	end
	
	-- 스타일에따라 안보여줄 이미지를 선택한다.
	local	Mystyle		= GetMyCharacterStyle()
	
	if Index == 1 and Mystyle == "chr_grab" then	-- 타격스킬탭에 직업이 러쉬면
		winMgr:getWindow("MyRoom_EmptyOrSkill"..Index..7):setVisible(false)		-- 슬라이딩 false
		winMgr:getWindow("MyRoom_SkillEmpty"..7):setVisible(true)
	elseif Index == 2 and Mystyle == "chr_strike" then	-- 잡기스킬탭에 직업이 스트리트면
		--winMgr:getWindow("MyRoom_EmptyOrSkill"..Index..7):setVisible(false)		-- 대쉬타격 false
	end

	local	TotalPage	= 0
	local	Count		= 0
	
	for i = 1, #tAllSkillTree[Index] do
		if winMgr:getWindow("MyRoom_EmptyOrSkill"..Index..i):isVisible() then
			if Index == 2 then
				if i == 5 or i == 6 then
					Count = Count + 2
				end
			end
			Count = Count + 1
		end
	end
		
	TotalPage = (Count / 8) + 1
	return TotalPage

end


--------------------------------------------------------------------
-- 보유 스킬들 랜더
--------------------------------------------------------------------
function PossessionSkillRender(args)
	local local_window	= CEGUI.toWindowEventArgs(args).window
	local _drawer		= local_window:getDrawer()
	local SelectButtonIndex	= 0

	for i = 1, #tMyRoomSkillKindTabBtn_Name do
		if CEGUI.toRadioButton(winMgr:getWindow(tMyRoomSkillKindTabBtn_Name[i])):isSelected() then
			SelectButtonIndex	= tonumber(winMgr:getWindow(tMyRoomSkillKindTabBtn_Name[i]):getUserString("Index"))
		end		
	end

	if SelectButtonIndex == 0 then
		return
	end
	
	local Index	= tonumber(local_window:getUserString("ImgIndex"))
--	if Index > #tSkillStringTable[SelectButtonIndex] then
--		return
--	end
	_drawer:setTextColor(255,198,30,255)
	_drawer:setFont(g_STRING_FONT_GULIMCHE, 13)

	Size = GetStringSize(g_STRING_FONT_GULIMCHE, 13, tAllSkillTree[SelectButtonIndex][Index])
	_drawer:drawText(tAllSkillTree[SelectButtonIndex][Index], 94 / 2 - Size / 2, 25)

	InputCommand(_drawer, SelectButtonIndex, Index)		-- 커맨드 입력한다.
end

-- 보유스킬쪽 스킬을 랜더한다.
function SkillIconRender(args)
	
	local local_window	= CEGUI.toWindowEventArgs(args).window	-- 현재 윈도우
	local _drawer		= local_window:getDrawer()
	local ItemNumber	= tonumber(local_window:getUserString("SkillItemNum"))
	local Index			= tonumber(local_window:getUserString("SkillItemIndex"))

	local ItemName, FileName, ItemDesc, Promotion, Grade, level, attribute = ToC_GetItemInfo(ItemNumber, Index)
	
	_drawer:drawTextureSA("UIData/SkillUIData/"..FileName, 0, 0,   100, 100,   0, 0,   150, 150,   255, 0, 0);
	
	--_drawer:drawTextureSA("UIData/skillitem001.tga", 18, 45,   87, 35,   497 + (Promotion % 2) * 88, 35 * (Promotion / 2),   170, 170,   255, 0, 0);
	local style = Promotion % 2
	local item_promotion = Promotion / 2
	
	_drawer:drawTextureSA("UIData/Skill_up2.tga", 18, 45,  89, 35,  tAttributeImgTexXTable[style][attribute], tAttributeImgTexYTable[style][attribute],   170, 170,   255, 0, 0)
	_drawer:drawTextureSA("UIData/Skill_up2.tga", 18, 45,  89, 35,  promotionImgTexXTable[style], promotionImgTexYTable[item_promotion],   170, 170,   255, 0, 0)
end
--[[
Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 12, 47,   29, 29,   731, 719,   160, 160,   255, 0, 0);	--a
Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 12, 47,   29, 29,   761, 719,   160, 160,   255, 0, 0);	--s
Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 12, 47,   29, 29,   791, 719,   160, 160,   255, 0, 0);	--d
Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 12, 47,   29, 29,   821, 719,   160, 160,   255, 0, 0);	--위
Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 12, 47,   29, 29,   851, 719,   160, 160,   255, 0, 0);	--q
Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 12, 47,   29, 29,   881, 719,   160, 160,   255, 0, 0);	--w
Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 12, 47,   29, 29,   911, 719,   160, 160,   255, 0, 0);	--e

Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 12, 47,   29, 29,   731, 749,   160, 160,   255, 0, 0);	--+
Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 12, 47,   29, 29,   761, 749,   160, 160,   255, 0, 0);	--or
Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 12, 47,   29, 29,   791, 749,   160, 160,   255, 0, 0);	--왼
Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 12, 47,   29, 29,   821, 749,   160, 160,   255, 0, 0);	--아래
Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 12, 47,   29, 29,   851, 749,   160, 160,   255, 0, 0);	--오른
Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 12, 47,   29, 29,   881, 749,   160, 160,   255, 0, 0);	--f
Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 12, 47,   29, 29,   911, 749,   160, 160,   255, 0, 0);	--...
--]]


--------------------------------------------------------------------
-- 아이템 커멘드입력
--------------------------------------------------------------------
function InputCommand(Commanedrawer, ButtonIndex, Index)
	--Commanedrawer
	if ButtonIndex == 1	then	-- 타격
		if Index == 1 then		-- 일반타격
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 12, 47,   29, 29,   791, 719,   160, 160,   255, 0, 0);
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 31, 47,   29, 29,   791, 719,   160, 160,   255, 0, 0);
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 50, 47,   29, 29,   791, 719,   160, 160,   255, 0, 0);
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 69, 47,   29, 29,   911, 749,   160, 160,   255, 0, 0);
			
		elseif Index == 2 then	-- 상단타격
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 12, 47,   29, 29,   821, 719,   160, 160,   255, 0, 0);	--위
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 31, 47,   29, 29,   731, 749,   160, 160,   255, 0, 0);	--+
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 50, 47,   29, 29,   791, 719,   160, 160,   255, 0, 0);	--d
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 69, 47,   29, 29,   911, 749,   160, 160,   255, 0, 0);	--...
			
		elseif Index == 3 then	-- 중단타격
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 12, 42,   29, 29,   791, 749,   160, 160,   255, 0, 0);	--왼
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 12, 57,   29, 29,   761, 749,   160, 160,   255, 0, 0);	--왼
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 12, 72,   29, 29,   851, 749,   160, 160,   255, 0, 0);	--왼
			
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 31, 57,   29, 29,   731, 749,   160, 160,   255, 0, 0);	--+
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 50, 57,   29, 29,   791, 719,   160, 160,   255, 0, 0);	--d
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 69, 57,   29, 29,   911, 749,   160, 160,   255, 0, 0);	--...
		
		elseif Index == 4 then	-- 하단타격
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 12, 47,   29, 29,   821, 749,   160, 160,   255, 0, 0);	--위
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 31, 47,   29, 29,   731, 749,   160, 160,   255, 0, 0);	--+
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 50, 47,   29, 29,   791, 719,   160, 160,   255, 0, 0);	--d
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 69, 47,   29, 29,   911, 749,   160, 160,   255, 0, 0);	--...
		elseif Index == 5 then	-- 대쉬타격
			Commanedrawer:setTextColor(255,255,255,255)
			Commanedrawer:setFont(g_STRING_FONT_GULIMCHE, 12)
			local Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, "("..MR_String_47..")")
			Commanedrawer:drawText("("..MR_String_47..")", 45 - Size / 2, 47)
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 38, 63,   29, 29,   791, 719,   160, 160,   255, 0, 0);
		elseif Index == 6 then	-- 다이빙타격		
			Commanedrawer:setTextColor(255,255,255,255)
			Commanedrawer:setFont(g_STRING_FONT_GULIMCHE, 12)
			local Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, "("..MR_String_48..")")
			Commanedrawer:drawText("("..MR_String_48..")", 45 - Size / 2, 47)
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 38, 63,   29, 29,   791, 719,   160, 160,   255, 0, 0);
		elseif Index == 7 then	-- 슬라이딩
			Commanedrawer:setTextColor(255,255,255,255)
			Commanedrawer:setFont(g_STRING_FONT_GULIMCHE, 12)
			local Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, "("..MR_String_47..")")
			Commanedrawer:drawText("("..MR_String_47..")", 45 - Size / 2, 47)
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 38, 63,   29, 29,   761, 719,   160, 160,   255, 0, 0);
		end
	elseif ButtonIndex == 2 then	-- 잡기
		if Index == 1 then
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 17, 47,   29, 29,   791, 749,   160, 160,   255, 0, 0);	--위
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 36, 47,   29, 29,   731, 749,   160, 160,   255, 0, 0);	--+
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 55, 47,   29, 29,   761, 719,   160, 160,   255, 0, 0);	--s
		elseif Index == 2 then
--			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 17, 42,   29, 29,   791, 749,   160, 160,   255, 0, 0);	--왼
--			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 17, 57,   29, 29,   761, 749,   160, 160,   255, 0, 0);	--왼
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 17, 47,   29, 29,   851, 749,   160, 160,   255, 0, 0);	--왼
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 36, 47,   29, 29,   731, 749,   160, 160,   255, 0, 0);	--+
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 55, 47,   29, 29,   761, 719,   160, 160,   255, 0, 0);	--s
		elseif Index == 3 then
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 17, 47,   29, 29,   821, 749,   160, 160,   255, 0, 0);	--위
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 36, 47,   29, 29,   731, 749,   160, 160,   255, 0, 0);	--+
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 55, 47,   29, 29,   761, 719,   160, 160,   255, 0, 0);	--s
		elseif Index == 4 then
			Commanedrawer:setTextColor(255,255,255,255)
			Commanedrawer:setFont(g_STRING_FONT_GULIMCHE, 12)
			local Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, "("..MR_String_48..")")
			Commanedrawer:drawText("("..MR_String_48..")", 45 - Size / 2, 47)
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 38, 63,   29, 29,   761, 719,   160, 160,   255, 0, 0);
		elseif Index == 5 then
			Commanedrawer:setTextColor(255,255,255,255)
			Commanedrawer:setFont(g_STRING_FONT_GULIMCHE, 12)
			local Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, "("..MR_String_49..")")
			Commanedrawer:drawText("("..MR_String_49..")", 45 - Size / 2, 47)
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 38, 63,   29, 29,   761, 719,   160, 160,   255, 0, 0);
		elseif Index == 6 then
			Commanedrawer:setTextColor(255,255,255,255)
			Commanedrawer:setFont(g_STRING_FONT_GULIMCHE, 112)
			local Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, "("..MR_String_50..")")
			Commanedrawer:drawText("("..MR_String_50..")", 45 - Size / 2, 47)
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 38, 63,   29, 29,   761, 719,   160, 160,   255, 0, 0);
		elseif Index == 7 then
			Commanedrawer:setTextColor(255,255,255,255)
			Commanedrawer:setFont(g_STRING_FONT_GULIMCHE, 12)
			Commanedrawer:drawText("("..MR_String_47..")", 12, 50)
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 67, 47,   29, 29,   761, 719,   160, 160,   255, 0, 0);
		end
	elseif ButtonIndex == 3 then	-- 필살기
		if Index == 1 then
			Commanedrawer:setTextColor(255,255,255,255)
			Commanedrawer:setFont(g_STRING_FONT_GULIMCHE, 112)
			local Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, "("..MR_String_51..")")
			Commanedrawer:drawText("("..MR_String_51..")", 45 - Size / 2, 47)
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 38, 63,   29, 29,   851, 719,   160, 160,   255, 0, 0);
		elseif Index == 2 then
			Commanedrawer:setTextColor(255,255,255,255)
			Commanedrawer:setFont(g_STRING_FONT_GULIMCHE, 112)
			local Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, "("..MR_String_52..")")
			Commanedrawer:drawText("("..MR_String_52..")", 45 - Size / 2, 47)
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 38, 63,   29, 29,   851, 719,   160, 160,   255, 0, 0);
		elseif Index == 3 then
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 38, 47,   29, 29,   881, 719,   160, 160,   255, 0, 0);
		elseif Index == 4 then
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 38, 47,   29, 29,   911, 719,   160, 160,   255, 0, 0);
		end
	elseif ButtonIndex == 4 then	-- 팀더블
		if Index == 1 then
			Commanedrawer:setTextColor(255,255,255,255)
			Commanedrawer:setFont(g_STRING_FONT_GULIMCHE, 112)
			local Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, "("..MR_String_53..")")
			Commanedrawer:drawText("("..MR_String_53..")", 45 - Size / 2, 47)
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 38, 63,   29, 29,   761, 719,   160, 160,   255, 0, 0);	--s
		elseif Index == 2 then
			Commanedrawer:setTextColor(255,255,255,255)
			Commanedrawer:setFont(g_STRING_FONT_GULIMCHE, 112)
			Commanedrawer:drawText(MR_String_54, 5, 47)
			--Commanedrawer:drawText("뜬 아군에 접근", 5, 64)
		end
	elseif ButtonIndex == 5 then	-- 기타
		if Index == 1 then
			Commanedrawer:setTextColor(255,255,255,255)
			Commanedrawer:setFont(g_STRING_FONT_GULIMCHE, 112)
			local Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, "("..MR_String_55..")")
			Commanedrawer:drawText("("..MR_String_55..")", 45 - Size / 2, 47)
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 38, 63,   29, 29,   731, 719,   160, 160,   255, 0, 0);
		elseif Index == 2 then
			Commanedrawer:setTextColor(255,255,255,255)
			Commanedrawer:setFont(g_STRING_FONT_GULIMCHE, 112)
			local Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, "("..MR_String_55..")")
			Commanedrawer:drawText("("..MR_String_55..")", 45 - Size / 2, 47)
			Commanedrawer:drawTextureSA("UIData/tutorial003.tga", 38, 63,   29, 29,   731, 719,   160, 160,   255, 0, 0);
		end		
	else

	end
end

--------------------------------------------------------------------
-- 보유스킬 라디오버튼 클릭 이벤트
--------------------------------------------------------------------
function MyRoom_SkillKindTabClick(args)
	local local_window	= CEGUI.toWindowEventArgs(args).window
	if CEGUI.toRadioButton(local_window):isSelected() then
		local ButtonIndex	= tonumber(local_window:getUserString("Index"))
		
		for i = 1, #tAllSkillTree do
			for j = 1, #tAllSkillTree[i] do
				winMgr:getWindow("MyRoom_EmptyOrSkill"..i..j):setVisible(false)
			end
		end
		for i = 1, PAGE_MAXSKILLTAB do
			winMgr:getWindow("MyRoom_SkillEmpty"..i):setVisible(true)
		end
		local TotalPage	= MyRoom_GetSkillTreeTotalPage(1, ButtonIndex)	-- 총 페이지수를 구해준다
		
	
	end
end


RegistEscEventInfo("MyRoom_ChangeNameAlpha", "OnClick_ChangeNameCancel")
RegistEnterEventInfo("MyRoom_ChangeNameAlpha", "OnClick_ChangeNameOk")
------------------------------------------------
-- 이름바꾸기에 사용될 알파이미지
------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyRoom_ChangeNameAlpha")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)


------------------------------------------------
---이름바꾸기에 사용될 메인이미지
------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyRoom_ChangeNameWindow")
mywindow:setTexture("Enabled", "UIData/popup001.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/popup001.tga", 0, 0)
mywindow:setPosition((g_MAIN_WIN_SIZEX - 338) / 2, (g_MAIN_WIN_SIZEY - 270) / 2);
mywindow:setSize(338, 270)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow('MyRoom_ChangeNameAlpha'):addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/StaticText", "NoticeStaticText")
mywindow:setTextColor(255,200,50,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 15)
mywindow:setText(PreCreateString_1657)			-- GetSStringInfo(LAN_LUA_CREATE_CHARACTER_1)
mywindow:setSize(220, 20)
mywindow:setPosition(100, 100)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('MyRoom_ChangeNameWindow'):addChildWindow(mywindow)


------------------------------------------------
---이름바꾸기에 사용될 EDITBOX
------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Editbox", "MyRoom_ChangeNameEditBox")
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 112)
mywindow:setText("")
--mywindow:setAlphaWithChild(0)
--mywindow:setUseEventController(false)
mywindow:setSize(200, 25)
mywindow:setPosition(70, 150)
mywindow:setZOrderingEnabled(false)
CEGUI.toEditbox(mywindow):setMaxTextLength(12)
winMgr:getWindow('MyRoom_ChangeNameWindow'):addChildWindow(mywindow)


------------------------------------------------
-- 이름바꾸기 확인, 취소버튼
------------------------------------------------
OkCancel_BtnName  = {["err"]=0, "MyRoom_ChangeNameOkBtn", "MyRoom_ChangeNameCancelBtn"}
OkCancel_BtnTexX  = {["err"]=0,		693,	858}
OkCancel_BtnPosX  = {["err"]=0,		4,		169}
OkCancel_BtnEvent = {["err"]=0, "OnClick_ChangeNameOk", "OnClick_ChangeNameCancel"}


for i=1, #OkCancel_BtnName do
	mywindow = winMgr:createWindow("TaharezLook/Button", OkCancel_BtnName[i]);
	mywindow:setTexture("Normal", "UIData/popup001.tga", OkCancel_BtnTexX[i], 849);
	mywindow:setTexture("Hover", "UIData/popup001.tga", OkCancel_BtnTexX[i], 878);
	mywindow:setTexture("Pushed", "UIData/popup001.tga", OkCancel_BtnTexX[i], 907);
	mywindow:setTexture("PushedOff", "UIData/popup001.tga", OkCancel_BtnTexX[i], 936);
	mywindow:setSize(166, 29);
	mywindow:setPosition(OkCancel_BtnPosX[i], 235);	
	mywindow:subscribeEvent("Clicked", OkCancel_BtnEvent[i])
	winMgr:getWindow('MyRoom_ChangeNameWindow'):addChildWindow(mywindow)
	
end


------------------------------------------------
-- 이름바꾸기 확인버튼 클릭
------------------------------------------------
function OnClick_ChangeNameOk(args)
	winMgr:getWindow('MyRoom_ChangeNameAlpha'):setVisible(false)
	local ChageName = winMgr:getWindow('MyRoom_ChangeNameEditBox'):getText()
	
	for i = 1, PAGE_MAXITEM do 
		if CEGUI.toRadioButton(winMgr:getWindow("MyRoom_Item"..i)):isSelected() then
			local ListIndex		= 	tonumber(winMgr:getWindow("MyRoom_Item"..i):getUserString('ListIndex'))
			WndMyRoom_ChageNickName(ChageName, ListIndex)
			break
		end
	end
end


------------------------------------------------
---이름바꾸기에 취소버튼 클릭
------------------------------------------------
function OnClick_ChangeNameCancel(args)
	winMgr:getWindow('MyRoom_ChangeNameAlpha'):setVisible(false)

end








RegistEscEventInfo("MyRoom_KeyInput", "CapsuleButtonEvent")
RegistEnterEventInfo("MyRoom_KeyInput", "CapsuleButtonEvent")
RegistEnterEventInfo("MyRoom_WhiteEffect", "CapsuleButtonEvent")
------------------------------------------------
-- 캡슐아이템 알파.
------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyRoom_ExchangeItemAlpha")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:addController("CapsuleBoxAlphaControler", "CapsuleAlphaEvent", "alpha", "Sine_EaseInOut", 0, 255, 30, true, false, 10)
root:addChildWindow(mywindow)


CapsuleResultRender	= false
-------------------------------------------------------------
-- 캡슐아이템 보상윈도우
-------------------------------------------------------------
startPos	= 200

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyRoom_ExchangeItemMain")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 255)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 255)
mywindow:setPosition(420, (g_MAIN_WIN_SIZEY - 313) / 2);
mywindow:setSize(243, 313)
mywindow:setVisible(false)
mywindow:setAlign(8)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:clearControllerEvent("CapsuleEvent");
mywindow:clearActiveController()
mywindow:addController("CapsuleBoxControler", "CapsuleEvent", "xscale", "Quintic_EaseIn", 30, 255, 5, true, false, 10)
mywindow:addController("CapsuleBoxControler", "CapsuleEvent", "yscale", "Quintic_EaseIn", 50, 255, 5, true, false, 10)
mywindow:addController("CapsuleBoxControler", "CapsuleEvent", "y", "Sine_EaseInOut", startPos , startPos - 307, 4, true, false, 10)
mywindow:addController("CapsuleBoxControler", "CapsuleEvent", "y", "Sine_EaseInOut", startPos - 307, startPos, 2, true, false, 10)
mywindow:addController("CapsuleBoxControler", "CapsuleEvent", "y", "Sine_EaseInOut", startPos, startPos - 39, 2, true, false, 10)
mywindow:addController("CapsuleBoxControler", "CapsuleEvent", "y", "Sine_EaseInOut", startPos - 39, startPos, 1, true, false, 10)
mywindow:addController("CapsuleBoxControler", "CapsuleEvent", "y", "Sine_EaseInOut", startPos, startPos - 9, 1, true, false, 10)
mywindow:addController("CapsuleBoxControler", "CapsuleEvent", "y", "Sine_EaseInOut", startPos - 9, startPos, 1, true, false, 10)
mywindow:subscribeEvent("MotionEventEnd", "CapsuleMotionEnd");
mywindow:subscribeEvent("StartRender", "ExchangeItemMainRender")
root:addChildWindow(mywindow)


-------------------------------------------------------------
-- 캡슐아이템 키 입력 막기위해
-------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyRoom_KeyInput")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(0, 0);
mywindow:setSize(100, 20)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)



mywindow = winMgr:createWindow("TaharezLook/Button", "CapsuleRewardItemButton");
mywindow:setTexture("Normal", "UIData/quest1.tga", 0, 786)
mywindow:setTexture("Hover", "UIData/quest1.tga", 0, 815)
mywindow:setTexture("Pushed", "UIData/quest1.tga", 0, 844)
mywindow:setTexture("Disabled", "UIData/quest1.tga", 0, 873)
mywindow:setPosition(3, 279);
mywindow:setSize(237, 29);
mywindow:subscribeEvent("Clicked", "CapsuleButtonEvent")
winMgr:getWindow('MyRoom_ExchangeItemMain'):addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyRoom_WhiteEffect")
mywindow:setTexture("Enabled", "UIData/blwhite.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/blwhite.tga", 0, 0)
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
--mywindow:addController("CapsuleBoxAlphaControler", "WhiteEffectEvent", "alpha", "Sine_EaseInOut", 50, 255, 2, true, false, 10)
mywindow:addController("CapsuleBoxAlphaControler", "WhiteEffectEvent", "alpha", "Sine_EaseInOut", 255, 0, 20, true, false, 10)
Realroot:addChildWindow(mywindow)


tCapsuleItemInfo	= {['err'] = 0, "", "", "", 0, "", 0} -- 마지막 [7]은 1은 zen만 들어올경우

tick		= 0
function ExchangeItemMainRender(args)
	local local_window	= CEGUI.toWindowEventArgs(args).window
	local _drawer		= local_window:getDrawer()
	if CapsuleResultRender == false then
		return
	end
		
	_drawer:setTextColor(255, 169, 83,255)
	_drawer:setFont(g_STRING_FONT_GULIM, 11)
	local String = AdjustString(g_STRING_FONT_GULIM, 11, MR_String_86, 205)					-- 아이템 설명
	
	-- zen만 보상 받을 때
	if tCapsuleItemInfo[7] == 1 then
		_drawer:drawTexture("UIData/quest1.tga", 0, 0, 243, 179, 0, 255)
		_drawer:drawTexture("UIData/quest1.tga", 0, 179, 243, 33, 0, 534)
		_drawer:drawTextureSA("UIData/GameSlotItem001.tga", 12, 47,   98, 91,   392, 842,   244, 240,   255, 0, 0);	-- 그랑 이미지	
		DrawEachNumber("UIData/GameNewImage.tga", tCapsuleItemInfo[4], 8, 162, 82, 32, 838, 19, 25, 19,  _drawer)		-- 그랑 숫자 이미지.
		_drawer:drawText(String, 15, 150)
		DebugStr("zen : "..tCapsuleItemInfo[4])
	-- zen이랑 아이템을 같이 보상 받을 때
	else
	
		if tCapsuleItemInfo[4] > 0 then
			_drawer:drawTexture("UIData/quest1.tga", 0, 0, 243, 313, 0, 255)
			
			_drawer:drawTextureA("UIData/quest1.tga", 4, 142, 235, 97, 243, 255, 255)
			-- 두번째 보상(그랑)
			_drawer:drawTextureSA("UIData/GameSlotItem001.tga", 12, 147,   98, 91,   392, 842,   244, 240,   255, 0, 0);	-- 그랑 이미지	
			DrawEachNumber("UIData/GameNewImage.tga", tCapsuleItemInfo[4], 8, 162, 182, 32, 838, 19, 25, 19,  _drawer)		-- 그랑 숫자 이미지.
			_drawer:drawText(String, 15, 250)	
		else
			_drawer:drawTexture("UIData/quest1.tga", 0, 0, 243, 179, 0, 255)
			_drawer:drawTexture("UIData/quest1.tga", 0, 179, 243, 33, 0, 534)
			_drawer:drawText(String, 15, 150)	
		end
		
		_drawer:drawTextureA("UIData/quest1.tga", 4,  42, 235, 97, 243, 255, 255)
		
		-- 첫번째 보상
		_drawer:setTextColor(255,205,86,255)
		_drawer:setFont(g_STRING_FONT_GULIM, 12)
		local String = SummaryString(g_STRING_FONT_GULIM, 12, tCapsuleItemInfo[1], 100)
		local Size = GetStringSize(g_STRING_FONT_GULIM, 12, String)						-- 아이템 이름
		_drawer:drawText(String, (340 - Size) / 2, 54)
		
		_drawer:setTextColor(255,255,255,255)
		_drawer:setFont(g_STRING_FONT_GULIM, 11)
		String = AdjustString(g_STRING_FONT_GULIM, 11, tCapsuleItemInfo[3], 110)					-- 아이템 설명
		_drawer:drawText(String, 113, 75)		
		
		_drawer:drawTextureSA(tCapsuleItemInfo[2], 12, 48,   256, 256,   0, 0,   204, 218,   255, 0, 0);	-- 아이템 이미지.
		if tCapsuleItemInfo[6] ~= "" then
			_drawer:drawTextureSA(tCapsuleItemInfo[6], 12, 48,   256, 256,   0, 0,   204, 218,   255, 0, 0);	-- 아이템 이미지.
		end
			
		local Size = GetStringSize(g_STRING_FONT_GULIM, 11, "x "..tCapsuleItemInfo[5])						-- 아이템 갯수
		common_DrawOutlineText1(_drawer, "x "..tCapsuleItemInfo[5], 102 - Size, 55, 56, 0,0,0,255, 255,255,255,0);
		--_drawer:drawText("x "..tCapsuleItemInfo[5], 106 - Size, 55)
	end
end


function CapsuleButtonEvent(args)
	tCapsuleItemInfo[1]	= ""
	tCapsuleItemInfo[2]	= ""
	tCapsuleItemInfo[3]	= ""
	tCapsuleItemInfo[4]	= 0
	tCapsuleItemInfo[5] = 0
	tCapsuleItemInfo[6]	= ""
	tCapsuleItemInfo[7] = 0
	SettingPresentState(0)		-- 3d 애니메이션 변수 초기화
	ToC_ExchangeItemEnter()
	CapsuleResultRender	= false
	winMgr:getWindow("MyRoom_ExchangeItemAlpha"):setVisible(false)
	winMgr:getWindow('MyRoom_ExchangeItemMain'):setVisible(false)
	winMgr:getWindow("MyRoom_WhiteEffect"):setVisible(false)
	winMgr:getWindow('MyRoom_ExchangeItemMain'):clearActiveController()
	winMgr:getWindow("MyRoom_KeyInput"):setVisible(false)		
end


function SaveCapsuleItemInfo(ItemName, ItemFileName, ItemFileName2, ItemDesc, money, Count, onlyZen)
	tCapsuleItemInfo[1]	= ItemName
	tCapsuleItemInfo[2]	= ItemFileName
	tCapsuleItemInfo[3]	= ItemDesc
	tCapsuleItemInfo[4]	= money
	tCapsuleItemInfo[5]	= Count
	tCapsuleItemInfo[6]	= ItemFileName2
	tCapsuleItemInfo[7] = onlyZen
	--winMgr:getWindow('MyRoom_ExchangeItemMain'):setVisible(true)
	
	if onlyZen == 1 then
		winMgr:getWindow("CapsuleRewardItemButton"):setPosition(3, 179)
	else
		if money > 0 then
			winMgr:getWindow("CapsuleRewardItemButton"):setPosition(3, 279)
		else
			winMgr:getWindow("CapsuleRewardItemButton"):setPosition(3, 179)
		end
	end
	SettingPresentState(1)		-- 3d 애니메이션을 돌려준다.
end


function ShowCapuleAlpha()
	root:addChildWindow(winMgr:getWindow("MyRoom_ExchangeItemAlpha"))
	winMgr:getWindow("MyRoom_ExchangeItemAlpha"):setVisible(true)
	winMgr:getWindow("MyRoom_ExchangeItemAlpha"):activeMotion("CapsuleAlphaEvent");	
end

function ShowCapuleReward()
	winMgr:getWindow("MyRoom_ExchangeItemMain"):activeMotion("CapsuleEvent");
	root:addChildWindow(winMgr:getWindow("MyRoom_ExchangeItemMain"))
	winMgr:getWindow('MyRoom_ExchangeItemMain'):setVisible(true)	
	
	Realroot:addChildWindow(winMgr:getWindow("MyRoom_WhiteEffect"))
	winMgr:getWindow("MyRoom_WhiteEffect"):setVisible(true)
	winMgr:getWindow("MyRoom_WhiteEffect"):activeMotion("WhiteEffectEvent");	

--	winMgr:getWindow("MyRoom_WhiteEffect"):setTexture("Disabled", "UIData/blackFadeIn.tga", 0, 0)
	
--	winMgr:getWindow("MyRoom_WhiteEffect"):setTexture("Disabled", "UIData/nm1.tga", 0, 0)
end


fileNameTable = {['err'] = 0, [0] = "nm1", "blackFadeIn", "nm1"}
function WhiteEffect(index)
	--winMgr:getWindow("MyRoom_WhiteEffect"):setTexture("Disabled", "UIData/"..fileNameTable[index]..".tga", 0, 0)
end

MotionCount	= 0

function CapsuleMotionEnd(args)
	if MotionCount	== 0 then
		CapsuleResultRender	= true
	elseif MotionCount == 2 then
		MotionCount = 0
		winMgr:getWindow("MyRoom_KeyInput"):setVisible(true)		
		return
	end
	MotionCount = MotionCount + 1
end




------------------------------------------------
-- 엠블럼 바꾸기
------------------------------------------------
local CheckEmblemInCheck = false

-- 엠블럼바꾸기 알파창
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ChangeAmblemAlpha")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)	
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)

RegistEscEventInfo("ChangeAmblemAlpha", "ChangeAmblemCancelEvent")
RegistEnterEventInfo("ChangeAmblemAlpha", "ChangeAmblemRegistEvent")

--  엠블럼바꾸기 메인이미지.
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ChangeAmblemMain")
mywindow:setTexture("Enabled", "UIData/fightClub_003.tga", 0, 468)
mywindow:setTexture("Disabled", "UIData/fightClub_003.tga", 0, 468)
mywindow:setPosition((g_MAIN_WIN_SIZEX - 340) / 2, (g_MAIN_WIN_SIZEY - 153) / 2)
mywindow:setSize(340, 153)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("ChangeAmblemAlpha"):addChildWindow(mywindow)


--  엠블럼바꾸기 엠블럼이미지.
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ChangeAmblemImg")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(17, 55)
mywindow:setSize(32, 32)
mywindow:setScaleWidth(183)
mywindow:setScaleHeight(183)
mywindow:setEnabled(false)	
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("ChangeAmblemMain"):addChildWindow(mywindow)



mywindow = winMgr:createWindow("TaharezLook/Editbox", "ChangeAmblemEdit")
mywindow:setFont(g_STRING_FONT_GULIMCHE, 114)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setText("basic.tga")
mywindow:setPosition(55, 53)
mywindow:setSize(180, 25)
mywindow:setAlphaWithChild(0)
mywindow:setEnabled(true)
mywindow:setZOrderingEnabled(false)
mywindow:setUseEventController(false)
CEGUI.toEditbox(mywindow):setMaxTextLength(20)
--CEGUI.toEditbox(mywindow):subscribeEvent("EditboxFull", "OnMessengerEditBoxFull")
--CEGUI.toEditbox(mywindow):subscribeEvent("TextAccepted", "ClubInputName")
winMgr:getWindow("ChangeAmblemMain"):addChildWindow(mywindow)



-- 엠블럼바꾸기 버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "ChangeAmblemButton")
mywindow:setTexture("Normal", "UIData/fightClub_001.tga", 111, 471)
mywindow:setTexture("Hover", "UIData/fightClub_001.tga", 111, 492)
mywindow:setTexture("Pushed", "UIData/fightClub_001.tga", 111, 513)
mywindow:setTexture("Disabled", "UIData/fightClub_001.tga", 111, 534)
mywindow:setPosition(223, 52)
mywindow:setSize(111, 21)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ChangeAmblemButtonEvent")
winMgr:getWindow("ChangeAmblemMain"):addChildWindow(mywindow)


-- 바꾸기 버튼
tAmblemButtonName  = {['err'] = 0, "ChangeAmblemRegistButton", "ChangeAmblemCancelButton"}
tAmblemButtonEvent = {['err'] = 0, "ChangeAmblemRegistEvent",  "ChangeAmblemCancelEvent"}

for i = 1, #tAmblemButtonName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tAmblemButtonName[i])
	mywindow:setTexture("Normal", "UIData/popup001.tga", 693 + (i-1)*165, 849)
	mywindow:setTexture("Hover", "UIData/popup001.tga", 693 + (i-1)*165, 878)
	mywindow:setTexture("Pushed", "UIData/popup001.tga", 693 + (i-1)*165, 907)
	mywindow:setTexture("Disabled", "UIData/popup001.tga", 693 + (i-1)*165, 907)
	mywindow:setPosition(4 + (i-1)*165, 119)
	mywindow:setSize(166, 29)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", tAmblemButtonEvent[i])
	winMgr:getWindow("ChangeAmblemMain"):addChildWindow(mywindow)
end


-- 엠블럼 바꾸는 창을 띄워준다.
function ShowChangeAmblemWin()
	root:addChildWindow(winMgr:getWindow("ChangeAmblemAlpha"))
	winMgr:getWindow("ChangeAmblemAlpha"):setVisible(true)
	winMgr:getWindow("ChangeAmblemImg"):setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	winMgr:getWindow("ChangeAmblemImg"):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	winMgr:getWindow("ChangeAmblemEdit"):setText("basic.tga")
	CheckEmblemInCheck = false
end


-- 찾아보기 버튼 이벤트
function ChangeAmblemButtonEvent(args)
	
	local Edit = winMgr:getWindow("ChangeAmblemEdit"):getText()
	ToC_ChangeEmblem(Edit)
	
end


-- 엠블럼이미지를 셋팅한다.
function SetAmblemImage(ImageName)
	CheckEmblemInCheck = true
	winMgr:getWindow("ChangeAmblemImg"):setTexture("Enabled", ImageName, 0, 0)
	winMgr:getWindow("ChangeAmblemImg"):setTexture("Disabled", ImageName, 0, 0)
end



-- 등록 버튼 이벤트
function ChangeAmblemRegistEvent(args)
	if CheckEmblemInCheck == false then
		ShowNotifyOKMessage_Lua(MR_String_80)
		return
	end
	winMgr:getWindow("ChangeAmblemImg"):setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	winMgr:getWindow("ChangeAmblemImg"):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	winMgr:getWindow("ChangeAmblemAlpha"):setVisible(false)
	
	for i = 1, PAGE_MAXITEM do 
		if CEGUI.toRadioButton(winMgr:getWindow("MyRoom_Item"..i)):isSelected() then
			local ListIndex		= 	tonumber(winMgr:getWindow("MyRoom_Item"..i):getUserString('ListIndex'))
			ToC_SendChangeEmblem(ListIndex)
			break
		end
	end
	

end

-- 취소 버튼 이벤트
function ChangeAmblemCancelEvent(arge)
	winMgr:getWindow("ChangeAmblemImg"):setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	winMgr:getWindow("ChangeAmblemAlpha"):setVisible(false)
end

function ShowAdapterWindow()
	for i = 1, PAGE_MAXITEM do 
		if CEGUI.toRadioButton(winMgr:getWindow("MyRoom_Item"..i)):isSelected() then
			local ListIndex		= 	tonumber(winMgr:getWindow("MyRoom_Item"..i):getUserString('ListIndex'))
				adapterEvent(ListIndex)
			break
		end
	end
end

-- 샵의 캐릭터 관련 뒷판 이미지 윈도우를 얻어온다.
function GetEachBaseBackName()
	return winMgr:getWindow("MyRoom_CharacterBackImg")
end



--------------------------------------------------------------------
-- 더티엑스 전직확인창
--------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'dirtyX_AlphaImage');
mywindow:setTexture('Enabled', 'UIData/OnDLGBackImage.tga', 0, 0);
mywindow:setPosition(0,0);
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow);

RegistEscEventInfo("dirtyX_AlphaImage", "HideDirtyXChangeImage")

-- 메인
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'dirtyX_MainImage');
mywindow:setTexture("Enabled", "UIData/jobchange4.tga", 0, 488)
mywindow:setPosition(244, 216)
mywindow:setSize(537, 336)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('dirtyX_AlphaImage'):addChildWindow(mywindow);


-- 보상 팝업창 닫기버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "dirtyX_MainCloseButton");
mywindow:setTexture("Normal", "UIData/jobchange4.tga", 794, 488);
mywindow:setTexture("Hover", "UIData/jobchange4.tga", 829, 488);
mywindow:setTexture("Pushed", "UIData/jobchange4.tga", 864, 488);
mywindow:setTexture("PushedOff", "UIData/jobchange4.tga", 794, 488);
mywindow:setPosition(497, 33)
mywindow:setSize(35, 35)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "HideDirtyXChangeImage");
winMgr:getWindow("dirtyX_MainImage"):addChildWindow(mywindow)


-- 전직 클래스 이름
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "dirtyX_NameImage")
mywindow:setTexture("Enabled", "UIData/jobchange4.tga", 537, 760)
mywindow:setPosition(120, 33)
mywindow:setSize(210, 36)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("dirtyX_MainImage"):addChildWindow(mywindow)


-- 전직 스피커맨 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RewardSpeakermanImage")
mywindow:setTexture("Enabled", "UIData/jobchange4.tga", 720, 0)
mywindow:setPosition(0, 90)
mywindow:setSize(144, 244)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("dirtyX_MainImage"):addChildWindow(mywindow)

-- 전직 설명
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "dirtyX_DescImage")
mywindow:setTexture("Enabled", "UIData/jobchange4.tga", 0, 860)
mywindow:setPosition(140, 78)
mywindow:setSize(391, 164)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("dirtyX_MainImage"):addChildWindow(mywindow)



-- 전직 확인창 보여준다,
function ShowDirtyXChangeImage(promotion)
	DirtyXChangeClassResultSetting(promotion)
	root:addChildWindow(winMgr:getWindow('dirtyX_AlphaImage'))
	winMgr:getWindow('dirtyX_AlphaImage'):setVisible(true)
	
end

-- 전직 확인창 보여준다,
function HideDirtyXChangeImage()
	winMgr:getWindow('dirtyX_AlphaImage'):setVisible(false)
end

-- 전직 완료후, Notify창 이미지 셋팅 함수.
function DirtyXChangeClassResultSetting(promotion)
	--==========================
	-- 더티 엑스
	--==========================
	if promotion == 5 then
		winMgr:getWindow("dirtyX_NameImage"):setTexture("Enabled",		"UIData/jobchange4.tga", 537, 760)	-- 이름
		winMgr:getWindow("RewardSpeakermanImage"):setTexture("Enabled", "UIData/jobchange4.tga", 720, 0)	-- 스피커맨 이미지
		winMgr:getWindow("RewardSpeakermanImage"):setPosition(0, 90)
		winMgr:getWindow("RewardSpeakermanImage"):setSize(144, 244)

		winMgr:getWindow("dirtyX_DescImage"):setTexture("Enabled", "UIData/jobchange4.tga", 0, 860)			-- 설명
		winMgr:getWindow("dirtyX_DescImage"):setPosition(140, 78)
		winMgr:getWindow("dirtyX_DescImage"):setSize(391, 164)
	
	--==========================
	-- 스모
	--==========================
	elseif promotion == 6 then
		winMgr:getWindow("dirtyX_NameImage"):setTexture("Enabled",		"UIData/jobchange4.tga", 537, 796)	-- 이름
		winMgr:getWindow("RewardSpeakermanImage"):setTexture("Enabled", "UIData/jobchange4.tga", 720, 244)	-- 스피커맨 이미지
		winMgr:getWindow("RewardSpeakermanImage"):setPosition(-25, 90)
		winMgr:getWindow("RewardSpeakermanImage"):setSize(167, 244)

		winMgr:getWindow("dirtyX_DescImage"):setTexture("Enabled", "UIData/jobchange4.tga", 655, 860)		-- 설명
		winMgr:getWindow("dirtyX_DescImage"):setSize(369, 164)
	
	--==========================
	-- 쿵푸
	--==========================
	elseif promotion == 7 then
		winMgr:getWindow("dirtyX_NameImage"):setTexture("Enabled",		"UIData/jobchange4.tga", 748, 795)	-- 이름
		winMgr:getWindow("RewardSpeakermanImage"):setTexture("Enabled", "UIData/jobchange4.tga", 864, 0)	-- 스피커맨 이미지
		winMgr:getWindow("RewardSpeakermanImage"):setPosition(-25, 90)
		winMgr:getWindow("RewardSpeakermanImage"):setSize(144, 244)
		
		-- 간격은 144

		winMgr:getWindow("dirtyX_DescImage"):setTexture("Enabled", "UIData/ChangedJobs.tga", 655, 0)		-- 설명
		winMgr:getWindow("dirtyX_DescImage"):setSize(369, 142)
	
	--==========================
	-- 닌자
	--==========================
	elseif promotion == 8 then
		winMgr:getWindow("dirtyX_NameImage"):setTexture("Enabled",		"UIData/jobchange4.tga", 537, 832)	-- 이름
		winMgr:getWindow("RewardSpeakermanImage"):setTexture("Enabled", "UIData/jobchange4.tga", 576, 244)	-- 스피커맨 이미지
		winMgr:getWindow("RewardSpeakermanImage"):setPosition(-25, 90)
		winMgr:getWindow("RewardSpeakermanImage"):setSize(144, 244)
		
		-- 간격은 144

		winMgr:getWindow("dirtyX_DescImage"):setTexture("Enabled", "UIData/jobchange5.tga", 0, 0)		-- 설명
		winMgr:getWindow("dirtyX_DescImage"):setSize(369, 164)

	elseif promotion == 9 then
		winMgr:getWindow("dirtyX_NameImage"):setTexture("Enabled",		"UIData/jobchange4.tga", 748, 832)	-- 이름
		winMgr:getWindow("RewardSpeakermanImage"):setTexture("Enabled", "UIData/jobchange4.tga",  579, 0)	-- 스피커맨 이미지
		winMgr:getWindow("RewardSpeakermanImage"):setPosition(-25, 90)
		winMgr:getWindow("RewardSpeakermanImage"):setSize(144, 244)
		
		-- 간격은 144

		winMgr:getWindow("dirtyX_DescImage"):setTexture("Enabled", "UIData/jobchange5.tga", 0, 164)		-- 설명
		winMgr:getWindow("dirtyX_DescImage"):setSize(369, 164)
	end	
	
end









