VERSION = "0.0.2"

MathJax.Hub.Config
	config: ["MMLorHTML.js"]
	jax: ["input/MathML", "output/HTML-CSS"]
	extensions: ["mml2jax.js","MathMenu.js","MathZoom.js"]
	showMathMenu: false
	showMathMenuMSIE: false

require.config
	urlArgs: "v=#{VERSION}"
	paths:
		"jquery": "lib/jquery.min"
		"jqueryui": "lib/jquery-ui.min"
		"JSAlgebra": "lib/JS-Algebra/src/"
		"MathJax": "http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=MML_HTMLorMML"
		"TouchPunch": "lib/Touch-Punch/jquery.ui.touch-punch.min"
		"MobileEvents": "lib/jquery.mobile-events.min"
	shim:
		"jqueryui": ["jquery"]
		"TouchPunch": ["jquery"]
		"MobileEvents": ["jquery"]

require ["jquery", "jqueryui", "MobileEvents", "frontend/setupFrontend", "frontend/finishLoading"], ($, ui, me, setupFrontend, finishLoading) ->
	$ ->
		setupFrontend()
		require ["TouchPunch"]
		finishLoading()