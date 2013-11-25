MathJax.Hub.Config
	config: ["MMLorHTML.js"]
	jax: ["input/MathML", "output/HTML-CSS"]
	extensions: ["mml2jax.js","MathMenu.js","MathZoom.js"]
	showMathMenu: false
	showMathMenuMSIE: false

require.config
	paths:
		"jquery": "lib/jquery.min"
		"jqueryui": "lib/jquery-ui.min"
		"JSAlgebra": "lib/JS-Algebra/src/"
		"MathJax": "http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=MML_HTMLorMML"
	shim:
		"jqueryui": ["jquery"]

require ["jquery", "jqueryui", "frontend/setupFrontend", "frontend/finishLoading"], ($, ui, setupFrontend, finishLoading) ->
	$ ->
		setupFrontend()
		finishLoading()