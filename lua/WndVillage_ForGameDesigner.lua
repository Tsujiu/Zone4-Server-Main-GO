
function WndVillage_ForGameDesigner_WndVillage_ForGameDesigner()

-----------------------------------------
-- 초기 카메라 위치 세팅
-----------------------------------------
-- 앵글, 타겟위치와의 거리, 카메라의 높이, 카메라 타겟의 높이
--SetCameraOption(150, 2000, 30, 100);	-- SceneDesign.dat에서 적용

-----------------------------------------
-- 광장 캐릭터 속도 및 걷는 애니메이션
-----------------------------------------
SetMoveVelocity(70, 80);
--SetMoveAniFile("AVM_남걷기.kf", "AVW_여걷기.kf");
SetMoveAniFile("A_이동Changed-move.kf", "A_이동여자Changed-move.kf");
SetLightDir(250, -190, 250);



-----------------------------------------
-- 채팅 뷰 글씨 색 설정
-----------------------------------------
--[[
CEGUI.WindowManager:getSingleton():getWindow('sj_systemChat_0'):setTextColor(255, 200, 80, 255);
CEGUI.WindowManager:getSingleton():getWindow('sj_systemChat_0'):setTextOutLineColor(0, 0, 0, 255);

CEGUI.WindowManager:getSingleton():getWindow('sj_systemChat_1'):setTextColor(0, 0, 0, 255);
CEGUI.WindowManager:getSingleton():getWindow('sj_systemChat_1'):setTextOutLineColor(0, 0, 0, 255);

CEGUI.WindowManager:getSingleton():getWindow('multichat_list_1'):setTextColor(255, 255, 255, 255);
CEGUI.WindowManager:getSingleton():getWindow('multichat_list_1'):setTextOutLineColor(0, 0, 0, 255);

CEGUI.WindowManager:getSingleton():getWindow('multichat_list_2'):setTextColor(255, 255, 255, 255);
CEGUI.WindowManager:getSingleton():getWindow('multichat_list_2'):setTextOutLineColor(0, 0, 0, 255);

CEGUI.WindowManager:getSingleton():getWindow('multichat_list_3'):setTextColor(255, 255, 255, 255);
CEGUI.WindowManager:getSingleton():getWindow('multichat_list_3'):setTextOutLineColor(0, 0, 0, 255);
--]]
-----------------------------------------
-- 채팅 처음 세팅
-----------------------------------------
local VGD_String_Action = {["protecterr"]=0, }
VGD_String_Action[0]	= PreCreateString_2536	--GetSStringInfo(LAN_WATER_GUN)		-- /물총 watergun
VGD_String_Action[1]	= PreCreateString_1695	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_41)		-- /춤1
VGD_String_Action[2]	= PreCreateString_1712	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_58)		-- /춤2
VGD_String_Action[3]	= PreCreateString_2382	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_100)		-- /춤3
VGD_String_Action[4]	= PreCreateString_2383	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_101)		-- /춤4
VGD_String_Action[5]	= PreCreateString_1711	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_57)		-- /위협
VGD_String_Action[6]	= PreCreateString_1696	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_42)		-- /따귀
VGD_String_Action[7]	= PreCreateString_1697	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_43)		-- /울기
VGD_String_Action[8]	= PreCreateString_1698	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_44)		-- /놉기
VGD_String_Action[9]	= PreCreateString_1699	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_45)		-- /포옹
VGD_String_Action[10]	= PreCreateString_1700	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_46)		-- /사랑해 --GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_47)		-- /손인사
VGD_String_Action[11]	= PreCreateString_1702	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_48)		-- /하하
VGD_String_Action[12]	= PreCreateString_1703	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_49)		-- /때리기
VGD_String_Action[13]	= PreCreateString_1704	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_50)		-- /긍정
VGD_String_Action[14]	= PreCreateString_1705	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_51)		-- /따귀맞기
VGD_String_Action[15]	= PreCreateString_1706	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_52)		-- /부정
VGD_String_Action[16]	= PreCreateString_1707	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_53)		-- /왜
VGD_String_Action[17]	= PreCreateString_1708	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_54)		-- /준비
VGD_String_Action[18]	= PreCreateString_1709	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_55)		-- /빵빵
VGD_String_Action[19]	= PreCreateString_1710	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_56)		-- /맞기
VGD_String_Action[20]	= PreCreateString_4744	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_113)		-- /춤5

-- 이모티콘 New 테이블
tNewEmoticonCheckTable = {['err']=0, }
tNewEmoticonCheckTable[0]	= false
tNewEmoticonCheckTable[1]	= false
tNewEmoticonCheckTable[2]	= false
tNewEmoticonCheckTable[3]	= false
tNewEmoticonCheckTable[4]	= false
tNewEmoticonCheckTable[5]	= false
tNewEmoticonCheckTable[6]	= false
tNewEmoticonCheckTable[7]	= false
tNewEmoticonCheckTable[8]	= false
tNewEmoticonCheckTable[9]	= false
tNewEmoticonCheckTable[10]	= false
tNewEmoticonCheckTable[11]	= false
tNewEmoticonCheckTable[12]	= false
tNewEmoticonCheckTable[13]	= false
tNewEmoticonCheckTable[14]	= false
tNewEmoticonCheckTable[15]	= false
tNewEmoticonCheckTable[16]	= false
tNewEmoticonCheckTable[17]	= false
tNewEmoticonCheckTable[18]	= false
tNewEmoticonCheckTable[19]	= false
tNewEmoticonCheckTable[20]	= false


