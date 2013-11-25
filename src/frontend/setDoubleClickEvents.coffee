define ["jquery", "require"], ($, require) ->
	# We include require because we have to rely on solveEquation as a dependency, but it relies on this.
	# This avoids a circular dependency.

	setDoubleClickEvents = (element) ->
		# Set things to happen upon double-clicking.

		if element?
			target = $(element).find(".variable")
		else
			target = $(".variable")

		target.dblclick ->
			console.log("clicked " + $(@).toString())
			variable = $(@).text()

			# What equation/expression was it in?
			formulaID = $(@).parents("div").attr("id")
			# The ID of an equation should be of the form "equation-n" where n is an integer.
			# The ID of an expression should be of the form "expression-n" in the same way.
			[formulaType, formulaNumber] = formulaID.split("-")

			console.log("Double-clicked " + variable + " in " + formulaType + " " + formulaNumber)

			if formulaType == "equation"
				require ["backend/solveEquation", "frontend/addExpressionToWhiteboard", "backend/addExpressionToIndex"], (solveEquation, addExpressionToWhiteboard, addExpressionToIndex) ->

					expression = solveEquation(formulaNumber, variable)
					addExpressionToWhiteboard(expression)
					addExpressionToIndex(expression)
		
		# Disable highlighting on variables.
		target.disableSelection()