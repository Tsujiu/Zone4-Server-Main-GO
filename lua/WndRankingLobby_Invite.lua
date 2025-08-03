-----------------------------------------
-- Script Entry Point
-----------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr = CEGUI.WindowManager:getSingleton()
local root = winMgr:getWindow("DefaultWindow")
guiSystem:setGUISheet(root)

g_bExcuseButtonClick = false -- Global variable to check whether the drop button is pressed
g_ReportType = nil -- Type of report (0 = Personal Insult, 1 = Illegal Program, 2 = Fraud, 3 = Cash Transaction)
g_ReportCharName = nil -- Name of the character being reported

local TEXTURE_HEIGHT = 924
local TEXTURE_OFFSET_Y = 18

local MAX_FRIEND = 10
local FRIEND_COUNT = 0

local CURRENT_PAGE = 1
local MAX_PAGE = 0
local cachedFriendList = {}
local friendList = {}
local character_key_selected;

RegistEscEventInfo("rankingLobbyInviteFrame", "GranEventClose")
RegistEnterEventInfo("rankingLobbyInviteFrame", "GranEventClose")

-- กรอบหน้าต่างเชิญเพื่อน
rankingLobbyFrame = winMgr:createWindow("TaharezLook/StaticImage", "rankingLobbyInviteFrame")
rankingLobbyFrame:setTexture("Enabled", "UIData/invisible.tga", 700, 200)
rankingLobbyFrame:setProperty("FrameEnabled", "False")
rankingLobbyFrame:setProperty("BackgroundEnabled", "False")
rankingLobbyFrame:setWideType(6);
rankingLobbyFrame:setPosition(360, 160)
rankingLobbyFrame:setSize(328, 454)
rankingLobbyFrame:setVisible(false)
rankingLobbyFrame:setAlwaysOnTop(true)
root:addChildWindow(rankingLobbyFrame)

-- หน้าต่างเชิญเพื่อน
bgInvite = winMgr:createWindow("TaharezLook/StaticImage", "rankingLobbyInvite")
bgInvite:setTexture("Enabled", "UIData/Ranking_Set.png", 349, 424)
bgInvite:setTexture("Disabled", "UIData/Ranking_Set.png", 349, 424)
bgInvite:setProperty("FrameEnabled", "False")
bgInvite:setProperty("BackgroundEnabled", "False")
bgInvite:setSize(328, 454)
bgInvite:setVisible(false)
-- bgInvite:setAlwaysOnTop(true)
bgInvite:setZOrderingEnabled(false)
rankingLobbyFrame:addChildWindow(bgInvite)

-- ปุ่มเชิญเพื่อน
btnInvite = winMgr:createWindow("TaharezLook/Button", "rankingLobbyInviteBtn")
btnInvite:setTexture("Normal", "UIData/Ranking_Set.png", 694, 424)
btnInvite:setTexture("Hover", "UIData/Ranking_Set.png", 694, 453)
btnInvite:setTexture("Pushed", "UIData/Ranking_Set.png", 694, 483)
btnInvite:setTexture("Disabled", "UIData/Ranking_Set.png", 694, 511)
btnInvite:setSize(318, 28)
btnInvite:setPosition(6, 421)
btnInvite:setVisible(true)
btnInvite:setAlwaysOnTop(true)
btnInvite:setZOrderingEnabled(false)
btnInvite:subscribeEvent("Clicked", "Invite_Confirm")
rankingLobbyFrame:addChildWindow(btnInvite)

-- ปุ่มถัดไป ก่อนหน้า ย้อนหลัง
local MyFriendList_BtnName = {
    ["err"] = 0,
    [0] = "MyFriendList_LBtn",
    "MyFriendList_RBtn"
}
local MyFriendList_BtnTexX = {
    ["err"] = 0,
    [0] = 427,
    454
}
local MyFriendList_BtnPosX = {
    ["err"] = 0,
    [0] = 100,
    211
}
local MyFriendList_BtnEvent = {
    ["err"] = 0,
    [0] = "PrevPage",
    "NextPage"
}

