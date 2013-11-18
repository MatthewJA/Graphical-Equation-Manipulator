describe "Can solve simple equations", ->

	beforeEach ->
		algebra = window.algebra

	it "involving multiplication", ->
		E = new algebra.Variable("E")
		m = new algebra.Variable("m")
		c2 = new algebra.Variable("c", 2)

		Eh = new algebra.Variable("E", 0.5)
		cn2 = new algebra.Variable("c", -2)
		c = new algebra.Variable("c")
		mnh = new algebra.Variable("m", -0.5)

		equation = new algebra.Equation([E], [m, c2])

		result = equation.solve("m")
		expect(result).toEqual new algebra.Equation([m], [E, cn2])

		result = equation.solve("c")
		expect(result).toEqual new algebra.Equation([c], [Eh, mnh])

		result = equation.solve("E")
		expect(result).toEqual equation

	it "involving constants and multiplication", ->
		E = new algebra.Variable("E")
		h = new algebra.Constant(1, 2)
		m = new algebra.Variable("m")
		v2 = new algebra.Variable("v", 2)

		v = new algebra.Variable("v")
		Eh = new algebra.Variable("E", 0.5)
		mnh = new algebra.Variable("m", -0.5)
		vn2 = new algebra.Variable("v", -2)
		two = new algebra.Constant(2)
		sqrt2 = new algebra.Constant(Math.pow(2, 0.5))

		equation = new algebra.Equation([E], [h, m, v2])

		result = equation.solve("m")
		expect(result).toEqual new algebra.Equation([m], [E, two, vn2])

		result = equation.solve("v")
		expect(result).toEqual new algebra.Equation([v], [Eh, sqrt2, mnh])

		result = equation.solve("E")
		expect(result).toEqual equation

describe "Fails reasonably when", ->

	beforeEach ->
		algebra = window.algebra

	it "attempting to solve an equation for a variable it does not contain", ->
		a = new algebra.Variable("a")
		b = new algebra.Variable("b")

		equation = new algebra.Equation([a], [b])

		expect(-> equation.solve("z")).toThrow(new algebra.AlgebraException("Variable to solve for was not in equation."))