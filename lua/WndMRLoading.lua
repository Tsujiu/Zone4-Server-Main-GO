--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)



-- 로딩시에 배경이미지
function WndMRLoading_RenderBackImage(bItem)
	if bItem == 0 then
		drawer:drawTexture("UIData/WndLoadingImage_new.dds", 0, 0, 1024, 768, 0, 0)
	else
		drawer:drawTexture("UIData/WndLoadingImage_new2.dds", 0, 0, 1024, 768, 0, 0)
	end
end





-- 케릭터 로딩 퍼센트
function WndMRLoading_RenderCharacter(index, name, percent)
	drawer:setTextColor(255, 255, 255, 255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 14)
	for i=0, index do
		common_DrawOutlineText2(drawer, name, 45, 490 + (index * 20), 0,0,0,255, 255,255,255,255)
		common_DrawOutlineText2(drawer, percent .. " %", 200, 490 + (index * 20), 0,0,0,255, 255,255,255,255)
	end
end