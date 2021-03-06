define [
	"jquery"
	"frontend/setEventHandlers"
	"frontend/settings"
	"backend/expressionIndex"
	"require"
	"frontend/setExpressionAddendums"
	"frontend/expressionToString"
], ($, setEventHandlers, settings, expressionIndex, require, setExpressionAddendums, expressionToString) ->

	# Add an expression to the program.
	# This involves adding it to the whiteboard and adding it
	# to the backend.

	setupExpressionDiv = (expressionDiv) ->
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

	addExpressionToWhiteboard = (expression, expressionID, position=null) ->
		# Add an expression to the whiteboard.
		# expression: A Coffeequate equation to add to the whiteboard.
		# position: {top, left} position to add the expression. Optional.

		# Generate the div representing the expression.
		html = expressionToString(expression, expressionID)
		expressionDiv = $(html)

		# Add the div to the whiteboard.
		$("#whiteboard-panel").append(expressionDiv)

		if settings.get("mathJaxEnabled")
			# Typeset the expression with MathJax, and once that is
			# finished, give the expression its event handlers.
			MathJax.Hub.Queue(["Typeset", MathJax.Hub])
			MathJax.Hub.Queue ->
				# We need to use the queue because typesetting typically
				# returns before it actually finishes typesetting - 
				# and typesetting involves replacing all the HTML for
				# the expression. So we want to add event handlers to the
				# resultant HTML, after typesetting is done.
				setupExpressionDiv(expressionDiv)
		else
			setupExpressionDiv(expressionDiv)


	return (expression, units=null) ->
		# expression: The expression to add.
		# -> The ID of the newly-added expression.

		expressionID = expressionIndex.add(expression)

		# If we have values set for any of the variables in this expression, we need to attach an evaluated version of the expression.
		setExpressionAddendums(expression)

		# If units are set then they need to be applied to the expression.
		expression._gem_units = units

		addExpressionToWhiteboard(expression, expressionID)
		return expressionID