define ["jquery", "frontend/setDraggables", "frontend/setDoubleClickEvents"], ($, setDraggables, setDoubleClickEvents) ->
	solveEquation = (equationID, variable) ->
		# Solve the equation with the given ID for the given variable.

		$("#whiteboard-panel").append('<div id="expression-2" class="expression"><span class="variable">' + variable + '</span>' +
			' = <span class="variable">' + variable + '</span></div>')

		setDraggables($("#expression-2"))
		setDoubleClickEvents($("#expression-2"))