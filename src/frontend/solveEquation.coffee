define [
	"jquery"
	"frontend/setDraggables"
	"frontend/setDoubleClickEvents"
	"backend/solveEquation"
	"backend/getExpressions"
], ($, setDraggables, setDoubleClickEvents, doSolveEquation, getExpressions) ->
	solveEquation = (equationID, variable) ->
		# Solve the equation with the given ID for the given variable.

		newExpressionID = getExpressions().length

		$("#whiteboard-panel").append('<div id="expression-' + newExpressionID + '" class="expression"><span class="variable">' + variable + '</span>' +
			' = <span class="variable">' + variable + '</span></div>')

		getExpressions().push("expression we don't care about")

		setDraggables($("#expression-" + newExpressionID))
		setDoubleClickEvents($("#expression-" + newExpressionID))