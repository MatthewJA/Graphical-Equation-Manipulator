define ->

	# Stores the expressions known to the program in a singleton array.
	# Each expression has an ID which refers to its position in the array.
	# ...Of course, it's a remarkably bad idea to splice this array. Don't do that.

	expressions = []

	return {
		add: (expression) ->
			# Store an expression in the expressions index.
			# expression: The JS-Algebra equation to store as an expression.
			# -> The ID of the newly-stored expression.

			expressions.push(expression)
			return expressions.length - 1

		get: (expressionID) ->
			# Return the expression associated with the given ID.
			# expressionID: The ID of the expression to return.
			# -> The expression with the given ID.

			return expressions[expressionID]

		size: ->
			# Return the number of expressions in the index.
			# -> The number of expressions.

			return expressions.length
	}