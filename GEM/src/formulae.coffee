# Holds all the formulae known to GEM.

define ["Equation"], (Eq) ->

	formulae = {

		"volume-density":
			name: "Density (volume)"
			keywords: ["density", "volume", "mass"]
			equation: -> new Eq("ρ", "V/m")

		"force":
			name: "Newton's 2nd Law"
			keywords: ["force", "newton's", "law", "2nd", "mass",
				"acceleration"]
			equation: -> new Eq("F", "m*a")

		"velocity":
			name: "Velocity"
			keywords: ["velocity", "speed", "distance", "displacement",
				"position", "location", "time"]
			equation: -> new Eq("v", "x/t")

		"acceleration":
			name: "Acceleration"
			keywords: ["acceleration", "velocity", "speed", "time"]
			equation: -> new Eq("a", "v/t")

		"jerk":
			name: "Jerk"
			keywords: ["jerk", "acceleration", "time"]
			equation: -> new Eq("j", "a/t")

		"angular-velocity":
			name: "Angular velocity"
			keywords: ["angular", "velocity", "rotation", "time", "radians",
				"angle"]
			equation: -> new Eq("ω", "θ/t")

		"angular-acceleration":
			name: "Angular acceleration"
			keywords: ["angular", "acceleration", "velocity", "rotation",
				"time", "radians", "angle"]
			equation: -> new Eq("α", "ω/t")

		"momentum":
			name: "Momentum"
			keywords: ["momentum", "mass", "velocity", "inertia"]
			equation: -> new Eq("p", "m*v")

		"impulse":
			name: "Impulse"
			keywords: ["impulse", "change", "momentum", "in"]
			equation: -> new Eq("Δp", "p2 - p1")

		"angular-momentum":
			name: "Angular momentum"
			keywords: ["angular", "angle", "momentum", "radians", "rotation",
				"distance", "perpendicular"]
			equation: -> new Eq("L", "dp*p")

		"torque":
			name: "Torque"
			keywords: ["torque", "angular", "force", "distance", "moment",
				"perpendicular"]
			equation: -> new Eq("τ", "dp*F")

		"angular-impulse":
			name: "Angular impulse"
			keywords: ["angular", "angle", "radians", "impulse", "momentum"]
			equation: -> new Eq("ΔL", "L2 - L1")
	}

	return {

		# Get an equation by name.
		#
		# @param name [String] The name of the equation to return.
		# @return [Equation] The equation of the given name.
		getEquation: (name) ->
			if name of formulae
				return formulae[name].equation()
			else
				throw new Error("No formula called " + name + " exists.")

		# Return an array of the names of all the formulae.
		#
		# @return [Array<String>] Names of all formulae.
		getAllFormulaNames: ->
			names = []
			for formula of formulae
				names.push(formula)

			return names

		# Return the proper name of an equation.
		#
		# @return [String] Proper name of an equation.
		getName: (name) ->
			if name of formulae
				return formulae[name].name
			else
				throw new Error("No formula called " + name + " exists.")

		# Return the keywords of an equation.
		#
		# @return [Array<String>] Array of keywords.
		getKeywords: (name) ->
			if name of formulae
				return formulae[name].keywords
			else
				throw new Error("No formula called " + name + " exists.")

	}