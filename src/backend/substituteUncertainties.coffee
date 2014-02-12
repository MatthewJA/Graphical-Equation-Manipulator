define [
	"backend/uncertaintiesIndex"
	"backend/equationIndex"
	"backend/expressionIndex"
	"backend/numericalValues"
	"backend/equivalenciesIndex"
], (uncertaintiesIndex, equationIndex, expressionIndex, numericalValues, equivalenciesIndex)->

	# Substitute uncertainties into an equation and return the MathML or HTML representation of it.

	toMathML: (equationID, expression) ->
		if expression
			equation = expressionIndex.get(equationID)
		else
			equation = equationIndex.get(equationID)
		uncertaintyMap = uncertaintiesIndex.getUncertaintyMap()
		values = numericalValues.getNumericalValues()

		subbedEquation = equation.sub(values, uncertaintyMap, equivalenciesIndex)
		uncertainties = equation.right.getUncertainty().sub(values, uncertaintyMap, equivalenciesIndex)

		console.log("calling toMathML on subbedEquation")
		subbedEquationString = subbedEquation.toMathML(equationID, expression, "0", true)

		# We get rid of the "</math></div>" at the end of the string
		subbedEquationString = subbedEquationString.slice(0, subbedEquationString.length - 13)

		console.log("calling toMathML on uncertainties")
		uncertaintiesString = uncertainties.toMathML(equationID, expression, "0", false)

		return (subbedEquationString + "<mo>&PlusMinus;</mo>" + uncertaintiesString + "</math></div>")

	toHTML: (equationID, expression) ->
		if expression
			equation = expressionIndex.get(equationID)
		else
			equation = equationIndex.get(equationID)
		uncertaintyMap = uncertaintiesIndex.getUncertaintyMap()
		values = numericalValues.getNumericalValues()

		return "<div>"
