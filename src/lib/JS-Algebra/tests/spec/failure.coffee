define [
	"JSAlgebra/variable"
	"JSAlgebra/constant"
	"JSAlgebra/equation"
	"JSAlgebra/algebraException"
], (Variable, Constant, Equation, AlgebraException) ->

	describe "Fails reasonably when", ->

		it "attempting to solve an equation for a variable it does not contain", ->
			equation = new Equation(["a"], ["b"])
			expect(-> equation.solve("z")).toThrow(new AlgebraException("Variable to solve for was not in equation."))

		it "attempting to substitute values that make no sense", ->
			equation = new Equation(["a"], ["b"])
			expect(-> equation.sub({"a": 1, "b": 2})).toThrow(new AlgebraException("Inconsistent numbers substituted into equation."))