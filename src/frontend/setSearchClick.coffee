define [
	"jquery"
	"backend/getFormulae"
	"frontend/addEquationToWhiteboard"
	"backend/addEquationToIndex"
], ($, getFormulae, addEquationToWhiteboard, addEquationToIndex) ->

	setSearchClick = (element) ->
		# Set up given search elements/all search elements to be clicked upon.
		# Clicking upon them will add their equation to the whiteboard.
		# element: An element to set events for. Optional.

		if element?
			target = element
		else
			target = $(".search-result")

		target.click ->
			# The name of the equation is the id of the search result.
			equationName = $(@).attr("id")

			# Debug.
			console.log(equationName)

			# Add the equation to the frontend and the backend.
			equation = getFormulae()[equationName]
			addEquationToWhiteboard(equation)
			addEquationToIndex(equation)