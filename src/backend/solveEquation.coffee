define ["backend/equationIndex"], (equationIndex) ->

	# Solve the equation with the given ID for the given variable.

	solveEquation = (equationID, variable) ->
		# equationID: The ID of the equation to solve.
		# variable: The variable to solve for.
		# -> The solved Coffeequate equation.

		equation = equationIndex.get(equationID)
		console.log "solution is #{equation.solve(variable)}"
		return equation.solve(variable)