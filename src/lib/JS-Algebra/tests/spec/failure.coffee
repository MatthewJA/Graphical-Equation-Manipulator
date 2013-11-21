define ["variable", "constant", "equation", "algebraException"], (Variable, Constant, Equation, AlgebraException) ->

	describe "Fails reasonably when", ->

		it "attempting to solve an equation for a variable it does not contain", ->
			a = new Variable("a")
			b = new Variable("b")

			equation = new Equation([a], [b])

			expect(-> equation.solve("z")).toThrow(new AlgebraException("Variable to solve for was not in equation."))