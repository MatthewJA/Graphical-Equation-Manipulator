define ["coffeequate"], (coffeequate) ->

	# Retrieve a Coffeequate expression by its name.

	formulae =
		# These are all functions, so they return new copies each time.

		# Mechanics.
		## Force.
		"force": -> new coffeequate.Equation("F::{kg * m * s**-2}", "m::{kg} * a::{m * s**-2}")
		"centripetal-force": -> new coffeequate.Equation("F::{kg * m * s**-2}", "m::{kg} * v::{m * s**-1}**2 * r::{m}**-1")
		"gravity-force": -> new coffeequate.Equation("F::{kg * m * s**-2}", "\\G * m::{kg} * M::{kg} * r::{m}**-2")
		"friction-force": -> new coffeequate.Equation("F::{kg * m * s**-2}", "μ * N::{kg * m * s**-2}")

		## Momentum.
		"momentum": -> new coffeequate.Equation("p::{kg * m * s**-1}", "m::{kg} * v::{m * s**-1}")
		"angular-momentum": -> new coffeequate.Equation("L::{kg * m**2 * s**-1}", "I::{kg * m**2} * ω::{s**-1}")

		## Moment of inertia.
		"moment-of-inertia-disk": -> new coffeequate.Equation("I::{kg * m**2}", "1/2 * m::{kg} * R::{m}**2")
		"moment-of-inertia-point": -> new coffeequate.Equation("I::{kg * m**2}", "m::{kg} * R::{m}**2")

		## Velocity and acceleration.
		"projectile-motion": -> new coffeequate.Equation("s::{m}", "u::{m * s**-1} * t::{s} + 1/2 * a::{m * s**-2} * t::{s}**2")
		"projectile-velocity": -> new coffeequate.Equation("v::{m * s**-1}", "u::{m * s**-1} + a::{m * s**-2} * t::{s}")
		"differential-velocity": -> new coffeequate.Equation("a::{m * s**-2}", "@v::{m * s**-2}")
		"distance-over-time": -> new coffeequate.Equation("v::{m * s**-1}", "d::{m} * t::{s}**-1")
		"velocity-over-time": -> new coffeequate.Equation("a::{m * s**-2}", "v::{m * s**-1} * t::{s}**-1")
		"angular-velocity": -> new coffeequate.Equation("v::{m * s**-1}", "r::{m} * ω::{s**-1}")

		## Energy.
		"kinetic-energy": -> new coffeequate.Equation("Ek::{kg * m**2 * s**-2}", "m::{kg} * v::{m * s**-1}**2 * 1/2")
		"energy-mass-relation": -> new coffeequate.Equation("E::{kg * m**2 * s**-2}", "m::{kg} * \\c ** 2")
		"gravitational-potential-energy": -> new coffeequate.Equation("Ep::{kg * m**2 * s**-2}", "-1 * \\G * m::{kg} * M::{kg} * r::{m}**-1")
		"gravitational-potential-energy-simple": -> new coffeequate.Equation("Ep::{kg * m**2 * s**-2}", "m::{kg} * g::{m * s**-2} * h::{m}")
		"rotational-energy": -> new coffeequate.Equation("E::{kg * m**2 * s**-2}", "I::{kg * m**2} * ω::{s**-1}**2")

		# Properties.
		"volume-density": -> new coffeequate.Equation("ρ::{kg * m**-3}", "m::{kg} * V::{m**3}**-1")

		# Geometry.
		"radius-circumference": -> new coffeequate.Equation("c::{m}", "2 * \\π * r::{m}")
		"circle-area": -> new coffeequate.Equation("A::{m**2}", "\\π * r::{m}**2")
		"rectangle-area": -> new coffeequate.Equation("A::{m**2}", "w::{m} * l::{m}")
		"prism-volume": -> new coffeequate.Equation("V::{m**3}", "A::{m**2} * h::{m}")

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