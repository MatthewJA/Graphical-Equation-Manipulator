define ["backend/getEquations"], (getEquations) ->
	nextEquationID = ->
		getEquations().length # So if we have [Equation0, Equation1] then the length will be 2 and the new ID will be 2.