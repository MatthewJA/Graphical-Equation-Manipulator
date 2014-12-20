# Add a new expression to the whiteboard and index.

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

	# Add a new expression to the whiteboard and index.
	#
	# @param expression [Expression] The expression to add.
	addExpression = (expression) ->
		console.log "let's add an expression"
		$("#whiteboard").append(expression.element)
		console.log "it's in the whiteboard now"

		expression.element.attr("id", "expression-#{expression.id}")
		render.math ->
			# Update the element as MathJax just replaced it.
			expression.element = $("#expression-#{expression.id}")

			# Add event handlers.
			eventHandler.expression(expression.element)

			# Place the element randomly.
			placeRandomly(expression.element)

			# Go through the variables in the expression and give each a unique
			# ID.
			for variable in expression.element.find(".variable")
				label = $(variable).text()
				$(variable).attr("id",
					"variable-exp-#{expression.id}-#{label}")

	return addExpression