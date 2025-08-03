--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local schemeMgr = CEGUI.SchemeManager:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()

guiSystem:setGUISheet(root)
root:activate()

local MAX_ITEMLIST		= 5 -- 나의 목록 리스트 최대개수
local ITEMLIST_COSTUME	= 0
local ITEMLIST_ETC		= 1
local ITEMLIST_SPECIAL	= 2
local ITEMLIST_SKILL	= 3
local g_currenItemList	= GetCurrentMailItemMode()
local TempCount, TempName, TempFileName, TempFileName2, Tempperiod , TempSkillLevel
local TempAvatarTypeValue , TempAttach
local TempSlotIndex		= -1
local TempCoin			= 0
local TempGran			= 0
local TempCharge		= 0
local TempItemNumber	= 0
local itemAdded			= false
local MaxGran , MaxCoin

-- 현재 메일 아이템 목록 페이지
local g_curPage_ItemList = 1
local g_maxPage_ItemList = 1

local MAX_ITEMLIST = GetMaxMailItemListNum()	

local WINDOW_MYITEM_LIST = 0

g_tPresentPopupInfo = {['protecterr']=0, "", "", "", "", ""}	-- 파일이름, 아이템 이름, 아이템 종류, 저장 공간.

g_Attach	 = -1
g_AvatarType = -100

local Mail_String_Nick				    = PreCreateString_1196	--GetSStringInfo(LAN_LUA_WND_MYINFO_4)	-- 칭호
local Mail_String_Select_Item			= PreCreateString_1197	--GetSStringInfo(LAN_LUA_WND_MYINFO_5)	-- 아이템을 선택해주세요.
local Mail_String_PresentItemGetMsg		= PreCreateString_1821	--GetSStringInfo(LAN_LUA_WND_MYINFO_39)	--%s %s\n아이템을 받으시겠습니까?

g_MailCurrentPage	= 1;
g_MailMaxPage		= 1;
g_MaxMailNumToPage	= 9; 


----------------------------------------------------------------------
--우편함 백그라운드 윈도우 생성
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MailBackImage")
mywindow:setTexture("Enabled", "UIData/mail.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/mail.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);

mywindow:setPosition(0, 100);
mywindow:setSize(437, 549)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)
RegistEscEventInfo("MailBackImage", "CloseMail")

----------------------------------------------------------------------
--우편함 백그라운드 윈도우 생성
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Titlebar", "Mail_titlebar")
mywindow:setPosition(3, 1)
mywindow:setSize(410, 26)
winMgr:getWindow('MailBackImage'):addChildWindow(winMgr:getWindow('Mail_titlebar'))

----------------------------------------------------------------------
--메일 쓰기  
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MailWriteImage")
mywindow:setTexture("Enabled", "UIData/mail.tga", 0, 549)
mywindow:setTexture("Disabled", "UIData/mail.tga", 0, 549)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(50,300);
mywindow:setSize(437, 332)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/Titlebar", "Write_titlebar")
mywindow:setPosition(3, 1)
mywindow:setSize(410, 26)

winMgr:getWindow('MailWriteImage'):addChildWindow(winMgr:getWindow('Write_titlebar'))
RegistEscEventInfo("MailWriteImage", "OnClickWriteClose")


mywindow = winMgr:createWindow("TaharezLook/StaticImage", "WriteAlphaImage")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setEnabled(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)


----------------------------------------------------------------------
--첨부 물품 보내기시 나오는 팝업윈도우  
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MailAddReceiveImage")
mywindow:setTexture("Enabled", "UIData/deal.tga", 592, 0)
mywindow:setTexture("Disabled", "UIData/deal.tga", 592, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(450,50);
mywindow:setSize(296, 212)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)

----------------------------------------------------------------------
--첨부 물품 팝업윈도우에 붙는 이미지들 작업1
-----------------------------------------------------------------------
tMailAddReceive =
{ ["protecterr"]=0,  "AddZenImage", "AddCoinImage", "AddBackImage1", "AddBackImage2"}

tMailAddReceiveTextPosX	= {['err'] = 0,  949, 969, 561, 561}
tMailAddReceiveTextPosY	= {['err'] = 0,  96, 96, 210, 210}
tMailAddReceiveSizeX	= {['err'] = 0,  20, 20, 94, 94}
tMailAddReceiveSizeY	= {['err'] = 0,  20, 20, 21, 21}
tMailAddReceivePosX		= {['err'] = 0,  20, 160, 50, 190}


for i=1, #tMailAddReceive do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", tMailAddReceive[i])
	mywindow:setTexture("Enabled", "UIData/mail.tga", tMailAddReceiveTextPosX[i], tMailAddReceiveTextPosY[i])
	mywindow:setTexture("Disabled", "UIData/mail.tga", tMailAddReceiveTextPosX[i], tMailAddReceiveTextPosY[i])
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(tMailAddReceivePosX[i],110);
	mywindow:setSize(tMailAddReceiveSizeX[i], tMailAddReceiveSizeY[i])
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	winMgr:getWindow('MailAddReceiveImage'):addChildWindow(mywindow)
end


	-- 첨부내용 보기용 새창 백판
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MailAddNew_Back")
	mywindow:setTexture("Enabled", "UIData/deal.tga",			296,583 );
	mywindow:setTexture("Disabled", "UIData/deal.tga",			296,583);

	mywindow:setSize(290, 45);
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(5, 40)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow('MailAddReceiveImage'):addChildWindow(mywindow)
	
	-- 첨부내용 보기용 새창아이템 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MailAddNew_Image")
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(0, 5)
	mywindow:setSize(128, 128)
	mywindow:setScaleWidth(102)
	mywindow:setScaleHeight(102)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow('MailAddNew_Back'):addChildWindow(mywindow)
	
	
	-- 첨부내용 보기용 새창 아이템 이름
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "MailAddNew_Name")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,200,50,255)
	mywindow:setText("")
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 1)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow('MailAddNew_Back'):addChildWindow(mywindow)
	
	--첨부내용 보기용 새창  아이템 갯수
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "MailAddNew_Num")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(150,150,150,255)
	mywindow:setText("")
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 15)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow('MailAddNew_Back'):addChildWindow(mywindow)
	
	-- 첨부내용 보기용 새창 아이템 기간
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "MailAddNew_Period")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(150,150,150,255)
	mywindow:setText("")
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 30)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow('MailAddNew_Back'):addChildWindow(mywindow)
	
	--첨부내용 보기용 새창 코인, 그랑 텍스트 

	tMailAddText =   { ["protecterr"]=0, "MailCoinAddtext", "MailGranAddtext"}
	tMailAddPosX  =    { ["protecterr"]=0, 100, 100 }
	tMailAddPosY  =    { ["protecterr"]=0, 265, 285 }
	for i=1 , #tMailAddText do
		mywindow = winMgr:createWindow("TaharezLook/StaticText", tMailAddText[i])
		mywindow:setProperty("FrameEnabled", "false")
		mywindow:setProperty("BackgroundEnabled", "false")
		mywindow:setPosition(tMailAddPosX[i],tMailAddPosX[i])
		mywindow:setSize(150, 18)
		mywindow:setText("")
		mywindow:setZOrderingEnabled(false)	
		mywindow:setFont(g_STRING_FONT_GULIM, 12)
		mywindow:setTextColor(255, 255, 255, 255)
		mywindow:setVisible(true)
		winMgr:getWindow('MailAddReceiveImage'):addChildWindow( winMgr:getWindow(tMailAddText[i]) );
	end

----------------------------------------------------------------------
--첨부 물품 확인창 
-----------------------------------------------------------------------
tMailOkButtonName =
{ ["protecterr"]=0,"AddReceiveOkButton", "AddSendOkButton"}
tMailOkButtonTextPosX		= {['err'] = 0,  590, 590}
tMailOkButtonTextPosY		= {['err'] = 0,  684, 713, 742}
tMailOkButtonSizeX			= {['err'] = 0,  286, 286}
tMailOkButtonSizeY			= {['err'] = 0,  29, 29}

tMailOkButtonEvent			= {["err"]=0, "OnClickMailOkReceive", "OnClickMailOkSend"}
for i=1, #tMailOkButtonName do	
	mywindow = winMgr:createWindow("TaharezLook/Button",		tMailOkButtonName[i]);	
	mywindow:setTexture("Normal", "UIData/deal.tga",			tMailOkButtonTextPosX[i],tMailOkButtonTextPosY[1]);
	mywindow:setTexture("Hover", "UIData/deal.tga",				tMailOkButtonTextPosX[i], tMailOkButtonTextPosY[2]);
	mywindow:setTexture("Pushed", "UIData/deal.tga",			tMailOkButtonTextPosX[i], tMailOkButtonTextPosY[3]);
	mywindow:setTexture("PushedOff", "UIData/deal.tga",			tMailOkButtonTextPosX[i], tMailOkButtonTextPosY[3]);	
	mywindow:setTexture("SelectedNormal", "UIData/deal.tga",	tMailOkButtonTextPosX[i], tMailOkButtonTextPosY[3]);
	mywindow:setTexture("SelectedHover", "UIData/deal.tga",		tMailOkButtonTextPosX[i], tMailOkButtonTextPosY[3]);
	mywindow:setTexture("SelectedPushed", "UIData/deal.tga",	tMailOkButtonTextPosX[i], tMailOkButtonTextPosY[3]);
	mywindow:setTexture("SelectedPushedOff", "UIData/deal.tga",	tMailOkButtonTextPosX[i], tMailOkButtonTextPosY[3]);
	mywindow:setTexture("Disabled", "UIData/invisible.tga",			190, 706);
	mywindow:setSize(tMailOkButtonSizeX[i],tMailOkButtonSizeY[i]);	
	mywindow:setPosition(5,178);
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true);
	mywindow:subscribeEvent("Clicked", tMailOkButtonEvent[i])
end

winMgr:getWindow('MailAddReceiveImage'):addChildWindow( winMgr:getWindow(tMailOkButtonName[1]));


----------------------------------------------------------------------
--마이 리스트 ( 첨부 리스트)  
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MailItemImage")
mywindow:setTexture("Enabled", "UIData/deal.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/deal.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(550,280);
mywindow:setSize(296, 438)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/Titlebar", "Item_titlebar")
mywindow:setPosition(3, 1)
mywindow:setSize(270, 26)

winMgr:getWindow('MailItemImage'):addChildWindow(winMgr:getWindow('Item_titlebar'))

----------------------------------------------------------------------
--메일 실질적인 내용오는 에디트 박스 
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "MailEditBox");
mywindow:setPosition(40, 310);
mywindow:setSize(380, 143); 
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setUseEventController(true)
mywindow:setViewTextMode(1)
mywindow:setAlign(1)
mywindow:setVisible(true);
mywindow:setLineSpacing(7)
winMgr:getWindow('MailBackImage'):addChildWindow(mywindow)

----------------------------------------------------------------------
--메일 쓰기용 에디트 박스 
-----------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/MultiLineEditbox", "MailWriteEditBox");
mywindow:setProperty('ReadOnly', 'true');
mywindow:setTextColor(255,255,255, 255);  --색깔수정
mywindow:setFont(g_STRING_FONT_GULIM, 12);
mywindow:setPosition(15, 68);
mywindow:setSize(407, 163);
mywindow:setAlwaysOnTop(true)
mywindow:setVisible(false);

--------------------------------------------------------------------
--쓰기 에디트 박스 8개 생성
--------------------------------------------------------------------
tMailWriteBox =
{ ["protecterr"]=0, "MailWrite_1", "MailWrite_2", "MailWrite_3", "MailWrite_4", "MailWrite_5" ,"MailWrite_6","MailWrite_7"}

tMailEditEvent= 
{['protecterr'] = 0, "NextMailEdit2", "NextMailEdit3", "NextMailEdit4", "NextMailEdit5", "NextMailEdit6" ,"NextMailEdit7","NextMailEdit1"}

tMailWriteBoxPosX	= {['err'] = 0, 70,70,30,30,30,30,30,30}
tMailWriteBoxPosY	= {['err'] = 0, 48, 69,90,110,130,150,170,190}
tMailWriteSizeX     = {['err'] = 0, 280, 150,400,400,400,400,400,400}
tMailWriteSizeY     = {['err'] = 0, 23, 23,23,23,23,23,23,23}
tMailSetMatText     = {['err'] = 0, 40,12,160,160,160,160,170,170}
for i=1 , 7 do
	mywindow = winMgr:createWindow("TaharezLook/Editbox", tMailWriteBox[i])
	mywindow:setText("")
	mywindow:setPosition(tMailWriteBoxPosX[i], tMailWriteBoxPosY[i])
	mywindow:setAlphaWithChild(0)
	mywindow:setUseEventController(false)
	mywindow:setSize(tMailWriteSizeX[i], tMailWriteSizeY[i])
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 112)
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setZOrderingEnabled(false)
	mywindow:setEnabled(false)
	CEGUI.toEditbox(winMgr:getWindow(tMailWriteBox[i])):setMaxTextLength(tMailSetMatText[i])
	CEGUI.toEditbox(winMgr:getWindow(tMailWriteBox[i])):subscribeEvent("EditboxFull", "MailEditFull")
	CEGUI.toEditbox(winMgr:getWindow(tMailWriteBox[i])):subscribeEvent("TextAccepted", tMailEditEvent[i])
	CEGUI.toEditbox(winMgr:getWindow(tMailWriteBox[i])):subscribeEvent("TextAcceptedBack", "MailEditEventBack")
	winMgr:getWindow('MailWriteImage'):addChildWindow(mywindow)
end
    winMgr:getWindow("MailWrite_1"):setEnabled(true)
    winMgr:getWindow("MailWrite_1"):activate()
    winMgr:getWindow("MailWrite_2"):setEnabled(true)
    winMgr:getWindow("MailWrite_3"):setEnabled(true)

--탭이벤트    
for i=1 , 2 do
	CEGUI.toEditbox(winMgr:getWindow(tMailWriteBox[i])):subscribeEvent("TextAcceptedOnlyTab",tMailEditEvent[i])
end

for i=3 , 7 do
    CEGUI.toEditbox(winMgr:getWindow(tMailWriteBox[i])):subscribeEvent("TextAcceptedOnlyTab","NextMailEditFirst")
end
    
 --------------------------------------------------------------------
-- 숫자를 다 채우면 다음 박스로 이동시킨다.
--------------------------------------------------------------------
function MailEditFull(args)
	for i = 3, #tMailWriteBox do
		if winMgr:getWindow(tMailWriteBox[i]):isActive() then
		
			winMgr:getWindow(tMailWriteBox[i]):deactivate();
			winMgr:getWindow(tMailWriteBox[i]):setEnabled(false);
			
			if i==7 then
				winMgr:getWindow(tMailWriteBox[i]):activate();
				winMgr:getWindow(tMailWriteBox[i]):setEnabled(true);
				return;
			end
				
			winMgr:getWindow(tMailWriteBox[i + 1]):setEnabled(true);
			winMgr:getWindow(tMailWriteBox[i + 1]):activate();
			winMgr:getWindow(tMailWriteBox[i + 1]):setText("")
			return;
		end
	end
end   

function tMailTabEvent1(args)
  
end

function MailEditEventBack(args)

	for i = 4, #tMailWriteBox do
	    local Debugwritebox =winMgr:getWindow(tMailWriteBox[i]):getText()
		if winMgr:getWindow(tMailWriteBox[i]):isActive() and winMgr:getWindow(tMailWriteBox[i]):getText()==""  then	    
			winMgr:getWindow(tMailWriteBox[i]):setEnabled(false);
			winMgr:getWindow(tMailWriteBox[i-1]):setEnabled(true);
			winMgr:getWindow(tMailWriteBox[i-1]):activate();
			winMgr:getWindow(tMailWriteBox[i]):deactivate();
			return;
		end
	end
end   
    
function NextMailEdit2()
	winMgr:getWindow("MailWrite_2"):activate()
end

function NextMailEdit3()
	for i=1 , 5 do
	   if winMgr:getWindow(tMailWriteBox[8-i]):getText() ~= ""  then
	
			winMgr:getWindow(tMailWriteBox[8-i]):activate();
			return
	   end	   
	end
	winMgr:getWindow("MailWrite_3"):setText("")
	winMgr:getWindow("MailWrite_3"):activate()
end

function NextMailEdit4()
	winMgr:getWindow("MailWrite_3"):setEnabled(false);
	winMgr:getWindow("MailWrite_3"):deactivate();
	winMgr:getWindow("MailWrite_4"):setEnabled(true);
	winMgr:getWindow("MailWrite_4"):setText("")
	winMgr:getWindow("MailWrite_4"):activate()
end

function NextMailEdit5()
	winMgr:getWindow("MailWrite_4"):setEnabled(false);
	winMgr:getWindow("MailWrite_4"):deactivate();
	winMgr:getWindow("MailWrite_5"):setEnabled(true);
	winMgr:getWindow("MailWrite_5"):setText("")
	winMgr:getWindow("MailWrite_5"):activate()
end

function NextMailEdit6()
	winMgr:getWindow("MailWrite_5"):setEnabled(false);
	winMgr:getWindow("MailWrite_5"):deactivate();
	winMgr:getWindow("MailWrite_6"):setEnabled(true);
	winMgr:getWindow("MailWrite_6"):setText("")
	winMgr:getWindow("MailWrite_6"):activate()
end

function NextMailEdit7()
	winMgr:getWindow("MailWrite_6"):setEnabled(false);
	winMgr:getWindow("MailWrite_6"):deactivate();
	winMgr:getWindow("MailWrite_7"):setEnabled(true);
	winMgr:getWindow("MailWrite_7"):setText("")
	winMgr:getWindow("MailWrite_7"):activate()
end

function NextMailEdit1()
	winMgr:getWindow("MailWrite_7"):activate()
	winMgr:getWindow("MailWrite_7"):setEnabled(true);
end

function NextMailEditFirst()
	winMgr:getWindow("MailWrite_1"):activate()
	winMgr:getWindow("MailWrite_1"):setEnabled(true);
end

function RefreshMailEditBox()
	for i=1 , #tMailWriteBox do
		winMgr:getWindow(tMailWriteBox[i]):setEnabled(false)
	end
	winMgr:getWindow("MailWrite_1"):setEnabled(true)
    winMgr:getWindow("MailWrite_1"):activate()
    winMgr:getWindow("MailWrite_2"):setEnabled(true)
    winMgr:getWindow("MailWrite_3"):setEnabled(true)
end

