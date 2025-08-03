

-----------------------------------------
-- Script Entry Point
-----------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
root:activate()


local gainTotalGran = 0
local TempTotalGran = 0
local b_HuntingArcade = 0

g_PARTY_TYPE_KILLNPC = PreCreateString_3378		--GetSStringInfo(HUNTING_UI)
g_PARTY_TYPE_ARCADERATE = PreCreateString_3379	--GetSStringInfo(ARCADE_UI)


--------------------------------------------------------------------
-- ä�� ���� ���� ���̱�
--------------------------------------------------------------------
root:addChildWindow(winMgr:getWindow('ChannelPositionBG'));
winMgr:getWindow('ChannelPositionBG'):setVisible(true);
winMgr:getWindow('ChannelPositionBG'):setWideType(1);
winMgr:getWindow('ChannelPositionBG'):setPosition(795, 2);
winMgr:getWindow('NewMoveServerBtn'):setVisible(false)
winMgr:getWindow('NewMoveExitBtn'):setVisible(true)
ChangeChannelPosition("")

root:setSubscribeEvent("MouseButtonUp", "OnRootMouseButtonUp")
function OnRootMouseButtonUp(args)
	root:removeChildWindow(winMgr:getWindow('pu_btnContainer'))
end

function WndQuest_RenderBackImage()	
	--drawer:drawTexture( 'UIData/GAmeImage.tga', 0, 0, 376,146, 0, 0)	
	--drawer:setTextColor(255,0, 255, 255)
	--drawer:setFont(g_STRING_FONT_GODIC, 30)		
	--drawer:drawText('NowLoading', 300,200)
end

local ScreenSizeX = 1024
local ScreenSizeY = 768

-- �̱�
local PARKGRADE= {['err'] = 0, [0]=90, 108, 126, 162}
local HOTELGRADE = {['err'] = 0, [0]=300, 360, 420, 540 }
local HALEMGRADE = {['err'] = 0, [0]=360, 432, 504, 648 }
local HROADGRADE = {['err'] = 0, [0]=420, 504, 588, 756 }
local SUBWAYGRADE = {['err'] = 0, [0]=480, 576, 672, 864 }
local HIDDENGRADE = {['err'] = 0, [0]=30, 36, 42, 54}
local TEMPLEGRADE = {['err'] = 0, [0]=360, 432, 504, 648 }
local ArcadeReslutGrade_EN = {['err'] = 0, [1002] = PARKGRADE, [1001] = HOTELGRADE, [1003] = HALEMGRADE, [1004] =HROADGRADE, [1005] = SUBWAYGRADE, [2000] =HIDDENGRADE, [1011] =TEMPLEGRADE} 

-- �±�
local PARKGRADE_THAI = {['err'] = 0, [0]=90, 108, 126, 162}
local HOTELGRADE_THAI = {['err'] = 0, [0]=300, 360, 420, 540 }
local HALEMGRADE_THAI = {['err'] = 0, [0]=360, 432, 504, 648 }
local HROADGRADE_THAI = {['err'] = 0, [0]=420, 504, 588, 756 }
local SUBWAYGRADE_THAI = {['err'] = 0, [0]=480, 576, 672, 864 }
local HIDDENGRADE_THAI = {['err'] = 0, [0]=30, 36, 42, 54}
local TEMPLEGRADE_THAI = {['err'] = 0, [0]=360, 432, 504, 648 }
local ArcadeReslutGrade_THAI = {['err'] = 0, [1002] = PARKGRADE_THAI, [1001] = HOTELGRADE_THAI, [1003] = HALEMGRADE_THAI, [1004] =HROADGRADE_THAI, [1005] = SUBWAYGRADE_THAI, [2000] =HIDDENGRADE_THAI, [1011] =TEMPLEGRADE_THAI} 

-- �ѱ�
local PARKGRADE_KOR = {['err'] = 0, [0]=60, 72, 84, 108}
local HOTELGRADE_KOR = {['err'] = 0, [0]=240, 288, 336, 432 }
local HALEMGRADE_KOR = {['err'] = 0, [0]=300, 360, 420 , 540 }
local HROADGRADE_KOR = {['err'] = 0, [0]=360, 432, 504, 648 }
local SUBWAYGRADE_KOR = {['err'] = 0, [0]=360, 432, 504, 648 }
local HIDDENGRADE_KOR = {['err'] = 0, [0]=30, 36, 42, 54}
local TEMPLEGRADE_KOR = {['err'] = 0, [0]=240, 288, 336, 432 }
local ArcadeReslutGrade_KOR = {['err'] = 0, [1002] = PARKGRADE_KOR, [1001] = HOTELGRADE_KOR, [1003] = HALEMGRADE_KOR, [1004] =HROADGRADE_KOR, [1005] = SUBWAYGRADE_KOR, [2000] =HIDDENGRADE_KOR, [1011] =TEMPLEGRADE_KOR} 


function WndQuest_RenderCharacter
			( deltatime
			, myslot
            , myteam
			, slot
			, team
			, friend
			, characterName
			, screenX
			, screenY
			, hp
			, sp
			, maxhp
			, maxsp
			, bArcadeEvent
			, NameR
			, NameG
			, NameB
			)
	
	local MONSTER_RACING = false
	local ARCADE = 1		-- 0:����, 1:����, 2:���ͷ��̽�, 3:������, 4:������(������)
	local isPenalty = false	-- �����̵�� ���Ƽ�� ����
	local penaltyValue = 0	-- ���Ƽ ���� ����
	local showAllSP = 0		-- ��� ���� sp����(���Ӹ� ����)
	local showAllItem = 0	-- ��� ���� ������ ����(���Ӹ� ����)
	local _1stItemType = 0
	local _2ndItemType = 0
	local exceptE = 0
	--DebugStr("11111NameR : " .. NameR .. "NameG : " .. NameR .. "NameB : " .. NameR);
	Common_RenderCharacter(deltatime, myslot, myteam, slot, team, characterName, 
		screenX, screenY, hp, sp, maxhp, maxsp, friend, isPenalty, penaltyValue, 
		ARCADE, showAllSP, showAllItem, _1stItemType, _2ndItemType, MONSTER_RACING, bArcadeEvent, exceptE, NameR
			, NameG, NameB)
	
end

-- ���� ������ �׸���
function WndQuest_AutoPostion(PostionValue)

	if PostionValue <= 0 then
		return
	end
	
	drawer = winMgr:getWindow("DefaultWindow"):getDrawer();
	
	-- ���� ���
	drawer:drawTexture("UIData/mainbarchat.tga", 250, 2 , 175, 20, 445, 666 );
	
	local ImagSize = PostionValue * 150 / 1000000
	
	-- ���� ����
	drawer:drawTexture("UIData/mainbarchat.tga", 271, 7 , ImagSize, 10, 620, 666 );
	
	local CurrentSize	= GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(PostionValue))
	local MaxSize		= GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(PostionMax))
	
	common_DrawOutlineText1(drawer, PostionValue, 385 - CurrentSize / 2, 7, 0,0,0,255, 255,255,255,255)
	
--	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
--	drawer:setTextColor(255,255,255,255)
--	drawer:drawText(PostionValue, 390 - CurrentSize / 2, 7)
	
--	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
--	drawer:setTextColor(255,255,255,255)
--	drawer:drawText(" / "..PostionMax, 390 - MaxSize / 2, 7)
end

-- ��Ƽ ���� ���� 
for i = 0, 2 do
	mywindow = winMgr:createWindow("TaharezLook/Button", "PartAutoPostion"..i)
	mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 512, 820)
	mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 512, 820)
	mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 512, 820)
	mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 512, 820)
	mywindow:setWideType(0)
	mywindow:setPosition(152, 121 + ( i * 72 ) )
	mywindow:setSize(32, 32)
	mywindow:setVisible(false)
	mywindow:subscribeEvent("MouseEnter", "WndQuest_Enter_AutoPostionToolTip")
	mywindow:subscribeEvent("MouseLeave", "WndQuest_Leave_AutoPostionToolTip")
	root:addChildWindow(mywindow)
end

function WndQuest_AutoPostionPartInit()
	for i = 0, 2 do
		winMgr:getWindow("PartAutoPostion"..i):setVisible(false)
	end
end

function WndQuest_AutoPostionPart(Index, bAutoPostion)
	if bAutoPostion == false then
		winMgr:getWindow( "PartAutoPostion"..Index ):setVisible(false)
	else
		winMgr:getWindow( "PartAutoPostion"..Index ):setVisible(true)
	end
end


function WndQuest_Enter_AutoPostionToolTip(args)
	local EnterWindow	= CEGUI.toWindowEventArgs(args).window
	local x, y			= GetBasicRootPoint(EnterWindow)
		
	-- �ڽ�Ƭ �ƹ�Ÿ ���� ���� ������ ���� 
	-- 0�� ���� �����ε����� -3�� ����. ��ġ�� �ȵ� ��
	GetToolTipBaseInfo(x + 65, y, 2, KIND_ITEM, -3, 10000071)	-- ������ ���� ������ �������ش�.
	SetShowToolTip(true)
end

function WndQuest_Leave_AutoPostionToolTip(args)
	SetShowToolTip(false)
end



-- �Ƿε� �׸���.
function WndQuest_ShowFatigue(fatigue, maxfatigue)

	

--	drawer = winMgr:getWindow("DefaultWindow"):getDrawer();
	-- �Ƿε� ���
--	drawer:drawTexture("UIData/hunting_003.tga", 395, 85	, 248, 20, 726, 592, WIDETYPE_5 );
	
	-- �Ƿε� ��
	local min = (fatigue * 10) /60
--	DrawEachNumberWide("UIData/Hunting_001.tga", min , 8, 590 , 90, 242, 574, 9, 12, 9, WIDETYPE_5)
	--DrawEachNumberWide("UIData/Hunting_001.tga", min , 1, 210 , 74, 242, 550, 9, 12, 9, WIDETYPE_0)
	--DrawEachNumberWide("UIData/Hunting_001.tga", min , 1, 210 , 84, 242, 574, 9, 12, 9, WIDETYPE_0)


	
	--DebugStr('fatigue:'..fatigue)
	--DebugStr('maxfatigue:'..maxfatigue)
	--[[
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
	
	--]]
	

end




--------------------------------------------------------------------

-- ������ �׸���

--------------------------------------------------------------------
g_eventTime4 = 0
local g_twinkleImage = 0
function WndQuest_RenderME(mySlot, mybone, hp, sp, maxhp, maxsp, deltatime, RESPAWN_TIME, reviveTick, level, characterName, isGameOver, 
			lifeCount, partyOwner, coinNum, gainCoin, remainReviveTick, countdownPassed, transform, myReviveTick, network, m_bAdvantageParty,
			bTournamentArcade, maxUseableLife, curUseableLife, isHuntingArcade, bArcadeEvent)
									
	-- ����ȭ�� �������� ���� �׸���
	local isPenalty = false	-- �����̵�� ���Ƽ�� ����
	local penaltyValue = 0	-- ���Ƽ ���� ����
	local exceptE = 0
	local visibleHPSP = 1
	Common_RenderME(mySlot, mybone, hp, sp, maxhp, maxsp, deltatime, RESPAWN_TIME, myReviveTick, level, characterName, 
					isGameOver, lifeCount, countdownPassed, transform, isPenalty, penaltyValue, bArcadeEvent, exceptE, visibleHPSP, bTournamentArcade)
	b_HuntingArcade = isHuntingArcade
	-- �Ʒ����� ȿ���� �ش�.
	--[[
	if bArcadeEvent == 1 then
		g_eventTime4 = g_eventTime4 + deltatime
		g_eventTime4 = g_eventTime4 % 60
	end
	--]]
	
	-- ������
	if bTournamentArcade == 0 then
		if mySlot == partyOwner then
			drawer:drawTexture("UIData/battleroom001.tga", 4, 84, 75, 24, 136, 837)
		end
	end
	--[[
	-- ��Ʈ��ũ
	local offset = 0
	if		 0 <= network and network <= 20 then	offset = 88
	elseif	20 <  network and network <= 40 then	offset = 68
	elseif	40 <  network and network <= 60 then	offset = 51
	elseif	60 <  network and network <= 80 then	offset = 34
	elseif	80 <  network and network <= 100 then	offset = 17
	else											offset = 17
	end
	drawer:drawTexture("UIData/dungeonmsg.tga", 7, 106, offset, 4, 284, 812)
	--]]
	
	-- ������
	local LIFE_POSX = 102-20
	drawer:drawTexture("UIData/dungeonmsg.tga", LIFE_POSX, 85, 18, 18, 570, 704)				-- ��Ʈ�̹���
	local lifeNum = lifeCount
	if lifeNum <= 0 then
		lifeNum = 0
	end
	drawer:drawTexture("UIData/dungeonmsg.tga", LIFE_POSX+19, 89, 10, 11, 503, 226)				-- X
	DrawEachNumber("UIData/dungeonmsg.tga", lifeNum, 1, LIFE_POSX+32, 88, 516, 224, 12, 14, 15)	-- ������
	
	
	-- ������
	if isHuntingArcade == 0 then
		--[[
		drawer:drawTexture("UIData/dungeonmsg.tga", LIFE_POSX+2, 78, 13, 16, 552, 705)				-- �����̹���
		drawer:drawTexture("UIData/dungeonmsg.tga", LIFE_POSX+19, 83, 10, 11, 503, 226)				-- X
		local _left, _right = DrawEachNumber("UIData/dungeonmsg.tga", coinNum, 1, LIFE_POSX+32, 82, 516, 224, 12, 14, 15)	-- ��������

		drawer:drawTexture("UIData/dungeonmsg.tga", _right+15, 80, 13, 17, 578, 158)				-- (
		drawer:drawTexture("UIData/dungeonmsg.tga", _right+24, 84, 10, 11, 493, 226)				-- +
		_left, _right = DrawEachNumber("UIData/dungeonmsg.tga", gainCoin, 1, _right+34, 82, 516, 224, 12, 14, 15)	-- ��������
		drawer:drawTexture("UIData/dungeonmsg.tga", _right+10, 80, 13, 17, 591, 158)				-- )
		--]]
	end
	-- ��������� �׾��� �� â�� �������� �ʴ´�.
	if isGameOver == 1 then
		return
	end
		

	-- ��鿡 ī��Ʈ �ٿ��� �����ش�.
	local textureY = 300
	if hp <= 0 then
		
		if bTournamentArcade == 1 then
			if curUseableLife <= 0 then
				return 
			end
		end
	
		g_twinkleImage = g_twinkleImage + deltatime
		g_twinkleImage = g_twinkleImage % 400
	
		-- ������ �ɸ��Ͱ� �׾��� �� ī��Ʈ�ٿ� �����ش�.
		if isHuntingArcade == 0 then
			if reviveTick > 0 then	
				local count = remainReviveTick / 60
				drawer:drawTexture("UIData/dungeonmsg.tga", 0, textureY, 1024, 157, 0, 509, WIDETYPE_5)					-- �׾��� �� �����̹���
				WndQuest_DrawEachNumberWide("UIData/numberUi001.tga", count, 8, 480, textureY-104, 0, 0, 80, 100, 80, WIDETYPE_5)	-- ī��Ʈ �ٿ�
				drawer:drawTexture("UIData/quest.tga", 340, textureY+25, 337, 99, 0, 763, WIDETYPE_5)					-- ��� �����ϰڽ��ϱ�?
			else
				
				-- �ٸ�ȭ�� ��ȯ(����Ʈ)
				if countdownPassed == 1 then
					if g_twinkleImage < 200 then
						drawer:drawTexture("UIData/quest.tga", 450, 420, 206, 36, 0, 607, WIDETYPE_5)
					else
						drawer:drawTexture("UIData/quest.tga", 450, 420, 206, 36, 206, 607, WIDETYPE_5)
					end
				end
			end
		else
			if myReviveTick > 0 then	
				local count = remainReviveTick / 60
				drawer:drawTexture("UIData/dungeonmsg.tga", 0, textureY, 1024, 157, 0, 509, WIDETYPE_5)					-- �׾��� �� �����̹���
				WndQuest_DrawEachNumberWide("UIData/numberUi001.tga", count, 8, 480, textureY-104, 0, 0, 80, 100, 80, WIDETYPE_5)	-- ī��Ʈ �ٿ�
				drawer:drawTexture("UIData/quest.tga", 340, textureY+25, 337, 99, 0, 763, WIDETYPE_5)					-- ��� �����ϰڽ��ϱ�?
			end
		end
		
		if countdownPassed == 1 then
			-- �����̽� ���(������)
			
			if g_twinkleImage < 200 then
				drawer:drawTexture("UIData/quest.tga", 450, 470, 206, 36, 0, 571, WIDETYPE_5)
			else
				drawer:drawTexture("UIData/quest.tga", 450, 470, 206, 36, 206, 571, WIDETYPE_5)
			end
			
			-- 1 ~ 10������ ��� ������ �Һ� �ȵȴٴ� ����
			if m_bAdvantageParty == 1 then
				if isHuntingArcade == 0 then
					drawer:drawTexture("UIData/party003.tga", 241, 560, 508, 103, 383, 542, WIDETYPE_5)
				end
			end
		else		
			if myReviveTick > 0 then
				-- �����̽� ���(������)
				if g_twinkleImage < 200 then
					drawer:drawTexture("UIData/quest.tga", 450, 470, 206, 36, 0, 571, WIDETYPE_5)
				else
					drawer:drawTexture("UIData/quest.tga", 450, 470, 206, 36, 206, 571, WIDETYPE_5)
				end
				
				-- 1 ~ 10������ ��� ������ �Һ� �ȵȴٴ� ����
				if bTournamentArcade == 0 and isHuntingArcade == 0 then
					if m_bAdvantageParty == 1  then
						drawer:drawTexture("UIData/party003.tga", 241, 560, 508, 103, 383, 542, WIDETYPE_5)
					end
				end
			end
		end
		
		-- ���� �׾��ִ� ���ȿ� 
		if myReviveTick > 0 then
			--����Ҽ� �ִ� �ִ� ������ ���� �׸�
			for i=0, maxUseableLife-1 do	
				drawer:drawTexture("UIData/dungeonmsg.tga", 500-(maxUseableLife*22)+(i*45), 524, 42, 35, 982, 313, WIDETYPE_5)
			end
			--����Ҽ� �ִ� ���� ������ ���� �׸�
			for i=0, curUseableLife-1 do
				drawer:drawTexture("UIData/dungeonmsg.tga", 500-(maxUseableLife*22)+(i*45), 524, 42, 35, 940, 313, WIDETYPE_5)
			end
			
			drawer:drawTexture("UIData/dungeonmsg.tga", 436, 564, 153, 19, 871, 349, WIDETYPE_5)
			WndQuest_DrawEachNumberWide("UIData/dungeonmsg.tga", curUseableLife, 8, 560, 566, 498, 262, 16, 15, 16, WIDETYPE_5)
		end
	end
