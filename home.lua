local composer = require( "composer" )
local widget = require( "widget" )
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
display.setDefault( "anchorX", 0 )
display.setDefault( "anchorY", 0 )

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )

    -- define the function
    function f(x) return math.sin(x) * x^2 end


    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    local graphContainer = display.newContainer(320, 240)

    local redBox = display.newImage("300x240.png")
        redBox:setFillColor( 1, 0, 0, 0.8 )

        graphContainer:insert(redBox, true)
    
    local greenBox = display.newRect(graphContainer, 0, 0, 80, 80)
        greenBox:setFillColor(0, 1, 0)
    
    local blueBox = display.newRect(graphContainer, 0, 0, 40, 40)
        blueBox:setFillColor(0, 0, 1)


    -- Groupings 

    graphContainer.anchorChildren = false
    
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