--------------------------------------------------------------------
-- 메일쓰기창 (그랑 코인 첨부창으로부터 받아온 값 텍스트)
--------------------------------------------------------------------
Write_Gran_Coin_Text =	{ ["protecterr"]=0, "Write_Gran_Text", "Write_Coin_Text", "Write_Charge_Text"}
Write_Gran_Coin_PosX  =    { ["protecterr"]=0, 410, 410 , 410}
Write_Gran_Coin_PosY  =    { ["protecterr"]=0, 241, 265 , 280 }	
for i=1 , #Write_Gran_Coin_Text do
	mywindow = winMgr:createWindow("TaharezLook/StaticText", Write_Gran_Coin_Text[i])
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,200,50,255)
	mywindow:setText("")
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(Write_Gran_Coin_PosX[i], Write_Gran_Coin_PosY[i])
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("MailWriteImage"):addChildWindow(mywindow)

end

-----------------------------------------------------------------------
--우편함 라디오 박스    받은편지 , 보낸편지
-----------------------------------------------------------------------
tMailEventHandler	= {['err'] = 0, "OnSelected_Receive", "OnSelected_Send"}
tMailMenuRadio =
{ ["protecterr"]=0,	"Mail_Receive",  "Mail_Send"}
tMailMenuTextPosX	= {['err'] = 0, 733, 841}

for i=1, #tMailMenuRadio do	
	mywindow = winMgr:createWindow("TaharezLook/RadioButton",	tMailMenuRadio[i]);	
	mywindow:setTexture("Normal", "UIData/mail.tga",			tMailMenuTextPosX[i], 0);
	mywindow:setTexture("Hover", "UIData/mail.tga",			tMailMenuTextPosX[i], 29);
	mywindow:setTexture("Pushed", "UIData/mail.tga",			tMailMenuTextPosX[i], 58);
	mywindow:setTexture("PushedOff", "UIData/mail.tga",		tMailMenuTextPosX[i], 58);	
	mywindow:setTexture("SelectedNormal", "UIData/mail.tga",	tMailMenuTextPosX[i], 58);
	mywindow:setTexture("SelectedHover", "UIData/mail.tga",	tMailMenuTextPosX[i],58);
	mywindow:setTexture("SelectedPushed", "UIData/mail.tga",	tMailMenuTextPosX[i], 58);
	mywindow:setTexture("SelectedPushedOff", "UIData/mail.tga",tMailMenuTextPosX[i], 58);
	mywindow:setTexture("Disabled", "UIData/mail.tga",			tMailMenuTextPosX[i], 87);
	mywindow:setSize(108, 29);
	mywindow:setProperty("GroupID", 7777)
	mywindow:setPosition((i*111)-100,42);
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true);
	mywindow:setEnabled(true)
	mywindow:subscribeEvent("SelectStateChanged", tMailEventHandler[i]);
	winMgr:getWindow('MailBackImage'):addChildWindow( winMgr:getWindow(tMailMenuRadio[i]) );
end
   
 -----------------------------------------------------------------------
--메일 리스트 라디오 박스
-----------------------------------------------------------------------
 
tMailListRadio =
{ ["protecterr"]=0, "MailList_1", "MailList_2", "MailList_3", "MailList_4", "MailList_5"}



-- 라디오 버튼에 들어갈  메일 이름 , 보낸사람, 날짜

tMailInfoTextName	= {['err'] = 0, 'MailName', 'SendName', 'MailDay'}
tMailInfoTextPosX	= {['err'] = 0,100, 240, 350}
tMailInfoTextPosY	= {['err'] = 0, 6, 6, 6}
tMailInfoSizeX		= {['err'] = 0, 5, 5 , 5}
tMailInfoSizeY		= {['err'] = 0, 5, 5, 5}
tMailInfoTestText	= {['err'] = 0, "", "", ""}

for i=1, #tMailListRadio do	
	mywindow = winMgr:createWindow("TaharezLook/RadioButton",	tMailListRadio[i]);	
	mywindow:setTexture("Normal", "UIData/invisible.tga",			0, 881);
	mywindow:setTexture("Hover", "UIData/mail.tga",			0, 881);
	mywindow:setTexture("Pushed", "UIData/mail.tga",			0, 906);
	mywindow:setTexture("PushedOff", "UIData/mail.tga",		0, 906);	
	mywindow:setTexture("SelectedNormal", "UIData/mail.tga",	0,906);
	mywindow:setTexture("SelectedHover", "UIData/mail.tga",	0, 906);
	mywindow:setTexture("SelectedPushed", "UIData/mail.tga",	0, 906);
	mywindow:setTexture("SelectedPushedOff", "UIData/mail.tga",0, 906);
	mywindow:setTexture("Disabled", "UIData/invisible.tga",			190, 706);
	mywindow:setSize(416, 25);
	mywindow:setPosition(11, 78+(i-1)*30);
	mywindow:setVisible(true);
	mywindow:setUserString('Index', tostring(i))
	mywindow:setEnabled(true)
	mywindow:setProperty("GroupID", 6666)
    mywindow:subscribeEvent("SelectStateChanged", "OnSelectedMailList");
    
    mywindow:setUserString("MailIndex", tostring(-1));		--메일 첨부 아이템 인덱스
	mywindow:setUserString("MailKind", tostring(-1));		--메일 첨부 아이템 종류
	mywindow:setUserString("MailName", "");					--메일 첨부 아이템 이름
	mywindow:setUserString("MailDesc", "");					--메일 첨부 아이템 설명
	mywindow:setUserString("MailFileName", "");				--메일 첨부 아이템 텍스쳐 파일이름
	mywindow:setUserString("MailFileName2", "");			--메일 첨부 아이템 텍스쳐 파일이름
	mywindow:setUserString("MailDurationTime","");          --메일 첨부 아이템 남은기간
	mywindow:setUserString("MailUsecount",tostring(-1));    --메일 첨부 아이템개수
	mywindow:setUserString("MailSendingTime","");
	mywindow:setUserString("MailAddCoin",tostring(-1));
	mywindow:setUserString("MailAddGran",tostring(-1));
	mywindow:setUserString("MailMsg","");
	mywindow:setUserString("BoolReceive",tostring(-1));
	mywindow:setUserString("MailTitle","");
	mywindow:setUserString("MailSkill",tostring(-1));
	mywindow:setUserString("MailGUID",tostring(-1));        -- 랜덤스텟
	mywindow:setUserString("MailItemName1", "");	
	mywindow:setUserString("MailItemName2", "");	
	
	mywindow:setUserString("MailItemAttach", "");			-- 어태치	★
	mywindow:setUserString("MailItemAvatarType", "");		-- 아바타 타입 ★
	
	winMgr:getWindow('MailBackImage'):addChildWindow( winMgr:getWindow(tMailListRadio[i]) );
	
	
	for j=1, #tMailInfoTextName do
		local child_window = winMgr:createWindow("TaharezLook/StaticText", tMailListRadio[i]..tMailInfoTextName[j])	
		child_window:setProperty("FrameEnabled", "false")
		child_window:setProperty("BackgroundEnabled", "false")
		child_window:setSize(tMailInfoSizeX[j], tMailInfoSizeY[j])
		child_window:setVisible(true)
		child_window:setPosition(tMailInfoTextPosX[j], tMailInfoTextPosY[j])
		child_window:setEnabled(false)
--		child_window:setText("aaaa")
		child_window:setViewTextMode(1)
		child_window:setAlign(8)
		--child_window:setLineSpacing(1)
		mywindow:addChildWindow(child_window);
		--winMgr:registerCacheWindow(tMailButtonName[i]..tMailInfoTextName[j])
	end
	
	
end

tMailListAddImage =
{ ["protecterr"]=0, "tMailListAdd_1", "tMailListAdd_2", "tMailListAdd_3", "tMailListAdd_4", "tMailListAdd_5"}

for i=1, #tMailListAddImage do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", tMailListAddImage[i])
	mywindow:setTexture("Enabled", "UIData/mail.tga", 990, 96)
	mywindow:setTexture("Disabled", "UIData/mail.tga", 990, 96)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(395, 3)
	mywindow:setSize(20, 20)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setVisible(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(tMailListRadio[i]):addChildWindow(mywindow)
end

-----------------------------------------------------------------------
--마이 아이템  리스트 라디오 박스
-----------------------------------------------------------------------
tMailItemRadio =
{ ["protecterr"]=0, "MailItemList_1", "MailItemList_2", "MailItemList_3", "MailItemList_4", "MailItemList_5"}


tMailItemTextPosX	= {['err'] = 0,120, 250, 330}
tMailItemTextPosY	= {['err'] = 0, 5, 5, 5}
tMailItemSizeX		= {['err'] = 0, 5, 5, 5}
tMailItemSizeY		= {['err'] = 0, 5, 5, 5}


for i=1, #tMailItemRadio do	
	mywindow = winMgr:createWindow("TaharezLook/RadioButton",	tMailItemRadio[i]);	
	mywindow:setTexture("Normal", "UIData/deal.tga",			296,583 );
	mywindow:setTexture("Hover", "UIData/deal.tga",			296,583);
	mywindow:setTexture("Pushed", "UIData/deal.tga",			296,583);
	mywindow:setTexture("PushedOff", "UIData/deal.tga",		296,583);	
	mywindow:setTexture("SelectedNormal", "UIData/deal.tga",	296,583);
	mywindow:setTexture("SelectedHover", "UIData/deal.tga",	296,583);
	mywindow:setTexture("SelectedPushed", "UIData/deal.tga",	296,583);
	mywindow:setTexture("SelectedPushedOff", "UIData/deal.tga",296,583);
	mywindow:setTexture("Disabled", "UIData/invisible.tga",			0, 403);
	mywindow:setSize(282, 52);
	mywindow:setPosition(7, 65+(i-1)*55);
	mywindow:setVisible(true);
	mywindow:setUserString('Index', tostring(i))
	mywindow:setEnabled(true)
    mywindow:subscribeEvent("MouseButtonDown", "OnMailListMouseDown")
	winMgr:getWindow('MailItemImage'):addChildWindow( winMgr:getWindow(tMailItemRadio[i]) );
	
		
	-- 아이템 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MailItemList_Image_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(0, 0)
	mywindow:setSize(128, 128)
	mywindow:setScaleWidth(102)
	mywindow:setScaleHeight(102)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setLayered(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(tMailItemRadio[i]):addChildWindow(mywindow)
	
	
	-- 코스튬 아바타 관련 백 이미지 ★
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MailItemList_Back_Image_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(0, 0)
	mywindow:setSize(128, 128)
	mywindow:setScaleWidth(102)
	mywindow:setScaleHeight(102)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setLayered(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(tMailItemRadio[i]):addChildWindow(mywindow)
	
	-- 아이템 특수 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MailItemList_ImageType_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(0, 0)
	mywindow:setSize(128, 128)
	mywindow:setScaleWidth(102)
	mywindow:setScaleHeight(102)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setLayered(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(tMailItemRadio[i]):addChildWindow(mywindow)
	
	-- 스킬 레벨 테두리 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MailItemList_SkillLevelImage_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(25, 32)
	mywindow:setSize(29, 16)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(tMailItemRadio[i]):addChildWindow(mywindow)
	
	-- 스킬레벨 + 글자
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "MailItemList_SkillLevelText_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
	mywindow:setPosition(31, 32)
	mywindow:setSize(40, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("MailItemList_Image_"..i):addChildWindow(mywindow)
	
	-- 툴팁 이벤트를 위한 이미지
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MailItemList_EventImage_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(0, 0)
	mywindow:setSize(52, 52)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("Index", i)
	mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_MailItemListInfo")
	mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_MailVanishTooltip")
	winMgr:getWindow(tMailItemRadio[i]):addChildWindow(mywindow)
	
	
	-- 아이템 이름
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "MailItemList_Name_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,200,50,255)
	mywindow:setText("")
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 2)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(tMailItemRadio[i]):addChildWindow(mywindow)
	
	-- 아이템 갯수
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "MailItemList_Num_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(150,150,150,255)
	mywindow:setText("")
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 17)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(tMailItemRadio[i]):addChildWindow(mywindow)
	
	-- 아이템 기간
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "MailItemList_Period_"..i)
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(150,150,150,255)
	mywindow:setText("")
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 32)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(tMailItemRadio[i]):addChildWindow(mywindow)
	
	
	
	

end

-----------------------------------------------------------------------
--아이템 리스트 첨부 버튼 5개
-----------------------------------------------------------------------
 
tMailItemButton =
{ ["protecterr"]=0, "MailItemButton_1", "MailItemButton_2", "MailItemButton_3", "MailItemButton_4", "MailItemButton_5"}
 

for i=1, #tMailItemButton do	
	mywindow = winMgr:createWindow("TaharezLook/Button",	tMailItemButton[i]);	
	mywindow:setTexture("Normal", "UIData/deal.tga",			166,590);
	mywindow:setTexture("Hover", "UIData/deal.tga",				166, 608);
	mywindow:setTexture("Pushed", "UIData/deal.tga",			166, 626);
	mywindow:setTexture("PushedOff", "UIData/deal.tga",			166, 626);	
	mywindow:setTexture("SelectedNormal", "UIData/deal.tga",	166, 626);
	mywindow:setTexture("SelectedHover", "UIData/deal.tga",		166, 626);
	mywindow:setTexture("SelectedPushed", "UIData/deal.tga",	166, 626);
	mywindow:setTexture("SelectedPushedOff", "UIData/deal.tga",	166, 626);
	mywindow:setTexture("Disabled", "UIData/invisible.tga",		190, 706);
	mywindow:setSize(63,18 );	
	mywindow:setPosition(220,95+(i-1)*54);
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true);
	mywindow:setUserString('ListIndex', tostring(i));
	mywindow:setEnabled(true)
	mywindow:subscribeEvent("Clicked", "tMaiItemButtonEvent")
	winMgr:getWindow('MailItemImage'):addChildWindow( winMgr:getWindow(tMailItemButton[i]) );
end



 -----------------------------------------------------------------------
--편지 쓰기 , 전체 삭제 , 선택삭제  버튼
-----------------------------------------------------------------------
 
tMailButtonName =
{ ["protecterr"]=0, "Mail_Write", "Mail_Delete", "Mail_AllDelete"}
tMailButtonTextPosX	= {['err'] = 0, 437, 546, 655}
tMailButtonTextPosY	= {['err'] = 0, 403, 428 ,453, 478}

tMailButtonEvent = {["err"]=0, "OnClickMailWrite", "OnClickMailDelete", "OnClickMailAllDelete"}
for i=1, #tMailButtonName do	
	mywindow = winMgr:createWindow("TaharezLook/Button",	tMailButtonName[i]);	
	mywindow:setTexture("Normal", "UIData/mail.tga",		tMailButtonTextPosX[i],tMailButtonTextPosY[1]);
	mywindow:setTexture("Hover", "UIData/mail.tga",			tMailButtonTextPosX[i], tMailButtonTextPosY[2]);
	mywindow:setTexture("Pushed", "UIData/mail.tga",		tMailButtonTextPosX[i], tMailButtonTextPosY[3]);
	mywindow:setTexture("PushedOff", "UIData/mail.tga",		tMailButtonTextPosX[i], tMailButtonTextPosY[3]);	
	mywindow:setTexture("SelectedNormal", "UIData/mail.tga",tMailButtonTextPosX[i], tMailButtonTextPosY[3]);
	mywindow:setTexture("SelectedHover", "UIData/mail.tga",	tMailButtonTextPosX[i], tMailButtonTextPosY[3]);
	mywindow:setTexture("SelectedPushed", "UIData/mail.tga",tMailButtonTextPosX[i], tMailButtonTextPosY[3]);
	mywindow:setTexture("SelectedPushedOff", "UIData/mail.tga",tMailButtonTextPosX[i], tMailButtonTextPosY[3]);
	mywindow:setTexture("Disabled", "UIData/mail.tga",			tMailButtonTextPosX[i], tMailButtonTextPosY[4]);
	mywindow:setSize(97, 25);	
	mywindow:setPosition((97*i)-83,225);
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true);
	mywindow:setEnabled(true)
	mywindow:subscribeEvent("Clicked", tMailButtonEvent[i])
	winMgr:getWindow('MailBackImage'):addChildWindow( winMgr:getWindow(tMailButtonName[i]) );
end

if IsThaiLanguage() or IsEngLanguage() or IsGSPLanguage() then----0421KSG
	winMgr:getWindow("Mail_Write"):setEnabled(false)		
end
	
-----------------------------------------------------------------------
--첨부된 물품 받기  ,  보내기 버튼 
-----------------------------------------------------------------------

tMailADDName			= {["protecterr"]=0, "ADD_Receive", "ADD_Send"}
tMailADDButtonTextPosX	= {['err'] = 0, 0, 398 }
tMailADDButtonTextPosY	= {['err'] = 0, 931, 959, 987}
tMailADDButtonPosY		= {['err'] = 0, 505, 290 }
tMailADDButtonEvent		= {["err"]=0, "OnClickAddReceive", "OnClickAddSend"}
	
for i=1, #tMailADDName do
	mywindow = winMgr:createWindow("TaharezLook/Button",		tMailADDName[i]);	
	mywindow:setTexture("Normal", "UIData/mail.tga",			tMailADDButtonTextPosX[i], tMailADDButtonTextPosY[1]);
	mywindow:setTexture("Hover", "UIData/mail.tga",				tMailADDButtonTextPosX[i], tMailADDButtonTextPosY[2]);
	mywindow:setTexture("Pushed", "UIData/mail.tga",			tMailADDButtonTextPosX[i], tMailADDButtonTextPosY[3]);
	mywindow:setTexture("PushedOff", "UIData/mail.tga",			tMailADDButtonTextPosX[i], tMailADDButtonTextPosY[3]);	
	mywindow:setTexture("SelectedNormal", "UIData/mail.tga",	tMailADDButtonTextPosX[i], tMailADDButtonTextPosY[3]);
	mywindow:setTexture("SelectedHover", "UIData/mail.tga",		tMailADDButtonTextPosX[i], tMailADDButtonTextPosY[3]);
	mywindow:setTexture("SelectedPushed", "UIData/mail.tga",	tMailADDButtonTextPosX[i], tMailADDButtonTextPosY[3]);
	mywindow:setTexture("SelectedPushedOff", "UIData/mail.tga",	tMailADDButtonTextPosX[i], tMailADDButtonTextPosY[3]);
	mywindow:setTexture("Disabled", "UIData/invisible.tga",			190, 706);
	mywindow:setSize(398, 28);	
	mywindow:setPosition(19,tMailADDButtonPosY[i]);
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true);
	mywindow:setUserString('Index', tostring(i));
	mywindow:setEnabled(false)
	mywindow:subscribeEvent("Clicked", tMailADDButtonEvent[i])
