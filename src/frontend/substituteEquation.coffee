define [
	"jquery"
	"frontend/rewrite"
	"backend/substituteEquation"
	"backend/equationIndex"
	"backend/expressionIndex"
	"frontend/addExpression"
], ($, rewrite, substituteEquation, equationIndex, expressionIndex, addExpression) ->

	# Sub an equation into an expression.

	return (targetExpressionID, sourceEquationID, variableID) ->
		# targetEquationID: The ID of the equation to sub into.
		# sourceEquationID: The ID of the equation to sub from.
		# variableID: Which variable to cancel out.

		targetExpression = expressionIndex.get(targetExpressionID)
		sourceEquation = equationIndex.get(sourceEquationID)
		
		subbedEquations = substituteEquation(targetExpression, sourceEquation, variableID)

		rewrite.rewriteExpression(targetExpressionID, subbedEquations[0])
		for expression in subbedEquations[1..]
			addExpression(expression)