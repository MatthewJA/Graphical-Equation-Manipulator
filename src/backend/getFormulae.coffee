define ["JSAlgebra/equation"], (Equation) ->

	# Stores the formulae available for use in a singleton object.
	# Formulae are JS-Algebra Equation objects. The getFormulae() object
	# maps a string formula ID to the equation it represents.

	formulae =
		"kinetic-energy": new Equation(["Ek"], ["1/2", "m", "v**2"])
		"momentum": new Equation(["p"], ["m", "v"])
		"gravity": new Equation(["F"], ["G", "m", "M", "r**-2"])
		"gravitational-potential-energy": new Equation(["Ep"], ["-1", "G", "m", "M", "r**-1"])
	-> formulae