end
    winMgr:getWindow('MailBackImage'):addChildWindow( winMgr:getWindow(tMailADDName[1]));
	winMgr:getWindow('MailWriteImage'):addChildWindow( winMgr:getWindow(tMailADDName[2]));
	winMgr:getWindow('ADD_Send'):setEnabled(true)

-----------------------------------------------------------------------
--코스튬 , 스킬 , 기타  , 스폐셜
-----------------------------------------------------------------------
 
tMailItemButtonName =
{ ["protecterr"]=0, "Item_Cos", "Item_Etc", "Item_Special", "Item_Skill"}
tMailItemButtonTextPosX	= {['err'] = 0, 0, 140, 210, 70}
tMailItemButtonTextPosY	= {['err'] = 0, 455, 476 ,497}
tMailItemButtonEvent = {["err"]=0, "Select_Item_Cos", "Select_Item_Etc","Select_Item_Special","Select_Item_Skill"}

for i=1, #tMailItemButtonName do	
	mywindow = winMgr:createWindow("TaharezLook/RadioButton",	tMailItemButtonName[i]);	
	mywindow:setTexture("Normal", "UIData/deal.tga",		tMailItemButtonTextPosX[i],tMailItemButtonTextPosY[1]);
	mywindow:setTexture("Hover", "UIData/deal.tga",			tMailItemButtonTextPosX[i], tMailItemButtonTextPosY[2]);
	mywindow:setTexture("Pushed", "UIData/deal.tga",		tMailItemButtonTextPosX[i], tMailItemButtonTextPosY[3]);
	mywindow:setTexture("PushedOff", "UIData/deal.tga",		tMailItemButtonTextPosX[i], tMailItemButtonTextPosY[3]);	
	mywindow:setTexture("SelectedNormal", "UIData/deal.tga",tMailItemButtonTextPosX[i], tMailItemButtonTextPosY[3]);
	mywindow:setTexture("SelectedHover", "UIData/deal.tga",	tMailItemButtonTextPosX[i], tMailItemButtonTextPosY[3]);
	mywindow:setTexture("SelectedPushed", "UIData/deal.tga",tMailItemButtonTextPosX[i], tMailItemButtonTextPosY[3]);
	mywindow:setTexture("SelectedPushedOff", "UIData/deal.tga",tMailItemButtonTextPosX[i], tMailItemButtonTextPosY[3]);
	mywindow:setTexture("Disabled", "UIData/invisible.tga",	190, 706);
	mywindow:setSize(70, 21);	
	mywindow:setPosition((72*i)-68,39);
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true);
	mywindow:setEnabled(true)
	mywindow:subscribeEvent("SelectStateChanged", tMailItemButtonEvent[i]);
	winMgr:getWindow('MailItemImage'):addChildWindow( winMgr:getWindow(tMailItemButtonName[i]) );
end


--winMgr:getWindow('Item_Skill'):setEnabled(false)

-----------------------------------------------------------------------
--ZEN첨부하기, COIN첨부하기
-----------------------------------------------------------------------
tMailAddButtonName = { ["protecterr"]=0, "Zen_Add", "Coin_Add"}
tMailAddButtonTextPosX	= {['err'] = 0, 733, 876}
tMailAddButtonTextPosY	= {['err'] = 0, 117, 146 ,175}

tMailAddButtonEvent = {["err"]=0, "OnClickZenAdd", "OnClickCoinAdd"}
for i=1, #tMailAddButtonName do	
	mywindow = winMgr:createWindow("TaharezLook/Button",	tMailAddButtonName[i]);	
	mywindow:setTexture("Normal", "UIData/mail.tga",		tMailAddButtonTextPosX[i], tMailAddButtonTextPosY[1]);
	mywindow:setTexture("Hover", "UIData/mail.tga",			tMailAddButtonTextPosX[i], tMailAddButtonTextPosY[2]);
	mywindow:setTexture("Pushed", "UIData/mail.tga",		tMailAddButtonTextPosX[i], tMailAddButtonTextPosY[3]);
	mywindow:setTexture("PushedOff", "UIData/mail.tga",		tMailAddButtonTextPosX[i], tMailAddButtonTextPosY[3]);	
	mywindow:setTexture("SelectedNormal", "UIData/mail.tga",tMailAddButtonTextPosX[i], tMailAddButtonTextPosY[3]);
	mywindow:setTexture("SelectedHover", "UIData/mail.tga",	tMailAddButtonTextPosX[i], tMailAddButtonTextPosY[3]);
	mywindow:setTexture("SelectedPushed", "UIData/mail.tga",tMailAddButtonTextPosX[i], tMailAddButtonTextPosY[3]);
	mywindow:setTexture("SelectedPushedOff", "UIData/mail.tga",tMailAddButtonTextPosX[i], tMailAddButtonTextPosY[3]);
	mywindow:setTexture("Disabled", "UIData/mail.tga",		tMailAddButtonTextPosX[i], tMailAddButtonTextPosY[3]);
	mywindow:setSize(143, 29);	
	mywindow:setPosition((143*i)-138,404);
	mywindow:setAlwaysOnTop(true)
	mywindow:setVisible(true);

	if  i == 2 then
		mywindow:setEnabled(true)
	end

	mywindow:subscribeEvent("Clicked", tMailAddButtonEvent[i])
	winMgr:getWindow('MailItemImage'):addChildWindow( winMgr:getWindow(tMailAddButtonName[i]) );
end

----편지쓰기 내용 현재라인찾기, 전체 삭제

Mail_Focus_Button	     = {["err"]=0, "Mail_Focus_Button_Delete", "Mail_Focus_Button_find" }
Mail_Focus_ButtonTexX   = {["err"]=0, 796, 858 }
Mail_Focus_ButtonPosX   = {["err"]=0, 290, 356 }
Mail_Focus_ButtonPosY   = {["err"]=0, 190, 190 }
Mail_Focus_Event = {["err"]=0, "DeleteEditboxEvent", "NextMailEdit3"}

for i=1, #Mail_Focus_Button do
	mywindow = winMgr:createWindow("TaharezLook/Button", Mail_Focus_Button[i])
	mywindow:setTexture("Normal", "UIData/mail.tga", Mail_Focus_ButtonTexX[i], 920)
	mywindow:setTexture("Hover", "UIData/mail.tga", Mail_Focus_ButtonTexX[i], 938)
	mywindow:setTexture("Pushed", "UIData/mail.tga", Mail_Focus_ButtonTexX[i], 956)
	mywindow:setTexture("PushedOff", "UIData/mail.tga", Mail_Focus_ButtonTexX[i], 974)
	mywindow:setPosition(Mail_Focus_ButtonPosX[i], Mail_Focus_ButtonPosY[i])
	mywindow:setSize(62, 18)
	mywindow:setSubscribeEvent("Clicked", Mail_Focus_Event[i])
	winMgr:getWindow('MailWriteImage'):addChildWindow(Mail_Focus_Button[i])
end

---------------------------------
-- 체크 박스 --------------------
---------------------------------
tMailListCheck =
{ ["protecterr"]=0, "MailCheck_1", "MailCheck_2", "MailCheck_3", "MailCheck_4", "MailCheck_5"}

for i=1, #tMailListCheck do
	mywindow = winMgr:createWindow("TaharezLook/Checkbox", tMailListCheck[i] )
	mywindow:setTexture("Normal", "UIData/mail.tga", 949, 1)
	mywindow:setTexture("Hover", "UIData/mail.tga", 949, 1)
	mywindow:setTexture("Pushed", "UIData/mail.tga", 966, 1)
	mywindow:setTexture("PushedOff", "UIData/mail.tga", 966, 1)
	
	mywindow:setTexture("SelectedNormal", "UIData/mail.tga", 966, 1)
	mywindow:setTexture("SelectedHover", "UIData/mail.tga", 966, 1)
	mywindow:setTexture("SelectedPushed", "UIData/mail.tga", 966, 1)
	mywindow:setTexture("SelectedPushedOff", "UIData/mail.tga", 966, 1)
	
	mywindow:setPosition(15, 84+(i-1)*30)
	mywindow:setSize(17, 17)
	mywindow:setVisible(true)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setProperty("Selected", "false")
	mywindow:subscribeEvent("CheckStateChanged", "MailListCheckBoxEvent")
	mywindow:setUserString("MailIndex", i);		-- 인덱스를 저장 시켜줌
	winMgr:getWindow('MailBackImage'):addChildWindow( mywindow);
	
end


-------------------------------------------------------------------------
--메일내용보기 텍스트 < 제목, 보낸사람 표시해주는 텍스트>
-----------------------------------------------------------------------
tMailInfoText =   { ["protecterr"]=0, "MailInfoTitle", "MailInfoName" ,"MailCointext", "MailGrantext"}
tMailInfoPosX  =    { ["protecterr"]=0, 100, 100 ,400 , 400}
tMailInfoPosY  =    { ["protecterr"]=0, 265, 285 ,472, 447}  -- 그랑 코인은 메일 선택시 위치 다시 정해주고 있음
for i=1 , #tMailInfoText do
	mywindow = winMgr:createWindow("TaharezLook/StaticText", tMailInfoText[i])
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(tMailInfoPosX[i],tMailInfoPosY[i])
	mywindow:setSize(150, 18)
	mywindow:setText("")
	mywindow:setZOrderingEnabled(false)	
	mywindow:setFont(g_STRING_FONT_GULIM, 12)
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setVisible(true)
	winMgr:getWindow('MailBackImage'):addChildWindow( winMgr:getWindow(tMailInfoText[i]) );
end


-------------------------------------------------------------------------
--메일내용보기 <이미지, 아이템정보표시> <437,539>
-----------------------------------------------------------------------


-- 내용 보기용 백판

	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MailAdd_Back")
	mywindow:setTexture("Enabled", "UIData/deal.tga",	296,583)
	mywindow:setTexture("Disabled", "UIData/deal.tga",	296,583)
	mywindow:setSize(276, 44);
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(23, 443)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow('MailBackImage'):addChildWindow(mywindow)
	
	-- 아이템 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MailAdd_Image")
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(0, 3)
	mywindow:setSize(128, 128)
	mywindow:setScaleWidth(102)
	mywindow:setScaleHeight(102)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setLayered(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow('MailAdd_Back'):addChildWindow(mywindow)
	
	-- 코스튬 아바타 관련 백 이미지 ★
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MailAdd_Image_Back")
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(0, 3)
	mywindow:setSize(128, 128)
	mywindow:setScaleWidth(102)
	mywindow:setScaleHeight(102)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setLayered(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow('MailAdd_Back'):addChildWindow(mywindow)
	
	-- 아이템 특수 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MailAdd_TypeImage")
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(0, 3)
	mywindow:setSize(128, 128)
	mywindow:setScaleWidth(102)
	mywindow:setScaleHeight(102)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setLayered(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow('MailAdd_Back'):addChildWindow(mywindow)
	
	-- 스킬 레벨 테두리 이미지
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MailAdd_SkillLevelImage")
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(25, 32)
	mywindow:setSize(29, 16)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow('MailAdd_Back'):addChildWindow(mywindow)
	
	-- 스킬레벨 + 글자
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "MailAdd_SkillLevelText")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
	mywindow:setPosition(31, 32)
	mywindow:setSize(40, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow('MailAdd_Back'):addChildWindow(mywindow)
	
	-- 툴팁 이벤트를 위한 이미지
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MailAddTool_Image")
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(0, 0)
	mywindow:setSize(52, 52)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("MailAddToolIndex", tostring(-1))
	mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_MailAddInfoTooltip")
	mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_MailAddVanishTooltip")
	winMgr:getWindow('MailAdd_Back'):addChildWindow(mywindow)
	
	
	-- 아이템 이름
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "MailAdd_Name")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255,200,50,255)
	mywindow:setText("")
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 1)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow('MailAdd_Back'):addChildWindow(mywindow)
	
	-- 아이템 갯수
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "MailAdd_Num")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(150,150,150,255)
	mywindow:setText("")
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 15)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow('MailAdd_Back'):addChildWindow(mywindow)
	
	-- 아이템 기간
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "MailAdd_Period")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(150,150,150,255)
	mywindow:setText("")
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setPosition(60, 30)
	mywindow:setSize(220, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow('MailAdd_Back'):addChildWindow(mywindow)




------------------------------------
--우편함 보이기
------------------------------------

function ShowMail()

	root:addChildWindow(winMgr:getWindow('MailBackImage'))
	winMgr:getWindow('MailBackImage'):setVisible(true);
	if CEGUI.toRadioButton( winMgr:getWindow('Mail_Receive') ):isSelected() == true then
		RefreshMailList()
	else
		winMgr:getWindow("Mail_Receive"):setProperty('Selected', 'True');
	end
	MailisVisible(true);
	
end

function CloseMail()
	local CurrentPosIndex = GetCurrentWndType()
	if CurrentPosIndex == WND_LUA_VILLAGE then
		VirtualImageSetVisible(false)
	end	
	winMgr:getWindow('MailBackImage'):setVisible(false);
	ResetMailInfo()	
	
	-- 메일 / 인벤토리 활성화 ★
	if CurrentWndType == WND_LUA_MYROOM then
		return
	end
	
	if CurrentWndType == WND_LUA_ITEMSHOP then
		return
	end

	SetShowToolTip(false)
	HideAnimationWindow()

	--winMgr:getWindow("MainBar_Bag"):setEnabled(true)
	--winMgr:getWindow("popup_mail_btn"):setEnabled(true)
end


------------------------------------
--받은 편지 버튼
------------------------------------
function OnSelected_Receive(args)
	--DebugStr('OnSelected_Receivestart');
	
	local local_window = CEGUI.toWindowEventArgs(args).window;
	if CEGUI.toRadioButton(local_window):isSelected() then
		local find_window = winMgr:getWindow('Mail_Receive');
		if find_window ~= nil then
			g_MailCurrentPage = 1
		    RefreshMailList()
			ResetMailInfo()
			winMgr:getWindow(tMailListRadio[1]):setProperty('Selected', 'false');
			RefreMailListRadio(args)
			RefreshCheckBox()
			
		end
		
	end	
end
------------------------------------
--보낸 편지 버튼
------------------------------------
function OnSelected_Send(args)
	--DebugStr('OnSelected_Sendstart');
	
	local local_window = CEGUI.toWindowEventArgs(args).window;
	
	if CEGUI.toRadioButton(local_window):isSelected() then
		local find_window = winMgr:getWindow('Mail_Send');
		if find_window ~= nil then
			 g_MailCurrentPage = 1
			 RefreshMailList()
			 ResetMailInfo()
			 winMgr:getWindow(tMailListRadio[1]):setProperty('Selected', 'false');
			 RefreMailListRadio(args)
			 RefreshCheckBox()
		end	
	end
		
end

------------------------------------
----------- 편지 쓰기 버튼-----------
------------------------------------
function OnClickMailWrite(args)
	-- 인벤토리 / 메일창 버튼 비활성화 ★
	winMgr:getWindow("MyInven_BackImage"):setVisible(false)
	--winMgr:getWindow("MainBar_Bag"):setEnabled(false)
	--winMgr:getWindow("popup_mail_btn"):setEnabled(false)
	
	--DebugStr('OnClickMailWrite start');
	
	winMgr:getWindow('WriteAlphaImage'):setVisible(true)
	root:addChildWindow( winMgr:getWindow('WriteAlphaImage'))
	RequestItemListToMail()
	winMgr:getWindow('MailBackImage'):setVisible(false)
	winMgr:getWindow('MailWriteImage'):setVisible(true)
	root:addChildWindow(winMgr:getWindow("MailItemImage"))
	winMgr:getWindow('MailItemImage'):setVisible(true);	
	winMgr:getWindow('MailWrite_1'):activate() 
  
	
	-- 메일쓰기창을 열면 클론 아바타의 비쥬얼 설정창을 강제로 닫아준다 ★
	-- # 외형 아바타를 메일로 전송할수 있기 떄문에.. 애초에 방지.
	--winMgr:getWindow("Costume_Visual_Root"):setVisible(false)
	--winMgr:getWindow("CostumeItemList"):setVisible(false)
end
------------------------------------
----------- 편지 삭제 버튼-----------
------------------------------------
function OnClickMailDelete(args)

	-- DebugStr('OnClickMailDelete start');
	 if CheckRemainMail() == false then
	  return;
	 end 
	 
	 local boolDelete = false
	 for i=1, 5 do
	 	 if CEGUI.toCheckbox(winMgr:getWindow(tMailListCheck[i])):isSelected() then
	 		boolDelete = true
	 	 end
	 end
	 if boolDelete == true then
		ShowCommonAlertOkCancelBoxWithFunction("", PreCreateString_2056,  'OnClickMailDeleteQuestOk', 'OnClickMailDeleteQuestCancel');
													--GetSStringInfo(LAN_LUA_MAIL_DELETE)
	 else 
	 return;
	 end
end
------------------------------------
----------- 편지 전체삭제 버튼-----------
------------------------------------
function OnClickMailAllDelete(args)
    DebugStr('OnClickMailAllDelete start');
    
    if CheckRemainMail() then
		ShowCommonAlertOkCancelBoxWithFunction("", PreCreateString_2057,  'OnClickAllMailDeleteQuestOk', 'OnClickAllMailDeleteQuestCancel');
													--GetSStringInfo(LAN_LUA_MAIL_ALLDELETE)																			
	end
end




------------------------------------
----------- 아이템 카운트 팝업호출 -----
------------------------------------
function tMaiItemButtonEvent(args)	

	--DebugStr('tMaiItemButtonEvent start');
	local index = CEGUI.toWindowEventArgs(args).window:getUserString("ListIndex")
	--DebugStr("첨부리스트index:"..index);
	index=index-1
	local bEnable , avatarType , attach = SelectMailItemToRegist(tonumber(index))
	
	-- 코스튬 아바타 관련 임시 저장 ★
	-- : 사용하는 루아함수 -> ClickedRegistInputAddItem()
	TempAvatarTypeValue = avatarType
	TempAttach			= attach
	
	if bEnable then
		ItemCountInputPopup(avatarType, attach)
	end
end

------------------------------------
----------- 첨부된 물품 받기 -------
------------------------------------

function OnClickAddReceive(args)

	--DebugStr('OnClickAddReceive start');
 	MailGetEvent();
   
end


------------------------------------
----------- 첨부물품 보내기  -------
------------------------------------
function OnClickAddSend(args)

	--DebugStr('OnClickAddSend start');
	
	TitleText= winMgr:getWindow("MailWrite_1"):getText()
	ReceiveText= winMgr:getWindow("MailWrite_2"):getText()
	MsgText1 = winMgr:getWindow("MailWrite_3"):getText()
	MsgText2 = winMgr:getWindow("MailWrite_4"):getText()
	MsgText3 = winMgr:getWindow("MailWrite_5"):getText()
	MsgText4 = winMgr:getWindow("MailWrite_6"):getText()
	MsgText5 = winMgr:getWindow("MailWrite_7"):getText()
	
	
	MsgText = MsgText1.."\\n"..MsgText2.."\\n"..MsgText3.."\\n"..MsgText4.."\\n"..MsgText5 --.."\\n"..MsgText6
	--DebugStr('MsgText:'..MsgText)
	if MsgText == "" then
		Send_Present(TitleText,ReceiveText, "hi")
	else
		Send_Present(TitleText,ReceiveText, MsgText)
	end
   
end
------------------------------------
-----------첨부물품 받기 확인-------현재사용안함
------------------------------------

function OnClickMailOkReceive(args)

	DebugStr('OnClickMailOkReceive start');
	
end
------------------------------------
-----------첨부물품 보내기 확인-----
------------------------------------
function OnClickMailOkSend(args)

	DebugStr('OnClickMailOkSend start');
	
end

function AddButtenEnable(AddEnable)

	if  AddEnable then
	  
		for i=1, #tMailItemButton do
			winMgr:getWindow(tMailItemButton[i]):setEnabled(true)
		end
	else
		for i=1, #tMailItemButton do
			winMgr:getWindow(tMailItemButton[i]):setEnabled(false)
		end
	end  
end


----------------------------------------------------------
----------체크박스 클릭 이벤트
----------------------------------------------------------

function MailListCheckBoxEvent(args)

	DebugStr('MailCheckBoxCliked');
	local MyWindow = CEGUI.toWindowEventArgs(args).window;
	local MailIndex	= MyWindow:getUserString("MailIndex");
	--DebugStr('MailIndex:'..MailIndex);

end
------------------------------------
--코스튬선택이벤트------------------
------------------------------------
function Select_Item_Cos(args)
	DebugStr('Select_Item_Cos start');
	
	local local_window = CEGUI.toWindowEventArgs(args).window;
	if CEGUI.toRadioButton(local_window):isSelected() then
		local find_window = winMgr:getWindow('Item_Cos');
		if find_window ~= nil then
			g_currenItemList = ITEMLIST_COSTUME
			ChangedMailItemList(g_currenItemList)
			
		end	
	end	
end

------------------------------------
--소비선택이벤트--------------------
------------------------------------
function Select_Item_Etc(args)
	DebugStr('Select_Item_Etc start');
	
	local local_window = CEGUI.toWindowEventArgs(args).window;
	if CEGUI.toRadioButton(local_window):isSelected() then
		local find_window = winMgr:getWindow('Item_Etc');
		if find_window ~= nil then
			g_currenItemList = ITEMLIST_ETC
			ChangedMailItemList(g_currenItemList)
		end	
	end	
end
------------------------------------
---강화선택이벤트-------------------
------------------------------------
function Select_Item_Special(args)
	DebugStr('Select_Item_Special start');
	
	local local_window = CEGUI.toWindowEventArgs(args).window;
	if CEGUI.toRadioButton(local_window):isSelected() then
		local find_window = winMgr:getWindow('Item_Special');
		if find_window ~= nil then
			g_currenItemList = ITEMLIST_SPECIAL
			ChangedMailItemList(g_currenItemList)
		end	
	end	
end
------------------------------------
---스킬선택이벤트-------------------
------------------------------------
function Select_Item_Skill(args)
	DebugStr('Select_Item_Skill start');
	
	local local_window = CEGUI.toWindowEventArgs(args).window;
	if CEGUI.toRadioButton(local_window):isSelected() then
		local find_window = winMgr:getWindow('Item_Skill');
		if find_window ~= nil then
			g_currenItemList = ITEMLIST_SKILL
			ChangedMailItemList(g_currenItemList)
		end	
	end	
end


------------------------------------
---페이지표시텍스트-----------------
------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "MailItemList_PageText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setPosition(110, 380)
mywindow:setSize(80, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:clearTextExtends()
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('MailItemImage'):addChildWindow(mywindow)

------------------------------------
---페이지앞뒤버튼-------------------
------------------------------------
local tMyMailItemList_BtnName  = {["err"]=0, [0]="MyMailItemList_LBtn", "MyMailItemList_RBtn"}
local tMyMailItemList_BtnTexX  = {["err"]=0, [0]= 987, 970}
local tMyMailItemList_BtnPosX  = {["err"]=0, [0]= 93, 192}
local tMyMailItemList_BtnEvent = {["err"]=0, [0]= "OnClickMailItemList_PrevPage", "OnClickMailItemList_NextPage"}
for i=0, #tMyMailItemList_BtnName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tMyMailItemList_BtnName[i])
	mywindow:setTexture("Normal", "UIData/myinfo.tga", tMyMailItemList_BtnTexX[i], 0)
	mywindow:setTexture("Hover", "UIData/myinfo.tga", tMyMailItemList_BtnTexX[i], 22)
	mywindow:setTexture("Pushed", "UIData/myinfo.tga", tMyMailItemList_BtnTexX[i], 44)
	mywindow:setTexture("PushedOff", "UIData/myinfo.tga", tMyMailItemList_BtnTexX[i], 0)
	mywindow:setPosition(tMyMailItemList_BtnPosX[i], 378)
	mywindow:setSize(17, 22)
	mywindow:setSubscribeEvent("Clicked", tMyMailItemList_BtnEvent[i])
	winMgr:getWindow('MailItemImage'):addChildWindow(mywindow)
end

------------------------------------
---이전페이지이벤트-------------------
------------------------------------
		 
function  OnClickMailItemList_PrevPage()
     RefreshCheckBox()
     DebugStr('OnClickMailItemList_PrevPage');
     DebugStr('g_curPage_ItemList이전:'..g_curPage_ItemList);
	if	g_curPage_ItemList > 1 then
			g_curPage_ItemList = g_curPage_ItemList - 1
			DebugStr('g_curPage_ItemList이후:'..g_curPage_ItemList);
			ChangedMailItemListCurrentPage(g_curPage_ItemList)
	end
	
end
------------------------------------
---다음페이지이벤트-----------------
------------------------------------
function OnClickMailItemList_NextPage()
    RefreshCheckBox()
	DebugStr('OnClickMailItemList_NextPage');
	  DebugStr('g_curPage_ItemList이전:'..g_curPage_ItemList);
	if	g_curPage_ItemList < g_maxPage_ItemList then
			g_curPage_ItemList = g_curPage_ItemList + 1
			DebugStr('g_curPage_ItemList이후:'..g_curPage_ItemList);
			ChangedMailItemListCurrentPage(g_curPage_ItemList)
	end
	
end

----------------------------------------------마이 아이템 리스트 창에 사용되는 그랑코인
------------------------------------
---그랑이미지-----------------------
------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MailItemList_GranImage")
mywindow:setTexture("Enabled", "UIData/Itemshop001.tga", 482, 788)
mywindow:setTexture("Disabled", "UIData/Itemshop001.tga", 482, 788)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(16, 350)
mywindow:setSize(18, 18)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('MailItemImage'):addChildWindow(mywindow)


------------------------------------
---코인이미지-----------------------
------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MailItemList_CoinImage")
mywindow:setTexture("Enabled", "UIData/mail.tga", 969, 96)
mywindow:setTexture("Disabled", "UIData/mail.tga", 969, 96)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(160, 350)
mywindow:setSize(20, 20)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('MailItemImage'):addChildWindow(mywindow)

------------------------------------
---현재그랑표시---------------------
------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "MailItemList_MyGran")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setPosition(44, 350)
mywindow:setSize(120, 20)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('MailItemImage'):addChildWindow(mywindow)


------------------------------------
---현재코인표시---------------------
------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "MailItemList_MyCoin")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setPosition(190, 350)
mywindow:setSize(120, 20)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('MailItemImage'):addChildWindow(mywindow)


