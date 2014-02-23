define [
	"backend/equationIndex"
	"backend/equivalenciesIndex"
	"backend/expressionIndex"
	"backend/numericalValues"
	"backend/uncertaintiesIndex"
	"backend/variableIndex"
], (equationIndex, equivalenciesIndex, expressionIndex, numericalValues, uncertaintiesIndex, variableIndex) ->
	->
		equationIndex.clear()
		equivalenciesIndex.clear()
		expressionIndex.clear()
		numericalValues.clear()
		uncertaintiesIndex.clear()
		variableIndex.clear()