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

require ["jquery"], ($) ->
	# Trigger the flag that we've finished loading.
	window.gem.loaded = true # window.gem is defined in the preloader.