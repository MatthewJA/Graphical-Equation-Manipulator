define ["JSAlgebra/variable", "JSAlgebra/constant", "JSAlgebra/equation"], (Variable, Constant, Equation) ->

	describe "Can solve simple equations", ->

		it "involving multiplication", ->
			equation = new Equation(["E"], ["m", "c**2"])

			result = equation.solve "m"
			expect(result).toEqual new Equation(["m"], ["E", "c**-2"])

			result = equation.solve "c"
			expect(result).toEqual new Equation(["c"], ["E**0.5", "m**-0.5"])

			result = equation.solve "E"
			expect(result).toEqual equation

		it "involving constants and multiplication", ->
			equation = new Equation(["E"], ["1/2", "m", "v**2"])

			result = equation.solve("m")
			expect(result).toEqual new Equation(["m"], [2, "E", "v**-2"])

			result = equation.solve("v")
			expect(result).toEqual new Equation(["v"], [Math.pow(2, 0.5), "E**0.5", "m**-0.5"])

			result = equation.solve("E")
			expect(result).toEqual equation