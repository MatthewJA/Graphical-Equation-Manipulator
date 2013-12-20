define [], ->
	class Constant
		# A (fractional) constant in an equation. Has a numerator and a denominator.
		constructor: (@numerator, @denominator=1, roots=null) ->
			# numerator: Top half of the fraction.
			# denominator: Bottom half of the fraction.
			# roots: Maps a root to how many times this constant is rooted by it.

			@isTerm = true # To avoid instanceof, which doesn't seem to be working.
			@isConstant = true # "

			if roots?
				@roots = roots
			else
				@roots = {} # Object mapping roots to how many roots there are.
				# E.g. {2: 1} means that this constant is square rooted.

		pow: (power) ->
			# Raise this constant to a power.
			# power: The power to raise this constant to.\

			if power < 0
				# Reciprocate, then evaluate.
				power *= -1
				[@numerator, @denominator] = [@denominator, @numerator]

			# Is the power fractional?
			[num, den] = @fractionSimplify(power)
			console.log(num, den)

			unless den == 1
				# It is, so we need to root this.
				# What is the root?
				# For now, we're going to use a number guesser to find what number it is.
				for i in [2..9] # We'll ignore larger roots.
					if -0.000001 <= power - (1/i) < 0.000001
						# Good enough!
						power *= i
						den = i

						if den of @roots
							@roots[den] += 1
						else
							@roots[den] = 1

						break

			@numerator = Math.pow(@numerator, power)
			@denominator = Math.pow(@denominator, power)

		multiply: (constant) ->
			# Multiply this constant by another.
			# constant: The constant to multiply by.
			a = constant.copy()
			b = @copy()

			for root of b.roots
				if b.roots[root] > 0
					for i in [1..b.roots[root]]
						a.pow(root)

			for root of a.roots
				if a.roots[root] > 0
					for i in [1..a.roots[root]]
						b.pow(root)

			roots = {}
			for root of a.roots
				if root of roots
					roots[root] += a.roots[root]
				else
					roots[root] = a.roots[root]
			for root of b.roots
				if root of roots
					roots[root] += b.roots[root]
				else
					roots[root] = b.roots[root]

			return new Constant(@numerator * constant.numerator, @denominator * constant.denominator, roots)

		simplify: ->
			# Simplify the constant to the simplest possible fraction.
			[@numerator, @denominator] = @fractionSimplify(@numerator, @denominator)

		fractionSimplify: (num, den=1) ->
			# Convert a numerator and a denominator into a reduced fraction.
			# Find the GCD of num and den using Euclid's algorithm.

			a = num
			b = den

			until b == 0
				[a, b] = [b, a % b]

			gcd = a

			# Divide out.
			num /= gcd
			den /= gcd

			return [num, den]

		evaluate: ->
			# Evaluate this constant and return a float.
			val = @numerator/@denominator
			for root of @roots
				val = Math.pow(val, 1/root)

			return val

		copy: ->
			# Return a copy of this constant.
			new Constant(@numerator, @denominator, @roots)

		toMathML: ->
			# Return this constant as a MathML string.
			if @denominator == 1
				str = "<mn>#{@numerator}</mn>"
			else
				str = "<mfrac><mrow><mn>#{@numerator}</mn></mrow><mrow><mn>#{@denominator}</mn></mrow></mfrac>"

			# Roots!
			for root of @roots
				if @roots[root] > 0
					str = "<mroot><mrow>#{str}</mrow><mn>#{root}</mn></mroot>"

			return str

		toString: ->
			if @denominator == 1
				str = "#{@numerator}"
			else
				str = "#{@numerator}/#{@denominator}"

			for root of @roots
				if @roots[root] > 0
					str = "(#{str})**(1/#{Math.pow(root, @roots[root])})"

			return str