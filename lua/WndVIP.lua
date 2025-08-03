--------------------------------------------------------------------
-- Script Entry Point
--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root	    = winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)
root:activate()
-------------------------------------------------------------------------
--Constants
-------------------------------------------------------------------------
local MAX_BENEFIT_ITEM_X_COUNT = 3
local MAX_BENEFIT_ITEM_Y_COUNT = 3
local BENEFIT_ITEM_POSX = 310
local BENEFIT_ITEM_POSY = 220
-------------------------------------------------------------------------
local BG_VIP_SIZEX = 600
local BG_VIP_SIZEY = 480
local BG_VIP_POSX = 114
local BG_VIP_POSY = 144
-------------------------------------------------------------------------
local BG_BENEFIT_CHART_SIZEX = 900
local BG_BENEFIT_CHART_SIZEY = 400
local BG_BENEFIT_CHART_POSX = 114
local BG_BENEFIT_CHART_POSY = 144
-------------------------------------------------------------------------
local GAGE_OUTER_VIP_POINT_SIZEX = 460
local GAGE_OUTER_VIP_POINT_SIZEY = 22
local GAGE_OUTER_VIP_POINT_POSX = 170
local GAGE_OUTER_VIP_POINT_POSY = 50
-------------------------------------------------------------------------
local GAGE_INNER_VIP_POINT_SIZEX = 460
local GAGE_INNER_VIP_POINT_SIZEY = 22
local GAGE_INNER_VIP_POINT_POSX = 170
local GAGE_INNER_VIP_POINT_POSY = 50
-------------------------------------------------------------------------
local CONST_TEXT_CURRENT_VIP_LEVEL_SIZEX = 140
local CONST_TEXT_CURRENT_VIP_LEVEL_SIZEY = 25
local CONST_TEXT_CURRENT_VIP_LEVEL_POSX = 30
local CONST_TEXT_CURRENT_VIP_LEVEL_POSY = 60
-------------------------------------------------------------------------
local TEXT_CURRENT_VIP_LEVEL_SIZEX = 140
local TEXT_CURRENT_VIP_LEVEL_SIZEY = 25
local TEXT_CURRENT_VIP_LEVEL_POSX = 30
local TEXT_CURRENT_VIP_LEVEL_POSY = 80
-------------------------------------------------------------------------
local CONST_TEXT_CURRENT_VIP_POINT_SIZEX = 10
local CONST_TEXT_CURRENT_VIP_POINT_SIZEY = 10
local CONST_TEXT_CURRENT_VIP_POINT_POSX = 270
local CONST_TEXT_CURRENT_VIP_POINT_POSY = 77
-------------------------------------------------------------------------
local TEXT_CURRENT_VIP_POINT_SIZEX = 10
local TEXT_CURRENT_VIP_POINT_SIZEY = 10
local TEXT_CURRENT_VIP_POINT_POSX = 320
local TEXT_CURRENT_VIP_POINT_POSY = 107
-------------------------------------------------------------------------
local CONST_TEXT_ACHIEVE_POINT_SIZEX = 10
local CONST_TEXT_ACHIEVE_POINT_SIZEY = 10
local CONST_TEXT_ACHIEVE_POINT_POSX = 10
local CONST_TEXT_ACHIEVE_POINT_POSY = 10
-------------------------------------------------------------------------
local TEXT_ACHIEVE_POINT_SIZEX = 10
local TEXT_ACHIEVE_POINT_SIZEY = 10
local TEXT_ACHIEVE_POINT_POSX = 10
local TEXT_ACHIEVE_POINT_POSY = 40
-------------------------------------------------------------------------
local CONST_TEXT_ENTIRE_VIP_POINT_SIZEX = 10
local CONST_TEXT_ENTIRE_VIP_POINT_SIZEY = 10
local CONST_TEXT_ENTIRE_VIP_POINT_POSX = 19
local CONST_TEXT_ENTIRE_VIP_POINT_POSY = 207
-------------------------------------------------------------------------
local TEXT_ENTIRE_VIP_POINT_SIZEX = 10
local TEXT_ENTIRE_VIP_POINT_SIZEY = 10
local TEXT_ENTIRE_VIP_POINT_POSX = 119
local TEXT_ENTIRE_VIP_POINT_POSY = 237
-------------------------------------------------------------------------
local CONST_TEXT_TOBE_EXTINCT_VIP_POINT_SIZEX = 10
local CONST_TEXT_TOBE_EXTINCT_VIP_POINT_SIZEY = 10
local CONST_TEXT_TOBE_EXTINCT_VIP_POINT_POSX = 19
local CONST_TEXT_TOBE_EXTINCT_VIP_POINT_POSY = 270
-------------------------------------------------------------------------
local TEXT_TOBE_EXTINCT_VIP_POINT_SIZEX = 10
local TEXT_TOBE_EXTINCT_VIP_POINT_SIZEY = 10
local TEXT_TOBE_EXTINCT_VIP_POINT_POSX = 119
local TEXT_TOBE_EXTINCT_VIP_POINT_POSY = 300
-------------------------------------------------------------------------
local CONST_TEXT_AFTER_EXTINCT_VIP_POINT_SIZEX = 10
local CONST_TEXT_AFTER_EXTINCT_VIP_POINT_SIZEY = 10
local CONST_TEXT_AFTER_EXTINCT_VIP_POINT_POSX = 19
local CONST_TEXT_AFTER_EXTINCT_VIP_POINT_POSY = 333
-------------------------------------------------------------------------
local TEXT_AFTER_EXTINCT_VIP_POINT_SIZEX = 10
local TEXT_AFTER_EXTINCT_VIP_POINT_SIZEY = 10
local TEXT_AFTER_EXTINCT_VIP_POINT_POSX = 119
local TEXT_AFTER_EXTINCT_VIP_POINT_POSY = 363
-------------------------------------------------------------------------
local CONST_TEXT_TIME_TO_EXTINCT_SIZEX = 10
local CONST_TEXT_TIME_TO_EXTINCT_SIZEY = 10
local CONST_TEXT_TIME_TO_EXTINCT_POSX = 19
local CONST_TEXT_TIME_TO_EXTINCT_POSY = 399
-------------------------------------------------------------------------
local TEXT_TIME_TO_EXTINCT_SIZEX = 10
local TEXT_TIME_TO_EXTINCT_SIZEY = 10
local TEXT_TIME_TO_EXTINCT_POSX = 119
local TEXT_TIME_TO_EXTINCT_POSY = 429
-------------------------------------------------------------------------
local CONST_TEXT_DISCOUNT_RATE_SIZEX = 10
local CONST_TEXT_DISCOUNT_RATE_SIZEY = 10
local CONST_TEXT_DISCOUNT_RATE_POSX = 351
local CONST_TEXT_DISCOUNT_RATE_POSY = 228
-------------------------------------------------------------------------
local TEXT_DISCOUNT_RATE_SIZEX = 10
local TEXT_DISCOUNT_RATE_SIZEY = 10
local TEXT_DISCOUNT_RATE_POSX = 375
local TEXT_DISCOUNT_RATE_POSY = 327
-------------------------------------------------------------------------
local CONST_TEXT_TITLE_VIP_POINT_STATUS_SIZEX = 150
local CONST_TEXT_TITLE_VIP_POINT_STATUS_SIZEY = 10
local CONST_TEXT_TITLE_VIP_POINT_STATUS_POSX = 54
local CONST_TEXT_TITLE_VIP_POINT_STATUS_POSY = 165
-------------------------------------------------------------------------
local CONST_TEXT_TITLE_DISCOUNT_BENEFIT_SIZEX = 100
local CONST_TEXT_TITLE_DISCOUNT_BENEFIT_SIZEY = 10
local CONST_TEXT_TITLE_DISCOUNT_BENEFIT_POSX = 355
local CONST_TEXT_TITLE_DISCOUNT_BENEFIT_POSY = 165
-------------------------------------------------------------------------
local BTN_SEE_COMPARE_BENEFIT_SIZEX = 100
local BTN_SEE_COMPARE_BENEFIT_SIZEY = 30
local BTN_SEE_COMPARE_BENEFIT_POSX = 450
local BTN_SEE_COMPARE_BENEFIT_POSY = 105
-------------------------------------------------------------------------
local RECT_SEE_DISCOUNT_BENEFIT_SIZEX = 162
local RECT_SEE_DISCOUNT_ITEM_BENEFIT_SIZEY = 268
local RECT_SEE_DISCOUNT_BENEFIT_POSX = 619
local RECT_SEE_DISCOUNT_ITEM_BENEFIT_POSY = 268
-------------------------------------------------------------------------
local BTN_CLOSE_SIZEX = 23
local BTN_CLOSE_SIZEY = 23
local BTN_CLOSE_POSX = 777
local BTN_CLOSE_POSY = 0
-------------------------------------------------------------------------Entry Button
mywindow = winMgr:createWindow("TaharezLook/Button", "VIPButton")
mywindow:setTexture("Normal", "UIData/mainbarchat.tga", 344, 588)
mywindow:setTexture("Hover", "UIData/mainbarchat.tga", 344, 616)
mywindow:setTexture("Pushed", "UIData/mainbarchat.tga", 344, 644)
mywindow:setTexture("PushedOff", "UIData/mainbarchat.tga", 344, 588)
mywindow:setTexture("Disabled", "UIData/mainbarchat.tga", 344, 672)
mywindow:setSize(86, 28)
mywindow:setVisible(false)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "ShowVIPPanel")
root:addChildWindow(mywindow)


