define ["backend/getEquations"], (getEquations) ->

	nextEquationID = ->
		# Return the next available equation ID.

		return getEquations().length # So if we have [Equation-0, Equation-1] then the length will be 2 and the new ID will be 2.