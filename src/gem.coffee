VERSION = "0.0.7"

require.config
	urlArgs: "v=#{VERSION}"
	baseUrl: "./src"
	catchError: true
	paths:
		"coffeequate": "vendor/Coffeequate/coffeequate"
		"jquery": "vendor/jQuery/jquery.min"
		"jqueryui": "vendor/jQuery/jquery.ui.min"
		"MobileEvents": "vendor/jQuery/jquery.mobile.events.min"
		"ContextMenu": "vendor/jQuery/jquery.contextMenu"
		"impromptu": "vendor/jQuery/jquery.impromptu.min"
		"TouchPunch": "vendor/TouchPunch/jquery.ui.touchpunch.min"
		"MathJax": (if window.getParameter("mathJaxEnabled") == "false" then "frontend/blank" else "http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=MML_HTMLorMML")
	shim:
		"jqueryui": ["jquery"]
		"TouchPunch": ["jquery"]
		"MobileEvents": ["jquery"]
		"ContextMenu": ["jquery"]
		"impromptu": ["jquery"]
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

require.onError = (err) ->
    console.log(err.requireType)
    console.log('modules: ' + err.requireModules)
    throw err

require [
	"jquery"
	"jqueryui"
	"MobileEvents"
	"frontend/setupFrontend"
	"frontend/finishLoading"
	"frontend/setupSettings"
	"frontend/settings"
	"MathJax"
	"ContextMenu"
	"impromptu"
], ($, ui, me, setupFrontend, finishLoading, setupSettings, settings, MathJax, ContextMenu, impromptu) ->
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