-------------------------------------------------------------------------
--CreateWindows
-------------------------------------------------------------------------BG
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "VIPAlphaImage")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setEnabled(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)



-------------------------------------------------------------------------BG
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "VIPBackground")
mywindow:setTexture("Enabled", "UIData/frame/frame_002.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/frame/frame_002.tga", 0, 0)
mywindow:setframeWindow(true)
mywindow:setWideType(6)
mywindow:setVisible(false)
mywindow:setPosition((g_MAIN_WIN_SIZEX-BG_VIP_SIZEX)/2, (g_MAIN_WIN_SIZEY-BG_VIP_SIZEY)/2)
mywindow:setSize(BG_VIP_SIZEX, BG_VIP_SIZEY)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)
RegistEscEventInfo("VIPBackground", "HideVIPPanel")


-------------------------------------------------------------------------BG
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "VIPBenefitChartBackground")
mywindow:setTexture("Enabled", "UIData/frame/frame_002.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/frame/frame_002.tga", 0, 0)
mywindow:setframeWindow(true)
mywindow:setWideType(6)
mywindow:setVisible(false)
mywindow:setPosition((g_MAIN_WIN_SIZEX-BG_BENEFIT_CHART_SIZEX)/2, (g_MAIN_WIN_SIZEY-BG_BENEFIT_CHART_SIZEY)/2)
mywindow:setSize(BG_BENEFIT_CHART_SIZEX, BG_BENEFIT_CHART_SIZEY)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
root:addChildWindow(mywindow)
RegistEscEventInfo("VIPBenefitChartBackground", "OnHideVIPBenefitChart")

