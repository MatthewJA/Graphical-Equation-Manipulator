define ["backend/equationIndex"], (equationIndex) ->

	# Solve the equation with the given ID for the given variable.

	solveEquation = (equationID, variable) ->
		# equationID: The ID of the equation to solve.
		# variable: The variable to solve for.
		# -> The solved JS-Algebra equation.

		equation = equationIndex.get(equationID)
		return equation.solve(variable)