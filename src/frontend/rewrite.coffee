define [
	"jquery"
	"frontend/setEventHandlers"
	"frontend/settings"
	"backend/expressionIndex"
	"backend/equationIndex"
	"require"
	"frontend/setExpressionAddendums"
	"frontend/expressionToString"
], ($, setEventHandlers, settings, expressionIndex, equationIndex, require, setExpressionAddendums, expressionToString) ->

	rewriteEquation = (equationID, newEquation) ->
		# Rewrite the equation with the given ID as a new equation.
		if settings.get("mathJaxEnabled")
			# Generate the div representing the equation.
			html = newEquation.toMathML(equationID, false, "0", true)
			equationDiv = $(html)
			position = $("#equation-#{equationID}").position()

			# Add the div to the whiteboard.
			$("#equation-#{equationID}").replaceWith(equationDiv)

			# Typeset the equation with MathJax, and once that is
			# finished, give the equation its event handlers.
			MathJax.Hub.Queue(["Typeset", MathJax.Hub])
			MathJax.Hub.Queue ->
				# We need to use the queue because typesetting typically
				# returns before it actually finishes typesetting - 
				# and typesetting involves replacing all the HTML for
				# the equation. So we want to add event handlers to the
				# resultant HTML, after typesetting is done.
				$("#equation-#{equationID}").css
					top: "#{position.top}px"
					left: "#{position.left}px"
					position: "absolute"
				require ["frontend/setEventHandlers"], (setEventHandlers) ->
					setEventHandlers(equationDiv)
		else
			html = equation.toHTML(equationID, false, "0", true)
			equationDiv = $(html)

			# Add the div to the whiteboard.
			$("#equation-#{equationID}").replaceWith(equationDiv)
			$("#equation-#{equationID}").css
				top: "#{position.top}px"
				left: "#{position.left}px"
				position: "absolute"
			require ["frontend/setEventHandlers"], (setEventHandlers) ->
				setEventHandlers(equationDiv)

		equationIndex.set(equationID, newEquation)

	rewriteExpression = (expressionID, newExpression) ->
		# Rewrite the expression with the given ID as a new expression.
		exp = expressionIndex.get(expressionID)

		# Recalculate the addendums.
		oldGemEvaluatedExpression = exp._gem_evaluatedExpression?.copy()
		oldGemUncertaintyExpression = exp._gem_uncertaintyExpression?.copy()
		setExpressionAddendums(newExpression)

		evaluationUnchanged = (if oldGemEvaluatedExpression? then \
			oldGemEvaluatedExpression.equals(newExpression._gem_evaluatedExpression) else \
			oldGemEvaluatedExpression == newExpression._gem_evaluatedExpression)
		uncertaintyUnchanged = (if oldGemUncertaintyExpression? then \
			oldGemUncertaintyExpression.equals(newExpression._gem_UncertaintyExpression) else \
			oldGemUncertaintyExpression == newExpression._gem_UncertaintyExpression)
		unless exp.equals?(newExpression) and evaluationUnchanged and uncertaintyUnchanged
			console.log "#{exp} not equal to #{newExpression}"

			if settings.get("mathJaxEnabled")
				# Generate the div representing the expression.
				html = expressionToString(newExpression, expressionID)
				expressionDiv = $(html)
				position = $("#expression-#{expressionID}").position()

				# Add the div to the whiteboard.
				$("#expression-#{expressionID}").replaceWith(expressionDiv)

				# Typeset the expression with MathJax, and once that is
				# finished, give the expression its event handlers.
				MathJax.Hub.Queue(["Typeset", MathJax.Hub])
				MathJax.Hub.Queue ->
					# We need to use the queue because typesetting typically
					# returns before it actually finishes typesetting - 
					# and typesetting involves replacing all the HTML for
					# the expression. So we want to add event handlers to the
					# resultant HTML, after typesetting is done.
					$("#expression-#{expressionID}").css
						top: "#{position.top}px"
						left: "#{position.left}px"
						position: "absolute"
					require ["frontend/setEventHandlers"], (setEventHandlers) ->
						setEventHandlers(expressionDiv)
			else
				html = expressionToString(newExpression, expressionID)
				expressionDiv = $(html)
				position = $("#expression-#{expressionID}").position()

				# Add the div to the whiteboard.
				$("#expression-#{expressionID}").replaceWith(expressionDiv)
				$("#expression-#{expressionID}").css
					top: "#{position.top}px"
					left: "#{position.left}px"
					position: "absolute"
				require ["frontend/setEventHandlers"], (setEventHandlers) ->
					setEventHandlers(expressionDiv)

			expressionIndex.set(expressionID, newExpression)

	refreshExpressionsWithVariable = (variable) ->
		require ["backend/equivalenciesIndex"], (equivalenciesIndex) ->
			equivalencies = equivalenciesIndex.get(variable)
			for expression, index in expressionIndex.getAllExpressions()
				for v in equivalencies
					if v in expression.getAllVariables()
						console.log "refreshing expression", expression.toString()
						rewriteExpression(index, expressionIndex.get(index))

	return {
		rewriteEquation: rewriteEquation
		rewriteExpression: rewriteExpression
		rewriteVariable: (equationID, variableID, newLabel, newVariableID=null) ->
			# Rewrite a variable.
			throw new Error("Not implemented.")
		refreshExpressionsWithVariable: refreshExpressionsWithVariable
	}