-------------------------------------------------------------------------BTN
mywindow = winMgr:createWindow("TaharezLook/Button", "BTNVIPBenefitChartClosebutton")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setPosition(BG_BENEFIT_CHART_SIZEX - BTN_CLOSE_SIZEX, BTN_CLOSE_POSY)
mywindow:setSize(BTN_CLOSE_SIZEX, BTN_CLOSE_SIZEY)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "OnHideVIPBenefitChart")
winMgr:getWindow("VIPBenefitChartBackground"):addChildWindow(mywindow)

-------------------------------------------------------------------------BTN
mywindow = winMgr:createWindow("TaharezLook/Button", "BTNCompareBenefit")
mywindow:setTexture("Normal", "UIData/C_Button.tga", 488, 0)
mywindow:setTexture("Hover", "UIData/C_Button.tga", 488, 22)
mywindow:setTexture("Pushed", "UIData/C_Button.tga", 488, 44)
mywindow:setTexture("PushedOff", "UIData/C_Button.tga", 488, 0)
mywindow:setPosition(BTN_SEE_COMPARE_BENEFIT_POSX, BTN_SEE_COMPARE_BENEFIT_POSY)
mywindow:setSize(BTN_SEE_COMPARE_BENEFIT_SIZEX, BTN_SEE_COMPARE_BENEFIT_SIZEY)
mywindow:setZOrderingEnabled(false)
mywindow:setSubscribeEvent("Clicked", "OpenPageToCompareBenefit")
winMgr:getWindow("VIPBackground"):addChildWindow(mywindow)

