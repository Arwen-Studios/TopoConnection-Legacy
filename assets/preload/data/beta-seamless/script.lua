function onCreate()
	setProperty('skipCountdown', true)
end

function onDestroy()
	setProperty('skipCountdown', false)
end