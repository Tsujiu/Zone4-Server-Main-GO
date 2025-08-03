-----------------------------------------
-- Script Entry Point
-----------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local schemeMgr = CEGUI.SchemeManager:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)



--[[
--------------------------------------------------------------------

-- 방만들기 팝업창

--------------------------------------------------------------------
-- 백그라운드 알파 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "방만들기 알파창")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 0)
mywindow:setSize(1024, 768)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)


-- 방만들기 셋팅창
makeroomwindow = winMgr:createWindow("TaharezLook/StaticImage", "방만들기 셋팅창")
makeroomwindow:setTexture("Enabled", "UIData/createquestpopup001.tga", 376, 435)
makeroomwindow:setTexture("Disabled", "UIData/createquestpopup001.tga", 376, 435)
makeroomwindow:setProperty("FrameEnabled", "False")
makeroomwindow:setProperty("BackgroundEnabled", "False")
makeroomwindow:setPosition(350, 200)
makeroomwindow:setSize(347, 445)
makeroomwindow:setVisible(false)
makeroomwindow:setAlwaysOnTop(true)
makeroomwindow:setZOrderingEnabled(false)
root:addChildWindow(makeroomwindow)


-- 방만들기 확인, 방만들기 취소버튼
tMakeBattleRoomName  = { ["protecterr"]=0, "방만들기 확인버튼", "방만들기 취소버튼" }
tMakeBattleRoomTexX	 = { ["protecterr"]=0, 349, 429 }
tMakeBattleRoomPosX	 = { ["protecterr"]=0, 165, 248 }
tMakeBattleRoomEvent = { ["protecterr"]=0, "MakeRoom_OK", "MakeRoom_CANCEL" }

for i=1, 2 do
	mywindow = winMgr:createWindow("TaharezLook/Button", tMakeBattleRoomName[i])
	mywindow:setTexture("Normal", "UIData/mainBG_Button001.tga", tMakeBattleRoomTexX[i], 392)
	mywindow:setTexture("Hover", "UIData/mainBG_Button001.tga", tMakeBattleRoomTexX[i], 426)
	mywindow:setTexture("Pushed", "UIData/mainBG_Button001.tga", tMakeBattleRoomTexX[i], 460)
	mywindow:setTexture("PushedOff", "UIData/mainBG_Button001.tga", tMakeBattleRoomTexX[i], 392)
	mywindow:setPosition(tMakeBattleRoomPosX[i], 268)
	mywindow:setSize(80, 34)
	mywindow:setAlwaysOnTop(true)
	mywindow:subscribeEvent("Clicked", tMakeBattleRoomEvent[i])
	makeroomwindow:addChildWindow(mywindow)
end



function MakeRoom_OK()
	MakeRoom_CANCEL()
	
	roomPassword = winMgr:getWindow("방생성_비밀번호"):getText()	
	WndQuestLobby_createRoom(tQuestListList[listIndex][roomCreate_currentquestIndex], roomCreate_difficult, roomCreate_userCount, roomPassword)
end



function MakeRoom_CANCEL()
	winMgr:getWindow("방만들기 알파창"):setVisible(false)
	winMgr:getWindow("방만들기 셋팅창"):setVisible(false)
	
	-- 방만들기를 완성하면 채팅창을 활성화 시킨다
	winMgr:getWindow("채팅하기"):setEnabled(true)
end




--------------------------------------------------------------------

-- 퀘스트룸 만들기 5개 정보
--------------------------------------------------------------------

-- 1. 퀘스트 제목
mywindow = winMgr:createWindow("TaharezLook/StaticText", "퀘스트 제목")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(0, 0, 0, 255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setPosition(130, 60)
mywindow:setSize(40, 14)
mywindow:setZOrderingEnabled(false)
makeroomwindow:addChildWindow(mywindow)

function QuestTitie()
	name = WndQuestLobby_GetQuestInfo(tQuestListList[listIndex][roomCreate_currentquestIndex])
	winMgr:getWindow("퀘스트 제목"):setText(name)
end




-- 2. 퀘스트 번호
for i=1, table.getn(tQuestListList[listIndex]) do

	width = 39
	widthgab = 42	

	mywindow = winMgr:createWindow("TaharezLook/RadioButton", i .. "번 방만들기 퀘스트")
	mywindow:setTexture("Normal", "UIData/questlobby001.tga", 672 + width* (i - 1), 152)
	mywindow:setTexture("Hover", "UIData/questlobby001.tga",  672 + width* (i - 1), 194)
	mywindow:setTexture("Pushed", "UIData/questlobby001.tga",  672 + width* (i - 1), 236)
	mywindow:setTexture("PushedOff", "UIData/questlobby001.tga", 672 + width* (i - 1), 194)
	mywindow:setTexture("SelectedNormal", "UIData/questlobby001.tga" ,672 + width* (i - 1), 194)
	mywindow:setTexture("SelectedHover", "UIData/questlobby001.tga" , 672 + width* (i - 1), 194)
	mywindow:setTexture("SelectedPushed", "UIData/questlobby001.tga",  672 + width* (i - 1), 236)
	mywindow:setTexture("SelectedPushedOff", "UIData/questlobby001.tga",  672 + width* (i - 1), 194)
	mywindow:setPosition(26 + widthgab * (i - 1), 90)
	mywindow:setSize(width, 42)
	mywindow:setProperty("GroupID", 400)
	
	if( i == currentquestIndex ) then	
		mywindow:setProperty("Selected", "true")
	else
		mywindow:setProperty("Selected", "false")
	end
		
	mywindow:setUserString( "QuestIndex", i )
	mywindow:subscribeEvent("SelectStateChanged","WndQuestLobby_RoomCreate_QuestSelectChanged")
	makeroomwindow:addChildWindow(mywindow)
end


function WndQuestLobby_RoomCreate_QuestSelectChanged(args)
	currentquestIndex = tonumber( CEGUI.toWindowEventArgs(args).window:getUserString( "QuestIndex" ))
end




-- 3. 난이도
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "퀘스트 난이도")
mywindow:setTexture("Enabled", "UIData/questlobby001.tga", 592, 189)
mywindow:setTexture("Disabled", "UIData/questlobby001.tga", 592, 189)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(178, 143)
mywindow:setSize(80, 24)
mywindow:setZOrderingEnabled(false)
makeroomwindow:addChildWindow(mywindow)

