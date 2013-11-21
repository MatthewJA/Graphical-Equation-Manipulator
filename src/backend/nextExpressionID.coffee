define ["backend/getExpressions"], (getExpressions) ->
	nextExpressionID = ->
		getExpressions().length # So if we have [Expression0, Expression1] then the length will be 2 and the new ID will be 2.