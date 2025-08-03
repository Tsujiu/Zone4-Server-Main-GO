-----------------------------------------
-- Script Entry Point
-----------------------------------------
-- �˸� �޼��� ���̱�
function ShowNotifyMessage(message, ...)

    local winMgr = CEGUI.WindowManager:getSingleton()
    local root = winMgr:getWindow("DefaultWindow")
    local drawer = root:getDrawer()

    if winMgr:getWindow("NM_NotifyMessageText") then
    else

        -----------------------------------------------------------

        -- �Ϲ� �˸� �޼���(Ȯ�ι�ư�� ����)

        -----------------------------------------------------------
        -- �޼��� ���� �̹���
        mywindow = winMgr:createWindow("TaharezLook/StaticImage", "NM_NotifyMessageAlpha")
        mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
        mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
        mywindow:setProperty("FrameEnabled", "False")
        mywindow:setProperty("BackgroundEnabled", "False")
        mywindow:setPosition(0, 0)
        mywindow:setSize(1920, 1200)
        mywindow:setVisible(false)
        mywindow:setAlwaysOnTop(true)
        mywindow:setZOrderingEnabled(false)
        root:addChildWindow(mywindow)

        -- �޼��� ����â
        progressbarwindow1 = winMgr:createWindow("TaharezLook/StaticImage", "NM_NotifyMessageMain")
        progressbarwindow1:setTexture("Enabled", "UIData/popup001.tga", 0, 0)
        progressbarwindow1:setTexture("Disabled", "UIData/popup001.tga", 0, 0)
        progressbarwindow1:setProperty("FrameEnabled", "False")
        progressbarwindow1:setProperty("BackgroundEnabled", "False")
        progressbarwindow1:setWideType(6);
        progressbarwindow1:setPosition(338, 246)
        progressbarwindow1:setSize(346, 275)
        progressbarwindow1:setVisible(false)
        progressbarwindow1:setAlwaysOnTop(true)
        progressbarwindow1:setZOrderingEnabled(false)
        root:addChildWindow(progressbarwindow1)

        -- �޼��� ����â
        mywindow = winMgr:createWindow("TaharezLook/StaticText", "NM_NotifyMessageText")
        mywindow:setProperty("FrameEnabled", "false")
        mywindow:setProperty("BackgroundEnabled", "false")
        mywindow:setTextColor(255, 255, 255, 255)
        mywindow:setFont(g_STRING_FONT_DODUM, 115)
        mywindow:setText("")
        mywindow:setPosition(60, 120)
        mywindow:setSize(250, 36)
        mywindow:setAlwaysOnTop(true)
        progressbarwindow1:addChildWindow(mywindow)
    end

    if winMgr:getWindow("NM_NotifyMessageAlpha") then

        winMgr:getWindow("NM_NotifyMessageAlpha"):setVisible(true)
        root:addChildWindow(winMgr:getWindow("NM_NotifyMessageAlpha"))
        winMgr:getWindow("NM_NotifyMessageMain"):setVisible(true)
        root:addChildWindow(winMgr:getWindow("NM_NotifyMessageMain"))

        if select('#', ...) == 0 then

            local i, j = string.find(message, "\n")
            if i ~= nil then

                strSize = GetStringSize(g_STRING_FONT_DODUM, 115, message)
                winMgr:getWindow("NM_NotifyMessageText"):setPosition(48, 110)
                winMgr:getWindow("NM_NotifyMessageText"):clearTextExtends()
                winMgr:getWindow("NM_NotifyMessageText"):setViewTextMode(1)
                winMgr:getWindow("NM_NotifyMessageText"):setAlign(8)
                winMgr:getWindow("NM_NotifyMessageText"):setLineSpacing(5)
                winMgr:getWindow("NM_NotifyMessageText"):addTextExtends(message, g_STRING_FONT_DODUM, 115, 255, 255,
                    255, 255, 2, 0, 0, 0, 255)

            else

                local strSize = GetStringSize(g_STRING_FONT_DODUM, 115, message)
                if strSize > 320 then
                    local msg1, msg2 = SplitString(message, 34)
                    local msg = msg1 .. "\n" .. msg2

                    strSize = GetStringSize(g_STRING_FONT_DODUM, 115, msg1)
                    winMgr:getWindow("NM_NotifyMessageText"):setPosition(173 - (strSize / 2), 116)
                    winMgr:getWindow("NM_NotifyMessageText"):clearTextExtends()
                    winMgr:getWindow("NM_NotifyMessageText"):setViewTextMode(1)
                    winMgr:getWindow("NM_NotifyMessageText"):setAlign(1)
                    winMgr:getWindow("NM_NotifyMessageText"):setLineSpacing(5)
                    winMgr:getWindow("NM_NotifyMessageText"):addTextExtends(message, g_STRING_FONT_DODUM, 115, 255, 255,
                        255, 255, 2, 0, 0, 0, 255)
                else
                    winMgr:getWindow("NM_NotifyMessageText"):setPosition(173 - (strSize / 2), 132)
                    winMgr:getWindow("NM_NotifyMessageText"):clearTextExtends()
                    winMgr:getWindow("NM_NotifyMessageText"):setViewTextMode(1)
                    winMgr:getWindow("NM_NotifyMessageText"):setAlign(1)
                    winMgr:getWindow("NM_NotifyMessageText"):setLineSpacing(5)
                    winMgr:getWindow("NM_NotifyMessageText"):addTextExtends(message, g_STRING_FONT_DODUM, 115, 255, 255,
                        255, 255, 2, 0, 0, 0, 255)
                end
            end

        else

            -- �μ� 1: ���Ĺ��(1:��������, 8:�������)
            local align = 1
            if select(1, ...) ~= nil then
                align = select(1, ...)
            end

            -- �μ� 2: ���� ���� ����
            local spacing = 5
            if select(2, ...) ~= nil then
                spacing = select(2, ...)
            end

            -- �μ� 3: ���� x��ġ
            local posX = 84
            if select(3, ...) ~= nil then
                posX = select(3, ...)
            end

            -- �μ� 4: ���� y��ġ
            local posY = 116
            if select(4, ...) ~= nil then
                posY = select(4, ...)
            end

            winMgr:getWindow("NM_NotifyMessageText"):setPosition(posX, posY)
            winMgr:getWindow("NM_NotifyMessageText"):clearTextExtends()
            winMgr:getWindow("NM_NotifyMessageText"):setViewTextMode(1)
            winMgr:getWindow("NM_NotifyMessageText"):setAlign(align)
            winMgr:getWindow("NM_NotifyMessageText"):setLineSpacing(spacing)
            winMgr:getWindow("NM_NotifyMessageText"):addTextExtends(message, g_STRING_FONT_DODUM, 115, 255, 255, 255,
                255, 2, 0, 0, 0, 255)

        end

    end

