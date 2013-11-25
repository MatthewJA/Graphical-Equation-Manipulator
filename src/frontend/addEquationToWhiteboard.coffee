define [
	"jquery"
	"frontend/setDraggables"
	"frontend/setDoubleClickEvents"
	"backend/nextEquationID"
], ($, setDraggables, setDoubleClickEvents, nextEquationID) ->
	# Add an equation to the whiteboard. The equation passed in should be a JS-Algebra equation.

	addEquation = (equation) ->
		equationID = nextEquationID()
		html = equation.toMathML(equationID)
		equationDiv = $(html)

		$("#whiteboard-panel").append(equationDiv)
		
		console.log(MathJax)
		MathJax.Hub.Queue(["Typeset",MathJax.Hub])
		MathJax.Hub.Queue ->
			setDraggables(equationDiv)
			setDoubleClickEvents(equationDiv)