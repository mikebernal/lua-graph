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
    local navMenu = {"Home", "About", "Author", "v.1.0.", "", "", "", "", "Exit"} 

    local function toggleMenu( event )
        if (event.phase == "ended") then
            print("go to menu")
            composer.hideOverlay( "fade", 400 )
        end
    end

    -- Background
    local background = display.newRect(sceneGroup, 0, 0, width, height)
      background.x = width  * 0.5
      background.y = height * 0.4
      background:setFillColor(255, 255, 255)

    -- Close button
    local closeBtn = display.newText(sceneGroup, "Close", 0, 0, native.systemFont, 16)
        closeBtn.x = width - 50
        closeBtn.y = -10
        closeBtn:setFillColor(0.1, 0.1, 0.1)

    local function onRowRender( event )

      -- Get reference to the row group
      local row = event.row
    
      -- Cache the row "contentWidth" and "contentHeight" because the row bounds can change as children objects are added
      local rowHeight = row.contentHeight
      local rowWidth = row.contentWidth

      local rowTitle = display.newText( row, navMenu[row.index] , 0, 0, nil, 14 )
      rowTitle:setFillColor( 0 )
    
      -- Align the label left and vertically centered
      rowTitle.anchorX = 0
      rowTitle.x = 20
      rowTitle.y = rowHeight * 0.5
    end

  local function onRowTouch( event )
    -- home scene
    composer.hideOverlay( "fade", 400 )
    if(event.row.index == 1) then
        composer.gotoScene("home", "slideRight")
    -- about scene
    elseif(event.row.index == 2) then
        composer.gotoScene("about", "slideRight")
    -- author scene
    elseif(event.row.index == 3) then
        composer.gotoScene("author", "slideRight")
    -- exit
    elseif(event.row.index == 9) then
        native.requestExit()
    -- exit
    else 
        composer.hideOverlay( "fade", 400 )
    end

  end

  -- Create the widget
  local tableView = widget.newTableView(
      {
          left = 0,
          top = 0,
          height = heigth,
          width = width - 20,
          onRowRender = onRowRender,
          onRowTouch = onRowTouch,
          listener = scrollListener,
      }
  )
  
  -- Insert rows
  for i = 1, 9 do
  
      local isCategory = false
      local rowHeight = 55
      local rowColor = { default={1,1,1}, over={1,0.5,0,0.2} }
      local lineColor = { 0.5, 0.5, 0.5 }

  
      -- Insert a row into the tableView
      tableView:insertRow(
          {
              isCategory = isCategory,
              rowHeight = rowHeight,
              rowColor = rowColor,
              lineColor = lineColor
          }
      )
  end

  -- Group insertion
  sceneGroup:insert(tableView)

  -- Event listeners
  closeBtn:addEventListener("touch", toggleMenu)
  scene:addEventListener( "hide", scene )


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