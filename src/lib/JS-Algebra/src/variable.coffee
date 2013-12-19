define [], ->
	class Variable
		# A variable in an equation.
		constructor: (@label, @power=1, roots=null) ->
			# label: The name of this variable.
			# power: The initial power this variable is raised to.
			# roots: Maps a root to how many times this variable is rooted by it.

			@isTerm = true # To avoid instanceof, which doesn't seem to be working.
			@isVariable = true # "

			if roots?
				@roots = roots
			else
				@roots = {}

		pow: (power) ->
			# Raise this variable to a power.
			# power: The power to raise this variable to.

			console.log("Raising #{@} to the power of #{power}")

			if power of @roots
				@roots[power] -= 1
				return

			# Is the power fractional?
			[num, den] = @fractionSimplify(power)

			console.log("found #{num}/#{den}")

			unless den == 1
				# It is a fractional power, so we need to root this.
				# What is the root?
				# For now, we're going to use a number guesser to find what number it is.
				for i in [2..9] # We'll ignore larger roots.
					console.log(1/i, power)
					if -0.000001 <= (unless power < 0 then power else -power) - (1/i) < 0.000001
						# Good enough!
						power *= i
						den = i

						@power *= power

						# Can we evenly divide the power by our root instead of adding it?
						if @power % den == 0
							@power /= den
						else
							if den of @roots
								@roots[den] += 1
							else
								@roots[den] = 1
						return

			@power *= power

		copy: ->
			# Return a copy of this variable.
			new Variable(@label, @power, @roots)

		toString: ->
			switch @power
				when 1
					str = @label
				when 0
					return "1"
				else
					str = @label + "**" + @power

			for root of @roots
				if @roots[root] > 0
					str = "(#{str})**(1/#{root})"

			return str

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

		toMathML: ->
			# Strip off the ID of this variable if it has one.
			# IDs are separated by -'s.
			labelArray = @label.split("-")
			label = labelArray[0]
			labelID = if labelArray[1]? then 'id="variable-' + @label + '"' else ""

			if label.length > 1
				labelOutput = '<msub class="variable"' + labelID + '><mi>' + label[0] + '</mi><mi>' + label[1..] + "</mi></msub>"
			else
				labelOutput = '<mi class="variable"' + labelID + '>' + label + '</mi>'

			if @power == 1
				str = labelOutput
			else if @power > 0
				str = '<msup>' + labelOutput + '<mn>' + @power + "</mn></msup>"
			else
				return "1"

			for root of @roots
				if @roots[root] > 0
					str = "<mroot><mrow>#{str}</mrow><mn>#{root}</mn></mroot>"

			return str