define [
	"jquery"
	"frontend/solveEquation"
	"frontend/setDraggables"
	"frontend/setDoubleClickEvents"
	"frontend/setSearchClick"
], ($, solveEquation, setDraggables, setDoubleClickEvents, setSearchClick) ->

	setupFrontend = ->
		# Initialise the frontend.
		# This will be called by $(document).ready.

		setDraggables()
		setDoubleClickEvents()
		setSearchClick()