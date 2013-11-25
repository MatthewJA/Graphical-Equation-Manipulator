define [
	"jquery"
	"frontend/setDraggables"
	"frontend/setDoubleClickEvents"
	"backend/nextEquationID"
], ($, setDraggables, setDoubleClickEvents, nextEquationID) ->

	addEquationToWhiteboard = (equation) ->
		# Add an equation to the whiteboard.
		# equation: A JS-Algebra equation to add to the whiteboard.

		# Generate the HTML representing the equation.
		equationID = nextEquationID()
		html = equation.toMathML(equationID)
		equationDiv = $(html)

		# Add the HTML to the page.
		$("#whiteboard-panel").append(equationDiv)
		
		# Typeset the equation with MathJax, and once that is finished,
		# give the equation its event handlers.
		MathJax.Hub.Queue(["Typeset",MathJax.Hub])
		MathJax.Hub.Queue ->
			# We use the queue because typesetting returns before it actually finishes
			# typesetting, and typesetting involves replacing all of the HTML we generated
			# with spans which the event handlers will have to hook into.
			setDraggables(equationDiv)
			setDoubleClickEvents(equationDiv)