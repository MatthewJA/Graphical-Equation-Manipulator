define ["jquery", "frontend/settings", "require"], ($, settings, require) ->

	# Set the event handlers of either a specific element
	# or every element on the page.

	setEquationDraggables = (element=null) ->
		# Set equations and expressions to be dragged around.
		# element: A formula (expression or equation div) to set events for. Optional.		

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
		# element: A formula (expression or equation div) to set events for. Optional.

		if element?
			target = $(element).find(".variable")
		else
			target = $(".variable")

		target.doubletap ->
			[variable, formulaType, formulaID] = getInfo($(@))

			# Debug output.
			console.log("Double-clicked " + variable + " in " + formulaType + " " + formulaID)

			if formulaType == "equation"
				require [
					"backend/solveEquation"
					"frontend/addExpression"
				], (solveEquation, addExpression) ->
					expression = solveEquation(formulaID, variable)
					addExpression(expression)
		
		# Disable highlighting on variables.
		target.disableSelection()

	setVariableDraggables = (element=null) ->
		# Set variables to have drag events such that you can drag one variable to another variable to equate them.
		# element: A formula (expression or equation div) to set events for. Optional.

		if element?
			target = $(element).find(".variable")
		else
			target = $(".variable")

		target.draggable
			start: (event, ui) ->
				# Add CSS to make the helper look like the draggable target.
				if $(event.target).parents(".equation").length != 0
					# Target is an equation variable.
					$(ui.helper).addClass("equationVariableHelper");
				else if $(event.target).parents(".expression").length != 0
					# Target is an expression variable.
					$(ui.helper).addClass("expressionVariableHelper");

				$(ui.helper).css("font-size", $(event.target).css("font-size"))

				unless settings.get("mathJaxEnabled")
					$(ui.helper).css("font-family", "monospace")

				# Hide the original variable we are dragging.
				$(event.target).fadeTo(0, 0)

			drag: (event, ui) ->
				# do drag stuff:
				# update the line element?

			stop: (event, ui) ->
				# fix the line element to whatever we dropped it on

				# Show the original variable we are dragging.
				$(event.target).fadeTo(0, 1)

			containment: "#whiteboard-panel"

			revert: true
			helper: "clone"
			appendTo: "#whiteboard-panel"

		target.droppable
			tolerance: "pointer"
			accept: ".variable"

			drop: (event, ui) ->
				[droppableID, droppableFormulaType, droppableFormulaID] = getInfo($(event.target))
				[draggableID, draggableFormulaType, draggableFormulaID] = getInfo($(ui.draggable))

				if droppableFormulaType == "equation" and draggableFormulaType == "equation"
					# Set an equivalency between this variable and the other variable.
					colour = "rgb(#{Math.floor(Math.random()*256)}, #{Math.floor(Math.random()*256)}, #{Math.floor(Math.random()*256)})"
					$(event.target).css("color", colour)
					$(ui.draggable).css("color", colour)
					$(ui.helper).css("color", colour)

	getInfo = (variableElement) ->
		# Get information about the variable represented by the given element.
		# vairableElement: A jQuery element representing a variable.
		# -> [variableID, formulaType, formulaID]
		variable = variableElement.attr("id") # The ID of the variable element is also the variableID, but the element ID
		# has an extra "variable-" appended to the start.

		if /variable-/.test(variable)
			variable = variable.split("-")[1..].join("-")

		# What equation/expression was the variable we clicked in?
		formulaID = variableElement.parents("div").attr("id")

		# The ID of an equation should be of the form "equation-n" where n is an integer.
		# The ID of an expression should be of the form "expression-n" in the same way.
		[formulaType, formulaNumber] = formulaID.split("-")

		return [variable, formulaType, formulaNumber]

	return (element=null) ->
		# element: A formula (expression or equation div) to set events for. Optional.

		setEquationDraggables(element)
		setDoubleClickEvents(element)
		setVariableDraggables(element)