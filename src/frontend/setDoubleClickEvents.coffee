define ["jquery", "require"], ($, require) ->
	# We include require because we have to rely on addExpressionTo* as dependencies, but these relies on this module.
	# This avoids a circular dependency.

	setDoubleClickEvents = (element=null) ->
		# Set events to happen upon double-clicking.
		# element: An element to set events for. Optional.

		if element?
			target = $(element).find(".variable")
		else
			target = $(".variable")

		target.dblclick ->
			variable = $(@).text()

			# What equation/expression was the variable we clicked in?
			formulaID = $(@).parents("div").attr("id")

			# The ID of an equation should be of the form "equation-n" where n is an integer.
			# The ID of an expression should be of the form "expression-n" in the same way.
			[formulaType, formulaNumber] = formulaID.split("-")

			# Debug output.
			console.log("Double-clicked " + variable + " in " + formulaType + " " + formulaNumber)

			if formulaType == "equation"
				require [
					"backend/solveEquation"
					"frontend/addExpressionToWhiteboard"
					"backend/addExpressionToIndex"
				], (solveEquation, addExpressionToWhiteboard, addExpressionToIndex) ->
					expression = solveEquation(formulaNumber, variable)
					addExpressionToWhiteboard(expression)
					addExpressionToIndex(expression)
		
		# Disable highlighting on variables.
		target.disableSelection()