--퀘스트 난이도 왼쪽 버턴
mywindow = winMgr:createWindow("TaharezLook/Button", "방생성_난이도왼쪽")
mywindow:setPosition(128, 140)
mywindow:setSize(28, 30)
mywindow:setTexture("Normal", "UIData/questlobby001.tga", 962 , 17)
mywindow:setTexture("Hover", "UIData/questlobby001.tga",  962, 47)
mywindow:setTexture("Pushed", "UIData/questlobby001.tga",  962, 77)
mywindow:setTexture("PushedOff", "UIData/questlobby001.tga", 962 , 107)
mywindow:subscribeEvent("Clicked", "WndQuestLobby_RoomCreate_DifficultLeftClicked")
makeroomwindow:addChildWindow(mywindow)


--퀘스트 난이도 오른쪽 버턴
mywindow = winMgr:createWindow("TaharezLook/Button", "방생성_난이도오른쪽")
mywindow:setPosition(278, 140)
mywindow:setSize(28, 30)
mywindow:setTexture("Normal", "UIData/questlobby001.tga", 990 , 17)
mywindow:setTexture("Hover", "UIData/questlobby001.tga",  990, 47)
mywindow:setTexture("Pushed", "UIData/questlobby001.tga",  990, 77)
mywindow:setTexture("PushedOff", "UIData/questlobby001.tga", 990 , 107)
mywindow:subscribeEvent("Clicked", "WndQuestLobby_RoomCreate_DifficultRightClicked")
makeroomwindow:addChildWindow(mywindow)


function WndQuestLobby_RoomCreate_DifficultLeftClicked()

	if( roomCreate_difficult == 0 ) then
		roomCreate_difficult = 2
	else
		roomCreate_difficult = roomCreate_difficult - 1
	end
	
	ChangeDifficult()
end


function WndQuestLobby_RoomCreate_DifficultRightClicked()
	
	if( roomCreate_difficult == 2 ) then
		roomCreate_difficult = 0
	else
		roomCreate_difficult = roomCreate_difficult + 1
	end
	
	ChangeDifficult()
end


function ChangeDifficult()
	winMgr:getWindow("퀘스트 난이도"):setTexture("Enabled", "UIData/questlobby001.tga", 592, 189+(roomCreate_difficult*24))
end