end

-- �˸� �޼��� ���߱�
function HideNotifyMessage()

    local winMgr = CEGUI.WindowManager:getSingleton()
    if winMgr:getWindow("NM_NotifyMessageAlpha") then
        winMgr:getWindow("NM_NotifyMessageAlpha"):setVisible(false)
        winMgr:getWindow("NM_NotifyMessageMain"):setVisible(false)
        winMgr:getWindow("NM_NotifyMessageText"):setText("")
    end

end

------------------------------------------------------------

-- Ȯ�ι�ư�� �ִ� �޼��� ��Ƹ� ȣ��

------------------------------------------------------------
function NotifyMessageOKClicked_Lua()

    local winMgr = CEGUI.WindowManager:getSingleton()

    winMgr:getWindow("NM_Notify_LuaAlpha"):setVisible(false)
    winMgr:getWindow("NM_Notify_LuaMain"):setVisible(false)
    winMgr:getWindow("NM_Notify_LuaText"):setText("")
    --	SetInputEnable(true)
end

function ShowNotifyOKMessage_Lua(message, ...)
    DebugStr(message)
    local winMgr = CEGUI.WindowManager:getSingleton()
    local root = winMgr:getWindow("DefaultWindow")
    local drawer = root:getDrawer()
    CEGUI.MouseCursor:getSingleton():show()

    if winMgr:getWindow("NM_Notify_LuaAlpha") then
    else

        -- ��׶��� ���� �̹���
        mywindow = winMgr:createWindow("TaharezLook/StaticImage", "NM_Notify_LuaAlpha")
        mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
        mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
        mywindow:setProperty("FrameEnabled", "False")
        mywindow:setProperty("BackgroundEnabled", "False")
        mywindow:setPosition(0, 0)
        mywindow:setSize(1920, 1200)
        mywindow:setVisible(false)
        mywindow:setAlwaysOnTop(true)
        mywindow:setZOrderingEnabled(false)
        root:addChildWindow(mywindow)

        -- ���� ����â
        errorwindow = winMgr:createWindow("TaharezLook/StaticImage", "NM_Notify_LuaMain")
        errorwindow:setTexture("Enabled", "UIData/popup001.tga", 0, 0)
        errorwindow:setTexture("Disabled", "UIData/popup001.tga", 0, 0)
        errorwindow:setProperty("FrameEnabled", "False")
        errorwindow:setProperty("BackgroundEnabled", "False")
        errorwindow:setWideType(6);
        errorwindow:setPosition(338, 246)
        errorwindow:setSize(346, 275)
        errorwindow:setVisible(false)
        errorwindow:setAlwaysOnTop(true)
        errorwindow:setZOrderingEnabled(false)
        root:addChildWindow(errorwindow)

        -- ���� ����â
        mywindow = winMgr:createWindow("TaharezLook/StaticText", "NM_Notify_LuaText")
        mywindow:setProperty("FrameEnabled", "false")
        mywindow:setProperty("BackgroundEnabled", "false")
        mywindow:setTextColor(255, 255, 255, 255)
        mywindow:setFont(g_STRING_FONT_DODUM, 115)
        mywindow:setText("")
        mywindow:setPosition(44, 120)
        mywindow:setSize(250, 36)
        mywindow:setAlwaysOnTop(true)
        mywindow:setEnabled(false)
        errorwindow:addChildWindow(mywindow)

        -- ���� Ȯ�ι�ư  --��ɷ� ����
        mywindow = winMgr:createWindow("TaharezLook/Button", "NM_Notify_LuaOkButton")
        mywindow:setTexture("Normal", "UIData/popup001.tga", 693, 617)
        mywindow:setTexture("Hover", "UIData/popup001.tga", 693, 646)
        mywindow:setTexture("Pushed", "UIData/popup001.tga", 693, 675)
        mywindow:setTexture("PushedOff", "UIData/popup001.tga", 693, 704)
        mywindow:setPosition(4, 235)
        mywindow:setSize(331, 29)
        mywindow:setAlwaysOnTop(true)
        mywindow:subscribeEvent("Clicked", "NotifyMessageOKClicked_Lua")
        errorwindow:addChildWindow(mywindow)

        -- ����, ESC ���
        RegistEnterEventInfo("NM_Notify_LuaMain", "NotifyMessageOKClicked_Lua")
        RegistEscEventInfo("NM_Notify_LuaMain", "NotifyMessageOKClicked_Lua")
    end

    if winMgr:getWindow("NM_Notify_LuaMain") then

        root:addChildWindow(winMgr:getWindow("NM_Notify_LuaAlpha"));
        winMgr:getWindow("NM_Notify_LuaAlpha"):setVisible(true)
        root:addChildWindow(winMgr:getWindow("NM_Notify_LuaMain"));
        winMgr:getWindow("NM_Notify_LuaMain"):setVisible(true)
        local resultMseeage = ""

        if select('#', ...) == 0 then
            local i, j = string.find(message, "\n")
            if i ~= nil then
                local strSize = GetStringSize(g_STRING_FONT_DODUM, 115, message)
                winMgr:getWindow("NM_Notify_LuaText"):clearTextExtends()
                winMgr:getWindow("NM_Notify_LuaText"):setPosition(48, 110)
                winMgr:getWindow("NM_Notify_LuaText"):setViewTextMode(1)
                winMgr:getWindow("NM_Notify_LuaText"):setAlign(8)
                winMgr:getWindow("NM_Notify_LuaText"):setLineSpacing(5)
                resultMseeage = message
            else

                local strSize = GetStringSize(g_STRING_FONT_DODUM, 115, message)
                local msg = ""
                if strSize > 320 then
                    local msg1, msg2 = SplitString(message, 34)
                    msg = msg1 .. "\n" .. msg2
                    strSize = GetStringSize(g_STRING_FONT_DODUM, 115, msg1)
                    winMgr:getWindow("NM_Notify_LuaText"):setPosition(173 - (strSize / 2), 116)
                else
                    winMgr:getWindow("NM_Notify_LuaText"):setPosition(173 - (strSize / 2), 132)
                    msg = message
                end
                winMgr:getWindow("NM_Notify_LuaText"):clearTextExtends()
                winMgr:getWindow("NM_Notify_LuaText"):setViewTextMode(1)
                winMgr:getWindow("NM_Notify_LuaText"):setAlign(1)
                winMgr:getWindow("NM_Notify_LuaText"):setLineSpacing(5)
                resultMseeage = msg
            end
        else

            -- �μ� 1: ���Ĺ��(1:��������, 8:�������)
            local align = 1
            if select(1, ...) ~= nil then
                align = select(1, ...)
            end

            -- �μ� 2: ���� ���� ����
            local spacing = 5
            if select(2, ...) ~= nil then
                spacing = select(2, ...)
            end

            -- �μ� 3: ���� x��ġ
            local posX = 84
            if select(3, ...) ~= nil then
                posX = select(3, ...)
            end

            -- �μ� 4: ���� y��ġ
            local posY = 116
            if select(4, ...) ~= nil then
                posY = select(4, ...)
            end

            winMgr:getWindow("NM_Notify_LuaText"):setPosition(posX, posY)
            winMgr:getWindow("NM_Notify_LuaText"):clearTextExtends()
            winMgr:getWindow("NM_Notify_LuaText"):setViewTextMode(1)
            winMgr:getWindow("NM_Notify_LuaText"):setAlign(align)
            winMgr:getWindow("NM_Notify_LuaText"):setLineSpacing(spacing)
            resultMseeage = message
        end

        local tbufStringTable = {
            ['err'] = 0
        }
        local tbufSpecialTable = {
            ['err'] = 0
        }
        local count = 0
        if resultMseeage ~= "" then
            tbufStringTable = {
                ['err'] = 0
            }
            tbufSpecialTable = {
                ['err'] = 0
            }
            count = 0
            tbufStringTable, tbufSpecialTable = cuttingString(resultMseeage, tbufStringTable, tbufSpecialTable, count)

            for i = 0, #tbufStringTable do
                local colorIndex = tonumber(tbufSpecialTable[i])
                if colorIndex == nil then
                    colorIndex = 0
                end
                winMgr:getWindow("NM_Notify_LuaText"):addTextExtends(tbufStringTable[i], g_STRING_FONT_GULIM, 14,
                    tSpecialColorTable[colorIndex][0], tSpecialColorTable[colorIndex][1],
                    tSpecialColorTable[colorIndex][2], 255, 0, 255, 255, 255, 255)
            end
        end
    end
