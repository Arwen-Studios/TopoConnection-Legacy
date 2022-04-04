--50 = upscroll
--570 = downscroll

function onCreatePost()
	setProperty('iconP1.alpha', 0)
	setProperty('iconP2.alpha', 0)
	setProperty('laneunderlayOpponent.alpha', 0)
	setProperty('scoreTxt.y', 10)
    setProperty('healthBar.y', 340)
	setProperty('healthBar.x', 969)
	setProperty('healthBar.angle', 90)
	setProperty('timeBar.y', 689)
	setProperty('timeTxt.y', 676)

	local texture = 'p2Notes/' .. 'Nxxty'
	for i = 0, 3 do setPropertyFromGroup('opponentStrums', i, 'texture', texture) end
    for i = 0, getProperty('unspawnNotes.length') - 1 do
        if not getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
            setPropertyFromGroup('unspawnNotes', i, 'texture', texture)
        end
    end
end

function onSongStart()
	if not getPropertyFromClass('ClientPrefs', 'pussyMode', false) then
		noteTweenAlpha('aee', 0, 0, 0.2, 'smootherStepOut')
		noteTweenAlpha('eaa', 1, 0, 0.3, 'smootherStepOut')
		noteTweenAlpha('pss', 2, 0, 0.4, 'smootherStepOut')
		noteTweenAlpha('hcd', 3, 0, 0.5, 'smootherStepOut')

		setPropertyFromGroup('playerStrums',0,'downScroll',false)
		setPropertyFromGroup('playerStrums',1,'downScroll',false)
		setPropertyFromGroup('playerStrums',2,'downScroll',false)
		setPropertyFromGroup('playerStrums',3,'downScroll',false)

		noteTweenY('psX', 6, 50, 1, 'expoOut')
		noteTweenY('hcZ', 7, 50, 1, 'expoOut')
		noteTweenY('p3X', 4, 50, 1, 'expoOut')
		noteTweenY('h0Z', 5, 50, 1, 'expoOut')
	end
end

function onUpdate()
	if not getPropertyFromClass('ClientPrefs', 'pussyMode', false) then
		if (curStep == 256) then
			setPropertyFromGroup('playerStrums',2,'downScroll',false)
			setPropertyFromGroup('playerStrums',3,'downScroll',false)
			setPropertyFromGroup('playerStrums',0,'downScroll',true)
			setPropertyFromGroup('playerStrums',1,'downScroll',true)

			noteTweenY('psX', 6, 50, 8, 'expoOut')
			noteTweenY('hcZ', 7, 50, 8, 'expoOut')
			noteTweenY('p3X', 4, 570, 8, 'expoOut')
			noteTweenY('h0Z', 5, 570, 8, 'expoOut')
		end

		if (curStep == 640) then
			setPropertyFromGroup('playerStrums',2,'downScroll',false)
			setPropertyFromGroup('playerStrums',3,'downScroll',false)
			setPropertyFromGroup('playerStrums',0,'downScroll',false)
			setPropertyFromGroup('playerStrums',1,'downScroll',false)

			noteTweenY('psX', 6, 50, 2, 'expoOut')
			noteTweenY('hcZ', 7, 50, 2, 'expoOut')
			noteTweenY('p3X', 4, 50, 2, 'expoOut')
			noteTweenY('h0Z', 5, 50, 2, 'expoOut')
		end

		if (curStep == 895) then
			setPropertyFromGroup('playerStrums',0,'downScroll',false)
			setPropertyFromGroup('playerStrums',1,'downScroll',true)
			setPropertyFromGroup('playerStrums',2,'downScroll',false)
			setPropertyFromGroup('playerStrums',3,'downScroll',true)

			noteTweenY('psX', 6, 50, 2, 'expoOut')
			noteTweenY('hcZ', 7, 570, 2, 'expoOut')
			noteTweenY('p3X', 4, 50, 2, 'expoOut')
			noteTweenY('h0Z', 5, 570, 2, 'expoOut')
		end

		if (curStep == 1151) then
			setPropertyFromGroup('playerStrums',0,'downScroll',true)
			setPropertyFromGroup('playerStrums',1,'downScroll',true)
			setPropertyFromGroup('playerStrums',2,'downScroll',true)
			setPropertyFromGroup('playerStrums',3,'downScroll',true)

			noteTweenY('psX', 6, 570, 2, 'expoOut')
			noteTweenY('hcZ', 7, 570, 2, 'expoOut')
			noteTweenY('p3X', 4, 570, 2, 'expoOut')
			noteTweenY('h0Z', 5, 570, 2, 'expoOut')
		end

		if (curStep == 1280) then
			setPropertyFromGroup('playerStrums',0,'downScroll',true)
			setPropertyFromGroup('playerStrums',1,'downScroll',true)
			setPropertyFromGroup('playerStrums',2,'downScroll',false)
			setPropertyFromGroup('playerStrums',3,'downScroll',false)

			noteTweenY('psX', 6, 50, 2, 'expoOut')
			noteTweenY('hcZ', 7, 50, 2, 'expoOut')
			noteTweenY('p3X', 4, 570, 2, 'expoOut')
			noteTweenY('h0Z', 5, 570, 2, 'expoOut')
		end

		if (curStep == 1407) then
			setPropertyFromGroup('playerStrums',0,'downScroll',false)
			setPropertyFromGroup('playerStrums',1,'downScroll',false)
			setPropertyFromGroup('playerStrums',2,'downScroll',false)
			setPropertyFromGroup('playerStrums',3,'downScroll',false)

			noteTweenY('psX', 6, 50, 2, 'expoOut')
			noteTweenY('hcZ', 7, 50, 2, 'expoOut')
			noteTweenY('p3X', 4, 50, 2, 'expoOut')
			noteTweenY('h0Z', 5, 50, 2, 'expoOut')
		end
	end
end