define [
	"jquery"
	"backend/getFormula"
	"frontend/addEquation"
], ($, getFormula, addEquation) ->

	# Set up given search elements/all search elements to be dragged onto the whiteboard (or clicked).
	# Clicking upon (or dragging) them will add their equation to the whiteboard.

	initialised = false

	return (element=null) ->
		# element: An element to set events for. Optional.

		if element?
			target = element
		else
			target = $(".search-result")

		unless initialised
			$("#whiteboard-panel").droppable
				tolerance: "pointer"
				accept: ".search-result"

				drop: (event, ui) ->
					equationName = $(ui.draggable).attr("id").split("-")[1..].join("-")

					equation = getFormula(equationName)
					addEquation(equation, ui.position)

			initialised = true

		target.click ->
			# The name of the equation is the id of the search result, minus the formula- prefix.
			equationName = $(@).attr("id").split("-")[1..].join("-")

			# Add the equation to the frontend and the backend.
			equation = getFormula(equationName)
			console.log(equation.toString())
			console.log(equation.toMathML())
			addEquation(equation)

		target.draggable
			helper: "clone"
			appendTo: "#whiteboard-panel"