end

------------------------------------------------------------

-- Ȯ�ι�ư�� �ִ� �޼���(c�Լ� ȣ��)

------------------------------------------------------------
-- �˸�Ȯ�� �޼��� ���̱�
function NotifyMessageOKClicked()

    local winMgr = CEGUI.WindowManager:getSingleton()
    local root = winMgr:getWindow("DefaultWindow")
    local drawer = root:getDrawer()
    CEGUI.MouseCursor:getSingleton():show()

    winMgr:getWindow("NM_NotifyConfirmAlpha"):setVisible(false)
    winMgr:getWindow("NM_NotifyConfirmMain"):setVisible(false)
    winMgr:getWindow("NM_NotifyConfirmText"):setText("")
    okFunction = winMgr:getWindow("NM_NotifyConfirmAlpha"):getUserString('OKFunction');

    if ("nofunction" == okFunction) then
    else
        CallFunction(okFunction)
    end
end

function ShowNotifyYesNo(arg, argYesFunc, argNoFunc)
    ShowCommonAlertRejectBoxWithFunction('', arg, argYesFunc, argNoFunc)
end

-- �˸� Ȯ�� �޼��� ���߱�
function ShowNotifyOKMessage(message, okFunction)
    local winMgr = CEGUI.WindowManager:getSingleton()
    local root = winMgr:getWindow("DefaultWindow")
    local drawer = root:getDrawer()

    if (okFunction == nil) then
        okFunction = "nofunction"
    end

    if winMgr:getWindow("NM_NotifyConfirmAlpha") then
    else
        -- ��׶��� ���� �̹���
        mywindow = winMgr:createWindow("TaharezLook/StaticImage", "NM_NotifyConfirmAlpha")
        mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
        mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
        mywindow:setProperty("FrameEnabled", "False")
        mywindow:setProperty("BackgroundEnabled", "False")
        mywindow:setPosition(0, 0)
        mywindow:setSize(1920, 1200)
        mywindow:setVisible(false)
        mywindow:setAlwaysOnTop(true)
        mywindow:setZOrderingEnabled(false)
        root:addChildWindow(mywindow)

        -- ���� ����â
        errorwindow1 = winMgr:createWindow("TaharezLook/StaticImage", "NM_NotifyConfirmMain")
        errorwindow1:setTexture("Enabled", "UIData/popup001.tga", 0, 0)
        errorwindow1:setTexture("Disabled", "UIData/popup001.tga", 0, 0)
        errorwindow1:setProperty("FrameEnabled", "False")
        errorwindow1:setProperty("BackgroundEnabled", "False")
        errorwindow1:setWideType(6);
        errorwindow1:setPosition(338, 246)
        errorwindow1:setSize(346, 275)
        errorwindow1:setVisible(false)
        errorwindow1:setAlwaysOnTop(true)
        errorwindow1:setZOrderingEnabled(false)
        root:addChildWindow(errorwindow1)

        -- ���� ����â
        mywindow = winMgr:createWindow("TaharezLook/StaticText", "NM_NotifyConfirmText")
        mywindow:setProperty("FrameEnabled", "false")
        mywindow:setProperty("BackgroundEnabled", "false")
        mywindow:setTextColor(255, 255, 255, 255)
        mywindow:setFont(g_STRING_FONT_DODUM, 115)
        mywindow:setText("")
        mywindow:setPosition(60, 120)
        mywindow:setSize(250, 36)
        mywindow:setAlwaysOnTop(true)
        mywindow:setEnabled(false)
        errorwindow1:addChildWindow(mywindow)

        -- ���� Ȯ�ι�ư
        mywindow = winMgr:createWindow("TaharezLook/Button", "NM_NotifyConfirmOKButton")
        mywindow:setTexture("Normal", "UIData/popup001.tga", 693, 617)
        mywindow:setTexture("Hover", "UIData/popup001.tga", 693, 646)
        mywindow:setTexture("Pushed", "UIData/popup001.tga", 693, 675)
        mywindow:setTexture("PushedOff", "UIData/popup001.tga", 693, 617)
        mywindow:setSize(331, 29)
        mywindow:setPosition(4, 235)
        mywindow:setAlwaysOnTop(true)
        mywindow:subscribeEvent("Clicked", "NotifyMessageOKClicked")
        errorwindow1:addChildWindow(mywindow)

        -- ����, ESC ���
        RegistEnterEventInfo("NM_NotifyConfirmMain", "NotifyMessageOKClicked")
        RegistEscEventInfo("NM_NotifyConfirmMain", "NotifyMessageOKClicked")
    end

    winMgr:getWindow("NM_NotifyConfirmAlpha"):setUserString('OKFunction', okFunction)
    winMgr:getWindow("NM_NotifyConfirmAlpha"):setVisible(true)
    winMgr:getWindow("NM_NotifyConfirmMain"):setVisible(true)

    --[[
	local strSize = GetStringSize(g_STRING_FONT_DODUM, 115, message)
	if strSize > 320 then
		local msg1, msg2 = SplitString(message, 34)
		local msg = msg1 .. "\n" .. msg2
		
		strSize = GetStringSize(g_STRING_FONT_DODUM, 115, msg1)
		winMgr:getWindow("NM_NotifyConfirmText"):clearTextExtends()
		winMgr:getWindow("NM_NotifyConfirmText"):setPosition(173-(strSize/2), 116)
		winMgr:getWindow("NM_NotifyConfirmText"):setViewTextMode(1)
		winMgr:getWindow("NM_NotifyConfirmText"):setAlign(1)
		winMgr:getWindow("NM_NotifyConfirmText"):setLineSpacing(5)
		winMgr:getWindow("NM_NotifyConfirmText"):addTextExtends(msg, g_STRING_FONT_DODUM, 115, 255,255,255,255, 2, 0,0,0,255)
	else
		winMgr:getWindow("NM_NotifyConfirmText"):clearTextExtends()
		winMgr:getWindow("NM_NotifyConfirmText"):setPosition(173-(strSize/2), 132)
		winMgr:getWindow("NM_NotifyConfirmText"):setViewTextMode(1)
		winMgr:getWindow("NM_NotifyConfirmText"):setAlign(1)
		winMgr:getWindow("NM_NotifyConfirmText"):setLineSpacing(5)
		winMgr:getWindow("NM_NotifyConfirmText"):addTextExtends(message, g_STRING_FONT_DODUM, 115, 255,255,255,255, 2, 0,0,0,255)
	end
	--]]

    local i, j = string.find(message, "\n")
    if i ~= nil then
        local strSize = GetStringSize(g_STRING_FONT_DODUM, 115, message)
        winMgr:getWindow("NM_NotifyConfirmText"):clearTextExtends()
        winMgr:getWindow("NM_NotifyConfirmText"):setPosition(48, 110)
        winMgr:getWindow("NM_NotifyConfirmText"):setViewTextMode(1)
        winMgr:getWindow("NM_NotifyConfirmText"):setAlign(8)
        winMgr:getWindow("NM_NotifyConfirmText"):setLineSpacing(5)
        winMgr:getWindow("NM_NotifyConfirmText"):addTextExtends(message, g_STRING_FONT_DODUM, 115, 255, 255, 255, 255,
            2, 0, 0, 0, 255)
    else

        local strSize = GetStringSize(g_STRING_FONT_DODUM, 115, message)
        if strSize > 320 then
            local msg1, msg2 = SplitString(message, 34)
            local msg = msg1 .. "\n" .. msg2

            strSize = GetStringSize(g_STRING_FONT_DODUM, 115, msg1)
            winMgr:getWindow("NM_NotifyConfirmText"):clearTextExtends()
            winMgr:getWindow("NM_NotifyConfirmText"):setPosition(173 - (strSize / 2), 116)
            winMgr:getWindow("NM_NotifyConfirmText"):setViewTextMode(1)
            winMgr:getWindow("NM_NotifyConfirmText"):setAlign(1)
            winMgr:getWindow("NM_NotifyConfirmText"):setLineSpacing(5)
            winMgr:getWindow("NM_NotifyConfirmText"):addTextExtends(msg, g_STRING_FONT_DODUM, 115, 255, 255, 255, 255,
                2, 0, 0, 0, 255)
        else
            winMgr:getWindow("NM_NotifyConfirmText"):clearTextExtends()
            winMgr:getWindow("NM_NotifyConfirmText"):setPosition(173 - (strSize / 2), 132)
            winMgr:getWindow("NM_NotifyConfirmText"):setViewTextMode(1)
            winMgr:getWindow("NM_NotifyConfirmText"):setAlign(1)
            winMgr:getWindow("NM_NotifyConfirmText"):setLineSpacing(5)
            winMgr:getWindow("NM_NotifyConfirmText"):addTextExtends(message, g_STRING_FONT_DODUM, 115, 255, 255, 255,
                255, 2, 0, 0, 0, 255)
        end

    end
