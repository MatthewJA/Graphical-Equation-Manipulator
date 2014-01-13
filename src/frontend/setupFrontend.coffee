define [
	"jquery"
	"frontend/setEventHandlers"
	"frontend/setSearchResultHandlers"
	"frontend/connections"
	"frontend/generateSearchResults"
], ($, setEventHandlers, setSearchResultHandlers, connections, generateSearchResults) ->

	# Initialise the frontend.
	# This will be called by $(document).ready.

	return ->
		$(window).resize ->
			connections.repaintVariables()
		setEventHandlers()
		generateSearchResults()
		setSearchResultHandlers()