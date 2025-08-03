local guiSystem = CEGUI.System:getSingleton()
local winMgr = CEGUI.WindowManager:getSingleton()
local root = winMgr:getWindow("DefaultWindow")


local GUITool = require("GUITools")
-- local ImGUI = require("ImGuiLayout")


guiSystem:setGUISheet(root)

local MAX_REWARD_SLOT = 4
local currentIndex = 1  -- For Reward Panel paging

local MAX_OVERVIEW_LABEL = 3
local currentOverviewIndex = 1  -- For Overview Panel paging
local GapY_interval = 105

-- This variable is changed by GetRankLevel(...)
-- and indicates the player's highest rank index
local AllowingClaim = 1

--------------------------------------------------------------------------
-- NEW: Table to keep track of already-claimed ranks
--      Key = rank index (1=Rookie, 2=Bronze, 3=Iron, etc.)
--      Value = true if the rank has been claimed
--------------------------------------------------------------------------
local AlreadyClaimingSet = {}

--------------------------------------------------------------------------------
-- REWARD DATA TABLE
--------------------------------------------------------------------------------
local rankIconImg = {
    {name = "Rookie",     img = {203, 221}, size = {54, 62}, pos = {-15, 35}, 
     nameImg = {30, 257}, namePos = {-25, 125}, nameSize = {77, 16}, SlotSize = 1},
    {name = "Bronze",     img = {295, 220}, size = {55, 64}, pos = {-13, 35}, 
     nameImg = {31, 228}, namePos = {-27, 125}, nameSize = {81, 15}, SlotSize = 1},
    {name = "Iron",       img = {375, 220}, size = {54, 63}, pos = {-15, 35}, 
     nameImg = {31, 199}, namePos = {-10, 125}, nameSize = {50, 15}, SlotSize = 1},
    {name = "Silver",     img = {469, 216}, size = {84, 63}, pos = {-30, 35}, 
     nameImg = {31, 170}, namePos = {-20, 125}, nameSize = {68, 16}, SlotSize = 1},
    {name = "Gold",       img = {213, 136}, size = {89, 64}, pos = {-31, 35}, 
     nameImg = {30, 143}, namePos = {-15, 125}, nameSize = {57, 15}, SlotSize = 2},
    {name = "Platinum",   img = {422, 133}, size = {85, 64}, pos = {-29, 35}, 
     nameImg = {31, 115}, namePos = {-37, 125}, nameSize = {103, 15}, SlotSize = 2},
    {name = "Diamond",    img = {309, 140}, size = {102, 63}, pos = {-39, 35}, 
     nameImg = {31, 87},  namePos = {-34, 125}, nameSize = {98, 15}, SlotSize = 3},
    {name = "Master",     img = {247, 30},  size = {93, 80}, pos = {-33, 25}, 
     nameImg = {31, 59},  namePos = {-25, 125}, nameSize = {82, 15}, SlotSize = 3},
    {name = "GrandMaster",img = {358, 30},  size = {110,75}, pos = {-42, 25}, 
     nameImg = {31, 31},  namePos = {-65, 125}, nameSize = {156, 15}, SlotSize = 4},
}

local RewardSlotBackgroundPanal = {
  {SlotType = 1,img = {249, 466}, size = {170, 220}, pos = {- 71, 150}},
  {SlotType = 2,img = {439, 466}, size = {170, 220}, pos = {- 71, 150}},
  {SlotType = 3,img = {625, 466}, size = {170, 220}, pos = {- 71, 150}},
  {SlotType = 4,img = {815, 466}, size = {170, 220}, pos = {- 71, 150}}  
}

local RewardItemSlot = {
  {pos = {50, 50}},
  {pos1 = {50, 20},pos2 = {50, 100}},
  {pos1 = {18, 20},pos2 = {90, 20},pos3 = {54, 100},},
  {pos1 = {18, 20},pos2 = {90, 20},pos3 = {18, 100},pos4 = {90,100}}
}

--------------------------------------------------------------------------------
-- OVERVIEW DATA TABLE (texture coords + position offsets + item paths)
--------------------------------------------------------------------------------
local Header_Top_IMG = {
  {
    name = "1st",
    texture = { x = 483, y = 253, w = 40, h = 23 },
    pos     = { x = 55, y = 135 },
    -- Each index corresponds to an item image for _2, _3, _4 respectively
    ImageSetPath = {
      "UIData/ItemUIData/Costume/Common/J_Ring/Candle_Light_ring.tga",   -- For RewardItemPreview_Top_IMG_2_ItemImage
      "UIData/ItemUIData/Item/title_happychristmas11.tga",              -- For RewardItemPreview_Top_IMG_3_ItemImage
      "UIData/ItemUIData/Costume/Common/H_Bag/Common_santa2011_bag_001.tga" -- For RewardItemPreview_Top_IMG_4_ItemImage
    }
  },
  {
    name = "2nd",
    texture = { x = 484, y = 353, w = 40, h = 19 },
    pos     = { x = 55, y = 135 },
    ImageSetPath = {
      "UIData/ItemUIData/Costume/Common/J_Ring/Candle_Light_ring.tga",
      "UIData/ItemUIData/Item/title_happychristmas11.tga",
      "UIData/ItemUIData/Costume/Common/H_Bag/Common_santa2011_bag_001.tga"
    }
  },
  {
    name = "3rd",
    texture = { x = 482, y = 460, w = 38, h = 19 },
    pos     = { x = 55, y = 135 },
    ImageSetPath = {
      "UIData/ItemUIData/Costume/Common/J_Ring/Candle_Light_ring.tga",
      "UIData/ItemUIData/Item/title_happychristmas11.tga",
      "UIData/ItemUIData/Costume/Common/H_Bag/Common_santa2011_bag_001.tga"
    }
  },
  {
    name = "4th",
    texture = { x = 549, y = 252, w = 30, h = 22 },
    pos     = { x = 59, y = 135 },
    ImageSetPath = {
      "UIData/ItemUIData/Item/title_happychristmas11.tga",
      "UIData/ItemUIData/Costume/Common/H_Bag/Common_santa2011_bag_001.tga",
      "UIData/ItemUIData/Costume/Common/J_Ring/Candle_Light_ring.tga"            
    }
  },
  {
    name = "5th",
    texture = { x = 548, y = 352, w = 31, h = 21 },
    pos     = { x = 59, y = 135 },
    ImageSetPath = {
      "UIData/ItemUIData/Item/title_happychristmas11.tga",
      "UIData/ItemUIData/Costume/Common/H_Bag/Common_santa2011_bag_001.tga",
      "UIData/ItemUIData/Costume/Common/J_Ring/Candle_Light_ring.tga"        
    }
  },
  {
    name = "6th",
    texture = { x = 548, y = 458, w = 32, h = 22 },
    pos     = { x = 59, y = 135 },
    ImageSetPath = {
      "UIData/ItemUIData/Item/title_happychristmas11.tga",
      "UIData/ItemUIData/Costume/Common/H_Bag/Common_santa2011_bag_001.tga",
      "UIData/ItemUIData/Costume/Common/J_Ring/Candle_Light_ring.tga"        
    }
  },
}

