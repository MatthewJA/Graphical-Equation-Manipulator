define ["coffeequate"], (coffeequate) ->

	# Retrieve a Coffeequate expression by its name.

	formulae =
		"kinetic-energy": -> new coffeequate.Equation("Ek", "m * v**2 * 1/2") # These are all functions, so they return new copies each time.
		"momentum": -> new coffeequate.Equation("p", "m * v")
		"gravity": -> new coffeequate.Equation("F", "\\G * m * M * r**-2")
		"gravitational-potential-energy": -> new coffeequate.Equation("Ep", "-1 * \\G * m * M * r**-1")
		"gravitational-potential-energy-simple": -> new coffeequate.Equation("Ep", "m * g * h")
		"force": -> new coffeequate.Equation("F", "m * a")
		"centripetal-force": -> new coffeequate.Equation("F", "m * v**2 * r**-1")
		"product": -> new coffeequate.Equation("a", "b * c")
		"contrived-pow-example": -> new coffeequate.Equation("a", "(b**-1)")
		"projectile-motion": -> new coffeequate.Equation("s", "u * t + 1/2 * a * t**2")
		"energy-mass-relation": -> new coffeequate.Equation("E", "m * \\c ** 2")
		"differential-velocity": -> new coffeequate.Equation("a", "@v")
		"double-differential-location": -> new coffeequate.Equation("a", "@@s")

	return {
		get: (name) ->
			# name: The name of the equation to return.
			# -> The equation of the given name.
			if name of formulae
				return formulae[name]()
			else
				throw new Error("No formula called " + name + " exists.")

		getAllFormulaNames: ->
			# Return an array of the names of all the formulae.
			names = []
			for formula of formulae
				names.push(formula)

			return names

	}