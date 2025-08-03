-----------------------------------------
-- Script Entry Point
-----------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root	    = winMgr:getWindow("DefaultWindow")
guiSystem:setGUISheet(root)
root:activate()


--------------------------------------------------------------------
-- 문자열에 대한 정보 받아온다(로컬라이징)
--------------------------------------------------------------------
local NCS_String_PurchaseConfirm	= PreCreateString_1007		--GetSStringInfo(LAN_LUA_ARCADESHOP_1)	-- 위 아이템을 정말 구입하시겠습니까? 
local MR_String_16					= PreCreateString_1122		--GetSStringInfo(LAN_LUA_SHOP_COMMON_3)	-- 타격공격
MR_String_17						= PreCreateString_1123		--GetSStringInfo(LAN_LUA_SHOP_COMMON_4)	-- 잡기공격
local MR_String_18					= PreCreateString_1124		--GetSStringInfo(LAN_LUA_SHOP_COMMON_5)	-- 크리티컬
local MR_String_19					= PreCreateString_1125		--GetSStringInfo(LAN_LUA_SHOP_COMMON_6)	-- 타격방어
local MR_String_20					= PreCreateString_1126		--GetSStringInfo(LAN_LUA_SHOP_COMMON_7)	-- 잡기방어

local Shop_String_19					= PreCreateString_1120		--GetSStringInfo(LAN_LUA_SHOP_COMMON_1)	-- 기간을 선택해주세요.

local ShopCommon_String_Stat_No			= PreCreateString_1127		--GetSStringInfo(LAN_LUA_SHOP_COMMON_8)	-- 스텟없음
local ShopCommon_String_Day				= PreCreateString_1057		--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_40)	-- 일
local ShopCommon_String_Unlimited		= PreCreateString_1056		--GetSStringInfo(LAN_LUA_CHALLENGEMISSION_39)	-- 삭제시까지
local ShopCommon_NotEnough_Gran			= PreCreateString_9			--GetSStringInfo(LAN_SHORT_MONEY)	-- 그랑이 부족합니다
local ShopCommon_NotEnough_Cash			= PreCreateString_95		--GetSStringInfo(LAN_SHORT_CASH)	-- 캐시가 부족합니다
local ShopCommon_String_GRAN			= PreCreateString_200		--GetSStringInfo(LAN_GRAN)	-- 그랑
local ShopCommon_String_CASH			= PreCreateString_1955		--GetSStringInfo(LAN_CASH)	-- 캐시
local CommonShop_String_NOT_LEVEL		= PreCreateString_103		--GetSStringInfo(LAN_LOW_CHARACLEVEL)
local CommonShop_String_PURCHASE_SKILL_FAIL		= PreCreateString_2055		--GetSStringInfo(LAN_PURCHASE_SKILL_FAIL)



local EnoughBuyItem	= 0
local purchaseTypeIndex = 0
local purchasePrice = 0
local saleValue	= 0
TYPE_GRAN	= 25005		-- 그랑 결제
TYPE_CASH	= 13001		-- 캐시 결제

Type_Purchase	= 0
Type_Present	= 1

NCS_Selected_Window	= ""		-- 전역으로 선택된 윈도우 확인.
local WearItemNumber	= -1
local WearItemIndex		= -1


local Item_BuyProductNo	= 0;
local Item_PurchaseType	= -1;

if IsKoreanLanguage() then
	PRODUCT_STOP_SELL = -1
	PRODUCT_SELL	  = 0
	PRODUCT_NEW		  = 5
	PRODUCT_HOT		  = 6
	PRODUCT_SALE_50	  = 2
	PRODUCT_EVENT	  = 3
	PRODUCT_RESERVE	  = 4
	PRODUCT_SOLD_OUT  = 1
	PRODUCT_LIMITED_TIME_SALE = -1
	PRODUCT_SALE_30 = -1
	PRODUCT_SALE	= -1
else
	PRODUCT_STOP_SELL = 0
	PRODUCT_SELL	  = 1
	PRODUCT_NEW		  = 2
	PRODUCT_HOT		  = 4
	PRODUCT_SALE_50	  = 8
	PRODUCT_EVENT	  = 16
	PRODUCT_SALE_80	  = 32
	PRODUCT_SOLD_OUT  = 64
	PRODUCT_LIMITED_TIME_SALE = 128
	PRODUCT_SALE_30	  = 256
	PRODUCT_SALE	  = 512
end

--[[
KOR_PRODUCT_SELL	 = 0
KOR_PRODUCT_SOLD_OUT = 1
KOR_PRODUCT_SALE	 = 2
KOR_PRODUCT_EVENT	 = 3
KOR_PRODUCT_RESERVE  = 4
KOR_PRODUCT_NEW		 = 5
KOR_PRODUCT_HOT		 = 6
--]]

local bCouponSelectCheck = false
local bPeriodSelectCheck = false



tWinAlphaName = {['protecterr'] = 0, 'CommonAlphaPage'}
tTextureX = {['protecterr'] = 0, 0}
tTextureY = {['protecterr'] = 0, 0}
tSizeX = {['protecterr'] = 0, 1920}
tSizeY = {['protecterr'] = 0, 1200}
tPosX = {['protecterr'] = 0, 0}
tPosY = {['protecterr'] = 0, 0}

for i=1, #tWinAlphaName do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", tWinAlphaName[i])
	mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", tTextureX[i], tTextureY[i])
	mywindow:setSize(tSizeX[i], tSizeY[i])
	mywindow:setPosition(tPosX[i], tPosY[i])
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	root:addChildWindow(mywindow)
	
end

RegistEscEventInfo("CommonAlphaPage", "OnClickOneBuyCancelButton")
RegistEnterEventInfo("CommonAlphaPage", "OnClickOneBuyOkButton")


--------------------------------------------------------------------

-- 샵 공통 구입하기 팝업창

--------------------------------------------------------------------
--------------------------------------------------------------------
-- 구입하기 투명이미지.
--------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'NCS_PurchaceAlphaImage');
mywindow:setTexture('Enabled', 'UIData/invisible.tga', 0, 0);
mywindow:setTexture('Disabled', 'UIData/invisible.tga', 0, 0);
mywindow:setWideType(6)
mywindow:setPosition(360, 190);
mywindow:setSize(340, 367);
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:setUserString("noFunction", "")
root:addChildWindow(mywindow);


--------------------------------------------------------------------
-- 구입하기 제목 이미지.
--------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'NCS_PurchaceTitleImage');
mywindow:setTexture('Enabled', 'UIData/popup001.tga', 0, 855);
mywindow:setTexture('Disabled', 'UIData/popup001.tga', 0, 855);
mywindow:setPosition(0, 3);
mywindow:setSize(340, 41);
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow('NCS_PurchaceAlphaImage'):addChildWindow(mywindow);

--------------------------------------------------------------------
-- 구입하기 중간 이미지.
--------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'NCS_PurchaceMiddleImage');
mywindow:setTexture('Enabled', 'UIData/popup001.tga', 349, 0);
mywindow:setTexture('Disabled', 'UIData/popup001.tga', 349, 0);
mywindow:setPosition(0, 41);
mywindow:setSize(340, 276);
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow('NCS_PurchaceAlphaImage'):addChildWindow(mywindow);

--------------------------------------------------------------------
-- 구입하기 아래 이미지.
--------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'NCS_PurchaceBottomImage');
mywindow:setTexture('Enabled', 'UIData/popup001.tga', 0, 222);
mywindow:setTexture('Disabled', 'UIData/popup001.tga', 0, 222);
mywindow:setPosition(0, 317);
mywindow:setSize(340, 46);
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow('NCS_PurchaceAlphaImage'):addChildWindow(mywindow);

--------------------------------------------------------------------
-- 구입하기 속 알맹이 이미지.
--------------------------------------------------------------------
tBuyItemBackName	= {['protecterr']=0, "NCS_ItemContainerImage", "NCS_BuyBeforeBackImage", "NCS_BuyAfterBackImage"}
tBuyItemBackTexY	= {['protecterr']=0,			359,				519,			575}
tBuyItemBackPosY	= {['protecterr']=0,			6,					158,			216}		
tBuyItemBackSizeY	= {['protecterr']=0,			150,				54,				54}			

for i = 1, #tBuyItemBackName do
	mywindow = winMgr:createWindow('TaharezLook/StaticImage', tBuyItemBackName[i]);
	mywindow:setTexture('Enabled', 'UIData/option.tga', 0, tBuyItemBackTexY[i]);
	mywindow:setTexture('Disabled', 'UIData/option.tga', 0, tBuyItemBackTexY[i]);
	mywindow:setPosition(10, tBuyItemBackPosY[i]);
	mywindow:setSize(323, tBuyItemBackSizeY[i]);
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow('NCS_PurchaceMiddleImage'):addChildWindow( mywindow );
end


mywindow = winMgr:createWindow('TaharezLook/StaticImage', "NCS_ItemImageContainer");
mywindow:setTexture('Enabled', 'UIData/invisible.tga', 0, 0);
mywindow:setTexture('Disabled', 'UIData/invisible.tga', 0, 0);
mywindow:setPosition(17, 12);
mywindow:setSize(100, 100);
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('NCS_ItemContainerImage'):addChildWindow( mywindow );


--------------------------------------------------------------------
-- 텍스트들.
--------------------------------------------------------------------
-- 아이탬 이름, 스텟4개, 사용기간 텍스트
tBuyItemInfoTextName	= {['protecterr']=0, "NCS_PurchaseNameText", "NCS_PurchaseStatText1", "NCS_PurchaseStatText2", "NCS_PurchaseStatText3", "NCS_PurchaseStatText4", "NCS_PurchaseStatText5", "NCS_PurchasePariodText"}
tBuyItemInfoTextPosX	= {['protecterr']=0,		140,			140,				140,				140,				140,				140,		95}
tBuyItemInfoTextPosY	= {['protecterr']=0,		8,				38,					38 + 17,		38 + (17 * 2),		38 + (17 * 3),		38 + (17 * 4),	118}
tBuyItemInfoTextSizeX	= {['protecterr']=0,		170,			170,				170,				170,				170,				170,		200}

for i = 1, #tBuyItemInfoTextName do
	mywindow = winMgr:createWindow("TaharezLook/StaticText", tBuyItemInfoTextName[i])
	mywindow:setPosition(tBuyItemInfoTextPosX[i], tBuyItemInfoTextPosY[i])
	mywindow:setSize(tBuyItemInfoTextSizeX[i], 30)
	mywindow:setZOrderingEnabled(false)	
	mywindow:setViewTextMode(1)
	mywindow:setAlign(1)
	mywindow:setLineSpacing(2)
	winMgr:getWindow("NCS_ItemContainerImage"):addChildWindow(mywindow)
end