end




local PartyLifeUiTick = 250
local CheckUi = 0
--------------------------------------------------------------------

-- ��Ƽ�� ���� �׸���

--------------------------------------------------------------------
local tFaceEffect = { ["err"]=0, [0]=0, 0, 0 }
function WndQuest_RenderParty(slot, partyNum, level, name, bone, hp, sp, maxhp, maxsp, partyOwner, network, lifeCount, coinNum, deltaTime, 
			bDie, transform, visibleCharacter, isHuntingArcade, curUseableLife, bArcadeEvent)
	
	--DebugStr('slot:'..slot)
	--DebugStr('partyNum:'..partyNum)
	
	local FONT_SIZE = 12
	if IsKoreanLanguage() then
		FONT_SIZE = 11
	end
	
	if maxhp <= 0 then
		return
	end
	if maxsp <= 0 then
		maxsp = 3000
	end
	
	local teamRealWidth		= 83
	local teamHPWidth		= hp * teamRealWidth / maxhp
	local teamOldHPWidth	= lasthp[slot] * teamRealWidth / maxhp
	local teamSPWidth		= sp * teamRealWidth / maxsp
	local teamOldSPWidth	= lastsp[slot] * teamRealWidth / maxsp
	
	-- ���� ���� 152(partyNum�� 0 ~ 2���� �´�, slot���� �ٸ���)
	local spacing = 72*partyNum-35

	-- ���� �̹���
	--drawer:drawTexture("UIData/GameNewImage.tga", 276+spacing, 4, 146, 57, 875, 3)
	drawer:drawTexture("UIData/mainBG_Button004.tga", 4, spacing+150 , 145, 60, 0, 366)
	
	
	--[[
	-- ��Ʈ��ũ
	local offset = 0
	if		 0 <= network and network <= 20 then	offset = 86
	elseif	20 <  network and network <= 40 then	offset = 68
	elseif	40 <  network and network <= 60 then	offset = 51
	elseif	60 <  network and network <= 80 then	offset = 34
	elseif	80 <  network and network <= 100 then	offset = 17
	else											offset = 17
	end
	drawer:drawTexture("UIData/dungeonmsg.tga", 8, spacing+215, offset, 4, 284, 812)
	--]]
	
	-- HP, SP
	drawer:drawTexture("UIData/mainBG_Button004.tga", 58, spacing+170, teamHPWidth, 8, 145, 370)
	drawer:drawTexture("UIData/mainBG_Button004.tga", 58, spacing+170, teamOldHPWidth, 8, 145, 362)
	drawer:drawTexture("UIData/mainBG_Button004.tga", 58, spacing+182, teamSPWidth, 8, 145, 386)
	drawer:drawTexture("UIData/mainBG_Button004.tga", 58, spacing+182, teamOldSPWidth, 8, 145, 378)
	
	--[[
	if bArcadeEvent == 1 then
		if g_eventTime4 < 30 then
			drawer:drawTextureA("UIData/GameNewImage.tga", 334+spacing, 17, teamSPWidth, 7, 693, 753, 200)
		end
	end
	--]]

	----------------------------------------
	--	�ɸ��� ��
	----------------------------------------
	if transform == 501 then
	 transform = 26
	elseif transform == 502 then
	 transform = 27
	elseif transform == 503 then
	 transform = 28
	elseif transform == 504 then
	 transform = 29
	elseif transform == 505 then
	 transform = 30
	elseif transform == 506 then
	 transform = 31
	elseif transform == 507 then
	 transform = 32
	end
	if transform <= 0 then
	
		-- ���� ������ ��
		if hp <= 0 then	
			-- ��(�׾��� ��)
			if bDie == 1 then
				tFaceEffect[partyNum] = tFaceEffect[partyNum] + deltaTime
				tFaceEffect[partyNum] = tFaceEffect[partyNum] % 200
				
				if tFaceEffect[partyNum] < 100 then
					drawer:drawTexture("UIData/GameImage.tga", 8, spacing+157, 46, 46, 49, 595+bone*49)
				end
			
			-- �� X��
			else
				drawer:drawTexture("UIData/GameImage.tga", 8, spacing+157, 46, 46, 98, 595+bone*49)
			end
			
		-- ��(���)
		else
			drawer:drawTexture("UIData/GameImage.tga", 8, spacing+157 , 46, 46, 0, 595+bone*49)
		end
	else
		if hp <= 0 then	
			
			-- ��(�׾��� ��)
			if bDie == 1 then
				tFaceEffect[partyNum] = tFaceEffect[partyNum] + deltaTime
				tFaceEffect[partyNum] = tFaceEffect[partyNum] % 200
				
				if tFaceEffect[partyNum] < 100 then
					drawer:drawTexture("UIData/"..tTransformSmallFileName[transform], 8, spacing+157, 46, 46, tTransformSmallTexX[transform]+49, tTransformSmallTexY[transform])
				end
			
			-- �� X��
			else
				drawer:drawTexture("UIData/"..tTransformSmallFileName[transform], 8, spacing+157, 46, 46, tTransformSmallTexX[transform]+98, tTransformSmallTexY[transform])
			end
			
		-- ��(���)
		else
			drawer:drawTexture("UIData/"..tTransformSmallFileName[transform], 8, spacing+157, 46, 46, tTransformSmallTexX[transform], tTransformSmallTexY[transform])
		end
	end
	
	-- ����
	drawer:setFont(g_STRING_FONT_GULIMCHE, FONT_SIZE)
	drawer:setTextColor(255,205,86,255)
	drawer:drawText("Lv." .. level, 15,  spacing+155)
	
	-- �̸�
	drawer:setTextColor(255,255,255,255)
	drawer:drawText(name, 65, spacing+155)
	
	-- ������
	if slot == partyOwner then
		drawer:drawTexture("UIData/GameNewImage.tga",  8, spacing+200, 46, 17, 967, 66)
	end
		
	-- ������
	drawer:drawTexture("UIData/dungeonmsg.tga", 60, spacing+190, 18, 18, 570, 704)				-- ��Ʈ�̹���
	local lifeNum = lifeCount
	if lifeNum <= 0 then
		lifeNum = 0
	end
	drawer:drawTexture("UIData/dungeonmsg.tga", 81, spacing+195, 10, 11, 503, 226)				-- X
	DrawEachNumber("UIData/dungeonmsg.tga", lifeNum, 1, 96, spacing+193, 516, 224, 12, 14, 15)	-- ������
	if isHuntingArcade == 0 then
		-- ����
		--[[
		drawer:drawTexture("UIData/dungeonmsg.tga", 63, spacing+213, 13, 16, 552, 705)				-- �����̹���
		drawer:drawTexture("UIData/dungeonmsg.tga", 85, spacing+215, 10, 11, 503, 226)				-- X
		
		drawer:drawTexture("UIData/dungeonmsg.tga", 99, spacing+215, 11, 11, 502, 213)				-- *
		drawer:drawTexture("UIData/dungeonmsg.tga", 99, spacing+215, 11, 11, 502, 213)				-- *
		
		drawer:drawTexture("UIData/dungeonmsg.tga", 200, 300, 80, 13, 17, 578, 158)				-- (
		
		drawer:drawTexture("UIData/dungeonmsg.tga", 131, spacing+213, 84, 10, 11, 493, 226)				-- +
		_left, _right = DrawEachNumber("UIData/dungeonmsg.tga", coinNum, 1, 100, spacing+213, 516, 224, 12, 14, 15)	-- ��������
		--drawer:drawTexture("UIData/dungeonmsg.tga", _right+10, 80, 13, 17, 591, 158)				-- )
		--]]
	end
	
	-- ���� ���� ���� �ִ� �ɸ���
	if visibleCharacter == 1 then
		--drawer:drawTexture("UIData/GameNewImage.tga", 273+spacing, 1, 153, 63, 721, 0)
	end
		
	if PartyLifeUiTick == 250  then
		CheckUi = 0
	end
	
	if PartyLifeUiTick == 50  then
		CheckUi = 1
	end
	
	if CheckUi == 0 then
		PartyLifeUiTick = PartyLifeUiTick - 5
	else
		PartyLifeUiTick = PartyLifeUiTick + 5
	end
	
	if curUseableLife > 0 then
		if hp <= 0 then	
			
			if partyNum == 0 then
				if CheckUi == 0 then
					drawer:drawTexture("UIData/GameNewImage2.tga", 160, spacing+155, 93, 44, 931, 577)
				else
					drawer:drawTexture("UIData/GameNewImage2.tga", 160, spacing+155, 93, 44, 931, 621)
				end
			elseif partyNum == 1 then
				if CheckUi == 0 then
					drawer:drawTexture("UIData/GameNewImage2.tga", 160, spacing+155, 93, 44, 931, 665)
				else
					drawer:drawTexture("UIData/GameNewImage2.tga", 160, spacing+155, 93, 44, 931, 709)
				end
			else
				if CheckUi == 0 then
					drawer:drawTexture("UIData/GameNewImage2.tga", 160, spacing+155, 93, 44, 838, 577) 
				else
					drawer:drawTexture("UIData/GameNewImage2.tga", 160, spacing+155, 93, 44, 838, 621) 
				end
			end
			
			drawer:drawTexture("UIData/dungeonmsg.tga", 220, spacing+165, 10, 11, 503, 226)	-- X
			DrawEachNumber("UIData/dungeonmsg.tga", curUseableLife, 1, 230, spacing+163, 516, 224, 12, 14, 15)	-- ������
		
		end
	end
	
end






--------------------------------------------------------------------

-- ������ ����

--------------------------------------------------------------------
local g_itemSlotX_0 = 100
local g_itemSlotX_1 = 160
local g_itemSlotX_2 = 220
local g_itemSlotY	= 78
function WndQuest_RenderStartItemSlot(bSlot0, bSlot1, bSlot2)
	
	--[[
	if bSlot0 == 1 then
		drawer:drawTexture("UIData/GameNewImage.tga", g_itemSlotX_0, g_itemSlotY, 49, 51, 550, 104)
	else
		drawer:drawTexture("UIData/GameNewImage.tga", g_itemSlotX_0, g_itemSlotY, 49, 51, 604, 104)
	end
	
	if bSlot1 == 1 then
		drawer:drawTexture("UIData/GameNewImage.tga", g_itemSlotX_1, g_itemSlotY, 49, 51, 550, 104)
	else
		drawer:drawTexture("UIData/GameNewImage.tga", g_itemSlotX_1, g_itemSlotY, 49, 51, 604, 104)
	end
	
	if bSlot2 == 1 then
		drawer:drawTexture("UIData/GameNewImage.tga", g_itemSlotX_2, g_itemSlotY, 49, 51, 550, 104)
	else
		drawer:drawTexture("UIData/GameNewImage.tga", g_itemSlotX_2, g_itemSlotY, 49, 51, 604, 104)
	end
	--]]
end






--------------------------------------------------------------------

-- ���� ���� �׸���

--------------------------------------------------------------------
local myInfoPosY = 120
function WndQuest_RenderMyInfo(doubleAtk, teamAtk, evade, damagedDamage, deltaTime)
	
	-- ���� �׸���
	--drawer:drawTexture("UIData/dungeonmsg.tga", 758, 36, 262, 52, 276, 852+myInfoPosY)

	--local _infoX = 838
	--local _left, _right
	
	-- ��������
	--DrawEachNumber("UIData/dungeonmsg.tga", doubleAtk, 8, _infoX+7, 164-myInfoPosY, 498, 281, 13, 15, 16)
	
	-- ������
	--DrawEachNumber("UIData/dungeonmsg.tga", teamAtk, 8, _infoX+7, 184-myInfoPosY, 498, 281, 13, 15, 16)

	-- ȸ��
	--DrawEachNumber("UIData/dungeonmsg.tga", evade, 8, _infoX+131, 165-myInfoPosY, 498, 281, 13, 15, 16)
	
	-- �ǰ�
	--_left, _right = DrawEachNumber("UIData/dungeonmsg.tga", damagedDamage, 8, _infoX+130, 184-myInfoPosY, 498, 262, 13, 15, 16)
--	drawer:drawTexture("UIData/dungeonmsg.tga", _left-13, 181-myInfoPosY, 17, 15, 690, 251)
	
end
			






--------------------------------------------------------------------

-- �ð� �׸���

--------------------------------------------------------------------
tTime = { ["err"]=0, [0]=515, 550, 586, 622, 657, 693, 729, 766, 801, 836 }
local g_bStop	 = false
local g_min		 = 0
local g_sec		 = 0
local g_milliSec = 0
function WndQuest_RenderTime(min, sec, milliSec, bShowDanger)

	-- Danger�ð����� �ð��� ���߰� �����ֱ� ���ؼ�
	if bShowDanger > 0 then
		if g_bStop == false then
			g_bStop		= true
			g_min		= min
			g_sec		= sec
			g_milliSec	= milliSec			
		end
	else
		g_bStop		= false
		g_min		= min
		g_sec		= sec
		g_milliSec	= milliSec
	end

	-- ���� �׸���
	--drawer:drawTexture("UIData/dungeonmsg.tga", 758, 4, 262, 32, 276, 820)
		
	local startPos1	= 810
	local startPos2	= 832
	local changePosY = 40
	-- minute
	drawer:drawTexture("UIData/dungeonmsg.tga", startPos1, 34+changePosY, 38, 26, tTime[g_min/10], 192, 1)
	drawer:drawTexture("UIData/dungeonmsg.tga", startPos2, 34+changePosY, 38, 26, tTime[g_min%10], 192, 1)
	
	-- ' �� :
	drawer:drawTexture("UIData/dungeonmsg.tga", startPos2+23, 34+changePosY, 16, 26, 891, 192, 1)
	drawer:drawTexture("UIData/dungeonmsg.tga", startPos2+30, 34+changePosY, 16, 26, 870, 192, 1)
	
	
	-- second
	drawer:drawTexture("UIData/dungeonmsg.tga", startPos1+65, 34+changePosY, 38, 26, tTime[g_sec/10], 192, 1)
	drawer:drawTexture("UIData/dungeonmsg.tga", startPos2+65, 34+changePosY, 38, 26, tTime[g_sec%10], 192, 1)
	
	-- ' �� .
	drawer:drawTexture("UIData/dungeonmsg.tga", startPos2+23+65, 34+changePosY, 16, 26, 891, 192, 1)
	drawer:drawTexture("UIData/dungeonmsg.tga", startPos2+30+65, 47+changePosY, 16, 13, 870, 205, 1)
	
	
	-- milli second
	drawer:drawTexture("UIData/dungeonmsg.tga", startPos1+130, 34+changePosY, 38, 26, tTime[g_milliSec/10], 192, 1)
	drawer:drawTexture("UIData/dungeonmsg.tga", startPos2+130, 34+changePosY, 38, 26, tTime[g_milliSec%10], 192, 1)
	
	-- "
	drawer:drawTexture("UIData/dungeonmsg.tga", startPos2+24+130, 34+changePosY, 16, 26, 911, 192, 1)
	
end


function WndQuest_HuntingRenderTime(min, sec, milliSec, bShowDanger)
	
	
	-- Danger�ð����� �ð��� ���߰� �����ֱ� ���ؼ�
	
	g_bStop		= false
	g_min		= min
	g_sec		= sec
	g_milliSec	= milliSec
	

	-- ���� �׸���
	--drawer:drawTexture("UIData/dungeonmsg.tga", 758, 4, 262, 32, 276, 820, WIDETYPE_1 )
		
	local startPos1	= 814-380
	local startPos2	= 836-380
	local startPosy = 54
	
	-- minute
	drawer:drawTexture("UIData/dungeonmsg.tga", startPos1, startPosy, 38, 26, tTime[g_min/10], 192, WIDETYPE_5)
	drawer:drawTexture("UIData/dungeonmsg.tga", startPos2, startPosy, 38, 26, tTime[g_min%10], 192, WIDETYPE_5)
	
	-- ' �� :
	drawer:drawTexture("UIData/dungeonmsg.tga", startPos2+23, startPosy, 16, 26, 891, 192, WIDETYPE_5)
	drawer:drawTexture("UIData/dungeonmsg.tga", startPos2+30, startPosy, 16, 26, 870, 192, WIDETYPE_5)
	
	
	-- second
	drawer:drawTexture("UIData/dungeonmsg.tga", startPos1+65, startPosy, 38, 26, tTime[g_sec/10], 192, WIDETYPE_5)
	drawer:drawTexture("UIData/dungeonmsg.tga", startPos2+65, startPosy, 38, 26, tTime[g_sec%10], 192, WIDETYPE_5)
	
	-- ' �� .
	drawer:drawTexture("UIData/dungeonmsg.tga", startPos2+23+65, startPosy, 16, 26, 891, 192, WIDETYPE_5)
	drawer:drawTexture("UIData/dungeonmsg.tga", startPos2+30+65, startPosy, 16, 13, 870, 205, WIDETYPE_5)
	
	
	-- milli second
	drawer:drawTexture("UIData/dungeonmsg.tga", startPos1+130, startPosy, 38, 26, tTime[g_milliSec/10], 192, WIDETYPE_5)
	drawer:drawTexture("UIData/dungeonmsg.tga", startPos2+130, startPosy, 38, 26, tTime[g_milliSec%10], 192, WIDETYPE_5)
	
	-- "
	drawer:drawTexture("UIData/dungeonmsg.tga", startPos2+24+130, startPosy, 16, 26, 911, 192, WIDETYPE_5)
	
end


--------------------------------------------------------------------

-- ���� ������ �׸���

