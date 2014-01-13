define [
	"backend/solveEquation"
	"backend/formulae"
	"backend/equationIndex"
	"JSAlgebra/equation"
], (solveEquation, formulae, equationIndex, Equation) ->

	describe "Can solve", ->

		it "physics equations linearly", ->
			equation = formulae.get("momentum")
			equationID = equationIndex.add(equation)
			expect(solveEquation(equationID, "p")).toEqual equation
			expect(solveEquation(equationID, "m")).toEqual (new Equation(["m"], ["p", "v**-1"]))