--------------------------------------------------------------------
-- 콤보박스로 쓸 버튼
--------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/Button', 'NCS_PurchasePeriodButton');
mywindow:setTexture('Normal', 'UIData/Itemshop001.tga', 401, 788);
mywindow:setTexture('Hover', 'UIData/Itemshop001.tga', 421, 788);
mywindow:setTexture('Pushed', 'UIData/Itemshop001.tga', 441, 788);
mywindow:setTexture('PushedOff', 'UIData/Itemshop001.tga', 441, 788);
mywindow:setPosition(292, 124);
mywindow:setSize(18, 17);
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:subscribeEvent("Clicked", "ItemBuyPeriodSelectBt")
winMgr:getWindow('NCS_ItemContainerImage'):addChildWindow(mywindow);


--------------------------------------------------------------------
-- 콤보박스로 쓸 버튼
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "NCS_PeriodSelectText")
mywindow:setPosition(80, 126)
mywindow:setSize(211, 17)
mywindow:setZOrderingEnabled(false)	
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:subscribeEvent("Clicked", "ItemBuyPeriodSelectBt")
winMgr:getWindow('NCS_ItemContainerImage'):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "NCS_PeriodSelectAlphaImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)		--빈공간
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(80, 126)
mywindow:setSize(207, 17)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:subscribeEvent("MouseClick", "ItemBuyPeriodSelectBt")
winMgr:getWindow('NCS_ItemContainerImage'):addChildWindow(mywindow)


--------------------------------------------------------------------
-- 버튼 (확인, 취소, 캐쉬충전)
--------------------------------------------------------------------
tBuyItemMainButtonName	= {['protecterr']=0, "NCS_PurchaseOkButton", "NCS_PurchaseCancelButton"}
tBuyItemMainButtonTexX	= {['protecterr']=0,		693,			858}
tBuyItemMainButtonPosX	= {['protecterr']=0,		4,				169}
tBuyItemMainButtonEvent	= {['protecterr']=0, "OnClickOneBuyOkButton", "OnClickOneBuyCancelButton"}

for i=1, #tBuyItemMainButtonName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tBuyItemMainButtonName[i])
	mywindow:setTexture("Normal", "UIData/popup001.tga", tBuyItemMainButtonTexX[i], 849)
	mywindow:setTexture("Hover", "UIData/popup001.tga", tBuyItemMainButtonTexX[i], 878)
	mywindow:setTexture("Pushed", "UIData/popup001.tga", tBuyItemMainButtonTexX[i], 907)
	mywindow:setTexture("Disabled", "UIData/popup001.tga", tBuyItemMainButtonTexX[i], 849)
	mywindow:setPosition(tBuyItemMainButtonPosX[i], 13)
	mywindow:setSize(166, 29)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:subscribeEvent("Clicked", tBuyItemMainButtonEvent[i])
	winMgr:getWindow('NCS_PurchaceBottomImage'):addChildWindow(mywindow)
end

--------------------------------------------------------------------
-- 기간 라디오버튼 넣어줄 투명이미지.
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "NCS_PeriodSelectImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 700, 200)		--빈공간
mywindow:setTexture("Disabled", "UIData/invisible.tga", 700, 200)
mywindow:setPosition(87, 148)
mywindow:setSize(213, 85)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('NCS_PurchaceMiddleImage'):addChildWindow(mywindow)


--------------------------------------------------------------------
-- 기간 라디오버튼
--------------------------------------------------------------------
tBuyItemPeriodSelectBtName	= {['protecterr']=0, "Period1", "Period2", "Period3", "Period4", "Period5"}
tBuyItemPeriodSelectBtPosY	= {['protecterr']=0,	0,			17,		17 *2,		17*3,       17*4 }

for i=1, #tBuyItemPeriodSelectBtName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tBuyItemPeriodSelectBtName[i])
	mywindow:setTexture("Normal", "UIData/option.tga", 328, 418)
	mywindow:setTexture("Hover", "UIData/option.tga", 328, 438)
	mywindow:setTexture("Pushed", "UIData/option.tga", 328, 438)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 328, 438)
	mywindow:setTexture("SelectedNormal", "UIData/option.tga", 328, 438)
	mywindow:setTexture("SelectedHover", "UIData/option.tga", 328, 438)
	mywindow:setTexture("SelectedPushed", "UIData/option.tga", 328, 438)
	mywindow:setPosition(0, tBuyItemPeriodSelectBtPosY[i])
	mywindow:setProperty("GroupID", 3015)	--??
	mywindow:setSize(213, 17)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("SelectStateChanged", "BuyItemPeriodBtEvent")
	winMgr:getWindow('NCS_PeriodSelectImage'):addChildWindow(mywindow)
end

--------------------------------------------------------------------
-- 기간 라디오버튼 텍스트
--------------------------------------------------------------------
tBuyItemPeriodTextName	= {['protecterr']=0, "Period1_Text", "Period2_Text", "Period3_Text", "Period4_Text", "Period5_Text"}

for i=1, #tBuyItemPeriodTextName do
	mywindow = winMgr:createWindow("TaharezLook/StaticText", tBuyItemPeriodTextName[i])
	mywindow:setPosition(0, 2)
	mywindow:setSize(231, 17)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)	
	mywindow:setViewTextMode(1)
	mywindow:setAlign(8)
	mywindow:setLineSpacing(2)
	mywindow:setUserString('String', tostring(0));				-- 돈
	mywindow:setUserString('Money', tostring(0));				-- 돈
	mywindow:setUserString('PayType', tostring(0));			-- 결제수단
	mywindow:setUserString('productExpire', tostring(0));	-- 사용기간
	mywindow:setUserString('BuyProductNo', tostring(0));	-- 프로덕트넘버
	winMgr:getWindow("Period"..tostring(i)):addChildWindow(mywindow)
end

tMoneyInfoTextName		= {['protecterr']=0, "NCS_PurchaseBeforeGranText", "NCS_PurchaseBeforeCashText", "NCS_PurchaseAfterGranText", "NCS_PurchaseAfterCashText"}
tMoneyInfoTextPosY		= {['protecterr']=0,		7,			31,				7,				31 }
tMoneyInfoTextWinName	= {['protecterr']=0, "NCS_BuyBeforeBackImage", "NCS_BuyBeforeBackImage", "NCS_BuyAfterBackImage", "NCS_BuyAfterBackImage"}
 
for i=1, #tMoneyInfoTextName do
	local tMoneyInfoTextPosYPlus = 0
	mywindow = winMgr:createWindow("TaharezLook/StaticText", tMoneyInfoTextName[i])
	if IsKoreanLanguage() then
		if i==1 or i==3 then
			mywindow:setVisible(false)
		else
			tMoneyInfoTextPosYPlus = 11		
		end		
	end	
	mywindow:setPosition(90, tMoneyInfoTextPosY[i] - tMoneyInfoTextPosYPlus)
	mywindow:setSize(165, 20)
	mywindow:setZOrderingEnabled(true)	
	mywindow:setEnabled(false)
	mywindow:setViewTextMode(1)
	mywindow:setAlign(5)
	mywindow:setLineSpacing(2)
	winMgr:getWindow(tMoneyInfoTextWinName[i]):addChildWindow(mywindow)
end




-- 기간 연장 Title이미지.
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "NCS_ExtensionPeriod")
mywindow:setTexture("Enabled", "UIData/skillitem001.tga", 724, 306)
mywindow:setTexture("Disabled", "UIData/skillitem001.tga", 724, 306)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 0)
mywindow:setSize(340, 41)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("NCS_PurchaceAlphaImage"):addChildWindow(mywindow)








--------------------------------------------------------------------

-- 함수들

--------------------------------------------------------------------
function PurchaseOKorCancel()
	for i = 1, #tBuyItemPeriodSelectBtName do
		winMgr:getWindow(tBuyItemPeriodSelectBtName[i]):setProperty("Selected", "false")
	end
	winMgr:getWindow('NCS_PeriodSelectImage'):setVisible(false)
	
end


--------------------------------------------------------------------
-- 사용기간 선택 버튼
--------------------------------------------------------------------
function ItemBuyPeriodSelectBt()
	bPeriodSelectCheck = true
	if winMgr:getWindow("NCS_PeriodSelectImage"):isVisible(true) then
		winMgr:getWindow("NCS_PeriodSelectImage"):setVisible(false)
	else
		winMgr:getWindow('NCS_PurchaceMiddleImage'):addChildWindow(winMgr:getWindow("NCS_PeriodSelectImage"))
		winMgr:getWindow("NCS_PeriodSelectImage"):setVisible(true)
	end
end

--------------------------------------------------------------------
-- 아이템 정보 텍스트 뿌려줄
--------------------------------------------------------------------
function ItemInfoText()




end


--------------------------------------------------------------------
-- 구입하기 창을 보여준다.
--------------------------------------------------------------------
function ShowBuyItemContainer()

	winMgr:getWindow('NCS_PurchaceAlphaImage'):setVisible(true)

end



------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------

-- 구입하기 확인창

--------------------------------------------------------------------
--------------------------------------------------------------------
-- 구입하기확인창 알파.
--------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'NCS_PurchaseConfirmAlphaImage');
mywindow:setTexture('Enabled', 'UIData/OnDLGBackImage.tga', 0, 0);
mywindow:setTexture('Disabled', 'UIData/OnDLGBackImage.tga', 0, 0);
mywindow:setProperty('BackgroundEnabled', 'False');
mywindow:setProperty('FrameEnabled', 'False');
mywindow:setPosition(0,0);
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow);


RegistEscEventInfo("NCS_PurchaseConfirmAlphaImage", "OnClickRealOneBuyCancelButton")
RegistEnterEventInfo("NCS_PurchaseConfirmAlphaImage", "OnClickRealOneBuyOkButton")
--------------------------------------------------------------------
-- 구입하기확인창 뒷판.
--------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'NCS_PurchaseConfirmImage');
mywindow:setTexture('Enabled', 'UIData/popup001.tga', 0, 0);
mywindow:setTexture('Disabled', 'UIData/popup001.tga', 0, 0);
mywindow:setProperty('BackgroundEnabled', 'False');
mywindow:setProperty('FrameEnabled', 'False');
mywindow:setPosition((1024 - 340) / 2, (768 - 268) / 2);
mywindow:setSize(340, 268);
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow('NCS_PurchaseConfirmAlphaImage'):addChildWindow(mywindow);


--------------------------------------------------------------------
-- 구입하기 제목 이미지.
--------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'NCS_PurchaseConfirmTitleImage');
mywindow:setTexture('Enabled', 'UIData/popup001.tga', 0, 855);
mywindow:setTexture('Disabled', 'UIData/popup001.tga', 0, 855);
mywindow:setProperty('BackgroundEnabled', 'False');
mywindow:setProperty('FrameEnabled', 'False');
mywindow:setPosition(0, 0);
mywindow:setSize(340, 41);
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow('NCS_PurchaseConfirmImage'):addChildWindow(mywindow);


--------------------------------------------------------------------
-- 구입하기확인창 아이템 이미지 들어가는부분.
--------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticImage', "NCS_ItemContainer1");
mywindow:setTexture('Enabled', 'UIData/option.tga', 0, 359);
mywindow:setTexture('Disabled', 'UIData/option.tga', 0, 359);
mywindow:setProperty('BackgroundEnabled', 'False');
mywindow:setProperty('FrameEnabled', 'False');
if IsKoreanLanguage() then
	mywindow:setPosition(10, 39);
