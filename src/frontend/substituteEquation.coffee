define [
	"jquery"
	"frontend/rewrite"
	"backend/substituteEquation"
	"backend/equationIndex"
	"backend/expressionIndex"
], ($, rewrite, substituteEquation, equationIndex, expressionIndex) ->

	# Sub an equation into an expression.

	return (targetExpressionID, sourceEquationID, variableID) ->
		# targetEquationID: The ID of the equation to sub into.
		# sourceEquationID: The ID of the equation to sub from.
		# variableID: Which variable to cancel out.

		targetExpression = expressionIndex.get(targetExpressionID)
		sourceEquation = equationIndex.get(sourceEquationID)
		
		subbedEquation = substituteEquation(targetExpression, sourceEquation, variableID)
		rewrite.rewriteExpression(targetExpressionID, subbedEquation)