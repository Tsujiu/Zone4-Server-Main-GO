local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)
root:activate()

function SetupConsole()

end

function Log(text)
	
end

function Log2(text, number)
	
end

function Start()
	xpcall(DoStart, errorHandler1)
end

function DoStart()
	LOG("Start WndTest")
	WndMyCollection()
end

_currentTime = 0
_deltaTime = 0
function Update(currentTime, deltaTime)
	_currentTime = currentTime
	_deltaTime = deltaTime
	xpcall(DoUpdate, errorHandler2)
end

drawState = 0
luaTime = 0;
function DoUpdate()
	currentTime = _currentTime
	deltaTime = _deltaTime

	if currentTime > 100 then
		winMgr:getWindow("wndtest_debug_text2"):setText("ERROR")

		if winMgr:getWindow("wndtest_debug_text1") then
			winMgr:getWindow("wndtest_debug_text1"):setText("PLAY")
		end

		if winMgr:getWindow("wndtest_debug_time") then
			winMgr:getWindow("wndtest_debug_time"):setText("currentTime: " .. tostring(currentTime))
		end

		if winMgr:getWindow("wndtest_debug_deltatime") then
			winMgr:getWindow("wndtest_debug_deltatime"):setText("deltaTime: " .. tostring(deltaTime))
		end

		Test_WndMatchMaking(currentTime, deltaTime)
		-- Test_WndGameResult(currentTime, deltaTime)
		-- Test_WndMatchMakingReward(currentTime, deltaTime)

		winMgr:getWindow("wndtest_debug_text2"):setText("OK")
	end
end

function LateUpdate(currentTime, deltaTime)
	
end

function Destroy()

end
function errorHandler1(err)
	LOG("WndTest error: " .. err)

end

function WndMyCollection()
	LOG("Start WndMyCollection")
	-- local guiSystem = CEGUI.System:getSingleton()
	-- local winMgr	= CEGUI.WindowManager:getSingleton()
	-- local root		= winMgr:getWindow("DefaultWindow")
	-- local drawer	= root:getDrawer()
	-- guiSystem:setGUISheet(root)
	-- root:activate()
	-- body
	-- background
	background = winMgr:createWindow("TaharezLook/StaticImage", "Collection_BackImage")
	-- LOG("created windows")
	background:setTexture("Enabled", "UIData/Collection/Collection_UI.png", 0, 0)

	-- LOG("created setTexture")
	-- position center screen
	background:setPosition((g_MAIN_WIN_SIZEX-900)/2, (g_MAIN_WIN_SIZEY-500)/2)
	-- LOG("created setPosition")
	background:setSize(900, 500)
	-- LOG("created setSize")
	background:setVisible(true)
	-- LOG("created setVisible")
	background:setAlwaysOnTop(true)
	-- LOG("created setAlwaysOnTop")
	background:setZOrderingEnabled(true)
	-- LOG("created setZOrderingEnabled")
	root:addChildWindow(background)
	-- LOG("End WndMyCollection")
	-- render button menu
	RenderButtonMenu()
	-- -- render table
	RenderTable()
	-- -- render pagination
	RenderPagination()
	-- -- render radio filter collection
	RenderRedioFilterCollection()
	-- -- render search bar
	CollectionSeachbar()
	-- -- render collection info

	 MyCollectionInfo() 
	
	--  GetCollectionList()





	-- RenderItemReward()
	-- RegisterSet()
	-- -- debug text
	-- debugText = Text("Collection_DebugText")
	-- debugText:setPosition(10, 10)
	-- root:addChildWindow(debugText)
	-- MyCollectionModeOpen()
	

end

	--  function GetCollectionList()
	-- 	c_data = GetCollectionPage(1)
	-- 		LOG("c_data : "..c_data);
	-- 		-- c_RequireItem = GetRequireItem(1)
	-- 		-- split "|"","," array data
	-- 		collection_data = {{}}
	-- 		-- 1,Root Collection - Tree 1,0
	-- 		i = 1
	-- 		for token in string.gmatch(c_data, "[^|]+") do
	-- 			collection_data[i] = {}
	-- 			j = 1
	-- 			for token2 in string.gmatch(token, "[^,]+") do
	-- 				collection_data[i][j] = token2
	-- 				j = j + 1
	-- 			end
	-- 			DrawerRowTable(i-1,collection_data[i][1].." "..collection_data[i][2]  ,0)
	-- 			i = i + 1
	-- 		end
	-- end

-- -- ////////////////////////////////////////////////////////////////////////////////
function Text(name)
	mywindow = winMgr:createWindow("TaharezLook/StaticText", name)
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont("tahoma", 16)
	-- mywindow:setFont(g_STRING_FONT_GULIMCHE, 12);
	mywindow:setText("")
	mywindow:setPosition(10, 0)
	mywindow:setSize(250, 36)
	mywindow:setAlwaysOnTop(true)
	root:addChildWindow(mywindow)
	return mywindow
end



function RenderButtonMenu()
	LOG("eeee")
	background = winMgr:getWindow("Collection_BackImage")
	btnWidth = 100
	btnHigh = 30
	btnLen =5
	margin =5
	menuName ={"Charater","Costume" ,"PVE" ,"PVP","Event","Secret" }
	-- i=0
	for  i = 0, #menuName-1  do
	
		menu = winMgr:createWindow("TaharezLook/Button", "collection_button"..i)
	
		menu:setTexture("Normal", "UIData/Collection/Collection_UI.png", ((btnWidth*i)), 520)
		menu:setTexture("Hover", "UIData/Collection/Collection_UI.png", ((btnWidth*i)), 520+35)
		menu:setPosition(((btnWidth+margin)*i)+15, 50)
		menu:setSize(btnWidth, btnHigh)
		menu:setVisible(true)
		menu:setAlwaysOnTop(true)
		menu:setZOrderingEnabled(true)
		menu:subscribeEvent("Clicked", function()
			LOG("menuName "..menuName[i + 1])
            ManuTabBar(menuName[i + 1])
        end)
		background:addChildWindow(menu)
		-- i=i+1
	end
end


function ManuTabBar(selectedMenu)

	clearAllRows()
    
    local dataList = {}
    local favFlagList = {}

    if selectedMenu == "Charater" then
        dataList = {"character test1", "character test2", "character test3", "character test4", "character test5", "character test6"}
        favFlagList = {0, 0, 0, 0, 0, 0}
    elseif selectedMenu == "Costume" then
        dataList = {"qwertyuiopasdfghjklzxcvbnm", "Costume test2", "Costume test3", "Costume test4", "Costume test5", "Costume test6"}
        favFlagList = {0, 0, 0, 0, 0, 0}
    elseif selectedMenu == "PVE" then
        dataList = {"PVE test1", "PVE test2", "PVE test3", "PVE test4", "PVE test5", "PVE test6"}
        favFlagList = {0, 0, 0, 0, 0, 0}
    elseif selectedMenu == "PVP" then
        dataList = {"PVP test1", "PVP test2", "PVP test3", "PVP test4", "PVP test5", "PVP test6"}
        favFlagList = {0, 0, 0, 0, 0, 0}
    elseif selectedMenu == "Event" then
        dataList = {"Event test1", "Event test2", "Event test3", "Event test4", "Event test5", "Event test6"}
        favFlagList = {0, 0, 0, 0, 0, 0}
    elseif selectedMenu == "Secret" then
        dataList = {"Secret test1", "Secret test2", "Secret test3", "Secret test4", "Secret test5", "Secret test6", "Secret test7", "Secret test8"}
        favFlagList = {0, 0, 0, 0, 0, 0,0, 0}

        
    end



	bg = winMgr:getWindow("Collection_OverAllFrame")
	bg:setVisible(true)

	for i = 0, #dataList - 1 do
		drawerRowTable(i, dataList[i + 1], favFlagList[i + 1])
	end
	
	

end