------------------------------------
--그랑, 코인 첨부용 윈도우------------
------------------------------------

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Add_Gran_Coin")
mywindow:setTexture("Enabled", "UIData/mail.tga", 437, 0)
mywindow:setTexture("Disabled", "UIData/mail.tga", 437, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(450,50);
mywindow:setSize(296, 210)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)


--------그랑, 코인 첨부창에 사용될 스테틱 에디트박스


------------------------------------
---첨부현재그랑표시---------------------
------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "MailItemList_AddMyGran")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setPosition(45,138)
mywindow:setSize(145, 25)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('Add_Gran_Coin'):addChildWindow(mywindow)


------------------------------------
---첨부현재코인표시---------------------
------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "MailItemList_AddMyCoin")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setPosition(185, 141)
mywindow:setSize(120, 20)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('Add_Gran_Coin'):addChildWindow(mywindow)

------------------------------------
---첨부입력그랑,코인---------------------
------------------------------------

Add_Gran_Coin_EditBox =
{ ["protecterr"]=0, "AddGran_EditBox", "AddCoin_EditBox"}
ChangeCGEditBox       =
 { ["protecterr"]=0, "ChageCoin_EditBox", "ChageGran_EditBox"}

Add_Gran_Coin_PosX		= {['err'] = 0, 100, 100}
Add_Gran_Coin_PosY		= {['err'] = 0, 60, 92}
Add_Gran_Coin_SizeX     = {['err'] = 0, 130, 130}
Add_Gran_Coin_SizeY     = {['err'] = 0, 23, 23}
Add_Gran_Coin_MaXText   = {['err'] = 0, 6, 6}


for i=1 , #Add_Gran_Coin_EditBox do
	mywindow = winMgr:createWindow("TaharezLook/Editbox", Add_Gran_Coin_EditBox[i])
	mywindow:setText("")
	mywindow:setPosition(Add_Gran_Coin_PosX[i], Add_Gran_Coin_PosY[i])
	mywindow:setAlphaWithChild(0)
	mywindow:setUseEventController(false)
	mywindow:setSize(Add_Gran_Coin_SizeX[i], Add_Gran_Coin_SizeY[i])
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 112)
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setZOrderingEnabled(false)
	CEGUI.toEditbox(mywindow):setInputOnlyNumber()
	winMgr:getWindow(Add_Gran_Coin_EditBox[i]):setText("0")
	mywindow:subscribeEvent("TextAccepted", ChangeCGEditBox[i])
	mywindow:subscribeEvent("TextAcceptedOnlyTab", ChangeCGEditBox[i])
	CEGUI.toEditbox(winMgr:getWindow(Add_Gran_Coin_EditBox[i])):setMaxTextLength(Add_Gran_Coin_MaXText[i])
	winMgr:getWindow('Add_Gran_Coin'):addChildWindow(mywindow)
end
    winMgr:getWindow("AddGran_EditBox"):activate()


function ChageCoin_EditBox()
	winMgr:getWindow("AddCoin_EditBox"):activate()
end
  
function ChageGran_EditBox()
	winMgr:getWindow("AddGran_EditBox"):activate()
end

------------------------------------
---첨부확인취소 버튼----------------
------------------------------------
-- 등록 버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "Add_Gran_Coin_RegistBtn")
mywindow:setTexture("Normal", "UIData/deal.tga", 590, 568)
mywindow:setTexture("Hover", "UIData/deal.tga", 590, 597)
mywindow:setTexture("Pushed", "UIData/deal.tga", 590, 626)
mywindow:setTexture("PushedOff", "UIData/deal.tga", 590, 568)
mywindow:setPosition(5, 175)
mywindow:setSize(143, 29)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "Add_Gran_Coin_Regist")
winMgr:getWindow("Add_Gran_Coin"):addChildWindow(mywindow)



-- 취소 버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "Add_Gran_Coin_CancelBtn")
mywindow:setTexture("Normal", "UIData/deal.tga", 733, 568)
mywindow:setTexture("Hover", "UIData/deal.tga", 733, 597)
mywindow:setTexture("Pushed", "UIData/deal.tga", 733, 626)
mywindow:setTexture("PushedOff", "UIData/deal.tga", 733, 568)
mywindow:setPosition(148, 175)
mywindow:setSize(143, 29)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "Add_Gran_Coin_Cancle")
winMgr:getWindow("Add_Gran_Coin"):addChildWindow(mywindow)



--Add_Gran_Coin_RegistBtn  호출이벤트  그랑,코인 첨부 등록 

function Add_Gran_Coin_Regist(args)	

	DebugStr('Add_Gran_Coin_Regist확인중');
	local AddGranCount = tonumber(winMgr:getWindow("AddGran_EditBox"):getText())
	local AddCoinCount = tonumber(winMgr:getWindow("AddCoin_EditBox"):getText())
	
	local bSuccess = RequestAddGranCoinRegist(AddGranCount,AddCoinCount, true)	
	
	if bSuccess  then
		TempCoin = AddCoinCount
		TempGran = AddGranCount
		local r,g,b = GetGranColor(AddGranCount)
		local granText = CommatoMoneyStr(AddGranCount)
		textSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, granText)
		winMgr:getWindow("Write_Gran_Text"):setText(granText);
		winMgr:getWindow("Write_Gran_Text"):setPosition(410-textSize, 217);
		winMgr:getWindow("Write_Gran_Text"):setTextColor(r,g,b,255)
		local coinText = CommatoMoneyStr(AddCoinCount)
		local textSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, coinText)
		winMgr:getWindow("Write_Coin_Text"):setText(coinText);
		winMgr:getWindow("Write_Coin_Text"):setPosition(410-textSize, 241)
		
		RequestMailCharge(TempSlotIndex , TempItemNumber ,TempCoin, TempGran)	
		
	else
		return
	end
	  
	winMgr:getWindow("Add_Gran_Coin"):setVisible(false)
end

--Add_Gran_Coin_CalcelBtn  호출이벤트   그랑,코인 첨부 취소
function Add_Gran_Coin_Cancle(args)	
	DebugStr('Add_Gran_Coin_Close확인중');
	winMgr:getWindow("Add_Gran_Coin"):setVisible(false)
	winMgr:getWindow("AddGran_EditBox"):setText("0")
	winMgr:getWindow("AddCoin_EditBox"):setText("0")
end




------------------------------------------------------------------------------

------------------------------------
----------- Zen 첨부하기 버튼 -----
------------------------------------
function OnClickZenAdd(args)	

	DebugStr('OnClickZenAdd start확인중');
	winMgr:getWindow("AddGran_EditBox"):activate()
	winMgr:getWindow("AddGran_EditBox"):setText("")
	winMgr:getWindow("AddCoin_EditBox"):deactivate()
	root:addChildWindow(winMgr:getWindow("Add_Gran_Coin"))
	winMgr:getWindow('Add_Gran_Coin'):setVisible(true);
end

------------------------------------
----------- Coin 첨부하기 버튼 -----
------------------------------------
function OnClickCoinAdd(args)	

	DebugStr('OnClickCoinAdd start확인중');
	winMgr:getWindow("AddCoin_EditBox"):activate()
	winMgr:getWindow("AddCoin_EditBox"):setText("")
	winMgr:getWindow("AddGran_EditBox"):deactivate()
	root:addChildWindow(winMgr:getWindow("Add_Gran_Coin"))
	winMgr:getWindow('Add_Gran_Coin'):setVisible(true);
end

------------------------------------
----------- 마우스 클릭시 메일 이름을 알아온다 -----
------------------------------------

function OnMailListMouseDown(args) --현재 사용안함
	DebugStr('OnMailListListClicked start');
end
------------------------------------
----------- 종료버튼 ---------------
------------------------------------

tCloseMailButtonName = {["err"]=0, "Mail_closeBtn","Write_closeBtn","Item_closeBtn"}
tCloseMailEvent= {["err"]=0, "OnClickMailClose", "OnClickWriteBtnClose", "OnClickItemClose"}
tCloseMailButtonNamePos	= {['err'] = 0,405 ,405,265}
for i=1, #tCloseMailButtonName do
   
	mywindow = winMgr:createWindow("TaharezLook/Button", tCloseMailButtonName[i]);	
	mywindow:setTexture("Normal",		"UIData/mainBG_Button002.tga",	354, 159)
	mywindow:setTexture("Hover",		"UIData/mainBG_Button002.tga",	354, 182)
	mywindow:setTexture("Pushed",		"UIData/mainBG_Button002.tga",	354, 159)
	mywindow:setTexture("PushedOff",	"UIData/mainBG_Button002.tga",	354, 159)
	mywindow:setTexture("Disabled",		"UIData/mainBG_Button002.tga",	354, 159)
	
	mywindow:setPosition(tCloseMailButtonNamePos[i], 5)
	mywindow:setSize(23, 23);
	mywindow:setVisible(true);
	mywindow:setZOrderingEnabled(false);
	mywindow:setAlwaysOnTop(true)
	mywindow:subscribeEvent("Clicked", tCloseMailEvent[i]);
	
end

    winMgr:getWindow('MailBackImage'):addChildWindow(winMgr:getWindow(tCloseMailButtonName[1]))
    winMgr:getWindow('MailWriteImage'):addChildWindow(winMgr:getWindow(tCloseMailButtonName[2]))
    --winMgr:getWindow('MailItemImage'):addChildWindow(winMgr:getWindow(tCloseMailButtonName[3]))

------------------------------------
----------- 종료함수 ---------------
------------------------------------   

--우체부 메인창 종료
function OnClickMailClose(args)
	local CurrentPosIndex = GetCurrentWndType()
	if CurrentPosIndex == WND_LUA_VILLAGE then
		VirtualImageSetVisible(false)
	end
	winMgr:getWindow('MailBackImage'):setVisible(false);
	MailisVisible(false);
	winMgr:getWindow('MailAddReceiveImage'):setVisible(false);
	ResetMailInfo()
	if CurrentPosIndex == WND_LUA_VILLAGE then
		TownNpcEscBtnClickEvent()
	end
end

