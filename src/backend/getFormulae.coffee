define ["JSAlgebra/equation"], (Equation) ->
	# Stores the formulae available for use.
	formulae =
		"kinetic-energy": new Equation(["Ek"], ["1/2", "m", "v**2"])
		"momentum": new Equation(["p"], ["m", "v"])
	-> formulae