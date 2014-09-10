# GEM Equation object, which wraps a Coffeequate Expression.

define ["coffeequate", "elementTools"], (CQ, elementTools) ->

	class Equation

		# Make a new Equation.
		#
		# @param lhs [String, CQ.Expression] The left hand side of the equation.
		# @param rhs [String, CQ.Expression] The right hand side of the equation.
		# @return [Equation]
		constructor: (lhs, rhs) ->
			@lhs = CQ(lhs)
			@rhs = CQ(rhs)

		toMathML: ->
			"<mrow>#{@lhs.toMathML()}<mo>=</mo>#{@rhs.toMathML()}</mrow>"

		toElement: ->
			elementTools.makeEquation(@toMathML())