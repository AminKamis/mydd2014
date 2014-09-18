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
local bg = display.newImage('images/bg.png')
--local bgVector = display.newRect( screenWidth, screenHeight, display.contentWidth, display.contentHeight )
--bgVector:setFillColor(23,43,165)



-- [user numeric input]
local numericField

-- [Title View]
local titleBg
local playBtn
local titleView


-- App Background
local mainBg
local texture1

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

-- PopUp
local eatLessPopUp
local eatModeratePopUp 
local eatMorePopUp
local eatMorePopUp1
local eatMorePopUp2
local eatMostPopUp 

-- Sounds
--local correctSnd = audio.loadSound('correct.caf')
local DisSnd = audio.loadSound('audio/discount.mp3')


-- Variables
local correct = 0 -- Counts the correct dropped items

-- Functions
local Main = {}
local Barcode = {}
local startButtonListeners = {}
local showGameView = {}
local gameListeners = {}
local hitTestObjects = {}
local dragTheFood = {}
local alert = {}
local userKeyInBarcode = {}
local runMe = {}
local eatLess = {}
local eatModerate = {}
local eatMore = {}
local eatMost = {}
local removeBarcode = {}
local eatMore1 = {}
local texture = {}

--Ads Func
local point = {}
local point2 = {}
local voucher = {}
local zalora = {}
local advertise ={}
--Nemeric Input

function runMe()
	Barcode()
end

function userKeyInBarcode(getObj)


	return function (event)

		print( "Barcode is: ".. tostring( getObj() ) )

        if ( "began" == event.phase and 'mydd2014' ) then
            -- This is the "keyboard has appeared" event
            --Barcode()
            native.setKeyboardFocus( numericField )

        elseif ( "ended" == event.phase and 'mydd2014' ) then
            -- This event is called when the user stops editing a field:
            -- for example, when they touch a different field or keyboard focus goes away
            --Barcode()
            native.setKeyboardFocus( numericField )

            print( "Barcode is" ..tostring( getObj().text ) )         -- display the text entered

        elseif ( "submitted" == event.phase and 'mydd2014' ) then
            -- This event occurs when the user presses the "return" key
            -- (if available) on the onscreen keyboard

            -- Hide keyboard
            native.setKeyboardFocus( numericField )

        end
    end     -- "return function()"

end   

numericField = native.newTextField( centerX-100, centerY, 220, 60 )
numericField.inputType = "number" and "numeric"
numericField.y = display.contentCenterX + 120

numericField:addEventListener( "userInput", userKeyInBarcode)


function Barcode()
	Main()
	-- hide the image
	--texture1.isVisible = false

	-- remove the image
	--texture1:removeSelf()
end

function Main()
    titleBg = display.newImage('images/titleBg.png', 70, 35)
    playBtn = display.newImage('images/playBtn.png', screenLeft+100, 400)
    local logo = display.newImage( 'images/logo.png', 180, 190 )
    titleView = display.newGroup(titleBg, playBtn, logo)
    startButtonListeners('add')   
    texture()

    
end


function point()
	local pointImg = display.newImage( 'images/point.png',315, 538)
	transition.from(pointImg, {time = 400, 
					 alpha = 0.1, 
			    onComplete = function() timer.performWithDelay(5000, 
			    	         function() transition.to(pointImg, 

			    	         	{time = 200, 
			    	         	alpha = 0.1, 
			    	       onComplete = function() display.remove(pointImg) 
			    	              ins = nil end}) end) end})
end

function point2()
	local point2Img = display.newImage( 'images/point2.png',319, 664)
	transition.from(point2Img, {time = 400, 
					 alpha = 0.1, 
			    onComplete = function() timer.performWithDelay(5000, 
			    	         function() transition.to(point2Img, 

			    	         	{time = 200, 
			    	         	alpha = 0.1, 
			    	       onComplete = function() display.remove(point2Img) 
			    	        point2Img = nil end}) end) end})	
end