--[[
local String_ActionList = ""
local String_ActionListNum = table.getn(VGD_String_Action)

for i = 1, String_ActionListNum do
	if i == String_ActionListNum then
		String_ActionList = String_ActionList.."/"..VGD_String_Action[i]
	else
		String_ActionList = String_ActionList.."/"..VGD_String_Action[i].." "
	end
end
--]]

-- 소셜액션 이름등록
tEmoticonActionName = {["err"]=0, }
for i=0, #VGD_String_Action do
	tEmoticonActionName[i] = "/"..VGD_String_Action[i]
end

STAND = 0
MOVE = 1
LAY	= 2

-- 추가 소셜액션
-- 남
AddSocial(STAND, "\/"..VGD_String_Action[0].."1"	, STAND, 'AVM_물총.kf'					, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[1].."1"	, STAND, 'AVM_dance01.kf'				, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[2].."1"	, STAND, 'AVM_dance02.kf'				, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[3].."1"	, STAND, 'AVM_dance03.kf'				, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[4].."1"	, STAND, 'AVM_dance04.kf'				, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[5].."1"	, STAND, 'AVM_위협.kf'					, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[6].."1"	, STAND, 'AVM_따귀때리기남자.kf'		, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[7].."1"	, STAND, 'AVM_남자울기.kf'				, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[8].."1"	, STAND, 'AVM_남자누워있기.kf'			, 0, 100)		-- 마지막 0은 무한의미
AddSocial(STAND, "\/"..VGD_String_Action[9].."1"	, STAND, 'AVM_힙합포옹.kf'				, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[10].."1"	, STAND, 'AVM_사랑의총.kf'				, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[11].."1"	, STAND, 'AVM_남자웃기.kf'				, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[12].."1"	, STAND, 'AVM_복부때리기.kf'			, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[13].."1"	, STAND, 'AVM_긍정.kf'					, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[14].."1"	, STAND, 'AVM_따귀맞기남자.kf'			, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[15].."1"	, STAND, 'AVM_부정.kf'					, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[16].."1"	, STAND, 'AVM_말하기왜.kf'				, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[17].."1"	, STAND, 'AVM_발풀기.kf'				, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[18].."1"	, STAND, 'AVM_사랑의총_연속네번.kf'		, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[19].."1"	, STAND, 'AVM_복부맞기.kf'				, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[20].."1"	, STAND, 'AVM_dance05.kf'				, 0, 100)
AddSocial(STAND, '\/응1'							, STAND, 'AVM_긍정.kf'					, 0, 100)
AddSocial(STAND, '\/ㅇㅇ1'							, STAND, 'AVM_긍정.kf'					, 0, 100)
AddSocial(STAND, '\/아니1'							, STAND, 'AVM_부정.kf'					, 0, 100)


-- 여
AddSocial(STAND, "\/"..VGD_String_Action[0].."2"	, STAND, 'AVW_물총.kf'					, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[1].."2"	, STAND, 'AVW_dance01.kf'				, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[2].."2"	, STAND, 'AVW_dance02.kf'				, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[3].."2"	, STAND, 'AVW_dance03.kf'				, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[4].."2"	, STAND, 'AVW_dance04.kf'				, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[5].."2"	, STAND, 'AVW_여위협.kf'				, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[6].."2"	, STAND, 'AVW_따귀때리기여자.kf'		, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[7].."2"	, STAND, 'AVW_여자울기.kf'				, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[8].."2"	, STAND, 'AVW_여자누워있기.kf'			, 0, 100)		-- 마지막 0은 무한의미
AddSocial(STAND, "\/"..VGD_String_Action[9].."2"	, STAND, 'AVW_힙합포옹.kf'				, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[10].."2"	, STAND, 'AVW_여자사랑의총.kf'			, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[11].."2"	, STAND, 'AVW_여자웃기.kf'				, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[12].."2"	, STAND, 'AVW_여복부때리기.kf'			, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[13].."2"	, STAND, 'AVW_여긍정.kf'				, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[14].."2"	, STAND, 'AVW_따귀맞기여자.kf'			, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[15].."2"	, STAND, 'AVW_여부정.kf'				, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[16].."2"	, STAND, 'AVW_말하기왜.kf'				, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[17].."2"	, STAND, 'AVW_발풀기.kf'				, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[18].."2"	, STAND, 'AVW_여자사랑의총_연속네번.kf'	, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[19].."2"	, STAND, 'AVW_여복부맞기.kf'			, 0, 100)
AddSocial(STAND, "\/"..VGD_String_Action[20].."2"	, STAND, 'AVW_dance05.kf'				, 0, 100)
AddSocial(STAND, '\/응2'							, STAND, 'AVW_여긍정.kf'				, 0, 100)
AddSocial(STAND, '\/ㅇㅇ2'							, STAND, 'AVW_여긍정.kf'				, 0, 100)
AddSocial(STAND, '\/아니2'							, STAND, 'AVW_여부정.kf'				, 0, 100)


