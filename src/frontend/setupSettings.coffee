define ["frontend/getParameter", "frontend/settings"], (getParameter, settings) ->

	# Read in the get parameters and use them to set the settings of the app.

	return ->
		console.log("Loading settings...")
		for key in settings.keys()
			g = getParameter(key)
			if g?
				if g == "false"
					g = false
				else if g == "true"
					g = true

				settings.set(key, g)
			console.log(key, settings.get(key))