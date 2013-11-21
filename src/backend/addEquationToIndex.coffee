define ["backend/getEquations"], (getEquations) ->
	addEquation = (equation) ->
		getEquations().push(equation)