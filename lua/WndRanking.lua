--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root	    = winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)
root:activate()

--------------------------------------------------------------------

-- ???? ?? ???? ??????

--------------------------------------------------------------------
local cacheListPlayer = {}
local currently_listPlayer = {}

offsetSizeY = 31
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_Ranking_Background_Image")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(263, 16)
mywindow:setSize(495, 494+(offsetSizeY+150))
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

parentWindow = mywindow
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_Ranking_Background_Panel")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
-- mywindow:setWideType(6);
mywindow:setPosition(0, offsetSizeY)
mywindow:setSize(495, 494)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
parentWindow:addChildWindow(mywindow)


--#New_Ranking
--headder Board
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_Ranking_Background_Image1")
-- mywindow:setTexture("Enabled", "UIData/ranking.tga", 525, 0)
-- mywindow:setTexture("Disabled", "UIData/ranking.tga", 525, 0)
mywindow:setTexture("Enabled", "UIData/ranking_board.tga", 22 , 12)
mywindow:setTexture("Disabled", "UIData/ranking_board.tga", 22, 12)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
-- mywindow:setWideType(6);
mywindow:setPosition(0, 0)
mywindow:setSize(495, offsetSizeY+offsetSizeY)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
parentWindow:addChildWindow(mywindow)
--#New_Ranking
-- Body Board

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_Ranking_Background_Image2")
-- mywindow:setTexture("Enabled", "UIData/ranking.tga", 525, offsetSizeY)
-- mywindow:setTexture("Disabled", "UIData/ranking.tga", 525, offsetSizeY)
mywindow:setTexture("Enabled", "UIData/ranking_board.tga", 22, 99)
mywindow:setTexture("Disabled", "UIData/ranking_board.tga", 22, 99)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
-- mywindow:setWideType(6);
mywindow:setPosition(0, offsetSizeY+offsetSizeY)
mywindow:setSize(495, 240)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
parentWindow:addChildWindow(mywindow)


-- ??????
--#New_Ranking
-- Footer Board
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_Ranking_Background_Image3_Footer")
-- mywindow:setTexture("Enabled", "UIData/ranking.tga", 525, offsetSizeY)
-- mywindow:setTexture("Disabled", "UIData/ranking.tga", 525, offsetSizeY)
mywindow:setTexture("Enabled", "UIData/ranking_board.tga", 22, 432)
mywindow:setTexture("Disabled", "UIData/ranking_board.tga", 22, 432)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
-- mywindow:setWideType(6);
mywindow:setPosition(0, 640)
mywindow:setSize(495, 37)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
parentWindow:addChildWindow(mywindow)


-- ??????
mywindow = winMgr:createWindow("TaharezLook/Titlebar", "sj_Ranking_Titlebar")
mywindow:setPosition(3, 1)
mywindow:setSize(460, 45)
winMgr:getWindow("sj_Ranking_Background_Image"):addChildWindow(mywindow)



--------------------------------------------------------------------

-- ?????? ???? ??? ????5??(????, ????, ???????, ????, ???)

--------------------------------------------------------------------
local g_curTabGroup = 1
local g_curRankType = 0

local tRankName = {['err']=0, [0]="sj_RankType_level", "sj_RankType_battle", "sj_RankType_arcade", "sj_RankType_ladder", "sj_RankType_club"}
local tRankTexY = {['err']=0, [0]=	0,	 99,	198,	297,	396}
local tRankPosX = {['err']=0, [0]=	5, 	 90,	175,	260,	345}

for i=0, #tRankName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tRankName[i])
	winMgr:getWindow("sj_Ranking_Background_Panel"):addChildWindow(tRankName[i])
end

local tRankName2 = {['err']=0, [0]="sj_RankType_matchmaking"}
local tRankTexX = {['err']=0, [0]=	297,	0,	0,	0,	0,	0}
local tRankTexY = {['err']=0, [0]=	3,		0,	0,	0,	0,	0}
local tRankPosX = {['err']=0, [0]=	5,		0,	0,	0,	0,	0}
for i=0, #tRankName2 do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tRankName2[i])
	winMgr:getWindow("sj_Ranking_Background_Panel"):addChildWindow(tRankName2[i])
end


function split(input, delimiter)
    local result = {}
    if delimiter == "" then
        -- Handle splitting into characters
        for i = 1, #input do
            result[i] = input:sub(i, i)
        end
    else
        for match in (input .. delimiter):gmatch("(.-)" .. delimiter) do
            table.insert(result, match)
        end
    end
    return result
end


local page = 1
local indexPage = 1

local season_list = 2
local currently_season = 1

-- ?????????????????????? ????????????
function ChangeRankType()
	-- ?????????????????? ?????????????????????????????? ???????????????????????? ??????????????????? ??????? ???????????? ????????????????????? ??????????????????? ???????????? ????????????? ?????????????.
	-- winMgr:getWindow("sj_selectBattleInfo_backImage"):setVisible(true)
	winMgr:getWindow("sj_selectBattleInfo_backImage"):setVisible(true)
	winMgr:getWindow("sj_selectBattleInfo_selectedDesc"):setVisible(true)
	winMgr:getWindow("sj_selectBattleInfo_selectedDesc"):setTextExtends("Season "..currently_season, g_STRING_FONT_GULIMCHE, 12, 255, 255, 255, 255,   0, 255,255,255,255)
	-- ?????? ?????????? ???????? ??????? ??? ???? ??????? ??????? ???? ????? ?????.
	winMgr:getWindow("sj_selectBattleInfo_tempRankType"):setVisible(false)
	ChangeRankingInfo(0,0,currently_season)
	-- reset_Value_Mode()
	-- for i=0, #tRankName do
	-- 	if CEGUI.toRadioButton(winMgr:getWindow(tRankName[i])):isSelected() then
	-- 		g_curTabGroup = 0
	-- 		g_curRankType = i
	-- 		SetRankInfoInType(i)
	-- 		break
	-- 	end
	-- end
	-- for i=0, #tRankName2 do
	-- 	if CEGUI.toRadioButton(winMgr:getWindow(tRankName2[i])):isSelected() then
	-- 		g_curTabGroup = 1
	-- 		g_curRankType = i
	-- 		SetRankInfoInType(i)
	-- 		break
	-- 	end
	-- end
end

-- ???????? ????
-- function ChangeRankType()
-- 	-- ?????? ?????????? ???????? ??????? ??? ???? ??????? ??????? ???? ????? ?????.

-- 	-- ?????? ?????????? ???????? ??????? ??? ???? ??????? ??????? ???? ????? ?????.
-- 	winMgr:getWindow("sj_selectBattleInfo_tempRankType"):setVisible(false)
-- 	-- reset_Value_Mode()
-- 	for i=0, #tRankName do
-- 		if CEGUI.toRadioButton(winMgr:getWindow(tRankName[i])):isSelected() then
-- 			g_curTabGroup = 0
-- 			g_curRankType = i
-- 			-- SetRankInfoInType(i)
-- 			break
-- 		end
-- 	end
-- 	for i=0, #tRankName2 do
-- 		if CEGUI.toRadioButton(winMgr:getWindow(tRankName2[i])):isSelected() then
-- 			g_curTabGroup = 1
-- 			g_curRankType = i
-- 			-- SetRankInfoInType(i)
-- 			break
-- 		end
-- 	end
-- end





