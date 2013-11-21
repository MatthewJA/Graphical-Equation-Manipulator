define [
	"jquery"
	"frontend/setDraggables"
	"frontend/setDoubleClickEvents"
	"backend/getEquations"
], ($, setDraggables, setDoubleClickEvents, getEquations) ->
	# Add an equation to the whiteboard. The equation passed in should be a JS-Algebra equation.

	addEquation = (equation) ->
		equationID = getEquations().length # So if we have [Expression0, Expression1] then the length will be 2 and the new ID will be 2.
		html = equation.toGEMHTML(equationID)
		equationDiv = $(html)

		getEquations().push(equation)
		$("#whiteboard-panel").append(equationDiv)
		setDraggables(equationDiv)
		setDoubleClickEvents(equationDiv)