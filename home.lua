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

    local funcTitle

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

    -- Function name
    local graphTitle = display.newText(sceneGroup, "Function Name", 0, 0, native.systemFont, 18)
        graphTitle.x = width - 155
        graphTitle.y = 20
        graphTitle:setFillColor(0.1, 0.1, 0.1)

    -- Graph placeholder
    local graph = display.newImageRect(sceneGroup, "300x240.png", 300, 240)
        graph.x = width * 0.5
        graph.y = 150

    -- DropDownMenu module
    local DDM = require "lib.DropDownMenu"
    local RowData = require "lib.RowData"

    -- Color DDM Row Data
    local mathFunction = {"sin", "cos", "tan", "log10"}
    for i=1, #mathFunction do
        local rowData = RowData.new(mathFunction[i], {ID=i})
        mathFunction[i] = rowData
    end

    -- Callback function that will be called when a row is clicked.
    local function onRowSelected(name, rowData)
        if (name == "functionName") then
            -- print("Transformation function is " .. rowData.value)
            funcTitle = rowData.value
            print("function is " .. funcTitle)
            graphTitle.text = rowData.value

        end
    end

    -- Initializing the DropDownMenu object
    local colorDDM = DDM.new({
        name = "functionName",
        x = 10,
        y = width - 40,
        width = 300,
        height = 45,
        dataList = mathFunction,
        onRowSelected = onRowSelected
    })
 
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