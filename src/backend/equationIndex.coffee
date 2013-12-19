define ->

	# Stores the equations known to the program in a singleton array.
	# Each equation has an ID which refers to its position in the array.
	# ...Of course, it's a remarkably bad idea to splice this array. Don't do that.

	equations = []

	return {
		add: (equation) ->
			# Store an equation in the equations index.
			# equation: The JS-Algebra equation to store as an equation.
			# -> The ID of the newly-stored equation.

			equations.push(equation)
			return equations.length - 1

		get: (equationID) ->
			# Return the equation associated with the given ID.
			# equationID: The ID of the equation to return.
			# -> The equation with the given ID.

			if equationID >= equations.length or equationID < 0
				throw new Error("No equation with ID #{equationID} exists.")

			return equations[equationID]

		size: ->
			# Return the number of equations in the index.
			# -> The number of equations.

			return equations.length

		set: (equationID, equation) ->
			# Replace an equation with another.
			# equationID: The ID of the equation to replace.
			# equation: The new equation.

			if equationID >= equation.length or equationID < 0
				throw new Error("No equation with ID #{equationID} exists.")

			equations[equationID] = equation
			return equations[equationID]
	}