------------------------------------------------------------------------------
-- GetRankLevel: sets "AllowingClaim" based on rank name
------------------------------------------------------------------------------
function SetAllowingClaim(RankInfo)
  LOG("GetRankLevel Info: " .. RankInfo )

  local rank_name_with_level = RankInfo:match("^[^,]+,([^,]+),")
  if not rank_name_with_level then
    return nil, nil -- Return nil if no match is found
  end

  -- Try to split the rank into (rank_name, rank_level)
  local rank_name, rank_level = rank_name_with_level:match("^(.-)_(.-)$")
  if (not rank_name or rank_name == "") or (not rank_level or rank_level == "") then
    rank_name = rank_name_with_level
    rank_level = nil
  end

  -- Update the global AllowingClaim index
  if     rank_name == "Rookie"      then AllowingClaim = 1
  elseif rank_name == "Bronze"      then AllowingClaim = 2
  elseif rank_name == "Iron"        then AllowingClaim = 3
  elseif rank_name == "Silver"      then AllowingClaim = 4
  elseif rank_name == "Gold"        then AllowingClaim = 5
  elseif rank_name == "Platinum"    then AllowingClaim = 6
  elseif rank_name == "Diamond"     then AllowingClaim = 7
  elseif rank_name == "Master"      then AllowingClaim = 8
  elseif rank_name == "GrandMaster" then AllowingClaim = 9
  end

  LOG("Checking on AllowingClaim: ".. AllowingClaim)
end