-- Define the MillitaryArts enum as a table
local MillitaryArts = {"STREET", -- 0
"RUSH", -- 1
"TAEKWONDO", -- 2
"JUDO", -- 3
"BOXING", -- 4
"PROWRESTLING", -- 5
"CAPOERA", -- 6
"HAPGIDO", -- 7
"MUAYTHAI", -- 8
"SAMBO", -- 9
"DIRTYX" -- 10
}

function Invite_Confirm()
    SendInvite()
end

function PrevPage()
    for i = 0, 9 do
        winMgr:getWindow('BackgroundFrame' .. i):setTexture("Normal", "UIData/messenger4.img", 903, 393)
        winMgr:getWindow('BackgroundFrame' .. i):setTexture("Hover", "UIData/messenger4.img", 566, 282)
        winMgr:getWindow('BackgroundFrame' .. i):setTexture("Pushed", "UIData/messenger4.img", 566, 307)
    end
    return OnClickMyFriend_PrevPage();
end

function NextPage()
    for i = 0, 9 do
        winMgr:getWindow('BackgroundFrame' .. i):setTexture("Normal", "UIData/messenger4.img", 903, 393)
        winMgr:getWindow('BackgroundFrame' .. i):setTexture("Hover", "UIData/messenger4.img", 566, 282)
        winMgr:getWindow('BackgroundFrame' .. i):setTexture("Pushed", "UIData/messenger4.img", 566, 307)
    end
    return OnClickMyFriend_NextPage();
end