else
	mywindow:setPosition(10, 45);
end
mywindow:setSize(323, 150);
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('NCS_PurchaseConfirmImage'):addChildWindow( mywindow );


--------------------------------------------------------------------
-- 구입하기확인창 아이템 이미지 들어가는부분.땜빵
--------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticImage', "NCS_ItemContainer2");
mywindow:setTexture('Enabled', 'UIData/option.tga', 280, 482);
mywindow:setTexture('Disabled', 'UIData/option.tga', 280, 482);
mywindow:setProperty('BackgroundEnabled', 'False');
mywindow:setProperty('FrameEnabled', 'False');
mywindow:setPosition(290, 123);
mywindow:setSize(2, 19);
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('NCS_ItemContainer1'):addChildWindow( mywindow );


--------------------------------------------------------------------
-- 구입하기확인창 아이템 이미지
--------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticImage', "NCS_ConfirmItemImage");
mywindow:setTexture('Enabled', 'UIData/invisible.tga', 0, 0);
mywindow:setTexture('Disabled', 'UIData/invisible.tga', 0, 0);
mywindow:setPosition(10, 12);
mywindow:setSize(115, 115);
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('NCS_ItemContainer1'):addChildWindow( mywindow );


--------------------------------------------------------------------
-- 구입하기확인창 아이템Text들어가는 부분.
--------------------------------------------------------------------
tRealBuyItemInfoTextName	= {['protecterr']=0, "NCS_RealPurchaseNameText", "NCS_RealPurchaseStatText1", "NCS_RealPurchaseStatText2", "NCS_RealPurchaseStatText3", "NCS_RealPurchaseStatText4", "NCS_RealPurchasePariodText"}
tRealBuyItemInfoTextPosX	= {['protecterr']=0,		140,			140,				140,				140,				140,			95}
tRealBuyItemInfoTextPosY	= {['protecterr']=0,		14,				38,					38 + 20,		38 + (20 * 2),		38 + (20 * 3),		127}
tRealBuyItemInfoTextSizeX	= {['protecterr']=0,		170,			170,				170,				170,				170,			200}

for i = 1, #tRealBuyItemInfoTextName do
	mywindow = winMgr:createWindow("TaharezLook/StaticText", tRealBuyItemInfoTextName[i])
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(tRealBuyItemInfoTextPosX[i], tRealBuyItemInfoTextPosY[i])
	mywindow:setSize(tRealBuyItemInfoTextSizeX[i], 30)
	mywindow:setZOrderingEnabled(false)	
	mywindow:setViewTextMode(1)
	if i == 1 or i == 6 then
		mywindow:setAlign(8)
	else
		mywindow:setAlign(1)
	end
	mywindow:setLineSpacing(2)
	winMgr:getWindow("NCS_ItemContainer1"):addChildWindow(mywindow)
end



--------------------------------------------------------------------
-- 구입하기확인창 구입 text 들어가는 부분.
--------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticText', "NCS_PurchaseOKString");
mywindow:setZOrderingEnabled(false)
if IsKoreanLanguage() then
	mywindow:setPosition(0, 192);
	mywindow:setLineSpacing(1)
else
	mywindow:setPosition(0, 201);
	mywindow:setLineSpacing(2)
end
mywindow:setSize(340, 20);
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
winMgr:getWindow('NCS_PurchaseConfirmImage'):addChildWindow( mywindow );



--------------------------------------------------------------------
-- 버튼 (확인, 취소)
--------------------------------------------------------------------
tBuyItemRealButtonName	= {['protecterr']=0, "NCS_RealPurchaseOKButton", "NCS_RealPurchaseCancelButton"}
tBuyItemRealButtonTexX	= {['protecterr']=0,		693,			858}
tBuyItemRealButtonPosX	= {['protecterr']=0,		4,				169}		
tBuyItemRealButtonEvent	= {['protecterr']=0, "OnClickRealOneBuyOkButton", "OnClickRealOneBuyCancelButton"}

for i=1, #tBuyItemRealButtonName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tBuyItemRealButtonName[i])
	mywindow:setTexture("Normal", "UIData/popup001.tga", tBuyItemRealButtonTexX[i], 849)
	mywindow:setTexture("Hover", "UIData/popup001.tga", tBuyItemRealButtonTexX[i], 878)
	mywindow:setTexture("Pushed", "UIData/popup001.tga", tBuyItemRealButtonTexX[i], 907)
	mywindow:setTexture("Disabled", "UIData/popup001.tga", tBuyItemRealButtonTexX[i], 849)
	mywindow:setPosition(tBuyItemRealButtonPosX[i], 235)
	mywindow:setSize(166, 29)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:subscribeEvent("Clicked", tBuyItemRealButtonEvent[i])
	winMgr:getWindow('NCS_PurchaseConfirmImage'):addChildWindow(mywindow)
end



function ShowRealPurchaseWindow(itemNumber, FileName, ItemName, ItemPeriod, type, ItemKind)
	root:addChildWindow(winMgr:getWindow("NCS_PurchaseConfirmAlphaImage"))
	winMgr:getWindow("NCS_PurchaseConfirmAlphaImage"):setVisible(true);
	
	-- 아이템 이미지.
	winMgr:getWindow('NCS_ConfirmItemImage'):setTexture('Enabled', FileName, 0, 0);	
	
	for i = 1, #tRealBuyItemInfoTextName do
		winMgr:getWindow(tRealBuyItemInfoTextName[i]):clearTextExtends();	-- 초기화
	end
	-- 아이템 이름
	winMgr:getWindow("NCS_RealPurchaseNameText"):addTextExtends(ItemName, g_STRING_FONT_GULIMCHE, 12, 204,255,255, 255,   3, 60,60,60,255);	
	
	if ItemKind ~= 23 then		-- 아케이드 쿠폰 능력치 나오는것 막기
		local AtkStr, AtkGra, Cri, Hp, Sp, DefStr, DefGra,TeamA, DoubleA, SpecialA, TeamD, DoubleD, SpecialD, CriDmg = GetItemStat(tonumber(itemNumber));
		
		local tStat			= {['protecterr']=0, AtkStr, AtkGra, Cri, Hp, Sp, DefStr, DefGra}
		local tStatNameText = {['protecterr']=0, PreCreateString_1122, PreCreateString_1123, PreCreateString_1124, 
										"HP", "SP", PreCreateString_1125, PreCreateString_1126 }
		local StatCount		= 0;

				
		for i = 1, #tStatNameText do
			if tStat[i] ~= 0 then
				local SignString = ""
				if tStat[i] > 0 then
					SignString = "+"
				end
				if i == 3  or i == 14 then
					local aa = tStat[i] / 10
					local bb = tStat[i] % 10
					tStat[i] = tostring(aa).."."..bb.."%"				
				end
				StatCount = StatCount + 1
				if winMgr:getWindow("NCS_RealPurchaseStatText"..tostring(StatCount)) then
					winMgr:getWindow("NCS_RealPurchaseStatText"..tostring(StatCount)):addTextExtends(tStatNameText[i].." "..SignString..tStat[i], g_STRING_FONT_GULIMCHE, 12, 255,255,255, 255,   0, 255,255,255,255);
				end

			end
		end
	end
	winMgr:getWindow("NCS_RealPurchasePariodText"):addTextExtends(ItemPeriod, g_STRING_FONT_GULIMCHE, 12, 255,198,30, 255,   0, 0,0,0,255);
	
		
	-- 선물하기인지 구입하기인지
	local String = ""	
	if IsKoreanLanguage() then
		if type == Type_Purchase then
			Item_PurchaseType = Type_Purchase
			String = PreCreateString_3397
		elseif type == Type_Present then
			Item_PurchaseType = Type_Present
			local Name = winMgr:getWindow("p_SendNameEditbox"):getText()
			if Name ~= nil then
				--String = string.format(GetSStringInfo(LAN_SEND_PRESENT), Name)
				String = PreCreateString_3398
			end
		end
		
		winMgr:getWindow("NCS_PurchaseOKString"):clearTextExtends()
		winMgr:getWindow("NCS_PurchaseOKString"):addTextExtends(String, g_STRING_FONT_GULIMCHE,11, 255,205,86,255, 1, 0,0,0,255);
	else
		if type == Type_Purchase then
			Item_PurchaseType = Type_Purchase
			String = NCS_String_PurchaseConfirm
		elseif type == Type_Present then
			Item_PurchaseType = Type_Present
			local Name = winMgr:getWindow("p_SendNameEditbox"):getText()
			if Name ~= nil then
				String = string.format(PreCreateString_2179, Name)			-- GetSStringInfo(LAN_SEND_PRESENT)		
			end
		end
		
		winMgr:getWindow("NCS_PurchaseOKString"):clearTextExtends()
		winMgr:getWindow("NCS_PurchaseOKString"):addTextExtends(String, g_STRING_FONT_GULIMCHE,12, 255,205,86,255, 1, 0,0,0,255);
	end	
		
	
end


-- 확인 팝업창 ok버튼
function OnClickRealOneBuyOkButton(args)

	DebugStr('OnClickOneBuyOkButton2 start');
	winMgr:getWindow("NCS_PurchaseConfirmAlphaImage"):setVisible(false);
	
	if Item_PurchaseType == Type_Purchase then
		Toc_ClickedPurchaseButton(Item_BuyProductNo, Type_Purchase, "", "")
	elseif Item_PurchaseType == Type_Present then
		local Name = winMgr:getWindow("p_SendNameEditbox"):getText()
		local msg = winMgr:getWindow("p_SendMessageEditbox"):getText()
		--msg = AdjustString(g_STRING_FONT_GULIMCHE, 12, msg, 170)
		Toc_ClickedPurchaseButton(Item_BuyProductNo, Type_Present, Name, msg)
	end
	
	ToC_SetSelectDiscountIndex(-1)
end


-- 구입하기 정말 취소버튼
function OnClickRealOneBuyCancelButton(args)
	
	winMgr:getWindow("NCS_PurchaseConfirmAlphaImage"):setVisible(false);

	ToC_SetSelectDiscountIndex(-1)
end



