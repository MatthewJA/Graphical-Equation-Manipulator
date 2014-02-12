define [
	"jquery"
	"frontend/setEventHandlers"
	"frontend/settings"
	"backend/expressionIndex"
	"require"
	"backend/numericalValues"
	"backend/uncertaintiesIndex"
	"backend/equivalenciesIndex"
	"frontend/expressionToString"
], ($, setEventHandlers, settings, expressionIndex, require, numericalValues, uncertaintiesIndex, equivalenciesIndex, expressionToString) ->

	# Add an expression to the program.
	# This involves adding it to the whiteboard and adding it
	# to the backend.

	addExpressionToWhiteboard = (expression, expressionID, position=null) ->
		# Add an expression to the whiteboard.
		# expression: A Coffeequate equation to add to the whiteboard.
		# position: {top, left} position to add the expression. Optional.

		if settings.get("mathJaxEnabled")
			# Generate the div representing the expression.
			html = expressionToString(expression, expressionID)
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
			html = expressionToString(expression, expressionID)
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

		# If we have values set for any of the variables in this expression, we need to attach an evaluated version of the expression.
		variables = expression.right.getAllVariables()
		for variable in variables
			console.log numericalValues
			if numericalValues.get(variable)?
				evaluatedExpression = expression.sub(numericalValues.getNumericalValues(), uncertaintiesIndex.getUncertaintyMap(), equivalenciesIndex)
				expression._gem_evaluatedExpression = evaluatedExpression

				# If we have uncertainties set for any of the variables in this expression, we need to attach those too.
				for otherVariable in variables
					if uncertaintiesIndex.get(otherVariable)?
						uncertaintyExpression = expression.right.getUncertainty().sub(
							numericalValues.getNumericalValues(), uncertaintiesIndex.getUncertaintyMap(), equivalenciesIndex)
						expression._gem_uncertaintyExpression = uncertaintyExpression
						break
				break

		addExpressionToWhiteboard(expression, expressionID)
		return expressionID