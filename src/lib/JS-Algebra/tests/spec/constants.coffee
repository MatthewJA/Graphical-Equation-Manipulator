define [
	"JSAlgebra/constant"
], (Constant) ->

	describe "Constants", ->

		it "can be simplified", ->
			half = new Constant(2, 4)
			half.simplify()
			expect(half).toEqual(new Constant(1, 2))

		it "can be made into non-decimal forms", ->
			half = new Constant(0.5)
			half.simplify()
			expect(half).toEqual(new Constant(1, 2))