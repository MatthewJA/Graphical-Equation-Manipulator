define ["coffeequate"], (coffeequate) ->

	# Retrieve a Coffeequate expression by its name.

	# Each formula is an object with properties: name, description, keywords, equation

	formulae =
		# These are all functions, so they return new copies each time.

		# Mechanics.
		## Force.
		"force":
			name: "Newton's 2nd Law"
			keywords: ["force", "newton's", "law", "2nd", "mass", "acceleration"]
			equation: -> new coffeequate.Equation("F::{kg * m * s**-2}", "m::{kg} * a::{m * s**-2}")

		"centripetal-force":
			name: "Centripetal Force"
			keywords: ["centripetal", "force", "mass", "velocity", "radius", "distance", "length"]
			equation: -> new coffeequate.Equation("F::{kg * m * s**-2}", "m::{kg} * v::{m * s**-1}**2 * r::{m}**-1")

		"friction-force":
			name: "Friction"
			keywords: ["friction", "force", "coefficient of", "normal"]
			equation: -> new coffeequate.Equation("F::{kg * m * s**-2}", "μ * N::{kg * m * s**-2}")

		"drag-force":
			name: "Drag"
			keywords: ["drag", "force", "density", "area", "velocity", "coefficient of", "speed"]
			equation: -> new coffeequate.Equation("F::{kg * m * s**-2}", "1/2 * ρ::{kg * m**-3} * A::{m**2} * C * v::{m * s**-1}**2")

		## Torque.
		"torque":
			name: "Torque"
			keywords: ["torque", "force", "distance", "perpendicular"]
			equation: -> new coffeequate.Equation("τ::{kg * m**2 * s**-2}", "F::{kg * m * s**-2} * dperpendicular::{m}")

		## Gravity
		"gravitational-force":
			name: "Gravitational Force"
			keywords: ["gravity", "gravitational", "force", "mass", "distance"]
			equation: -> new coffeequate.Equation("F::{kg * m * s**-2}", "\\G * m::{kg} * M::{kg} * r::{m}**-2")

		"gravitational-force-simple":
			name: "Gravitational Force in a Constant Gravitational Field"
			keywords: ["gravity", "gravitational", "force", "mass", "distance"]
			equation: -> new coffeequate.Equation("F::{kg * m * s**-2}", "m::{kg} * g::{m * s**-2}")

		"gravitational-potential-energy":
			name: "Gravitational Potential Energy"
			keywords: ["gravity", "gravitational", "potential", "energy", "mass", "distance"]
			equation: -> new coffeequate.Equation("Ep::{kg * m**2 * s**-2}", "-1 * \\G * m::{kg} * M::{kg} * r::{m}**-1")

		"gravitational-potential-energy-simple":
			name: "Gravitational Potential Energy in a Constant Gravitational Field"
			keywords: ["gravity", "gravitational", "potential", "energy", "mass", "distance"]
			equation: -> new coffeequate.Equation("Ep::{kg * m**2 * s**-2}", "m::{kg} * g::{m * s**-2} * h::{m}")

		## Springs.
		"spring-force":
			name: "Spring Force"
			keywords: ["spring", "force", "constant", "distance", "displacement"]
			equation: -> new coffeequate.Equation("F::{kg * m * s**-2}", "-k::{kg * s**-2} * D::{m}")

		"spring-energy":
			name: "Spring Energy"
			keywords: ["spring", "energy", "constant", "distance", "displacement"]
			equation: -> new coffeequate.Equation("E::{kg * m**2 * s**-2}", "1/2 * k::{kg * s**-2} * D::{m}**2")

		## Momentum.
		"momentum":
			name: "Momentum"
			keywords: ["momentum", "mass", "velocity", "speed"]
			equation: -> new coffeequate.Equation("p::{kg * m * s**-1}", "m::{kg} * v::{m * s**-1}")

		"angular-momentum":
			name: "Angular Momentum"
			keywords: ["angular", "momentum", "moment of", "inertia", "frequency"]
			equation: -> new coffeequate.Equation("L::{kg * m**2 * s**-1}", "I::{kg * m**2} * ω::{s**-1}")

		## Moment of inertia.
		"moment-of-inertia-disk":
			name: "Moment of Inertia for a Disk"
			keywords: ["moment of", "inertia", "disk", "mass", "radius"]
			equation: -> new coffeequate.Equation("I::{kg * m**2}", "1/2 * m::{kg} * R::{m}**2")

		"moment-of-inertia-point":
			name: "Moment of Inertia for a Point Mass"
			keywords: ["moment of", "inertia", "point", "mass", "radius"]
			equation: -> new coffeequate.Equation("I::{kg * m**2}", "m::{kg} * R::{m}**2")

		## Velocity and acceleration.
		"projectile-motion":
			name: "Projectile Motion Displacement"
			keywords: ["projectile", "motion", "displacement", "distance", "time", "speed", "initial", "velocity", "final", "acceleration"]
			equation: -> new coffeequate.Equation("s::{m}", "u::{m * s**-1} * t::{s} + 1/2 * a::{m * s**-2} * t::{s}**2")

		"projectile-velocity":
			name: "Projectile Motion Velocity"
			keywords: ["projectile", "motion", "velocity", "speed", "initial", "final", "acceleration", "time"]
			equation: -> new coffeequate.Equation("v::{m * s**-1}", "u::{m * s**-1} + a::{m * s**-2} * t::{s}")

		"distance-over-time":
			name: "Velocity"
			keywords: ["velocity", "distance", "time", "displacement", "speed"]
			equation: -> new coffeequate.Equation("v::{m * s**-1}", "d::{m} * t::{s}**-1")

		"velocity-over-time":
			name: "Acceleration"
			keywords: ["acceleration", "velocity", "speed", "time"]
			equation: -> new coffeequate.Equation("a::{m * s**-2}", "v::{m * s**-1} * t::{s}**-1")

		"angular-velocity":
			name: "Angular Velocity"
			keywords: ["angular", "velocity", "radius", "distance", "displacement", "frequency"]
			equation: -> new coffeequate.Equation("v::{m * s**-1}", "r::{m} * ω::{s**-1}")

		## Energy.
		"kinetic-energy":
			name: "Kinetic Energy"
			keywords: ["kinetic", "energy", "mass", "velocity", "speed"]
			equation: -> new coffeequate.Equation("Ek::{kg * m**2 * s**-2}", "m::{kg} * v::{m * s**-1}**2 * 1/2")

		"energy-mass-relation":
			name: "Energy-Mass Equivalence"
			keywords: ["energy", "mass", "relation", "equivalence", "einstein"]
			equation: -> new coffeequate.Equation("E::{kg * m**2 * s**-2}", "m::{kg} * \\c ** 2")

		# "rotational-energy":
		# 	equation: -> new coffeequate.Equation("E::{kg * m**2 * s**-2}", "I::{kg * m**2} * ω::{s**-1}**2")
		# "heat-energy":
		# 	equation: -> new coffeequate.Equation("EH::{kg * m**2 * s**-2}", "c::{m * s**-2 * K**-1} * m::{kg} * ΔT::{K}")
		# "internal-energy":
		# 	equation: -> new coffeequate.Equation("ΔU::{kg * m**2 * s**-2}", "Q::{kg * m**2 * s**-2} + W::{kg * m**2 * s**-2}")
		# "work-from-pressure-volume":
		# 	equation: -> new coffeequate.Equation("W::{kg * m**2 * s**-2}", "P::{kg * m**-1 * s**-2} * V::{m**3}")

		# ## Radiation and power.
		# "black-body-radiation-power":
		# 	equation: -> new coffeequate.Equation("P::{kg * m**2 * s**-3}", "A::{m**2} * \\σ * T::{K}**4")
		# "heat-flow-through-insulator":
		# 	equation: -> new coffeequate.Equation("P::{kg * m**2 * s**-3}", "A::{m**2} * ΔT::{K} * R::{kg**-1 * s**3 * K}")
		# "larmor-radiation-power":
		# 	equation: -> new coffeequate.Equation("@E::{kg * m**2 * s**-3}", "-2/3 * q::{A * s}**2 * (4 * \\π * \\ε0)**-1 * a::{m * s**-2}**2 * \\c::{m * s**-1}**-1")

		# # Properties.
		# "volume-density":
		# 	equation: -> new coffeequate.Equation("ρ::{kg * m**-3}", "m::{kg} * V::{m**3}**-1")

		# # Electromagnetism.
		# "coulombs-law":
		# 	equation: -> new coffeequate.Equation("F::{kg * m * s**-2}", "(4 * \\π * \\ε0)**-1 * q1::{A * s} * q2::{A * s} * r::{m}**-2")
		# "electric-field-strength":
		# 	equation: -> new coffeequate.Equation("E::{kg * m * s**-3 * A}", "F::{kg * m * s**-2} * q::{A * s}**-1")

		# # Quantum mechanics.

		# # Thermodynamics.
		# "ideal-gas":
		# 	equation: -> new coffeequate.Equation("P::{kg * m**-1 * s**-2}", "n::{mol} * \\R * T::{K} * V::{m**3}**-1")

		# # Geometry.
		# "radius-circumference":
		# 	equation: -> new coffeequate.Equation("c::{m}", "2 * \\π * r::{m}")
		# "circle-area":
		# 	equation: -> new coffeequate.Equation("A::{m**2}", "\\π * r::{m}**2")
		# "rectangle-area":
		# 	equation: -> new coffeequate.Equation("A::{m**2}", "w::{m} * l::{m}")
		# "prism-volume":
		# 	equation: -> new coffeequate.Equation("V::{m**3}", "A::{m**2} * h::{m}")

	return {
		getEquation: (name) ->
			# name: The name of the equation to return.
			# -> The equation of the given name.
			if name of formulae
				return formulae[name].equation()
			else
				throw new Error("No formula called " + name + " exists.")

		getAllFormulaNames: ->
			# Return an array of the names of all the formulae.
			names = []
			for formula of formulae
				names.push(formula)

			return names

		getName: (name) ->
			# Return the proper name of an equation.
			if name of formulae
				return formulae[name].name
			else
				throw new Error("No formula called " + name + " exists.")

		getKeywords: (name) ->
			# Return the keywords of an equation.
			if name of formulae
				return formulae[name].keywords
			else
				throw new Error("No formula called " + name + " exists.")

		makeEquation: (left, right) ->
			# Make a new equation. Wrapper.
			return new coffeequate.Equation(left, right)

		makeExpression: (right) ->
			# Make a new expression from a string.
			return new coffeequate.parse.stringToExpression(right)

	}