-------------------------------------------------------------------------BTN
mywindow = winMgr:createWindow("TaharezLook/Button", "BTNClosebutton")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setPosition(BG_VIP_SIZEX - BTN_CLOSE_SIZEX, BTN_CLOSE_POSY)
mywindow:setSize(BTN_CLOSE_SIZEX, BTN_CLOSE_SIZEY)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "HideVIPPanel")
winMgr:getWindow("VIPBackground"):addChildWindow(mywindow)

-------------------------------------------------------------------------Text
mywindow = winMgr:createWindow("TaharezLook/StaticText", "ConstTextCurrentVIPLevel")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont(g_STRING_FONT_DODUM, 115)
mywindow:setText("ConstTextCurrentVIPLevel")
mywindow:setPosition(CONST_TEXT_CURRENT_VIP_LEVEL_POSX, CONST_TEXT_CURRENT_VIP_LEVEL_POSY)
mywindow:setSize(CONST_TEXT_CURRENT_VIP_LEVEL_SIZEX, CONST_TEXT_CURRENT_VIP_LEVEL_SIZEY)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
winMgr:getWindow("VIPBackground"):addChildWindow(mywindow)

-------------------------------------------------------------------------Text
mywindow = winMgr:createWindow("TaharezLook/StaticText", "TextCurrentVIPLevel")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont(g_STRING_FONT_DODUM, 115)
mywindow:setText("TextCurrentVIPLevel")
mywindow:setPosition(TEXT_CURRENT_VIP_LEVEL_POSX, TEXT_CURRENT_VIP_LEVEL_POSY)
mywindow:setSize(TEXT_CURRENT_VIP_LEVEL_SIZEX, TEXT_CURRENT_VIP_LEVEL_SIZEY)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
winMgr:getWindow("VIPBackground"):addChildWindow(mywindow)

-------------------------------------------------------------------------Text
mywindow = winMgr:createWindow("TaharezLook/StaticText", "ConstTextCurrentVIPPoints")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont(g_STRING_FONT_DODUM, 115)
mywindow:setText("ConstTextCurrentVIPPoints")
mywindow:setPosition(CONST_TEXT_CURRENT_VIP_POINT_POSX, CONST_TEXT_CURRENT_VIP_POINT_POSY)
mywindow:setSize(CONST_TEXT_CURRENT_VIP_POINT_SIZEX, CONST_TEXT_CURRENT_VIP_POINT_SIZEY)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
winMgr:getWindow("VIPBackground"):addChildWindow(mywindow)

-------------------------------------------------------------------------Text
mywindow = winMgr:createWindow("TaharezLook/StaticText", "TextCurrentVIPPoints")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont(g_STRING_FONT_DODUM, 115)
mywindow:setText("TextCurrentVIPPoints")
mywindow:setPosition(TEXT_CURRENT_VIP_POINT_POSX, TEXT_CURRENT_VIP_POINT_POSY)
mywindow:setSize(TEXT_CURRENT_VIP_POINT_SIZEX, TEXT_CURRENT_VIP_POINT_SIZEY)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
winMgr:getWindow("VIPBackground"):addChildWindow(mywindow)

