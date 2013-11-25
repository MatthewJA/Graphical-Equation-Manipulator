define ["backend/getEquations"], (getEquations) ->

	addEquationToIndex = (equation) ->
		# Store an equation in the equations index.
		# equation: The JS-Algebra equation to store.

		getEquations().push(equation)