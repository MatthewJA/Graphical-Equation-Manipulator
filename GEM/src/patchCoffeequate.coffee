# Patch Coffeequate to have a map method for Expressions.
# Work in progress - I lost the need for this before I finished
# writing it, so I'm currently unsure whether I need it at all.

define ["coffeequate"], (CQ) ->

	return ->
		# CQ only exports the CQ function, so we'll
		# have to reverse-engineer it a bit to get the
		# classes we need to change.

		expr = CQ("x + y") # Dummy expression.
		Expression = expr.constructor
		Add = expr.expr.constructor
		expr = CQ("x * y")
		Mul = expr.expr.constructor
		expr = CQ("x ** y")
		Pow = expr.expr.constructor
		expr = CQ("x")
		Variable = expr.expr.constructor
		expr = CQ("1")
		Constant = expr.expr.constructor
		expr = CQ("x").getUncertainty()
		Uncertainty = expr.expr.constructor
		expr = CQ("\\G")
		SymbolicConstant = expr.expr.constructor

		# Map a function over variables.
		#
		# @param fun [Function] A function to map.
		# @return [Expression] A mapped Expression.
		Expression.prototype.mapOverVariables = (fun) ->
			new Expression(@expr.mapOverVariables(fun))

		# Map a function over variables.
		#
		# @param fun [Function] A function to map.
		# @return [Expression] A mapped Expression.
		Add.prototype.mapOverVariables = (fun) ->
			mappedChildren = []
			for child in children
				mappedChildren.push(child.mapOverVariables(fun))