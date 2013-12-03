define ["JSAlgebra/variable", "JSAlgebra/constant", "JSAlgebra/algebraException"], (Variable, Constant, AlgebraException) ->
	class Equation
		# Represents an equation. Can only handle multiplication/division at the moment.
		constructor: (leftTerms, rightTerms) ->
			# leftTerms: An array of terms on the left side of this equation.
			# rightTerms: An array of terms on the right side of this equation.

			# These arrays may be of strings or of Variables/Constants (or a mix of both).
			@leftTerms = []
			@rightTerms = []

			for term in leftTerms
				@leftTerms.push(Equation.handleInputTerm(term))
			for term in rightTerms
				@rightTerms.push(Equation.handleInputTerm(term))

		@handleInputTerm: (term) ->
			# Convert strings to Variables or Constants, and return Variables or Constants as-is.

			if typeof(term) == 'string' or (term instanceof String)
				# Parse it.
				constant = /^-?\d+(\.\d+)?$/ # 123.456789
				variable = /^[A-Za-z_]+([0-9]+)?$/ # Ek
				fractional = /^-?\d+(\.\d+)?\/\d+(\.\d+)?$/ # 123.456/78.9
				power = /^[A-Za-z_]+([0-9]+)?\*\*-?\d+(\.\d+)?$/ # Ek**0.5

				if term.match(constant)?
					c = new Constant(parseFloat(term))
					c.simplify()
					return c
				else if term.match(variable)?
					return new Variable(term)
				else if term.match(fractional)?
					[n, d] = term.split("/")
					c = new Constant(parseFloat(n), parseFloat(d))
					c.simplify()
					return c
				else if term.match(power)?
					[v, p] = term.split("**")
					return new Variable(v, parseFloat(p))
				else
					throw new Error("Invalid term in equation: " + term)

			else if typeof(term) == 'number' or (term instanceof Number)
				c = new Constant(term)
				c.simplify()
				return c

			else if term.isTerm?
				return term.copy()

			else
				throw new TypeError("Expected Variable, Constant, number, or string, got: " + term)

		solve: (variable) ->
			# Solve the equation for a variable.
			# Returns an Equation where variable is the left hand side of that equation.
			# variable: The variable to solve for.
			
			# First, get all terms that aren't the one we are solving for in one place.
			# leftTerms should contain the terms we're solving for, and rightTerms will contain everything else.
			leftTerms = []
			rightTerms = []
			for term in @leftTerms
				if term.isVariable? and term.label == variable
					leftTerm = term.copy()
					leftTerms.push leftTerm
				else
					rightTerm = term.copy()
					rightTerm.pow(-1)
					rightTerms.push rightTerm

			for term in @rightTerms
				if term.isVariable? and term.label == variable
					leftTerm = term.copy()
					leftTerm.pow(-1)
					leftTerms.push leftTerm
				else
					rightTerm = term.copy()
					rightTerms.push rightTerm

			if (leftTerms.length == 0) # The variable was not in the equation, so throw an exception.
				throw new AlgebraException("Variable to solve for was not in equation.")

			# Now we have to get the variable we want by itself, independent of any powers.
			# To do this, we will divide all powers by the power of our variable on the left hand side.

			power = 1
			for term in leftTerms
				# We expect only one term in leftTerms, and it should be a variable (the variable we want).
				# Might add more checking for this later.
				power = term.power

			for term in leftTerms
				term.pow(1/power)
			for term in rightTerms
				term.pow(1/power)

			e = new Equation(leftTerms, rightTerms)
			return e.collectConstants()

		collectConstants: ->
			constant = new Constant(1)

			leftTerms = []
			rightTerms = []

			for term in @leftTerms
				if term.isConstant?
					a = term.copy()
					a.pow(-1)
					constant = constant.multiply(a)
				else
					leftTerms.push term

			for term in @rightTerms
				if term.isConstant?
					constant = constant.multiply(term)
				else
					rightTerms.push term

			constant.simplify()

			if constant.evaluate() != 1
				rightTerms.unshift(constant)

			leftTerms.push(new Constant(1)) if leftTerms.length == 0
			rightTerms.push(new Constant(1)) if leftTerms.length == 0

			return new Equation(leftTerms, rightTerms)

		replaceVariables: (replacements) ->
			# Replace variables in this equation with differently named ones, according to a map.
			# replacements: {original: replacement} variable labels.

			for term in @leftTerms
				if term.isVariable? and term.label of replacements
					term.label = replacements[term.label]
			for term in @rightTerms
				if term.isVariable? and term.label of replacements
					term.label = replacements[term.label]

		getAllVariables: ->
			# Get all variable labels in this equation.
			# -> An array of all variable labels in this equation.
			variableLabels = []
			for term in @leftTerms
				if term.isVariable?
					variableLabels.push(term.label)
			for term in @rightTerms
				if term.isVariable?
					variableLabels.push(term.label)

			return variableLabels

		sub: (values) ->
			# Substitute values into the variables of the equation and return a new equation.
			# Values is an object mapping variable labels to their values.
			leftTerms = []
			leftConstant = null

			for term in @leftTerms
				if term.isVariable?
					if term.label of values
						if values[term.label].isConstant?
							v = values[term.label].copy()
						else
							v = new Constant(values[term.label])

						v.pow(term.power)

						if leftConstant?
							leftConstant = leftConstant.multiply(v)
						else
							leftConstant = v
					else
						leftTerms.push term

				else if term.isConstant?
					if leftConstant?
						leftConstant = leftConstant.multiply(term)
					else
						leftConstant = term.copy()

			rightTerms = []
			rightConstant = null

			for term in @rightTerms
				if term.isVariable?
					if term.label of values
						if values[term.label].isConstant?
							v = values[term.label].copy()
						else
							v = new Constant(values[term.label])

						v.pow(term.power)

						if rightConstant?
							rightConstant = rightConstant.multiply(v)
						else
							rightConstant = v
					else
						rightTerms.push term

				else if term.isConstant?
					if rightConstant?
						rightConstant = rightConstant.multiply(term)
					else
						rightConstant = term.copy()

			if leftTerms.length == 0 and rightTerms.length == 0 and leftConstant? and rightConstant?
				throw new AlgebraException("Inconsistent numbers substituted into equation.")

			leftTerms.unshift(leftConstant) if leftConstant?
			rightTerms.unshift(rightConstant) if rightConstant?

			equation = new Equation(leftTerms, rightTerms)
			console.log(equation.toString())
			return equation.collectConstants()

		evaluate: (variable, values=null) ->
			# Substitute in values if they are passed in, then attempt to evaluate
			# the equation for the given variable. If the result is a number, return it,
			# otherwise return the equation representing the variable.
			# variable: The variable to evaluate for.
			# values: The values to substitute in. Optional.

			if values?
				f = @solve(variable).sub(values)
			else
				f = @solve(variable)

			if f.rightTerms.length == 1 and f.rightTerms[0].isConstant?
				return f.rightTerms[0].evaluate()
			else
				return f

		toString: ->
			output = []
			for term in @leftTerms
				if term.isVariable? and term.power == 0 then # Skip term.
				else
					output.push term.toString()

			leftHandSide = output.join " * "

			output = []
			for term in @rightTerms
				if term.isVariable? and term.power == 0 then # Skip term.
				else
					output.push term.toString()

			rightHandSide = output.join " * "

			return leftHandSide + " = " + rightHandSide

		toHTML: (equationID, expression=false) ->
			unless expression
				divClass = "equation"
				if equationID?
					divID = "equation-" + equationID
				else
					divID = "equation"
			else
				divClass = "expression"
				if equationID?
					divID = "expression-" + equationID
				else
					divID = "expression"

			html = '<div id="' + divID + '" class="' + divClass + '">'

			leftTerms = []
			for term in @leftTerms
				if term.isVariable?
					if term.power == 0 then
					else
						if term.power == 1
							power = ""
						else
							power = "**" + term.power
						leftTerms.push('<span class="variable">' + term.label + '</span>' + power)
				else
					leftTerms.push(term)

			rightTerms = []

			for term in @rightTerms
				if term.isVariable?
					if term.power == 0 then
					else
						if term.power == 1
							power = ""
						else
							power = "**" + term.power
						rightTerms.push('<span class="variable">' + term.label + '</span>' + power)
				else
					rightTerms.push(term)

			html += leftTerms.join(" * ") + " = " + rightTerms.join(" * ") + "</div>"

			return html

		toMathML: (equationID, expression=false) ->
			unless expression
				mathClass = "equation"
				if equationID?
					mathID = "equation-" + equationID
				else
					mathID = "equation"
			else
				mathClass = "expression"
				if equationID?
					mathID = "expression-" + equationID
				else
					mathID = "expression"

			html = '<div id="' + mathID + '" class="' + mathClass + '"><math xmlns="http://www.w3.org/1998/Math/MathML">'

			leftTermsLeft = []
			leftTermsTop = []
			leftTermsBottom = []
			for term in @leftTerms
				if term.isVariable?
					if term.power == 0 then
					else
						if term.power > 0
							leftTermsTop.push(term.toMathML())
						else
							t = term.copy()
							t.pow(-1)
							leftTermsBottom.push(t.toMathML())
				else
					leftTermsLeft.push(term.toMathML())

			rightTermsLeft = []
			rightTermsTop = []
			rightTermsBottom = []
			for term in @rightTerms
				if term.isVariable?
					if term.power == 0 then
					else
						if term.power > 0
							rightTermsTop.push(term.toMathML())
						else
							t = term.copy()
							t.pow(-1)
							rightTermsBottom.push(t.toMathML())
				else
					rightTermsLeft.push(term.toMathML())

			leftSide = []
			if leftTermsLeft.length > 0
				leftSide.push(leftTermsLeft.join("<mo>&middot;</mo>"))

			if leftTermsTop.length > 0 and leftTermsBottom.length > 0
				# Display a fraction.
				leftSide.push("<mfrac><mrow>" + leftTermsTop.join("<mo>&middot;</mo>") + "</mrow><mrow>" + leftTermsBottom.join("<mo>&middot;</mo>") + "</mrow></mfrac>")
			else if leftTermsTop.length > 0
				# Just display a linearly output equation.
				leftSide.push(leftTermsTop.join("<mo>&middot;</mo>"))
			else if leftTermsBottom.length > 0
				# We have the bottom half of a fraction, so put a 1 above it and display it as such.
				leftSide.push("<mfrac><mrow><mn>1</mn></mrow><mrow>" + leftTermsBottom.join("<mo>&middot;</mo>") + "</mrow></mfrac>")

			html += leftSide.join("<mo>&middot;</mo>") + "<mo>=</mo>"

			rightSide = []
			if rightTermsLeft.length > 0
				rightSide.push(rightTermsLeft.join("<mo>&middot;</mo>"))

			if rightTermsTop.length > 0 and rightTermsBottom.length > 0
				# Display a fraction.
				rightSide.push("<mfrac><mrow>" + rightTermsTop.join("<mo>&middot;</mo>") + "</mrow><mrow>" + rightTermsBottom.join("<mo>&middot;</mo>") + "</mrow></mfrac>")
			else if rightTermsTop.length > 0
				# Just display a linearly output equation.
				rightSide.push(rightTermsTop.join("<mo>&middot;</mo>"))
			else if rightTermsBottom.length > 0
				# We have the bottom half of a fraction, so put a 1 above it and display it as such.
				rightSide.push("<mfrac><mrow><mn>1</mn></mrow><mrow>" + rightTermsBottom.join("<mo>&middot;</mo>") + "</mrow></mfrac>")

			html += rightSide.join("<mo>&middot;</mo>") + "</math>"

			return html