-- ??????? ???? ????????(?????, ?????????... ???)(1??:?????????? ?? ??????????? ???????? ?????)
local tRankInfoName  = {["err"]=0, [0]="sj_exp",	"sj_battle", "sj_sRank", "sj_ladder", "sj_clubRecord", "sj_matchmaking"}
local tRankInfoTexX  = {["err"]=0, [0]=	297,	0,		297,	297,	297,	408	}
local tRankInfoTexY  = {["err"]=0, [0]=	283,	0,		309,	335,	361,	9 }
local tRankInfoPosX  = {["err"]=0, [0]=	358, 	0,		359,	347,	351,	403 }
local tRankInfoPosY  = {["err"]=0, [0]=	86, 	86,		86,		86,		86,		92 }
local tRankInfoSizeX = {["err"]=0, [0]=	119, 	0,		119,	119,	119,	25 }
local tRankInfoSizeY = {["err"]=0, [0]=	25, 	25,		25,		25,		25,		30 }
for i=0, #tRankInfoName do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", tRankInfoName[i])
	-- mywindow:setTexture("Enabled", "UIData/ranking.tga", tRankInfoTexX[i], tRankInfoTexY[i])
	-- mywindow:setTexture("Disabled", "UIData/ranking.tga", tRankInfoTexX[i], tRankInfoTexY[i])
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(tRankInfoPosX[i], tRankInfoPosY[i])
	mywindow:setSize(tRankInfoSizeX[i], tRankInfoSizeY[i])
	mywindow:setVisible(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_Ranking_Background_Panel"):addChildWindow(mywindow)
end



--------------------------------------------------------------------

-- ?????? ????? ???

--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Editbox", "sj_Ranking_Find_text")
mywindow:setPosition(66, 86)
mywindow:setSize(200, 24)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setAlphaWithChild(0)
mywindow:setUseEventController(false)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("TextAccepted", "ClickFindRankUser")
CEGUI.toEditbox(mywindow):setMaxTextLength(16)
CEGUI.toEditbox(mywindow):subscribeEvent("EditboxFull", "OnEditboxFullEvent")
winMgr:getWindow("sj_Ranking_Background_Panel"):addChildWindow(mywindow)

function OnEditboxFullEvent(args)
	PlayWave('sound/FullEdit.wav')
end


-- ??? ??? ???
-- mywindow = winMgr:createWindow("TaharezLook/Button", "sj_Ranking_FindBtn")
-- mywindow:setTexture("Normal", "UIData/ranking.tga", 297, 112+26)
-- mywindow:setTexture("Hover", "UIData/ranking.tga", 297, 112)
-- mywindow:setTexture("Pushed", "UIData/ranking.tga", 297, 112+52)
-- mywindow:setTexture("PushedOff", "UIData/ranking.tga", 297, 112+26)
-- mywindow:setTexture("Enabled", "UIData/ranking.tga", 297, 112+26)
-- mywindow:setTexture("Disabled", "UIData/ranking.tga", 297, 112+26)
-- mywindow:setPosition(223, 85)
-- mywindow:setSize(59, 25)
-- mywindow:setZOrderingEnabled(false)
-- mywindow:subscribeEvent("Clicked", "ClickFindRankUser")
-- winMgr:getWindow("sj_Ranking_Background_Panel"):addChildWindow(mywindow)


-- ?????? ????? ????? ??
function ClickFindRankUser()

	local findUserName = winMgr:getWindow("sj_Ranking_Find_text"):getText()
	
	--??? ????????? ???? ?????? ???????
	ClearFindInfos()
	if findUserName == "" then
		ChangeRankingPage("","",1)
	else
		WndRank_FindUser(findUserName)
	end
end


-- ?????? ?????? ???
function ShowFindBoder(index)
	winMgr:getWindow(index.."sj_userInfo_findImage"):setVisible(true)
end


-- ??????? ????(?????? ????, ???? ????)
function ClearFindInfos()
	winMgr:getWindow("sj_Ranking_Find_text"):setText("")
	for i=0, 9 do
		winMgr:getWindow(i.."sj_userInfo_findImage"):setVisible(false)
	end
end


--------------------------------------------------------------------

-- ??????? ???? ??????

--#New_Ranking
-- list player 
--------------------------------------------------------------------
local aspectRatio = 26 / 14
local newWidth = 290
local newHeight_find = newWidth * aspectRatio

mywindow =  winMgr:createWindow("TaharezLook/StaticImage", "sj_text_find")
mywindow:setTexture("Enabled", "UIData/ranking_board.tga", 136, 852)
mywindow:setTexture("Disabled", "UIData/ranking_board.tga", 136, 852)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(17, 260)
mywindow:setSize(26, 14)
mywindow:setScaleWidth(newHeight_find)
mywindow:setScaleHeight(newHeight_find)
mywindow:setZOrderingEnabled(false)
mywindow:setVisible(true)
winMgr:getWindow("sj_Ranking_Background_Panel"):addChildWindow(mywindow)

mywindow =  winMgr:createWindow("TaharezLook/StaticImage", "sj_text_stars")
mywindow:setTexture("Enabled", "UIData/ranking_board.tga", 30, 853)
mywindow:setTexture("Disabled", "UIData/ranking_board.tga", 30, 853)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(415, 260)
mywindow:setSize(27, 9)
mywindow:setScaleWidth(newHeight_find)
mywindow:setScaleHeight(newHeight_find)
mywindow:setZOrderingEnabled(false)
mywindow:setVisible(true)
winMgr:getWindow("sj_Ranking_Background_Panel"):addChildWindow(mywindow)

mywindow =  winMgr:createWindow("TaharezLook/StaticImage", "sj_input_find")
mywindow:setTexture("Enabled", "UIData/ranking_board.tga", 82, 870)
mywindow:setTexture("Disabled", "UIData/ranking_board.tga", 82, 870)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(48, 253)
mywindow:setSize(152, 24)
mywindow:setScaleWidth(newHeight_find)
mywindow:setScaleHeight(newHeight_find)
mywindow:setZOrderingEnabled(false)
mywindow:setVisible(true)
winMgr:getWindow("sj_Ranking_Background_Panel"):addChildWindow(mywindow)

--------------------------------------------------------------------
--#New_Ranking
--Text Box Ranking Find
--------------------------------------------------------------------

mywindow = winMgr:createWindow("TaharezLook/Editbox", "RankingFindPlayer")
mywindow:setPosition(0, 3)
mywindow:setSize(200, 24)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setAlphaWithChild(0)
mywindow:setUseEventController(false)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("TextAccepted", "ClickRankingFindPlayer")
CEGUI.toEditbox(mywindow):setMaxTextLength(12)
CEGUI.toEditbox(mywindow):subscribeEvent("EditboxFull", "OnEditboxFullEvent")
mywindow:setVisible(true) -- test
winMgr:getWindow("sj_input_find"):addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/Button", "sj_button_find")
mywindow:setTexture("Normal", "UIData/ranking.tga", 297, 112)
mywindow:setTexture("Hover", "UIData/ranking.tga", 297, 164)
mywindow:setTexture("Pushed", "UIData/ranking.tga", 297, 164)
mywindow:setTexture("PushedOff", "UIData/ranking.tga", 297, 112)
mywindow:setPosition(226, 255)
mywindow:setSize(59, 25)
mywindow:setZOrderingEnabled(false)
mywindow:setVisible(true)
mywindow:subscribeEvent("Clicked", "ClickRankingFindPlayer")
winMgr:getWindow('sj_Ranking_Background_Panel'):addChildWindow(mywindow)

function ClickRankingFindPlayer()

	local findUserName = winMgr:getWindow("RankingFindPlayer"):getText()
	-- local findUserName = "cka"
	if findUserName == "" then
		winMgr:getWindow("RankingFindPlayer"):setText("")
		return
	end

	GetRankingPlayerByName(tostring("%"..findUserName.."%"))
	winMgr:getWindow("RankingFindPlayer"):setText("")
end

--------------------------------------------------------------------
--#New_Ranking
-- list player 
for i=0, 9 do
	
	-- ???? ?????	
	-- backwindow = winMgr:createWindow("TaharezLook/StaticImage", i.."sj_userInfo_backImage")
	-- backwindow:setTexture("Enabled", "UIData/ranking_board.tga", 539, 182)
	-- backwindow:setTexture("Disabled", "UIData/ranking_board.tga", 539, 182)
	-- backwindow:setProperty("FrameEnabled", "False")
	-- backwindow:setProperty("BackgroundEnabled", "False")
	-- -- backwindow:setPosition(11, 116+(i*33))
	-- backwindow:setPosition(11, 285+(i*33))
	-- backwindow:setSize(482, 27)
	-- backwindow:setZOrderingEnabled(false)
	-- winMgr:getWindow("sj_Ranking_Background_Panel"):addChildWindow(backwindow)

	backwindow = winMgr:createWindow("TaharezLook/StaticImage", i.."sj_userInfo_backImage")
	backwindow:setTexture("Enabled", "UIData/ranking.tga", 551, 555)
	backwindow:setTexture("Disabled", "UIData/ranking.tga", 551, 555)
	backwindow:setProperty("FrameEnabled", "False")
	backwindow:setProperty("BackgroundEnabled", "False")
	-- backwindow:setPosition(11, 116+(i*33))
	backwindow:setPosition(11, 285+(i*33))
	backwindow:setSize(473, 29)
	backwindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_Ranking_Background_Panel"):addChildWindow(backwindow)
	
	-- ????? ???? ?
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i.."sj_userInfo_findImage")
	mywindow:setTexture("Enabled", "UIData/ranking.tga", 551, 585)
	mywindow:setTexture("Disabled", "UIData/ranking.tga", 551, 585)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(11, 285+(i*33))
	mywindow:setSize(473, 29)
	mywindow:setVisible(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("sj_Ranking_Background_Panel"):addChildWindow(mywindow)
	

	local aspectRatio_Badge = 95 / 75 
	local newWidth_Badge = 36
	local newScale_Badge = newWidth_Badge * aspectRatio_Badge
	-- ????
	local DebugRankBadge = winMgr:createWindow("TaharezLook/StaticImage", i.."sj_userInfo_rank")
	DebugRankBadge:setTexture("Enabled", "UIData/Raking_Badge.png", 70, 35)
	DebugRankBadge:setScaleHeight(75)
	DebugRankBadge:setScaleWidth(95)
	DebugRankBadge:setScaleWidth(newScale_Badge+4)
	DebugRankBadge:setScaleHeight(newScale_Badge)
	DebugRankBadge:setPosition(-50, 312)
	DebugRankBadge:setSize(220, 220)
	winMgr:getWindow(i.."sj_userInfo_backImage"):addChildWindow(DebugRankBadge)

	-- mywindow = winMgr:createWindow("TaharezLook/StaticText", i.."sj_userInfo_rank")
	-- mywindow:setProperty("FrameEnabled", "false")
	-- mywindow:setProperty("BackgroundEnabled", "false")
	-- mywindow:setTextColor(255, 255, 255, 255)
	-- mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	-- mywindow:setText("")
	-- mywindow:setPosition(64, 8)
	-- mywindow:setSize(40, 20)
	-- mywindow:setZOrderingEnabled(false)
	-- winMgr:getWindow(i.."sj_userInfo_backImage"):addChildWindow(mywindow)
	
		
	-- ???? ???? ???? ?????
	-- Icon Up and Down No.
	-- mywindow = winMgr:createWindow("TaharezLook/StaticImage", i.."sj_userInfo_rankChangeImage")
	-- mywindow:setProperty("FrameEnabled", "False")
	-- mywindow:setProperty("BackgroundEnabled", "False")
	-- mywindow:setTexture("Enabled", "UIData/ranking.tga", 297, 195)
	-- mywindow:setTexture("Disabled", "UIData/ranking.tga", 297, 195)
	-- mywindow:setPosition(65, 10)
	-- mywindow:setSize(10, 10)
	-- mywindow:setAlwaysOnTop(true)
	-- mywindow:setZOrderingEnabled(true)
	-- winMgr:getWindow(i.."sj_userInfo_backImage"):addChildWindow(mywindow)
	
	-- ???? ???? ????
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i.."sj_userInfo_rankChange")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 112)
	mywindow:setText("")
	mywindow:setPosition(76, 0)
	mywindow:setSize(40, 20)
	mywindow:setZOrderingEnabled(false)
	mywindow:setViewTextMode(1)
	mywindow:setAlign(1)
	mywindow:setLineSpacing(12)
	mywindow:setVisible(false)
	winMgr:getWindow(i.."sj_userInfo_backImage"):addChildWindow(mywindow)
	
	-- ???? ?????
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i.."sj_userInfo_ladder")
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(111, 3)
	mywindow:setSize(47, 21)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	winMgr:getWindow(i.."sj_userInfo_backImage"):addChildWindow(mywindow)
	
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i.."sj_userInfo_matchmaking_rank")
	mywindow = drawRankWindow(mywindow, 0, 111, 0, 120)
	winMgr:getWindow(i.."sj_userInfo_backImage"):addChildWindow(mywindow)
	
	-- ????
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i.."sj_userInfo_level")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 112)
	mywindow:setText("")
	mywindow:setPosition(145, 5)
	mywindow:setSize(40, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(i.."sj_userInfo_backImage"):addChildWindow(mywindow)
	
	-- ???
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i.."sj_userInfo_name")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 112)
	mywindow:setText("")
	mywindow:setPosition(178, 5)
	mywindow:setSize(40, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(i.."sj_userInfo_backImage"):addChildWindow(mywindow)
	
	-- ????1
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i.."sj_userInfo_info1")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 112)
	mywindow:setText("")
	mywindow:setPosition(340, 5)
	mywindow:setSize(40, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(i.."sj_userInfo_backImage"):addChildWindow(mywindow)

	-- ????2
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i.."sj_userInfo_info2")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 112)
	mywindow:setText("")
	mywindow:setPosition(340, 5)
	mywindow:setSize(40, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(i.."sj_userInfo_backImage"):addChildWindow(mywindow)
end






--------------------------------------------------------------------

-- ????????????????(????????????)???????????? ???????? ??????????????????(MVP, KO, ????????????????????????, ??????????????????, ????????)
--------------------------------------------------------------------
-- ???????????? MVP ???????????? ???????????????????? ???????????? ???????????? ????????????????????
-- mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_selectBattleInfo_backImage")
-- mywindow:setTexture("Enabled", "UIData/ranking.tga", 295, 696)
-- mywindow:setTexture("Disabled", "UIData/ranking.tga", 295, 696)
-- mywindow:setProperty("FrameEnabled", "False")
-- mywindow:setProperty("BackgroundEnabled", "False")
-- mywindow:setPosition(15, 42)
-- mywindow:setSize(191, 25)
-- mywindow:setZOrderingEnabled(false)
-- mywindow:setAlwaysOnTop(true)
-- mywindow:setVisible(true)
-- winMgr:getWindow('sj_Ranking_Background_Panel'):addChildWindow(mywindow)

-- -- ??????????????????????????????? ???????????? ????????????? ???????????????????????? ????????
-- mywindow = winMgr:createWindow("TaharezLook/Button", "sj_selectBattleInfo_selectBtn")
-- mywindow:setTexture("Normal", "UIData/option.tga", 371, 310)
-- mywindow:setTexture("Hover", "UIData/option.tga", 399, 310)
-- mywindow:setTexture("Pushed", "UIData/option.tga", 427, 310)
-- mywindow:setTexture("PushedOff", "UIData/option.tga", 427, 310)
-- mywindow:setPosition(165, 1)
-- mywindow:setSize(25, 23)
-- mywindow:setZOrderingEnabled(false)
-- mywindow:setAlwaysOnTop(true)
-- mywindow:subscribeEvent("Clicked", "ClickAddRankType")
-- winMgr:getWindow('sj_selectBattleInfo_backImage'):addChildWindow(mywindow)

-- -- ?????????????? ????????
-- mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_selectBattleInfo_selectedDesc")
-- mywindow:setProperty("FrameEnabled", "false")
-- mywindow:setProperty("BackgroundEnabled", "false")
-- mywindow:setPosition(294, 92)
-- mywindow:setSize(160, 25)
-- mywindow:setZOrderingEnabled(false)
-- mywindow:setViewTextMode(1)
-- mywindow:setAlign(8)
-- mywindow:setLineSpacing(2)
-- mywindow:setAlwaysOnTop(true)
-- mywindow:setEnabled(false)
-- winMgr:getWindow('sj_Ranking_Background_Panel'):addChildWindow(mywindow)

-- -- ???????????????? ???????????? ??????????????? ???????????????????? ????????????????????
-- mywindow = winMgr:createWindow("TaharezLook/Button", "sj_selectBattleInfo_tempSelectBtn")
-- mywindow:setTexture("Normal", "UIData/invisible.tga", 0, 0)
-- mywindow:setTexture("Hover", "UIData/invisible.tga", 0, 0)
-- mywindow:setTexture("Pushed", "UIData/invisible.tga", 0, 0)
-- mywindow:setTexture("PushedOff", "UIData/invisible.tga", 0, 0)
-- mywindow:setPosition(0, 1)
-- mywindow:setSize(160, 22)
-- mywindow:setZOrderingEnabled(false)
-- mywindow:setAlwaysOnTop(true)
-- mywindow:subscribeEvent("Clicked", "ClickAddRankType")
-- winMgr:getWindow("sj_selectBattleInfo_backImage"):addChildWindow(mywindow)

--#New_Ranking
-- drop down list SS.
--======================================================================================================

-- Drop down menu bar AND select list
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_selectBattleInfo_backImage")
mywindow:setTexture("Enabled", "UIData/ranking.tga", 295, 696)
mywindow:setTexture("Disabled", "UIData/ranking.tga", 295, 696)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(15, 42)
mywindow:setSize(191, 25)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setVisible(true)
winMgr:getWindow('sj_Ranking_Background_Panel'):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/Button", "sj_selectBattleInfo_selectBtn")
mywindow:setTexture("Normal", "UIData/option.tga", 371, 310)
mywindow:setTexture("Hover", "UIData/option.tga", 399, 310)
mywindow:setTexture("Pushed", "UIData/option.tga", 427, 310)
mywindow:setTexture("PushedOff", "UIData/option.tga", 427, 310)
mywindow:setPosition(165, 1)
mywindow:setSize(25, 23)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setVisible(true)
mywindow:subscribeEvent("Clicked", "ClickAddRankType")
winMgr:getWindow('sj_selectBattleInfo_backImage'):addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_selectBattleInfo_selectedDesc")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setPosition(20, 49)
mywindow:setSize(160, 25)
mywindow:setZOrderingEnabled(false)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
winMgr:getWindow('sj_Ranking_Background_Panel'):addChildWindow(mywindow)

function ClickAddRankType()
	if winMgr:getWindow("sj_selectBattleInfo_tempRankType"):isVisible() then
		winMgr:getWindow("sj_selectBattleInfo_tempRankType"):setVisible(false)
	else
		winMgr:getWindow("sj_selectBattleInfo_tempRankType"):setVisible(true)
	end
end

local g_MaxEnableAddRankNum = 6
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_selectBattleInfo_tempRankType")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(15, 44+26)
mywindow:setSize(167, (g_MaxEnableAddRankNum+1)*26)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("sj_Ranking_Background_Panel"):addChildWindow(mywindow)

-- list Drop down menu
local tSelectRadioBtPosY = {['err']=0, [0]=0, 26, 26*2, 26*3, 26*4, 26*5, 26*6}
local tSelectRadioIndex  = {['err']=0, [0]=1, 5, 6, 7, 9, 10, 11}	-- ???????????????????????? ???????????? ????????????? ???????
for i=0, season_list do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", "season_"..i)
	mywindow:setTexture("Normal", "UIData/ranking.tga", 295, 722)
	mywindow:setTexture("Hover", "UIData/ranking.tga", 295, 748)
	mywindow:setTexture("Pushed", "UIData/ranking.tga", 295, 748)
	mywindow:setTexture("SelectedNormal", "UIData/ranking.tga", 295, 748)
	mywindow:setTexture("SelectedHover", "UIData/ranking.tga", 295, 748)
	mywindow:setTexture("SelectedPushed", "UIData/ranking.tga", 295, 748)
	mywindow:setPosition(1, tSelectRadioBtPosY[i])
	mywindow:setProperty("GroupID", 4008)
	mywindow:setSize(165, 25)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:setVisible(true)
	mywindow:subscribeEvent("SelectStateChanged", "ChangeAddRankType")
	winMgr:getWindow('sj_selectBattleInfo_tempRankType'):addChildWindow(mywindow)
	
	-- ???????? ???????????????? ????????????
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "season_"..i.."text")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setPosition(0, 6)
	mywindow:setSize(165, 25)
	mywindow:setViewTextMode(1)
	mywindow:setAlign(8)
	mywindow:setLineSpacing(2)
	mywindow:setTextExtends("Season "..i+1, g_STRING_FONT_GULIMCHE, 12, 0, 0, 0, 255,   0, 0,0,0,255)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(true)
	winMgr:getWindow("season_"..i):addChildWindow(mywindow)
end

function ChangeAddRankType()
	for i=0, season_list do
		if CEGUI.toRadioButton(winMgr:getWindow("season_"..i)):isSelected() then
			reset_Value_Mode()	

			winMgr:getWindow("sj_selectBattleInfo_tempRankType"):setVisible(false)
			
			g_curAddRankType = i
			winMgr:getWindow("sj_selectBattleInfo_selectedDesc"):setVisible(true)
			winMgr:getWindow("sj_selectBattleInfo_selectedDesc"):setTextExtends("Season "..i+1, g_STRING_FONT_GULIMCHE, 12, 255, 255, 255, 255,   0, 255,255,255,255)
			winMgr:getWindow("season_"..i):setProperty("Selected", "false")
			
			ChangeRankingInfo(0,0,i+1)
		end
	end
end


-- ?????????????????????? ????????????
function ChangeRankType()
	-- ?????????????????? ?????????????????????????????? ???????????????????????? ??????????????????? ??????? ???????????? ????????????????????? ??????????????????? ???????????? ????????????? ?????????????.
	-- winMgr:getWindow("sj_selectBattleInfo_backImage"):setVisible(true)
	winMgr:getWindow("sj_selectBattleInfo_backImage"):setVisible(true)
	winMgr:getWindow("sj_selectBattleInfo_selectedDesc"):setVisible(true)
	winMgr:getWindow("sj_selectBattleInfo_selectedDesc"):setTextExtends("Season "..currently_season, g_STRING_FONT_GULIMCHE, 12, 255, 255, 255, 255,   0, 255,255,255,255)
	-- ?????? ?????????? ???????? ??????? ??? ???? ??????? ??????? ???? ????? ?????.
	winMgr:getWindow("sj_selectBattleInfo_tempRankType"):setVisible(false)
	ChangeRankingInfo(0,0,currently_season)
	-- reset_Value_Mode()
	-- for i=0, #tRankName do
	-- 	if CEGUI.toRadioButton(winMgr:getWindow(tRankName[i])):isSelected() then
	-- 		g_curTabGroup = 0
	-- 		g_curRankType = i
	-- 		SetRankInfoInType(i)
	-- 		break
	-- 	end
	-- end
	-- for i=0, #tRankName2 do
	-- 	if CEGUI.toRadioButton(winMgr:getWindow(tRankName2[i])):isSelected() then
	-- 		g_curTabGroup = 1
	-- 		g_curRankType = i
	-- 		SetRankInfoInType(i)
	-- 		break
	-- 	end
	-- end
