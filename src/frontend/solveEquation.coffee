define [
	"jquery"
	"frontend/addExpression"
	"backend/addExpression"
	"backend/solveEquation"
	"backend/nextExpressionID"
	"backend/getEquations"
], ($, addExpressionToWhiteboard, addExpressionToIndex, doSolveEquation, nextExpressionID, getEquations) ->
	solveEquation = (equationID, variable) ->
		# Solve the equation with the given ID for the given variable.

		newExpressionID = nextExpressionID()
		expression = getEquations()[equationID] # Debugging.
		addExpressionToWhiteboard(expression)
		addExpressionToIndex(expression)