--------------------------------------------------------------------
-- 구입하기 팝업창 이벤트
--------------------------------------------------------------------
function PurchaseContent(mywindow, PurchaseType)
	WearItemNumber		= -1
	WearItemIndex		= -1
	
	local RelationproductNo	= 	tonumber(mywindow:getUserString('RelationproductNo'))
	
	if PurchaseType == Type_Purchase then
		winMgr:getWindow('CommonAlphaPage'):setVisible(true);
		root:addChildWindow( winMgr:getWindow('CommonAlphaPage') );
		
		winMgr:getWindow('NCS_PurchaceAlphaImage'):setVisible(true);
		winMgr:getWindow('CommonAlphaPage'):addChildWindow('NCS_PurchaceAlphaImage');
		
		winMgr:getWindow('NCS_PurchaceAlphaImage'):addChildWindow(winMgr:getWindow('NCS_PurchaceMiddleImage'));
		winMgr:getWindow('NCS_PurchaceMiddleImage'):setPosition(0, 41)
		-- 중간 이미지 		
		winMgr:getWindow('NCS_PurchaceMiddleImage'):setTexture('Enabled', 'UIData/popup001.tga', 349, 0);
		for i = 1, #tBuyItemBackName do
			winMgr:getWindow(tBuyItemBackName[i]):setTexture('Enabled', 'UIData/option.tga', 0, tBuyItemBackTexY[i]);
			winMgr:getWindow(tBuyItemBackName[i]):setTexture('Disabled', 'UIData/option.tga', 0, tBuyItemBackTexY[i]);
		end
		
		-- 그랑 텍스트
		winMgr:getWindow('NCS_BuyBeforeBackImage'):setPosition(10, 158)
		winMgr:getWindow('NCS_BuyAfterBackImage'):setPosition(10, 216)

		winMgr:getWindow("NCS_PurchaceTitleImage"):setTexture('Enabled', 'UIData/popup001.tga', 0, 855);
		winMgr:getWindow("NCS_PurchaceTitleImage"):setTexture('Disabled', 'UIData/popup001.tga', 0, 855);
		CheckCouponUsable(ToC_CheckDiscountCoupon(), ToC_CheckUsableItemCoupon(RelationproductNo, PRODUCT_SALE_50))
		
		--ToC_CheckUsableItemCoupon(RelationproductNo, PRODUCT_SALE)
		--winMgr:getWindow("NCS_CouponSelectText"):setVisible(ToC_CheckDiscountCoupon())
		--winMgr:getWindow("NCS_CouponSelectText"):setTextExtends(PreCreateString_2703, g_STRING_FONT_GULIMCHE, 12, 255,255,255, 255,   0, 0,0,0,255)
			
	elseif PurchaseType == Type_Present then
		CheckCouponUsable(false, false)
		winMgr:getWindow('p_presentAlpha'):setVisible(true);
		root:addChildWindow( winMgr:getWindow('p_presentAlpha') );
		
		-- 에디트 박스 초기화
		winMgr:getWindow("p_SendNameEditbox"):setText("")
		winMgr:getWindow("p_SendMessageEditbox"):setText("")
	
		winMgr:getWindow('p_presentMain'):addChildWindow(winMgr:getWindow('NCS_PurchaceMiddleImage'));
		winMgr:getWindow('NCS_PurchaceMiddleImage'):setPosition(0, 141)
				
		-- 중간 이미지 
		winMgr:getWindow('NCS_PurchaceMiddleImage'):setTexture('Enabled', 'UIData/invisible.tga', 349, 0);
		for i = 1, #tBuyItemBackName do
			winMgr:getWindow(tBuyItemBackName[i]):setTexture('Enabled', 'UIData/invisible.tga', 0, tBuyItemBackTexY[i]);
			winMgr:getWindow(tBuyItemBackName[i]):setTexture('Disabled', 'UIData/invisible.tga', 0, tBuyItemBackTexY[i]);
		end
		
		-- 그랑 텍스트
		winMgr:getWindow('NCS_BuyBeforeBackImage'):setPosition(6, 152)
		winMgr:getWindow('NCS_BuyAfterBackImage'):setPosition(6, 209)
		
	end
		
	local ItemNumber		= 	tonumber(mywindow:getUserString('ItemNumber'))
	local item_name			= 	mywindow:getUserString('ItemName')
	local ItemNameFile		= 	mywindow:getUserString('ItemNameFile')
	local Pieces			= 	tonumber(mywindow:getUserString('Pieces'))	-- 한번에 파는 아이템 갯수
	local ItemKind			= 	tonumber(mywindow:getUserString('ItemKind'))
	
	
	winMgr:getWindow("NCS_ItemImageContainer"):setTexture('Enabled', ItemNameFile, 0, 0);
	winMgr:getWindow("NCS_ItemImageContainer"):setTexture('Disabled', ItemNameFile, 0, 0);
	
	winMgr:getWindow("NCS_PeriodSelectText"):setTextExtends(Shop_String_19, g_STRING_FONT_GULIMCHE, 12, 255, 255, 255, 255,   0, 255,255,255,255);
	winMgr:getWindow("NCS_PeriodSelectText"):setUserString('SelectPeriod', 1);
	winMgr:getWindow("Period1_Text"):setTextExtends(Shop_String_19, g_STRING_FONT_GULIMCHE, 12, 0, 0, 0, 255,   0, 0,0,0,255);

	local Count	= GetRelationItemCount(RelationproductNo)
	for	i = 0, 3 do
		winMgr:getWindow("Period"..tostring(i+2)):setEnabled(false)
		winMgr:getWindow("Period"..tostring(i+2).."_Text"):clearTextExtends()
	end
	
	local tIndex = {['err']=0, [0]=0, 1, 2, 3}
	
	for	i = 0, Count - 1 do
		winMgr:getWindow("Period"..tostring(i+2)):setEnabled(true)
		local Point, ExpireTime, ProductNumber, PayType = GetRelationItem(RelationproductNo, i)
		local String	= ""

		if PayType == TYPE_GRAN then
			--String = ExpireTime.." / "..tostring(Point).." "..ShopCommon_String_GRAN
			String = ExpireTime.." / %d "..ShopCommon_String_GRAN
			
		elseif PayType == TYPE_CASH then
			String = ExpireTime.." / %d "..ShopCommon_String_CASH
	
		end
		winMgr:getWindow("Period"..tostring(tIndex[i]+2).."_Text"):setUserString('Money', tostring(Point));				-- 돈
		winMgr:getWindow("Period"..tostring(tIndex[i]+2).."_Text"):setUserString('PayType', tostring(PayType));			-- 결제수단
		winMgr:getWindow("Period"..tostring(tIndex[i]+2).."_Text"):setUserString('productExpire', ExpireTime);	-- 사용기간
		winMgr:getWindow("Period"..tostring(tIndex[i]+2).."_Text"):setUserString('BuyProductNo', tostring(ProductNumber));	-- 프로덕트넘버
		winMgr:getWindow("Period"..tostring(tIndex[i]+2).."_Text"):setUserString('String', String);	-- 내용
		local PointString	= string.format(String, tonumber(Point))
		winMgr:getWindow("Period"..tostring(tIndex[i]+2).."_Text"):setTextExtends(PointString, g_STRING_FONT_GULIMCHE, 12, 0, 0, 0, 255,   0, 0,0,0,255);
	end
	winMgr:getWindow('NCS_PurchaseNameText'):setAlign(7);
	winMgr:getWindow('NCS_PurchaseNameText'):setTextExtends(item_name, g_STRING_FONT_GULIMCHE, 12, 255,198,30, 255,   1, 60,60,60,255);
	winMgr:getWindow('NCS_PurchaseNameText'):setText(item_name);

	for i = 1, 5 do
		winMgr:getWindow("NCS_PurchaseStatText"..tostring(i)):clearTextExtends();	-- 초기화
	end

	
	if ItemKind ~= 23 then		-- 아케이드 쿠폰 능력치 나오는것 막기
		local AtkStr, AtkGra, Cri, Hp, Sp, DefStr, DefGra,TeamA, DoubleA, SpecialA, TeamD, DoubleD, SpecialD, CriDmg = GetItemStat(tonumber(ItemNumber));
		local tStat			= {['protecterr']=0, AtkStr, AtkGra, Cri, Hp, Sp, DefStr, DefGra}
		local tStatNameText = {['protecterr']=0, PreCreateString_1122, PreCreateString_1123, PreCreateString_1124, 
										"HP", "SP", PreCreateString_1125, PreCreateString_1126 }
		local StatCount		= 1;

		for i = 1, #tStatNameText do
			if tStat[i] ~= 0 then
				local SignString = ""
				
				if tStat[i] > 0 then
					if i == 3  or i == 14 then
						local aa = tStat[i] / 10
						local bb = tStat[i] % 10
						tStat[i] = tostring(aa).."."..bb.."%"				
					end
					SignString = "+"
					winMgr:getWindow("NCS_PurchaseStatText"..tostring(StatCount)):addTextExtends(tStatNameText[i].." "..SignString..tStat[i], g_STRING_FONT_GULIMCHE, 12, 0,255,0,255,   0, 255,255,255,255);
				else
					if i == 3  or i == 14 then
						local aa = tStat[i] / 10
						local bb = tStat[i] % 10
						tStat[i] = tostring(aa).."."..bb.."%"				
					end
					winMgr:getWindow("NCS_PurchaseStatText"..tostring(StatCount)):addTextExtends(tStatNameText[i].." "..SignString..tStat[i], g_STRING_FONT_GULIMCHE, 12, 231,32,20,255,   0, 255,255,255,255);
				end			
				StatCount = StatCount + 1
			end
		end
	end
	
	local my_point	= GetInvenMyMoney();
	local item_point = tonumber( mywindow:getUserString('PricePoint') );	-- 현재 선택한 아이템 포인트를 전역변수에 세팅

	winMgr:getWindow('NCS_PurchaseBeforeGranText'):setTextExtends(CommatoMoneyStr64(tostring(my_point)), g_STRING_FONT_GULIMCHE, 12, 255, 255, 255, 255,   0, 0,0,0,255);
	winMgr:getWindow('NCS_PurchaseBeforeCashText'):setTextExtends(CommatoMoneyStr(tostring(GetMyCash())), g_STRING_FONT_GULIMCHE, 12, 255, 255, 255, 255,   0, 0,0,0,255);

	winMgr:getWindow('NCS_PurchaseAfterGranText'):setTextExtends(CommatoMoneyStr64(tostring(my_point)), g_STRING_FONT_GULIMCHE, 12, 255,198,30, 255,   0, 0,0,0,255);
	winMgr:getWindow('NCS_PurchaseAfterCashText'):setTextExtends(CommatoMoneyStr(tostring(GetMyCash())), g_STRING_FONT_GULIMCHE, 12, 255,198,30, 255,   0, 0,0,0,255);
	winMgr:getWindow("NCS_PurchaseAfterCashSaleText"):setVisible(false)
end


