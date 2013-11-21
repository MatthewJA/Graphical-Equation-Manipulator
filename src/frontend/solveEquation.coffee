define [
	"jquery"
	"frontend/addExpression"
	"backend/solveEquation"
	"backend/nextExpressionID"
	"backend/getEquations"
], ($, setDraggables, setDoubleClickEvents, doSolveEquation, nextExpressionID, getEquations) ->
	solveEquation = (equationID, variable) ->
		# Solve the equation with the given ID for the given variable.

		newExpressionID = nextExpressionID()
		expression = getEquations()[equationID] # Debugging.
		addFrontendExpression(expression)
		addBackendExpression(expression)