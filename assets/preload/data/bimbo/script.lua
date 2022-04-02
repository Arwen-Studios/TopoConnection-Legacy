function onCreatePost()
	if not getProperty('opponentMode') then
		for i= 0, 3 do
			setPropertyFromGroup('opponentStrums', i, 'texture', 'noteskins/opponent/bimbo')
		end
	end

	if getProperty('opponentMode') then
		for i= 0, 3 do
			setPropertyFromGroup('opponentStrums', i, 'texture', 'noteskins/opponent/boyfriend')
		end
	end
	
	if not getProperty('opponentMode') then
		for i = 0, getProperty('unspawnNotes.length') - 1 do
			if not getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
				setPropertyFromGroup('unspawnNotes', i, 'texture', 'noteskins/opponent/bimbo')
			end
		end
	end

	if getProperty('opponentMode') then
		for i = 0, getProperty('unspawnNotes.length') - 1 do
			if not getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
				setPropertyFromGroup('unspawnNotes', i, 'texture', 'noteskins/opponent/boyfriend')
			end
		end
	end
end