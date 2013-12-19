define ["backend/equivalenciesIndex"], (equivalenciesIndex) ->

	# Subsitute one equation into another.

	return (targetEquation, sourceEquation, variable) ->
		# targetEquation: The equation to sub into.
		# sourceEquation: The equation to sub from.
		# variable: Which variable to cancel out.

		return targetEquation.substituteEquation(sourceEquation, variable, equivalenciesIndex)