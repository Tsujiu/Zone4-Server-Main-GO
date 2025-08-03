
-----------------------------------------------------------------------

--	문자열 로드

-----------------------------------------------------------------------
local STRING_TUTORIALEX_1		= PreCreateString_1309	--GetSStringInfo(LAN_LUA_WND_PRACTICE_DESIGNER_1)
local STRING_TUTORIALEX_2		= PreCreateString_1310	--GetSStringInfo(LAN_LUA_WND_PRACTICE_DESIGNER_2)
local STRING_TUTORIALEX_3		= PreCreateString_1311	--GetSStringInfo(LAN_LUA_WND_PRACTICE_DESIGNER_3)
local STRING_TUTORIALEX_4		= PreCreateString_1312	--GetSStringInfo(LAN_LUA_WND_PRACTICE_DESIGNER_4)
local STRING_TUTORIALEX_5		= PreCreateString_1313	--GetSStringInfo(LAN_LUA_WND_PRACTICE_DESIGNER_5)
local STRING_TUTORIALEX_6		= PreCreateString_1314	--GetSStringInfo(LAN_LUA_WND_PRACTICE_DESIGNER_6)
local STRING_TUTORIALEX_7		= PreCreateString_1315	--GetSStringInfo(LAN_LUA_WND_PRACTICE_DESIGNER_7)
local STRING_TUTORIALEX_8		= PreCreateString_1316	--GetSStringInfo(LAN_LUA_WND_PRACTICE_DESIGNER_8)
local STRING_TUTORIALEX_9		= PreCreateString_1317	--GetSStringInfo(LAN_LUA_WND_PRACTICE_DESIGNER_9)
local STRING_TUTORIALEX_10		= PreCreateString_1318	--GetSStringInfo(LAN_LUA_WND_PRACTICE_DESIGNER_10)
local STRING_TUTORIALEX_11		= PreCreateString_1319	--GetSStringInfo(LAN_LUA_WND_PRACTICE_DESIGNER_11)
local STRING_TUTORIALEX_12		= PreCreateString_1320	--GetSStringInfo(LAN_LUA_WND_PRACTICE_DESIGNER_12)
local STRING_TUTORIALEX_13		= PreCreateString_1321	--GetSStringInfo(LAN_LUA_WND_PRACTICE_DESIGNER_13)
local STRING_TUTORIALEX_14		= PreCreateString_1322	--GetSStringInfo(LAN_LUA_WND_PRACTICE_DESIGNER_14)
local STRING_TUTORIALEX_15		= PreCreateString_1323	--GetSStringInfo(LAN_LUA_WND_PRACTICE_DESIGNER_15)
local STRING_TUTORIALEX_16		= PreCreateString_1324	--GetSStringInfo(LAN_LUA_WND_PRACTICE_DESIGNER_16)
local STRING_TUTORIALEX_17		= PreCreateString_1325	--GetSStringInfo(LAN_LUA_WND_PRACTICE_DESIGNER_17)
local STRING_TUTORIALEX_18		= PreCreateString_1326	--GetSStringInfo(LAN_LUA_WND_PRACTICE_DESIGNER_18)
local STRING_TUTORIALEX_19		= PreCreateString_1327	--GetSStringInfo(LAN_LUA_WND_PRACTICE_DESIGNER_19)
local STRING_TUTORIALEX_20		= PreCreateString_1328	--GetSStringInfo(LAN_LUA_WND_PRACTICE_DESIGNER_20)
local STRING_TUTORIALEX_21		= PreCreateString_1329	--GetSStringInfo(LAN_LUA_WND_PRACTICE_DESIGNER_21)
local STRING_TUTORIALEX_22		= PreCreateString_1330	--GetSStringInfo(LAN_LUA_WND_PRACTICE_DESIGNER_22)
local STRING_TUTORIALEX_23		= PreCreateString_1331	--GetSStringInfo(LAN_LUA_WND_PRACTICE_DESIGNER_23)
local STRING_TUTORIALEX_24		= PreCreateString_1332	--GetSStringInfo(LAN_LUA_WND_PRACTICE_DESIGNER_24)
local STRING_TUTORIALEX_25		= PreCreateString_1333	--GetSStringInfo(LAN_LUA_WND_PRACTICE_DESIGNER_25)
local STRING_TUTORIALEX_26		= PreCreateString_1334	--GetSStringInfo(LAN_LUA_WND_PRACTICE_DESIGNER_26)
local STRING_TUTORIALEX_27		= PreCreateString_1335	--GetSStringInfo(LAN_LUA_WND_PRACTICE_DESIGNER_27)
local STRING_TUTORIALEX_28		= PreCreateString_1336	--GetSStringInfo(LAN_LUA_WND_PRACTICE_DESIGNER_28)
local STRING_TUTORIALEX_29		= PreCreateString_1337	--GetSStringInfo(LAN_LUA_WND_PRACTICE_DESIGNER_29)
local STRING_TUTORIALEX_30		= PreCreateString_1338	--GetSStringInfo(LAN_LUA_WND_PRACTICE_DESIGNER_30)
local STRING_TUTORIALEX_31		= PreCreateString_1339	--GetSStringInfo(LAN_LUA_WND_PRACTICE_DESIGNER_31)
local STRING_TUTORIALEX_32		= PreCreateString_1340	--GetSStringInfo(LAN_LUA_WND_PRACTICE_DESIGNER_32)
local STRING_TUTORIALEX_33		= PreCreateString_1341	--GetSStringInfo(LAN_LUA_WND_PRACTICE_DESIGNER_33)
local STRING_TUTORIALEX_34		= PreCreateString_1342	--GetSStringInfo(LAN_LUA_WND_PRACTICE_DESIGNER_34)
local STRING_TUTORIALEX_35		= PreCreateString_1343	--GetSStringInfo(LAN_LUA_WND_PRACTICE_DESIGNER_35)
local STRING_TUTORIALEX_36		= PreCreateString_1344	--GetSStringInfo(LAN_LUA_WND_PRACTICE_DESIGNER_36)
local STRING_TUTORIALEX_37		= PreCreateString_1345	--GetSStringInfo(LAN_LUA_WND_PRACTICE_DESIGNER_37)
local STRING_TUTORIALEX_38		= PreCreateString_1346	--GetSStringInfo(LAN_LUA_WND_PRACTICE_DESIGNER_38)
local STRING_TUTORIALEX_39		= PreCreateString_1347	--GetSStringInfo(LAN_LUA_WND_PRACTICE_DESIGNER_39)
local STRING_TUTORIALEX_40		= PreCreateString_1348	--GetSStringInfo(LAN_LUA_WND_PRACTICE_DESIGNER_40)
local STRING_TUTORIALEX_41		= PreCreateString_1349	--GetSStringInfo(LAN_LUA_WND_PRACTICE_DESIGNER_41)
local STRING_TUTORIALEX_42		= PreCreateString_1350	--GetSStringInfo(LAN_LUA_WND_PRACTICE_DESIGNER_42)
local STRING_TUTORIALEX_43		= PreCreateString_1351	--GetSStringInfo(LAN_LUA_WND_PRACTICE_DESIGNER_43)
local STRING_TUTORIALEX_44		= PreCreateString_1352	--GetSStringInfo(LAN_LUA_WND_PRACTICE_DESIGNER_44)
local STRING_TUTORIALEX_45		= PreCreateString_1353	--GetSStringInfo(LAN_LUA_WND_PRACTICE_DESIGNER_45)
local STRING_TUTORIALEX_46		= PreCreateString_1354	--GetSStringInfo(LAN_LUA_WND_PRACTICE_DESIGNER_46)





