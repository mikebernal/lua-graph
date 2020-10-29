-- -----------------------------------------------------------------------------------
-- Global settings
-- -----------------------------------------------------------------------------------


-- -----------------------------------------------------------------------------------
-- Import libraries
-- -----------------------------------------------------------------------------------

local composer = require("composer")

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

-- -----------------------------------------------------------------------------------
--     Graph Container
-- -----------------------------------------------------------------------------------
    -- local graphContainer = display.newContainer(999, 999)
    local graphContainer = display.newGroup()
        graphContainer.x = 10
        graphContainer.y = 30
        graphContainer.actualContentWidth = 12
        graphContainer.actualContentHeight = 4

    local benignGroup    = display.newGroup()
    local maliciousGroup = display.newGroup()
    local zeroDaysGroup  = display.newGroup()

    local width  = display.actualContentWidth
    local height = display.actualContentHeight

    local benign    = {  -2.4, -2.7, -2.07, 2.37, -2.14, -2.63, 2.07, 2.18, 2.24, 2.52   }
    local malicious = {  2.52, 2.17, 2.36, -2.33, 2.45, 2.4, -2.14, -2.77, -2.51, -2.76  }
    local zeroDays  = { 0.25, 0.01, 0.22, 0.76, -0.54, -0.06, -0.33, -0.25, 1.73, -0.74  }

    local benignNetworkX   = {}
    local benignNetworkY   = {}
    local maliciousNetworkX = {}
    local maliciousNetworkY = {}
    local zeroDaysNetworkX  = {}
    local zeroDaysNetworkY  = {}

    local lDim = 10

    local funcTitle
    -- Point radius
    local radius = 2.4

    -- Graph x, y spacing
    local xPlot  = 27 
    local yPlot  = 115

    -- Graph point clearance
    local clearance = 35

    -- Invert points
    local invert = -1
    -- Render benign points, network
    local function plotBenign(i, point)
        local toPlot = display.newCircle( benignGroup, i * xPlot, ((point * clearance) * invert) + yPlot, radius )

        benignNetworkX[i] = i * xPlot
        benignNetworkY[i] = ((point * clearance) * invert) + yPlot
        if (i == 10) then 
            local star = display.newLine( benignGroup, benignNetworkX[1], benignNetworkY[1],  benignNetworkX[2], benignNetworkY[2])

            for i = 3, 10, 1 do
                star:append( benignNetworkX[i], benignNetworkY[i] )
            end

            star:setStrokeColor( 0, 0, 1, 1 )
            star.strokeWidth = 1
        end

        toPlot:setFillColor(0, 0, 1, 1)

    end

    -- Render malicious points, network
    local function plotMalicious(i, point)
        local toPlot = display.newCircle( maliciousGroup, i * xPlot, ((point * clearance) * invert) + yPlot, radius )

        maliciousNetworkX[i] = i * xPlot
        maliciousNetworkY[i] = ((point * clearance) * invert) + yPlot
        if (i == 10) then 
            local star = display.newLine( maliciousGroup, maliciousNetworkX[1], maliciousNetworkY[1],  maliciousNetworkX[2], maliciousNetworkY[2])

            for i = 3, 10, 1 do
                star:append( maliciousNetworkX[i], maliciousNetworkY[i] )
            end

            star:setStrokeColor( 1, 0, 0, 1 )
            star.strokeWidth = 1
        end

        toPlot:setFillColor(1, 0, 0, 1)
    end

    -- Render zero days points, network
    local function plotZeroDays(i, point)
        local toPlot = display.newCircle(  zeroDaysGroup, i * xPlot, ((point * clearance) * invert) + yPlot, radius )

        zeroDaysNetworkX[i] = i * xPlot
        zeroDaysNetworkY[i] = ((point * clearance) * invert) + yPlot
        if (i == 10) then 
            local star = display.newLine( zeroDaysGroup, zeroDaysNetworkX[1], zeroDaysNetworkY[1],  zeroDaysNetworkX[2], zeroDaysNetworkY[2])

            for i = 3, 10, 1 do
                star:append( zeroDaysNetworkX[i], zeroDaysNetworkY[i] )
            end

            star:setStrokeColor( 0, 1, 0, 1 )
            star.strokeWidth = 1
        end

        toPlot:setFillColor(0, 1, 0, 1)
    end

    -- DropDownMenu module
    local DDM = require "lib.DropDownMenu"
    local RowData = require "lib.RowData"

    -- Color DDM Row Data
    local mathFunction = { "default", "sin", "cos", "tan", "log10" }

    for i=1, #mathFunction do
        local rowData = RowData.new(mathFunction[i], {ID=i})
        mathFunction[i] = rowData
    end

    local function drawLines(i)
        local line = display.newLine( graphContainer, 0, i, 300, i )
        line:setStrokeColor( 0, 0, 0, 0.1 )
        line.strokeWidth = .89
    end

    local graphTitle = display.newText("", 0, 0, native.systemFont, 18)
        graphTitle.x = width - 155
        graphTitle.y = 20
        graphTitle:setFillColor(0.1, 0.1, 0.1)

    -- Callback function that will be called when a row is clicked.
    local function onRowSelected(name, rowData)
        if (name == "functionName") then
            funcTitle = rowData.value
            graphTitle.text = rowData.value
        end

        if (funcTitle == 'default') then
            print('default')

            -- if (benignGroup ~= nil and maliciousGroup ~= nil and zeroDaysGroup ~= nil) then
            --     display.remove(benignGroup)
            --     display.remove(maliciousGroup)
            --     display.remove(zeroDaysGroup)
            -- end

            for i = 1, 10, 1 do
                plotBenign(i, benign[i])
                plotMalicious(i, malicious[i])
                plotZeroDays(i, zeroDays[i])
            end


        elseif (funcTitle == 'sin') then
            print('sin')

        elseif (funcTitle == 'cos') then
            print('cos')
        
        elseif (funcTitle == 'tan') then
            print('tan')

        elseif (funcTitle == 'log10') then
            print('log10')

        else
            print('no selected')  

        end

    end

    -- Initializing the DropDownMenu object
    local colorDDM = DDM.new({
        name = "functionName",
        x = width - 160,
        y = height - 230,
        width = 295,
        height = 45,
        dataList = mathFunction,
        onRowSelected = onRowSelected
    })

    local options = {
        isModal = true,
        effect = "fade",
        time = 400,
    }

    -- STATIC ELEMENTS

    local function toggleMenu( event )
        if (event.phase == "ended") then
            composer.showOverlay("menu", options)
        end
    end

    local legends = display.newGroup()
        legends.y = 5

    -- Background
    local background = display.newRect(0, 0, width, height)
        background.x = width  * 0.5
        background.y = height * 0.4
        background:setFillColor(255, 255, 255)

    -- Screen title
    local title = display.newText("Home", 0, 0, native.systemFont, 18)
        title.x = width - 290
        title.y = -25
        title:setFillColor(0.1, 0.1, 0.1)

    -- Navigation button
    local navIcon = display.newText("Menu", 0, 0, native.systemFont, 18)
        navIcon.x = width - 30
        navIcon.y = -25
        navIcon:setFillColor(0.1, 0.1, 0.1)

    -- -----------------------------------------------------------------------------------
    --     Graph Points
    -- -----------------------------------------------------------------------------------

    -- Include the padding


    -- display.newRect( [parent,] x, y, width, height )
    local graph = display.newRect(0, 0, 300, 240)
        graph.anchorX = 0
        graph.anchorY = 0
        graph.strokeWidth = 1
        graph:setStrokeColor( 0, 0, 0, 0.1 )



    -- -----------------------------------------------------------------------------------
    --     Graph Legend
    -- -----------------------------------------------------------------------------------

    local benignLegend = display.newRect( 0, 0, lDim, lDim)
        benignLegend.x = 10
        benignLegend.y = 250
        benignLegend:setFillColor(0, 0, 255)

    local maliciousLegend = display.newRect( 0, 0, lDim, lDim)
        maliciousLegend.x = 10
        maliciousLegend.y = 265
        maliciousLegend:setFillColor(255, 0, 0)

    local zeroDaysLegend = display.newRect( 0, 0, lDim, lDim)
        zeroDaysLegend.x =  10
        zeroDaysLegend.y = 280
        zeroDaysLegend:setFillColor(0, 255, 0)

    -- Legend Label
    local benignLabel = display.newText( "Benign", 0, 0, native.systemFont, 11)
        benignLabel.x = 39
        benignLabel.y = 250
        benignLabel:setFillColor(0)

    local maliciousLabel = display.newText( "Malicious", 0, 0, native.systemFont, 11)
        maliciousLabel.x = 45
        maliciousLabel.y = 265
        maliciousLabel:setFillColor(0)

    local zeroDaysLabel = display.newText( "Zero Days", 0, 0, native.systemFont, 11)
        zeroDaysLabel.x = 48
        zeroDaysLabel.y = 280
        zeroDaysLabel:setFillColor(0)

    -- Groupings
    graphContainer:insert(graph)
    graphContainer:insert(legends)

    sceneGroup:insert(background)
    sceneGroup:insert(navIcon)
    sceneGroup:insert(title)
    sceneGroup:insert(graphContainer)
    sceneGroup:insert(graphTitle)
    sceneGroup:insert(colorDDM)

    legends:insert(benignLegend)
    legends:insert(maliciousLegend)
    legends:insert(zeroDaysLegend)

    legends:insert(benignLabel)
    legends:insert(maliciousLabel)
    legends:insert(zeroDaysLabel)
    
    graphContainer:insert(benignGroup )  
    graphContainer:insert(maliciousGroup)
    graphContainer:insert(zeroDaysGroup )
    -- -- Draw horiontal lines
    for i = 0, 240, clearance do
        drawLines(i)
    end

-- -----------------------------------------------------------------------------------
--     Event listeners
-- -----------------------------------------------------------------------------------

    navIcon:addEventListener("touch", toggleMenu)

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