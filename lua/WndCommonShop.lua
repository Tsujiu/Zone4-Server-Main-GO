guiSystem = CEGUI.System:getSingleton();
winMgr = CEGUI.WindowManager:getSingleton();
root = winMgr:getWindow("DefaultWindow");
guiSystem:setGUISheet(root)
guiSystem:setDefaultMouseCursor("TaharezLook", "MouseArrow")

--------------------------------------------------------------------
-- 문자열에 대한 정보 받아온다(로컬라이징)
--------------------------------------------------------------------
local CommonShop_String_GRAN					= PreCreateString_200	--GetSStringInfo(LAN_GRAN)						-- 그랑 
CommonShop_String_LEVEL							= PreCreateString_1138	--GetSStringInfo(LAN_LUA_WND_COMMON_SHOP_2)		-- 레벨 
CommonShop_String_PURCHASE						= PreCreateString_1139	--GetSStringInfo(LAN_LUA_WND_COMMON_SHOP_3)		-- %s을(를) 구입하시겠습니까? 
CommonShop_String_ATTACH						= PreCreateString_1140	--GetSStringInfo(LAN_LUA_WND_COMMON_SHOP_4)		-- %s을(를) 착용하시겠습니까?
CommonShop_String_NOT_CHARACTER					= PreCreateString_1141	--GetSStringInfo(LAN_LUA_WND_COMMON_SHOP_5)		-- 캐릭터가 맞지 않습니다.
CommonShop_String_NOT_LEVEL						= PreCreateString_103	--GetSStringInfo(LAN_LOW_CHARACLEVEL)		-- 레벨이 맞지 않습니다.
CommonShop_String_NOT_TYPE						= PreCreateString_1143	--GetSStringInfo(LAN_LUA_WND_COMMON_SHOP_7)		-- 타입이 맞지 않습니다.
local CommonShop_String_NOT_SELECTiTEM			= PreCreateString_1144	--GetSStringInfo(LAN_LUA_WND_COMMON_SHOP_8)		-- 선택한 아이템이 없습니다.
local CommonShop_String_ALREADY_HAVEITEM		= PreCreateString_1145	--GetSStringInfo(LAN_LUA_WND_COMMON_SHOP_9)		-- 이미 보유한 아이템입니다.
local CommonShop_String_ALREADY_ATTACHITEM		= PreCreateString_1146	--GetSStringInfo(LAN_LUA_WND_COMMON_SHOP_10)	-- 이미 착용한 아이템입니다.
local CommonShop_String_NOT_RELEASE_BASEITEM	= PreCreateString_1147	--GetSStringInfo(LAN_LUA_WND_COMMON_SHOP_11)	-- 기본 아이템은 해제할 수 없습니다.
local CommonShop_String_NOT_ATTACH				= PreCreateString_1148	--GetSStringInfo(LAN_LUA_WND_COMMON_SHOP_12)	-- 착용중인 아이템이 아닙니다.
local CommonShop_String_PURCHASE_ITEM_ALL		= PreCreateString_1149	--GetSStringInfo(LAN_LUA_WND_COMMON_SHOP_13)	-- 모두 구입하시겠습니까?
local CommonShop_String_ATTACH_ITEM_ALL			= PreCreateString_1150	--GetSStringInfo(LAN_LUA_WND_COMMON_SHOP_14)	-- 구입한 아이템을 모두 착용하시겠습니까?
local CommonShop_String_SELECT_ITEM				= PreCreateString_1197	--GetSStringInfo(LAN_LUA_WND_MYINFO_5)			-- 아이템을 선택해주세요
local CommonShop_String_NOT_ENOUGH_GRAN			= PreCreateString_1012	--GetSStringInfo(LAN_LUA_ARCADESHOP_6)			-- 그랑이 부족합니다
local CommonShop_String_NOT_ENOUGH_CASH			= PreCreateString_95	--GetSStringInfo(LAN_SHORT_CASH)				-- 캐시가 부족합니다
Common_String_CASH								= PreCreateString_1955	--GetSStringInfo(LAN_CASH)
TYPE_GRAN	= 25005		-- 그랑 결제
TYPE_CASH	= 13001		-- 캐시 결제
--------------------------------
------- 공통 전역 변수들 -------
--------------------------------
g_IsRecv = false;
g_CurrCategory = "-1";
g_BoneType = "-1";

g_PageItemCount		= 8;
g_PageAllBuyCount	= 3;

g_nCurrPage		= 1;
g_nTotalPage	= 1;

g_nCurrAllbuyPage	= 1;
g_nTotalAllbuyPage	= 1;

g_IsDebug = true;

root:setUserString('CurrItemIndex', '-1');

function DebugStr(args)
	if g_IsDebug == true then
		Lua_DebugStr(args);
	end
end

DebugStr('WndCommonShop lua START');
--------------------------------
------- 공통 UI 이벤트들 -------
--------------------------------
-- 캐릭터 회전 이벤트 --
function CharRotateLeftDown()	-- 왼쪽 회전
	CharRotateOn(0)
end
function CharRotateRightDown()	-- 오른쪽 회전
	CharRotateOn(1)
end
function CharRotateLeftUp()		-- 회전 멈추기(마우스 버튼 땟을때)
	CharRotateOff()
end
function CharRotateRightUp()	-- 회전 멈추기(마우스 버튼 땟을때)
	CharRotateOff()
end


-----------------------------------------------
--------------- 공통 일반 함수들 --------------
-----------------------------------------------

function Begin()	--- 왜 이렇게 해야만 하는지 모르겠음;; ---
	winMgr:getWindow('CS_ALL'):setProperty('Selected', 'true');
end

function RenderStart(args)
	g_IsRecv = false;
	if args == true then
		g_IsRecv = true;
	end
end

-- 코스튬 라이오 버튼 보여짐 true 보여지고 flase 이면 사라짐
function ShowCostumeSub(args)
	local WinName = {['protecterr'] = 0, 'CS_ALL', 'CS_HEAR', 'CS_FACE', 'CS_UPPER', 'CS_HAND', 'CS_LOWER', 'CS_FOOT', 'CS_DECO', 'CS_SET'}

	for i=1, #WinName do
		winMgr:getWindow(WinName[i]):setProperty('Visible', args)
		winMgr:getWindow(WinName[1]):setProperty('Selected', 'false')
	end
	
end

