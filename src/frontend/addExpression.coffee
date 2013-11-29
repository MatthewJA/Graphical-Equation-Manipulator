define [
	"jquery"
	"frontend/setEventHandlers"
	"frontend/settings"
	"backend/expressionIndex"
], ($, setEventHandlers, settings, expressionIndex) ->

	# Add an expression to the program.
	# This involves adding it to the whiteboard and adding it
	# to the backend.

	addExpressionToWhiteboard = (expression, expressionID) ->
		# Add an expression to the whiteboard.
		# expression: A JS-Algebra equation to add to the whiteboard.

		if settings.mathJaxEnabled
			# Generate the div representing the expression.
			html = expression.toMathML(expressionID, true)
			expressionDiv = $(html)

			# Add the div to the whiteboard.
			$("#whiteboard-panel").append(expressionDiv)

			# Typeset the expression with MathJax, and once that is
			# finished, give the expression its event handlers.
			MathJax.Hub.Queue(["Typeset", MathJax.Hub])
			MathJax.Hub.Queue ->
				# We need to use the queue because typesetting typically
				# returns before it actually finishes typesetting - 
				# and typesetting involves replacing all the HTML for
				# the expression. So we want to add event handlers to the
				# resultant HTML, after typesetting is done.
				setEventHandlers(expressionDiv)
		else
			html = expression.toHTML(expressionID, true)
			expressionDiv = $(html)

			# Add the div to the whiteboard.
			$("#whiteboard-panel").append(expressionDiv)
			setEventHandlers(expressionDiv)

	return (expression) ->
		# expression: The expression to add.
		# -> The ID of the newly-added expression.

		expressionID = expressionIndex.add(expression)
		addExpressionToWhiteboard(expression, expressionID)
		return expressionID