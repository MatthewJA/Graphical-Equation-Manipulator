define [
	"jquery"
	"backend/getFormula"
	"frontend/addEquation"
], ($, getFormula, addEquation) ->

	# Set up given search elements/all search elements to be clicked upon.
	# Clicking upon them will add their equation to the whiteboard.

	return (element=null) ->
		# element: An element to set events for. Optional.

		if element?
			target = element
		else
			target = $(".search-result")

		target.click ->
			# The name of the equation is the id of the search result.
			equationName = $(@).attr("id")

			# Add the equation to the frontend and the backend.
			equation = getFormula(equationName)
			addEquation(equation)