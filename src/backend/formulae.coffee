define ["coffeequate"], (coffeequate) ->

	# Retrieve a Coffeequate expression by its name.

	formulae =
		"kinetic-energy": -> new coffeequate.Equation("Ek::{kg * m**2 * s**-2}",
								"m::{kg} * v::{m * s**-1}**2 * 1/2") # These are all functions, so they return new copies each time.
		"momentum": -> new coffeequate.Equation("p::{kg * m * s**-1}", "m::{kg} * v::{m * s**-1}")
		"gravity": -> new coffeequate.Equation("F::{kg * m * s**-2}", "\\G * m::{kg} * M::{kg} * r::{m}**-2")
		"gravitational-potential-energy": -> new coffeequate.Equation("Ep::{kg * m**2 * s**-2}", "-1 * \\G * m::{kg} * M::{kg} * r::{m}**-1")
		"gravitational-potential-energy-simple": -> new coffeequate.Equation("Ep::{kg * m**2 * s**-2}", "m::{kg} * g::{m * s**-2} * h::{m}")
		"force": -> new coffeequate.Equation("F::{kg * m * s**-2}", "m::{kg} * a::{m * s**-2}")
		"centripetal-force": -> new coffeequate.Equation("F::{kg * m * s**-2}", "m::{kg} * v::{m * s**-1}**2 * r::{m}**-1")
		"projectile-motion": -> new coffeequate.Equation("s::{m}", "u::{m * s**-1} * t::{s} + 1/2 * a::{m * s**-2} * t::{s}**2")
		"projectile-velocity": -> new coffeequate.Equation("v::{m * s**-1}", "u::{m * s**-1} + a::{m * s**-2} * t::{s}")
		"energy-mass-relation": -> new coffeequate.Equation("E::{kg * m**2 * s**-2}", "m::{kg} * \\c ** 2")
		"differential-velocity": -> new coffeequate.Equation("a::{m * s**-2}", "@v::{m * s**-2}")
		"distance-over-time": -> new coffeequate.Equation("v::{m * s**-1}", "d::{m} * t::{s}**-1")
		"velocity-over-time": -> new coffeequate.Equation("a::{m * s**-2}", "v::{m * s**-1} * t::{s}**-1")
		"radius-circumference": -> new coffeequate.Equation("c::{m}", "2 * \\π * r::{m}")

	return {
		get: (name) ->
			# name: The name of the equation to return.
			# -> The equation of the given name.
			if name of formulae
				console.log formulae[name]()
				return formulae[name]()
			else
				throw new Error("No formula called " + name + " exists.")

		getAllFormulaNames: ->
			# Return an array of the names of all the formulae.
			names = []
			for formula of formulae
				names.push(formula)

			return names

		makeEquation: (left, right) ->
			# Make a new equation. Wrapper.
			return new coffeequate.Equation(left, right)

	}