# define [], ->

define ["jquery", "frontend/solveEquation"], ($, solveEquation) ->

	setupFrontend = ->
		# Initialise the frontend.
		# This will be called by $(document).ready.

		setDraggables = ->
			# Set equations and expressions to be dragged around.
			# They should only be able to be dragged from non-variable parts.

			draggableProperties =
				# Constrain movement to within the whiteboard.
				containment: "#whiteboard-panel"
				scroll: false

				# Ensure only non-variable parts can be dragged.
				cancel: ".variable"

			$(".equation").draggable(draggableProperties)
			$(".expression").draggable(draggableProperties)

		setDoubleClickEvents = ->
			# Set things to happen upon double-clicking.

			$(".variable").dblclick ->
				# What variable was clicked?
				variable = $(@).text()

				# What equation/expression was it in?
				formulaID = $(@).parent().attr("id")
				# The ID of an equation should be of the form "equation-n" where n is an integer.
				# The ID of an expression should be of the form "expression-n" in the same way.
				[formulaType, formulaNumber] = formulaID.split("-")

				console.log("Double-clicked " + variable + " in " + formulaType + " " + formulaNumber)

				# solveEquation()

			# Disable highlighting on variables.
			$(".variable").disableSelection()

		setDraggables()
		setDoubleClickEvents()