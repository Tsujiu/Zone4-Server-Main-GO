local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")

local GUITool = require("GUITools")
local ImGUI = require("ImGuiDebug")

-- local json = require("cjson") -- Ensure you have a JSON library available
guiSystem:setGUISheet(root)

local IsRankingOverallPanalOpen = false
-- Using for setting Text of Player Stat
NMatchText = winMgr:createWindow("TaharezLook/StaticText", "NMatchText")     
WinRateText = winMgr:createWindow("TaharezLook/StaticText", "WinRateText")   
KDAText = winMgr:createWindow("TaharezLook/StaticText", "KDAText")   
KOText = winMgr:createWindow("TaharezLook/StaticText", "KOText")   
MVPText = winMgr:createWindow("TaharezLook/StaticText", "MVPText")   
DMGText = winMgr:createWindow("TaharezLook/StaticText", "DMGText")   

-- Using for setting Personal Icon IMG
UserIconIMG = winMgr:createWindow("TaharezLook/StaticImage", "UserIconIMG")

-- Match History Section
local currentStartIndex = 1 -- Start of the current range
local pageSize = 5 -- Number of datasets per page
local Display_match = {}


-- Sprite sheets 
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


local UniqueIMGID = 0
local IsShowOtherName = 0

-- Main Background image 
    
-- Parent Object for MainSeasonalPanal 
local MainOverAllPanalParent = winMgr:createWindow("TaharezLook/StaticImage", "MainOverAllPanalParent")
MainOverAllPanalParent:setTexture("Enabled", "UIData/invisible.tga", 0, 0)        
MainOverAllPanalParent:setVisible(true)
MainOverAllPanalParent:setAlwaysOnTop(false)
GUITool.AnchorMiddle(MainOverAllPanalParent)
MainOverAllPanalParent:setPosition(-(1024/2),-(728/2))

BackgroundIMG = winMgr:createWindow("TaharezLook/StaticImage", "BackgroundIMG2")
BackgroundIMG:setTexture("Enabled", "UIData/WndRankingOverall_Background.png", 0, 100) 
BackgroundIMG:setPosition((g_MAIN_WIN_SIZEX - 800) / 2 , ((g_MAIN_WIN_SIZEY - 600) / 2) + 100)
BackgroundIMG:setSize(805, 500)
BackgroundIMG:setZOrderingEnabled(false)
BackgroundIMG:setAlwaysOnTop(true)
BackgroundIMG:setVisible(false)
MainOverAllPanalParent:addChildWindow(BackgroundIMG)

-- Create the background image 

HistoryBackgroundIMG = winMgr:createWindow("TaharezLook/StaticImage", "HistoryBackgroundIMG")
HistoryBackgroundIMG:setTexture("Enabled", "UIData/WndRankingOverall_Background_History.png", 16, 119)
-- HistoryBackgroundIMG:setTexture("Disabled", "UIData/myinfo.tga", 0, 0)  
HistoryBackgroundIMG:setPosition((g_MAIN_WIN_SIZEX - 805) / 2 , ((g_MAIN_WIN_SIZEY - 500) / 2) + 70)
HistoryBackgroundIMG:setSize(805, 500)
HistoryBackgroundIMG:setZOrderingEnabled(false)
HistoryBackgroundIMG:setVisible(false)
HistoryBackgroundIMG:setAlwaysOnTop(true)
MainOverAllPanalParent:addChildWindow(HistoryBackgroundIMG)


-- TabBar on Top 
BackgroundPanalIMG = winMgr:createWindow("TaharezLook/StaticImage", "BackgroundPanalIMG")
OverallPanalIMG = winMgr:createWindow("TaharezLook/Button", "OverallPanalIMG")
HistoryPanalIMG = winMgr:createWindow("TaharezLook/Button", "HistoryPanalIMG")
CustomPanalIMG = winMgr:createWindow("TaharezLook/Button", "CustomPanalIMG")

