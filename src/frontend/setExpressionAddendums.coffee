define [
	"backend/numericalValues"
	"backend/uncertaintiesIndex"
	"backend/equivalenciesIndex"
	"frontend/settings"
], (numericalValues, uncertaintiesIndex, equivalenciesIndex, settings) ->

	# Add the evaluation and uncertainties to an expression. Side effecting! Doesn't return.

	(expression) ->
		console.log "setting addendums on", expression.toString()
		showSymbolicUncertainties = settings.get("showSymbolicUncertainties")
		variables = expression.right.getAllVariables()
		for variable in variables
			if numericalValues.get(variable)?
				evaluatedExpression = expression.sub(numericalValues.getNumericalValues(), uncertaintiesIndex.getUncertaintyMap(), equivalenciesIndex, settings.get("assumeZeroUncertainty"), true)
				expression._gem_evaluatedExpression = evaluatedExpression
				console.log "set a value"
				break
		console.log "value is", expression._gem_evaluatedExpression?.toString()

		# If we have uncertainties set for any of the variables in this expression, we need to attach those too.
		if showSymbolicUncertainties or expression._gem_evaluatedExpression?
			for otherVariable in variables
				if showSymbolicUncertainties or uncertaintiesIndex.get(otherVariable)?
					uncertaintyExpression = expression.right.getUncertainty().sub(
						numericalValues.getNumericalValues(), uncertaintiesIndex.getUncertaintyMap(), equivalenciesIndex, settings.get("assumeZeroUncertainty"), true)
					expression._gem_uncertaintyExpression = uncertaintyExpression
					break