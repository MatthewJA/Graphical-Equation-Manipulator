define ["src/variable", "src/constant", "src/equation"], (Variable, Constant, Equation) ->

	describe "Can solve simple equations", ->

		it "involving multiplication", ->
			E = new Variable("E")
			m = new Variable("m")
			c2 = new Variable("c", 2)

			Eh = new Variable("E", 0.5)
			cn2 = new Variable("c", -2)
			mnh = new Variable("m", -0.5)
			c = new Variable("c")

			equation = new Equation([E], [m, c2])

			result = equation.solve "m"
			expect(result).toEqual new Equation([m], [E, cn2])

			result = equation.solve "c"
			expect(result).toEqual new Equation([c], [Eh, mnh])

			result = equation.solve "E"
			expect(result).toEqual equation

		it "involving constants and multiplication", ->
			E = new Variable("E")
			h = new Constant(1, 2)
			m = new Variable("m")
			v2 = new Variable("v", 2)

			v = new Variable("v")
			Eh = new Variable("E", 0.5)
			mnh = new Variable("m", -0.5)
			vn2 = new Variable("v", -2)
			two = new Constant(2)
			sqrt2 = new Constant(Math.pow(2, 0.5))

			equation = new Equation([E], [h, m, v2])

			result = equation.solve("m")
			expect(result).toEqual new Equation([m], [E, two, vn2])

			result = equation.solve("v")
			expect(result).toEqual new Equation([v], [Eh, sqrt2, mnh])

			result = equation.solve("E")
			expect(result).toEqual equation