function MainPanal()
    -- GetTSCharacter()   
    
    winMgr:getWindow("BackgroundPanalIMG"):setVisible(true)
    winMgr:getWindow("OverallPanalIMG"):setVisible(true)
    winMgr:getWindow("HistoryPanalIMG"):setVisible(true)
    winMgr:getWindow("CustomPanalIMG"):setVisible(true)

    BackgroundPanalIMG:setTexture("Enabled", "UIData/WndRankingOverall_Background.png", 0, 0)
    -- BackgroundPanalIMG:setTexture("Disabled", "UIData/myinfo.tga", 0, 0)  
    BackgroundPanalIMG:setPosition((g_MAIN_WIN_SIZEX - 800) / 2 , ((g_MAIN_WIN_SIZEY - 600) / 2) - 25)
    BackgroundPanalIMG:setSize(805, 100)
    BackgroundPanalIMG:setZOrderingEnabled(false)
    MainOverAllPanalParent:addChildWindow(BackgroundPanalIMG)  

    OverallPanalIMG:setTexture("Normal", "UIData/RankOverall.png", 4, 13)
    -- OverallPanalIMG:setTexture("Disabled", "UIData/myinfo.tga", 0, 0)  
    OverallPanalIMG:setPosition(10, 27)
    OverallPanalIMG:setSize(200, 50)
    OverallPanalIMG:setZOrderingEnabled(false)
    OverallPanalIMG:setClippedByParent(false)
    OverallPanalIMG:subscribeEvent("Clicked", function()  	    
        ToggleRankingOverallPanal(1)  
        ToggleRankingHistory(0)
    end)     
    BackgroundPanalIMG:addChildWindow(OverallPanalIMG)

    -- OverallPanal 
    HistoryPanalIMG:setTexture("Normal", "UIData/RankOverall.png", 217, 13)
    -- HistoryPanalIMG:setTexture("Disabled", "UIData/myinfo.tga", 0, 0)  
    HistoryPanalIMG:setPosition(215, 27)
    HistoryPanalIMG:setSize(200, 50)
    HistoryPanalIMG:setClippedByParent(false)
    HistoryPanalIMG:setZOrderingEnabled(false)
    HistoryPanalIMG:subscribeEvent("Clicked", function()   	
    ToggleRankingOverallPanal(0)  
    ToggleRankingHistory(1)
    end) 
    BackgroundPanalIMG:addChildWindow(HistoryPanalIMG)

    ToggleRankingOverallPanal(1)  
    ToggleRankingHistory(0)  

    -- OverallPanal 
    CustomPanalIMG:setTexture("Normal", "UIData/RankOverall.png", 430, 13)
    -- CustomPanalIMG:setTexture("Disabled", "UIData/myinfo.tga", 0, 0)  
    CustomPanalIMG:setPosition(420, 27)
    CustomPanalIMG:setSize(200, 50)
    CustomPanalIMG:setZOrderingEnabled(false)
    CustomPanalIMG:setClippedByParent(false)
    BackgroundPanalIMG:addChildWindow(CustomPanalIMG)               

    InitRankingOverallPanal()
    InitRankingHistory() 

    SettingDefaultProfile(0)    
    UsernamePanal()           

    -- -- User Icon Panal
    winMgr:getWindow("UserIconIMG"):setVisible(true)
    winMgr:getWindow("UsernamePanalIMG"):setVisible(true)
    winMgr:getWindow("UsernameText"):setVisible(true)
    winMgr:getWindow("UsernameLevelText"):setVisible(true)   
    
end

function CloseMainPanal()
    winMgr:getWindow("BackgroundPanalIMG"):setVisible(false)
    winMgr:getWindow("OverallPanalIMG"):setVisible(false)
    winMgr:getWindow("HistoryPanalIMG"):setVisible(false)
    winMgr:getWindow("CustomPanalIMG"):setVisible(false)

    -- User Icon Panal
    winMgr:getWindow("UserIconIMG"):setVisible(false)
    winMgr:getWindow("UsernamePanalIMG"):setVisible(false)
    winMgr:getWindow("UsernameText"):setVisible(false)
    winMgr:getWindow("UsernameLevelText"):setVisible(false)      

    ToggleRankingOverallPanal(0)  
    ToggleRankingHistory(0)  
end

function ToggleRankingOverallPanal(ActiveCode)
    if ActiveCode == 0 then
        BackgroundIMG:setVisible(false)	
    elseif ActiveCode == 1 then
        -- GetTSCharacter()  
        BackgroundIMG:setVisible(true)	
    end
end

function ToggleRankingHistory(ActiveCode)
    
    if ActiveCode == 0 then
        HistoryBackgroundIMG:setVisible(false)	
    elseif ActiveCode == 1 then
        HistoryBackgroundIMG:setVisible(true)	
    end
end



local TempData = _G.PersonalData
local img_CharacterX = 0
local img_CharacterY = 0

function SettingDefaultProfile(bone)
    
	if bone == 0 then
		-- Wells
		img_CharacterX = tRankImgWellsX[1]
		img_CharacterY = tRankImgWellsY[1]
	elseif bone == 1 then
		-- Ray
		img_CharacterX = tRankImgRayX[1]
		img_CharacterY = tRankImgRayY[1]
	elseif bone == 2 then
		-- Joony
		img_CharacterX = tRankImgJoonyX[1]
		img_CharacterY = tRankImgJoonyY[1]
	elseif bone == 3 then
		-- Lilru
		img_CharacterX = tRankImgLilruX[1]
		img_CharacterY = tRankImgLilruY[1]
	elseif bone == 4 then
		-- Nicky
		img_CharacterX = tRankImgNickyX[1]
		img_CharacterY = tRankImgNickyY[1]
	elseif bone == 5 then
		-- Sera
		img_CharacterX = tRankImgSeraX[1]
		img_CharacterY = tRankImgSeraY[1]
	else
		img_CharacterX = tRankImgSeraX[1]
		img_CharacterY = tRankImgSeraY[1]
	end
end

