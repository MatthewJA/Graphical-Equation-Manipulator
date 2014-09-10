# Setup event handlers for various elements.

define ["jquery"], ($) ->

	# Properties of draggable equations and expressions.
	draggableProperties =
		# Constrain movement within the whiteboard.
		containment: "#whiteboard"
		scroll: false

		# Ensure only non-variable parts can be dragged.
		cancel: ".variable"

		# Called upon drag.
		drag: (event, ui) ->

		# Called upon stopping dragging.
		stop: (event, ui) ->

	# Set event handlers on an equation and its components.
	#
	# @param element [$.Element] An element to set event handlers for.
	equation = (element) ->
		# Set draggable.
		# element.draggable(draggableProperties)
		console.log element
		element.draggable()

	# Set event handlers on an expression and its components.
	#
	# @param element [$.Element] An element to set event handlers for.
	expression = (element) ->
		# Set draggable.
		element.draggable(draggableProperties)

	return {
		equation: equation
		expression: expression
	}