--------------------------------------------------------------------
-- 아이템 기간선택 라디오버튼 이벤트
--------------------------------------------------------------------
function BuyItemPeriodBtEvent(args)

	local Point = 0
	local _RelationProductNo, PointString = "";
	local my_point	= GetInvenMyMoney();
	local my_Cash	= GetMyCash();
	local type		= 0
	local PayType	= 0
	local	final_Money	= 0;
	for i = 1, #tBuyItemPeriodSelectBtName do
		if CEGUI.toRadioButton(winMgr:getWindow(tBuyItemPeriodSelectBtName[i])):isSelected() == true then
			winMgr:getWindow("NCS_PeriodSelectImage"):setVisible(false)
			if i == 1 then
				winMgr:getWindow("NCS_PeriodSelectText"):setTextExtends(Shop_String_19, g_STRING_FONT_GULIMCHE, 12, 255, 255, 255, 255,   0, 255,255,255,255);
				winMgr:getWindow("NCS_PeriodSelectText"):setUserString('BuyProductNo', "");
				winMgr:getWindow('NCS_PurchaseBeforeGranText'):setTextExtends(CommatoMoneyStr64(tostring(my_point)), g_STRING_FONT_GULIMCHE, 12, 255, 255, 255, 255,   0, 0,0,0,255);
				winMgr:getWindow('NCS_PurchaseAfterGranText'):setTextExtends(CommatoMoneyStr64(tostring(my_point)), g_STRING_FONT_GULIMCHE, 12, 255,198,30, 255,   0, 0,0,0,255);
				winMgr:getWindow('NCS_PurchaseBeforeCashText'):setTextExtends(CommatoMoneyStr(tostring(my_Cash)), g_STRING_FONT_GULIMCHE, 12, 255, 255, 255, 255,   0, 0,0,0,255);
				winMgr:getWindow('NCS_PurchaseAfterCashText'):setTextExtends(CommatoMoneyStr(tostring(my_Cash)), g_STRING_FONT_GULIMCHE, 12, 255,198,30, 255,   0, 0,0,0,255);
				purchaseTypeIndex = 0
				purchasePrice = 0
				_RelationProductNo	= winMgr:getWindow("Period2_Text"):getUserString('BuyProductNo');
				ClearCouponSelectBtn(-1, _RelationProductNo)
			elseif i >= 2 then
				Point				= tonumber(winMgr:getWindow("Period"..tostring(i).."_Text"):getUserString('Money'))
				
				_RelationProductNo	= winMgr:getWindow("Period"..tostring(i).."_Text"):getUserString('BuyProductNo');
				PayType				= tonumber(winMgr:getWindow("Period"..tostring(i).."_Text"):getUserString('PayType'));
				local String		= winMgr:getWindow("Period"..tostring(i).."_Text"):getUserString('String')

				if PayType == TYPE_GRAN then
					type = TYPE_GRAN
					winMgr:getWindow('NCS_PurchaseAfterCashText'):setTextExtends(CommatoMoneyStr(tostring(my_Cash)), g_STRING_FONT_GULIMCHE, 12, 255,198,30, 255,   0, 0,0,0,255);
					winMgr:getWindow('NCS_PurchaseBeforeGranText'):setTextExtends(CommatoMoneyStr64(tostring(my_point)), g_STRING_FONT_GULIMCHE, 12, 255, 255, 255, 255,   0, 0,0,0,255);
					winMgr:getWindow('NCS_PurchaseAfterGranText'):setTextExtends(CommatoMoneyStr64(tostring(GetInvenMyMoneyCalc(tonumber(-Point)))), g_STRING_FONT_GULIMCHE, 12, 255,198,30, 255,   0, 0,0,0,255);	
					final_Money = my_point
					purchaseTypeIndex = TYPE_GRAN
					purchasePrice = 0
					PointString	= string.format(String, tonumber(Point))
					ToC_SetSelectDiscountIndex(-1)
					Point = SettingCouponSelectBtn(_RelationProductNo, ToC_GetSelectDiscountIndex())
				elseif PayType == TYPE_CASH then
					type = TYPE_CASH
					winMgr:getWindow('NCS_PurchaseAfterGranText'):setTextExtends(CommatoMoneyStr(tostring(my_point)), g_STRING_FONT_GULIMCHE, 12, 255,198,30, 255,   0, 0,0,0,255);
					winMgr:getWindow('NCS_PurchaseBeforeCashText'):setTextExtends(CommatoMoneyStr(tostring(my_Cash)), g_STRING_FONT_GULIMCHE, 12, 255, 255, 255, 255,   0, 0,0,0,255);
					winMgr:getWindow('NCS_PurchaseAfterCashText'):setTextExtends(CommatoMoneyStr(tostring(my_Cash-tonumber(Point))), g_STRING_FONT_GULIMCHE, 12, 255,198,30, 255,   0, 0,0,0,255);
					final_Money = my_Cash
					purchaseTypeIndex = TYPE_CASH
					purchasePrice = Point
					PointString	= string.format(String, tonumber(Point))					
					Point = SettingCouponSelectBtn(_RelationProductNo, ToC_GetSelectDiscountIndex())
				end
				
				winMgr:getWindow("NCS_PeriodSelectText"):setTextExtends(PointString, g_STRING_FONT_GULIMCHE, 12, 255,198,30, 255,   0, 255,255,255,255);
				winMgr:getWindow("NCS_PeriodSelectText"):setUserString('BuyProductNo', _RelationProductNo);
				
				Item_BuyProductNo = tonumber(_RelationProductNo)
		--		local selectItemIndex = root:getUserString('CurrItemIndex');
		--		if selectItemIndex ~= '-1' then
		--			Lua_DebugStr("_RelationProductNo : ".._RelationProductNo)
		--			local select_window		= winMgr:getWindow('Select_Item'..selectItemIndex);	
		--			select_window:setUserString('BuyProductNo', _RelationProductNo);					--아이템 넘버 셋팅.
		--		end
			end
			
			winMgr:getWindow("NCS_PeriodSelectText"):setUserString('SelectPeriod', tostring(i));
			winMgr:getWindow(tBuyItemPeriodSelectBtName[i]):setProperty("Selected", "false")
		end
	end

	ToC_GetSelectDiscountIndex()

	local couponName, disCountRate = ToC_GetDiscountCouponName(buttonIndex)
	
	local purchasePrice = tonumber(Point)
	local saleValue = purchasePrice * disCountRate / 100
	purchasePrice = purchasePrice - saleValue
	
	if purchasePrice > 0 then
		if (final_Money - purchasePrice) < 0 then
			if type == TYPE_GRAN then
				EnoughBuyItem = 1;		-- 그랑이 모자름.
			elseif type == TYPE_CASH then
				EnoughBuyItem = 2;		-- 캐시이 모자름.
			end
		else
			EnoughBuyItem = 0;
		end
	else
		EnoughBuyItem = 0;
	end
end

-- 구입하기 확인 버튼클릭이벤트
function OnClickOneBuyOkButton(args)
	DebugStr('OnClickOneBuyOkButton start');
	
	local select_window = NCS_Selected_Window
	
	local item_Name = select_window:getUserString('ItemName');
	local item_number = tonumber( select_window:getUserString('ItemNumber') );
	local item_file_name = select_window:getUserString("ItemNameFile");
	local itemLevel		= tonumber(select_window:getUserString("Level"))
	
	
	local ItemPeriodIndex = winMgr:getWindow("NCS_PeriodSelectText"):getUserString('SelectPeriod');
	local Point, ProductExpire, ProductNumber;

	if ItemPeriodIndex == "1" then
		ShowCommonAlertOkBoxWithFunction(Shop_String_19, 'OnClickAlertOkSelfHide');
		return
	end
	if EnoughBuyItem == 1 then
		ShowCommonAlertOkBoxWithFunction(ShopCommon_NotEnough_Gran, 'OnClickAlertOkSelfHide');
		return
	elseif EnoughBuyItem == 2 then
		ShowCommonAlertOkBoxWithFunction(ShopCommon_NotEnough_Cash, 'OnClickAlertOkSelfHide');
		return
	end
		
--	local _my_name, _money, _level, _promotion, _my_style, _type, _sp_point, _hp_point, _experience = GetMyInfo(false);
--	if itemLevel > _level then
--		ShowCommonAlertOkBoxWithFunction(CommonShop_String_NOT_LEVEL, 'OnClickAlertOkSelfHide');
--		return
--	end
	
--	if Toc_PurchaseRestriction(item_number) == false then
--		ShowCommonAlertOkBoxWithFunction(CommonShop_String_PURCHASE_SKILL_FAIL, 'OnClickAlertOkSelfHide');
--		return
--	end
	
	
	local Point		= tonumber(winMgr:getWindow("Period"..ItemPeriodIndex.."_Text"):getUserString('Money'))
	local PayType	= tonumber(winMgr:getWindow("Period"..ItemPeriodIndex.."_Text"):getUserString('PayType'))
	local Expire	= tonumber(winMgr:getWindow("Period"..ItemPeriodIndex.."_Text"):getUserString('productExpire'))
	local String	= winMgr:getWindow("Period"..ItemPeriodIndex.."_Text"):getUserString('String');
	local ItemKind	= tonumber(select_window:getUserString("ItemKind"))
	
	local ExpireTime	= ShopCommon_String_Unlimited	-- 영구
	if Expire ~= 0 then
		ExpireTime		= tostring(Expire)..ShopCommon_String_Day
	end		
	local PointString	= string.format(String, tonumber(Point - saleValue))
	winMgr:getWindow('CommonAlphaPage'):setVisible(false)
	winMgr:getWindow('NCS_PeriodSelectImage'):setVisible(false)
	
	ShowRealPurchaseWindow(item_number, item_file_name, item_Name, PointString, Type_Purchase, ItemKind)
	saleValue = 0	
	DebugStr('OnClickOneBuyOkButton end');
end


-- 취소버튼
function OnClickOneBuyCancelButton()
	winMgr:getWindow('CommonAlphaPage'):setVisible(false)
	winMgr:getWindow('NCS_PeriodSelectImage'):setVisible(false)
	if winMgr:getWindow('NCS_CouponSelectImage') then
		winMgr:getWindow('NCS_CouponSelectImage'):setVisible(false)
	end
	ToC_SetSelectDiscountIndex(-1)
	saleValue = 0
end







--------------------------------------------------------------------

-- 착용하기 확인창

--------------------------------------------------------------------
--------------------------------------------------------------------
-- 바로 착용 확인창 알파.
--------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'NCS_WearConfirmAlphaImage');
mywindow:setTexture('Enabled', 'UIData/OnDLGBackImage.tga', 0, 0);
mywindow:setTexture('Disabled', 'UIData/OnDLGBackImage.tga', 0, 0);
mywindow:setPosition(0,0);
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("DefaultWindow"):addChildWindow(mywindow);


RegistEscEventInfo("NCS_WearConfirmAlphaImage", "OnShopDirectlyWearCancel")
RegistEnterEventInfo("NCS_WearConfirmAlphaImage", "OnShopDirectlyWearOk")


--------------------------------------------------------------------
-- 바로 착용 확인창 뒷판.
--------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticImage', 'NCS_WearConfirmImage');
mywindow:setTexture('Enabled', 'UIData/popup001.tga', 0, 0);
mywindow:setTexture('Disabled', 'UIData/popup001.tga', 0, 0);
mywindow:setWideType(6)
mywindow:setPosition((1024 - 340) / 2, (768 - 268) / 2);
mywindow:setSize(340, 268);
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:setUserString("okFunction", "")
mywindow:setUserString("noFunction", "")
winMgr:getWindow('NCS_WearConfirmAlphaImage'):addChildWindow(mywindow);

--------------------------------------------------------------------
-- 바로 착용 텍스트
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "NCS_WearConfirmText");
mywindow:setVisible(true);
mywindow:setEnabled(false)
mywindow:setPosition(3, 45);
mywindow:setSize(340, 180);
mywindow:clearTextExtends();
mywindow:setViewTextMode(1);
mywindow:setAlign(7);
mywindow:setLineSpacing(2);
winMgr:getWindow('NCS_WearConfirmImage'):addChildWindow(mywindow);


