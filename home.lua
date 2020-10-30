-- -----------------------------------------------------------------------------------
-- Import libraries
-- -----------------------------------------------------------------------------------

local composer = require("composer")

-- Third party libraries
local DDM     = require "lib.DropDownMenu"
local RowData = require "lib.RowData"

-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
-- Variable initalization
-- -----------------------------------------------------------------------------------
local scene = composer.newScene()

-- Screen dimension
local width  = display.actualContentWidth
local height = display.actualContentHeight

-- Dataset
local benign    = { -2.4, -2.7, -2.07, 2.37, -2.14, -2.63, 2.07, 2.18, 2.24,   2.52  }
local malicious = { 2.52, 2.17, 2.36, -2.33, 2.45, 2.4, -2.14, -2.77, -2.51,  -2.76  }
local zeroDays  = { 0.25, 0.01, 0.22, 0.76, -0.54, -0.06, -0.33, -0.25, 1.73, -0.74  }

-- Node points
local benignNetworkX    = {}
local benignNetworkY    = {}
local maliciousNetworkX = {}
local maliciousNetworkY = {}
local zeroDaysNetworkX  = {}
local zeroDaysNetworkY  = {}

-- Graph coordinates
local lDim      = 10
local radius    = 2.4
local xPlot     = 27 
local yPlot     = 115
local clearance = 35
local invert    = -1

local benignToPlot
local maliciousToPlot
local zeroDaysToPlot

-- UI elements
local background
local title
local navIcon
local graphTitle
local graph
local benignLegend
local maliciousLegend
local zeroDaysLegend
local benignLabel
local maliciousLabel
local zeroDaysLabel
local colorDDM
local mathFunction = { "default", "sin", "cos", "tan", "log10" }
local options      = { isModal = true, effect = "fade", time = 400 }

-- Groups
local graphContainer
local benignGroup   
local maliciousGroup
local zeroDaysGroup 
local legends

local benignNode
local maliciousNode
local zeroDaysNode

-- -----------------------------------------------------------------------------------
-- Function definition
-- -----------------------------------------------------------------------------------

-- Display screen menu
function toggleMenu( event )

    if (event.phase == "ended") then
        composer.showOverlay("menu", options)
    end

end

-- Render benign points and network
function plotBenign(i, point)

    benignGroup  = display.newGroup()
    -- Bug
    benignToPlot = display.newCircle( benignGroup, i * xPlot, ((point * clearance) * invert) + yPlot, radius )
     benignToPlot:setFillColor(0, 0, 1, 1)

    benignNetworkX[i] = i * xPlot
    benignNetworkY[i] = ((point * clearance) * invert) + yPlot

    if (i == 10) then 
        benignNode = display.newLine( benignGroup, benignNetworkX[1], benignNetworkY[1],  benignNetworkX[2], benignNetworkY[2])
            benignNode:setStrokeColor( 0, 0, 1, 1 )
            benignNode.strokeWidth = 1

        for i = 3, 10, 1 do
            benignNode:append( benignNetworkX[i], benignNetworkY[i] )
        end

    end

    graphContainer:insert(benignGroup)

end

-- Render malicious points and network
function plotMalicious(i, point)

    maliciousGroup  = display.newGroup()
    MaliciousToPlot = display.newCircle( maliciousGroup, i * xPlot, ((point * clearance) * invert) + yPlot, radius )
        MaliciousToPlot:setFillColor(1, 0, 0, 1)

    maliciousNetworkX[i] = i * xPlot
    maliciousNetworkY[i] = ((point * clearance) * invert) + yPlot

    if (i == 10) then 
        maliciousNode = display.newLine( maliciousGroup, maliciousNetworkX[1], maliciousNetworkY[1],  maliciousNetworkX[2], maliciousNetworkY[2])
            maliciousNode:setStrokeColor( 1, 0, 0, 1 )
            maliciousNode.strokeWidth = 1

        for i = 3, 10, 1 do
            maliciousNode:append( maliciousNetworkX[i], maliciousNetworkY[i] )
        end

    end

    graphContainer:insert(maliciousGroup)

end

-- Render zero days points and network
function plotZeroDays(i, point)

    zeroDaysGroup  = display.newGroup()
    zeroDaysToPlot = display.newCircle(  zeroDaysGroup, i * xPlot, ((point * clearance) * invert) + yPlot, radius )
        zeroDaysToPlot:setFillColor(0, 1, 0, 1)

    zeroDaysNetworkX[i] = i * xPlot
    zeroDaysNetworkY[i] = ((point * clearance) * invert) + yPlot

    if (i == 10) then 
        zeroDaysNode = display.newLine( zeroDaysGroup, zeroDaysNetworkX[1], zeroDaysNetworkY[1],  zeroDaysNetworkX[2], zeroDaysNetworkY[2])
            zeroDaysNode:setStrokeColor( 0, 1, 0, 1 )
            zeroDaysNode.strokeWidth = 1

        for i = 3, 10, 1 do
            zeroDaysNode:append( zeroDaysNetworkX[i], zeroDaysNetworkY[i] )
        end

    end

    graphContainer:insert(zeroDaysGroup)

end

-- List transformation function
function listFunctions()

    for i=1, #mathFunction do
        local rowData = RowData.new(mathFunction[i], {ID=i})
        mathFunction[i] = rowData
    end

end

function removePlots() 
    if (benignGroup ~= nil and maliciousGroup ~= nil and zeroDaysGroup ~= nil) then
        display.remove(benignGroup)
        display.remove(maliciousGroup)
        display.remove(zeroDaysGroup)
    end
