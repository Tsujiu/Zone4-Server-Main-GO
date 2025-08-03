local guiSystem = CEGUI.System:getSingleton();
local winMgr = CEGUI.WindowManager:getSingleton();
local root = winMgr:getWindow("DefaultWindow");


--------------------------------------------------------------------
-- 문자열에 대한 정보 받아온다(로컬라이징)
--------------------------------------------------------------------
local CommonSkill_String_GRAN			= PreCreateString_200	--GetSStringInfo(LAN_GRAN)						-- 그랑 
local CommonSkill_String_CASH			= PreCreateString_1955	--GetSStringInfo(LAN_CASH)						-- 캐시
local CommonSkill_String_LEVEL			= PreCreateString_1138	--GetSStringInfo(LAN_LUA_WND_COMMON_SHOP_2)		-- 레벨 
TYPE_GRAN	= 25005		-- 그랑 결제
TYPE_CASH	= 13001		-- 캐시 결제

g_KeepCash	= 0

function GetCash(cash)
	g_KeepCash = cash
end


function inlua_ShowCurrPageNumber(args)
	local sPageName
	for i=1, 9 do
		sPageName = 'Curr_' .. '0' .. tostring(i)
		mywindow = winMgr:getWindow(sPageName)
		mywindow:setProperty('Visible', args)

		sPageName = 'Curr_' .. tostring(i) .. '0'
		mywindow = winMgr:getWindow(sPageName)
		mywindow:setProperty('Visible', args)

		sPageName = 'Total_' .. '0' .. tostring(i)
		mywindow = winMgr:getWindow(sPageName)
		mywindow:setProperty('Visible', args)

		sPageName = 'Total_' .. tostring(i) .. '0'
		mywindow = winMgr:getWindow(sPageName)
		mywindow:setProperty('Visible', args)
	end
	
	mywindow = winMgr:getWindow('Curr_00')
	mywindow:setProperty('Visible', 'false')
	mywindow = winMgr:getWindow('Total_00')
	mywindow:setProperty('Visible', 'false')

end

g_PageSkillCount = 8

-- 스킬 파일 이름을 초기화 한다. --------------------------------------------------------------------------------------------------
function inlua_InitItemTexture()
	for i=1, g_PageSkillCount do	
		local winName = "Select_Item" .. i
		mywindow = winMgr:getWindow(winName)
		mywindow:setUserString('ItemFileName', '')
		mywindow:setUserString('ItemNumber', '')
		mywindow:setUserString('ItemName', '')
		mywindow:setUserString('PricePoint', '-1')
		mywindow:setUserString('PriceCash', '-1')
		mywindow:setUserString('PayType', '-1')
		mywindow:setUserString('Level', '-1')
		mywindow:setUserString('Possession', '0')
		mywindow:setUserString('Hot', '0')
		mywindow:setUserString('New', '0')
		mywindow:setUserString('PageItemIndex', tostring(i))
--		mywindow:setUserString("KeyInput", '');
		mywindow:setProperty("Selected", "false")
	end
end


inlua_InitItemTexture()

function ShowEmptyButton_(args)

	for i=1, g_PageItemCount do
		winName = 'SkillEmpty' .. tostring(i);
		
		winMgr:getWindow(winName):setProperty('Visible', args)
		winName = 'Select_Item' .. tostring(i)
		winMgr:getWindow(winName):setProperty('Visible', args)
		if i == 1 then
			winMgr:getWindow(winName):setProperty('Selected', 'false')
		else
			winMgr:getWindow(winName):setProperty('Selected', 'false')
		end
	end
	
end