--------------------------------------------------------------------
-- 버튼 (확인, 취소)
--------------------------------------------------------------------
ButtonName	= {['protecterr']=0, "NCS_WearOKButton", "NCS_WearCancelButton"}
ButtonTexX	= {['protecterr']=0,		693,			858}
ButtonPosX	= {['protecterr']=0,		4,				169}		
ButtonEvent	= {['protecterr']=0, "OnShopDirectlyWearOk", "OnShopDirectlyWearCancel"}

for i=1, #ButtonName do
	mywindow = winMgr:createWindow("TaharezLook/Button", ButtonName[i])
	mywindow:setTexture("Normal", "UIData/popup001.tga", ButtonTexX[i], 849)
	mywindow:setTexture("Hover", "UIData/popup001.tga", ButtonTexX[i], 878)
	mywindow:setTexture("Pushed", "UIData/popup001.tga", ButtonTexX[i], 907)
	mywindow:setTexture("Disabled", "UIData/popup001.tga", ButtonTexX[i], 849)
	mywindow:setPosition(ButtonPosX[i], 235)
	mywindow:setSize(166, 29)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:subscribeEvent("Clicked", ButtonEvent[i])
	winMgr:getWindow('NCS_WearConfirmImage'):addChildWindow(mywindow)
end


-- 바로 착용
function ShowWearBox(itemName, itemNumber, itemIndex)
	local String	= string.format(PreCreateString_1140, itemName)		-- GetSStringInfo(LAN_LUA_WND_COMMON_SHOP_4)
	
	ButtonName	= {['protecterr']=0, "NCS_WearOKButton", "NCS_WearCancelButton"}
	ButtonEvent	= {['protecterr']=0, "OnShopDirectlyWearOk", "OnShopDirectlyWearCancel"}
	
	for i=1, #ButtonName do
		winMgr:getWindow(ButtonName[i]):subscribeEvent("Clicked", ButtonEvent[i])
	end
	
	winMgr:getWindow('NCS_WearConfirmImage'):setUserString("noFunction", "OnShopDirectlyWearCancel")
	winMgr:getWindow('NCS_WearConfirmImage'):setUserString("okFunction", "OnShopDirectlyWearOk")
	
	winMgr:getWindow('NCS_WearConfirmText'):clearTextExtends();
	winMgr:getWindow('NCS_WearConfirmText'):addTextExtends(String, g_STRING_FONT_DODUMCHE, 115,255,255,255,255,    2, 0,0,0,255);	

	root:addChildWindow(winMgr:getWindow('NCS_WearConfirmAlphaImage'));
	winMgr:getWindow('NCS_WearConfirmAlphaImage'):setVisible(true)
	
	
	WearItemNumber	= itemNumber
	WearItemIndex	= itemIndex
end

-- 바로 착용 확인 버튼
function OnShopDirectlyWearOk(args)
	local okfunc = winMgr:getWindow('NCS_WearConfirmImage'):getUserString("okFunction")
	if okfunc ~= "OnShopDirectlyWearOk" then
		return
	end
	winMgr:getWindow('NCS_WearConfirmImage'):setUserString("okFunction", "")
	winMgr:getWindow('NCS_WearConfirmAlphaImage'):setVisible(false)
	
	if Toc_PurchaseRestriction(WearItemNumber) == false then
		ShowCommonAlertOkBoxWithFunction(CommonShop_String_PURCHASE_SKILL_FAIL, 'OnClickAlertOkSelfHide');
		return
	end
	ToC_ClickedWearButton(WearItemNumber, WearItemIndex)		-- 착용한다고 보내준다.
	ToC_GetMyCharacterInfo()
end


-- 바로 착용 취소 버튼
function OnShopDirectlyWearCancel(args)
	local nofunc = winMgr:getWindow('NCS_WearConfirmImage'):getUserString("noFunction")
	if nofunc ~= "OnShopDirectlyWearCancel" then
		return
	end
	winMgr:getWindow('NCS_WearConfirmImage'):setUserString("noFunction", "")
	winMgr:getWindow('NCS_WearConfirmAlphaImage'):setVisible(false)
	ToC_GetMyCharacterInfo()
end





RegistEscEventInfo("p_presentAlpha", "OnClickPresentCancelButton")
RegistEnterEventInfo("p_presentAlpha", "OnClickPresentOkButton")

--==================================================================
-- Present Popup
--==================================================================
--------------------------------------------------------------------
-- Present Popup Alpha Image.
--------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticImage', "p_presentAlpha");
mywindow:setTexture('Enabled', 'UIData/OnDLGBackImage.tga', 0, 0);
mywindow:setTexture('Disabled', 'UIData/OnDLGBackImage.tga', 0, 0);
mywindow:setPosition(0, 0);
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow);


--------------------------------------------------------------------
-- Present Popup Main Window
--------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticImage', "p_presentMain")
mywindow:setTexture('Enabled', 'UIData/skillshop002.tga', 685, 574)
mywindow:setTexture("Disabled", "UIData/skillshop002.tga", 685, 574)
mywindow:setPosition((g_MAIN_WIN_SIZEX - 339) / 2, (g_MAIN_WIN_SIZEY - 450) / 2)
mywindow:setSize(339, 450)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow('p_presentAlpha'):addChildWindow(mywindow)


--------------------------------------------------------------------
-- Receive Character Check
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Editbox", "p_SendNameEditbox")
mywindow:setPosition(95, 47)
mywindow:setSize(144, 20)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setAlphaWithChild(0)
mywindow:setUseEventController(false)
CEGUI.toEditbox(mywindow):setMaxTextLength(12)
winMgr:getWindow('p_presentMain'):addChildWindow(mywindow)


--------------------------------------------------------------------
-- Send Message EditBox
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Editbox", "p_SendMessageEditbox")
mywindow:setPosition(14, 104)
mywindow:setSize(304, 20)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setAlphaWithChild(0)
mywindow:setUseEventController(false)
CEGUI.toEditbox(mywindow):setMaxTextLength(190)
winMgr:getWindow('p_presentMain'):addChildWindow(mywindow)



--------------------------------------------
-- Character Check, FriendList Button
--------------------------------------------
pButtonName		= {['protecterr']=0, "p_CheckButton", "p_ShowFriendListButton" }
pButtonPosY		= {['protecterr']=0,		47,					67}
pButtonTexX		= {['protecterr']=0,		531,				608}
pButtonEvent	= {['protecterr']=0, "p_CheckButtonEvent", "p_ShowFriendListButtonEvent" }

for i=1, #pButtonName do
	mywindow = winMgr:createWindow("TaharezLook/Button", pButtonName[i])
	mywindow:setTexture("Normal", "UIData/skillshop002.tga", pButtonTexX[i], 574)
	mywindow:setTexture("Hover", "UIData/skillshop002.tga", pButtonTexX[i], 592)
	mywindow:setTexture("Pushed", "UIData/skillshop002.tga", pButtonTexX[i], 610)
	mywindow:setTexture("Disabled", "UIData/skillshop002.tga", pButtonTexX[i], 628)
	mywindow:setPosition(250, pButtonPosY[i])
	mywindow:setSize(77, 18)
	mywindow:subscribeEvent("Clicked", pButtonEvent[i])
	winMgr:getWindow('p_presentMain'):addChildWindow(mywindow)
end


--------------------------------------------------------------------
-- Receive Button, Cancel Button
--------------------------------------------------------------------
tPButtonName	= {['protecterr']=0, "NCS_PresentOkButton", "NCS_PresentCancelButton"}
tPButtonTexX	= {['protecterr']=0,		693,			858}
tPButtonPosX	= {['protecterr']=0,		4,				169}
tPButtonEvent	= {['protecterr']=0, "OnClickPresentOkButton", "OnClickPresentCancelButton"}

for i=1, #tPButtonName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tPButtonName[i])
	mywindow:setTexture("Normal", "UIData/popup001.tga", tPButtonTexX[i], 849)
	mywindow:setTexture("Hover", "UIData/popup001.tga", tPButtonTexX[i], 878)
	mywindow:setTexture("Pushed", "UIData/popup001.tga", tPButtonTexX[i], 907)
	mywindow:setTexture("Disabled", "UIData/popup001.tga", tPButtonTexX[i], 849)
	mywindow:setPosition(tPButtonPosX[i], 417)
	mywindow:setSize(166, 29)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:subscribeEvent("Clicked", tPButtonEvent[i])
	winMgr:getWindow('p_presentMain'):addChildWindow(mywindow)
end


--------------------------------------------------------------------
-- Present FriendList Main
--------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticImage', "p_FriendListMain")
mywindow:setTexture('Enabled', 'UIData/skillshop002.tga', 540, 754)
mywindow:setTexture("Disabled", "UIData/skillshop002.tga", 540, 754)
mywindow:setPosition(680, 225)
mywindow:setSize(145, 274)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:setSubscribeEvent("MouseWheel", 'FriendListWheelEvent');
winMgr:getWindow('p_presentAlpha'):addChildWindow(mywindow)


LIST_MAX	= 11


for i = 0, LIST_MAX do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", "p_FriendListButton"..i)
	mywindow:setTexture("Normal", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Hover", "UIData/skillshop002.tga", 401, 992)
	mywindow:setTexture("Pushed", "UIData/skillshop002.tga", 401, 1008)
	mywindow:setTexture("SelectedNormal", "UIData/skillshop002.tga", 401, 1008)
	mywindow:setTexture("SelectedHover", "UIData/skillshop002.tga", 401, 1008)
	mywindow:setTexture("SelectedPushed", "UIData/skillshop002.tga", 401, 1008)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(3, 31 + i * 19)
	mywindow:setSize(139, 16)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("buttonIndex", tostring(i))
	mywindow:subscribeEvent("SelectStateChanged", "p_FriendListClick")
	winMgr:getWindow('p_FriendListMain'):addChildWindow(mywindow)
--[[	
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "p_FriendListLevelText"..i)
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setText("WWWWWWWWWWW"..i)
	mywindow:setSize(139, 16)
	mywindow:setPosition(4, 32 + i * 18)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow('p_FriendListMain'):addChildWindow(mywindow)
--]]	
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "p_FriendListText"..i)
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setText("WWWWWWWWWWW"..i)
	mywindow:setSize(139, 16)
	mywindow:setPosition(5, 32 + i * 19)
	mywindow:setUserString("Name", "")
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow('p_FriendListMain'):addChildWindow(mywindow)

end

mywindow = winMgr:createWindow("TaharezLook/Button", "p_FriendListCloseButton")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setPosition(121, 1)
mywindow:setSize(23, 23)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "FriendListCloseButtonEvent")
winMgr:getWindow('p_FriendListMain'):addChildWindow(mywindow)