-- 아이템 라이오 버튼 보여짐 true 보여지고 flase 이면 사라짐
function ShowItemSub(args)
	local WinName = {['protecterr'] = 0, 'CS_ALL2', 'CS_ATTACK', 'CS_DEFFENCE', 'CS_SPECIAL'}

	for i=1, #WinName do
		--winMgr:getWindow(WinName[i]):setProperty('Visible', args)
		winMgr:getWindow(WinName[1]):setProperty('Selected', 'false')
	end
	
end

-- 엠프티(빈) 버튼 보여줌, 사라짐 - 이 함수는 C++에서도 호출함 주의 바람~
function ShowEmptyButton(args)
	for i=1, g_PageItemCount do
		winName = 'CS_EMPTYSLOT' .. tostring(i);
		
		winMgr:getWindow(winName):setProperty('Visible', args)
		winName = 'Select_Item' .. tostring(i)
		winMgr:getWindow(winName):setProperty('Visible', args)
		if i == 1 then
			winMgr:getWindow(winName):setProperty('Selected', 'false')
		else
			winMgr:getWindow(winName):setProperty('Selected', 'false')
		end
	end
	InitItemSelectData();
end

--[[
function ShowAllBuyEmptyButton(args)
	for i=1, g_PageAllBuyCount do
		winName = 'hh_AllBuy_Empty ' .. tostring(i);
		winMgr:getWindow(winName):setProperty('Visible', args)
		
		winName = 'hh_Allbuy_image' .. tostring(i)
		winMgr:getWindow(winName):setProperty('Visible', args)
		
		if i == 1 then
			winMgr:getWindow(winName):setProperty('Selected', 'false')
		else
			winMgr:getWindow(winName):setProperty('Selected', 'false')
		end
	end
	--InitItemSelectData();
end
--]]

--모든 아이템을  선택 안하게 한다.
function DeSelect_SelectItemAll()
	for i=1, g_PageItemCount do
		local winName = 'Select_Item' .. tostring(i);
		winMgr:getWindow(winName):setProperty('Selected', 'false')
	end
end


function ShowSelectButton(args)
	for i=1, #tItemSelectWinName do
		winMgr:getWindow(tItemSelectWinName[i]):setProperty('Visible', args);
	end
end

function InitItemSelectData()
	for i=1, #tItemSelectWinName do
		mywindow = winMgr:getWindow(tItemSelectWinName[i])
		mywindow:setUserString('ItemFileName', '')
		mywindow:setUserString('ItemNumber', '')
		mywindow:setUserString('ItemName', '')
		mywindow:setUserString('PricePoint', '-1')
		mywindow:setUserString('PriceCash', '-1')
		mywindow:setUserString('Level', '-1')
		mywindow:setUserString('Possession', '0')
		mywindow:setUserString('Hot', '0')
		mywindow:setUserString('New', '0')
		mywindow:setUserString('PageItemIndex', tostring(i))		
	end
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



---------------------------------------------------
------------------ 렌더 함수들 --------------------
---------------------------------------------------
-- 캐릭터 선택 창에 대한 랜더링 함수 --------------
function renderItemSelect(args)
	if g_IsRecv == false then
		return;
	end

	drawer = CEGUI.toWindowEventArgs(args).window:getDrawer()
	mywindow = CEGUI.toWindowEventArgs(args).window
	
	drawer = mywindow:getDrawer()
	local sItemFileName = mywindow:getUserString("ItemFileName")
	
	if sItemFileName ~= "" then
		-- 코스튬 2D를 나나탬
		drawer:drawTexture(sItemFileName, 9, 2, 243, 108, 0, 0)
		
		
		-- 아이템 보유를 나타냄
		if mywindow:getUserString("Possession") == "1" then
			drawer:drawTexture("UIData/skillshop002.tga", 3, 4, 52, 17, 89, 953);
		end
		
		-- Hot 아이템
		if mywindow:getUserString("Hot") == "1" then
			drawer:drawTexture("UIData/ItemUIData/itemshop_button.tga", 0, 0, 74, 48, 74, 0)
		end
		
		-- New 아이템
		if mywindow:getUserString("New") == "1" then
			drawer:drawTexture("UIData/ItemUIData/itemshop_button.tga", 0, 0, 74, 48, 145, 0)					
		end
		
		-- 아이템 착용를 나타냄
		if mywindow:getUserString("Wear") == "1" then
			drawer:drawTexture("UIData/skillshop002.tga", 3, 4, 52, 17, 3, 953);
		end
	end
end

-- 캐릭터 선택 창에 대한 랜더링 함수 ------------------------------------------------------------------------------------------
function renderEndItemContent(args)
	local nPosX = 125
	local nPosY = 19
	
	drawer = CEGUI.toWindowEventArgs(args).window:getDrawer()
	drawer:setFont(g_STRING_FONT_GULIMCHE, 112);
	
	local_window = CEGUI.toWindowEventArgs(args).window;
	
	renderItemSelect(args);
	
	if CEGUI.toWindowEventArgs(args).window:getUserString("ItemName") ~= "" then
	
		local my_money = GetMyMoney();
		local my_level = GetMyLevel();

		drawer:setTextColor(255, 0, 0, 255)
		sText = CEGUI.toWindowEventArgs(args).window:getUserString("ItemName")
		drawer:drawText(sText, 131, 11)
		nPosX = nPosX - 1
		nPosY = nPosY - 1
		
		drawer:setTextColor(255,255,0,255)
		sText = CEGUI.toWindowEventArgs(args).window:getUserString("ItemName")
		--drawer:drawText(sText, 130, 10)
		
		common_DrawOutlineText2(drawer, sText, 130, 10, 0,0,0,255, 255,255,255,255)
		
		local price_point = CEGUI.toWindowEventArgs(args).window:getUserString("PricePoint");
		if price_point == '-1' then
			price_point = '0';
		end
				
		sText = CommonShop_String_GRAN.." : " .. CommatoMoneyStr(price_point);
		
		local str_price = 'Point : ' .. tostring(CommatoMoneyStr(price_point));
		local str_price_size = GetStringSize(g_STRING_FONT_GULIMCHE, 112, str_price);
		local str_price_ctrl_pos = (116 - str_price_size)/2;
		local level_str = CEGUI.toWindowEventArgs(args).window:getUserString("Level");
		
		-- 색 설정
		local str_level = CommonShop_String_LEVEL..tostring(level_str);
		
		local str_level_size = GetStringSize(g_STRING_FONT_GULIMCHE, 112, str_level);
		local str_level_ctrl_pos = (48 - str_level_size)/2;
		
		
		-- 프라이스하고 레벨 그리기
		-- Itemshop001.tga
		drawer:drawTexture("UIData/Itemshop001.tga", 72, 4, 48, 16, 348, 837);
		drawer:drawTexture("UIData/Itemshop001.tga",  4, 88, 116, 16, 280, 859);
		
		if my_level >= tonumber(level_str) then
			drawer:setTextColor(255,255,255,255);
		else
			drawer:setTextColor(255,0,0,255);
		end
		drawer:drawText(str_level, 72+str_level_ctrl_pos, 7);
		
		-- 내돈 검사
		if my_money >= tonumber(price_point) then
			drawer:setTextColor(255,255,255,255);
		else
			drawer:setTextColor(255,0,0,255);
		end
		drawer:drawText(str_price, 4+str_price_ctrl_pos, 88+3);
		drawer:setTextColor(0,0,0,255);
		
	end
