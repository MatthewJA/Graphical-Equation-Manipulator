define ["coffeequate"], (coffeequate) ->

	# Retrieve a Coffeequate expression by its name.

	formulae =
		"kinetic-energy": -> coffeequate.parse.stringToExpression("1/2 * m * v**2 + -Ek") # These are all functions, so they return new copies each time.
		"momentum": -> coffeequate.parse.stringToExpression("m * v + -p")
		"gravity": -> coffeequate.parse.stringToExpression("G * m * M * r**-2 + -F")
		"gravitational-potential-energy": -> coffeequate.parse.stringToExpression("-1 * G * m * M * r**-1 + -Ep")
		"gravitational-potential-energy-simple": -> coffeequate.parse.stringToExpression("m * g * h + -Ep")
		"force": -> coffeequate.parse.stringToExpression("m * a + -F")
		"centripetal-force": -> coffeequate.parse.stringToExpression("m * v**2 * r**-1 + -F")
		"product": -> coffeequate.parse.stringToExpression("a * b + -c")
		"contrived-example": -> coffeequate.parse.stringToExpression("3 * z * x + -y * w**3")

	return (name) ->
		# name: The name of the equation to return.
		# -> The equation of the given name.
		if name of formulae
			return formulae[name]()
		else
			throw new Error("No formula called " + name + " exists.")