function ResetNameText(Name, Level)
        -- Set UsernameText (Name)
        -- LOG("Test ResetNameText [Name]: " .. Name)
        -- LOG("Test ResetNameText [Level]: " .. Level)

        IsShowOtherName = 1

        local UsernameText = winMgr:getWindow("UsernameText")          
        UsernameText:setFont("tahoma", 30)	
        UsernameText:setText(Name)         
    
        -- Set UsernameText (Level)
        local UsernameLevelText = winMgr:getWindow("UsernameLevelText")              
        UsernameLevelText:setFont("tahoma", 15)	
        UsernameLevelText:setText("Level: " .. Level)  
end

function UsernamePanal()

    -- Function to split and trim the input string
    local function processTempData(input)
        -- Trim function to remove trailing and leading spaces
        local function trim(s)
            return s:match("^%s*(.-)%s*$")
        end

        -- Split the input string based on the comma
        local name, value = input:match("^(.-)%s*,%s*(.*)$")
        
        if name and value then
            -- Trim spaces behind the character name
            name = trim(name)
            -- Return the trimmed name and numeric value
            return name, value
        else
            -- Return default values if input doesn't match the expected pattern
            return "Unknown", "0"
        end
    end    
    
    -- Process TempData to get username and level
    local username, level = processTempData(TempData)
    -- Icon boarder
    UsernamePanalIMG = winMgr:createWindow("TaharezLook/StaticImage", "UsernamePanalIMG")
    UsernamePanalIMG:setTexture("Enabled", "UIData/invisible.tga", 700, 200)     
    UsernamePanalIMG:setPosition(((g_MAIN_WIN_SIZEX - 200) / 4) - 120, 190)
    UsernamePanalIMG:setSize(200, 200) 
    UsernamePanalIMG:setAlwaysOnTop(true)
    UsernamePanalIMG:setZOrderingEnabled(true)
    root:addChildWindow(UsernamePanalIMG)    

  
    -- Username & Icon Character

    -- DefaultIconImg     
    if(UniqueIMGID ~= 0) then      
        -- LOG("UniqueIMGID: ".. UniqueIMGID)
        UserIconIMG:setTexture("Enabled", "UIData/Profile/".. UniqueIMGID .. ".tga", 0, 0)
        UserIconIMG:setSize(52, 54)
        UserIconIMG:setScaleHeight(500)
        UserIconIMG:setScaleWidth(500)	      
    else
        UserIconIMG:setTexture("Enabled", "UIData/ranking_board.img", (img_CharacterX), (img_CharacterY))
        UserIconIMG:setSize(105, 110)
    end            
    UserIconIMG:setPosition(25, 5)   
    UserIconIMG:setZOrderingEnabled(false)
    UserIconIMG:setAlwaysOnTop(true)
    UsernamePanalIMG:addChildWindow(UserIconIMG)   
    
    -- Set UsernameText (Name)
    UsernameText = winMgr:createWindow("TaharezLook/StaticText", "UsernameText")          
    UsernameText:setPosition(145 , 35)
    UsernameText:setSize(300, 50)
    UsernameText:setZOrderingEnabled(false)
    UsernameText:setAlwaysOnTop(true)
    UsernameText:setTextColor(255, 255, 255, 255)
    UsernameText:setFont("tahoma", 30)	
    
    UsernamePanalIMG:addChildWindow(UsernameText)   
      
    -- Set UsernameText (Level)
    UsernameLevelText = winMgr:createWindow("TaharezLook/StaticText", "UsernameLevelText")          
    UsernameLevelText:setPosition(150 , 70)
    UsernameLevelText:setSize(300, 50)
    UsernameLevelText:setZOrderingEnabled(false)
    UsernameLevelText:setAlwaysOnTop(true)
    UsernameLevelText:setTextColor(255, 255, 255, 255)
    UsernameLevelText:setFont("tahoma", 15)	
     
    UsernamePanalIMG:addChildWindow(UsernameLevelText)  
    
    if IsShowOtherName == 0 then
        UsernameText:setText(username)  
        UsernameLevelText:setText("Level: " .. level)  
    end

    -- Icon
    IconIMG = winMgr:createWindow("TaharezLook/StaticImage", "IconIMG")
    IconIMG:setTexture("Enabled", "UIData/RankOverall.png", 8, 155)
    IconIMG:setPosition(20, 0)
    IconIMG:setSize(125, 125)
    IconIMG:setZOrderingEnabled(false)
    IconIMG:setAlwaysOnTop(true)
    UsernamePanalIMG:addChildWindow(IconIMG)
    
    -- Using for reset boolean IsShowOtherName
    IsShowOtherName = 0
 
end

function SetUniqueIcon(ImgKey)
    LOG("Test Profile IMG ID: ".. ImgKey)
    UniqueIMGID = ImgKey
    -- UsernamePanal()   
    UniqueIMG = winMgr:getWindow("UserIconIMG")
    UniqueIMG:setTexture("Enabled", "UIData/Profile/" .. ImgKey  .. ".tga",0,0)    
end