-- 존에 들어 갔을때 연결돼는 룸번호
-- 1000
g_Zone1_RoomNumber = 1000;
-- 1001 위쪽 랭킹쪽에 있음
g_Zone2_RoomNumber = 1001;
-- 1002 건널목 왼쪽
g_Zone3_RoomNumber = 1002;
-- 1003 건널목 오른쪽
g_Zone4_RoomNumber = 1003;


-- 도우미 설명 부분

tHelperString = {['protecterr'] = 0,}
tHelperString[1] = PreCreateString_1387	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_7)--'[그랑/경험치]대전과 아케이드에서\n그랑과 경험치를 획득할 수 있습니다.'-- 7
tHelperString[2] = PreCreateString_1399	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_19)--'[대전]우측 하단 대전가기를\n클릭하면 대전을 할 수 있습니다.'--19
tHelperString[3] = PreCreateString_1385	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_5)--'[코인]코인은 아케이드를\n통해 획득 할 수 있습니다.'--5
tHelperString[4] = PreCreateString_1391	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_11)--'[광장]광장에서 M키를 누르면\n전체맵이 활성화 됩니다.'--11
tHelperString[5] = PreCreateString_1397	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_17)--'[전직]레벨10이 되면 광장의\n랜디하트를 통해 전직을 합니다.'--17
tHelperString[6] = PreCreateString_1713	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_59)--'[가이드]광장 중앙에 있는\n유키에게 가보시면 많은 이야기를\n들을 수 있습니다.'--59
tHelperString[7] = PreCreateString_1398	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_18)--'[챌린지미션]광장에 스피커맨을\n찾아가면 챌린지 미션에 대한\n설명을 들으실 수 있습니다.'--18
tHelperString[8] = PreCreateString_1388	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_8)--'[챌린지미션]챕터를 모두 완료하면\n다음 챕터로 넘어갑니다.'--8
tHelperString[9] = PreCreateString_1389	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_9)--'[챌린지미션]승리/패배 관련\n챌린지 미션은 대전에서\n진행할 수 있습니다.'--9
tHelperString[10] = PreCreateString_1390	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_10)--'[챌린지미션]챌린지 미션은\n아케이드와 대전에서 도전하여\n완료할 수 있습니다.'--10
tHelperString[11] = PreCreateString_1400	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_20)--'[아케이드]아케이드를 통해\n코인 및 체험스킬을\n획득하실 수 있습니다.'--20
tHelperString[12] = PreCreateString_1401	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_21)--'[아케이드]아케이드를 중간에\n포기하면 진행한 챌린지 미션들이\n누적되지 않습니다.'--21
tHelperString[13] = PreCreateString_1386	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_6)--'[아이템]아이템을 구입하려면\n광장 분수대에 유키를 찾아가세요.'--6
tHelperString[14] = PreCreateString_1394	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_14)--'[아이템]칭호, 캐릭터 변신을\n획득하면 우측 상단 선물함에서\n확인이 가능합니다.'--14
tHelperString[15] = PreCreateString_1396	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_16)--'[아이템]아이템, 코스튬, 스킬은\n마우스 더블 클릭으로\n장착이 가능합니다.'--16
tHelperString[16] = PreCreateString_1393	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_13)--'[선물함]우측 상단에 선물함을\n클릭한 후 아이템을 더블클릭하면\n선물을 받을 수 있습니다.'--13
tHelperString[17] = PreCreateString_1395	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_15)--'[체험스킬]체험스킬을 선물함에서\n받으면 우측 하단 내 스킬에서\n확인이 가능합니다.'--15
tHelperString[18] = PreCreateString_1392	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_12)--'[채팅매크로]우측 상단에 옵션을\n클릭한 후 게임 탭에서\n매크로를 확인할 수 있습니다.'--12


-- 챌린지 미션 엔피씨 대화(0)
--'정말 좋은 날씨에 연속이군요~\n이래서 6구역을 좋아한다니까 하하하'
tChallengeMissionString = {['err'] = 0, }
tChallengeMissionString[1] = PreCreateString_1402	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_22)

-- 코인교환 엔피씨 대화(1)
--'안녕하세요!\n제6구역에서 아이템을 판매하고 있는 유키라고 해요.\n아이템에 관련해서 궁금한 점이 있으면 언제든 물어보세요.'
tWelcomeMentString = {['err'] = 0, PreCreateString_1403} --GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_23)

--길드 엔피씨 대화(2)
--"오 멋진 격투가께서 찾아오셨네요.\n파이트 클럽들의 사무적인 일을 담당하는 샤론이라고 해요.\n세인트협회의 내부사정으로 인해 파이트 클럽 등록이 아직 불가능해요."
tGuildNpcString = {['err'] = 0, PreCreateString_1404}	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_24) 

-- 파티매칭1 NPC 대화
-- 어머~ 안녕하세요!\n파티 매칭 서포터 안젤라 맘슨이에요.\n저를 어디서 보신 것 같으시다구요??\n후후..맞아요. 저는 쌍둥이 언니입니다.\n아마도 제 동생을 보신 것 같네요. 동생은 6구역 광장 남쪽에 있어요.
tParty1Ment = {['err'] = 0, PreCreateString_1891}	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_79) 