--메일 쓰기창 종료
function OnClickWriteClose(args)
	local CurrentPosIndex = GetCurrentWndType()
	if CurrentPosIndex == WND_LUA_VILLAGE then
		VirtualImageSetVisible(false)
	end
	winMgr:getWindow('MailWriteImage'):setVisible(false);
	winMgr:getWindow('MailItemImage'):setVisible(false);
	RefreshMailEditBox()
	GranCoinReset()  -- 그랑 코인 빼준값 초기화
	WriteAddRegisterReset() -- 에디트 박스및 텍스트 초기화
	winMgr:getWindow("Add_Gran_Coin"):setVisible(false)
	ClickedAddtemCancel()  --아이템 첨부해준거 다시 취소
	ResetChargeGranCoin()  -- 수수료 계산용 그랑 코인 리셋
	winMgr:getWindow('WriteAlphaImage'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('WriteAlphaImage') );
	
	local CurrentWndType = GetCurrentWndType()
	
	if CurrentWndType == WND_LUA_MYROOM then
		return
	end
	
	if CurrentWndType == WND_LUA_ITEMSHOP then
		return
	end
	
	--winMgr:getWindow("MainBar_Bag"):setEnabled(true)
	--winMgr:getWindow("popup_mail_btn"):setEnabled(true)
end


function OnClickWriteBtnClose(args)
	local CurrentPosIndex = GetCurrentWndType()
	if CurrentPosIndex == WND_LUA_VILLAGE then
		VirtualImageSetVisible(false)
	end
	winMgr:getWindow('MailWriteImage'):setVisible(false);
	winMgr:getWindow('MailItemImage'):setVisible(false);
	RefreshMailEditBox()
	GranCoinReset()  -- 그랑 코인 빼준값 초기화
	WriteAddRegisterReset() -- 에디트 박스및 텍스트 초기화
	winMgr:getWindow("Add_Gran_Coin"):setVisible(false)
	ClickedAddtemCancel()  --아이템 첨부해준거 다시 취소
	ResetChargeGranCoin()  -- 수수료 계산용 그랑 코인 리셋
	winMgr:getWindow('WriteAlphaImage'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('WriteAlphaImage') );
	TownNpcEscBtnClickEvent()
	
	
	if CurrentWndType == WND_LUA_MYROOM then
		return
	end
	
	if CurrentWndType == WND_LUA_ITEMSHOP then
		return
	end
	
	--winMgr:getWindow("MainBar_Bag"):setEnabled(true)
	--winMgr:getWindow("popup_mail_btn"):setEnabled(true)

end

--아이템 리스트창 종료
function OnClickItemClose(args)
	winMgr:getWindow('MailItemImage'):setVisible(false);
end

--수수료 계산용 그랑 코인 리셋
function ResetChargeGranCoin()
	TempCoin = 0
	TempGran = 0
end
---------------------------------
--수수료 계산용 값
---------------------------------
function SetMailCharge(MailCharge)
	DebugStr('MailCharge:'..MailCharge)
	TempCharge = MailCharge
	local ChargeText = CommatoMoneyStr(TempCharge)
	textSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, ChargeText)
	if TempCharge == 0 then
		winMgr:getWindow("Write_Charge_Text"):setText("");
	else
		winMgr:getWindow("Write_Charge_Text"):setText(ChargeText);
	end
	winMgr:getWindow("Write_Charge_Text"):setPosition(410-textSize, 267);
	winMgr:getWindow("Write_Charge_Text"):setTextColor(255,255,100,255)
end

-------------------------------------------------------------------
-- 나의 아이템 리스트에 아이템 목록 설정
-------------------------------------------------------------------
-- 내아이템 목록 초기화

function ClearMailItemList()
	for i=1, MAX_ITEMLIST do
		winMgr:getWindow(tMailItemRadio[i]):setVisible(false)
		winMgr:getWindow(tMailItemButton[i]):setVisible(false)
	end
end

-- 현재 내아이템 목록에 존재하는 아이템만 설정
function SetupMailItemList(i, itemName, itemFileName, itemFileName2, itemUseCount, itemGrade, avatarType, attach)
  
    local j=i+1
	
	winMgr:getWindow(tMailItemRadio[j]):setVisible(true)
	winMgr:getWindow(tMailItemButton[j]):setVisible(true)

	-- 아이템 파일이름

	winMgr:getWindow("MailItemList_Image_"..j):setTexture("Disabled", itemFileName, 0, 0)
	winMgr:getWindow("MailItemList_Image_"..j):setScaleWidth(102)
	winMgr:getWindow("MailItemList_Image_"..j):setScaleHeight(102)
	winMgr:getWindow("MailItemList_Image_"..j):setLayered(false)
		
	if itemFileName2 == "" then
		winMgr:getWindow("MailItemList_Image_"..j):setLayered(false)
	else
		winMgr:getWindow("MailItemList_Image_"..j):setLayered(true)
		winMgr:getWindow("MailItemList_Image_"..j):setTexture("Layered", itemFileName2, 0, 0)
	end
	
	winMgr:getWindow("MailItemList_ImageType_"..j):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	
	if itemGrade > 0 then
		winMgr:getWindow("MailItemList_SkillLevelImage_"..j):setVisible(true)
		winMgr:getWindow("MailItemList_SkillLevelImage_"..j):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[itemGrade], 486)
		winMgr:getWindow( "MailItemList_SkillLevelText_"..j):setTextColor(tGradeTextColorTable[itemGrade][1], tGradeTextColorTable[itemGrade][2], tGradeTextColorTable[itemGrade][3], 255)
		winMgr:getWindow( "MailItemList_SkillLevelText_"..j):setText("+"..itemGrade)
		if IsKoreanLanguage() then
			winMgr:getWindow("MailItemList_ImageType_"..j):setTexture("Disabled", "UIData/ItemUIData/Insert/seal.tga", 0, 0)
		end
	else
		winMgr:getWindow("MailItemList_SkillLevelImage_"..j):setVisible(false)
		winMgr:getWindow("MailItemList_SkillLevelText_"..j):setText("")
	end
	
	-- 아이템 이름
	winMgr:getWindow("MailItemList_Name_"..j):setText(itemName)
	
	-- 아이템 갯수
	local countText = CommatoMoneyStr(itemUseCount)
	local szCount = PreCreateString_1526.." : "..countText
	winMgr:getWindow("MailItemList_Num_"..j):setText(szCount)
	
	-- 아이템 기간
	local period = PreCreateString_1207.." : "..PreCreateString_1056
	winMgr:getWindow("MailItemList_Period_"..j):setText(period)
	
	
	-- 코스튬 아바타 아이콘 등록 함수 ★
	SetAvatarIconS("MailItemList_Image_" , "MailItemList_Image_" , "MailItemList_Back_Image_" , j , avatarType , attach)
end


-- 내아이템 리스트 현재 페이지 / 최대 페이지
function MailItemListPage(curPage, maxPage)
	g_curPage_ItemList = curPage
	g_maxPage_ItemList = maxPage
	
	winMgr:getWindow("MailItemList_PageText"):setTextExtends(curPage.." / "..maxPage, g_STRING_FONT_GULIM, 14, 255,255,255,255,   0, 255,255,255,255)
end



-- 현재 나의 그랑을 보여준다.
function MailCurrentGran(myCurrentGran)
	
		winMgr:getWindow("MailItemList_MyGran"):setText(myCurrentGran)
		winMgr:getWindow("MailItemList_AddMyGran"):setText(myCurrentGran)
		MaxGran=myCurrentGran
	
end

-- 현재 나의 코인을 보여준다.
function MailCurrentCoin(myCurrentCoin)
	
		winMgr:getWindow("MailItemList_MyCoin"):setText(myCurrentCoin)
		winMgr:getWindow("MailItemList_AddMyCoin"):setText(myCurrentCoin)
		MaxCoin=myCurrentCoin
	
end


function OnMouseEnter_MailItemListInfo(args)
	-- 툴팁 띄워준다.
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local x, y = GetBasicRootPoint(EnterWindow)
	
	-- 현재 선택된 윈도우를 찾는다.
	local index = tonumber(EnterWindow:getUserString("Index"))
	index=index-1
	
	local itemKind, itemNumber = GetMailTooltipInfo(WINDOW_MYITEM_LIST, index)
	itemKind, itemNumber = SettingSpecialItemToolTip(itemKind, itemNumber)
	local Kind = -1
	if itemKind == ITEMKIND_COSTUM then
		Kind = KIND_COSTUM
	elseif itemKind == ITEMKIND_SKILL then
		Kind = KIND_SKILL
	elseif itemKind == ITEMKIND_HOTPICKS then
		Kind = KIND_ORB
	else
		Kind = KIND_ITEM
	end	
	
	--DebugStr("메일 인덱스 : " .. index)
	GetToolTipBaseInfo(x + 50, y, 2, Kind, -5, itemNumber)	-- 툴팁에 괜한 정보를 세팅해준다.
	SetShowToolTip(true)
end

-- 이미지에 마우스가 벗어나면 툴팁을 삭제한다.
function OnMouseLeave_MailVanishTooltip()
	SetShowToolTip(false)	
end



-- 받은 메일 보낸메일 클릭시 나오는 이미지 툴팁
function OnMouseEnter_MailAddInfoTooltip(args)
	DebugStr('OnMouseEnter_MailAddInfoTooltip()')
	-- 툴팁 띄워준다.
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local x, y = GetBasicRootPoint(EnterWindow)
	
	-- 현재 선택된 윈도우를 찾는다.
	local index = tonumber(EnterWindow:getUserString("MailAddToolIndex"))
	index=index-1
	
	local itemKind, itemNumber = GetAddTooltipInfo(index , g_MailCurrentPage)
	itemKind, itemNumber = SettingSpecialItemToolTip(itemKind, itemNumber)
	local Kind = -1
	if itemKind == ITEMKIND_COSTUM then
		Kind = KIND_COSTUM
	elseif itemKind == ITEMKIND_SKILL then
		Kind = KIND_SKILL
	elseif itemKind == ITEMKIND_HOTPICKS then
		Kind = KIND_ORB
	else
		Kind = KIND_ITEM
	end	
	
	-- 비쥬얼 아바타를 위해서 슬롯인덱스를 -5값을 줌
	-- 수정하시면 안되요~ ★
	GetToolTipBaseInfo(x + 50, y, 2, Kind, -5, itemNumber)	-- 툴팁에 괜한 정보를 세팅해준다.
	SetShowToolTip(true)
end

-- 이미지에 마우스가 벗어나면 툴팁을 삭제한다.
function OnMouseLeave_MailAddVanishTooltip()
	SetShowToolTip(false)	
end
-------------------------------------------------------------------
-- 메일 페이지 수를 계산한다
-------------------------------------------------------------------
function GetMailPage(PresentCount)
	DebugStr('PresentCount:'..PresentCount)
	g_MailMaxPage = (PresentCount - 1) / 5 + 1;
	if g_MailCurrentPage > g_MailMaxPage then
	   g_MailCurrentPage = g_MailMaxPage
	end
	
	if CEGUI.toRadioButton( winMgr:getWindow('Mail_Send') ):isSelected() == true then
		MailSetting(g_MailCurrentPage , 2)
		--DebugStr('보낸메일세팅')
	else
		MailSetting(g_MailCurrentPage , 1)
		--DebugStr('받은메일세팅')
	end
end

--------------------------------------------------------------------
-- 서버로부터 받아온 정보를 뿌려주기위해 저장.
--------------------------------------------------------------------
function SettingMailList(PosIndex, ItemIndex, FileName, FileName2, Desc, ItemNames, ItemKind, DurationTime, 
ItemKey, NameFrom, SkillPromotion, remaintime, sendingtime, addcoin, addgran,addTitle,addMsg, usecount , boolReceive , skillLevel, mailGuid, ItemName1, ItemName2, attach, avatarType)
	
	mywindow = winMgr:getWindow(tMailListRadio[PosIndex]);
	mywindow:setUserString("MailIndex",		tostring(ItemIndex));	--인벤토리 내 아이템 인덱스
	mywindow:setUserString("MailFileName",	FileName);				--이미지 파일 경로
	mywindow:setUserString("MailFileName2",	FileName2);				--이미지 파일 경로
	mywindow:setUserString("MailDesc",		Desc);					--아이템 설명
	mywindow:setUserString("MailName",		ItemNames);				--아이템 이름
	DebugStr("After ItemNames---> " .. ItemNames)

	mywindow:setUserString("MailKind",		tostring(ItemKind));	--아이템 종류	
	mywindow:setUserString("MailDurationTime",	tostring(DurationTime));--아이템 남은 기간.	
	mywindow:setUserString("MailKey",		tostring(ItemKey));		--아이템 고유 키값.	
	mywindow:setUserString("MailSendingTime", sendingtime);			-- 선물함에서 남은 시간.
	mywindow:setUserString("MailUsecount", usecount);				-- 사용가능 갯수
	mywindow:setUserString("MailAddCoin", addcoin);					-- 첨부된 코인
	mywindow:setUserString("MailAddGran", addgran);					-- 첨부된 그랑 
	mywindow:setUserString("MailMsg", addMsg);						--메일 내용
	mywindow:setUserString("BoolReceive", boolReceive);
	mywindow:setUserString("MailTitle", addTitle);
	mywindow:setUserString("MailSkill", skillLevel);
	mywindow:setUserString("MailGUID", mailGuid);
	mywindow:setUserString("MailItemName1", ItemName1);
	mywindow:setUserString("MailItemName2", ItemName2);
	mywindow:setUserString("MailItemAttach", attach);				-- 어태치★
	mywindow:setUserString("MailItemAvatarType", avatarType);		-- 아바타 타입★
	
	winMgr:getWindow(tMailListCheck[PosIndex]):setEnabled(true);
	local summaryTitle=SummaryString(g_STRING_FONT_GULIMCHE, 12, addTitle,120 )
	
	if boolReceive == 1 then   -- 읽은메일
	
		winMgr:getWindow(tMailListAddImage[PosIndex]):setVisible(false);
		winMgr:getWindow(tMailListRadio[PosIndex]..tMailInfoTextName[1]):addTextExtends(summaryTitle, g_STRING_FONT_GULIMCHE, 112, 150,150,150,255,   0, 100,100,100,255);
		winMgr:getWindow(tMailListRadio[PosIndex]..tMailInfoTextName[2]):addTextExtends(NameFrom, g_STRING_FONT_GULIMCHE, 112, 150,150,150,255,   0, 255,255,255,255);
		winMgr:getWindow(tMailListRadio[PosIndex]..tMailInfoTextName[3]):addTextExtends(sendingtime, g_STRING_FONT_GULIMCHE, 112, 150,150,150,255,   0, 30,30,30,255);
	
	    
	 
	elseif boolReceive == 0 then  -- 읽지않은 메일
		winMgr:getWindow(tMailListAddImage[PosIndex]):setVisible(true);
		local Mail_Coin_number	= tonumber(winMgr:getWindow(tMailListRadio[PosIndex]):getUserString("MailAddCoin"));
		local Mail_Gran_number	= tonumber(winMgr:getWindow(tMailListRadio[PosIndex]):getUserString("MailAddGran"));
		if ItemNames == "" then					 
				if Mail_Coin_number<1 and Mail_Gran_number<1 then
						winMgr:getWindow("ADD_Receive"):setVisible(false)
						winMgr:getWindow("ADD_Receive"):setEnabled(false)
						winMgr:getWindow(tMailListAddImage[PosIndex]):setVisible(false);
				end
		end
	  
		
		winMgr:getWindow(tMailListRadio[PosIndex]..tMailInfoTextName[1]):addTextExtends(summaryTitle, g_STRING_FONT_GULIMCHE, 112, 0,230,255,255,   0, 30,30,30,255);
		winMgr:getWindow(tMailListRadio[PosIndex]..tMailInfoTextName[2]):addTextExtends(NameFrom, g_STRING_FONT_GULIMCHE, 112, 0,230,255,255,   0, 30,30,30,255);
		winMgr:getWindow(tMailListRadio[PosIndex]..tMailInfoTextName[3]):addTextExtends(sendingtime, g_STRING_FONT_GULIMCHE, 112, 0,255,255,255,   0, 30,30,30,255);
		
	else  -- 보낸편지함
		winMgr:getWindow(tMailListAddImage[PosIndex]):setVisible(false);
		winMgr:getWindow(tMailListRadio[PosIndex]..tMailInfoTextName[1]):addTextExtends(summaryTitle, g_STRING_FONT_GULIMCHE, 112, 0,230,255,255,   0, 30,30,30,255);
		winMgr:getWindow(tMailListRadio[PosIndex]..tMailInfoTextName[2]):addTextExtends(NameFrom, g_STRING_FONT_GULIMCHE, 112, 0,230,255,255,   0, 30,30,30,255);
		winMgr:getWindow(tMailListRadio[PosIndex]..tMailInfoTextName[3]):addTextExtends(sendingtime, g_STRING_FONT_GULIMCHE, 112, 0,255,255,255,   0, 30,30,30,255);
	end
	
	winMgr:getWindow(tMailListRadio[PosIndex]..tMailInfoTextName[1]):setText(addTitle)
	winMgr:getWindow(tMailListRadio[PosIndex]..tMailInfoTextName[2]):setText(NameFrom)
	winMgr:getWindow(tMailListRadio[PosIndex]..tMailInfoTextName[3]):setText(DurationTime)
	
	--if CEGUI.toRadioButton( winMgr:getWindow('Mail_Send') ):isSelected() == true then    -- 보낸편지는 선물받기가 없음  
	--   winMgr:getWindow(tMailListAddImage[PosIndex]):setVisible(false);
	--end

end




