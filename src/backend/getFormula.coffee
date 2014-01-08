define ["coffeequate"], (coffeequate) ->

	# Retrieve a Coffeequate expression by its name.

	formulae =
		"kinetic-energy": -> new coffeequate.Equation("Ek", "m * v**2 * 1/2") # These are all functions, so they return new copies each time.
		"momentum": -> new coffeequate.Equation("p", "m * v")
		"gravity": -> new coffeequate.Equation("F", "G * m * M * r**-2")
		"gravitational-potential-energy": -> new coffeequate.Equation("-1 * G * m * M * r**-1 + -Ep")
		"gravitational-potential-energy-simple": -> new coffeequate.Equation("m * g * h + -Ep")
		"force": -> new coffeequate.Equation("F", "m * a")
		"centripetal-force": -> new coffeequate.Equation("F", "m * v**2 * r**-1")
		"product": -> new coffeequate.Equation("a * b + -c")
		"contrived-example": -> new coffeequate.Equation("3 * z * x + -y * w**3")
		"contrived-pow-example": -> new coffeequate.Equation("a", "(b**-1)")
		"projectile-motion": -> new coffeequate.Equation("s", "u * t + 1/2 * a * t**2")

	return (name) ->
		# name: The name of the equation to return.
		# -> The equation of the given name.
		if name of formulae
			return formulae[name]()
		else
			throw new Error("No formula called " + name + " exists.")