-- 파티매칭2 NPC 대화
-- 어머~ 안녕하세요!\n파티 매칭 서포터 엠마 맘슨이에요.\n저를 어디서 보신 것 같으시다구요??\n후후..맞아요. 저는 쌍둥이 동생입니다.\n아마도 제 언니를 보신 것 같네요. 언니는 6구역 광장 북쪽에 있어요.
tParty2Ment = {['err'] = 0, PreCreateString_1892}	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_80)

--전직엔피씨 멘트(3)
tChangeJobString = {['err'] = 0,}
tChangeJobString[1] = PreCreateString_1405	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_25)--"어서오시게!\n보아하니 아직 격투가로서는 부족한거 같군.\n레벨 10이 되면 나를 찾아오게 진정한 격투란 무엇인가를 알려주겠네!"
tChangeJobString[2] = PreCreateString_1406	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_26)--"오! 이제 진정한 격투가의 길을 배울 자세가 된거 같군.\n어떤 무술을 사용하는 격투가가 되고 싶은지 선택해보게.\n이 랜디하트님이 직접 무술을 가르쳐 주겠네!"
tChangeJobString[3] = PreCreateString_1407	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_27)--"왔는가! 격투가여!\n레벨 20이 되서 나에게 오면 또 다른 격투의 세계를 느낄 수 있게 해주겠네!\n정말 기대가 크네!"

-- 조합 엔피씨 처음대화
tCostumeCraftingString = {['err'] = 0, PreCreateString_2361}	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_91)


-- Npc스토리 텔링
tNpcStoryTelling	 = { ["err"]=0, [0]={["err"]=0, }, {["err"]=0, }, {["err"]=0, }, {["err"]=0, }, {["err"]=0, }, {["err"]=0, }, {["err"]=0, }, {["err"]=0, }}
tNpcStoryTellingName = { ["err"]=0, [0]={["err"]=0, }, {["err"]=0, }, {["err"]=0, }, {["err"]=0, }, {["err"]=0, }, {["err"]=0, }, {["err"]=0, }, {["err"]=0, }}

-- 챌린지 미션 NPC
tNpcStoryTelling[0]["size"] = 3
tNpcStoryTelling[0][1] = PreCreateString_1408	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_28)--"챌린지 미션은 세인트 협회에서 여러분의 수련을 돕기 위해 마련된 프로그램이에요.\n여러분이 대전을 하거나 아케이드에서 바이엑스 일당을 물리치는 모든 과정을 기록하여\n일정 수준을 넘어서는 경지에 도달하면 선물을 드리고 있답니다.\n챌린지 미션은 자동으로 진행되며 선물도 바로바로 지급된답니다."
tNpcStoryTelling[0][2] = PreCreateString_1409	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_29)--"바이엑스에 대항하여 만들어진 단체에요.\n오스틴 Jr 사장과 Mr.블러드는 반칙과 편파판정으로 우리를 붕괴했죠.\n하지만 우리 세인트 협회는 다시 부활하고 있어요.\n언젠가는 악행을 일삼는 바이엑스를 반드시 처단할 거에요."
tNpcStoryTelling[0][3] = PreCreateString_1410	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_30)--"저..저의 정체가 궁금하시다구요?\n전 단지 여러분을 도와드리고 있을 뿐이에요.\n사정이 있어서 얼굴을 숨기고 있어요.\n아마도.. 언젠가는 저에 대해 알 수 있는 날이 언젠가는 있겠죠.."

-- 챌린지 미션 대화 버튼 이름
tNpcStoryTellingName[0][1] = PreCreateString_1723	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_62)--"챌린지미션이란?"
tNpcStoryTellingName[0][2] = PreCreateString_1724	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_63)--"세인트협회란?"
tNpcStoryTellingName[0][3] = PreCreateString_1725	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_64)--"스피커맨의 정체"


-- 파티매칭1 NPC
tNpcStoryTelling[1]["size"] = 4
tNpcStoryTelling[1][1] = PreCreateString_1897	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_85)--파티는 마음이 통하는 사람들끼리 모이는 공간이에요.\n"백짓장도 맞들면 낫다"라는 말이 있듯이 서로 힘을 모으면\n어려운 것을 쉽게 해결 할 수 있어요.\n어서 빨리 파티를 해서 힘을 모아 바이엑스를 이겨주세요.\n파티에 관련된 기능은 제 옆의 팝업창에서 하실 수 있어요.
tNpcStoryTelling[1][2] = PreCreateString_1898	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_86)--지금도 어디선가 바이엑스 일당들이 세인트 협회를 노리고 있어요.\n바이엑스 악당들을 물리쳐서 세인트 협회를 지키고 제4구역을 탈환해주세요.\n아케이드에서는 여러분의 스킬을 강화 할 수 있는 스킬 강화권을 획득 할 수 있어요.\n아케이드 종류에 따라 입장권이 필요한 것을 잊지 마세요.\n입장권은 대전을 플레이하면 랜덤하게 나와요.
tNpcStoryTelling[1][3] = PreCreateString_1899	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_87)--가슴 안에서 잠자고 있던 격투 본능을 느끼보세요.\n혼자서 하는 대전은 외로우니까, 파티를 해서 가보세요.\n대전에서는 아케이드 입장권이 나오니 빨리 가서 입장권을 획득해보세요.
tNpcStoryTelling[1][4] = PreCreateString_1900	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_88)--준비중 파티는 파티를 재정비하는 파티입니다.\n파티의 기본 설정은 항상 준비중으로 되어 있으니, 원하는 파티를 가실 때에는\n파티의 구분을 바꿔주세요.