--------------------------------------------------------------------
-- 우편함 페이지전환 버튼
--------------------------------------------------------------------
tMailPageButtonName  = { ["protecterr"]=0, "My_MailLeftButton", "My_MailRightButton"}
tMailPageButtonTexX  = { ["protecterr"]=0,	987,	970}
tMailPageButtonPosX  = { ["protecterr"]=0,	312,	406}
tMailPageButtonEvent = { ["protecterr"]=0,	"Mail_PrevBt", "Mail_NextBt"}
for i=1, #tMailPageButtonName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tMailPageButtonName[i])
	mywindow:setTexture("Normal", "UIData/myinfo.tga", tMailPageButtonTexX[i], 0)
	mywindow:setTexture("Hover", "UIData/myinfo.tga", tMailPageButtonTexX[i], 22)
	mywindow:setTexture("Pushed", "UIData/myinfo.tga", tMailPageButtonTexX[i], 44)
	mywindow:setTexture("PushedOff", "UIData/myinfo.tga", tMailPageButtonTexX[i], 44)
	mywindow:setPosition(tMailPageButtonPosX[i], 227)
	mywindow:setSize(17, 22)
	mywindow:setVisible(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:subscribeEvent("Clicked", tMailPageButtonEvent[i])
	winMgr:getWindow("MailBackImage"):addChildWindow(mywindow)
end






--------------------------------------------------------------------
-- 우편함 페이지 텍스트
--------------------------------------------------------------------
mywindow = winMgr:createWindow('TaharezLook/StaticText', 'My_MailPageText');
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setPosition(358, 230);
mywindow:setSize(20, 37);
mywindow:setZOrderingEnabled(true)
--mywindow:setText('text')
--mywindow:setVisible(true)	
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setAlwaysOnTop(true)
mywindow:setLineSpacing(2)
winMgr:getWindow("MailBackImage"):addChildWindow(mywindow)



--------------------------------------------------------------------
-- 우편함 페이지 전환버튼 이벤트
-- 우편함 왼쪽 버튼--------------------------------------------------------
function Mail_PrevBt()
	if g_MailCurrentPage == 1 then
		g_MailCurrentPage = 1;
	else
		g_MailCurrentPage = g_MailCurrentPage - 1;
		ResetMailListRadio()
		ResetMailListText()
		if CEGUI.toRadioButton( winMgr:getWindow('Mail_Send') ):isSelected() == true then
			MailSetting(g_MailCurrentPage , 2)
		else
			MailSetting(g_MailCurrentPage , 1)
		end
		
		g_SelectedPresentSlotNum = 0;
		winMgr:getWindow('My_MailPageText'):clearTextExtends();
		winMgr:getWindow('My_MailPageText'):addTextExtends(tostring(g_MailCurrentPage)..' / '..tostring(g_MailMaxPage),
																g_STRING_FONT_GULIMCHE, 15,    255,255,255,255,     0,     0,0,0,255);
		winMgr:getWindow(tMailListRadio[1]):setProperty('Selected', 'false');

		ResetMailInfo()
		RefreMailListRadio(args)
		RefreshCheckBox()
		
	end
end
--------------------------------------------------------------------
-- 우편함 오른쪽 버튼
function Mail_NextBt()
	if g_MailCurrentPage >= g_MailMaxPage then
		g_MailCurrentPage = g_MailMaxPage;
	else
		g_MailCurrentPage = g_MailCurrentPage + 1;
		ResetMailListRadio()
		ResetMailListText()

		if CEGUI.toRadioButton( winMgr:getWindow('Mail_Send') ):isSelected() == true then
			MailSetting(g_MailCurrentPage , 2)
		else
			MailSetting(g_MailCurrentPage , 1)
		end
		g_SelectedPresentSlotNum = 0;
		winMgr:getWindow('My_MailPageText'):clearTextExtends();
		winMgr:getWindow('My_MailPageText'):addTextExtends(tostring(g_MailCurrentPage)..' / '..tostring(g_MailMaxPage),
																g_STRING_FONT_GULIMCHE, 15,    255,255,255,255,     0,     0,0,0,255);
		
		winMgr:getWindow(tMailListRadio[1]):setProperty('Selected', 'false');
		ResetMailInfo()
		RefreMailListRadio(args)
		RefreshCheckBox()
	end
end



--------------------------------------------------------------------
-- 우편함 인벤설정 (현재는 페이지 텍스트 수정)
--------------------------------------------------------------------
function ShowMailInven()
	winMgr:getWindow('My_MailPageText'):clearTextExtends();
	winMgr:getWindow('My_MailPageText'):addTextExtends(tostring(g_MailCurrentPage)..' / '..tostring(g_MailMaxPage) , g_STRING_FONT_GULIMCHE, 15,    255,255,255,255,     0,     0,0,0,255);
end

------------------------------------
----------- 편지리스트 Refresh -----
------------------------------------
function RefreshMailList()
    DebugStr('RefreshMailList()');
    
	if CEGUI.toRadioButton( winMgr:getWindow('Mail_Send') ):isSelected() == true then
		MailSendListRequest();
    end
    if CEGUI.toRadioButton( winMgr:getWindow('Mail_Receive') ):isSelected() == true then
		MailListRequest();
    end
	RefreshCheckBox()
	MailisVisible(true)
	RefreMailListRadio(args)
	
end

--------------------------------------------------------------------
-- 라디오 버튼 리셋
--------------------------------------------------------------------

function ResetMailListRadio()
    DebugStr('ResetMailListRadio()호출');
	for i = 1, 5 do
		local local_window = winMgr:getWindow(tMailListRadio[i]);
		local_window:clearTextExtends();
		local_window:setText("");
		local_window:setUserString("MailIndex",		tostring(-1));	--인벤토리 내 아이템 인덱스
		local_window:setUserString("MailFileName",	"");			--이미지 파일 경로
		local_window:setUserString("MailFileName2",	"");			--이미지 파일 경로		
		local_window:setUserString("MailDesc",		"");			--아이템 설명
		local_window:setUserString("MailName",		"");			--아이템 이름
		local_window:setUserString("MailKind",		tostring(-1));	--아이템 종류	
		local_window:setUserString("MailDurationTime",	tostring(-1));	--아이템 남은 기간.	
		local_window:setUserString("MailKey",		tostring(-1));	--아이템 고유 키값.	
		local_window:setUserString("MailSkillPromotionName", "");	--스킬 이름.
		local_window:setUserString("MailRemainTime", "");			-- 선물함에서 남은 시간.
		local_window:setUserString("MailNameFrom", "");				-- 보낸 사람 이름.
		local_window:setUserString("MailSendingTime", "");			-- 선물함에서 남은 시간.
		local_window:setUserString("MailSkill", tostring(-1));		-- 선물함에서 남은 시간.
		local_window:setUserString("MailGUID", tostring(-1));	
		local_window:setProperty("Selected", "false")
	end
end	

--------------------------------------------------------------------
-- 체크 박스 리셋
--------------------------------------------------------------------
function RefreshCheckBox()

	for i=1, 5  do 
		winMgr:getWindow(tMailListCheck[i]):setProperty("Selected", "false")
	end
 
end
--------------------------------------------------------------------
-- 라디오 버튼 텍스트 리셋
--------------------------------------------------------------------

function ResetMailListText()
    --DebugStr('ResetMailListText()호출');
	for i = 1, 5 do
		winMgr:getWindow(tMailListRadio[i]..tMailInfoTextName[1]):clearTextExtends();
		winMgr:getWindow(tMailListRadio[i]..tMailInfoTextName[2]):clearTextExtends();
		winMgr:getWindow(tMailListRadio[i]..tMailInfoTextName[3]):clearTextExtends();
		winMgr:getWindow(tMailListRadio[i]..tMailInfoTextName[1]):setText("");
		winMgr:getWindow(tMailListRadio[i]..tMailInfoTextName[2]):setText("");
		winMgr:getWindow(tMailListRadio[i]..tMailInfoTextName[3]):setText("");			
	end
end	

function ResetWriteEditBox()

	for i =1, #tMailWriteBox do	
		winMgr:getWindow(tMailWriteBox[i]):setText("");
	end
	winMgr:getWindow("Write_Gran_Text"):setText("");
	winMgr:getWindow("Write_Coin_Text"):setText("");
	winMgr:getWindow("Write_Charge_Text"):setText("");
	winMgr:getWindow("AddGran_EditBox"):setText("0");
	winMgr:getWindow("AddCoin_EditBox"):setText("0");
	winMgr:getWindow('WriteAddCancelBtn'):setVisible(false)

end
--------------------------------------------------------------------
-- 메일리스트 라디오 버튼 텍스트 업데이트(보낸사람, 날짜 등)
--------------------------------------------------------------------


function MailListUpdate(args)

	DebugStr('MailListUpdate')

	for i = 1, 5 do
		local local_window = winMgr:getWindow(tMailListRadio[i]);
		local item_Name	= local_window:getUserString("itemName")
	
		if local_window:getUserString("itemName") ~= "" then
			local item_Used			 = local_window:getUserString('MailDurationTime');
			local item_FileName		 = local_window:getUserString("MailFileName");
			local item_Kind			 = tonumber(local_window:getUserString("MailKind"));
			local item_RemainTime	 = local_window:getUserString("MailRemainTime");
			local skillPromotionName = local_window:getUserString("MailSkillPromotionName");
			local Usecount			 = tonumber(local_window:getUserString("MailUsecount"))
			local item_Sender	 	 = local_window:getUserString("MailNameFrom");	
		end
	end
end


---------------------------------
-- 메일클릭시
---------------------------------
function OnSelectedMailList(args)	

	local local_window = CEGUI.toWindowEventArgs(args).window;
	
	if CEGUI.toRadioButton(local_window):isSelected() then
		local IndextCount=tonumber(local_window:getUserString('Index'))
		g_SelectedPresentSlotNum = IndextCount
		RealIndexCount = IndextCount + (g_MailCurrentPage * 5) - 5
		local win_name = local_window:getName();
		local Title_Name= winMgr:getWindow(win_name..'MailName'):getText()
		local Send_Name= winMgr:getWindow(win_name..'SendName'):getText()
		local PresentKey = local_window:getUserString("MailKey");
		local PresentKeyNumber = tonumber(PresentKey);
		local Mail_GUID	= tonumber(winMgr:getWindow(tMailListRadio[IndextCount]):getUserString("MailGUID"));
		local Mail_Type = 0
		if CEGUI.toRadioButton( winMgr:getWindow('Mail_Send') ):isSelected() == true then
			Mail_Type = 1
		end
		MailRandomItemRequest(Mail_GUID, PresentKeyNumber, Mail_Type)
		
	    if Send_Name ~= "" then
	            -- 저장된 UserString을 가져온다
				local Mail_FileName		= winMgr:getWindow(tMailListRadio[IndextCount]):getUserString("MailFileName");
				local Mail_FileName2	= winMgr:getWindow(tMailListRadio[IndextCount]):getUserString("MailFileName2");
				local Mail_itemName		= winMgr:getWindow(tMailListRadio[IndextCount]):getUserString("MailName");
				local Mail_CountNumber	= winMgr:getWindow(tMailListRadio[IndextCount]):getUserString("MailUsecount");
				local Mail_Period		= tonumber(winMgr:getWindow(tMailListRadio[IndextCount]):getUserString("MailDurationTime"));
				local Mail_Coin			= winMgr:getWindow(tMailListRadio[IndextCount]):getUserString("MailAddCoin");
				local Mail_Gran			= winMgr:getWindow(tMailListRadio[IndextCount]):getUserString("MailAddGran");
				local Mail_Msg          = winMgr:getWindow(tMailListRadio[IndextCount]):getUserString("MailMsg");
				local Mail_Key          = winMgr:getWindow(tMailListRadio[IndextCount]):getUserString("MailKey");
				local Bool_Receive = tonumber(winMgr:getWindow(tMailListRadio[IndextCount]):getUserString("BoolReceive"))
				local Mail_SkillLevel = tonumber(winMgr:getWindow(tMailListRadio[IndextCount]):getUserString("MailSkill"))
				local Mail_Coin_number	= tonumber(winMgr:getWindow(tMailListRadio[IndextCount]):getUserString("MailAddCoin"));
				local Mail_Gran_number	= tonumber(winMgr:getWindow(tMailListRadio[IndextCount]):getUserString("MailAddGran"));
				local Mail_Attach		= tonumber(winMgr:getWindow(tMailListRadio[IndextCount]):getUserString("MailItemAttach"));		-- ★
				local Mail_AvatarType	= tonumber(winMgr:getWindow(tMailListRadio[IndextCount]):getUserString("MailItemAvatarType"));	-- ★
				
			
				if Bool_Receive == 1 then  -- 메일을 읽었을때 ( 첨부를 받았을때)
				
				    winMgr:getWindow("ADD_Receive"):setVisible(false)
				    winMgr:getWindow("ADD_Receive"):setEnabled(false)
				    winMgr:getWindow("MailAdd_Image"):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
				    winMgr:getWindow("MailAdd_Name"):setText("")
					winMgr:getWindow("MailAdd_Period"):setText("")
					winMgr:getWindow("MailAdd_Num"):setText("")
					winMgr:getWindow(tMailInfoText[3]):setText("");
				    winMgr:getWindow(tMailInfoText[4]):setText("");
				    winMgr:getWindow("MailAdd_Image"):setLayered(false)
				    winMgr:getWindow("MailAdd_Image_Back"):setVisible(false)
				    winMgr:getWindow("MailAddTool_Image"):setEnabled(false)  -- 툴팁 기능 false
				    winMgr:getWindow("MailAddTool_Image"):setUserString("MailAddToolIndex",	tostring(-1))
				    winMgr:getWindow("MailAdd_SkillLevelImage"):setVisible(false)
				    winMgr:getWindow("MailAdd_SkillLevelText"):setText("")
					DebugStr("메일을 읽었을때 ( 첨부를 받았을때) BOOL RECEIVE : " .. Bool_Receive);
				else	-- 메일을 읽지않았을때
					
					--if Bool_Receive ==12 then   -- 보낸편지 일경우는 받기버튼을 표시하지 않는다
					--	winMgr:getWindow("ADD_Receive"):setVisible(false)
					--	winMgr:getWindow("ADD_Receive"):setEnabled(false) 
				    --else
					--	DebugStr("winMgr:getWindow(DD_Receive):setVisible(true) BOOL RECEIVE : " .. Bool_Receive);
						winMgr:getWindow("ADD_Receive"):setVisible(true)
						winMgr:getWindow("ADD_Receive"):setEnabled(true) 
				    --end
				    
				    ------------------------------------------
				    -----첨부 아이템 관련 정보를 뿌려준다-----
				    ------------------------------------------
				    --DebugStr('Mail_FileName:'..Mail_FileName)
				   -- DebugStr('Mail_FileName2:'..Mail_FileName2)
				    -- 아이템 이미지
					winMgr:getWindow("MailAdd_Image"):setTexture("Disabled", Mail_FileName, 0, 0)
					winMgr:getWindow("MailAdd_Image"):setLayered(false)
					
					if Mail_FileName2 == "" then
						winMgr:getWindow("MailAdd_Image"):setLayered(false)
					else
						--winMgr:getWindow("MailAdd_Image"):setLayered(true)
						winMgr:getWindow("MailAdd_Image"):setTexture("Layered", Mail_FileName2, 0, 0)
					end
					
					------------------------------------------
					-- 클론 아바타 아이콘 변경 ★
					------------------------------------------
					
					if Mail_AvatarType == -1 then
						
						SetAvatarIcon("MailAdd_Image" , "MailAdd_Image_Back" , Mail_AvatarType , Mail_Attach)
					else
						winMgr:getWindow("MailAdd_Image_Back"):setVisible(false)
					end
					
					
					winMgr:getWindow("MailAdd_Name"):setText(Mail_itemName)
					
					winMgr:getWindow("MailAddTool_Image"):setEnabled(true) 
					winMgr:getWindow("MailAddTool_Image"):setUserString("MailAddToolIndex",	tostring(IndextCount)); -- 툴팁 기능 true
					
					winMgr:getWindow("MailAdd_TypeImage"):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
					-- 스킬 일경우 레벨 표시
					if Mail_SkillLevel > 0 then
						winMgr:getWindow("MailAdd_SkillLevelImage"):setVisible(true)
						winMgr:getWindow("MailAdd_SkillLevelImage"):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[Mail_SkillLevel], 486)
						winMgr:getWindow("MailAdd_SkillLevelText"):setTextColor(tGradeTextColorTable[Mail_SkillLevel][1], tGradeTextColorTable[Mail_SkillLevel][2], tGradeTextColorTable[Mail_SkillLevel][3], 255)
						winMgr:getWindow("MailAdd_SkillLevelText"):setText("+"..Mail_SkillLevel)
						if IsKoreanLanguage() then
							winMgr:getWindow("MailAdd_TypeImage"):setTexture("Disabled", "UIData/ItemUIData/Insert/seal.tga", 0, 0)
						end
					else
						winMgr:getWindow("MailAdd_SkillLevelImage"):setVisible(false)
						winMgr:getWindow("MailAdd_SkillLevelText"):setText("")
					end
					
					-- 아이템 갯수
					local countText = CommatoMoneyStr(Mail_CountNumber)
					local szCount = PreCreateString_1526.." : "..countText
					winMgr:getWindow("MailAdd_Num"):setText(szCount)
					
					-- 아이템 기간
				    if Mail_Period == 0 then
						local period = PreCreateString_1207.." : "..PreCreateString_1056
						winMgr:getWindow("MailAdd_Period"):setText(period) 
				    else
						local period = PreCreateString_1207.." : "..Mail_Period
						winMgr:getWindow("MailAdd_Period"):setText(period) 
					end
				
				    -- 코인 정렬
					local coinText = CommatoMoneyStr(Mail_Coin_number)
					local textSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, coinText)
					winMgr:getWindow(tMailInfoText[3]):setText(coinText);
					winMgr:getWindow(tMailInfoText[3]):setPosition(412-textSize, 470)
					
					-- 그랑 정렬
					local r,g,b = GetGranColor(Mail_Gran_number)
					local granText = CommatoMoneyStr(Mail_Gran_number)
					textSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, granText)
					winMgr:getWindow(tMailInfoText[4]):setText(granText);
					winMgr:getWindow(tMailInfoText[4]):setPosition(412-textSize, 440);
					winMgr:getWindow(tMailInfoText[4]):setTextColor(r,g,b,255)
					
					if Mail_itemName == "" then  -- 첨부 물품없이 메일만 왔을경우
						--DebugStr("itemName is Null")
						winMgr:getWindow("MailAddTool_Image"):setEnabled(false)  -- 툴팁 기능 false
						winMgr:getWindow("MailAddTool_Image"):setUserString("MailAddToolIndex",	tostring(-1))
						winMgr:getWindow("MailAdd_Num"):setText("")
						winMgr:getWindow("MailAdd_Period"):setText("") 
						if Mail_Coin_number < 1 and Mail_Gran_number < 1 then
							winMgr:getWindow("ADD_Receive"):setVisible(false)
							winMgr:getWindow("ADD_Receive"):setEnabled(false)
							
							if Bool_Receive == 0 then
								MailRead(Mail_Key , RealIndexCount-1);	-- 선물을 읽었다고 보내준다
								--DebugStr('메일을 읽었다고 서버에 보내준다')
							end
						end
					end
				end
				-- 아이템 여부와 관계없이 나머지 보낸사람 메일제목등을 표시해준다
				
				if Mail_Coin_number < 1 and	Mail_Gran_number < 1 then
					winMgr:getWindow(tMailInfoText[3]):setText("");  -- 코인 그랑이 없을시는 표시하지 않는다
					winMgr:getWindow(tMailInfoText[4]):setText("");	
				end
				-- 보낸사람 ,메일 제목 , 메시지 내용표시
				winMgr:getWindow(tMailInfoText[1]):setText(Title_Name);
				winMgr:getWindow(tMailInfoText[2]):setText(Send_Name);
				winMgr:getWindow("MailEditBox"):clearTextExtends();
				winMgr:getWindow("MailEditBox"):addTextExtends(Mail_Msg, g_STRING_FONT_GULIMCHE, 11,    255,255,255,255,     0,     0,0,0,255);
				
				--if CEGUI.toRadioButton( winMgr:getWindow('Mail_Send') ):isSelected() == true then    -- 보낸편지는 선물받기가 없음  
				--	  winMgr:getWindow("ADD_Receive"):setVisible(false);
				--end
				
	   end
	end