-- 스킬샵 아이콘 / 정보들 랜더링 함수.
function renderSkillEndItemContent(args)
	local offset_x = 9;
	local offset_y = 5;
	local offset_x2 = 6;
	local offset_y2 = 7;

	local l_PosX = 115
	local I_PosY = 5
	local bItemNeedCondition	= true;
	local bMyPromotion			= true;
	
	drawer = CEGUI.toWindowEventArgs(args).window:getDrawer();
	local local_window = CEGUI.toWindowEventArgs(args).window;
	drawer:setFont(g_STRING_FONT_GULIMCHE, 112)
	if CEGUI.toWindowEventArgs(args).window:getUserString("ItemName") ~= "" then
	
		local my_money = 0
		local my_level = GetMyLevel();
		
		-- 파일 이름을 가져와서 스킬 이미지 랜더링해줌.======		
		local sItemFileName = CEGUI.toWindowEventArgs(args).window:getUserString('ItemFileName')
		drawer:drawTextureSA(sItemFileName, 2+offset_x, 2+offset_y, 102, 90, 0, 0, 186, 186, 255,0,0)

		--==================================================
		
		-- 스킬 가격========================================
		drawer:setTextColor(0, 0, 0, 255)
		local price_point = CEGUI.toWindowEventArgs(args).window:getUserString("PricePoint");
		if price_point == '-1' then
			price_point = '0';
		end
		
		local PayType	= tonumber(CEGUI.toWindowEventArgs(args).window:getUserString("PayType"))
		
		local	String	= ""
		if PayType	== TYPE_GRAN then
			String		= CommonSkill_String_GRAN
			my_money	= GetMyMoney();
			drawer:drawTexture("UIData/Itemshop001.tga",130, 57, 19, 19, 482, 788);
		elseif PayType	== TYPE_CASH then
			String		= CommonSkill_String_CASH
			my_money	= GetMyCash();
			drawer:drawTexture("UIData/Itemshop001.tga",130, 57, 19, 19, 462, 788);
		end

		local str_price = tostring(NumberStrToMoneyStr(price_point)).." "..String
		local str_price_size = GetStringSize(g_STRING_FONT_GULIMCHE, 112, str_price);
		local str_price_ctrl_pos = (116 - str_price_size)/2;
		--==================================================	
		
		--제한레벨==========================================
		local level_str = CEGUI.toWindowEventArgs(args).window:getUserString("Level");
		local str_level = CommonSkill_String_LEVEL..tostring(level_str);
		local str_level_size = GetStringSize(g_STRING_FONT_GULIMCHE, 112, str_level);
		local str_level_ctrl_pos = (-3 - str_level_size)/2;	
		--==================================================		
		
		drawer:setTextColor(0,0,0,255);
		local itemNum = local_window:getUserString('ItemNumber');
		local KeyInput = local_window:getUserString('KeyInput');	-- 커멘드 아직 안넣었음.나중에 넣을지도..
		local itemKind = 'Grab';									-- 잡기 계열인지 타격 계열인지..
		if itemNum/100000 == 8 then									-- 아이템 넘버로 타격계열인지 잡기계열인지 골라냄.
			itemKind = 'Street';
		end
		
		--직업 관련---
		local _my_name, _money, _level, _promotion, _my_style, _type, _sp_point, _hp_point, _experience = GetMyInfo(false);
		-- 직업 아이콘.
		if g_CurrViewAttackType == "1" then
			drawer:drawTextureSA("UIData/skillitem001.tga", 43, 52, 87, 35, 497, g_SkillTypeRadioIndex * 35, 186, 186, 255,0,0)--스트리트
		elseif g_CurrViewAttackType == "2" then
			drawer:drawTextureSA("UIData/skillitem001.tga", 43, 52, 87, 35, 585, g_SkillTypeRadioIndex * 35, 186, 186, 255,0,0)		-- 		
			--(const char * textureName, int x, int y, int width, int height, int textureX, int textureY, int scaleX, int scaleY, int alpha, int align, float angle) 	
		end
		
		local My_promotion	= ""
		
		if _my_style % 2 == 0 then		-- 스트리트
			My_promotion = "chr_strike"
		else							-- 러쉬
			My_promotion = "chr_grab"
		end
		
		if My_promotion == "chr_strike" and itemKind == "Grab" then
			bItemNeedCondition	= false;
			bMyPromotion		= false;
		elseif My_promotion == "chr_grab" and itemKind == "Street" then
			bItemNeedCondition	= false;
			bMyPromotion		= false;
		else
			if (g_SkillTypeRadioIndex ~= 0) and (_promotion ~= g_SkillTypeRadioIndex) then
				bItemNeedCondition	= false;
				bMyPromotion		= false;
			end
		end

		local skillDesc = local_window:getUserString('ItemDesc');
		sText = skillDesc;

		local _DescStart, _DescEnd = string.find(sText, "%$");
		local _ItemSkillKind = "";		--스킬종류
		local _ItemSkillDamage = "";	--스킬데미지
		local _ItemDetailDesc = "";		--스킬설명
		
		if _DescStart ~= nil then
			_ItemSkillKind = string.sub(sText, 1, _DescStart - 1);
			_ItemDetailDesc = string.sub(sText, _DescEnd + 1);
		
			_DescStart, _DescEnd = string.find(_ItemDetailDesc, "%$");
			if _DescStart ~= nil then
				_ItemSkillDamage = string.sub(_ItemDetailDesc, 1, _DescStart - 1);
				_ItemDetailDesc = string.sub(_ItemDetailDesc, _DescEnd + 1);
			end
			
		end
		
		drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
		Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, _ItemSkillKind)
		common_DrawOutlineText1(drawer, _ItemSkillKind, l_PosX + 54 - (Size / 2) , I_PosY + 19 + offset_y + offset_y2, 255,255,255,255, 50,80,230,255)