end

------------------------------------------------------------

-- �̺�Ʈ�� ����Ʈ ���� �˾�

------------------------------------------------------------
function NotifyEventPopupOKClicked()
    local winMgr = CEGUI.WindowManager:getSingleton()

    winMgr:getWindow("NM_EventMessageAlpha"):setVisible(false)
    winMgr:getWindow("NM_EventMessageMain"):setVisible(false)
    winMgr:getWindow("NM_EventMessageText1"):setVisible(false)
    winMgr:getWindow("NM_EventMessageText2"):setVisible(false)
end

function ShowEventOKPopup(flag)

    local winMgr = CEGUI.WindowManager:getSingleton()
    local root = winMgr:getWindow("DefaultWindow")
    local drawer = root:getDrawer()
    CEGUI.MouseCursor:getSingleton():show()
    if winMgr:getWindow("NM_EventMessageAlpha") then
    else

        -----------------------------------------------------------

        -- �Ϲ� �˸� �޼���

        -----------------------------------------------------------
        -- �̺�Ʈ �޼��� ���� �̹���
        mywindow = winMgr:createWindow("TaharezLook/StaticImage", "NM_EventMessageAlpha")
        mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
        mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
        mywindow:setProperty("FrameEnabled", "False")
        mywindow:setProperty("BackgroundEnabled", "False")
        mywindow:setPosition(0, 0)
        mywindow:setSize(1920, 1200)
        mywindow:setVisible(false)
        mywindow:setAlwaysOnTop(true)
        mywindow:setZOrderingEnabled(false)
        root:addChildWindow(mywindow)

        -- �̺�Ʈ �޼��� ����â
        eventpopupwindow = winMgr:createWindow("TaharezLook/StaticImage", "NM_EventMessageMain")
        eventpopupwindow:setTexture("Enabled", "UIData/other001.tga", 657, 0)
        eventpopupwindow:setTexture("Disabled", "UIData/other001.tga", 657, 0)
        eventpopupwindow:setProperty("FrameEnabled", "False")
        eventpopupwindow:setProperty("BackgroundEnabled", "False")
        eventpopupwindow:setWideType(6);
        eventpopupwindow:setPosition(338, 173)
        eventpopupwindow:setSize(367, 422)
        eventpopupwindow:setVisible(false)
        eventpopupwindow:setAlwaysOnTop(true)
        eventpopupwindow:setZOrderingEnabled(false)
        root:addChildWindow(eventpopupwindow)

        -- �̺�Ʈ �޼��� ����â
        mywindow = winMgr:createWindow("TaharezLook/StaticImage", "NM_EventMessageText1")
        mywindow:setTexture("Enabled", "UIData/other001.tga", 697, 446)
        mywindow:setTexture("Disabled", "UIData/other001.tga", 697, 446)
        mywindow:setProperty("FrameEnabled", "false")
        mywindow:setProperty("BackgroundEnabled", "false")
        mywindow:setPosition(214, 86)
        mywindow:setSize(119, 24)
        mywindow:setVisible(false)
        mywindow:setAlwaysOnTop(true)
        eventpopupwindow:addChildWindow(mywindow)

        -- �̺�Ʈ �޼��� ����â
        mywindow = winMgr:createWindow("TaharezLook/StaticImage", "NM_EventMessageText2")
        mywindow:setTexture("Enabled", "UIData/other001.tga", 697, 476)
        mywindow:setTexture("Disabled", "UIData/other001.tga", 697, 476)
        mywindow:setProperty("FrameEnabled", "false")
        mywindow:setProperty("BackgroundEnabled", "false")
        mywindow:setPosition(199, 253)
        mywindow:setSize(43, 35)
        mywindow:setVisible(false)
        mywindow:setAlwaysOnTop(true)
        eventpopupwindow:addChildWindow(mywindow)

        -- �̺�Ʈ �޼��� Ȯ�ι�ư
        mywindow = winMgr:createWindow("TaharezLook/Button", "NM_EventMessageOKButton")
        mywindow:setTexture("Normal", "UIData/popup001.tga", 864, 485)
        mywindow:setTexture("Hover", "UIData/popup001.tga", 864, 519)
        mywindow:setTexture("Pushed", "UIData/popup001.tga", 864, 553)
        mywindow:setTexture("PushedOff", "UIData/popup001.tga", 864, 485)
        mywindow:setPosition(150, 374)
        mywindow:setSize(80, 34)
        mywindow:setAlwaysOnTop(true)
        mywindow:subscribeEvent("Clicked", "NotifyEventPopupOKClicked")
        eventpopupwindow:addChildWindow(mywindow)

        -- ����, ESC ���
        RegistEnterEventInfo("NM_EventMessageMain", "NotifyEventPopupOKClicked")
        RegistEscEventInfo("NM_EventMessageMain", "NotifyEventPopupOKClicked")
    end

    if winMgr:getWindow("NM_EventMessageAlpha") then

        winMgr:getWindow("NM_EventMessageAlpha"):setVisible(true)
        winMgr:getWindow("NM_EventMessageMain"):setVisible(true)

        if flag == 1 then
            winMgr:getWindow("NM_EventMessageText1"):setVisible(true)
            winMgr:getWindow("NM_EventMessageText1"):setTexture("Enabled", "UIData/other001.tga", 697, 446)
            winMgr:getWindow("NM_EventMessageText2"):setVisible(true)
            winMgr:getWindow("NM_EventMessageText2"):setTexture("Enabled", "UIData/other001.tga", 697, 476)
        elseif flag == 2 then
            winMgr:getWindow("NM_EventMessageText1"):setVisible(true)
            winMgr:getWindow("NM_EventMessageText1"):setTexture("Enabled", "UIData/other001.tga", 819, 446)
            winMgr:getWindow("NM_EventMessageText2"):setVisible(true)
            winMgr:getWindow("NM_EventMessageText2"):setTexture("Enabled", "UIData/other001.tga", 745, 476)
        end
    end

