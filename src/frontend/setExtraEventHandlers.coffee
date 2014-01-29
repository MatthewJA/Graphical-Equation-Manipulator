define ["jquery", "frontend/addTextComment"], ($, addTextComment) ->

	# Set event handlers for extra options.

	return ->
		$("#extra-add-comment").click ->
			$.prompt(
				{state0: {
					title: "Enter comment."
					html:'<input type="text" name="comment" value="Physics is great"><br>'
					buttons: {"Okay": 1, "Cancel": -1}
					focus: 0
					submit: (e, v, m, f) ->
						e.preventDefault()
						if v == 1
							comment = f.comment
							addTextComment(comment)
						$.prompt.close()
					}})