function RenderTable()
	background = winMgr:getWindow("Collection_BackImage")
	headTable = winMgr:createWindow("TaharezLook/StaticImage", "Collection_TableHead")
	headTable:setTexture("Enabled", "UIData/Collection/Collection_UI.png", 0, 590)

	headTable:setPosition(15, 85)
	headTable:setSize(625, 30)
	headTable:setVisible(true)
	headTable:setAlwaysOnTop(true)
	headTable:setZOrderingEnabled(true)
	background:addChildWindow(headTable)

	-- for each collections_data 
	-- data , pages = paginationCollectionData(#collections_data, 1)

end


function drawerRowTable(index,data,favFlag)
	-- limit 6 row rendering
	if index > 5 then
		return 
	end
	background = winMgr:getWindow("Collection_BackImage")
	rowWidth = 625
	rowHigh = 50
	Rowtable = winMgr:createWindow("TaharezLook/Button", "Collection_Table"..index)
	Rowtable:setTexture("Normal", "UIData/Collection/Collection_UI.png", 0, 620)
		
	Rowtable:setPosition(15, 120+(index*50))
	Rowtable:setSize(rowWidth, rowHigh)
	Rowtable:setVisible(true)
	Rowtable:setAlwaysOnTop(true)
	Rowtable:setZOrderingEnabled(true)
	Rowtable:setProperty('Selected', 'false')
	-- Rowtable:subscribeEvent("SelectStateChanged", function()
			
	-- 	-- onRowClick(index, data)
	-- end)

	background:addChildWindow(Rowtable)
	text = winMgr:createWindow("TaharezLook/Button", "Collection_Text"..index)
	text:setText(data)
	text:setPosition(25, (rowHigh-10)/2)
	text:setSize(200, 50)
	text:setFont("tahoma", 10)
	text:setTextColor(255, 255, 255, 255)
	-- onclick event
	text:subscribeEvent("Clicked", function()		 
		onRowClick(index, data)
	end)
		-- hover event
	
	Rowtable:addChildWindow(text)
		-- fav btn icon
	fav = winMgr:createWindow("TaharezLook/Button", "Collection_Fav"..index)
	if (favFlag == 1) then
		fav:setTexture("Normal", "UIData/Collection/Collection_UI.png",625, 872)
	else
		fav:setTexture("Normal", "UIData/Collection/Collection_UI.png",625, 852)
	end
	fav:setPosition(5, (rowHigh-20)/2)
	fav:setSize(20, 20)
	fav:setVisible(true)
	fav:setAlwaysOnTop(true)
	fav:setZOrderingEnabled(true)
	fav:subscribeEvent("Clicked", function()
			
	end)
	Rowtable:addChildWindow(fav)
		-- render items 9 slot after text item data
	marginIcon =5
	for i = 0, 8 do
		item = winMgr:createWindow("TaharezLook/Button", "Collection_Item"..index.."_"..i)
		item:setTexture("Normal", "UIData/Collection/Collection_UI.png", 35*i, 815)
		item:setPosition(170+(i*(30+marginIcon)), (rowHigh-25)/2)
		item:setSize(30, 30)
		item:setVisible(true)
		item:setAlwaysOnTop(false)
		item:setZOrderingEnabled(true)
		
		Rowtable:addChildWindow(item)

		ItemButton = winMgr:createWindow("TaharezLook/Button", "Collection_Item_Chack"..index.."_".. i)
		ItemButton:setTexture("Normal", "UIData/Collection/Collection_UI.png", 625, 793) -- ใช้ Texture สำหรับปุ่มรางวัล
		ItemButton:setPosition(180+(i*(30+marginIcon)), (rowHigh-10)/2)
		ItemButton:setSize(24, 21) -- ขนาดเล็กกว่าไอคอน
		ItemButton:setVisible(true)
		ItemButton:setAlwaysOnTop(true)
		ItemButton:setZOrderingEnabled(true)
		Rowtable:addChildWindow(ItemButton)


	end

	
		-- add btn claim or add item
	btnClaim = winMgr:createWindow("TaharezLook/Button", "Collection_Claim"..index)
	btnClaim:setTexture("Normal", "UIData/Collection/Collection_Register_UI.png", 0, 480)
	btnClaim:setPosition(510, (rowHigh-25)/2)
	btnClaim:setSize(100, 32)
	btnClaim:setVisible(true)
	btnClaim:setAlwaysOnTop(true)
	btnClaim:setZOrderingEnabled(true)
	btnClaim:subscribeEvent("Clicked", function()
			
	end)
	Rowtable:addChildWindow(btnClaim)

	RowtableBtn = winMgr:createWindow("TaharezLook/RadioButton", "Collection_Btn"..index)
	RowtableBtn:setTexture("Normal", "UIData/invisible.tga", 0, 0)
	RowtableBtn:setTexture("SelectedNormal", "UIData/Collection/Collection_Register_UI.png", 0, 515)
	RowtableBtn:setTexture("SelectedHover", "UIData/Collection/Collection_Register_UI.png", 0, 515)
	RowtableBtn:setTexture("SelectedPushed", "UIData/Collection/Collection_Register_UI.png", 0, 515)
	RowtableBtn:setTexture("SelectedPushedOff", "UIData/Collection/Collection_Register_UI.png", 0, 515)
	RowtableBtn:setPosition(15, 125+(index*50))
	RowtableBtn:setSize(rowWidth, rowHigh)
	RowtableBtn:setAlwaysOnTop(true)
	RowtableBtn:setZOrderingEnabled(true)
	RowtableBtn:setProperty("GroupID", 10001)
	RowtableBtn:subscribeEvent("SelectStateChanged", function()
		onRowClick(index, data)
	end)
	
	background:addChildWindow(RowtableBtn)
	

		
end


function clearAllRows()
     background = winMgr:getWindow("Collection_BackImage")
    for i = 0, 5 do
         row = background:getChild("Collection_Table" .. i)
        if row then
            background:removeChildWindow(row)
            winMgr:destroyWindow(row)
        end

         btn = background:getChild("Collection_Btn" .. i)
        if btn then
            background:removeChildWindow(btn)
            winMgr:destroyWindow(btn)
        end
    end
end

function changeFavoriteIcon(favFlag)
	if favFlag then
		return "UIData/Collection/Collection_UI.png",625, 872
	else
		return "UIData/Collection/Collection_UI.png",625, 852
	end
end

function onRowClick(index, data,Rowtable)
	-- Logic for handling row clicks
	if someItem then
	bg = winMgr:getWindow("Collection_OverAllFrame")
	bg:setVisible(true)
	else
	RenderItemReward() 
	end

	winMgr:getWindow('Collection_Background'):setVisible(false)
	winMgr:getWindow('Collection_ItemSet10'):setVisible(false)
	winMgr:getWindow('Collection_ItemRewardDetail'):setVisible(false)


end

function RenderPagination()
    local currentPage = 1
    local totalPages = 3 


    background = winMgr:getWindow("Collection_BackImage")
    
    -- ปุ่ม prev
    prevPgn = winMgr:createWindow("TaharezLook/Button", "Collection_Prev")
    prevPgn:setTexture("Normal", "UIData/Collection/Collection_UI.png", 625, 815)
    prevPgn:setPosition((625-50)/2, 420)
    prevPgn:setSize(20, 20)
    prevPgn:setVisible(true)
    prevPgn:setAlwaysOnTop(true)
    prevPgn:setZOrderingEnabled(true)
    
    -- การจัดการเหตุการณ์ปุ่ม prev
    prevPgn:subscribeEvent("Clicked", function()
        if currentPage > 1 then
            currentPage = currentPage - 1
            updatePaginationText(currentPage, totalPages)
           
        end
    end)

    background:addChildWindow(prevPgn)
    
    -- ข้อความ "x/y"
    text = Text("Collection_Pagination")
    text:setText(currentPage.."/"..totalPages)
    text:setPosition((625-10)/2, 420)
    text:setSize(20, 20)
    background:addChildWindow(text)
    
    -- ปุ่ม next
    nextPgn = winMgr:createWindow("TaharezLook/Button", "Collection_Next")
    nextPgn:setTexture("Normal", "UIData/Collection/Collection_UI.png", 625, 833)
    nextPgn:setPosition((625+50)/2, 420)
    nextPgn:setSize(20, 20)
    nextPgn:setVisible(true)
    nextPgn:setAlwaysOnTop(true)
    nextPgn:setZOrderingEnabled(true)
    
    -- การจัดการเหตุการณ์ปุ่ม next
    nextPgn:subscribeEvent("Clicked", function()
        if currentPage < totalPages then
            currentPage = currentPage + 1
            updatePaginationText(currentPage, totalPages)
         
        end
    end)

    background:addChildWindow(nextPgn)
end

function updatePaginationText(currentPage, totalPages)
    local text = winMgr:getWindow("Collection_Pagination")
    text:setText(currentPage.."/"..totalPages)
end




function RenderRedioFilterCollection()
	background = winMgr:getWindow("Collection_BackImage")
	radioFrame = winMgr:createWindow("TaharezLook/StaticImage", "Collection_RadioFrame")
	radioFrame:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	radioFrame:setPosition(360, 450)
	radioFrame:setSize(500, 100)
	background:addChildWindow(radioFrame)
	-- radio button
	RenderRadioAllCollection(radioFrame)
	RenderRadioInCompletedCollection(radioFrame)
	RenderRadioCompletedCollection(radioFrame)
	


end
function RenderRadioAllCollection(radioFrame)
	radioAll = winMgr:createWindow("TaharezLook/RadioButton", "Collection_Radio_All")
	radioAll:setTexture("Normal", "UIData/Collection/Collection_UI.png", 625, 915)
	radioAll:setTexture("SelectedNormal", "UIData/Collection/Collection_UI.png", 625, 895)
	radioAll:setTexture("SelectedHover", "UIData/Collection/Collection_UI.png", 625, 895)
	radioAll:setTexture("SelectedPushed", "UIData/Collection/Collection_UI.png", 625, 895)
	radioAll:setTexture("SelectedPushedOff", "UIData/Collection/Collection_UI.png", 625, 895)

	radioAll:setPosition(10, 10)
	radioAll:setSize(40, 20)
	radioAll:setVisible(true)
	radioAll:setAlwaysOnTop(true)
	radioAll:setZOrderingEnabled(true)
	radioAll:setProperty('Selected', 'true')
	-- event on select radio button
	-- radioAll:subscribeEvent("SelectStateChanged", "Collection_Radio_All_SelectStateChanged")

	radioFrame:addChildWindow(radioAll)
	-- add text ALL right of radio button
	textAll = Text("Collection_Radio_All_Text")
	textAll:setText("ALL")
	textAll:setPosition(30, 8)
	textAll:setSize(20, 20)
	radioFrame:addChildWindow(textAll)
end

function RenderRadioInCompletedCollection(radioFrame)
	radioInCompleted = winMgr:createWindow("TaharezLook/RadioButton", "Collection_Radio_InCompleted")
	radioInCompleted:setTexture("Normal", "UIData/Collection/Collection_UI.png", 625, 915)
	radioInCompleted:setTexture("SelectedNormal", "UIData/Collection/Collection_UI.png", 625, 895)
	radioInCompleted:setTexture("SelectedHover", "UIData/Collection/Collection_UI.png", 625, 895)
	radioInCompleted:setTexture("SelectedPushed", "UIData/Collection/Collection_UI.png", 625, 895)
	radioInCompleted:setTexture("SelectedPushedOff", "UIData/Collection/Collection_UI.png", 625, 895)
	radioInCompleted:setPosition(60, 10)
	radioInCompleted:setSize(110, 20)
	-- radioInCompleted:setSelected(true)
	radioInCompleted:setVisible(true)
	radioInCompleted:setAlwaysOnTop(true)
	radioInCompleted:setZOrderingEnabled(true)
	-- event on select radio button
	radioInCompleted:subscribeEvent("SelectStateChanged", "Collection_Radio_InCompleted_SelectStateChanged")

	radioFrame:addChildWindow(radioInCompleted)
	-- add text InCompleted right of radio button
	textInCompleted = Text("Collection_Radio_InCompleted_Text")
	textInCompleted:setText("InCompleted")
	textInCompleted:setPosition(80, 8)
	textInCompleted:setSize(20, 20)
	radioFrame:addChildWindow(textInCompleted)

end

function RenderRadioCompletedCollection(radioFrame)
	radioCompleted = winMgr:createWindow("TaharezLook/RadioButton", "Collection_Radio_Completed")
	radioCompleted:setTexture("Normal", "UIData/Collection/Collection_UI.png", 625, 915)
	radioCompleted:setTexture("SelectedNormal", "UIData/Collection/Collection_UI.png", 625, 895)
	radioCompleted:setTexture("SelectedHover", "UIData/Collection/Collection_UI.png", 625, 895)
	radioCompleted:setTexture("SelectedPushed", "UIData/Collection/Collection_UI.png", 625, 895)
	radioCompleted:setTexture("SelectedPushedOff", "UIData/Collection/Collection_UI.png", 625, 895)
	radioCompleted:setPosition(180, 10)
	radioCompleted:setSize(100, 20)
	-- radioCompleted:setSelected(true)
	radioCompleted:setVisible(true)
	radioCompleted:setAlwaysOnTop(true)
	radioCompleted:setZOrderingEnabled(true)
	-- event on select radio button
	radioCompleted:subscribeEvent("SelectStateChanged", "Collection_Radio_InCompleted_SelectStateChanged")

	radioFrame:addChildWindow(radioCompleted)
	-- add text InCompleted right of radio button
	textCompleted = Text("Collection_Radio_Completed_Text")
	textCompleted:setText("Completed")
	textCompleted:setPosition(200, 8)
	textCompleted:setSize(120, 20)
	radioFrame:addChildWindow(textCompleted)

end

function CollectionSeachbar()

	background = winMgr:getWindow("Collection_BackImage")
	
	--icon search
	searchBar = winMgr:createWindow("TaharezLook/Editbox", "Collection_SearchBar")
	-- searchBar:setTexture("Normal", "UIData/Collection/Collection_UI.png", 0, 500)
	searchBar:setPosition(680, 85)
	searchBar:setSize(180, 30)
	searchBar:setVisible(true)
	searchBar:setAlwaysOnTop(true)
	-- text align center
	--disable background
	searchBar:setProperty("FrameEnabled", "false")
	searchBar:setProperty("BackgroundEnabled", "false")
	
	searchBar:setZOrderingEnabled(false)
	searchBar:setTextColor(255, 255, 255, 255)
	searchBar:setProperty("TextPadding", "{{0,0},{5,0}}")
	-- text is white
	searchBar:setText("Enter text here")

	-- searchBar:setProperty("NormalTextColour", "FFFFFFFF") -- RGBA format: white with full opacity

	background:addChildWindow(searchBar)

	--search bar background
	searchBarBackground = winMgr:createWindow("TaharezLook/Button", "Collection_SearchBarBackground")
	searchBarBackground:setTexture("Normal", "UIData/Collection/Collection_UI.png", 0, 870)
	searchBarBackground:setPosition(655, 85)
	searchBarBackground:setSize(30, 30)
	searchBarBackground:setVisible(true)
	searchBarBackground:setAlwaysOnTop(true)
	searchBarBackground:setZOrderingEnabled(true)
	background:addChildWindow(searchBarBackground)
	-- btn refresh
	searchBarRefresh = winMgr:createWindow("TaharezLook/Button", "Collection_SearchBarRefresh")
	searchBarRefresh:setTexture("Normal", "UIData/Collection/Collection_UI.png", 270, 870)
	searchBarRefresh:setPosition(850, 85)
	searchBarRefresh:setSize(30, 30)
	searchBarRefresh:setVisible(true)
	searchBarRefresh:setAlwaysOnTop(true)
	searchBarRefresh:setZOrderingEnabled(true)
	background:addChildWindow(searchBarRefresh)
end

function MyCollectionInfo()
	background = winMgr:getWindow("Collection_BackImage")
	Max_common = 99
	Max_high = 99
	Max_Unique = 99
	Max_Rare = 99
	Max_Legendary = 99
	Max_Ultimate = 99
	Common = 70
	High = 10
	Unique = 10
	Rare = 20
	Legendary = 10
	Ultimate = 20
	-- body
		
	

	-- local aspectRatio_InfoBackground = 230 / 350
    -- local newWidth_InfoBackground = 230
    -- local newHeight_InfoBackground = newWidth_InfoBackground * aspectRatio_InfoBackground
	InfoBackground = winMgr:createWindow("TaharezLook/StaticImage", "Collection_Background")
	InfoBackground:setTexture("Enabled", "UIData/Collection/Collection_UI.png", 785, 515)
	InfoBackground:setPosition(650, 125)
	InfoBackground:setSize(230,350 )
	-- InfoBackground:setScaleWidth(newWidth_InfoBackground+20)
    -- InfoBackground:setScaleHeight(newWidth_InfoBackground+20)
	InfoBackground:setVisible(true)
	InfoBackground:setAlwaysOnTop(true)
	InfoBackground:setZOrderingEnabled(true)
	background:addChildWindow(InfoBackground)
	InfoOverAllFrame = winMgr:createWindow("TaharezLook/StaticImage", "Collection_OverAllFrame")
	InfoOverAllFrame:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	InfoOverAllFrame:setPosition(650, 115)
	InfoOverAllFrame:setSize(230,350 )
	InfoOverAllFrame:setAlwaysOnTop(true)
	InfoOverAllFrame:setZOrderingEnabled(true)
	background:addChildWindow(InfoOverAllFrame)
	-- icon
	icon = winMgr:createWindow("TaharezLook/StaticImage", "Collection_Icon")
	icon:setTexture("Enabled", "UIData/Collection/Collection_UI.png", 630, 515)
	icon:setPosition(50, 40)
	icon:setSize(150,180)
	icon:setVisible(true)
	icon:setAlwaysOnTop(true)
	icon:setZOrderingEnabled(true)
	InfoOverAllFrame:addChildWindow(icon)
	-- text
	text = Text("Collection_Header")
	text:setText("Collection Achievement")
	--mid top background
	text:setPosition(30, 10)
	text:setSize(200, 20)
	InfoOverAllFrame:addChildWindow(text)
	marginX = 15
	ProgressBar("Common",		InfoOverAllFrame,	Max_common,		Common,		marginX,	180)
	ProgressBar("High",			InfoOverAllFrame,	Max_high,		High,		marginX,	200)
	ProgressBar("Unique",		InfoOverAllFrame,	Max_Unique,		Unique,		marginX,	220)
	ProgressBar("Rare",			InfoOverAllFrame,	Max_Rare,		Rare,		marginX,	240)
	ProgressBar("Legendary",	InfoOverAllFrame,	Max_Legendary,	Legendary,	marginX,	260)
	ProgressBar("Ultimate",		InfoOverAllFrame,	Max_Ultimate,	Ultimate,	marginX,	280)
end

function ProgressBar(name,infoBackground,max,now,posX,posY)
		
		lengthBar = 200
		gap=15
	
		-- text common
		text = Text("Collection_"..name)
		text:setText(name)
		text:setPosition(posX, posY)
		text:setSize(200, 20)
		text:setFont("tahoma", 10)
		text:setTextColor(255, 255, 255, 255)
		infoBackground:addChildWindow(text)
		
		--text count common
	
		text = Text("Collection_Count_"..name)
		text:setText(now.."/"..max)
		text:setPosition(posX+170, posY)
		text:setSize(200, 20)
		text:setFont("tahoma", 10)
		text:setTextColor(255, 255, 255, 255)
		infoBackground:addChildWindow(text)
		
		--progress bar
		progressBarBackgroundCommon = winMgr:createWindow("TaharezLook/StaticImage", "Collection_ProgressBar_background_"..name)
		progressBarBackgroundCommon:setTexture("Enabled", "UIData/Collection/Collection_UI.png", 0, 850)
		progressBarBackgroundCommon:setPosition(posX, posY+gap)
		progressBarBackgroundCommon:setSize(200, 5)
		progressBarBackgroundCommon:setVisible(true)
		progressBarBackgroundCommon:setAlwaysOnTop(true)
		progressBarBackgroundCommon:setZOrderingEnabled(true)
		infoBackground:addChildWindow(progressBarBackgroundCommon)
	
	
	
		progressBarCommon = winMgr:createWindow("TaharezLook/StaticImage", "Collection_ProgressBar_"..name)
		progressBarCommon:setTexture("Enabled", "UIData/Collection/Collection_UI.png", 0, 860)
		progressBarCommon:setPosition(posX, posY+gap)
		progressBarCommon:setSize((now*lengthBar)/max, 5)
		progressBarCommon:setVisible(true)
		progressBarCommon:setAlwaysOnTop(true)
		progressBarCommon:setZOrderingEnabled(true)
		infoBackground:addChildWindow(progressBarCommon)
	
end

function WndMyCollectionToggle()
	background = winMgr:getWindow("Collection_BackImage")
	GetCollectionList()
	if background:isVisible() == true then
		background:setVisible(false)
	else
		background:setVisible(true)
	end
end

function MyCollectionModeOpen()
   
	MyCollectionLogger("Start MyCollectionModeOpen")
	WndMyCollection()
	winMgr:getWindow("Collection_BackImage"):setVisible(true)
	GetCollectionList()
end

function WndMyCollectionClose()
	background = winMgr:getWindow("Collection_BackImage")
	background:setVisible(false)

end

function RemoveRowTable()
	background = winMgr:getWindow("Collection_BackImage")
	MyCollectionLogger("RemoveRowTable")
	for i = 0, 5 do
		item = winMgr:getWindow("Collection_Table"..i)
		-- destroy item
		background:removeChildWindow(item)

	end
end


function RenderItemReward()
    ItemCollectionBackround = winMgr:createWindow("TaharezLook/StaticImage", "Collection_ItemCollectionBackround")
    ItemCollectionBackround:setTexture("Enabled", "UIData/Collection/Collection_Register_UI.png", 0, 565)
    ItemCollectionBackround:setPosition(645, 50)
    ItemCollectionBackround:setSize(235,425)
    ItemCollectionBackround:setVisible(true)
    ItemCollectionBackround:setAlwaysOnTop(true)
    ItemCollectionBackround:setZOrderingEnabled(true)
    background:addChildWindow(ItemCollectionBackround)
	-- winMgr:getWindow('Collection_ItemRequirement'):addChildWindow(ItemRequirement)
	



	local aspectRatio_ItemRequirement = 200 / 100
    local newWidth_ItemRequirement = 145
    local newHeight_ItemRequirement = newWidth_ItemRequirement * aspectRatio_ItemRequirement
    ItemRequirement = winMgr:createWindow("TaharezLook/StaticImage", "Collection_ItemRequirement")
    ItemRequirement:setTexture("Enabled", "UIData/Collection/Collection_UI.png", 314, 765)
    ItemRequirement:setPosition((210-200)/2, 80)
    ItemRequirement:setSize(200,100 )
	ItemRequirement:setScaleWidth(newHeight_ItemRequirement)
    ItemRequirement:setScaleHeight(newHeight_ItemRequirement)
    ItemRequirement:setVisible(true)
    ItemRequirement:setAlwaysOnTop(true)
    ItemRequirement:setZOrderingEnabled(true)
    ItemCollectionBackround:addChildWindow(ItemRequirement)

	text = Text("Collection_Item_Requirement")
	text:setText("Item")
	--mid top background
	text:setPosition(90, 50)
	text:setSize(1, 1)
	text:setFont("tahoma", 15)
	text:setTextColor(255, 182,80,255)
	ItemCollectionBackround:addChildWindow(text)

	local aspectRatio_ItemCollection = 200 / 100
    local newWidth_ItemCollection = 145
    local newHeight_ItemCollection = newWidth_ItemCollection * aspectRatio_ItemCollection
	ItemReward = winMgr:createWindow("TaharezLook/StaticImage", "Collection_ItemReward")
    ItemReward:setTexture("Enabled", "UIData/Collection/Collection_UI.png", 314, 765)
    ItemReward:setPosition((210-200)/2,215)
    ItemReward:setSize(200,100 )
	ItemReward:setScaleWidth(newHeight_ItemCollection)
    ItemReward:setScaleHeight(newHeight_ItemCollection)
    ItemReward:setVisible(true)
    ItemReward:setAlwaysOnTop(true)
    ItemReward:setZOrderingEnabled(true)
    ItemCollectionBackround:addChildWindow(ItemReward)

	text = Text("Collection_Item_Reward")
	text:setText("Reward")
	--mid top background
	text:setPosition(85, 195)
	text:setSize(200, 20)
	text:setFont("tahoma", 15)
	text:setTextColor(255, 182,80,255)
	ItemCollectionBackround:addChildWindow(text)


	text = Text("Collection_Item_Set")
	text:setText("High Adventure Set")
	--mid top background
	text:setPosition(70, 5)
	text:setSize(200, 20)
	text:setFont("tahoma", 10)
	text:setAlwaysOnTop(true)
	text:setTextColor(43, 255,0,255)
	ItemRequirement:addChildWindow(text)

	ItemReward = winMgr:createWindow("TaharezLook/StaticImage", "Collection_ItemAdd")
    ItemReward:setTexture("Enabled", "UIData/Collection/Collection_UI.png", 314, 874)
    ItemReward:setPosition((330-200)/2,340)
    ItemReward:setSize(100,31 )
    ItemReward:setVisible(true)
    ItemReward:setAlwaysOnTop(true)
    ItemReward:setZOrderingEnabled(true)
    ItemCollectionBackround:addChildWindow(ItemReward)



    -- RenderItemSet(index,"path item ing",postion X,position Y,Size X, Size Y,ตำ  ห       frame UI X, ตำ  ห       frame UI Y)

	-- RenderItemRewards("Hit Attack","",
	-- 95 , 230,
	-- 65, 67,
	-- 257, 434)
	-- text = Text("Collection_ItemFrame")
	-- text:setText("    Hit\nAttack +0") 
	-- --mid top background
	-- text:setPosition(103, 239)
	-- text:setSize(200, 50)
	-- text:setFont("tahoma", 7 )
	-- text:setTextColor(255, 255,255,255)
	-- ItemCollectionBackround:addChildWindow(text)

	-- RenderItemRewards("Hit Defence","",
	-- 95 , 280,
	-- 65, 67,
	-- 259, 502)
	-- text = Text("Collection_ItemFrame2")
	-- text:setText("    Hit\nDefence +0") 
	-- --mid top background
	-- text:setPosition(103, 250)
	-- text:setSize(200, 50)
	-- text:setFont("tahoma", 7 )
	-- text:setTextColor(255, 255,255,255)
	-- ItemCollectionBackround:addChildWindow(text)
	MockUpLoopItemSet() 
	MockUpLoopItemReward()
	-- RegisterItem()
	-- RegisterSet()

	

end 


function RenderItemSet(i,item_path,posX,posY,sizeX,sizeY,cropX,cropY,item_registed)
	
    ItemCollectionBackround = winMgr:getWindow("Collection_ItemRequirement")
    ItemFrame = winMgr:createWindow("TaharezLook/Button", "Collection_ItemFrame"..i)
    ItemFrame:setTexture("Normal", "UIData/Collection/Collection_UI.png",cropX,cropY)
    ItemFrame:setTexture("Hover","UIData/Collection/Collection_UI.png", cropX, cropY-40)
    
    ItemFrame:setPosition(posX,posY)
    ItemFrame:setSize(30, 30)
    ItemFrame:setVisible(true)
    ItemFrame:setAlwaysOnTop(true)
    ItemFrame:setZOrderingEnabled(true)
	ItemFrame:subscribeEvent("Clicked", function()
		winMgr:getWindow("Collection_ItemReward"):setVisible(false)
		RegisterItem()
        
    end)
    ItemCollectionBackround:addChildWindow(ItemFrame)
	MockUpLoopRewardButtons()


	




    
   
end	


function createRewardButtons(i,item_path,posX,posY,sizeX,sizeY,cropX,cropY)

	local aspectRatio_BtnReward = 24 / 22
    local newWidth_BtnReward = 120
    local newHeight_BtnReward = newWidth_BtnReward * aspectRatio_BtnReward
    createRewardButtonsBackround = winMgr:getWindow("Collection_ItemRequirement")
	BtnReward = winMgr:createWindow("TaharezLook/StaticImage", "Collection_ItemRewardDetail_"..i)
	BtnReward:setTexture("Enabled", "UIData/Collection/Collection_UI.png", cropX,cropY)
    BtnReward:setPosition(posX,posY)
    BtnReward:setSize(sizeX,sizeY)
	BtnReward:setScaleWidth(newWidth_BtnReward+40)
    BtnReward:setScaleHeight(newWidth_BtnReward+20)
    BtnReward:setVisible(true)
    BtnReward:setAlwaysOnTop(true)
    BtnReward:setZOrderingEnabled(true)
    createRewardButtonsBackround:addChildWindow(BtnReward)

end

function MockUpLoopRewardButtons()
    -- Configuration
    local cardwidth = 550
    local items = 9 -- Total number of items
    local columns = 5 -- Max columns per row
    local padding = 10 -- Space between items
    local sizeX, sizeY = 24, 21 -- Size of each item
    local containerWidth = (cardwidth - ((sizeX * columns) + (padding * (columns - 1)))) / 2
    local startY = 20 -- Starting Y-coordinate
    local cropItemArr = {
        {625, 793}, {625, 793}, {625, 793}, {625, 793}, {625, 793},
        {625, 793}, {625, 793}, {625, 793}, {625, 793}
    }

    -- Loop to render items dynamically with center alignment
    local currentIndex = 0
    while currentIndex < items do
        -- Calculate the number of items in the current row
        local itemsInRow = math.min(columns, items - currentIndex)

		local totalRowWidth = itemsInRow * sizeX + (itemsInRow - 1) * padding

		-- Calculate starting X to center items
		local startX = (containerWidth - totalRowWidth) / 2

        -- Render items in the current row
        for i = 1, itemsInRow do
            local posX = startX + (i - 1) * (sizeX + padding)
            local posY = startY + math.floor(currentIndex / columns) * (sizeY + padding)

            -- Get crop coordinates
            local cropX, cropY = cropItemArr[currentIndex + 1][1], cropItemArr[currentIndex + 1][2]

            -- Render the item
            createRewardButtons("item_set_Btn"..currentIndex, "", posX, posY, sizeX, sizeY, cropX, cropY)
            currentIndex = currentIndex + 1
        end
    end
end



function RenderItemRewards(i,item_path,posX,posY,sizeX,sizeY,cropX,cropY)
    ItemCollectionBackround = winMgr:getWindow("Collection_ItemReward")
    ItemFrame = winMgr:createWindow("TaharezLook/Button", "Collection_ItemFrame"..i)
    ItemFrame:setTexture("Normal", "UIData/Collection/Collection_Register_UI.png",cropX,cropY)
    -- ItemFrame:setTexture("Hover","UIData/Collection/Collection_UI.png", cropX, cropY-40)
    
    ItemFrame:setPosition(posX,posY)
    ItemFrame:setSize(sizeX,sizeY)
    ItemFrame:setVisible(true)
    ItemFrame:setAlwaysOnTop(true)
    ItemFrame:setZOrderingEnabled(true)
    ItemCollectionBackround:addChildWindow(ItemFrame)
    
    LOG("test RenderItemFrame")
    if item_path ~= "" then
        LOG("item_path is not null after render ".. item_path)
        ItemImg = winMgr:createWindow("TaharezLook/Button", "Collection_ItemImgData"..i)
        ItemImg:setTexture("Normal", item_path, 0, 0)
        
        -- ItemImg:setTexture("Normal", "UIData/Collection/Collection_UI.png", 95, cropY)
        ItemImg:setPosition(2,2)
        ItemImg:setSize(100, 100)
        ItemImg:setScaleWidth(65)
        ItemImg:setScaleHeight(65)
        ItemImg:setVisible(true)
    -- hover event
    
    ItemFrame:addChildWindow(ItemImg)
    end
end




function MockUpLoopItemSet()
-- Configuration
local cardwidth = 570
local items = 9 -- Total number of items
local columns = 5 -- Max columns per row
local padding = 5 -- Space between items
local sizeX, sizeY = 30, 30 -- Size of each item
local containerWidth = (cardwidth - ((sizeX * columns) + (padding * (columns - 1)))) / 2 -- Width of the container (ItemCollectionBackround)
local startY = 20 -- Starting Y-coordinate
local cropItemArr = {
	{0, 815}, {35, 815}, {70, 815}, {105, 815}, {140, 815},
	{175, 815}, {210, 815}, {245, 815} ,{280, 815}
}

-- Loop to render items dynamically with center alignment
	local currentIndex = 0
	while currentIndex < items do
	-- Calculate the number of items in the current row
		local itemsInRow = math.min(columns, items - currentIndex)

		-- Calculate total row width
		local totalRowWidth = itemsInRow * sizeX + (itemsInRow - 1) * padding

		-- Calculate starting X to center items
		local startX = (containerWidth - totalRowWidth) / 2

		-- Render items in the current row
		for i = 1, itemsInRow do
			local posX = startX + (i - 1) * (sizeX + padding)
			local posY = startY + math.floor(currentIndex / columns) * (sizeY + padding)

			-- Get crop coordinates
			local cropX, cropY = cropItemArr[currentIndex + 1][1], cropItemArr[currentIndex + 1][2]

			-- Render the item
			RenderItemSet("item_set_"..currentIndex, "", posX, posY, sizeX, sizeY, cropX, cropY)
			currentIndex = currentIndex + 1
		end
	end
end

function MockUpLoopItemReward()
	LOG("MockUpLoopItemReward")
	-- Configuration
	local cardwidth = 600
	local items = 6 -- Total number of items
	local columns = 3 -- Max columns per row
	local padding = 5 -- Space between items
	local sizeX, sizeY = 40, 40 -- Size of each item
	local containerWidth = (cardwidth - ((sizeX * columns) + (padding * (columns - 1)))) / 2 -- Width of the container (ItemCollectionBackround)
	local startY = 5-- Starting Y-coordinate
	local cropItemArr = {
		{45, 435}, {0, 435}, {45*2,435 }, {45*3, 435}, {45*4, 435},
		{45*5, 435}, {45*6,435}, {80, 435}
	}

	-- Loop to render items dynamically with center alignment
	local currentIndex = 0
	while currentIndex < items do
		-- Calculate the number of items in the current row
		local itemsInRow = math.min(columns, items - currentIndex)

		-- Calculate total row width
		local totalRowWidth = itemsInRow * sizeX + (itemsInRow - 1) * padding

		-- Calculate starting X to center items
		local startX = (containerWidth - totalRowWidth) / 2

		-- Render items in the current row
		for i = 1, itemsInRow do
			local posX = startX + (i - 1) * (sizeX + padding)-15
			local posY = startY + math.floor(currentIndex / columns) * (sizeY + padding)

			-- Get crop coordinates
			local cropX, cropY = cropItemArr[currentIndex + 1][1], cropItemArr[currentIndex + 1][2]

			-- Render the item
			RenderItemRewards("item_reward"..currentIndex, "", posX, posY, sizeX, sizeY, cropX, cropY)
			currentIndex = currentIndex + 1
		end
	end
end



function RegisterItem()
	
	ItemCollectionBackround = winMgr:createWindow("TaharezLook/StaticImage", "Collection_ItemCollectionBackround")
    ItemCollectionBackround:setTexture("Enabled", "UIData/Collection/Collection_Register_UI.png", 0, 565)
    ItemCollectionBackround:setPosition(645, 50)
    ItemCollectionBackround:setSize(235,425 )
    ItemCollectionBackround:setVisible(true)
    ItemCollectionBackround:setAlwaysOnTop(true)
    ItemCollectionBackround:setZOrderingEnabled(true)
	
    background:addChildWindow(ItemCollectionBackround)



	local aspectRatio_ItemCollection = 200 / 100
    local newWidth_ItemCollection = 145
    local newHeight_ItemCollection = newWidth_ItemCollection * aspectRatio_ItemCollection
	RegisterItemdCilck = winMgr:createWindow("TaharezLook/StaticImage", "Collection_ItemRewardDetail")
    RegisterItemdCilck:setTexture("Enabled", "UIData/Collection/Collection_UI.png", 314, 765)
    -- RegisterItemdCilck:setPosition((210-200)/2,186)
     RegisterItemdCilck:setPosition((10)/2, 200)

    RegisterItemdCilck:setSize(200,100 )
	RegisterItemdCilck:setScaleWidth(newHeight_ItemCollection)
    RegisterItemdCilck:setScaleHeight(newHeight_ItemCollection)
    RegisterItemdCilck:setVisible(true)
    RegisterItemdCilck:setAlwaysOnTop(true)
    RegisterItemdCilck:setZOrderingEnabled(true)
    ItemCollectionBackround:addChildWindow(RegisterItemdCilck)

	text = Text("Collection_Item_Reward")
	text:setText("High Adventure Hat")
	--mid top background
	text:setPosition(70,5)
	text:setSize(200, 20)
	text:setFont("tahoma", 10)
	text:setTextColor(43, 255,0,255)
	RegisterItemdCilck:addChildWindow(text)


	text = Text("Collection_ItemSet11")
	text:setText("Good quality travel sun hat.")
	--mid top background
	text:setPosition(55, 90)
	text:setSize(200, 20)
	text:setFont("tahoma", 10)
	text:setTextColor(229, 224,224,255)
	RegisterItemdCilck:addChildWindow(text)


	local aspectRatio_ItemSetShow = 33 / 31
    local newWidth_ItemSetShow = 400
    local newHeight_ItemSetShow = newWidth_ItemSetShow * aspectRatio_ItemSetShow
	ItemSetShow = winMgr:createWindow("TaharezLook/StaticImage", "Collection_ItemSet10")
    ItemSetShow:setTexture("Enabled", "UIData/Collection/Collection_UI.png", 210, 815)
    ItemSetShow:setPosition(80,20)
    ItemSetShow:setSize(31, 33)
	ItemSetShow:setScaleWidth(newHeight_ItemSetShow)
    ItemSetShow:setScaleHeight(newHeight_ItemSetShow)
    ItemSetShow:setVisible(true)
    ItemSetShow:setAlwaysOnTop(true)
    ItemSetShow:setZOrderingEnabled(true)
    RegisterItemdCilck:addChildWindow(ItemSetShow)


	-- text = Text("Collection_Item_Set")
	-- text:setText("High Adventure Set")
	-- --mid top background
	-- text:setPosition(70, 85)
	-- text:setSize(200, 20)
	-- text:setFont("tahoma", 10)
	-- text:setTextColor(43, 255,0,255)
	-- ItemCollectionBackround:addChildWindow(text)

	ItemBtnAdd = winMgr:createWindow("TaharezLook/StaticImage", "Collection_ItemAdd")
    ItemBtnAdd:setTexture("Enabled", "UIData/Collection/Collection_UI.png", 315, 875)
    ItemBtnAdd:setPosition((340-200)/2,340)
    ItemBtnAdd:setSize(100,30 )
    ItemBtnAdd:setVisible(true)
    ItemBtnAdd:setAlwaysOnTop(true)
    ItemBtnAdd:setZOrderingEnabled(true)
    ItemCollectionBackround:addChildWindow(ItemBtnAdd)
	ItemBtnAdd:subscribeEvent("MouseClick", function()
			
		RegisterSet()
	end)


end

 function RegisterSet()

	RegisterSetCollectionBackround = winMgr:createWindow("TaharezLook/StaticImage", "Collection_RegisterSetCollectionBackround")
    RegisterSetCollectionBackround:setTexture("Enabled", "UIData/Collection/Collection_Register_UI.png", 0, 0)
    RegisterSetCollectionBackround:setPosition(300, 50)
    RegisterSetCollectionBackround:setSize(312,432 )
    RegisterSetCollectionBackround:setVisible(true)
    RegisterSetCollectionBackround:setAlwaysOnTop(true)
    RegisterSetCollectionBackround:setZOrderingEnabled(true)
    background:addChildWindow(RegisterSetCollectionBackround)

	text = Text("Collection_Register_Requirement")
	text:setText("Register")
	--mid top background
	text:setPosition(115, 10)
	text:setSize(200, 20)
	text:setFont("tahoma", 15)
	text:setTextColor(255, 182,80,255)
	RegisterSetCollectionBackround:addChildWindow(text)

	text = Text("Collection_Register_Requirement2")
	text:setText("Register this item ?")
	--mid top background
	text:setPosition(100, 49)
	text:setSize(200, 20)
	text:setFont("tahoma", 10)
	text:setTextColor(255, 255,255,255)
	RegisterSetCollectionBackround:addChildWindow(text)

	text = Text("Collection_Register_Requirement3")
	text:setText("Registering this item will destroy it.")
	--mid top background
	text:setPosition(70, 65)
	text:setSize(200, 20)
	text:setFont("tahoma", 10)
	text:setTextColor(255, 0,0,255)
	RegisterSetCollectionBackround:addChildWindow(text)

	RegistecCancel = winMgr:createWindow("TaharezLook/StaticImage", "Collection_RegistecCancel")
    RegistecCancel:setTexture("Enabled", "UIData/Collection/Collection_UI.png", 624, 724)
    RegistecCancel:setPosition(289, 4)
    RegistecCancel:setSize(17,16 )
    RegistecCancel:setVisible(true)
    RegistecCancel:setAlwaysOnTop(true)
    RegistecCancel:setZOrderingEnabled(true)
    RegisterSetCollectionBackround:addChildWindow(RegistecCancel)
	RegistecCancel:subscribeEvent("MouseClick", function()
		RegisterSetCollectionBackround:setVisible(false)  
	end)

	local aspectRatio_RegisterRequirement = 200 / 100
    local newWidth_RegisterRequirement = 141
    local newHeight_RegisterRequirement = newWidth_RegisterRequirement * aspectRatio_RegisterRequirement
    RegisterRequirement = winMgr:createWindow("TaharezLook/StaticImage", "Collection_RegisterRequirement")
    RegisterRequirement:setTexture("Enabled", "UIData/Collection/Collection_UI.png", 314, 765)
    RegisterRequirement:setPosition((210-200)/2,110)
    RegisterRequirement:setSize(200,100 )
	RegisterRequirement:setScaleWidth(newHeight_RegisterRequirement+90)
    RegisterRequirement:setScaleHeight(newHeight_RegisterRequirement+380)
    RegisterRequirement:setVisible(true)
    RegisterRequirement:setAlwaysOnTop(true)
    RegisterRequirement:setZOrderingEnabled(true)
    RegisterSetCollectionBackround:addChildWindow(RegisterRequirement)

	local aspectRatio_RegisterSetItem = 275 / 50
    local newWidth_RegisterSetItem = 50
    local newHeight_RegisterSetItem = newWidth_RegisterSetItem * aspectRatio_RegisterSetItem
    RegisterSetItem = winMgr:createWindow("TaharezLook/Button", "Collection_RegisterSetItem")
    RegisterSetItem:setTexture("Normal", "UIData/Collection/Collection_UI.png", 0, 965)
	RegisterSetItem:setTexture("Hover", "UIData/Collection/Collection_UI.png", 0, 910)
    RegisterSetItem:setPosition((216-200)/2,115)
    RegisterSetItem:setSize(275,50 )
	RegisterSetItem:setScaleWidth(newHeight_RegisterSetItem+15)
    RegisterSetItem:setScaleHeight(newHeight_RegisterSetItem)
    RegisterSetItem:setVisible(true)
    RegisterSetItem:setAlwaysOnTop(true)
    RegisterSetItem:setZOrderingEnabled(true)
    RegisterSetCollectionBackround:addChildWindow(RegisterSetItem)

	local aspectRatio_RegisterSetItem2 = 275 / 50
    local newWidth_RegisterSetItem2 = 50
    local newHeight_RegisterSetItem2 = newWidth_RegisterSetItem2 * aspectRatio_RegisterSetItem2
    RegisterSetItem2 = winMgr:createWindow("TaharezLook/Button", "Collection_RegisterSetItem2")
    RegisterSetItem2:setTexture("Normal", "UIData/Collection/Collection_UI.png", 0, 965)
	RegisterSetItem2:setTexture("Hover", "UIData/Collection/Collection_UI.png", 0, 910)
    RegisterSetItem2:setPosition((216-200)/2,165)
    RegisterSetItem2:setSize(275,50 )
	RegisterSetItem2:setScaleWidth(newHeight_RegisterSetItem2+15)
    RegisterSetItem2:setScaleHeight(newHeight_RegisterSetItem2)
    RegisterSetItem2:setVisible(true)
    RegisterSetItem2:setAlwaysOnTop(true)
    RegisterSetItem2:setZOrderingEnabled(true)
    RegisterSetCollectionBackround:addChildWindow(RegisterSetItem2)

	local aspectRatio_RegisterSetItem3 = 275 / 50
    local newWidth_RegisterSetItem3 = 50
    local newHeight_RegisterSetItem3 = newWidth_RegisterSetItem3 * aspectRatio_RegisterSetItem3
    RegisterSetItem3 = winMgr:createWindow("TaharezLook/Button", "Collection_RegisterSetItem3")
    RegisterSetItem3:setTexture("Normal", "UIData/Collection/Collection_UI.png", 0, 965)
	RegisterSetItem3:setTexture("Hover", "UIData/Collection/Collection_UI.png", 0, 910)
    RegisterSetItem3:setPosition((216-200)/2,216)
    RegisterSetItem3:setSize(275,50 )
	RegisterSetItem3:setScaleWidth(newHeight_RegisterSetItem3+15)
    RegisterSetItem3:setScaleHeight(newHeight_RegisterSetItem3)
    RegisterSetItem3:setVisible(true)
    RegisterSetItem3:setAlwaysOnTop(true)
    RegisterSetItem3:setZOrderingEnabled(true)
    RegisterSetCollectionBackround:addChildWindow(RegisterSetItem3)

	local aspectRatio_RegisterSetItem4 = 275 / 50
    local newWidth_RegisterSetItem4 = 50
    local newHeight_RegisterSetItem4 = newWidth_RegisterSetItem4 * aspectRatio_RegisterSetItem4
    RegisterSetItem4 = winMgr:createWindow("TaharezLook/Button", "Collection_RegisterSetItem4")
    RegisterSetItem4:setTexture("Normal", "UIData/Collection/Collection_UI.png", 0, 965)
	RegisterSetItem4:setTexture("Hover", "UIData/Collection/Collection_UI.png", 0, 910)
    RegisterSetItem4:setPosition((216-200)/2,268)
    RegisterSetItem4:setSize(275,50 )
	RegisterSetItem4:setScaleWidth(newHeight_RegisterSetItem4+15)
    RegisterSetItem4:setScaleHeight(newHeight_RegisterSetItem4)
    RegisterSetItem4:setVisible(true)
    RegisterSetItem4:setAlwaysOnTop(true)
    RegisterSetItem4:setZOrderingEnabled(true)
    RegisterSetCollectionBackround:addChildWindow(RegisterSetItem4)

	
    RegisterPagination = winMgr:createWindow("TaharezLook/StaticImage", "Collection_RegisterPagination")
    RegisterPagination:setTexture("Enabled", "UIData/Collection/Collection_UI.png", 625, 817)
    RegisterPagination:setPosition(120,330)
    RegisterPagination:setSize(18,17 )
    RegisterPagination:setVisible(true)
    RegisterPagination:setAlwaysOnTop(true)
    RegisterPagination:setZOrderingEnabled(true)
    RegisterSetCollectionBackround:addChildWindow(RegisterPagination)

	RegisterPagination2 = winMgr:createWindow("TaharezLook/StaticImage", "Collection_RegisterPagination2")
    RegisterPagination2:setTexture("Enabled", "UIData/Collection/Collection_UI.png", 625, 835)
    RegisterPagination2:setPosition(165,330)
    RegisterPagination2:setSize(18,17 )
    RegisterPagination2:setVisible(true)
    RegisterPagination2:setAlwaysOnTop(true)
    RegisterPagination2:setZOrderingEnabled(true)
    RegisterSetCollectionBackround:addChildWindow(RegisterPagination2)

	text = Text("Collection_Registe_Pagination")
	text:setText("1/1")
	text:setPosition(135, 330)
	text:setSize(20, 10)
	RegisterSetCollectionBackround:addChildWindow(text)

	local aspectRatio_RegisterIconItem = 33 / 31
    local newWidth_RegisterIconItem = 310
    local newHeight_RegisterIconItem = newWidth_RegisterIconItem * aspectRatio_RegisterIconItem
	RegisterIconItem = winMgr:createWindow("TaharezLook/StaticImage", "Collection_RegisterIconItem")
    RegisterIconItem:setTexture("Enabled", "UIData/Collection/Collection_UI.png", 210, 815)
    RegisterIconItem:setPosition(5,5)
    RegisterIconItem:setSize(31,33 )
	RegisterIconItem:setScaleWidth(newHeight_RegisterIconItem+5)
    RegisterIconItem:setScaleHeight(newHeight_RegisterIconItem+10)
    RegisterIconItem:setVisible(true)
    RegisterIconItem:setAlwaysOnTop(true)
    RegisterIconItem:setZOrderingEnabled(true)
    RegisterSetItem:addChildWindow(RegisterIconItem)


	text = Text("Collection_Register_Icon_Item")
	text:setText("High Adventure Hat +0")
	--mid top background
	text:setPosition(50, 15)
	text:setSize(1, 1)
	text:setFont("tahoma", 10)
	text:setTextColor(43, 255,0,255)
	RegisterSetItem:addChildWindow(text)


	local aspectRatio_RegisterIconItem2 = 33 / 31
    local newWidth_RegisterIconItem2 = 310
    local newHeight_RegisterIconItem2 = newWidth_RegisterIconItem2 * aspectRatio_RegisterIconItem2
	RegisterIconItem2 = winMgr:createWindow("TaharezLook/StaticImage", "Collection_RegisterIconItem2")
    RegisterIconItem2:setTexture("Enabled", "UIData/Collection/Collection_UI.png", 210, 815)
    RegisterIconItem2:setPosition(5,5)
    RegisterIconItem2:setSize(31,33 )
	RegisterIconItem2:setScaleWidth(newHeight_RegisterIconItem2+5)
    RegisterIconItem2:setScaleHeight(newHeight_RegisterIconItem2+10)
    RegisterIconItem2:setVisible(true)
    RegisterIconItem2:setAlwaysOnTop(true)
    RegisterIconItem2:setZOrderingEnabled(true)
    RegisterSetItem2:addChildWindow(RegisterIconItem2)


	text = Text("Collection_Register_Icon_Item2")
	text:setText("High Adventure Hat +3")
	--mid top background
	text:setPosition(50, 15)
	text:setSize(1, 1)
	text:setFont("tahoma", 10)
	text:setTextColor(43, 255,0,255)
	RegisterSetItem2:addChildWindow(text)

	text = Text("Collection_Register_Icon_Item3")
	text:setText("All def 3 ")
	--mid top background
	text:setPosition(50, 30)
	text:setSize(1, 1)
	text:setFont("tahoma", 10)
	text:setTextColor(142, 142,142,255)
	RegisterSetItem2:addChildWindow(text)

	text = Text("Collection_Register_Icon_Item4")
	text:setText("All atk 8 ")
	--mid top background
	text:setPosition(50, 40)
	text:setSize(1, 1)
	text:setFont("tahoma", 10)
	text:setTextColor(142, 142,142,255)
	RegisterSetItem2:addChildWindow(text)

	local aspectRatio_RegisterIconItem3 = 33 / 31
    local newWidth_RegisterIconItem3 = 310
    local newHeight_RegisterIconItem3 = newWidth_RegisterIconItem3 * aspectRatio_RegisterIconItem3
	RegisterIconItem3 = winMgr:createWindow("TaharezLook/StaticImage", "Collection_RegisterIconItem3")
    RegisterIconItem3:setTexture("Enabled", "UIData/Collection/Collection_UI.png", 210, 815)
    RegisterIconItem3:setPosition(5,5)
    RegisterIconItem3:setSize(31,33 )
	RegisterIconItem3:setScaleWidth(newHeight_RegisterIconItem3+5)
    RegisterIconItem3:setScaleHeight(newHeight_RegisterIconItem3+10)
    RegisterIconItem3:setVisible(true)
    RegisterIconItem3:setAlwaysOnTop(true)
    RegisterIconItem3:setZOrderingEnabled(true)
    RegisterSetItem3:addChildWindow(RegisterIconItem3)


	
	text = Text("Collection_Register_Icon_Item5")
	text:setText("High Adventure Hat +4")
	--mid top background
	text:setPosition(50,15)
	text:setSize(1, 1)
	text:setFont("tahoma", 10)
	text:setTextColor(43, 255,0,255)
	RegisterSetItem3:addChildWindow(text)

	text = Text("Collection_Register_Icon_Item6")
	text:setText("All def 14 ")
	--mid top background
	text:setPosition(50,30)
	text:setSize(1, 1)
	text:setFont("tahoma", 10)
	text:setTextColor(142, 142,142,255)
	RegisterSetItem3:addChildWindow(text)

	local aspectRatio_RegisterIconItem4 = 33 / 31
    local newWidth_RegisterIconItem4 = 310
    local newHeight_RegisterIconItem4 = newWidth_RegisterIconItem4 * aspectRatio_RegisterIconItem4
	RegisterIconItem4 = winMgr:createWindow("TaharezLook/StaticImage", "Collection_RegisterIconItem4")
    RegisterIconItem4:setTexture("Enabled", "UIData/Collection/Collection_UI.png", 210, 815)
    RegisterIconItem4:setPosition(5,5)
    RegisterIconItem4:setSize(31,33 )
	RegisterIconItem4:setScaleWidth(newHeight_RegisterIconItem4+5)
    RegisterIconItem4:setScaleHeight(newHeight_RegisterIconItem4+10)
    RegisterIconItem4:setVisible(true)
    RegisterIconItem4:setAlwaysOnTop(true)
    RegisterIconItem4:setZOrderingEnabled(true)
    RegisterSetItem4:addChildWindow(RegisterIconItem4)

	text = Text("Collection_Register_Icon_Item7")
	text:setText("High Adventure Hat +10")
	--mid top background
	text:setPosition(50,15)
	text:setSize(1, 1)
	text:setFont("tahoma", 10)
	text:setTextColor(43, 255,0,255)
	RegisterSetItem4:addChildWindow(text)

	text = Text("Collection_Register_Icon_Item8")
	text:setText("All def 72 ")
	--mid top background
	text:setPosition(50,30)
	text:setSize(1, 1)
	text:setFont("tahoma", 10)
	text:setTextColor(142, 142,142,255)
	RegisterSetItem4:addChildWindow(text)


	
	RegisterBtnAdd = winMgr:createWindow("TaharezLook/StaticImage", "Collection_RegisterBtnAdd")
    RegisterBtnAdd:setTexture("Enabled", "UIData/Collection/Collection_UI.png", 314, 874)
    RegisterBtnAdd:setPosition(100,380)
    RegisterBtnAdd:setSize(100,31 )
    RegisterBtnAdd:setVisible(true)
    RegisterBtnAdd:setAlwaysOnTop(true)
    RegisterBtnAdd:setZOrderingEnabled(true)
    RegisterSetCollectionBackround:addChildWindow(RegisterBtnAdd)
	

 end
