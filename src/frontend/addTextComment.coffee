define ["jquery"], ($) ->

	# Add a text comment to the screen.

	return (comment) ->
		c = $('<div class="text-comment" />')
		c.text(comment)
		c.html(c.html().replace("\\\\", "<br>"))
		$("#whiteboard-panel").append(c)
		c.draggable
			containment: "#whiteboard-panel"
			scroll: false
		c.contextMenu("context-menu-text-comment", {
			"Delete comment":
				click: (element) ->
					element.remove()
			"Edit comment":
				click: (element) ->
					$.prompt(
						{state0: {
							title: "Enter comment."
							html:'<input type="text" name="comment" value="' + element.html() + '"><br>'
							buttons: {"Okay": 1, "Cancel": -1}
							focus: 0
							submit: (e, v, m, f) ->
								e.preventDefault()
								if v == 1
									element.html(f.comment.replace("\\\\", "<br>"))
									$.prompt.close()
								else
									$.prompt.close()
							}
						state1: {
							title: "Please enter a number."
							buttons: {"Okay": 1, "Cancel": -1}
							focus: 0
							submit: (e, v, m, f) ->
								e.preventDefault()
								if v == 1
									$.prompt.prevState()
								else
									$.prompt.close()
							}})
			},
			{
				disable_native_context_menu: true
				leftClick: false
			}
		)