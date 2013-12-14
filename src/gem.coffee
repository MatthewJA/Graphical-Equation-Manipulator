VERSION = "0.0.5"

MathJax.Hub.Config
	config: ["MMLorHTML.js"]
	jax: ["input/MathML", "output/HTML-CSS"]
	extensions: ["mml2jax.js","MathMenu.js","MathZoom.js"]
	showMathMenu: false
	showMathMenuMSIE: false

require.config
	urlArgs: "v=#{VERSION}"
	paths:
		"jquery": "lib/jQuery/jquery.min"
		"jqueryui": "lib/jQuery/jquery-ui.min"
		"JSAlgebra": "lib/JS-Algebra/src/"
		"MathJax": "lib/MathJax/MathJax"
		"TouchPunch": "lib/Touch-Punch/jquery.ui.touch-punch.min"
		"MobileEvents": "lib/jQuery/jquery.mobile-events.min"
	shim:
		"jqueryui": ["jquery"]
		"TouchPunch": ["jquery"]
		"MobileEvents": ["jquery"]

require [
	"jquery"
	"jqueryui"
	"MobileEvents"
	"frontend/setupFrontend"
	"frontend/finishLoading"
	"frontend/setupSettings"
	"frontend/settings"
], ($, ui, me, setupFrontend, finishLoading, setupSettings, settings) ->
	$ ->
		# Handle settings.
		setupSettings()

		# Load Touch Punch to handle jQuery UI events on mobile devices.
		require ["TouchPunch"]

		# Setup the frontend.
		setupFrontend()

		unless settings.get("loadForever")
			# Tell the user that we have finished loading.
			finishLoading()