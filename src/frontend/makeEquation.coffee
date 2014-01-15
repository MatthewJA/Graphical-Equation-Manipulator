define ["frontend/addEquation", "backend/formulae"], (addEquation, formulae) ->

	return (left, right) ->
		equation = formulae.makeEquation(left, right)
		equationID = addEquation(equation)
		return [equationID, equation]