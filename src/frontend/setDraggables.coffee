define ["jquery"], ($) ->

	setDraggables = (element) ->
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