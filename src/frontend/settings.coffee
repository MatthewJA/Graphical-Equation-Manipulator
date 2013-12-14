define ->
	
	# A singleton object storing frontend settings, usually boolean.

	settings =
		mathJaxEnabled: true
		connectionWidth: 1
		loadForever: false

	return {
		get: (name) ->
			# Get the value of a setting.
			# name: The setting to get the value of.
			# -> The value of the setting, or undefined if no such setting exists.

			return settings[name]

		set: (name, value) ->
			# Set the value of a setting.
			# name: The setting to set the value of.

			settings[name] = value

		keys: ->
			# Return an array of possible settings.
			# -> An array of possible settings.

			keys = []
			for key of settings
				keys.push(key)

			return keys
	}