function voucher()
	local voucherImg = display.newImage( 'images/voucher.png',20, 538)
	transition.from(voucherImg, {time = 400, 
					 alpha = 0.1, 
			    onComplete = function() timer.performWithDelay(5000, 
			    	         function() transition.to(voucherImg, 

			    	         	{time = 200, 
			    	         	alpha = 0.1, 
			    	       onComplete = function() display.remove(voucherImg) 
			    	       voucherImg = nil end}) end) end})	
end

function zalora()
	local zaloraImg = display.newImage( 'images/zalora.png',170, 664)
	transition.from(zaloraImg, {time = 400, 
					 alpha = 0.1, 
			    onComplete = function() timer.performWithDelay(5000, 
			    	         function() transition.to(zaloraImg, 

			    	         	{time = 200, 
			    	         	alpha = 0.1, 
			    	       onComplete = function() display.remove(zaloraImg) 
			    	        zaloraImg = nil end}) end) end})
end

function advertise()
	local AdsImg = display.newImage( 'images/ads.png',20, 664)
	transition.from(AdsImg, {time = 400, 
					 alpha = 0.1, 
			    onComplete = function() timer.performWithDelay(5000, 
			    	         function() transition.to(AdsImg, 

			    	         	{time = 200, 
			    	         	alpha = 0.1, 
			    	       onComplete = function() display.remove(AdsImg) 
			    	           AdsImg = nil end}) end) end})	
end




function texture()
 	texture1 = display.newImage('images/texture.png', centerX-225,display.contentCenterY+125 )	

 end



function startButtonListeners(action)
    if(action == 'add') then
        playBtn:addEventListener('tap', showGameView)


    else
        playBtn:removeEventListener('tap', showGameView)
        numericField:removeSelf()
        --numericField.inVisible = false
    end
end


function showGameView:tap(e)
    transition.to(titleView, 
    	{time = 200, 
    		x = -titleView.height, 
   onComplete = function() startButtonListeners('rmv') display.remove(titleView) 
    titleView = nil 
    end})



-- Place holders

eatLessHolder = display.newImage('images/01.png', centerX-80, 10)
eatModerateHolder = display.newImage('images/02.png', centerX-120, 152)
eatMoreHolder = display.newImage('images/03.png', centerX-162, 223)
eatTheMostHolder = display.newImage('images/04.png', centerX-223, 295)
eatVegeHolder = display.newImage('images/03.png', centerX-162, 223)


-- Instructions
ins = display.newImage('images/instructions.png', centerX-190, 390)
transition.from(ins, {time = 400, 
					 alpha = 0.1, 
			    onComplete = function() timer.performWithDelay(5000, 
			    	         function() transition.to(ins, 

			    	         	{time = 200, 
			    	         	alpha = 0.1, 
			    	       onComplete = function() display.remove(ins) 
			    	              ins = nil end}) end) end})


-- Food Pyramid Items To Drag

    eatless = display.newImage('images/eatless.png', centerX+35, 550)
    eatmoderate = display.newImage('images/eatmoderate.png', centerX+45, 670)
    eatmore = display.newImage('images/eatmore.png', centerX-185, 550)
    eatthemost = display.newImage('images/eatthemost.png', centerX-250, 670)
    eatvege = display.newImage('images/eatvege.png', centerX-100, 670)


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

function eatLess()
	eatLessPopUp = display.newImage( 'images/popup-eatless.png', centerX-200, 10 )
	transition.from(eatLessPopUp, {time = 300, 
					 alpha = 0.1, 
			    onComplete = function() timer.performWithDelay(2000, 
			    	         function() transition.to(eatLessPopUp,

			    	         	{time = 200, 
			    	         	alpha = 0, 
			    	       onComplete = function() display.remove(eatLessPopUp,eatModeratePopUp) 
			    	              ins = nil end}) end) end})
	 point()
end

