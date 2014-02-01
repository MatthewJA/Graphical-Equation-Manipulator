define [
	"jquery"
	"frontend/setEventHandlers"
	"frontend/connections"
	"frontend/updateSearchResults"
	"frontend/setExtraEventHandlers"
], ($, setEventHandlers, connections, updateSearchResults, setExtraEventHandlers) ->

	# Initialise the frontend.
	# This will be called by $(document).ready.

	return ->
		$(window).resize ->
			connections.repaintVariables()
		setEventHandlers()
		updateSearchResults()
		setExtraEventHandlers()