define ["jquery", "frontend/addTextComment", "frontend/updateSearchResults", "frontend/settings"], ($, addTextComment, updateSearchResults, settings) ->

	# Set event handlers for extra options and fields.

	return ->
		$("#extra-add-comment").click ->
			$.prompt(
				{state0: {
					title: "Enter comment."
					html:'<input type="text" name="comment" value="Physics is great"><br>'
					buttons: {"Okay": 1, "Cancel": -1}
					focus: "input[name='comment']"
					submit: (e, v, m, f) ->
						e.preventDefault()
						if v == 1
							comment = f.comment
							addTextComment(comment)
						$.prompt.close()
					}})

		$("#extra-uncertainties").click ->
			$(@).toggleClass("button-down")
			settings.set("showSymbolicUncertainties", not settings.get("showSymbolicUncertainties"))
			settings.set("assumeZeroUncertainty", not settings.get("assumeZeroUncertainty"))

		$("#search-box").on "change keyup paste", ->
			condition = (z) -> (new RegExp($("#search-box").val())).test(z)
			updateSearchResults(condition)