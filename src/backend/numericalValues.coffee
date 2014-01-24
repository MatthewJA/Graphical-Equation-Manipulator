define ->

	# Store the value of variables.

	values = {}
	valueExpressions = {} # Store IDs of expressions that show the value of variables.

	return {
		set: (variable, value, expr) ->
			values[variable] = value
			valueExpressions[variable] = expr # ID

		get: (variable) ->
			if variable of values
				return value[variable]
			else
				return null

		getExpression: (variable) ->
			return valueExpressions[variable]

		getNumericalValues: ->
			return values

	}