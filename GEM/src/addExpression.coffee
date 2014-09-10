# Add a new expression to the whiteboard and index.

define [
	"jquery"
	"index"
	"render"
	"eventHandler"
], ($, index, render, eventHandler) ->

	# Add a new expression to the whiteboard and index.
	#
	# @param expression [Expression] The expression to add.
	addExpression = (expression) ->
		$("#whiteboard").append(expression.element)
		index.expression.add(expression)
		expression.element.attr("id", "expression-#{expression.id}")
		render.math ->
			expression.element = $("#expression-#{expression.id}")
			eventHandler.expression(expression.element)

	return addExpression