end
--======================================================================================================


--====================== Button Class Show ===========================================================================================


local onShowJobs = 0
--#New_Ranking
--Button Job Show
local tRankLRButtonShowJobRush = {["err"]=0, "hapgido", "judo", "sambo", "pro_wrestling"}
local tRankLRButtonShowJobStreet  = {["err"]=0, "Teakwondo", "boxing", "muaythai", "capoeira"}
local tRankLRButtonShowJobSpecial  = {["err"]=0, "sumo", "kungfu", "ninja", "systema", "dirtyX"}

local tRankLRButtonShowJob_position_tga = {["err"]=0, 0, 77, 154, 231, 308}
local tRankLRButtonShowJob_set_position = {["err"]=0, 0, 80, 160, 240, 320}

for i=1, #tRankLRButtonShowJobSpecial do
	mywindow = winMgr:createWindow("TaharezLook/Button", "sj_Show_Job_"..tRankLRButtonShowJobSpecial[i])
	mywindow:setTexture("Normal", "UIData/ranking_board.tga", 539 + tRankLRButtonShowJob_position_tga[i], 424)
	mywindow:setTexture("Hover", "UIData/ranking_board.tga", 539 + tRankLRButtonShowJob_position_tga[i], 449)
	mywindow:setTexture("Pushed", "UIData/ranking_board.tga", 539 + tRankLRButtonShowJob_position_tga[i], 424)
	mywindow:setTexture("PushedOff", "UIData/ranking_board.tga", 539 + tRankLRButtonShowJob_position_tga[i], 449)
	mywindow:setPosition(15 + tRankLRButtonShowJob_set_position[i], 69)
	mywindow:setSize(75, 22)
	mywindow:setZOrderingEnabled(false)
	-- mywindow:setSubscribeEvent("Clicked", "sj_Show_Job_"..tRankLRButtonShowJobSpecial[i])
	mywindow:subscribeEvent("Clicked", function()
		reset_Value_Mode()
		GetUserListOnClick("sj_Show_Job_"..tRankLRButtonShowJobSpecial[i])		
	end)    
	mywindow:setVisible(false)
	winMgr:getWindow("sj_Ranking_Background_Panel"):addChildWindow(mywindow)
end

for i=1, #tRankLRButtonShowJobStreet do
	mywindow = winMgr:createWindow("TaharezLook/Button", "sj_Show_Job_"..tRankLRButtonShowJobStreet[i])
	mywindow:setTexture("Normal", "UIData/ranking_board.tga", 539 + tRankLRButtonShowJob_position_tga[i], 374)
	mywindow:setTexture("Hover", "UIData/ranking_board.tga", 539 + tRankLRButtonShowJob_position_tga[i], 399)
	mywindow:setTexture("Pushed", "UIData/ranking_board.tga", 539 + tRankLRButtonShowJob_position_tga[i], 374)
	mywindow:setTexture("PushedOff", "UIData/ranking_board.tga", 539 + tRankLRButtonShowJob_position_tga[i], 399)
	mywindow:setPosition(15 + tRankLRButtonShowJob_set_position[i], 69)
	mywindow:setSize(75, 22)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", function()   
		reset_Value_Mode()	
		GetUserListOnClick("sj_Show_Job_"..tRankLRButtonShowJobStreet[i])				
	end)    
	mywindow:setVisible(false)
	winMgr:getWindow("sj_Ranking_Background_Panel"):addChildWindow(mywindow)
end

for i=1, #tRankLRButtonShowJobRush do
	mywindow = winMgr:createWindow("TaharezLook/Button", "sj_Show_Job_"..tRankLRButtonShowJobRush[i])
	mywindow:setTexture("Normal", "UIData/ranking_board.tga", 539 + tRankLRButtonShowJob_position_tga[i], 325)
	mywindow:setTexture("Hover", "UIData/ranking_board.tga", 539 + tRankLRButtonShowJob_position_tga[i], 349)
	mywindow:setTexture("Pushed", "UIData/ranking_board.tga", 539 + tRankLRButtonShowJob_position_tga[i], 325)
	mywindow:setTexture("PushedOff", "UIData/ranking_board.tga", 539 + tRankLRButtonShowJob_position_tga[i], 349)
	mywindow:setPosition(15 + tRankLRButtonShowJob_set_position[i], 69)
	mywindow:setSize(75, 22)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", function()   	
		reset_Value_Mode()
		GetUserListOnClick("sj_Show_Job_"..tRankLRButtonShowJobRush[i])			
	end)    
	mywindow:setVisible(false)
	winMgr:getWindow("sj_Ranking_Background_Panel"):addChildWindow(mywindow)
end

function sj_Show_Class_Special()
	for i=1, #tRankLRButtonShowJobSpecial do
		winMgr:getWindow("sj_Show_Job_"..tRankLRButtonShowJobSpecial[i]):setVisible(true)
	end

	trunOffBtnJob_Special()
end

function sj_Show_Class_Street()
	for i=1, #tRankLRButtonShowJobStreet do
		winMgr:getWindow("sj_Show_Job_"..tRankLRButtonShowJobStreet[i]):setVisible(true)
	end
	trunOffBtnJob_Street()
end

function sj_Show_Class_Rush()
	for i=1, #tRankLRButtonShowJobRush do
		winMgr:getWindow("sj_Show_Job_"..tRankLRButtonShowJobRush[i]):setVisible(true)

	end
	trunOffBtnJob_Rush()
end

--=================================================================================================================


--====================== Button Class Show ===========================================================================================
--------------------------------------------------------------------
-- ??? ??? ???
--#New_Ranking
--Button Class Show
--------------------------------------------------------------------
local tRankLRButtonShowClass  = {["err"]=0, "Street", "Rush", "Special"}
local tRankLRButtonShowClass_positions = {["err"]=0, 0, 77, 154}
local tRankLRButtonShowClass_positionX = {["err"]=0, 0, 80, 160}
for i=1, #tRankLRButtonShowClass do
	mywindow = winMgr:createWindow("TaharezLook/Button", "sj_Show_Class_"..tRankLRButtonShowClass[i])
	mywindow:setTexture("Normal", "UIData/ranking_board.tga", 539 + tRankLRButtonShowClass_positions[i], 275)
	mywindow:setTexture("Hover", "UIData/ranking_board.tga", 539 + tRankLRButtonShowClass_positions[i], 299)
	mywindow:setTexture("Pushed", "UIData/ranking_board.tga", 539 + tRankLRButtonShowClass_positions[i], 275)
	mywindow:setTexture("PushedOff", "UIData/ranking_board.tga", 539 + tRankLRButtonShowClass_positions[i], 299)
	mywindow:setPosition(15 + tRankLRButtonShowClass_positionX[i], 42)
	mywindow:setSize(75, 22)
	mywindow:setZOrderingEnabled(false)
	mywindow:setSubscribeEvent("Clicked", "sj_Show_Class_"..tRankLRButtonShowClass[i])
	mywindow:setVisible(false)
	winMgr:getWindow("sj_Ranking_Background_Panel"):addChildWindow(mywindow)

end
--=================================================================================================================


--====================== Button Mode Show ===========================================================================================
--------------------------------------------------------------------
--#New_Ranking
--Button Mode Show
--------------------------------------------------------------------
local tRankButtonShowMode  = {["err"]=0, "sj_Show_Ranking_Mode", "sj_Show_KOC_Mode"}
local tRankButtonShowMode_positionsX = {["err"]=0, 0, 157}
local tRankButtonShowMode_positions_img_X = {["err"]=0, 539, 692}
local tRankButtonShowMode_size = {["err"]=0, 0, 1}
for i=1, #tRankButtonShowMode do
	mywindow = winMgr:createWindow("TaharezLook/Button", tRankButtonShowMode[i])
	mywindow:setTexture("Normal", "UIData/ranking_board.tga", tRankButtonShowMode_positions_img_X[i], 227)
	mywindow:setTexture("Hover", "UIData/ranking_board.tga", tRankButtonShowMode_positions_img_X[i], 251)
	mywindow:setTexture("Pushed", "UIData/ranking_board.tga", tRankButtonShowMode_positions_img_X[i], 227)
	mywindow:setTexture("PushedOff", "UIData/ranking_board.tga", tRankButtonShowMode_positions_img_X[i], 251)
	mywindow:setPosition(15 + tRankButtonShowMode_positionsX[i], 15)
	mywindow:setSize(152+ tRankButtonShowMode_size[i], 22)
	mywindow:setAlwaysOnTop(true)
	mywindow:setSubscribeEvent("Clicked", tRankButtonShowMode[i])
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(true)
	winMgr:getWindow("sj_Ranking_Background_Panel"):addChildWindow(mywindow)
end

--------------------------------------------------------------------

function trunOffBtnJob_Street()
	for i=1, #tRankLRButtonShowJobSpecial do
		winMgr:getWindow("sj_Show_Job_"..tRankLRButtonShowJobSpecial[i]):setVisible(false)
	end

	for i=1, #tRankLRButtonShowJobRush do
		winMgr:getWindow("sj_Show_Job_"..tRankLRButtonShowJobRush[i]):setVisible(false)
	end
end

function trunOffBtnJob_Rush()
	for i=1, #tRankLRButtonShowJobStreet do
		winMgr:getWindow("sj_Show_Job_"..tRankLRButtonShowJobStreet[i]):setVisible(false)
	end

	for i=1, #tRankLRButtonShowJobSpecial do
		winMgr:getWindow("sj_Show_Job_"..tRankLRButtonShowJobSpecial[i]):setVisible(false)
	end
end

function trunOffBtnJob_Special()
	for i=1, #tRankLRButtonShowJobStreet do
		winMgr:getWindow("sj_Show_Job_"..tRankLRButtonShowJobStreet[i]):setVisible(false)
	end

	for i=1, #tRankLRButtonShowJobRush do
		winMgr:getWindow("sj_Show_Job_"..tRankLRButtonShowJobRush[i]):setVisible(false)
	end
end

function trunOffBtnClass()
	
	for i=1, #tRankLRButtonShowClass do
		winMgr:getWindow("sj_Show_Class_"..tRankLRButtonShowClass[i]):setVisible(false)
	end
end

function trunOffBtnJob()
	for i=1, #tRankLRButtonShowJobSpecial do
		winMgr:getWindow("sj_Show_Job_"..tRankLRButtonShowJobSpecial[i]):setVisible(false)
	end

	for i=1, #tRankLRButtonShowJobRush do
		winMgr:getWindow("sj_Show_Job_"..tRankLRButtonShowJobRush[i]):setVisible(false)
	end
	
	for i=1, #tRankLRButtonShowJobStreet do
		winMgr:getWindow("sj_Show_Job_"..tRankLRButtonShowJobStreet[i]):setVisible(false)
	end
end

--------------------------------------------------------------------
function sj_Show_KOC_Mode()
	winMgr:getWindow("sj_selectBattleInfo_backImage"):setVisible(false)
	winMgr:getWindow("sj_selectBattleInfo_selectedDesc"):setVisible(false)
	winMgr:getWindow("sj_selectBattleInfo_selectedDesc"):setTextExtends("", g_STRING_FONT_GULIMCHE, 12, 255, 255, 255, 255,   0, 255,255,255,255)

	for i=1, #tRankLRButtonShowClass do
		winMgr:getWindow("sj_Show_Class_"..tRankLRButtonShowClass[i]):setVisible(true)
	end	
end

function sj_Show_Ranking_Mode()
	winMgr:getWindow("sj_selectBattleInfo_backImage"):setVisible(true)
	winMgr:getWindow("sj_selectBattleInfo_selectedDesc"):setVisible(true)
	winMgr:getWindow("sj_selectBattleInfo_selectedDesc"):setTextExtends("Season "..currently_season, g_STRING_FONT_GULIMCHE, 12, 255, 255, 255, 255,   0, 255,255,255,255)

	GetUserListOnClick("sj_Show_Ranking_Mode")	
	trunOffBtnClass()
	trunOffBtnJob()
end

function reset_Value_Mode()
	for indexs=1, 10 do
		-- currently_listPlayer[index] = ""
		local index = tonumber(indexs)-1 or 0
		-- ????
		winMgr:getWindow(index .. "sj_userInfo_rank"):setPosition(36, 2)
		winMgr:getWindow(index .. "sj_userInfo_rank"):setTexture("Enabled", "UIData/Raking_Badge.png", 70, 35)
		winMgr:getWindow(index .. "sj_userInfo_rank"):setVisible(false)
		winMgr:getWindow(index .. "sj_userInfo_rank"):clearTextExtends()

		-- ????
		winMgr:getWindow(index .. "sj_userInfo_level"):setText("")
		winMgr:getWindow(index .. "sj_userInfo_level"):setVisible(false)
		-- ???
		winMgr:getWindow(index .. "sj_userInfo_name"):setText("")
		winMgr:getWindow(index .. "sj_userInfo_name"):setVisible(false)
		
		-- ????1
		winMgr:getWindow(index .. "sj_userInfo_info1"):setText("")
		winMgr:getWindow(index .. "sj_userInfo_info1"):setVisible(false)
	end
end
--------------------------------------------------------------------

--=================================================================================================================
local tRankImgJoonyX  = {["err"]=0, 227, 123, 19}
local tRankImgJoonyY  = {["err"]=0, 698}

local tRankImgWellsX  = {["err"]=0, 227, 123, 19}
local tRankImgWellsY  = {["err"]=0, 490}

local tRankImgRayX  = {["err"]=0, 227, 123, 19}
local tRankImgRayY  = {["err"]=0, 594}
-------------------------------------------------------------------- Nicky Lilru
local tRankImgLilruY  = {["err"]=0, 642, 539, 435}
local tRankImgSeraY  = {["err"]=0, 490}

local tRankImgNickyX  = {["err"]=0, 642, 539, 435}
local tRankImgNickyY  = {["err"]=0, 594}

local tRankImgSeraX  = {["err"]=0, 642, 539, 435}
local tRankImgSeraY  = {["err"]=0, 698}
--------------------------------------------------------------------
--#New_Ranking
--Ranking 1st 2nd 3rd Player
--------------------------------------------------------------------
local aspectRatio = 102 / 102
local newWidth = 190
local newHeight = newWidth * aspectRatio

-- 1st
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Ranking_player_1st")
mywindow:setTexture("Enabled", "UIData/ranking_board.tga", 227, 490)
mywindow:setTexture("Disabled", "UIData/ranking_board.tga", 227, 490)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(210, 69)
mywindow:setSize(102, 102)
mywindow:setScaleWidth(newHeight)
mywindow:setScaleHeight(newHeight)
mywindow:setZOrderingEnabled(false)
mywindow:setEnabled(false)
mywindow:setLayered(true)
winMgr:getWindow("sj_Ranking_Background_Image2"):addChildWindow(mywindow)

	local aspectRatio_brand = 95 / 31
	local newWidth_brand = 120
	local newHeight_brand = newWidth_brand * aspectRatio_brand
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Ranking_player_1st_brand")
	mywindow:setTexture("Enabled", "UIData/ranking_board.tga", 18, 907)
	mywindow:setTexture("Disabled", "UIData/ranking_board.tga", 18, 907)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	-- mywindow:setWideType(6);
	mywindow:setPosition(-15, 75)
	mywindow:setSize(95, 31)
	mywindow:setScaleWidth(newHeight_brand)
	mywindow:setScaleHeight(newHeight_brand)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("Ranking_player_1st"):addChildWindow(mywindow)


	mywindow = winMgr:createWindow("TaharezLook/StaticText", "Ranking_player_1st_name")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setText("")
	mywindow:setPosition(36, 91)
	mywindow:setSize(40, 20)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(true)
	winMgr:getWindow('Ranking_player_1st'):addChildWindow(mywindow)