end


function inlua_DrawMessage(winName, Text)
	drawer = winMgr:getWindow(winName):getDrawer()
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)	
	common_DrawOutlineText2(drawer, Text, 40, 126, 0,0,255,255, 255,255,255,255)
end


-- Common_PurchaseBox에 등록되어 있는 랜더링 함수
function renderBuyMessageBox(args)
	if winMgr:getWindow('Common_PurchaseBox'):getProperty('Visible') == 'True' then
		mywindow = winMgr:getWindow('Select_Item' .. root:getUserString('CurrItemIndex'))
		inlua_DrawMessage('Common_PurchaseBox',  string.format(CommonShop_String_PURCHASE, mywindow:getUserString('ItemName')))
	end
end


-- Common_AttachBox에 등록되어 있는 랜더링 함수
function renderWearMessageBox(args)	
	if winMgr:getWindow('Common_AttachBox'):getProperty('Visible') == 'True' then
		mywindow = winMgr:getWindow('Select_Item' .. root:getUserString('CurrItemIndex'))
		inlua_DrawMessage('Common_AttachBox',  string.format(CommonShop_String_PURCHASE, mywindow:getUserString('ItemName')))
	end
end





-- 캐릭터 회전 버튼 -----------------------------------------------
tWinRotateName = {['protecterr'] = 0, 'hh_Left_Rotation', 'hh_Right_Rotation'}
tTextureX = {['protecterr'] = 0, 349, 428}
tTextureY = {['protecterr'] = 0, 528, 528}
tTextureHoverX = {['protecterr'] = 0, 349, 428}
tTextureHoverY = {['protecterr'] = 0, 607, 607}
tTexturePushedX = {['protecterr'] = 0, 349, 428}
tTexturePushedY = {['protecterr'] = 0, 686, 686}
nSizeX = 79
nSizeY = 79
tPosX = {['protecterr'] = 0, 40, 322}
tPosY = {['protecterr'] = 0, 439, 439}
GoRoundDownEventName = {['protecterr'] = 0 , "CharRotateLeftDown", "CharRotateRightDown" }
GoRoundUpEventName = {['protecterr'] = 0 , "CharRotateLeftUp", "CharRotateRightUp" }

for i=1, #tWinRotateName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tWinRotateName[i])
	mywindow:setTexture("Normal", "UIData/mainBG_Button001.tga", tTextureX[i], tTextureY[i])
	mywindow:setTexture("Hover", "UIData/mainBG_Button001.tga", tTextureHoverX[i], tTextureHoverY[i])
	mywindow:setTexture("Pushed", "UIData/mainBG_Button001.tga", tTexturePushedX[i], tTexturePushedY[i])
	mywindow:setTexture("PushedOff", "UIData/mainBG_Button001.tga", tTextureX[i], tTextureY[i])
	mywindow:setSize(nSizeX, nSizeY)
	mywindow:setPosition(tPosX[i], tPosY[i])
	mywindow:subscribeEvent("MouseButtonDown", GoRoundDownEventName[i])
	mywindow:subscribeEvent("MouseButtonUp", GoRoundUpEventName[i])
	root:addChildWindow(mywindow)
end




-- 서브 카테고리 의상 관련 ---------------------------------------------------------
-- 단순 의상 라이오 버튼 담는 컨테이너
tWinSubCategoryName = {['protecterr'] = 0, 'CS_ALL', 'CS_HEAR', 'CS_FACE', 'CS_UPPER', 'CS_HAND', 'CS_LOWER', 'CS_FOOT', 'CS_DECO', 'CS_SET'}
tTextureX = {['protecterr'] = 0, 0, 46, 46*2, 46*3, 46*4, 46*5, 46*6, 46*7, 46*8}
tTextureY = {['protecterr'] = 0, 687, 687, 687, 687, 687, 687, 687, 687, 687}
tTextureHoverX = {['protecterr'] = 0, 0, 46, 46*2, 46*3, 46*4, 46*5, 46*6, 46*7, 46*8}
tTextureHoverY = {['protecterr'] = 0, 713, 713, 713, 713, 713, 713, 713, 713, 713}
tTexturePushedX = {['protecterr'] = 0, 0, 46, 46*2, 46*3, 46*4, 46*5, 46*6, 46*7, 46*8}
tTexturePushedY = {['protecterr'] = 0, 739, 739, 739, 739, 739, 739, 739, 739, 739}
nSizeX = 46
nSizeY = 26
nPosX = 30
nPosY = 15
nOffsetX = 56
nOffsetY = 0

--- 단순 의상 라이오 버튼 담는 컨테이너
for i=1, #tWinSubCategoryName do
	local mywindow = winMgr:createWindow("TaharezLook/RadioButton", tWinSubCategoryName[i])
	mywindow:setTexture("Normal", "UIData/ItemShop001.tga", tTextureX[i], tTextureY[i])
	mywindow:setTexture("Hover", "UIData/ItemShop001.tga", tTextureHoverX[i], tTextureHoverY[i])
	mywindow:setTexture("Pushed", "UIData/ItemShop001.tga", tTexturePushedX[i], tTexturePushedY[i])
	mywindow:setTexture("PushedOff", "UIData/ItemShop001.tga", tTextureX[i], tTextureY[i])

	mywindow:setTexture("SelectedNormal", "UIData/ItemShop001.tga", tTexturePushedX[i], tTexturePushedY[i])
	mywindow:setTexture("SelectedHover", "UIData/ItemShop001.tga", tTextureHoverX[i], tTextureHoverY[i])
	mywindow:setTexture("SelectedPushed", "UIData/ItemShop001.tga", tTextureHoverX[i], tTextureHoverY[i])
	mywindow:setTexture("SelectedPushedOff", "UIData/ItemShop001.tga", tTextureHoverX[i], tTextureHoverY[i])

	mywindow:setSize(nSizeX, nSizeY)
	mywindow:setPosition(nPosX+nOffsetX*(i-1), nPosY)
	mywindow:setProperty("GroupID", 2)
	mywindow:setUserString("SubItemName", tWinSubCategoryName[i])