-------------------------------------------------------------------------Text
mywindow = winMgr:createWindow("TaharezLook/StaticText", "ConstTextAchievePoint")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont(g_STRING_FONT_DODUM, 115)
mywindow:setText("ConstTextAchievePoint")
mywindow:setPosition(CONST_TEXT_ACHIEVE_POINT_POSX, CONST_TEXT_ACHIEVE_POINT_POSY)
mywindow:setSize(CONST_TEXT_ACHIEVE_POINT_SIZEX, CONST_TEXT_ACHIEVE_POINT_SIZEY)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
winMgr:getWindow("VIPBackground"):addChildWindow(mywindow)

-------------------------------------------------------------------------Text
mywindow = winMgr:createWindow("TaharezLook/StaticText", "TextAchievePoint")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont(g_STRING_FONT_DODUM, 115)
mywindow:setText("TextAchievePoint")
mywindow:setPosition(TEXT_ACHIEVE_POINT_POSX, TEXT_ACHIEVE_POINT_POSY)
mywindow:setSize(TEXT_ACHIEVE_POINT_SIZEX, TEXT_ACHIEVE_POINT_SIZEY)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
winMgr:getWindow("VIPBackground"):addChildWindow(mywindow)

-------------------------------------------------------------------------Text
mywindow = winMgr:createWindow("TaharezLook/StaticText", "ConstTextEntirePoint")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont(g_STRING_FONT_DODUM, 115)
mywindow:setText("ConstTextCurrentPoint")
mywindow:setPosition(CONST_TEXT_ENTIRE_VIP_POINT_POSX, CONST_TEXT_ENTIRE_VIP_POINT_POSY)
mywindow:setSize(CONST_TEXT_ENTIRE_VIP_POINT_SIZEX, CONST_TEXT_ENTIRE_VIP_POINT_SIZEY)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
winMgr:getWindow("VIPBackground"):addChildWindow(mywindow)

-------------------------------------------------------------------------Text
mywindow = winMgr:createWindow("TaharezLook/StaticText", "TextEntirePoint")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont(g_STRING_FONT_DODUM, 115)
mywindow:setText("TextEntirePoint")
mywindow:setPosition(TEXT_ENTIRE_VIP_POINT_POSX, TEXT_ENTIRE_VIP_POINT_POSY)
mywindow:setSize(TEXT_ENTIRE_VIP_POINT_SIZEX, TEXT_ENTIRE_VIP_POINT_SIZEY)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
winMgr:getWindow("VIPBackground"):addChildWindow(mywindow)

-------------------------------------------------------------------------Text
mywindow = winMgr:createWindow("TaharezLook/StaticText", "ConstTextPointTobeExtinct")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont(g_STRING_FONT_DODUM, 115)
mywindow:setText("ConstTextTobeExtinctPoint")
mywindow:setPosition(CONST_TEXT_TOBE_EXTINCT_VIP_POINT_POSX, CONST_TEXT_TOBE_EXTINCT_VIP_POINT_POSY)
mywindow:setSize(CONST_TEXT_TOBE_EXTINCT_VIP_POINT_SIZEX, CONST_TEXT_TOBE_EXTINCT_VIP_POINT_SIZEY)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
winMgr:getWindow("VIPBackground"):addChildWindow(mywindow)

-------------------------------------------------------------------------Text
mywindow = winMgr:createWindow("TaharezLook/StaticText", "TextPointTobeExtinct")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont(g_STRING_FONT_DODUM, 115)
mywindow:setText("TextPointTobeExtinct")
mywindow:setPosition(TEXT_TOBE_EXTINCT_VIP_POINT_POSX, TEXT_TOBE_EXTINCT_VIP_POINT_POSY)
mywindow:setSize(TEXT_TOBE_EXTINCT_VIP_POINT_SIZEX, TEXT_TOBE_EXTINCT_VIP_POINT_SIZEY)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
winMgr:getWindow("VIPBackground"):addChildWindow(mywindow)