--		common_DrawOutlineText2(drawer, KeyInput, l_PosX + offset_x + offset_x2, I_PosY + 17 * 2 + offset_y + offset_y2, 255,255,255,255, 0,0,0,255);
		drawer:setFont(g_STRING_FONT_GULIMCHE, 112);
		
		-- 아이템 보유를 나타냄
		
		if local_window:getUserString('Possession') == "1" then
			drawer:drawTexture("UIData/skillshop002.tga", 3, 4, 52, 17, 89, 953);
		end
		
		-- 프라이스하고 레벨 그리기
		-- Itemshop001.tga
		drawer:drawTexture("UIData/Itemshop001.tga", 45, 4, 48, 16, 348, 837);
		--drawer:drawTexture("UIData/Itemshop001.tga",  4, 88, 116, 16, 280, 859);
		
		drawer:setFont(g_STRING_FONT_GULIMCHE, 112);
		if my_level >= tonumber(level_str) then
			drawer:setTextColor(204,255,255,255);
		else
			drawer:setTextColor(254,120,120,255);
			bItemNeedCondition = false;
		end
		drawer:drawText(str_level, 72+str_level_ctrl_pos, 7);
		
		-- 내돈 검사
		if my_money >= tonumber(price_point) then
			drawer:setTextColor(50,80,230,255);
		else
			drawer:setTextColor(254,120,120,255);
			bItemNeedCondition = false;
		end
		
		
		drawer:setFont(g_STRING_FONT_GULIMCHE, 212)
		drawer:drawText(str_price, 129+str_price_ctrl_pos, 58+3);
		drawer:setFont(g_STRING_FONT_GULIMCHE, 112);
		
		--스킬 이름 설정(필요조건에 만족하지 못하는게 한개라도 있으면 빨간색으로 표시해주기위해 마지막에..
		
		drawer:setTextColor(0, 0, 0, 255)
		local sText =CEGUI.toWindowEventArgs(args).window:getUserString("ItemName")
		--sText = CEGUI.toWindowEventArgs(args).window:getUserString("ItemName")
		
		local nameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, sText)
		if bItemNeedCondition == true then
			--drawer:drawText(sText, l_PosX+offset_x+3, I_PosY+offset_y)		
			common_DrawOutlineText2(drawer, sText, l_PosX+offset_x+45-nameSize/2, I_PosY+offset_y+2, 60,60,60,255, 204,255,255,255)
		else
			common_DrawOutlineText2(drawer, sText, l_PosX+offset_x+45-nameSize/2, I_PosY+offset_y+2, 30,30,30,255, 254,120,120,255)
		end
		
		drawer:setTextColor(0, 0, 0, 255)
		if bMyPromotion == false then
			drawer:drawTexture("UIData/skillshop002.tga", 3, 4, 52, 17, 89, 970);
			drawer:drawTexture("UIData/skillitem001.tga", 0, 0, 235, 110, 0, 439);
		end
	end
--	renderItemSelect(args)
end


-- 버튼 이벤트 함수
-- 타격 스킬 카테고리를 보이게/안보이게 한다. -------------------------------------------------------------------------
function inlua_ShowStrikeItemCategory(args)
	local winName = {['protecterr'] = 0, "CS_Street", "CS_Taekwondo", "CS_Boxing", "CS_Muaythai", "CS_Capoera"}
	
	for i=1, #winName do
		winMgr:getWindow(winName[i]):setProperty('Visible', args);
	end	
