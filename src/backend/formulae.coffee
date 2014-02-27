define ["coffeequate"], (coffeequate) ->

	# Retrieve a Coffeequate expression by its name.

	formulae =
		# These are all functions, so they return new copies each time.

		# Mechanics.
		## Force.
		"force": -> new coffeequate.Equation("F::{kg * m * s**-2}", "m::{kg} * a::{m * s**-2}")
		"centripetal-force": -> new coffeequate.Equation("F::{kg * m * s**-2}", "m::{kg} * v::{m * s**-1}**2 * r::{m}**-1")
		"friction-force": -> new coffeequate.Equation("F::{kg * m * s**-2}", "μ * N::{kg * m * s**-2}")
		"drag-force": -> new coffeequate.Equation("F::{kg * m * s**-2}", "1/2 * ρ::{kg * m**-3} * A::{m**2} * C * v::{m * s**-1}**2")

		## Torque.
		"torque": -> new coffeequate.Equation("τ::{kg * m**2 * s**-2}", "F::{kg * m * s**-2} * dperpendicular::{m}")

		## Gravity
		"gravitational-force": -> new coffeequate.Equation("F::{kg * m * s**-2}", "\\G * m::{kg} * M::{kg} * r::{m}**-2")
		"gravitational-force-simple": -> new coffeequate.Equation("F::{kg * m * s**-2}", "m::{kg} * g::{m * s**-2}")
		"gravitational-potential-energy": -> new coffeequate.Equation("Ep::{kg * m**2 * s**-2}", "-1 * \\G * m::{kg} * M::{kg} * r::{m}**-1")
		"gravitational-potential-energy-simple": -> new coffeequate.Equation("Ep::{kg * m**2 * s**-2}", "m::{kg} * g::{m * s**-2} * h::{m}")

		## Springs.
		"spring-force": -> new coffeequate.Equation("F::{kg * m * s**-2}", "-k::{kg * s**-2} * D::{m}")
		"spring-energy": -> new coffeequate.Equation("E::{kg * m**2 * s**-2}", "1/2 * k::{kg * s**-2} * D::{m}**2")

		## Momentum.
		"momentum": -> new coffeequate.Equation("p::{kg * m * s**-1}", "m::{kg} * v::{m * s**-1}")
		"angular-momentum": -> new coffeequate.Equation("L::{kg * m**2 * s**-1}", "I::{kg * m**2} * ω::{s**-1}")

		## Moment of inertia.
		"moment-of-inertia-disk": -> new coffeequate.Equation("I::{kg * m**2}", "1/2 * m::{kg} * R::{m}**2")
		"moment-of-inertia-point": -> new coffeequate.Equation("I::{kg * m**2}", "m::{kg} * R::{m}**2")

		## Velocity and acceleration.
		"projectile-motion": -> new coffeequate.Equation("s::{m}", "u::{m * s**-1} * t::{s} + 1/2 * a::{m * s**-2} * t::{s}**2")
		"projectile-velocity": -> new coffeequate.Equation("v::{m * s**-1}", "u::{m * s**-1} + a::{m * s**-2} * t::{s}")
		"projectile-velocity-squared": -> new coffeequate.Equation("v::{m * s**-1}", "(u::{m * s**-1}**2 + 2 * a::{m * s**-2} * s::{m})**1/2")
		"differential-velocity": -> new coffeequate.Equation("a::{m * s**-2}", "@v::{m * s**-2}")
		"distance-over-time": -> new coffeequate.Equation("v::{m * s**-1}", "d::{m} * t::{s}**-1")
		"velocity-over-time": -> new coffeequate.Equation("a::{m * s**-2}", "v::{m * s**-1} * t::{s}**-1")
		"angular-velocity": -> new coffeequate.Equation("v::{m * s**-1}", "r::{m} * ω::{s**-1}")

		## Energy.
		"kinetic-energy": -> new coffeequate.Equation("Ek::{kg * m**2 * s**-2}", "m::{kg} * v::{m * s**-1}**2 * 1/2")
		"energy-mass-relation": -> new coffeequate.Equation("E::{kg * m**2 * s**-2}", "m::{kg} * \\c ** 2")
		"rotational-energy": -> new coffeequate.Equation("E::{kg * m**2 * s**-2}", "I::{kg * m**2} * ω::{s**-1}**2")
		"heat-energy": -> new coffeequate.Equation("EH::{kg * m**2 * s**-2}", "c::{m * s**-2 * K**-1} * m::{kg} * ΔT::{K}")

		## Radiation and power.
		"black-body-radiation-power": -> new coffeequate.Equation("P::{kg * m**2 * s**-3}", "A::{m**2} * \\σ * T::{K}**4")
		"heat-flow-through-insulator": -> new coffeequate.Equation("P::{kg * m**2 * s**-3}", "A::{m**2} * ΔT::{K} * R::{kg**-1 * s**3 * K}")
		"larmor-radiation-power": -> new coffeequate.Equation("@E::{kg * m**2 * s**-3}", "-2/3 * q::{A * s}**2 * (4 * \\π * \\ε0)**-1 * a::{m * s**-2}**2 * \\c::{m * s**-1}**-1")

		# Properties.
		"volume-density": -> new coffeequate.Equation("ρ::{kg * m**-3}", "m::{kg} * V::{m**3}**-1")

		# Electromagnetism.
		"coulombs-law": -> new coffeequate.Equation("F::{kg * m * s**-2}", "(4 * \\π * \\ε0)**-1 * q1::{A * s} * q2::{A * s} * r::{m}**-2")
		"electric-field-strength": -> new coffeequate.Equation("E::{kg * m * s**-3 * A}", "F::{kg * m * s**-2} * q::{A * s}**-1")

		# Quantum mechanics.

		# Thermodynamics.
		"ideal-gas": -> new coffeequate.Equation("P::{kg * m**-1 * s**-2}", "n::{mol} * \\R * T::{K} * V::{m**3}**-1")

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

		makeExpression: (right) ->
			# Make a new expression from a string.
			return new coffeequate.parse.stringToExpression(right)

	}