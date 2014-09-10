# GEM Equation object, which wraps a Coffeequate Expression.

define ["coffeequate", "elementTools"], (CQ, elementTools) ->

	class Equation

		# Make a new Equation.
		#
		# @param lhs [String, CQ.Expression] The left hand side of equation.
		# @param rhs [String, CQ.Expression] The right hand side of equation.
		# @return [Equation]
		constructor: (lhs, rhs) ->
			@lhs = CQ(lhs)
			@rhs = CQ(rhs)
			@element = elementTools.makeEquation(@toMathML())
			@id = null

		toMathML: ->
			"<mrow>#{@lhs.toMathML()}<mo>=</mo>#{@rhs.toMathML()}</mrow>"