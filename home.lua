-- -----------------------------------------------------------------------------------
-- Global settings
-- -----------------------------------------------------------------------------------


-- -----------------------------------------------------------------------------------
-- Import libraries
-- -----------------------------------------------------------------------------------

local composer = require("composer")
local widget   = require("widget")

-- -----------------------------------------------------------------------------------
-- Local settings
-- -----------------------------------------------------------------------------------

local scene = composer.newScene()

-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    
    -- Screen dimension 
    local width  = display.actualContentWidth
    local height = display.actualContentHeight

    -- Background
    local background = display.newRect(sceneGroup, 0, 0, width, height)
      background.x = width  * 0.5
      background.y = height * 0.4
      background:setFillColor(255, 255, 255)

    -- Screen title
    local title = display.newText(sceneGroup, "Home", 0, 0, native.systemFont, 18)
        title.x = width - 290
        title.y = -25
        title:setFillColor(0.1, 0.1, 0.1)

    -- Navigation button
    local navIcon = display.newText(sceneGroup, "Menu", 0, 0, native.systemFont, 18)
        navIcon.x = width - 30
        navIcon.y = -25
        navIcon:setFillColor(0.1, 0.1, 0.1)

    -- Graph placeholder
    local graph = display.newImageRect(sceneGroup, "300.png", 300, 300)
        graph.x = width * 0.5
        graph.y = 200


 
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen

    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene