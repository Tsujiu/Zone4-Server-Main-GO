function WndVillage_WndVillage()
	-----------------------------------------
	-- Script Entry Point
	-----------------------------------------
	local guiSystem	= CEGUI.System:getSingleton();
	local winMgr	= CEGUI.WindowManager:getSingleton();
	local root		= winMgr:getWindow("DefaultWindow");
	local GUITool =  require("GUITools")
	guiSystem:setGUISheet(root)
	root:activate()
	
	local isHideMatchMakingButton = false
	
	SPK_NONE			= 0;
	SPK_FIRSTLOGIN		= 1;
	SPK_PRACTICE_MOVE	= 2;
	SPK_MAP				= 3;
	SPK_FIGHTGO			= 4;
	
	g_SpkState	=	SPK_NONE;
	
	
	-- �����? �޼��� ����
	local HelpMessage			= ""
	local HelpMessageindex		= 0
	
	
	-- �����̵� ������ ��ġ ����
	local g_ArcadeLife			= 1;
	local g_ChangeGran			= 0; 
	
	local g_SelectCoinPrice		= 0
	local g_SelectCoinName		= string;
	local g_SelectDescription	= string;
	local g_SelectFileName		= string;
	local g_SelectKind			= nil;
	local g_SelectedItem		= 0;
	
	local g_EnterZone = 0;
	g_CurrentCameraMagState = false
	local BPM_String_PartyBan2 = PreCreateString_1017	--GetSStringInfo(LAN_LUA_BTNPAGEMOVE_2)
	
	local g_MsgCount = 0;
	
	local ZONETYPEBASE = 10;
	local ZONETYPECHINA = 20;
	
	local b_pushCtrl = 0
	local ZoneTypeNameTable = {PreCreateString_2918, PreCreateString_2919}	-- ���� Ÿ�Կ� ���� �̸�
	
	function CheckPushCtrl(CheckCtrl)
		DebugStr('CheckCtrl:'..CheckCtrl)
		b_pushCtrl = CheckCtrl
	end
	
	
	--winMgr:getWindow('pu_btn(Channel)_effect'):activeMotion('ChannelEffect')
	
	----------------------------------------------------------------------------------
	
	-- �����? �������̽� �̹���
	
	----------------------------------------------------------------------------------
	myhelpwindow = winMgr:createWindow("TaharezLook/StaticImage", "hh_Helper_Interface")
	myhelpwindow:setTexture("Enabled", "UIData/messenger.tga", 0, 315)
	myhelpwindow:setTexture("Disabled", "UIData/messenger.tga", 0, 315)
	myhelpwindow:setProperty("FrameEnabled", "False")
	myhelpwindow:setProperty("BackgroundEnabled", "False")
	myhelpwindow:setPosition(782, 220)
	myhelpwindow:setSize(233, 96)
	myhelpwindow:setVisible(false)
	myhelpwindow:setAlwaysOnTop(true)
	myhelpwindow:setZOrderingEnabled(false)
	root:addChildWindow(myhelpwindow)
	
	function CheckHelpInterface()
	--	if winMgr:getWindow('hh_Helper_Interface') then
	--		local Helpinter = winMgr:getWindow('hh_Helper_Interface'):isVisible()
	--		if Helpinter then
	--			HelpStart(Helpinter);
	--		end
	--	end
	end
	
	--------------------------------------------------------------------
	-- Ÿ��Ʋ��(����̸�? ���콺�� �����̰� �ϱ�)
	--------------------------------------------------------------------
	myhelptitlebarwindow = winMgr:createWindow("TaharezLook/Titlebar", "hh_Helper_Titlebar")
	myhelptitlebarwindow:setPosition(44, 1)
	myhelptitlebarwindow:setSize(160, 20)
	myhelpwindow:addChildWindow(myhelptitlebarwindow)
	
	
	----------------------------------------------------------------------------------
	-- �����? ��, �� ��ư
	----------------------------------------------------------------------------------
	myhelpleftwindow = winMgr:createWindow("TaharezLook/Button", "hh_Helper_Left")
	myhelpleftwindow:setTexture("Normal", "UIData/myinfo2.tga", 634, 0)
	myhelpleftwindow:setTexture("Hover", "UIData/myinfo2.tga",  634, 13)
	myhelpleftwindow:setTexture("Pushed", "UIData/myinfo2.tga",  634, 26)
	myhelpleftwindow:setTexture("PushedOff", "UIData/myinfo2.tga", 634, 0)
	myhelpleftwindow:setPosition(190, 74)
	myhelpleftwindow:setSize(9, 13)
	myhelpleftwindow:subscribeEvent("Clicked", "WndVillage_HelpLeftClicked")
	myhelpwindow:addChildWindow(myhelpleftwindow)
	
	function WndVillage_HelpLeftClicked()
		Helpbotton(true);
		local ment_window = winMgr:getWindow('hh_Helper_Ment')
		ment_window:clearTextExtends()
		CEGUI.toGUISheet(ment_window):setTextViewDelayTime(11)
		
		local helpMent = "";
		
		HelpMessageindex = HelpMessageindex - 1;
		
		if HelpMessageindex < 2 then
			HelpMessageindex = 1;
			helpMent = tHelperString[HelpMessageindex]
			HelpMessageindex = 18;
		else
			helpMent = tHelperString[HelpMessageindex]
		end
		
		ment_window:addTextExtends(helpMent, g_STRING_FONT_GULIMCHE, 12, 255,255,0,255,    0, 0,0,0,255);
	end
	
	
	myhelprightwindow = winMgr:createWindow("TaharezLook/Button", "hh_Helper_Right")
	myhelprightwindow:setTexture("Normal", "UIData/myinfo2.tga", 625, 0)
	myhelprightwindow:setTexture("Hover", "UIData/myinfo2.tga",  625, 13)
	myhelprightwindow:setTexture("Pushed", "UIData/myinfo2.tga",  625, 26)
	myhelprightwindow:setTexture("PushedOff", "UIData/myinfo2.tga", 625, 0)
	myhelprightwindow:setPosition(210, 74)
	myhelprightwindow:setSize(9, 13)
	myhelprightwindow:subscribeEvent("Clicked", "WndVillage_HelpRightClicked")
	myhelpwindow:addChildWindow(myhelprightwindow)
	
	function WndVillage_HelpRightClicked()
		Helpbotton(true);
		local ment_window = winMgr:getWindow('hh_Helper_Ment')
		ment_window:clearTextExtends()
		CEGUI.toGUISheet(ment_window):setTextViewDelayTime(11)
	
		local helpMent = "";
		
		HelpMessageindex = HelpMessageindex + 1;
		
		if HelpMessageindex > 16 then
			HelpMessageindex = 17;
			helpMent = tHelperString[HelpMessageindex]
			HelpMessageindex = 0;
		else
			helpMent = tHelperString[HelpMessageindex]
		end
		
		ment_window:addTextExtends(helpMent, g_STRING_FONT_GULIMCHE,  12, 255,255,0,255,    0, 0,0,0,255);
	end
	
	
	----------------------------------------------------------------------------------
	-- �����? ���� ��ư
	----------------------------------------------------------------------------------
	myXButtonwindow = winMgr:createWindow("TaharezLook/Button", "hh_Helper_Cancel")
	myXButtonwindow:setTexture("Normal", "UIData/C_Button.tga", 488, 0)
	myXButtonwindow:setTexture("Hover", "UIData/C_Button.tga", 488, 22)
	myXButtonwindow:setTexture("Pushed", "UIData/C_Button.tga", 488, 44)
	myXButtonwindow:setTexture("PushedOff", "UIData/C_Button.tga", 488, 0)
	myXButtonwindow:setTexture("Disabled", "UIData/C_Button.tga", 488, 66)
	
	myXButtonwindow:setSize(20, 20)
	myXButtonwindow:setPosition(208, 2)
	myXButtonwindow:setVisible(true)
	myXButtonwindow:setZOrderingEnabled(false)
	myXButtonwindow:subscribeEvent("Clicked", "CloseHelpButton")
	myhelpwindow:addChildWindow(myXButtonwindow)
	
	function CloseHelpButton()
		winMgr:getWindow("hh_Helper_Interface"):setVisible(false);
	end
	
	function ShowHelp()
		winMgr:getWindow("hh_Helper_Interface"):setVisible(true);
	end
	
	-------------------------------------------------------------
	
	-- �����? ��Ʈ
	
	-------------------------------------------------------------
	Helpmentwindow = winMgr:createWindow("TaharezLook/StaticText", "hh_Helper_Ment");
	Helpmentwindow:setProperty("FrameEnabled", "false");
	Helpmentwindow:setProperty("BackgroundEnabled", "false");
	Helpmentwindow:setFont(g_STRING_FONT_DODUMCHE, 12);
	Helpmentwindow:setTextColor(255, 255, 255, 255);
	Helpmentwindow:setPosition(10, 55);
	Helpmentwindow:setSize(700, 16);
	Helpmentwindow:setAlign(0);
	Helpmentwindow:setViewTextMode(2);
	Helpmentwindow:setLineSpacing(6);
	Helpmentwindow:clearTextExtends()
	Helpmentwindow:setText('');
	Helpmentwindow:setVisible(true);
	winMgr:getWindow('hh_Helper_Interface'):addChildWindow(Helpmentwindow);
	
	-- �����? ��Ʈ
	function ShowHelpMent(MessageIndex)
		local ment_window = winMgr:getWindow('hh_Helper_Ment')	
		ment_window:setVisible(true);
		CEGUI.toGUISheet(ment_window):setTextViewDelayTime(11)
		ment_window:clearTextExtends();	
		ment_window:setPosition(9, 30);
		
		HelpMessageindex = MessageIndex;	
		HelpMessage = tHelperString[HelpMessageindex]
		ment_window:addTextExtends(HelpMessage,  g_STRING_FONT_GULIMCHE, 12, 255,255,0,255,    0, 0,0,0,255);
	end
	
	----------------------------------------------------------------------------------
	
	--	���� NPC ����
	
	----------------------------------------------------------------------------------
	-- NPC ����
	local g_IsDebug	 = true
	local g_NpcType  = 0
	local g_NpcIndex = 0
	local g_currentZoom = false
	
	local NPC_CHALLANGE_MISSION	= 0
	local NPC_PARTY1			= 1
	local NPC_PARTY2			= 2
	local NPC_CLUB				= 3
	local NPC_CHANGE_JOB		= 4
	local NPC_MERCHANT			= 5
	local NPC_CLUB2				= 6 -- ������ �ӽ�
	local NPC_COSTUME_CRAFTING	= 7 -- �ڽ�Ƭ ���� ���Ǿ�
	
	local NpcStoryTellingIndex	= 0
	local NPCBaseTelling		= ""
	
	-- ���� c�� ��ϵ�? npc�� Ÿ���� �����Ѵ�.
	local npcMaxNum  = GetMaxNPCNum()	-- NPC ��
	local tIsNearNPC = {["err"]=0,}		-- NPC�� ������ �� ���? 1
	local t_NPC_TYPE = {["err"]=0,}		-- NPC�� Ÿ���� ����
	for i=0, npcMaxNum-1 do
		t_NPC_TYPE[i] = GetNPCType(i)
		tIsNearNPC[i] = 0
	end
	
	
	----------------------------------------------------------------------------------
	-- ����, ���?, ç����, ���� SPACE �̹���
	----------------------------------------------------------------------------------
	tMynpcspaceName	= {['err']=0, }
	for i=0, npcMaxNum-1 do
		tMynpcspaceName[i] = "sj_npcSpaceImage_"..i
		
		mynpcspacewindow = winMgr:createWindow("TaharezLook/StaticImage", tMynpcspaceName[i])	
		mynpcspacewindow:setTexture("Enabled", "UIData/tutorial001.tga", 925, 327)
		mynpcspacewindow:setTexture("Disabled", "UIData/tutorial001.tga", 925, 327)
		mynpcspacewindow:setProperty("FrameEnabled", "False")
		mynpcspacewindow:setProperty("BackgroundEnabled", "False")		
		mynpcspacewindow:setSize(80, 41)
		mynpcspacewindow:setVisible(false)
		mynpcspacewindow:setAlwaysOnTop(false)
		mynpcspacewindow:setZOrderingEnabled(false)
		root:addChildWindow(mynpcspacewindow)
	end
	
	
	----------------------------------------------------------------------------------
	-- NPC ��ó�� ���� SPACE�� ǥ���Ѵ�.
	----------------------------------------------------------------------------------
	function ShowSpaceUI(index)
		winMgr:getWindow(tMynpcspaceName[index]):setVisible(true)
		IsClosedNPC(index, true, g_CurrentCameraMagState)	
		g_NpcIndex = index
	end
	
	----------------------------------------------------------------------------------
	-- NPC���� �־����� SPACE�� �����?.
	----------------------------------------------------------------------------------
	function HideSpaceUI(index)
		-- �����̽��� ���涧 Ȯ���ؼ� �����? ���?, �־����� �����? ���? 2������ �ٸ��� ó���Ѵ�.
		local isCloseTo = false
		if g_CurrentCameraMagState then
			isCloseTo = true
		end
		winMgr:getWindow(tMynpcspaceName[index]):setVisible(false)
		IsClosedNPC(index, isCloseTo, g_CurrentCameraMagState)
	end
	
	----------------------------------------------------------------------
	-- NPC ��ó���� �����̽��ٸ� �Է����� ���?
	----------------------------------------------------------------------
	function OnSpaceEvent(index, nShow)		
		tIsNearNPC[index] = nShow
	end
	
	
	
	-----------------------------------------
	-- NPC ��ȭ ����
	-----------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "NPC_TellingBack")
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setWideType(7);
	mywindow:setPosition(0, 501)
	mywindow:setSize(1024, 267)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent('EndRender', 'renderNpcTalkText');
	root:addChildWindow(mywindow)
	
	---------------------------------------------------------
	-- NPC ��ȭ �̹���.
	---------------------------------------------------------
	mynpcwindow = winMgr:createWindow("TaharezLook/StaticImage", "NPC_TellingImage")
	mynpcwindow:setTexture("Enabled", "UIData/tutorial001.tga", 0, 2)
	mynpcwindow:setTexture("Disabled", "UIData/tutorial001.tga", 0, 2)
	mynpcwindow:setProperty("FrameEnabled", "False")
	mynpcwindow:setProperty("BackgroundEnabled", "False")
	mynpcwindow:setPosition(0, 43)
	mynpcwindow:setSize(1024, 224)
	mynpcwindow:setVisible(true)
	mynpcwindow:setAlwaysOnTop(true)
	mynpcwindow:setZOrderingEnabled(true)
	winMgr:getWindow("NPC_TellingBack"):addChildWindow(mynpcwindow)
	
	
	---------------------------------------------------------
	-- NPC ��ȭ �̸� �̹���.
	---------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "NPC_TellingNameImage")
	mywindow:setTexture("Enabled", "UIData/tutorial001.tga", 587, 336)
	mywindow:setTexture("Disabled", "UIData/tutorial001.tga", 587, 336)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(0, -8)
	mywindow:setSize(273, 43)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	winMgr:getWindow("NPC_TellingImage"):addChildWindow(mywindow)
	
	
	---------------------------------------------------------
	-- NPC��ȭ�� ���� ������ư
	---------------------------------------------------------
	local MAX_TALKBUTTON = 6
	for i = 1, MAX_TALKBUTTON do
		mywindow = winMgr:createWindow("TaharezLook/RadioButton", "NPC_TalkButton"..i)
		mywindow:setTexture("Normal", "UIData/tutorial001.tga", 587, 467)
		mywindow:setTexture("Hover", "UIData/tutorial001.tga", 587, 495)
		mywindow:setTexture("Pushed", "UIData/tutorial001.tga", 587, 523)
		mywindow:setTexture("SelectedNormal", "UIData/tutorial001.tga", 587, 551)
		mywindow:setTexture("SelectedHover", "UIData/tutorial001.tga", 587, 551)
		mywindow:setTexture("SelectedPushed", "UIData/tutorial001.tga", 587, 551)	
		mywindow:setProperty("GroupID", 3200)
		mywindow:setSize(204, 27)
		mywindow:setPosition(30, 43 + ((i - 1) * 35))
		mywindow:setZOrderingEnabled(true)
		mywindow:setAlwaysOnTop(true)
		mywindow:subscribeEvent("SelectStateChanged", "NPC_TalkingButtonEvent")
		mywindow:setProperty("Selected", "false")
		mywindow:setVisible(false)
		winMgr:getWindow("NPC_TellingImage"):addChildWindow(mywindow)
	end
	
	
	----------------------------------------------------------------------
	-- NPC��ȭâ�� ��ư�� �� �ʱ�ȭ ��Ų��.
	----------------------------------------------------------------------
	function ResetNPCTalkButton()
		for i = 1, MAX_TALKBUTTON do
			winMgr:getWindow("NPC_TalkButton"..i):setVisible(false)
			if CEGUI.toRadioButton(winMgr:getWindow("NPC_TalkButton"..i)):isSelected() then
				winMgr:getWindow("NPC_TalkButton"..i):setProperty("Selected", "false")			
			end
		end
	end
	
	
	----------------------------------------------------------------------
	-- NPC��ȭâ�� ��ư �̺�Ʈ
	----------------------------------------------------------------------
	function NPC_TalkingButtonEvent(args)
		for i = 1, MAX_TALKBUTTON do
			if CEGUI.toRadioButton(winMgr:getWindow("NPC_TalkButton"..i)):isSelected() then
				
				local ment_window = winMgr:getWindow('NPC_MentText')
				local TalkComplete = CEGUI.toGUISheet(ment_window):isCompleteViewText();
				
				ment_window:clearTextExtends()
				CEGUI.toGUISheet(ment_window):setTextViewDelayTime(11)			
				ment_window:addTextExtends(tNpcStoryTelling[g_NpcType][i], g_STRING_FONT_DODUMCHE, 16, 255,255,255,255,   0, 0,0,0,255 );
				break
			end
		end
	end
	
	
	----------------------------------------------------------------------
	-- NPC ��ȭ �̹��� ESCŰ ���?
	----------------------------------------------------------------------
	RegistEscEventInfo("NPC_TellingBack", "ExchangeExit")
	
	
	
	-- NPC Ȯ��
	function Shownpccommu(NpcType)
		
		-- ī�޶� Ȯ�� true
		g_CurrentCameraMagState = true
	
		winMgr:getWindow("NPC_TellingBack"):setVisible(true)
		winMgr:getWindow("NPC_TellingBack"):setAlwaysOnTop(false)
		
		-- NPC��ȭ�� �� ��ư�� ���ش�
		ShowMiniMap(0);
			
		if NpcType == NPC_CHALLANGE_MISSION then
			if g_checktextstate == false then
				ShowChallengeMission(true)
			end
			
		elseif NpcType == NPC_PARTY1 then
			if g_checktextstate == false then
				ShowPartyWindow()
			end
			
		elseif NpcType == NPC_PARTY2 then
			if g_checktextstate == false then
				ShowPartyWindow()
			end
			
		elseif NpcType == NPC_CLUB then
			if g_checktextstate == false then
				IsQualifiedCreateClub()
			end
			
		elseif NpcType == NPC_CHANGE_JOB then
			if g_checktextstate == false then
				ShowMissionInfo()
			end
			
		elseif NpcType == NPC_MERCHANT then
			if g_checktextstate == false then
				OpenArcadeShop()
			end
			
		elseif NpcType == NPC_CLUB2 then  --������ �ӽ�
			if g_checktextstate == false then
				DebugStr('Ŭ��������UI')
				ShowClubWarWindow()
			end
		elseif NpcType == NPC_COSTUME_CRAFTING then  --������ �ӽ�
			if g_checktextstate == false then
				ShowItemCrafting()
			end
		end
		
		for i = 1, tNpcStoryTelling[NpcType]["size"] do
			winMgr:getWindow("NPC_TalkButton"..i):setVisible(true)
		end	
	end
	
	
	-------------------------------------------------------------
	-- ���� NPC ��Ʈ
	-------------------------------------------------------------
	coinnpcmentwindow = winMgr:createWindow("TaharezLook/StaticText", "NPC_MentText");
	coinnpcmentwindow:setProperty("FrameEnabled", "false");
	coinnpcmentwindow:setProperty("BackgroundEnabled", "false");
	coinnpcmentwindow:setFont(g_STRING_FONT_DODUMCHE, 16);
	coinnpcmentwindow:setTextColor(255, 255, 255, 255);
	coinnpcmentwindow:setPosition(45+120, 55);
	coinnpcmentwindow:setSize(700, 153);
	coinnpcmentwindow:setAlign(0);
	coinnpcmentwindow:setViewTextMode(2);
	coinnpcmentwindow:setLineSpacing(12);
	coinnpcmentwindow:clearTextExtends()
	coinnpcmentwindow:setText('');
	coinnpcmentwindow:setVisible(true);
	winMgr:getWindow('NPC_TellingImage'):addChildWindow(coinnpcmentwindow);
	
	
	----------------------------------------------------------------------
	-- NPC ��Ʈ ����
	----------------------------------------------------------------------
	function ShowNPCMent(NpcType)
		local ment_window = winMgr:getWindow('NPC_MentText')
		ment_window:setVisible(true)
		CEGUI.toGUISheet(ment_window):setTextViewDelayTime(11)
		ment_window:clearTextExtends()
		NpcStoryTellingIndex = 0;
		
		if NpcType == NPC_CHALLANGE_MISSION then	
			ment_window:setPosition(120+120, 47);
			NPCBaseTelling = tChallengeMissionString[1]
					
		elseif NpcType == NPC_PARTY1 then
			ment_window:setPosition(120+120, 47);
			NPCBaseTelling = tParty1Ment[1]
			
		elseif NpcType == NPC_PARTY2 then
			ment_window:setPosition(120+120, 47);
			NPCBaseTelling = tParty2Ment[1]
					
		elseif NpcType == NPC_CLUB then	
			ment_window:setPosition(120+120, 47);
			NPCBaseTelling = tGuildNpcString[1]
				
		elseif NpcType == NPC_CHANGE_JOB then
			ment_window:setPosition(120+120, 47);
			local State = JobChangeConditionState();
			
			if State == 0 then			-- �� 10�̸�
				NPCBaseTelling = tChangeJobString[1];
				
			elseif State == 1 then		-- �� 10�̻� ��������
				if g_CurrentState == 0 then
					NPCBaseTelling = tChangeJobString[2];
					
				elseif g_CurrentState == 1 then
				
					if g_SelectPromotion ~= 6 then
						 NPCBaseTelling = tChangeJobMissionMentString[g_Style][g_SelectPromotion];
					 elseif g_SelectPromotion == 6 then
						 NPCBaseTelling = tChangeJobMissionMentString[1][5];
					 end
					
					-- NPC ��ȭ ��ư�� ���õȰ� Ǯ���ش�.
					for i = 1, MAX_TALKBUTTON do
						if CEGUI.toRadioButton(winMgr:getWindow("NPC_TalkButton"..i)):isSelected() then
							winMgr:getWindow("NPC_TalkButton"..i):setProperty("Selected", "false")			
						end
					end
				end
				
			elseif State == 2 then		-- �� 15�̻� �����ѳ�
				NPCBaseTelling = tChangeJobString[3];
			end
			
		elseif NpcType == NPC_MERCHANT then
			ment_window:setPosition(120+120, 47);
			NPCBaseTelling = tWelcomeMentString[1]
			
		elseif NpcType == NPC_CLUB2 then  --������ �ӽ�
			ment_window:setPosition(120+120, 47);
			NPCBaseTelling = tGuildNpcString[1]
		elseif NpcType == NPC_COSTUME_CRAFTING then
			ment_window:setPosition(120+120, 47);
			NPCBaseTelling = tCostumeCraftingString[1]
		
		end
		
		ment_window:addTextExtends(NPCBaseTelling, g_STRING_FONT_GULIMCHE, 16, 255,255,255,255,   0, 0,0,0,255 );
	end
	
	
	
	
	----------------------------------------------------------------------
	-- NPC�� ��ȭ�ϱ�
	----------------------------------------------------------------------
	local g_STRING_NPC_4 = PreCreateString_1372	--GetSStringInfo(LAN_LUA_WND_VILLAGE_4)	-- ���� ��Ʈ
	function renderNpcTalkText(args)
	
		local drawer = CEGUI.toWindowEventArgs(args).window:getDrawer()
		
		-- ��ȭâ�� ���̻��̸��� ������ �̹���.
		drawer:setFont(g_STRING_FONT_GULIMCHE, 14)
		drawer:drawTexture("UIData/tutorial001.tga", 0, 78, 183, 8, 587, 458);
		for i = 1, tNpcStoryTelling[g_NpcType]["size"] do
			drawer:drawTexture("UIData/tutorial001.tga", 0, 113 + ((i - 1) * 35), 183, 8, 587, 458);
			-- ��ư�� ����? ��ư �̸�
			common_DrawOutlineText2(drawer, tNpcStoryTellingName[g_NpcType][i], 42, 94 + ((i - 1) * 35), 60,60,60,255, 255,255,0,255)
		end
		
		drawer:setFont(g_STRING_FONT_GULIMCHE, 18)
		drawer:setTextColor(87,242,9,255)	
		local Npc_Name = GetNPCName(g_NpcIndex)
		local nameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 18, Npc_Name)
		drawer:drawText(Npc_Name, 90-nameSize/2, 48)
	end
	
	
	----------------------------------------------------------------------
	-- NPC ��ȭ���� ��ư
	----------------------------------------------------------------------
	tMycoinexchangeButtonName		= {['protecterr']=0, [0]="CommunicateButton" , "ExchangeClose"}
	tMycoinexchangeButtonTexName	= {['protecterr']=0, [0]="UIData/invisible.tga", "UIData/Arcade_lobby.tga"}
	tMycoinexchangeButtonTexY		= {['protecterr']=0, [0]=	262,	0	}
	tMycoinexchangeButtonPosX		= {['protecterr']=0, [0]=	785,	905	}
	tMycoinexchangeButtonEvent		= {['protecterr']=0, [0]="CommunicateNPC" , "ExchangeExit" }
	for i=0, #tMycoinexchangeButtonName do
		myselectwindow = winMgr:createWindow("TaharezLook/Button", tMycoinexchangeButtonName[i])
		
		myselectwindow:setTexture("Normal", tMycoinexchangeButtonTexName[1], 421, 308)
		myselectwindow:setTexture("Hover", tMycoinexchangeButtonTexName[1], 421, 360)
		myselectwindow:setTexture("Pushed", tMycoinexchangeButtonTexName[1], 421, 410)
		myselectwindow:setTexture("PushedOff", tMycoinexchangeButtonTexName[1], 421, 308)
	
		myselectwindow:setPosition(tMycoinexchangeButtonPosX[i], 165)
		myselectwindow:setSize(103, 49)
		if i == 0 then
			myselectwindow:setVisible(false)
		else
			myselectwindow:setVisible(true)
		end
		myselectwindow:setZOrderingEnabled(false)
		myselectwindow:setAlwaysOnTop(true)
		myselectwindow:subscribeEvent("Clicked", tMycoinexchangeButtonEvent[i])
		mynpcwindow:addChildWindow(myselectwindow)
	end
	
	
	
	----------------------------------------------------------------------
	-- NPC ��ȭ���� / ���̶ߴ� �������? ����
	----------------------------------------------------------------------
	function ExchangeExit()
		DebugStr('ExchangeExit()')
		-- ī�޶� Ȯ�� false
		g_CurrentCameraMagState = false
		
		if winMgr:getWindow('hh_Helper_Interface'):isVisible() == false then
			--ShowHelp();
		end
	
		-- NPC��ȭ ������ ���� �ٽ� �����?
		ShowMiniMap(1);
		
		if g_NpcType == NPC_CHALLANGE_MISSION then
		--	CM_CloseButtonClickVillage()
			
		elseif g_NpcType == NPC_PARTY1 then
			ClosePartyWindow()
			
		elseif g_NpcType == NPC_PARTY2 then
			ClosePartyWindow()
			
		elseif g_NpcType == NPC_CLUB then
			CloseFightClubInfo()
			
		elseif g_NpcType == NPC_CHANGE_JOB then
			CloseChangeJob()
			winMgr:getWindow("CJ_MainImage"):setVisible(false)
		
		elseif g_NpcType == NPC_MERCHANT then
			CloseArcadeShop()
			
		elseif g_NpcType == NPC_CLUB2 then --������ �ӽ�
			DebugStr('Ŭ��������npc����')
			CloseClubWarWindow()
		elseif g_NpcType == NPC_COSTUME_CRAFTING then		
			CloseItemCrafting()
		end
		MailBallonSearch()
		g_currentZoom = false
		ClickNPC_spaceUI(g_NpcIndex, false)
		FadeInStart(510)
		winMgr:getWindow("NPC_TellingBack"):setVisible(false)
		Oncontroller();	
		
		g_checktextstate = false;
		Util_SettingWinAlpha(tAlphaSettingWinName, 0);
		
	end
	
	
	----------------------------------------------------------------------
	-- npc��ȭ�ϱ� ��ư Ŭ�� �̺�Ʈ
	----------------------------------------------------------------------
	function CommunicateNPC()
		local ment_window = winMgr:getWindow('NPC_MentText')
		local TalkComplete = CEGUI.toGUISheet(ment_window):isCompleteViewText();
		
		if TalkComplete then
			ment_window:clearTextExtends()
			CEGUI.toGUISheet(ment_window):setTextViewDelayTime(11)
			NpcStoryTellingIndex = NpcStoryTellingIndex + 1;
			-- NPC�ε����� +1�� ���ִ� ������ ���� NPC�ε����� ForGameDesigner�� �ε����� ���߱�����
			if 	#tNpcStoryTelling[g_NpcType] < NpcStoryTellingIndex then
				NpcStoryTellingIndex = 0;
			end
	
			local NpcTelling = "";
			
			if NpcStoryTellingIndex == 0 then
				NpcTelling	= NPCBaseTelling
			else
				NpcTelling	= tNpcStoryTelling[g_NpcType][NpcStoryTellingIndex]
			end
			ment_window:addTextExtends(NpcTelling, g_STRING_FONT_DODUMCHE, 16, 255,255,255,255,   0, 0,0,0,255 )
	
		else
			CEGUI.toGUISheet(ment_window):setCompleteViewText(true)
		end
		
	end
	
	
	
	
	
	----------------------------------------------------------------------
	
	-- Selectable Object ����
	
	----------------------------------------------------------------------
	local OBJECT_TYPE_RANKING = 0
	local OBJECT_TYPE_PROMOTION = 1
	local OBJECT_TYPE_TOURNAMENT_RANKING = 2
	local OBJ_TYPE_SLOTMACHINE = 3
	local OBJ_TYPE_GANGWAR_RANKING = 4
	local OBJ_TYPE_DEFENCE_RANKING = 5
	
	
	local g_objIndex = 0
	local objMaxNum  = GetMaxObjNum()	-- ������Ʈ ��
	local tIsNearObj = {["err"]=0,}		-- ������Ʈ�� ������ �� ���? 1
	local t_Obj_TYPE = {["err"]=0,}		-- ������Ʈ�� Ÿ���� ����
	for i=0, objMaxNum-1 do
		t_Obj_TYPE[i] = GetObjType(i)
		tIsNearObj[i] = 0
	end
	
	
	----------------------------------------------------------------------------------
	-- ����, ���?, ç����, ���� SPACE �̹���
	----------------------------------------------------------------------------------
	tObjSpaceImageName	= {['err']=0, }
	for i=0, objMaxNum-1 do
		tObjSpaceImageName[i] = "sj_objSpaceImage_"..i
		
		objSpaceWindow = winMgr:createWindow("TaharezLook/StaticImage", tObjSpaceImageName[i])	
		objSpaceWindow:setTexture("Enabled", "UIData/tutorial001.tga", 925, 327)
		objSpaceWindow:setTexture("Disabled", "UIData/tutorial001.tga", 925, 327)
		objSpaceWindow:setProperty("FrameEnabled", "False")
		objSpaceWindow:setProperty("BackgroundEnabled", "False")
		objSpaceWindow:setSize(80, 41)
		objSpaceWindow:setVisible(false)
		objSpaceWindow:setAlwaysOnTop(false)
		objSpaceWindow:setZOrderingEnabled(false)
		root:addChildWindow(objSpaceWindow)
	end
	
	function OnEventObjSpaceUI(index, bNear)
		if bNear == 1 then
			g_objIndex = index
			winMgr:getWindow(tObjSpaceImageName[index]):setVisible(true)
		else
			winMgr:getWindow(tObjSpaceImageName[index]):setVisible(false)
		end
		tIsNearObj[index] = bNear
	end
	
	function WndVillage_DrawObjSpaceImage(index, x, y)	
		winMgr:getWindow(tObjSpaceImageName[index]):setPosition(x+30, y)
	end
	
	
	
	----------------------------------------------------------------------
	
	-- Ű����
	
	----------------------------------------------------------------------
	g_UseMaxMap = true;
	g_bTestToggle = true;
	g_bTextDrawToggle = true;
	g_editboxByParty = false;	-- ��Ƽ���� ����Ʈ �ڽ��� Enter�� �Է����� ���?
	g_checktextstate = false;
	
	
	function WndVillageEscEvent()
		if winMgr:getWindow("sj_village_GuideAlpha_firstEnter") then
			if winMgr:getWindow("sj_village_GuideAlpha_firstEnter"):isVisible() == false then
				UIEscEvent()	-- ������ Wndpopu.lua�� ���� �̺�Ʈ�� �ϳ��� �������� �س��� ���Ұ�. �׷��� ���� �ҷ��ش�.
			--	if winMgr:getWindow("TownNPC_VirtualImage"):isVisible() == false then
			--		TownNpcEscBtnClickEvent()
			--	end
			end
		end
	end
	
	
	function OnRootKeyUp(args)	
		local keyEvent = CEGUI.toKeyEventArgs(args);
		----------------
		-- UI ����Ű ����
		----------------
		--if b_pushCtrl == 1 then
		DebugStr('keyEvent.scancode:'..keyEvent.scancode)	
		if CheckBlockInput() then
			return
		end
		
			
		--end
		----------------
		-- ESC Ű
		----------------
		-- esc�̺�Ʈ�� ���Ǿ� Ű �Է°� ���ļ� ������ ������(c���� ó��)
		----------------
		-- F2 Ű
		---------------
		if keyEvent.scancode == 113 then
			if GetMyShopState() == 0 and IsItemTrading() == false then
				--SetSelectVillage()
				--BtnPageMove_RequestVillage() -- �������� �̵�
				SetInputEnable(false)
				OpenChannelImage()
				--return
			end
		
		----------------
		-- F3 Ű
		----------------
		--[[
		elseif keyEvent.scancode == 114 then-- F3
			
			if GetMyShopState() == 0 and IsItemTrading() == false then
				ShowChannelSelect() --�������� �̵�
				SetSelectBattle()
				BtnPageMove_RequestBattleChannel()
				return
			end
		--]]
		----------------
		-- F5 Ű
		----------------
		elseif keyEvent.scancode == 116 then-- F5
			DebugStr('F5 Ű')
			--[[
			if GetMyShopState() == 0 and IsItemTrading() == false then
				if IsTestPassport() == false then
					SetSelectShop()
					if IsPartyPlaying() > 0 then
						if IsKoreanLanguage() then
							ShowCommonAlertOkCancelBoxWithFunction("��ƼŻ��", "�� �˴ϴ�.\n�׷��� �̵��Ͻðڽ��ϱ�?", "PartyCheckOkButton", "PartyCheckCancelButton")
						else
							ShowCommonAlertOkCancelBoxWithFunction("", BPM_String_PartyBan2, "PartyCheckOkButton", "PartyCheckCancelButton")
						end
					else
						if IsKoreanLanguage() then
							return
						end
						BtnPageMove_GoToItemShop() -- ������ �̵�
					end
				end
			end
			--]]
		----------------
		-- F4 Ű
		----------------
		elseif keyEvent.scancode == 115 then -- F4
			if IsKoreanLanguage() then
				return
			end
			if GetMyShopState() == 0 and IsItemTrading() == false then
				SetSelectMyRoom()
				if IsPartyPlaying() > 0 then
						if IsKoreanLanguage() then
							ShowCommonAlertOkCancelBoxWithFunction("��ƼŻ��", "�� �˴ϴ�.\n�׷��� �̵��Ͻðڽ��ϱ�?", "PartyCheckOkButton", "PartyCheckCancelButton")
						else
							ShowCommonAlertOkCancelBoxWithFunction("", BPM_String_PartyBan2, "PartyCheckOkButton", "PartyCheckCancelButton")
						end
				else
					BtnPageMove_GoToMyItem()  -- ���̷����� �̵�
				end
			end
		----------------
		-- F11 Ű
		----------------
		elseif keyEvent.scancode == 122 then -- F11
			
			CallPopupOption() -- �ɼ�ȣ��
			return
			
		----------------
		-- Ctrl Ű
		----------------
		elseif keyEvent.scancode == 17 then
			SendUseDigTool()
			
		---------------
		-- Enter VK_RETURN
		--------------- 
		elseif keyEvent.scancode == 13 then
			--DebugStr("keyEvent")
			UIEnterEvent()	-- ������ Wndpopu.lua�� ���� �̺�Ʈ�� �ϳ��� �������� �س��� ���Ұ�. �׷��� ���� �ҷ��ش�.
			
			-- ���� ���̼����?(�غ���) ���? ����
			if GetMyShopState() == 1 then
				return
			end
			
			-- �ŷ����� ���� ���������? �ӼӸ��� �ϵ��� �Ѵ�
			if IsItemTrading() then
				winMgr:getWindow("sj_MyDealChat_editbox"):activate()
				return
			end
			
			if g_currentZoom == false then
			
				-- �������� enterŰ ���û��¸� üũ�Ѵ�.
				local edit_bg_visible	 = winMgr:getWindow('CommonAlertOkCancelBoxWithEdit'):isVisible()
				local is_msg_chat_active = winMgr:getWindow("doChattingAtMessenger"):isVisible()
				local createClubWindows	 = winMgr:getWindow("sj_club_createWindow"):isVisible()
				local rankingWindows	 = winMgr:getWindow("sj_Ranking_Background_Image"):isVisible()
				local partyWindows		 = winMgr:getWindow("sjparty_BackImage"):isVisible()
				local is_Mail_Write_active = winMgr:getWindow("MailWriteImage"):isVisible()
				local is_Mail_Back_active = winMgr:getWindow("MailBackImage"):isVisible()
				local is_FightCLub_active = winMgr:getWindow("FightClub_ClubNameWindow"):isVisible()
				local is_ClubList_active = winMgr:getWindow("FightClub_ClubListWindow"):isVisible()
				local is_Profile_Visible		= winMgr:getWindow('ProfileBackImage'):isVisible()
				local is_ProfileRepair_Visible	= winMgr:getWindow('ProfileRepairImage'):isVisible()
				local is_TourRanking_windows = winMgr:getWindow('TourRanking_Background_Image'):isVisible()
				local is_MyshopView_windows = winMgr:getWindow('MyshopViewSearchBackImage'):isVisible()
				local is_FB_windows   = false
				local is_FBPost_windows   = false
			
				local is_Escrow_windows
				
				if CheckfacilityData(FACILITYCODE_ESCROWSYSTEM) == 1 then
					is_Escrow_windows = winMgr:getWindow('EscrowBackground'):isVisible()
				else
					is_Escrow_windows = false
				end
				
				-- �޽����� ���� ���� �������? �Ϲ� ä�ùڽ��� �����ش�.
				if	edit_bg_visible				== false and
					is_msg_chat_active			== false and
					createClubWindows			== false and
					rankingWindows				== false and
					is_Mail_Write_active		== false and
					is_Mail_Back_active			== false and
					--is_FightCLub_active			== false and
					--is_ClubList_active			== false and
					is_Profile_Visible			== false and
					is_ProfileRepair_Visible	== false and
					is_TourRanking_windows		== false and
					CheckNpcModeforLua()		== false and
					is_MyshopView_windows       == false and
					is_Escrow_windows			== false and
					is_FB_windows				== false and
					is_FBPost_windows			== false and
					partyWindows == false			then
					
					
					OnRootKeyUpChatting()
					
				-- �޽����� �������� ���? �޽��� ä�ùڽ� activate
				else
					if is_msg_chat_active then
						winMgr:getWindow("doChattingAtMessenger"):activate()
					end
				end
			end
			
		---------------
		-- W
		---------------
		elseif keyEvent.scancode == 82 then
			
			-- ���� ���̼����?(�غ���) ���? ����
			if GetMyShopState() == 1 then
				return
			end
			
			-- �ŷ����� ���? ����
			if IsItemTrading() then
				return
			end
	
			if	ForLuaCheckActivationEditBox() == false then
				ShowMap();			
			end
		
		--TABŰ
		elseif keyEvent.scancode == 9 then 
		
			ChangeChatPopupTab()
		
		--�Ʒ�ȭ��ǥŰ
		
		elseif keyEvent.scancode == 40 then 
				--[[
			if winMgr:getWindow('doChatting'):isActive() == true  then
				local ChatMsg, ListSize = ChatMsgListLoad(g_MsgCount)
				g_MsgCount = g_MsgCount + 1
				
				if g_MsgCount >= ListSize then
					g_MsgCount = 0
				end
				winMgr:getWindow('doChatting'):setText(ChatMsg)
			end
				--]]
		
		---------------
		-- SPACE(���� ���ķδ� �߰����� ���� �߰��� return�� ���� ;;, �ؿ��� �����)
		---------------
		elseif keyEvent.scancode == 32 then
			-- ���Ըӽ��� �����������?
			winMgr:getWindow("sjParty_Avarta_TypeWindow_tempImage"):setVisible(false)
			if winMgr:getWindow("OrbSlot_Background_Image"):isVisible() then
				if winMgr:getWindow("RewardBackImage"):isVisible() then
					OnClickRewardOk()
					return
				end
				ControlOrbMachine()
				return
			end
					
			-- ���� ���̼����?(�غ���) ���? ����
			if GetMyShopState() == 1 then
				return
			end
			
			-- �ŷ����� ���? ����
			if IsItemTrading() then
				return
			end
			
			if winMgr:getWindow("doChatting") then
				if winMgr:getWindow("doChatting"):isVisible() then
					return
				end
			end
			
			-- ó�� ���۽� �ڵ����� �������� �����Ѵ�.
			if winMgr:getWindow('sj_village_text_firstEnter') then
				local isTalkComplete = CEGUI.toGUISheet(winMgr:getWindow('sj_village_text_firstEnter')):isCompleteViewText();
				if winMgr:getWindow('sj_village_passBtn_firstEnter'):isVisible() and isTalkComplete then
					FirstEnterButtonEnter();
				end
			end
			
			-- ��ŷ������ �����̽��� �������? ��ŷ�� �����ش�.
			if tIsNearObj[g_objIndex] == 1 then
	
				-- 0:��ŷ ������Ʈ
				if t_Obj_TYPE[g_objIndex] == OBJECT_TYPE_RANKING then
					ShowRanking()
				
				-- 1:������ ������Ʈ
				elseif t_Obj_TYPE[g_objIndex] == OBJECT_TYPE_PROMOTION then
					ShowPromotionEvent()
				
				-- 2:��ʸ��? ��ŷ
				elseif t_Obj_TYPE[g_objIndex] == OBJECT_TYPE_TOURNAMENT_RANKING then
					--local STRING_PREPARING = PreCreateString_1273	--GetSStringInfo(LAN_LUA_WND_POPUP_2) -- �غ����Դϴ�.
					--ShowNotifyOKMessage_Lua(STRING_PREPARING)
					ShowTourRanking()
					
				--3:���Ըӽ�
				elseif t_Obj_TYPE[g_objIndex] == OBJ_TYPE_SLOTMACHINE then
					ShowOrbSlotMachine()
					ClickObject_ORBSLOT(true)
					
				elseif t_Obj_TYPE[g_objIndex] == OBJ_TYPE_GANGWAR_RANKING then
	
					if CheckfacilityData(FACILITYCODE_GANG_WAR) == 1 then
						ShowClubWarRanking()
					else
						local STRING_PREPARING = PreCreateString_1273 --GetSStringInfo(LAN_LUA_WND_POPUP_2) -- �غ����Դϴ�.
						ShowNotifyOKMessage_Lua(STRING_PREPARING)
					end
				elseif t_Obj_TYPE[g_objIndex] == OBJ_TYPE_DEFENCE_RANKING then
	
					--if CheckfacilityData(FACILITYCODE_GANG_WAR) == 1 then
						GetDefenceRankInfo()
					--else
						--local STRING_PREPARING = PreCreateString_1273	--GetSStringInfo(LAN_LUA_WND_POPUP_2) -- �غ����Դϴ�.
						--ShowNotifyOKMessage_Lua(STRING_PREPARING)
					--end
				end
			end
			
			-- NPC�� ������ ���� ���?
			if tIsNearNPC[g_NpcIndex] == 1 then
				DebugStr('npc��ó')
				
				local edit_chat_active			= winMgr:getWindow('doChatting'):isActive()
				local edit_bg_visible			= winMgr:getWindow('CommonAlertOkCancelBoxWithEdit'):isVisible()
				local edit_PartyCreate_active	= winMgr:getWindow('sjParty_Create_NameEditbox'):isActive()
				local edit_PartyInvite_active	= winMgr:getWindow('sjParty_Invite_NameEditbox'):isActive()
				local edit_Messengerchat_active = winMgr:getWindow('doChattingAtMessenger'):isActive()
				local edit_macro1_active		= winMgr:getWindow('MacroEditBox_1'):isActive()
				local edit_macro2_active		= winMgr:getWindow('MacroEditBox_2'):isActive()
				local edit_macro3_active		= winMgr:getWindow('MacroEditBox_3'):isActive()
				local edit_macro4_active		= winMgr:getWindow('MacroEditBox_4'):isActive()			
				local AS_popup_visible			= winMgr:getWindow('AS_PopupBackAlphaImg'):isVisible()
				local club_create_visible		= winMgr:getWindow('sj_club_createWindow'):isVisible()
				local club_name_visible			= winMgr:getWindow('FightClub_ClubNameWindow'):isVisible()
				local club_list_visible			= winMgr:getWindow('FightClub_ClubListWindow'):isVisible()
				local Mail_Window_active		= winMgr:getWindow("MailBackImage"):isVisible()
				local edit_Megaphone			= winMgr:getWindow('MegaPhoneMsgEditBox'):isActive()
				local crafting_popup2			= winMgr:getWindow('CraftingMainBackImage'):isVisible()
				local crafting_popup			= winMgr:getWindow('Crafting_RewardImagePopup'):isVisible()
				local is_Profile_Visible		= winMgr:getWindow('ProfileBackImage'):isVisible()
				local is_ProfileRepair_Visible	= winMgr:getWindow('ProfileRepairImage'):isVisible()
				
				-- ���� ����Ʈ�ڽ� ���õȰ� ������ �������?
				if	edit_chat_active == false and
					edit_bg_visible == false and 
					edit_PartyCreate_active == false and
					edit_PartyInvite_active == false and
					edit_Messengerchat_active == false and
					edit_macro1_active == false and 
					edit_macro2_active == false and
					edit_macro3_active == false and 
					edit_macro4_active == false	and
					club_create_visible == false	and
					club_name_visible == false	and
					club_list_visible == false	and
					Mail_Window_active == false and
					AS_popup_visible == false and
					edit_Megaphone == false and 
					is_Profile_Visible == false and
					is_ProfileRepair_Visible == false and
					crafting_popup2 == false and
					ForLuaCheckActivationEditBox() == false and
					crafting_popup == false then
						
					-- �ٽ��ѹ��� NPC�� �����ִ��� üũ�Ѵ�.(���Ұ��? �����̸鼭 NPC �˾�â�� �������? ����)
					if IsCloseNPC(g_NpcIndex) == false then
						return
					end
					
					if g_currentZoom then
						ExchangeExit()
						return
					else
						CommunicateNPC()
						g_currentZoom = true
					end
			
					-- ���� NPC�� �°� ����(NPC�߰��� �����? �߰��ϸ� ��)
					if		t_NPC_TYPE[g_NpcIndex] == NPC_CHALLANGE_MISSION then	g_NpcType = NPC_CHALLANGE_MISSION
					elseif	t_NPC_TYPE[g_NpcIndex] == NPC_PARTY1			then	g_NpcType = NPC_PARTY1
					elseif	t_NPC_TYPE[g_NpcIndex] == NPC_PARTY2			then	g_NpcType = NPC_PARTY2
					elseif	t_NPC_TYPE[g_NpcIndex] == NPC_CLUB				then	g_NpcType = NPC_CLUB
					elseif	t_NPC_TYPE[g_NpcIndex] == NPC_CHANGE_JOB		then	g_NpcType = NPC_CHANGE_JOB
					elseif	t_NPC_TYPE[g_NpcIndex] == NPC_MERCHANT			then	g_NpcType = NPC_MERCHANT
					elseif	t_NPC_TYPE[g_NpcIndex] == NPC_CLUB2				then	g_NpcType = NPC_CLUB2  -- ������ �ӽ�
					elseif	t_NPC_TYPE[g_NpcIndex] == NPC_COSTUME_CRAFTING	then	g_NpcType = NPC_COSTUME_CRAFTING
					
					end
					DebugStr("npc type: " .. g_NpcType)
					
					Offcontroller()			-- �Ʒ��� ��ư ��Ʈ�ѷ� off
					ResetNPCTalkButton()	-- NPC�� ������ �����? ���� ��ư �ʱ�ȭ
					Shownpccommu(g_NpcType)	-- ���� NPC�� �´� �����츦 �ٿ��?.
					ClickNPC_spaceUI(g_NpcIndex, true)
					if g_checktextstate == false then
						FadeInStart(510)
						ShowNPCMent(g_NpcType)
						g_checktextstate = true
					end
					
					-- ����̰�? �����? �ִٸ� ����̸�? �ݴ´�.
					if winMgr:getWindow('hh_Helper_Interface'):isVisible() == true then
						--CloseHelpButton()
					end
				end
			end
				
		end	
		
		if	ForLuaCheckActivationEditBox() == false then
			--DebugStr('rerere')
			if CheckNpcModeforLua() then
				return
			end
			
			local CommonBox1 =  winMgr:getWindow('CommonAlertAlphaImg'):isVisible()
			local CommonBox2 =  winMgr:getWindow("FriendAlertAlphaImg"):isVisible()
			local CommonBox3 =  winMgr:getWindow("sj_party_AlphaImg"):isVisible()
			local CommonBox4 =  winMgr:getWindow("ApdaterAlphaImage"):isVisible()
			local CommonBox5 =  winMgr:getWindow("OrbDettachAlphaImg"):isVisible()
			local CommonBox6 =  winMgr:getWindow("PetStatUpgrade_MainWindow"):isVisible()
			if GetMyShopState() == 0 
				and IsItemTrading() == false 
				and CommonBox1 == false
				and CommonBox2 == false
				and CommonBox3 == false 
				and CommonBox4 == false
				and CommonBox5 == false
				and CommonBox6 == false then
				
				if keyEvent.scancode == 84 then  -- �̺�Ʈ ����Ű(T)
					CallPopupEvent()
					return
				end
				
				if keyEvent.scancode == 67 then  -- ������ ����Ű(c)
					CallPopupMyInfo()
					return
				end
				
				if keyEvent.scancode == 73 then  -- ���� ����Ű(I)
					DebugStr("CallPopupInven ȣ��")
					
					-- ��Ż ��ų ���� ����
					if winMgr:getWindow("RentalSkill_Main"):isVisible() == true then
						return
					end
					
					-- Ŭ�� �ƹ�Ÿ ��ȯ�� ����
					if IsKoreanLanguage() == false then
						if winMgr:getWindow("Costume_Change_MainWindow"):isVisible() == false	-- �ƹ�Ÿ ��ȯ
						and winMgr:getWindow("Costume_Visual_Main"):isVisible() == false		-- �����? ����
						and winMgr:getWindow("CostumeItemList"):isVisible() == false			-- ����Ʈâ
						and winMgr:getWindow("MailWriteImage"):isVisible() == false then		-- ���� ���� â
							DebugStr("�κ�����")
							CallPopupInven()
						end
					else
						CallPopupInven()
					end
					
					return
				end
				
				if keyEvent.scancode == 75 then  -- ���� ����Ű(k)
					
					-- Ŭ�� �ƹ�Ÿ ��ȯ�� ����
					if IsKoreanLanguage() == false then
						if winMgr:getWindow("Costume_Change_MainWindow"):isVisible() == false	-- �ƹ�Ÿ ��ȯ
						and winMgr:getWindow("Costume_Visual_Main"):isVisible() == false		-- �����? ����
						and winMgr:getWindow("CostumeItemList"):isVisible() == false			-- ����Ʈâ
						and winMgr:getWindow("MailWriteImage"):isVisible() == false then		-- ���� ���� â
							CallPopupPresent()
						end
					else
						CallPopupPresent()
					end -- end of languagecode
					
					return
					
				end
				
				if keyEvent.scancode == 77 then  -- �޽��� ����Ű(M)
					CallPopupMessenger()
					return
				end
				
				if keyEvent.scancode == 78 then  -- Ŭ�� ����Ű(n)
					CallPopupMyClub()
					return
				end
				
				if keyEvent.scancode == 71 then  -- ���� ����(g)
					if IsKoreanLanguage() then
						ShowGameRating()
					end
					return
				end
				
				if keyEvent.scancode == 76 then  -- ����Ʈ ����Ű(L)
					CallPopupQuest()
					return
				end
				
				if keyEvent.scancode == 80 then -- ������ ����Ű(p)
					ShowProfileUi()
					return
				end
			end
		end
	end
	
	root:subscribeEvent("KeyUp", "OnRootKeyUp");
	
	
	
	
	if g_IsDebug == true then
		SettingDebugMode(true)
	end
	
	function DebugStr(args)
		if g_IsDebug == true then
			Lua_DebugStr(args)
		end
	end
	
	
	function OnMotionEventEnd(args)
		--guide_click_win:setVisible(false);
	end
	
	
	function OnGuideActionMotionEventEnd(args)
		--guide_click_win:setVisible(false);
	end
	
	
	-- �Ƿε� �׸���.
	function WndVillage_ShowFatigue(fatigue, maxfatigue)
	
	
		drawer = winMgr:getWindow("DefaultWindow"):getDrawer();
		
		drawer:setFont(g_STRING_FONT_GULIMCHE, 10);
		drawer:setTextColor(255,255,255,255);
		
		
		percent =  fatigue * 100/maxfatigue
		
		if( fatigue > 0 ) then
			if( percent <= 0) then
				percent = 1		
			end
		
		end
		
		--percent = (percent + 1) % 101
		reversePercent = 100 - percent
		
		
		percentstring =  percent .. '%'
		Size = GetStringSize(g_STRING_FONT_GULIM, 10, percentstring)
		
		
		
		baseX = 423
		baseY = 717
		
		drawer:drawTexture("UIData/mainBG_button004.tga", baseX, baseY		, 29, 50, 228, 366, 2);
		drawer:drawTexture("UIData/mainBG_button004.tga", baseX, baseY + ( reversePercent/ 2) 	, 29, 50  - ( reversePercent/ 2) , 257, 366 + ( reversePercent/ 2),2 );
		
		--drawer:drawText(percent .. '%', baseX + 2, baseY,2)
		common_DrawOutlineText1(drawer, percentstring,  baseX + 15 - Size / 2, baseY + 30, 0,0,0,255, 97,230,240,255,2)
		
		
		
		
	
	end
	
	
	-- ��Ʈ�ѷ� ����
	function OnFirstRender()
		-- OnUpdateGoMatchMakingButton()
	end
	
	function Offcontroller()
		winMgr:getWindow('BPM_MenuButtonContainer'):setVisible(false);
		winMgr:getWindow('BPM_ContainerImage'):setVisible(false);
		winMgr:getWindow('BPM_MenuButton'):setVisible(false);
		winMgr:getWindow('BPM_MoveFightButton'):setVisible(false);
		winMgr:getWindow('BPM_MoveShopButton'):setVisible(false);
		winMgr:getWindow('BPM_MoveMyroomButton'):setVisible(false);
		winMgr:getWindow('BPM_MoveVillageButton'):setVisible(false);
		winMgr:getWindow('Club_Notice_baloon'):setVisible(false);
		winMgr:getWindow('ShowTourBoardBtn'):setVisible(false)
		winMgr:getWindow('TourTestMoveBtn'):setVisible(false)
		winMgr:getWindow('ShowTourEntrySettingBtn'):setVisible(false)
		winMgr:getWindow('ShowTourEntrySettingBtn'):setVisible(false)
		winMgr:getWindow('ClubWarNoticeDefaultImage'):setVisible(false)
		winMgr:getWindow('MainBarExtend'):setVisible(false)
		winMgr:getWindow('ChannelPositionBG'):setVisible(false);
		winMgr:getWindow('MyQuest_SimpleWindowBack'):setVisible(false)
		winMgr:getWindow('ChatBackground'):setVisible(false)
		winMgr:getWindow("GoMatchMakingButton"):setVisible(false)

		winMgr:getWindow("OpenCollection"):setVisible(false)
		
		winMgr:getWindow("sj_buff_tempAlphaImage"):setVisible(false)
		winMgr:getWindow("AutoMatch_MenuBtn"):setVisible(false)
		
		winMgr:getWindow('MyInven_BackImage'):setVisible(false)
		winMgr:getWindow('UserInfo_Main'):setVisible(false)
		
		if CheckfacilityData(FACILITYCODE_ESCROWSYSTEM) == 1 then
			winMgr:getWindow('EscrowButton'):setVisible(false)
		end
	
	end
	
	function Oncontroller()
		winMgr:getWindow('BPM_ContainerImage'):setVisible(true);
		winMgr:getWindow('BPM_MenuButton'):setVisible(true);
		winMgr:getWindow('BPM_MoveFightButton'):setVisible(true);
		winMgr:getWindow('BPM_MoveShopButton'):setVisible(true);
		winMgr:getWindow('BPM_MoveMyroomButton'):setVisible(true);
		winMgr:getWindow('BPM_MoveVillageButton'):setVisible(true);
		winMgr:getWindow("OpenCollection"):setVisible(true)
		MovePopupButton(20, 0)
		if g_EffectCount > 0 then
		end
		--winMgr:getWindow('Club_Notice_baloon'):setVisible(true);
		
		
		if CheckfacilityData(FACILITYCODE_PROFILE) == 1 then
			--winMgr:getWindow('ProfileEffectBtn'):setVisible(true)
		end
		
		OccupationGetInfo() -- ��ʸ��? �������� Ȯ��
		if IsPartyJoined() == false then
			ShowTourTestMoveBtn(true)
		end
		winMgr:getWindow('ClubWarNoticeDefaultImage'):setVisible(true)
		winMgr:getWindow('MainBarExtend'):setVisible(true)
		winMgr:getWindow('ChannelPositionBG'):setVisible(true);
		winMgr:getWindow('MainBar_Mail_EffectImage'):setVisible(true);
		winMgr:getWindow('MyQuest_SimpleWindowBack'):setVisible(true)
		winMgr:getWindow("sj_buff_tempAlphaImage"):setVisible(true)
		winMgr:getWindow('ChatBackground'):setVisible(true)
	
		if isHideMatchMakingButton == false then
			winMgr:getWindow("GoMatchMakingButton"):setVisible(true)
		end
		
		if CheckfacilityData(FACILITYCODE_ESCROWSYSTEM) == 1 then
			winMgr:getWindow('EscrowButton'):setVisible(true)
		end
	end
	
	
	
	SetBooleanWidth(100);
	guiSystem:setDefaultMouseCursor("TaharezLook", "MouseArrow");
	
	
	
	--winMgr:getWindow('BPM_VillageMovebtn'):setVisible(false)
	--winMgr:getWindow('BPM_VillageMovebtn2'):setVisible(true)
	
	
	------------------------------------------------
	
	--	NPC ���� SPACE, �̸����� �׸���.
	
	------------------------------------------------
	function WndVillage_DrawNpcUI(index, type, x, y, name, title)
		
		--  Ȯ������ ���� ������ �ʴ´�.
		if g_CurrentCameraMagState then
			return
		end
		
		drawer = winMgr:getWindow("DefaultWindow"):getDrawer();
		drawer:setFont(g_STRING_FONT_GULIMCHE, 14)
		drawer:setTextColor(255,255,255,255)
		
		local offset = -25
		local id_width = 50
		
		local SPACE_X = 0
		local SPACE_Y = 0
		
		if type == NPC_CHALLANGE_MISSION then
		
			local size = GetStringSize(g_STRING_FONT_GULIMCHE, 14, title)
			common_DrawOutlineText1(drawer, title, x+68-size/2, y+52+offset, 0,0,0,255, 97,230,240,255)
			common_DrawOutlineText1(drawer, name, x+80-id_width, y+72+offset, 0,0,0,255, 255,205,86,255)
			
			SPACE_X = x+80-id_width
			SPACE_Y = y+3+offset
			
		elseif type == NPC_PARTY1 then
		
			local size = GetStringSize(g_STRING_FONT_GULIMCHE, 14, title)
			common_DrawOutlineText1(drawer, title, x+68-size/2, y+70+offset, 0,0,0,255, 97,230,240,255)
			common_DrawOutlineText1(drawer, name, x+70-id_width, y+87+offset, 0,0,0,255, 255,198,30,255)
			
			SPACE_X = x+80-id_width
			SPACE_Y = y+24+offset
			
		elseif type == NPC_PARTY2 then
		
			local size = GetStringSize(g_STRING_FONT_GULIMCHE, 14, title)
			common_DrawOutlineText1(drawer, title, x+68-size/2, y+70+offset, 0,0,0,255, 97,230,240,255)
			common_DrawOutlineText1(drawer, name, x+76-id_width, y+87+offset, 0,0,0,255, 255,198,30,255)
			
			SPACE_X = x+80-id_width
			SPACE_Y = y+24+offset
			
		elseif type == NPC_CLUB then
		
			local size = GetStringSize(g_STRING_FONT_GULIMCHE, 14, title)
			common_DrawOutlineText1(drawer, title, x+70-size/2, y+63+offset, 0,0,0,255, 97,230,240,255)
			common_DrawOutlineText1(drawer, name, x+96-id_width, y+80+offset, 0,0,0,255, 255,198,30,255)
			
			SPACE_X = x+77-id_width
			SPACE_Y = y+20+offset
			
		elseif type == NPC_CHANGE_JOB then
		
			local size = GetStringSize(g_STRING_FONT_GULIMCHE, 14, title)
			common_DrawOutlineText1(drawer, title, x+74-size/2, y+42+offset, 0,0,0,255, 97,230,240,255)
			common_DrawOutlineText1(drawer, name, x+78-id_width, y+59+offset, 0,0,0,255, 255,198,30,255)
			
			SPACE_X = x+77-id_width
			SPACE_Y = y-3+offset
			
		elseif type == NPC_MERCHANT then
		
			local size = GetStringSize(g_STRING_FONT_GULIMCHE, 14, title)
			common_DrawOutlineText1(drawer, title, x+68-size/2, y+68+offset, 0,0,0,255, 97,230,240,255)
			common_DrawOutlineText1(drawer, name, x+100-id_width, y+85+offset, 0,0,0,255, 255,198,30,255)
			
			SPACE_X = x+80-id_width
			SPACE_Y = y+24+offset
		
		elseif type == NPC_CLUB2 then --������(�ӽ�)
		
			local size = GetStringSize(g_STRING_FONT_GULIMCHE, 14, title)
			common_DrawOutlineText1(drawer, title, x+70-size/2, y+63+offset, 0,0,0,255, 97,230,240,255)
			common_DrawOutlineText1(drawer, name, x+96-id_width, y+80+offset, 0,0,0,255, 255,198,30,255)
			
			SPACE_X = x+77-id_width
			SPACE_Y = y+20+offset
		elseif type == NPC_COSTUME_CRAFTING then
		
			local size = GetStringSize(g_STRING_FONT_GULIMCHE, 14, title)
			common_DrawOutlineText1(drawer, title, x+68-size/2, y+68+offset, 0,0,0,255, 97,230,240,255)
			common_DrawOutlineText1(drawer, name, x+100-id_width, y+85+offset, 0,0,0,255, 255,198,30,255)
			
			SPACE_X = x+80-id_width
			SPACE_Y = y+24+offset	
		end
		
		winMgr:getWindow(tMynpcspaceName[index]):setPosition(SPACE_X, SPACE_Y)
	end
	
	
	
	
	------------------------------------------------
	
	--	�ɸ��� ���� ȣĪ, ���� �̸��� �׸���.
	
	------------------------------------------------
	local g_StartTime = 0;
	local g_helppos = 10
	if IsThaiLanguage() or IsEngLanguage() or IsGSPLanguage() then----0421KSG
		g_helppos = 50
	end
	
	local bFlagStage = 0
	local bFlagCurrent = 0
	function WndVillage_OnDrawCharacter(characterName, titleName, boneType, mybone, screenX, screenY ,bChatMessage, chatmessage,
			level, px, py, colorType, ladderlevel, bFlag, clubEmblem, icafe , Clubname , ClubTitleName , ProfileKey, bDiffTitleCheck, 
			AniTitleTick, m_matchmaking_level)
	
		-- 3 Stage Flag
		if bFlagCurrent ~= bFlag then
			bFlagStage = bFlagStage + 1
			bFlagCurrent = bFlag
			if bFlagStage > 3 then
				bFlagStage = 1
			end
		end
		
		drawer = winMgr:getWindow("DefaultWindow"):getDrawer()
		
		local is_social = string.find(chatmessage, "/")
		
		local offset = 0
		if boneType == 2 or boneType == 5 then		-- ��
			offset = 26
		elseif boneType == 1 or boneType == 4 then
			offset = 15
		end
	
		drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
		drawer:setTextColor(255,255,255,255)
		local id_width = (GetStringSize(g_STRING_FONT_GULIMCHE, 14, characterName)+38) / 2
		
		------------------------
		-- Īȣ, ����, ����, �̸�
		------------------------
		-- ��ĳ�������� Ȯ��
		-- �� ��Ƽ ���� Ȯ��
		local TitleName	= titleName
		------------------------
		-- Īȣ�̹���.	
		------------------------	
		-- Ŭ�� �̸�
		--drawer:setTextColor(255,0,0,255)
		if string.len(Clubname) > 0 then
			if TitleName > 0 then--and bDiffTitleCheck <= 0 then   -- Īȣ�� ����Ҷ�?
				common_DrawOutlineText1(drawer, Clubname , screenX+90-id_width, screenY-3+offset, 0,0,0,255, 255,100,100,255)
			else					-- Īȣ�� �������? ������
				common_DrawOutlineText1(drawer, Clubname, screenX+90-id_width, screenY+10+offset, 0,0,0,255, 255,100,100,255)
			end
		end
		
		drawer:setFont(g_STRING_FONT_GULIMCHE, 14)
		-- �̸� �� ����
		local OtherNormalColor = {['err']=0, 255,255,255}
		local MyNormalColor = {['err']=0, 81,209,100}
		local PartyColor = {['err']=0, 120,200,255}
		
		
		if colorType == 0 then	-- �׳� �Ϲ� ĳ����
			common_DrawOutlineText1(drawer, characterName, screenX+108-id_width, screenY+33+offset, 0,0,0,255, OtherNormalColor[1],OtherNormalColor[2],OtherNormalColor[3],255)
		elseif colorType == 1 then	-- �� ĳ����
			common_DrawOutlineText1(drawer, characterName, screenX+108-id_width, screenY+33+offset, 0,0,0,255, MyNormalColor[1],MyNormalColor[2],MyNormalColor[3],255)
		elseif colorType == 2 then	-- ��Ƽ ĳ����
			common_DrawOutlineText1(drawer, characterName, screenX+108-id_width, screenY+33+offset, 0,0,0,255, PartyColor[1],PartyColor[2],PartyColor[3],255)
		elseif colorType == 3 then
		end
		
		-- ���� / �������?
		-- Maxion 
		-- This function using to show rank/LV/Clan and etc that hover on the top of player character
		if bFlagStage == 1 then
			common_DrawOutlineText1(drawer, 'Lv.' ..tostring(level), screenX+62-id_width, screenY+33+offset, 0,0,0,255, 255,198,30,255) --����ǥ��			
		elseif bFlagStage == 2 then
			-- drawRank(0, screenX+57+10-id_width, screenY+20+offset, 160)
			-- Maxion Edit here Require m_matchmaking_level to link with New Rank Icon
			drawRank2(m_matchmaking_level or 0, screenX+57+0-id_width, screenY+20+offset, 160)
			-- setRankBadgeIcon("Unrank")
		elseif bFlagStage == 3 then
			drawer:drawTexture("UIData/numberUi001.tga",screenX+57-id_width, screenY+27+offset, 47, 21, 113, 600+21*ladderlevel)		--����ǥ��	
			--drawer:drawTexture("UIData/numberUi001.tga",screenX+57-id_width, screenY+27+offset, 47, 21, 113, 600+21*1)
		end
			
		------------------------
		-- Ŭ�� ������ �̹���
		------------------------
		--DebugStr('����ĳ���Ϳ�����:'..clubEmblem)
		if clubEmblem > 0 then --string.len(clubEmblem) > 0 then
			drawer:drawTextureSA(GetClubDirectory(GetLanguageType())..clubEmblem..".tga", screenX+60-id_width, screenY+1+offset, 32, 32, 0, 0, 200, 200, 255, 0, 0)	
		end
		
		if bDiffTitleCheck > 0 and ProfileKey > 0 then
			if bFlag == 1 then
				local titleIndex = TitleName - 27 
				local tTexIndexTableX = {['err']=0, [0]= 256, 320, 384, 448, 0, 256, 320, 384, 448}
				local tTexIndexTableY = {['err']=0, [0]= 0, 0, 0, 0, 0, 64, 64, 64, 64}
				drawer:drawTextureSA("UIData/numberUi002.tga", screenX+5-id_width, screenY+offset, 64, 64, tTexIndexTableX[titleIndex], tTexIndexTableY[titleIndex], 200, 200, 255, 0, 0)	
			else
				drawer:drawTextureSA("UIData/Profile/"..ProfileKey..".tga", screenX+5-id_width, screenY+offset, 64, 64, 0, 0, 200, 200, 255, 0, 0)	
			end
		elseif bDiffTitleCheck > 0 then
			local titleIndex = TitleName - 27
			local tTexIndexTableX = {['err']=0, [0]= 256, 320, 384, 448, 0, 256, 320, 384, 448}
			local tTexIndexTableY = {['err']=0, [0]= 0, 0, 0, 0, 0, 64, 64, 64, 64}
			drawer:drawTextureSA("UIData/numberUi002.tga", screenX+5-id_width, screenY+offset, 64, 64, tTexIndexTableX[titleIndex], tTexIndexTableY[titleIndex], 200, 200, 255, 0, 0)	
		else		
		------------------------
		-- �������� �̹���		
		------------------------		
			if ProfileKey > 0 then 
				drawer:drawTextureSA("UIData/Profile/"..ProfileKey..".tga", screenX+5-id_width, screenY+offset, 64, 64, 0, 0, 200, 200, 255, 0, 0)			
			end	
		end
		-- Īȣ�� ������ �ִٸ�
		if titleName > 0 then
			--DebugStr("Īȣ Īȣ Number : " .. titleName )
			if titleName == 26 then		-- Ŭ�� Īȣ
				common_DrawOutlineText1(drawer, ClubTitleName, screenX+90-id_width, screenY+15+offset, 0,0,0,255, 120,200,255,255)
			elseif #tTitleFilName >= titleName then
				drawer:drawTexture("UIData/"..tTitleFilName[titleName],screenX+88-id_width, screenY+10+offset, 110, 18, tTitleTexX[titleName], tTitleTexY[titleName])		--Ÿ��Ʋ
			elseif titleName >= 10001 then	-- �ִ� Īȣ
				drawer:drawTexture("UIData/"..tAniTitleFilName[titleName - 10001], screenX+88-id_width, screenY+10+offset, 110, 18, tAniTitleTexX[titleName - 10001], 18 * AniTitleTick)
			end
		end
		
		------------------------
		-- ����ī�� �̹���
		------------------------	
		local icafePosX = GetStringSize(g_STRING_FONT_GULIMCHE, 14, characterName)+4
		if icafe == 1 then
			drawer:drawTextureSA("UIData/LobbyImage_new.tga", screenX+108-id_width+icafePosX, screenY+25+offset, 64, 45, 729, 235, 128, 128, 255, 0, 0)	-- ���?
		
		elseif icafe == 2 then
			drawer:drawTextureSA("UIData/LobbyImage_new.tga", screenX+108-id_width+icafePosX, screenY+25+offset, 64, 45, 665, 235, 128, 128, 255, 0, 0)	-- �����̾�
		end
	end
	
	function WndVillage_OnDrawPet(petName,  petkind,  screenX, screenY, alpha, my)
		drawer = winMgr:getWindow("DefaultWindow"):getDrawer()
	
		if alpha > 255 then
			alpha = 255
		end
		
		if alpha < 0 then
			alpha = 0
		end
		
		
		--DebugStr('alpha:'..alpha)
		local offset = 0
		if petkind == 0 or petkind == 1 then		-- ��
			offset = 5
		elseif petkind == 2  then
			offset = 0
		end
	
		drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
		drawer:setTextColor(255,255,255,255)
		local id_width = (GetStringSize(g_STRING_FONT_GULIMCHE, 14, petName)+38) / 2
		
	
		drawer:setFont(g_STRING_FONT_GULIMCHE, 14)	
		-- �̸� �� ����
		local OtherNormalColor = {['err']=0, 255,255,255}
		local MyNormalColor = {['err']=0, 81,209,100}
		local PartyColor = {['err']=0, 120,200,255}
		
		if my == true then
			common_DrawOutlineText1(drawer, petName, screenX+20-id_width, screenY+offset, 0,0,0, alpha, MyNormalColor[1],MyNormalColor[2],MyNormalColor[3], alpha)
		else
			common_DrawOutlineText1(drawer, petName, screenX+20-id_width, screenY+offset, 0,0,0, alpha, OtherNormalColor[1],OtherNormalColor[2],OtherNormalColor[3], alpha)
		end
	end
	
	
	------------------------------------------------
	
	--	��ǳ�� �׸���
	
	------------------------------------------------
	function RenderBoolean(px, py, str_chat, chatBubbleType, bChange)
		local real_str_chat = str_chat;
		if string.len(real_str_chat) <= 0 then
			return
		end
		
		if 0 > chatBubbleType or chatBubbleType > MAX_CHAT_BUBBLE_NUM then
			return
		end
		
		
		if chatBubbleType == 13 or chatBubbleType == 14 then
			if bChange == 1 then
				chatBubbleType = 13
			else
				chatBubbleType = 14
			end
		end
		
		local alpha  = 255
		local UNIT   = 18									-- 1edge�� ������
		local UNIT2X = UNIT*2								-- 1edge�� ������ * 2
		local texX_L = tChatBubbleTexX[chatBubbleType]		-- �ؽ�ó ���� x��ġ
		local texY_L = tChatBubbleTexY[chatBubbleType]		-- �ؽ�ó ���� y��ġ
		local texX_R = texX_L+(UNIT*2)						-- �ؽ�ó ������ x��ġ
		local texY_R = texY_L+(UNIT*2)						-- �ؽ�ó ������ y��ġ
		local r,g,b  = GetChatBubbleColor(chatBubbleType)	-- �ؽ�Ʈ ����(0:���?, 1:������)
		local posX	 = 0									-- ��ǳ�� x��ġ
		local posY	 = tChatBubblePosY[chatBubbleType]		-- ��ǳ�� y��ġ
		local tailTexX = tChatBubbleTailTexX[chatBubbleType]
		local tailTexY = tChatBubbleTailTexY[chatBubbleType]
		local tailSizX = 18
		local tailSizY = 18
		local tailPosY = tChatBubbleTailPosY[chatBubbleType]
		local textPosY = tChatTextPosY[chatBubbleType]
		
		
		local twidth, theight = GetBooleanTextSize(real_str_chat, g_STRING_FONT_GULIMCHE, 14)
		local AREA_X = twidth
		local AREA_Y = theight
		
		-- ��� ���� �ϱ�
		local DIV_X = twidth  / UNIT
		local DIV_Y = theight / UNIT
		local X = px-(UNIT2X+UNIT+(DIV_X*UNIT))/2 + posX
		local Y = py-AREA_Y-(UNIT*3) + posY
		
		-- ������ 4����
		drawer = root:getDrawer()
		drawer:drawTextureA("UIData/gamedesign.tga", posX+X,					 posY+Y,					 UNIT, UNIT, texX_L, texY_L, alpha)-- ���� ��
		drawer:drawTextureA("UIData/gamedesign.tga", posX+X+UNIT2X+(DIV_X*UNIT), posY+Y,					 UNIT, UNIT, texX_R, texY_L, alpha)-- ������ ��
		drawer:drawTextureA("UIData/gamedesign.tga", posX+X,					 posY+Y+UNIT2X+(DIV_Y*UNIT), UNIT, UNIT, texX_L, texY_R, alpha)-- ���� �Ʒ�
		drawer:drawTextureA("UIData/gamedesign.tga", posX+X+UNIT2X+(DIV_X*UNIT), posY+Y+UNIT2X+(DIV_Y*UNIT), UNIT, UNIT, texX_R, texY_R, alpha)-- ������ �Ʒ�
		
		-- ���� ����
		for i=0, DIV_X do
			drawer:drawTextureA("UIData/gamedesign.tga", posX+X+UNIT+(i*UNIT), posY+Y,						UNIT, UNIT, texX_L+UNIT, texY_L, alpha)-- ������
			drawer:drawTextureA("UIData/gamedesign.tga", posX+X+UNIT+(i*UNIT), posY+Y+UNIT2X+(DIV_Y*UNIT),	UNIT, UNIT, texX_L+UNIT, texY_R, alpha)-- �Ʒ�����
			
			-- ���
			for j=0, DIV_Y do
				drawer:drawTextureA("UIData/gamedesign.tga", posX+X+UNIT+(i*UNIT), posY+Y+UNIT+(j*UNIT), UNIT, UNIT, texX_L+UNIT, texY_L+UNIT, alpha)
			end
		end
		
		-- ���� ����
		for i=0, DIV_Y do
			drawer:drawTextureA("UIData/gamedesign.tga", posX+X,					 posY+Y+UNIT+(i*UNIT), UNIT, UNIT, texX_L, texY_L+UNIT, alpha)-- ���ʶ���
			drawer:drawTextureA("UIData/gamedesign.tga", posX+X+UNIT2X+(DIV_X*UNIT), posY+Y+UNIT+(i*UNIT), UNIT, UNIT, texX_R, texY_L+UNIT, alpha)-- �����ʶ���
		end
		
		-- ��ǳ�� ���� �׸���
		if chatBubbleType == 0 then
			drawer:drawTextureA("UIData/gamedesign.tga", posX+X+(UNIT+(DIV_X*UNIT)/2), posY+Y+UNIT2X+(DIV_Y*UNIT)+tailPosY, tailSizX, tailSizY, tailTexX, tailTexY, alpha)
		else
			drawer:drawTextureA("UIData/gamedesign.tga", posX+X+UNIT+(DIV_X*UNIT), posY+Y+UNIT2X+(DIV_Y*UNIT)+tailPosY, tailSizX, tailSizY, tailTexX, tailTexY, alpha)
		end
		
		-- �ؽ�Ʈ �׸���
		drawer:setTextColor(r,g,b,255)
		drawer:setFont(g_STRING_FONT_GULIMCHE, 14)
		drawer:drawText(real_str_chat, X+UNIT+2, Y+UNIT+textPosY)
	end
	
	
	
	function WndVillage_OnDrawBoolean(chatMsg, posx, posy, boneType, chatBubbleType, bChange)
		local is_social = string.find(chatMsg, "/");
		if is_social then
			if is_social == 1 then
				return;
			end
		end
		local offset = 0;
		if boneType == 2 or boneType == 5 then		-- ��
			offset = 26;
		elseif boneType == 1 or boneType == 4 then
			offset = 15;
		end
		
		
		RenderBoolean(posx+67, posy+45+offset, chatMsg, chatBubbleType , bChange)
	end
	
	
	
	------------------------------------------------
	
	-- ��Ƽ �������� ������, ���ε� ���� �׸���
	
	------------------------------------------------
	function WndVillage_OnDrawPartyInfos()
		--[[
		-- ���� ���� �׸���
		if winMgr:getWindow('PartyMyInfo'):isVisible() then
			local lifeNum, coinNum = GetMyLifeAndCoin()
			
			-- ������
			local LIFE_POSX = 102
			drawer:drawTexture("UIData/dungeonmsg.tga", LIFE_POSX, 61, 18, 18, 570, 704)				-- ��Ʈ�̹���
			if lifeNum <= 0 then
				lifeNum = 0
			end
			drawer:drawTexture("UIData/dungeonmsg.tga", LIFE_POSX+19, 68, 10, 11, 503, 226)				-- X
			DrawEachNumber("UIData/dungeonmsg.tga", lifeNum, 1, LIFE_POSX+32, 66, 516, 224, 12, 14, 15)	-- ������
			
			-- ������
			drawer:drawTexture("UIData/dungeonmsg.tga", LIFE_POSX+2, 78, 13, 16, 552, 705)				-- �����̹���
			drawer:drawTexture("UIData/dungeonmsg.tga", LIFE_POSX+19, 83, 10, 11, 503, 226)				-- X
			local _left, _right = DrawEachNumber("UIData/dungeonmsg.tga", coinNum, 1, LIFE_POSX+32, 82, 516, 224, 12, 14, 15)	-- ��������
		end
		
		-- ��Ƽ������ ���� ���?
		for i=1, 3 do
			if winMgr:getWindow('PartyInfo'..i):isVisible() then
				
				local lifeNum = tonumber(winMgr:getWindow('PartyInfo'..i):getUserString("lifeNum"))
				
				-- ������
				local LIFE_POSX = (i*152)+124
				drawer:drawTexture("UIData/dungeonmsg.tga", LIFE_POSX, 61, 18, 18, 570, 704)				-- ��Ʈ�̹���
				if lifeNum <= 0 then
					lifeNum = 0
				end
				drawer:drawTexture("UIData/dungeonmsg.tga", LIFE_POSX+19, 68, 10, 11, 503, 226)				-- X
				DrawEachNumber("UIData/dungeonmsg.tga", lifeNum, 1, LIFE_POSX+32, 66, 516, 224, 12, 14, 15)	-- ������
			end
		end
		--]]
	end
	
	
	
	
	function WndVillage_OnMyPositionChange(x, y)
		zoneNumber = WndVillage_GetZoneNumber()
	end
	
	
	
	local g_nZoomX = 240;
	local g_nZoomY = 240;
	local g_PlayerAngle = 0;
	local g_PlayerX = 0;
	local g_PlayerY = 0;
	local g_minimapPathTable = {['protecterr'] = 0, "UIData/mini_map1.tga", "UIData/mini_map3.tga"}
	local g_minimapTexXTable = {['protecterr'] = 0, 380, 386}
	local g_minimapTexYTable = {['protecterr'] = 0, 353, 404}
	local g_minimapPath = "UIData/mini_map1.tga"
	local g_minimapTexX = 380
	local g_minimapTexY = 353
	
	function WndVillage_EndRender(px, py, player_angle, TownType)
		local Path = "UIData/mini_map1.tga"
		local TexX = 380
		local TexY = 353
		if 0 < TownType and TownType <= #g_minimapPathTable then
			Path = g_minimapPathTable[TownType]
			g_minimapTexX = g_minimapTexXTable[TownType]
			g_minimapTexY = g_minimapTexYTable[TownType]
		end
		g_PlayerAngle = player_angle;
		g_PlayerX = px;
		
		if TownType == 2 then
			g_PlayerY = py
		else
			g_PlayerY = py + 35;
		end
		
		g_minimapPath = Path
	end
	
	
	
	
	------------------------------------------------
	
	-- ��ü�� ��Ƽ�� ��ġǥ��
	
	------------------------------------------------
	g_tPartyMemberPx = {['protecterr'] = 0,	1000, 1000, 1000 }
	g_tPartyMemberPy = {['protecterr'] = 0,	1000, 1000, 1000 }
	
	function SetPartyMemberPosition(index, px, py)
		g_tPartyMemberPx[index + 1] = px;
		g_tPartyMemberPy[index + 1] = py + 34;
	end
	
	
	
	
	------------------------------------------------
	
	-- �̴ϸ� �׸���
	
	------------------------------------------------
	function MiniMap_EndRender(args)
	
		drawer = CEGUI.toWindowEventArgs(args).window:getDrawer();
		local mm_width = 240;
		local mm_height = 145;
		local mm_pos_x = 0; --760+10+30;
		local mm_pos_y = 0; --60+10;
		--40, 34
		local scroll_x = g_PlayerX; --GetPlayerScrollX(px, g_nZoomX, 255);
		local scroll_y = g_PlayerY; --GetPlayerScrollY(py, g_nZoomY, 255);
		-- �÷��̾ �̵��Ѹ�ŭ ��ũ�� �ϱ� ���ؼ� ���� �����? ����.
		
		local partyPosX = 0;
		local partyPosY = 0;
	--	+ 291, -PlayerY + 295
		drawer:drawTextureSA(g_minimapPath, mm_pos_x, mm_pos_y, mm_width, mm_height, g_minimapTexX-mm_width/2+scroll_x, g_minimapTexY-mm_height/2-scroll_y, g_nZoomX, g_nZoomY, 255, 2, 0);
		
		drawer:drawTextureWithScale_Angle_Offset("UIData/village.tga", mm_pos_x+mm_width/2, mm_pos_y+mm_height/2, 21, 21, 244, 390, 255, 255, 255, g_PlayerAngle, 8, 0, 0);
		for i = 1, #g_tPartyMemberPx do
			if g_tPartyMemberPx[i] ~= 1000 then
				partyPosX = -(scroll_x - g_tPartyMemberPx[i]) * g_nZoomX / 255;
				partyPosY = (scroll_y - g_tPartyMemberPy[i]) * g_nZoomX / 255;
				if (partyPosX > -(mm_width / 2) and partyPosX < (mm_width / 2) - 12) and (partyPosY > -(mm_height / 2) and partyPosY < (mm_height / 2)) then
					drawer:drawTextureSA("UIData/mainBG_Button001.tga", (mm_pos_x+mm_width/2) + partyPosX - 4, mm_pos_y+mm_height/2 + partyPosY - 3, 11, 11, 196, 980, 255, 255, 255, 2, 0);
				end
			end
		end
	
	--	drawer:drawTexture("UIData/village.tga", mm_pos_x, mm_pos_y, 200, 202, 40, 310);
	end
	
	
	
	------------------------------------------------------------------
	
	-- ���� ���� ����
	
	------------------------------------------------------------------
	g_MyStyle = GetMyStyle();
	
	g_JobSelectedWindow = nil;
	
	function OnClick_ZoomIn(args)
		if g_nZoomX < 255+100 then
			g_nZoomX = g_nZoomX + 100;
			g_nZoomY = g_nZoomY + 100;
		end
	end
	
	
	function OnClick_ZoomOut(args)
		if g_nZoomX > 255-100 then
			g_nZoomX = g_nZoomX - 100;
			g_nZoomY = g_nZoomY - 100;
		end
	end
	
	
	SetCtrlShadowBound(0, 190, 0);
	
	------------------------------------------------------------------------------------------------
	-- �̴ϸ� �ٿ���
	------------------------------------------------------------------------------------------------
	winMgr:getWindow('DefaultWindow'):addChildWindow(winMgr:getWindow('MiniMapContainer'));
	winMgr:getWindow("MiniMapContainer"):setPosition(789, 38);  -- Precreate wide ��ġ �缳��
	winMgr:getWindow('MiniMapContainer'):setAlwaysOnTop(true)
	winMgr:getWindow('MiniMapContainer'):setZOrderingEnabled(false)
	
	winMgr:getWindow('MiniMapContainer'):addChildWindow(winMgr:getWindow('MiniMapMiddleBG'));
	
	
	
	--------------------------------------------------------------------
	-- ä�� ���� ���� ���̱�
	--------------------------------------------------------------------
	root:addChildWindow(winMgr:getWindow('ChannelPositionBG'));
	winMgr:getWindow('ChannelPositionBG'):setWideType(1);
	winMgr:getWindow('ChannelPositionBG'):setPosition(800, 2);
	winMgr:getWindow('ChannelPositionBG'):setVisible(true)
	--winMgr:getWindow('ChannelPositionBG'):addChildWindow(winMgr:getWindow('ChannelPositionText'));
	winMgr:getWindow('ChannelPositionBG'):addChildWindow(winMgr:getWindow('NewMoveServerBtn'));
	winMgr:getWindow('ChannelPositionBG'):addChildWindow(winMgr:getWindow('NewMoveExitBtn'));
	winMgr:getWindow('NewMoveServerBtn'):setVisible(true)
	winMgr:getWindow('NewMoveExitBtn'):setVisible(false)
	winMgr:getWindow("chat_tab_emoticon"):setVisible(true)
	
	winMgr:getWindow('MiniMapBottomBG'):addChildWindow(winMgr:getWindow('MiniMapCloseButton'));
	winMgr:getWindow('MiniMapBottomBG'):addChildWindow(winMgr:getWindow('MiniMapOpenButton'));
	winMgr:getWindow('MiniMapContainer'):addChildWindow(winMgr:getWindow('MiniMapLineBG'));
	winMgr:getWindow('MiniMapTopBG'):setPosition(20, 0);
	winMgr:getWindow('MiniMapLineBG'):setPosition(10, 0);
	winMgr:getWindow('MiniMapMiddleBG'):setPosition(15, 5);
	
	winMgr:getWindow('MiniMapContainer'):addChildWindow(winMgr:getWindow('MiniMapZoomInButton'));
	winMgr:getWindow('MiniMapContainer'):addChildWindow(winMgr:getWindow('MiniMapZoomOutButton'));
	
	winMgr:getWindow('MiniMapZoomInButton'):setSubscribeEvent('Clicked', 'OnClick_ZoomIn');
	winMgr:getWindow('MiniMapZoomOutButton'):setSubscribeEvent('Clicked', 'OnClick_ZoomOut');
	winMgr:getWindow('MiniMapOpenButton'):setSubscribeEvent('Clicked', 'OnClicked_MiniMapOpenButton');
	winMgr:getWindow('MiniMapCloseButton'):setSubscribeEvent('Clicked', 'OnClicked_MiniMapCloseButton');
	winMgr:getWindow('MiniMapMiddleBG'):setSubscribeEvent('EndRender', 'MiniMap_EndRender');
	
	
	winMgr:getWindow('MiniMapContainer'):addChildWindow(winMgr:getWindow('ChannelPositionText'));
	winMgr:getWindow('ChannelPositionText'):setPosition(20, 118);
	
	
	winMgr:getWindow('MiniMapOpenButton'):setVisible(true);
	winMgr:getWindow('MiniMapCloseButton'):setVisible(false);
	winMgr:getWindow('MiniMapZoomInButton'):setVisible(true);
	winMgr:getWindow('MiniMapZoomOutButton'):setVisible(true);
	
	
	if CheckfacilityData(FACILITYCODE_FACEBOOKSYSTEM) == 1 then
		winMgr:getWindow('MiniMapContainer'):addChildWindow(winMgr:getWindow('FacebookButton'));
		winMgr:getWindow('FacebookButton'):setSubscribeEvent('Clicked', 'ShowFacebook');
		winMgr:getWindow('FacebookButton'):setVisible(true);
	end
	
	-- �̴ϸ� ȿ����
	--local pos = winMgr:getWindow('MiniMapBottomBG'):getPosition();
	winMgr:getWindow('MiniMapBottomBG'):clearActiveController()
	winMgr:getWindow('MiniMapMiddleBG'):clearActiveController()
	winMgr:getWindow('MiniMapTopBG'):clearActiveController()
	------------------------------------------------------------------------------------------------
	
	------------------------------------------------
	----            ���� �ʱ� ������            ----
	------------------------------------------------
	function OnClicked_MiniMapCloseButton(args)
		winMgr:getWindow('MiniMapOpenButton'):setVisible(true);
		winMgr:getWindow('MiniMapCloseButton'):setVisible(false);
		winMgr:getWindow('MiniMapZoomInButton'):setVisible(true);
		winMgr:getWindow('MiniMapZoomOutButton'):setVisible(true);
		
		if CheckfacilityData(FACILITYCODE_FACEBOOKSYSTEM) == 1 then
			winMgr:getWindow('FacebookButton'):setVisible(true);
		end
	end
	
	function OnClicked_MiniMapOpenButton(args)
		winMgr:getWindow('MiniMapOpenButton'):setVisible(false);
		winMgr:getWindow('MiniMapCloseButton'):setVisible(true);
		
		winMgr:getWindow('MiniMapBottomBG'):activeMotion('MiniMapUpMotion');
		winMgr:getWindow('MiniMapMiddleBG'):activeMotion('MiniMapUpMotion');
		winMgr:getWindow('MiniMapTopBG'):activeMotion('MiniMapUpMotion');
		winMgr:getWindow('MiniMapZoomInButton'):setVisible(false);
		winMgr:getWindow('MiniMapZoomOutButton'):setVisible(false);
		
		if CheckfacilityData(FACILITYCODE_FACEBOOKSYSTEM) == 1 then
			winMgr:getWindow('FacebookButton'):setVisible(false);
		end
	end
	
	
	
	function SettingChannelPosition(zoneName, channelName)
		
		winMgr:getWindow('ChannelPositionText'):setTextExtends(zoneName, g_STRING_FONT_GULIMCHE, 112,  255,255,255, 255,   1,   0,0,0,255);
		winMgr:getWindow('ChannelPositionText'):addTextExtends(" / ", g_STRING_FONT_GULIMCHE, 112,   255,255,255, 255,   1,   0,0,0,255);
		winMgr:getWindow('ChannelPositionText'):addTextExtends(channelName, g_STRING_FONT_GULIMCHE, 112,   255,255,255, 255,   1,   0,0,0,255);
		
	end
	
	
	--------------------------------------------------------------------
	-- ���忡�� ���콺 ���� ��ư Ŭ��
	--------------------------------------------------------------------
	function OnRootMouseButtonUp(args)
	
		ClearSelectRButtonUser()	-- ���콺 ���������� ������ ���� �̸� �ʱ�ȭ
	
		-- ���� �˾� �ʱ�ȭ
		root:removeChildWindow(winMgr:getWindow('pu_btnContainer'))
		
		-- ��Ƽ�������� ��Ƽ����, �ο� �ʱ�ȭ
		winMgr:getWindow("sjParty_Create_TypeWindow_tempImage"):setVisible(false)
		winMgr:getWindow("sjParty_Create_TypePosWindow_tempImage"):setVisible(false)
		winMgr:getWindow("sjParty_Create_NumWindow_tempImage"):setVisible(false)
		winMgr:getWindow("sjParty_Avarta_TypeWindow_tempImage"):setVisible(false)
	end
	
	
	
	--------------------------------------------------------------------
	-- ���忡�� ���콺 ������ ��ưŬ��
	--------------------------------------------------------------------
	function OnRootMouseRButtonUp(args)
	
		if winMgr:getWindow('CommonAlertAlphaImg'):isVisible() then
			return
		end
		
		if winMgr:getWindow('Popup_AlphaBackImg'):isVisible() then
			return
		end
		
		if winMgr:getWindow('sj_MyDealAlphaImage'):isVisible() then
			return
		end
		
		root:removeChildWindow(winMgr:getWindow('pu_btnContainer'))
		
		-- �����϶��� üũ ���ش�.	
		local messenger_window = winMgr:getWindow('sj_messengerBackWindow')	
		if messenger_window ~= nil then
			local messenger_visible = messenger_window:isVisible()	
			if messenger_visible == false then
				PickObjects()
			end		
		end
	end
	
	root:setSubscribeEvent("MouseButtonUp", "OnRootMouseButtonUp")
	root:setSubscribeEvent("MouseRButtonUp", "OnRootMouseRButtonUp")
	
	
	
	--------------------------------------------------------------------
	
	-- ���� ���� �����? ������ �̹���(������ ����Ŀ�Ƕ����־��µ� �ٲ���)
	
	--------------------------------------------------------------------
	--------------------------------------------------------------------
	-- �������忡�� �� ���� ����
	--------------------------------------------------------------------
	local MentTextIndex = 0;
	
	
	--------------------------------------------------------------------
	-- ���� �������� ����
	--------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_village_GuideAlpha_firstEnter")
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
	
	--------------------------------------------------------------------
	-- ���� �������� ����Ŀ�� �̹���, ��Ʈâ.
	--------------------------------------------------------------------
	tWinName	= {['protecterr'] = 0, 'sj_village_speakerman_Image', 'sj_village_speakerman_mentWindow'}
	tTexName	= {['protecterr'] = 0, 'UIData/jobchange3.tga', 'UIData/tutorial001.tga'}
	tTextureX	= {['protecterr'] = 0,    0,     0  }
	tTextureY	= {['protecterr'] = 0,    0,     0  }
	tSizeX		= {['protecterr'] = 0,  550,    1024}
	tSizeY		= {['protecterr'] = 0,  706,    229 }
	tPosX		= {['protecterr'] = 0,   0,    0  }
	tPosY		= {['protecterr'] = 0,   62,   	526 }
	
	for i=1, #tWinName do
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", tWinName[i]);
		mywindow:setTexture("Enabled", tTexName[i], 0, 0);
		mywindow:setProperty("FrameEnabled", "false");
		mywindow:setProperty("BackgroundEnabled", "false");
		mywindow:setSize(tSizeX[i],tSizeY[i]);
		mywindow:setPosition(tPosX[i], tPosY[i]);
		mywindow:setVisible(true);
		mywindow:setAlwaysOnTop(true);
		mywindow:setZOrderingEnabled(false);
		winMgr:getWindow("sj_village_GuideAlpha_firstEnter"):addChildWindow(mywindow);
	end
	
	winMgr:getWindow('sj_village_speakerman_mentWindow'):subscribeEvent('EndRender', 'renderSpkMentText');
	
	
	--------------------------------------------------------------------
	-- �������� �ؽ�Ʈ �׸���.
	--------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/StaticText", 'sj_village_text_firstEnter');
	mywindow:setProperty("FrameEnabled", "false");
	mywindow:setProperty("BackgroundEnabled", "false");
	mywindow:setPosition(120+120, 47);
	mywindow:setSize(700, 153);	
	mywindow:setAlign(0);	
	mywindow:setViewTextMode(2);
	mywindow:setLineSpacing(15);
	mywindow:clearTextExtends()
	mywindow:setVisible(true);
	mywindow:setProperty("Disabled", "true")
	winMgr:getWindow('sj_village_speakerman_mentWindow'):addChildWindow(mywindow);
	
	
	--------------------------------------------------------------------
	-- ���������? ��Ʈâ�� ��ư(space, ����enter)
	--------------------------------------------------------------------
	tWinName		= {['protecterr'] = 0, 'sj_village_passBtn_firstEnter', 'sj_village_enterBattleBtn_firstEnter'}
	tWinEventName	= {['protecterr'] = 0, 'FirstEnterButtonEnter', 'FirstEnterButtonEvent'}
	tTextureName	= {['protecterr'] = 0, 'tutorial001', 'button'}
	tWinTexX		= {['protecterr'] = 0, 874,	822}
	tWinTexY		= {['protecterr'] = 0, 372,	411}
	tWinTexTerm		= {['protecterr'] = 0, 91,	52}
	
	tWinPosX		= {['protecterr'] = 0, 828,	790}
	tWinPosY		= {['protecterr'] = 0, 130,	155}
	tWinSizeX		= {['protecterr'] = 0, 150,	202}
	tWinSizeY		= {['protecterr'] = 0, 91,	49}
	
	for i = 1, #tWinName do
		mywindow = winMgr:createWindow("TaharezLook/Button", tWinName[i])
		mywindow:setTexture("Normal", "UIData/"..tTextureName[i]..".tga", tWinTexX[i], tWinTexY[i])
		mywindow:setTexture("Hover", "UIData/"..tTextureName[i]..".tga", tWinTexX[i], tWinTexY[i]+tWinTexTerm[i])
		mywindow:setTexture("Pushed", "UIData/"..tTextureName[i]..".tga", tWinTexX[i], tWinTexY[i]+tWinTexTerm[i]*2)
		mywindow:setTexture("PushedOff", "UIData/"..tTextureName[i]..".tga", tWinTexX[i], tWinTexY[i])
		mywindow:setPosition(tWinPosX[i], tWinPosY[i])
		mywindow:setSize(tWinSizeX[i], tWinSizeY[i])
		mywindow:setVisible(false)
		mywindow:setZOrderingEnabled(false)
		mywindow:subscribeEvent("Clicked", tWinEventName[i])
		winMgr:getWindow("sj_village_speakerman_mentWindow"):addChildWindow(mywindow)
	end
	
	
	--------------------------------------------------------------------
	-- ��Ʈâ �����κ�(����Ŀ�� �̸�)
	--------------------------------------------------------------------
	function renderSpkMentText(args)
		drawer = CEGUI.toWindowEventArgs(args).window:getDrawer();
		drawer:setFont(g_STRING_FONT_DODUMCHE, 20);
		common_DrawOutlineText2(drawer, g_STRING_NPC_4.." :", 90, 47, 0,0,0,255, 255,255,0,255)
	end
	
	
	--------------------------------------------------------------------
	-- �������� ��Ʈâ ��ư �̺�Ʈ
	--------------------------------------------------------------------
	function FirstEnterButtonEnter()
		local ment_window = winMgr:getWindow('sj_village_text_firstEnter')
		CEGUI.toGUISheet(ment_window):setTextViewDelayTime(11)
		
		ment_window:clearTextExtends()
		MentTextIndex = MentTextIndex + 1;
		
		-- ��Ʈ�� ���� �Դ�.
		if #tFirstEnterText == MentTextIndex then
			-- ��Ʈ�� �����ְ� ��ư�� �ٲ��ش�.
			ment_window:addTextExtends(tFirstEnterText[MentTextIndex], g_STRING_FONT_DODUMCHE, 16, 255,255,255,255,   0, 0,0,0,255 );
			winMgr:getWindow('sj_village_passBtn_firstEnter'):setVisible(false)
			winMgr:getWindow('sj_village_enterBattleBtn_firstEnter'):setVisible(true)
			return;
		end
		
		-- ������ ��Ʈ�� �ٽ� �����ش�.
		ment_window:addTextExtends(tFirstEnterText[MentTextIndex], g_STRING_FONT_DODUMCHE, 16, 255,255,255,255,   0, 0,0,0,255 );
	
	end
	
	
	--------------------------------------------------------------------
	-- �������� �ٷ� �о�־���? ��ư �̺�Ʈ��.
	--------------------------------------------------------------------
	function FirstEnterButtonEvent()
		winMgr:getWindow("sj_village_GuideAlpha_firstEnter"):setVisible(false)
		FirstEnterEvent();
	
	end
	
	--------------------------------------------------------------------
	-- ���� �������� �̹����� �����ش�.
	--------------------------------------------------------------------
	function ShowFirstEnter()
	
		-- ȭ�鿡 �̹����� �ѷ��ش�.
		root:addChildWindow(winMgr:getWindow("sj_village_GuideAlpha_firstEnter"));
		winMgr:getWindow("sj_village_GuideAlpha_firstEnter"):setVisible(true)
		ShowfirstEnterMent()
	
	end
	
	
	--------------------------------------------------------------------
	-- ó�� ��Ʈ�� ����ش�?.
	--------------------------------------------------------------------
	function ShowfirstEnterMent()
		local ment_window = winMgr:getWindow('sj_village_text_firstEnter')
		CEGUI.toGUISheet(ment_window):setTextViewDelayTime(11)
		winMgr:getWindow('sj_village_passBtn_firstEnter'):setVisible(true)
		MentTextIndex = 1;
		
		ment_window:clearTextExtends()
		ment_window:addTextExtends(tFirstEnterText[MentTextIndex], g_STRING_FONT_DODUMCHE, 16, 255,255,255,255,   0, 0,0,0,255 );
	end
	
	
	
	--------------------------------------------------------------------
	
	-- �̴ϸ�
	
	--------------------------------------------------------------------
	function ShowMiniMap(visible)
		if visible == 0 then
			winMgr:getWindow('MiniMapContainer'):setVisible(false)
		else
			winMgr:getWindow('MiniMapContainer'):setVisible(true)
		end
		
		Util_SettingWinAlpha(tAlphaSettingWinName, 0);
		
	end
	
	function HideMultiChat()
	end
	
	-- ä��â  �ʱ�  ����
	function SetChatInitVillage()
		Chatting_SetChatWideType(2)
		Chatting_SetChatPosition(3, 462)
		Chatting_SetChatEditEvent(1)
		Chatting_SetChatTab(CHATTYPE_ALL, CHATTYPE_PARTY, CHATTYPE_PRIVATE, CHATTYPE_GANG, CHATTYPE_SYSTEM1, CHATTYPE_MEGAPHONE, CHATTYPE_EMOTICON)
	end
	
	
	
	--[[
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "bbb")
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(400, 200)
	mywindow:setSize(100, 100)
	mywindow:setVisible(true)		--false�� ����ٰ�? ���߿� 
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	root:addChildWindow(mywindow)
		
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "aaa")
		mywindow:setTexture("Enabled", "UIData/GameSlotItem001.tga", 0, 842)
		mywindow:setTexture("Disabled", "UIData/GameSlotItem001.tga", 0, 842)
		mywindow:setPosition(0, 0)
		mywindow:setSize(98, 91)
		mywindow:setVisible(false)		--false�� ����ٰ�? ���߿� 
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(true)
		mywindow:setUseEventController(false);
	--	mywindow:setScaleWidth(50);
	--	mywindow:setScaleHeight(50);
		mywindow:clearControllerEvent("aaEvent");
		mywindow:addController("aa", "aaEvent", "alpha", "Sine_EaseIn", 0, 255, 8, true, false, 10)
	--	mywindow:addController("aa", "aaEvent", "y", "Sine_EaseInOut", 54 , -100, 2, true, true, 10)
	--	mywindow:addController("aa", "aaEvent", "y", "Sine_EaseInOut", -100, 54, 2, true, true, 10)
	--	mywindow:addController("aa", "aaEvent", "y", "Sine_EaseInOut", 54, 15, 1, true, true, 10)
	--	mywindow:addController("aa", "aaEvent", "y", "Sine_EaseInOut", 15, 54, 1, true, true, 10)
	--	mywindow:addController("aa", "aaEvent", "y", "Sine_EaseInOut", 54, 45, 1, true, true, 10)
	--	mywindow:addController("aa", "aaEvent", "y", "Sine_EaseInOut", 45, 54, 1, true, true, 10)
	--	mywindow:addController("aa", "aaEvent", "y", "Sine_EaseInOut", 54, 54, 2, true, true, 10)
		winMgr:getWindow("bbb"):addChildWindow(mywindow)
		--]]
	--------------------------------------------------------------------
	
	function TestFunction()
		DebugStr(tButtonTypeNameTable[28])
		winMgr:getWindow(tButtonTypeNameTable[28]):setVisible(false)
	end
	
	--[[
	mywindow = winMgr:createWindow("TaharezLook/Editbox", "doChatting");
	mywindow:setPosition(0, 0);
	mywindow:setSize(306, 21);
	mywindow:setAlphaWithChild(0)
	mywindow:setUseEventController(false)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12);
	mywindow:setTextColor(255, 255, 255, 255);
	mywindow:setAlwaysOnTop(false);
	--mywindow:setSubscribeEvent("TextAccepted", "Chatting_OnTextAccepted1");
	mywindow:setVisible(true);
	root:addChildWindow(mywindow);
	CEGUI.toEditbox(winMgr:getWindow("doChatting")):setMaxTextLength(64)
	--CEGUI.toEditbox(winMgr:getWindow("doChatting")):setSubscribeEvent("EditboxFull", "OnTextFullEvent")
	]]--
	
	--[[
	mywindow = winMgr:createWindow("TaharezLook/Button", "��ư1")
	mywindow:setTexture("Normal", "UIData/Arcade_lobby.tga", 421, 308)
	mywindow:setTexture("Hover", "UIData/Arcade_lobby.tga", 421, 360)
	mywindow:setTexture("Pushed", "UIData/Arcade_lobby.tga", 421, 410)
	mywindow:setTexture("PushedOff", "UIData/Arcade_lobby.tga", 421, 308)
	mywindow:setWideType(7)
	mywindow:setPosition(450, 600)
	mywindow:setSize(103, 49)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", "testFunction")
	root:addChildWindow(mywindow)
	]]
	
	--------------------------------------------------------------------
	-- ĳ�� ���� ��ư�̺�Ʈ
	--------------------------------------------------------------------
	--function Common_ZombieBtnEvent()
	--	JobChangeMissionStart(6)
	--	ClickZombieWeb()
	--	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(true)
	--	root:addChildWindow(winMgr:getWindow('CommonAlertAlphaImg') );
	--end
	
	--function Common_ZombieWebClose()
	--	ZombieWebClose()
	--	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	--	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
	--end
	
	
	------------------------------------------------
	-- ������ �̺�Ʈ �����ش�.
	------------------------------------------------
	function ShowLevelUpEvent(LevelupMoney)
		RegistEscEventInfo("LevelUpEventAlpha", "LevelUpEventButtonEvent")
		RegistEnterEventInfo("LevelUpEventAlpha", "LevelUpEventButtonEvent")
		root:addChildWindow(winMgr:getWindow("LevelUpEventAlpha"))
		winMgr:getWindow("LevelUpEventAlpha"):setVisible(true)
		winMgr:getWindow("LevelUpEventRewardBack"):setUserString("LevelUpEvent", LevelupMoney)
	end
	
	
	function LevelUpEventRender(args)
		local drawer = CEGUI.toWindowEventArgs(args).window:getDrawer()
		local LevelupMoney = tonumber(CEGUI.toWindowEventArgs(args).window:getUserString("LevelUpEvent"))
		local _left = DrawEachNumber("UIData/other001.tga", LevelupMoney, 8, 195, 34, 11, 683, 24, 33, 25, drawer)
		drawer:drawTexture("UIData/other001.tga", _left-25, 35, 30, 29, 266, 685)
	end
	
		
	function LevelUpEventButtonEvent()
		winMgr:getWindow("LevelUpEventAlpha"):setVisible(false)
	end
	
	
	
	
	Util_SettingWinAlpha(tAlphaSettingWinName, 0);
	--Util_SettingWinAlpha(tAlphaSettingWinName, 255);
	
	--[[
	function Village_Debug(data)
		
		drawer = root:getDrawer();
		drawer:setTextColor(255, 255, 255, 255)
		drawer:setFont(g_STRING_FONT_GULIMCHE, 12)	
		drawer:drawText(data, 100, 20)
	end
	--]]
	
	
	
	---------------------------------------------------------------
	
	-- ���� �̺�Ʈ
	
	---------------------------------------------------------------
	-- ���� �̺�Ʈ ����â
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_village_event_alphaWindow")
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
	
	-- ���� �̺�Ʈ ����â
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_village_eventWindow")
	mywindow:setTexture("Enabled", "UIData/Startpopup.tga", 0, 60)
	mywindow:setTexture("Disabled", "UIData/Startpopup.tga", 0, 60)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(0, 0)
	mywindow:setSize(340, 270)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_village_event_alphaWindow"):addChildWindow(mywindow)
	
	-- cow suite
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_village_cowSuiteImage")
	mywindow:setTexture("Enabled", "UIData/Startpopup.tga", 0, 745)
	mywindow:setTexture("Disabled", "UIData/Startpopup.tga", 0, 745)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(26, 71)
	mywindow:setSize(116, 99)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_village_eventWindow"):addChildWindow(mywindow)
	
	
	-- ���� �̺�Ʈ �ݱ���?
	mywindow = winMgr:createWindow("TaharezLook/Button", "sj_village_eventOkBtn")
	mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
	mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
	mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
	mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 159)
	mywindow:setPosition(310, 5)
	mywindow:setSize(23, 23)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", "OpenBetaEventOKClicked")
	winMgr:getWindow("sj_village_eventWindow"):addChildWindow(mywindow)
	
	
	-- ���� �̺�Ʈ Ȯ�ι�ư
	mywindow = winMgr:createWindow("TaharezLook/Button", "sj_village_eventOkBtn2")
	mywindow:setTexture("Normal", "UIData/popup001.tga", 693, 617)
	mywindow:setTexture("Hover", "UIData/popup001.tga", 693, 646)
	mywindow:setTexture("Pushed", "UIData/popup001.tga", 693, 675)
	mywindow:setTexture("PushedOff", "UIData/popup001.tga", 693, 617)
	mywindow:setSize(331, 29)
	mywindow:setPosition(4, 234)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", "OpenBetaEventOKClicked")
	winMgr:getWindow("sj_village_eventWindow"):addChildWindow(mywindow)
	
	
	function OpenBetaEventOKClicked()
		winMgr:getWindow("sj_village_event_alphaWindow"):setVisible(false)
	end
	
	
	local tOBTEventTexX  = {["err"]=0, 0,		0,		340,	680}
	local tOBTEventTexY  = {["err"]=0, 0,		269,	0,		0}
	local tOBTEventSizeY = {["err"]=0, 270,		476,	580,	684}
	local tOBTEventPosY  = {["err"]=0, 249,		146,	94,		42}
	local tOkButtonPosY  = {["err"]=0, 235,		442,	546,	650}
	local tCowSuiteTexX  = {["err"]=0, [0]=0, 116, 232, 348, 464, 580}
	
	function ShowOpenBetaEventPopup(eventType, boneType)
		root:addChildWindow(winMgr:getWindow("sj_village_event_alphaWindow"))
		winMgr:getWindow("sj_village_event_alphaWindow"):setVisible(true)
	
		winMgr:getWindow("sj_village_eventWindow"):setTexture("Enabled", "UIData/Startpopup.tga", tOBTEventTexX[eventType], tOBTEventTexY[eventType])
		winMgr:getWindow("sj_village_eventWindow"):setTexture("Disabled", "UIData/Startpopup.tga", tOBTEventTexX[eventType], tOBTEventTexY[eventType])
		winMgr:getWindow("sj_village_eventWindow"):setPosition(342, tOBTEventPosY[eventType])
		winMgr:getWindow("sj_village_eventWindow"):setSize(340, tOBTEventSizeY[eventType])
		
		-- cow suite
		if eventType > 2 then
			winMgr:getWindow("sj_village_cowSuiteImage"):setVisible(true)
			winMgr:getWindow("sj_village_cowSuiteImage"):setTexture("Enabled", "UIData/Startpopup.tga", tCowSuiteTexX[boneType], 745)
			winMgr:getWindow("sj_village_cowSuiteImage"):setTexture("Disabled", "UIData/Startpopup.tga", tCowSuiteTexX[boneType], 745)
		else
			winMgr:getWindow("sj_village_cowSuiteImage"):setVisible(false)
		end
		
		-- Ȯ�ι�ư
		winMgr:getWindow("sj_village_eventOkBtn2"):setPosition(4, tOkButtonPosY[eventType])
	end
	
	RegistEscEventInfo("sj_village_event_alphaWindow", "OpenBetaEventOKClicked")
	
	
	
	-- dig�������� ���� �������� ����ִ�? ������(��Ʈ�ѷ�)
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "digRewardBack")
	mywindow:setTexture("Enabled", "UIData/mainBG_button002.tga", 457, 641)
	mywindow:setTexture("Disabled", "UIData/nm1.tga", 0, 0)
	mywindow:setAlign(8)
	mywindow:setPosition(0, 0)
	mywindow:setSize(52, 52)
	mywindow:setVisible(false)		--false�� ����ٰ�? ���߿� 
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:addController("digController", "DigEvent", "visible", "Sine_EaseIn", 1, 1,	15, true, false, 10)
	mywindow:addController("digController", "DigEvent", "alpha", "Sine_EaseIn", 255, 255,15, true, false, 10)
	mywindow:addController("digController", "DigEvent", "alpha", "Sine_EaseIn", 255, 0,15, true, false, 10)
	mywindow:addController("digController", "DigEvent", "xscale", "Elastic_EaseOut", 6, 255, 8, true, false, 10)
	mywindow:addController("digController", "DigEvent", "yscale", "Elastic_EaseOut", 6, 255, 8, true, false, 10)
	mywindow:setSubscribeEvent("MotionEventEnd", "DigRewardMotionEnd");
	root:addChildWindow(mywindow)
	
	-- �̹��� ������
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "digRewardImg")
	mywindow:setTexture("Enabled", "UIData/ItemUIData/Item/slot_change.tga",0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(4, 4)
	mywindow:setSize(110, 110)
	mywindow:setScaleWidth(102);
	mywindow:setScaleHeight(112);
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:setUseEventController(false)
	winMgr:getWindow('digRewardBack'):addChildWindow(mywindow)
	
	
	-- ����ũ�� ��ư
	if CheckfacilityData(FACILITYCODE_ESCROWSYSTEM) == 1 then
		mywindow = winMgr:createWindow("TaharezLook/Button", "EscrowButton")
		mywindow:setTexture("Normal", "UIData/mainbarchat.tga", 344, 588)
		mywindow:setTexture("Hover", "UIData/mainbarchat.tga", 344, 616)
		mywindow:setTexture("Pushed", "UIData/mainbarchat.tga", 344, 644)
		mywindow:setTexture("PushedOff", "UIData/mainbarchat.tga", 344, 588)
		mywindow:setTexture("Disabled", "UIData/mainbarchat.tga", 344, 672)
		mywindow:setSize(86, 28)
		--mywindow:setWideType(4);
		--mywindow:setPosition(934, 551)
		mywindow:setVisible(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:subscribeEvent("Clicked", "Escrow_Show")
		root:addChildWindow(mywindow)
	end
	
	if IsThaiLanguage() or IsEngLanguage() or IsGSPLanguage() then----0421KSG
		winMgr:getWindow("EscrowButton"):setEnabled(false)		
	end
	
	-- ���ı� ������ ����ϱ�? ��ư
	local tDigImgPosX		= {['err'] = 0, [0] = 851, 772, 772, 772}
	local tFishingImgPosX   = {['err'] = 0, [0] = 851, 772, 772, 772}
	
	mywindow = winMgr:createWindow("TaharezLook/Button", "DigItemButton")
	mywindow:setTexture("Normal", "UIData/mainbarchat.tga", 258, 588)
	mywindow:setTexture("Hover", "UIData/mainbarchat.tga", 258, 616)
	mywindow:setTexture("Pushed", "UIData/mainbarchat.tga", 258, 644)
	mywindow:setTexture("PushedOff", "UIData/mainbarchat.tga", 258, 588)
	mywindow:setTexture("Disabled", "UIData/mainbarchat.tga", 258, 672)
	mywindow:setSize(86, 28)
	--mywindow:setWideType(4);
	--mywindow:setPosition(934, 551)
	mywindow:setVisible(false)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", "DigItemButtonEvent")
	root:addChildWindow(mywindow)
	
	-- ���ı� ������ ����ϱ�? ��ư�� ������Ʈ �����ش�.
	function UpdateDigToolCheck(digtype, bZone3)
		if digtype == -1 then
			winMgr:getWindow("DigItemButton"):setVisible(false)
			return
		end
		
		if bZone3 == 2 then		-- Zone3��������.
			--[[
			winMgr:getWindow("DigItemButton"):setTexture("Normal", "UIData/fishing.tga", 0, 0)
			winMgr:getWindow("DigItemButton"):setTexture("Hover", "UIData/fishing.tga", 0, 30)
			winMgr:getWindow("DigItemButton"):setTexture("Pushed", "UIData/fishing.tga", 0, 60)
			winMgr:getWindow("DigItemButton"):setTexture("PushedOff", "UIData/fishing.tga", 0, 0)
			--]]
			--[[winMgr:getWindow("DigItemButton"):setTexture("Normal", "UIData/mainBG_button003.tga", 824, 120)
			winMgr:getWindow("DigItemButton"):setTexture("Hover", "UIData/mainBG_button003.tga", 824, 150)
			winMgr:getWindow("DigItemButton"):setTexture("Pushed", "UIData/mainBG_button003.tga", 824, 180)
			winMgr:getWindow("DigItemButton"):setTexture("PushedOff", "UIData/mainBG_button003.tga", 824, 120)]]
			winMgr:getWindow("DigItemButton"):setTexture("Normal", "UIData/mainbarchat.tga", 0, 588)
			winMgr:getWindow("DigItemButton"):setTexture("Hover", "UIData/mainbarchat.tga", 0, 616)
			winMgr:getWindow("DigItemButton"):setTexture("Pushed", "UIData/mainbarchat.tga", 0, 644)
			winMgr:getWindow("DigItemButton"):setTexture("PushedOff", "UIData/mainbarchat.tga", 0, 588)
			winMgr:getWindow("DigItemButton"):setTexture("Disabled", "UIData/mainbarchat.tga", 0, 672)
			
		else
			--[[
			winMgr:getWindow("DigItemButton"):setTexture("Normal", "UIData/mainBG_button002.tga", tDigImgPosX[digtype], 664)
			winMgr:getWindow("DigItemButton"):setTexture("Hover", "UIData/mainBG_button002.tga", tDigImgPosX[digtype], 694)
			winMgr:getWindow("DigItemButton"):setTexture("Pushed", "UIData/mainBG_button002.tga", tDigImgPosX[digtype], 724)
			winMgr:getWindow("DigItemButton"):setTexture("PushedOff", "UIData/mainBG_button002.tga", tDigImgPosX[digtype], 724)
			--]]
			--[[winMgr:getWindow("DigItemButton"):setTexture("Normal", "UIData/mainBG_button003.tga", 934, 0)
			winMgr:getWindow("DigItemButton"):setTexture("Hover", "UIData/mainBG_button003.tga", 934, 30)
			winMgr:getWindow("DigItemButton"):setTexture("Pushed", "UIData/mainBG_button003.tga", 934, 60)
			winMgr:getWindow("DigItemButton"):setTexture("PushedOff", "UIData/mainBG_button003.tga", 934, 0)]]
			winMgr:getWindow("DigItemButton"):setTexture("Normal", "UIData/mainbarchat.tga", 258, 588)
			winMgr:getWindow("DigItemButton"):setTexture("Hover", "UIData/mainbarchat.tga", 258, 616)
			winMgr:getWindow("DigItemButton"):setTexture("Pushed", "UIData/mainbarchat.tga", 258, 644)
			winMgr:getWindow("DigItemButton"):setTexture("PushedOff", "UIData/mainbarchat.tga", 258, 588)
			winMgr:getWindow("DigItemButton"):setTexture("Disabled", "UIData/mainbarchat.tga", 258, 672)
		end
		winMgr:getWindow("DigItemButton"):setVisible(true)
	end
	
	
	-- ���ı� ������ ����ϱ�? ��ư �̺�Ʈ
	function DigItemButtonEvent()
		SendUseDigTool()
	end
	
	
	-- dig�������� ���̴� ��ġ�� �����ش�.
	function SettingDigAttachPos(key, boneType, DigType)
		local a = DigAniTable[DigType][boneType][1]
		local b = DigAniTable[DigType][boneType][2]
		local c = DigAniTable[DigType][boneType][3]
		local d = DigAniTable[DigType][boneType][4]
		local e = DigAniTable[DigType][boneType][5]
		local f = DigAniTable[DigType][boneType][6]
			
		SetDigAniPos(key, a, b, c, d, e, f)
		
	end
	
	
	
	-- ���İ� �������� �޴� �������� 
	function ReceiveDigReward(itemKind, itemImageName, value, x, y)
		winMgr:getWindow("digRewardBack"):setPosition(x,y)
		winMgr:getWindow("digRewardBack"):activeMotion("DigEvent")
		winMgr:getWindow("digRewardBack"):setVisible(true)
		winMgr:getWindow("digRewardImg"):setTexture("Enabled", itemImageName, 0, 0)
	
	end
	
	-- �������� ���� �������� ��ġ�� ����ش�?.
	function SetDigRewardPos(x,y)
		winMgr:getWindow("digRewardBack"):setPosition(x + 43,y + 30)
	end
	
	
	digBooleanActionCount = 0
	function DigRewardMotionEnd(args)
		if digBooleanActionCount == 3 then	
			winMgr:getWindow("digRewardBack"):setVisible(false)
			digBooleanActionCount = 0
			return
		end	
		digBooleanActionCount = digBooleanActionCount + 1
	end
	
	
	
	-- ���� �Ĵ� ���϶� �����ִ� �������ٸ� �����ش�.
	function ShowDigGaegebar(screenX, screenY, DeltaTime, Maxtime, digtype)
	
	
		local digcount = 1
		
		if digtype == 1 then
			digcount = 1
		elseif digtype == 2 then
			digcount = 2
		elseif digtype == 3 then
			digcount = 3
		elseif digtype == 4 then
			digcount = 1
		elseif digtype == 6 then
			digcount = 2
		elseif digtype == 7 then
			digcount = 3
		end
		
		local drawer = winMgr:getWindow("DefaultWindow"):getDrawer()
		screenX = 451
		local gaegeX = 117 * DeltaTime / Maxtime
		
		if digtype <= 0 then
			drawer:drawTexture("UIData/mainBG_button002.tga", screenX, screenY, 121, 13, 540, 185, WIDETYPE_5)
			drawer:drawTexture("UIData/mainBG_button002.tga", screenX+2, screenY+2, gaegeX, 9, 542, 200, WIDETYPE_5)
			return
		end
		for i=1, digcount do
			-- ������ ����
			drawer:drawTexture("UIData/mainBG_button002.tga", screenX, screenY + ((i-1)*17), 121, 13, 540, 185, WIDETYPE_5)
			-- ������
			drawer:drawTexture("UIData/mainBG_button002.tga", screenX+2, screenY+2+((i-1)*17), gaegeX, 9, 542, 200, WIDETYPE_5)
		end
	end
	
	
	
	-- ���ı� ������ �����ش�.
	function ShowDigReward(itemImageName, itemImageName2, itemImageName3, x, y, boneType, rewardCount)
		drawer = winMgr:getWindow("DefaultWindow"):getDrawer()
		
		local tTable = {['err']=0, itemImageName, itemImageName2, itemImageName3 }
		local offset = 0
		if boneType == 2 or boneType == 5 then		-- ��
			offset = 26
		elseif boneType == 1 or boneType == 4 then
			offset = 15
		end
		local plusX = 44 - ((rewardCount-1) * 30)
		for i=1, rewardCount do
			local plusXoffset = plusX + ((i-1)*60)
			drawer:drawTextureSA("UIData/mainBG_button002.tga", x+plusXoffset, y+offset-5, 52, 52, 457, 641, 255, 255, 255, 0, 0)
			drawer:drawTextureSA(tTable[i], x+plusXoffset+4, y+offset-1, 110, 110, 0, 0, 102, 112, 255, 0, 0)
		end
	end
	--[[
	--------------------------------------------------------------------
	-- ������ ��ü ���� ����
	--------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "NoticeBackImage")
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(7, 490)
	mywindow:setSize(418, 38)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	root:addChildWindow(mywindow)
	
	--------------------------------------------------------------------
	-- ������ ��ü ���� ������ �̹���
	--------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "NoticeItemImage")
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(5,5)
	mywindow:setSize(128, 128)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("NoticeBackImage"):addChildWindow(mywindow)
	
	--------------------------------------------------------------------
	-- ������ ��ü ���� �ؽ�Ʈ �̹���
	--------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "NoticeItemText");
	mywindow:setProperty("FrameEnabled", "false");
	mywindow:setProperty("BackgroundEnabled", "false");
	mywindow:setFont(g_STRING_FONT_DODUMCHE, 12);
	mywindow:setTextColor(255, 255, 255, 255);
	mywindow:setPosition(45, 15);
	mywindow:setSize(5, 5);
	--mywindow:setText('aaaaa');
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true);
	winMgr:getWindow('NoticeBackImage'):addChildWindow(mywindow);
	
	function NoticeItemShow(NoticeText , NoticeImage)
		winMgr:getWindow("NoticeItemImage"):setScaleWidth(80)
		winMgr:getWindow("NoticeItemImage"):setScaleHeight(80)
		winMgr:getWindow("NoticeItemImage"):setTexture("Enabled", NoticeImage, 0, 0)
		winMgr:getWindow("NoticeItemImage"):setTexture("Disabled", NoticeImage, 0, 0)
		
		winMgr:getWindow("NoticeItemText"):setText(NoticeText)
	end
	--]]
	
	
	-- ���θ��? ���?
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "WndVillage_Promotion_Back")
	mywindow:setTexture("Enabled", "UIData/frame/frame_010.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/frame/frame_010.tga", 0, 0)
	mywindow:setframeWindow(true)
	mywindow:setWideType(6);
	mywindow:setPosition(167, 106)
	mywindow:setSize(690, 556)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	root:addChildWindow(mywindow)
	
	-- ���θ��? Ÿ��Ʋ
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "WndVillage_Promotion_Title")
	mywindow:setTexture("Enabled", "UIData/GameNewImage2.tga", 633, 915)
	mywindow:setTexture("Disabled", "UIData/GameNewImage2.tga", 633, 915)
	mywindow:setPosition(238, 3)
	mywindow:setSize(214, 30)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("WndVillage_Promotion_Back"):addChildWindow(mywindow)
	
	-- �ݱ���?
	mywindow = winMgr:createWindow("TaharezLook/Button", "WndVillage_Promotion_CloseBtn")
	mywindow:setTexture("Normal", "UIData/C_Button.tga", 488, 0)
	mywindow:setTexture("Hover", "UIData/C_Button.tga", 488, 22)
	mywindow:setTexture("Pushed", "UIData/C_Button.tga", 488, 44)
	mywindow:setTexture("PushedOff", "UIData/C_Button.tga", 488, 0)
	mywindow:setPosition(657, 5)
	mywindow:setSize(24, 22)
	mywindow:setZOrderingEnabled(false)
	mywindow:setSubscribeEvent("Clicked", "ClosePromotionEvent")
	winMgr:getWindow("WndVillage_Promotion_Back"):addChildWindow(mywindow)
	
	-- ���θ��? �̹���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "WndVillage_Promotion_Image")
	--mywindow:setTexture("Enabled", "UIData/gamedesign.tga", 303, 476)
	--mywindow:setTexture("Disabled", "UIData/gamedesign.tga", 303, 476)
	mywindow:setTexture("Enabled", "UIData/village_promotion02.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/village_promotion02.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(26, 55)
	--mywindow:setSize(640, 480)
	mywindow:setSize(1024, 512)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("WndVillage_Promotion_Back"):addChildWindow(mywindow)
	
	--mywindow:setScale(640/1024, 480/512)
	SetWindowScale("WndVillage_Promotion_Image", 640, 1024, 480, 512)
	
	
	function ShowPromotionEvent()
		winMgr:getWindow('WndVillage_Promotion_Back'):setVisible(true)
	end
	
	function ClosePromotionEvent(args)
		winMgr:getWindow('WndVillage_Promotion_Back'):setVisible(false)
	end
	RegistEscEventInfo("WndVillage_Promotion_Back", "ClosePromotionEvent")
	
	
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "MycharacterPosAndAngleText");
	mywindow:setFont(g_STRING_FONT_DODUMCHE, 12)
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setPosition(830, 670)
	mywindow:setSize(200, 20)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	root:addChildWindow(mywindow)
	
	-- ���� �� �ɸ����� ��ġ�� �ѷ��ش�(�׽�Ʈ����϶���?)
	function CurrentMycharacterPosAndAngle(px, py, angle)
		winMgr:getWindow('MycharacterPosAndAngleText'):setVisible(true)
		winMgr:getWindow('MycharacterPosAndAngleText'):setText("PosX  : "..px);
		winMgr:getWindow('MycharacterPosAndAngleText'):addText("\nPosY  : "..py);
		winMgr:getWindow('MycharacterPosAndAngleText'):addText("\nAngle : "..angle);
	end
	
	--------------------------------------------------------------------
	-- �����? �� ����
	--------------------------------------------------------------------
	
	
	-- �����? �� ���?
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "HuntingMapSelectBackAlpha")
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setWideType(6);
	mywindow:setPosition(50, 100)
	mywindow:setSize(1024, 592)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	root:addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "HuntingMapSelectBackImage")
	mywindow:setTexture("Enabled", "UIData/hunting_003.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/hunting_003.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(100, 0)
	mywindow:setSize(672, 592)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("HuntingMapSelectBackAlpha"):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "HuntingInCountBackImage")
	mywindow:setTexture("Enabled", "UIData/hunting_003.tga", 710, 506)
	mywindow:setTexture("Disabled", "UIData/hunting_003.tga", 710, 506)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(309, 397)
	mywindow:setSize(314, 35)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("HuntingMapSelectBackImage"):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "HuntingInCountLimitImage")
	mywindow:setTexture("Enabled", "UIData/hunting_003.tga", 816, 636)
	mywindow:setTexture("Disabled", "UIData/hunting_003.tga", 816, 636)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(278, 6)
	mywindow:setSize(18, 24)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("HuntingInCountBackImage"):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "HuntingInCountImage")
	mywindow:setTexture("Enabled", "UIData/hunting_003.tga", 726, 612)
	mywindow:setTexture("Disabled", "UIData/hunting_003.tga", 726, 612)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(240, 6)
	mywindow:setSize(18, 24)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("HuntingInCountBackImage"):addChildWindow(mywindow)
	
	function SetHuntingInCount(InCount)
		winMgr:getWindow("HuntingInCountImage"):setTexture("Enabled", "UIData/hunting_003.tga", 726 + ( 18 * InCount ), 612)
		winMgr:getWindow("HuntingInCountImage"):setTexture("Disabled", "UIData/hunting_003.tga", 726 + ( 18 * InCount ), 612)
	end
	
	
	 -----------------------------------------------------------------------
	-- �� ������ư
	-----------------------------------------------------------------------
	 
	HuntingMapRadioBtn =
	{ ["protecterr"]=0, "HuntingMapRadioBtn_1", "HuntingMapRadioBtn_2", "HuntingMapRadioBtn_3", "HuntingMapRadioBtn_4", "HuntingMapRadioBtn_5",
	--  �Ʒ���, ����, �ҹ������� ,����Ʈ , ����ö , ���?
						"HuntingMapRadioBtn_6"}
	HuntingMapBtnPosX    = {['err'] = 0, 130, 275, 330 ,150, 420, 285} 
	HuntingMapBtnPosY    = {['err'] = 0, 250, 120, 190, 70, 70 ,150}  
	HuntingMapIndex		 = {['err'] = 0, 4000, 4001, 4002, 4003, 4004, 4011}
	HuntingMapLevel		 = {['err'] = 0, 1, 10, 15 , 20, 25, 15} 
	HuntingTexturePosY   = {['err'] = 0, 592 , 677, 762 , 847, 932, 592} 
	
	for i=1, #HuntingMapRadioBtn do	
		mywindow = winMgr:createWindow("TaharezLook/RadioButton",			HuntingMapRadioBtn[i]);	
		
		UIDataFileName = "UIData/hunting_003.tga"
		if i > 5 then
			UIDataFileName = "UIData/hunting_004.tga"
		end
		mywindow:setTexture("Normal",			UIDataFileName,		0, HuntingTexturePosY[i]);
		mywindow:setTexture("Hover",			UIDataFileName,		100, HuntingTexturePosY[i]);
		mywindow:setTexture("Pushed",			UIDataFileName,		200, HuntingTexturePosY[i]);
		mywindow:setTexture("PushedOff",		UIDataFileName,		200, HuntingTexturePosY[i]);	
		mywindow:setTexture("SelectedNormal",	UIDataFileName,		200, HuntingTexturePosY[i]);
		mywindow:setTexture("SelectedHover",	UIDataFileName,		200, HuntingTexturePosY[i]);
		mywindow:setTexture("SelectedPushed",	UIDataFileName,		200, HuntingTexturePosY[i]);
		mywindow:setTexture("SelectedPushedOff",UIDataFileName,		200, HuntingTexturePosY[i]);
		mywindow:setTexture("Disabled",		    UIDataFileName,		300, HuntingTexturePosY[i]);
		mywindow:setSize(100, 85);
		mywindow:setProperty("GroupID", 0751)
		mywindow:setUserString('HuntingMapIndex', tostring(HuntingMapIndex[i]))
		mywindow:setUserString('HuntingExplainIndex', tostring(i))
		mywindow:setUserString('HuntingLevelIndex', tostring(HuntingMapLevel[i]))
		mywindow:setPosition(HuntingMapBtnPosX[i], HuntingMapBtnPosY[i]);
		mywindow:setAlwaysOnTop(true)
		mywindow:subscribeEvent("SelectStateChanged", "OnClickSelectMap");
		winMgr:getWindow('HuntingMapSelectBackImage'):addChildWindow(mywindow);
		
		if i == 1 then
			if CheckfacilityData(FACILITYCODE_HUNTING_GROUND) == 0 then
				mywindow:setVisible(false)
			end
		end
		
		if i == 2 then
			if CheckfacilityData(FACILITYCODE_HUNTING_CENTER) == 0 then
				mywindow:setVisible(false)
			end
		end
		
		if i == 3 then
			if CheckfacilityData(FACILITYCODE_HUNTING_OUTLAW) == 0 then
				mywindow:setVisible(false)
			end
		end
		
		if i == 4 then
			if CheckfacilityData(FACILITYCODE_HUNTING_HOUSE) == 0 then
				mywindow:setVisible(false)
			end
		end
		
		if i == 5 then
			if CheckfacilityData(FACILITYCODE_HUNTING_STATION) == 0 then
				mywindow:setVisible(false)
			end
		end
		
	end
	
	function ShowHuntingSelectMapUI(VillageType, FatigueCount)
		--[[if IsThaiLanguage() or IsEngLanguage() then----0421KSG
		
			local STRING_PREPARING = PreCreateString_1840	--GetSStringInfo(LAN_NOTACADE_TICKET) -- �غ����Դϴ�.
			ShowNotifyOKMessage_Lua(STRING_PREPARING)
			SetInputEnable(true)
			
			return
		end]]--
	
		if VillageType == ZONETYPECHINA then
		
			if CheckfacilityData(FACILITYCODE_HUNTING_TEMPLE) == 0 then
				return
			end
			
			winMgr:getWindow('HuntingMapSelectBackImage'):setTexture("Enabled", "UIData/hunting_004.tga", 0, 0)
			winMgr:getWindow('HuntingMapSelectBackImage'):setTexture("Disabled", "UIData/hunting_004.tga", 0, 0)
			
			for i=1, 5 do	
				winMgr:getWindow(HuntingMapRadioBtn[i]):setVisible(false)
			end
		else
			winMgr:getWindow('HuntingMapSelectBackImage'):setTexture("Enabled", "UIData/hunting_003.tga", 0, 0)
			winMgr:getWindow('HuntingMapSelectBackImage'):setTexture("Disabled", "UIData/hunting_003.tga", 0, 0)
			
			for i=6, 6 do	
				winMgr:getWindow(HuntingMapRadioBtn[i]):setVisible(false)
			end
		end
		
		GetHuntingPartyInfo()
		SetHuntingInCount(FatigueCount)
		
		root:addChildWindow(winMgr:getWindow('HuntingMapSelectBackAlpha'))
		winMgr:getWindow('HuntingMapSelectBackAlpha'):setVisible(true)
	end
	
	
	----------------------------------------------------
	--  �����? �� ���� �̹���
	----------------------------------------------------
	HuntingMapExplainImage = { ["protecterr"]=0, "HuntingMapExplain_1", "HuntingMapExplain_2", "HuntingMapExplain_3", "HuntingMapExplain_4", "HuntingMapExplain_5", "HuntingMapExplain_6"}
	
	HuntingMapExplainTexY    = {['err'] = 0, 136 , 210, 284, 358, 432 , 136}  
	
	for i=1, #HuntingMapExplainImage do	
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", HuntingMapExplainImage[i])
		
		if i > 5 then
			mywindow:setTexture("Enabled", "UIData/hunting_004.tga", 672, HuntingMapExplainTexY[i] )
			mywindow:setTexture("Disabled", "UIData/hunting_004.tga", 672, HuntingMapExplainTexY[i] )
		else
			mywindow:setTexture("Enabled", "UIData/hunting_003.tga", 672, HuntingMapExplainTexY[i] )
			mywindow:setTexture("Disabled", "UIData/hunting_003.tga", 672, HuntingMapExplainTexY[i] )
		end
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")
		mywindow:setPosition(158, 467)
		mywindow:setSize(352,74)
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow('HuntingMapSelectBackImage'):addChildWindow(mywindow)
	end
	
	----------------------------------------------------
	--  �����? �� ���� �̹���
	----------------------------------------------------
	HuntingMapTitleImage =
	{ ["protecterr"]=0, "HuntingMapTitle_1", "HuntingMapTitle_2", "HuntingMapTitle_3", "HuntingTitle_4" ,"HuntingTitle_5", "HuntingTitle_6"}
	
	HuntingMapTitleTexY    = {['err'] = 0, 592 , 613, 634, 655, 676, 592}  
	
	for i=1, #HuntingMapTitleImage do	
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", HuntingMapTitleImage[i])
		
		if i > 5 then
			mywindow:setTexture("Enabled", "UIData/hunting_004.tga", 581, HuntingMapTitleTexY[i] )
			mywindow:setTexture("Disabled", "UIData/hunting_004.tga", 581, HuntingMapTitleTexY[i] )
		else
			mywindow:setTexture("Enabled", "UIData/hunting_003.tga", 581, HuntingMapTitleTexY[i] )
			mywindow:setTexture("Disabled", "UIData/hunting_003.tga", 581, HuntingMapTitleTexY[i] )
		end
		
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")
		mywindow:setPosition(105, 400)
		mywindow:setSize(145,21)
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow('HuntingMapSelectBackImage'):addChildWindow(mywindow)
	end
	
	----------------------------------------------------
	--  �����? �� ���� �ִϸ��̼�
	----------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "HuntingSelectAniImage")
	mywindow:setTexture("Enabled", "UIData/hunting_003.tga", 440, 592)
	mywindow:setTexture("Disabled", "UIData/hunting_003.tga", 440, 592)
	mywindow:setPosition(-25, -22)
	mywindow:setSize(142, 142)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(false)
	mywindow:setAlign(8);
	mywindow:setZOrderingEnabled(false)
	mywindow:addController("SelectMotion", "SelectMotion", "angle", "Linear_EaseNone", 0, 1000, 10, true, true, 10)
	root:addChildWindow(mywindow)
	
	HunterMapIndexCount = 0
	HunterMapIndexLevel = 50
	
	function OnClickSelectMap(args)
	
		local local_window = CEGUI.toWindowEventArgs(args).window;
		if CEGUI.toRadioButton(local_window):isSelected() then
			HunterMapIndexCount = tonumber(local_window:getUserString('HuntingMapIndex'))
			HunterMapIndexLevel = tonumber(local_window:getUserString('HuntingLevelIndex'))
			--local_window:addChildWindow(winMgr:getWindow('HuntingSelectAniImage'))
			--winMgr:getWindow('HuntingSelectAniImage'):clearActiveController()
			--winMgr:getWindow('HuntingSelectAniImage'):setVisible(true)
			--winMgr:getWindow('HuntingSelectAniImage'):activeMotion('SelectMotion');
			
			ExplainIndex = tonumber(local_window:getUserString('HuntingExplainIndex'))
			for i=1, #HuntingMapExplainImage do	
				winMgr:getWindow(HuntingMapExplainImage[i]):setVisible(false)
			end
			
			for i=1, #HuntingMapTitleImage do	
				winMgr:getWindow(HuntingMapTitleImage[i]):setVisible(false)
			end
			winMgr:getWindow(HuntingMapExplainImage[ExplainIndex]):setVisible(true)
			winMgr:getWindow(HuntingMapTitleImage[ExplainIndex]):setVisible(true)
		end
	end
	
	RegistEscEventInfo("HuntingMapSelectBackAlpha", "OnClickHuntingClose")
	----------------------------------------------------------------------
	-- �����? �ʼ��� ������?
	-----------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/Button", "HuntingMapCloseBtn")
	mywindow:setTexture("Normal",		"UIData/hunting_003.tga",	998, 0)
	mywindow:setTexture("Hover",		"UIData/hunting_003.tga",	998, 21)
	mywindow:setTexture("Pushed",		"UIData/hunting_003.tga",	998, 42)
	mywindow:setTexture("PushedOff",	"UIData/hunting_003.tga",	998, 42)
	mywindow:setTexture("Disabled",		"UIData/hunting_003.tga",	998, 63)
	mywindow:setPosition(792, 17)
	mywindow:setVisible(false)
	mywindow:setSize(21, 21)
	mywindow:setSubscribeEvent("Clicked", "OnClickHuntingClose")
	winMgr:getWindow('HuntingMapSelectBackImage'):addChildWindow(mywindow)
	
	
	 -----------------------------------------------------------------------
	-- �����? �� ���� ���� ���? ��ư
	-----------------------------------------------------------------------
	 
	local HuntingMapSelectBtn = { ["protecterr"]=0, "HuntingMapSelectBtn1", "HuntingMapSelectBtn2"}
	
	local HuntingMapSelectBtnPosX    = {['err'] = 0, 445, 527 } 
	local HuntingMapSelectTexPosX    = {['err'] = 0, 830, 914 } 
	local HuntingMapSelect_BtnEvent = {["err"]=0, "OnClickHuntingStart", "OnClickHuntingClose"}
	
	for i=1, #HuntingMapSelectBtn do	
		mywindow = winMgr:createWindow("TaharezLook/Button",HuntingMapSelectBtn[i]);
		mywindow:setTexture("Normal",		"UIData/hunting_003.tga",	HuntingMapSelectTexPosX[i] , 0)
		mywindow:setTexture("Hover",		"UIData/hunting_003.tga",	HuntingMapSelectTexPosX[i], 34)
		mywindow:setTexture("Pushed",		"UIData/hunting_003.tga",	HuntingMapSelectTexPosX[i], 68)
		mywindow:setTexture("PushedOff",	"UIData/hunting_003.tga",	HuntingMapSelectTexPosX[i], 68)
		mywindow:setTexture("Disabled",		"UIData/hunting_003.tga",	HuntingMapSelectTexPosX[i], 102)
		mywindow:setPosition(HuntingMapSelectBtnPosX[i], 349)
		mywindow:setVisible(true)
		mywindow:setSize(84, 34)
		mywindow:setSubscribeEvent("Clicked", HuntingMapSelect_BtnEvent[i])
		winMgr:getWindow('HuntingMapSelectBackImage'):addChildWindow(mywindow)	
	end
	
	--------------------------------------------------------------------------------------------
	-- �����? ����, ����, ����
	--------------------------------------------------------------------------------------------
	local HuntingRewardRadioBtn = { ["protecterr"]=0, "HuntingRewardRadioCount", "HuntingRewardRadioRandom", "HuntingRewardRadioSelf"}
	local HuntingRewardRadioPosY = {["err"]=0, 466, 488, 515 }
	
	
	for i=1, #HuntingRewardRadioBtn do
		mywindow = winMgr:createWindow("TaharezLook/RadioButton", HuntingRewardRadioBtn[i])
		mywindow:setTexture("Normal", "UIData/invisible.tga", 1002, 984)
		mywindow:setTexture("Hover", "UIData/invisible.tga", 1002, 984)
		mywindow:setTexture("Pushed", "UIData/hunting_003.tga", 672, 54)
		mywindow:setTexture("PushedOff", "UIData/hunting_003.tga", 672, 54)
		
		mywindow:setTexture("SelectedNormal", "UIData/hunting_003.tga", 672, 54)
		mywindow:setTexture("SelectedHover", "UIData/hunting_003.tga", 672, 54)
		mywindow:setTexture("SelectedPushed", "UIData/hunting_003.tga", 672, 54)
		mywindow:setTexture("SelectedPushedOff", "UIData/hunting_003.tga", 672, 54)
		mywindow:setPosition(82, HuntingRewardRadioPosY[i])
		mywindow:setSize(22, 22)
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:setSubscribeEvent("SelectStateChanged", "RewardEventHandler")
		winMgr:getWindow('HuntingMapSelectBackImage'):addChildWindow(mywindow)
		--[[
		if i == 1 or i == 2 then
			mywindow:setEnabled(false)
			mywindow:setVisible(false)
		end
		--]]
	end
	
	function RewardEventHandler(args)
		--[[
		local local_window = CEGUI.toWindowEventArgs(args).window;
		if CEGUI.toRadioButton(local_window):isSelected() then
			--DebugStr('RewardEventHandler start');
			local win_name = local_window:getName();
			if win_name == 'HuntingRewardRadioCount' then 
				DebugStr('RewardEventHandler 3');
				SettingHuntingRewardType(2)
			elseif win_name == 'HuntingRewardRadioRandom' then
				DebugStr('RewardEventHandler 2');
				SettingHuntingRewardType(1)
			else
				DebugStr('RewardEventHandler 1');
				SettingHuntingRewardType(0)
			end
		end
		--]]
	end
	
	winMgr:getWindow('HuntingRewardRadioSelf'):setProperty("Selected", "true")
	
	----------------------------------------------------------------------
	-- �����? ���� �Լ�
	-----------------------------------------------------------------------
	function OnClickHuntingStart()
		if HunterMapIndexCount > 0 then
			DebugStr('HunterMapIndexCount:'..HunterMapIndexCount)
			RequestCreateHunting(HunterMapIndexCount, HunterMapIndexLevel)
		end
	end
	
	----------------------------------------------------------------------
	-- �����? �� ���� ���� �Լ�
	-----------------------------------------------------------------------
	function OnClickHuntingClose()
		winMgr:getWindow("HuntingMapSelectBackAlpha"):setVisible(false)	
		winMgr:getWindow("HuntingPartyInfoImage"):setVisible(false)	
		winMgr:getWindow('HuntingSelectAniImage'):setVisible(false)
		winMgr:getWindow("HuntingMapSelectBackImage"):setPosition(100, 0)
		SetInputEnable(true)
	end
	
	----------------------------------------------------------------------
	-- �����? �����۸���
	-----------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/Button", "itemResetBtn")
	mywindow:setTexture("Normal", "UIData/mainBG_Button002.tga", 930, 664)
	mywindow:setTexture("Hover", "UIData/mainBG_Button002.tga", 930, 664+ 47)
	mywindow:setTexture("Pushed", "UIData/mainBG_Button002.tga", 930, 664+ 47*2)
	mywindow:setTexture("PushedOff", "UIData/mainBG_Button002.tga", 930, 664+ 47*3)
	mywindow:setPosition(470, 530)
	mywindow:setSize(47, 47)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", "SetItemReset")
	root:addChildWindow(mywindow)
	
	function SetItemReset()
		ClubWarFlagChage()
	end
	
	
	
	
	
	
	
	
	
	--------------------------------------------------------------------
	-- ���� �� ����
	--------------------------------------------------------------------
	
	
	-- ���� �� ���?
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "GraveMapSelectBackAlpha")
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setWideType(6);
	mywindow:setPosition(50, 100)
	mywindow:setSize(1024, 592)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	root:addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "GraveMapSelectBackImage")
	mywindow:setTexture("Enabled", "UIData/ArcadeGrave_001.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/ArcadeGrave_001.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(100, 0)
	mywindow:setSize(672, 592)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("GraveMapSelectBackAlpha"):addChildWindow(mywindow)
	
	 -----------------------------------------------------------------------
	-- ���� �� ������ư
	-----------------------------------------------------------------------
	 
	GraveMapIndex	 = {['err'] = 0, 1006, 1007, 1008, 1009}
	GraveTexturePosX = {['err'] = 0, 0, 272, 544, 680} 
	GraveTexturePosY = {['err'] = 0, 670 , 670, 670, 384} 
	
	for i=1, #GraveMapIndex do	
	
		UIDataFileName = "UIData/ArcadeGrave_001.tga"
		
		mywindow = winMgr:createWindow("TaharezLook/RadioButton", "GraveMapRadioBtn_" .. i);	
		mywindow:setTexture("Normal",			UIDataFileName,		GraveTexturePosX[i],	 GraveTexturePosY[i]);
		mywindow:setTexture("Hover",			UIDataFileName,		GraveTexturePosX[i]+136, GraveTexturePosY[i]);
		mywindow:setTexture("Pushed",			UIDataFileName,		GraveTexturePosX[i]+136, GraveTexturePosY[i]);
		mywindow:setTexture("PushedOff",		UIDataFileName,		GraveTexturePosX[i]+136, GraveTexturePosY[i]);	
		mywindow:setTexture("SelectedNormal",	UIDataFileName,		GraveTexturePosX[i]+136, GraveTexturePosY[i]);
		mywindow:setTexture("SelectedHover",	UIDataFileName,		GraveTexturePosX[i]+136, GraveTexturePosY[i]);
		mywindow:setTexture("SelectedPushed",	UIDataFileName,		GraveTexturePosX[i]+136, GraveTexturePosY[i]);
		mywindow:setTexture("SelectedPushedOff",UIDataFileName,		GraveTexturePosX[i]+136, GraveTexturePosY[i]);
		mywindow:setTexture("Disabled",		    UIDataFileName,		GraveTexturePosX[i],	 GraveTexturePosY[i]);
		mywindow:setSize(136, 286);
		mywindow:setProperty("GroupID", 0752)
		mywindow:setUserString('GraveMapIndex', tostring(i))
		mywindow:setPosition(48 + ((i-1)*147), 77);
		mywindow:setAlwaysOnTop(true)
		mywindow:subscribeEvent("SelectStateChanged", "OnClickSelectGraveMap");
		winMgr:getWindow('GraveMapSelectBackImage'):addChildWindow(mywindow);
		
		if i > 4 then
			winMgr:getWindow("GraveMapRadioBtn_" .. i):setEnabled(false)
		end
		
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "GraveMapDifficulty" .. i)
		mywindow:setTexture("Enabled",	UIDataFileName, 694, 0 )
		mywindow:setTexture("Disabled", UIDataFileName, 694, 0 )
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")
		mywindow:setPosition(6, 239)
		mywindow:setSize(125,33)
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("GraveMapRadioBtn_" .. i):addChildWindow(mywindow)
		
		mywindow = winMgr:createWindow("TaharezLook/Button", "GraveMapDifficultyBtnLeft" .. i)
		mywindow:setTexture("Normal",	UIDataFileName, 695, 66)
		mywindow:setTexture("Hover",	UIDataFileName, 695, 97)
		mywindow:setTexture("Pushed",	UIDataFileName, 695, 128)
		mywindow:setTexture("PushedOff",UIDataFileName, 695, 66)
		mywindow:setTexture("Disabled", UIDataFileName, 695, 159)
		mywindow:setSize(31, 31)
		mywindow:setPosition(1, 1)
		mywindow:setVisible(true)
		mywindow:setEnabled(false)
		mywindow:setZOrderingEnabled(false)
		mywindow:setAlwaysOnTop(true)
	--	mywindow:subscribeEvent("Clicked", "OnClickGraveDifficultyLeft")
		winMgr:getWindow("GraveMapDifficulty" .. i):addChildWindow(mywindow)
		
		mywindow = winMgr:createWindow("TaharezLook/Button", "GraveMapDifficultyBtnRight" .. i)
		mywindow:setTexture("Normal",	UIDataFileName, 726, 66)
		mywindow:setTexture("Hover",	UIDataFileName, 726, 97)
		mywindow:setTexture("Pushed",	UIDataFileName, 726, 128)
		mywindow:setTexture("PushedOff",UIDataFileName, 726, 66)
		mywindow:setTexture("Disabled", UIDataFileName, 726, 159)
		mywindow:setSize(31, 31)
		mywindow:setPosition(93, 1)
		mywindow:setVisible(true)
		mywindow:setEnabled(false)
		mywindow:setZOrderingEnabled(false)
		mywindow:setAlwaysOnTop(true)
	--	mywindow:subscribeEvent("Clicked", "OnClickGraveDifficultyRight")
		winMgr:getWindow("GraveMapDifficulty" .. i):addChildWindow(mywindow)
		
		----------------------------------------------------
		--  ���� �� ���� �̹���
		----------------------------------------------------
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "GraveMapExplain_"..i)
		mywindow:setTexture("Enabled", "UIData/ArcadeGrave_story_001.tga", 0, 0 + ( ( i - 1 ) * 70 ) )
		mywindow:setTexture("Disabled", "UIData/ArcadeGrave_story_001.tga", 0, 0 + ( ( i - 1 ) * 70 ) )
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")
		mywindow:setPosition(80, 420)
		mywindow:setSize(512,70)
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow('GraveMapSelectBackImage'):addChildWindow(mywindow)
		
	end
	
	
	function ShowGraveSelectMapUI(VillageType)
		root:addChildWindow(winMgr:getWindow('GraveMapSelectBackAlpha'))
		winMgr:getWindow('GraveMapSelectBackAlpha'):setVisible(true)
	end
	
	
	----------------------------------------------------
	--  ���� �� ���� �ִϸ��̼�
	----------------------------------------------------
	--[[
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "GraveSelectAniImage")
	mywindow:setTexture("Enabled", "UIData/hunting_003.tga", 440, 592)
	mywindow:setTexture("Disabled", "UIData/hunting_003.tga", 440, 592)
	mywindow:setPosition(-25, -22)
	mywindow:setSize(142, 142)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(false)
	mywindow:setAlign(8);
	mywindow:setZOrderingEnabled(false)
	mywindow:addController("SelectMotion", "SelectMotion", "angle", "Linear_EaseNone", 0, 1000, 10, true, true, 10)
	root:addChildWindow(mywindow)
	]]
	
	SelectedGraveMapIndex = 0
	
	function OnClickSelectGraveMap(args)
	
		local local_window = CEGUI.toWindowEventArgs(args).window;
		if CEGUI.toRadioButton(local_window):isSelected() then
		
			SelectedGraveMapIndex = tonumber(local_window:getUserString('GraveMapIndex'))
			
			--local_window:addChildWindow(winMgr:getWindow('GraveSelectAniImage'))
			--winMgr:getWindow('GraveSelectAniImage'):clearActiveController()
			--winMgr:getWindow('GraveSelectAniImage'):setVisible(true)
			--winMgr:getWindow('GraveSelectAniImage'):activeMotion('SelectMotion');
			
			for i=1, #GraveMapIndex do	
				winMgr:getWindow("GraveMapDifficulty"..i):setVisible(false)
				winMgr:getWindow("GraveMapExplain_"..i):setVisible(false)
			end
			
			winMgr:getWindow("GraveMapExplain_"..SelectedGraveMapIndex):setVisible(true)
		--	winMgr:getWindow("GraveMapDifficulty"..SelectedGraveMapIndex):setVisible(true)
		end
	end
	
	--[[
	RegistEscEventInfo("GraveMapSelectBackImage", "OnClickGraveClose")
	----------------------------------------------------------------------
	-- ���� �ʼ��� ������?
	-----------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/Button", "GraveMapCloseBtn")
	mywindow:setTexture("Normal",		"UIData/hunting_003.tga",	998, 0)
	mywindow:setTexture("Hover",		"UIData/hunting_003.tga",	998, 21)
	mywindow:setTexture("Pushed",		"UIData/hunting_003.tga",	998, 42)
	mywindow:setTexture("PushedOff",	"UIData/hunting_003.tga",	998, 42)
	mywindow:setTexture("Disabled",		"UIData/hunting_003.tga",	998, 63)
	mywindow:setPosition(792, 17)
	mywindow:setVisible(false)
	mywindow:setSize(21, 21)
	mywindow:setSubscribeEvent("Clicked", "OnClickGraveClose")
	winMgr:getWindow('GraveMapSelectBackImage'):addChildWindow(mywindow)
	]]
	
	 -----------------------------------------------------------------------
	-- ���� �� ���� ���� ���? ��ư
	-----------------------------------------------------------------------
	 
	local GraveMapSelectBtn = { ["protecterr"]=0, "GraveMapSelectBtn1", "GraveMapSelectBtn2"}
	
	local GraveMapSelectBtnPosX    = {['err'] = 0, 247, 332 } 
	local GraveMapSelectTexPosX    = {['err'] = 0, 830, 914 } 
	local GraveMapSelect_BtnEvent = {["err"]=0, "OnClickGraveStart", "OnClickGraveClose"}
	
	for i=1, #GraveMapSelectBtn do	
		mywindow = winMgr:createWindow("TaharezLook/Button",GraveMapSelectBtn[i]);
		mywindow:setTexture("Normal",		"UIData/ArcadeGrave_001.tga",	GraveMapSelectTexPosX[i] , 0)
		mywindow:setTexture("Hover",		"UIData/ArcadeGrave_001.tga",	GraveMapSelectTexPosX[i], 34)
		mywindow:setTexture("Pushed",		"UIData/ArcadeGrave_001.tga",	GraveMapSelectTexPosX[i], 68)
		mywindow:setTexture("PushedOff",	"UIData/ArcadeGrave_001.tga",	GraveMapSelectTexPosX[i], 68)
		mywindow:setTexture("Disabled",		"UIData/ArcadeGrave_001.tga",	GraveMapSelectTexPosX[i], 102)
		mywindow:setPosition(GraveMapSelectBtnPosX[i], 515)
		mywindow:setVisible(true)
		mywindow:setSize(84, 34)
		mywindow:setSubscribeEvent("Clicked", GraveMapSelect_BtnEvent[i])
		winMgr:getWindow('GraveMapSelectBackImage'):addChildWindow(mywindow)	
	end
	
	----------------------------------------------------------------------
	-- ���� ���� �Լ�
	-----------------------------------------------------------------------
	function OnClickGraveStart()	
		if SelectedGraveMapIndex > 0 then
			DebugStr('SelectedGraveMapIndex:'..SelectedGraveMapIndex)
			RequestCreateGrave(GraveMapIndex[SelectedGraveMapIndex])
		end
	end
	
	----------------------------------------------------------------------
	-- ���� �� ���� ���� �Լ�
	-----------------------------------------------------------------------
	function OnClickGraveClose()
		SelectedGraveMapIndex = 0;
		winMgr:getWindow("GraveMapSelectBackAlpha"):setVisible(false)	
	--	winMgr:getWindow("GravePartyInfoImage"):setVisible(false)	
	--	winMgr:getWindow('GraveSelectAniImage'):setVisible(false)
	--	winMgr:getWindow("GraveMapSelectBackImage"):setPosition(100, 0)
	
		for i=1, #GraveMapIndex do	
			winMgr:getWindow("GraveMapRadioBtn_"..i):setProperty("Selected", "false")
			winMgr:getWindow("GraveMapDifficulty"..i):setVisible(false)
			winMgr:getWindow("GraveMapExplain_"..i):setVisible(false)
		end
		
		SetInputEnable(true)
	end
	
	
	
	
	
	
	
	
	
	
	
	--------------------------------------------------------------------
	
	-- ���� �Ұ� �̹���
	
	--------------------------------------------------------------------
	
	-- ���� �Ұ� ������ ����
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_villageIntroBackImage")
	mywindow:setTexture("Enabled", "UIData/Arcade_lobby.tga", 0, 746)
	mywindow:setTexture("Disabled", "UIData/Arcade_lobby.tga", 0, 746)
	mywindow:setWideType(5);
	mywindow:setPosition(0, 120)
	mywindow:setSize(1024, 138)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:addController("IntroBackEvent", "IntroBackEvent", "alpha", "Sine_EaseInOut", 0, 255, 10, false, false, 10)
	mywindow:addController("IntroBackEvent", "IntroBackEvent", "alpha", "Sine_EaseInOut", 255, 255, 20, false, false, 10)
	mywindow:addController("IntroBackEvent", "IntroBackEvent", "alpha", "Sine_EaseInOut", 255, 0, 10, false, false, 10)
	root:addChildWindow(mywindow)
	
	-- ������� ǥ��
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_villageIntroZoneImage")
	mywindow:setTexture("Enabled", "UIData/Arcade_lobby.tga", 419, 159)
	mywindow:setTexture("Disabled", "UIData/Arcade_lobby.tga", 419, 159)
	mywindow:setWideType(5);
	mywindow:setPosition(212, 135)
	mywindow:setSize(605, 109)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:addController("IntroEvent", "IntroEvent", "alpha", "Sine_EaseInOut", 0, 255, 10, false, false, 10)
	mywindow:addController("IntroEvent", "IntroEvent", "alpha", "Sine_EaseInOut", 255, 255, 20, false, false, 10)
	mywindow:addController("IntroEvent", "IntroEvent", "alpha", "Sine_EaseInOut", 255, 0, 10, false, false, 10)
	root:addChildWindow(mywindow)
	ZoneTypeNumber = 6
	
	function WndVillage_IntroduceVillage(zoneNumber)
		DebugStr('zoneNumber:'..zoneNumber)
		ZoneTypeNumber = zoneNumber
		if zoneNumber == 3 then
			winMgr:getWindow("sj_villageIntroZoneImage"):setTexture("Enabled", "UIData/Arcade_lobby.tga", 419, 159) -- 419, 226
			winMgr:getWindow("sj_villageIntroZoneImage"):setTexture("Disabled", "UIData/Arcade_lobby.tga", 419, 159)
		elseif zoneNumber == 6 then
			winMgr:getWindow("sj_villageIntroZoneImage"):setTexture("Enabled", "UIData/Arcade_lobby.tga", 419, 50) -- 419, 117
			winMgr:getWindow("sj_villageIntroZoneImage"):setTexture("Disabled", "UIData/Arcade_lobby.tga", 419, 50)
		end
		
		winMgr:getWindow("sj_villageIntroBackImage"):setVisible(true)
		winMgr:getWindow("sj_villageIntroZoneImage"):setVisible(true)
		winMgr:getWindow("sj_villageIntroBackImage"):activeMotion("IntroBackEvent")
		winMgr:getWindow("sj_villageIntroZoneImage"):activeMotion("IntroEvent")
	end
	
	-------------------------------------------------------------------
	-- ������ ���? ��ư
	--------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/Button", "ViewItemButton")
	mywindow:setTexture("Normal", "UIData/mainbarchat.tga", 86, 588)
	mywindow:setTexture("Hover", "UIData/mainbarchat.tga", 86, 616)
	mywindow:setTexture("Pushed", "UIData/mainbarchat.tga", 86, 644)
	mywindow:setTexture("PushedOff", "UIData/mainbarchat.tga", 86, 588)
	mywindow:setTexture("Disabled", "UIData/mainbarchat.tga", 86, 672)
	mywindow:setSize(86, 28)
	--mywindow:setWideType(4);
	--mywindow:setPosition(934, 615)
	mywindow:setVisible(false)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", "OnclickShowViewItem")
	root:addChildWindow(mywindow)
	
	function OnclickShowViewItem()
		
		--if winMgr:getWindow("MainBar_MyShop"):isDisabled() == false then
			winMgr:getWindow("MyshopViewBackImage"):setVisible(true)
			winMgr:getWindow("MyshopViewSearchBackImage"):setVisible(true)
		--end
	end
	
	function CheckItemViewBtnVisible(type)
		if type == 1 then
			winMgr:getWindow("ViewItemButton"):setVisible(true)
		else
			winMgr:getWindow("ViewItemButton"):setVisible(false)
			winMgr:getWindow("MyshopViewBackImage"):setVisible(false)
			winMgr:getWindow("MyshopViewSearchBackImage"):setVisible(false)
		end
	end
	
	
	----------------------------------------------------
	--  ������ ���� BackImage
	----------------------------------------------------
	-- ������ �˾� BackImage
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TipPopUpBackImageBG")
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setWideType(6)
	mywindow:setVisible(false)
	mywindow:setPosition((g_MAIN_WIN_SIZEX-764)/2, (g_MAIN_WIN_SIZEY-463)/2)
	mywindow:setSize(764, 463)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	root:addChildWindow(mywindow)
	
	-- ������ �˾� ESC
	RegistEscEventInfo("TipPopUpBackImageBG", "GameTipPopUpCancel")
	
	
	
	
	------------------------------------------------------------------------------------------------------- �ڡ�
	-- Cow Event	Cow Event		Cow Event		Cow Event		Cow Event		Cow Event
	------------------------------------------------------------------------------------------------------- �ڡ�
	local CowNumber_Six;
	local CowNumber_Five;
	local CowNumber_Four;
	local CowNumber_Three;
	local CowNumber_Two;
	local CowNumber_One;
	local CowMaxNumber;
	local WinPlayerName;
	
	local g_Cow_PosX = -1
	local g_Cow_PosY = -1
	g_Cow_PosX, g_Cow_PosY = GetWindowSize()
	local CenterX = (g_Cow_PosX / 2) - ( (118 + 213) / 2 ) -- (ų��ī�� + �ѹ�����)
	local CenterY = (g_Cow_PosY - g_Cow_PosY)
	
	local tNumberTexturePositionX	= { ['err']=0, [0]=414,153,182,211,240,269,298,327,356,385 }
	local tNumberPosition			= { ['err']=0, [0]=118,153,188,223,258,293}
	
	
	
	-- ī�� �̺�Ʈ BackImage ����
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Event_Cow_BackImg_Alpha")
	mywindow:setTexture("Enabled",	"UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setProperty("FrameEnabled", "False")
	--mywindow:setWideType(6)
	mywindow:setPosition(CenterX , CenterY)
	mywindow:setVisible(false)
	mywindow:setSize( (118+213) , 60)
	mywindow:subscribeEvent('EndRender', 'DrawCowEventCnt');
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	root:addChildWindow(mywindow)
	
	-- ī�� �̺�Ʈ BackImage
	mainWindow = winMgr:createWindow("TaharezLook/StaticImage", "Event_Cow_BackImg")
	mainWindow:setTexture("Enabled",	"UIData/mainBG_button003.tga", 548, 987)
	mainWindow:setTexture("Disabled",	"UIData/mainBG_button003.tga", 548, 987)
	mainWindow:setProperty("BackgroundEnabled", "False")
	mainWindow:setProperty("FrameEnabled", "False")
	mainWindow:setPosition(113, 4)
	mainWindow:setVisible(true)
	mainWindow:setSize(213, 37)
	mainWindow:setAlwaysOnTop(false)
	mainWindow:setZOrderingEnabled(false)
	winMgr:getWindow("Event_Cow_BackImg_Alpha"):addChildWindow(mainWindow)
	
	-- ī�� �̺�Ʈ kill the cow �̹���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Event_Kill_the_Cow_Img")
	mywindow:setTexture("Enabled",	"UIData/mainBG_button003.tga", 643, 927)
	mywindow:setTexture("Disabled", "UIData/mainBG_button003.tga", 643, 927)
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setPosition(0 , 0)
	mywindow:setVisible(true)
	mywindow:setSize(118 , 60)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("Event_Cow_BackImg_Alpha"):addChildWindow(mywindow)
	
	
	function RenderCowEventCount(nKillCount)
		-- ���� ��󳻱�?
		CowNumber_Six	= (nKillCount / 100000)
		CowNumber_Five	= (nKillCount - (CowNumber_Six*100000)) / 10000 
		CowNumber_Four	= (nKillCount - (CowNumber_Six*100000 + CowNumber_Five*10000)) / 1000
		CowNumber_Three	= (nKillCount - (CowNumber_Six*100000 + CowNumber_Five*10000 + CowNumber_Four*1000)) / 100
		CowNumber_Two	= (nKillCount - (CowNumber_Six*100000 + CowNumber_Five*10000 + CowNumber_Four*1000 + CowNumber_Three*100)) / 10
		CowNumber_One	= (nKillCount % 10)
		CowMaxNumber	= nKillCount
		
		-- ���� â ��������
		g_Cow_PosX, g_Cow_PosY = GetWindowSize()
		local x = (g_Cow_PosX / 2) - ( (118 + 213) / 2 ) -- (ų��ī�� + �ѹ�����)
		local y = (g_Cow_PosY - g_Cow_PosY)
		
		-- ��ġ �缳�� / ���� ����
		winMgr:getWindow("Event_Cow_BackImg_Alpha"):setPosition(x , y)
		winMgr:getWindow("Event_Cow_BackImg_Alpha"):setVisible(true)
	end
	
	function DrawCowEventCnt( args )
		-- ų���� �°� UI�� ������ �Ѵ�
		local drawer = CEGUI.toWindowEventArgs(args).window:getDrawer()
		ComputeKillNumberAndDraw(drawer)
	end
	
	function ComputeKillNumberAndDraw(drawer)
		-- INFOMATION :: drawTexture("���?" , ������X, ������Y, ������, ������, �ؽ���Pos, �ؽ���Pos) --
		-- 6 �ڸ���
		if CowMaxNumber >= 100000 then
			drawer:drawTexture("UIData/mainBG_button003.tga", tNumberPosition[0], 7, 29, 29, tNumberTexturePositionX[CowNumber_Six], 995)
		else
			drawer:drawTexture("UIData/mainBG_button003.tga",tNumberPosition[0], 8, 29, 29, tNumberTexturePositionX[0], 995)
		end
		
		-- 5 �ڸ���
		if CowMaxNumber >= 10000 then
			drawer:drawTexture("UIData/mainBG_button003.tga", tNumberPosition[1], 7, 29, 29, tNumberTexturePositionX[CowNumber_Five], 995)
		else
			drawer:drawTexture("UIData/mainBG_button003.tga",tNumberPosition[1], 8, 29, 29, tNumberTexturePositionX[0], 995)
		end
		
		-- 4 �ڸ���
		if CowMaxNumber >= 1000 then
			drawer:drawTexture("UIData/mainBG_button003.tga", tNumberPosition[2], 7, 29, 29, tNumberTexturePositionX[CowNumber_Four], 995)
		else
			drawer:drawTexture("UIData/mainBG_button003.tga",tNumberPosition[2], 8, 29, 29, tNumberTexturePositionX[0], 995)
		end
			
		-- 3 �ڸ���
		if CowMaxNumber >= 100 then
			drawer:drawTexture("UIData/mainBG_button003.tga", tNumberPosition[3], 7, 29, 29, tNumberTexturePositionX[CowNumber_Three], 995)
		else
			drawer:drawTexture("UIData/mainBG_button003.tga",tNumberPosition[3], 8, 29, 29, tNumberTexturePositionX[0], 995)
		end
		
		-- 2 �ڸ���
		if CowMaxNumber >= 10 then
			drawer:drawTexture("UIData/mainBG_button003.tga", tNumberPosition[4], 7, 29, 29, tNumberTexturePositionX[CowNumber_Two], 995)
		else
			drawer:drawTexture("UIData/mainBG_button003.tga",tNumberPosition[4], 8, 29, 29, tNumberTexturePositionX[0], 995)
		end
		
		-- 1 �ڸ���
		if CowMaxNumber >= 1 then
			drawer:drawTexture("UIData/mainBG_button003.tga", tNumberPosition[5], 7, 29, 29, tNumberTexturePositionX[CowNumber_One], 995)
		else
			drawer:drawTexture("UIData/mainBG_button003.tga",tNumberPosition[5], 8, 29, 29, tNumberTexturePositionX[0], 995)
		end
	end
	
	
	-- ��÷�� �ȳ� UI
	local WinPosX = -1
	local WinPosY = -1
	--local tWinPosX		= { ['err']=0, [0] = 366, 430, 495, 561, 626, 691 }
	local tWinPosX		= { ['err']=0, [0] = 10,  78,  142, 208, 273, 339, 404, 468 }
	local tTexturePosX	= { ['err']=0, [0] = 590, 629, 668, 707, 746, 785, 824, 863, 902, 941 }
	
	-- ī�� �̺�Ʈ ��÷�� ��׶���?
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Event_Cow_Win_Alpha")
	mywindow:setTexture("Enabled",	"UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("BackgroundEnabled",	"False")
	mywindow:setProperty("FrameEnabled",		"False")
	mywindow:setPosition(0 , 0)
	mywindow:setVisible(false)
	mywindow:setSize(1024 , 164)
	mywindow:subscribeEvent('EndRender', 'DrawCowEventWinPlayer');
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	root:addChildWindow(mywindow)
	
	
	
	function StartWinPlayerRender()
		winMgr:getWindow("Event_Cow_Win_Alpha"):setVisible(true)
		WinPosX , WinPosY = GetWindowSize()
		WinPosX = (WinPosX / 2) - (1024 / 2)
		WinPosY = (WinPosY - WinPosY) + 100
		winMgr:getWindow("Event_Cow_Win_Alpha"):setPosition(WinPosX , WinPosY)
	end
	
	function DrawCowEventWinPlayer( args )
		local drawer = CEGUI.toWindowEventArgs(args).window:getDrawer()
		
		------------------------------
		-- �̺�Ʈ ��÷�� ������
		------------------------------
		DrawCowEventPlayerName(drawer)
	end
	
	function DrawCowEventPlayerName( draw )
		local strName, killCnt = GetWinUserData()
		
		if strName ~= nil then
			-- 1. ���? �׸���
			--draw:drawTexture("UIData/Event001.tga", 0, 0, 1024, 164, 0, 860)
			draw:drawTexture("UIData/Event001.tga", 250, 20, 517, 81, 0, 811)
			
			-- 2. �ѹ� �׸���
			local Six , Five , Four , Three , Two , One = ComputeDetachNumber(killCnt)
			draw:drawTexture("UIData/Event001.tga", tWinPosX[0], 57, 39, 60, tTexturePosX[0],		224)
			draw:drawTexture("UIData/Event001.tga", tWinPosX[1], 57, 39, 60, tTexturePosX[0],		224)
			
			draw:drawTexture("UIData/Event001.tga", tWinPosX[2], 57, 39, 60, tTexturePosX[Six],		224)
			draw:drawTexture("UIData/Event001.tga", tWinPosX[3], 57, 39, 60, tTexturePosX[Five],	224)
			draw:drawTexture("UIData/Event001.tga", tWinPosX[4], 57, 39, 60, tTexturePosX[Four],	224)
			draw:drawTexture("UIData/Event001.tga", tWinPosX[5], 57, 39, 60, tTexturePosX[Three],	224)
			draw:drawTexture("UIData/Event001.tga", tWinPosX[6], 57, 39, 60, tTexturePosX[Two],		224)
			draw:drawTexture("UIData/Event001.tga", tWinPosX[7], 57, 39, 60, tTexturePosX[One],		224)
			
			-- 3. ���� ����
			draw:setTextColor(255,255,255,255)
			draw:setFont(g_STRING_FONT_GULIMCHE, 112)
			draw:drawText(strName, (1024/2)-150 , (768/2) - 250)
		end
	end
	
	function CloseWinCowEvent()
		winMgr:getWindow("Event_Cow_Win_Alpha"):setVisible(false)
	end
	
	-- ���� �������� �߶󳻴� �Լ�
	function ComputeDetachNumber( killCount )
		local Six	= (killCount / 100000)
		local Five	= (killCount - (Six*100000)) / 10000 
		local Four	= (killCount - (Six*100000 + Five*10000)) / 1000
		local Three	= (killCount - (Six*100000 + Five*10000 + Four*1000)) / 100
		local Two	= (killCount - (Six*100000 + Five*10000 + Four*1000 + Three*100)) / 10
		local One	= (killCount % 10)
		
		return Six , Five , Four , Three , Two , One
	end
	
	
	-- �̺�Ʈ ����
	function EndKillTheCowEvent()
		winMgr:getWindow("Event_Cow_Win_Alpha"):setVisible(false)
		winMgr:getWindow("Event_Cow_BackImg_Alpha"):setVisible(false)
	end
	
	
	-- ���� �̺�Ʈ
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Event_Hidden_BackImg_Alpha")
	mywindow:setTexture("Enabled",	"UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setPosition(CenterX , CenterY)
	mywindow:setVisible(true)
	mywindow:setSize( (118+213) , 60)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	root:addChildWindow(mywindow)
	
	mainWindow = winMgr:createWindow("TaharezLook/StaticImage", "Event_Hidden_BackImg")
	mainWindow:setTexture("Enabled",	"UIData/mainBG_button003.tga", 548, 987)
	mainWindow:setTexture("Disabled",	"UIData/mainBG_button003.tga", 548, 987)
	mainWindow:setProperty("BackgroundEnabled", "False")
	mainWindow:setProperty("FrameEnabled", "False")
	mainWindow:setPosition(113, 4)
	mainWindow:setVisible(true)
	mainWindow:setSize(213, 37)
	mainWindow:setAlwaysOnTop(false)
	mainWindow:setZOrderingEnabled(false)
	winMgr:getWindow("Event_Hidden_BackImg_Alpha"):addChildWindow(mainWindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Event_Kill_the_Hidden_Img")					
	mywindow:setTexture("Enabled",	"UIData/Arcade_2stage.tga", 328, 389)
	mywindow:setTexture("Disabled", "UIData/Arcade_2stage.tga", 328, 389)
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setPosition(75 , -5)
	mywindow:setVisible(true)
	mywindow:setSize(50 , 50)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("Event_Hidden_BackImg_Alpha"):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Event_Kill_the_Hidden_Img_grave1")					
	mywindow:setTexture("Enabled",	"UIData/Arcade_7stage_1.tga", 328, 389)
	mywindow:setTexture("Disabled", "UIData/Arcade_7stage_1.tga", 328, 389)
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setPosition(-5 , -5)
	mywindow:setVisible(false)
	mywindow:setSize(50 , 50)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("Event_Hidden_BackImg_Alpha"):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Event_Kill_the_Hidden_Img_grave2")					
	mywindow:setTexture("Enabled",	"UIData/Arcade_7stage_2.tga", 328, 389)
	mywindow:setTexture("Disabled", "UIData/Arcade_7stage_2.tga", 328, 389)
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setPosition(35 , -5)
	mywindow:setVisible(false)
	mywindow:setSize(50 , 50)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("Event_Hidden_BackImg_Alpha"):addChildWindow(mywindow)
	
	
	
	for i = 0, 5 do
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Event_Kill_the_Hidden_Count_Img"..i)
		mywindow:setTexture("Enabled",	"UIData/mainBG_button003.tga", 414, 995)
		mywindow:setTexture("Disabled", "UIData/mainBG_button003.tga", 414, 995)
		mywindow:setProperty("BackgroundEnabled", "False")
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setPosition(5 + ( i * 35 ), 4)
		mywindow:setVisible(true)
		mywindow:setSize(29 , 29)
		mywindow:setAlwaysOnTop(false)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("Event_Hidden_BackImg"):addChildWindow(mywindow)
	end	
	
	local tHiddenTexturePositionX	= { ['err']=0, [0]=414,153,182,211,240,269,298,327,356,385 }
	
	function RenderHiddenEventCount(nKillCount)		
	
		if nKillCount == 0 then
			winMgr:getWindow("Event_Kill_the_Hidden_Img"):setTexture("Enabled",  "UIData/Arcade_2stage.tga", 328, 389)	
		end	
		
		if nKillCount > 0 and nKillCount < 150000 then																					-- hotel
			winMgr:getWindow("Event_Kill_the_Hidden_Img"):setTexture("Enabled",  "UIData/Arcade_2stage.tga", 328, 389)		
			nKillCount = nKillCount % 150000
		elseif nKillCount >= 150000 and nKillCount < 300000 then																		-- Halem
			winMgr:getWindow("Event_Kill_the_Hidden_Img"):setTexture("Enabled",  "UIData/Arcade_3stage.tga", 328, 389)	
			nKillCount = nKillCount % 150000
		elseif nKillCount >= 300000 and nKillCount < 450000 then																		-- H.Road
			winMgr:getWindow("Event_Kill_the_Hidden_Img"):setTexture("Enabled",  "UIData/Arcade_4stage.tga", 328, 389)	
			nKillCount = nKillCount % 150000
		elseif nKillCount >= 450000 and nKillCount < 600000 then																		-- Subway
			winMgr:getWindow("Event_Kill_the_Hidden_Img"):setTexture("Enabled",  "UIData/Arcade_5stage.tga", 328, 389)	
			nKillCount = nKillCount % 150000
		elseif nKillCount >= 600000 and nKillCount < 750000 then																		-- Temple
			winMgr:getWindow("Event_Kill_the_Hidden_Img"):setTexture("Enabled",  "UIData/Arcade_6stage.tga", 328, 389)	
			nKillCount = nKillCount % 150000
		elseif nKillCount >= 750000 and nKillCount < 900000 then																		-- Grave
			winMgr:getWindow("Event_Kill_the_Hidden_Img"):setTexture("Enabled",  "UIData/Arcade_7stage_3.tga", 328, 389)	
			winMgr:getWindow("Event_Kill_the_Hidden_Img_grave1"):setVisible(true)
			winMgr:getWindow("Event_Kill_the_Hidden_Img_grave2"):setVisible(true)
			nKillCount = nKillCount % 150000
		end		
	
		if nKillCount > 0 then
			if (nKillCount % 150000) == 0 then
				nKillCount = 150000	
			end
		end
	
		-- ���� ��󳻱�?
		local Number_Six	= (nKillCount / 100000)
		local Number_Five	= (nKillCount - (Number_Six*100000)) / 10000 
		local Number_Four	= (nKillCount - (Number_Six*100000 + Number_Five*10000)) / 1000
		local Number_Three	= (nKillCount - (Number_Six*100000 + Number_Five*10000 + Number_Four*1000)) / 100
		local Number_Two	= (nKillCount - (Number_Six*100000 + Number_Five*10000 + Number_Four*1000 + Number_Three*100)) / 10
		local Number_One	= (nKillCount % 10)
		
		local tCount	= { ['err']=0, [0] = Number_Six, Number_Five, Number_Four, Number_Three, Number_Two, Number_One }
		
		for i = 0, 5 do
			winMgr:getWindow("Event_Kill_the_Hidden_Count_Img"..i):setTexture("Enabled",  "UIData/mainBG_button003.tga", tHiddenTexturePositionX[tCount[i]], 995)
			winMgr:getWindow("Event_Kill_the_Hidden_Count_Img"..i):setTexture("Disabled", "UIData/mainBG_button003.tga", tHiddenTexturePositionX[tCount[i]], 995)
		end
	end
	
	function StartHiddenEvent()
		winMgr:getWindow("Event_Hidden_BackImg_Alpha"):setVisible(true)
	end
	
	function CloseHiddenEvent()
		winMgr:getWindow("Event_Hidden_BackImg_Alpha"):setVisible(false)
	end
	
	-- ���� ���� ��÷��
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Event_Hidden_Winner_BackImg")
	mywindow:setTexture("Enabled", "UIData/dungeonmsg.tga", 0, 509)
	mywindow:setTexture("Disabled", "UIData/dungeonmsg.tga", 0, 509)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition((g_Cow_PosX / 2) - ( 1024 / 2 ), 100)
	mywindow:setSize(1024, 157)
	mywindow:setZOrderingEnabled(true)
	mywindow:setVisible(false)
	root:addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Event_Hidden_Winner_Img")
	mywindow:setTexture("Enabled",	"UIData/Event001.tga", 0, 811)
	mywindow:setTexture("Disabled",	"UIData/Event001.tga", 0, 811)
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setPosition(250, 20)
	mywindow:setVisible(true)
	mywindow:setSize(517, 81)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("Event_Hidden_Winner_BackImg"):addChildWindow(mywindow)
	
		
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "Event_Hidden_Winner_Name")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 20)
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setPosition(305, 110)
	mywindow:setSize(150, 10)
	winMgr:getWindow("Event_Hidden_Winner_BackImg"):addChildWindow(mywindow)
		
	
	local tWinner_PosX		= { ['err']=0, [0] = 10, 78, 142, 208, 273, 339, 404, 468 }
	local tWinner_Text_PosX	= { ['err']=0, [0] = 590, 629, 668, 707, 746, 785, 824, 863, 902, 941 }
	
	for i = 0, #tWinner_PosX do
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Event_Kill_the_Hidden_Winner_Count_Img"..i)
		mywindow:setTexture("Enabled",	"UIData/Event001.tga", 590, 224)
		mywindow:setTexture("Disabled", "UIData/Event001.tga", 590, 224)
		mywindow:setProperty("BackgroundEnabled", "False")
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setPosition(tWinner_PosX[i], 10)
		mywindow:setVisible(true)
		mywindow:setSize(39 , 60)
		mywindow:setAlwaysOnTop(false)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("Event_Hidden_Winner_Img"):addChildWindow(mywindow)
	end	
	
	function SetWinnerNotify(Text, nKillCount)
	
		local size = GetStringSize(g_STRING_FONT_GULIMCHE, 20, Text)
			
		winMgr:getWindow("Event_Hidden_Winner_BackImg"):setVisible(true)
		winMgr:getWindow("Event_Hidden_Winner_Name"):setText(Text)
		winMgr:getWindow("Event_Hidden_Winner_Name"):setPosition(508 - (size / 2), 110)
		
		if nKillCount == 0 then
			winMgr:getWindow("Event_Kill_the_Hidden_Img"):setTexture("Enabled",  "UIData/Arcade_2stage.tga", 328, 389)	
		end
		
		if nKillCount > 0 and nKillCount < 150000 then																					-- hotel
			winMgr:getWindow("Event_Kill_the_Hidden_Img"):setTexture("Enabled",  "UIData/Arcade_2stage.tga", 328, 389)		
			nKillCount = nKillCount % 150000
		elseif nKillCount >= 150000 and nKillCount < 300000 then																		-- Halem
			winMgr:getWindow("Event_Kill_the_Hidden_Img"):setTexture("Enabled",  "UIData/Arcade_3stage.tga", 328, 389)	
			nKillCount = nKillCount % 150000
		elseif nKillCount >= 300000 and nKillCount < 450000 then																		-- H.Road
			winMgr:getWindow("Event_Kill_the_Hidden_Img"):setTexture("Enabled",  "UIData/Arcade_4stage.tga", 328, 389)	
			nKillCount = nKillCount % 150000
		elseif nKillCount >= 450000 and nKillCount < 600000 then																		-- Subway
			winMgr:getWindow("Event_Kill_the_Hidden_Img"):setTexture("Enabled",  "UIData/Arcade_5stage.tga", 328, 389)	
			nKillCount = nKillCount % 150000
		elseif nKillCount >= 600000 and nKillCount < 750000 then																		-- Temple
			winMgr:getWindow("Event_Kill_the_Hidden_Img"):setTexture("Enabled",  "UIData/Arcade_6stage.tga", 328, 389)	
			nKillCount = nKillCount % 150000
		elseif nKillCount >= 750000 and nKillCount < 900000 then																		-- Grave
			winMgr:getWindow("Event_Kill_the_Hidden_Img"):setTexture("Enabled",  "UIData/Arcade_7stage_3.tga", 328, 389)	
			winMgr:getWindow("Event_Kill_the_Hidden_Img_grave1"):setVisible(true)
			winMgr:getWindow("Event_Kill_the_Hidden_Img_grave2"):setVisible(true)
			nKillCount = nKillCount % 150000
		end
		
		if nKillCount > 0 then
			if (nKillCount % 150000) == 0 then
				nKillCount = 150000	
			end
		end
		
		-- ���� ��󳻱�?
		local Number_Eight  = 0
		local Number_Seven  = 0
		local Number_Six	= (nKillCount / 100000)
		local Number_Five	= (nKillCount - (Number_Six*100000)) / 10000 
		local Number_Four	= (nKillCount - (Number_Six*100000 + Number_Five*10000)) / 1000
		local Number_Three	= (nKillCount - (Number_Six*100000 + Number_Five*10000 + Number_Four*1000)) / 100
		local Number_Two	= (nKillCount - (Number_Six*100000 + Number_Five*10000 + Number_Four*1000 + Number_Three*100)) / 10
		local Number_One	= (nKillCount % 10)
		
		local tCount	= { ['err']=0, [0] = Number_Eight, Number_Seven, Number_Six, Number_Five, Number_Four, Number_Three, Number_Two, Number_One }
		
		for i = 0, 7 do
			winMgr:getWindow("Event_Kill_the_Hidden_Winner_Count_Img"..i):setTexture("Enabled",  "UIData/Event001.tga", tWinner_Text_PosX[tCount[i]], 224)
			winMgr:getWindow("Event_Kill_the_Hidden_Winner_Count_Img"..i):setTexture("Disabled", "UIData/Event001.tga", tWinner_Text_PosX[tCount[i]], 224)
		end
	end
	
	function CloseWinnerNotify()
		winMgr:getWindow("Event_Hidden_Winner_BackImg"):setVisible(false)
	end
	
	
	------------------------------------------------
	-------------- ������ �ٲٱ� -------------------
	------------------------------------------------
	local CheckEmblemInCheck = false
	
	-- �������ٲٱ� ����â
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ChangeAmblemAlpha")
	mywindow:setTexture("Enabled",	"UIData/OnDLGBackImage.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
	mywindow:setPosition(0, 0)
	mywindow:setSize(1920, 1200)
	mywindow:setVisible(false)	
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	root:addChildWindow(mywindow)
	
	RegistEscEventInfo("ChangeAmblemAlpha", "ChangeAmblemCancelEvent")
	RegistEnterEventInfo("ChangeAmblemAlpha", "ChangeAmblemRegistEvent")
	
	
	--  �������ٲٱ� �����̹���.
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ChangeAmblemMain")
	mywindow:setTexture("Enabled", "UIData/fightClub_003.tga", 0, 468)
	mywindow:setTexture("Disabled", "UIData/fightClub_003.tga", 0, 468)
	mywindow:setPosition((g_MAIN_WIN_SIZEX - 340) / 2, (g_MAIN_WIN_SIZEY - 153) / 2)
	mywindow:setSize(340, 153)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	winMgr:getWindow("ChangeAmblemAlpha"):addChildWindow(mywindow)
	
	
	--  �������ٲٱ� �������̹���.
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
	
	
	
	-- �������ٲٱ� ��ư
	mywindow = winMgr:createWindow("TaharezLook/Button", "ChangeAmblemButton")
	mywindow:setTexture("Normal",	"UIData/fightClub_001.tga", 111, 471)
	mywindow:setTexture("Hover",	"UIData/fightClub_001.tga", 111, 492)
	mywindow:setTexture("Pushed",	"UIData/fightClub_001.tga", 111, 513)
	mywindow:setTexture("Disabled", "UIData/fightClub_001.tga", 111, 534)
	mywindow:setPosition(223, 52)
	mywindow:setSize(111, 21)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", "ChangeAmblemButtonEvent")
	winMgr:getWindow("ChangeAmblemMain"):addChildWindow(mywindow)
	
	
	-- �ٲٱ� ��ư
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
	
	
	local g_EmbleSlotIndex = -1
	
	-- ������ �ٲٴ� â�� ����ش�?.
	function ShowChangeAmblemWin( slot )
		root:addChildWindow(winMgr:getWindow("ChangeAmblemAlpha"))
		winMgr:getWindow("ChangeAmblemAlpha"):setVisible(true)
		winMgr:getWindow("ChangeAmblemImg"):setTexture("Enabled", "UIData/invisible.tga", 0, 0)
		winMgr:getWindow("ChangeAmblemImg"):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		winMgr:getWindow("ChangeAmblemEdit"):setText("basic.tga")
		CheckEmblemInCheck	= false
		g_EmbleSlotIndex	= slot
	end
	
	
	-- ã�ƺ��� ��ư �̺�Ʈ
	function ChangeAmblemButtonEvent(args)
		DebugStr("ã�ƺ��� ��ư : ����~")
		local Edit = winMgr:getWindow("ChangeAmblemEdit"):getText()
		ChangeEmblem(Edit)
	end
	
	
	-- �������̹����� �����Ѵ�.
	function SetAmblemImage(ImageName)
		CheckEmblemInCheck = true
		winMgr:getWindow("ChangeAmblemImg"):setTexture("Enabled", ImageName, 0, 0)
		winMgr:getWindow("ChangeAmblemImg"):setTexture("Disabled", ImageName, 0, 0)
	end
	
	
	
	-- ���? ��ư �̺�Ʈ
	function ChangeAmblemRegistEvent(args)
		if CheckEmblemInCheck == false then
			--ShowNotifyOKMessage_Lua(MR_String_80)
			
			-- �ӽ÷� ���� �����?.
			ShowNotifyOKMessage_Lua("�������� ������ּ���?")
			return
		end
		winMgr:getWindow("ChangeAmblemImg"):setTexture("Enabled", "UIData/invisible.tga", 0, 0)
		winMgr:getWindow("ChangeAmblemImg"):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		winMgr:getWindow("ChangeAmblemAlpha"):setVisible(false)
	
		SendChangeEmblem(g_EmbleSlotIndex)
	end
	
	
	-- ���? ��ư �̺�Ʈ
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
	
	
	
	
	
	
	--==============================================================================================
	--								���� �׽�Ʈ ��ư On/Off
	--==============================================================================================
	local TestBtnViewFlag = 0
	
	if TestBtnViewFlag == 1 then
		--------------------------------------------------------------------
		-- ���� �׽�Ʈ ��ư 1
		--------------------------------------------------------------------
		mywindow = winMgr:createWindow("TaharezLook/Button", "Start_CutBtn")
		mywindow:setTexture("Normal",	"UIData/channel_001.tga", 936, 676)
		mywindow:setTexture("Hover",	"UIData/channel_001.tga", 936, 701)
		mywindow:setTexture("Pushed",	"UIData/channel_001.tga", 936, 726)
		mywindow:setTexture("PushedOff","UIData/channel_001.tga", 936, 676)
		mywindow:setWideType(2);
		mywindow:setPosition(10, 400)
		mywindow:setSize(88, 25)
		mywindow:setAlwaysOnTop(true)
		mywindow:setVisible(true)
		mywindow:subscribeEvent("Clicked", "TestFunc")
		root:addChildWindow(mywindow)
		function TestFunc()
			UseCreateCloneAvatarItem()
		end
		
		
		--------------------------------------------------------------------
		-- ���� �׽�Ʈ ��ư 2
		--------------------------------------------------------------------
		mywindow = winMgr:createWindow("TaharezLook/Button", "Test_Start_CutBtn")
		mywindow:setTexture("Normal", "UIData/channel_001.tga", 936, 676)
		mywindow:setTexture("Hover", "UIData/channel_001.tga", 936, 701)
		mywindow:setTexture("Pushed", "UIData/channel_001.tga", 936, 726)
		mywindow:setTexture("PushedOff", "UIData/channel_001.tga", 936, 676)
		mywindow:setWideType(2);
		mywindow:setPosition(10, 430)
		mywindow:setSize(88, 25)
		mywindow:setAlwaysOnTop(true)
		mywindow:setVisible(true)
		mywindow:subscribeEvent("Clicked", "TestFunc2")
		root:addChildWindow(mywindow)
		function TestFunc2()
		
			GoDefenceMode();	-- ���潺 ���? ����
			
		end
		
	end	-- end of TestBtnViewFlag == 1 then
	--==============================================================================================
	
	
	
	
	
	
	-- ���� ���۽� �˾� ����?��
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ZombieSelectBackImage")
	mywindow:setTexture("Enabled", "UIData/hunting_005.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/hunting_005.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setWideType(6);
	mywindow:setPosition(50, 100)
	mywindow:setSize(672, 592)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	root:addChildWindow(mywindow)
	
	RegistEscEventInfo("ZombieSelectBackImage", "OnClickZombieClose")
	
	local ZombieSelectBtnPosX    = {['err'] = 0, 445, 527 } 
	local ZombieSelectTexPosX    = {['err'] = 0, 830, 914 } 
	local ZombieSelect_BtnEvent = {["err"]=0, "OnClickZombieStart", "OnClickZombieClose"}
	
	for i=1, #ZombieSelect_BtnEvent do
		mywindow = winMgr:createWindow("TaharezLook/Button","ZombieSelectBtn"..i);
		mywindow:setTexture("Normal",		"UIData/hunting_003.tga",	ZombieSelectTexPosX[i] , 0)
		mywindow:setTexture("Hover",		"UIData/hunting_003.tga",	ZombieSelectTexPosX[i], 34)
		mywindow:setTexture("Pushed",		"UIData/hunting_003.tga",	ZombieSelectTexPosX[i], 68)
		mywindow:setTexture("PushedOff",	"UIData/hunting_003.tga",	ZombieSelectTexPosX[i], 68)
		mywindow:setTexture("Disabled",		"UIData/hunting_003.tga",	ZombieSelectTexPosX[i], 102)
		mywindow:setPosition(ZombieSelectBtnPosX[i], 349)
		mywindow:setVisible(true)
		mywindow:setSize(84, 34)
		mywindow:setSubscribeEvent("Clicked", ZombieSelect_BtnEvent[i])
		winMgr:getWindow('ZombieSelectBackImage'):addChildWindow(mywindow)	
	end
	
	
	ZombiMapRadioBtn =
	{ ["protecterr"]=0, "ZombiMapRadioBtn_1", "ZombiMapRadioBtn_2", "ZombiMapRadioBtn_3", "ZombiMapRadioBtn_4", "ZombiMapRadioBtn_5"}
	ZombiMapBtnPosX    = {['err'] = 0, 290, 275, 330 ,150, 420} 
	ZombiMapBtnPosY    = {['err'] = 0, 139, 120, 190, 70, 70}  
	ZombiMapIndex		 = {['err'] = 0, 4200, 4200, 4200, 4200, 4200}
	ZombiMapLevel		 = {['err'] = 0, 10, 10, 15 , 20, 25} 
	
	for i=1, #ZombiMapRadioBtn do	
		mywindow = winMgr:createWindow("TaharezLook/RadioButton",			ZombiMapRadioBtn[i]);	
		mywindow:setTexture("Normal",			"UIData/hunting_005.tga",		0, 592);
		mywindow:setTexture("Hover",			"UIData/hunting_005.tga",		0, 703);
		mywindow:setTexture("Pushed",			"UIData/hunting_005.tga",		0, 703);
		mywindow:setTexture("PushedOff",		"UIData/hunting_005.tga",		0, 703);	
		mywindow:setTexture("SelectedNormal",	"UIData/hunting_005.tga",		0, 703);
		mywindow:setTexture("SelectedHover",	"UIData/hunting_005.tga",		0, 703);
		mywindow:setTexture("SelectedPushed",	"UIData/hunting_005.tga",		0, 703);
		mywindow:setTexture("SelectedPushedOff","UIData/hunting_005.tga",		0, 703);
		mywindow:setTexture("Disabled",		    "UIData/hunting_005.tga",		0, 703);
		mywindow:setSize(164, 110);
		mywindow:setProperty("GroupID", 0752)
		mywindow:setUserString('ZombiMapIndex', tostring(ZombiMapIndex[i]))
		mywindow:setUserString('ZombiExplainIndex', tostring(i))
		mywindow:setUserString('ZombiLevelIndex', tostring(ZombiMapLevel[i]))
		mywindow:setPosition(ZombiMapBtnPosX[i], ZombiMapBtnPosY[i]);
		mywindow:setAlwaysOnTop(true)
		if i > 1 then
			mywindow:setVisible(false)
		end
		mywindow:subscribeEvent("SelectStateChanged", "OnClickSelectZombiMap");
		winMgr:getWindow('ZombieSelectBackImage'):addChildWindow(mywindow);
	end
	
	-- ���� ���巹��
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ZombieMonsterImage")
	mywindow:setTexture("Enabled", "UIData/hunting_005.tga", 910, 739)
	mywindow:setTexture("Disabled", "UIData/hunting_005.tga", 910, 739)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(391, 108)
	mywindow:setSize(114, 57)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow('ZombieSelectBackImage'):addChildWindow(mywindow)	
	
	
	ZombiMapIndexLevel = 50
	ZombiDungeonNumber = 0
	
	function OnClickSelectZombiMap(args)
	
		local local_window = CEGUI.toWindowEventArgs(args).window;
		if CEGUI.toRadioButton(local_window):isSelected() then
			ZombiDungeonNumber = tonumber(local_window:getUserString('ZombiMapIndex'))
			ZombiMapIndexLevel = tonumber(local_window:getUserString('ZombiLevelIndex'))
			ExplainIndex = tonumber(local_window:getUserString('ZombiExplainIndex'))
			for i=1, #ZombiMapExplainImage do	
				winMgr:getWindow(ZombiMapExplainImage[i]):setVisible(false)
			end
			
			for i=1, #ZombiMapTitleImage do	
				winMgr:getWindow(ZombiMapTitleImage[i]):setVisible(false)
			end
			winMgr:getWindow(ZombiMapExplainImage[ExplainIndex]):setVisible(true)
			winMgr:getWindow(ZombiMapTitleImage[ExplainIndex]):setVisible(true)
			
			if IsPartyJoined() then
				root:addChildWindow(winMgr:getWindow('ZombiePartyInfoImage'))
				winMgr:getWindow('ZombiePartyInfoImage'):setVisible(true)
			end
			
			if CheckfacilityData(FACILITYCODE_ZOMBIEDEFENCEHARD) == 1 then
				winMgr:getWindow('ZombieSelectBackImage'):addChildWindow(winMgr:getWindow('ZombieMapLevelImage'))	
				winMgr:getWindow('ZombieMapLevelImage'):setVisible(true)
			end
			
			ClearZombiePartyInfo()
			GetZomibePartyInfo(ZombiDungeonNumber)
		end
	end
	
	
	
	local CurrentLevelMode = 0
	
	-- ���� �ϵ�븻��� ����
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ZombieMapLevelImage")
	mywindow:setTexture("Enabled", "UIData/hunting_ticket.tga", 380, 485)
	mywindow:setTexture("Disabled", "UIData/hunting_ticket.tga", 380, 485)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(306, 232)
	mywindow:setSize(132, 27)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	
	if CheckfacilityData(FACILITYCODE_ZOMBIEDEFENCEHARD) == 1 then
		winMgr:getWindow('ZombieSelectBackImage'):addChildWindow(mywindow)	
	end
	
	-- ���� �ϵ�븻��� �����̹���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ZombieMapLevelSelectImage")
	mywindow:setTexture("Enabled", "UIData/hunting_ticket.tga", 438, 440)
	mywindow:setTexture("Disabled", "UIData/hunting_ticket.tga", 438, 440)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(28, 5)
	mywindow:setSize(73, 20)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow('ZombieMapLevelImage'):addChildWindow(mywindow)	
	--------------------------------------------------------------------
	
	-- ���潺 ���� ��ư
	
	--------------------------------------------------------------------
	local ZombiMapLevelBtn  = {["err"]=0, "ZombiMapLevelBtn_LBtn", "ZombiMapLevelBtn_RBtn"}
	local ZombiMapLevelBtnTexX  = {["err"]=0, 0, 90}
	local ZombiMapLevelBtnPosX  = {["err"]=0, 2, 107}
	local ZombiMapLevelBtnEvent = {["err"]=0, "Prev_ZombiMapLevelBtn", "Next_ZombiMapLevelBtn"}
	for i=1, #ZombiMapLevelBtn do
		mywindow = winMgr:createWindow("TaharezLook/Button", ZombiMapLevelBtn[i])
		mywindow:setTexture("Normal", "UIData/hunting_ticket.tga", ZombiMapLevelBtnTexX[i]+332, 461)
		mywindow:setTexture("Hover", "UIData/hunting_ticket.tga", ZombiMapLevelBtnTexX[i]+354, 461)
		mywindow:setTexture("Pushed", "UIData/hunting_ticket.tga", ZombiMapLevelBtnTexX[i]+376, 461)
		mywindow:setTexture("PushedOff", "UIData/hunting_ticket.tga", ZombiMapLevelBtnTexX[i]+399, 461)
		mywindow:setTexture("PushedOff", "UIData/hunting_ticket.tga", ZombiMapLevelBtnTexX[i]+399, 461)
		mywindow:setTexture("Disabled", "UIData/hunting_ticket.tga", ZombiMapLevelBtnTexX[i]+399, 461)
		mywindow:setPosition(ZombiMapLevelBtnPosX[i], 2)
		mywindow:setSize(23, 23)
		mywindow:setZOrderingEnabled(false)
		mywindow:setSubscribeEvent("Clicked", ZombiMapLevelBtnEvent[i])
		winMgr:getWindow("ZombieMapLevelImage"):addChildWindow(mywindow)
	end
	 winMgr:getWindow("ZombiMapLevelBtn_LBtn"):setEnabled(false)
	------------------------------------
	---���潺 �븻���? ��ư---------
	------------------------------------
			 
	function Prev_ZombiMapLevelBtn()
		 CurrentLevelMode = 0
		 GetZomibePartyInfo(ZombiDungeonNumber)
		 winMgr:getWindow("ZombieMapLevelSelectImage"):setTexture("Enabled", "UIData/hunting_ticket.tga", 438, 440)
		 winMgr:getWindow("ZombiMapLevelBtn_LBtn"):setEnabled(false)
		 winMgr:getWindow("ZombiMapLevelBtn_RBtn"):setEnabled(true)
		 SettingZombiMapTile()
	end
	
	------------------------------------
	---���潺 �ϵ��� ��ư---------
	------------------------------------
	function Next_ZombiMapLevelBtn()
		CurrentLevelMode = 1
		GetZomibePartyInfo(ZombiDungeonNumber+CurrentLevelMode)
		winMgr:getWindow("ZombieMapLevelSelectImage"):setTexture("Enabled", "UIData/hunting_ticket.tga", 438, 420)
		winMgr:getWindow("ZombiMapLevelBtn_RBtn"):setEnabled(false)
		winMgr:getWindow("ZombiMapLevelBtn_LBtn"):setEnabled(true)
		SettingZombiMapTile()
	end
	
	----------------------------------------------------
	--  ���� �� ���� �̹���
	----------------------------------------------------
	ZombiMapExplainImage =
	{ ["protecterr"]=0, "ZombiMapExplain_1", "ZombiMapExplain_2", "ZombiMapExplain_3", "ZombiMapExplain_4", "ZombiMapExplain_5"}
	
	ZombiMapExplainTexY    = {['err'] = 0, 136 , 210, 284, 358, 432 }  
	
	for i=1, #ZombiMapExplainImage do	
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", ZombiMapExplainImage[i])
		mywindow:setTexture("Enabled", "UIData/Hunting_005.tga", 672, ZombiMapExplainTexY[i] )
		mywindow:setTexture("Disabled", "UIData/Hunting_005.tga", 672, ZombiMapExplainTexY[i] )
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")
		mywindow:setPosition(258, 457)
		mywindow:setSize(352,74)
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow('ZombieSelectBackImage'):addChildWindow(mywindow)
	end
	
	
	function OnClickZombieClose()
		winMgr:getWindow('ZombieSelectBackImage'):setVisible(false)
		SetVillageInputEnable(true)
		
		winMgr:getWindow('ZombiePartyInfoImage'):setVisible(false)
		
		for i=1, #ZombiMapTitleImage do	
			winMgr:getWindow(ZombiMapTitleImage[i]):setVisible(false)
		end
		
		for i=1, #ZombiMapExplainImage do	
			winMgr:getWindow(ZombiMapExplainImage[i]):setVisible(false)
		end
	end
	
	function OnClickZombieStart()
	
		if ZombiDungeonNumber == 0 then
			ShowNotifyOKMessage_Lua(PreCreateString_4266)
			return
		end
		
		local checkUseCoupon = CheckPartyUserHasDefenceCoupon(ZombiDungeonNumber+CurrentLevelMode)
		DebugStr('checkUseCoupon:'..checkUseCoupon)
		
		if checkUseCoupon == 2 then
			OnClickZombieClose()
			local STRING_PREPARING = PreCreateString_1840	--GetSStringInfo(LAN_NOTACADE_TICKET) -- �غ����Դϴ�.
			ShowNotifyOKMessage_Lua(STRING_PREPARING)
			return
		end
		if checkUseCoupon < 1 then
			OnClickZombieClose()
			local STRING_PREPARING = PreCreateString_4220	--GetSStringInfo(LAN_ZOMBI_DEFFENSE_01) -- �غ����Դϴ�.
			ShowNotifyOKMessage_Lua(STRING_PREPARING)
			return
		end
		
		ZombieZoneStart(ZombiMapIndexLevel+(CurrentLevelMode*10), ZombiDungeonNumber+CurrentLevelMode)
		
	end
	
	function ZombieZoneEnter()
		
		for i = 1, #ZombiMapRadioBtn do
			winMgr:getWindow(ZombiMapRadioBtn[i]):setProperty("Selected", "false")
		end
		
		DebugStr(FACILITYCODE_ZOMBIEDEFENCEHARD)
		
		if CheckfacilityData(FACILITYCODE_ZOMBIEDEFENCEHARD) == 1 then
			root:addChildWindow(winMgr:getWindow('ZombieSelectBackImage'))
		end
		
		winMgr:getWindow('ZombieSelectBackImage'):setVisible(true)
		winMgr:getWindow('ZombieMapLevelImage'):setVisible(false)
		ZombiMapIndexLevel = 50
		ZombiDungeonNumber = 0
		Prev_ZombiMapLevelBtn()
	end
	
	
	
	-- ���� ��Ƽ�� ����(�����? ����)
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ZombiePartyInfoImage")
	mywindow:setTexture("Enabled", "UIData/hunting_ticket.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/hunting_ticket.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setWideType(6);
	mywindow:setPosition(718, 482)
	mywindow:setSize(288, 210)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	root:addChildWindow(mywindow)
	
	
	
	local tZombiePartyInfoPosY		= { ['err']=0,  50, 80, 110, 140 }
	
	for i = 1, 4 do
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ZombiePartyInfoSubImage"..i)
		mywindow:setTexture("Enabled","UIData/hunting_ticket.tga", 300, 0)
		mywindow:setTexture("Disabled", "UIData/hunting_ticket.tga", 300, 0)
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")
		mywindow:setPosition(20, tZombiePartyInfoPosY[i])
		mywindow:setSize(212, 30)
		--mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow('ZombiePartyInfoImage'):addChildWindow(mywindow);
		
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "zombiePartyInfoName"..i);
		mywindow:setProperty("FrameEnabled", "false");
		mywindow:setProperty("BackgroundEnabled", "false");
		mywindow:setFont(g_STRING_FONT_DODUMCHE, 12);
		mywindow:setTextColor(255, 255, 255, 255);
		mywindow:setPosition(10, 8);
		mywindow:setSize(100, 16);
		winMgr:getWindow("ZombiePartyInfoSubImage"..i):addChildWindow(mywindow);
		
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "zombiePartyInfoCoupon"..i);
		mywindow:setProperty("FrameEnabled", "false");
		mywindow:setProperty("BackgroundEnabled", "false");
		mywindow:setFont(g_STRING_FONT_DODUMCHE, 12);
		mywindow:setTextColor(255, 255, 255, 255);
		mywindow:setPosition(220, 8);
		mywindow:setSize(100, 16);
		winMgr:getWindow("ZombiePartyInfoSubImage"..i):addChildWindow(mywindow);
	end
	
	
	
	function SettingZombiePartyInfo(index, name, count, dungeonnumber)
		DebugStr('SettingZombiePartyInfo')
		
		for i = 1, 4 do
			if dungeonnumber == 4201 then
				winMgr:getWindow("ZombiePartyInfoSubImage"..i):setTexture("Enabled","UIData/hunting_ticket.tga", 300, 30)
			else
				winMgr:getWindow("ZombiePartyInfoSubImage"..i):setTexture("Enabled","UIData/hunting_ticket.tga", 300, 0)
			end
		end
		
		winMgr:getWindow("ZombiePartyInfoSubImage"..index):setVisible(true)
		winMgr:getWindow("zombiePartyInfoName"..index):setText(name);
		winMgr:getWindow("zombiePartyInfoCoupon"..index):setText(count);
	end
	
	function ClearZombiePartyInfo()
		for i = 1, 4 do
			winMgr:getWindow("ZombiePartyInfoSubImage"..i):setVisible(false)
			winMgr:getWindow("zombiePartyInfoName"..i):setText("");
			winMgr:getWindow("zombiePartyInfoCoupon"..i):setText("");
		end
	end
	----------------------------------------------------
	--  ���� �� ���� �̹���
	----------------------------------------------------
	ZombiMapTitleImage =
	{ ["protecterr"]=0, "ZombiMapTitle_1", "ZombiMapTitle_2", "ZombiMapTitle_3", "ZombiTitle_4" ,"ZombiTitle_5"}
	
	ZombiMapTitleTexY    = {['err'] = 0, 884 , 884, 884, 884, 884}  
	ZombiMapTitleHardTexY    = {['err'] = 0, 744 , 744, 744, 744, 744} 
	
	for i=1, #ZombiMapTitleImage do	
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", ZombiMapTitleImage[i])
		mywindow:setTexture("Enabled", "UIData/hunting_005.tga", 696, ZombiMapTitleTexY[i] )
		mywindow:setTexture("Disabled", "UIData/hunting_005.tga", 696, ZombiMapTitleTexY[i] )
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")
		mywindow:setPosition(47, 405)
		mywindow:setSize(213,140)
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow('ZombieSelectBackImage'):addChildWindow(mywindow)
	end
	
	function SettingZombiMapTile()
		for i=1, #ZombiMapTitleImage do
			if CurrentLevelMode == 0 then
				winMgr:getWindow(ZombiMapTitleImage[i]):setTexture("Enabled", "UIData/hunting_005.tga", 696, ZombiMapTitleTexY[i] )
				winMgr:getWindow(ZombiMapTitleImage[i]):setTexture("Disabled", "UIData/hunting_005.tga", 696, ZombiMapTitleTexY[i] )
			else
				winMgr:getWindow(ZombiMapTitleImage[i]):setTexture("Enabled", "UIData/hunting_005.tga", 696, ZombiMapTitleHardTexY[i] )
				winMgr:getWindow(ZombiMapTitleImage[i]):setTexture("Disabled", "UIData/hunting_005.tga", 696, ZombiMapTitleHardTexY[i] )
			end
		end
	end
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "HuntingPartyInfoImage")
	mywindow:setTexture("Enabled", "UIData/hunting_ticket.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/hunting_ticket.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(670, 380)
	mywindow:setSize(288, 210)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("HuntingMapSelectBackAlpha"):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "HuntingPartyInfoImageNam")
	mywindow:setTexture("Enabled", "UIData/hunting_ticket.tga", 290, 89)
	mywindow:setTexture("Disabled", "UIData/hunting_ticket.tga", 290, 89)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(34, 11)
	mywindow:setSize(220, 20)
	winMgr:getWindow('HuntingPartyInfoImage'):addChildWindow(mywindow)
	
	local tHuntingPartyInfoPosY		= { ['err']=0,  55, 85, 115, 145 }
	
	for i = 1, 4 do
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "HuntingPartyInfoSubCountBackImage"..i)
		mywindow:setTexture("Enabled","UIData/hunting_ticket.tga", 290, 63)
		mywindow:setTexture("Disabled", "UIData/hunting_ticket.tga", 290, 63)
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")
		mywindow:setPosition(145, tHuntingPartyInfoPosY[i] + 2 )
		mywindow:setSize(120, 26)
		winMgr:getWindow('HuntingPartyInfoImage'):addChildWindow(mywindow);
		
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "HuntingPartyInfoSubLimitCountImage"..i)
		mywindow:setTexture("Enabled", "UIData/hunting_003.tga", 816, 636)
		mywindow:setTexture("Disabled", "UIData/hunting_003.tga", 816, 636)
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")
		mywindow:setPosition(222, tHuntingPartyInfoPosY[i] + 3 )
		mywindow:setSize(18, 24)
		winMgr:getWindow('HuntingPartyInfoImage'):addChildWindow(mywindow);
		
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "HuntingPartyInfoSubCountImage"..i)
		mywindow:setTexture("Enabled", "UIData/hunting_003.tga", 726, 612)
		mywindow:setTexture("Disabled", "UIData/hunting_003.tga", 726, 612)
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")
		mywindow:setPosition(175, tHuntingPartyInfoPosY[i] + 3 )
		mywindow:setSize(18, 24)
		winMgr:getWindow('HuntingPartyInfoImage'):addChildWindow(mywindow);
		
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "HuntingPartyInfoSubImage"..i)
		mywindow:setTexture("Enabled","UIData/hunting_ticket.tga", 300, 0)
		mywindow:setTexture("Disabled", "UIData/hunting_ticket.tga", 300, 0)
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")
		mywindow:setPosition(25, tHuntingPartyInfoPosY[i])
		mywindow:setSize(130, 30)
		winMgr:getWindow('HuntingPartyInfoImage'):addChildWindow(mywindow);
		
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "HuntingPartyInfoName"..i);
		mywindow:setProperty("FrameEnabled", "false");
		mywindow:setProperty("BackgroundEnabled", "false");
		mywindow:setFont(g_STRING_FONT_DODUMCHE, 12);
		mywindow:setTextColor(255, 255, 255, 255);
		mywindow:setPosition(10, 8);
		mywindow:setSize(100, 16);
		winMgr:getWindow("HuntingPartyInfoSubImage"..i):addChildWindow(mywindow);
	end
	
	
	function SettingHuntingPartyInfo(index, name, count)
		winMgr:getWindow("HuntingPartyInfoImage"):setVisible(true)
		
		winMgr:getWindow("HuntingMapSelectBackImage"):setPosition(0, 0)
		
		winMgr:getWindow("HuntingPartyInfoSubCountBackImage"..index):setVisible(true)
		winMgr:getWindow("HuntingPartyInfoSubLimitCountImage"..index):setVisible(true)
		winMgr:getWindow("HuntingPartyInfoSubCountImage"..index):setVisible(true)
		winMgr:getWindow("HuntingPartyInfoSubImage"..index):setVisible(true)
		
		winMgr:getWindow("HuntingPartyInfoSubCountImage"..index):setTexture("Enabled", "UIData/hunting_003.tga", 726 + ( 18 * count), 612)
		winMgr:getWindow("HuntingPartyInfoSubCountImage"..index):setTexture("Disabled", "UIData/hunting_003.tga", 726 + ( 18 * count), 612)
		
		winMgr:getWindow("HuntingPartyInfoName"..index):setText(name)
	end
	
	function StartHiddenEvent()
		winMgr:getWindow("Event_Hidden_BackImg_Alpha"):setVisible(true)
	end
	
	function CloseHiddenEvent()
		winMgr:getWindow("Event_Hidden_BackImg_Alpha"):setVisible(false)
	end
	
	
	--����
	--[[
	local mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CreateAosCharacterBackImage")
	mywindow:setTexture("Enabled",	"UIData/invisible.tga", 0 , 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0 , 0)
	mywindow:setWideType(6)
	mywindow:setPosition(200 , 150)
	mywindow:setSize(512, 512)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	root:addChildWindow(mywindow)
	CreateNewFrameSetWindow(mywindow:getName(), 402, 430, 1, 0)
	--]]
	--[[
	drawer:drawTexture("UIData/Arcade_lobby.tga", 324, 400, 376, 119, 648, 612, WIDETYPE_6)
	DrawEachNumberWide("UIData/Arcade_lobby.tga", min, 2, 435, 436, 574, 819, 45, 69, 45, WIDETYPE_6)
	DrawEachNumberWide("UIData/Arcade_lobby.tga", sec1, 8, 500, 436, 574, 819, 45, 69, 45, WIDETYPE_6)
	DrawEachNumberWide("UIData/Arcade_lobby.tga", sec2, 8, 540, 436, 574, 819, 45, 69, 45, WIDETYPE_6)
	--]]
	--[[
	local mywindow = winMgr:createWindow("TaharezLook/StaticImage", "CreateAosCharacterBackImage")
	mywindow:setTexture("Enabled",	"UIData/center_line_001.tga", 0 , 0)
	mywindow:setTexture("Disabled", "UIData/center_line_001.tga", 0 , 0)
	mywindow:setWideType(6)
	mywindow:setPosition(200 , 150)
	mywindow:setSize(512, 512)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	root:addChildWindow(mywindow)
	CreateNewFrameSetWindow(mywindow:getName(), 402, 430, 1, 0)
	--]]
	
	------------------------------------------------
	-- ��׶���? ���� �̹���
	local mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_questroom_alphaWindow")
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
	
	-- �˾� ����â
	local popupwindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_questroom_backWindow")
	popupwindow:setTexture("Enabled", "UIData/popup001.tga", 0, 0)
	popupwindow:setTexture("Disabled", "UIData/popup001.tga", 0, 0)
	popupwindow:setProperty("FrameEnabled", "False")
	popupwindow:setProperty("BackgroundEnabled", "False")
	popupwindow:setWideType(6)
	popupwindow:setPosition(338, 246)
	popupwindow:setSize(346, 275)
	popupwindow:setVisible(false)
	popupwindow:setAlwaysOnTop(true)
	popupwindow:setZOrderingEnabled(false)
	root:addChildWindow(popupwindow)
	
	-- ��Ƽ ��ġ ESCŰ ���?
	RegistEscEventInfo("sj_questroom_backWindow", "CloseAdvantagePopup")
	
	-- �˾� ����â
	local mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_questroom_descImage")
	mywindow:setTexture("Enabled", "UIData/party003.tga", 383, 645)
	mywindow:setTexture("Disabled", "UIData/party003.tga", 383, 645)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(11, 84)
	mywindow:setSize(317, 106)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	popupwindow:addChildWindow(mywindow)
	
	-- �˾� ����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_questroom_text")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont(g_STRING_FONT_DODUM, 115)
	mywindow:setText("")
	mywindow:setPosition(44, 120)
	mywindow:setSize(250, 36)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	popupwindow:addChildWindow(mywindow)
	
	-- �˾� Ȯ�ι�ư
	mywindow = winMgr:createWindow("TaharezLook/Button", "sj_questroom_okBtn")
	mywindow:setTexture("Normal", "UIData/popup001.tga",693, 617)
	mywindow:setTexture("Hover", "UIData/popup001.tga", 693, 646)
	mywindow:setTexture("Pushed", "UIData/popup001.tga", 693, 675)
	mywindow:setTexture("PushedOff", "UIData/popup001.tga", 693, 704)
	mywindow:setPosition(4, 235)
	mywindow:setSize(331, 29)
	mywindow:setAlwaysOnTop(true)
	mywindow:subscribeEvent("Clicked", "CloseAdvantagePopup")
	popupwindow:addChildWindow(mywindow)
	
	
	local tArcadeImage = {["err"]=0,
	[1001] = "UIData/ItemUIData/Item/Arcade_Ticket_hotel.tga", 
	[1002] = "UIData/ItemUIData/Item/Arcade_Ticket_park.tga", 
	[1003] = "UIData/ItemUIData/Item/Arcade_Ticket_halem.tga", 
	[1004] = "UIData/ItemUIData/Item/Arcade_Ticket_hroad.tga", 
	[1005] = "UIData/ItemUIData/Item/Arcade_Ticket_Subway.TGA",
	[1006] = "UIData/ItemUIData/Item/Arcade_Ticket_Grave_001.tga",
	[1007] = "UIData/ItemUIData/Item/Arcade_Ticket_Grave_001.tga",
	[1008] = "UIData/ItemUIData/Item/Arcade_Ticket_Grave_001.tga",
	[1009] = "UIData/ItemUIData/Item/Arcade_Ticket_Grave_1_4.tga",							
	[1011] = "UIData/ItemUIData/Item/Arcade_Ticket_Temple.TGA",
	[1012] = "UIData/ItemUIData/Item/All_Arcade_Ticket.tga",
	[1100] = "UIData/ItemUIData/Item/Hard_Arcade_Ticket.tga"}
	
	function CallAdvantagePopup(DungeonNum, message)
		DebugStr('CallAdvantagePopup1 : ' .. DungeonNum)
		--�����̵� ������ �������� ���Ǵ� ���?
		local PublicArcadeCouponType = 1012;
		if ARCADE_HARD_HOTEL <= DungeonNum and DungeonNum <= ARCADE_HARD_EVENT then
			PublicArcadeCouponType = ARCADE_HARD_ENTER;
		end	
		winMgr:getWindow("sj_questroom_descImage"):setTexture("Enabled", tArcadeImage[PublicArcadeCouponType], 0, 0)
		winMgr:getWindow("sj_questroom_descImage"):setTexture("Disabled", tArcadeImage[PublicArcadeCouponType], 0, 0)
		winMgr:getWindow("sj_questroom_descImage"):setPosition(120, 54)
		winMgr:getWindow("sj_questroom_descImage"):setSize(128, 128)			
		winMgr:getWindow("sj_questroom_alphaWindow"):setVisible(true)
		winMgr:getWindow("sj_questroom_backWindow"):setVisible(true)
	
		local strSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, message)
		winMgr:getWindow("sj_questroom_text"):clearTextExtends()
		winMgr:getWindow("sj_questroom_text"):setPosition(48, 180)
		winMgr:getWindow("sj_questroom_text"):setViewTextMode(1)
		winMgr:getWindow("sj_questroom_text"):setAlign(8)
		winMgr:getWindow("sj_questroom_text"):setLineSpacing(5)
		winMgr:getWindow("sj_questroom_text"):addTextExtends(message, g_STRING_FONT_GULIMCHE, 12, 255,255,255,255, 2, 0,0,0,255)
		root:addChildWindow(winMgr:getWindow("sj_questroom_alphaWindow"))
		root:addChildWindow(winMgr:getWindow("sj_questroom_backWindow"))
	end
	
	function CloseAdvantagePopup()
		winMgr:getWindow("sj_questroom_alphaWindow"):setVisible(false)
		winMgr:getWindow("sj_questroom_backWindow"):setVisible(false)
		winMgr:getWindow("sj_questroom_text"):setText("")
	end
	
	
	
	
	
	
	
	--------------------------------------------------------------------
	-- �ϵ��� �� �� ����
	--------------------------------------------------------------------
	-- �ϵ� �� ���?
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "HardModeMapSelectBackAlphaBG")
	--mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	--mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Enabled",	"UIData/OnDLGBackImage.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	--mywindow:setWideType(6);
	mywindow:setPosition(0 , 0) 
	mywindow:setSize(1920, 1200)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	root:addChildWindow(mywindow)
	
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "HardModeMapSelectBackAlpha")
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	--mywindow:setTexture("Enabled",	"UIData/OnDLGBackImage.tga", 0, 0)
	--mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setWideType(6);
	mywindow:setPosition(0 , 0) 
	mywindow:setSize(1920, 1200)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	--root:addChildWindow(mywindow)
	winMgr:getWindow("HardModeMapSelectBackAlphaBG"):addChildWindow(mywindow)
	
	RegistEscEventInfo("HardModeMapSelectBackAlpha", "OnClickHardModeClose")
	
	function OffHardModeMapSelectBackAlpha()
		DebugStr("OffHardModeMapSelectBackAlpha")
		
		winMgr:getWindow("HardModeMapSelectBackAlphaBG"):setVisible(false)
		winMgr:getWindow("HardModeMapSelectBackAlpha"):setVisible(false)
	end
	
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "HardModeMapSelectBackImage")
	mywindow:setTexture("Enabled", "UIData/Arcade_Hard_Select_01.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/Arcade_Hard_Select_01.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	--mywindow:setWideType(6);
	mywindow:setPosition(120, 90)
	mywindow:setSize(787, 590)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("HardModeMapSelectBackAlpha"):addChildWindow(mywindow)
	
	
	
	 -----------------------------------------------------------------------
	-- �ϵ��� �� ������ư
	-----------------------------------------------------------------------
	local BtWidth = 136;
	local BtHeihgt = 286;
	
	-- HardModeMapIndex	 = {['err'] = 0, 1102, 1101, 1103, 1104, 1105}
	HardModeMapIndex	 = {['err'] = 0, 1102, 1101, 1103, 1104, 0}
	HardModeTexturePosX = {['err'] = 0, BtWidth * 0, BtWidth * 1, BtWidth * 2, BtWidth * 3, BtWidth * 4}
	HardModeTexturePosY = {['err'] = 0, 596 , 596, 596, 596, 596} 
	
	
	HardModeTexture2PosX = {['err'] = 0, BtWidth * 0, BtWidth * 1, BtWidth * 2, BtWidth * 3, BtWidth * 4} 
	HardModeTexture2PosY = {['err'] = 0, 0 , 0, 0 , 0, 0} 
	
	for i=1, #HardModeMapIndex do	
	
		UIDataFileName = "UIData/Arcade_Hard_Select_01.tga"
		UIDataFileName2= "UIData/Arcade_Hard_Select_02.tga"
		
		mywindow = winMgr:createWindow("TaharezLook/RadioButton", "HardModeMapRadioBtn_" .. i);
		if HardModeMapIndex[i] ~= 0 then
			DebugStr("�ϵ��� �� ������ư")
			mywindow:setTexture("Normal",			UIDataFileName,		HardModeTexturePosX[i],		HardModeTexturePosY[i]);
			mywindow:setTexture("Hover",			UIDataFileName2,	HardModeTexture2PosX[i],	HardModeTexture2PosY[i]);
			mywindow:setTexture("Pushed",			UIDataFileName2,	HardModeTexture2PosX[i],	HardModeTexture2PosY[i] + BtHeihgt* 2);
			mywindow:setTexture("PushedOff",		UIDataFileName2,	HardModeTexture2PosX[i], 	HardModeTexture2PosY[i] + BtHeihgt* 2);	
			mywindow:setTexture("SelectedNormal",	UIDataFileName2,	HardModeTexture2PosX[i], 	HardModeTexture2PosY[i]);
			mywindow:setTexture("SelectedHover",	UIDataFileName2,	HardModeTexture2PosX[i], 	HardModeTexture2PosY[i]);
			mywindow:setTexture("SelectedPushed",	UIDataFileName2,	HardModeTexture2PosX[i], 	HardModeTexture2PosY[i] + BtHeihgt* 2);
			mywindow:setTexture("SelectedPushedOff",UIDataFileName2,	HardModeTexture2PosX[i], 	HardModeTexture2PosY[i]);
			mywindow:setTexture("Disabled",		    UIDataFileName2,	HardModeTexture2PosX[i],	HardModeTexture2PosY[i]);
		else
			mywindow:setTexture("Normal",			UIDataFileName2,	HardModeTexture2PosX[i],	HardModeTexture2PosY[i] + BtHeihgt* 1);
			mywindow:setTexture("Hover",			UIDataFileName2,	HardModeTexture2PosX[i],	HardModeTexture2PosY[i] + BtHeihgt* 1);
			mywindow:setTexture("Pushed",			UIDataFileName2,	HardModeTexture2PosX[i],	HardModeTexture2PosY[i] + BtHeihgt* 1);
			mywindow:setTexture("PushedOff",		UIDataFileName2,	HardModeTexture2PosX[i], 	HardModeTexture2PosY[i] + BtHeihgt* 1);	
			mywindow:setTexture("SelectedNormal",	UIDataFileName2,	HardModeTexture2PosX[i], 	HardModeTexture2PosY[i] + BtHeihgt* 1);
			mywindow:setTexture("SelectedHover",	UIDataFileName2,	HardModeTexture2PosX[i], 	HardModeTexture2PosY[i] + BtHeihgt* 1);
			mywindow:setTexture("SelectedPushed",	UIDataFileName2,	HardModeTexture2PosX[i], 	HardModeTexture2PosY[i] + BtHeihgt* 1);
			mywindow:setTexture("SelectedPushedOff",UIDataFileName2,	HardModeTexture2PosX[i], 	HardModeTexture2PosY[i] + BtHeihgt* 1);
			mywindow:setTexture("Disabled",		    UIDataFileName2,	HardModeTexture2PosX[i],	HardModeTexture2PosY[i] + BtHeihgt* 1);
			winMgr:getWindow("HardModeMapRadioBtn_" .. i):setEnabled(false)
		end
		mywindow:setSize(136, 286);
		mywindow:setProperty("GroupID", 0752)
		mywindow:setUserString('HardModeMapIndex', tostring(i))
		mywindow:setPosition(42 + ((i-1)*140), 77);
		mywindow:setAlwaysOnTop(true)
		mywindow:subscribeEvent("SelectStateChanged", "OnClickSelectHardModeMap");
		winMgr:getWindow('HardModeMapSelectBackImage'):addChildWindow(mywindow);
		
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "HardModeMapDifficulty" .. i)
		mywindow:setTexture("Enabled",	UIDataFileName, 694, 0 )
		mywindow:setTexture("Disabled", UIDataFileName, 694, 0 )
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")
		mywindow:setPosition(6, 239)
		mywindow:setSize(125,33)
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("HardModeMapRadioBtn_" .. i):addChildWindow(mywindow)
		
		mywindow = winMgr:createWindow("TaharezLook/Button", "HardModeMapDifficultyBtnLeft" .. i)
		mywindow:setTexture("Normal",	UIDataFileName, 695, 66)
		mywindow:setTexture("Hover",	UIDataFileName, 695, 97)
		mywindow:setTexture("Pushed",	UIDataFileName, 695, 128)
		mywindow:setTexture("PushedOff",UIDataFileName, 695, 66)
		mywindow:setTexture("Disabled", UIDataFileName, 695, 159)
		mywindow:setSize(31, 31)
		mywindow:setPosition(1, 1)
		mywindow:setVisible(true)
		mywindow:setEnabled(false)
		mywindow:setZOrderingEnabled(false)
		mywindow:setAlwaysOnTop(true)
	--	mywindow:subscribeEvent("Clicked", "OnClickHardModeDifficultyLeft")
		winMgr:getWindow("HardModeMapDifficulty" .. i):addChildWindow(mywindow)
		
		mywindow = winMgr:createWindow("TaharezLook/Button", "HardModeMapDifficultyBtnRight" .. i)
		mywindow:setTexture("Normal",	UIDataFileName, 726, 66)
		mywindow:setTexture("Hover",	UIDataFileName, 726, 97)
		mywindow:setTexture("Pushed",	UIDataFileName, 726, 128)
		mywindow:setTexture("PushedOff",UIDataFileName, 726, 66)
		mywindow:setTexture("Disabled", UIDataFileName, 726, 159)
		mywindow:setSize(31, 31)
		mywindow:setPosition(93, 1)
		mywindow:setVisible(true)
		mywindow:setEnabled(false)
		mywindow:setZOrderingEnabled(false)
		mywindow:setAlwaysOnTop(true)
	--	mywindow:subscribeEvent("Clicked", "OnClickHardModeDifficultyRight")
		winMgr:getWindow("HardModeMapDifficulty" .. i):addChildWindow(mywindow)
		
		----------------------------------------------------
		--  �ϵ��� �� ���� �̹���
		----------------------------------------------------
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "HardModeMapExplain_"..i)
		mywindow:setTexture("Enabled", "UIData/Arcade_Hard_Select_03.tga", 6, 6 + ( 62 * (i-1)) )
		mywindow:setTexture("Disabled", "UIData/Arcade_Hard_Select_03.tga", 6, 6 + ( 62 * (i-1)) )
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")
		mywindow:setPosition(170, 420)
		mywindow:setSize(435,62)
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow('HardModeMapSelectBackImage'):addChildWindow(mywindow)
		
	end
	
	
	function ShowHardModeSelectMapUI()
		root:addChildWindow(winMgr:getWindow('HardModeMapSelectBackAlpha'))
		if winMgr:getWindow('HardModeMapSelectBackAlpha') == nil then 
		else
			winMgr:getWindow("HardModeMapSelectBackAlphaBG"):setVisible(true)
			winMgr:getWindow('HardModeMapSelectBackAlpha'):setVisible(true)
		end
	
	end
	
	
	----------------------------------------------------
	--  �ϵ��� �� ���� �ִϸ��̼�
	----------------------------------------------------
	--[[
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "HardModeSelectAniImage")
	mywindow:setTexture("Enabled", "UIData/hunting_003.tga", 440, 592)
	mywindow:setTexture("Disabled", "UIData/hunting_003.tga", 440, 592)
	mywindow:setPosition(-25, -22)
	mywindow:setSize(142, 142)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(false)
	mywindow:setAlign(8);
	mywindow:setZOrderingEnabled(false)
	mywindow:addController("SelectMotion", "SelectMotion", "angle", "Linear_EaseNone", 0, 1000, 10, true, true, 10)
	root:addChildWindow(mywindow)
	]]
	
	SelectedHardModeMapIndex = 0
	
	function OnClickSelectHardModeMap(args)
	
		local local_window = CEGUI.toWindowEventArgs(args).window;
		if CEGUI.toRadioButton(local_window):isSelected() then
		
			SelectedHardModeMapIndex = tonumber(local_window:getUserString('HardModeMapIndex'))
			DebugStr("SelectedHardModeMapIndex : " .. SelectedHardModeMapIndex);
	
			for i=1, #HardModeMapIndex do	
				winMgr:getWindow("HardModeMapDifficulty"..i):setVisible(false)
				winMgr:getWindow("HardModeMapExplain_"..i):setVisible(false)
			end
			
			winMgr:getWindow("HardModeMapExplain_"..SelectedHardModeMapIndex):setVisible(true)
		--	winMgr:getWindow("HardModeMapDifficulty"..SelectedHardModeMapIndex):setVisible(true)
		end
	end
	
	--[[
	RegistEscEventInfo("HardModeMapSelectBackImage", "OnClickHardModeClose")
	----------------------------------------------------------------------
	-- �ϵ��� �ʼ��� ������?
	-----------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/Button", "HardModeMapCloseBtn")
	mywindow:setTexture("Normal",		"UIData/hunting_003.tga",	998, 0)
	mywindow:setTexture("Hover",		"UIData/hunting_003.tga",	998, 21)
	mywindow:setTexture("Pushed",		"UIData/hunting_003.tga",	998, 42)
	mywindow:setTexture("PushedOff",	"UIData/hunting_003.tga",	998, 42)
	mywindow:setTexture("Disabled",		"UIData/hunting_003.tga",	998, 63)
	mywindow:setPosition(100, 17)
	mywindow:setVisible(false)
	mywindow:setSize(21, 21)
	mywindow:setSubscribeEvent("Clicked", "OnClickHardModeClose")
	winMgr:getWindow('HardModeMapSelectBackImage'):addChildWindow(mywindow)
	]]
	
	 -----------------------------------------------------------------------
	-- �ϵ��� �� ���� ���� ���? ��ư
	-----------------------------------------------------------------------
	 
	local HardModeMapSelectBtn = { ["protecterr"]=0, "HardModeMapSelectBtn1", "HardModeMapSelectBtn2"}
	
	local HardModeMapSelectBtnPosX    = {['err'] = 0, 315, 395 } 
	local HardModeMapSelectTexPosX    = {['err'] = 0, 788, 872 } 
	local HardModeMapSelect_BtnEvent = {["err"]=0, "OnClickHardModeStart", "OnClickHardModeClose"}
	
	for i=1, #HardModeMapSelectBtn do	
		mywindow = winMgr:createWindow("TaharezLook/Button",HardModeMapSelectBtn[i]);
		mywindow:setTexture("Normal",		"UIData/Arcade_Hard_Select_01.tga",	HardModeMapSelectTexPosX[i] , 15)
		mywindow:setTexture("Hover",		"UIData/Arcade_Hard_Select_01.tga",	HardModeMapSelectTexPosX[i], 49)
		mywindow:setTexture("Pushed",		"UIData/Arcade_Hard_Select_01.tga",	HardModeMapSelectTexPosX[i], 83)
		mywindow:setTexture("PushedOff",	"UIData/Arcade_Hard_Select_01.tga",	HardModeMapSelectTexPosX[i], 83)
		mywindow:setTexture("Disabled",		"UIData/Arcade_Hard_Select_01.tga",	HardModeMapSelectTexPosX[i], 118)
		mywindow:setPosition(HardModeMapSelectBtnPosX[i], 515)
		mywindow:setVisible(true)
		mywindow:setSize(72, 29)
		mywindow:setSubscribeEvent("Clicked", HardModeMapSelect_BtnEvent[i])
		winMgr:getWindow('HardModeMapSelectBackImage'):addChildWindow(mywindow)	
	end
	
	----------------------------------------------------------------------
	-- �ϵ��� ���� �Լ�
	-----------------------------------------------------------------------
	function OnClickHardModeStart()	
		if SelectedHardModeMapIndex > 0 then
			DebugStr('SelectedHardModeMapIndex:'..SelectedHardModeMapIndex)
			RequestCreateHardMode(HardModeMapIndex[SelectedHardModeMapIndex])
		end
	end
	
	----------------------------------------------------------------------
	-- �ϵ��� �� ���� ���� �Լ�
	-----------------------------------------------------------------------
	function OnClickHardModeClose()
		SelectedHardModeMapIndex = 0;
		winMgr:getWindow("HardModeMapSelectBackAlphaBG"):setVisible(false)
		winMgr:getWindow("HardModeMapSelectBackAlpha"):setVisible(false)	
	--	winMgr:getWindow("HardModePartyInfoImage"):setVisible(false)	
	--	winMgr:getWindow('HardModeSelectAniImage'):setVisible(false)
	--	winMgr:getWindow("HardModeMapSelectBackImage"):setPosition(100, 0)
	
		for i=1, #HardModeMapIndex do	
			winMgr:getWindow("HardModeMapRadioBtn_"..i):setProperty("Selected", "false")
			winMgr:getWindow("HardModeMapDifficulty"..i):setVisible(false)
			winMgr:getWindow("HardModeMapExplain_"..i):setVisible(false)
		end
		
		SetInputEnable(true)
	end
		
	--------------------------------------------------------------------
	-- ShowScrumbleResults �̹���
	--------------------------------------------------------------------
	local WndScrambleResultBG = winMgr:createWindow("TaharezLook/StaticImage", "Scramble_ResultBG")
	WndScrambleResultBG:setPosition(100, 100)
	WndScrambleResultBG:setWideType(6);
	WndScrambleResultBG:setSize(518, 574)	
	WndScrambleResultBG:setVisible(false)	
	WndScrambleResultBG:setEnabled(false)
	WndScrambleResultBG:setZOrderingEnabled(false)
	root:addChildWindow(WndScrambleResultBG)
	local ParentX = 0;
	local ParentY = 0;
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ResultBG")
	mywindow:setTexture("Enabled", "UIData/fightClub_010.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/fightClub_010.tga", 0, 0)
	mywindow:setSize(518, 574)	
	mywindow:setWideType(6);
	mywindow:setPosition(ParentX+250, ParentY+100)
	mywindow:setVisible(true)	
	mywindow:setEnabled(true)
	mywindow:setZOrderingEnabled(false)
	WndScrambleResultBG:addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RankText")
	mywindow:setTexture("Enabled", "UIData/fightClub_010.tga", 518, 0)
	mywindow:setTexture("Disabled", "UIData/fightClub_010.tga", 518, 0)
	mywindow:setSize(72, 31)
	mywindow:setWideType(6);
	mywindow:setPosition(350 + ParentX, 195 + ParentY)
	mywindow:setVisible(true)	
	mywindow:setEnabled(true)
	mywindow:setZOrderingEnabled(false)
	WndScrambleResultBG:addChildWindow(mywindow)
	
	
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ZenText")
	mywindow:setTexture("Enabled", "UIData/fightClub_010.tga", 590, 0)
	mywindow:setTexture("Disabled", "UIData/fightClub_010.tga", 590, 0)
	mywindow:setWideType(6);
	mywindow:setPosition(350 + ParentX, 235 + ParentY)
	mywindow:setSize(72, 31)	
	mywindow:setVisible(true)	
	mywindow:setEnabled(true)
	mywindow:setZOrderingEnabled(false)
	WndScrambleResultBG:addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "RankTextInList")
	mywindow:setTexture("Enabled", "UIData/fightClub_010.tga", 662 + 44 * 0 , 0)
	mywindow:setTexture("Disabled", "UIData/fightClub_010.tga", 662, 0)
	mywindow:setWideType(6);
	mywindow:setPosition(302 + ParentX, 316 + ParentY)
	mywindow:setSize(44, 17)	
	mywindow:setVisible(true)	
	mywindow:setEnabled(true)
	mywindow:setZOrderingEnabled(false)
	WndScrambleResultBG:addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "LevelTextInList")
	mywindow:setTexture("Enabled", "UIData/fightClub_010.tga", 662 + 44 * 1 , 0)
	mywindow:setTexture("Disabled", "UIData/fightClub_010.tga", 662, 0)
	mywindow:setWideType(6);
	mywindow:setPosition(392 + ParentX, 316 + ParentY)
	mywindow:setSize(44, 17)	
	mywindow:setVisible(true)	
	mywindow:setEnabled(true)
	mywindow:setZOrderingEnabled(false)
	WndScrambleResultBG:addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "NameTextInList")
	mywindow:setTexture("Enabled", "UIData/fightClub_010.tga", 662 + 44 * 2 , 0)
	mywindow:setTexture("Disabled", "UIData/fightClub_010.tga", 662, 0)
	mywindow:setWideType(6);
	mywindow:setPosition(497 + ParentX, 316 + ParentY)
	mywindow:setSize(44, 17)	
	mywindow:setVisible(true)	
	mywindow:setEnabled(true)
	mywindow:setZOrderingEnabled(false)
	WndScrambleResultBG:addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ZenTextInList")
	mywindow:setTexture("Enabled", "UIData/fightClub_010.tga", 662 + 44 * 3 , 0)
	mywindow:setTexture("Disabled", "UIData/fightClub_010.tga", 662, 0)
	mywindow:setWideType(6);
	mywindow:setPosition(597 + ParentX, 316 + ParentY)
	mywindow:setSize(44, 17)	
	mywindow:setVisible(true)	
	mywindow:setEnabled(true)
	mywindow:setZOrderingEnabled(false)
	WndScrambleResultBG:addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/Button", "HideScrumbleResultBG")
	mywindow:setTexture("Normal", "UIData/fightClub_010.tga", 518, 124 + 41 * 0)
	mywindow:setTexture("Hover", "UIData/fightClub_010.tga", 518, 124 + 41 * 1)
	mywindow:setTexture("Pushed", "UIData/fightClub_010.tga", 518, 124 + 41 * 2)
	mywindow:setTexture("PushedOff", "UIData/fightClub_010.tga", 518, 124 + 41 * 3)
	mywindow:setWideType(6);
	mywindow:setPosition(450, 610)
	mywindow:setSize(122, 41)
	mywindow:setVisible(false)	
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:subscribeEvent("Clicked", "HideScrumbleResults")
	root:addChildWindow(mywindow)
	
	function ShowScrumbleResults()
		winMgr:getWindow("Scramble_ResultBG"):setVisible(true)	
		winMgr:getWindow("Scramble_ResultBG"):setEnabled(true)
		winMgr:getWindow("HideScrumbleResultBG"):setEnabled(true)
		winMgr:getWindow("HideScrumbleResultBG"):setVisible(true)	
	end
	
	function HideScrumbleResults()
		winMgr:getWindow("Scramble_ResultBG"):setVisible(false)	
		winMgr:getWindow("Scramble_ResultBG"):setEnabled(false)
		winMgr:getWindow("HideScrumbleResultBG"):setEnabled(false)
		winMgr:getWindow("HideScrumbleResultBG"):setVisible(false)
	end
	
	
	
	tNumberTable = { ['err']=0, "MyZenNumberOne", "MyZenNumberTwo", "MyZenNumberThree", "MyZenNumberFour", "MyZenNumberFive", "MyZenNumberSix", "MyZenNumberSeven", "MyZenNumberEight"}
	for i=1, #tNumberTable do
		if winMgr:getWindow(tNumberTable[i]) == nil then
			DebugStr("----------------Create Window" .. tNumberTable[i])
			mywindow = winMgr:createWindow("TaharezLook/StaticImage", tNumberTable[i]);
			mywindow:setVisible(true)
			mywindow:setSize(24, 28)
			winMgr:getWindow("ResultBG"):addChildWindow(mywindow)	
		end
	end
	
	function AddScrambleResult(Rank, Level, Name, Zen, isMine)
		if isMine == true then
			SetMyResult(isMine, Rank, Zen)
		end
		
		if Rank >= 10 then
			return
		end
		if winMgr:getWindow("ScrambleResult"..Rank) == nil then
			WndScrambleResult = winMgr:createWindow("TaharezLook/StaticImage", "ScrambleResult"..Rank)
			WndScrambleResult:setSize(150, 30)	
			WndScrambleResult:setVisible(true)	
			WndScrambleResult:setEnabled(true)
			WndScrambleResult:setZOrderingEnabled(false)
			winMgr:getWindow("ResultBG"):addChildWindow(WndScrambleResult)
	
			mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ScrambleResult_Rank"..Rank)
			mywindow:setWideType(6);
			mywindow:setSize(12, 17)	
			mywindow:setVisible(true)	
			mywindow:setEnabled(true)
			mywindow:setZOrderingEnabled(false)
			WndScrambleResult:addChildWindow(mywindow)
	
			mywindow = winMgr:createWindow("TaharezLook/StaticText", "ScrambleResult_Level"..Rank)
			mywindow:setPosition(4, 0)
			mywindow:setSize(100, 20)
			mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
			mywindow:setTextColor(255, 255, 255, 255)
			WndScrambleResult:addChildWindow(mywindow)
			
			mywindow = winMgr:createWindow("TaharezLook/StaticText", "ScrambleResult_Name"..Rank)
			mywindow:setPosition(4, 0)
			mywindow:setSize(130, 20)
			mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
			mywindow:setTextColor(255, 255, 255, 255)
			WndScrambleResult:addChildWindow(mywindow)
	
			mywindow = winMgr:createWindow("TaharezLook/StaticText", "ScrambleResult_Zen"..Rank)
			mywindow:setPosition(4, 0)
			mywindow:setSize(100, 20)
			mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
			mywindow:setAlign(7);
			mywindow:setWideType(0);
			WndScrambleResult:addChildWindow(mywindow)
			
			mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ScrambleResult_My"..Rank)
			mywindow:setTexture("Enabled", "UIData/fightClub_010.tga", 0 , 575)
			mywindow:setTexture("Disabled", "UIData/fightClub_010.tga", 0 , 575)
			mywindow:setWideType(6);
			mywindow:setSize(474, 43)	
			mywindow:setZOrderingEnabled(false)
			WndScrambleResult:addChildWindow(mywindow)
		end
	
		winMgr:getWindow("ScrambleResult_Rank"..Rank):setTexture("Enabled", "UIData/fightClub_010.tga", 838 + 12 * Rank, 0)
		winMgr:getWindow("ScrambleResult_Level"..Rank):setText(Level);
		
		SetScrambleResultName(Rank, Name)
		SetScrambleResultZen(Rank, Zen)
		SetMyRankBG(isMine, Rank)
	
		local RankPosX = 320
		local RankPosY = 343
		if Rank == 9 then
			winMgr:getWindow("ScrambleResult_Rank"..Rank):setSize(24, 17)
			winMgr:getWindow("ScrambleResult_Rank"..Rank):setPosition(RankPosX - 5, RankPosY+ Rank * 26)
		else
			winMgr:getWindow("ScrambleResult_Rank"..Rank):setPosition(RankPosX, RankPosY+ Rank * 26)
		end
	
		winMgr:getWindow("ScrambleResult_Level"..Rank):setPosition(55,  143 + Rank * 26)
	end
	
	function SetScrambleResultName(Rank, Name)
		local summaryName = SummaryString(g_STRING_FONT_GULIMCHE, 12, Name, 90)
		local strSize = GetStringSize(g_STRING_FONT_GULIMCHE, 112, summaryName)
		local PosX = 165-(strSize/2);
		local PosY =  143 +   Rank * 26
		winMgr:getWindow("ScrambleResult_Name"..Rank):setPosition(PosX, PosY)
		winMgr:getWindow("ScrambleResult_Name"..Rank):setText(summaryName);
	end
	
	function SetScrambleResultZen(Rank, Zen)
		local mywindow = winMgr:getWindow("ScrambleResult_Zen"..Rank);
		local Test = CommatoMoneyStr64(Zen)
		local r,g,b = GetGranColor(Zen)
		local size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(Test))
		mywindow:setTextColor(r, g, b, 255)
		local PosX = 295 - size;
		local PosY =  143 +   Rank * 26
	
		mywindow:setPosition(PosX, PosY)
		mywindow:setText(Test);
	end
	
	function SetMyRankBG(isMine, Rank)
		local mywindow = winMgr:getWindow("ScrambleResult_My"..Rank)
		if mywindow ~= nil then
			mywindow:setVisible(isMine)	
			mywindow:setEnabled(isMine)
			local PosX = 275;
			local PosY =  332 +   Rank * 26
			mywindow:setPosition(PosX, PosY)
		end
	end
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyRankNumberTen");
	mywindow:setVisible(true)
	mywindow:setSize(24, 28)
	winMgr:getWindow("ResultBG"):addChildWindow(mywindow)	
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyRankNumberOne");
	mywindow:setVisible(true)
	mywindow:setSize(24, 28)
	winMgr:getWindow("ResultBG"):addChildWindow(mywindow)	
	
	
	function SetMyResult(isMine, Rank, Zen)
		SetMyRankTen((Rank+1) / 10)
		SetMyRankOne((Rank+1) % 10)
		
		for i=1, #tNumberTable  do
			local Front = math.pow (10, i + 1 - 1)
			local Curr = math.pow (10, i - 1)
			SetMyZen(Zen/Front, Zen/Curr % 10, tNumberTable[i], i - 1)
		end
	end
	
	
	function SetMyRankTen(RankTen)
		mywindow = winMgr:getWindow( "MyRankNumberTen");
		if RankTen <= 0 then
			mywindow:setVisible(false)
			return
		end
		
		mywindow:setTexture("Enabled", "UIData/fightClub_010.tga", 518 + 24 * RankTen , 31)
		mywindow:setPosition(357, 100)
	end
	
	function SetMyRankOne(RankOne)
		mywindow = winMgr:getWindow("MyRankNumberOne");
		if RankOne < 0 then
			mywindow:setVisible(false)
			return
		end
	
		mywindow:setTexture("Enabled", "UIData/fightClub_010.tga", 518 + 24 * RankOne , 31)
		mywindow:setPosition(375, 100)
	end
	
	function SetMyZen(BeforeNum, Zen, WindowName, Pos)
		if winMgr:getWindow(WindowName) == nil then
			return
		end
		
		mywindow = winMgr:getWindow(WindowName);
		if Zen <= 0 and BeforeNum <= 0 then
			mywindow:setVisible(false)
			return
		end
		mywindow:setTexture("Enabled", "UIData/fightClub_010.tga", 518 + 24 * Zen , 59)
		mywindow:setPosition(375 - Pos * 19, 137)
	end
	
	--------------------------------------------------------------------
	-- Rungsimun @ GameInside - Go MatchMaking Button
	--------------------------------------------------------------------
	-- g_GAME_WIN_SIZEX, g_GAME_WIN_SIZEY = GetCurrentResolution()
	mywindow = winMgr:createWindow("TaharezLook/Button", "GoMatchMakingButton")
	mywindow:setTexture("Normal", "UIData/MatchMakingRoom3.tga", 367, 1)
	mywindow:setTexture("Hover", "UIData/MatchMakingRoom3.tga", 367, 67)
	mywindow:setTexture("Pushed", "UIData/MatchMakingRoom3.tga", 367, 1)
	mywindow:setTexture("PushedOff", "UIData/MatchMakingRoom3.tga", 367, 67)
	mywindow:setTexture("Disabled", "UIData/MatchMakingRoom3.tga", 552, 1)
	-- mywindow:setAlign(3)
	mywindow:setWideType(7)
	mywindow:setPosition(837, 632)
	mywindow:setSize(183, 65)
	mywindow:setVisible(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", "OnGoMatchMaking")
	root:addChildWindow(mywindow)
	
	function OnGoMatchMaking()
		GoMatchMaking();
	end
	
	-- check
	
	
	
	
	-- function HideMatchMakingButton()
	-- 	isHideMatchMakingButton = true
	-- 	mywindow = winMgr:getWindow("GoMatchMakingButton")
	-- 	mywindow:setVisible(true)
	-- 	mywindow:setEnabled(false)
	-- end
	
	-- function ShowMatchMakingButton()
	-- 	isHideMatchMakingButton = false
	-- 	mywindow = winMgr:getWindow("GoMatchMakingButton")
	-- 	mywindow:setVisible(true)
	-- 	mywindow:setEnabled(true)
	-- end
	
	-- function OnUpdateGoMatchMakingButton()
	-- 	-- g_GAME_WIN_SIZEX, g_GAME_WIN_SIZEY = GetCurrentResolution()
	-- 	-- screenOffsetX = 0
	-- 	-- if g_GAME_WIN_SIZEX > 1024 then
	-- 	-- 	screenOffsetX = (g_GAME_WIN_SIZEX - 1024) / 2
	-- 	-- end
	
	-- 	-- mywindow = winMgr:getWindow("GoMatchMakingButton")
	-- 	-- if mywindow ~= nil then
	-- 	-- 	-- mywindow:setPosition(screenOffsetX + 837, g_GAME_WIN_SIZEY - 65 - 6 - 64)
	-- 	-- 	-- mywindow:setPosition(screenOffsetX + 630, g_GAME_WIN_SIZEY - 220)
	-- 	-- end
	-- end
	-- OnUpdateGoMatchMakingButton();
	
	
	end -- end of "WndVillage_WndVillage()"