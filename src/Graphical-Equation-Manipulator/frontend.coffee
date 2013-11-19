$ = jQuery

$(document).ready ->
	setDraggables()

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