-- 파티매칭1 대화버튼 이름
tNpcStoryTellingName[1][1] = PreCreateString_1893	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_81)--파티란?
tNpcStoryTellingName[1][2] = PreCreateString_1894	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_82)--아케이드 파티
tNpcStoryTellingName[1][3] = PreCreateString_1895	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_83)--대전 파티
tNpcStoryTellingName[1][4] = PreCreateString_1896	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_84)--준비중 파티


-- 파티매칭2 NPC(파티1과 같음)
tNpcStoryTelling[2]["size"] = 4
tNpcStoryTelling[2][1] = PreCreateString_1897	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_85)--파티는 마음이 통하는 사람들끼리 모이는 공간이에요.\n"백짓장도 맞들면 낫다"라는 말이 있듯이 서로 힘을 모으면\n어려운 것을 쉽게 해결 할 수 있어요.\n어서 빨리 파티를 해서 힘을 모아 바이엑스를 이겨주세요.\n파티에 관련된 기능은 제 옆의 팝업창에서 하실 수 있어요.
tNpcStoryTelling[2][2] = PreCreateString_1898	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_86)--지금도 어디선가 바이엑스 일당들이 세인트 협회를 노리고 있어요.\n바이엑스 악당들을 물리쳐서 세인트 협회를 지키고 제4구역을 탈환해주세요.\n아케이드에서는 여러분의 스킬을 강화 할 수 있는 스킬 강화권을 획득 할 수 있어요.\n아케이드 종류에 따라 입장권이 필요한 것을 잊지 마세요.\n입장권은 대전을 플레이하면 랜덤하게 나와요.
tNpcStoryTelling[2][3] = PreCreateString_1899	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_87)--가슴 안에서 잠자고 있던 격투 본능을 느끼보세요.\n혼자서 하는 대전은 외로우니까, 파티를 해서 가보세요.\n대전에서는 아케이드 입장권이 나오니 빨리 가서 입장권을 획득해보세요.
tNpcStoryTelling[2][4] = PreCreateString_1900	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_88)--준비중 파티는 파티를 재정비하는 파티입니다.\n파티의 기본 설정은 항상 준비중으로 되어 있으니, 원하는 파티를 가실 때에는\n파티의 구분을 바꿔주세요.


-- 파티매칭2 대화버튼 이름(파티1과 같음)
tNpcStoryTellingName[2][1] = PreCreateString_1893	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_81)--파티란?
tNpcStoryTellingName[2][2] = PreCreateString_1894	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_82)--아케이드 파티
tNpcStoryTellingName[2][3] = PreCreateString_1895	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_83)--대전 파티
tNpcStoryTellingName[2][4] = PreCreateString_1896	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_84)--준비중 파티


-- 길드 NPC
tNpcStoryTelling[3]["size"]	= 3
tNpcStoryTelling[3][1] = PreCreateString_1416	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_36)--"마음에 맞는 격투가들이 모여서 만든 모임을 파이트 클럽이라고 해요.\n중세시대에는 길드라고도 불렸던 것이죠.\n파이트 클럽 간의 경쟁을 바탕으로 세인트 협회는 성장하고 있어요.\n당신도 파이트 클럽에 소속되시면 실력이 좋아지는 것을 느낄 수 있을거에요."
tNpcStoryTelling[3][2] = PreCreateString_1417	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_37)--"새로운 파이트 클럽을 등록하시겠다구요?\n레벨 10이 되고 난 후 서류작업을 하세요.\n세인트협회 발전 기금 1만 그랑을 지불하시면 클럽을 등록할 수 있어요.\n현재 세인트 협회의 클럽 관련 부서가 설치되지 않아 등록이 불가능해요."
tNpcStoryTelling[3][3] = PreCreateString_1418	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_38)--"클럽 등록 후 클럽 이름, 클럽 마크, 클럽 칭호는 변경하려면\n캐시가 소모되니 주의하세요.\n클럽 URL은 등록 후 변경이 불가능합니다."

-- 길드 대화 버튼 이름
tNpcStoryTellingName[3][1] = PreCreateString_1729	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_68)--"파이트 클럽"
tNpcStoryTellingName[3][2] = PreCreateString_1730	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_69)--"파이트 클럽 등록"
tNpcStoryTellingName[3][3] = PreCreateString_1731	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_70)--"등록시 주의점"


