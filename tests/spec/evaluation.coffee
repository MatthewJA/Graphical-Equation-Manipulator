define [
	"JSAlgebra/equation"
], (Equation) ->

	describe "Can evaluate simple equations", ->

		it "involving multiplication of variables", ->
			equation = new Equation(["p"], ["m", "v"])
			expect(equation.sub({"m": 5, "v": 2})).toEqual(new Equation(["p"], [10]))
			expect(equation.sub({"v": 2})).toEqual(new Equation(["p"], [2, "m"]))
			expect(equation.sub({"p": 10, "v": 2})).toEqual(new Equation([1], ["2/10", "m"]))
			expect(equation.sub({})).toEqual(equation)

		it "involving multiplication of variables and constants", ->
			equation = new Equation(["Ek"], ["1/2", "m", "v**2"])
			expect(equation.sub({"m": 5, "v": 2})).toEqual(new Equation(["Ek"], ["20/2"]))
			expect(equation.sub({"v": 2})).toEqual(new Equation(["Ek"], ["4/2", "m"]))

		it "for a particular variable, if given enough values to solve the whole equation", ->
			equation = new Equation(["Ek"], ["1/2", "m", "v**2"])
			expect(equation.evaluate("Ek", {"m": 5, "v": 2})).toEqual(10)
			expect(equation.evaluate("m", {"Ek": 10, "v": 2})).toEqual(5)

		it "for a particular variable, if not given enough values to solve the whole equation", ->
			equation = new Equation(["Ek"], ["1/2", "m", "v**2"])
			expect(equation.evaluate("Ek", {"m": 5})).toEqual(new Equation(["Ek"], ["5/2", "v**2"]))
			expect(equation.evaluate("Ek", {"v": 2})).toEqual(new Equation(["Ek"], ["4/2", "m"]))
			expect(equation.evaluate("m", {"v": 2})).toEqual(new Equation(["m"], ["2/4", "Ek"]))