--------------------------------------------------------------------
local g_bossLastHp		= 0
local g_bossLastHpTime	= 0
local g_bossLastSp		= 0
local g_bossLastSpTime	= 0
local g_bossEffect		= 0
local g_bossHpAccel		= 100
local g_bossDeadTime	= 0
local g_bossGaugeStart	= false
local g_bossAlpha		= 0
function WndQuest_RenderBossInfo(deltatime, name, bossImage, hp, maxhp, sp, maxsp, isHuntingArcade)

	if g_bossGaugeStart == false then
		return
	end
	
	if g_bossDeadTime >= 5000 then
		return
	end
	
	if maxhp == 0 then
		return
	end
	if maxsp == 0 then
		maxsp = 3000
	end
	
	if g_bossDeadTime <= 0 then
		g_bossAlpha = g_bossAlpha + deltatime
		if g_bossAlpha >= 255 then
			g_bossAlpha = 255
		end
	end
	
	
	-- ���� ������ ����
	if g_bossDeadTime >= 3000 then
		g_bossAlpha = g_bossAlpha - (g_bossDeadTime-3000)/3
		if g_bossAlpha <= 0 then
			g_bossAlpha = 0
		end
	end
	drawer:drawTextureA("UIData/quest.tga", 393, 66, 320, 47, 704, 637, g_bossAlpha, WIDETYPE_5)

	local WIDTH_HP  = 304
	local WIDTH_SP  = 260
	
	
	---------
	-- ��
	---------
	if hp <= 0 then
		g_bossEffect = g_bossEffect + deltatime
		g_bossEffect = g_bossEffect % 200
		if g_bossEffect < 100 then
			drawer:drawTextureA(bossImage, 326, 22, 75, 86, 300, 108, g_bossAlpha, WIDETYPE_5)
		else
			drawer:drawTextureA(bossImage, 326, 22, 75, 86, 375, 108, g_bossAlpha, WIDETYPE_5)
		end
		
	elseif 0 < hp and hp <= 3000 then
		g_bossEffect = g_bossEffect + deltatime
		g_bossEffect = g_bossEffect % 400
		if g_bossEffect < 200 then
			drawer:drawTextureA(bossImage, 326, 22, 75, 86, 150, 108, g_bossAlpha, WIDETYPE_5)
		else
			drawer:drawTextureA(bossImage, 326, 22, 75, 86, 225, 108, g_bossAlpha, WIDETYPE_5)
		end
	else
		drawer:drawTextureA(bossImage, 326, 22, 75, 86, 150, 108, g_bossAlpha, WIDETYPE_5)
	end
	
	
	
	---------
	-- �̸�
	---------
	drawer:drawTextureA(bossImage, 397, 31, 312, 37, 0, 71, g_bossAlpha, WIDETYPE_5)
--	drawer:setFont(g_STRING_FONT_GULIMCHE, 14)
--	drawer:setTextColor(255, 255, 255, g_bossAlpha)
--	local r, g, b = NameColorByMaxHP(maxhp)
--	common_DrawOutlineText1(drawer, name, 397, 58, 0,0,0,g_bossAlpha, r,g,b,g_bossAlpha, WIDETYPE_5)
	
	
	---------
	-- hp
	---------
	g_bossLastHpTime	= g_bossLastHpTime + deltatime
	local change_hp		= g_bossLastHpTime / g_bossHpAccel
	g_bossLastHp		= g_bossLastHp - change_hp
	
	-- ���ӵ��� ����
	if g_bossHpAccel > 1 then
		g_bossHpAccel = g_bossHpAccel - 1
	end

	if g_bossLastHp < hp then
		g_bossLastHp	 = hp
		g_bossLastHpTime = 0
		g_bossHpAccel	 = 100
	end

	-- ��5���� ���鼭 0 <= hp < 6000, 6000 <= hp < 12000 �̷������� 5���� üũ�ؾ� �Ѵ�.
	-- remain+(divide-i)�� �ϰԵǸ� �׻� 0 ~ 6000������ ���� ������ �ȴ�
	local MAXHP	= 12000
	if maxhp < 12000 then
		MAXHP = maxhp
	end
	
	if maxhp > 60000 then
		MAXHP = maxhp / 5
	end
	
	local remain1 = g_bossLastHp % MAXHP
	local remain2 = hp % MAXHP	
	local divide  = hp / MAXHP
	
	for i=0, 4 do
		if divide-i >= 0 then
			local changedHP = (remain1+(divide-i)*MAXHP) * WIDTH_HP / MAXHP
			local currentHP = (remain2+(divide-i)*MAXHP) * WIDTH_HP / MAXHP

			drawer:drawTextureA("UIData/quest.tga", 401, 71, changedHP, 34, 704, 854+i*34, g_bossAlpha, WIDETYPE_5)	-- ��ȭ�ϴ� hp
			drawer:drawTextureA("UIData/quest.tga", 401, 71, currentHP, 34, 704, 684+i*34, g_bossAlpha, WIDETYPE_5)	-- ���̴� hp
		end
	end

	
	---------
	-- SP
	---------
	--[[
	g_bossLastSpTime = g_bossLastSpTime + deltatime
	local change_sp	 = g_bossLastSpTime / 20

	g_bossLastSp = g_bossLastSp - change_sp	

	if g_bossLastSp < sp then
		g_bossLastSp = sp
		g_bossLastSpTime = 0
	end
	
	local changedSP	= g_bossLastSp * WIDTH_SP / maxsp
	local currentSP	= sp * WIDTH_SP / maxsp	
	drawer:drawTextureA("UIData/quest.tga", 98, 706, changedSP, 12, 272, 558, g_bossAlpha)	-- ��ȭ�ϴ� sp
	drawer:drawTextureA("UIData/quest.tga", 98, 706, currentSP, 12, 0, 558, g_bossAlpha)	-- ���̴� sp
	--]]
end








----------------------------------------------------------

-- ���� ���� �׸���

----------------------------------------------------------
local g_startTime	= 0
local g_startPos	= 0
local g_bstart		= true
local g_currentStage = 0
local g_onceSetup = true
local g_StartAlpha = 255
local TextPosX=  622
local TextPosY = 56

function WndQuest_InitValue()
	g_startTime		= 0
	g_startPos		= 0
	g_bstart		= true
	g_currentStage	= 0
	g_onceSetup		= true
	g_StartAlpha	= 255
	TextPosX		=  622
	TextPosY		= 56
end

-- ����� ���� ȭ��
function WndQuest_HuntingRenderStart(deltaTime , dungeonNumber)
	
	TextPosX = 622
	if dungeonNumber == 4001 then
		TextPosY = 170
	elseif dungeonNumber == 4002 then
		TextPosY = 284
	elseif dungeonNumber == 4003 then
		TextPosY = 398
	elseif dungeonNumber == 4004 then
		TextPosY = 512
	elseif dungeonNumber == 4011 then
		TextPosX = 220
		TextPosY = 56
	elseif dungeonNumber == 4100 then
		TextPosX = 220
		TextPosY = 170
	else
		TextPosY = 56
	end
	
	
	local START_TICK = 2000	
	g_startTime = deltaTime
	
	if g_startTime >= START_TICK then
		if g_bstart then
			PlaySound("sound/Dungeon/Dungeon_Start.wav")
			g_bstart = false
		end		
		
		local startTime = g_startTime - START_TICK
		
		-- 1500������ ����� ����.
		if 0 <= startTime and startTime <= 1500 then		
			g_startPos = Effect_Elastic_EaseOut(startTime, -600, 1050, 1500, 0, 0)
		elseif startTime > 2300 then
			if g_StartAlpha > 0 then
				g_StartAlpha = g_StartAlpha - 5
			end
		end
		drawer:drawTextureA("UIData/hunting_001.tga", g_startPos-100, 200, 402, 114 , TextPosX, TextPosY, g_StartAlpha, WIDETYPE_5 )
		--drawer:drawTextureA("UIData/hunting_001.tga", g_startPos-100, 200, 622, TextPosY , 402, 114, g_StartAlpha)
	end	
end

function WndQuest_RenderStart(deltaTime, currentCut, totalCut, isTournamentArcade)
	
	if currentCut+1 >= totalCut then
		return
	end
	
	-- ���� �������� �׸���
	if isTournamentArcade == 1 then

		if g_onceSetup then
			g_onceSetup		= false
			g_currentStage	= currentCut + 1
		end

		drawer:drawTexture("UIData/Tournament001.tga", 390, 16, 158, 47, 610, 655, WIDETYPE_5)
		WndQuest_DrawEachNumberWide("UIData/Tournament001.tga", g_currentStage, 1, 570, 21, 754, 710, 27, 39, 27, WIDETYPE_5)
	end
	
	local START_TICK = 1000	
	g_startTime = deltaTime
	
	if g_startTime >= START_TICK then
		if g_bstart then
			PlaySound("sound/Dungeon/Dungeon_Start.wav")
			g_bstart = false
		end		
		
		local startTime = g_startTime - START_TICK
		
		-- 1500������ ����� ����.
		if 0 <= startTime and startTime <= 1500 then		
			g_startPos = Effect_Elastic_EaseOut(startTime, -600, 900, 1500, 0, 0)
		
		-- ���Ŀ� 800�� �Ǹ� �������.
		elseif 1500 < startTime and startTime <= 2300 then		
			g_startPos = Effect_Back_EaseIn(startTime-1500, 290, 1600, 800, 0)
			
		-- 2300�� ������ �����
		elseif startTime > 2300 then
			g_startTime = 2400
			g_startPos	= 2000
		--	g_bstart = true
			return
		end	
		
		-- ��ŸƮ
		if isTournamentArcade == 1 then
			drawer:drawTexture("UIData/numberUi001.tga", g_startPos-100, 200, 422, 85, 240, 225, WIDETYPE_5)
			WndQuest_DrawEachNumberWide("UIData/numberUi001.tga", currentCut+1, 1, g_startPos+360, 200, 134, 140, 89, 85, 89, WIDETYPE_5)
		else
			if currentCut == 0 then
				drawer:drawTexture("UIData/dungeonmsg.tga", g_startPos, 200, 460, 83, 5, 4, WIDETYPE_5)
			else
				drawer:drawTexture("UIData/numberUi001.tga", g_startPos-100, 200, 422, 85, 240, 225, WIDETYPE_5)
				WndQuest_DrawEachNumberWide("UIData/numberUi001.tga", currentCut+1, 1, g_startPos+360, 200, 134, 140, 89, 85, 89, WIDETYPE_5)
			end
		end
	end	
end





----------------------------------------------------------

-- Danger ����Ʈ

----------------------------------------------------------
local g_leftDanger			= -461
local g_rightDanger			= 1024
local g_startDangerTime		= 0
local g_startDangerPos		= 0
local g_startDangerEffect	= 0
local g_endDangerTime		= 0
local g_endDangerPos		= 0
function WndQuest_RenderDanger(dangerState, deltaTime)
	
	local START_TICK = 1000
	local END_TICK	 = 200
	
	-- danger ����
	if dangerState == 1 then
		g_startDangerTime = g_startDangerTime + deltaTime
		if g_startDangerTime >= START_TICK then
			local startTime = g_startDangerTime - START_TICK
			if 0 <= startTime and startTime <= 1500 then
				g_startDangerPos = Effect_Elastic_EaseOut(startTime, -461, 1204, 1500, 0, 0)
				drawer:drawTexture("UIData/dungeonmsg.tga", g_leftDanger+g_startDangerPos, 150, 461, 42, 484, 4, WIDETYPE_5)
				drawer:drawTexture("UIData/dungeonmsg.tga", g_rightDanger-g_startDangerPos, 192, 461, 41, 484, 46, WIDETYPE_5)
			else
				g_startDangerEffect = g_startDangerEffect + deltaTime
				g_startDangerEffect = g_startDangerEffect % 500
				if g_startDangerEffect < 250 then
					drawer:drawTexture("UIData/dungeonmsg.tga", 282, 150, 461, 83, 484, 4, WIDETYPE_5)
				end
			end
		end
		
		
		
	-- danger �������
	elseif dangerState == 2 then
		g_endDangerTime = g_endDangerTime + deltaTime
		if g_endDangerTime >= END_TICK then
			local endTime = g_endDangerTime - END_TICK
			if 0 <= endTime and endTime <= 800 then
			
				g_endDangerPos = Effect_Back_EaseIn(endTime, 290, 1600, 800, 0)
				drawer:drawTexture("UIData/dungeonmsg.tga", g_endDangerPos, 150, 461, 83, 484, 4 ,WIDETYPE_5)
				
			-- 800�� ������ �����
			elseif endTime < 800 then
			
				g_endDangerTime = endTime + END_TICK
				g_endDangerPos	= 1500
				
			end
		else
			g_startDangerEffect = g_startDangerEffect + deltaTime
			g_startDangerEffect = g_startDangerEffect % 500
			if g_startDangerEffect < 250 then
				drawer:drawTexture("UIData/dungeonmsg.tga", 282, 150, 461, 83, 484, 4, WIDETYPE_5)
			end
		end
	end

end





----------------------------------------------------------

-- ���� ���� ����Ʈ(Clear)

----------------------------------------------------------
local t_ClearScaleX = { ["err"]=0, [0]=255*10, 255*10, 255*10, 255*10, 255*10, 255*10 }
local t_ClearScaleY = { ["err"]=0, [0]=255*10, 255*10, 255*10, 255*10, 255*10, 255*10 }
local t_ClearAlpha  = { ["err"]=0, [0]=0, 0, 0, 0, 0, 0 }
local t_ClearAngle  = { ["err"]=0, [0]=0, 0, 0, 0, 0, 0 }
local t_ClearEffect = { ["err"]=0, [0]=0, -1, -1, -1, -1, -1 }
local t_ClearTexX	= { ["err"]=0, [0]=5, 102, 198, 292, 387, 480 }
--local t_ClearSizeX	= { ["err"]=0, [0]=87, 82, 86, 86, 88, 74 }
local t_ClearSizeX	= { ["err"]=0, [0]=97, 96, 94, 95, 93, 74 }
local t_ClearPosX	= { ["err"]=0, [0]=289, 385, 480, 574, 668, 761 }
local g_ClearSound  = true
function Effect_DungeonClear(deltaTime)

	for i=0, #t_ClearEffect do
		if t_ClearEffect[i] == 0 then
			
			if g_ClearSound then
				PlaySound("sound/Dungeon/Dungeon_Clear.wav")
				PlaySound('sound/System/System_Clear.wav')
				g_ClearSound = false
			end
		
			-- ó���� ũ�� ���� �۾�����, ȸ���ϰ�, ���İ� �����Ѵ�.
			t_ClearScaleX[i] = t_ClearScaleX[i] - (deltaTime*6)
			if t_ClearScaleX[i] <= 255 then
				t_ClearScaleX[i] = 255
				t_ClearEffect[i] = 1
			else
				if t_ClearScaleX[i] <= 255*8 then
					if i < 5 then
						t_ClearEffect[i+1] = 0
					end
				end
			end
			
			t_ClearScaleY[i] = t_ClearScaleY[i] - (deltaTime*6)
			if t_ClearScaleY[i] <= 255 then
				t_ClearScaleY[i] = 255
			end
			
			t_ClearAlpha[i] = t_ClearAlpha[i] + (deltaTime/2)
			if t_ClearAlpha[i] >= 255 then
				t_ClearAlpha[i] = 255
			end
			
			t_ClearAngle[i] = t_ClearAngle[i] + (deltaTime*10)
			if t_ClearAngle[i] >= 4000 then
				t_ClearAngle[i] = 4000
			end			
			
			drawer:drawTextureWithScale_Angle_Offset("UIData/dungeonmsg.tga", t_ClearPosX[i], 343, t_ClearSizeX[i], 83, t_ClearTexX[i], 99,
																t_ClearScaleX[i], t_ClearScaleY[i], t_ClearAlpha[i], t_ClearAngle[i], 8,261,249, WIDETYPE_5)
			
		elseif t_ClearEffect[i] == 1 then
		
			drawer:drawTextureWithScale_Angle_Offset("UIData/dungeonmsg.tga", t_ClearPosX[i], 343, t_ClearSizeX[i], 83, t_ClearTexX[i], 99,
																255, 255, 255, 0, 8,261,249, WIDETYPE_5)
		end
	end

end




----------------------------------------------------------

-- ���ӻ��� �׸���

----------------------------------------------------------
local g_failedTime	= 0
local g_failedPos	= 0
local g_failedSound = true
local g_gogoSound	= true
local g_nextSound   = true
local g_nextTime	= 0
function WndQuest_ClearGoGoSound()
	g_gogoSound = true
end
tCount = { ["err"]=0, 212, 324, 436 }

local START_COUNT_POSX = 590
local END_COUNT_POSX = 900

local g_countPosX = START_COUNT_POSX
local g_countAlpha = 100
local g_lastCount1 = 0
local g_lastCount2 = 0