end



-- 잡기 스킬 카테고리를 보이게/안보이게 한다. -------------------------------------------------------------------------
function inlua_ShowGrabItemCategory(args)
	local winName = {['protecterr'] = 0, "CS_Rush", "CS_Prowrestling", "CS_Judo", "CS_Hapgido", "CS_Sambo"}
	
	for i=1, #winName do
		winMgr:getWindow(winName[i]):setProperty('Visible', args);
	end
end


-- 기본 틀 스태틱 이미지 -----------------------------------------------------------------------------------------
tWinName = {['protecterr'] = 0,  "CS_SKillVideo", 'CS_MessageBoxImg' }
tTextureX = {['protecterr'] = 0,     548,             0}
tTextureY = {['protecterr'] = 0,       0,             0}
tSizeX = {['protecterr'] = 0,        476,             0}
tSizeY = {['protecterr'] = 0,        548,             0}
tPosX = {['protecterr'] = 0,          17,             0}
tPosY = {['protecterr'] = 0,         136,             0}

for i=1, #tWinName do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", tWinName[i])
	mywindow:setSize(tSizeX[i], tSizeY[i])
	mywindow:setPosition(tPosX[i], tPosY[i])
	mywindow:setProperty("FrameEnabled", "false")	
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setZOrderingEnabled(false)
	
	mywindow:setTexture("Enabled", "UIData/SkillShop002.tga", tTextureX[i], tTextureY[i])
	
	root:addChildWindow(mywindow)
end


-- 기본 틀 스태틱 이미지 -----------------------------------------------------------------------------------------

mywindow = winMgr:createWindow("TaharezLook/StaticImage", 'Common_Skill_MainImage')
mywindow:setTexture("Enabled", "UIData/SkillShop002.tga", 0, 0);
mywindow:setProperty("FrameEnabled", "false")	
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setPosition(514, 118);
mywindow:setSize(487, 565);
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

--[[
mywindow = winMgr:getWindow('스킬샵 메인');
mywindow:setPosition(513, 118);
mywindow:setTexture("Enabled", "UIData/tutorial005.tga", 537, 0);
mywindow:setSize(577, 573);
--]]


winMgr:getWindow('CS_ItemMainWin'):setVisible(false)

nSizeX = 235;
nSizeY = 110;
nPosX = 9;
nPosY = 55;
nTextureAlphaX = 300;
nTextureAlphaY = 765;
nTextureX = 299;
nTextureY = 765;
nTextureHoverX = 300;
nTextureHoverY = 875;

nPosX = {['protecterr'] = 0,       8,  6+240,       8,   6+240,         8,     6+240,         8,     6+240 }
nPosY = {['protecterr'] = 0,      54,     54,  54+112,  54+112,  54+112*2,  54+112*2,  54+112*3,  54+112*3 }

-- 빈 선택 영역하고 선택 영역하고 같이 하고 있다.
for i=1, #tEmptyWinName do
	DebugStr(tItemSelectWinName[i]);
	select_mywindow = winMgr:getWindow(tItemSelectWinName[i]);
	select_mywindow:setSize(nSizeX, nSizeY);
	
	select_mywindow:setTexture("Normal", "UIData/SkillShop002.tga", 8, 54)
	select_mywindow:setTexture("Hover", "UIData/SkillShop002.tga", nTextureHoverX, nTextureHoverY)
	select_mywindow:setTexture("Pushed", "UIData/SkillShop002.tga", nTextureX, nTextureY)
	select_mywindow:setTexture("PushedOff", "UIData/SkillShop002.tga", nTextureX, nTextureY)

	select_mywindow:setTexture("SelectedNormal", "UIData/SkillShop002.tga", nTextureX, nTextureY)
	select_mywindow:setTexture("SelectedHover", "UIData/SkillShop002.tga", nTextureX, nTextureY)
	select_mywindow:setTexture("SelectedPushed", "UIData/SkillShop002.tga", nTextureX, nTextureY)
	select_mywindow:setTexture("SelectedPushedOff", "UIData/SkillShop002.tga", nTextureX, nTextureY)
	select_mywindow:setPosition(nPosX[i], nPosY[i]);
	
	mywindow = winMgr:getWindow(tEmptyWinName[i]);
	mywindow:setSize(0, 0);
	mywindow:setTexture("Enabled", "UIData/Itemshop001.tga", 0, 0);
	
	mywindow:setPosition(nPosX[i], nPosY[i]);