--------------------------------------------------------------------------------
-- PAGING FOR REWARD PANEL
--------------------------------------------------------------------------------
function ChangePage(direction)
  -- If "next" and not at the last set of items:
  if direction == "next" and currentIndex < (#rankIconImg - (MAX_REWARD_SLOT - 1)) then
      currentIndex = currentIndex + 1
  elseif direction == "prev" and currentIndex > 1 then
      currentIndex = currentIndex - 1
  end
  SortRankReward()
end

--------------------------------------------------------------------------------
-- PAGING FOR OVERVIEW PANEL (CALCULATED MAX PAGES)
--------------------------------------------------------------------------------
function ChangeOverviewPage(direction)
  -- Automatically compute how many pages we have
  local totalOverviewPages = math.ceil(#Header_Top_IMG / MAX_OVERVIEW_LABEL)

  local newIndex = currentOverviewIndex
  if direction == "next" then
      if currentOverviewIndex < totalOverviewPages then
          newIndex = currentOverviewIndex + 1
      end
  elseif direction == "prev" then
      if currentOverviewIndex > 1 then
          newIndex = currentOverviewIndex - 1
      end
  end

  if newIndex ~= currentOverviewIndex then
      currentOverviewIndex = newIndex
      SortOverview()
  end
end

function MouseEnter_RankingButton(args)
  LOG("-----------------MouseEnter_RankingButton-----------------")
  LOG("-----------------MouseEnter_RankingButton Exit-----------------")
end

function MouseLeave_RankingButton(args)
  LOG("-----------------MouseLeave_RankingButton-----------------")
  SetShowToolTip(false)
  LOG("-----------------MouseLeave_RankingButton Exit-----------------")
end

--------------------------------------------------------------------------------
-- MAIN PANELS
--------------------------------------------------------------------------------
function MainSeasonalPanal()  
  -- Parent Object for MainSeasonalPanal 
  local MainSeasonalPanalParent = winMgr:createWindow("TaharezLook/StaticImage", "MainSeasonalPanalParent")
  MainSeasonalPanalParent:setTexture("Enabled", "UIData/invisible.tga", 0, 0)        
  MainSeasonalPanalParent:setVisible(true)
  MainSeasonalPanalParent:setZOrderingEnabled(true)
  MainSeasonalPanalParent:setMousePassThroughEnabled(true)
  GUITool.AnchorMiddle(MainSeasonalPanalParent)
  MainSeasonalPanalParent:setPosition(-(1024/2),-(728/2))
  
  -- Create the background Main Panel image 
  SeasonalBGPanalIMG = winMgr:createWindow("TaharezLook/StaticImage", "SeasonalBGPanalIMG")
  SeasonalBGPanalIMG:setTexture("Enabled", "UIData/WndSeasonal_Reward.png", 198, 373)
  SeasonalBGPanalIMG:setPosition(((g_MAIN_WIN_SIZEX - 802) / 2 ) + 5 , ((g_MAIN_WIN_SIZEY - 62) / 2) - 271)
  SeasonalBGPanalIMG:setSize(822, 82)
  SeasonalBGPanalIMG:setVisible(true)
  SeasonalBGPanalIMG:setAlwaysOnTop(true)
  SeasonalBGPanalIMG:setMousePassThroughEnabled(true)
  SeasonalBGPanalIMG:setZOrderingEnabled(true)
  MainSeasonalPanalParent:addChildWindow(SeasonalBGPanalIMG)

  -- OverviewButton
  OverviewButton = winMgr:createWindow("TaharezLook/Button", "OverviewButton")
  OverviewButton:setTexture("Normal", "UIData/WndSeasonal_Reward.png", 203, 378)
  OverviewButton:setPosition(120,88)
  OverviewButton:setSize(202, 52)
  OverviewButton:setVisible(true)
  OverviewButton:setZOrderingEnabled(true)
  OverviewButton:setClippedByParent(false)
  OverviewButton:subscribeEvent("Clicked", function ()
    LOG("OverviewButton:Clicked")
    local overviewVisible = winMgr:getWindow("OverViewImgMainPanal"):isVisible()
    -- Toggle
    winMgr:getWindow("OverViewImgMainPanal"):setVisible(not overviewVisible)
    winMgr:getWindow("PreviousOverviewButton"):setVisible(not overviewVisible)
    winMgr:getWindow("NextOverviewButton"):setVisible(not overviewVisible)

    if not overviewVisible then
      -- If overview is being shown, hide the reward panel
      winMgr:getWindow("RewardSlotMainPanal"):setVisible(false)
      winMgr:getWindow("NextRewardButton"):setVisible(false)
      winMgr:getWindow("PreviousRewardButton"):setVisible(false)
    end
  end)
  MainSeasonalPanalParent:addChildWindow(OverviewButton)

  -- RewardButton
  RewardButton = winMgr:createWindow("TaharezLook/Button", "RewardButton")
  RewardButton:setTexture("Normal", "UIData/WndSeasonal_Reward.png", 408, 378)
  RewardButton:setPosition(326, 88)
  RewardButton:setSize(202, 52)
  RewardButton:setVisible(true)
  RewardButton:setZOrderingEnabled(true)
  RewardButton:setAlwaysOnTop(true)
  RewardButton:setClippedByParent(false)
  RewardButton:subscribeEvent("Clicked", function()  	    
    LOG("RewardButton:Clicked")
    local rewardVisible = winMgr:getWindow("RewardSlotMainPanal"):isVisible()
    -- Toggle
    winMgr:getWindow("RewardSlotMainPanal"):setVisible(not rewardVisible)
    winMgr:getWindow("NextRewardButton"):setVisible(not rewardVisible)
    winMgr:getWindow("PreviousRewardButton"):setVisible(not rewardVisible)

    -- Hide overview if Reward is being shown
    winMgr:getWindow("PreviousOverviewButton"):setVisible(false)
    winMgr:getWindow("NextOverviewButton"):setVisible(false)
    if not rewardVisible then
      winMgr:getWindow("OverViewImgMainPanal"):setVisible(false)
    end
  end) 
  MainSeasonalPanalParent:addChildWindow(RewardButton)

  -- RankingButton
  RankingButton = winMgr:createWindow("TaharezLook/Button", "RankingButton")
  RankingButton:setTexture("Normal", "UIData/WndSeasonal_Reward.png", 613, 378)
  RankingButton:setPosition(415, 5)
  RankingButton:setSize(202, 52)
  RankingButton:setZOrderingEnabled(true)
  RankingButton:subscribeEvent("Clicked", function() 
    --RankingLeadderBoard()  
  end) 
  SeasonalBGPanalIMG:addChildWindow(RankingButton)

  -- Initialize the reward panel
  ShowRankRewardInit()
  
  -- Using to call RankingSeasonReward in c++ (stub)
  GetRankingSeasonReward()

  -- Check available reward logic
  CheckAvailableRewardRankItem()

  -- Initialize the overview panel
  ShowOverViewInit()
end

function CloseMainSeasonalPanal()
  winMgr:getWindow("RewardSlotMainPanal"):setVisible(false)
  winMgr:getWindow("SeasonalBGPanalIMG"):setVisible(false)
  winMgr:getWindow("NextRewardButton"):setVisible(false)
  winMgr:getWindow("PreviousRewardButton"):setVisible(false)
  winMgr:getWindow("PreviousOverviewButton"):setVisible(false)
  winMgr:getWindow("NextOverviewButton"):setVisible(false)
  winMgr:getWindow("OverViewImgMainPanal"):setVisible(false)
  winMgr:getWindow("OverviewButton"):setVisible(false)
  winMgr:getWindow("RewardButton"):setVisible(false)
end

--------------------------------------------------------------------------------
-- REWARDS PANEL: INIT & SORT
--------------------------------------------------------------------------------

function ShowRankRewardInit()

  local startIdx = (currentIndex - 1) * MAX_REWARD_SLOT + 1
  local GapX_interval = 200

  local MainSeasonalPanalParent = winMgr:getWindow("MainSeasonalPanalParent")

  RewardSlotMainPanal = winMgr:createWindow("TaharezLook/StaticImage", "RewardSlotMainPanal")
  RewardSlotMainPanal:setTexture("Enabled", "UIData/invisible.tga", 700, 200)
  RewardSlotMainPanal:setPosition(0, 0)
  RewardSlotMainPanal:setSize(600, 600)
  RewardSlotMainPanal:setVisible(false)
  MainSeasonalPanalParent:addChildWindow(RewardSlotMainPanal) 

  PreviousRewardButton = winMgr:createWindow("TaharezLook/Button", "PreviousRewardButton")
  PreviousRewardButton:setTexture("Normal", "UIData/WndSeasonal_Reward.png", 142, 389)   
  PreviousRewardButton:setPosition(105,((g_MAIN_WIN_SIZEY - 11) / 2) - 30)
  PreviousRewardButton:setSize(9, 11)
  PreviousRewardButton:setVisible(false)
  PreviousRewardButton:setZOrderingEnabled(true)
  PreviousRewardButton:setAlwaysOnTop(true)
  PreviousRewardButton:setClippedByParent(false)
  PreviousRewardButton:subscribeEvent("Clicked", function()  	    
    ChangePage("prev")
  end)
  RewardSlotMainPanal:addChildWindow(PreviousRewardButton)

  NextRewardButton = winMgr:createWindow("TaharezLook/Button", "NextRewardButton")
  NextRewardButton:setTexture("Normal", "UIData/WndSeasonal_Reward.png", 153, 389)   
  NextRewardButton:setPosition(915,((g_MAIN_WIN_SIZEY - 11) / 2) - 30)
  NextRewardButton:setSize(9, 11)
  NextRewardButton:setVisible(false)
  NextRewardButton:setZOrderingEnabled(true)
  NextRewardButton:setAlwaysOnTop(true)
  NextRewardButton:setClippedByParent(false)
  NextRewardButton:subscribeEvent("Clicked", function()  	    
    ChangePage("next")
  end)
  RewardSlotMainPanal:addChildWindow(NextRewardButton)  

  for i = 1, MAX_REWARD_SLOT do
    local index = startIdx + i - 1
    if index > #rankIconImg then break end

    local reward = rankIconImg[index]
    
    local RewardSlotPanal = winMgr:createWindow("TaharezLook/StaticImage", "RewardSlotPanal"..i)   
    RewardSlotMainPanal:addChildWindow(RewardSlotPanal)
    
    local RewardRankName = winMgr:createWindow("TaharezLook/StaticImage", "RewardRankName"..i)   
    RewardSlotMainPanal:addChildWindow(RewardRankName)

    local RewardRankImg = winMgr:createWindow("TaharezLook/StaticImage", "RewardRankImg"..i)   
    RewardSlotMainPanal:addChildWindow(RewardRankImg)

    local RewardRankClaimPanal = winMgr:createWindow("TaharezLook/StaticImage", "RewardRankClaimPanal"..i)
    RewardRankClaimPanal:setTexture("Enabled", "UIData/WndSeasonal_Reward.png", 249, 466)
    RewardRankClaimPanal:setPosition((GapX_interval * i) - 71, ((g_MAIN_WIN_SIZEY - 408) / 2) + 150)
    RewardRankClaimPanal:setSize(170, 220)
    RewardRankClaimPanal:setAlwaysOnTop(true)
    RewardSlotMainPanal:addChildWindow(RewardRankClaimPanal)

    -- "Claim" Button
    local RewardRankCliamButton = winMgr:createWindow("TaharezLook/Button", "RewardRankCliamButton"..i)
    RewardRankCliamButton:setTexture("Disabled", "UIData/WndSeasonal_Reward.png", 30, 294)
    RewardRankCliamButton:setTexture("Enabled",  "UIData/WndSeasonal_Reward.png", 30, 322)
    RewardRankCliamButton:setTexture("Hover",    "UIData/WndSeasonal_Reward.png", 30, 370)
    RewardRankCliamButton:setPosition((GapX_interval * i) - 35, 501)
    RewardRankCliamButton:setSize(102, 32)
    RewardRankCliamButton:setEnabled(false)  -- default, will enable if allowed
    RewardRankCliamButton:setAlwaysOnTop(true)
    RewardRankCliamButton:setClippedByParent(false)
    RewardRankCliamButton:subscribeEvent("Clicked", function()
      LOG("Claimed rank: " .. reward.name .. " (index="..tostring(index)..")")

      RecievingItem(i)
      -- Mark this rank as claimed in AlreadyClaimingSet
      AlreadyClaimingSet[index] = true
      -- Disable the button
      RewardRankCliamButton:setEnabled(false)
    end)
    RewardSlotMainPanal:addChildWindow(RewardRankCliamButton)
    
    -- Up to 4 item slots
    local ItemRewardRankClaimPanal1 = winMgr:createWindow("TaharezLook/StaticImage", "ItemRewardRankClaimPanal1_"..i)
    ItemRewardRankClaimPanal1:setTexture("Enabled",  "UIData/ItemUIData/Costume/Basic/A_Hair/W_M_Hair_001.tga", 5, 5)
    ItemRewardRankClaimPanal1:setPosition(0, 0)
    ItemRewardRankClaimPanal1:setSize(128, 128)
    ItemRewardRankClaimPanal1:setScaleHeight(140)
    ItemRewardRankClaimPanal1:setScaleWidth(140)
    ItemRewardRankClaimPanal1:setAlwaysOnTop(true)
    ItemRewardRankClaimPanal1:setVisible(false)
    RewardRankClaimPanal:addChildWindow(ItemRewardRankClaimPanal1)

    local ItemRewardRankClaimPanal2 = winMgr:createWindow("TaharezLook/StaticImage", "ItemRewardRankClaimPanal2_"..i)
    ItemRewardRankClaimPanal2:setTexture("Enabled", "UIData/ItemUIData/Costume/Basic/A_Hair/W_S_Hair_002.tga", 5, 5)
    ItemRewardRankClaimPanal2:setPosition(0, 0)
    ItemRewardRankClaimPanal2:setSize(128, 128)
    ItemRewardRankClaimPanal2:setScaleHeight(140)
    ItemRewardRankClaimPanal2:setScaleWidth(140)
    ItemRewardRankClaimPanal2:setAlwaysOnTop(true)
    ItemRewardRankClaimPanal2:setVisible(false)
    RewardRankClaimPanal:addChildWindow(ItemRewardRankClaimPanal2)

    local ItemRewardRankClaimPanal3 = winMgr:createWindow("TaharezLook/StaticImage", "ItemRewardRankClaimPanal3_"..i)
    ItemRewardRankClaimPanal3:setTexture("Enabled", "UIData/ItemUIData/Costume/Basic/C_Upper/W_B_Upper_001.tga", 5, 5)
    ItemRewardRankClaimPanal3:setPosition(0, 0)
    ItemRewardRankClaimPanal3:setSize(128, 128)
    ItemRewardRankClaimPanal3:setScaleHeight(140)
    ItemRewardRankClaimPanal3:setScaleWidth(140)
    ItemRewardRankClaimPanal3:setAlwaysOnTop(true)
    ItemRewardRankClaimPanal3:setVisible(false)
    RewardRankClaimPanal:addChildWindow(ItemRewardRankClaimPanal3)

    local ItemRewardRankClaimPanal4 = winMgr:createWindow("TaharezLook/StaticImage", "ItemRewardRankClaimPanal4_"..i)
    ItemRewardRankClaimPanal4:setTexture("Enabled", "UIData/ItemUIData/Costume/Basic/F_Foot/W_S_Foot_002.tga", 5, 5)
    ItemRewardRankClaimPanal4:setPosition(0, 0)
    ItemRewardRankClaimPanal4:setSize(128, 128)
    ItemRewardRankClaimPanal4:setScaleHeight(140)
    ItemRewardRankClaimPanal4:setScaleWidth(140)
    ItemRewardRankClaimPanal4:setAlwaysOnTop(true)
    ItemRewardRankClaimPanal4:setVisible(false)
    RewardRankClaimPanal:addChildWindow(ItemRewardRankClaimPanal4)

  end

  SortRankReward()
end

function SortRankReward()
  local GapX_interval = 200

  for i = 1, MAX_REWARD_SLOT do
      local index = currentIndex + i - 1
      if index > #rankIconImg then break end

      local reward = rankIconImg[index]
      
      local RewardSlotPanal = winMgr:getWindow("RewardSlotPanal"..i)
      RewardSlotPanal:setTexture("Enabled", "UIData/WndSeasonal_Reward.png", 44, 468)
      RewardSlotPanal:setPosition((GapX_interval * i) - 85, ((g_MAIN_WIN_SIZEY - 408) / 2) - 25)
      RewardSlotPanal:setSize(194, 408)
      
      local RewardRankName = winMgr:getWindow("RewardRankName"..i)
      RewardRankName:setTexture("Enabled", "UIData/WndSeasonal_Reward.png", reward.nameImg[1], reward.nameImg[2])
      RewardRankName:setSize(reward.nameSize[1], reward.nameSize[2])
      RewardRankName:setPosition((GapX_interval * i) + reward.namePos[1],
                                 ((g_MAIN_WIN_SIZEY - 408) / 2) + reward.namePos[2])
      RewardRankName:setAlwaysOnTop(true)
      
      local RewardRankImg = winMgr:getWindow("RewardRankImg"..i)
      RewardRankImg:setTexture("Enabled", "UIData/WndSeasonal_Reward.png", reward.img[1], reward.img[2])
      RewardRankImg:setPosition((GapX_interval * i) + reward.pos[1],
                                ((g_MAIN_WIN_SIZEY - 408) / 2) + reward.pos[2])
      RewardRankImg:setAlwaysOnTop(true)
      RewardRankImg:setSize(reward.size[1], reward.size[2])

      local RewardRankClaimPanal = winMgr:getWindow("RewardRankClaimPanal"..i)
      RewardRankClaimPanal:setVisible(true)
      RewardRankClaimPanal:setTexture("Enabled", "UIData/WndSeasonal_Reward.png", 249, 466)
      RewardRankClaimPanal:setPosition((GapX_interval * i) - 71,
                                       ((g_MAIN_WIN_SIZEY - 408) / 2) + 150)
      RewardRankClaimPanal:setSize(170, 220)

      -- Match correct background panel by slotSize
      local matched = false
      for _, slotData in ipairs(RewardSlotBackgroundPanal) do
        if reward.SlotSize == slotData.SlotType then
          RewardRankClaimPanal:setTexture("Enabled", "UIData/WndSeasonal_Reward.png", slotData.img[1], slotData.img[2])
          RewardRankClaimPanal:setPosition((GapX_interval * i) + slotData.pos[1],
                                           ((g_MAIN_WIN_SIZEY - 408) / 2) + slotData.pos[2])
          RewardRankClaimPanal:setSize(slotData.size[1], slotData.size[2])
          matched = true
          break
        end
      end

      if not matched then
        RewardRankClaimPanal:setVisible(false)
      end

      -- Enable/disable "Claim" button:
      local RewardRankCliamButton = winMgr:getWindow("RewardRankCliamButton"..i)
      if (index <= AllowingClaim) and (not AlreadyClaimingSet[index]) then
        RewardRankCliamButton:setEnabled(true)
      else
        RewardRankCliamButton:setEnabled(false)
      end
     
      SetSlotIMGClaimReward(i, index)
  end
end

--------------------------------------------------------------------------------
-- OVERVIEW PANEL: INIT, SORT, and UPDATE PAGING BUTTONS
--------------------------------------------------------------------------------
function ShowOverViewInit()
  local MainSeasonalPanalParent = winMgr:getWindow("MainSeasonalPanalParent")

  OverViewImgMainPanal = winMgr:createWindow("TaharezLook/StaticImage", "OverViewImgMainPanal")
  OverViewImgMainPanal:setTexture("Enabled", "UIData/invisible.tga", 700, 200)
  OverViewImgMainPanal:setSize(600, 600)
  OverViewImgMainPanal:setVisible(false)
  OverViewImgMainPanal:setAlpha(0)
  OverViewImgMainPanal:setZOrderingEnabled(true)
  OverViewImgMainPanal:setMousePassThroughEnabled(true)
  MainSeasonalPanalParent:addChildWindow(OverViewImgMainPanal) 

  local OverViewImg = winMgr:createWindow("TaharezLook/StaticImage", "OverViewImg")
  OverViewImg:setTexture("Enabled", "UIData/WndRankLobby_Overview.png", 11, 10)
  OverViewImg:setPosition(((g_MAIN_WIN_SIZEX - 457) / 2 ) - 265, ((g_MAIN_WIN_SIZEY - 416) / 2))
  OverViewImg:setSize(457, 416)  
  OverViewImgMainPanal:addChildWindow(OverViewImg)

  local OverViewBasePanal = winMgr:createWindow("TaharezLook/StaticImage", "OverViewBasePanal")
  OverViewBasePanal:setTexture("Enabled", "UIData/WndRankLobby_Overview.png", 36, 445)
  OverViewBasePanal:setPosition(((g_MAIN_WIN_SIZEX - 457) / 2 ) + 205, ((g_MAIN_WIN_SIZEY - 416) / 2) + 10)
  OverViewBasePanal:setSize(432, 388)
  OverViewImgMainPanal:addChildWindow(OverViewBasePanal)

  -- Create windows for 3 "Overview" rows
  for i = 1, MAX_OVERVIEW_LABEL do
    local Header_Top = winMgr:createWindow("TaharezLook/StaticImage", "Header_Top_IMG_" .. i)
    OverViewImgMainPanal:addChildWindow(Header_Top)

    local RewardItemPreview_Top_IMG = winMgr:createWindow("TaharezLook/StaticImage", "RewardItemPreview_Top_IMG".. i)
    OverViewImgMainPanal:addChildWindow(RewardItemPreview_Top_IMG)

    local RewardItemPreview_Top_TextImg = winMgr:createWindow("TaharezLook/StaticImage", "RewardItemPreview_Top_TextImg ".. i)
    OverViewImgMainPanal:addChildWindow(RewardItemPreview_Top_TextImg)

    local RewardItemPreview_Top_IMG_2 = winMgr:createWindow("TaharezLook/StaticImage", "RewardItemPreview_Top_IMG_2".. i)
    OverViewImgMainPanal:addChildWindow(RewardItemPreview_Top_IMG_2)

    local RewardItemPreview_Top_TextImg_2 = winMgr:createWindow("TaharezLook/StaticImage", "RewardItemPreview_Top_TextImg_2 ".. i)
    OverViewImgMainPanal:addChildWindow(RewardItemPreview_Top_TextImg_2)

    local RewardItemPreview_Top_IMG_3 = winMgr:createWindow("TaharezLook/StaticImage", "RewardItemPreview_Top_IMG_3".. i)
    OverViewImgMainPanal:addChildWindow(RewardItemPreview_Top_IMG_3)

    local RewardItemPreview_Top_TextImg_3 = winMgr:createWindow("TaharezLook/StaticImage", "RewardItemPreview_Top_TextImg_3 ".. i)
    OverViewImgMainPanal:addChildWindow(RewardItemPreview_Top_TextImg_3)

    local RewardItemPreview_Top_IMG_4 = winMgr:createWindow("TaharezLook/StaticImage", "RewardItemPreview_Top_IMG_4".. i)
    OverViewImgMainPanal:addChildWindow(RewardItemPreview_Top_IMG_4)

    local RewardItemPreview_Top_TextImg_4 = winMgr:createWindow("TaharezLook/StaticImage", "RewardItemPreview_Top_TextImg_4".. i)
    OverViewImgMainPanal:addChildWindow(RewardItemPreview_Top_TextImg_4)

    ----------------------------------------------------------------------------
    -- NEW: Create the additional static images for each row:
    ----------------------------------------------------------------------------
    local RewardItemPreview_Top_IMG_2_ItemImage = winMgr:createWindow(
      "TaharezLook/StaticImage", 
      "RewardItemPreview_Top_IMG_2_ItemImage"..i
    )
    RewardItemPreview_Top_IMG_2_ItemImage:setAlwaysOnTop(true)
    RewardItemPreview_Top_IMG_2:addChildWindow(RewardItemPreview_Top_IMG_2_ItemImage)

    local RewardItemPreview_Top_IMG_3_ItemImage = winMgr:createWindow(
      "TaharezLook/StaticImage", 
      "RewardItemPreview_Top_IMG_3_ItemImage"..i
    )
    RewardItemPreview_Top_IMG_3_ItemImage:setAlwaysOnTop(true)
    RewardItemPreview_Top_IMG_3:addChildWindow(RewardItemPreview_Top_IMG_3_ItemImage)

    local RewardItemPreview_Top_IMG_4_ItemImage = winMgr:createWindow(
      "TaharezLook/StaticImage",
      "RewardItemPreview_Top_IMG_4_ItemImage"..i
    )
    RewardItemPreview_Top_IMG_4_ItemImage:setAlwaysOnTop(true)
    RewardItemPreview_Top_IMG_4:addChildWindow(RewardItemPreview_Top_IMG_4_ItemImage)
  end

  -- PreviousOverviewButton
  PreviousOverviewButton = winMgr:createWindow("TaharezLook/Button", "PreviousOverviewButton")
  PreviousOverviewButton:setTexture("Normal", "UIData/WndSeasonal_Reward.png", 142, 389) 
  PreviousOverviewButton:setPosition(765, ((g_MAIN_WIN_SIZEY - 11) / 2) + 160)
  PreviousOverviewButton:setSize(9, 11)
  PreviousOverviewButton:setZOrderingEnabled(true)
  PreviousOverviewButton:setAlwaysOnTop(true)
  PreviousOverviewButton:setVisible(false)
  PreviousOverviewButton:setClippedByParent(false)
  PreviousOverviewButton:setMousePassThroughEnabled(false)
  PreviousOverviewButton:subscribeEvent("Clicked", function()  	    
    ChangeOverviewPage("prev")
  end)
  MainSeasonalPanalParent:addChildWindow(PreviousOverviewButton)

  -- NextOverviewButton
  NextOverviewButton = winMgr:createWindow("TaharezLook/Button", "NextOverviewButton")
  NextOverviewButton:setTexture("Normal", "UIData/WndSeasonal_Reward.png", 153, 389)
  NextOverviewButton:setPosition(795, ((g_MAIN_WIN_SIZEY - 11) / 2) + 160)
  NextOverviewButton:setSize(9, 11)
  NextOverviewButton:setZOrderingEnabled(true)
  NextOverviewButton:setAlwaysOnTop(true)
  NextOverviewButton:setVisible(false)
  NextOverviewButton:setClippedByParent(false)
  NextOverviewButton:setMousePassThroughEnabled(false)
  NextOverviewButton:subscribeEvent("Clicked", function()  	    
    ChangeOverviewPage("next")
  end)
  MainSeasonalPanalParent:addChildWindow(NextOverviewButton)

  -- Show the first page of Overview
  SortOverview()
end

function SetItemOverView(RankLevel,PathItem)
  LOG("Into SetItemOverView (tolua_GetOverViewItem Lua Part)")
  LOG(RankLevel)
  LOG(PathItem)
  LOG("_______________________________________________________")
end

function SortOverview()
  local startIdx = (currentOverviewIndex - 1) * MAX_OVERVIEW_LABEL + 1

  for i = 1, MAX_OVERVIEW_LABEL do    
    local realIndex = startIdx + i - 1

    local Header_Top                     = winMgr:getWindow("Header_Top_IMG_" .. i)
    local RewardItemPreview_Top_IMG      = winMgr:getWindow("RewardItemPreview_Top_IMG".. i)
    local RewardItemPreview_Top_TextImg  = winMgr:getWindow("RewardItemPreview_Top_TextImg ".. i)
    local RewardItemPreview_Top_IMG_2    = winMgr:getWindow("RewardItemPreview_Top_IMG_2".. i)
    local RewardItemPreview_Top_TextImg_2= winMgr:getWindow("RewardItemPreview_Top_TextImg_2 ".. i)
    local RewardItemPreview_Top_IMG_3    = winMgr:getWindow("RewardItemPreview_Top_IMG_3".. i)
    local RewardItemPreview_Top_TextImg_3= winMgr:getWindow("RewardItemPreview_Top_TextImg_3 ".. i)
    local RewardItemPreview_Top_IMG_4    = winMgr:getWindow("RewardItemPreview_Top_IMG_4".. i)
    local RewardItemPreview_Top_TextImg_4= winMgr:getWindow("RewardItemPreview_Top_TextImg_4".. i)

    -- NEW windows for item images:
    local RewardItemPreview_Top_IMG_2_ItemImage = winMgr:getWindow("RewardItemPreview_Top_IMG_2_ItemImage".. i)
    local RewardItemPreview_Top_IMG_3_ItemImage = winMgr:getWindow("RewardItemPreview_Top_IMG_3_ItemImage".. i)
    local RewardItemPreview_Top_IMG_4_ItemImage = winMgr:getWindow("RewardItemPreview_Top_IMG_4_ItemImage".. i)

    if realIndex > #Header_Top_IMG then
      -- Hide everything if no data
      Header_Top:setVisible(false)
      RewardItemPreview_Top_IMG:setVisible(false)
      RewardItemPreview_Top_TextImg:setVisible(false)
      RewardItemPreview_Top_IMG_2:setVisible(false)
      RewardItemPreview_Top_TextImg_2:setVisible(false)
      RewardItemPreview_Top_IMG_3:setVisible(false)
      RewardItemPreview_Top_TextImg_3:setVisible(false)
      RewardItemPreview_Top_IMG_4:setVisible(false)
      RewardItemPreview_Top_TextImg_4:setVisible(false)
      -- Hide new item images
      RewardItemPreview_Top_IMG_2_ItemImage:setVisible(false)
      RewardItemPreview_Top_IMG_3_ItemImage:setVisible(false)
      RewardItemPreview_Top_IMG_4_ItemImage:setVisible(false)
    else
      local headerData = Header_Top_IMG[realIndex]

      -- Show them
      Header_Top:setVisible(true)
      RewardItemPreview_Top_IMG:setVisible(true)
      RewardItemPreview_Top_TextImg:setVisible(true)
      RewardItemPreview_Top_IMG_2:setVisible(true)
      RewardItemPreview_Top_TextImg_2:setVisible(true)
      RewardItemPreview_Top_IMG_3:setVisible(true)
      RewardItemPreview_Top_TextImg_3:setVisible(true)
      RewardItemPreview_Top_IMG_4:setVisible(true)
      RewardItemPreview_Top_TextImg_4:setVisible(true)

      -- Show new item images
      RewardItemPreview_Top_IMG_2_ItemImage:setVisible(true)
      RewardItemPreview_Top_IMG_3_ItemImage:setVisible(true)
      RewardItemPreview_Top_IMG_4_ItemImage:setVisible(true)

      -- Header top (the rank name, e.g. "1st", "2nd")
      Header_Top:setTexture(
        "Enabled", 
        "UIData/WndRankLobby_Overview.png",
        headerData.texture.x, 
        headerData.texture.y
      )
      Header_Top:setSize(headerData.texture.w, headerData.texture.h)
      Header_Top:setPosition(
        ((g_MAIN_WIN_SIZEX - 150) / 2) + headerData.pos.x, 
        GapY_interval * i + headerData.pos.y
      )

      -- The rest of the preview item images (background placeholders)
      RewardItemPreview_Top_IMG:setTexture("Enabled", "UIData/WndRankLobby_Overview.png", 477, 15)
      RewardItemPreview_Top_IMG:setPosition(((g_MAIN_WIN_SIZEX - 65) / 2 ) + 80, GapY_interval * i + 125)
      RewardItemPreview_Top_IMG:setSize(65, 65)  

      RewardItemPreview_Top_TextImg:setTexture("Enabled", "UIData/WndRankLobby_Overview.png", 478, 168)
      RewardItemPreview_Top_TextImg:setPosition(((g_MAIN_WIN_SIZEX - 89) / 2 ) + 80, GapY_interval * i + 195)
      RewardItemPreview_Top_TextImg:setSize(89, 11)

      RewardItemPreview_Top_IMG_2:setTexture("Enabled", "UIData/WndRankLobby_Overview.png", 478, 86)
      RewardItemPreview_Top_IMG_2:setPosition(((g_MAIN_WIN_SIZEX - 60) / 2 ) + 190, GapY_interval * i + 125)
      RewardItemPreview_Top_IMG_2:setSize(60, 60)

      RewardItemPreview_Top_TextImg_2:setTexture("Enabled", "UIData/WndRankLobby_Overview.png", 484, 185)
      RewardItemPreview_Top_TextImg_2:setPosition(((g_MAIN_WIN_SIZEX - 71) / 2 ) + 190, GapY_interval * i + 195)
      RewardItemPreview_Top_TextImg_2:setSize(71, 9)

      RewardItemPreview_Top_IMG_3:setTexture("Enabled", "UIData/WndRankLobby_Overview.png", 478, 86)
      RewardItemPreview_Top_IMG_3:setPosition(((g_MAIN_WIN_SIZEX - 60) / 2 ) + 270, GapY_interval * i + 125)
      RewardItemPreview_Top_IMG_3:setSize(60, 60)

      RewardItemPreview_Top_TextImg_3:setTexture("Enabled", "UIData/WndRankLobby_Overview.png", 484, 185)
      RewardItemPreview_Top_TextImg_3:setPosition(((g_MAIN_WIN_SIZEX - 71) / 2 ) + 270, GapY_interval * i + 195)
      RewardItemPreview_Top_TextImg_3:setSize(71, 9)

      RewardItemPreview_Top_IMG_4:setTexture("Enabled", "UIData/WndRankLobby_Overview.png", 478, 86)
      RewardItemPreview_Top_IMG_4:setPosition(((g_MAIN_WIN_SIZEX - 60) / 2 ) + 350, GapY_interval * i + 125)
      RewardItemPreview_Top_IMG_4:setSize(60, 60)

      RewardItemPreview_Top_TextImg_4:setTexture("Enabled", "UIData/WndRankLobby_Overview.png", 484, 185)
      RewardItemPreview_Top_TextImg_4:setPosition(((g_MAIN_WIN_SIZEX - 71) / 2 ) + 350, GapY_interval * i + 195)
      RewardItemPreview_Top_TextImg_4:setSize(71, 9)

      ----------------------------------------------------------------------------
      -- Position & set textures for the new item images from headerData.ImageSetPath
      ----------------------------------------------------------------------------
      local imgPaths = headerData.ImageSetPath  -- a table of 3 paths
      if imgPaths and #imgPaths >= 3 then
        -- [1] => RewardItemPreview_Top_IMG_2_ItemImage
        RewardItemPreview_Top_IMG_2_ItemImage:setTexture("Enabled", imgPaths[1], 0, 0)
        RewardItemPreview_Top_IMG_3_ItemImage:setTexture("Enabled", imgPaths[2], 0, 0)
        RewardItemPreview_Top_IMG_4_ItemImage:setTexture("Enabled", imgPaths[3], 0, 0)
      end

      -- Make sure they match the position/size of the base images
      RewardItemPreview_Top_IMG_2_ItemImage:setPosition(0,0)    
      RewardItemPreview_Top_IMG_3_ItemImage:setPosition(0,0)
      RewardItemPreview_Top_IMG_4_ItemImage:setPosition(0,0)

       -- Make sure they match the position/size of the base images
       RewardItemPreview_Top_IMG_2_ItemImage:setScaleHeight(150)
       RewardItemPreview_Top_IMG_2_ItemImage:setScaleWidth(150)

       RewardItemPreview_Top_IMG_3_ItemImage:setScaleHeight(150)
       RewardItemPreview_Top_IMG_3_ItemImage:setScaleWidth(150)

       RewardItemPreview_Top_IMG_4_ItemImage:setScaleHeight(150)
       RewardItemPreview_Top_IMG_4_ItemImage:setScaleWidth(150)      
     
    end
  end
end

function SetSlotClaimReward(SlotSize,SlotIndex)
  rankIconImg[SlotIndex].SlotSize = SlotSize  
  SortRankReward()
end

function SetSlotIMGClaimReward(i, rankIndex)
  local slotSize = rankIconImg[rankIndex].SlotSize
  
  local slot1 = winMgr:getWindow("ItemRewardRankClaimPanal1_"..i)
  local slot2 = winMgr:getWindow("ItemRewardRankClaimPanal2_"..i)
  local slot3 = winMgr:getWindow("ItemRewardRankClaimPanal3_"..i)
  local slot4 = winMgr:getWindow("ItemRewardRankClaimPanal4_"..i)

  slot1:setVisible(false)
  slot2:setVisible(false)
  slot3:setVisible(false)
  slot4:setVisible(false)
  
  if slotSize == 1 then
      slot1:setPosition(RewardItemSlot[1].pos[1], RewardItemSlot[1].pos[2])
      slot1:setVisible(true)
  elseif slotSize == 2 then
      slot1:setPosition(RewardItemSlot[2].pos1[1], RewardItemSlot[2].pos1[2])
      slot2:setPosition(RewardItemSlot[2].pos2[1], RewardItemSlot[2].pos2[2])
      slot1:setVisible(true)
      slot2:setVisible(true)
  elseif slotSize == 3 then
      slot1:setPosition(RewardItemSlot[3].pos1[1], RewardItemSlot[3].pos1[2])
      slot2:setPosition(RewardItemSlot[3].pos2[1], RewardItemSlot[3].pos2[2])
      slot3:setPosition(RewardItemSlot[3].pos3[1], RewardItemSlot[3].pos3[2])
      slot1:setVisible(true)
      slot2:setVisible(true)
      slot3:setVisible(true)
  elseif slotSize == 4 then
      slot1:setPosition(RewardItemSlot[4].pos1[1], RewardItemSlot[4].pos1[2])
      slot2:setPosition(RewardItemSlot[4].pos2[1], RewardItemSlot[4].pos2[2])
      slot3:setPosition(RewardItemSlot[4].pos3[1], RewardItemSlot[4].pos3[2])
      slot4:setPosition(RewardItemSlot[4].pos4[1], RewardItemSlot[4].pos4[2])
      slot1:setVisible(true)
      slot2:setVisible(true)
      slot3:setVisible(true)
      slot4:setVisible(true)
  end
end

function SetItemImg(rankindex, path, itemSlotNumber)
  LOG("===== Test SetItemImg =====")
  LOG(rankindex)
  LOG(tostring(path:gsub('"', ""))) 
  LOG(itemSlotNumber)
  LOG("===== Test SetItemImg =====")

  local slot1 = winMgr:getWindow("ItemRewardRankClaimPanal1_"..rankindex)
  local slot2 = winMgr:getWindow("ItemRewardRankClaimPanal2_"..rankindex)
  local slot3 = winMgr:getWindow("ItemRewardRankClaimPanal3_"..rankindex)
  local slot4 = winMgr:getWindow("ItemRewardRankClaimPanal4_"..rankindex)

  local LinkString = tostring(path:gsub('"', ""))

  if itemSlotNumber == 1 then
    slot1:setTexture("Enabled", LinkString , 0, 0)      
  elseif itemSlotNumber == 2 then
    slot2:setTexture("Enabled", LinkString , 0, 0)
  elseif itemSlotNumber == 3 then
    slot3:setTexture("Enabled", LinkString , 0, 0)
  elseif itemSlotNumber == 4 then
    slot4:setTexture("Enabled", LinkString , 0, 0)
  end

  SortRankReward() 
end

function SetDisabledRewardRankCliamButton (RankSetIndex)
  local RewardRankCliamButton = winMgr:getWindow("RewardRankCliamButton" .. RankSetIndex)
  RewardRankCliamButton:setEnabled(false)
  AlreadyClaimingSet[RankSetIndex] = true
end
