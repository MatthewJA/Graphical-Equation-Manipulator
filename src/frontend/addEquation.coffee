define [
	"jquery"
	"frontend/setDraggables"
	"frontend/setDoubleClickEvents"
	"backend/nextEquationID"
], ($, setDraggables, setDoubleClickEvents, nextEquationID) ->
	# Add an equation to the whiteboard. The equation passed in should be a JS-Algebra equation.

	addEquation = (equation) ->
		equationID = nextEquationID()
		html = equation.toGEMHTML(equationID)
		equationDiv = $(html)

		$("#whiteboard-panel").append(equationDiv)
		setDraggables(equationDiv)
		setDoubleClickEvents(equationDiv)