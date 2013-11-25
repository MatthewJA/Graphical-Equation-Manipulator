define ["backend/getExpressions"], (getExpressions) ->

	addExpressionToIndex = (expression) ->
		# Store an expression in the expressions index.
		# expression: The JS-Algebra equation to store as an expression.

		getExpressions().push(expression)