function WndQuest_RenderDungeonState(state, deltaTime, goTime, cutGoGo, nextSceneCount, lastCut, isTournamentArcade)
	
	-- NEXT �� ��츸 ī��Ʈ�� �Ѵ�.(3, 2, 1)
	if cutGoGo == 1 then
		if nextSceneCount > 0 then
			if nextSceneCount <= #tCount then
				if g_lastCount1 ~= nextSceneCount then
					g_lastCount1 = nextSceneCount
					
					g_countPosX = START_COUNT_POSX
					g_countAlpha = 100
				end
			
				drawer:drawTexture("UIData/numberUi001.tga", 548, 500, 476, 109, 548, 831, WIDETYPE_4)
				drawer:drawTextureA("UIData/numberUi001.tga", g_countPosX, 500, 112, 112, tCount[nextSceneCount], 831, g_countAlpha, WIDETYPE_4)
			end
		end
	end
	
	if lastCut == 2 then
		if nextSceneCount > 0 then
			if nextSceneCount <= #tCount then
				if g_lastCount2 ~= nextSceneCount then
					g_lastCount2 = nextSceneCount
					
					g_countPosX = START_COUNT_POSX
					g_countAlpha = 100
				end
				
				drawer:drawTexture("UIData/numberUi001.tga", 548, 500, 476, 109, 548, 831, WIDETYPE_4)
				drawer:drawTextureA("UIData/numberUi001.tga", g_countPosX, 500, 112, 112, tCount[nextSceneCount], 831, g_countAlpha, WIDETYPE_4)
			end
		end
	end
	
	g_countPosX = g_countPosX + deltaTime * 2
	if g_countPosX >= END_COUNT_POSX then
		g_countPosX = END_COUNT_POSX
	end
	
	g_countAlpha = g_countAlpha + deltaTime
	if g_countAlpha >= 255 then
		g_countAlpha = 255
	end
	
	
	
	if state <= 0 then
		return
	end

	-- ����
	if state == 1 then
		Effect_DungeonClear(deltaTime)

	-- ����
	elseif state == 2 then
	
		g_failedTime = g_failedTime + deltaTime
		local alpha = g_failedTime/3
		if alpha >= 120 then
			alpha = 120
		end
		drawer:drawTextureA("UIData/OnDLGBackImage.tga", 0, 0, 1920, 1200, 0, 0, alpha)
		
		if 0 <= g_failedTime and g_failedTime <= 1500 then
			if g_failedSound then
				PlaySound("sound/Dungeon/Dungeon_Failed.wav")
				PlaySound("sound/System/System_Fail.wav")
				g_failedSound = false
			end
			g_failedPos = Effect_Bounce_EaseOut(g_failedTime, -300, 600, 1500)				
		end
		
		if isTournamentArcade == 1 then
			drawer:drawTexture("UIData/GameNewImage2.tga", 189, g_failedPos, 650, 77, 11, 590, WIDETYPE_5)
		else
			drawer:drawTexture("UIData/dungeonmsg.tga", 280, g_failedPos, 487, 83, 5, 202, WIDETYPE_5)
		end
	
	-- ������ NEXT
	elseif state == 3 then
	--[[
		g_nextTime = g_nextTime + deltaTime
		g_nextTime = g_nextTime % 1000
		if g_nextTime < 500 then
			if g_nextSound then
				PlaySound("sound/Dungeon_Next.wav")
				g_nextSound = false
			end			
			drawer:drawTexture("UIData/dungeonmsg.tga", 616, 200, 321, 82, 694, 728)	-- next
			drawer:drawTexture("UIData/dungeonmsg.tga", 930, 195, 90, 92, 706, 824)		-- ->
		--	drawer:drawTexture("UIData/dungeonmsg.tga", 790, 200, 205, 123, 255, 338)
		else
			g_nextSound = true
		end	
	--]]
	
	-- GO
	elseif state == 4 then
		--[[
		if goTime >= 0 then
			local effectTime = goTime % 1000
			if effectTime < 500 then
				if g_gogoSound then
					PlaySound("sound/Dungeon_Next.wav")
					g_gogoSound = false
				end				
				drawer:drawTexture("UIData/dungeonmsg.tga", 790, 200, 205, 123, 255, 338)
			else
				g_gogoSound = true
			end
		end
		--]]
	end
	
end



function WndQuest_RenderCountDown(remainTime)
	
	nextSceneConnt = (remainTime / 1000) + 1
	if nextSceneConnt <= #tCount then
		drawer:drawTexture("UIData/dungeonmsg.tga", 479, 300, 66, 62, tCount[nextSceneConnt], 124, WIDETYPE_5)	
	end	
	
end



----------------------------------------------------------

-- ���� ���� �̹���
local mywindow = winMgr:createWindow("TaharezLook/StaticImage", "BossTalkingImage")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(4)
mywindow:setPosition(600, 280)
mywindow:setSize(498, 492)
mywindow:setAlwaysOnTop(true)
mywindow:setVisible(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)
----------------------------------------------------------
g_bossGuiAlpha = 0
g_bossGuiState = 0
function WndQuest_RenderBossGuiState(state, deltaTime, bossName, bossImageFile, bossSpeech, bossDieSpeak, bossHP)

	-- ���� �����Ŀ� ������ �װԵǸ� g_bossDeadTime����
	if state > 0 then
		if bossHP <= 0 then
			g_bossDeadTime = g_bossDeadTime + deltaTime
		end
	end

	--DebugStr("g_bossGuiState :: " .. g_bossGuiState)
	g_bossGuiState = state
	if state == 0 then
		g_bossGuiAlpha = 0
		if winMgr:getWindow("sj_wndQuest_bossSpeakForLive") then
			winMgr:getWindow("sj_wndQuest_bossSpeakForLive"):setVisible(false)
		end
		return
		
		
	--------------------------
	--	Danger�� ���� ���ϱ� ����
	--------------------------
	elseif state == 1 then
		g_bossGuiAlpha = g_bossGuiAlpha + (deltaTime/2)
		if g_bossGuiAlpha >= 255 then
			g_bossGuiAlpha = 255
		end
		
		drawer:drawTextureA("UIData/tutorial001.tga", 0, 544, 1024, 229, 0, 0, g_bossGuiAlpha, WIDETYPE_7)
		winMgr:getWindow("BossTalkingImage"):setVisible(true)
		winMgr:getWindow("BossTalkingImage"):setTexture("Enabled", bossImageFile,  0, 532)
		--drawer:drawTextureA(bossImageFile, 600, 280, 498, 492, 0, 532, g_bossGuiAlpha, WIDETYPE_4)	-- ���� �̹���
		
		drawer:setFont(g_STRING_FONT_DODUMCHE, 16)
		drawer:setTextColor(255,255,255,g_bossGuiAlpha)
		
		-- ���� ���ϴ� ���ڽ���
		if g_bossGuiAlpha >= 255 then
			winMgr:getWindow("sj_wndQuest_bossSpeakForLive"):setVisible(true)
			winMgr:getWindow("sj_wndQuest_bossSpeakForLive"):clearTextExtends()
			winMgr:getWindow("sj_wndQuest_bossSpeakForLive"):setTextExtends(bossSpeech, g_STRING_FONT_DODUMCHE, 16, 255, 255, 255, 255,   1, 0,0,0,255)
		
			winMgr:getWindow("ChatBackground"):setVisible(false)
			winMgr:getWindow("MainBarWindow"):setVisible(false)
		end
		
		-- ���� �̸�
		drawer:setTextColor(204, 0, 0, 255)
		drawer:setFont(g_STRING_FONT_DODUMCHE, 24)
		common_DrawOutlineText1(drawer, bossName, 30, 580, 51,0,0,g_bossGuiAlpha, 255,0,0,g_bossGuiAlpha, WIDETYPE_7)
		
		
	--------------------------
	--	Danger�Ŀ� ������ ���ư� �� �������ϱ� �������
	--------------------------
	elseif state == 2 then
		g_bossGuiAlpha = g_bossGuiAlpha - (deltaTime/2)
		if g_bossGuiAlpha <= 0 then
			g_bossGuiAlpha = 0
		end
		
		drawer:drawTextureA("UIData/tutorial001.tga", 0, 544, 1024, 229, 0, 0, g_bossGuiAlpha, WIDETYPE_7)
		winMgr:getWindow("BossTalkingImage"):setVisible(false)
		winMgr:getWindow("BossTalkingImage"):setTexture("Enabled", bossImageFile,  0, 532)
		
		-- �������� �������� ���� ���ְ� ���İ��� �� ���ڷ� �������.
		winMgr:getWindow("sj_wndQuest_bossSpeakForLive"):setViewTextMode(1)
		winMgr:getWindow("sj_wndQuest_bossSpeakForLive"):clearTextExtends()
		winMgr:getWindow("sj_wndQuest_bossSpeakForLive"):setTextExtends(bossSpeech, g_STRING_FONT_DODUMCHE, 16, 255, 255, 255, g_bossGuiAlpha,   1, 0,0,0,g_bossGuiAlpha)
		
		drawer:setTextColor(204, 0, 0, 255)
		drawer:setFont(g_STRING_FONT_DODUMCHE, 24)
		common_DrawOutlineText1(drawer, bossName, 30, 580, 51,0,0,g_bossGuiAlpha, 255,0,0,g_bossGuiAlpha, WIDETYPE_7)
		
		winMgr:getWindow("ChatBackground"):setVisible(true)
		winMgr:getWindow("MainBarWindow"):setVisible(true)
		
	elseif state == 3 then
		g_bossGuiAlpha = 0
		if winMgr:getWindow("sj_wndQuest_bossSpeakForLive") then
			winMgr:getWindow("sj_wndQuest_bossSpeakForLive"):setVisible(false)	
			winMgr:getWindow("sj_wndQuest_bossSpeakForLive"):clearTextExtends()
			winMgr:getWindow("ChatBackground"):setVisible(true)
			winMgr:getWindow("MainBarWindow"):setVisible(true)
			winMgr:getWindow("BossTalkingImage"):setVisible(false)
		end
		
	elseif state == 4 then
		if g_bossDeadTime >= 3800 then
			g_bossGuiAlpha = g_bossGuiAlpha + (deltaTime/2)
			if g_bossGuiAlpha >= 255 then
				g_bossGuiAlpha = 255
			end
			winMgr:getWindow("BossTalkingImage"):setVisible(false)
			
			drawer:drawTextureA("UIData/tutorial001.tga", 0, 544, 1024, 229, 0, 0, g_bossGuiAlpha, WIDETYPE_7)
			drawer:drawTextureA(bossImageFile, 15, 572, 160, 187, 0, 345, g_bossGuiAlpha, WIDETYPE_7)-- ���� ������ �̹���
			
			drawer:setFont(g_STRING_FONT_DODUMCHE, 16)
			drawer:setTextColor(255,255,255,g_bossGuiAlpha)
			
			-- ���� ���ϴ� ���ڽ���
			if g_bossGuiAlpha >= 255 then
				winMgr:getWindow("sj_wndQuest_bossSpeakAfterDie"):setVisible(true)
				winMgr:getWindow("sj_wndQuest_bossSpeakAfterDie"):setPosition(200, 638)
				winMgr:getWindow("sj_wndQuest_bossSpeakAfterDie"):clearTextExtends()
				winMgr:getWindow("sj_wndQuest_bossSpeakAfterDie"):setTextExtends(bossDieSpeak, g_STRING_FONT_DODUMCHE, 16, 255, 255, 255, 255,   1, 0,0,0,255)
				winMgr:getWindow("ChatBackground"):setVisible(false)
				winMgr:getWindow("MainBarWindow"):setVisible(false)
			end
			
			drawer:setTextColor(204, 0, 0, 255)
			drawer:setFont(g_STRING_FONT_DODUMCHE, 24)
			common_DrawOutlineText1(drawer, bossName, 40, 555, 51,0,0,g_bossGuiAlpha, 255,0,0,g_bossGuiAlpha, WIDETYPE_7)
		end
	end
	
	-- ���� HP�� �׸���
	if state >= 3 then
		g_bossGaugeStart = true
	end
	
end




----------------------------------------------------------

-- NPC ���

----------------------------------------------------------
function WndQuest_RenderScript(speachTime, npcName, bossSpeech)
			
	--------------------------
	-- NPC ���ϱ� ����
	--------------------------
	if speachTime < 4000 then
		alphaalpha = speachTime / 2
		if alphaalpha >= 255 then
			alphaalpha = 255
		end		
	else
		alphaalpha = 255 - ((speachTime - 4000) / 2)
	end
	
	if alphaalpha >= 255 then
		alphaalpha = 255
	end	
	
	if alphaalpha < 0 then
		alphaalpha = 0
	end	
	
	-- ���â
	drawer:drawTextureA("UIData/tutorial001.tga", 0, 544, 1024, 229, 0, 0, alphaalpha, WIDETYPE_7)
	
	-- NPC �̸�
	drawer:setTextColor(204, 0, 0, alphaalpha)
	drawer:setFont(g_STRING_FONT_DODUMCHE, 24)
	drawer:drawText(npcName, 30, 580, WIDETYPE_7)
	
	-- NPC ���
	drawer:setFont(g_STRING_FONT_DODUMCHE, 16)
	drawer:setTextColor(255,255,255,alphaalpha)
	drawer:drawText(bossSpeech, 30, 638, WIDETYPE_7)	
end



function WndQuest_RendershowScenarioPage(loadingTime, scenarioFile, scenarioScript)

	if string.len(scenarioFile) > 0 then	
		drawer:drawTextureA(scenarioFile, 0, 0, 1024,768, 0, 0, 255, WIDETYPE_7)
	else
		drawer:drawTextureA("UIData/blackFadeIn.tga", 0, 0, 1024,768, 0, 0, 255, WIDETYPE_7)
	end
			
	-- �ε� ����	
	local loadingText = scenarioScript
	if string.len(loadingText) > 0 then
		drawer:setFont(LAN_FONT_HY_HEADLINE, 24)
		drawer:setTextColor(255,255,0,255)
		local size = GetStringSize(LAN_FONT_HY_HEADLINE, 24, loadingText)
		drawer:drawText(loadingText, 512-size/2, 366, WIDETYPE_7)
	end
end



local g_flag1 = true
function BossGuiMent()
	if g_bossGuiState == 1 and g_bossGuiAlpha >= 255 then
		if g_flag1 then
			CEGUI.toGUISheet(winMgr:getWindow("sj_wndQuest_bossSpeakForLive")):setTextViewDelayTime(20)
			winMgr:getWindow("sj_wndQuest_bossSpeakForLive"):setVisible(true)
			g_flag1 = false
		end
	end
end


local g_flag2 = true
function BossGuiMent2()
	if g_bossGuiState == 4 and g_bossGuiAlpha >= 255 then
		if g_bossDeadTime >= 3800 then
			if g_flag2 then
				CEGUI.toGUISheet(winMgr:getWindow("sj_wndQuest_bossSpeakAfterDie")):setTextViewDelayTime(20)				
				winMgr:getWindow("sj_wndQuest_bossSpeakAfterDie"):setVisible(true)
				g_flag2 = false
			end
		end
	end
end






-- �ɸ��� �̹��� ���� �̸��� ������ �ӽ������츦 �����Ѵ�.
_window = winMgr:createWindow("TaharezLook/StaticText", "sj_wndQuest_bossSpeakForLive")
_window:setProperty("FrameEnabled", "False")
_window:setProperty("BackgroundEnabled", "False")
_window:setFont(g_STRING_FONT_DODUMCHE, 16)
_window:setTextColor(255, 255, 255, 255)
_window:setWideType(7)
_window:setPosition(30, 638)
_window:setSize(200, 153)
_window:setAlign(0)
_window:setViewTextMode(2)
_window:setLineSpacing(5)
_window:clearTextExtends()
_window:setVisible(false)
_window:subscribeEvent("EndRender", "BossGuiMent")
root:addChildWindow(_window)


-- �ɸ��� �̹��� ���� �̸��� ������ �ӽ������츦 �����Ѵ�.
_window = winMgr:createWindow("TaharezLook/StaticText", "sj_wndQuest_bossSpeakAfterDie")
_window:setProperty("FrameEnabled", "False")
_window:setProperty("BackgroundEnabled", "False")
_window:setFont(g_STRING_FONT_DODUMCHE, 16)
_window:setTextColor(255, 255, 255, 255)
_window:setWideType(7)
_window:setPosition(200, 638) --30, 638
_window:setSize(200, 153)
_window:setAlign(0)
_window:setViewTextMode(2)
_window:setLineSpacing(5)
_window:clearTextExtends()
_window:setVisible(false)
_window:subscribeEvent("EndRender", "BossGuiMent2")
root:addChildWindow(_window)


-- 5���� ä�� �ʱ�ȭ
local tShowText		 = { ["protectErr"]=0 }
local tShowTextColor = { ["protectErr"]=0 }
local tShowTextType  = { ["protectErr"]=0 }

function WndQuest_ClearChatting()

	for i=1, table.getn(tShowText) do
		table.remove(tShowText,  i)		-- ä�ó���
		table.remove(tShowTextColor, i)	-- ä�û���
		table.remove(tShowTextType, i)	-- ä��Ÿ��
	end
	
end


----------------------------------------------------

-- ����

----------------------------------------------------
function WndQuest_RenderHelp(bHelp, bHuntingMode)
	
--	drawer:drawTexture("UIData/bunhae_002.tga", 152, 82, 113, 27, 0, 82)
	if bHuntingMode == 0 then
		-- ���� ������
		if bHelp == 1 then
			drawer:drawTexture("UIData/other001.tga", 4, 132, 565, 306, 0, 0)
		end
	else
		-- ��Ű ���� ��ư
		--drawer:drawTexture("UIData/hunting_001.tga", 102, 80, 97, 27, 224, 656)
	end
	
end





------------------------------------------------

--	��ǳ�� �׸���

------------------------------------------------
function WndQuest_OnDrawBoolean(str_chat, px, py, chatBubbleType)
	
	local real_str_chat = str_chat;
	if string.len(real_str_chat) <= 0 then
		return
	end
		
	if 0 > chatBubbleType or chatBubbleType > MAX_CHAT_BUBBLE_NUM then
		return
	end
	
	
	local alpha  = 255
	local UNIT   = 18		-- 1edge�� ������
	local UNIT2X = UNIT*2								-- 1edge�� ������ * 2
	local texX_L = tChatBubbleTexX[chatBubbleType]		-- �ؽ�ó ���� x��ġ
	local texY_L = tChatBubbleTexY[chatBubbleType]		-- �ؽ�ó ���� y��ġ
	local texX_R = texX_L+(UNIT*2)						-- �ؽ�ó ������ x��ġ
	local texY_R = texY_L+(UNIT*2)						-- �ؽ�ó ������ y��ġ
	local r,g,b  = GetChatBubbleColor(chatBubbleType)	-- �ؽ�Ʈ ����(0:���, 1:������)
	local posX	 = 0		-- ��ǳ�� x��ġ
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