--[[
mywindow = winMgr:createWindow("TaharezLook/Button", "p_FriendListOKButton")
mywindow:setTexture("Normal", "UIData/skillshop002.tga", 546, 647)
mywindow:setTexture("Hover", "UIData/skillshop002.tga", 546, 672)
mywindow:setTexture("Pushed", "UIData/skillshop002.tga", 546, 697)
mywindow:setTexture("Disabled", "UIData/skillshop002.tga", 546, 722)
mywindow:setPosition(2, 242)
mywindow:setSize(139, 25)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
mywindow:subscribeEvent("Clicked", "p_FriendListOKClick")
winMgr:getWindow('p_FriendListMain'):addChildWindow(mywindow)
--]]

--------------------------------------------------------------------
-- Present Name Check
--------------------------------------------------------------------
function p_CheckButtonEvent(args)
	local Name = winMgr:getWindow("p_SendNameEditbox"):getText()
	if Name == nil then
		-- 사용할 수 없는 아이디.
		return
	end	
	ToC_CheckNameforPresent(Name)
end


--------------------------------------------------------------------
-- Show FriendListButton
--------------------------------------------------------------------
function p_ShowFriendListButtonEvent(args)
	winMgr:getWindow("p_FriendListMain"):setVisible(true)
	
	for i = 0, LIST_MAX do
		local Name	= ToC_GetFriendListToIndex(i, true)
		local Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, Name)
		winMgr:getWindow('p_FriendListText'..i):setPosition(70 - (Size / 2), 32 + i * 19)
		
		winMgr:getWindow('p_FriendListText'..i):setText(Name)	
		winMgr:getWindow('p_FriendListText'..i):setUserString("Name", Name)
		CEGUI.toRadioButton(winMgr:getWindow('p_FriendListButton'..i)):setSelected(false)
		winMgr:getWindow('p_FriendListButton'..i):setEnabled(true)
		if Name == "" then
			winMgr:getWindow('p_FriendListButton'..i):setEnabled(false)				
		end				
	end	
end


--------------------------------------------------------------------
-- Present OkButton Event
--------------------------------------------------------------------
function OnClickPresentOkButton(args)
	local select_window = NCS_Selected_Window
	
	local item_Name		  = select_window:getUserString('ItemName');
	local item_number	  = tonumber( select_window:getUserString('ItemNumber') );
	local item_file_name  = select_window:getUserString("ItemNameFile");
	local itemLevel		  = tonumber(select_window:getUserString("Level"))
	local ItemKind		  = tonumber(select_window:getUserString("ItemKind"))
	local ItemPeriodIndex = tonumber(winMgr:getWindow("NCS_PeriodSelectText"):getUserString('SelectPeriod'))
	
	-- 기간을 선택해주세요
	if ItemPeriodIndex == 1 then
		ShowCommonAlertOkBoxWithFunction(Shop_String_19, 'OnClickAlertOkSelfHide');
		return
	end
	
	-- 돈이 모자란다.
	if EnoughBuyItem == 1 then
		ShowCommonAlertOkBoxWithFunction(ShopCommon_NotEnough_Gran, 'OnClickAlertOkSelfHide');
		return
	elseif EnoughBuyItem == 2 then
		ShowCommonAlertOkBoxWithFunction(ShopCommon_NotEnough_Cash, 'OnClickAlertOkSelfHide');
		return
	end
	
	-- 레벨이 낮다.	
--	local _my_name, _money, _level, _promotion, _my_style, _type, _sp_point, _hp_point, _experience = GetMyInfo(false);
--	if itemLevel > _level then
--		ShowCommonAlertOkBoxWithFunction(CommonShop_String_NOT_LEVEL, 'OnClickAlertOkSelfHide');
--		return
--	end
	
	local Name = winMgr:getWindow("p_SendNameEditbox"):getText()
	if Name == nil or Name == "" then
		ShowCommonAlertOkBoxWithFunction(PreCreateString_2194, 'OnClickAlertOkSelfHide');		-- GetSStringInfo(LAN_INPUT_FIGHTERNAME_GIFT)
		return
	end	
	
	
	local Point		= tonumber(winMgr:getWindow("Period"..ItemPeriodIndex.."_Text"):getUserString('Money'))
	local PayType	= tonumber(winMgr:getWindow("Period"..ItemPeriodIndex.."_Text"):getUserString('PayType'))
	local Expire	= tonumber(winMgr:getWindow("Period"..ItemPeriodIndex.."_Text"):getUserString('productExpire'))
	local String	= winMgr:getWindow("Period"..ItemPeriodIndex.."_Text"):getUserString('String');
	if PayType == TYPE_GRAN then
		ShowCommonAlertOkBoxWithFunction(PreCreateString_2195, 'OnClickAlertOkSelfHide');		-- GetSStringInfo(LAN_CAN_NOT_PRESENT_SELL_GRAN)
		return
	end
	-- 기간(스트링)
	local ExpireTime	= ShopCommon_String_Unlimited	-- 영구
	if Expire ~= 0 then
		ExpireTime	= tostring(Expire)..ShopCommon_String_Day
	end		

	-- 가격(스트링)	
--	local String	= ""
--	if PayType == TYPE_GRAN then
--		String = ExpireTime.." / "..tostring(Point).." "..ShopCommon_String_GRAN
--	elseif PayType == TYPE_CASH then
--		String = ExpireTime.." / "..tostring(Point).." "..ShopCommon_String_CASH
--	end
	local PointString	= string.format(String, tonumber(Point))
	ShowRealPurchaseWindow(item_number, item_file_name, item_Name, PointString, Type_Present, ItemKind)
	
	winMgr:getWindow("p_FriendListMain"):setVisible(false)
	winMgr:getWindow('p_presentAlpha'):setVisible(false)
end



--------------------------------------------------------------------
-- Present CancelButton Event
--------------------------------------------------------------------
function OnClickPresentCancelButton(args)


	winMgr:getWindow("p_FriendListMain"):setVisible(false)
	winMgr:getWindow('p_presentAlpha'):setVisible(false)
end




function p_FriendListClick(args)
	local local_window	= CEGUI.toWindowEventArgs(args).window
	if CEGUI.toRadioButton(local_window):isSelected() then
		local Index	= local_window:getUserString("buttonIndex")
		local Text	= winMgr:getWindow("p_FriendListText"..Index):getUserString("Name")
		winMgr:getWindow('p_SendNameEditbox'):setText(Text)
		winMgr:getWindow('p_FriendListMain'):setVisible(false)
		
	end
end


--[[
-- 친구목록 확인버튼
function p_FriendListOKClick(args)


end
--]]

-- 친구목록 휠 이벤트
function FriendListWheelEvent(args)
	local Delta = CEGUI.toMouseEventArgs(args).wheelChange
	local Check = ToC_CheckFriendListWheelEvent(Delta)	
	-- 휠을 이동할 수 없는 위치면	
	if Check == false then
		return
	end

	for i = 0, LIST_MAX do
		local Name	= ToC_GetFriendListToIndex(i, false)
		
		local Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, Name)
		winMgr:getWindow('p_FriendListText'..i):setPosition(70 - (Size / 2), 32 + i * 19)
		winMgr:getWindow('p_FriendListText'..i):setText(Name)	
		winMgr:getWindow('p_FriendListText'..i):setUserString("Name", Name)
		winMgr:getWindow('p_FriendListButton'..i):setEnabled(true)
		if Name == "" then
			winMgr:getWindow('p_FriendListText'..i):setUserString("Name", "")
			winMgr:getWindow('p_FriendListButton'..i):setEnabled(false)				
		end				
	end	

end


function FriendListCloseButtonEvent(args)
	winMgr:getWindow('p_FriendListMain'):setVisible(false)
end


function PeriodHideKind(kind)
	if kind == ITEMKIND_RESET_PLAY_RECORD or 
	   kind == ITEMKIND_CHANGE_CHARACTER_NAME or 
	   kind == ITEMKIND_CAPSULE or 
	   kind == ITEMKIND_ITEM_GENERATE then
	   
	   return true	   
	end	
	return false
end





--------------------------------------------------------------------
-- 콤보박스로 쓸 버튼
--------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/Button', 'NCS_CouponSelectButton')
mywindow:setTexture('Normal', 'UIData/Itemshop001.tga', 401, 788);
mywindow:setTexture('Hover', 'UIData/Itemshop001.tga', 421, 788);
mywindow:setTexture('Pushed', 'UIData/Itemshop001.tga', 441, 788);
mywindow:setTexture('PushedOff', 'UIData/Itemshop001.tga', 441, 788);
mywindow:setTexture("Disabled", "UIData/Itemshop001.tga", 441, 788)
mywindow:setPosition(292, 144)
mywindow:setSize(18, 17)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ItemCouponSelectBt")
winMgr:getWindow('NCS_ItemContainerImage'):addChildWindow(mywindow);


--------------------------------------------------------------------
-- 콤보박스로 쓸 버튼
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "NCS_CouponSelectText")
mywindow:setPosition(80, 146)
mywindow:setSize(211, 17)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:setViewTextMode(1)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)	
winMgr:getWindow('NCS_ItemContainerImage'):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "NCS_CouponSelectAlphaImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)		--빈공간
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(80, 144)
mywindow:setSize(207, 17)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("MouseClick", "ItemCouponSelectBt")
winMgr:getWindow('NCS_ItemContainerImage'):addChildWindow(mywindow)