-- 2nd
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Ranking_player_2nd")
mywindow:setTexture("Enabled", "UIData/ranking_board.tga", 123, 594)
mywindow:setTexture("Disabled", "UIData/ranking_board.tga", 123, 594)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(77, 99)
mywindow:setSize(102, 102)
mywindow:setScaleWidth(newHeight)
mywindow:setScaleHeight(newHeight)
mywindow:setZOrderingEnabled(false)
mywindow:setEnabled(false)
mywindow:setLayered(true)
winMgr:getWindow("sj_Ranking_Background_Image2"):addChildWindow(mywindow)

	local aspectRatio_brand = 95 / 31
	local newWidth_brand = 120
	local newHeight_brand = newWidth_brand * aspectRatio_brand
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Ranking_player_2nd_brand")
	mywindow:setTexture("Enabled", "UIData/ranking_board.tga", 18, 943)
	mywindow:setTexture("Disabled", "UIData/ranking_board.tga", 18, 943)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	-- mywindow:setWideType(6);
	mywindow:setPosition(-15, 75)
	mywindow:setSize(95, 31)
	mywindow:setScaleWidth(newHeight_brand)
	mywindow:setScaleHeight(newHeight_brand)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("Ranking_player_2nd"):addChildWindow(mywindow)

	mywindow = winMgr:createWindow("TaharezLook/StaticText", "Ranking_player_2nd_name")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setText("")
	mywindow:setPosition(36, 91)
	mywindow:setSize(40, 20)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(true)
	winMgr:getWindow('Ranking_player_2nd'):addChildWindow(mywindow)

-- 3rd
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Ranking_player_3rd") 
mywindow:setTexture("Enabled", "UIData/ranking_board.tga", 19, 698)
mywindow:setTexture("Disabled", "UIData/ranking_board.tga", 19, 698)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(336, 99)
mywindow:setSize(102, 102)
mywindow:setScaleWidth(newHeight)
mywindow:setScaleHeight(newHeight)
mywindow:setZOrderingEnabled(false)
mywindow:setEnabled(false)
mywindow:setLayered(true)
winMgr:getWindow("sj_Ranking_Background_Image2"):addChildWindow(mywindow)

	local aspectRatio_brand = 95 / 31
	local newWidth_brand = 120
	local newHeight_brand = newWidth_brand * aspectRatio_brand
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Ranking_player_3rd_brand")
	mywindow:setTexture("Enabled", "UIData/ranking_board.tga", 18, 976)
	mywindow:setTexture("Disabled", "UIData/ranking_board.tga", 18, 976)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	-- mywindow:setWideType(6);
	mywindow:setPosition(-15, 75)
	mywindow:setSize(95, 31)
	mywindow:setScaleWidth(newHeight_brand)
	mywindow:setScaleHeight(newHeight_brand)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("Ranking_player_3rd"):addChildWindow(mywindow)

	mywindow = winMgr:createWindow("TaharezLook/StaticText", "Ranking_player_3rd_name")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setText("")
	mywindow:setPosition(36, 91)
	mywindow:setSize(40, 20)
	mywindow:setZOrderingEnabled(false)
	mywindow:setVisible(true)
	winMgr:getWindow('Ranking_player_3rd'):addChildWindow(mywindow)

function getInfoTopPlayerSt(
	nameSt, rankingSt, boneSt, totalStarSt)
	
	local img_CharacterX = 0
	local img_CharacterY = 0
	winMgr:getWindow("Ranking_player_1st_name"):setText("")
	if totalStarSt > 0 then
		winMgr:getWindow("Ranking_player_1st_brand"):setVisible(true)
		winMgr:getWindow("Ranking_player_1st_name"):setVisible(true)
		winMgr:getWindow("Ranking_player_1st"):setVisible(true)

		if boneSt == 0 then
			-- Wells
			img_CharacterX = tRankImgWellsX[1]
			img_CharacterY = tRankImgWellsY[1]
		elseif boneSt == 1 then
			-- Ray
			img_CharacterX = tRankImgRayX[1]
			img_CharacterY = tRankImgRayY[1]
		elseif boneSt == 2 then
			-- Joony
			img_CharacterX = tRankImgJoonyX[1]
			img_CharacterY = tRankImgJoonyY[1]
		elseif boneSt == 3 then
			-- Lilru
			img_CharacterX = tRankImgLilruX[1]
			img_CharacterY = tRankImgLilruY[1]
		elseif boneSt == 4 then
			-- Nicky
			img_CharacterX = tRankImgNickyX[1]
			img_CharacterY = tRankImgNickyY[1]
		elseif boneSt == 5 then
			-- Sera
			img_CharacterX = tRankImgSeraX[1]
			img_CharacterY = tRankImgSeraY[1]
		else
			img_CharacterX = tRankImgSeraX[1]
			img_CharacterY = tRankImgSeraY[1]
		end
		
		local nameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(nameSt))
		winMgr:getWindow("Ranking_player_1st_name"):setPosition(72-nameSize/2, 91)
		winMgr:getWindow("Ranking_player_1st_name"):setText(tostring(nameSt))
		winMgr:getWindow("Ranking_player_1st"):setTexture("Enabled", "UIData/ranking_board.tga", img_CharacterX, img_CharacterY)
		winMgr:getWindow("Ranking_player_1st"):setTexture("Disabled", "UIData/ranking_board.tga", img_CharacterX, img_CharacterY)
	else
		winMgr:getWindow("Ranking_player_1st_brand"):setVisible(false)
		winMgr:getWindow("Ranking_player_1st_name"):setVisible(false)
		winMgr:getWindow("Ranking_player_1st"):setVisible(false)
	end
end

function getInfoTopPlayerNd(
	nameNd, rankingNd, boneNd, totalStarNd)
	local img_CharacterX = 0
	local img_CharacterY = 0

	winMgr:getWindow("Ranking_player_2nd_name"):setText("")
	if totalStarNd > 0 then
		
		winMgr:getWindow("Ranking_player_2nd_brand"):setVisible(true)
		winMgr:getWindow("Ranking_player_2nd_name"):setVisible(true)
		winMgr:getWindow("Ranking_player_2nd"):setVisible(true)

		_G.PersonalBoneType = boneNd

		if boneNd == 0 then
			-- Wells
			img_CharacterX = tRankImgWellsX[2]
			img_CharacterY = tRankImgWellsY[2]
		elseif boneNd == 1 then
			-- Ray
			img_CharacterX = tRankImgRayX[2]
			img_CharacterY = tRankImgRayY[1]
		elseif boneNd == 2 then
			-- Joony
			img_CharacterX = tRankImgJoonyX[2]
			img_CharacterY = tRankImgJoonyY[1]
		elseif boneNd == 3 then
			-- Lilru
			img_CharacterX = tRankImgLilruX[2]
			img_CharacterY = tRankImgLilruY[1]
		elseif boneNd == 4 then
			-- Nicky
			img_CharacterX = tRankImgNickyX[2]
			img_CharacterY = tRankImgNickyY[1]
		elseif boneNd == 5 then
			-- Sera
			img_CharacterX = tRankImgSeraX[2]
			img_CharacterY = tRankImgSeraY[1]
		else
			img_CharacterX = tRankImgSeraX[2]
			img_CharacterY = tRankImgSeraY[1]
		end
		
		local nameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(nameNd))
		winMgr:getWindow("Ranking_player_2nd_name"):setPosition(72-nameSize/2, 91)
		winMgr:getWindow("Ranking_player_2nd_name"):setText(tostring(nameNd))
		winMgr:getWindow("Ranking_player_2nd"):setTexture("Enabled", "UIData/ranking_board.tga", img_CharacterX, img_CharacterY)
		winMgr:getWindow("Ranking_player_2nd"):setTexture("Disabled", "UIData/ranking_board.tga", img_CharacterX, img_CharacterY)
		
	else
		winMgr:getWindow("Ranking_player_2nd_brand"):setVisible(false)
		winMgr:getWindow("Ranking_player_2nd_name"):setVisible(false)
		winMgr:getWindow("Ranking_player_2nd"):setVisible(false)
	end

end

function getInfoTopPlayerRd(
	nameRd, rankingRd, boneRd, totalStarRd)

	local img_CharacterX = 0
	local img_CharacterY = 0

	winMgr:getWindow("Ranking_player_3rd_name"):setText("")
	if totalStarRd > 0 then
		winMgr:getWindow("Ranking_player_3rd_brand"):setVisible(true)
		winMgr:getWindow("Ranking_player_3rd_name"):setVisible(true)
		winMgr:getWindow("Ranking_player_3rd"):setVisible(true)
		if boneRd == 0 then
			-- Wells
			img_CharacterX = tRankImgWellsX[3]
			img_CharacterY = tRankImgWellsY[1]
		elseif boneRd == 1 then
			-- Ray
			img_CharacterX = tRankImgRayX[3]
			img_CharacterY = tRankImgRayY[1]
		elseif boneRd == 2 then
			-- Joony
			img_CharacterX = tRankImgJoonyX[3]
			img_CharacterY = tRankImgJoonyY[1]
		elseif boneRd == 3 then
			-- Lilru
			img_CharacterX = tRankImgLilruX[3]
			img_CharacterY = tRankImgLilruY[1]
		elseif boneRd == 4 then
			-- Nicky
			img_CharacterX = tRankImgNickyX[3]
			img_CharacterY = tRankImgNickyY[1]
		elseif boneRd == 5 then
			-- Sera
			img_CharacterX = tRankImgSeraX[3]
			img_CharacterY = tRankImgSeraY[1]
		else
			img_CharacterX = tRankImgSeraX[3]
			img_CharacterY = tRankImgSeraY[1]
		end
	
		local nameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(nameRd))
		winMgr:getWindow("Ranking_player_3rd_name"):setPosition(72-nameSize/2, 91)
		winMgr:getWindow("Ranking_player_3rd_name"):setText(tostring(nameRd))
		winMgr:getWindow("Ranking_player_3rd"):setTexture("Enabled", "UIData/ranking_board.tga", img_CharacterX, img_CharacterY)
		winMgr:getWindow("Ranking_player_3rd"):setTexture("Disabled", "UIData/ranking_board.tga", img_CharacterX, img_CharacterY)

	else
		winMgr:getWindow("Ranking_player_3rd_brand"):setVisible(false)
		winMgr:getWindow("Ranking_player_3rd_name"):setVisible(false)
		winMgr:getWindow("Ranking_player_3rd"):setVisible(false)
	end

end

--------------------------------------------------------------------
--#New_Ranking
--Loop For Creat Body player
--------------------------------------------------------------------
local loopCreatSpace = 9
	for i=0, loopCreatSpace do
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", i.."_sj_Ranking_Background_Player_Row")
		mywindow:setTexture("Enabled", "UIData/ranking_board.tga", 22, 383)
		mywindow:setTexture("Disabled", "UIData/ranking_board.tga", 22, 383)
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")
		-- mywindow:setWideType(6);
		mywindow:setPosition(0, 240+(36*i))
		mywindow:setSize(495, 37)
		mywindow:setAlwaysOnTop(false)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("sj_Ranking_Background_Image2"):addChildWindow(mywindow)
	end

--#New_Ranking
-- Number Page 

mywindow = winMgr:createWindow("TaharezLook/StaticText", "sj_RankingPageText")
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setSize(95, 31)
mywindow:setPosition(227, 3)
mywindow:setAlphaWithChild(0)
mywindow:setUseEventController(false)
winMgr:getWindow('sj_Ranking_Background_Image3_Footer'):addChildWindow(mywindow)

function ShowRankPageInfo(currPage, maxPage)
	local pageText = tostring(currPage.."  /  "..maxPage)
	local pageSize = GetStringSize(g_STRING_FONT_GULIMCHE, 16, pageText)
	winMgr:getWindow("sj_RankingPageText"):setText(pageText)
end

--------------------------------------------------------------------

-- ??? ?ขฏ? ???
--#New_Ranking
--------------------------------------------------------------------
local tRankLRButtonName  = {["err"]=0, "sj_Ranking_LBtn", "sj_Ranking_RBtn"}
local tRankLRButtonTexX  = {["err"]=0, 987, 970}
local tRankLRButtonPosX  = {["err"]=0, 178, 304}
local tRankLRButtonEvent = {["err"]=0, "Prev_RankInfo", "Next_RankInfo"}
for i=1, #tRankLRButtonName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tRankLRButtonName[i])
	mywindow:setTexture("Normal", "UIData/myinfo.tga", tRankLRButtonTexX[i], 0)
	mywindow:setTexture("Hover", "UIData/myinfo.tga", tRankLRButtonTexX[i], 22)
	mywindow:setTexture("Pushed", "UIData/myinfo.tga", tRankLRButtonTexX[i], 44)
	mywindow:setTexture("PushedOff", "UIData/myinfo.tga", tRankLRButtonTexX[i], 0)
	--mywindow:setPosition(tRankLRButtonPosX[i], 452)
	mywindow:setPosition(tRankLRButtonPosX[i], 6)
	mywindow:setSize(17, 22)
	mywindow:setZOrderingEnabled(false)
	mywindow:setSubscribeEvent("Clicked", tRankLRButtonEvent[i])
	winMgr:getWindow("sj_Ranking_Background_Image3_Footer"):addChildWindow(mywindow)
end


function Prev_RankInfo()
	reset_Value_Mode()
	-- local type, curPage, maxPage = GetCurrentRankType()	
	local curPage = GetCurrentRankType()	
	-- curPage = curPage - 1
	-- if curPage <= 1 then
	-- 	curPage = 1
	-- end
	ChangeRankingPage(curPage, 0)
	
	-- ????? ??????? ???? ?????
	-- ClearFindInfos()
end


function Next_RankInfo()
	reset_Value_Mode()
	-- local type, curPage, maxPage = GetCurrentRankType()	
	local curPage = GetCurrentRankType()	
	-- curPage = curPage + 1
	-- if curPage >= maxPage then
	-- 	curPage = maxPage
	-- end
	ChangeRankingPage(curPage, 1)
	
	-- ????? ??????? ???? ?????
	-- ClearFindInfos()
end







--------------------------------------------------------------------

-- ???? ?????
--#New_Ranking
-- Close Button
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_Ranking_CloseBtn")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setPosition(464, 6)
mywindow:setSize(23, 23)
mywindow:setZOrderingEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setSubscribeEvent("Clicked", "CloseRankingList")
winMgr:getWindow("sj_Ranking_Background_Image"):addChildWindow(mywindow)


