define ["backend/getEquations"], (getEquations) ->

	solveEquation = (equationID, variable) ->
		# Solve the equation with the given ID for the given variable.
		# equationID: The ID of the equation to solve.
		# variable: The variable to solve for.

		equation = getEquations()[equationID]
		return equation.solve(variable)