function WndQuest_Debug(xcenti, ycenti, oldDrawIndex, drawIndex, capture)
		
	drawer:setTextColor(255, 255, 255, 255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	if capture == 1 then
		drawer:drawText(".", 4, 0)
	end
	
	--[[
	drawer:setTextColor(255, 255, 255, 255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)	
	drawer:drawText("HP ( " .. xcenti, 280, 80)
	drawer:drawText("SP ( " .. ycenti, 280, 100)
	drawer:drawText(" / " .. oldDrawIndex.." )", 340, 80)
	drawer:drawText(" / " .. drawIndex.." )", 340, 100)
--]]

end






----------------------------------------------------

-- ���� ����â

----------------------------------------------------
quitwindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_wndQuest_exitBackWindow")
quitwindow:setTexture("Enabled", "UIData/dungeonmsg.tga", 0, 509)
quitwindow:setTexture("Disabled", "UIData/dungeonmsg.tga", 0, 509)
quitwindow:setProperty("FrameEnabled", "False")
quitwindow:setProperty("BackgroundEnabled", "False")
quitwindow:setWideType(5);
quitwindow:setPosition(0, 300)
quitwindow:setSize(1024, 157)
quitwindow:setAlpha(0)
quitwindow:setZOrderingEnabled(true)
quitwindow:setVisible(false)
root:addChildWindow(quitwindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_wndQuest_exitDescWindow")
mywindow:setTexture("Enabled", "UIData/quest1.tga", 257, 460)
mywindow:setTexture("Disabled", "UIData/quest1.tga", 257, 460)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(356, 10)
mywindow:setSize(326, 66)
mywindow:setAlpha(0)
quitwindow:addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/Button", "sj_wndQuest_exitOkBtn")
mywindow:setTexture("Normal", "UIData/quest.tga", 644, 564)
mywindow:setTexture("Hover", "UIData/quest.tga", 439, 760)
mywindow:setTexture("Pushed", "UIData/quest.tga", 439, 825)
mywindow:setTexture("PushedOff", "UIData/quest.tga", 644, 564)
mywindow:setPosition(340, 80)
mywindow:setSize(153, 65)
mywindow:setAlpha(0)
mywindow:subscribeEvent("Clicked", "WndQuest_QuitOK")
quitwindow:addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/Button", "sj_wndQuest_exitCancelBtn")
mywindow:setTexture("Normal", "UIData/quest.tga", 842, 564)
mywindow:setTexture("Hover", "UIData/quest.tga", 439, 890)
mywindow:setTexture("Pushed", "UIData/quest.tga", 439, 955)
mywindow:setTexture("PushedOff", "UIData/quest.tga", 842, 564)
mywindow:setPosition(538, 80)
mywindow:setSize(153, 65)
mywindow:setAlpha(0)
mywindow:subscribeEvent("Clicked", "WndQuest_QuitCancel")
quitwindow:addChildWindow(mywindow)


-- ������ ����Ͽ� ���ķ� ��Ÿ���� ��� ��ư �̹������� ������ ���� �̹����� �׸��� �ʴ´�;;
local g_escapeAlpha = 0
function WndQuest_Escape(bFlag, deltaTime)
		
	if bFlag == 1 then
		quitwindow:setVisible(true)		
		g_escapeAlpha = g_escapeAlpha + deltaTime
		if g_escapeAlpha >= 255 then
			g_escapeAlpha = 255
			
		end
		
	else
		g_escapeAlpha = g_escapeAlpha - deltaTime
		if g_escapeAlpha <= 0 then
			g_escapeAlpha = 0
			quitwindow:setVisible(false)
		else
		end	
	end
	
	if b_HuntingArcade == 1 then
		winMgr:getWindow("sj_wndQuest_exitDescWindow"):setSize(326, 36)
	end
	winMgr:getWindow("sj_wndQuest_exitBackWindow"):setAlpha(g_escapeAlpha)
	winMgr:getWindow("sj_wndQuest_exitDescWindow"):setAlpha(g_escapeAlpha)
	winMgr:getWindow("sj_wndQuest_exitOkBtn"):setAlpha(g_escapeAlpha)
	winMgr:getWindow("sj_wndQuest_exitCancelBtn"):setAlpha(g_escapeAlpha)
end





----------------------------------------------------

-- ���� �������

----------------------------------------------------
local myPostionY = 45

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_wndQuest_bossFaceImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(5);
mywindow:setPosition(650, myPostionY-5)
mywindow:setSize(50, 50)
mywindow:setZOrderingEnabled(true)
mywindow:setAlwaysOnTop(true)
mywindow:setVisible(false)
mywindow:setAlign(8);
mywindow:addController("bossMotion", "bossMotion", "xscale", "Elastic_EaseOut", 1, 260, 9, true, true, 10)
mywindow:addController("bossMotion", "bossMotion", "yscale", "Elastic_EaseOut", 1, 260, 9, true, true, 10)
root:addChildWindow(mywindow)

local g_action = false

-- �����̵� �������
function SettingArcadeRate(currentStateRate)
	ChangeChannelPosition(g_PARTY_TYPE_ARCADERATE..' '..currentStateRate.." %")
end


function WndQuest_ShowCurrentStageState(bossImageFile, currentStateRate)
	
	if g_bossGaugeStart == true then
		winMgr:getWindow("sj_wndQuest_bossFaceImage"):setVisible(false)
	--	winMgr:getWindow("CharacterInfoBackWindow"):setVisible(false)
		return
	end		
end

----------------------------------------------------

--  ����� ������� ���ǹ� ������� 

----------------------------------------------------

function WndQuest_RenderHuntingCountInfo(HuntingKillinfo, PartyKillInfo,  HuntingCountinfo, totalZen,  totalExp)
	--������� ī���ͺ��ʽ�  ų�� �ð� ����
	
	
	--[[
	drawer:drawTexture("UIData/Hunting_001.tga", 800, 6, 224, 158, 0, 586, WIDETYPE_1)
	WndQuest_DrawEachNumberWide("UIData/Hunting_001.tga", HuntingKillinfo , 8, 965 , 57, 242, 550, 9, 12, 9, WIDETYPE_1)
	WndQuest_DrawEachNumberWide("UIData/Hunting_001.tga", HuntingCountinfo , 8, 965 , 110, 242, 550, 9, 12, 9, WIDETYPE_1)
	WndQuest_DrawEachNumberWide("UIData/Hunting_001.tga", PartyKillInfo , 8, 965 , 83, 242, 550, 9, 12, 9, WIDETYPE_1)
	--]]
	
	drawer:drawTexture("UIData/Hunting_001.tga", 855, 175, 172, 57, 0, 919, WIDETYPE_1)-- ���� �����
	--�Ű�����(�����̸�, ����, ���Ĺ��, x, y, �ؽ���x, �ؽ���y, ������x, ������y, �ؽ��� ����)
	--[[
	drawer:drawTexture("UIData/Hunting_001.tga", 800, 165, 224, 59, 0, 527, WIDETYPE_1)  
	WndQuest_DrawEachNumberWide("UIData/Hunting_001.tga", totalExp , 8, 962 , 202, 242, 574, 9, 12, 9, WIDETYPE_1)
	WndQuest_DrawEachNumberWide("UIData/Hunting_001.tga", gainTotalGran , 8, 962 , 175, 242, 562, 9, 12, 9, WIDETYPE_1)
	--]]
end

--������ ����� ���� ų ����ų ī��Ʈ ���� �׾��� ��
function WndQuest_DrawHuntingBossKillCount(KilledCount)
	local startPos1	= 814-380
	local startPos2	= 836-380
	local startPosy = 90

	drawer:drawTexture("UIData/dungeonmsg.tga", startPos2, startPosy, 80, 17, 873, 415, WIDETYPE_5)

	drawer:drawTexture("UIData/dungeonmsg.tga", startPos2 + 90, startPosy + 2, 14, 15, 28 + 14 * KilledCount, 666, WIDETYPE_5)

	drawer:drawTexture("UIData/dungeonmsg.tga", startPos2 + 105, startPosy - 2, 13, 20, 872, 435, WIDETYPE_5)

	drawer:drawTexture("UIData/dungeonmsg.tga", startPos2+130 - 8, startPosy + 2, 14, 15, 28 + 14 * 1, 666, WIDETYPE_5)

	--drawer:drawTexture("UIData/dungeonmsg.tga", startPos2+130, 34+changePosY, 38, 26, tTime[g_milliSec%10], 192, 1)

end

function WndQuest_RenderFuntionKey(HpPotionCount, MpPotionCount ,PreHpPotionCount, PreMpPotionCount, EventHpPotion, EventMpPotion, CoolTimeHpPotion, CoolTimeMpPotion)
--[[ 
	local KeyPadPosY = 2
	if g_bossGaugeStart == true then
		--KeyPadPosY = 661
		--KeyPadPosY = 5
	end
	
	isArcadeBoss = g_bossGaugeStart	
	local KeyPadPosX = 327
	drawer:setTextColor(255, 255, 255, 255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	drawer:drawTexture("UIData/Hunting_001.tga", KeyPadPosX, KeyPadPosY, 404, 46, 107, 466, WIDETYPE_5)  -- ����Űâ �ӽ�
	

	local CountText = CommatoMoneyStr(HpPotionCount)
	local textSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, CountText)
	common_DrawOutlineText1(drawer, HpPotionCount , KeyPadPosX+56 - textSize, KeyPadPosY+30, 0,0,0,255, 255,255,255,255, WIDETYPE_5)
	
	CountText = CommatoMoneyStr(MpPotionCount)
	textSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, CountText)
	common_DrawOutlineText1(drawer, MpPotionCount , KeyPadPosX+95 - textSize, KeyPadPosY+30, 0,0,0,255, 255,255,255,255, WIDETYPE_5)
	
	
	CountText = CommatoMoneyStr(PreHpPotionCount)
	textSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, CountText)
	common_DrawOutlineText1(drawer, PreHpPotionCount , KeyPadPosX+138 - textSize, KeyPadPosY+30, 0,0,0,255, 255,255,255,255, WIDETYPE_5)
	
	CountText = CommatoMoneyStr(PreMpPotionCount)
	textSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, CountText)
	common_DrawOutlineText1(drawer, PreMpPotionCount , KeyPadPosX+178 - textSize, KeyPadPosY+30, 0,0,0,255, 255,255,255,255, WIDETYPE_5)
	
	--local CheckDefine = GetCoolTimeModeCheck();
	--DebugStr("CheckDefine : " .. CheckDefine)
	
	CountText = CommatoMoneyStr(CoolTimeHpPotion) -- ��Ÿ�� ���� HP
	textSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, CountText)
	--if CheckDefine == 1 then
		--common_DrawOutlineText1(drawer, CoolTimeHpPotion , KeyPadPosX+218 - textSize, KeyPadPosY+30, 0,0,0,255, 255,255,255,255, WIDETYPE_5)
	--end
	
	CountText = CommatoMoneyStr(CoolTimeMpPotion) -- ��Ÿ�� ���� MP
	textSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, CountText)
	
	--if CheckDefine == 1 then
		--common_DrawOutlineText1(drawer, CoolTimeMpPotion , KeyPadPosX+258 - textSize, KeyPadPosY+30, 0,0,0,255, 255,255,255,255, WIDETYPE_5)
	--end
	
	
	
	CountText = CommatoMoneyStr(EventHpPotion)
	textSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, CountText)
	--common_DrawOutlineText1(drawer, EventHpPotion , KeyPadPosX+218 - textSize, KeyPadPosY+30, 0,0,0,255, 255,255,255,255, WIDETYPE_5)
	
	CountText = CommatoMoneyStr(EventMpPotion)
	textSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, CountText)
	--common_DrawOutlineText1(drawer, EventMpPotion , KeyPadPosX+258 - textSize, KeyPadPosY+30, 0,0,0,255, 255,255,255,255, WIDETYPE_5)
--]]

	MainBar_SetSlotText(1, HpPotionCount)
	MainBar_SetSlotText(2, MpPotionCount)
	MainBar_SetSlotText(3, PreHpPotionCount)
	MainBar_SetSlotText(4, PreMpPotionCount)
	--MainBar_SetSlotText(5, EventHpPotion)
	--MainBar_SetSlotText(6, EventMpPotion)

end


----------------------------------------------------
--  ����� Ű �̹���
----------------------------------------------------
for i = 1, 3 do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "HuntingKeyimage"..i)
	mywindow:setTexture("Enabled", "UIData/Hunting_001.tga", i*48, 976)
	mywindow:setTexture("Disabled", "UIData/Hunting_001.tga", 0, 976)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setWideType(1)
	mywindow:setPosition(863+(i*54)-54, 178)
	mywindow:setSize(48, 48)
	mywindow:setZOrderingEnabled(true)
	mywindow:setEnabled(false)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setAlign(8);
	mywindow:addController("KeyMothion", "KeyMothion", "xscale", "Elastic_EaseOut", 240, 300, 9, true, true, 10)
	mywindow:addController("KeyMothion", "KeyMothion", "yscale", "Elastic_EaseOut", 240, 300, 9, true, true, 10)
	root:addChildWindow(mywindow)
end

----------------------------------------------------
--  ����� Ű ����
----------------------------------------------------

function WndQuest_RenderBasicHuntingImage()
	winMgr:getWindow('HuntingKeyimage1'):setVisible(true)
	winMgr:getWindow('HuntingKeyimage2'):setVisible(true)
	winMgr:getWindow('HuntingKeyimage3'):setVisible(true)
	--winMgr:getWindow("ArcadeInvenBtn"):setVisible(true)
end

function WndQuest_NoticeDiedHuntingBoss()
	winMgr:getWindow('HuntingNoticeImage3'):setVisible(false)
	winMgr:getWindow('HuntingNoticeImage3'):clearActiveController()
	winMgr:getWindow('HuntingNoticeImage3'):activeMotion('NoticeMotion4');
	winMgr:getWindow('HuntingNoticeImage3'):setVisible(true)
end

function WndQuest_RenderHuntingKeyInfo(Akey, Bkey, Ckey, CheckKey)
	
	winMgr:getWindow('HuntingItemImage'):setTexture("Disabled", "UIData/Hunting_001.tga", CheckKey*48, 976)
	
	
	
	if Akey == 1 then
		DebugStr('Akey����')
		winMgr:getWindow('HuntingKeyimage1'):clearActiveController()
		winMgr:getWindow('HuntingKeyimage1'):activeMotion('KeyMothion');
		winMgr:getWindow('HuntingKeyimage1'):setEnabled(true)
	else
		winMgr:getWindow('HuntingKeyimage1'):clearActiveController()
		winMgr:getWindow('HuntingKeyimage1'):setEnabled(false)
	end

	
	if Bkey == 1 then
		DebugStr('Bkey����')
		winMgr:getWindow('HuntingKeyimage2'):clearActiveController()
		winMgr:getWindow('HuntingKeyimage2'):activeMotion('KeyMothion');
		winMgr:getWindow('HuntingKeyimage2'):setEnabled(true)
	else
		winMgr:getWindow('HuntingKeyimage2'):clearActiveController()
		winMgr:getWindow('HuntingKeyimage2'):setEnabled(false)
	end
	
	
	if Ckey == 1 then
		DebugStr('Ckey����')
		winMgr:getWindow('HuntingKeyimage3'):clearActiveController()
		winMgr:getWindow('HuntingKeyimage3'):activeMotion('KeyMothion');
		winMgr:getWindow('HuntingKeyimage3'):setEnabled(true)
	else
		winMgr:getWindow('HuntingKeyimage3'):clearActiveController()
		winMgr:getWindow('HuntingKeyimage3'):setEnabled(false)
	end
	
	
	if Akey > 0 or Bkey > 0 or Ckey > 0 then
		winMgr:getWindow('HuntingNoticeImage'):activeMotion('NoticeMotion');
		winMgr:getWindow('HuntingNoticeImage'):setVisible(true)
	end
	
	if Akey > 0 and Bkey > 0 and Ckey > 0 then
		DebugStr('����������')
		winMgr:getWindow('HuntingNoticeImage2'):setVisible(false)
		winMgr:getWindow('HuntingNoticeImage2'):setTexture("Enabled", "UIData/Hunting_001.tga", 166, 853)
		winMgr:getWindow('HuntingNoticeImage2'):clearActiveController()
		winMgr:getWindow('HuntingNoticeImage2'):activeMotion('NoticeMotion2');
		winMgr:getWindow('HuntingNoticeImage2'):setVisible(true)
	end
end


-- ���� �˸����� 

local tHuntingText		 = { ["protectErr"]=0 }
local tHuntTextColor		 = { ["protectErr"]=0 }

function WndQuest_ClearHuntingNotice()
	DebugStr('_ClearHuntingNotice')
	for i=1, table.getn(tHuntingText) do
		table.remove(tHuntingText,  i)		-- ä�ó���
	end
	
end

----------------------------------------------------
--  ����� �ý��� ���â
----------------------------------------------------
function WndQuest_RenderHuntingNotice()
	drawer:setFont(g_STRING_FONT_GULIMCHE, 13)
	drawer:setTextColor(255, 178, 0, 255)
	HuntingTexty = 370
	HuntingTextx = 12
	count = 0
	for i=1, table.getn(tHuntingText) do
		count = count + 1
		-- 1: (���)
		if tHuntTextColor[i] == -1 then
			common_DrawOutlineText1(drawer, tostring(tHuntingText[i]), HuntingTextx, HuntingTexty, 0,0,0,255, ChatMySelfFontData[3],ChatMySelfFontData[4],ChatMySelfFontData[5],255, WIDETYPE_2)
		
		-- 0: (����)
		elseif tHuntTextColor[i] == 0 then
			common_DrawOutlineText1(drawer, tostring(tHuntingText[i]), HuntingTextx, HuntingTexty, 0,0,0,255, ChatWarnningFontData[3],ChatWarnningFontData[4],ChatWarnningFontData[5],255 ,WIDETYPE_2)
		
		-- 1:(���)
		elseif tHuntTextColor[i] == 1 then
			common_DrawOutlineText1(drawer, tostring(tHuntingText[i]), HuntingTextx, HuntingTexty, 0,0,0,255, ChatNormalFontData[3],ChatNormalFontData[4],ChatNormalFontData[5],255,WIDETYPE_2)
			
		-- 2:(�Ķ���)
		elseif tHuntTextColor[i] == 2 then
			common_DrawOutlineText1(drawer, tostring(tHuntingText[i]), HuntingTextx, HuntingTexty, 0,0,0,255, ChatPartyFontData[3],ChatPartyFontData[4],ChatPartyFontData[5],255,WIDETYPE_2)
			
		-- 3:(���)
		elseif tHuntTextColor[i] == 3 then
			common_DrawOutlineText1(drawer, tostring(tHuntingText[i]), HuntingTextx, HuntingTexty, 0,0,0,255, ChatWhisperFontData[3],ChatWhisperFontData[4],ChatWhisperFontData[5],255,WIDETYPE_2)
			
		-- 4:(�Ķ���)
		elseif tHuntTextColor[i] == 4 then
			common_DrawOutlineText1(drawer, tostring(tHuntingText[i]), HuntingTextx, HuntingTexty, 0,0,0,255, ChatTeamFontData[3],ChatTeamFontData[4],ChatTeamFontData[5],255,WIDETYPE_2)
		
		-- 5:(�ݻ�)
		elseif tHuntTextColor[i] == 5 then
			common_DrawOutlineText1(drawer, tostring(tHuntingText[i]), HuntingTextx, HuntingTexty, 0,0,0,255, ChatSystemFontData[3],ChatSystemFontData[4],ChatSystemFontData[5],255,WIDETYPE_2)
		
		-- 6:(�ݻ�)
		elseif tHuntTextColor[i] == 6 then
			common_DrawOutlineText1(drawer, tostring(tHuntingText[i]), HuntingTextx, HuntingTexty, 0,0,0,255, ChatSystem2FontData[3],ChatSystem2FontData[4],ChatSystem2FontData[5],255,WIDETYPE_2)
		
		-- 7:(�������)
		elseif tHuntTextColor[i] == 7 then
			common_DrawOutlineText1(drawer, tostring(tHuntingText[i]), HuntingTextx, HuntingTexty, 0,0,0,255, ChatGangFontData[3],ChatGangFontData[4],ChatGangFontData[5],255,WIDETYPE_2)
		end

		HuntingTexty = HuntingTexty + 16
		if count >= 8 then
			return
		end
	end
	
