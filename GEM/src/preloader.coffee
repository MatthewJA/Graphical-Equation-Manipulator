# Display a nice preloading animation while the user waits for loading.
# This code uses no libraries, for somewhat obvious reasons that they will
# not yet have loaded when this runs.

window.gem = {} # GEM flags.

preloader = document.getElementById("preloader")

# Properties of each heavenly sphere in the animation.
bodies =
	sun:
		position: [0, 0]	# radius, angle
		speed: 0			# radians per tick
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

# Sizes of the preloader.
width = preloader.clientWidth
height = preloader.clientHeight

# Last updated time, for calculating dt.
lastUpdate = (new Date()).getTime() - Math.random()*20000
dt = 0

# Current preloader opacity.
opacity = 1.0

# Current preloader activity.
closingPreloader = true

# Step through the animation.
sim = ->
	now = (new Date()).getTime()
	dt = now - lastUpdate
	lastUpdate = now
	for body of bodies
		x = width/2 - bodies[body].element.clientWidth/2 +
			bodies[body].position[0]*Math.cos(bodies[body].position[1])
		y = height/2 - bodies[body].element.clientHeight/2 +
			bodies[body].position[0]*Math.sin(bodies[body].position[1])

		bodies[body].element.style.left = "#{x}px"
		bodies[body].element.style.top = "#{y}px"

		bodies[body].position[1] = (bodies[body].position[1] +
			bodies[body].speed*dt) % (Math.PI * 2)

	unless window.gem.loaded?
		setTimeout(sim, 0)
	else
		setTimeout(closePreloader, 0)

# Step through the animated closing of the preloader.
closePreloader = ->
	if closingPreloader
		opacity -= 0.02
		document.getElementById("loader").style.opacity = "#{opacity}"

		if opacity <= 0
			closingPreloader = false
			document.getElementById("loader").style.display = "none"
			setTimeout(closePreloader, 0)
		else
			setTimeout(sim, 0)

	else
		opacity += 0.02
		document.getElementById("whiteboard").style.display = "block"
		document.getElementById("whiteboard").style.opacity = "#{opacity}"

		if opacity < 1
			setTimeout(closePreloader, 0)
		else
			window.gem.preloaderClosed = true

sim()