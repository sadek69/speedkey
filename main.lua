
local w = display.actualContentWidth
local h = display.actualContentHeight
local defaultField
long = 2
scoren = 0
words = ""--for one words
rndwords = ""--for long text
speed = 2000
sw = 0 --swith help to prevent double tap
local physics = require( "physics" )
physics.start()
sw2 = 1 --game mode one symbol 1 long words 2

beep = audio.loadSound("lazer.wav")

local l = {"q","w","e","r","t","y","u","i","o","p","a","s","d","f","g","h","j","k","l","z","x","c","v","b","n","m"}
words=l[math.random(1, 26)]--for one words

local score  = display.newText( scoren, display.contentCenterX+100, 160, native.systemFont, 12 )


local function textListener( event )

  if ( event.target.text == words ) and sw == 0 and sw2 == 1 then
    scoren = scoren + 1 --score calculator
    defaultField.text=""
    score:removeSelf()
    score  = display.newText( scoren, display.contentCenterX+100, 160, native.systemFont, 12 )
    sw = 1 --prevent multiple tap
    audio.play(beep)
  elseif sw2 == 2 then
    if event.phase == "submitted" then
      if event.target.text == rndwords then
        print( event.target.text )
        scoren = scoren + 1 --score cacluator
        defaultField.text=""
        score:removeSelf()
        score  = display.newText( scoren, display.contentCenterX+100, 160, native.systemFont, 12 )
        audio.play(beep)
        print("popal")
      end
    end
  else
    defaultField.text=""
  end


  if scoren > 30 then
    sw2 = 2
    speed = 4000
  end
  if scoren > 60 then
    long = 3
    speed = 4000
  end
  if scoren > 90 then
    long = 4
    speed = 8000
  end
  if scoren > 120 then
    long = 5
    speed = 16000
  end

end


local function gameLoop()
    if sw2 == 1 then
      words = l[math.random(1, 26)]
      tapText = display.newText( words, display.contentCenterX+(math.random(-175,175)), -190, native.systemFont, 12 )
      physics.addBody (tapText, "dynamic", { radius=25, bounce=0.3} )
      sw = 0 --try to stop multiple tap
    elseif sw2 == 2 then
      rndwords = ""
      --generator
      for i = 1, long do
        rndwords = rndwords..l[math.random(1,26)]
      end
      tapText = display.newText( rndwords, display.contentCenterX+(math.random(-175,175)), -190, native.systemFont, 12 )
      physics.addBody (tapText, "dynamic", { radius=25, bounce=0.3} )

    end

end

 -- timer  mil sec update
gameLoopTimer = timer.performWithDelay( speed, gameLoop, 0 )


display.setDefault( "background", 144/255, 142/255, 144/255,0)





-- Create text field
defaultField = native.newTextField( 220, 160, 120, 16 )
defaultField:addEventListener( "userInput", textListener )