-- 전직 NPC--------------------------------------------------
tNpcStoryTelling[4]["size"]	= 2
tNpcStoryTelling[4][1] = PreCreateString_1714	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_60)--"클래스는 자신의 고유 무술을 얘기하는 것이라네.\n우선 처음 시작은 스트리트(타격계열)와 러쉬(잡기계열)로 시작한다네.\n나중에는 전문 격투가로서 새로운 무술을 배울 수 있지."
tNpcStoryTelling[4][2] = PreCreateString_1716	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_61)--"전직은 스트리트(타격계열)과 러쉬(잡기계열)에서\n멋진 무술들을 배울 수 있는 자격을 심사하는 것이라네.\n레벨 10에 전직이 가능하며 스트리트는 태권도, 복싱, 무에타이로\n러쉬는 프로레슬링, 유도, 합기도로 전직이 가능하지.\n아직 밣혀지지 않은 숨겨진 무술들이 나중에 나올 수도 있다네."


-- 전직 대화버튼 이름
tNpcStoryTellingName[4][1] = PreCreateString_1733	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_71)--"클래스란"
tNpcStoryTellingName[4][2] = PreCreateString_1734	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_72)--"전직이란"


-- 코인교환 NPC
tNpcStoryTelling[5]["size"] = 5
tNpcStoryTelling[5][1] = PreCreateString_1411	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_31)--"[그랑]은 아이템이나 코스튬, 스킬을 구입할 때 주로 사용되죠.\n대전을 하거나 아케이드에서 바이엑스 일당을 해치우면 그랑을 획득할 수 있어요.\n\n[코인]은 코인 선물상자를 구입할 때 사용해요.\n아케이드에서 바이엑스 일당을 해치우면 코인을 획득할 수 있어요."
tNpcStoryTelling[5][2] = PreCreateString_1412	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_32)--"가슴 안에서 잠자고 있던 격투 본능을 느껴보세요.\n대전을 하면 할수록 진정한 격투가로 성장하고 있는 자신을 확인할 수 있을 거에요.\n대전을 하면 많은 그랑과 경험치가 지급되고 있어요."
tNpcStoryTelling[5][3] = PreCreateString_1413	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_33)--"지금도 어디선가 바이엑스 일당들이 세인트협회를 노리고 있어요.\n바이엑스 악당들을 물리쳐서 세인트협회를 지키고 제4구역을 탈환하도록 해요!\n아케이드에서 바이엑스를 물리치면 코인과 체험스킬을 획득할 수 있어요.\n아케이드 위치는 광장에서 M키를 눌러서 확인하세요."
tNpcStoryTelling[5][4] = PreCreateString_1414	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_34)--"선물 상자에서는 다양한 아이템이 나와요.\n코인 선물상자는 그랑과 변신 아이템이 나오고 있어요.\n그랑 선물상자에서는 코인과 아케이드 라이프가 나오고 있어요."
tNpcStoryTelling[5][5] = PreCreateString_1415	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_35)--"실패를 성공으로!\n아케이드에서 KO를 당했을 때 사용하면 한번 더 기회를 얻을 수 있어요.\n징글징글한 바이엑스들에게 복수하고 싶다면 항상 가지고 있어야 할 아이템이죠."

-- 코인교환 대화버튼 이름
tNpcStoryTellingName[5][1] = PreCreateString_1726	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_65)--"그랑과 코인"
tNpcStoryTellingName[5][2] = PreCreateString_1060	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_DESIGNER_3)--"대 전"
tNpcStoryTellingName[5][3] = PreCreateString_1061	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_DESIGNER_4)--"아케이드"
tNpcStoryTellingName[5][4] = PreCreateString_1727	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_66)--"선물상자란?"
tNpcStoryTellingName[5][5] = PreCreateString_1728	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_67)--"라이프란?"

-- 점령전 NPC (임시로)
tNpcStoryTelling[6]["size"]	= 3
tNpcStoryTelling[6][1] = PreCreateString_1416	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_36)--"마음에 맞는 격투가들이 모여서 만든 모임을 파이트 클럽이라고 해요.\n중세시대에는 길드라고도 불렸던 것이죠.\n파이트 클럽 간의 경쟁을 바탕으로 세인트 협회는 성장하고 있어요.\n당신도 파이트 클럽에 소속되시면 실력이 좋아지는 것을 느낄 수 있을거에요."
tNpcStoryTelling[6][2] = PreCreateString_1417	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_37)--"새로운 파이트 클럽을 등록하시겠다구요?\n레벨 10이 되고 난 후 서류작업을 하세요.\n세인트협회 발전 기금 1만 그랑을 지불하시면 클럽을 등록할 수 있어요.\n현재 세인트 협회의 클럽 관련 부서가 설치되지 않아 등록이 불가능해요."
tNpcStoryTelling[6][3] = PreCreateString_1418	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_38)--"클럽 등록 후 클럽 이름, 클럽 마크, 클럽 칭호는 변경하려면\n캐시가 소모되니 주의하세요.\n클럽 URL은 등록 후 변경이 불가능합니다."

-- 점령전 NPC 버튼 이름(임시로)
tNpcStoryTellingName[6][1] = PreCreateString_1729	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_68)--"파이트 클럽"
tNpcStoryTellingName[6][2] = PreCreateString_1730	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_69)--"파이트 클럽 등록"
tNpcStoryTellingName[6][3] = PreCreateString_1731	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_70)--"등록시 주의점"