-------------------------------------------------------------------------Text
mywindow = winMgr:createWindow("TaharezLook/StaticText", "ConstTextPointAfterExtinct")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont(g_STRING_FONT_DODUM, 115)
mywindow:setText("ConstTextAfterExtinctPoint")
mywindow:setPosition(CONST_TEXT_AFTER_EXTINCT_VIP_POINT_POSX, CONST_TEXT_AFTER_EXTINCT_VIP_POINT_POSY)
mywindow:setSize(CONST_TEXT_AFTER_EXTINCT_VIP_POINT_SIZEX, CONST_TEXT_AFTER_EXTINCT_VIP_POINT_SIZEY)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
winMgr:getWindow("VIPBackground"):addChildWindow(mywindow)

-------------------------------------------------------------------------Text
mywindow = winMgr:createWindow("TaharezLook/StaticText", "TextPointAfterExtinct")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont(g_STRING_FONT_DODUM, 115)
mywindow:setText("TextPointAfterExtinct")
mywindow:setPosition(TEXT_AFTER_EXTINCT_VIP_POINT_POSX, TEXT_AFTER_EXTINCT_VIP_POINT_POSY)
mywindow:setSize(TEXT_AFTER_EXTINCT_VIP_POINT_SIZEX, TEXT_AFTER_EXTINCT_VIP_POINT_SIZEY)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
winMgr:getWindow("VIPBackground"):addChildWindow(mywindow)

-------------------------------------------------------------------------Text
mywindow = winMgr:createWindow("TaharezLook/StaticText", "ConstTextTimeToExtinct")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont(g_STRING_FONT_DODUM, 115)
mywindow:setText("ConstTextTimeToExtinct")
mywindow:setPosition(CONST_TEXT_TIME_TO_EXTINCT_POSX, CONST_TEXT_TIME_TO_EXTINCT_POSY)
mywindow:setSize(CONST_TEXT_TIME_TO_EXTINCT_SIZEX, CONST_TEXT_TIME_TO_EXTINCT_SIZEY)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
winMgr:getWindow("VIPBackground"):addChildWindow(mywindow)

-------------------------------------------------------------------------Text
mywindow = winMgr:createWindow("TaharezLook/StaticText", "TextTimeToExtinct")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont(g_STRING_FONT_DODUM, 115)
mywindow:setText("TextTimeToExtinct")
mywindow:setPosition(TEXT_TIME_TO_EXTINCT_POSX, TEXT_TIME_TO_EXTINCT_POSY)
mywindow:setSize(TEXT_TIME_TO_EXTINCT_SIZEX, TEXT_TIME_TO_EXTINCT_SIZEY)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
winMgr:getWindow("VIPBackground"):addChildWindow(mywindow)

-------------------------------------------------------------------------Text
mywindow = winMgr:createWindow("TaharezLook/StaticText", "ConstTextDiscountRate")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont(g_STRING_FONT_DODUM, 115)
mywindow:setText("ConstTextDiscountRate")
mywindow:setPosition(CONST_TEXT_DISCOUNT_RATE_POSX, CONST_TEXT_DISCOUNT_RATE_POSY)
mywindow:setSize(CONST_TEXT_DISCOUNT_RATE_SIZEX, CONST_TEXT_DISCOUNT_RATE_SIZEY)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
winMgr:getWindow("VIPBackground"):addChildWindow(mywindow)


-------------------------------------------------------------------------Text
mywindow = winMgr:createWindow("TaharezLook/StaticText", "TextDiscountRate")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont(g_STRING_FONT_DODUM, 115)
mywindow:setText("TextDiscountRate")
mywindow:setPosition(TEXT_DISCOUNT_RATE_POSX, TEXT_DISCOUNT_RATE_POSY)
mywindow:setSize(TEXT_DISCOUNT_RATE_SIZEX, TEXT_DISCOUNT_RATE_SIZEY)
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
winMgr:getWindow("VIPBackground"):addChildWindow(mywindow)


-------------------------------------------------------------------------Text
mywindow = winMgr:createWindow("TaharezLook/StaticText", "ConstTextTitleVIPPointStatus")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont(g_STRING_FONT_DODUM, 115)
mywindow:setText("ConstTextTitleVIPPointStatus")
mywindow:setPosition(CONST_TEXT_TITLE_VIP_POINT_STATUS_POSX , CONST_TEXT_TITLE_VIP_POINT_STATUS_POSY )
mywindow:setSize(CONST_TEXT_TITLE_VIP_POINT_STATUS_SIZEX , CONST_TEXT_TITLE_VIP_POINT_STATUS_SIZEY )
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
winMgr:getWindow("VIPBackground"):addChildWindow(mywindow)


