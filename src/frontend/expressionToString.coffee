define ["frontend/settings"], (settings) ->

	# Take an expression, convert it to MathML or HTML, and patch the result so that it includes information on values and uncertainties.

	(expression, expressionID) ->
		console.log "getting string of", expression
		html = (if settings.get("mathJaxEnabled") \
					then expression.toMathML(expressionID, true, "0", true)[...-13] \
					else expression.toHTML(expressionID, true, "0", true)[...-6])	# We slice it to remove </math></div> and </div>.

		if expression._gem_evaluatedExpression?
			html += "<mo>=</mo>" + (if settings.get("mathJaxEnabled") \
										then expression._gem_evaluatedExpression.toMathML(expressionID, true, "0", false) \
										else expression._gem_evaluatedExpression.toHTML(expressionID, true, "0", false))

		if expression._gem_uncertaintyExpression? and (expression._gem_evaluatedExpression? or settings.get("showSymbolicUncertainties"))
			html += "<mo>&plusmn;</mo>" + (if settings.get("mathJaxEnabled") \
												then expression._gem_uncertaintyExpression.toMathML(expressionID, true, "0", false) \
												else expression._gem_uncertaintyExpression.toHTML(expressionID, true, "0", false))
			console.log html
		if expression._gem_units? and expression._gem_evaluatedExpression?
			html += (if settings.get("mathJaxEnabled") then expression._gem_units.toMathML() else expression._gem_units.toHTML())

		html += (if settings.get("mathJaxEnabled") then "</math></div>" else "</div>")

		return html