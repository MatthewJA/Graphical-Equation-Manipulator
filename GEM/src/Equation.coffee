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

		# Solve this equation for a given variable and return an Expression.
		#
		# @param label [String] Label of variable to solve for.
		# @return [Expression] Solved equation as an expression.
		solveFor: (label) ->
			expr = @toCoffeequate()
			solved = expr.solve(label)

			# We could have multiple solutions, so return all of them.
			expressions = (new Expression(CQ(label), soln) for soln in solved)
			return expressions

		# Get the whole equation as a CQ Expression equated to zero.
		#
		# @return [CQ.Expression]
		toCoffeequate: ->
			Mul = CQ.raw.Mul
			Add = CQ.raw.Add
			return CQ(new Add(@rhs, new Mul(-1, @lhs))).expand().simplify()

		toMathML: ->
			"<mrow>#{@lhs.toMathML()}<mo>=</mo>#{@rhs.toMathML()}</mrow>"

		toExpression: ->
			new Expression(@lhs, @rhs)