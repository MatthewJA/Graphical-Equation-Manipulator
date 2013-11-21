define ["backend/getExpressions"], (getExpressions) ->
	addExpression = (expression) ->
		getExpressions().push(expression)