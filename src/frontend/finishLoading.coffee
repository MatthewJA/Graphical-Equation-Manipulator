define ["jquery"], ($) ->

	# Finish loading by hiding the loader and showing the GEM window.
	
	return ->
		$("#gem-window").show()
		$("#loader").hide()