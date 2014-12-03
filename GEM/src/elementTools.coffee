# HTML element-generating functions.
# These will usually just wrap other elements or strings in a useful way.

define ["jquery"], ($) ->

	# Take a MathML string and turn it into an equation element.
	#
	# @param mathML [String] A MathML string.
	# @return [Element] A jQuery element for an equation element.
	makeEquation = (mathML) ->
		element = $("<math>#{mathML}</math>")
		element.addClass("grabbable equation")
		return element

	# Take a MathML string and turn it into an expression element.
	#
	# @param mathML [String] A MathML string.
	# @return [Element] A jQuery element for an expression element.
	makeExpression = (mathML) ->
		element = $("<math>#{mathML}</math>")
		element.addClass("grabbable expression")
		return element

	return {
		makeEquation: makeEquation
		makeExpression: makeExpression
	}