mywindow = winMgr:createWindow("TaharezLook/StaticText", "MyFriendList_PageText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 16)
mywindow:setPosition(133, 398)
mywindow:setSize(80, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:clearTextExtends()
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
bgInvite:addChildWindow(mywindow)

function RefreshMyFriendList()
    if (MAX_PAGE == 0) then
        MAX_PAGE = 1
    end
    winMgr:getWindow('MyFriendList_PageText'):clearTextExtends()
    winMgr:getWindow('MyFriendList_PageText'):addTextExtends(tostring(CURRENT_PAGE) .. ' / ' .. tostring(MAX_PAGE),
        g_STRING_FONT_GULIMCHE, 114, 230, 230, 230, 255, 0, 0, 0, 0, 255)

    ClearFriendList()
end

-- ฟังก์ชันอัปเดตข้อมูล Cache
function UpdateFriendListCache(friendList)
    cachedFriendList = {}
    for i, friendData in ipairs(friendList) do
        cachedFriendList[i] = {
            gang_name = friendData.gang_name,
            rank_name = friendData.rank_name,
            friend_name = friendData.friend_name,
            class_name = friendData.class_name,
            level = friendData.level
        }
    end
end

function UpdateFriendList()
    LOG("========= Updating friend list after login =========")

    -- Clear existing friend list UI
    ClearFriendList()

    -- Re-populate friend list
    for i, friend in ipairs(friendList) do
        LOG(string.format("Friend %d:", i))
        LOG(string.format("  Index: %d", friend.index))
        LOG(string.format("  Gang Name: %s", friend.gang_name))
        LOG(string.format("  Rank Name: %s", friend.rank_name))
        LOG(string.format("  Friend Name: %s", friend.friend_name))
        LOG(string.format("  Class Name: %s", friend.class_name))
        LOG(string.format("  Level: %s", tostring(friend.level)))
        LOG(string.format("  Badge Coordinates: (%d, %d)", friend.badge_x, friend.badge_y))

        -- Show the updated friend list in the UI
        ShowFriendList(friend.index, friend.gang_name, friend.rank_name, friend.friend_name, 
                       friend.class_name, friend.level, friend.badge_x, friend.badge_y)
    end
end

function OnMouseEnterMoveButton_Invite(args)
    local window = CEGUI.toWindowEventArgs(args).window
    local szIndex = window:getUserString("index")
    if szIndex ~= "" then
        local index = tonumber(szIndex)
        -- winMgr:getWindow('BackgroundFrame' .. index):setVisible(true)
        -- rankingLobbyFrame:setVisible(true)
        winMgr:getWindow('rankingLobbyInviteGangText' .. index):setTextColor(255, 255, 0, 255)
        winMgr:getWindow('rankingLobbyInviteRankNameText' .. index):setTextColor(255, 255, 0, 255)
        winMgr:getWindow('rankingLobbyInviteFriendNameText' .. index):setTextColor(255, 255, 0, 255)
        winMgr:getWindow('rankingLobbyInviteClassNameText' .. index):setTextColor(255, 255, 0, 255)
    end
end

function OnMouseLeaveMoveButton_Invite(args)
    local window = CEGUI.toWindowEventArgs(args).window
    local szIndex = window:getUserString("index")
    if szIndex ~= "" then
        local index = tonumber(szIndex)
        winMgr:getWindow('rankingLobbyInviteGangText' .. index):setTextColor(255, 255, 255, 255)
        winMgr:getWindow('rankingLobbyInviteRankNameText' .. index):setTextColor(255, 255, 255, 255)
        winMgr:getWindow('rankingLobbyInviteFriendNameText' .. index):setTextColor(255, 255, 255, 255)
        winMgr:getWindow('rankingLobbyInviteClassNameText' .. index):setTextColor(255, 255, 255, 255)
    end
end

function OnMouseClickButton_Invite(args)
    local window = CEGUI.toWindowEventArgs(args).window
    local szIndex = window:getUserString("index")

    if szIndex ~= "" then
        local index = tonumber(szIndex)
        character_key_selected = szIndex
        OnSelectFriend(szIndex)

        for i = 0, 9 do
            if i == index then
                winMgr:getWindow('BackgroundFrame' .. i):setTexture("Normal", "UIData/messenger4.img", 566, 307)
                winMgr:getWindow('BackgroundFrame' .. i):setTexture("Hover", "UIData/messenger4.img", 566, 282)
                winMgr:getWindow('BackgroundFrame' .. i):setTexture("Pushed", "UIData/messenger4.img", 566, 307)
            else
                winMgr:getWindow('BackgroundFrame' .. i):setTexture("Normal", "UIData/messenger4.img", 903, 393)
                winMgr:getWindow('BackgroundFrame' .. i):setTexture("Hover", "UIData/messenger4.img", 566, 282)
                winMgr:getWindow('BackgroundFrame' .. i):setTexture("Pushed", "UIData/messenger4.img", 566, 307)
            end
        end
    end
end

local function getWindowSafe(name)
    if winMgr:isWindowPresent(name) then
        return winMgr:getWindow(name)
    else
        return nil
    end
end

-- Function to detect if an integer corresponds to a valid enum index
local function detectClassValue(index)
    local numIndex = tonumber(index) -- Convert index to a number
    if numIndex and numIndex >= 0 and numIndex < #MillitaryArts then
        return MillitaryArts[numIndex + 1] -- Lua tables are 1-indexed
    else
        return nil
    end
end

local textureCoordinates = {{496, 0}, -- STREET
{585, 0}, -- RUSH
{496, 36}, -- TAEKWONDO
{585, 36}, -- JUDO
{496, 72}, -- BOXING
{585, 72}, -- PROWRESTLING
{496, 108}, -- CAPOERA
{585, 108}, -- HAPGIDO
{496, 144}, -- MUAYTHAI
{586, 144}, -- SAMBO
{498, 175} -- DIRTYX
}

local Currently_friendList = {} -- temp current show friendList

local gap_y = 32

function ShowFriendList(index, gang_name, rank_name, friend_name, class_name, level, badge_x, badge_y,emblemKey)

    -- local gangTextWindow = getWindowSafe('rankingLobbyInviteGangText' .. index)
    -- if gangTextWindow then
    --     gangTextWindow:setEnabled(true)
    --     gangTextWindow:setVisible(true)
    --     gangTextWindow:setText(gang_name)
    --     gangTextWindow:setTextColor(255, 255, 255, 255)
    -- end
    
    local gangIMGWindow = getWindowSafe('rankingLobbyInviteGangText' .. index)
    local IconGangIMG = getWindowSafe('IconGangIMG' .. index)

    LOG("emblemKey received:", emblemKey or "nil")  -- ตรวจสอบค่าที่ได้รับ

    if emblemKey and emblemKey ~= "" then
        local imagePath = "item/ClubEmblem/" .. emblemKey .. ".tga" -- ใช้ emblemKey เป็นชื่อไฟล์
        LOG("Setting emblem texture:", imagePath) -- Debugging

        IconGangIMG:setTexture("Enabled", imagePath, 0, 0) -- โหลดรูปจาก emblemKey
        IconGangIMG:setSize(30, 30)
        IconGangIMG:setScaleHeight(160)
        IconGangIMG:setScaleWidth(160)
        -- IconGangIMG:setPosition(15, 79.5)
        gangIMGWindow:setEnabled(true)
        gangIMGWindow:setVisible(true)
    else
        IconGangIMG:setTexture("Enabled", "", 0, 0) -- ไม่โหลดรูปถ้าไม่มี emblemKey
        gangIMGWindow:setEnabled(false)
        gangIMGWindow:setVisible(false)
    end

    gangIMGWindow:setTextColor(255, 255, 255, 255) 

    local rankNameWindow = getWindowSafe('rankingLobbyInviteRankNameText' .. index)
    local IconRankIMG = getWindowSafe('IconRankIMG' .. index)

    IconRankIMG:setTexture("Enabled", "UIData/Raking_Badge.png", badge_x, badge_y)
    IconRankIMG:setScaleHeight(36)
    IconRankIMG:setScaleWidth(36)
    IconRankIMG:setSize(300, 215)

    rankNameWindow:setEnabled(true)
    rankNameWindow:setVisible(true)
    -- rankNameWindow:setText(rank_name)               
    rankNameWindow:setTextColor(255, 255, 255, 255)
    IconRankIMG:setVisible(true)

    local friendNameWindow = getWindowSafe('rankingLobbyInviteFriendNameText' .. index)
    local LevelText = getWindowSafe('LevelText' .. index)
    if friendNameWindow then
        LevelText:setEnabled(true)
        LevelText:setVisible(true)
        LevelText:setText(level)
        LevelText:setTextColor(255, 255, 255, 255)

        friendNameWindow:setEnabled(true)
        friendNameWindow:setVisible(true)
        friendNameWindow:setText(friend_name)
        friendNameWindow:setTextColor(255, 255, 255, 255) -- gray
    end

    local classNameWindow = getWindowSafe('rankingLobbyInviteClassNameText' .. index)

    if classNameWindow then
        -- Test UI Picture
        local className = detectClassValue(class_name)
        if className then
            local textureCoord = textureCoordinates[tonumber(class_name) + 1]
            ClassIMG = getWindowSafe('ClassIMG' .. index)
            -- Set the texture based on the index
            if textureCoord then
                ClassIMG:setTexture("Enabled", "UIData/skillitem001.img", textureCoord[1], textureCoord[2])
            end
            -- Configure the ClassIMG settings
            ClassIMG:setSize(89, 32)
            ClassIMG:setScaleHeight(170)
            ClassIMG:setScaleWidth(170)
            -- Enable and display the classNameWindow
            classNameWindow:setEnabled(true)
            classNameWindow:setVisible(true)
            -- classNameWindow:setText(className)
            classNameWindow:setTextColor(255, 255, 255, 255)
            ClassIMG:setVisible(true)
        else
            print("Invalid class index:", index)
        end
    end

end

function ClearFriendList()
    for index = 0, 9 do
        Currently_friendList[index] = ""
        local IconRankIMG = getWindowSafe('IconRankIMG' .. index)
        IconRankIMG:setVisible(false)

        local ClassIMG = getWindowSafe('ClassIMG' .. index)
        ClassIMG:setVisible(false)

        local LevelText = getWindowSafe('LevelText' .. index)
        if LevelText then
            LevelText:setText("")
            LevelText:setVisible(false)
        end

        local gangTextWindow = getWindowSafe('rankingLobbyInviteGangText' .. index)
        if gangTextWindow then
            gangTextWindow:setText("")
            gangTextWindow:setVisible(false)
        end

        -- local gangIMGWindow = getWindowSafe('rankingLobbyInviteGangText' .. index)
        -- if gangIMGWindow then
        --     gangIMGWindow:setText("")
        --     gangIMGWindow:setVisible(false)
        -- end

        local rankNameWindow = getWindowSafe('rankingLobbyInviteRankNameText' .. index)
        if rankNameWindow then
            rankNameWindow:setText("")
            rankNameWindow:setVisible(false)
        end

        local friendNameWindow = getWindowSafe('rankingLobbyInviteFriendNameText' .. index)
        if friendNameWindow then
            friendNameWindow:setText("")
            friendNameWindow:setTextColor(255, 255, 255, 255)
            friendNameWindow:setVisible(false)
        end

        local classNameWindow = getWindowSafe('rankingLobbyInviteClassNameText' .. index)
        if classNameWindow then
            classNameWindow:setText("")
            classNameWindow:setVisible(false)
        end
    end     

end

function RemoveFriendList(friend_name)
    LOG("========= Removing friend from Lua friend list: " .. friend_name .. " =========")

    -- Find and remove the friend from friendList
    local updatedFriendList = {}
    local friendRemoved = false

    for i, friend in ipairs(friendList) do
        if friend.friend_name ~= friend_name then
            table.insert(updatedFriendList, friend)
        else
            LOG("Removing friend: " .. friend.friend_name)
            friendRemoved = true
        end
    end

    if not friendRemoved then
        LOG("Friend '" .. friend_name .. "' not found in Lua friend list.")
        return
    end

    -- Update the global friendList with the modified list
    friendList = updatedFriendList

    -- Update UI and refresh list
    LOG("Updated friend list after removal:")
    for i, friend in ipairs(friendList) do
        LOG(string.format("Friend %d:", i))
        LOG(string.format("  Index: %d", i - 1))  -- Fix index numbering
        LOG(string.format("  Gang Name: %s", friend.gang_name))
        LOG(string.format("  Rank Name: %s", friend.rank_name))
        LOG(string.format("  Friend Name: %s", friend.friend_name))
        LOG(string.format("  Class Name: %s", friend.class_name))
        LOG(string.format("  Level: %s", tostring(friend.level)))
        LOG(string.format("  Badge Coordinates: (%d, %d)", friend.badge_x, friend.badge_y))
    end

    -- Refresh UI
    ClearFriendList()
    ShowPage(CURRENT_PAGE)
end

-- แสดงรายชื่อเพื่อน
for index = 0, 9 do

    -- ชื่อแก๊งเพื่อน
    textGang = winMgr:createWindow("TaharezLook/Button", "rankingLobbyInviteGangText" .. index)
    textGang:setProperty("FrameEnabled", "False")
    textGang:setProperty("BackgroundEnabled", "False")
    textGang:setProperty("HorzFormatting", "WordWrapLeftAligned")
    textGang:setProperty("VertFormatting", "TopAligned")
    textGang:setSize(50, 10)
    textGang:setPosition(14, 80 + (gap_y * index))
    textGang:setVisible(false)
    textGang:setEnabled(false)
    rankingLobbyFrame:addChildWindow(textGang)

    -- Text Level
    LevelText = winMgr:createWindow("TaharezLook/Button", "LevelText" .. index)
    LevelText:setProperty("FrameEnabled", "False")
    LevelText:setProperty("BackgroundEnabled", "False")
    LevelText:setProperty("HorzFormatting", "WordWrapLeftAligned")
    LevelText:setProperty("VertFormatting", "TopAligned")
    LevelText:setSize(50, 10)
    LevelText:setPosition(45, 80 + (gap_y * index))
    LevelText:setVisible(false)
    LevelText:setEnabled(false)
    rankingLobbyFrame:addChildWindow(LevelText)

    -- ชื่อ Rank
    textRank = winMgr:createWindow("TaharezLook/Button", "rankingLobbyInviteRankNameText" .. index)
    textRank:setProperty("FrameEnabled", "False")
    textRank:setProperty("BackgroundEnabled", "False")
    textRank:setProperty("HorzFormatting", "WordWrapLeftAligned")
    textRank:setProperty("VertFormatting", "TopAligned")
    textRank:setSize(71, 10)
    textRank:setPosition(80, 84 + (gap_y * index))

    textRank:setVisible(false)
    textRank:setEnabled(false)
    textRank:setUserString("index", tostring(index))
    rankingLobbyFrame:addChildWindow(textRank)

    -- ชื่อเพื่อน
    textFriendName = winMgr:createWindow("TaharezLook/Button", "rankingLobbyInviteFriendNameText" .. index)
    textFriendName:setProperty("FrameEnabled", "False")
    textFriendName:setProperty("BackgroundEnabled", "False")
    textFriendName:setProperty("HorzFormatting", "WordWrapLeftAligned")
    textFriendName:setProperty("VertFormatting", "TopAligned")
    textFriendName:setSize(83, 10)
    textFriendName:setPosition(155, 80 + (gap_y * index))
    textFriendName:setVisible(false)
    textFriendName:setEnabled(false)
    textFriendName:setUserString("index", tostring(index))
    rankingLobbyFrame:addChildWindow(textFriendName)

    -- ชื่อ IMG
    ClassIMG = winMgr:createWindow("TaharezLook/StaticImage", "ClassIMG" .. index)
    ClassIMG:setPosition(255, 76 + (gap_y * index))
    ClassIMG:setAlwaysOnTop(true)
    ClassIMG:setZOrderingEnabled(false)
    ClassIMG:setVisible(true)
    rankingLobbyFrame:addChildWindow(ClassIMG)

    IconRankIMG = winMgr:createWindow("TaharezLook/StaticImage", "IconRankIMG" .. index)
    IconRankIMG:setPosition(80, 72 + (gap_y * index))
    ClassIMG:setVisible(true)
    rankingLobbyFrame:addChildWindow(IconRankIMG)

    -- IconGangIMG = winMgr:createWindow("TaharezLook/StaticImage", "IconGangIMG" .. index)
    -- IconGangIMG:setPosition(16, 78 + (gap_y * index))
    -- IconGangIMG:setAlwaysOnTop(true)
    -- IconGangIMG:setVisible(true)
    -- rankingLobbyFrame:addChildWindow(IconGangIMG)

    IconGangIMG = winMgr:createWindow("TaharezLook/StaticImage", "IconGangIMG" .. index)
    IconGangIMG:setPosition(16, 78 + (gap_y * index)) -- ปรับตำแหน่ง
    IconGangIMG:setSize(30, 30) -- กำหนดขนาด
    IconGangIMG:setAlwaysOnTop(false) -- ปิด AlwaysOnTop
    IconGangIMG:setVisible(true)
    rankingLobbyFrame:addChildWindow(IconGangIMG)

    -- ชื่อ Class
    textClassName = winMgr:createWindow("TaharezLook/Button", "rankingLobbyInviteClassNameText" .. index)
    textClassName:setProperty("FrameEnabled", "False")
    textClassName:setProperty("BackgroundEnabled", "False")
    textClassName:setProperty("HorzFormatting", "WordWrapLeftAligned")
    textClassName:setProperty("VertFormatting", "TopAligned")
    textClassName:setSize(47, 10)
    textClassName:setPosition(280, 80 + (gap_y * index))
    textClassName:setVisible(false)
    textClassName:setEnabled(false)
    textClassName:setUserString("index", tostring(index))
    rankingLobbyFrame:addChildWindow(textClassName)

    -- Hover Background
    BackgroundFrame = winMgr:createWindow("TaharezLook/Button", "BackgroundFrame" .. index)
    BackgroundFrame:setTexture("Normal", "UIData/messenger4.img", 903, 393)
    BackgroundFrame:setTexture("Hover", "UIData/messenger4.img", 566, 282)
    BackgroundFrame:setTexture("Pushed", "UIData/messenger4.img", 566, 307)
    BackgroundFrame:setPosition(10, 78 + (gap_y * (index)))
    BackgroundFrame:setSize(308, 23)
    BackgroundFrame:setVisible(true)
    BackgroundFrame:setUserString("index", tostring(index))
    BackgroundFrame:subscribeEvent("Clicked", "OnMouseClickButton_Invite");
    BackgroundFrame:setAlwaysOnTop(true)
    BackgroundFrame:setZOrderingEnabled(false)
    rankingLobbyFrame:addChildWindow(BackgroundFrame)

end

-- Create a global table to hold references to friend name windows
_G.FriendNameWindows = {}

for i = 0, #MyFriendList_BtnName do
    mywindow = winMgr:createWindow("TaharezLook/Button", MyFriendList_BtnName[i])
    mywindow:setTexture("Normal", "UIData/fightclub_004.tga", MyFriendList_BtnTexX[i], 493)
    mywindow:setTexture("Hover", "UIData/fightclub_004.tga", MyFriendList_BtnTexX[i], 520)
    mywindow:setTexture("Pushed", "UIData/fightclub_004.tga", MyFriendList_BtnTexX[i], 547)
    mywindow:setTexture("PushedOff", "UIData/fightclub_004.tga", MyFriendList_BtnTexX[i], 547)
    mywindow:setPosition(MyFriendList_BtnPosX[i], 393)
    mywindow:setSize(27, 27)
    mywindow:setVisible(false)
    mywindow:setAlwaysOnTop(true)
    mywindow:setZOrderingEnabled(false)
    mywindow:setSubscribeEvent("Clicked", MyFriendList_BtnEvent[i])
    rankingLobbyFrame:addChildWindow(mywindow)

    -- Store the window reference in the global table
    FriendNameWindows[i] = mywindow
end

function UpdateOnlineStatus(Username)
    for index = 0, 9 do
        if Currently_friendList[index] == Username then
            local friendNameWindow = getWindowSafe('rankingLobbyInviteFriendNameText' .. index)
            friendNameWindow:setTextColor(255, 255, 255, 255)
        end
    end
end

-- เก็บข้อมูลเพื่อนทั้งหมด
function StoreFriendList(index, gang_name, rank_name, friend_name, class_name, level, badge_x, badge_y,emblemKey)
    -- Ensure the friend is not already in the list
    for _, friend in ipairs(friendList) do
        if friend.friend_name == friend_name then
            LOG("Duplicate friend detected, skipping: " .. friend_name)
            return
        end
    end

    -- Insert new friend into the list
    local friend = {
        index = index,
        gang_name = gang_name,
        rank_name = rank_name,
        friend_name = friend_name,
        class_name = class_name,
        level = level,
        badge_x = badge_x,
        badge_y = badge_y,
        emblemKey = emblemKey
    }
    table.insert(friendList, friend)
end

function SetMaxPage(maxPage)
    MAX_PAGE = maxPage
end

function ShowPage(page) -- แสดงหน้าที่ page
    local start = (page - 1) * MAX_FRIEND + 1
    local finish = page * MAX_FRIEND
    CURRENT_PAGE = page

    RefreshMyFriendList()

    for i = start, finish do
        if friendList[i] then
            ShowFriendList(friendList[i].index, friendList[i].gang_name, friendList[i].rank_name,
                friendList[i].friend_name, friendList[i].class_name, friendList[i].level, friendList[i].badge_x,
                friendList[i].badge_y, friendList[i].emblemKey)
        end
    end

    for i = 0, #MyFriendList_BtnName do
        local MyFriendList_BtnEvent = getWindowSafe('MyFriendList_BtnName[' .. i .. ']')
        MyFriendList_BtnEvent:setVisible(true)
        MyFriendList_BtnEvent:setAlwaysOnTop(true)
        MyFriendList_BtnEvent:setZOrderingEnabled(false)
    end
end