-- 코스튬 조합 엔피씨
tNpcStoryTelling[7]["size"] = 4
tNpcStoryTelling[7][1] = PreCreateString_2362	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_92)--"코스튬 조합이란..음.. 간단하게 설명하자면..\n2개의 평범한 코스튬을 조합하여 1개의 레전드 코스튬을 갖기 위한 수단입니다!!\n참 간단하죠??후후.. "
tNpcStoryTelling[7][2] = PreCreateString_2363	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_93)--"코스튬을 조합하기 위해서는 2개의 코스튬과 1개의 코스튬 큐브라는 재료가 필요합니다.\n코스튬 큐브는 상인NPC 유키를 통해서 구매 하실 수 있습니다."
tNpcStoryTelling[7][3] = PreCreateString_2364	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_94)--"코스튬을 조합하는 방법은 아주 간단합니다.\n첫 번째, 조합 할 코스튬 2개와 코스튬 큐브 1개를 등록 버튼을 눌러서 등록해주세요.\n두 번째, 조합 버튼을 눌러서 코스튬을 조합합니다.\n마지막으로 코스튬 조합 결과를 확인하면 됩니다. 간단하죠?\n주의해야 할 점으로...\n코스튬 조합에 실패하면 1개의 코스튬이 파괴됩니다.\n코스튬 조합은 실패 확률이 높으니 신중하게 고민하셔야 합니다. "
tNpcStoryTelling[7][4] = PreCreateString_2365	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_95)--"코스튬 조합에 성공하게 되면 레전드 등급의 코스튬을 획득하게 됩니다.\n레전드 등급의 코스튬은 정말 최고의 성능을 자랑합니다!!\n모든 세인트 협회 소속 파이터분들이 레전드 코스튬을 갖게 되면 좋겠네요.\n저희 세인트 협회 연구소가 개발한 정말 후회 없는 최고의 코스튬입니다. "


-- 코스튬 조합 엔피씨 대화버튼 이름
tNpcStoryTellingName[7][1] = PreCreateString_2366	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_96)--"코스튬 조합이란?"
tNpcStoryTellingName[7][2] = PreCreateString_2367	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_97)--"코스튬 큐브란?"
tNpcStoryTellingName[7][3] = PreCreateString_2368	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_98)--"조합 방법"
tNpcStoryTellingName[7][4] = PreCreateString_2369	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_99)--"레전드 코스튬"




-- 광장 최초입장 스피커맨 멘트
tFirstEnterText = {['protecterr'] = 0, }
tFirstEnterText[1] = PreCreateString_1419	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_39)--"어이 애송이! 제4구역으로 가려는 모양이야?\n그곳은 4년전 바이엑스 일당이 세인트를 몰아내고\n지금은 무법천지가 된 아주 무서운 곳이라구...\n먼저 여기 제6구역에서 너의 이름을 알리는게 좋을껄?"
tFirstEnterText[2] = PreCreateString_1420	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_40)--'여기 제6구역에서는 흩어진 세인트 회원들을 만날 수도 있을거야\n그럼 어떤 실력가들이 있는지 먼저 "대전하러 가기"로 가보는게 좋겠다.\n내 예상에는 여기 제6구역도 만만하지는 않을껄?'



-- 전직 NPC의 전직 직업에 대한 다른 설명이 들어간다.
tChangeJobMissionString = {['protecterr'] = 0, }
--"원하는 클래스를 선택하세요."
tChangeJobMissionString[1] = PreCreateString_1047	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_30)--"태권도"
tChangeJobMissionString[2] = PreCreateString_1048	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_31)--"복싱"
tChangeJobMissionString[3] = PreCreateString_1050	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_33)--"무에타이"
tChangeJobMissionString[4] = PreCreateString_1049	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_32)--"카포에라"
tChangeJobMissionString[5] = PreCreateString_1053	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_36)--"프로레슬링"
tChangeJobMissionString[6] = PreCreateString_1052	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_35)--"유도"
tChangeJobMissionString[7] = PreCreateString_1054	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_37)--"합기도"
tChangeJobMissionString[8] = PreCreateString_1055	--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_38)--"삼보"
tChangeJobMissionString[9] = "스모"

-- 전직하는 직업에따라 달라지는 멘트
tChangeJobMissionMentString = {['protecterr'] = 0, {["protecterr"]=0, }, {["protecterr"]=0, }}