end


------- 메인 아이템 라디오 버튼 서브 버튼들 -------- 
tWinItemSubCategoryName = {['protecterr'] = 0, 'CS_ALL2', 'CS_ATTACK', 'CS_DEFFENCE', 'CS_SPECIAL'}
tTextureX = {['protecterr'] = 0, 624, 624+46, 624+46*2, 624+46*3}
tTextureY = {['protecterr'] = 0, 780, 780, 780, 780}
tTextureHoverX = {['protecterr'] = 0, 624, 624+46, 624+46*2, 624+46*3}
tTextureHoverY = {['protecterr'] = 0, 806, 806, 806, 806}
tTexturePushedX = {['protecterr'] = 0, 624, 624+46, 624+46*2, 624+46*3}
tTexturePushedY = {['protecterr'] = 0, 832, 832, 832, 832}
nSizeX = 46
nSizeY = 26
nPosX = 30
nPosY = 15
nOffsetX = 56
nOffsetY = 0

for i=1, #tWinItemSubCategoryName do

	local mywindow = winMgr:createWindow("TaharezLook/RadioButton", tWinItemSubCategoryName[i])
	mywindow:setTexture("Normal", "UIData/ItemShop001.tga", tTextureX[i], tTextureY[i])
	mywindow:setTexture("Hover", "UIData/ItemShop001.tga", tTextureHoverX[i], tTextureHoverY[i])
	mywindow:setTexture("Pushed", "UIData/ItemShop001.tga", tTexturePushedX[i], tTexturePushedY[i])
	mywindow:setTexture("PushedOff", "UIData/ItemShop001.tga", tTextureX[i], tTextureY[i])

	mywindow:setTexture("SelectedNormal", "UIData/ItemShop001.tga", tTexturePushedX[i], tTexturePushedY[i])
	mywindow:setTexture("SelectedHover", "UIData/ItemShop001.tga", tTextureHoverX[i], tTextureHoverY[i])
	mywindow:setTexture("SelectedPushed", "UIData/ItemShop001.tga", tTextureHoverX[i], tTextureHoverY[i])
	mywindow:setTexture("SelectedPushedOff", "UIData/ItemShop001.tga", tTextureHoverX[i], tTextureHoverY[i])

	mywindow:setSize(nSizeX, nSizeY)
	mywindow:setPosition(nPosX+nOffsetX*(i-1), nPosY)
	mywindow:setProperty("GroupID", 4)
	mywindow:setVisible(false);
	
end

-- Select_Item라디오 버튼 1 ~ 8 --------------------------------------------------------------------------------------------
tItemSelectWinName = {['protecterr'] = 0, "Select_Item1", "Select_Item2", "Select_Item3", "Select_Item4", "Select_Item5", "Select_Item6", "Select_Item7", "Select_Item8"}
nTextureAlphaX = 0
nTextureAlphaY = 24+110;
nTextureX = 10
nTextureY = 54
nTextureHoverX = 0
nTextureHoverY = 24
nSizeX = 270
nSizeY = 110

nPosX = {['protecterr'] = 0,      10, 10+276, 10, 10+276, 10, 10+276, 10, 10+276}
nPosY = {['protecterr'] = 0,      54, 54, 54+112, 54+112, 54+112*2, 54+112*2, 54+112*3, 54+112*3}

for i=1, #tItemSelectWinName do

	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tItemSelectWinName[i])
	mywindow:setTexture("Normal", "UIData/Itemshop001.tga", nTextureX, nTextureY)
	mywindow:setTexture("Hover", "UIData/skillitem001.tga", nTextureHoverX, nTextureHoverY)
	mywindow:setTexture("Pushed", "UIData/skillitem001.tga", nTextureAlphaX, nTextureAlphaY)
--	mywindow:setTexture("PushedOff", "UIData/skillitem001.tga", nTextureAlphaX, nTextureAlphaX)

	mywindow:setTexture("SelectedNormal", "UIData/skillitem001.tga", nTextureAlphaX, nTextureAlphaY)
	mywindow:setTexture("SelectedHover", "UIData/skillitem001.tga", nTextureAlphaX, nTextureAlphaY)
	mywindow:setTexture("SelectedPushed", "UIData/skillitem001.tga", nTextureAlphaX, nTextureAlphaY)
--	mywindow:setTexture("SelectedPushedOff", "UIData/skillitem001.tga", nTextureAlphaX, nTextureAlphaY)

	mywindow:setSize(nSizeX, nSizeY)
	
	mywindow:setUserString('ItemFileName', '')
	mywindow:setUserString('ItemNumber', '')
	mywindow:setUserString('ItemName', '')
	mywindow:setUserString('PricePoint', '-1')
	mywindow:setUserString('PriceCash', '-1')
	mywindow:setUserString('Level', '-1')
	mywindow:setUserString('Possession', '0')
	mywindow:setUserString('Hot', '0')
	mywindow:setUserString('New', '0')
	mywindow:setUserString('PageItemIndex', tostring(i))
	mywindow:setZOrderingEnabled(false);
	
	mywindow:setPosition(nPosX[i], nPosY[i]);
	
	mywindow:setProperty('GroupID', 10)
end



-- 알파 스태틱 이미지 -------------------------------------------------------------------------
tWinAlphaName = {['protecterr'] = 0, 'CommonAlphaPage'}
tTextureX = {['protecterr'] = 0, 0}
tTextureY = {['protecterr'] = 0, 0}
tSizeX = {['protecterr'] = 0, 1920}
tSizeY = {['protecterr'] = 0, 1200}
tPosX = {['protecterr'] = 0, 0}
tPosY = {['protecterr'] = 0, 0}

