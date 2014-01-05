( ->
	bodies =
		sun:
			position: [0, 0]
			speed: 0
			element: document.getElementById("preloader-sun")
		venus:
			position: [80, 0]
			speed: 40 * Math.PI / 40000
			element: document.getElementById("preloader-venus")
		earth:
			position: [120, 0]
			speed: 24 * Math.PI / 40000
			element: document.getElementById("preloader-earth")
		mars:
			position: [160, 0]
			speed: 12 * Math.PI / 40000
			element: document.getElementById("preloader-mars")
		jupiter:
			position: [220, 0]
			speed: 2 * Math.PI / 40000
			element: document.getElementById("preloader-jupiter")

	width = document.getElementById("preloader").clientWidth
	height = document.getElementById("preloader").clientHeight

	lastUpdate = (new Date()).getTime() - Math.random()*20000

	sim = ->
		now = (new Date()).getTime()
		dt = now - lastUpdate
		lastUpdate = now
		for body of bodies
			x = width/2 - bodies[body].element.clientWidth/2 + bodies[body].position[0]*Math.cos(bodies[body].position[1])
			y = height/2 - bodies[body].element.clientHeight/2 + bodies[body].position[0]*Math.sin(bodies[body].position[1])

			bodies[body].element.style.left = "#{x}px"
			bodies[body].element.style.top = "#{y}px"

			bodies[body].position[1] = (bodies[body].position[1] + bodies[body].speed*dt) % (Math.PI * 2)

		unless window.loadedGEM?
			setTimeout(sim, 0)

	# Shoving this here because it's kind of preloader-related.
	# http://stackoverflow.com/a/831060/1105803

	window.getParameter = (name) ->
		if (name = (new RegExp('[?&]'+encodeURIComponent(name)+'=([^&]*)')).exec(location.search))
			decodeURIComponent(name[1])

	sim()

).call(@)