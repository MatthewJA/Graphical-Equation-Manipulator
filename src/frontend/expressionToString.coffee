define ["frontend/settings"], (settings) ->

	# Take an expression, convert it to MathML or HTML, and patch the result so that it includes information on values and uncertainties.

	(expression, expressionID) ->
		html = (if settings.get("mathJaxEnabled") \
					then expression.toMathML(expressionID, true, "0", true)[...-13] \
					else expression.toHTML(expressionID, true, "0", true)[...-6])	# We slice it to remove </math></div> and </div>.

		console.log expression._gem_evaluatedExpression

		if expression._gem_evaluatedExpression?
			html += "<mo>=</mo>" + (if settings.get("mathJaxEnabled") \
										then expression._gem_evaluatedExpression.toMathML(expressionID, true, "0", false) \
										else expression._gem_evaluatedExpression.toHTML(expressionID, true, "0", false))

		if expression._gem_uncertaintyExpression?
			html += "<mo>&plusmn;</mo>" + (if settings.get("mathJaxEnabled") \
												then expression._gem_uncertaintyExpression.toMathML(expressionID, true, "0", false) \
												else expression._gem_uncertaintyExpression.toHTML(expressionID, true, "0", false))

		html += (if settings.get("mathJaxEnabled") then "</math></div>" else "</div>")

		return html