for i=1, #tWinAlphaName do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", tWinAlphaName[i])
	mywindow:setSize(tSizeX[i], tSizeY[i])
	mywindow:setPosition(tPosX[i], tPosY[i])
	mywindow:setProperty("FrameEnabled", "false")	
	mywindow:setProperty("BackgroundEnabled", "false")	

	mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", tTextureX[i], tTextureY[i])
	mywindow:setProperty("AlwaysOnTop", "true")
	mywindow:setZOrderingEnabled(true)
	mywindow:setProperty('Visible', 'false')
	root:addChildWindow(mywindow)
	
end



-- 구입박스
RegistEscEventInfo("NCS_PurchaceAlphaImage", "OnClickOneBuyCancelButton")


tEmptyWinName = {['protecterr'] = 0, "CS_EMPTYSLOT1", "CS_EMPTYSLOT2", "CS_EMPTYSLOT3", "CS_EMPTYSLOT4", "CS_EMPTYSLOT5", "CS_EMPTYSLOT6", "CS_EMPTYSLOT7", "CS_EMPTYSLOT8"}
nTextureX = 0
nTextureY = 765
nSizeX = 270
nSizeY = 110
nPosX = {['protecterr'] = 0,      10, 10+276, 10, 10+276, 10, 10+276, 10, 10+276}
nPosY = {['protecterr'] = 0,      54, 54, 54+112, 54+112, 54+112*2, 54+112*2, 54+112*3, 54+112*3}

for i=1, #tEmptyWinName do

	mywindow = winMgr:createWindow('TaharezLook/StaticImage', tEmptyWinName[i])
	mywindow:setTexture('Enabled', "UIData/ItemShop001.tga", nTextureX, nTextureY)

	mywindow:setSize(nSizeX, nSizeY)
		
	mywindow:setPosition(nPosX[i], nPosY[i]);
	
--	mywindow:setProperty("AlwaysOnTop", "true")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	
end






-- 공통 레이아웃 스태틱 이미지 ---------------------------------------------------------------------------
tStaticWinName = {['protecterr'] = 0, 'CS_TopBar', 'CS_WinTitleName', 'CS_ItemMainWin', 'CS_ItemInfoWin', 'Common_PurchaseBox', 'Common_AttachBox', 'CS_ReleaseBoxWin'}
tTexName = {['protecterr'] = 0, 
'UIData/mainBG_Button001.tga',	-- 상단바
'UIData/mainBG_Button001.tga',	-- 방제목
'UIData/ItemShop001.tga',		-- CS_ItemMainWin
'UIData/ItemShop001.tga',		-- 아이템 정보
'UIData/popup001.tga',	-- Common_PurchaseBox
'UIData/popup001.tga',	-- Common_AttachBox
'UIData/popup001.tga'}	-- 해제 박스
tTextureX = {['protecterr'] = 0,     0,      584,   0,   0,            0,            0,            0 }
tTextureY = {['protecterr'] = 0,     0, 288+33*4,   0, 955,            0,            0,            0 }
tSizeX = {['protecterr'] = 0,	  1024,      136, 577, 440,          349,          349,          349 }
tSizeY = {['protecterr'] = 0,		71,       33, 573,  69,          275,          275,          275 }
tPosX = {['protecterr']	= 0,         0,       25, 439,  -7, 1024/2-349/2, 1024/2-349/2, 1024/2-349/2 }
tPosY = {['protecterr']	= 0,         0,       16, 118, 614,  768/2-277/2,  768/2-277/2,  768/2-277/2 }

for i=1, #tStaticWinName do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", tStaticWinName[i]);
	mywindow:setSize(tSizeX[i], tSizeY[i]);
	mywindow:setPosition(tPosX[i], tPosY[i]);
	mywindow:setProperty("FrameEnabled", "false");
	mywindow:setProperty("BackgroundEnabled", "false");
	mywindow:setTexture("Enabled", tTexName[i], tTextureX[i], tTextureY[i]);
	root:addChildWindow(mywindow)	-- 붙이는 건 나중에 붙인다. 테스트 할땐 붙여야지요~
end

winMgr:getWindow('CS_ItemMainWin'):setZOrderingEnabled(false);
winMgr:getWindow('CS_TopBar'):setZOrderingEnabled(false); --상단바를 누르면 방제목이 바뀌는 현상을 막기위해서
winMgr:getWindow('Common_PurchaseBox'):setZOrderingEnabled(false);
winMgr:getWindow('Common_PurchaseBox'):setAlwaysOnTop(true);




tWinName = {['protecterr'] = 0,'CS_PurchaseBoxText', 'CS_AttachBoxText', 'CS_ReleaseBoxText'}
tWinText = {['protecterr'] = 0,'', ' ', ''}

for i=1, #tWinName do
	_window = winMgr:createWindow("TaharezLook/StaticText", tWinName[i]);
	_window:setProperty("FrameEnabled", "false");
	_window:setProperty("BackgroundEnabled", "false");
	_window:setFont(g_STRING_FONT_GULIMCHE, 12);	
	_window:setTextColor(255, 255, 255, 255);
	_window:setPosition(0, 120);
	_window:setSize(349, 80);
	_window:setText(tWinText[i]);
	_window:setVisible(true);
end

winMgr:getWindow('Common_PurchaseBox'):addChildWindow( winMgr:getWindow('CS_PurchaseBoxText') );
winMgr:getWindow('Common_AttachBox'):addChildWindow( winMgr:getWindow('CS_AttachBoxText') );
winMgr:getWindow('CS_ReleaseBoxWin'):addChildWindow( winMgr:getWindow('CS_ReleaseBoxText') );
winMgr:getWindow('CS_ReleaseBoxWin'):setVisible(false);



tTextureX = {['protecterr'] = 0, 864, 945 }
tTextureY = {['protecterr'] = 0, 485, 485 }
tTextureHoverX = {['protecterr'] = 0, 864, 945 }
tTextureHoverY = {['protecterr'] = 0, 485+34, 485+34 }
tTexturePushedX = {['protecterr'] = 0, 864, 945 }
tTexturePushedY = {['protecterr'] = 0, 485+34*2, 485+34*2 }

