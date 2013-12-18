define [
	"jquery"
	"frontend/setEventHandlers"
	"frontend/settings"
], ($, setEventHandlers, settings) ->

	return {
		rewriteEquation: (equationID, newEquation) ->
			# Rewrite the equation with the given ID as a new equation.
			if settings.get("mathJaxEnabled")
				# Generate the div representing the equation.
				html = newEquation.toMathML(equationID)
				equationDiv = $(html)

				# Add the div to the whiteboard.
				$("#equation-#{equationID}").replaceWith(equationDiv)

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
				$("#equation-#{equationID}").replaceWith(equationDiv)
				setEventHandlers(equationDiv)

		rewriteVariable: (equationID, variableID, newLabel, newVariableID=null) ->
			# Rewrite a variable.
	}