-- ��ŷâ�� �ݴ´�.
function CloseRankingList()
	root:addChildWindow(winMgr:getWindow("sj_Ranking_Background_Image"))
	winMgr:getWindow("sj_Ranking_Background_Image"):setVisible(false)
	CloseRank()
	
	-- �ʱ�ȭ(��� ��ŷŸ�� 0��������)
	for i=0, #tRankName do
		winMgr:getWindow(tRankName[i]):setProperty("Selected", "false")
	end
	
	for i=0, #tRankName2 do
		winMgr:getWindow(tRankName2[i]):setProperty("Selected", "false")
	end
	
	-- �˻��� �����ִ� �׵θ� ���߱�
	ClearFindInfos()
end


-- ��ŷ �����̹��� ESCŰ ���
RegistEscEventInfo("sj_Ranking_Background_Image", "CloseRankingList")



--------------------------------------------------------------------

-- ��ŷâ�� �����ش�.

--------------------------------------------------------------------
function ShowRankingList(rankType)
	root:addChildWindow(winMgr:getWindow("sj_Ranking_Background_Image"))
	winMgr:getWindow("sj_Ranking_Background_Image"):setVisible(true)
	if g_curTabGroup == 0 then
		winMgr:getWindow(tRankName[rankType]):setProperty("Selected", "true")
	elseif g_curTabGroup == 1 then
		winMgr:getWindow(tRankName2[rankType]):setProperty("Selected", "true")
	end
	
	CEGUI.toRadioButton(winMgr:getWindow(tRankName2[0])):setSelected(true)
	ChangeRankType();
end



--------------------------------------------------------------------

-- ���� ���̴� ��ŷ ������ �����Ѵ�.
--#New_Ranking
--Get detail Info Rank
--------------------------------------------------------------------
-- function CurrentRankInfo(rankType, index, isRank, changeRank, rankQuantity, ladder, level, name, info1, info2)
-- 	if rankType == nil then
-- 		rankType = 100
-- 	end
-- 	winMgr:getWindow(index .. "sj_userInfo_matchmaking_rank"):setVisible(false)
-- 	-- ???? ?????? ????????? ???? ????
-- 	if isRank > 0 then
	
-- 		-- ????
-- 		local szRank = CommatoMoneyStr(isRank)
-- 		local rankText = tostring(szRank).." ("
-- 		local rankSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(rankText))
-- 		winMgr:getWindow(index .. "sj_userInfo_rank"):setPosition(64-rankSize, 5)
-- 		winMgr:getWindow(index .. "sj_userInfo_rank"):setText(tostring(rankText))
		
		
-- 		-- ???? ????		
-- 		if changeRank == 0 then
-- 			local rank1 = "- )"
-- 			winMgr:getWindow(index .. "sj_userInfo_rankChangeImage"):setVisible(false)
-- 			winMgr:getWindow(index .. "sj_userInfo_rankChange"):setVisible(true)
-- 			winMgr:getWindow(index .. "sj_userInfo_rankChange"):setPosition(70, 8)
-- 			winMgr:getWindow(index .. "sj_userInfo_rankChange"):clearTextExtends()
-- 			winMgr:getWindow(index .. "sj_userInfo_rankChange"):addTextExtends(rank1, g_STRING_FONT_GULIMCHE,12,	255, 255, 255, 255,   0, 255,255,255,255)
			
-- 		elseif changeRank == 1 then
-- 			local rank1 = rankQuantity .. ")"			
-- 			winMgr:getWindow(index .. "sj_userInfo_rankChangeImage"):setVisible(true)
-- 			winMgr:getWindow(index .. "sj_userInfo_rankChangeImage"):setTexture("Enabled", "UIData/ranking.tga", 297, 195)
-- 			winMgr:getWindow(index .. "sj_userInfo_rankChangeImage"):setTexture("Disabled", "UIData/ranking.tga", 297, 195)
-- 			winMgr:getWindow(index .. "sj_userInfo_rankChange"):setVisible(true)
-- 			winMgr:getWindow(index .. "sj_userInfo_rankChange"):setPosition(76, 8)
-- 			winMgr:getWindow(index .. "sj_userInfo_rankChange"):clearTextExtends()
-- 			winMgr:getWindow(index .. "sj_userInfo_rankChange"):addTextExtends(rank1, g_STRING_FONT_GULIMCHE,12,	255, 255, 255, 255,   0, 255,255,255,255)
			
-- 		elseif changeRank == 2 then
-- 			local rank1 = rankQuantity .. ")"			
-- 			winMgr:getWindow(index .. "sj_userInfo_rankChangeImage"):setVisible(true)
-- 			winMgr:getWindow(index .. "sj_userInfo_rankChangeImage"):setTexture("Enabled", "UIData/ranking.tga", 307, 195)
-- 			winMgr:getWindow(index .. "sj_userInfo_rankChangeImage"):setTexture("Disabled", "UIData/ranking.tga", 307, 195)
-- 			winMgr:getWindow(index .. "sj_userInfo_rankChange"):setVisible(true)
-- 			winMgr:getWindow(index .. "sj_userInfo_rankChange"):setPosition(76, 8)
-- 			winMgr:getWindow(index .. "sj_userInfo_rankChange"):clearTextExtends()
-- 			winMgr:getWindow(index .. "sj_userInfo_rankChange"):addTextExtends(rank1, g_STRING_FONT_GULIMCHE,12,	255, 255, 255, 255,   0, 255,255,255,255)
-- 		end
				
		
-- 		-- ????
-- 		if ladder >= 0 then
-- 			winMgr:getWindow(index .. "sj_userInfo_ladder"):setVisible(true)
-- 			winMgr:getWindow(index .. "sj_userInfo_ladder"):setTexture("Enabled", "UIData/numberUI001.tga", 113, 600+21*ladder)
-- 		end
		
-- 		if rankType == 100 then
-- 			winMgr:getWindow(index .. "sj_userInfo_ladder"):setVisible(false)
-- 			winMgr:getWindow(index .. "sj_userInfo_matchmaking_rank"):setVisible(true)
-- 			mywindow = winMgr:createWindow("TaharezLook/StaticImage", index .. "sj_userInfo_matchmaking_rank")
-- 			mywindow = drawRankWindow(mywindow, ladder, 111, 0, 120)
-- 		else
-- 			winMgr:getWindow(index .. "sj_userInfo_matchmaking_rank"):setVisible(false)
-- 		end
		
-- 		-- ????
-- 		winMgr:getWindow(index .. "sj_userInfo_level"):setPosition(174, 5)
-- 		winMgr:getWindow(index .. "sj_userInfo_level"):setText("Lv."..level)
		
		
-- 		-- ???
-- 		local nameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 112, name)
-- 		winMgr:getWindow(index .. "sj_userInfo_name"):setPosition(280-nameSize/2, 5)
-- 		winMgr:getWindow(index .. "sj_userInfo_name"):setText(name)
		
		
-- 		-- ????1
-- 		local expSize = GetStringSize(g_STRING_FONT_GULIMCHE, 112, info1)
-- 		winMgr:getWindow(index .. "sj_userInfo_info1"):setPosition(402-expSize/2, 5)
-- 		winMgr:getWindow(index .. "sj_userInfo_info1"):setText(info1)
	
	
-- 	-- ???? ?????? ????????? ???? ????
-- 	else
-- 		-- ????
-- 		winMgr:getWindow(index .. "sj_userInfo_rank"):setText("")
		
-- 		-- ???????? ?????
-- 		winMgr:getWindow(index .. "sj_userInfo_rankChangeImage"):setVisible(false)
		
-- 		-- ???????? ????
-- 		winMgr:getWindow(index .. "sj_userInfo_rankChange"):setVisible(false)
-- 		winMgr:getWindow(index .. "sj_userInfo_rankChange"):clearTextExtends()
		
-- 		-- ????(??????? ????????)
-- 		winMgr:getWindow(index .. "sj_userInfo_ladder"):setVisible(false)
		
-- 		-- ????
-- 		winMgr:getWindow(index .. "sj_userInfo_level"):setText("")
		
-- 		-- ???
-- 		winMgr:getWindow(index .. "sj_userInfo_name"):setText("")
		
-- 		-- ????1
-- 		winMgr:getWindow(index .. "sj_userInfo_info1"):setText("")
-- 	end
-- end

function CurrentRankInfo(indexs, isRanks, levels, rankNames, names, starts)
	local index = tonumber(indexs)-1 or 0
	local isRank = tonumber(isRanks) or 0
	local level = tonumber(levels) or 0
	local rankName = tostring(rankNames or "Unknown")
	local name = tostring(names or "N/A")
	local start = tostring(starts or "0")

		-- cacheListPlayer[index] = {
        --     RankID = isRank,
        --     RowNum = index,
        --     current_rank = start,
        --     level = level,
        --     player_name = name,
        --     rank_name = rankName
        -- }
		-- LOG("index : "..index)
		-- LOG("name : "..name)

	winMgr:getWindow(index .. "sj_userInfo_matchmaking_rank"):setVisible(false)
	-- ���� ������ ��ŷ������ ���� ���
	if isRank > 0 then
		-- ????
		-- local szRank = CommatoMoneyStr(isRank)
		-- local rankText = tostring(szRank)
		-- local rankSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(rankText))

		-- winMgr:getWindow(index .. "sj_userInfo_rank"):setText(tostring(rankText))
		
		-- Set the rank icon based on the rankName
		winMgr:getWindow(index .. "sj_userInfo_rank"):setVisible(true)
		if isRank >= 1 and isRank <= 3 then
			winMgr:getWindow(index .. "sj_userInfo_rank"):setTexture("Enabled", "UIData/Raking_Badge.png", 70, 35)
			winMgr:getWindow(index .. "sj_userInfo_rank"):setPosition(44, 1)

		elseif isRank >= 4 and isRank <= 6 then
			winMgr:getWindow(index .. "sj_userInfo_rank"):setTexture("Enabled", "UIData/Raking_Badge.png", 70, 246)
			winMgr:getWindow(index .. "sj_userInfo_rank"):setPosition(46, 1)
			
		elseif isRank >= 7 and isRank <= 11 then
			winMgr:getWindow(index .. "sj_userInfo_rank"):setTexture("Enabled", "UIData/Raking_Badge.png", 70, 440)
			winMgr:getWindow(index .. "sj_userInfo_rank"):setPosition(46, 1)
			
		elseif isRank >= 12 and isRank <= 16 then
			winMgr:getWindow(index .. "sj_userInfo_rank"):setTexture("Enabled", "UIData/Raking_Badge.png", 45, 650)
			winMgr:getWindow(index .. "sj_userInfo_rank"):setPosition(43, 1)
			
		elseif isRank >= 17 and isRank <= 21 then
			winMgr:getWindow(index .. "sj_userInfo_rank"):setTexture("Enabled", "UIData/Raking_Badge.png", 45, 870)
			winMgr:getWindow(index .. "sj_userInfo_rank"):setPosition(41, -4)
			
		elseif isRank >= 22 and isRank <= 26 then
			winMgr:getWindow(index .. "sj_userInfo_rank"):setTexture("Enabled", "UIData/Raking_Badge.png", 45, 1075)
			winMgr:getWindow(index .. "sj_userInfo_rank"):setPosition(42, -5)
			
		elseif isRank >= 27 and isRank <= 31 then
			winMgr:getWindow(index .. "sj_userInfo_rank"):setTexture("Enabled", "UIData/Raking_Badge.png", 30, 1285)
			winMgr:getWindow(index .. "sj_userInfo_rank"):setPosition(38, -5)
			
		elseif isRank >= 32 and isRank <= 36 then
			winMgr:getWindow(index .. "sj_userInfo_rank"):setTexture("Enabled", "UIData/Raking_Badge.png", 45, 1520)
			winMgr:getWindow(index .. "sj_userInfo_rank"):setPosition(41, -5)
			
		elseif isRank >= 37 then
			winMgr:getWindow(index .. "sj_userInfo_rank"):setTexture("Enabled", "UIData/Raking_Badge.png", 25, 1800)
			winMgr:getWindow(index .. "sj_userInfo_rank"):setPosition(37, 0)

		elseif isRank <= 1 then
			winMgr:getWindow(index .. "sj_userInfo_rank"):setVisible(false)
		else
			print("Unknown rank: " .. rankName)
		end

		-- ����
		winMgr:getWindow(index .. "sj_userInfo_level"):setPosition(124, 5)
		winMgr:getWindow(index .. "sj_userInfo_level"):setText("Lv."..level)
		winMgr:getWindow(index .. "sj_userInfo_level"):setVisible(true)

		-- �̸�
		local nameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 112, name)
		winMgr:getWindow(index .. "sj_userInfo_name"):setPosition(220, 5)
		-- winMgr:getWindow(index .. "sj_userInfo_name"):setPosition(280-nameSize/2, 5)
		winMgr:getWindow(index .. "sj_userInfo_name"):setText(name)
		winMgr:getWindow(index .. "sj_userInfo_name"):setVisible(true)
		
		-- ����1
		local startSize = GetStringSize(g_STRING_FONT_GULIMCHE, 112, start)
		winMgr:getWindow(index .. "sj_userInfo_info1"):setPosition(419-startSize/2, 5)
		winMgr:getWindow(index .. "sj_userInfo_info1"):setText(start)
		winMgr:getWindow(index .. "sj_userInfo_info1"):setVisible(true)
	
	-- ���� ������ ��ŷ������ ���� ���
	-- else
	-- -- ����
	-- 	winMgr:getWindow(index .. "sj_userInfo_rank"):setPosition(36, 2)
	-- 	winMgr:getWindow(index .. "sj_userInfo_rank"):setTexture("Enabled", "UIData/Raking_Badge.png", 70, 35)
	-- 	winMgr:getWindow(index .. "sj_userInfo_rank"):setVisible(false)
		
	-- 	-- �������� �?���
	-- 	winMgr:getWindow(index .. "sj_userInfo_rankChangeImage"):setVisible(false)
		
	-- 	-- �������� �?�?
	-- 	winMgr:getWindow(index .. "sj_userInfo_rankChange"):setVisible(false)
	-- 	winMgr:getWindow(index .. "sj_userInfo_rankChange"):clearTextExtends()
		
	-- 	winMgr:getWindow(index .. "sj_userInfo_rank"):setVisible(false)

	-- 	-- ����
	-- 	winMgr:getWindow(index .. "sj_userInfo_level"):setText("")
		
	-- 	-- �?�
	-- 	winMgr:getWindow(index .. "sj_userInfo_name"):setText("")
		
	-- 	-- ����1
	-- 	winMgr:getWindow(index .. "sj_userInfo_info1"):setText("")
	end
end



g_TourCurrentPage = 1
g_TourMaxPage = 1


--------------------------------------------------------------------

-- ��ʸ�Ʈ ��ŷâ �⺻ ���� ������

