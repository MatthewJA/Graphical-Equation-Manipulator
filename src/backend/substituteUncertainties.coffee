define ["backend/uncertaintiesIndex", "backend/equationIndex", "backend/numericalValues"], (uncertaintiesIndex, equationIndex, numericalValues)->

	# Substitute uncertainties into an equation and return the MathML or HTML representation of it.

	toMathML: (equationID, expression) ->
		equation = equationIndex.get(equationID)
		uncertaintyMap = uncertaintiesIndex.getUncertaintyMap()
		values = numericalValues.getNumericalValues()

		return "<math>"

	toHTML: (equationID, expression) ->
		equation = equationIndex.get(equationID)
		uncertaintyMap = uncertaintiesIndex.getUncertaintyMap()
		values = numericalValues.getNumericalValues()

		return "<div>"