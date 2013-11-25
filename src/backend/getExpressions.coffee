define ->

	# Stores the expressions known to the program in a singleton array.
	# Each expression has an ID which refers to its position in the array.
	# ...Of course, it's a remarkably bad idea to splice this array. Don't do that.

	expressions = []
	-> expressions