end

-- 타격 카테고리 --------------------------------------------------------------------------------------------------
tWinName = {['protecterr'] = 0,	   "CS_Street", "CS_Taekwondo", "CS_Boxing", "CS_Muaythai", "CS_Capoera"}
tTextureX = {['protecterr'] = 0,			0,		 98,       98*2,       98*3,	   98*4 }
tTextureY = {['protecterr'] = 0,		  649,	    649,	    649,	    649,	    649 }
tTextureHoverX = {['protecterr'] = 0,		0,		 98,       98*2,       98*3,	   98*4 }
tTextureHoverY = {['protecterr'] = 0,	  611,	    611,	    611,	    611,		611 }
tTextureSelectedX = {['protecterr'] = 0,	0,		 98,       98*2,       98*3,	   98*4 }
tTextureSelectedY = {['protecterr'] = 0,  573,	    573,		573,	    573,		573 }
nSizeX		= 98
nSizeY		= 38
nPosX		= 513
nPosY		= 83
nOffsetX	= 98
nOffsetY	= 0

for i=1, #tWinName do

	local mywindow = winMgr:createWindow("TaharezLook/RadioButton", tWinName[i])
	mywindow:setTexture("Normal", "UIData/SkillShop002.tga", tTextureX[i], tTextureY[i])
	mywindow:setTexture("Hover", "UIData/SkillShop002.tga", tTextureHoverX[i], tTextureHoverY[i])
	mywindow:setTexture("Pushed", "UIData/SkillShop002.tga", tTextureHoverX[i], tTextureHoverY[i])
	mywindow:setTexture("PushedOff", "UIData/SkillShop002.tga", tTextureX[i], tTextureY[i])

	mywindow:setTexture("SelectedNormal", "UIData/SkillShop002.tga", tTextureSelectedX[i], tTextureSelectedY[i])
	mywindow:setTexture("SelectedHover", "UIData/SkillShop002.tga", tTextureSelectedX[i], tTextureSelectedY[i])
	mywindow:setTexture("SelectedPushed", "UIData/SkillShop002.tga", tTextureSelectedX[i], tTextureSelectedY[i])
	mywindow:setTexture("SelectedPushedOff", "UIData/SkillShop002.tga", tTextureSelectedX[i], tTextureSelectedY[i])

	mywindow:setSize(nSizeX, nSizeY)
	mywindow:setPosition(nPosX+nOffsetX*(i-1), nPosY)
	mywindow:setProperty("GroupID", 2);
	
	mywindow:setUserString('Category', tostring(i));
	mywindow:setProperty('AlwaysOnTop', 'false');
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("SubItemNumber", tostring(i));
	mywindow:setUserString('Index', tostring(i));
	mywindow:subscribeEvent("SelectStateChanged", "inlua_SelectedStrikeCategory");
	root:addChildWindow(mywindow);
	
end

-- 잡기 카테고리 ------------------------------------------------------------------------------------------------------
tWinName = {['protecterr'] = 0,      "CS_Rush", "CS_Prowrestling", "CS_Judo", "CS_Hapgido", "CS_Sambo"}
tTextureX = {['protecterr'] = 0,       98*5,     98*6,   98*7,     98*8,    98*9}
tTextureY = {['protecterr'] = 0,        649,      649,    649,      649,     649}
tTextureHoverX = {['protecterr'] = 0,  98*5,     98*6,   98*7,     98*8,    98*9}
tTextureHoverY = {['protecterr'] = 0,   611,      611,    611,      611,     611}
tTexturePushedX = {['protecterr'] = 0, 98*5,     98*6,   98*7,     98*8,    98*9}
tTexturePushedY = {['protecterr'] = 0,  573,      573,    573,      573,     573}
nSizeX = 98
nSizeY = 38
nPosX = 513
nPosY = 83
nOffsetX = 98
nOffsetY = 0

