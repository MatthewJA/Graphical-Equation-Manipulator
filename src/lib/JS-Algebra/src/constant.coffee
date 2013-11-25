define [], ->
	class Constant
		# A (fractional) constant in an equation. Has a numerator and a denominator.
		constructor: (@numerator, @denominator=1) ->
			# numerator: Top half of the fraction.
			# denominator: Bottom half of the fraction.

			@isTerm = true # To avoid instanceof, which doesn't seem to be working.
			@isConstant = true # "

		pow: (power) ->
			# Raise this constant to a power.
			# power: The power to raise this constant to.

			if power < 0
				# Reciprocate, then evaluate.
				power *= -1
				[@numerator, @denominator] = [@denominator, @numerator]

			@numerator = Math.pow(@numerator, power)
			@denominator = Math.pow(@denominator, power)

		multiply: (constant) ->
			# Multiply this constant by another.
			# constant: The constant to multiply by.
			return new Constant(@numerator * constant.numerator, @denominator * constant.denominator)

		simplify: ->
			# Simplify the constant to the simplest possible fraction.

			# Find the greatest common divisor of the numerator and the denominator using Euclid's algorithm.
			a = @numerator, @denominator
			b = @numerator, @denominator

			until b == 0
				[a, b] = [b, a % b]
			
			gcd = a

			# Divide out.
			@numerator /= gcd
			@denominator /= gcd

		evaluate: ->
			# Evaluate this constant and return a float.
			return @numerator/@denominator

		copy: ->
			# Return a copy of this constant.
			new Constant(@numerator, @denominator)

		toMathML: ->
			# Return this constant as a MathML string.
			if @denominator == 1
				return "<mn>#{@numerator}</mn>"
			return "<mfrac><mrow><mn>#{@numerator}</mn></mrow><mrow><mn>#{@denominator}</mn></mrow></mfrac>"

		toString: ->
			if @denominator == 1
				return "#{@numerator}"
			return "#{@numerator}/#{@denominator}"