end

-- Callback function that will be called when a row is clicked.
function onRowSelected(name, rowData)

    if (name == "functionName") then
        graphTitle.text = rowData.value
    end

    if (graphTitle.text == 'default') then
        print('default')

         removePlots()

        for i = 1, 10, 1 do
            plotBenign(i, benign[i])
            plotMalicious(i, malicious[i])
            plotZeroDays(i, zeroDays[i])
        end

    elseif (graphTitle.text == 'sin') then
        print('sin')
        
        removePlots()

        for i = 1, 10, 1 do
            plotBenign(i, math.sin(benign[i]))
            plotMalicious(i, math.sin(malicious[i]))
            plotZeroDays(i, math.sin(zeroDays[i]))
        end

    elseif (graphTitle.text == 'cos') then
        print('cos')

        removePlots()

        for i = 1, 10, 1 do
            plotBenign(i, math.cos(benign[i]))
            plotMalicious(i, math.cos(malicious[i]))
            plotZeroDays(i, math.cos(zeroDays[i]))
        end
    
    elseif (graphTitle.text == 'tan') then
        print('tan')

        removePlots()

        for i = 1, 10, 1 do
            plotBenign(i, math.tan(benign[i]))
            plotMalicious(i, math.tan(malicious[i]))
            plotZeroDays(i, math.tan(zeroDays[i]))
        end

    elseif (graphTitle.text == 'log10') then
        print('log10')

        removePlots()

        for i = 1, 10, 1 do
            plotBenign(i, math.log10(benign[i]))
            plotMalicious(i, math.log10(malicious[i]))
            plotZeroDays(i, math.log10(zeroDays[i]))
        end
    else
        print('no selected')  

    end

end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    -- -----------------------------------------------------------------------------------
    -- Instantiation
    -- -----------------------------------------------------------------------------------

    -- Group 
    graphContainer = display.newGroup()
        graphContainer.x = 10
        graphContainer.y = 30
        graphContainer.actualContentWidth  = 12
        graphContainer.actualContentHeight = 4
        
    legends = display.newGroup()
        legends.y = 5

    local function drawLines(i)
        local line = display.newLine( graphContainer, 0, i, 300, i )
        line:setStrokeColor( 0, 0, 0, 0.1 )
        line.strokeWidth = .89
    end

    colorDDM = DDM.new({
        name          = "functionName",
        x             = width  - 160,
        y             = height - 230,
        width         = 295,
        height        = 45,
        dataList      = mathFunction,
        onRowSelected = onRowSelected
    })

    background = display.newRect(sceneGroup, 0, 0, width, height)
        background.x = width  * 0.5
        background.y = height * 0.4
        background:setFillColor(255, 255, 255)

    title = display.newText(sceneGroup, "Home", 0, 0, native.systemFont, 18)
        title.x = width - 290
        title.y = -25
        title:setFillColor(0.1, 0.1, 0.1)

    navIcon = display.newText(sceneGroup, "Menu", 0, 0, native.systemFont, 18)
        navIcon.x = width - 30
        navIcon.y = -25
        navIcon:setFillColor(0.1, 0.1, 0.1)

    graphTitle = display.newText(sceneGroup, "", 0, 0, native.systemFont, 18)
        graphTitle.x = width - 155
        graphTitle.y = 20
        graphTitle:setFillColor(0.1, 0.1, 0.1)

    graph = display.newRect(graphContainer, 0, 0, 300, 240)
        graph.anchorX = 0
        graph.anchorY = 0
        graph.strokeWidth = 1
        graph:setStrokeColor( 0, 0, 0, 0.1 )

    benignLegend = display.newRect( legends, 0, 0, lDim, lDim)
        benignLegend.x = 10
        benignLegend.y = 250
        benignLegend:setFillColor(0, 0, 255)

    maliciousLegend = display.newRect( legends, 0, 0, lDim, lDim)
        maliciousLegend.x = 10
        maliciousLegend.y = 265
        maliciousLegend:setFillColor( 255, 0, 0)

    zeroDaysLegend = display.newRect( legends, 0, 0, lDim, lDim)
        zeroDaysLegend.x =  10
        zeroDaysLegend.y = 280
        zeroDaysLegend:setFillColor(0, 255, 0)

    benignLabel = display.newText( legends, "Benign", 0, 0, native.systemFont, 11)
        benignLabel.x = 39
        benignLabel.y = 250
        benignLabel:setFillColor(0)

    maliciousLabel = display.newText( legends, "Malicious", 0, 0, native.systemFont, 11)
        maliciousLabel.x = 45
        maliciousLabel.y = 265
        maliciousLabel:setFillColor(0)

    zeroDaysLabel = display.newText( legends, "Zero Days", 0, 0, native.systemFont, 11)
        zeroDaysLabel.x = 48
        zeroDaysLabel.y = 280
        zeroDaysLabel:setFillColor(0)

    -- Group insertion
    sceneGroup:insert(graphContainer)
    sceneGroup:insert(colorDDM)
    graphContainer:insert(legends)

    -- Draw graphs' horizontal lines
    for i = 0, 240, clearance do
        drawLines(i)
    end

    -- Event listeners
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
        removePlots()
    end
end
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 
-- -----------------------------------------------------------------------------------
-- Function calls
-- -----------------------------------------------------------------------------------
listFunctions()
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
return scene