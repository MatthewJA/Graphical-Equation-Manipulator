VERSION = "0.0.4"

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
		"MathJax": "http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=MML_HTMLorMML"
		"TouchPunch": "lib/Touch-Punch/jquery.ui.touch-punch.min"
		"MobileEvents": "lib/jQuery/jquery.mobile-events.min"
		"jsPlumb": "lib/jsPlumb/jquery.jsPlumb.min"
	shim:
		"jqueryui": ["jquery"]
		"TouchPunch": ["jquery"]
		"MobileEvents": ["jquery"]
		"jsPlumb": {
			deps: ["jquery"],
			exports: "jsPlumb"
		}

require [
	"jquery"
	"jqueryui"
	"MobileEvents"
	"jsPlumb"
	"frontend/setupFrontend"
	"frontend/finishLoading"
	"frontend/setupSettings"
], ($, ui, me, jsPlumb, setupFrontend, finishLoading, setupSettings) ->
	$ ->
		# Handle settings.
		setupSettings()

		# Load Touch Punch to handle jQuery UI events on mobile devices.
		require ["TouchPunch"]

		# Setup the frontend.
		setupFrontend()

		# Setup jsPlumb.
		jsPlumb.Defaults.Container = $("#whiteboard-panel")

		# Tell the user that we have finished loading.
		finishLoading()