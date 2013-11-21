define [
	"jquery"
	"backend/getFormulae"
	"frontend/addEquationToWhiteboard"
	"backend/addEquationToIndex"
], ($, getFormulae, addEquationToWhiteboard, addEquationToIndex) ->

	# Set up given search elements/all search elements to be clicked upon.
	# Clicking upon them will add their equation to the whiteboard.

	setSearchClick = (element) ->
		if element?
			target = element
		else
			target = $(".search-result")

		target.click ->
			equationName = $(@).attr("id")
			console.log(equationName)
			equation = getFormulae()[equationName]
			addEquationToWhiteboard(equation)
			addEquationToIndex(equation)