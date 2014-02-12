define [
	"jquery"
	"frontend/setEventHandlers"
	"frontend/settings"
	"backend/expressionIndex"
	"require"
], ($, setEventHandlers, settings, expressionIndex, require) ->

	# Add an expression to the program.
	# This involves adding it to the whiteboard and adding it
	# to the backend.

	addExpressionToWhiteboard = (expression, expressionID, position=null) ->
		# Add an expression to the whiteboard.
		# expression: A Coffeequate equation to add to the whiteboard.
		# position: {top, left} position to add the expression. Optional.

		# If expression is a string, use that string as html instead of generating the HTML automatically.

		if settings.get("mathJaxEnabled")
			# Generate the div representing the expression.
			if expression instanceof String or typeof expression == "string"
				html = expression
			else
				html = expression.toMathML(expressionID, true, "0", true)
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
				require ["frontend/setEventHandlers"], (setEventHandlers) ->
					setEventHandlers(expressionDiv)
				unless position?
					padding = 10
					position =
						top: Math.floor(Math.random() * Math.max(0, $("#whiteboard-panel").height()-expressionDiv.height()-padding) + padding +
							$("#whiteboard-panel").offset().top)
						left: Math.floor(Math.random() * Math.max(0, $("#whiteboard-panel").width()-expressionDiv.width()-padding) + padding +
							$("#whiteboard-panel").offset().left)
				$(expressionDiv).css
					top: "#{position.top}px"
					left: "#{position.left}px"
					position: "absolute"
		else
			if expression instanceof String or typeof expression == "string"
				html = expression
			else
				html = expression.toHTML(expressionID, true, "0", true)
			expressionDiv = $(html)

			# Add the div to the whiteboard.
			$("#whiteboard-panel").append(expressionDiv)
			require ["frontend/setEventHandlers"], (setEventHandlers) ->
				setEventHandlers(expressionDiv)
			unless position?
				padding = 10
				position =
					top: Math.floor(Math.random() * Math.max(0, $("#whiteboard-panel").height()-expressionDiv.height()-padding) + padding +
						$("#whiteboard-panel").offset().top)
					left: Math.floor(Math.random() * Math.max(0, $("#whiteboard-panel").width()-expressionDiv.width()-padding) + padding +
						$("#whiteboard-panel").offset().left)
			$(expressionDiv).css
				top: "#{position.top}px"
				left: "#{position.left}px"
				position: "absolute"

	return (expression) ->
		# expression: The expression to add.
		# -> The ID of the newly-added expression.

		expressionID = expressionIndex.add(expression)
		addExpressionToWhiteboard(expression, expressionID)
		return expressionID