--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TourRanking_Background_Image")
mywindow:setTexture("Enabled", "UIData/ranking.tga", 525, 0)
mywindow:setTexture("Disabled", "UIData/ranking.tga", 525, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(263, 116)
mywindow:setSize(495, 494)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TourRanking_Background_Notice")
mywindow:setTexture("Enabled", "UIData/ranking.tga", 567, 645)
mywindow:setTexture("Disabled", "UIData/ranking.tga", 567, 645)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(35, 45)
mywindow:setSize(428, 21)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("TourRanking_Background_Image"):addChildWindow(mywindow)

-- Ÿ��Ʋ��
mywindow = winMgr:createWindow("TaharezLook/Titlebar", "Tour_Ranking_Titlebar")
mywindow:setPosition(3, 1)
mywindow:setSize(460, 45)
winMgr:getWindow("TourRanking_Background_Image"):addChildWindow(mywindow)

RegistEscEventInfo("TourRanking_Background_Image", "CloseTourRankingList")

-- �������� ���� �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TourRanking_StageImage")
mywindow:setTexture("Enabled", "UIData/ranking.tga", 328, 390)
mywindow:setTexture("Disabled", "UIData/ranking.tga", 328, 390)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(313 ,86)
mywindow:setSize(78,21)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("TourRanking_Background_Image"):addChildWindow(mywindow)

-- Ÿ�� ���� �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TourRanking_TimeImage")
mywindow:setTexture("Enabled", "UIData/ranking.tga", 328, 416)
mywindow:setTexture("Disabled", "UIData/ranking.tga", 328, 416)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(392, 86)
mywindow:setSize(78,21)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("TourRanking_Background_Image"):addChildWindow(mywindow)
--------------------------------------------------------------------

-- ��ʸ�Ʈ ��ŷ�˻� ����Ʈ �ڽ�

--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Editbox", "Tour_Ranking_Find_text")
mywindow:setPosition(66, 86)
mywindow:setSize(200, 24)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setAlphaWithChild(0)
mywindow:setUseEventController(false)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("TextAccepted", "ClickFindTourRankUser")
CEGUI.toEditbox(mywindow):setMaxTextLength(12)
CEGUI.toEditbox(mywindow):subscribeEvent("EditboxFull", "OnEditboxFullEvent")
winMgr:getWindow("TourRanking_Background_Image"):addChildWindow(mywindow)

-- �˻� ã�� ��ư
mywindow = winMgr:createWindow("TaharezLook/Button", "Tour_Ranking_FindBtn")
mywindow:setTexture("Normal", "UIData/ranking.tga", 297, 112+26)
mywindow:setTexture("Hover", "UIData/ranking.tga", 297, 112)
mywindow:setTexture("Pushed", "UIData/ranking.tga", 297, 112+52)
mywindow:setTexture("PushedOff", "UIData/ranking.tga", 297, 112+26)
mywindow:setTexture("Enabled", "UIData/ranking.tga", 297, 112+26)
mywindow:setTexture("Disabled", "UIData/ranking.tga", 297, 112+26)
mywindow:setPosition(223, 85)
mywindow:setSize(59, 25)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickFindTourRankUser")
winMgr:getWindow("TourRanking_Background_Image"):addChildWindow(mywindow)


-- ��ʸ�Ʈ �˻�ã�� ��ư�� Ŭ���� ��
function ClickFindTourRankUser()

	local findUserName = winMgr:getWindow("Tour_Ranking_Find_text"):getText()
	
	if findUserName ~= "" then
		GetTournamentRankName(findUserName)
	end
	winMgr:getWindow("Tour_Ranking_Find_text"):setText("")
end

--------------------------------------------------------------------

-- ��ʸ�Ʈ ��ŷ���� ���� ������

--------------------------------------------------------------------

for i=0, 9 do
	
	-- ���� �̹���	
	backwindow = winMgr:createWindow("TaharezLook/StaticImage", i.."Tour_userInfo_backImage")
	backwindow:setTexture("Enabled", "UIData/ranking.tga", 551, 555)
	backwindow:setTexture("Disabled", "UIData/ranking.tga", 551, 555)
	backwindow:setProperty("FrameEnabled", "False")
	backwindow:setProperty("BackgroundEnabled", "False")
	backwindow:setPosition(11, 116+(i*33))
	backwindow:setSize(473, 29)
	backwindow:setZOrderingEnabled(false)
	winMgr:getWindow("TourRanking_Background_Image"):addChildWindow(backwindow)
					
	-- �˻��� ���� â
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i.."Tour_userInfo_findImage")
	mywindow:setTexture("Enabled", "UIData/ranking.tga", 551, 585)
	mywindow:setTexture("Disabled", "UIData/ranking.tga", 551, 585)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(11, 116+(i*33))
	mywindow:setSize(473, 29)
	mywindow:setVisible(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("TourRanking_Background_Image"):addChildWindow(mywindow)

	-- ����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i.."Tour_userInfo_rank")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setText("")
	mywindow:setPosition(64, 8)
	mywindow:setSize(40, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(i.."Tour_userInfo_backImage"):addChildWindow(mywindow)
	
	
	-- ����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i.."Tour_userInfo_level")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 112)
	mywindow:setText("")
	mywindow:setPosition(120, 5)
	mywindow:setSize(40, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(i.."Tour_userInfo_backImage"):addChildWindow(mywindow)
	
	-- �̸�
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i.."Tour_userInfo_name")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 112)
	mywindow:setText("")
	mywindow:setPosition(225, 5)
	mywindow:setSize(40, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(i.."Tour_userInfo_backImage"):addChildWindow(mywindow)
	
	-- ����1
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i.."Tour_userInfo_info1")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 112)
	mywindow:setText("")
	mywindow:setPosition(320, 5)
	mywindow:setSize(40, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(i.."Tour_userInfo_backImage"):addChildWindow(mywindow)

	-- ����2
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i.."Tour_userInfo_info2")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 112)
	mywindow:setText("")
	mywindow:setPosition(375, 5)
	mywindow:setSize(60, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(i.."Tour_userInfo_backImage"):addChildWindow(mywindow)
end

--------------------------------------------------------------------

-- ��ʸ�Ʈ ��ŷ �¿� ��ư

--------------------------------------------------------------------
local TourRankLRButtonName  = {["err"]=0, "Tour_Ranking_LBtn", "Tour_Ranking_RBtn"}
local TourRankLRButtonTexX  = {["err"]=0, 987, 970}
local TourRankLRButtonPosX  = {["err"]=0, 178, 304}
local TourRankLRButtonEvent = {["err"]=0, "Prev_TourRankInfo", "Next_TourRankInfo"}
for i=1, #TourRankLRButtonName do
	mywindow = winMgr:createWindow("TaharezLook/Button", TourRankLRButtonName[i])
	mywindow:setTexture("Normal", "UIData/myinfo.tga", TourRankLRButtonTexX[i], 0)
	mywindow:setTexture("Hover", "UIData/myinfo.tga", TourRankLRButtonTexX[i], 22)
	mywindow:setTexture("Pushed", "UIData/myinfo.tga", TourRankLRButtonTexX[i], 44)
	mywindow:setTexture("PushedOff", "UIData/myinfo.tga", TourRankLRButtonTexX[i], 0)
	mywindow:setPosition(TourRankLRButtonPosX[i], 455)
	mywindow:setSize(17, 22)
	mywindow:setZOrderingEnabled(false)
	mywindow:setSubscribeEvent("Clicked", TourRankLRButtonEvent[i])
	winMgr:getWindow("TourRanking_Background_Image"):addChildWindow(mywindow)
end


-- ��ʸ�Ʈ ���������� / �ִ�������
mywindow = winMgr:createWindow("TaharezLook/StaticText", "Tour_RankingPageText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 16)
mywindow:setPosition(210, 458)
mywindow:setSize(80, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:clearTextExtends()
mywindow:setZOrderingEnabled(false)
mywindow:addTextExtends(tostring(g_TourCurrentPage)..' / '..tostring(g_TourMaxPage), g_STRING_FONT_GULIMCHE, 14,    230,230,230,255,     0,     0,0,0,255)
winMgr:getWindow('TourRanking_Background_Image'):addChildWindow(mywindow)


------------------------------------
---��ʸ�Ʈ �����������̺�Ʈ---------
------------------------------------
		 
function Prev_TourRankInfo()
     
     DebugStr('Prev_TourRankInfo');
	if	g_TourCurrentPage > 1 then
			--g_TourCurrentPage = g_TourCurrentPage - 1
			GetTournamentRankPage(g_TourCurrentPage -1)
	end
	
end



------------------------------------
---��ʸ�Ʈ �����������̺�Ʈ---------
------------------------------------
function Next_TourRankInfo()
  
	DebugStr('Next_TourRankInfo');
	if	g_TourCurrentPage < g_TourMaxPage then
			--g_TourCurrentPage = g_TourCurrentPage + 1
			GetTournamentRankPage(g_TourCurrentPage + 1)
	end
end

function SettingTournamentPage(CurrentPage , MaxPage)
	g_TourCurrentPage = CurrentPage
	g_TourMaxPage = MaxPage
	if g_TourCurrentPage > g_TourMaxPage then
		g_TourCurrentPage = g_TourMaxPage
	end
	winMgr:getWindow('Tour_RankingPageText'):clearTextExtends()
	winMgr:getWindow('Tour_RankingPageText'):addTextExtends(tostring(g_TourCurrentPage)..' / '..tostring(g_TourMaxPage), g_STRING_FONT_GULIMCHE, 14,    230,230,230,255,     0,     0,0,0,255)
end

--------------------------------------------------------------------

-- ��ʸ�Ʈ ��ŷâ �ݱ��ư

--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "Tour_Ranking_CloseBtn")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setPosition(464, 6)
mywindow:setSize(23, 23)
mywindow:setZOrderingEnabled(false)
mywindow:setSubscribeEvent("Clicked", "CloseTourRankingList")
winMgr:getWindow("TourRanking_Background_Image"):addChildWindow(mywindow)


-- ��ʸ�Ʈ ��ŷâ�� �ݴ´�.
function CloseTourRankingList()
	winMgr:getWindow("TourRanking_Background_Image"):setVisible(false)
	winMgr:getWindow("Tour_Ranking_Find_text"):setText("")
	winMgr:getWindow("Tour_Ranking_Find_text"):deactivate()
	CloseRank()
end

function GetTournamentInfo()
	g_TourCurrentPage = 1
	GetTournamentRankPage(g_TourCurrentPage)
	root:addChildWindow(winMgr:getWindow("TourRanking_Background_Image"))
	winMgr:getWindow("TourRanking_Background_Image"):setVisible(true)
end

function ClearTourRankInfo()

	for i=0, 9 do
		winMgr:getWindow(i .. "Tour_userInfo_rank"):setText("")
		winMgr:getWindow(i .. "Tour_userInfo_level"):setText("")
		winMgr:getWindow(i .. "Tour_userInfo_name"):setText("")
		winMgr:getWindow(i .. "Tour_userInfo_info1"):setText("")
		winMgr:getWindow(i .. "Tour_userInfo_info2"):setText("")
		winMgr:getWindow(i .. "Tour_userInfo_findImage"):setVisible(false)
	end
	
end

function UpdateTourRankInfo(index, Rank,  level, name, stage, time)
		
		-- ����
		local szRank = CommatoMoneyStr(Rank)
		local rankText = tostring(szRank)
		local rankSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(rankText))
		winMgr:getWindow(index .. "Tour_userInfo_rank"):setPosition(64-rankSize, 5)
		winMgr:getWindow(index .. "Tour_userInfo_rank"):setText(tostring(rankText))
							
		-- ����
		winMgr:getWindow(index .. "Tour_userInfo_level"):setPosition(120, 5)
		winMgr:getWindow(index .. "Tour_userInfo_level"):setText("Lv."..level)
		
		
		-- �̸�
		local nameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 112, name)
		winMgr:getWindow(index .. "Tour_userInfo_name"):setPosition(240-nameSize/2, 5)
		winMgr:getWindow(index .. "Tour_userInfo_name"):setText(name)
			
		-- ��������
		local StageSize = GetStringSize(g_STRING_FONT_GULIMCHE, 112, stage)
		winMgr:getWindow(index .. "Tour_userInfo_info1"):setPosition(340-StageSize/2, 5)
		winMgr:getWindow(index .. "Tour_userInfo_info1"):setText(stage)
		
		-- Ÿ��
		local TimeSize = GetStringSize(g_STRING_FONT_GULIMCHE, 112, time)
		winMgr:getWindow(index .. "Tour_userInfo_info2"):setPosition(422-TimeSize/2, 5)
		winMgr:getWindow(index .. "Tour_userInfo_info2"):setText(time)
		
end

function SettingSearchSelect(index)
	DebugStr('SettingSearchSelect()')
	if index > 0 then
		local RealIndex = index-1
		winMgr:getWindow(RealIndex.."Tour_userInfo_findImage"):setVisible(true)
	end
end


-- ���� Ȯ�� ��ư
mywindow = winMgr:createWindow("TaharezLook/Button", "TourRanking_RewardBtn")
mywindow:setTexture("Normal", "UIData/ranking.tga", 590, 748)
mywindow:setTexture("Hover", "UIData/ranking.tga",  590, 775)
mywindow:setTexture("Pushed", "UIData/ranking.tga",  590, 802)
mywindow:setTexture("PushedOff", "UIData/ranking.tga", 590, 748)
mywindow:setTexture("Disabled", "UIData/ranking.tga", 590, 829)
mywindow:setPosition(363, 452)
mywindow:setSize(94, 27)
mywindow:setZOrderingEnabled(false)
--if IsKoreanLanguage() then
	mywindow:setVisible(false)
--else
--	mywindow:setVisible(true)
--end
mywindow:subscribeEvent("Clicked", "OnClickTourRankingReward")
winMgr:getWindow("TourRanking_Background_Image"):addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/StaticImage", "TourRanking_RewardImage")
mywindow:setTexture("Enabled", "UIData/Event_RankingImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/Event_RankingImage.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setAlwaysOnTop(true)
mywindow:setWideType(6)
mywindow:setPosition(200, 150)
mywindow:setSize(611, 413)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

function OnClickTourRankingReward()	
	root:addChildWindow(winMgr:getWindow("TourRanking_RewardImage"))
	winMgr:getWindow("TourRanking_RewardImage"):setVisible(true)
end


--------------------------------------------------------------------

-- ��ʸ�Ʈ ����â �ݱ��ư

--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "Tour_RankingReward_CloseBtn")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setPosition(564, 10)
mywindow:setSize(23, 23)
mywindow:setZOrderingEnabled(false)
mywindow:setSubscribeEvent("Clicked", "OnClickCloseTourReward")
winMgr:getWindow("TourRanking_RewardImage"):addChildWindow(mywindow)

RegistEscEventInfo("TourRanking_RewardImage", "OnClickCloseTourReward")

-- ��ʸ�Ʈ ��ŷâ�� �ݴ´�.
function OnClickCloseTourReward()
	winMgr:getWindow("TourRanking_RewardImage"):setVisible(false)
end

































g_AutoCurrentPage = 1
g_AutoMaxPage = 1



--------------------------------------------------------------------

-- �ڵ���ġ ��ŷâ �⺻ ���� ������

--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "AutoRanking_Background_Image")
mywindow:setTexture("Enabled", "UIData/ranking2.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/ranking2.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(263, 116)
mywindow:setSize(496, 458)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "AutoRanking_Background_Notice")
mywindow:setTexture("Enabled", "UIData/ranking.tga", 567, 645)
mywindow:setTexture("Disabled", "UIData/ranking.tga", 567, 645)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(35, 45)
mywindow:setSize(428, 21)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("AutoRanking_Background_Image"):addChildWindow(mywindow)

-- Ÿ��Ʋ��
mywindow = winMgr:createWindow("TaharezLook/Titlebar", "Auto_Ranking_Titlebar")
mywindow:setPosition(3, 1)
mywindow:setSize(460, 45)
winMgr:getWindow("AutoRanking_Background_Image"):addChildWindow(mywindow)

RegistEscEventInfo("AutoRanking_Background_Image", "CloseAutoRankingList")


--------------------------------------------------------------------