end

----------------------------------------------------
--  ����� ����ä�� �Է�
----------------------------------------------------
-- ���� chatType (0: �ҹ�ä��(����), 1:�Ϲ�ä��(���), 2:��ä��(�Ķ���), 3:�ӼӸ�(���))
function WndQuest_InputHuntingNotice(insertMsg, ColorNumber)

	if table.getn(tHuntingText) >= 5 then
		table.remove(tHuntingText,  1)
		table.remove(tHuntTextColor, 1)
	end
	table.insert(tHuntingText, tostring(insertMsg))		
	table.insert(tHuntTextColor, tonumber(ColorNumber))	-- ä�û���	
	tablecount = table.getn(tHuntingText)	
	
end

----------------------------------------------------
--  ����� ����ġ ����
----------------------------------------------------
function WndQuest_RenderHuntingExp()
	--drawer:drawTexture("UIData/Hunting_001.tga", 2, 733, 1024, 36, 0, 788, WIDETYPE_7) 
end



----------------------------------------------------
--  ���� �ؽ�Ʈ
----------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "HuntingCharacterLevel");
mywindow:setFont(g_STRING_FONT_DODUMCHE, 10)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setWideType(7);
mywindow:setPosition(460, 749)
mywindow:setSize(200, 20)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

ExpNumber = 0
----------------------------------------------------
--  ����� ����ġ ����
----------------------------------------------------
function SettingHuntingExp(ExpSize, ExpPercent, CharacterLevel, IncreaseExp, CurrentExp, MaxExp, isHuntingArcade, killcount)

--	winMgr:getWindow('CharacterInfoExp'):setTextExtends(ExpPercent.."%  ("..CurrentExp.." / "..MaxExp..")", g_STRING_FONT_GULIMCHE, 110,  255,255,255, 255,   1,   100,50,25,255);
	SetMyCharacterInfoExp( CharacterLevel, CurrentExp, MaxExp, ExpPercent )
	
	if isHuntingArcade == 1 then
		ChangeChannelPosition(g_PARTY_TYPE_KILLNPC..' '..killcount)
	end
	
	if IncreaseExp == 0 then
		return
	end
	
	----------------------------------------------------
	--  ����� ����ġ ����Ʈ �̹���
	----------------------------------------------------
	ExpNumber = ExpNumber + 1
	
	ExpBackwindow = winMgr:createWindow("TaharezLook/StaticImage", "HuntingExpBackImage"..ExpNumber)
	ExpBackwindow:setTexture("Enabled", "UIData/invisible.tga", 992, 848)
	ExpBackwindow:setTexture("Disabled", "UIData/invisible.tga", 992, 848)
	ExpBackwindow:setWideType(5);
	ExpBackwindow:setPosition(450, 300)
	ExpBackwindow:setSize(200, 30)
	ExpBackwindow:setVisible(false)
	ExpBackwindow:setEnabled(false)
	ExpBackwindow:setScaleWidth(500)
	ExpBackwindow:setScaleHeight(500)
	ExpBackwindow:setAlwaysOnTop(false)
	ExpBackwindow:setZOrderingEnabled(false)
	ExpBackwindow:addController("ExpMotion", "ExpMotion", "y", "Linear_EaseNone", 300, 170, 10, true, false, 10)
	ExpBackwindow:subscribeEvent("MotionEventEnd", "HuntingExpImageDelete");
	root:addChildWindow(ExpBackwindow)	
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "HuntingExpTexImage"..ExpNumber)
	mywindow:setTexture("Enabled", "UIData/hunting_001.tga", 772, 842)
	mywindow:setTexture("Disabled", "UIData/hunting_001.tga", 772, 842)
	--mywindow:setWideType(5);
	mywindow:setPosition(5, 5)
	mywindow:setSize(57,22)
	mywindow:setVisible(true)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("HuntingExpBackImage"..ExpNumber):addChildWindow(mywindow)
	mywindow:addController("ExpMotion", "ExpMotion", "alpha", "Linear_EaseNone", 255,255 , 5, true, false, 10)
	mywindow:addController("ExpMotion", "ExpMotion", "alpha", "Linear_EaseNone", 255,0 , 10, true, false, 10)
	
	HuntingImageToNumber(IncreaseExp)
		
	winMgr:getWindow("HuntingExpBackImage"..ExpNumber):clearActiveController()
	winMgr:getWindow("HuntingExpBackImage"..ExpNumber):setVisible(true)
	winMgr:getWindow("HuntingExpBackImage"..ExpNumber):activeMotion("ExpMotion")
	winMgr:getWindow("HuntingExpTexImage"..ExpNumber):activeMotion("ExpMotion")
	
end


function HuntingImageToNumber(ChangeNumber)

	local Buffer = ChangeNumber
	local EXPCount = 0
	
	while Buffer > 0 do
		EXPCount = EXPCount+1
		Buffer	   = Buffer/10
	end
	
	local CuttingNumber = ChangeNumber
	local count = 0
	local PosXTerm = 22 * EXPCount

	while CuttingNumber > 0 do
	 
		local number = CuttingNumber%10
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "NumberCount"..count..ExpNumber)
		mywindow:setTexture("Enabled", "UIData/hunting_001.tga", 843+14*number, 845)
		mywindow:setTexture("Disabled", "UIData/hunting_001.tga", 843+14*number, 845)
		mywindow:setPosition(60 + PosXTerm -(22*count) , 5)
		mywindow:setSize(14, 19)
		mywindow:setVisible(true)
		mywindow:setEnabled(false)
		mywindow:setAlwaysOnTop(false)
		mywindow:addController("ExpMotion", "ExpMotion", "alpha", "Linear_EaseNone", 255,255 , 5, true, false, 10)
		mywindow:addController("ExpMotion", "ExpMotion", "alpha", "Linear_EaseNone", 255,0 , 10, true, false, 10)
		mywindow:setZOrderingEnabled(false)
		mywindow:activeMotion("ExpMotion")
		winMgr:getWindow("HuntingExpBackImage"..ExpNumber):addChildWindow(mywindow)
		count = count+1
		CuttingNumber = CuttingNumber/10		
	end
end

function HuntingExpImageDelete(args)
	local local_window = CEGUI.toWindowEventArgs(args).window;
	local win_name = local_window:getName();
	
	if local_window ~= nil then
		root:removeChildWindow(win_name)
		winMgr:destroyWindow(win_name)
	end
end
----------------------------------------------------
--  ����� ���� ���� (����ȹ�����)
----------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "HuntingNoticeImage")
mywindow:setTexture("Enabled", "UIData/hunting_001.tga", 507, 913)
mywindow:setTexture("Disabled", "UIData/hunting_001.tga", 507, 913)
mywindow:setWideType(5);
mywindow:setPosition(250, 200)
mywindow:setSize(517, 111)
mywindow:setVisible(false)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
mywindow:addController("NoticeMotion", "NoticeMotion", "alpha", "Sine_EaseInOut", 255, 255, 10, true, false, 10)
mywindow:addController("NoticeMotion", "NoticeMotion", "alpha", "Sine_EaseInOut", 255,0 , 10, true, false, 10)
root:addChildWindow(mywindow)

----------------------------------------------------
--  ������ �ٴ� ������ �̹���(����ȹ��� ���)
----------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "HuntingItemImage")
mywindow:setTexture("Enabled", "UIData/Hunting_001.tga", 48, 976)
mywindow:setTexture("Disabled", "UIData/Hunting_001.tga", 0, 976)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(235, 10)
mywindow:setSize(48, 48)
mywindow:setScaleWidth(280)
mywindow:setScaleHeight(280)
winMgr:getWindow('HuntingNoticeImage'):addChildWindow(mywindow)

----------------------------------------------------
--  ������ �ٴ� �˸� ����
----------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "HuntingItemTextImage")
mywindow:setTexture("Enabled", "UIData/Hunting_001.tga", 0, 884)
mywindow:setTexture("Disabled", "UIData/Hunting_001.tga", 0, 884)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(185, 60)
mywindow:setSize(166, 35)
winMgr:getWindow('HuntingNoticeImage'):addChildWindow(mywindow)

----------------------------------------------------
--  ����� ����2 ���� ( ������ �ִٴ� ����)
----------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "HuntingNoticeImage2")
mywindow:setTexture("Enabled", "UIData/hunting_001.tga", 507, 913)
mywindow:setTexture("Disabled", "UIData/hunting_001.tga", 507, 913)
mywindow:setWideType(5);
mywindow:setPosition(250, -250)
mywindow:setSize(517, 111)
mywindow:setVisible(false)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
mywindow:addController("NoticeMotion2", "NoticeMotion2", "y", "Sine_EaseIn", -250, -250, 20, true, false, 10)
mywindow:addController("NoticeMotion2", "NoticeMotion2", "y", "Sine_EaseIn", 250, 250, 10, true, false, 10)
mywindow:addController("NoticeMotion2", "NoticeMotion2", "y", "Sine_EaseIn", 250, 250, 10, true, false, 10)
mywindow:addController("NoticeMotion2", "NoticeMotion2", "alpha", "Sine_EaseInOut", 0, 0, 20, true, false, 10)
mywindow:addController("NoticeMotion2", "NoticeMotion2", "alpha", "Sine_EaseInOut", 255,255 , 10, true, false, 10)
mywindow:addController("NoticeMotion2", "NoticeMotion2", "alpha", "Sine_EaseInOut", 255,0 , 10, true, false, 10)
root:addChildWindow(mywindow)


----------------------------------------------------
--  ����2�� �ٴ� SPACE �̹���(���� �� �Ծ����� ���)
----------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "HuntingItemImage2")
mywindow:setTexture("Enabled", "UIData/Hunting_001.tga", 166, 843)
mywindow:setTexture("Disabled", "UIData/Hunting_001.tga", 166, 843)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(20, 20)
mywindow:setSize(425, 66)
winMgr:getWindow('HuntingNoticeImage2'):addChildWindow(mywindow)

----------------------------------------------------
--  ����� ����5 ���� ( ���� ���ȴٴ� ����)
----------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "HuntingNoticeImage5")
mywindow:setTexture("Enabled", "UIData/hunting_001.tga", 507, 913)
mywindow:setTexture("Disabled", "UIData/hunting_001.tga", 507, 913)
mywindow:setWideType(5);
mywindow:setPosition(250, 250)
mywindow:setSize(517, 111)
mywindow:setVisible(false)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
mywindow:addController("NoticeMotion5", "NoticeMotion5", "alpha", "Sine_EaseInOut", 255,255 , 10, true, false, 10)
mywindow:addController("NoticeMotion5", "NoticeMotion5", "alpha", "Sine_EaseInOut", 255,0 , 10, true, false, 10)
root:addChildWindow(mywindow)

----------------------------------------------------
--  ����5�� �ٴ� �̹���(���̿��ȴٴ� �̹���)
----------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "HuntingItemImage5")
mywindow:setTexture("Enabled", "UIData/Hunting_001.tga", 0, 400)
mywindow:setTexture("Disabled", "UIData/Hunting_001.tga", 0, 400)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(80, 20)
mywindow:setSize(332, 66)
winMgr:getWindow('HuntingNoticeImage5'):addChildWindow(mywindow)

function NoticeOpenBossArea()
	winMgr:getWindow('HuntingNoticeImage5'):setVisible(true)
	winMgr:getWindow('HuntingNoticeImage5'):clearActiveController()
	winMgr:getWindow('HuntingNoticeImage5'):activeMotion('NoticeMotion5');
end

----------------------------------------------------
--  ����� ������ ȹ�� ����
----------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "HuntingItemGetNoticeImage")
mywindow:setTexture("Enabled", "UIData/fightclub_005.tga", 497 ,62)  
mywindow:setTexture("Disabled", "UIData/fightclub_005.tga", 497 ,62)
mywindow:setWideType(6);
mywindow:setPosition(260,480)
mywindow:setSize(522, 89)
mywindow:setVisible(false)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
mywindow:addController("NoticeMotion3", "NoticeMotion3", "alpha", "Sine_EaseInOut", 255, 255, 20, true, false, 10)
mywindow:addController("NoticeMotion3", "NoticeMotion3", "alpha", "Sine_EaseInOut", 255,0 , 10, true, false, 10)
root:addChildWindow(mywindow)



function ShowHuntingNoticeReward(Path, Notice)
	winMgr:getWindow("HuntingNoticeItemImage"):setTexture("Enabled", Path , 0, 0 )
	winMgr:getWindow("HuntingNoticeItemImage"):setTexture("Disabled", Path , 0, 0 )
	winMgr:getWindow("HuntingItemGetNoticeImage"):clearActiveController()
	winMgr:getWindow("HuntingItemGetNoticeImage"):activeMotion("NoticeMotion3")
	winMgr:getWindow("HuntingItemGetNoticeImage"):setVisible(true)
	winMgr:getWindow("HuntingNoticeMsgString"):setTextExtends(Notice, g_STRING_FONT_GULIMCHE, 13, 112,255,253,255,    1, 0,0,0,255);
end


------------------------------------------------------------------
-- ����� ������ ȹ�� ���� ������ �̹���.
------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "HuntingNoticeItemImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 281, 42)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 281, 42)
mywindow:setPosition(65, 17)
mywindow:setSize(128, 128)
mywindow:setScaleWidth(155)
mywindow:setScaleHeight(155)
mywindow:setVisible(true)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('HuntingItemGetNoticeImage'):addChildWindow(mywindow)

------------------------------------------------------------------
-- ����� ������ ȹ�� ���� ���� �ؽ�Ʈ
------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticText', 'HuntingNoticeMsgString')
mywindow:setFont(g_STRING_FONT_GULIMCHE, 15)
mywindow:setTextColor(36,180,255,255)
mywindow:setPosition(150, 35);
mywindow:setSize(395, 35);
mywindow:setAlign(5)
mywindow:setLineSpacing(0)
mywindow:setViewTextMode(1)
mywindow:setAlwaysOnTop(true)
winMgr:getWindow('HuntingItemGetNoticeImage'):addChildWindow(mywindow)


----------------------------------------------------
-- ���� �׾����� ����
----------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "HuntingNoticeImage3")
mywindow:setTexture("Enabled", "UIData/hunting_001.tga", 332, 626)
mywindow:setTexture("Disabled", "UIData/hunting_001.tga", 332, 626)
mywindow:setWideType(5);
mywindow:setPosition(-700, 200)
mywindow:setSize(692, 75)
mywindow:setVisible(false)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
mywindow:addController("NoticeMotion4n", "NoticeMotion4", "x", "Sine_EaseIn", -700, 150, 5, true, false, 10)
mywindow:addController("NoticeMotion4", "NoticeMotion4", "alpha", "Sine_EaseInOut", 255,255 , 20, true, false, 10);
mywindow:addController("NoticeMotion4", "NoticeMotion4", "alpha", "Sine_EaseInOut", 255,0 , 10, true, false, 10);
root:addChildWindow(mywindow)

----------------------------------------------------
--  �����ۺй��� �̹���
----------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "HuntingRewardTypeImage")
mywindow:setTexture("Enabled", "UIData/Hunting_001.tga", 224, 724)
mywindow:setTexture("Disabled", "UIData/Hunting_001.tga", 224, 724)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setVisible(false)
mywindow:setWideType(1);
mywindow:setPosition(925, 130)
mywindow:setSize(91, 20)
root:addChildWindow(mywindow)

----------------------------------------------------
--  �����ۺй��� �̹��� ����
----------------------------------------------------
function SelectRewardTypeImage()
	
	local isJoinedd = IsPartyJoined()
	if isJoinedd == true then
		root:addChildWindow(winMgr:getWindow("PartyMyInfoDistribute"))
		winMgr:getWindow('PartyMyInfoDistribute'):setPosition(75, 55)
		winMgr:getWindow('PartyMyInfoDistribute'):setVisible(true)
	end

	--[[
	winMgr:getWindow('HuntingRewardTypeImage'):setVisible(true)
	if RewardType == 2 then

		winMgr:getWindow('HuntingRewardTypeImage'):setTexture("Enabled", "UIData/Hunting_001.tga", 224, 684)
		winMgr:getWindow('HuntingRewardTypeImage'):setTexture("Disabled", "UIData/Hunting_001.tga", 224, 684)
		
	elseif RewardType == 1 then
		winMgr:getWindow('HuntingRewardTypeImage'):setTexture("Enabled", "UIData/Hunting_001.tga", 224, 704)
		winMgr:getWindow('HuntingRewardTypeImage'):setTexture("Disabled", "UIData/Hunting_001.tga", 224, 704)
		
	else
		winMgr:getWindow('HuntingRewardTypeImage'):setTexture("Enabled", "UIData/Hunting_001.tga", 224, 724)
		winMgr:getWindow('HuntingRewardTypeImage'):setTexture("Disabled", "UIData/Hunting_001.tga", 224, 724)
	end
	--]]
end

----------------------------------------------------
--  SPACE IMAGE �׸���
----------------------------------------------------
function DrawHuntingSpaceImage(posx, posy)
	drawer:drawTexture("UIData/hunting_001.tga", posx-70, posy, 107,61, 0, 466)	
end

----------------------------------------------------
--  item ctrlŰ �׸���
----------------------------------------------------
function DrawHuntingItemImage(posx,posy)
	drawer:drawTexture("UIData/hunting_001.tga", posx-40, posy+75, 84,57, 458, 558)	
end