-- 4. 인원
mywindow = winMgr:createWindow("TaharezLook/StaticText", "방생성_인원설정")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(0, 0, 0, 255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setText("2 명")
mywindow:setPosition(202, 182)
mywindow:setSize(40, 20)
mywindow:setZOrderingEnabled(false)
makeroomwindow:addChildWindow(mywindow)


--인원 왼쪽 버턴
mywindow = winMgr:createWindow("TaharezLook/Button", "방생성_인원왼쪽")
mywindow:setPosition(128, 178)
mywindow:setSize(28, 30)
mywindow:setTexture("Normal", "UIData/questlobby001.tga", 962 , 17)
mywindow:setTexture("Hover", "UIData/questlobby001.tga",  962, 47)
mywindow:setTexture("Pushed", "UIData/questlobby001.tga",  962, 77)
mywindow:setTexture("PushedOff", "UIData/questlobby001.tga", 962 , 107)
mywindow:subscribeEvent("Clicked", "WndQuestLobby_RoomCreate_UserCountLeftClicked")
makeroomwindow:addChildWindow(mywindow)


--인원 오른쪽 버턴
mywindow = winMgr:createWindow("TaharezLook/Button", "방생성_인원오른쪽")
mywindow:setPosition(278, 178)
mywindow:setSize(28, 30)
mywindow:setTexture("Normal", "UIData/questlobby001.tga", 990 , 17)
mywindow:setTexture("Hover", "UIData/questlobby001.tga",  990, 47)
mywindow:setTexture("Pushed", "UIData/questlobby001.tga",  990, 77)
mywindow:setTexture("PushedOff", "UIData/questlobby001.tga", 990 , 107)
mywindow:subscribeEvent("Clicked", "WndQuestLobby_RoomCreate_UserCountRightClicked")
makeroomwindow:addChildWindow(mywindow)


function WndQuestLobby_RoomCreate_UserCountLeftClicked()
	
	if( roomCreate_userCount == 1 ) then
		roomCreate_userCount = 4
	else
		roomCreate_userCount = roomCreate_userCount -1
	end
	
	ChangeUserCount()
end


function WndQuestLobby_RoomCreate_UserCountRightClicked()
		
	if( roomCreate_userCount == 4 ) then	
		roomCreate_userCount = 1
	else
		roomCreate_userCount = roomCreate_userCount + 1
	end
	
	ChangeUserCount()
end


function ChangeUserCount()
	winMgr:getWindow("방생성_인원설정"):setText(roomCreate_userCount .. " 명")
end





-- 5. 비밀번호
mywindow = winMgr:createWindow("TaharezLook/Editbox", "방생성_비밀번호")
mywindow:setText("")
mywindow:setPosition(161, 220)
mywindow:setSize(113,24)	
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
makeroomwindow:addChildWindow(mywindow)
CEGUI.toEditbox(winMgr:getWindow("방생성_비밀번호")):setMaxTextLength(6)








--------------------------------------------------------------------

-- 에러메세지(C에서 호출)

--------------------------------------------------------------------
-- 백그라운드 알파 이미지
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "퀘스트룸 에러 알파창")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 0)
mywindow:setSize(1024, 768)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)


-- 에러 보일창
errorwindow = winMgr:createWindow("TaharezLook/StaticImage", "퀘스트룸 에러 보일창")
errorwindow:setTexture("Enabled", "UIData/mainBG_Button001.tga", 0, 392)
errorwindow:setTexture("Disabled", "UIData/mainBG_Button001.tga", 0, 392)
errorwindow:setProperty("FrameEnabled", "False")
errorwindow:setProperty("BackgroundEnabled", "False")
errorwindow:setPosition(350, 246)
errorwindow:setSize(349, 276)
errorwindow:setVisible(false)
errorwindow:setAlwaysOnTop(true)
errorwindow:setZOrderingEnabled(false)
root:addChildWindow(errorwindow)

-- 에러 내용창
mywindow = winMgr:createWindow("TaharezLook/StaticText", "퀘스트룸 에러 내용창")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255, 255, 255, 255)
mywindow:setFont(g_STRING_FONT_GULIM, 14)
mywindow:setText("")
mywindow:setPosition(60, 110)
mywindow:setSize(170, 36)
mywindow:setAlwaysOnTop(true)
errorwindow:addChildWindow(mywindow)

-- 에러 확인버튼
mywindow = winMgr:createWindow("TaharezLook/Button", "퀘스트룸 에러 확인버튼")
mywindow:setTexture("Normal", "UIData/mainBG_Button001.tga",349, 392)
mywindow:setTexture("Hover", "UIData/mainBG_Button001.tga", 349, 426)
mywindow:setTexture("Pushed", "UIData/mainBG_Button001.tga", 349, 460)
mywindow:setTexture("PushedOff", "UIData/mainBG_Button001.tga", 349, 494)
mywindow:setPosition(245, 236)
mywindow:setSize(80, 34)
mywindow:setAlwaysOnTop(true)
mywindow:subscribeEvent("Clicked", "WndQuestRoomErrorOK")
errorwindow:addChildWindow(mywindow)

function WndQuestRoomErrorOK()
	winMgr:getWindow("퀘스트룸 에러 알파창"):setVisible(false)
	winMgr:getWindow("퀘스트룸 에러 보일창"):setVisible(false)
	winMgr:getWindow("퀘스트룸 에러 내용창"):setPosition(60, 110)
	winMgr:getWindow("퀘스트룸 에러 내용창"):setText("")
	
	-- 에러OK를 누르면 채팅창을 활성화 시킨다
	winMgr:getWindow("채팅하기"):setEnabled(true)
end

function WndQuestRoom_WarningMessage(errorMessgae)
	winMgr:getWindow("퀘스트룸 에러 알파창"):setVisible(true)
	winMgr:getWindow("퀘스트룸 에러 보일창"):setVisible(true)
	
	-- 28글자까지 1줄
	if string.len(errorMessgae) <= 20 then
		winMgr:getWindow("퀘스트룸 에러 내용창"):setPosition(100, 110)
	elseif 34 <= string.len(errorMessgae) and string.len(errorMessgae) <= 38 then
		winMgr:getWindow("퀘스트룸 에러 내용창"):setPosition(30, 110)
	elseif 38 < string.len(errorMessgae) and string.len(errorMessgae) < 44 then
		winMgr:getWindow("퀘스트룸 에러 내용창"):setPosition(16, 110)
	end
	winMgr:getWindow("퀘스트룸 에러 내용창"):setText(errorMessgae)
end

--]]