-- 버튼 구입/착용 다이얼로그 박스 버튼 공통으로 쓰임 ------------------------------------------------------------------------------------------
tWinButtonName = {['protecterr'] = 0, 'CS_PurchaseOKButton', 'CS_PurchaseCancelButton', 'CS_AttachOKButton', 'CS_AttachCancelButton', 'DefaultOk', 'DefaultCancel', 'CS_ReleaseOKButton', 'CS_ReleaseCancelButton'}
tButtonEventHandler = {['protecterr'] = 0, "inlua_ClickedBuyOK",     "inlua_ClickedBuyCancel", 
										   "inlua_ClickedWearOK",    "inlua_ClickedWearCancel",
										   "inlua_ClickedDefaultOk", "inlua_ClickedDefaultCancel",
										   "inlua_ClickedUnWearOK", "inlua_ClickedUnWearCancel" }
tTextureX = {['protecterr'] = 0,		     864,      944, 864,      944, 864,      944, 864,      944 }
tTextureY = {['protecterr'] = 0,		     485,      485, 485,      485, 485,      485, 485,      485 }
tTextureHoverX = {['protecterr'] = 0,	     864,      944, 864,      944, 864,      944, 864,      944}
tTextureHoverY = {['protecterr'] = 0,	  485+34,   485+34, 485+34,   485+34, 485+34,   485+34, 485+34,   485+34}
tTexturePushedX = {['protecterr'] = 0,	     864,      944, 864,      944, 864,      944, 864,      944}
tTexturePushedY = {['protecterr'] = 0,	485+34*2, 485+34*2, 485+34*2, 485+34*2, 485+34*2, 485+34*2, 485+34*2, 485+34*2}
nSizeX = 80
nSizeY = 34
tPosX = {['protecterr'] = 0, 85, 187, 85, 187, 138, 187, 85, 187}
tPosY = {['protecterr'] = 0, 228, 228, 228, 228, 228, 228, 228, 228}

for i=1, #tWinButtonName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tWinButtonName[i])
	mywindow:setTexture("Normal", "UIData/popup001.tga", tTextureX[i], tTextureY[i])
	mywindow:setTexture("Hover", "UIData/popup001.tga", tTextureHoverX[i], tTextureHoverY[i])
	mywindow:setTexture("Pushed", "UIData/popup001.tga", tTexturePushedX[i], tTexturePushedY[i])
	mywindow:setTexture("PushedOff", "UIData/popup001.tga", tTextureX[i], tTextureY[i])
	mywindow:setSize(nSizeX, nSizeY)
	mywindow:setPosition(tPosX[i], tPosY[i])
	mywindow:subscribeEvent("Clicked", tButtonEventHandler[i])
end

-------------------------------------------------
-- 뉴 캐쉬 충전 버튼
-------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "hh_Cash_Charge")
mywindow:setTexture("Normal", "UIData/GameNewImage2.tga", 496, 876)
mywindow:setTexture("Hover", "UIData/GameNewImage2.tga", 496, 876+37)
mywindow:setTexture("Pushed", "UIData/GameNewImage2.tga", 496, 876+74)
mywindow:setTexture("Disabled", "UIData/GameNewImage2.tga", 496, 876+111)

mywindow:setSize(94, 36)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)

-------------------------------------------------
-- 기간만료 모두삭제 버튼
-------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "hh_expired_item_delete")
mywindow:setTexture("Normal", "UIData/GameNewImage2.tga", 591, 876)
mywindow:setTexture("Hover", "UIData/GameNewImage2.tga", 591, 876+37)
mywindow:setTexture("Pushed", "UIData/GameNewImage2.tga", 591, 876+74)
mywindow:setTexture("Disabled", "UIData/GameNewImage2.tga", 591, 876+111)

mywindow:setSize(94, 36)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)



-- 상점 안에 버튼들 ------------------------------------------------------------------------------------------
tWinShopButtonName = {['protecterr'] = 0, 'CS_CachChargeBtn', 'CS_PurchaseBtn', 'CS_PresentBtn', 'CS_RefreshBtn', 'CS_AllPurchaseBtn', 'CS_CouponEnterBtn' }

tTextureX = {['protecterr'] = 0,          0,		 830,	   926,      824,		884,	767}
tTextureY = {['protecterr'] = 0,        782,	     557,	   556,      710,       710,	694}
tTextureHoverX = {['protecterr'] = 0,     0,	     830,	   926,      824,		884,	767}
tTextureHoverY = {['protecterr'] = 0,   782,      557+38,   556+38,   710+59,    710+59,	734}
tTexturePushedX = {['protecterr'] = 0,    0,		 830,      926,      824,		884,	767}
tTexturePushedY = {['protecterr'] = 0,  782,    557+38*2, 556+38*2, 710+59*2,  710+59*2,	774}
tTextureDisbledX = {['protecterr'] = 0,   0,		 830,      926,      824, 		884,	767}
tTextureDisbledY = {['protecterr'] = 0, 782,    557+38*3, 556+38*3, 710+59*3,  710+59*3,	811}
tSizeX = {['protecterr'] = 0, 98,  94,  98, 59,   59,	94}
tSizeY = {['protecterr'] = 0, 38,  36,  38, 58,   58,	36}
tPosX = {['protecterr'] = 0, 263, 263, 263,  9,    9,	0}
tPosY = {['protecterr'] = 0,  10,  49,  89,  8, 9+61,	0}
		
