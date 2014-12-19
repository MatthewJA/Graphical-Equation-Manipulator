# Storage of various dynamic parts of the application for later reference.

define ->

	equation = (->

		equations = []

		# Add a new equation to the index.
		#
		# @param equation [Equation] The new equation object.
		add = (equation) ->
			equation.id = equations.length
			equations.push(equation)

		# Get an equation from the index.
		#
		# @param id [Number] The id of the equation.
		get = (id) ->
			equations[id]

		# Get the original array of existing equations. Bad idea.
		#
		# @return [Array<Equation>] An array of equations *by reference*.
		getRawEquations = ->
			equations

		return {
			add: add
			get: get
			getRaw: getRawEquations
		}

	).call()


	expression = (->

		expressions = []

		# Add a new expression to the index.
		#
		# @param expression [Expression] The new expression object.
		add = (expression) ->
			expression.id = expressions.length
			expressions.push(expression)

		# Get an expression from the index.
		#
		# @param id [Number] The id of the expression.
		get = (id) ->
			expressions[id]

		# Get the original array of existing expressions. Bad idea.
		#
		# @return [Array<Expression>] An array of expressions *by reference*.
		getRawExpressions = ->
			expressions

		return {
			add: add
			get: get
			getRaw: getRawExpressions
		}

	).call()

	line = (->

		lines = []

		# Add a new line to the index.
		#
		# @param line [Line] The new line object.
		add = (line) ->
			line.id = lines.length
			lines.push(line)

		# Get a line from the index.
		#
		# @param id [Number] The id of the expression.
		get = (id) ->
			lines[id]

		# Get the original array of existing expressions. Bad idea.
		#
		# @return [Array<Line>] An array of lines *by reference*.
		getRawLines = ->
			lines

		redrawAll = (context) ->
			context = $("#lines-canvas")[0].getContext("2d") unless context?

			for line in lines
				line.draw(context)

		return {
			add: add
			get: get
			getRaw: getRawLines
			redrawAll: redrawAll
			}

	).call()

	return {
		equation: equation
		expression: expression
		line: line
	}