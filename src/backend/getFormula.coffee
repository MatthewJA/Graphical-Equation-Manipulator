define ["JSAlgebra/equation"], (Equation) ->

	# Retrieve a JS-Algebra equation by its name.

	formulae =
		"kinetic-energy": -> new Equation(["Ek"], ["1/2", "m", "v**2"]) # These are all functions, so they return new copies each time.
		"momentum": -> new Equation(["p"], ["m", "v"])
		"gravity": -> new Equation(["F"], ["G", "m", "M", "r**-2"])
		"gravitational-potential-energy": -> new Equation(["Ep"], ["-1", "G", "m", "M", "r**-1"])
		"gravitational-potential-energy-simple": -> new Equation(["Ep"], ["m", "g", "h"])
		"force": -> new Equation(["F"], ["m", "a"])
		"centripetal-force": -> new Equation(["F"], ["m", "v**2", "r**-1"])
		"product": -> new Equation(["a"], ["b", "c"])
		"contrived-example": -> new Equation(["3", "z", "x"], ["y", "w**3"])

	return (name) ->
		# name: The name of the equation to return.
		# -> The equation of the given name.
		if name of formulae
			return formulae[name]()
		else
			throw new Error("No formula called " + name + " exists.")