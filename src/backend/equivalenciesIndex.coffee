define ->

	# Stores variables which are equivalent.

	# These equivalent variables are represented by strings - their IDs.
	# For example, the equivalencies might be [["Ek_0", "Ep_0"], ["m_1", "m_2", "M"]]
	equivalencies = []

	return {
		add: (a, b) ->
			# Add an equivalency.
			# a: A string representing a variable which is equivalent to b.
			# b: A string representing a variable which is equivalent to a.
			# -> An array of variables equivalent to a and b.

			# Are a or b already in the equivalency list?
			# If so, where?
			aStored = null
			bStored = null
			for equivalency, index in equivalencies
				if a in equivalency
					aStored = index
				if b in equivalency
					bStored = index

			if aStored? and bStored?
				# Merge the equivalencies.
				if aStored == bStored
					return equivalencies[aStored]

				newEquivalency = []
				for variable in equivalencies[aStored]
					unless variable in newEquivalency
						newEquivalency.push(variable)
				for variable in equivalencies[bStored]
					unless variable in newEquivalency
						newEquivalency.push(variable)

				if aStored > bStored
					equivalencies.splice(aStored, 1)
					equivalencies.splice(bStored, 1)
				else
					equivalencies.splice(bStored, 1)
					equivalencies.splice(aStored, 1)

				equivalencies.push(newEquivalency)
				return equivalencies[equivalencies.length-1]

			else if aStored?
				# Store b where a is stored.
				equivalencies[aStored].push(b)
				return equivalencies[aStored]

			else if bStored?
				# Store a where b is stored.
				equivalencies[bStored].push(a)
				return equivalencies[bStored]

			else
				# Add a new equivalency.
				equivalencies.push([a, b])
				return equivalencies[equivalencies.length-1]

		get: (variable) ->
			# Return all the equivalencies for a particular variable.
			# variable: The variable to find equivalencies for.
			# -> An array of equivalent variables.

			for equivalency in equivalencies
				if variable in equivalency
					return equivalency
			return []

		clear: ->
			# Clear the index.
			equivalencies.splice(0)
	}