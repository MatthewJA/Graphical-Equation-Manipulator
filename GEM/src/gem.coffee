###
Graphical Equation Manipulator

Matthew Alger, based on Buck Shlegeris' pyGEM.
https://github.com/MatthewJA/Graphical-Equation-Manipulator
https://github.com/bshlgrs/pyGEM

Licensed under GPL v3.
###

require.config
	baseUrl: "./src"
	paths:
		jquery: "vendor/jquery-2.1.1.min"
		coffeequate: "vendor/coffeequate.min"
		mathjax: "http://cdn.mathjax.org/mathjax/latest/" +
			"MathJax.js?config=MML_HTMLorMML.js"
		jqueryui: "vendor/jquery-ui.min"
	shim:
		jqueryui: ["jquery"]
		mathjax:
			exports: "MathJax"
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
	"Expression"
	"render"
	"jqueryui"
], ($, Expression, render, ui) ->

	# Trigger the flag that we've finished loading.
	window.gem.loaded = true # window.gem is defined in the preloader.

	require ["addEquation", "formulae"], (addEquation, formulae) ->
		addEquation(formulae.getEquation("force"))