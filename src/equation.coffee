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
				constant = /^\d+(\.\d+)?$/ # 123.456789
				variable = /^[A-Za-z_]+$/ # Ek
				fractional = /^\d+(\.\d+)?\/\d+(\.\d+)?$/ # 123.456/78.9
				power = /^[A-Za-z_]+\*\*\d+(\.\d+)?$/ # Ek**0.5

				if term.match(constant)?
					return new Constant(parseFloat(term))
				else if term.match(variable)?
					return new Variable(term)
				else if term.match(fractional)?
					[n, d] = term.split("/")
					return new Constant(parseFloat(n), parseFloat(d))
				else if term.match(power)?
					[v, p] = term.split("**")
					return new Variable(v, p)
				else
					throw new Error("Invalid term in equation: " + term)

			else if term.isTerm?
				return term

			else
				throw new TypeError("Expected Variable, Constant, or string, got: " + term)

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

			return new Equation(leftTerms, rightTerms)

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

		toGEMHTML: (equationID) ->
			if equationID?
				divID = "equation-" + equationID
			else
				divID = "equation"

			html = '<div id="' + divID + '" class="equation">'

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