for i=1, #tWinName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tWinName[i])
	mywindow:setTexture("Normal", "UIData/SkillShop002.tga", tTextureX[i], tTextureY[i])
	mywindow:setTexture("Hover", "UIData/SkillShop002.tga", tTextureHoverX[i], tTextureHoverY[i])
	mywindow:setTexture("Pushed", "UIData/SkillShop002.tga", tTexturePushedX[i], tTexturePushedY[i])
	mywindow:setTexture("PushedOff", "UIData/SkillShop002.tga", tTextureX[i], tTextureY[i])
	
	mywindow:setTexture("SelectedNormal", "UIData/SkillShop002.tga", tTexturePushedX[i], tTexturePushedY[i])
	mywindow:setTexture("SelectedHover", "UIData/SkillShop002.tga", tTexturePushedX[i], tTexturePushedY[i])
	mywindow:setTexture("SelectedPushed", "UIData/SkillShop002.tga", tTexturePushedX[i], tTexturePushedY[i])
	mywindow:setTexture("SelectedPushedOff", "UIData/SkillShop002.tga", tTexturePushedX[i], tTexturePushedY[i])

	mywindow:setSize(nSizeX, nSizeY)
	mywindow:setPosition(nPosX+nOffsetX*(i-1), nPosY)
	mywindow:setProperty("GroupID", 3)
	mywindow:setProperty('Visible', 'false')
	mywindow:setProperty('AlwaysOnTop', 'false')
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString('Category', tostring(i))	
	mywindow:setUserString('Index', tostring(i));
	mywindow:subscribeEvent("SelectStateChanged", "inlua_SelectedGrabCategory")
	root:addChildWindow(mywindow)

end



local _pos0 = winMgr:getWindow('CS_Judo'):getPosition();
local _pos1 = winMgr:getWindow('CS_Prowrestling'):getPosition();
winMgr:getWindow('CS_Judo'):setPosition(_pos1.x.offset, _pos1.y.offset);
winMgr:getWindow('CS_Prowrestling'):setPosition(_pos0.x.offset+98, _pos0.y.offset);

-------------------------------------- 하위 카테고리 --------------------------------------------------------
tWinName = {['protecterr'] = 0,   "CS_Tab_AllSkill", "CS_Tab_BuyEnable", "CS_Tab_Strike", "CS_Tab_Grab", "CS_Tab_Special", "CS_Tab_TeamDouble", "CS_Tab_Etc" }
tTextureX = {['protecterr'] = 0,		   0,         66,   66*2,   66*3,     66*4,      66*5,   66*6 }
tTextureY = {['protecterr'] = 0,	     687,        687,    687,    687,      687,       687,    687 }
tTextureHoverX = {['protecterr'] = 0,      0,         66,   66*2,   66*3,     66*4,      66*5,   66*6 }
tTextureHoverY = {['protecterr'] = 0,    713,        713,    713,    713,      713,       713,    713 }
tTextureSelectedX = {['protecterr'] = 0,   0,         66,   66*2,   66*3,     66*4,      66*5,   66*6 }
tTextureSelectedY = {['protecterr'] = 0, 739,        739,    739,    739,      739,       739,    739 }
nSizeX = 66
nSizeY = 26
nPosX = 9
nPosY = 15
nOffsetX = 67
nOffsetY = 0

for i=1, #tWinName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tWinName[i])
	mywindow:setTexture("Normal", "UIData/SkillShop002.tga", tTextureX[i], tTextureY[i])
	mywindow:setTexture("Hover", "UIData/SkillShop002.tga", tTextureHoverX[i], tTextureHoverY[i])
	mywindow:setTexture("Pushed", "UIData/SkillShop002.tga", tTextureSelectedX[i], tTextureSelectedY[i])
	mywindow:setTexture("PushedOff", "UIData/SkillShop002.tga", tTextureX[i], tTextureY[i])
	
	mywindow:setTexture("SelectedNormal", "UIData/SkillShop002.tga", tTextureSelectedX[i], tTextureSelectedY[i])
	mywindow:setTexture("SelectedHover", "UIData/SkillShop002.tga", tTextureSelectedX[i], tTextureSelectedY[i])
	mywindow:setTexture("SelectedPushed", "UIData/SkillShop002.tga", tTextureSelectedX[i], tTextureSelectedY[i])
	mywindow:setTexture("SelectedPushedOff", "UIData/SkillShop002.tga", tTextureSelectedX[i], tTextureSelectedY[i])

	mywindow:setSize(nSizeX, nSizeY)
	mywindow:setPosition(nPosX+nOffsetX*(i-1), nPosY)
	mywindow:setProperty("GroupID", 4)
	mywindow:setUserString('Index', tostring(i));
		
	mywindow:subscribeEvent("SelectStateChanged", "inlua_SelectedSubCategory")
	winParent = winMgr:getWindow("Common_Skill_MainImage")
	 winParent:addChildWindow(mywindow)
