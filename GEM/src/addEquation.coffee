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
			# Update the element as MathJax just replaced it.
			equation.element = $("#equation-#{equation.id}")

			# Add event handlers.
			eventHandler.equation(equation.element)
			
			# Position the element randomly.
			elW = equation.element.width()
			elH = equation.element.height()
			wW = $("#whiteboard").width()
			wH = $("#whiteboard").height()
			left = Math.random()*((wW - elW)/wW)*100
			console.log left
			top = Math.random()*((wH - elH)/wH)*100
			equation.element.css("position", "absolute")
			equation.element.css("left", "#{left}%")
			equation.element.css("top", "#{top}%")

	return addEquation