-- Define the toggle function
function InitRankingOverallPanal()          

    bgWidth = 805 
    bgHeight = 500 

    -- Call Player Info    
	NMatchText:setTextColor(255, 255, 255, 255)
	NMatchText:setFont("tahoma", 30)	
	NMatchText:setText("0")
	NMatchText:setPosition(400, 120)
	NMatchText:setSize(500, 100)
	NMatchText:setAlwaysOnTop(true)
    NMatchText:setVisible(true)
	BackgroundIMG:addChildWindow(NMatchText)

    
	WinRateText:setTextColor(255, 255, 255, 255)
	WinRateText:setFont("tahoma", 30)	
	WinRateText:setText("0.0 %")
	WinRateText:setPosition(675, 120)
	WinRateText:setSize(500, 100)
	WinRateText:setAlwaysOnTop(true)
    WinRateText:setVisible(true)
	BackgroundIMG:addChildWindow(WinRateText)

    KDAText:setTextColor(255, 255, 255, 255)
	KDAText:setFont("tahoma", 30)	
	KDAText:setText("0.0")
	KDAText:setPosition(400, 220)
	KDAText:setSize(500, 100)
	KDAText:setAlwaysOnTop(true)
    KDAText:setVisible(true)
	BackgroundIMG:addChildWindow(KDAText)

    KOText:setTextColor(255, 255, 255, 255)
	KOText:setFont("tahoma", 30)	
	KOText:setText("0")
	KOText:setPosition(675, 220)
	KOText:setSize(500, 100)
	KOText:setAlwaysOnTop(true)
    KOText:setVisible(true)
	BackgroundIMG:addChildWindow(KOText)

    MVPText:setTextColor(255, 255, 255, 255)
	MVPText:setFont("tahoma", 30)	
	MVPText:setText("0")
	MVPText:setPosition(400, 330)
	MVPText:setSize(500, 100)
	MVPText:setAlwaysOnTop(true)
    MVPText:setVisible(true)
	BackgroundIMG:addChildWindow(MVPText)

    DMGText:setTextColor(255, 255, 255, 255)
	DMGText:setFont("tahoma", 30)	
	DMGText:setText("0")
	DMGText:setPosition(675, 330)
	DMGText:setSize(500, 100)
	DMGText:setAlwaysOnTop(true)
    DMGText:setVisible(true)
	BackgroundIMG:addChildWindow(DMGText)

end

-- Function to set overall panel data
function SetOverallPanalData(Data)
    -- LOG("Lua SetOverallPanalData ------------------------")
    -- LOG(tostring(Data))
    -- LOG("Lua SetOverallPanalData ------------------------")

    -- Remove -- log timestamps or extraneous text before the data
    local sanitizedData = Data:match("{.*}") -- Extract the first block starting with '{'

    if not sanitizedData then
        -- LOG("Error: Input data does not contain a valid structure.")
        return
    end

    -- Extract "Stats" block using pattern matching
    local statsString = sanitizedData:match('"Stats"%s*:%s*{(.*)}') -- Match the "Stats" key and its block
    if not statsString then
        -- LOG("Error: 'Stats' block not found in the input data.")
        return
    end

    -- Extract individual fields from the Stats block
    local totalMatches = tonumber(statsString:match('"Total Matches"%s*:%s*(%d+)')) or 0
    local winRate = tonumber(statsString:match('"Win Rate"%s*:%s*([%d%.]+)')) or 0.0
    local kdRatio = tonumber(statsString:match('"K/D Ratio"%s*:%s*([%d%.]+)')) or 0.0
    local ko = tonumber(statsString:match('"KO"%s*:%s*(%d+)')) or 0
    local mvpCount = tonumber(statsString:match('"MVP Count"%s*:%s*(%d+)')) or 0
    local totalDamage = tonumber(statsString:match('"Total Damage"%s*:%s*(%d+)')) or 0

    -- -- Log extracted values for debugging
    -- LOG(string.format("Total Matches: %d", totalMatches))
    -- LOG(string.format("Win Rate: %.2f%%", winRate))
    -- LOG(string.format("K/D Ratio: %.2f", kdRatio))
    -- LOG(string.format("KO: %d", ko))
    -- LOG(string.format("MVP Count: %d", mvpCount))
    -- LOG(string.format("Total Damage: %d", totalDamage))

    -- Set the text fields using the extracted values
    NMatchText:setText(tostring(totalMatches))
    WinRateText:setText(string.format("%.2f%%", winRate)) -- Format as percentage
    KDAText:setText(string.format("%.2f", kdRatio))       -- Format as a decimal
    KOText:setText(tostring(ko))
    MVPText:setText(tostring(mvpCount))
    DMGText:setText(tostring(totalDamage))
end

