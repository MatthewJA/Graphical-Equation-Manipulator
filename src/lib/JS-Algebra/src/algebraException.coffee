define [], ->
	class AlgebraException
		constructor: (@message) ->
		toString: ->
			"AlgebraException: " + @message