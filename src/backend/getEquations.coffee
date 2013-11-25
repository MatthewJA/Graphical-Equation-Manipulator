define ->

	# Stores the equations known to the program in a singleton array.
	# Each equation has an ID which refers to its position in the array.
	# ...Of course, it's a remarkably bad idea to splice this array. Don't do that.

	equations = []
	-> equations