---------------------------------------------------
------------   스피커 맨 맨트 부분    -------------
---------------------------------------------------

-- 글씨 위아래 간격(인자-픽셀단위)
winMgr:getWindow('sj_practice_mentText'):setLineSpacing(15);

-- 폰트 설정
tSpkMentFontData = {['protecterr'] = 0, 
g_STRING_FONT_DODUMCHE, 16, 255,255,255,255,   1, 0,0,0,255 }

-- 기본 설면 멘트
tWelcomeMentString = {['err'] = 0, STRING_TUTORIALEX_1}--1309, 3338, 3339}

-- 메인메뉴 스피커맨 멘트
tMainMenuWelcomeMentString = {['err'] = 0, STRING_TUTORIALEX_2}

-- 튜토리얼 선택 멘트
tSelectTutorialMentString = {['err'] = 0, STRING_TUTORIALEX_3, STRING_TUTORIALEX_4}


-- 이동하기 전 설명 멘트
tMoveMentString = {['err'] = 0, STRING_TUTORIALEX_5, STRING_TUTORIALEX_6}

-- 대시하기 전 설명 멘트
tDashMentString = {['err'] = 0, STRING_TUTORIALEX_7}

-- 타격하기 전 설명 멘트
tHitMentString = {['err'] = 0, STRING_TUTORIALEX_8, STRING_TUTORIALEX_9, STRING_TUTORIALEX_10}

-- 잡기하기 전 설명 멘트
tGrabMentString = {['err'] = 0, STRING_TUTORIALEX_11, STRING_TUTORIALEX_12}

-- 회피하기 전 설명 멘트
tEvadeMentString = {['err'] = 0, STRING_TUTORIALEX_13, STRING_TUTORIALEX_14, STRING_TUTORIALEX_15, STRING_TUTORIALEX_16}

-- 필살기하기 전 설명 멘트
tSpecialMentString = {['err'] = 0, STRING_TUTORIALEX_17, STRING_TUTORIALEX_18, STRING_TUTORIALEX_19, STRING_TUTORIALEX_20}

-- 더블어택하기 전 설명 멘트
tDoubleAttackMentString = {['err'] = 0, STRING_TUTORIALEX_21, STRING_TUTORIALEX_22, STRING_TUTORIALEX_23, STRING_TUTORIALEX_24}

-- 팀 어택하기 전 설명 멘트
tTeamAttackMentString = {['err'] = 0, STRING_TUTORIALEX_25, STRING_TUTORIALEX_26, STRING_TUTORIALEX_27, STRING_TUTORIALEX_28}

