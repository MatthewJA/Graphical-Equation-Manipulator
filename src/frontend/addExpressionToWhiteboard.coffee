define [
	"jquery"
	"frontend/setDraggables"
	"frontend/setDoubleClickEvents"
	"backend/nextExpressionID"
], ($, setDraggables, setDoubleClickEvents, nextExpressionID) ->

	addExpressionToWhiteboard = (expression) ->
		# Add an expression to the whiteboard.
		# expression: A JS-Algebra equation to add to the whiteboard as an expression.

		# Generate the HTML representing the expression.
		expressionID = nextExpressionID()
		html = expression.toMathML(expressionID, true)
		expressionDiv = $(html)

		# Add the HTML to the page.
		$("#whiteboard-panel").append(expressionDiv)
		
		# Typeset the equation with MathJax, and once that is finished,
		# give the equation its event handlers.
		MathJax.Hub.Queue(["Typeset",MathJax.Hub])
		MathJax.Hub.Queue ->
			# We use the queue because typesetting returns before it actually finishes
			# typesetting, and typesetting involves replacing all of the HTML we generated
			# with spans which the event handlers will have to hook into.
			setDraggables(expressionDiv)
			setDoubleClickEvents(expressionDiv)