-- �ڵ���ġ ��ŷ�˻� ����Ʈ �ڽ�

--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Editbox", "Auto_Ranking_Find_text")
mywindow:setPosition(66, 86)
mywindow:setSize(200, 24)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setAlphaWithChild(0)
mywindow:setUseEventController(false)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("TextAccepted", "ClickFindAutoRankUser")
CEGUI.toEditbox(mywindow):setMaxTextLength(12)
CEGUI.toEditbox(mywindow):subscribeEvent("EditboxFull", "OnEditboxFullEvent")
--winMgr:getWindow("AutoRanking_Background_Image"):addChildWindow(mywindow)

-- �˻� ã�� ��ư
mywindow = winMgr:createWindow("TaharezLook/Button", "Auto_Ranking_FindBtn")
mywindow:setTexture("Normal", "UIData/ranking.tga", 297, 112+26)
mywindow:setTexture("Hover", "UIData/ranking.tga", 297, 112)
mywindow:setTexture("Pushed", "UIData/ranking.tga", 297, 112+52)
mywindow:setTexture("PushedOff", "UIData/ranking.tga", 297, 112+26)
mywindow:setTexture("Enabled", "UIData/ranking.tga", 297, 112+26)
mywindow:setTexture("Disabled", "UIData/ranking.tga", 297, 112+26)
mywindow:setPosition(223, 85)
mywindow:setSize(59, 25)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ClickFindAutoRankUser")
--winMgr:getWindow("AutoRanking_Background_Image"):addChildWindow(mywindow)


-- �ڵ���ġ �˻�ã�� ��ư�� Ŭ���� ��
function ClickFindAutoRankUser()

	local findUserName = winMgr:getWindow("Auto_Ranking_Find_text"):getText()
	
	if findUserName ~= "" then
		GetAutoRankName(findUserName)
	end
	winMgr:getWindow("Auto_Ranking_Find_text"):setText("")
end

--------------------------------------------------------------------

-- �ڵ���ġ ��ŷ���� ���� ������

--------------------------------------------------------------------

for i=0, 9 do
	
	-- ���� �̹���	
	backwindow = winMgr:createWindow("TaharezLook/StaticImage", i.."Auto_userInfo_backImage")
	backwindow:setTexture("Enabled", "UIData/ranking.tga", 551, 555)
	backwindow:setTexture("Disabled", "UIData/ranking.tga", 551, 555)
	backwindow:setProperty("FrameEnabled", "False")
	backwindow:setProperty("BackgroundEnabled", "False")
	backwindow:setPosition(11, 90+(i*33))
	backwindow:setSize(473, 29)
	backwindow:setZOrderingEnabled(false)
	winMgr:getWindow("AutoRanking_Background_Image"):addChildWindow(backwindow)
					
	-- �˻��� ���� â
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", i.."Auto_userInfo_findImage")
	mywindow:setTexture("Enabled", "UIData/ranking.tga", 551, 585)
	mywindow:setTexture("Disabled", "UIData/ranking.tga", 551, 585)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(11, 116+(i*33))
	mywindow:setSize(473, 29)
	mywindow:setVisible(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("AutoRanking_Background_Image"):addChildWindow(mywindow)

	-- ����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i.."Auto_userInfo_rank")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 12)
	mywindow:setText("")
	mywindow:setPosition(64, 8)
	mywindow:setSize(40, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(i.."Auto_userInfo_backImage"):addChildWindow(mywindow)
	
	
	-- ����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i.."Auto_userInfo_level")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 112)
	mywindow:setText("")
	mywindow:setPosition(120, 5)
	mywindow:setSize(40, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(i.."Auto_userInfo_backImage"):addChildWindow(mywindow)
	
	-- �̸�
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i.."Auto_userInfo_name")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 112)
	mywindow:setText("")
	mywindow:setPosition(225, 5)
	mywindow:setSize(40, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(i.."Auto_userInfo_backImage"):addChildWindow(mywindow)
	
	-- ����1
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i.."Auto_userInfo_info1")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 112)
	mywindow:setText("")
	mywindow:setPosition(320, 5)
	mywindow:setSize(40, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(i.."Auto_userInfo_backImage"):addChildWindow(mywindow)

	-- ����2
	mywindow = winMgr:createWindow("TaharezLook/StaticText", i.."Auto_userInfo_info2")
	mywindow:setProperty("FrameEnabled", "false")
	mywindow:setProperty("BackgroundEnabled", "false")
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 112)
	mywindow:setText("")
	mywindow:setPosition(375, 5)
	mywindow:setSize(60, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow(i.."Auto_userInfo_backImage"):addChildWindow(mywindow)
end

--------------------------------------------------------------------

-- �ڵ���ġ ��ŷ �¿� ��ư

--------------------------------------------------------------------
local AutoRankLRButtonName  = {["err"]=0, "Auto_Ranking_LBtn", "Auto_Ranking_RBtn"}
local AutoRankLRButtonTexX  = {["err"]=0, 987, 970}
local AutoRankLRButtonPosX  = {["err"]=0, 178, 304}
local AutoRankLRButtonEvent = {["err"]=0, "Prev_AutoRankInfo", "Next_AutoRankInfo"}
for i=1, #AutoRankLRButtonName do
	mywindow = winMgr:createWindow("TaharezLook/Button", AutoRankLRButtonName[i])
	mywindow:setTexture("Normal", "UIData/myinfo.tga", AutoRankLRButtonTexX[i], 0)
	mywindow:setTexture("Hover", "UIData/myinfo.tga", AutoRankLRButtonTexX[i], 22)
	mywindow:setTexture("Pushed", "UIData/myinfo.tga", AutoRankLRButtonTexX[i], 44)
	mywindow:setTexture("PushedOff", "UIData/myinfo.tga", AutoRankLRButtonTexX[i], 0)
	mywindow:setPosition(AutoRankLRButtonPosX[i], 425)
	mywindow:setSize(17, 22)
	mywindow:setZOrderingEnabled(false)
	mywindow:setSubscribeEvent("Clicked", AutoRankLRButtonEvent[i])
	winMgr:getWindow("AutoRanking_Background_Image"):addChildWindow(mywindow)
end


-- �ڵ���ġ ���������� / �ִ�������
mywindow = winMgr:createWindow("TaharezLook/StaticText", "Auto_RankingPageText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 16)
mywindow:setPosition(210, 428)
mywindow:setSize(80, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:clearTextExtends()
mywindow:setZOrderingEnabled(false)
mywindow:addTextExtends(tostring(g_AutoCurrentPage)..' / '..tostring(g_AutoMaxPage), g_STRING_FONT_GULIMCHE, 14,    230,230,230,255,     0,     0,0,0,255)
winMgr:getWindow('AutoRanking_Background_Image'):addChildWindow(mywindow)


------------------------------------
---�ڵ���ġ �����������̺�Ʈ---------
------------------------------------
		 
function Prev_AutoRankInfo()
     
     DebugStr('Prev_AutoRankInfo');
	if	g_AutoCurrentPage > 1 then
			--g_AutoCurrentPage = g_AutoCurrentPage - 1
			GetAutoRankPage(g_AutoCurrentPage -1)
	end
	
end



------------------------------------
---�ڵ���ġ �����������̺�Ʈ---------
------------------------------------
function Next_AutoRankInfo()
  
	DebugStr('Next_AutoRankInfo');
	if	g_AutoCurrentPage < g_AutoMaxPage then
			--g_AutoCurrentPage = g_AutoCurrentPage + 1
			GetAutoRankPage(g_AutoCurrentPage + 1)
	end
end

function SettingAutoPage(CurrentPage , MaxPage)
	g_AutoCurrentPage = CurrentPage
	g_AutoMaxPage = MaxPage
	if g_AutoCurrentPage > g_AutoMaxPage then
		g_AutoCurrentPage = g_AutoMaxPage
	end
	winMgr:getWindow('Auto_RankingPageText'):clearTextExtends()
	winMgr:getWindow('Auto_RankingPageText'):addTextExtends(tostring(g_AutoCurrentPage)..' / '..tostring(g_AutoMaxPage), g_STRING_FONT_GULIMCHE, 14,    230,230,230,255,     0,     0,0,0,255)
end

--------------------------------------------------------------------

-- �ڵ���ġ ��ŷâ �ݱ��ư

--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "Auto_Ranking_CloseBtn")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setPosition(464, 6)
mywindow:setSize(23, 23)
mywindow:setZOrderingEnabled(false)
mywindow:setSubscribeEvent("Clicked", "CloseAutoRankingList")
winMgr:getWindow("AutoRanking_Background_Image"):addChildWindow(mywindow)


-- �ڵ���ġ ��ŷâ�� �ݴ´�.
function CloseAutoRankingList()
	winMgr:getWindow("AutoRanking_Background_Image"):setVisible(false)
	winMgr:getWindow("Auto_Ranking_Find_text"):setText("")
	winMgr:getWindow("Auto_Ranking_Find_text"):deactivate()
	CloseRank()
end

function GetAutoRankInfo()
	g_AutoCurrentPage = 1
	GetAutoRankPage(g_AutoCurrentPage)
	root:addChildWindow(winMgr:getWindow("AutoRanking_Background_Image"))
	winMgr:getWindow("AutoRanking_Background_Image"):setVisible(true)
end

function ClearAutoRankInfo()

	for i=0, 9 do
		winMgr:getWindow(i .. "Auto_userInfo_rank"):setText("")
		winMgr:getWindow(i .. "Auto_userInfo_level"):setText("")
		winMgr:getWindow(i .. "Auto_userInfo_name"):setText("")
		winMgr:getWindow(i .. "Auto_userInfo_info1"):setText("")
		winMgr:getWindow(i .. "Auto_userInfo_info2"):setText("")
		winMgr:getWindow(i .. "Auto_userInfo_findImage"):setVisible(false)
	end
	
end

function UpdateAutoRankInfo(index, Rank,  level, name, mvpcount)
		
		-- ����
		local szRank = CommatoMoneyStr(Rank)
		local rankText = tostring(szRank)
		local rankSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tostring(rankText))
		winMgr:getWindow(index .. "Auto_userInfo_rank"):setPosition(44-rankSize, 5)
		winMgr:getWindow(index .. "Auto_userInfo_rank"):setText(tostring(rankText))
							
		-- ����
		winMgr:getWindow(index .. "Auto_userInfo_level"):setPosition(100, 5)
		winMgr:getWindow(index .. "Auto_userInfo_level"):setText("Lv."..level)
		
		
		-- �̸�
		local nameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 112, name)
		winMgr:getWindow(index .. "Auto_userInfo_name"):setPosition(240-nameSize/2, 5)
		winMgr:getWindow(index .. "Auto_userInfo_name"):setText(name)
		
		-- MVP ����
		local MvpSize = GetStringSize(g_STRING_FONT_GULIMCHE, 112, mvpcount)
		winMgr:getWindow(index .. "Auto_userInfo_info1"):setPosition(400-MvpSize/2, 5)
		winMgr:getWindow(index .. "Auto_userInfo_info1"):setText(mvpcount)
end
















g_DefenceCurrentPage = 1
g_DefenceMaxPage = 1
g_DefenceType = 0


--------------------------------------
--//-------- ����ŷ�Խ���-----------
--------------------------------------

--------------------------------------------------------------------
-- ��ŷâ �⺻ ���� ������
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ZombieRankBackImage")
mywindow:setTexture("Enabled", "UIData/zombie_rank.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/zombie_rank.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(6);
mywindow:setPosition(63, 46)
mywindow:setSize(860, 659)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

RegistEscEventInfo("ZombieRankBackImage", "CloseDefenceRankingList")

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ZombieRankLevelImageTemp")
mywindow:setTexture("Enabled", "UIData/zombie_rank.tga", 892, 1)
mywindow:setTexture("Disabled", "UIData/zombie_rank.tga", 892, 1)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(713, 25)
mywindow:setSize(132, 25)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
if CheckfacilityData(FACILITYCODE_ZOMBIEDEFENCEHARD) == 1 then
	winMgr:getWindow("ZombieRankBackImage"):addChildWindow(mywindow)
end

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ZombieRankLevelImage")
mywindow:setTexture("Enabled", "UIData/zombie_rank.tga", 898, 28)
mywindow:setTexture("Disabled", "UIData/zombie_rank.tga", 898, 28)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(719, 27)
mywindow:setSize(100, 20)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
if CheckfacilityData(FACILITYCODE_ZOMBIEDEFENCEHARD) == 1 then
	winMgr:getWindow("ZombieRankBackImage"):addChildWindow(mywindow)
end

mywindow = winMgr:createWindow("TaharezLook/Button", "ZombieRankLevelDropBtn")
mywindow:setTexture("Normal", "UIData/zombie_rank.tga", 1000, 26)
mywindow:setTexture("Hover", "UIData/zombie_rank.tga", 1000, 51)
mywindow:setTexture("Pushed", "UIData/zombie_rank.tga", 1000, 76)
mywindow:setTexture("PushedOff", "UIData/zombie_rank.tga",  1000, 26)
mywindow:setPosition(820, 25)
mywindow:setSize(24, 25)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setSubscribeEvent("Clicked", "OnClickZombieRankDrop")
if CheckfacilityData(FACILITYCODE_ZOMBIEDEFENCEHARD) == 1 then
	winMgr:getWindow("ZombieRankBackImage"):addChildWindow(mywindow)
end



mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ZombieRankLevelBtnBackImage")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 892, 1)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 892, 1)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(713, 50)
mywindow:setAlwaysOnTop(true)
mywindow:setSize(132, 55)
mywindow:setAlwaysOnTop(true)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)
if CheckfacilityData(FACILITYCODE_ZOMBIEDEFENCEHARD) == 1 then
	winMgr:getWindow("ZombieRankBackImage"):addChildWindow(mywindow)
end
--------------------------------------------------------------------

-- Normal Hard ��ư

--------------------------------------------------------------------
local DefenceRankNHButtonName  = {["err"]=0, "Defence_Ranking_NormalBtn", "Defence_Ranking_HardBtn"}
local DefenceRankNHButtonTexY  = {["err"]=0, 26, 51}
local DefenceRankNHButtonPosY  = {["err"]=0, 0, 25}
local DefenceRankNHButtonEvent = {["err"]=0, "OnClickDefenceRankingNormal", "OnClickDefenceRankingHard"}
for i=1, #DefenceRankNHButtonName do
	mywindow = winMgr:createWindow("TaharezLook/Button", DefenceRankNHButtonName[i])
	mywindow:setTexture("Normal", "UIData/zombie_rank.tga", 892, DefenceRankNHButtonTexY[i])
	mywindow:setTexture("Hover", "UIData/zombie_rank.tga", 892, DefenceRankNHButtonTexY[i]+50)
	mywindow:setTexture("Pushed", "UIData/zombie_rank.tga", 892, DefenceRankNHButtonTexY[i])
	mywindow:setTexture("PushedOff", "UIData/zombie_rank.tga", 892, DefenceRankNHButtonTexY[i])
	mywindow:setPosition(0, DefenceRankNHButtonPosY[i])
	mywindow:setSize(108, 25)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setSubscribeEvent("Clicked", DefenceRankNHButtonEvent[i])
	winMgr:getWindow("ZombieRankLevelBtnBackImage"):addChildWindow(mywindow)
end

