define [
	"jquery"
	"frontend/setEventHandlers"
	"frontend/settings"
	"backend/equationIndex"
], ($, setEventHandlers, settings, equationIndex) ->

	# Add an equation to the program.
	# This involves adding it to the whiteboard and adding it
	# to the backend.

	addEquationToWhiteboard = (equation, equationID) ->
		# Add an equation to the whiteboard.
		# equation: A JS-Algebra equation to add to the whiteboard.

		if settings.mathJaxEnabled
			# Generate the div representing the equation.
			html = equation.toMathML(equationID)
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
				setEventHandlers(equationDiv)
		else
			html = equation.toHTML(equationID)
			equationDiv = $(html)

			# Add the div to the whiteboard.
			$("#whiteboard-panel").append(equationDiv)
			setEventHandlers(equationDiv)

	return (equation) ->
		# equation: The equation to add.
		# -> The ID of the newly-added equation.

		equationID = equationIndex.add(equation)
		addEquationToWhiteboard(equation, equationID)
		return equationID