-- 아이템전 아이템 사용법 설명 멘트
tItemUseMentString = {['err'] = 0, STRING_TUTORIALEX_29, STRING_TUTORIALEX_30, STRING_TUTORIALEX_31}

-- 노템전 도구 사용법 설명 멘트
tNoItemUseMentString = {['err'] = 0, STRING_TUTORIALEX_32, STRING_TUTORIALEX_33, STRING_TUTORIALEX_34}


-- 모든 튜터리얼 끝나고하는 멘트
tTutorialEndMentString = {['err'] = 0, STRING_TUTORIALEX_35, STRING_TUTORIALEX_36}
tTutorialEndMentString2 = {['err'] = 0, STRING_TUTORIALEX_35}



-- 텍스트 확장
-- 멘트 위치 부분 말창으로부터 몇 떨어져 있는지..
tMentPosX = 110;
tMentPosY = 55;


-- 이부분은 프로그래밍 부분
g_tTalkTable = {['protecterr'] = 0, 
-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }

if g_IsFirstTutorial == true then
	g_tTalkTable[1] = tWelcomeMentString;
else
	g_tTalkTable[1] = tMainMenuWelcomeMentString;
end

g_tTalkTable[2] = tMoveMentString
g_tTalkTable[3] = tDashMentString
g_tTalkTable[4] = tHitMentString
g_tTalkTable[5] = tGrabMentString
g_tTalkTable[6] = tEvadeMentString
g_tTalkTable[7] = tSpecialMentString
g_tTalkTable[8] = tDoubleAttackMentString
g_tTalkTable[9] = tTeamAttackMentString
g_tTalkTable[10] = tItemUseMentString
g_tTalkTable[11] = tNoItemUseMentString

if g_IsFirstTutorial == true then
	g_tTalkTable[12] = tTutorialEndMentString
else
	g_tTalkTable[12] = tTutorialEndMentString2;
end



g_tCurMentString = g_tTalkTable[1];

CEGUI.toGUISheet(g_spk_ment_window):setTextViewDelayTime(16);

local tbufStringTable = {['err']=0, }
local tbufSpecialTable = {['err']=0, }
local count = 0

tbufStringTable, tbufSpecialTable = cuttingString(g_tCurMentString[1], tbufStringTable, tbufSpecialTable, count)

for i=0, #tbufStringTable do
	local colorIndex = tonumber(tbufSpecialTable[i])
	if colorIndex == nil then
		colorIndex = 0
	end
	winMgr:getWindow('sj_practice_mentText'):addTextExtends(tbufStringTable[i], g_STRING_FONT_DODUMCHE, 16
								, tSpecialColorTable[colorIndex][0], tSpecialColorTable[colorIndex][1], tSpecialColorTable[colorIndex][2], 255
								, 1, 0,0,0,255);
end


function SpeekerManSettingMent(main_seq, sub_seq)
	if main_seq == 1 then
		g_spk_ment_window:addTextExtends('kkkkkk', g_STRING_FONT_HY_HEADLINE, 22, 255,255,255,255,   1, 0,0,0,255);
	elseif main_seq == 2 then
	elseif main_seq == 3 then
	elseif main_seq == 4 then
	elseif main_seq == 5 then
	elseif main_seq == 6 then
	elseif main_seq == 7 then
	elseif main_seq == 8 then
	elseif main_seq == 9 then
	elseif main_seq == 10 then
	elseif main_seq == 11 then
	elseif main_seq == 12 then
	end
end












-------------------------------------------------------

--	중간 튜토리얼 설명 부분

-------------------------------------------------------

-- 글씨 찍는 속도
g_MiddleMentAppearSpeed = 11;

-- 폰트 설정 
tSpkMiddleMentFontData = {['err'] = 0, 
g_STRING_FONT_DODUMCHE, 14, 255,200,86,255,   1, 0,0,0,255 }

-- 글씨 다 찍은 후 계속 보여지는 시간
g_ContinueViewTime = 180;

-- 이부분은 프로그래밍 부분
g_tMiddleTalkTable = {['err'] = 0, STRING_TUTORIALEX_37, STRING_TUTORIALEX_38, STRING_TUTORIALEX_39, STRING_TUTORIALEX_40, STRING_TUTORIALEX_41,
STRING_TUTORIALEX_42, STRING_TUTORIALEX_43, STRING_TUTORIALEX_44, STRING_TUTORIALEX_45, STRING_TUTORIALEX_46}

g_tCurMiddleMentString = g_tMiddleTalkTable[1];

winMgr:getWindow('AdditionHelp'):addController("vanishedAddHelper", "VisibleFire", "visible", "Linear_EaseNone", 1, 1, g_ContinueViewTime, true, false, 10)
winMgr:getWindow('AdditionHelp'):addController("vanishedAddHelper", "VisibleFire", "visible", "Linear_EaseNone", 0, 0, 1, true, false, 10)
winMgr:getWindow('AdditionHelp'):subscribeEvent('CompleteViewText', 'OnCompleteViewText');
