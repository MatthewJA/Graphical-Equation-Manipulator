require.config
	paths:
		"jquery": "lib/jquery.min"
		"jqueryui": "lib/jquery-ui.min"
		"JSAlgebra": "lib/JS-Algebra/src/"
	shim:
		"jqueryui": ["jquery"]

require ["jquery", "jqueryui", "frontend/setupFrontend"], ($, ui, setupFrontend) ->
	$ ->
		setupFrontend()