define ["jquery"
		"frontend/settings"
		"frontend/connections"
		"require"
		"frontend/substituteEquation"
		"backend/expressionIndex"
		"frontend/makeEquation"
		"backend/numericalValues"
		"frontend/alert"
		"backend/uncertaintiesIndex"
], ($, settings, connections, require, substituteEquation, expressionIndex, makeEquation, numericalValues, alert, uncertaintiesIndex) ->

	# Set the event handlers of either a specific element
	# or every element on the page.

	initialised = false

	setEquationDraggables = (element=null) ->
		# Set equations and expressions to be dragged around.
		# element: A formula (expression or equation div) to set events for. Optional.		

		draggableProperties =
			# Constrain movement to within the whiteboard.
			containment: "#whiteboard-panel"
			scroll: false

			# Ensure only non-variable parts can be dragged.
			cancel: ".variable"

			drag: (event, ui) ->
				connections.repaintVariables($(event.target))

			stop: (event, ui) ->
				# For some reason, stopping the drag sometimes makes the variable
				# become detached from its connection - so as a fix for that, we
				# call repaint again.
				connections.repaintVariables($(event.target))

		if element?
			element.draggable(draggableProperties)
		else
			$(".equation").draggable(draggableProperties)
			$(".expression").draggable(draggableProperties)

	setDoubleClickEvents = (element=null) ->
		# Set events to happen upon double-clicking.
		# element: A formula (expression or equation div) to set events for. Optional.

		if element?
			target = $(element).find(".variable")
		else
			target = $(".variable")

		target.doubletap ->
			[variable, formulaType, formulaID] = getInfo($(@))

			# Debug output.
			console.log("Double-clicked " + variable + " in " + formulaType + " " + formulaID)

			if formulaType == "equation"
				require [
					"backend/solveEquation"
					"frontend/addExpression"
				], (solveEquation, addExpression) ->
					solutions = solveEquation(formulaID, variable)
					for solution in solutions
						expressionID = addExpression(solution)
		
		# Disable highlighting on variables.
		target.disableSelection()

	setContextMenus = (element=null) ->
		# Set context menus to appear when right-clicking a variable.

		if element?
			target = $(element).find(".variable")
		else
			target = $(".variable")

		target.contextMenu("context-menu-variable", {
			"Set numerical value":
				click: (variableElement) ->
					[variable, formulaType, formulaID] = getInfo(variableElement)
					$.prompt(
						{state0: {
							title: "Enter a numerical value for this variable."
							html:'<input type="text" name="numericalvalue" value="1"><br>'
							buttons: {"Set Value": 1, "Cancel": -1}
							focus: "input[name='numericalvalue']"
							submit: (e, v, m, f) ->
								e.preventDefault()
								if v == 1
									value = f.numericalvalue
									if /^-?\d+(\.\d+)?(\s*\+-\s*-?\d+(\.\d+)?)?$/.test(value)

										value = value.replace(/\s/g,"")
										splitValue = value.split("+-")
										uncertainty = splitValue[1]
										value = splitValue[0]

										# Set the uncertainty.
										uncertaintiesIndex.set(variable, uncertainty)

										# Make an equation equating this variable to a number.
										[equationID, equation] = makeEquation(variable, value)

										require ["backend/formulae"], (formulae) ->
											# Force the uncertainty for the expression.
											if uncertainty?
												equation._gem_uncertaintyExpression = formulae.makeExpression(uncertainty)

											# If we already have an expression showing the equation, then rewrite it.
											if numericalValues.getExpression(variable)?
												require ["frontend/rewrite"], (rewrite) -> rewrite.rewriteExpression(numericalValues.getExpression(variable), equation)
											else
												require ["frontend/addExpression"], (addExpression) ->
													eID = addExpression(equation)
													numericalValues.set(variable, value, eID)
										$.prompt.close()
									else
										$.prompt.nextState()
								else
									$.prompt.close()
							}
						state1: {
							title: "Please enter a number."
							buttons: {"Okay": 1, "Cancel": -1}
							focus: 0
							submit: (e, v, m, f) ->
								e.preventDefault()
								if v == 1
									$.prompt.prevState()
								else
									$.prompt.close()
							}})
			"Make into equation":
				click: (variableElement) ->
					[variable, formulaType, formulaID] = getInfo(variableElement)
					vid = (variableElement.attr("id").split("-")[-2..]).join("-")
					$.prompt(
						{state0: {
							title: "Enter an expression representing this variable. You can use multiplication *, addition +," +\
									" negation -, or exponentiation **. For example, A + 2 * B. You will be able to assign the values" +\
									" later."
							html:'<input type="text" name="equation" value="A + 2 * B"><br>'
							buttons: {"Okay": 1, "Cancel": -1}
							focus: "input[name='equation']"
							submit: (e, v, m, f) ->
								e.preventDefault()
								if v == 1
									require ["backend/formulae", "backend/equationIndex", "backend/equivalenciesIndex"], (formulae, equationIndex, equivalenciesIndex) ->
										try
											units = equationIndex.get(formulaID).getVariableUnits(vid)
											equation = formulae.makeEquation((variable.split("-")[...-1]).join(""), equation)
											for theVariable in equation.getAllVariables()
												equation.setVariableUnits(theVariable, equivalenciesIndex, units)
											require ["frontend/addEquation"], (addEquation) ->
												addEquation(equation)
												console.log "woop", equation.toString()
												console.log vid.toString(), ",", equation.left.label
												connections.setEquivalency(vid, equation.left.label)
											$.prompt.close()
										catch e
											console.log "invalid expression #{equation}"
											console.log e
											$.prompt.nextState()
								else
									$.prompt.close()
							},
						state1: {
							title: "Invalid expression."
							buttons: {"Okay": 1, "Cancel": -1}
							focus: 0
							submit: (e, v, m, f) ->
								e.preventDefault()
								if v == 1
									$.prompt.prevState()
								else
									$.prompt.close()
							}})
			"Delete formula":
				click: (variableElement) ->
					[variable, formulaType, formulaID] = getInfo(variableElement)
					connections.removeAllVariableConnections($("##{formulaType}-#{formulaID}"))
					$("##{formulaType}-#{formulaID}").remove()
			"Convert to LaTeX code":
				click: (variableElement) ->
					[variable, formulaType, formulaID] = getInfo(variableElement)
					if formulaType == "expression"
						require ["backend/expressionIndex"], (expressionIndex) ->
							window.prompt("LaTeX output.", expressionIndex.get(formulaID).toLaTeX())
					else if formulaType == "equation"
						require ["backend/equationIndex"], (equationIndex) ->
							window.prompt("LaTeX output.", equationIndex.get(formulaID).toLaTeX())
			},
			{
				disable_native_context_menu: true
				leftClick: false
			}
		)

		if element?
			target = $(element).find(".equation, .expression").addBack(".equation, .expression")
		else
			target = $(".equation, .expression")

		target.contextMenu("context-menu-formula", {
			"Delete formula":
				click: (variableElement) ->
					variableElement.remove()
					connections.removeAllVariableConnections(variableElement)
			"Convert to LaTeX code":
				click: (variableElement) ->
					[formulaType, formulaID] = variableElement.attr("id").split("-")
					if formulaType == "expression"
						require ["backend/expressionIndex"], (expressionIndex) ->
							window.prompt("LaTeX output.", expressionIndex.get(formulaID).toLaTeX())
					else if formulaType == "equation"
						require ["backend/equationIndex"], (equationIndex) ->
							window.prompt("LaTeX output.", equationIndex.get(formulaID).toLaTeX())
			},
			{
				disable_native_context_menu: true
				leftClick: false
			}
		)

	setVariableDraggables = (element=null) ->
		# Set variables to have drag events such that you can drag one variable to another variable to equate them.
		# element: A formula (expression or equation div) to set events for. Optional.

		if element?
			target = $(element).find(".variable")
		else
			target = $(".variable")

		target.draggable
			start: (event, ui) ->
				# Add CSS to make the helper look like the draggable target.
				if $(event.target).parents(".equation").length != 0
					# Target is an equation variable.
					$(ui.helper).addClass("equationVariableHelper");
				else if $(event.target).parents(".expression").length != 0
					# Target is an expression variable.
					$(ui.helper).addClass("expressionVariableHelper");

				$(ui.helper).css("font-size", $(event.target).css("font-size"))

				unless settings.get("mathJaxEnabled")
					$(ui.helper).css("font-family", "monospace")

				# Hide the original variable we are dragging.
				$(event.target).fadeTo(0, 0)

			drag: (event, ui) ->
				# do drag stuff:
				# (apparently, nothing at all)

			stop: (event, ui) ->
				# Show the original variable we are dragging.
				$(event.target).fadeTo(0, 1)

			containment: "#whiteboard-panel"

			revert: true
			helper: "clone"
			appendTo: "#whiteboard-panel"

		target.droppable
			tolerance: "pointer"
			accept: ".variable"

			drop: (event, ui) ->
				[droppableID, droppableFormulaType, droppableFormulaID] = getInfo($(event.target))
				[draggableID, draggableFormulaType, draggableFormulaID] = getInfo($(ui.draggable))

				if droppableFormulaType == "equation" and draggableFormulaType == "equation"
					# Set an equivalency between this variable and the other variable.
					require ["frontend/rewrite", "backend/equivalenciesIndex", "backend/equationIndex"], (rewrite, equivalenciesIndex, equationIndex) ->
						[variableIDa, variableIDb] = [droppableID, draggableID]
						console.log("getting units for #{variableIDa} and #{variableIDb}")
						aUnits = equationIndex.get(droppableFormulaID).getVariableUnits(variableIDa)
						bUnits = equationIndex.get(draggableFormulaID).getVariableUnits(variableIDb)
						console.log(aUnits, bUnits)
						if (aUnits? and bUnits? and aUnits.equals(bUnits)) or (aUnits == bUnits)
							connections.setEquivalency(variableIDa, variableIDb)
							# Force simplify any expressions involved. I'm going to cheat here a bit
							# and just force simplify *all* expressions.
							for i in [0...expressionIndex.size()]
								expression = expressionIndex.get(i)
								rewrite.rewriteExpression(i, expression.expandAndSimplify(equivalenciesIndex).simplify(equivalenciesIndex))
						else
							alert(event.target, "Units do not match: #{variableIDa} has units #{aUnits}, #{variableIDb} has units #{bUnits}.")
				else if droppableFormulaType == "expression" and draggableFormulaType == "equation"
					# Substitute the equation into this expression.
					substituteEquation(droppableFormulaID, draggableFormulaID, draggableID)

	getInfo = (variableElement) ->
		# Get information about the variable represented by the given element.
		# vairableElement: A jQuery element representing a variable.
		# -> [variableID, formulaType, formulaID]
		variable = variableElement.attr("id") # The ID of the variable element is also the variableID, but the element ID
		# has an extra "variable-equation-equationID-" appended to the start.
		if /variable-/.test(variable)
			variable = variable.split("-")[3..].join("-")

		# What equation/expression was the variable we clicked in?
		formulaID = variableElement.parents("div").attr("id")

		# The ID of an equation should be of the form "equation-n" where n is an integer.
		# The ID of an expression should be of the form "expression-n" in the same way.
		[formulaType, formulaNumber] = formulaID.split("-")

		return [variable, formulaType, formulaNumber]

	return (element=null) ->
		# element: A formula (expression or equation div) to set events for. Optional.

		setEquationDraggables(element)
		setDoubleClickEvents(element)
		setVariableDraggables(element)
		setContextMenus(element)