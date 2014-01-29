define [
	"jquery"
	"frontend/setEventHandlers"
	"frontend/setSearchResultHandlers"
	"frontend/connections"
	"frontend/generateSearchResults"
	"frontend/setExtraEventHandlers"
], ($, setEventHandlers, setSearchResultHandlers, connections, generateSearchResults, setExtraEventHandlers) ->

	# Initialise the frontend.
	# This will be called by $(document).ready.

	return ->
		$(window).resize ->
			connections.repaintVariables()
		setEventHandlers()
		generateSearchResults()
		setSearchResultHandlers()
		setExtraEventHandlers()