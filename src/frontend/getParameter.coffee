define ->

	# Return the value of a get parameter.

	return (name) ->
		# name: The parameter to check.
		# -> The value of that parameter, or undefined if it does not exist.
		# http://stackoverflow.com/a/831060/1105803

		if (name = (new RegExp('[?&]'+encodeURIComponent(name)+'=([^&]*)')).exec(location.search))
			decodeURIComponent(name[1])