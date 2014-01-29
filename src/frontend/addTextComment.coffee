define ["jquery"], ($) ->

	# Add a text comment to the screen.

	return (comment) ->
		c = $('<div class="text-comment" />')
		c.text(comment)
		$("#whiteboard-panel").append(c)
		c.draggable
			containment: "#whiteboard-panel"
			scroll: false