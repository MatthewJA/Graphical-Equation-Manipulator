define [], ->
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