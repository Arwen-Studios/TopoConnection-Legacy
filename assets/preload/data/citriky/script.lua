local startX = 300
local startY = 200

function onCreate()
	setProperty('skipCountdown', true)
end

function onStepHit()
	if curStep == 116 then 
		playTwo()
	end
	if curStep == 120 then 
		playOne()
	end
	if curStep == 124 then 
		playGo()
	end
end

function playTwo()
    makeLuaSprite('ready', 'ready', startX, startY)
	-- setScrollFactor('ready', 0, 0)
	setObjectCamera('ready', 'hud')
    addLuaSprite('ready', true)
    doTweenAlpha('readyTween', 'ready', 0, crochet / 1000, cubeInOut)
end

function playOne()
    makeLuaSprite('sett', 'set', startX, startY)
	-- setScrollFactor('sett', 0, 0)
	setObjectCamera('sett', 'hud')
    addLuaSprite('sett', true)
    doTweenAlpha('setTween', 'sett', 0, crochet / 1000, cubeInOut)
end

function playGo()
    makeLuaSprite('goo', 'go', startX, startY - 50)
	setObjectCamera('goo', 'hud')
    addLuaSprite('goo', true)
    doTweenAlpha('goTween', 'goo', 0, crochet / 1000, cubeInOut)
end