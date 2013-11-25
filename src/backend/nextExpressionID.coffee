define ["backend/getExpressions"], (getExpressions) ->

	nextExpressionID = ->
		# Return the next available expression ID.

		return getExpressions().length # So if we have [Expression-0, Expression-1] then the length will be 2 and the new ID will be 2.