----------------------------------------------------
--  �� ȹ�� �ִϸ��̼�
----------------------------------------------------
local ZenNumber = 0
function Hunting_PlayGetZenEffect(gainGran)
	RootWindow = winMgr:createWindow("TaharezLook/StaticImage", "ZenEffectBackImage"..ZenNumber)
	RootWindow:setTexture("Enabled", "UIData/invisible.tga", 992, 848)
	RootWindow:setTexture("Disabled", "UIData/invisible.tga", 992, 848)
	--RootWindow:setPosition(460, 450)
	RootWindow:setPosition(ScreenSizeX/2-50 , ScreenSizeY/2+100)
	RootWindow:setSize(64, 64)
	RootWindow:setEnabled(false)
	RootWindow:setAlwaysOnTop(false)
	RootWindow:setZOrderingEnabled(false)
	RootWindow:addController("ZenBackMotion", "ZenBackMotion", "x", "Linear_EaseNone", ScreenSizeX/2-50, ScreenSizeX-100, 8, true, false, 10)
	RootWindow:setUserString('PlusZenValue', tostring(gainGran))
	RootWindow:subscribeEvent("MotionEventEnd", "HuntingZenEffectEnd");
	root:addChildWindow(RootWindow)	
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ZenEffectImage"..ZenNumber)
	if gainGran == 1 then
		mywindow:setTexture("Disabled", "UIData/hunting_003.tga", 720, 832)
	elseif gainGran == 5 then
		mywindow:setTexture("Disabled", "UIData/hunting_003.tga", 464, 896)	
	elseif gainGran == 10 then
		mywindow:setTexture("Disabled", "UIData/hunting_003.tga", 656, 960)	
	elseif gainGran == 50 then
		mywindow:setTexture("Disabled", "UIData/hunting_003.tga", 656, 768)	
	elseif gainGran == 100 then
		mywindow:setTexture("Disabled", "UIData/hunting_003.tga", 656, 704)	
	end
	
	mywindow:setPosition(0, 0)
	mywindow:setSize(64, 64)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(false)
	mywindow:setAlign(8);
	mywindow:setZOrderingEnabled(false)
	mywindow:setScaleWidth(500)
	mywindow:setScaleHeight(500)
	mywindow:addController("ZenEffectMotion", "ZenEffectMotion", "y", "Sine_EaseIn", 0, -ScreenSizeY/2+50, 8, true, false, 10)
	RootWindow:addChildWindow(mywindow)
	
	winMgr:getWindow("ZenEffectBackImage"..ZenNumber):clearActiveController()
	winMgr:getWindow("ZenEffectBackImage"..ZenNumber):activeMotion("ZenBackMotion")
	winMgr:getWindow("ZenEffectImage"..ZenNumber):clearActiveController()
	winMgr:getWindow("ZenEffectImage"..ZenNumber):activeMotion("ZenEffectMotion")
	
	ZenNumber =  ZenNumber + 1
end

function HuntingZenEffectEnd(args)
	local local_window = CEGUI.toWindowEventArgs(args).window;
	local win_name = local_window:getName();
	GainGranValue = tonumber(local_window:getUserString('PlusZenValue'))
	gainTotalGran = gainTotalGran + GainGranValue
	if local_window ~= nil then
		root:removeChildWindow(win_name)
		winMgr:destroyWindow(win_name)
	end
end

function WndQuest_RenderRank(DungeonType, rank)
	
	
	if DungeonType > 2000 then
		DungeonType = 2000
	end

	drawer:drawTexture("UIData/Arcade_rank.tga", 797, 38, 224, 70, 0, 0, WIDETYPE_1)
	drawer:drawTexture("UIData/Arcade_rank.tga", 954, 31, 47, 47, 265+rank*(47), 0, WIDETYPE_1)
	
end


----------------------------------------------------
--  ĳ���� ��ǥ �ؽ�Ʈ
----------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "QuestMycharacterPosText");
mywindow:setFont(g_STRING_FONT_DODUMCHE, 12)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setPosition(830, 670)
mywindow:setSize(200, 20)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)



----------------------------------------------------
--  ĳ���� ��ǥ ���
----------------------------------------------------
function CurrentMycharacterQuestPos(px, py, pz, angle)
	if angle < 0 then
		angle = angle * -1
	end
	angle = angle % 360
	winMgr:getWindow('QuestMycharacterPosText'):setVisible(true)
	winMgr:getWindow('QuestMycharacterPosText'):setText("PosX  : "..px);
	winMgr:getWindow('QuestMycharacterPosText'):addText("\nPosY  : "..py);
	winMgr:getWindow('QuestMycharacterPosText'):addText("\nPosZ  : "..pz);
	winMgr:getWindow('QuestMycharacterPosText'):addText("\nAngle : "..angle);
end


function ShowHuntingOutBtn()
--	root:addChildWindow(winMgr:getWindow('CharacterInfoBackWindow'))
end

function ShowAracadeInventory()
	
	if winMgr:getWindow("MyInven_BackImage"):isVisible() == true then
		HideMyInventory()
	else
		ShowMyInventory(false, false);
	end
end

function HideAracadeInventory()
	HideMyInventory()
end




----------------------------------------------------
--  ����� �̴ϸ� �۾���
----------------------------------------------------
HUNTINGMINIMAP_POSX = 300
HUNTINGMINIMAP_POSY = 250


local DrawMiniMapNumberPosX = {['err'] = 0, [4000] = 130 , [4001] = 145, [4002] = 190, [4003] =185, [4004] = 225, [4011] = 185 , [4100] = 130} 
local DrawMiniMapNumberPosY = {['err'] = 0, [4000] = 200,  [4001] = 190, [4002] = 250, [4003] =115, [4004] = 95, [4011] = 365 , [4100] = 270}
local DrawMiniMapPath		= {['err'] = 0, [4000] = "UIData/HuntingMinimapPark.tga",  [4001] = "UIData/HuntingMinimapHotel.tga", [4002] = "UIData/HuntingMinimapHalem.tga"
										  , [4003] = "UIData/HuntingMinimapSafe.tga",  [4004] = "UIData/HuntingMinimapSubway.tga", [4011] = "UIData/HuntingMinimapTemple.tga" 
										  , [4100] = "UIData/HuntingMinimapCow.tga"}
local minimap_width = 222
local minimap_height = 136

function Hunting_DrawMiniMap(x, y, angle,  dungeonNumber)
	local posX = x
	local posY = -y
	local mm_width = 222
	local mm_height = 136
	local g_minimapTexX = 380
	local g_minimapTexY = 353
	
	drawer:drawTexture("UIData/blackfadein.tga", 800, 38 , 222, 136, 0, 0, WIDETYPE_1);
	drawer:drawTextureSA(DrawMiniMapPath[dungeonNumber], 800, 38 , 222, 136, DrawMiniMapNumberPosX[dungeonNumber]+posX, DrawMiniMapNumberPosY[dungeonNumber]+posY , 255, 255, 255, 2, 0, WIDETYPE_1);
end

function Hunting_DrawCharacterPosMiniMap(characterIndex, angle, Myposx, Myposy, x, y, hp, dungeonNumber, myindex, bossImage)

	local posX = x
	local posY = -y
	local sizeX = 10
	local sizeY = 10
	
	local diffX = Myposx - x
	local diffY = Myposy - y
	
	local RealPosX = 795+minimap_width/2 - diffX
	local RealPosY = 36 +minimap_height/2 + diffY
	
	if RealPosX > 798 and RealPosX < 795+215 and RealPosY > 43 and RealPosY < 40 + 130 then
		if hp > 0 then
			if characterIndex < 4 then	
				texX = 567
				texY = 581
			else
				texX = 567
				texY = 598
			end
			
			if characterIndex == bossindex then
				--drawer:drawTextureWithScale_Angle_Offset(bossImage, 800+minimap_width/2 - diffX, 36 +minimap_height/2 + diffY, 80, 93, 326, 439, 60, 60, 255, 10, 8, 0, 0, WIDETYPE_1)
				drawer:drawTextureWithScale_Angle_Offset(bossImage, 800+minimap_width/2 - diffX, 34 +minimap_height/2 + diffY, 50, 50, 328, 389, 255, 255, 255, 10, 8, 0, 0, WIDETYPE_1)
			elseif myindex == characterIndex then
				drawer:drawTextureWithScale_Angle_Offset("UIData/village.tga", 800+minimap_width/2, 38 +minimap_height/2, 21, 21, 244, 390, 255, 255, 255, angle, 8, 0, 0, WIDETYPE_1);
			else
				drawer:drawTextureWithScale_Angle_Offset("UIData/hunting_001.tga",  800+minimap_width/2 - diffX, 34 +minimap_height/2 + diffY, sizeX, sizeY, texX, texY, 180, 180, 255, 180, 8, 0, 0, WIDETYPE_1);
			end
		end		
	end
	
	--drawer:drawTextureWithScale_Angle_Offset("UIData/village.tga", 795+minimap_width/2, 38 +minimap_height/2, 21, 21, 244, 390, 255, 255, 255, angle, 8, 0, 0, WIDETYPE_1);
	drawer:drawTexture("UIData/mainBG_Button004.tga", 799, 37 , 224, 138, 288, 277 , WIDETYPE_1);
end

function Hunting_DrawWideMap(dungeonNumber)
	
	if dungeonNumber == 4000 then
		drawer:drawTextureSA("UIData/HuntingMinimapPark.tga", HUNTINGMINIMAP_POSX, HUNTINGMINIMAP_POSY, 512, 512, 0, 0, 255, 255, 255, 0, 0, WIDETYPE_7)
		HUNTINGMINIMAP_POSX = 300
		HUNTINGMINIMAP_POSY = 200
	elseif dungeonNumber == 4001 then
		drawer:drawTextureSA("UIData/HuntingMinimapHotel.tga", HUNTINGMINIMAP_POSX, HUNTINGMINIMAP_POSY, 512, 512, 0, 0, 255, 255, 255, 0, 0, WIDETYPE_7)
		HUNTINGMINIMAP_POSX = 300
		HUNTINGMINIMAP_POSY = 250
	elseif dungeonNumber == 4002 then
		drawer:drawTextureSA("UIData/HuntingMinimapHalem.tga", HUNTINGMINIMAP_POSX, HUNTINGMINIMAP_POSY, 512, 512, 0, 0, 255, 255, 255, 0, 0, WIDETYPE_7)
		HUNTINGMINIMAP_POSX = 300
		HUNTINGMINIMAP_POSY = 200
	elseif dungeonNumber == 4003 then
		drawer:drawTextureSA("UIData/HuntingMinimapSafe.tga", HUNTINGMINIMAP_POSX, HUNTINGMINIMAP_POSY, 512, 512, 0, 0, 255, 255, 255, 0, 0, WIDETYPE_7)
		HUNTINGMINIMAP_POSX = 300
		HUNTINGMINIMAP_POSY = 200
	elseif dungeonNumber == 4004 then
		drawer:drawTextureSA("UIData/HuntingMinimapSubway.tga", HUNTINGMINIMAP_POSX, HUNTINGMINIMAP_POSY, 512, 512, 0, 0, 255, 255, 255, 0, 0, WIDETYPE_7)
		HUNTINGMINIMAP_POSX = 300
		HUNTINGMINIMAP_POSY = 200
	elseif dungeonNumber == 4011 then
		drawer:drawTextureSA("UIData/HuntingMinimapTemple.tga", HUNTINGMINIMAP_POSX, HUNTINGMINIMAP_POSY, 512, 512, 0, 0, 255, 255, 255, 0, 0, WIDETYPE_7)
		HUNTINGMINIMAP_POSX = 250
		HUNTINGMINIMAP_POSY = 150
	elseif dungeonNumber == 4100 then
		drawer:drawTextureSA("UIData/HuntingMinimapCow.tga", HUNTINGMINIMAP_POSX, HUNTINGMINIMAP_POSY, 512, 512, 0, 0, 255, 255, 255, 0, 0, WIDETYPE_7)
		HUNTINGMINIMAP_POSX = 250
		HUNTINGMINIMAP_POSY = 150
	else
		drawer:drawTextureSA("UIData/HuntingMinimapPark.tga", HUNTINGMINIMAP_POSX, HUNTINGMINIMAP_POSY, 512, 512, 0, 0, 255, 255, 255, 0, 0, WIDETYPE_7)
		HUNTINGMINIMAP_POSX = 250
		HUNTINGMINIMAP_POSY = 200
	end
	
end


function Hunting_DrawCharacterPosWideMap(characterIndex, x, y, angle,  hp, bossindex,  bossImage, dungeonNumber, myindex)

	local posX = x
	local posY = -y
	local bossTexX = 328
	local bossTexY = 389
		
	if dungeonNumber == 4000 then
		posX = x+240
		posY = -y+265
	elseif dungeonNumber == 4001 then
		posX = x+255
		posY = -y+255
	elseif dungeonNumber == 4002 then
		posX = x+300
		posY = -y+315
	elseif dungeonNumber == 4003 then
		posX = x+295
		posY = -y+180
	elseif dungeonNumber == 4004 then
		posX = x+335
		posY = -y+160
	elseif dungeonNumber == 4011 then
		posX = x+295
		posY = -y+445
	elseif dungeonNumber == 4100 then
		posX = x+245
		posY = -y+340
		bossTexX = 598
		bossTexY = 337
		
		bossImage = "UIData/Arcade_lobby.tge"
	else
		posX = x+300
		posY = -y+455
	end

	local texX = 497
	local texY = 0
	local sizeX = 10
	local sizeY = 10
	
	if hp > 0 then
		if characterIndex < 4 then
			texX = 567
			texY = 581
		else
			texX = 567
			texY = 598
		end
	
		if characterIndex == bossindex then
			drawer:drawTextureWithScale_Angle_Offset(bossImage, HUNTINGMINIMAP_POSX+posX, HUNTINGMINIMAP_POSY+posY, 50, 50, bossTexX , bossTexY, 255, 255, 255, 10, 8, 0, 0, WIDETYPE_7)
		elseif myindex == characterIndex then
			drawer:drawTextureWithScale_Angle_Offset("UIData/village.tga", HUNTINGMINIMAP_POSX+posX, HUNTINGMINIMAP_POSY+posY, 21, 21, 244, 390, 255, 255, 255, angle, 8, 0, 0, WIDETYPE_7);
		else
			drawer:drawTextureWithScale_Angle_Offset("UIData/hunting_001.tga", HUNTINGMINIMAP_POSX+posX, HUNTINGMINIMAP_POSY+posY, sizeX, sizeY, texX, texY, 180, 180, 255, 180, 8, 0, 0, WIDETYPE_7);
		end
	end		
end




function SetWideScreenSize(width, height)
	ScreenSizeX = width
	ScreenSizeY = height
end

function ShowHuningResetNotice()
	drawer:drawTexture('UIData/hunting_001.tga', 150, 400, 692, 31, 332, 713, WIDETYPE_6)	
end


root:subscribeEvent("KeyUp", "OnQuestKeyUp");
function OnQuestKeyUp(args)	
	local keyEvent = CEGUI.toKeyEventArgs(args);
	if keyEvent.scancode == 40 or keyEvent.scancode == 39 or keyEvent.scancode == 38 or keyEvent.scancode == 37 then 
		if winMgr:getWindow('doChatting'):isActive() == true or winMgr:getWindow('PrivateChatting'):isActive() == true then
			winMgr:getWindow("doChatting"):setText("")
			winMgr:getWindow("doChatting"):setVisible(false)
			Chatting_SetChatEditVisible(false)
			return
		end
	end
end

function DrawCowZoneEndTime(exitRemainTime)
	WndQuest_DrawEachNumberWide("UIData/numberUi001.tga", exitRemainTime, 8, 850, 650, 0, 0, 80, 100, 80, WIDETYPE_6)
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
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)


-- ������ �˾� ESC
RegistEscEventInfo("TipPopUpBackImageBG", "GameTipPopUpCancel")


function DrawHungtingEventRemainTime(remainTime)
	
	local min = remainTime / 60
	local sec1 = (remainTime % 60) / 10
	local sec2 = (remainTime % 60) % 10
	
	drawer:drawTexture('UIData/Arcade_lobby.tga', 324, 400, 376, 119, 648, 268, WIDETYPE_6)
	WndQuest_DrawEachNumberWide("UIData/Arcade_lobby.tga", min, 2, 435, 436, 574, 387, 45, 69, 45, WIDETYPE_6)
	WndQuest_DrawEachNumberWide("UIData/Arcade_lobby.tga", sec1, 8, 500, 436, 574, 387, 45, 69, 45, WIDETYPE_6)
	WndQuest_DrawEachNumberWide("UIData/Arcade_lobby.tga", sec2, 8, 540, 436, 574, 387, 45, 69, 45, WIDETYPE_6)
end










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
local CenterY = (g_Cow_PosY - g_Cow_PosY) + 600

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
	-- ���� ��󳻱�
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
	local y = (g_Cow_PosY - g_Cow_PosY) + 50
	
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
	-- INFOMATION :: drawTexture("���" , ������X, ������Y, ������, ������, �ؽ���Pos, �ؽ���Pos) --
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

-- ī�� �̺�Ʈ ��÷�� ��׶���
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
	--DebugStr("strName : " .. strName)
	--DebugStr("killCnt : " .. killCnt)
	
	---------------------
	--[[
	strName = "�뷱��"	
	killCnt = 999
	WinPosX , WinPosY = GetWindowSize()
	WinPosX = (WinPosX / 2) - (1024 / 2)
	WinPosY = (WinPosY - WinPosY) + 100
	winMgr:getWindow("Event_Cow_Win_Alpha"):setPosition(WinPosX , WinPosY)
	--------------------
	]]--
	
	--local tempStr = string.format(PreCreateString_3608,strName,killCnt)	--GetSStringInfo(LAN_COW_EVENT_MAIL_04)
	--DebugStr("tempStr: " .. tempStr)
	
	if strName ~= nil then
		-- 1. ��� �׸���
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


-- ä��â  �ʱ�  ����
function SetChatInitQuest()
	Chatting_SetChatWideType(2)
	Chatting_SetChatPosition(3, 462)
	Chatting_SetChatEditEvent(3)
	Chatting_SetChatTabDefault()
end

