define ->

	# Store the uncertainty of variables.

	uncertainties = {}

	return {
		set: (variable, uncertainty) ->
			uncertainties[variable] = uncertainty

		get: (variable) ->
			if variable of uncertainties
				return uncertainties[variable]
			else
				return null

		getExpression: (variable) ->
			return uncertaintyExpressions[variable]

		getUncertaintyMap: ->
			return uncertainties

		clear: ->
			# Clear the index.
			for prop of uncertainties
				if uncertainties.hasOwnProperty(prop)
					delete uncertainties[prop]

	}