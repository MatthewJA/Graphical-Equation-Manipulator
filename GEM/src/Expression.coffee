# GEM Expression object, which wraps a Coffeequate Expression.

define ["coffeequate", "elementTools"], (CQ, elementTools) ->

	class Expression

		# Make a new Expression.
		#
		# @param lhs [String, CQ.Expression] The left hand side of the expression.
		# @param rhs [String, CQ.Expression] The right hand side of the expression.
		# @return [Expression]
		constructor: (lhs, rhs) ->
			@lhs = CQ(lhs)
			@rhs = CQ(rhs)

		toMathML: ->
			"<mrow>#{@lhs.toMathML()}<mo>=</mo>#{@rhs.toMathML()}</mrow>"

		toElement: ->
			elementTools.makeExpression(@toMathML())