-- ���� �̺�Ʈ
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Event_Hidden_BackImg_Alpha")
mywindow:setTexture("Enabled",	"UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setPosition(CenterX , CenterY - 600)
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
mywindow:setTexture("Enabled",	"UIData/Arcade_hidden1.tga", 328, 389)
mywindow:setTexture("Disabled", "UIData/Arcade_hidden1.tga", 328, 389)
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

	-- if nKillCount == 0 then
	-- 	winMgr:getWindow("Event_Kill_the_Hidden_Img"):setTexture("Enabled",  "UIData/Arcade_2stage.tga", 328, 389)	
	-- end

	-- if nKillCount > 0 and nKillCount < 150000 then																					-- hotel
	-- 	winMgr:getWindow("Event_Kill_the_Hidden_Img"):setTexture("Enabled",  "UIData/Arcade_2stage.tga", 328, 389)		
	-- 	nKillCount = nKillCount % 150000
	-- elseif nKillCount >= 150000 and nKillCount < 300000 then																		-- Halem
	-- 	winMgr:getWindow("Event_Kill_the_Hidden_Img"):setTexture("Enabled",  "UIData/Arcade_3stage.tga", 328, 389)	
	-- 	nKillCount = nKillCount % 150000
	-- elseif nKillCount >= 300000 and nKillCount < 450000 then																		-- H.Road
	-- 	winMgr:getWindow("Event_Kill_the_Hidden_Img"):setTexture("Enabled",  "UIData/Arcade_4stage.tga", 328, 389)	
	-- 	nKillCount = nKillCount % 150000
	-- elseif nKillCount >= 450000 and nKillCount < 600000 then																		-- Subway
	-- 	winMgr:getWindow("Event_Kill_the_Hidden_Img"):setTexture("Enabled",  "UIData/Arcade_5stage.tga", 328, 389)	
	-- 	nKillCount = nKillCount % 150000
	-- elseif nKillCount >= 600000 and nKillCount < 750000 then																		-- Temple
	-- 	winMgr:getWindow("Event_Kill_the_Hidden_Img"):setTexture("Enabled",  "UIData/Arcade_6stage.tga", 328, 389)	
	-- 	nKillCount = nKillCount % 150000
	-- elseif nKillCount >= 750000 and nKillCount < 900000 then																		-- Grave
	-- 	winMgr:getWindow("Event_Kill_the_Hidden_Img"):setTexture("Enabled",  "UIData/Arcade_7stage_3.tga", 328, 389)	
	-- 	winMgr:getWindow("Event_Kill_the_Hidden_Img_grave1"):setVisible(true)
	-- 	winMgr:getWindow("Event_Kill_the_Hidden_Img_grave2"):setVisible(true)
	-- 	nKillCount = nKillCount % 150000
	-- end
	if nKillCount == 0 then
		winMgr:getWindow("Event_Kill_the_Hidden_Img"):setTexture("Enabled",  "UIData/Arcade_hidden1.tga", 328, 389)	
	end

	winMgr:getWindow("Event_Kill_the_Hidden_Img"):setTexture("Enabled",  "UIData/Arcade_hidden1.tga", 328, 389)
	if nKillCount > 0 and nKillCount < 180000 then
		nKillCount = nKillCount % 20000
	else
		nKillCount = 20000
	end

	-- if nKillCount > 0 and nKillCount < 20000 then																					-- hotel
	-- 	winMgr:getWindow("Event_Kill_the_Hidden_Img"):setTexture("Enabled",  "UIData/Arcade_hidden1.tga", 328, 389)		
	-- 	nKillCount = nKillCount % 20000
	-- elseif nKillCount >= 20000 and nKillCount < 40000 then																		-- Halem
	-- 	winMgr:getWindow("Event_Kill_the_Hidden_Img"):setTexture("Enabled",  "UIData/Arcade_hidden1.tga", 328, 389)	
	-- 	nKillCount = nKillCount % 20000
	-- elseif nKillCount >= 40000 and nKillCount < 60000 then																		-- H.Road
	-- 	winMgr:getWindow("Event_Kill_the_Hidden_Img"):setTexture("Enabled",  "UIData/Arcade_hidden1.tga", 328, 389)	
	-- 	nKillCount = nKillCount % 20000
	-- elseif nKillCount >= 60000 and nKillCount < 80000 then																		-- Subway
	-- 	winMgr:getWindow("Event_Kill_the_Hidden_Img"):setTexture("Enabled",  "UIData/Arcade_hidden1.tga", 328, 389)	
	-- 	nKillCount = nKillCount % 20000
	-- elseif nKillCount >= 80000 and nKillCount < 100000 then																		-- Temple
	-- 	winMgr:getWindow("Event_Kill_the_Hidden_Img"):setTexture("Enabled",  "UIData/Arcade_hidden1.tga", 328, 389)	
	-- 	nKillCount = nKillCount % 20000
	-- elseif nKillCount >= 100000 and nKillCount < 120000 then																		-- Grave
	-- 	winMgr:getWindow("Event_Kill_the_Hidden_Img"):setTexture("Enabled",  "UIData/Arcade_hidden1.tga", 328, 389)	
	-- 	-- winMgr:getWindow("Event_Kill_the_Hidden_Img_grave1"):setVisible(true)
	-- 	-- winMgr:getWindow("Event_Kill_the_Hidden_Img_grave2"):setVisible(true)
	-- 	nKillCount = nKillCount % 20000
	-- elseif nKillCount >= 120000 and nKillCount < 140000 then																		-- Temple
	-- 	winMgr:getWindow("Event_Kill_the_Hidden_Img"):setTexture("Enabled",  "UIData/Arcade_hidden1.tga", 328, 389)	
	-- 	nKillCount = nKillCount % 20000
	-- elseif nKillCount >= 140000 and nKillCount < 160000 then																		-- Temple
	-- 	winMgr:getWindow("Event_Kill_the_Hidden_Img"):setTexture("Enabled",  "UIData/Arcade_hidden1.tga", 328, 389)	
	-- 	nKillCount = nKillCount % 20000
	-- elseif nKillCount >= 160000 and nKillCount < 180000 then																		-- Temple
	-- 	winMgr:getWindow("Event_Kill_the_Hidden_Img"):setTexture("Enabled",  "UIData/Arcade_hidden1.tga", 328, 389)	
	-- 	nKillCount = nKillCount % 20000
	-- else
	-- 	nKillCount = 20000
	-- end	
	
	if nKillCount > 0 then
		if (nKillCount % 20000) == 0 then
			nKillCount = 20000	
		end
	end
	
	-- ���� ��󳻱�
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
		winMgr:getWindow("Event_Kill_the_Hidden_Img"):setTexture("Enabled",  "UIData/Arcade_hidden1.tga", 328, 389)	
	end	

	winMgr:getWindow("Event_Kill_the_Hidden_Img"):setTexture("Enabled",  "UIData/Arcade_hidden1.tga", 328, 389)
	if nKillCount > 0 and nKillCount < 180000 then
		nKillCount = nKillCount % 20000
	else
		nKillCount = 20000
	end
	
	-- if nKillCount > 0 and nKillCount < 20000 then																				-- hotel
	-- 	winMgr:getWindow("Event_Kill_the_Hidden_Img"):setTexture("Enabled",  "UIData/Arcade_hidden1.tga", 328, 389)		
	-- 	nKillCount = nKillCount % 20000
	-- elseif nKillCount > 20000 and nKillCount < 40000 then																		-- Halem
	-- 	winMgr:getWindow("Event_Kill_the_Hidden_Img"):setTexture("Enabled",  "UIData/Arcade_hidden1.tga", 328, 389)	
	-- 	nKillCount = nKillCount % 20000
	-- elseif nKillCount > 40000 and nKillCount < 60000 then																		-- H.Road
	-- 	winMgr:getWindow("Event_Kill_the_Hidden_Img"):setTexture("Enabled",  "UIData/Arcade_hidden1.tga", 328, 389)	
	-- 	nKillCount = nKillCount % 20000
	-- elseif nKillCount > 60000 and nKillCount < 80000 then																		-- Subway
	-- 	winMgr:getWindow("Event_Kill_the_Hidden_Img"):setTexture("Enabled",  "UIData/Arcade_hidden1.tga", 328, 389)	
	-- 	nKillCount = nKillCount % 20000
	-- elseif nKillCount > 80000 and nKillCount < 100000 then																		-- Temple
	-- 	winMgr:getWindow("Event_Kill_the_Hidden_Img"):setTexture("Enabled",  "UIData/Arcade_hidden1.tga", 328, 389)	
	-- 	nKillCount = nKillCount % 20000
	-- elseif nKillCount >= 100000 and nKillCount < 120000 then																		-- Grave
	-- 	winMgr:getWindow("Event_Kill_the_Hidden_Img"):setTexture("Enabled",  "UIData/Arcade_hidden1.tga", 328, 389)	
	-- 	-- winMgr:getWindow("Event_Kill_the_Hidden_Img_grave1"):setVisible(true)
	-- 	-- winMgr:getWindow("Event_Kill_the_Hidden_Img_grave2"):setVisible(true)
	-- 	nKillCount = nKillCount % 20000
	-- elseif nKillCount >= 120000 and nKillCount < 140000 then																		-- Temple
	-- 	winMgr:getWindow("Event_Kill_the_Hidden_Img"):setTexture("Enabled",  "UIData/Arcade_hidden1.tga", 328, 389)	
	-- 	nKillCount = nKillCount % 20000
	-- elseif nKillCount >= 140000 and nKillCount < 160000 then																		-- Temple
	-- 	winMgr:getWindow("Event_Kill_the_Hidden_Img"):setTexture("Enabled",  "UIData/Arcade_hidden1.tga", 328, 389)	
	-- 	nKillCount = nKillCount % 20000
	-- elseif nKillCount >= 160000 and nKillCount < 180000 then																		-- Temple
	-- 	winMgr:getWindow("Event_Kill_the_Hidden_Img"):setTexture("Enabled",  "UIData/Arcade_hidden1.tga", 328, 389)	
	-- 	nKillCount = nKillCount % 20000
	-- else
	-- 	nKillCount = 20000
	-- end	
	
	if nKillCount > 0 then
		if (nKillCount % 20000) == 0 then
			nKillCount = 20000	
		end
	end
	
	-- ���� ��󳻱�
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

function WndQuest_DrawEachNumberWide(fileName, number, align, posX, posY, startX, startY, sizeX, sizeY, spacing, widetype, ...)
	local drawer
	if select('#', ...) == 0 then
		drawer = CEGUI.WindowManager:getSingleton():getWindow("DefaultWindow"):getDrawer()
	else
		drawer = select(1, ...)
	end
	
	if number < 0 then
		number = number * -1
	end
	
	local mil = number/1000000
	local hth = (number - (mil*1000000))/100000
	local myr = (number - (mil*1000000 + hth*100000))/10000
	local tho = (number - (mil*1000000 + hth*100000 + myr*10000))/1000
	local hun = (number - (mil*1000000 + hth*100000 + myr*10000 + tho*1000))/100
	local ten = (number - (mil*1000000 + hth*100000 + myr*10000 + tho*1000 + hun*100))/10
	local one = number%10
	
	local _left, _right
	local _1st, _2nd, _3rd, _4th, _5th, _6th, _7th
	
	-- ���� ����(1)
	if align == 1 then
		_1st = posX
		_2nd = posX+sizeX
		_3rd = posX+sizeX+sizeX
		_4th = posX+sizeX+sizeX+sizeX
		_5th = posX+sizeX+sizeX+sizeX+sizeX
		_6th = posX+sizeX+sizeX+sizeX+sizeX+sizeX
		_7th = posX+sizeX+sizeX+sizeX+sizeX+sizeX+sizeX
		
	-- ������ ����(2)
	elseif align == 2 then
		if number >= 1000000 then
			_1st = posX-sizeX-sizeX-sizeX-sizeX-sizeX-sizeX
			_2nd = posX-sizeX-sizeX-sizeX-sizeX-sizeX
			_3rd = posX-sizeX-sizeX-sizeX-sizeX
			_4th = posX-sizeX-sizeX-sizeX
			_5th = posX-sizeX-sizeX
			_6th = posX-sizeX
			_7th = posX
			
		elseif 100000 <= number and number < 1000000 then
			_1st = posX-sizeX-sizeX-sizeX-sizeX-sizeX
			_2nd = posX-sizeX-sizeX-sizeX-sizeX
			_3rd = posX-sizeX-sizeX-sizeX
			_4th = posX-sizeX-sizeX
			_5th = posX-sizeX
			_6th = posX
		
		elseif 10000 <= number and number < 100000 then
			_1st = posX-sizeX-sizeX-sizeX-sizeX
			_2nd = posX-sizeX-sizeX-sizeX
			_3rd = posX-sizeX-sizeX
			_4th = posX-sizeX
			_5th = posX
			
		elseif 1000 <= number and number < 10000 then
			_1st = posX-sizeX-sizeX-sizeX
			_2nd = posX-sizeX-sizeX
			_3rd = posX-sizeX
			_4th = posX
			
		elseif 100 <= number and number < 1000 then
			_1st = posX-sizeX-sizeX
			_2nd = posX-sizeX
			_3rd = posX
		
		elseif 10 <= number and number < 100 then
			_1st = posX-sizeX
			_2nd = posX
			
		elseif 0 <= number and number < 10 then
			_1st = posX
		end
		
	
	-- ��� ����(8)	
	elseif align == 8 then
		if number >= 1000000 then
			_1st = posX-sizeX-sizeX-sizeX
			_2nd = posX-sizeX-sizeX
			_3rd = posX-sizeX
			_4th = posX
			_5th = posX+sizeX
			_6th = posX+sizeX+sizeX
			_7th = posX+sizeX+sizeX+sizeX
			
		elseif 100000 <= number and number < 1000000 then
			_1st = posX - (sizeX/2)-sizeX-sizeX
			_2nd = posX - (sizeX/2)-sizeX
			_3rd = posX - (sizeX/2)
			_4th = posX + (sizeX/2)
			_5th = posX + (sizeX/2)+sizeX
			_6th = posX + (sizeX/2)+sizeX+sizeX
		
		elseif 10000 <= number and number < 100000 then
			_1st = posX-sizeX-sizeX
			_2nd = posX-sizeX
			_3rd = posX
			_4th = posX+sizeX
			_5th = posX+sizeX+sizeX
			
		elseif 1000 <= number and number < 10000 then
			_1st = posX - (sizeX/2)-sizeX
			_2nd = posX - (sizeX/2)
			_3rd = posX + (sizeX/2)
			_4th = posX + (sizeX/2)+sizeX
			
		elseif 100 <= number and number < 1000 then
			_1st = posX-sizeX
			_2nd = posX
			_3rd = posX+sizeX
			
		elseif 10 <= number and number < 100 then
			_1st = posX - (sizeX/2)
			_2nd = posX + (sizeX/2)
			
		elseif 0 <= number and number < 10 then
			_1st = posX
		end
		
	end
	
	
	-- ���� �׸���
	if number >= 1000000 then
		drawer:drawTexture(fileName, _1st, posY, sizeX, sizeY, startX+(mil*spacing), startY, widetype)
		drawer:drawTexture(fileName, _2nd, posY, sizeX, sizeY, startX+(hth*spacing), startY, widetype)
		drawer:drawTexture(fileName, _3rd, posY, sizeX, sizeY, startX+(myr*spacing), startY, widetype)
		drawer:drawTexture(fileName, _4th, posY, sizeX, sizeY, startX+(tho*spacing), startY, widetype)
		drawer:drawTexture(fileName, _5th, posY, sizeX, sizeY, startX+(hun*spacing), startY, widetype)
		drawer:drawTexture(fileName, _6th, posY, sizeX, sizeY, startX+(ten*spacing), startY, widetype)
		drawer:drawTexture(fileName, _7th, posY, sizeX, sizeY, startX+(one*spacing), startY, widetype)
		
		_left	= _1st
		_right	= _7th
		
	elseif 100000 <= number and number < 1000000 then
		drawer:drawTexture(fileName, _1st, posY, sizeX, sizeY, startX+(hth*spacing), startY, widetype)
		drawer:drawTexture(fileName, _2nd, posY, sizeX, sizeY, startX+(myr*spacing), startY, widetype)
		drawer:drawTexture(fileName, _3rd, posY, sizeX, sizeY, startX+(tho*spacing), startY, widetype)
		drawer:drawTexture(fileName, _4th, posY, sizeX, sizeY, startX+(hun*spacing), startY, widetype)
		drawer:drawTexture(fileName, _5th, posY, sizeX, sizeY, startX+(ten*spacing), startY, widetype)
		drawer:drawTexture(fileName, _6th, posY, sizeX, sizeY, startX+(one*spacing), startY, widetype)
		
		_left	= _1st
		_right	= _6th
	
	elseif 10000 <= number and number < 100000 then
		drawer:drawTexture(fileName, _1st, posY, sizeX, sizeY, startX+(myr*spacing), startY, widetype)
		drawer:drawTexture(fileName, _2nd, posY, sizeX, sizeY, startX+(tho*spacing), startY, widetype)
		drawer:drawTexture(fileName, _3rd, posY, sizeX, sizeY, startX+(hun*spacing), startY, widetype)
		drawer:drawTexture(fileName, _4th, posY, sizeX, sizeY, startX+(ten*spacing), startY, widetype)
		drawer:drawTexture(fileName, _5th, posY, sizeX, sizeY, startX+(one*spacing), startY, widetype)
		
		_left	= _1st
		_right	= _5th
	
	elseif 1000 <= number and number < 10000 then
		drawer:drawTexture(fileName, _1st, posY, sizeX, sizeY, startX+(tho*spacing), startY, widetype)
		drawer:drawTexture(fileName, _2nd, posY, sizeX, sizeY, startX+(hun*spacing), startY, widetype)
		drawer:drawTexture(fileName, _3rd, posY, sizeX, sizeY, startX+(ten*spacing), startY, widetype)
		drawer:drawTexture(fileName, _4th, posY, sizeX, sizeY, startX+(one*spacing), startY, widetype)
		
		_left	= _1st
		_right	= _4th
		
	elseif 100 <= number and number < 1000 then
		drawer:drawTexture(fileName, _1st, posY, sizeX, sizeY, startX+(hun*spacing), startY, widetype)
		drawer:drawTexture(fileName, _2nd, posY, sizeX, sizeY, startX+(ten*spacing), startY, widetype)
		drawer:drawTexture(fileName, _3rd, posY, sizeX, sizeY, startX+(one*spacing), startY, widetype)
		
		_left	= _1st
		_right	= _3rd
		
	elseif 10 <= number and number < 100 then
		drawer:drawTexture(fileName, _1st, posY, sizeX, sizeY, startX+(ten*spacing), startY, widetype)
		drawer:drawTexture(fileName, _2nd, posY, sizeX, sizeY, startX+(one*spacing), startY, widetype)
		
		_left	= _1st
		_right	= _2nd
		
	elseif 0 <= number and number < 10 then
		drawer:drawTexture(fileName, _1st, posY, sizeX, sizeY, startX+(one*spacing), startY, widetype)
		
		_left	= _1st
		_right	= _1st
	end
	
	return _left, _right
	
end