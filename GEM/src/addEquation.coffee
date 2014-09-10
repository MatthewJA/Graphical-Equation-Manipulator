# Add a new equation to the whiteboard and index.

define [
	"jquery"
	"index"
	"render"
	"eventHandler"
], ($, index, render, eventHandler) ->

	# Add a new equation to the whiteboard and index.
	#
	# @param equation [Equation] The equation to add.
	addEquation = (equation) ->
		$("#whiteboard").append(equation.element)
		index.equation.add(equation)
		equation.element.attr("id", "equation-#{equation.id}")
		render.math ->
			equation.element = $("#equation-#{equation.id}")
			eventHandler.equation(equation.element)

	return addEquation