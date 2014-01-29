define [
	"jquery"
	"frontend/setEventHandlers"
	"frontend/settings"
	"backend/equationIndex"
	"backend/variableIndex"
	"require"
], ($, setEventHandlers, settings, equationIndex, variableIndex, require) ->

	# Add an equation to the program.
	# This involves adding it to the whiteboard and adding it
	# to the backend. The equation being added will have its variables replaced
	# with unique ones.

	addEquationToWhiteboard = (equation, equationID, position=null) ->
		# Add an equation to the whiteboard.
		# equation: A Coffeequate equation to add to the whiteboard.
		# position: {top, left} position to add the equation. Optional.

		# Replace the variables in the equation with their unique IDs.
		replacements = {}
		for variable in equation.getAllVariables()
			# Make a unique ID for this variable.
			replacements[variable] = variableIndex.getNextUniqueID(variable)

		equation = equation.replaceVariables(replacements)

		if settings.get("mathJaxEnabled")
			# Generate the div representing the equation.
			html = equation.toMathML(equationID, false, "0", true)
			equationDiv = $(html)

			# Add the div to the whiteboard.
			$("#whiteboard-panel").append(equationDiv)

			# Typeset the equation with MathJax, and once that is
			# finished, give the equation its event handlers.
			MathJax.Hub.Queue(["Typeset", MathJax.Hub])
			MathJax.Hub.Queue ->
				# We need to use the queue because typesetting typically
				# returns before it actually finishes typesetting - 
				# and typesetting involves replacing all the HTML for
				# the equation. So we want to add event handlers to the
				# resultant HTML, after typesetting is done.
				require ["frontend/setEventHandlers"], (setEventHandlers) ->
					setEventHandlers(equationDiv)
				unless position?
					padding = 10
					position =
						top: Math.floor(Math.random() * Math.max(0, $("#whiteboard-panel").height()-equationDiv.height()-padding) + padding +
							$("#whiteboard-panel").offset().top)
						left: Math.floor(Math.random() * Math.max(0, $("#whiteboard-panel").width()-equationDiv.width()-padding) + padding +
							$("#whiteboard-panel").offset().left)
				$(equationDiv).css
					top: "#{position.top}px"
					left: "#{position.left}px"
					position: "absolute"

		else
			html = equation.toHTML(equationID, false, "0", true)
			equationDiv = $(html)

			# Add the div to the whiteboard.
			$("#whiteboard-panel").append(equationDiv)
			unless position?
				padding = 10
				position =
					top: Math.floor(Math.random() * Math.max(0, $("#whiteboard-panel").height()-equationDiv.height()-padding) + padding +
						$("#whiteboard-panel").offset().top)
					left: Math.floor(Math.random() * Math.max(0, $("#whiteboard-panel").width()-equationDiv.width()-padding) + padding +
						$("#whiteboard-panel").offset().left)
			$(equationDiv).css
				top: "#{position.top}px"
				left: "#{position.left}px"
				position: "absolute"
			setEventHandlers(equationDiv)

		return equation

	return (equation, position=null) ->
		# equation: The equation to add.
		# position: {top, left} position of the equation to add. Optional.
		# -> The ID of the newly-added equation.

		equationID = equationIndex.add(equation)
		equation = addEquationToWhiteboard(equation, equationID, position)
		equationIndex.set(equationID, equation)
		return equationID