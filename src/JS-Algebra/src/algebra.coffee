###
	JS-Algebra, a computer algebra system for JavaScript, written in CoffeeScript.

	At the moment, only does multiplication and division.
###

class Constant
	# A (fractional) constant in an equation. Has a numerator and a denominator.
	constructor: (@numerator, @denominator=1) ->
		# numerator: Top half of the fraction.
		# denominator: Bottom half of the fraction.

	pow: (power) ->
		# Raise this constant to a power.
		# power: The power to raise this constant to.

		if power < 0
			# Reciprocate, then evaluate.
			power *= -1
			[@numerator, @denominator] = [@denominator, @numerator]

		@numerator = Math.pow(@numerator, power)
		@denominator = Math.pow(@denominator, power)

	copy: ->
		# Return a copy of this constant.
		new Constant(@numerator, @denominator)

	toString: ->
		if @denominator == 1
			return "#{@numerator}"
		return "#{@numerator}/#{@denominator}"

class Variable
	# A variable in an equation.
	constructor: (@label, @power=1) ->
		# label: The name of this variable.
		# power: The initial power this variable is raised to.

	pow: (power) ->
		# Raise this variable to a power.
		# power: The power to raise this variable to.
		@power *= power

	copy: ->
		# Return a copy of this variable.
		new Variable(@label, @power)

	toString: ->
		switch @power
			when 1
				return @label
			when 0
				return "1"
			else
				return @label + "**" + @power

class Equation
	# Represents an equation. Can only handle multiplication/division at the moment.
	constructor: (@leftTerms, @rightTerms) ->
		# leftTerms: An array of terms on the left side of this equation.
		# rightTerms: An array of terms on the right side of this equation.

	solve: (variable) ->
		# Solve the equation for a variable.
		# Returns an Equation where variable is the left hand side of that equation.
		# variable: The variable to solve for.
		
		# First, get all terms that aren't the one we are solving for in one place.
		# leftTerms should contain the terms we're solving for, and rightTerms will contain everything else.
		leftTerms = []
		rightTerms = []
		for term in @leftTerms
			if term instanceof Variable and term.label == variable
				leftTerm = term.copy()
				leftTerms.push leftTerm
			else
				rightTerm = term.copy()
				rightTerm.pow(-1)
				rightTerms.push rightTerm

		for term in @rightTerms
			if term instanceof Variable and term.label == variable
				leftTerm = term.copy()
				leftTerm.pow(-1)
				leftTerms.push leftTerm
			else
				rightTerm = term.copy()
				rightTerms.push rightTerm

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
			if term instanceof Variable and term.power == 0 then # Skip term.
			else
				output.push term.toString()

		leftHandSide = output.join " * "

		output = []
		for term in @rightTerms
			if term instanceof Variable and term.power == 0 then # Skip term.
			else
				output.push term.toString()

		rightHandSide = output.join " * "

		return leftHandSide + " = " + rightHandSide

exportGlobals = ->
	# Export globals for use elsewhere.
	# http://stackoverflow.com/questions/4214731/coffeescript-global-variables/4215132#4215132

	# Setup.
	topRoot = exports ? this
	topRoot.algebra = {}
	root = topRoot.algebra

	# Export.
	root.Variable = Variable
	root.Constant = Constant
	root.Equation = Equation
	# I probably will need to change this interface at some point to make it significantly more abstracted. But it'll do for now.

exportGlobals()