end

--------------------------------------------------------
---보내기버튼을 비활성 시켜준다
-------------------------------------------------------
function SendButtonDisible() 
	winMgr:getWindow("ADD_Receive"):setVisible(false)
	winMgr:getWindow("ADD_Receive"):setEnabled(false)
end

--------------------------------------------------------------------
-- 메일첨부 내용 리셋 
--------------------------------------------------------------------
function ResetMailInfo(args)
	winMgr:getWindow("MailAdd_Image"):setTexture("Disabled","UIData/invisible.tga" , 0, 0)
	winMgr:getWindow("MailAdd_Image"):setLayered(false)
	winMgr:getWindow("MailAdd_SkillLevelImage"):setTexture("Disabled","UIData/invisible.tga" , 0, 0)
	winMgr:getWindow("MailAdd_SkillLevelText"):setText("")
	winMgr:getWindow("MailAdd_Name"):setText("")
	winMgr:getWindow("MailAdd_Num"):setText("")				
	winMgr:getWindow("MailAdd_Period"):setText("")
	winMgr:getWindow("MailInfoTitle"):setText("")
	winMgr:getWindow("MailInfoName"):setText("")
	winMgr:getWindow("MailCointext"):setText("")
	winMgr:getWindow("MailGrantext"):setText("")
	winMgr:getWindow("MailEditBox"):clearTextExtends();
	winMgr:getWindow("ADD_Receive"):setVisible(false)
	winMgr:getWindow("MailAdd_Image_Back"):setVisible(false)
	winMgr:getWindow("MailAddTool_Image"):setEnabled(false)
	winMgr:getWindow("MailAddTool_Image"):setUserString("MailAddToolIndex",	tostring(-1)) 
	winMgr:getWindow("MailAdd_TypeImage"):setTexture("Disabled","UIData/invisible.tga" , 0, 0)
end

function RefreMailListRadio(args)
	for i=1 , 5  do
		local name=winMgr:getWindow(tMailListRadio[i]..tMailInfoTextName[2]):getText()
		if name ~= "" then
			winMgr:getWindow(tMailListRadio[i]):setEnabled(true);
			winMgr:getWindow(tMailListCheck[i]):setEnabled(true);
		else 
		    winMgr:getWindow(tMailListRadio[i]):setEnabled(false);
		    winMgr:getWindow(tMailListCheck[i]):setEnabled(false);
		    winMgr:getWindow(tMailListAddImage[i]):setVisible(false);
		end
	end
end


--------------------------------------------------------------------
-- 이미지
--------------------------------------------------------------------
-- 선물함, 인벤토리 팝업창에 쓸 투명한 이미지.
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "InvisibleBackImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
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
	mywindow:setVisible(true);
	mywindow:setPosition(tPopupTextPosX[i], tPopupTextPosY[i]);
	mywindow:setSize(tPopupTextSizeX[i], tPopupTextSizeY[i]);
	mywindow:setViewTextMode(1);
	mywindow:setAlign(1);
	mywindow:setLineSpacing(13);
	winMgr:getWindow('InvisibleBackImage'):addChildWindow(mywindow);
end


function InvisibleRender()
	local _drawer = winMgr:getWindow("InvisibleBackImage"):getDrawer();
	
	winMgr:getWindow("itemBackImgage"):setPosition(11, 59)
	for i=1, #tPopupTextName do
	
		if i == 1 then
			winMgr:getWindow(tPopupTextName[i]):setLineSpacing(13);
			winMgr:getWindow(tPopupTextName[i]):setAlign(3);
			winMgr:getWindow(tPopupTextName[i]):setVisible(true)
			winMgr:getWindow(tPopupTextName[i]):clearTextExtends()
			local String	= string.format(Mail_String_PresentItemGetMsg, g_tPresentPopupInfo[2], g_tPresentPopupInfo[3])
			winMgr:getWindow(tPopupTextName[i]):addTextExtends(String, g_STRING_FONT_DODUM,13, 255,255,255,255, 1, 0,0,0,255);
			--DebugStr('String:'..g_tPresentPopupInfo[2])
			--DebugStr('String:'..g_tPresentPopupInfo[3])
		elseif i == 2 then
			winMgr:getWindow(tPopupTextName[i]):setLineSpacing(4);
			winMgr:getWindow(tPopupTextName[i]):setAlign(7);
			winMgr:getWindow(tPopupTextName[i]):setVisible(true)
			winMgr:getWindow(tPopupTextName[i]):clearTextExtends()
		elseif i == 3 then
			winMgr:getWindow(tPopupTextName[i]):setLineSpacing(13);
			winMgr:getWindow(tPopupTextName[i]):setVisible(false)
		end
	end
	
	if g_tPresentPopupInfo[3] == Mail_String_Nick or g_tPresentPopupInfo[3] == " " then
		_drawer:drawTexture(g_tPresentPopupInfo[1], 12, 60, 243, 108, 0, 0);		
	else
		--DebugStr("메일함: 어태치의 값 : " .. g_Attach)
		
		if g_AvatarType == -1 then
			local string = SearchCloneAvatarFileName(g_Attach)
			--DebugStr("메일함: 스트링의 값 : " .. tostring(string))
			
			if string == "" then
				-- 일반 아이템 이미지
				_drawer:drawTexture(g_tPresentPopupInfo[1], 20, 60, 243, 108, 0, 0);	-- 아이템 이미지
			else
				-- 클론 아이템 이미지
				_drawer:drawTexture(string, 20, 60, 243, 108, 0, 0)
			end
		else
			--DebugStr("들어가기나하냐?")
			_drawer:drawTexture(g_tPresentPopupInfo[1], 20, 60, 243, 108, 0, 0);		-- 아이템 이미지
		end
		
	end
	
	-- 캐시템 황금색 테두리
	if g_tPresentPopupInfo[5] ~= "" then
		_drawer:drawTexture(g_tPresentPopupInfo[5], 20, 60, 100, 100, 0, 0);
	end
end

--------------------------------------------------------------------
-- 선물받기 함수.
--------------------------------------------------------------------
local tKind = {["protecterr"] = 0, }

function MailGetEvent()
    DebugStr('MailGetEvent()호출');
	if g_SelectedPresentSlotNum <= 0 then
		ShowCommonAlertOkBoxWithFunction(Mail_String_Select_Item, 'OnClickAlertOkSelfHide');
		return;
	end
	
	local local_window = winMgr:getWindow(tMailListRadio[g_SelectedPresentSlotNum]);
	local Kind = tonumber(local_window:getUserString("MailKind"))
	g_Attach		= tonumber(local_window:getUserString("MailItemAttach"))		-- ★
	g_AvatarType	= tonumber(local_window:getUserString("MailItemAvatarType"))	-- ★

	g_tPresentPopupInfo[1] = local_window:getUserString("MailFileName")
	g_tPresentPopupInfo[5] = local_window:getUserString("MailFileName2")
	g_tPresentPopupInfo[2] = local_window:getUserString("MailItemName1")
	g_tPresentPopupInfo[3] = local_window:getUserString("MailItemName2")
	local DurationTime	   = tonumber(local_window:getUserString("MailDurationTime"));

	if local_window:getUserString("MailName") ~= "" then
		ShowCommonAlertOkCancelBoxWithFunction3("InvisibleBackImage", 'OnClickMailUseOk', 'OnClickPresentUseCancel');
	else
	   
		local Mail_Coin			= tonumber(winMgr:getWindow(tMailListRadio[g_SelectedPresentSlotNum]):getUserString("MailAddCoin"));
		local Mail_Gran			= tonumber(winMgr:getWindow(tMailListRadio[g_SelectedPresentSlotNum]):getUserString("MailAddGran"));
		if (Mail_Coin>0) or (Mail_Gran>0) then 
			ShowCommonAlertOkCancelBoxWithFunction("", PreCreateString_2065, 'OnClickMailUseOk', 'OnClickPresentUseCancel');
		else											--GetSStringInfo(LAN_LUA_RECEIVE_ITEM)
			ShowCommonAlertOkBoxWithFunction(Mail_String_Select_Item, 'OnClickAlertOkSelfHide');
		end
	end
	
end



------------------------------------------------------
-- 선물함 선물 사용 
------------------------------------------------------
function OnClickMailUseOk()
    DebugStr('OnClickMailUseOk()호출');
    ResetMailInfo()
    MailisVisible(true)
	local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "OnClickMailUseOk" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- 초기화를 해야함
	
	local local_window = winMgr:getWindow(tMailListRadio[g_SelectedPresentSlotNum]);
	local MailKey = local_window:getUserString("MailKey");
	 --DebugStr('MailKey:'..MailKey);
	local keyNumber = tonumber(MailKey);
	
	MailReceive(keyNumber);	-- 선물을 받았다고 메세지 보내준다.
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
	local_window:removeChildWindow("InvisibleBackImage");						-- 팝업창에 붙여줬던 이미지를 제거해준다.
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
	local_window:setVisible(false)
	SendButtonDisible()
	RefreshMailList()
end


------------------------------------------------------
-- 선물 사용 하지 않기
------------------------------------------------------
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

-------------------------------------------------------------
-- 마이리스트 내용 첨부시 나타나는 수량 입력 팝업창
-------------------------------------------------------------
AddInputAlphaWindow = winMgr:createWindow("TaharezLook/StaticImage", "AddInputAlphaImage")
AddInputAlphaWindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
AddInputAlphaWindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
AddInputAlphaWindow:setProperty("FrameEnabled", "False")
AddInputAlphaWindow:setProperty("BackgroundEnabled", "False")
AddInputAlphaWindow:setPosition(0, 0)
AddInputAlphaWindow:setSize(1920, 1200)
AddInputAlphaWindow:setVisible(false)
AddInputAlphaWindow:setAlwaysOnTop(true)
AddInputAlphaWindow:setZOrderingEnabled(false)
root:addChildWindow(AddInputAlphaWindow)

-- ESC등록
RegistEscEventInfo("AddInputAlphaImage", "ClickedAddInputClose")

------------------------------------------------------
-- 입력창 배경화면
------------------------------------------------------
MailAddInputWindow = winMgr:createWindow("TaharezLook/StaticImage", "AddInputBackImage")
MailAddInputWindow:setTexture("Enabled", "UIData/deal.tga", 592, 0)
MailAddInputWindow:setTexture("Disabled", "UIData/deal.tga", 592, 0)
MailAddInputWindow:setProperty("FrameEnabled", "False")
MailAddInputWindow:setProperty("BackgroundEnabled", "False")
MailAddInputWindow:setPosition(370, 200)
MailAddInputWindow:setSize(296, 212)
MailAddInputWindow:setAlwaysOnTop(true)
MailAddInputWindow:setZOrderingEnabled(false)
AddInputAlphaWindow:addChildWindow(MailAddInputWindow)

------------------------------------------------------
-- 타이틀 바
------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Titlebar", "AddInputBackImage_titlebar")
mywindow:setPosition(3, 1)
mywindow:setSize(264, 30)
MailAddInputWindow:addChildWindow(mywindow)

------------------------------------------------------
-- 제목 이미지 
------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyitemAdd_TitleImage")
mywindow:setTexture("Enabled", "UIData/deal.tga", 888, 0)
mywindow:setTexture("Disabled", "UIData/deal.tga", 888, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(100, 8)
mywindow:setSize(99, 16)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
MailAddInputWindow:addChildWindow(mywindow)

------------------------------------------------------
-- 아이템 이미지
------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyitemAdd_Image")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(8, 36)
mywindow:setSize(128, 128)
mywindow:setScaleWidth(102)
mywindow:setScaleHeight(102)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
mywindow:setLayered(false)
mywindow:setZOrderingEnabled(false)
MailAddInputWindow:addChildWindow(mywindow)


------------------------------------------------------
-- 코스튬 아바타 관련 백 이미지 ★
------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyitemAdd_Image_Back")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(8, 36)
mywindow:setSize(128, 128)
mywindow:setScaleWidth(102)
mywindow:setScaleHeight(102)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
mywindow:setLayered(false)
mywindow:setZOrderingEnabled(false)
MailAddInputWindow:addChildWindow(mywindow)


------------------------------------------------------
-- 툴팁 이미지를 위한 백판
------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyitemAdd_EventImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(8, 36)
mywindow:setSize(52, 52)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_SelectItemInfo")
mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_VanishTooltip")
MailAddInputWindow:addChildWindow(mywindow)

------------------------------------------------------
-- 아이템 이름
------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyitemAdd_Name")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,200,50,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setPosition(68, 34)
mywindow:setSize(220, 20)
mywindow:setZOrderingEnabled(false)
MailAddInputWindow:addChildWindow(mywindow)

------------------------------------------------------
-- 아이템 갯수
------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyitemAdd_Num")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setPosition(68, 50)
mywindow:setSize(220, 20)
mywindow:setZOrderingEnabled(false)
mywindow:setUserString("itemCount", 0)
MailAddInputWindow:addChildWindow(mywindow)

------------------------------------------------------
-- 아이템 기간
------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyitemAdd_Period")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(150,150,150,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setPosition(68, 66)
mywindow:setSize(220, 20)
mywindow:setZOrderingEnabled(false)
MailAddInputWindow:addChildWindow(mywindow)

------------------------------------------------------
-- 등록 수량 이미지
------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyitemAdd_RegistAmountImage")
mywindow:setTexture("Enabled", "UIData/deal.tga", 889, 154)
mywindow:setTexture("Disabled", "UIData/deal.tga", 889, 154)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(10, 122)
mywindow:setSize(78, 18)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
MailAddInputWindow:addChildWindow(mywindow)

------------------------------------------------------
-- 수량 입력칸
------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyitemAdd_InputAmountImage")
mywindow:setTexture("Enabled", "UIData/deal.tga", 696, 234)
mywindow:setTexture("Disabled", "UIData/deal.tga", 696, 234)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(120, 123)
mywindow:setSize(132, 21)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
MailAddInputWindow:addChildWindow(mywindow)

------------------------------------------------------
-- 수량 입력 에디트 박스
------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Editbox", "MyitemAdd_Count_editbox")
mywindow:setPosition(120, 124)
mywindow:setSize(110, 20)
mywindow:setAlphaWithChild(0)
mywindow:setUseEventController(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setTextColor(255,255,255,255)
CEGUI.toEditbox(mywindow):setInputOnlyNumber()
CEGUI.toEditbox(mywindow):setMaxTextLength(5)
CEGUI.toEditbox(mywindow):subscribeEvent("EditboxFull", "OnEditboxFullEvent")
MailAddInputWindow:addChildWindow(mywindow)

------------------------------------------------------
-- 수량 입력 좌우버튼
------------------------------------------------------
local tInputCountLRButtonName  = {["err"]=0, [0]="Add_InputCount_LBtn", "Add_InputCount_RBtn"}
local tInputCountLRButtonTexX  = {["err"]=0, [0]=889, 905}
local tInputCountLRButtonPosX  = {["err"]=0, [0]=100, 256}
local tInputCountLRButtonEvent = {["err"]=0, [0]="AddInputCount_L", "AddInputCount_R"}
for i=0, #tInputCountLRButtonName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tInputCountLRButtonName[i])
	mywindow:setTexture("Normal", "UIData/deal.tga", tInputCountLRButtonTexX[i], 172)
	mywindow:setTexture("Hover", "UIData/deal.tga", tInputCountLRButtonTexX[i], 188)
	mywindow:setTexture("Pushed", "UIData/deal.tga", tInputCountLRButtonTexX[i], 204)
	mywindow:setTexture("PushedOff", "UIData/deal.tga", tInputCountLRButtonTexX[i], 172)
	mywindow:setPosition(tInputCountLRButtonPosX[i], 125)
	mywindow:setSize(16, 16)
	mywindow:setSubscribeEvent("Clicked", tInputCountLRButtonEvent[i])
	MailAddInputWindow:addChildWindow(mywindow)
end


------------------------------------------------------
-- 수량 입력
------------------------------------------------------
function AddInputCount_L()
	
	-- 수량을 얻는다.
	local amountText = winMgr:getWindow("MyitemAdd_Count_editbox"):getText()
	--DebugStr('수량:'..amountText);
	if amountText == "" then
		amountText = "0"
	end
	local inputAmount = tonumber(amountText)
	
	-- 현재 가능한 수량을 구해서 비교한다.
	if inputAmount <= 0 then
		inputAmount = 0
		winMgr:getWindow("MyitemAdd_Count_editbox"):setText(tostring(inputAmount))
	else
		inputAmount = inputAmount - 1
		winMgr:getWindow("MyitemAdd_Count_editbox"):setText(tostring(inputAmount))
	end
end

------------------------------------------------------
-- 수량 입력
------------------------------------------------------
function AddInputCount_R()

	-- 수량을 얻는다.
	local amountText = winMgr:getWindow("MyitemAdd_Count_editbox"):getText()
	--DebugStr('수량:'..amountText);
	if amountText == "" then
		amountText = "0"
	end
	local inputAmount = tonumber(amountText)
	
	-- 현재 가능한 수량을 구해서 비교한다.
	local limitAmount = tonumber(winMgr:getWindow("MyitemAdd_Num"):getUserString("itemCount"))
	if inputAmount >= limitAmount then
		inputAmount = limitAmount
		winMgr:getWindow("MyitemAdd_Count_editbox"):setText(tostring(inputAmount))
	else
		inputAmount = inputAmount + 1
		winMgr:getWindow("MyitemAdd_Count_editbox"):setText(tostring(inputAmount))
	end
end
--------------------------------------------------------------------
--아이템 쓰기 첨부 팝업창 내용입력--
--------------------------------------------------------------------

function ItemCountInputPopup(avatarType, attach)
	winMgr:getWindow("MyitemAdd_Count_editbox"):activate()
	local itemCount, itemName, itemFileName, itemFileName2, itemskillLevel, itemSlotIndex, itemNumber = GetSelectAddItemInfo()
		
	--DebugStr('itemCount:'..itemCount);
	--DebugStr('itemName:'..itemName);
	--DebugStr('itemFileName:'..itemFileName);
	--DebugStr('itemskillLevel:'..itemskillLevel);
	--DebugStr('itemSlotIndex:'..itemSlotIndex);
			
	root:addChildWindow(winMgr:getWindow("AddInputAlphaImage"))  
	winMgr:getWindow("AddInputAlphaImage"):setVisible(true)
		
	-- 등록창 이미지(등록)
	winMgr:getWindow("MyitemAdd_TitleImage"):setTexture("Enabled", "UIData/deal.tga", 888, 0)
	winMgr:getWindow("MyitemAdd_TitleImage"):setTexture("Disabled", "UIData/deal.tga", 888, 0)
		
	-- 등록, 취소버튼 true
	winMgr:getWindow("AddiTem_RegistBtn"):setVisible(true)
	winMgr:getWindow("AddiTem_RegistBtn_CancelBtn"):setVisible(true)
	
	-- 아이템 파일이름
	winMgr:getWindow("MyitemAdd_Image"):setTexture("Disabled", itemFileName, 0, 0)
	winMgr:getWindow("MyitemAdd_Image"):setScaleWidth(102)
	winMgr:getWindow("MyitemAdd_Image"):setScaleHeight(102)
	winMgr:getWindow("MyitemAdd_Image"):setLayered(false)
	
	if itemFileName2 == "" then
		
	else
		winMgr:getWindow("MyitemAdd_Image"):setLayered(true)
		winMgr:getWindow("MyitemAdd_Image"):setTexture("Layered", itemFileName2, 0, 0)
	end
	
	
	if itemskillLevel > 0 then
		if IsKoreanLanguage() then
			winMgr:getWindow("MyitemAdd_Image"):setLayered(true)
			winMgr:getWindow("MyitemAdd_Image"):setTexture("Layered", "UIData/ItemUIData/Insert/seal.tga", 0, 0)
		end
	end
	
	-- 아이템 이름
	winMgr:getWindow("MyitemAdd_Name"):setText(itemName)
		
	-- 아이템 수량
	local countText = CommatoMoneyStr(itemCount)
	local szcount = PreCreateString_1526.." : "..countText
	winMgr:getWindow("MyitemAdd_Num"):setText(szcount)
	winMgr:getWindow("MyitemAdd_Num"):setUserString("itemCount", itemCount)
		
	-- 아이템 기간
	local period = PreCreateString_1207.." : "..PreCreateString_1056
	winMgr:getWindow("MyitemAdd_Period"):setText(period)
		
	if itemCount == 1 then
		winMgr:getWindow("MyitemAdd_Count_editbox"):setText("1")
	else
		winMgr:getWindow("MyitemAdd_Count_editbox"):setText("1") 
	end
	
	-- 임시 저장 
	TempName      =	itemName
	TempFileName  =	itemFileName
	TempFileName2 =	itemFileName2
	Tempperiod    = period
	TempSkillLevel = itemskillLevel
	TempSlotIndex  = itemSlotIndex
	TempItemNumber = itemNumber
	
	--DebugStr('!!!!!avatarType :' .. avatarType);
	--DebugStr('!!!!!attach :' .. attach);
	
	-- 코스튬 아바타 아이콘 등록 함수 ★
	SetAvatarIcon("MyitemAdd_Image" , "MyitemAdd_Image_Back" , avatarType , attach)
end

------------------------------------------------------
--마이아이템 첨부클릭시 나오는 팝업 종료하는 함수
------------------------------------------------------
function ClickedAddInputClose()
	winMgr:getWindow("AddInputAlphaImage"):setVisible(false)
	root:removeChildWindow(winMgr:getWindow("AddInputAlphaImage"))
	winMgr:getWindow("MyitemAdd_Count_editbox"):setText("")
	
	
	-- 등록 취소 -> 인벤/메일 버튼 비활성시키기★
	--winMgr:getWindow("MainBar_Bag"):setEnabled(false)
	--winMgr:getWindow("popup_mail_btn"):setEnabled(false)
end

------------------------------------------------------
-- 등록 버튼
------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "AddiTem_RegistBtn")
mywindow:setTexture("Normal", "UIData/deal.tga", 590, 568)
mywindow:setTexture("Hover", "UIData/deal.tga", 590, 597)
mywindow:setTexture("Pushed", "UIData/deal.tga", 590, 626)
mywindow:setTexture("PushedOff", "UIData/deal.tga", 590, 568)
mywindow:setPosition(5, 178)
mywindow:setSize(143, 29)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickedRegistInputAddItem")
winMgr:getWindow("AddInputBackImage"):addChildWindow(mywindow)


------------------------------------------------------
-- 취소 버튼
------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "AddiTem_RegistBtn_CancelBtn")
mywindow:setTexture("Normal", "UIData/deal.tga", 733, 568)
mywindow:setTexture("Hover", "UIData/deal.tga", 733, 597)
mywindow:setTexture("Pushed", "UIData/deal.tga", 733, 626)
mywindow:setTexture("PushedOff", "UIData/deal.tga", 733, 568)
mywindow:setPosition(148, 178)
mywindow:setSize(143, 29)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickedAddInputClose")
winMgr:getWindow("AddInputBackImage"):addChildWindow(mywindow)


