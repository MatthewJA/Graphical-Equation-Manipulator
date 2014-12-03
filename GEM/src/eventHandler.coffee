# Setup event handlers for various elements.

define ["jquery"], ($) ->

	# Properties of draggable equations and expressions.
	draggableFormulaProperties =
		# Constrain movement within the whiteboard.
		containment: "#whiteboard"
		scroll: false

		# Ensure only non-variable parts can be dragged.
		cancel: ".variable"

		# Called upon starting dragging.
		start: (event, ui) ->

		# Called upon drag.
		drag: (event, ui) ->

		# Called upon stopping dragging.
		stop: (event, ui) ->
			$(@).css("left",
				"#{parseInt($(@).css("left"))/($("#whiteboard").width()/100)}%")
			$(@).css("top",
				"#{parseInt($(@).css("top"))/($("#whiteboard").height()/100)}%")

	draggableVariableProperties =
		# Constrain movement within the whiteboard.
		containment: "#whiteboard"
		scroll: false

		# Revert position if we drop in the wrong spot.
		revert: true

		# Called upon starting dragging.
		start: (event, ui) ->

		# Called upon drag.
		drag: (event, ui) ->

		# Called upon stopping dragging.
		stop: (event, ui) ->

	# Event handler for mousedown on draggable equations and expressions.
	mousedownHandler = (event) ->
		$(event.target).css("cursor", "grabbing")

	mouseupHandler = (event) ->
		$(event.target).css("cursor", "grab")

	# Set event handlers on an equation and its components.
	#
	# @param element [$.Element] An element to set event handlers for.
	equation = (element) ->
		# Set draggable.
		element.draggable(draggableFormulaProperties)
		element.mousedown(mousedownHandler)
		element.mouseup(mouseupHandler)
		element.find(".variable").draggable(draggableVariableProperties)

	# Set event handlers on an expression and its components.
	#
	# @param element [$.Element] An element to set event handlers for.
	expression = (element) ->
		# Set draggable.
		element.draggable(draggableFormulaProperties)
		element.mousedown(mousedownHandler)
		element.mouseup(mouseupHandler)
		element.find(".variable").draggable(draggableVariableProperties)

	return {
		equation: equation
		expression: expression
	}