-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
-- most commonly used screen coordinates
centerX = display.contentCenterX
centerY = display.contentCenterY
screenLeft = display.screenOriginX
screenWidth = display.contentWidth - screenLeft * 2
screenRight = screenLeft + screenWidth
screenTop = display.screenOriginY
screenHeight = display.contentHeight - screenTop * 2
screenBottom = screenTop + screenHeight
display.contentWidth = screenWidth
display.contentHeight = screenHeight


display.setStatusBar(display.HiddenStatusBar)

-- UI/UX
 
-- [Background]
local bg = display.newImage('bg.png')

-- [Title View]
local titleBg
local playBtn
local titleView


-- App Background
local mainBg

-- Instructions
local ins

-- Drop Placeholder
local eatLessHolder
local eatModerateHolder
local eatMoreHolder
local eatTheMostHolder

-- Gamify items 
local eatless 
local eatmoderate
local eatmore 
local eatthemost 

-- Alert
local alertView

-- Sounds
--local correctSnd = audio.loadSound('correct.caf')
local DisSnd = audio.loadSound('discount.mp3')


-- Variables
local correct = 0 -- Counts the correct dropped items

-- Functions
local Main = {}
local startButtonListeners = {}
local showGameView = {}
local gameListeners = {}
local hitTestObjects = {}
local dragTheFood = {}
local alert = {}

--Nemeric Input
--local function userKeyInBarcode( event )

    --if ( event.phase == "began" ) then

        -- user begins enter barcode
        --print( event.text )
    --end   
--end

--local numericField = native.newTextField( 150, 150, 220, 36 )
--numericField.inputType = "number"

--numericField:addEventListener( "userInput", userKeyInBarcode )


function Main()
    titleBg = display.newImage('titleBg.png', 70, 35)
    playBtn = display.newImage('playBtn.png', 200, 400)
    titleView = display.newGroup(titleBg, playBtn)
    startButtonListeners('add')
end


function startButtonListeners(action)
    if(action == 'add') then
        playBtn:addEventListener('tap', showGameView)
        
    else
        playBtn:removeEventListener('tap', showGameView)
        
    end
end


function showGameView:tap(e)
    transition.to(titleView, 
    	{time = 300, 
    		x = -titleView.height, 
   onComplete = function() startButtonListeners('rmv') display.remove(titleView) 
    titleView = nil 
    end})


-- Place holders

eatLessHolder = display.newImage('01.png', centerX-80, 10)
eatModerateHolder = display.newImage('02.png', centerX-120, 152)
eatMoreHolder = display.newImage('03.png', centerX-162, 223)
eatTheMostHolder = display.newImage('04.png', centerX-223, 298)
eatVegeHolder = display.newImage('03.png', centerX-162, 223)


-- Instructions
ins = display.newImage('instructions.png', centerX-120, 390)
transition.from(ins, {time = 400, 
					 alpha = 0.1, 
			    onComplete = function() timer.performWithDelay(3000, 
			    	         function() transition.to(ins, 

			    	         	{time = 200, 
			    	         	alpha = 0.1, 
			    	       onComplete = function() display.remove(ins) 
			    	              ins = nil end}) end) end})


-- Food Pyramid Items To Drag

    eatless = display.newImage('eatless.png', centerX-35, 530)
    eatmoderate = display.newImage('eatmoderate.png', centerX+60, 650)
    eatmore = display.newImage('eatmore.png', centerX-185, 550)
    eatthemost = display.newImage('eatthemost.png', centerX-250, 650)
    eatvege = display.newImage('eatvege.png', centerX-100, 650)


    eatless.name = 'no1'
    eatmoderate.name = 'no2'
    eatmore.name = 'no3'
    eatthemost.name = 'no4'
    eatvege.name = 'no5'
 
	gameListeners()

end


function gameListeners()

    eatless:addEventListener('touch', dragTheFood)
    eatmoderate:addEventListener('touch', dragTheFood)
    eatmore:addEventListener('touch', dragTheFood)
    eatthemost:addEventListener('touch', dragTheFood)
    eatvege:addEventListener('touch', dragTheFood)

end


function hitTestObjects(obj1, obj2)
        local left = obj1.contentBounds.xMin <= obj2.contentBounds.xMin and obj1.contentBounds.xMax >= obj2.contentBounds.xMin
        local right = obj1.contentBounds.xMin >= obj2.contentBounds.xMin and obj1.contentBounds.xMin <= obj2.contentBounds.xMax
        local up = obj1.contentBounds.yMin <= obj2.contentBounds.yMin and obj1.contentBounds.yMax >= obj2.contentBounds.yMin
        local down = obj1.contentBounds.yMin >= obj2.contentBounds.yMin and obj1.contentBounds.yMin <= obj2.contentBounds.yMax
        return (left or right) and (up or down)
end


function dragTheFood(e)
    if(e.phase == 'began') then
        lastX = e.x - e.target.x
        lastY = e.y - e.target.y


    elseif(e.phase == 'moved') then
        e.target.x = e.x - lastX
        e.target.y = e.y - lastY

         
    elseif(e.target.name == 'no1' and e.phase == 'ended' and hitTestObjects(e.target, eatLessHolder)) then
        e.target.x = display.contentCenterX
        e.target.y = 99
        e.target:removeEventListener('touch', dragTheFood)
        correct = correct + 1
        --audio.play(correctSnd)   

    elseif(e.target.name == 'no2' and e.phase == 'ended' and hitTestObjects(e.target, eatModerateHolder)) then
        e.target.x = display.contentCenterX
        e.target.y = 185
        e.target:removeEventListener('touch', dragTheFood)
        correct = correct + 1
        

    elseif(e.target.name == 'no3' and e.phase == 'ended' and hitTestObjects(e.target, eatMoreHolder)) then
        e.target.x = display.contentCenterX
        e.target.y = 270
        e.target:removeEventListener('touch', dragTheFood)
        correct = correct + 1
         

    elseif(e.target.name == 'no4' and e.phase == 'ended' and hitTestObjects(e.target, eatTheMostHolder)) then
        e.target.x = display.contentCenterX
        e.target.y = 350
        e.target:removeEventListener('touch', dragTheFood)
        correct = correct + 1
          

    elseif(e.target.name == 'no5' and e.phase == 'ended' and hitTestObjects(e.target, eatVegeHolder)) then
        e.target.x = display.contentCenterX - 100
        e.target.y = 280
        e.target:removeEventListener('touch', dragTheFood)
        correct = correct + 1
          
    end
        
    if(e.phase == 'ended' and correct == 5) then
        --audio.stop()
        audio.play(DisSnd)
        alert()
   	end

end
    
function alert()
    alertView = display.newImage('discount.png', display.contentCenterX-120, 450)
    transition.from(alertView, {time = 200, alpha = 0.1})
end


Main()