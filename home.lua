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


local zeroDays  = { -2.76, 0.01, 0.22, 0.76, -0.54, -0.06, -0.33, -0.25, 1.73, -0.74 }
local benign    = {  -2.4, -2.7, -2.07, 2.37, -2.14, -2.63, 2.07, 2.18, 2.24, 2.52   }
local malignant = {  2.52, 2.17, 2.36, -2.33, 2.45, 2.4, -2.14, -2.77, -2.51, -2.76  }

-- local webView = native.newWebView( 200, 200, 200, 480 )
-- webView:request( "test.html", system.ResourceDirectory )

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

    local options = {
        isModal = true,
        effect = "fade",
        time = 400,
    }

    -- STATIC ELEMENTS

    local function toggleMenu( event )
        if (event.phase == "ended") then
            print("go to menu")
            composer.showOverlay("menu", options)
        end
    end

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
    local graphTitle = display.newText(sceneGroup, "", 0, 0, native.systemFont, 18)
        graphTitle.x = width - 155
        graphTitle.y = 20
        graphTitle:setFillColor(0.1, 0.1, 0.1)

    -- DropDownMenu module
    local DDM = require "lib.DropDownMenu"
    local RowData = require "lib.RowData"

    -- Color DDM Row Data
    local mathFunction = { "default", "sin", "cos", "tan", "log10" }

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
        x = width - 160,
        y = height - 270,
        width = 295,
        height = 45,
        dataList = mathFunction,
        onRowSelected = onRowSelected
    })

-- -----------------------------------------------------------------------------------
--     Graph Container
-- -----------------------------------------------------------------------------------

    -- Include the padding
    local graphContainer = display.newContainer(999, 999)
    graphContainer.x = 10
    graphContainer.y = 30

    -- display.newRect( [parent,] x, y, width, height )
    local graph = display.newRect(0, 0, 300, 240)
        graph.anchorX = 0
        graph.anchorY = 0
        graph.strokeWidth = 1
        graph:setStrokeColor( 0.1 )

    -- local blueBox = display.newRect( 0, 0, 300, 10 )
    --     blueBox:setFillColor( 0, 0, 1, 0.8 )
    --     blueBox.anchorX = 0
    --     blueBox.anchorY = 0

    -- local redBox = display.newRect( 0, 10, 300, 10 )
    --     redBox:setFillColor( 1, 0, 0, 0.8 )
    --     redBox.anchorX = 0
    --     redBox.anchorY = 0




    -- Groupings
    graphContainer:insert(graph)
    -- graphContainer:insert(blueBox)
    -- graphContainer:insert(redBox)


    sceneGroup:insert(background)
    sceneGroup:insert(navIcon)
    sceneGroup:insert(title)
    sceneGroup:insert(graphContainer)
    sceneGroup:insert(graphTitle)
    sceneGroup:insert(colorDDM)
    

    local function drawLines(i)
        local star = display.newLine( 0, i, 300, i )
        star:setStrokeColor( 0, 0, 0, 0.1 )
        star.strokeWidth = .89
        graphContainer:insert(star)

    end

    for i = 10, 240, 10 do
        -- draw lines
        print(i)
        drawLines(i)
    end


    -- Event listeners
    navIcon:addEventListener("touch", toggleMenu)

    -- Plot points
    -- display.newCircle( [parent,] xCenter, yCenter, radius )
    -- Top left origin xmin = 0, xmax= 300, ymin = 0, ymax = 240
    local pointA = display.newCircle(300, 240, 2 )
    pointA:setFillColor(1, 0, 0, 1)

    local pointB = display.newCircle(0, 0, 2 )
    pointB:setFillColor(1, 0, 0, 1)

    graphContainer:insert(pointA)
    graphContainer:insert(pointB)



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