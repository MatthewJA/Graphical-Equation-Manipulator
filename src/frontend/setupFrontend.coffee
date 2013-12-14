define [
	"jquery"
	"frontend/setEventHandlers"
	"frontend/setSearchResultHandlers"
	"frontend/connections"
], ($, setEventHandlers, setSearchResultHandlers, connections) ->

	# Initialise the frontend.
	# This will be called by $(document).ready.

	return ->
		$(window).resize ->
			connections.repaintVariables()
		setEventHandlers()
		setSearchResultHandlers()