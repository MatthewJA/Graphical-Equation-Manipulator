define [
	"jquery"
	"frontend/setEventHandlers"
	"frontend/setSearchResultHandlers"
], ($, setEventHandlers, setSearchResultHandlers) ->

	# Initialise the frontend.
	# This will be called by $(document).ready.

	return ->
		setEventHandlers()
		setSearchResultHandlers()