-------------------------------------------------------------------------Text
mywindow = winMgr:createWindow("TaharezLook/StaticText", "ConstTextTitleDiscountBenefit")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont(g_STRING_FONT_DODUM, 115)
mywindow:setText("ConstTextTitleDiscountBenefit")
mywindow:setPosition(CONST_TEXT_TITLE_DISCOUNT_BENEFIT_POSX   , CONST_TEXT_TITLE_DISCOUNT_BENEFIT_POSY  )
mywindow:setSize(CONST_TEXT_TITLE_DISCOUNT_BENEFIT_SIZEX   , CONST_TEXT_TITLE_DISCOUNT_BENEFIT_SIZEY  )
mywindow:setAlwaysOnTop(true)
mywindow:setEnabled(false)
winMgr:getWindow("VIPBackground"):addChildWindow(mywindow)

-------------------------------------------------------------------------

-------------------------------------------------------------------------
--Event Functions
-------------------------------------------------------------------------
function OnShowVIPPanel(CurrentVipPoint, MAXVIPPointNowLevel, RemainPoint, NextVIPLevel,
			EntirePoint, PointTobeExtinct, PointAfterExtinct, RemainDays, RemainHours )
	DebugStr("OnShowVIPPanel")
	winMgr:getWindow("VIPAlphaImage"):setVisible(true)
	mywindow  = winMgr:getWindow("VIPBackground")
	mywindow:setVisible(true)
	
	ShowTexts(CurrentVipPoint, MAXVIPPointNowLevel, RemainPoint, NextVIPLevel,
			EntirePoint, PointTobeExtinct, PointAfterExtinct, RemainDays, RemainHours )
end

function OnHideVIPPanel()
	winMgr:getWindow("VIPAlphaImage"):setVisible(false)
	mywindow  = winMgr:getWindow("VIPBackground")
	mywindow:setVisible(false)
	
	HideTexts()
	
	SetShowToolTip(false)
end
-------------------------------------------------------------------------
function ShowTexts(CurrentVipPoint, MAXVIPPointNowLevel, RemainPoint, NextVIPLevel,
			EntirePoint, PointTobeExtinct, PointAfterExtinct, RemainDays, RemainHours)

	OnShowTextCurrentVIPPoint(CurrentVipPoint, MAXVIPPointNowLevel )
	OnShowTextAchievePoint(CurrentVipPoint - MAXVIPPointNowLevel, NextVIPLevel)
	OnShowTextEntirePoint(EntirePoint)
	OnShowTextPointTobeExtinct(PointTobeExtinct)
	OnShowTextPointAfterExtinct(PointAfterExtinct)
	OnShowTextTimeToExtinct(RemainDays, RemainHours)
	OnShowTextDiscountRate(0)
end

function HideTexts()
	OnHideTextCurrentVIPPoint()
	OnHideTextAchievePoint()
	OnHideTextEntirePoint()
	OnHideTextPointTobeExtinct()
	OnHideTextPointAfterExtinct()
	OnHideTextTimeToExtinct()
	OnHideTextDiscountRate()	
end
-------------------------------------------------------------------------
function OnShowTextCurrentVIPPoint(CurrentVipPoint, MAXVIPPointNowLevel)
	mywindow  = winMgr:getWindow("TextCurrentVIPPoints")
	if mywindow ~= nil then
		mywindow:setVisible(true)
		mywindow:setText(CurrentVipPoint .. "/" .. MAXVIPPointNowLevel)
	end
end
function OnHideTextCurrentVIPPoint()
	mywindow  = winMgr:getWindow("TextCurrentVIPPoints")
	if mywindow ~= nil then
		mywindow:setVisible(true)
	end
