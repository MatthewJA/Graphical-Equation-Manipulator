describe "Algebra", ->

	algebra = window.algebra

	it "can solve simple equations with multiplication", ->
		E = new algebra.Variable("E")
		m = new algebra.Variable("m")
		c = new algebra.Variable("c", 2)

		equation = new algebra.Equation([E], [m, c])

		result = equation.solve("m").toString()
		expect(result).toBe "m = E * c**-2"

		result = equation.solve("c").toString()
		expect(result).toBe "c = E**0.5 * m**-0.5"

	it "can solve simple equations with constants and multiplication", ->
		E = new algebra.Variable("E")
		h = new algebra.Constant(1, 2)
		m = new algebra.Variable("m")
		v = new algebra.Variable("v", 2)

		equation = new algebra.Equation([E], [h, m, v])

		result = equation.solve("m").toString()
		expect(result).toBe "m = E * 2 * v**-2"

		result = equation.solve("v").toString()
		expect(result).toBe "v = E**0.5 * " + Math.pow(2, 0.5) + " * m**-0.5"

		result = equation.solve("E").toString()
		expect(result).toBe "E = 1/2 * m * v**2"