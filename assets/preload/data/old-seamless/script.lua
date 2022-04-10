function onCreate()
	setProperty('skipCountdown', true)
end

--function onCreatePost()
--	local texture = 'p2Notes/' .. 'Nxxty'
--
--	for i = 0, 3 do setPropertyFromGroup('opponentStrums', i, 'texture', texture) end
--    for i = 0, getProperty('unspawnNotes.length') - 1 do
--        if not getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
--            setPropertyFromGroup('unspawnNotes', i, 'texture', texture)
--        end
--    end

function onDestroy()
	setProperty('skipCountdown', false)
end

--end
