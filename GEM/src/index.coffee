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
		add = (l) ->
			l.id = lines.length
			lines.push(l)

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

			for l in lines
				l.draw(context)

		return {
			add: add
			get: get
			getRaw: getRawLines
			redrawAll: redrawAll
			}

	).call()

	equivalency = (->

		equivalencies = {}

		# Add a new equivalency to the index. The text of the elements will be
		# stored.
		#
		# @param a [$(Element)] First element.
		# @param b [$(Element)] Second element.
		add = (a, b) ->
			al = a.text()
			bl = b.text()
			if al of equivalencies
				equivalencies[al].push(bl)
			else
				equivalencies[al] = [al, bl]

			if bl of equivalencies
				equivalencies[bl].push(al)
			else
				equivalencies[bl] = [bl, al]

			# Add a line between the variables.
			require ["Line"], (Line) =>
				l = new Line(a, b)
				line.add(l)
				l.draw($("#lines-canvas")[0].getContext("2d"))

		# Get an equivalency from the index.
		#
		# @param a [String] Label to get equivalencies of.
		# @return [Array<String>] Equivalencies.
		get = (a) ->
			equivalencies[a]

		# Get the raw equivalencies map.
		#
		# @return [Object] Map of equivalencies.
		getRawEquivalencies = ->
			equivalencies

		return {
			add: add
			get: get
			getRaw: getRawEquivalencies
		}

	).call()

	return {
		equation: equation
		expression: expression
		line: line
		equivalency: equivalency
	}