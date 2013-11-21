require.config
	paths:
		"jquery": "lib/jquery.min"
		"jqueryui": "lib/jquery-ui.min"
		"JSAlgebra": "lib/JS-Algebra/src/"
	shim:
		# "jquery":
		# 	exports: ["$"]
		"jqueryui": ["jquery"]

require ["jquery", "jqueryui", "setupFrontend"], ($, ui, setupFrontend) ->
	$ ->
		setupFrontend()