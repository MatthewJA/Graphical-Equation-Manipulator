define [
	"backend/equationIndex"
	"backend/equivalenciesIndex"
	"backend/expressionIndex"
	"backend/numericalValues"
	"backend/uncertaintiesIndex"
	"backend/variableIndex"
], (equationIndex, equivalenciesIndex, expressionIndex, numericalValues, uncertaintiesIndex, variableIndex) ->
	->
		# Do nothing. Disabled all this for now because for some reason it bugs out and won't let
		# you join variables you've joined previously.
		# equationIndex.clear()
		# equivalenciesIndex.clear()
		# expressionIndex.clear()
		# numericalValues.clear()
		# uncertaintiesIndex.clear()
		# variableIndex.clear()