function CalculateTotalPages()
    local totalPages = math.ceil(#Display_match / 6)    
    return totalPages
end


function SetMatchHistoryData(Data)
    -- LOG("Lua SetMatchHistoryData ------------------------")
    -- LOG(tostring(Data))
    -- LOG("Lua SetMatchHistoryData ------------------------")       

    -- Ensure Display_match is initialized
    Display_match = {}

    -- Extract the content inside "Data": [...]
    local dataBlock = Data:match('"Data"%s*:%s*%[(.-)%]')
    if not dataBlock then
        -- LOG("No data found inside 'Data' block.")
        return
    end

    -- Helper function to format date to YYYY-MM-DD
    local function formatDate(isoDate)
        local year, month, day = isoDate:match("^(%d+)-(%d+)-(%d+)T")
        return string.format("%s-%s-%s", year or "N/A", month or "N/A", day or "N/A")
    end

    -- Parse each dataset enclosed in `{...}`
    for match in dataBlock:gmatch("{(.-)}") do
        -- Extract fields
        local kill = tonumber(match:match("^[^,]*,[^,]*,[^,]*,[^,]*,[^,]*,[^,]*,(%d+),"))
        local death = tonumber(match:match("^[^,]*,[^,]*,[^,]*,[^,]*,[^,]*,[^,]*,[^,]*,(%d+),"))
        local mvp = tonumber(match:match("^[^,]*,[^,]*,[^,]*,[^,]*,[^,]*,[^,]*,[^,]*,[^,]*,[^,]*,[^,]*,(%d+),"))
        local matchResult = match:match("^[^,]*,[^,]*,[^,]*,[^,]*,[^,]*,[^,]*,[^,]*,[^,]*,[^,]*,[^,]*,[^,]*,([^,]+),")
        local updatedDate = match:match(",([^,]+Z)")
        local map_id = tonumber(match:match(",(%d+),%d+$")) or 0 -- Extract map_id at the end of the dataset

        -- Format date
        local formattedDate = updatedDate and formatDate(updatedDate) or "N/A"

        -- Insert parsed data into the table
        table.insert(Display_match, {
            Match_result = matchResult or "N/A",
            Kill = kill or 0,
            Death = death or 0,
            MVP = mvp or 0,
            Updated_date = formattedDate,
            Map_id = map_id
        })
    end    
    ShowHistoryData()
end


function CheckMapImg(MapID,index)
    -- Calculate the current page   
    if MapID == "0" then -- Back street court
        HistoryAreaIMG = winMgr:getWindow("HistoryAreaIMG" .. index)
        HistoryAreaIMG:setTexture("Enabled", "UIData/WndRankingHistory.png", 13, 14)       
        
    elseif MapID == "1" then -- Beach
        HistoryAreaIMG = winMgr:getWindow("HistoryAreaIMG" .. index)
        HistoryAreaIMG:setTexture("Enabled", "UIData/WndRankingHistory.png", 13, 544)   
    elseif MapID == "2" then -- Junkyard
        HistoryAreaIMG = winMgr:getWindow("HistoryAreaIMG" .. index)
        HistoryAreaIMG:setTexture("Enabled", "UIData/WndRankingHistory.png", 13, 485)   
    elseif MapID == "3" then -- Moon Night Park
        HistoryAreaIMG = winMgr:getWindow("HistoryAreaIMG" .. index)
        HistoryAreaIMG:setTexture("Enabled", "UIData/WndRankingHistory.png", 13, 426)   
    elseif MapID == "4" then -- Danger
        HistoryAreaIMG = winMgr:getWindow("HistoryAreaIMG" .. index)
        HistoryAreaIMG:setTexture("Enabled", "UIData/WndRankingHistory.png", 13, 367)
    elseif MapID == "5" then -- Street
        HistoryAreaIMG = winMgr:getWindow("HistoryAreaIMG" .. index)
        HistoryAreaIMG:setTexture("Enabled", "UIData/WndRankingHistory.png", 13, 73)
    elseif MapID == "6" then -- Sky lounge
        HistoryAreaIMG = winMgr:getWindow("HistoryAreaIMG" .. index)
        HistoryAreaIMG:setTexture("Enabled", "UIData/WndRankingHistory.png", 13, 131)
    elseif MapID == "7" then -- By-X station
        HistoryAreaIMG = winMgr:getWindow("HistoryAreaIMG" .. index)
        HistoryAreaIMG:setTexture("Enabled", "UIData/WndRankingHistory.png", 13, 190)
    elseif MapID == "8" then -- Areana ring
        HistoryAreaIMG = winMgr:getWindow("HistoryAreaIMG" .. index)
        HistoryAreaIMG:setTexture("Enabled", "UIData/WndRankingHistory.png", 13, 249)
    elseif MapID == "9" then -- Barrier Factory
        HistoryAreaIMG = winMgr:getWindow("HistoryAreaIMG" .. index)
        HistoryAreaIMG:setTexture("Enabled", "UIData/WndRankingHistory.png", 13, 249)
    elseif MapID == "10" then -- Endless sky
        HistoryAreaIMG = winMgr:getWindow("HistoryAreaIMG" .. index)
        HistoryAreaIMG:setTexture("Enabled", "UIData/WndRankingHistory.png", 13, 308)
    elseif MapID == "11" then -- Endless sky
        HistoryAreaIMG = winMgr:getWindow("HistoryAreaIMG" .. index)
        HistoryAreaIMG:setTexture("Enabled", "UIData/WndRankingHistory.png", 13, 308)
    else
        HistoryAreaIMG = winMgr:getWindow("HistoryAreaIMG" .. index)
        HistoryAreaIMG:setTexture("Enabled", "UIData/WndRankingHistory.png", 13, 14)  
    end         

end

function ShowHistoryData()
    -- Calculate total pages
    local totalPages = CalculateTotalPages()

    -- Calculate the current page
    local currentPage = math.ceil(currentStartIndex / 6)

    -- Display matches within the range
    local Start_Page = currentStartIndex
    local End_Page = math.min(currentStartIndex + 5, #Display_match)

    -- LOG("-------- Show History Data --------")
    -- LOG("Start_Page: " .. Start_Page)
    -- LOG("End_Page: " .. End_Page)

     -- Update page text
     local HistoryPageText = winMgr:getWindow("HistoryPageText")
     HistoryPageText:setText((currentPage + 1) .. " / " .. (totalPages + 1))

    for index = Start_Page, End_Page do
        local matchIndex = index - Start_Page -- Adjust index for GUI elements
        local match = Display_match[index]

        if match then
            -- LOG("Displaying Match " .. index)
            -- LOG("MatchResult: " .. tostring(match.Match_result))
            -- LOG("Kill: " .. tostring(match.Kill))
            -- LOG("Death: " .. tostring(match.Death))
            -- LOG("MVP: " .. tostring(match.MVP))
            -- LOG("UpdatedDate: " .. tostring(match.Updated_date))
            -- LOG("MapID: ".. tostring(match.Map_id))

            local HistoryAreaIMG = winMgr:getWindow("HistoryAreaIMG" .. matchIndex)
            HistoryAreaIMG:setVisible(true)            

            local HistoryRankIMG = winMgr:getWindow("HistoryRankIMG" .. matchIndex)
            HistoryRankIMG:setVisible(true)

            -- Set date text
            local HistoryDateText = winMgr:getWindow("HistoryDateText" .. matchIndex)
            HistoryDateText:setText(tostring(match.Updated_date))
            HistoryBackgroundIMG:addChildWindow(HistoryDateText)

            -- Set Result Img
            local HistoryResultIMG = winMgr:getWindow("HistoryResultIMG" .. matchIndex)
            if tostring(match.Match_result) == "W" then
                HistoryResultIMG:setEnabled(true)
                HistoryResultIMG:setVisible(true)
            else
                HistoryResultIMG:setEnabled(false)
                HistoryResultIMG:setVisible(true)
            end

            -- Set result text
            local HistoryResulText = winMgr:getWindow("HistoryResulText" .. matchIndex)
            local resultText = (match.Match_result == "W" and "Win" or "Lose") .. " | " .. match.Kill .. " / " .. match.Death
            HistoryResulText:setText(resultText)
            HistoryBackgroundIMG:addChildWindow(HistoryResulText)

            -- Set MVP visibility
            local HistoryResultMVPIMG = winMgr:getWindow("HistoryResultMVPIMG" .. matchIndex)
            if match.MVP == 1 then
                HistoryResultMVPIMG:setVisible(true)
            else
                HistoryResultMVPIMG:setVisible(false)
            end
            HistoryBackgroundIMG:addChildWindow(HistoryResultMVPIMG)

            CheckMapImg(tostring(match.Map_id),index)
        end
    end   
end

function ClearHistory()
    for index = 0, pageSize do               
        -- Set Image
        local HistoryAreaIMG = winMgr:getWindow("HistoryAreaIMG" .. index)
        HistoryAreaIMG:setVisible(false)

        -- Set Rank
        local HistoryRankIMG = winMgr:getWindow("HistoryRankIMG" .. index)
        HistoryRankIMG:setVisible(false)

        -- Set date text
        local HistoryDateText = winMgr:getWindow("HistoryDateText" .. index)
        HistoryDateText:setText("")                

        -- Set Result Img
        local HistoryResultIMG = winMgr:getWindow("HistoryResultIMG" .. index)
        HistoryResultIMG:setVisible(false)
        
        -- Set result text
        local HistoryResulText = winMgr:getWindow("HistoryResulText" .. index)            
        HistoryResulText:setText("")            

        -- Set MVP visibility
        local HistoryResultMVPIMG = winMgr:getWindow("HistoryResultMVPIMG" .. index)
        HistoryResultMVPIMG:setVisible(false)        
        
        -- Page 
        local HistoryPageText = winMgr:getWindow("HistoryPageText")  
        HistoryPageText:setText("")     
    end
end

function InitRankingHistory()   

    local gap_y = 55
    for index = 0, pageSize do        
      
        -- Set Panal Img
        HistoryPanalIMG = winMgr:createWindow("TaharezLook/StaticImage", "HistoryPanalIMG" .. index)
        HistoryPanalIMG:setTexture("Enabled", "UIData/WndRankingHistory.png", 10, 652)        
        HistoryPanalIMG:setPosition(12 , 110 + (gap_y * index))
        HistoryPanalIMG:setSize(781, 50)
        HistoryPanalIMG:setVisible(false)
        HistoryPanalIMG:setZOrderingEnabled(false) -- Prevent Clicked to shift to top
        HistoryBackgroundIMG:addChildWindow(HistoryPanalIMG)
        
        -- Set Map Img
        HistoryAreaIMG = winMgr:createWindow("TaharezLook/StaticImage", "HistoryAreaIMG" .. index)
        HistoryAreaIMG:setTexture("Enabled", "UIData/WndRankingHistory.png", 13, 14)        
        HistoryAreaIMG:setPosition(14 , 112 + (gap_y * index))
        HistoryAreaIMG:setSize(281, 46)
        HistoryAreaIMG:setVisible(false)
        HistoryAreaIMG:setZOrderingEnabled(false)
        HistoryBackgroundIMG:addChildWindow(HistoryAreaIMG)

        -- Set RankGameText Img
        HistoryRankIMG = winMgr:createWindow("TaharezLook/StaticImage", "HistoryRankIMG" .. index)
        HistoryRankIMG:setTexture("Enabled", "UIData/WndRankingHistory.png", 5, 603)        
        HistoryRankIMG:setPosition(315 , 116 + (gap_y * index))
        HistoryRankIMG:setSize(146, 37)
        HistoryRankIMG:setVisible(false)
        HistoryRankIMG:setZOrderingEnabled(false)
        HistoryBackgroundIMG:addChildWindow(HistoryRankIMG)

        -- Set Date
        HistoryDateText = winMgr:createWindow("TaharezLook/StaticText", "HistoryDateText" .. index)          
        HistoryDateText:setPosition(500 , 116 + (gap_y * index))
        HistoryDateText:setSize(146, 37)
        HistoryDateText:setZOrderingEnabled(false)
        HistoryDateText:setTextColor(255, 255, 255, 255)
        HistoryDateText:setFont("tahoma", 15)	
        HistoryDateText:setVisible(false)
        HistoryDateText:setText("2024-12-18")  
        HistoryBackgroundIMG:addChildWindow(HistoryDateText)       

        -- Set Result button
        HistoryResultIMG = winMgr:createWindow("TaharezLook/StaticImage", "HistoryResultIMG" .. index)
        HistoryResultIMG:setTexture("Enabled", "UIData/WndRankingHistory.png", 10, 723)   
        HistoryResultIMG:setTexture("Disabled", "UIData/WndRankingHistory.png", 151, 723)
        HistoryResultIMG:setPosition(635 , 121 + (gap_y * index))
        HistoryResultIMG:setSize(121, 32)
        HistoryResultIMG:setZOrderingEnabled(false)
        HistoryResultIMG:setVisible(false)
        HistoryBackgroundIMG:addChildWindow(HistoryResultIMG)

        -- Set MVP
        HistoryResultMVPIMG = winMgr:createWindow("TaharezLook/StaticImage", "HistoryResultMVPIMG" .. index)
        HistoryResultMVPIMG:setTexture("Enabled", "UIData/WndRankingHistory.png", 173, 602)        
        HistoryResultMVPIMG:setPosition(625 , 118 + (gap_y * index))
        HistoryResultMVPIMG:setSize(30, 32)
        HistoryResultMVPIMG:setZOrderingEnabled(false)
        HistoryResultMVPIMG:setVisible(false)
        HistoryBackgroundIMG:addChildWindow(HistoryResultMVPIMG)

        -- Set Result Text
        HistoryResulText = winMgr:createWindow("TaharezLook/StaticText", "HistoryResulText" .. index)          
        HistoryResulText:setPosition(660 , 117 + (gap_y * index))
        HistoryResulText:setSize(146, 37)
        HistoryResulText:setZOrderingEnabled(false)
        HistoryResulText:setTextColor(255, 255, 255, 255)
        HistoryResulText:setFont("tahoma", 15)	
        HistoryResulText:setText("Win | 10-07")  
        HistoryResulText:setVisible(false)
        HistoryBackgroundIMG:addChildWindow(HistoryResulText)      
    end

    HistoryPreviousPageIMG = winMgr:createWindow("TaharezLook/Button", "HistoryPreviousPageIMG")
    HistoryPreviousPageIMG:setTexture("Normal", "UIData/WndRankingOverall_Background_History.png", 19, 618)        
    HistoryPreviousPageIMG:setPosition(350 , 445)
    HistoryPreviousPageIMG:setSize(16, 16)
    HistoryPreviousPageIMG:setZOrderingEnabled(false)
    HistoryPreviousPageIMG:setAlwaysOnTop(true)
    -- Previous Page Button
    HistoryPreviousPageIMG:subscribeEvent("Clicked", function()          
        -- LOG("HistoryPreviousPageIMG")

        if currentStartIndex > 1 then
            currentStartIndex = currentStartIndex - 6 -- Move to the previous page
            ClearHistory()
            ShowHistoryData()
        else
            -- LOG("Already on the first page!") -- -- Log boundary condition
        end
    end)
    HistoryBackgroundIMG:addChildWindow(HistoryPreviousPageIMG)    	
    

    HistoryNextPageIMG = winMgr:createWindow("TaharezLook/Button", "HistoryNextPageIMG")
    HistoryNextPageIMG:setTexture("Normal", "UIData/WndRankingOverall_Background_History.png", 49, 618)        
    HistoryNextPageIMG:setPosition(375 + 75 , 446)
    HistoryNextPageIMG:setSize(15, 16)
    HistoryNextPageIMG:setZOrderingEnabled(true)
    HistoryNextPageIMG:setAlwaysOnTop(true)
    -- Next Page Button
   -- Next Page Button
    HistoryNextPageIMG:subscribeEvent("Clicked", function()        
        -- LOG("HistoryNextPageIMG")

        if currentStartIndex + 6 <= #Display_match then
            currentStartIndex = currentStartIndex + 6 -- Move to the next page
            ClearHistory()
            ShowHistoryData()
        else
            -- LOG("Already on the last page!") -- -- Log boundary condition
        end
    end)
    
    HistoryBackgroundIMG:addChildWindow(HistoryNextPageIMG)

    HistoryPageText = winMgr:createWindow("TaharezLook/StaticText", "HistoryPageText")          
    HistoryPageText:setPosition(390 , 435)
    HistoryPageText:setSize(146, 37)
    HistoryPageText:setZOrderingEnabled(false)
    HistoryPageText:setTextColor(255, 255, 255, 255)
    HistoryPageText:setFont("tahoma", 15)	
    HistoryPageText:setText("1 / 1")  
    HistoryBackgroundIMG:addChildWindow(HistoryPageText)         
   
end

local RankName, RankLevel

-- Function to extract rank name and rank level

function SetRankBadge(base_rank)

    IconRank = winMgr:createWindow("TaharezLook/StaticImage", "IconRank") 

    if base_rank == "Rookie" then
        IconRank = winMgr:createWindow("TaharezLook/StaticImage", "IconRank") 
        IconRank:setTexture("Enabled", "UIData/Raking_Badge.png", 54, 36)   
        IconRank:setPosition(155, 300)
        IconRank:setSize(220, 220)	
        IconRank:setScaleHeight(200)
        IconRank:setScaleWidth(200)       

    elseif base_rank == "Bronze" then
        IconRank:setTexture("Enabled", "UIData/Raking_Badge.png", 70, 246)
        IconRank:setScaleHeight(200)
        IconRank:setScaleWidth(200)
        IconRank:setPosition(170, 300)
        IconRank:setSize(220, 220)     
        
    elseif base_rank == "Iron" then
        IconRank:setTexture("Enabled", "UIData/Raking_Badge.png", 70, 440)
        IconRank:setScaleHeight(200)
        IconRank:setScaleWidth(200)
        IconRank:setPosition(170, 300)
        IconRank:setSize(220, 220)
        
    elseif base_rank == "Silver" then
        IconRank:setTexture("Enabled", "UIData/Raking_Badge.png", 45, 650)
        IconRank:setScaleHeight(200)
        IconRank:setScaleWidth(200)
        IconRank:setPosition(150, 300)
        IconRank:setSize(300, 220)
        
    elseif base_rank == "Gold" then
        IconRank:setTexture("Enabled", "UIData/Raking_Badge.png", 45, 870)
        IconRank:setScaleHeight(200)
        IconRank:setScaleWidth(200)
        IconRank:setPosition(150, 300)
        IconRank:setSize(300, 220)
        
    elseif base_rank == "Platinum" then
        IconRank:setTexture("Enabled", "UIData/Raking_Badge.png", 45, 1075)
        IconRank:setScaleHeight(200)
        IconRank:setScaleWidth(200)
        IconRank:setPosition(150, 300)
        IconRank:setSize(300, 220)
        
    elseif base_rank == "Diamond" then
        IconRank:setTexture("Enabled", "UIData/Raking_Badge.png", 30, 1285)
        IconRank:setScaleHeight(200)
        IconRank:setScaleWidth(200)
        IconRank:setPosition(138, 280)
        IconRank:setSize(350, 220)
        
    elseif base_rank == "Master" then
        IconRank:setTexture("Enabled", "UIData/Raking_Badge.png", 45, 1520)        
        IconRank:setPosition(150, 280)
        IconRank:setSize(350, 220)
        
    elseif base_rank == "GrandMaster" then
        IconRank:setTexture("Enabled", "UIData/Raking_Badge.png", 25, 1800)      
        IconRank:setPosition(130, 300)
        IconRank:setSize(380, 220)
    
	elseif IconRank == "Close" then
		IconRank:setVisible(false)
    else
        print("Unknown rank: " .. IconRank)
    end

    root:addChildWindow(IconRank)
end


function GetRankIcon(RankInfo)
	-- Find the second element (rank name) in the comma-separated string
    local rank_name_with_level = RankInfo:match("^[^,]+,([^,]+),")
    if not rank_name_with_level then
        return nil, nil -- Return nil if no match is found
    end
    
    -- Split the rank name into name and level
    local rank_name, rank_level = rank_name_with_level:match("([^_]+)_([^_]+)")
    RankName = rank_name
    RankLevel = rank_level         
    SetRankBadge(rank_name)    
end









