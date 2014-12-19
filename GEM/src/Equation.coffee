# GEM Equation object, which wraps a Coffeequate Expression.

define [
	"coffeequate"
	"elementTools"
	"Expression"
	"index"
	], (CQ, elementTools, Expression, index) ->

	class Equation

		# Make a new Equation.
		#
		# @param lhs [String, CQ.Expression] The left hand side of equation.
		# @param rhs [String, CQ.Expression] The right hand side of equation.
		# @return [Equation]
		constructor: (lhs, rhs) ->
			@lhs = CQ(lhs)
			@rhs = CQ(rhs)

			# Add ourselves to the index.
			index.equation.add(@)

			# Go through the CQ expression and change the labels of the
			# variables to have a number on them. This is so that we can
			# identify them uniquely later.
			id = @id
			changeLabels = (variable) ->
				variable.label += id
				console.log(variable.label)
				return variable
			@lhs = @lhs.mapOverVariables(changeLabels)
			@rhs = @rhs.mapOverVariables(changeLabels)

			@element = elementTools.makeEquation(@toMathML())

		toMathML: ->
			"<mrow>#{@lhs.toMathML()}<mo>=</mo>#{@rhs.toMathML()}</mrow>"

		toExpression: ->
			new Expression(@lhs, @rhs)