function eatModerate()
	eatModeratePopUp = display.newImage( 'images/popup-eatmoderate.png', centerX-120, 90 )
	transition.from(eatModeratePopUp, {time = 300, 
					 alpha = 0.1, 
			    onComplete = function() timer.performWithDelay(2000, 
			    	         function() transition.to(eatModeratePopUp, 

			    	         	{time = 200, 
			    	         	alpha = 0, 
			    	       onComplete = function() display.remove(eatModeratePopUp,eatMorePopUp) 
			    	              ins = nil end}) end) end})
	point2()	
end

function eatMore()
	eatMorePopUp = display.newImage( 'images/popup-eatmore.png', centerX-55, 195 )
	transition.from(eatMorePopUp, {time = 300, 
					 alpha = 0.1, 
			    onComplete = function() timer.performWithDelay(2000, 
			    	         function() transition.to(eatMorePopUp, 

			    	         	{time = 200, 
			    	         	alpha = 0, 
			    	       onComplete = function() display.remove(eatMorePopUp,eatMorePopUp1,eatModeratePopUp) 
			    	              ins = nil end}) end) end})
	voucher()
end

function eatMore1()
	eatMorePopUp1 = display.newImage( 'images/popup-eatmore.png', centerX-250, 195 )
	transition.from(eatMorePopUp1, {time = 300, 
					 alpha = 0.1, 
			    onComplete = function() timer.performWithDelay(2000, 
			    	         function() transition.to(eatMorePopUp1,  

			    	         	{time = 200, 
			    	         	alpha = 0, 
			    	       onComplete = function() display.remove(eatMorePopUp1,eatMostPopUp2) 
			    	              ins = nil end}) end) end})
	zalora()		    	              		
end

function eatMost()
	eatMorePopUp2 = display.newImage( 'images/popup-eatmost.png', centerX-162, 223 )
	transition.from(eatMorePopUp2, {time = 300, 
					 alpha = 0.1, 
			    onComplete = function() timer.performWithDelay(2000, 
			    	         function() transition.to(eatMorePopUp, 

			    	         	{time = 200, 
			    	         	alpha = 0, 
			    	       onComplete = function() display.remove(eatMorePopUp2,eatMorePopUp1) 
			    	              ins = nil end}) end) end})	
	advertise()
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
        eatLess()
          

    elseif(e.target.name == 'no2' and e.phase == 'ended' and hitTestObjects(e.target, eatModerateHolder)) then
        e.target.x = display.contentCenterX
        e.target.y = 185
        e.target:removeEventListener('touch', dragTheFood)
        correct = correct + 1
        eatModerate()
        

    elseif(e.target.name == 'no3' and e.phase == 'ended' and hitTestObjects(e.target, eatMoreHolder)) then
        e.target.x = display.contentCenterX + 50
        e.target.y = 270
        e.target:removeEventListener('touch', dragTheFood)
        correct = correct + 1
        eatMore()
         

    elseif(e.target.name == 'no4' and e.phase == 'ended' and hitTestObjects(e.target, eatTheMostHolder)) then
        e.target.x = display.contentCenterX
        e.target.y = 350
        e.target:removeEventListener('touch', dragTheFood)
        correct = correct + 1
        eatMost()
          

    elseif(e.target.name == 'no5' and e.phase == 'ended' and hitTestObjects(e.target, eatVegeHolder)) then
        e.target.x = display.contentCenterX - 70
        e.target.y = 270
        e.target:removeEventListener('touch', dragTheFood)
        correct = correct + 1
        eatMore1()
          
    end
        
    if(e.phase == 'ended' and correct == 5) then
        audio.play(DisSnd)
        alert()
   	end

end
    
function alert()
    alertView = display.newImage('images/discount.png', display.contentCenterX-200, 450)
    transition.from(alertView, {time = 200, alpha = 0.1})
    eatMorePopUp1:removeSelf( )
    eatMorePopUp2:removeSelf( )
    eatMostPopUp:removeSelf( )
    eatModeratePopUp:removeSelf( )
    eatMorePopUp:removeSelf( )

    
end


runMe()