end
-------------------------------------------------------------------------
function	OnShowTextDiscountRate(DiscountRate)
	mywindow  = winMgr:getWindow("TextDiscountRate")
	if mywindow ~= nil then
		mywindow:setVisible(true)
		mywindow:setText(DiscountRate .. " %")
	end
end
function	OnHideTextDiscountRate()		
	mywindow  = winMgr:getWindow("TextDiscountRate")
	if mywindow ~= nil then
		mywindow:setVisible(true)
	end
end
-------------------------------------------------------------------------
function OnShowTextAchievePoint(RemainPoint, NextVIPLevel)
	--RemainPoint = CurrentVipPoint - MAXVIPPointNowLevel
	mywindow  = winMgr:getWindow("TextAchievePoint")
	if mywindow ~= nil then
		mywindow:setText(RemainPoint .. "Æ÷ÀÎÆ® È¹µæ ½Ã, VIP " .. NextVIPLevel .. "½Â±Þ")
		mywindow:setVisible(true)
	end
end
function OnHideTextAchievePoint()
	mywindow  = winMgr:getWindow("TextAchievePoint")
	if mywindow ~= nil then
		mywindow:setVisible(true)
	end	
end
-------------------------------------------------------------------------
function OnShowTextEntirePoint(EntirePoint)
	mywindow  = winMgr:getWindow("TextEntirePoint")
	if mywindow ~= nil then
		mywindow:setText(EntirePoint .. "P")
		mywindow:setVisible(true)
	end	
end
function OnHideTextEntirePoint()
	mywindow  = winMgr:getWindow("TextEntirePoint")
	if mywindow ~= nil then	
		mywindow:setVisible(true)
	end	
end
-------------------------------------------------------------------------
function OnShowTextPointTobeExtinct(PointTobeExtinct)
	mywindow  = winMgr:getWindow("TextPointTobeExtinct")
	if mywindow ~= nil then		
		mywindow:setText(PointTobeExtinct .. "P")
		mywindow:setVisible(true)
	end	
end
function OnHideTextPointTobeExtinct()
	mywindow  = winMgr:getWindow("TextPointTobeExtinct")
	if mywindow ~= nil then		
		mywindow:setVisible(true)
	end	
end
-------------------------------------------------------------------------
function OnShowTextPointAfterExtinct(PointAfterExtinct)
	mywindow  = winMgr:getWindow("TextPointAfterExtinct")
	if mywindow ~= nil then			
		mywindow:setText(PointAfterExtinct .. "P")
		mywindow:setVisible(true)
	end	
end
function OnHideTextPointAfterExtinct()
	mywindow  = winMgr:getWindow("TextPointAfterExtinct")
	if mywindow ~= nil then			
		mywindow:setVisible(true)
	end
end
-------------------------------------------------------------------------
function OnShowTextTimeToExtinct(RemainDays, RemainHours)
	mywindow  = winMgr:getWindow("TextTimeToExtinct")
	if mywindow ~= nil then				
		--mywindow:setText(RemainDays .. "ÀÏ " .. RemainHours .. "½Ã°£")	
		mywindow:setText(0 .. "ÀÏ " .. 0 .. "½Ã°£")	
		mywindow:setVisible(true)
	end	
end
function OnHideTextTimeToExtinct()
	mywindow  = winMgr:getWindow("TextTimeToExtinct")
	if mywindow ~= nil then		
		mywindow:setVisible(true)
	end
end
-------------------------------------------------------------------------
--function OpenPageToCashCharge()
--	ClickCashCharge()
--end
-------------------------------------------------------------------------
function OpenPageToCompareBenefit()
	mywindow  = winMgr:getWindow("VIPBenefitChartBackground")
	if mywindow ~= nil then
		winMgr:getWindow("VIPBackground"):setAlwaysOnTop(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setVisible(true)
	end
end

function OnHideVIPBenefitChart()
 	mywindow  = winMgr:getWindow("VIPBenefitChartBackground")
	if mywindow ~= nil then 
		mywindow:setVisible(false)
		winMgr:getWindow("VIPBackground"):setAlwaysOnTop(true)
	end
end