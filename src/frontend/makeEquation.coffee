define ["frontend/addEquation", "backend/formulae"], (addEquation, formulae) ->

	return (left, right, add=false) ->
		equation = formulae.makeEquation(left, right)
		if add
			equationID = addEquation(equation)
		return [equationID, equation]