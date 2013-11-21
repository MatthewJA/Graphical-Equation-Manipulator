define ["backend/getEquations"], (getEquations) ->
	solveEquation = (equationID, variable) ->
		# Solve the equation with the given ID for the given variable.
		equation = getEquations()[equationID]
		equation.solve(variable)