define ["JSAlgebra/equation"], (Equation) ->
	# Stores the formulae available for use.
	formulae =
		"kinetic-energy": new Equation(["Ek"], ["m", "v**2"])
	-> formulae