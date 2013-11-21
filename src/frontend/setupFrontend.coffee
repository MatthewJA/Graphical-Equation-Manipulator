define [
	"jquery"
	"frontend/setDraggables"
	"frontend/setDoubleClickEvents"
	"frontend/setSearchClick"
], ($, setDraggables, setDoubleClickEvents, setSearchClick) ->

	setupFrontend = ->
		# Initialise the frontend.
		# This will be called by $(document).ready.

		setDraggables()
		setDoubleClickEvents()
		setSearchClick()