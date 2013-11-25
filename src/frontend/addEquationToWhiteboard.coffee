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
		equationDiv = $('<div><math><mi class="variable">x</mi></math></div>')

		$("#whiteboard-panel").append(equationDiv)
		
		setDraggables(equationDiv)
		# setDoubleClickEvents(equationDiv)

		console.log(MathJax)
		MathJax.Hub.Queue(["Typeset",MathJax.Hub])