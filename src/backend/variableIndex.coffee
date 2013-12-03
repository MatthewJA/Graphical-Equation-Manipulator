define ->

	# An object dealing with variables and their labels.

	variables = {} # Variable ID -> Variable Label

	variableLabels = {} # Variable Label -> Number of variables with this label

	return {
		add: (variableID, name) ->
			# Add a variable ID to the index.
			# variableID: The ID of the variable to add.
			# name: The textual representation of the variable.
			
			variables[variableID] = name

		get: (variableID) ->
			# Retrieve the variable name associated with a particular variable ID.
			# variableID: The ID of the variable to fetch.

			return variables[variableID]

		getLabelCount: (label) ->
			# Count the number of variables with this label currently known to the program.
			# label: A label to get the count of.
			# -> The number of times this label has been used.

			count = variableLabels[label]
			if count?
				return count
			return 0

		incrementLabelCount: (label) ->
			# Increase the count for the given label by one.
			# label: A label to increase the count of.

			variableLabels[label] += 1

		getNextUniqueID: (label) ->
			# Convert a label into a unique ID.
			# label: The label of the variable to generate a unique ID for.
			# -> A unique ID.

			incrementLabelCount(label)
			return label + "_" + getLabelCount(label)
	}