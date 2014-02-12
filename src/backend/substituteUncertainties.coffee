define ["backend/uncertaintiesIndex", "backend/equationIndex", "backend/numericalValues"], (uncertaintiesIndex, equationIndex, numericalValues)->

	# Substitute uncertainties into an equation and return the MathML or HTML representation of it.

	toMathML: (equationID, expression) ->
		equation = equationIndex.get(equationID)
		uncertaintyMap = uncertaintiesIndex.getUncertaintyMap()
		values = numericalValues.getNumericalValues()

		subbedEquation = equation.sub(values, {}, [])
		uncertainties = equation.right.getUncertainty().sub(values, uncertaintyMap, {})

		subbedEquationString = subbedEquation.toMathML(equationID, true, "0", true)

		# We get rid of the "</math></div>" at the end of the string
		subbedEquationString = subbedEquationString.slice(0, subbedEquationString.length - 13)

		uncertaintiesString = uncertainties.toMathML(equationID, true, "0", false)

		return (subbedEquationString + "&PlusMinus;" + uncertaintiesString + "</math></div>")

	toHTML: (equationID, expression) ->
		equation = equationIndex.get(equationID)
		uncertaintyMap = uncertaintiesIndex.getUncertaintyMap()
		values = numericalValues.getNumericalValues()

		return "<div>"