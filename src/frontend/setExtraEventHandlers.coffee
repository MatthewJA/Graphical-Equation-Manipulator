define ["jquery", "frontend/addTextComment", "frontend/updateSearchResults"], ($, addTextComment, updateSearchResults) ->

	# Set event handlers for extra options and fields.

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

		$("#search-box").on "change keyup paste", ->
			condition = (z) -> (new RegExp($("#search-box").val())).test(z)
			updateSearchResults(condition)