function OnClickDefenceRankingNormal()
	DebugStr('OnClickDefenceRankingNormal')
	g_DefenceType = 0
	g_DefenceCurrentPage = 1
	OnClickZombieRankDrop()
	winMgr:getWindow("ZombieRankLevelImage"):setTexture("Enabled", "UIData/zombie_rank.tga", 898, 28)
	GetDefenceRankPage(g_DefenceCurrentPage, g_DefenceType)
end

function OnClickDefenceRankingHard()
	DebugStr('OnClickDefenceRankingHard')
	g_DefenceType = 1
	g_DefenceCurrentPage = 1
	OnClickZombieRankDrop()
	winMgr:getWindow("ZombieRankLevelImage"):setTexture("Enabled", "UIData/zombie_rank.tga", 898, 54)
	GetDefenceRankPage(g_DefenceCurrentPage, g_DefenceType)
end


function OnClickZombieRankDrop()
	
	if winMgr:getWindow("ZombieRankLevelBtnBackImage"):isVisible() then
		winMgr:getWindow("ZombieRankLevelBtnBackImage"):setVisible(false)
	else
		winMgr:getWindow("ZombieRankBackImage"):addChildWindow(winMgr:getWindow("ZombieRankLevelBtnBackImage"))
		winMgr:getWindow("ZombieRankLevelBtnBackImage"):setVisible(true)
	end
end


for i = 1, 5 do 
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ZombieRankBackLineImage"..i)
	mywindow:setTexture("Enabled", "UIData/zombie_rank.tga", 0, 678)
	mywindow:setTexture("Disabled", "UIData/zombie_rank.tga", 0, 678)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(17, 58+(i*112)-112)
	mywindow:setSize(826, 110)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("ZombieRankBackImage"):addChildWindow(mywindow)
	
	-- Ʈ���� �̹���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ZombieRankEmblem"..i)
	mywindow:setTexture("Enabled", "UIData/zombie_rank.tga", 360, 793)
	mywindow:setTexture("Disabled", "UIData/zombie_rank.tga", 360, 793)
	mywindow:setProperty("FrameEnabled", "False")
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setPosition(23, 5)
	mywindow:setSize(120, 104)
	--mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("ZombieRankBackLineImage"..i):addChildWindow(mywindow)
	
	local ZombiRankEmblemNumberPosX  = {["err"]=0, 47, 82}	
	-- ��ũ����
	for j = 1, 2 do
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ZombieRankEmblemNumber"..i..j)
		mywindow:setTexture("Enabled", "UIData/zombie_rank.tga", 0, 897)
		mywindow:setTexture("Disabled", "UIData/zombie_rank.tga", 0, 897)
		mywindow:setProperty("FrameEnabled", "False")
		mywindow:setProperty("BackgroundEnabled", "False")
		mywindow:setPosition(ZombiRankEmblemNumberPosX[j], 18)
		mywindow:setSize(37, 68)
		--mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		winMgr:getWindow("ZombieRankBackLineImage"..i):addChildWindow(mywindow)
	end
	
	-- ����
	for j = 1, 2 do
		subwindow = winMgr:createWindow("TaharezLook/StaticImage", "ZombieRankRoundNumberImage"..i..j)
		subwindow:setTexture("Enabled", "UIData/zombie_rank.tga", 148, 965)
		subwindow:setTexture("Disabled", "UIData/zombie_rank.tga", 148, 965)
		subwindow:setProperty("BackgroundEnabled", "False")
		subwindow:setProperty("FrameEnabled", "False")
		subwindow:setPosition(473+(j*22), 42)
		subwindow:setSize(22, 32)
		subwindow:setWheelEventDisabled(true)
		subwindow:setZOrderingEnabled(false)
		subwindow:setAlwaysOnTop(true)
		winMgr:getWindow("ZombieRankBackLineImage"..i):addChildWindow(subwindow)
	end

	local ZombiRankTimeNumberPosX  = {["err"]=0, 435, 456, 494, 515, 554, 575}

	-- �ð�
	for j = 1, 6 do
		subwindow = winMgr:createWindow("TaharezLook/StaticImage", "ZombieRankTimeNumberImage"..i..j)
		subwindow:setTexture("Enabled", "UIData/zombie_rank.tga", 148, 965)
		subwindow:setTexture("Disabled", "UIData/zombie_rank.tga", 148, 965)
		subwindow:setProperty("BackgroundEnabled", "False")
		subwindow:setProperty("FrameEnabled", "False")
		subwindow:setPosition(ZombiRankTimeNumberPosX[j]+182, 42)
		subwindow:setSize(22, 32)
		subwindow:setWheelEventDisabled(true)
		subwindow:setZOrderingEnabled(false)
		subwindow:setAlwaysOnTop(true)
		winMgr:getWindow("ZombieRankBackLineImage"..i):addChildWindow(subwindow)
	end
	
	for j = 1 , 4 do 
		subwindow = winMgr:createWindow("TaharezLook/StaticText", "ZombieRank_NameText"..i..j)
		subwindow:setProperty("FrameEnabled", "false")
		subwindow:setProperty("BackgroundEnabled", "false")
		subwindow:setTextColor(255,255,255,255)
		subwindow:setFont(g_STRING_FONT_GULIMCHE, 11)
		subwindow:setPosition(180 , 3+(j*20))
		subwindow:setSize(80, 20)
		subwindow:setViewTextMode(1)
		subwindow:setLineSpacing(2)
		subwindow:clearTextExtends()
		subwindow:setZOrderingEnabled(false)
		subwindow:setTextExtends("Name yo", g_STRING_FONT_GULIM, 13, 255,255,255,255,   0, 255,255,255,255)
		winMgr:getWindow("ZombieRankBackLineImage"..i):addChildWindow(subwindow)
	end
end


function ClearDefenceRankInfo()
	for i=1, 5 do
		winMgr:getWindow("ZombieRankBackLineImage"..i):setVisible(false)
		for j = 1 , 4 do 
			winMgr:getWindow("ZombieRank_NameText"..i..j):clearTextExtends()
		end
	end
end


-- �ڵ���ġ ��ŷâ�� �ݴ´�.
function CloseDefenceRankingList()
	
	winMgr:getWindow("ZombieRankBackImage"):setVisible(false)
	CloseRank()
end

function GetDefenceRankInfo()
	g_DefenceType = 0
	g_DefenceCurrentPage = 1
	winMgr:getWindow("ZombieRankLevelImage"):setTexture("Enabled", "UIData/zombie_rank.tga", 898, 28)
	GetDefenceRankPage(g_DefenceCurrentPage, g_DefenceType)
	root:addChildWindow(winMgr:getWindow("ZombieRankBackImage"))
	winMgr:getWindow("ZombieRankBackImage"):setVisible(true)
end


function UpdateDefenceRankInfo(index , name1, name2, name3, name4,  Round,  Time  )
	Realindex = index + ( g_DefenceCurrentPage * 5) - 5
	DebugStr('Realindex:'..Realindex)
	
	if name1 ~= ""  then
		winMgr:getWindow("ZombieRankBackLineImage"..index):setVisible(true)
	end
	
	-- ��ŷ �Է�
	if Realindex <= 100 then
		local Rankten = (Realindex/10)
		local Rankone = (Realindex%10)
		
		winMgr:getWindow("ZombieRankEmblemNumber"..index..1):setTexture("Enabled", "UIData/invisible.tga", 0, 897)
		winMgr:getWindow("ZombieRankEmblemNumber"..index..2):setTexture("Enabled", "UIData/invisible.tga", 0, 897)
			
		if Realindex == 1 then
			winMgr:getWindow("ZombieRankEmblem"..index):setTexture("Enabled", "UIData/zombie_rank.tga", 0, 793)
		elseif Realindex == 2 then
			winMgr:getWindow("ZombieRankEmblem"..index):setTexture("Enabled", "UIData/zombie_rank.tga", 120, 793)
		elseif Realindex == 3 then
			winMgr:getWindow("ZombieRankEmblem"..index):setTexture("Enabled", "UIData/zombie_rank.tga", 240, 793)
		elseif Realindex == 100 then
			winMgr:getWindow("ZombieRankEmblem"..index):setTexture("Enabled", "UIData/zombie_rank.tga", 480, 793)
		else
			winMgr:getWindow("ZombieRankEmblem"..index):setTexture("Enabled", "UIData/zombie_rank.tga", 360, 793)
			if Rankten == 0 then
				winMgr:getWindow("ZombieRankEmblemNumber"..index..2):setPosition(62, 18)
				winMgr:getWindow("ZombieRankEmblemNumber"..index..2):setTexture("Enabled", "UIData/zombie_rank.tga", 0+(37*Rankone), 897)
			else
				winMgr:getWindow("ZombieRankEmblemNumber"..index..2):setPosition(82, 18)
				winMgr:getWindow("ZombieRankEmblemNumber"..index..1):setTexture("Enabled", "UIData/zombie_rank.tga", 0+(37*Rankten), 897)
				winMgr:getWindow("ZombieRankEmblemNumber"..index..2):setTexture("Enabled", "UIData/zombie_rank.tga", 0+(37*Rankone), 897)
			end
		end	
	end
	
	-- �̸� �Է�
	winMgr:getWindow("ZombieRank_NameText"..index..1):setTextExtends(name1, g_STRING_FONT_GULIM, 13, 255,255,255,255,   0, 255,255,255,255)
	winMgr:getWindow("ZombieRank_NameText"..index..2):setTextExtends(name2, g_STRING_FONT_GULIM, 13, 255,255,255,255,   0, 255,255,255,255)
	winMgr:getWindow("ZombieRank_NameText"..index..3):setTextExtends(name3, g_STRING_FONT_GULIM, 13, 255,255,255,255,   0, 255,255,255,255)
	winMgr:getWindow("ZombieRank_NameText"..index..4):setTextExtends(name4, g_STRING_FONT_GULIM, 13, 255,255,255,255,   0, 255,255,255,255)
	
	-- �ð����
	local resultValue = Time
	local Hour =  (resultValue/3600)
	local HourTen =  (Hour/10)
	local HourOne =  (Hour%10)
	
	resultValue = resultValue - (Hour * 3600)
	
	local Minute =  (resultValue/60)
	local MinuteTen =  (Minute/10)
	local MinuteOne =  (Minute%10)
	resultValue = resultValue - (Minute * 60)
	
	local SecondTen =  (resultValue/10)
	local SecondOne =  (resultValue%10)
	
	winMgr:getWindow("ZombieRankTimeNumberImage"..index..1):setTexture("Enabled", "UIData/zombie_rank.tga", 148+(HourTen*22), 965)
	winMgr:getWindow("ZombieRankTimeNumberImage"..index..2):setTexture("Enabled", "UIData/zombie_rank.tga", 148+(HourOne*22), 965)
	winMgr:getWindow("ZombieRankTimeNumberImage"..index..3):setTexture("Enabled", "UIData/zombie_rank.tga", 148+(MinuteTen*22), 965)
	winMgr:getWindow("ZombieRankTimeNumberImage"..index..4):setTexture("Enabled", "UIData/zombie_rank.tga", 148+(MinuteOne*22), 965)
	winMgr:getWindow("ZombieRankTimeNumberImage"..index..5):setTexture("Enabled", "UIData/zombie_rank.tga", 148+(SecondTen*22), 965)
	winMgr:getWindow("ZombieRankTimeNumberImage"..index..6):setTexture("Enabled", "UIData/zombie_rank.tga", 148+(SecondOne*22), 965)
	
	
	-- ���� ����
	local roundten = Round / 10
	local roundone = Round % 10
	winMgr:getWindow("ZombieRankRoundNumberImage"..index..1):setTexture("Enabled", "UIData/zombie_rank.tga", 148+(roundten*22), 965)
	winMgr:getWindow("ZombieRankRoundNumberImage"..index..2):setTexture("Enabled", "UIData/zombie_rank.tga", 148+(roundone*22), 965)
end



--------------------------------------------------------------------

-- ���潺 ��ŷ �¿� ��ư

--------------------------------------------------------------------
local DefenceRankLRButtonName  = {["err"]=0, "Defence_Ranking_LBtn", "Defence_Ranking_RBtn"}
local DefenceRankLRButtonTexX  = {["err"]=0, 962, 993}
local DefenceRankLRButtonPosX  = {["err"]=0, 178, 304}
local DefenceRankLRButtonEvent = {["err"]=0, "Prev_DefenceRankInfo", "Next_DefenceRankInfo"}
for i=1, #DefenceRankLRButtonName do
	mywindow = winMgr:createWindow("TaharezLook/Button", DefenceRankLRButtonName[i])
	mywindow:setTexture("Normal", "UIData/zombie_rank.tga", DefenceRankLRButtonTexX[i], 913)
	mywindow:setTexture("Hover", "UIData/zombie_rank.tga", DefenceRankLRButtonTexX[i], 950)
	mywindow:setTexture("Pushed", "UIData/zombie_rank.tga", DefenceRankLRButtonTexX[i], 987)
	mywindow:setTexture("PushedOff", "UIData/zombie_rank.tga", DefenceRankLRButtonTexX[i], 913)
	mywindow:setPosition(DefenceRankLRButtonPosX[i]+170, 615)
	mywindow:setSize(31, 37)
	mywindow:setZOrderingEnabled(false)
	mywindow:setSubscribeEvent("Clicked", DefenceRankLRButtonEvent[i])
	winMgr:getWindow("ZombieRankBackImage"):addChildWindow(mywindow)
end


-- ���潺 ���������� / �ִ�������
mywindow = winMgr:createWindow("TaharezLook/StaticText", "Defence_RankingPageText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 18)
mywindow:setPosition(382, 623)
mywindow:setSize(80, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:clearTextExtends()
mywindow:setZOrderingEnabled(false)
mywindow:addTextExtends(tostring(g_DefenceCurrentPage)..' / '..tostring(g_DefenceMaxPage), g_STRING_FONT_GULIMCHE, 18,    230,230,230,255,     0,     0,0,0,255)
winMgr:getWindow("ZombieRankBackImage"):addChildWindow(mywindow)

------------------------------------
---���潺 �����������̺�Ʈ---------
------------------------------------
		 
function Prev_DefenceRankInfo()
     
     DebugStr('Prev_DefenceRankInfo');
	if	g_DefenceCurrentPage > 1 then
		GetDefenceRankPage(g_DefenceCurrentPage -1, g_DefenceType)
	end
	
end



------------------------------------
---���潺 �����������̺�Ʈ---------
------------------------------------
function Next_DefenceRankInfo()
  
	DebugStr('Next_DefenceRankInfo');
	if	g_DefenceCurrentPage < g_DefenceMaxPage then
		GetDefenceRankPage(g_DefenceCurrentPage + 1, g_DefenceType)
	end
end


function SettingDefencePage(CurrentPage , MaxPage)
	g_DefenceCurrentPage = CurrentPage
	g_DefenceMaxPage = MaxPage
	if g_DefenceCurrentPage > g_DefenceMaxPage then
		g_DefenceCurrentPage = g_DefenceMaxPage
	end
	winMgr:getWindow('Defence_RankingPageText'):clearTextExtends()
	winMgr:getWindow('Defence_RankingPageText'):addTextExtends(tostring(g_DefenceCurrentPage)..' / '..tostring(g_DefenceMaxPage), g_STRING_FONT_GULIMCHE, 14,    230,230,230,255,     0,     0,0,0,255)
end
--]]