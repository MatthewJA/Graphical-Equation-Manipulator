define [], ->
	class Variable
		# A variable in an equation.
		constructor: (@label, @power=1) ->
			# label: The name of this variable.
			# power: The initial power this variable is raised to.

			@isTerm = true # To avoid instanceof, which doesn't seem to be working.
			@isVariable = true # "

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

		toMathML: ->
			if @label.length > 1
				labelOutput = '<msub class="variable"><mi>' + @label[0] + '</mi><mi>' + @label[1..] + "</mi></msub>"
			else
				labelOutput = '<mi class="variable">' + @label + '</mi>'

			if term.power == 1
				return labelOutput
			else if term.power > 0
				return '<msup>' + labelOutput + '<mn>' + @power + "</mn></msup>"