-----------------------------------------
-- Script Entry Point
-----------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)
root:activate()


g_GAME_WIN_SIZEX, g_GAME_WIN_SIZEY = GetCurrentResolution()





-- 케릭터에 관한정보 그리기(HP, SP ...)

--------------------------------------------------------------------
function WndCoinMatchGame_RenderNextUpgradeInfo
			( isEnable
			, nextUpgrade
			, needCoin
            , upgradeEffect
            )
        
            
         
         local startingX = 05
         local startingY = 92   
            
           drawer:drawTexture("UIData/GameNewImage2.tga", startingX, startingY, 155, 46, 869, 978)
       --  drawer:drawTexture("UIData/AutoMatch.tga", startingX, startingY, 150, 60, 534, 770)
       -- drawer:drawTexture("UIData/fightClub_005.tga", startingX + 6, startingY, 40, 50, 518, 622)
            
        drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
        
        
        if isEnable == 1 then
			drawer:setTextColor(255,204,50,255)   	  
		else		
			drawer:setTextColor(255,204,50,255)   		
		end
		
		local tttext = 'Power ' .. upgradeEffect .. '%↑'-- +  + "%"
        drawer:drawText(tttext,startingX +  58, startingY + 8 )
        
        
        if isEnable == 1 then
			drawer:setTextColor(0,255,255,255)           
		else		
			drawer:setTextColor(255,0,0,255)   		
		end
		
        drawer:drawText('Up.'..nextUpgrade,startingX +  58, startingY + 29 )
        
        
        --drawer:drawTexture("UIData/mail.tga", startingX + 90, startingY + 30, 14, 14, 974, 100)
        
        if isEnable == 1 then
			drawer:setTextColor(0,0,255,255)           
		else		
			drawer:setTextColor(255,0,0,255)   		
		end
		
		
        drawer:drawText(needCoin,startingX +  120, startingY + 29 )
        
        
        --drawer:drawText(upgradeEffect..%..,startingX +  60, startingY + 30 )
        
            	
    --   common_DrawOutlineText1(drawer, "fsdfsdfsdfsd", 100, 20, 0,0,0,255, r,g,b,255)
            	
          
	
end