for i=1, #tWinShopButtonName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tWinShopButtonName[i])	
	if tWinShopButtonName[i] == 'CS_RefreshBtn' or tWinShopButtonName[i] == 'CS_AllPurchaseBtn' or tWinShopButtonName[i] == 'CS_PresentBtn' or tWinShopButtonName[i] == 'CS_PurchaseBtn' then
		mywindow:setTexture("Normal", "UIData/ItemShop001.tga", tTextureX[i], tTextureY[i]);
		mywindow:setTexture("Hover", "UIData/ItemShop001.tga", tTextureHoverX[i], tTextureHoverY[i]);
		mywindow:setTexture("Pushed", "UIData/ItemShop001.tga", tTexturePushedX[i], tTexturePushedY[i]);
		mywindow:setTexture("PushedOff", "UIData/ItemShop001.tga", tTextureX[i], tTextureY[i]);
		mywindow:setTexture("Disabled", "UIData/ItemShop001.tga", tTextureDisbledX[i], tTextureDisbledY[i]);
	elseif tWinShopButtonName[i] == 'CS_CouponEnterBtn' then
		mywindow:setTexture("Normal", "UIData/popup001.tga", tTextureX[i], tTextureY[i]);
		mywindow:setTexture("Hover", "UIData/popup001.tga", tTextureHoverX[i], tTextureHoverY[i]);
		mywindow:setTexture("Pushed", "UIData/popup001.tga", tTexturePushedX[i], tTexturePushedY[i]);
		mywindow:setTexture("PushedOff", "UIData/popup001.tga", tTextureX[i], tTextureY[i]);
		mywindow:setTexture("Disabled", "UIData/popup001.tga", tTextureDisbledX[i], tTextureDisbledY[i]);		
	else
		mywindow:setTexture("Normal", "UIData/mainBG_Button001.tga", tTextureX[i], tTextureY[i]);
		mywindow:setTexture("Hover", "UIData/mainBG_Button001.tga", tTextureHoverX[i], tTextureHoverY[i]);
		mywindow:setTexture("Pushed", "UIData/mainBG_Button001.tga", tTexturePushedX[i], tTexturePushedY[i]);
		mywindow:setTexture("PushedOff", "UIData/mainBG_Button001.tga", tTextureX[i], tTextureY[i]);
		mywindow:setTexture("Disabled", "UIData/mainBG_Button001.tga", tTextureDisbledX[i], tTextureDisbledY[i]);
	end

	mywindow:setSize(tSizeX[i], tSizeY[i])
	mywindow:setPosition(tPosX[i], tPosY[i])
end

winMgr:getWindow('CS_CachChargeBtn'):setVisible(false);
winMgr:getWindow('CS_PresentBtn'):setEnabled(false)
winMgr:getWindow('CS_CouponEnterBtn'):setEnabled(false)
winMgr:getWindow('CS_PresentBtn'):setVisible(false);
--winMgr:getWindow('CS_CachChargeBtn'):setProperty('DraggingEnabled', 'True');

function inlua_ClickedDefaultOk()
	winMgr:getWindow('CommonAlphaPage'):setVisible(false)
	winMgr:getWindow('Default Box'):setVisible(false)
end


--- 경고 창이라고 볼 수 있다. Default Box ---
mywindow = winMgr:createWindow("TaharezLook/StaticImage", 'Default Box');
mywindow:setSize(349, 275);
mywindow:setPosition(500, 300);
mywindow:setProperty("FrameEnabled", "false");
mywindow:setProperty("BackgroundEnabled", "false");
mywindow:setTexture("Enabled", 'UIData/popup001.tga', 0, 0);
mywindow:setProperty('Visible', 'false');
winMgr:getWindow('CommonAlphaPage'):addChildWindow(mywindow)	-- 붙이는 건 나중에 붙인다. 테스트 할땐 붙여야지요~

mywindow:addChildWindow( winMgr:getWindow('DefaultOk') );
--mywindow:addChildWindow( winMgr:getWindow('DefaultCancel') );


tWinName = {['protecterr'] = 0,'CS_DefaultBoxText'}

for i=1, #tWinName do
	_window = winMgr:createWindow("TaharezLook/StaticText", tWinName[i]);
	_window:setProperty("FrameEnabled", "false");
	_window:setProperty("BackgroundEnabled", "false");
	_window:setFont(g_STRING_FONT_GULIMCHE, 12);	
	_window:setTextColor(255, 255, 255, 255);
	_window:setPosition(100, 100);
	_window:setSize(349, 70);
	_window:setText("");
	_window:setVisible(true);
	winMgr:getWindow('Default Box'):addChildWindow(_window);
end

function ShowDefaultBoxText(win_name)	-- 'ClassNot_StaticText', 'LevelNot_StaticText', 'SelectNot_StaticText', 'TypeNot_StaticText', 'NoHavePoint_StaticText', 'ShoppingCartEmpty_StaticText', 'AlreadyPossession_StaticText' 다섯개중에 하나
	winMgr:getWindow('Common_PurchaseBox'):setVisible(false);
	winMgr:getWindow('Common_AttachBox'):setVisible(false);
	
	DebugStr('Win Name : ' .. win_name);
	winMgr:getWindow('CommonAlphaPage'):setVisibleChild(false);
	root:addChildWindow( winMgr:getWindow('CommonAlphaPage') );
	winMgr:getWindow('CommonAlphaPage'):addChildWindow( winMgr:getWindow('Default Box') );
	winMgr:getWindow('CommonAlphaPage'):setProperty('Visible', 'true');
	winMgr:getWindow('Default Box'):setProperty('Visible', 'true');
	--1024/2=512 - 350/2=175 =  338		,768/2=384 - 277/2=138 = 246
	winMgr:getWindow('Default Box'):setPosition(338, 246);
	
	winMgr:getWindow('CS_DefaultBoxText'):setVisible(true);
	winMgr:getWindow('CS_DefaultBoxText'):setPosition(0, 126);
	winMgr:getWindow('CS_DefaultBoxText'):clearTextExtends();
	winMgr:getWindow('CS_DefaultBoxText'):setViewTextMode(1);
	winMgr:getWindow('CS_DefaultBoxText'):setAlign(8);
	winMgr:getWindow('CS_DefaultBoxText'):setLineSpacing(1);
	
	if win_name == 'ClassNot_StaticText' then
		winMgr:getWindow("CS_DefaultBoxText"):addTextExtends(CommonShop_String_NOT_CHARACTER, g_STRING_FONT_DODUMCHE,114, 255,255,255,255,  2, 0,0,0,255);
	elseif win_name == 'LevelNot_StaticText' then
		winMgr:getWindow("CS_DefaultBoxText"):addTextExtends(CommonShop_String_NOT_LEVEL, g_STRING_FONT_DODUMCHE,114, 255,255,255,255,  2, 0,0,0,255);
	elseif win_name == 'SelectNot_StaticText' then
		winMgr:getWindow("CS_DefaultBoxText"):addTextExtends(CommonShop_String_SELECT_ITEM, g_STRING_FONT_DODUMCHE,114, 255,255,255,255,  2, 0,0,0,255);
	elseif win_name == 'TypeNot_StaticText' then
		winMgr:getWindow("CS_DefaultBoxText"):addTextExtends(CommonShop_String_NOT_TYPE, g_STRING_FONT_DODUMCHE,114, 255,255,255,255,  2, 0,0,0,255);
	elseif win_name == 'NoHavePoint_StaticText' then
		winMgr:getWindow("CS_DefaultBoxText"):addTextExtends(CommonShop_String_NOT_ENOUGH_GRAN, g_STRING_FONT_DODUM,114, 255,255,255,255,  2, 0,0,0,255);
	elseif win_name == 'NoHaveCash_StaticText' then
		winMgr:getWindow("CS_DefaultBoxText"):addTextExtends(CommonShop_String_NOT_ENOUGH_CASH, g_STRING_FONT_DODUM,114, 255,255,255,255,  2, 0,0,0,255);
	elseif win_name == 'ShoppingCartEmpty_StaticText' then
		winMgr:getWindow("CS_DefaultBoxText"):addTextExtends(CommonShop_String_NOT_SELECTiTEM, g_STRING_FONT_DODUMCHE,114, 255,255,255,255,  2, 0,0,0,255);
	elseif win_name == 'AlreadyPossession_StaticText' then
		winMgr:getWindow("CS_DefaultBoxText"):addTextExtends(CommonShop_String_ALREADY_HAVEITEM, g_STRING_FONT_DODUMCHE,114, 255,255,255,255,  2, 0,0,0,255);
	elseif win_name == 'AlreadyWear_StaticText' then
		winMgr:getWindow("CS_DefaultBoxText"):addTextExtends(CommonShop_String_ALREADY_ATTACHITEM, g_STRING_FONT_DODUMCHE,114, 255,255,255,255,  2, 0,0,0,255);
	elseif win_name == 'UnWearNotDefaultItem_StaticText' then
		winMgr:getWindow("CS_DefaultBoxText"):addTextExtends(CommonShop_String_NOT_RELEASE_BASEITEM, g_STRING_FONT_DODUMCHE,114, 255,255,255,255,  2, 0,0,0,255);
	elseif win_name == 'NotWear_StaticText' then	
		winMgr:getWindow("CS_DefaultBoxText"):addTextExtends(CommonShop_String_NOT_ATTACH, g_STRING_FONT_DODUMCHE,114, 255,255,255,255,  2, 0,0,0,255);
	end
