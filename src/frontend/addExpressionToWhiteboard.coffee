define [
	"jquery"
	"frontend/setDraggables"
	"frontend/setDoubleClickEvents"
	"backend/nextExpressionID"
], ($, setDraggables, setDoubleClickEvents, nextExpressionID) ->
	# Add an expression to the whiteboard. The expression passed in should be a JS-Algebra equation.

	addExpression = (expression) ->
		expressionID = nextExpressionID()
		html = expression.toMathML(expressionID, true)
		expressionDiv = $(html)

		$("#whiteboard-panel").append(expressionDiv)
		setDraggables(expressionDiv)
		setDoubleClickEvents(expressionDiv)

		MathJax.Hub.Queue(["Typeset",MathJax.Hub])