end


-- 타격/잡기 선택 -----------------------------------------------------------------------------------------
tWinName = {['protecterr'] = 0,     "CS_StrikeClass_Tab", "CS_GrabClass_Tab"}
tTextureX = {['protecterr'] = 0,              0,        150 }
tTextureY = {['protecterr'] = 0,            766,        766 }
tTextureHoverX = {['protecterr'] = 0,         0,        150 }
tTextureHoverY = {['protecterr'] = 0,       812,        812 }
tTexturePushedX = {['protecterr'] = 0,        0,        150 }
tTexturePushedY = {['protecterr'] = 0,      858,        858 }
tTextureSelectedX = {['protecterr'] = 0,      0,        150 }
tTextureSelectedY = {['protecterr'] = 0, 858+46,     858+46 }
nSizeX = 150
nSizeY = 46
nPosX = 16 
nPosY = 83
nOffsetX = 154
nOffsetY = 0

for i=1, #tWinName do

	local mywindow = winMgr:createWindow("TaharezLook/RadioButton", tWinName[i]);
	mywindow:setTexture("Normal", "UIData/SkillShop002.tga", tTextureX[i], tTextureY[i]);
	mywindow:setTexture("Hover", "UIData/SkillShop002.tga", tTextureHoverX[i], tTextureHoverY[i]);
	mywindow:setTexture("Pushed", "UIData/SkillShop002.tga", tTexturePushedX[i], tTexturePushedY[i]);
	mywindow:setTexture("PushedOff", "UIData/SkillShop002.tga", tTexturePushedX[i], tTexturePushedY[i]);

	mywindow:setTexture("SelectedNormal", "UIData/SkillShop002.tga", tTextureSelectedX[i], tTextureSelectedY[i]);
	mywindow:setTexture("SelectedHover", "UIData/SkillShop002.tga", tTextureSelectedX[i], tTextureSelectedY[i]);
	mywindow:setTexture("SelectedPushed", "UIData/SkillShop002.tga", tTextureSelectedX[i], tTextureSelectedY[i]);
	mywindow:setTexture("SelectedPushedOff", "UIData/SkillShop002.tga", tTextureSelectedX[i], tTextureSelectedY[i]);

	mywindow:setSize(nSizeX, nSizeY);
	mywindow:setPosition(nPosX+nOffsetX*(i-1), nPosY);
	mywindow:setProperty("GroupID", 1);
	
	mywindow:setUserString('AttackType', tostring(i)); -- 현재 메뉴에서 타격인지 잡기인지
	mywindow:subscribeEvent("SelectStateChanged", "inlua_SelectedStrikeOrGrab");
	root:addChildWindow(mywindow);
	
end

tSkillEmptyName = {['protecterr'] = 0, "SkillEmpty1", "SkillEmpty2", "SkillEmpty3", "SkillEmpty4", "SkillEmpty5", "SkillEmpty6", "SkillEmpty7", "SkillEmpty8"}
tSkillEmptyPosY = {['protecterr'] = 0,      54, 54, 54+112, 54+112, 54+112*2, 54+112*2, 54+112*3, 54+112*3}
tSkillEmptyPosX = {['protecterr'] = 0,      8, 8+238,8, 8+238, 8, 8+238, 8, 8+238}

for i=1, #tSkillEmptyName do

	mywindow = winMgr:createWindow('TaharezLook/StaticImage', tSkillEmptyName[i])
	mywindow:setTexture('Enabled', "UIData/skillitem001.tga", 0, 551)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(tSkillEmptyPosX[i], tSkillEmptyPosY[i]);
	mywindow:setSize(235, 110)
	mywindow:setVisible(true)
	winMgr:getWindow('Common_Skill_MainImage'):addChildWindow(mywindow)
end




winMgr:getWindow('CS_ItemInfoWin'):setVisible(false);