------------------------------------------------------
-- 아이템 첨부 확인
------------------------------------------------------
function ClickedRegistInputAddItem()

	DebugStr('ClickedRegistInputAddItem()')
	if winMgr:getWindow("AddInputAlphaImage"):isVisible() == false then
		return
	end

	-- 등록하기
	local useCount = tonumber(winMgr:getWindow("MyitemAdd_Count_editbox"):getText())
	if useCount == "" then
		useCount = 0
	end
	
	winMgr:getWindow("WriteAdd_Image"):setTexture("Disabled", TempFileName, 0, 0)
	winMgr:getWindow("WriteAdd_Image"):setScaleWidth(102)
	winMgr:getWindow("WriteAdd_Image"):setScaleHeight(102)
	if TempFileName2 == "" then
		winMgr:getWindow("WriteAdd_Image"):setLayered(false)
	else
		winMgr:getWindow("WriteAdd_Image"):setLayered(true)
		winMgr:getWindow("WriteAdd_Image"):setTexture("Layered", TempFileName2, 0, 0)
	end
	
	winMgr:getWindow("WriteAdd_Name"):setText(TempName)
	winMgr:getWindow("WriteAdd_Period"):setText(Tempperiod)
	winMgr:getWindow("WriteAdd_SkillLevelImage"):setLayered(false)
	
	if TempSkillLevel > 0 then
		winMgr:getWindow("WriteAdd_SkillLevelImage"):setVisible(true)
		winMgr:getWindow("WriteAdd_SkillLevelImage"):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[TempSkillLevel], 486)
		
		winMgr:getWindow("WriteAdd_SkillLevelText"):setTextColor(tGradeTextColorTable[TempSkillLevel][1], tGradeTextColorTable[TempSkillLevel][2], tGradeTextColorTable[TempSkillLevel][3], 255)
		winMgr:getWindow("WriteAdd_SkillLevelText"):setText("+"..TempSkillLevel)
		
		if IsKoreanLanguage() then
			winMgr:getWindow("WriteAdd_TypeImage"):setTexture("Disabled", "UIData/ItemUIData/Insert/seal.tga", 0, 0)
		end
	else
		winMgr:getWindow("WriteAdd_SkillLevelImage"):setVisible(false)
		winMgr:getWindow("WriteAdd_SkillLevelText"):setText("")
	end
	
	local bSuccess = RequestAddItemRegist(useCount, true)	

	if bSuccess  then
		winMgr:getWindow("WriteAdd_Num"):setText(szcount)
		ClickedAddInputClose()
		AddButtenEnable(false)
		winMgr:getWindow('WriteAddCancelBtn'):setVisible(true);
		RequestMailCharge(TempSlotIndex, TempItemNumber, TempCoin, TempGran)
	else
		ItemAddRegisterReset()
	end
	
	SetAvatarIcon("WriteAdd_Image" , "WriteAdd_Image_Back" , TempAvatarTypeValue , TempAttach) -- ★
	
	-- 딴짓못하게 인벤토리와 메일을 비활성화
	--winMgr:getWindow("MainBar_Bag"):setEnabled(false)
	--winMgr:getWindow("popup_mail_btn"):setEnabled(false)	
end


function ItemAddRegisterReset()
	winMgr:getWindow("WriteAdd_Image"):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	winMgr:getWindow("WriteAdd_Image"):setLayered(false)
	winMgr:getWindow("WriteAdd_Name"):setText("")
	winMgr:getWindow("WriteAdd_Period"):setText("")	
	winMgr:getWindow("WriteAdd_Num"):setText("")
	winMgr:getWindow("WriteAdd_SkillLevelImage"):setVisible(false)
	winMgr:getWindow("WriteAdd_Image_Back"):setVisible(false)
	winMgr:getWindow("WriteAdd_SkillLevelText"):setText("")
	TempSlotIndex = -1
	TempItemNumber = 0
	winMgr:getWindow("WriteAdd_TypeImage"):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
end

function WriteAddRegisterReset()

	winMgr:getWindow("Write_Gran_Text"):setText("")
	winMgr:getWindow("Write_Coin_Text"):setText("")
	winMgr:getWindow("Write_Charge_Text"):setText("")
	winMgr:getWindow("MailWrite_1"):setText("")
	winMgr:getWindow("MailWrite_2"):setText("")
	winMgr:getWindow("MailWrite_3"):setText("")
	winMgr:getWindow("MailWrite_4"):setText("")
	winMgr:getWindow("MailWrite_5"):setText("")
	winMgr:getWindow("MailWrite_6"):setText("")
	winMgr:getWindow("MailWrite_7"):setText("")
end

function DeleteEditboxEvent()
	for i=3, 7 do
		winMgr:getWindow("MailWrite_"..i):setText("")
		winMgr:getWindow("MailWrite_"..i):setEnabled(false)
		winMgr:getWindow("MailWrite_"..i):deactivate()
	end
	winMgr:getWindow("MailWrite_3"):setEnabled(true)
	winMgr:getWindow("MailWrite_3"):activate()
end

--------------------------------------------------------------------------------
---메일쓰기창에 첨부된 아이템의 이미지, 갯수등 
--------------------------------------------------------------------------------

-- 백판 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "BackAdd_Image")
mywindow:setTexture("Enabled", "UIData/deal.tga",			296,583 );
mywindow:setTexture("Disabled", "UIData/deal.tga",			296,583);
mywindow:setSize(276, 44);
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(23, 215)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('MailWriteImage'):addChildWindow(mywindow)


-- 아이템 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "WriteAdd_Image")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(8, 6)
mywindow:setSize(128, 128)
mywindow:setScaleWidth(102)
mywindow:setScaleHeight(102)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
mywindow:setLayered(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('BackAdd_Image'):addChildWindow(mywindow)


-- 코스튬 아바타 관련 백 이미지 ★
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "WriteAdd_Image_Back")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(8, 6)
mywindow:setSize(128, 128)
mywindow:setScaleWidth(102)
mywindow:setScaleHeight(102)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
mywindow:setLayered(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('BackAdd_Image'):addChildWindow(mywindow)

-- 아이템 타입이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "WriteAdd_TypeImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(8, 6)
mywindow:setSize(128, 128)
mywindow:setScaleWidth(102)
mywindow:setScaleHeight(102)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
mywindow:setLayered(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('BackAdd_Image'):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "WriteAdd_SkillLevelImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(33, 32)
mywindow:setSize(29, 16)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('BackAdd_Image'):addChildWindow(mywindow)
	
-- 스킬레벨 + 글자
mywindow = winMgr:createWindow("TaharezLook/StaticText", "WriteAdd_SkillLevelText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
mywindow:setPosition(39, 32)
mywindow:setSize(40, 20)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('BackAdd_Image'):addChildWindow(mywindow)

-- 아이템 이름
mywindow = winMgr:createWindow("TaharezLook/StaticText", "WriteAdd_Name")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,200,50,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setPosition(68, 1)
mywindow:setText("")
mywindow:setSize(220, 20)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('BackAdd_Image'):addChildWindow(mywindow)

-- 아이템 갯수
mywindow = winMgr:createWindow("TaharezLook/StaticText", "WriteAdd_Num")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setPosition(68, 15)
mywindow:setSize(220, 20)
mywindow:setText("")
mywindow:setZOrderingEnabled(false)
mywindow:setUserString("itemCount", 0)
winMgr:getWindow('BackAdd_Image'):addChildWindow(mywindow)

-- 아이템 기간
mywindow = winMgr:createWindow("TaharezLook/StaticText", "WriteAdd_Period")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(150,150,150,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
mywindow:setPosition(68, 29)
mywindow:setSize(220, 20)
mywindow:setText("")
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('BackAdd_Image'):addChildWindow(mywindow)


-- 아이템 첨부 등록후 취소하기 위한 버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "WriteAddCancelBtn")
mywindow:setTexture("Normal", "UIData/deal.tga", 970, 459)
mywindow:setTexture("Hover", "UIData/deal.tga", 970, 476)
mywindow:setTexture("Pushed", "UIData/deal.tga", 970, 493)
mywindow:setTexture("PushedOff", "UIData/deal.tga", 970, 459)
mywindow:setPosition(270, 240)
mywindow:setSize(17, 17)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setUserString("index", 1)
mywindow:subscribeEvent("Clicked", "ClickedAddtemCancel")
winMgr:getWindow("MailWriteImage"):addChildWindow(mywindow)

--------------------------------------------------------------------
---첨부된 아이템 등록 취소할때 
--------------------------------------------------------------------	
function ClickedAddtemCancel()

	DebugStr("ClickedAddtemCancel")
	winMgr:getWindow('WriteAddCancelBtn'):setVisible(false)
	local index =1
	CancelAddItemRegist(tonumber(index))
	ItemAddRegisterReset()
	AddButtenEnable(true)
	TempSlotIndex = -1
	TempItemNumber = 0
	RequestMailCharge(TempSlotIndex , TempItemNumber ,TempCoin, TempGran)
end


--------------------------------------------------------------------
---메일 삭제버튼팝업창 확인 누를시
--------------------------------------------------------------------	
function OnClickMailDeleteQuestOk()

	 for i=1, 5 do
	 	 if CEGUI.toCheckbox(winMgr:getWindow(tMailListCheck[i])):isSelected() then
	 		local j=  (g_MailCurrentPage*5)-5+i
	 		local local_window = winMgr:getWindow(tMailListRadio[i]);
			local Mail_Key	= local_window:getUserString("MailKey")
			
			if CEGUI.toRadioButton( winMgr:getWindow('Mail_Receive') ):isSelected() == true then
				Delete_Present(Mail_Key,2,1)
			end
			if CEGUI.toRadioButton( winMgr:getWindow('Mail_Send') ):isSelected() == true then
				Delete_Present(Mail_Key,1,1)
			end	 
	 	 end
	 end
	 
	RefreshMailList()
	ResetMailInfo(args)
	MailPageUpdate()
	ShowCommonAlertOkBoxWithFunction(PreCreateString_2058, 'OnClickAlertOkSelfHide')  
										--GetSStringInfo(LAN_LUA_MAIL_RESULT)
end

--------------------------------------------------------------------
---메일 삭제버튼팝업창 취소 누를시
--------------------------------------------------------------------	
function OnClickMailDeleteQuestCancel()
   	DebugStr('OnClickMailDeleteQuestCancel()')
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
	local_window:setVisible(false)
end

--------------------------------------------------------------------
---모든메일 삭제버튼팝업창 확인 누를시
--------------------------------------------------------------------	
function OnClickAllMailDeleteQuestOk()

	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
	local_window:setVisible(false)
	
	if CEGUI.toRadioButton( winMgr:getWindow('Mail_Receive') ):isSelected() == true then
		 Delete_Present(0,2,2)
		 --DebugStr('받은편지 삭제');
	 else
		 Delete_Present(0,1,2)
		-- DebugStr('보낸편지 삭제');
	 end
	 
	
    RefreshMailList()
    ResetMailInfo(args)
    RefreMailListRadio(args)
    ShowCommonAlertOkBoxWithFunction(PreCreateString_2058, 'OnClickAlertOkSelfHide')
										--GetSStringInfo(LAN_LUA_MAIL_RESULT)
 
end

--------------------------------------------------------------------
---모든메일 삭제버튼팝업창 취소 누를시
--------------------------------------------------------------------	
function OnClickAllMailDeleteQuestCancel()

	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox');
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
	local_window:setVisible(false)
end

----------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------
-- 선물이 왔을시 무조건 깜박
--------------------------------------------------------------------
function ShowMailBallon()
	DebugStr('ShowMailBallon()')
	if CheckNpcModeforLua() then
		return
	end
	
	Mainbar_ActiveEffect( BAR_BUTTONTYPE_MAIL )
end	

--------------------------------------------------------------------
-- 메일을 지우거나 받을시 조사해서 깜박
--------------------------------------------------------------------
function MailBallonSearch()
	DebugStr('MailBallonSearch()')
	if CheckNpcModeforLua() then
		return
	end
	
	if GetMailIconShow() then
		Mainbar_ActiveEffect( BAR_BUTTONTYPE_MAIL )
	else
		Mainbar_ClearEffect( BAR_BUTTONTYPE_MAIL )
	end
end

local tDirectWearItemInfo = {['protecterr']=0, -1, -1, -1, ""}
-- 선물함에 있는걸 받고 바로 착용하길 원할때.
function PresentWearYesOrNo(ItemNumber, SlotIndex, ItemKind, ItemName, IsCostumeAvatar)
	tDirectWearItemInfo[1] = ItemNumber
	tDirectWearItemInfo[2] = SlotIndex
	tDirectWearItemInfo[3] = ItemKind
	tDirectWearItemInfo[4] = ItemName
	if IsKoreanLanguage() then
		ShowCommonAlertOkCancelBoxWithFunction(ItemName, "을\n바로 착용하시겠습니까?", "OnDirectlyWearOk", "OnDirectlyWearCancel")
	else		
		local String	= string.format(PreCreateString_1140, ItemName)	--GetSStringInfo(LAN_LUA_WND_COMMON_SHOP_4)
		if IsCostumeAvatar == false then
			ShowCommonAlertOkCancelBoxWithFunction("", String, "OnDirectlyWearOk", "OnDirectlyWearCancel")
		end
	end
	
end


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