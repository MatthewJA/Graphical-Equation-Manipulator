# Add a new equation to the whiteboard and index.

define [
	"jquery"
	"index"
	"render"
	"eventHandler"
], ($, index, render, eventHandler) ->

	# Place an element in a random position.
	placeRandomly = (element) ->
		wT = $("#whiteboard").offset().top
		wL = $("#whiteboard").offset().left
		wH = $("#whiteboard").height()
		wW = $("#whiteboard").width()
		eT = element.offset().top
		eL = element.offset().left
		eH = element.height()
		eW = element.width()

		# Random number between -eT and wH - eT
		top = (Math.random() * (wH - eH) - eT)/wH * 100
		left = (Math.random() * (wW - eW) - eL)/wW * 100

		element.css
			top: top + "%"
			left: left + "%"

	# Add a new equation to the whiteboard and index.
	#
	# @param equation [Equation] The equation to add.
	addEquation = (equation) ->
		$("#whiteboard").append(equation.element)

		equation.element.attr("id", "equation-#{equation.id}")
		render.math ->
			# Update the element as MathJax just replaced it.
			equation.element = $("#equation-#{equation.id}")

			# Add event handlers.
			eventHandler.equation(equation.element)

			# Place the element randomly.
			placeRandomly(equation.element)

			# Go through the variables in the equation and give each a unique
			# CSS ID.
			for variable in equation.element.find(".variable")
				label = $(variable).text()
				$(variable).attr("id", "variable-equ-#{equation.id}-#{label}")

	return addEquation