-- 태권도
tChangeJobMissionMentString[1][1] = PreCreateString_1735	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_73)--"호! 태권도를 선택했군~ 하핫!\n연마만 잘하면 공중 콤보의 최강자가 될 수 있다는 태권도...\n열심히 연마하시게!"	
-- 복싱
tChangeJobMissionMentString[1][2] = PreCreateString_1736	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_74)--"호! 복싱을 선택했군~ 치칫! 슈슉!\n모든 클래스 중 주먹이 가장 빠르지 하하! 그 주먹에 정통으로 맞으면...\n으흐 상상도 하기 싫다네~"
-- 카포에라
tChangeJobMissionMentString[1][3] = PreCreateString_2052	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_89)--"호! 카포에라를 선택했군~ 하핫!\n춤을 추는 듯한 현란한 공격동작과 범위공격이 특징이지...\n열심히 수련하여 카포에라 마스터가 되게나!"
-- 무에타이
tChangeJobMissionMentString[1][4] = PreCreateString_1737	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_75)--"호! 무에타이를 선택했군~ 열라뽕따이!\n정말 시원시원하고 강력한 무술이지 암 그렇고 말고...\n열심히 해보게나!"
-- 유도
tChangeJobMissionMentString[2][1] = PreCreateString_1738	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_76)--"오! 유도를 선택한건가~ 하핫!\n유도는 그라운드 잡기 기술들이 굉장히 매력적이지!\n아 물론 다른 기술들도 매력적이라네~"
-- 프로레슬링
tChangeJobMissionMentString[2][2] = PreCreateString_1739	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_77)--"오! 레슬링을 선택한건가~ 흐흐!\n레슬링을 배운자 잡기의 최강자에 군림한다는 전설이 있다는데...\n사실인지는 나도 모른다네!"
-- 합기도
tChangeJobMissionMentString[2][3] = PreCreateString_1740	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_78)--"오! 합기도를 선택한건가~ 하핫!\n잡기 클래스 중 타격 기술이 가장 강력하다고 알려져 있지 ...\n직접 해보면 알게 될 거라네!"
-- 삼보
tChangeJobMissionMentString[2][4] = PreCreateString_2053	--GetSStringInfo(LAN_LUA_WND_VILLAGE_DESIGNER_90)--"오! 삼보를 선택했군~ 하핫!\n역동적인 잡기 기술들이 특징이지! 콤보로 연결되는 다이빙 잡기 기술에\n당하면 ...생각만해도 끔직하군!"
-- 스모
tChangeJobMissionMentString[1][5] = "오! 스모를 선택했군~ 하핫!\n 짱이삼"

------------------------------------------
-- 디그아이템 븉는 위치
------------------------------------------
-- 드릴
local tDrillAniPos_BM = {['err'] = 0, 32, -10, -107, 0, -70, 6}
local tDrillAniPos_MM = {['err'] = 0, 26, -10, -105, 0, -70, 6}
local tDrillAniPos_SM = {['err'] = 0, 21,  -8, -105, 0, -65, 6}
local tDrillAniPos_BW = {['err'] = 0, 24, -10, -109, 0, -70, 6}
local tDrillAniPos_MW = {['err'] = 0, 25, -10, -105, 0, -58, 6}
local tDrillAniPos_SW = {['err'] = 0, 24,  -8, -105, 0, -53, 6}
local tDrillAniPostable = {['err'] = 0, [0]=tDrillAniPos_BM, tDrillAniPos_MM, tDrillAniPos_SM, tDrillAniPos_BW, tDrillAniPos_MW, tDrillAniPos_SW} 

-- 곡괭이
local tAxeAniPos_BM = {['err'] = 0, -5, 13, 0, 0, -224, 5}--12, 8, -40, -195, 3}
local tAxeAniPos_MM = {['err'] = 0, -5, 10, 0, 0, -218, 5}
local tAxeAniPos_SM = {['err'] = 0, -5, 10, 0, 0, -210, 4}	--
local tAxeAniPos_BW = {['err'] = 0, -5, 10, 0, -15, -204, 4}
local tAxeAniPos_MW = {['err'] = 0, -5, 8, 0, -16, -202, 4}
local tAxeAniPos_SW = {['err'] = 0, -5, 10, 0, -20, -195, 4}
local tAxeAniPostable = {['err'] = 0, [0]=tAxeAniPos_BM, tAxeAniPos_MM, tAxeAniPos_SM, tAxeAniPos_BW, tAxeAniPos_MW, tAxeAniPos_SW} 


-- 슈퍼드릴
local tSuperDrillAniPos_BM	 = {['err'] = 0, 18, -10, -120, 0, -70, 6}
local tSuperDrillAniPos_MM	 = {['err'] = 0, 10, -10, -120, 0, -70, 6}
local tSuperDrillAniPos_SM	 = {['err'] = 0, 8,  -10, -120, 0, -65, 6}
local tSuperDrillAniPos_BW	 = {['err'] = 0, 15, -10, -120, 0, -70, 6}
local tSuperDrillAniPos_MW	 = {['err'] = 0, 10, -10, -120, 0, -70, 6}
local tSuperDrillAniPos_SW	 = {['err'] = 0, 10,  -10, -120, 0, -70, 6}
local tSuperDrillAniPostable = {['err'] = 0, [0]=tSuperDrillAniPos_BM, tSuperDrillAniPos_MM, tSuperDrillAniPos_SM, tSuperDrillAniPos_BW, tSuperDrillAniPos_MW, tSuperDrillAniPos_SW} 

-- 묶음
DigAniTable = {['err'] = 0, [0]=tAxeAniPostable, tDrillAniPostable, tDrillAniPostable, tDrillAniPostable , tSuperDrillAniPostable, tSuperDrillAniPostable, tSuperDrillAniPostable, tSuperDrillAniPostable }





-- 나라별로 분리
-- 광장 상점 카테고리이름 인덱스
local tEngName = {[0] =	0, 1, 1, 1, 1, 1} 
local tKorName = {[0] = 0, 1, 1, 1, 1, 1} 
local tThaiName = {[0]= 0, 1, 1, 1, 1, 1} 

tStoreCategoryName = {[0]= tEngName, tKorName, tThaiName } -- 0
	
------
	




end




