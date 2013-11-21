# define [], ->

define ["jquery", "frontend/solveEquation", "frontend/setDraggables", "frontend/setDoubleClickEvents"], ($, solveEquation, setDraggables, setDoubleClickEvents) ->

	setupFrontend = ->
		# Initialise the frontend.
		# This will be called by $(document).ready.

		setDraggables()
		setDoubleClickEvents()