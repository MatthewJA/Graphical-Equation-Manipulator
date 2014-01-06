VERSION = "0.0.7"

require.config
	urlArgs: "v=#{VERSION}"
	baseUrl: "./src"
	paths:
		"jquery": "lib/jQuery/jquery.min"
		"jqueryui": "lib/jQuery/jquery-ui.min"
		"MathJax": if window.getParameter("mathJaxEnabled") == "false" then "frontend/blank" else "http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=MML_HTMLorMML"
		"TouchPunch": "./src/lib/Touch-Punch/jquery.ui.touch-punch.min"
		"MobileEvents": "lib/jQuery/jquery.mobile-events.min"
		"coffeequate": "lib/coffeequate/coffeequate"
	shim:
		"jqueryui": ["jquery"]
		"TouchPunch": ["jquery"]
		"MobileEvents": ["jquery"]
		"MathJax":
			exports: "MathJax",
			init: ->
				MathJax.Hub.Config
					config: ["MMLorHTML.js"]
					jax: ["input/MathML", "output/HTML-CSS"]
					extensions: ["mml2jax.js","MathMenu.js","MathZoom.js"]
					showMathMenu: false
					showMathMenuMSIE: false
				MathJax.Hub.Startup.onload()
				return MathJax

require [
	"jquery"
	"jqueryui"
	"MobileEvents"
	"frontend/setupFrontend"
	"frontend/finishLoading"
	"frontend/setupSettings"
	"frontend/settings"
	"MathJax"
], ($, ui, me, setupFrontend, finishLoading, setupSettings, settings, MathJax) ->
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