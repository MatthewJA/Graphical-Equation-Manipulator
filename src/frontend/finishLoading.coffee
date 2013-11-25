define ["jquery"], ($) ->

	finishLoading = ->
		# Finish loading by hiding the loader and showing the GEM window.

		$("#gem-window").show()
		$("#loader").hide()