end

function ShowBuyBox(itemName)
	winMgr:getWindow('Default Box'):setVisible(false);
	winMgr:getWindow('Common_AttachBox'):setVisible(false);
	
	winMgr:getWindow('Common_PurchaseBox'):setVisible(true);
	winMgr:getWindow('CS_PurchaseBoxText'):clearTextExtends();
	winMgr:getWindow('CS_PurchaseBoxText'):setViewTextMode(1);
	winMgr:getWindow('CS_PurchaseBoxText'):setAlign(8);
	winMgr:getWindow('CS_PurchaseBoxText'):setLineSpacing(1);
	
	
	if itemName == 'CS_BuyAll' then
		winMgr:getWindow('CS_PurchaseBoxText'):addTextExtends(CommonShop_String_PURCHASE_ITEM_ALL, g_STRING_FONT_DODUMCHE, 14, 238,203,7,255,   1, 0,0,0,255);
	else 
		if IsKoreanLanguage() then
			winMgr:getWindow('CS_PurchaseBoxText'):addTextExtends(itemName, g_STRING_FONT_DODUMCHE, 14, 238,203,7,255,   1, 0,0,0,255);
			winMgr:getWindow('CS_PurchaseBoxText'):addTextExtends(CommonShop_String_PURCHASE, g_STRING_FONT_DODUMCHE, 114, 255,255,255,255,   2, 0,0,0,255);
		else			
			winMgr:getWindow('CS_PurchaseBoxText'):addTextExtends(string.format(CommonShop_String_PURCHASE, itemName), g_STRING_FONT_DODUMCHE, 114, 255,255,255,255,   2, 0,0,0,255);
		end
		
	end
end
--[[
function ShowItemBuyBox(itemName)
	winMgr:getWindow('Default Box'):setVisible(false);
	winMgr:getWindow('Common_AttachBox'):setVisible(false);
	
	winMgr:getWindow('Common_PurchaseBox'):setVisible(true);
	winMgr:getWindow('CS_PurchaseBoxText'):clearTextExtends();
	winMgr:getWindow('CS_PurchaseBoxText'):setViewTextMode(1);
	winMgr:getWindow('CS_PurchaseBoxText'):setAlign(8);
	winMgr:getWindow('CS_PurchaseBoxText'):setLineSpacing(1);
	
	
	if itemName == CS_BuyAll then
		winMgr:getWindow('CS_PurchaseBoxText'):addTextExtends('모두 구입하시겠습니까?', g_STRING_FONT_DODUMCHE, 14, 238,203,7,255,   1, 0,0,0,255);
	else 
		winMgr:getWindow('CS_PurchaseBoxText'):addTextExtends('선택한 아이템을 구입 하시겠습니까?', g_STRING_FONT_DODUMCHE, 114, 255,255,255,255,   2, 0,0,0,255);
	end
end
--]]
function ShowWearBox(itemName)
	winMgr:getWindow('Default Box'):setVisible(false);
	winMgr:getWindow('Common_PurchaseBox'):setVisible(false);
	
	winMgr:getWindow('Common_AttachBox'):setVisible(true);
	winMgr:getWindow('CS_AttachBoxText'):clearTextExtends();
	winMgr:getWindow('CS_AttachBoxText'):setViewTextMode(1);
	winMgr:getWindow('CS_AttachBoxText'):setAlign(8);
	winMgr:getWindow('CS_AttachBoxText'):setLineSpacing(1);
	
	if itemName == 'CS_BuyAll' then
		winMgr:getWindow('CS_AttachBoxText'):addTextExtends(CommonShop_String_ATTACH_ITEM_ALL, g_STRING_FONT_DODUMCHE, 114, 238,203,7,255,   1, 0,0,0,255);
	else
		if IsKoreanLanguage() then
			winMgr:getWindow('CS_AttachBoxText'):addTextExtends(itemName, g_STRING_FONT_DODUMCHE, 14, 238,203,7,255,   1, 0,0,0,255);
			winMgr:getWindow('CS_AttachBoxText'):addTextExtends("을(를) 착용하시겠습니까?", g_STRING_FONT_DODUMCHE, 114, 255,255,255,255,   2, 0,0,0,255);
		else
			winMgr:getWindow('CS_AttachBoxText'):addTextExtends(string.format(CommonShop_String_PURCHASE, itemName), g_STRING_FONT_DODUMCHE, 114, 255,255,255,255,   2, 0,0,0,255);
		end
	end
	
end


