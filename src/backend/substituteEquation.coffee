define ["backend/equivalenciesIndex"], (equivalenciesIndex) ->

	# Subsitute one equation into another.

	return (targetEquation, sourceExpression, variable) ->
		# targetExpression: The expression to sub into.
		# sourceExpression: The expression to sub from.
		# variable: Which variable to cancel out.

		return targetEquation.substituteExpression(sourceExpression, variable, equivalenciesIndex)