--------------------------------------------------------------------
-- 기간 라디오버튼 넣어줄 투명이미지.
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "NCS_CouponSelectImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 700, 200)		--빈공간
mywindow:setTexture("Disabled", "UIData/invisible.tga", 700, 200)
mywindow:setPosition(87, 164)
mywindow:setSize(213, 20)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('NCS_PurchaceMiddleImage'):addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/StaticText", "NCS_PurchaseAfterCashSaleText")
mywindow:setPosition(192, 25)
mywindow:setSize(165, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(0)
mywindow:setLineSpacing(2)
mywindow:setZOrderingEnabled(true)	
mywindow:setEnabled(false)
winMgr:getWindow("NCS_BuyAfterBackImage"):addChildWindow(mywindow)




function ItemCouponSelectBt()
	bCouponSelectCheck = true
	
	local ItemPeriodIndex = tonumber(winMgr:getWindow("NCS_PeriodSelectText"):getUserString('SelectPeriod'))

	if ItemPeriodIndex == 1 then
		ShowNotifyOKMessage_Lua(Shop_String_19)		-- 기간을 선택해주세요
		return
	end
	if purchaseTypeIndex ~= TYPE_CASH then
		ShowNotifyOKMessage_Lua(PreCreateString_2705)		-- 기간을 선택해주세요
		return
	end
	
	if ToC_CheckDiscountCoupon() then	-- 쿠폰이 있다면
		local couponCount = ToC_GetDiscountCouponCount()
		if winMgr:getWindow('NCS_CouponSelectImage'):isVisible() then
			winMgr:getWindow('NCS_CouponSelectImage'):setVisible(false)
		else
			winMgr:getWindow('NCS_PurchaceMiddleImage'):addChildWindow(winMgr:getWindow('NCS_CouponSelectImage'))			
			winMgr:getWindow('NCS_CouponSelectImage'):setVisible(true)
			winMgr:getWindow('NCS_CouponSelectImage'):setSize(213, (couponCount + 1) * 17)
			for i=0, 10 do
				if winMgr:getWindow("NCS_CouponSelect_"..i) then
					winMgr:getWindow("NCS_CouponSelect_"..i):setVisible(false)						
				end
			end
			for i=0, couponCount do
				local couponName, disCountRate = ToC_GetDiscountCouponName(i-1)
				if winMgr:getWindow("NCS_CouponSelect_"..i) then
					winMgr:getWindow("NCS_CouponSelect_"..i):setVisible(true)
				else
					mywindow = winMgr:createWindow("TaharezLook/Button", "NCS_CouponSelect_"..i)
					mywindow:setTexture("Normal", "UIData/option.tga", 328, 418)
					mywindow:setTexture("Hover", "UIData/option.tga", 328, 438)
					mywindow:setTexture("Pushed", "UIData/option.tga", 328, 438)
					mywindow:setTexture("PushedOff", "UIData/option.tga", 328, 438)	
					mywindow:setPosition(0, i * 17)
					mywindow:setSize(213, 17)
					mywindow:setAlwaysOnTop(true)
					mywindow:setZOrderingEnabled(false)
					mywindow:setUserString("index", i)
					mywindow:subscribeEvent("Clicked", "CouponSelectBtnEvent")
					winMgr:getWindow('NCS_CouponSelectImage'):addChildWindow(mywindow)
					
					mywindow = winMgr:createWindow("TaharezLook/StaticText", "NCS_CouponSelectText_"..i)
					mywindow:setPosition(0, 2)
					mywindow:setSize(231, 15)
					mywindow:setViewTextMode(1)
					mywindow:setAlign(8)
					mywindow:setLineSpacing(2)
					mywindow:setEnabled(false)
					mywindow:setAlwaysOnTop(true)
					mywindow:setZOrderingEnabled(false)
					winMgr:getWindow("NCS_CouponSelect_"..i):addChildWindow(mywindow)			
				end
				winMgr:getWindow("NCS_CouponSelectText_"..i):setTextExtends(couponName, g_STRING_FONT_GULIMCHE, 12, 0,0,0, 255,   0, 0,0,0,255)
			end
		end
	else
		-- 보유중인 쿠폰이 없습니다.
		
	end
	
end

function CouponSelectBtnEvent(args)
	local local_window	= CEGUI.toWindowEventArgs(args).window
	local buttonIndex	= tonumber(local_window:getUserString("index"))
	
	winMgr:getWindow('NCS_CouponSelectImage'):setVisible(false)
	buttonIndex = buttonIndex - 1
	ToC_SetSelectDiscountIndex(buttonIndex)

	local couponName, disCountRate = ToC_GetDiscountCouponName(buttonIndex)
	
	local my_Cash	= GetMyCash();
	saleValue = purchasePrice * disCountRate / 100
	winMgr:getWindow("NCS_CouponSelectText"):setTextExtends(couponName, g_STRING_FONT_GULIMCHE, 12, 255,255,255, 255,   0, 0,0,0,255)
	if disCountRate > 0 then
		winMgr:getWindow("NCS_PurchaseAfterCashSaleText"):setVisible(true)
		winMgr:getWindow("NCS_PurchaseAfterCashSaleText"):setTextExtends("+Sale", g_STRING_FONT_GULIMCHE, 10, 255, 169, 83, 255,   0, 0,0,0,255)
		winMgr:getWindow("NCS_PurchaseAfterCashSaleText"):addTextExtends("\n  -"..tostring(saleValue).." "..ShopCommon_String_CASH, g_STRING_FONT_GULIMCHE, 10, 255, 20, 20, 255,   0, 0,0,0,255)
	else
		winMgr:getWindow("NCS_PurchaseAfterCashSaleText"):setVisible(false)
	end
	winMgr:getWindow('NCS_PurchaseAfterCashText'):setTextExtends(CommatoMoneyStr(tostring(my_Cash - purchasePrice + saleValue)), g_STRING_FONT_GULIMCHE, 12, 255,198,30, 255,   0, 0,0,0,255);
	
	if EnoughBuyItem == 2 then
		if (my_Cash - purchasePrice + saleValue) >= 0 then
			EnoughBuyItem = 0
		end
	end	
end

function ClearCouponSelectBtn(index, relationProductNo)
	ToC_SetSelectDiscountIndex(index)
	local couponName, disCountRate = ToC_GetDiscountCouponName(index)
	
	local bCheck = ToC_CheckUsableItemCoupon(relationProductNo, PRODUCT_SALE_50)
	if bCheck then
		winMgr:getWindow("NCS_CouponSelectText"):setTextExtends(PreCreateString_2730, g_STRING_FONT_GULIMCHE, 12, 255,10,10, 255,   0, 0,0,0,255)
	else
		winMgr:getWindow("NCS_CouponSelectText"):setTextExtends(couponName, g_STRING_FONT_GULIMCHE, 12, 255,255,255, 255,   0, 0,0,0,255)
	end	
	winMgr:getWindow("NCS_PurchaseAfterCashSaleText"):setVisible(false)
end



function SettingCouponSelectBtn(relationProductNo, index)
	local couponName, disCountRate = ToC_GetDiscountCouponName(index)
	
	local my_Cash	= GetMyCash();
	saleValue = purchasePrice * disCountRate / 100
	
	local bCheck = ToC_CheckUsableItemCoupon(relationProductNo, PRODUCT_SALE_50)
	if bCheck then
		winMgr:getWindow("NCS_CouponSelectText"):setTextExtends(PreCreateString_2730, g_STRING_FONT_GULIMCHE, 12, 255,10,10, 255,   0, 0,0,0,255)
	else
		winMgr:getWindow("NCS_CouponSelectText"):setTextExtends(couponName, g_STRING_FONT_GULIMCHE, 12, 255,255,255, 255,   0, 0,0,0,255)
	end
	
	if disCountRate > 0 then
		winMgr:getWindow("NCS_PurchaseAfterCashSaleText"):setVisible(true)
		winMgr:getWindow("NCS_PurchaseAfterCashSaleText"):setTextExtends("+Sale", g_STRING_FONT_GULIMCHE, 10, 255, 169, 83, 255,   0, 0,0,0,255)
		winMgr:getWindow("NCS_PurchaseAfterCashSaleText"):addTextExtends("\n  -"..tostring(saleValue).."Cash", g_STRING_FONT_GULIMCHE, 10, 255, 20, 20, 255,   0, 0,0,0,255)
	else
		winMgr:getWindow("NCS_PurchaseAfterCashSaleText"):setVisible(false)
	end
	winMgr:getWindow('NCS_PurchaseAfterCashText'):setTextExtends(CommatoMoneyStr(tostring(my_Cash- purchasePrice + saleValue)), g_STRING_FONT_GULIMCHE, 12, 255,198,30, 255,   0, 0,0,0,255);
	if EnoughBuyItem == 2 then
		if (my_Cash - purchasePrice + saleValue) >= 0 then
			EnoughBuyItem = 0
		end
	end
	return purchasePrice - saleValue
end



function CheckCouponUsable(bPrivateCoupon, bCouponUsableItem)
	if bPrivateCoupon then
		-- 쿠폰을 사용할 수 있는 아이템일때
		winMgr:getWindow("NCS_CouponSelectText"):setVisible(true)
		winMgr:getWindow("NCS_PurchaseAfterCashSaleText"):setVisible(true)
		winMgr:getWindow("NCS_PurchaseAfterCashSaleText"):setText("")
		winMgr:getWindow('NCS_CouponSelectButton'):setVisible(true)
		winMgr:getWindow('NCS_PurchaceMiddleImage'):setSize(340, 276 + 16)
		winMgr:getWindow('NCS_PurchaceBottomImage'):setPosition(0,317 + 16)
		
		winMgr:getWindow('NCS_ItemContainerImage'):setSize(321,168)
		winMgr:getWindow('NCS_ItemContainerImage'):setTexture('Enabled', 'UIData/option.tga', 703, 535)
		winMgr:getWindow('NCS_BuyBeforeBackImage'):setPosition(10,158 + 16)
		winMgr:getWindow('NCS_BuyAfterBackImage'):setPosition(10,216 + 16)
		if bCouponUsableItem then -- 사용할 수 없는 템
			winMgr:getWindow('NCS_CouponSelectAlphaImage'):setVisible(false)
			winMgr:getWindow('NCS_CouponSelectButton'):setEnabled(false)
			winMgr:getWindow("NCS_CouponSelectText"):setTextExtends(PreCreateString_2730, g_STRING_FONT_GULIMCHE, 12, 255,10,10, 255,   0, 0,0,0,255)
		else					-- 사용가능한 템
			winMgr:getWindow('NCS_CouponSelectAlphaImage'):setVisible(true)
			winMgr:getWindow('NCS_CouponSelectButton'):setEnabled(true)
			winMgr:getWindow("NCS_CouponSelectText"):setTextExtends(PreCreateString_2703, g_STRING_FONT_GULIMCHE, 12, 255,255,255, 255,   0, 0,0,0,255)
				
		end
	else
		-- 쿠폰을 사용할 수 없는 아이템일때.
		winMgr:getWindow("NCS_CouponSelectText"):setVisible(false)
		winMgr:getWindow("NCS_CouponSelectText"):setTextExtends(PreCreateString_2703, g_STRING_FONT_GULIMCHE, 12, 255,255,255, 255,   0, 0,0,0,255)
		winMgr:getWindow("NCS_PurchaseAfterCashSaleText"):setVisible(false)
		winMgr:getWindow('NCS_CouponSelectAlphaImage'):setVisible(false)
		winMgr:getWindow('NCS_CouponSelectButton'):setVisible(false)
		winMgr:getWindow('NCS_PurchaceMiddleImage'):setSize(340, 276)
		winMgr:getWindow('NCS_PurchaceBottomImage'):setPosition(0,317)
		
		winMgr:getWindow('NCS_ItemContainerImage'):setSize(323,150)
		winMgr:getWindow('NCS_ItemContainerImage'):setTexture('Enabled', 'UIData/option.tga', 0, 359)
		winMgr:getWindow('NCS_BuyBeforeBackImage'):setPosition(10,158)
		winMgr:getWindow('NCS_BuyAfterBackImage'):setPosition(10,216)
	end	
end



function periodSelectEvent(bSelect)
	
	


end



function CouponSelectVisible()
	if bCouponSelectCheck then
		bCouponSelectCheck = false
		return
	end
	if winMgr:getWindow('NCS_CouponSelectImage'):isVisible() then
		winMgr:getWindow('NCS_CouponSelectImage'):setVisible(false)	
	end
end	

function PeriodSelectVisible()
	if bPeriodSelectCheck then
		bPeriodSelectCheck = false
		return
	end
	if winMgr:getWindow('NCS_PeriodSelectImage'):isVisible() then
		winMgr:getWindow('NCS_PeriodSelectImage'):setVisible(false)	
	end
end	
