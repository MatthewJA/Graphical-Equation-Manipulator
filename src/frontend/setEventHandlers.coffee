define ["jquery", "require"], ($, require) ->

	# Set the event handlers of either a specific element
	# or every element on the page.

	setDraggables = (element=null) ->
		# Set equations and expressions to be dragged around.
		# element: An element to set events for. Optional.		

		draggableProperties =
			# Constrain movement to within the whiteboard.
			containment: "#whiteboard-panel"
			scroll: false

			# Ensure only non-variable parts can be dragged.
			cancel: ".variable"

		if element?
			element.draggable(draggableProperties)
		else
			$(".equation").draggable(draggableProperties)
			$(".expression").draggable(draggableProperties)

	setDoubleClickEvents = (element=null) ->
		# Set events to happen upon double-clicking.
		# element: An element to set events for. Optional.

		if element?
			target = $(element).find(".variable")
		else
			target = $(".variable")

		target.doubletap ->
			variable = $(@).text()

			# What equation/expression was the variable we clicked in?
			formulaID = $(@).parents("div").attr("id")

			# The ID of an equation should be of the form "equation-n" where n is an integer.
			# The ID of an expression should be of the form "expression-n" in the same way.
			[formulaType, formulaNumber] = formulaID.split("-")

			# Debug output.
			console.log("Double-clicked " + variable + " in " + formulaType + " " + formulaNumber)

			if formulaType == "equation"
				require [
					"backend/solveEquation"
					"frontend/addExpression"
				], (solveEquation, addExpression) ->
					expression = solveEquation(formulaNumber, variable)
					addExpression(expression)
		
		# Disable highlighting on variables.
		target.disableSelection()

	return (element=null) ->
		# element: An element to set events for. Optional.

		setDraggables(element)
		setDoubleClickEvents(element)