end

------------------------------------------------------------

-- ���� �κ�, �������� �� á�� �� ������ �̺�Ʈâ

------------------------------------------------------------
function NotifyWarningPopupOKClicked()
    local winMgr = CEGUI.WindowManager:getSingleton()

    winMgr:getWindow("NM_WarningMessageAlpha"):setVisible(false)
    winMgr:getWindow("NM_WarningMessageMain"):setVisible(false)
end

function ShowWarningOKPopup()

    local winMgr = CEGUI.WindowManager:getSingleton()
    local root = winMgr:getWindow("DefaultWindow")
    local drawer = root:getDrawer()
    CEGUI.MouseCursor:getSingleton():show()
    if winMgr:getWindow("NM_WarningMessageAlpha") then
    else

        -----------------------------------------------------------

        -- �Ϲ� �˸� �޼���

        -----------------------------------------------------------
        -- �̺�Ʈ �޼��� ���� �̹���
        mywindow = winMgr:createWindow("TaharezLook/StaticImage", "NM_WarningMessageAlpha")
        mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
        mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
        mywindow:setProperty("FrameEnabled", "False")
        mywindow:setProperty("BackgroundEnabled", "False")
        mywindow:setPosition(0, 0)
        mywindow:setSize(1920, 1200)
        mywindow:setVisible(false)
        mywindow:setAlwaysOnTop(true)
        mywindow:setZOrderingEnabled(false)
        root:addChildWindow(mywindow)

        -- �̺�Ʈ �޼��� ����â
        Warningpopupwindow = winMgr:createWindow("TaharezLook/StaticImage", "NM_WarningMessageMain")
        Warningpopupwindow:setTexture("Enabled", "UIData/Match002.tga", 0, 667)
        Warningpopupwindow:setTexture("Disabled", "UIData/Match002.tga", 0, 667)
        Warningpopupwindow:setProperty("FrameEnabled", "False")
        Warningpopupwindow:setProperty("BackgroundEnabled", "False")
        Warningpopupwindow:setWideType(6);
        Warningpopupwindow:setPosition(346, 205)
        Warningpopupwindow:setSize(332, 357)
        Warningpopupwindow:setVisible(false)
        Warningpopupwindow:setAlwaysOnTop(true)
        Warningpopupwindow:setZOrderingEnabled(false)
        root:addChildWindow(Warningpopupwindow)

        -- �̺�Ʈ �޼��� Ȯ�ι�ư
        mywindow = winMgr:createWindow("TaharezLook/Button", "NM_WarningMessageOKButton")
        mywindow:setTexture("Normal", "UIData/Match002.tga", 332, 916)
        mywindow:setTexture("Hover", "UIData/Match002.tga", 332, 943)
        mywindow:setTexture("Pushed", "UIData/Match002.tga", 332, 970)
        mywindow:setTexture("PushedOff", "UIData/Match002.tga", 332, 997)
        mywindow:setPosition(126, 314)
        mywindow:setSize(81, 27)
        mywindow:setAlwaysOnTop(true)
        mywindow:subscribeEvent("Clicked", "NotifyWarningPopupOKClicked")
        Warningpopupwindow:addChildWindow(mywindow)

        -- ����, ESC ���
        RegistEnterEventInfo("NM_WarningMessageMain", "NotifyWarningPopupOKClicked")
        RegistEscEventInfo("NM_WarningMessageMain", "NotifyWarningPopupOKClicked")
    end

    if winMgr:getWindow("NM_WarningMessageAlpha") then

        winMgr:getWindow("NM_WarningMessageAlpha"):setVisible(true)
        winMgr:getWindow("NM_WarningMessageMain"):setVisible(true)
    end

end

function ConfirmInviteFunc()
    ConfirmInviteRankingLobby()
end

function CancelInviteFunc()
	LOG("Cancel test.")
	CancelInviteRankingLobby()
    winMgr:getWindow("FriendAlertAlphaImg"):setVisible(false)
end
