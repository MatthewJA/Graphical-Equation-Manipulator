define ["frontend/settings", "jquery", "backend/equivalenciesIndex"], (settings, $, equivalenciesIndex) ->

	# Store and manage 

	connections = [] # {source, target, element} objects representing connections.

	distance = (x1, y1, x2, y2) ->
		return Math.sqrt(Math.pow(x2-x1, 2) + Math.pow(y2-y1, 2))

	generateLineCSS = (x1, y1, x2, y2) ->
		# Generate CSS for a line element.
		height = settings.get("connectionWidth")
		width = Math.floor(distance(x1, y1, x2, y2)) - settings.get("variablePadding") * 2

		# Rotate the box.
		angle = Math.atan2(y2-y1, x2-x1)

		# Translate the box.
		# (0, 0) -> (x1, y1)
		translateX = x1 + Math.cos(angle) * settings.get("variablePadding")
		translateY = y1 + Math.sin(angle) * settings.get("variablePadding")

		# Make the CSS.
		css =
			"-moz-transform": "rotate(#{angle}rad)"
			"-moz-transform-origin": "0 0"
			"-webkit-transform": "rotate(#{angle}rad)"
			"-webkit-transform-origin": "0 0"
			"-o-transform": "rotate(#{angle}rad)"
			"-o-transform-origin": "0 0"
			"-ms-transform": "rotate(#{angle}rad)"
			"-ms-transform-origin": "0 0"
			"transform": "rotate(#{angle}rad)" # In an ideal world...
			"transform-origin": "0 0"
			"position": "absolute"
			"top": "#{translateY}px"
			"left": "#{translateX}px"
			"height": "#{height}px"
			"width": "#{width}px"

		return css

	generateLine = (x1, y1, x2, y2) ->
		# Generate a line element between two points.
		div = $("<div />")
		div.attr("class", "line")

		css = generateLineCSS(x1, y1, x2, y2)
		div.css(css)
		return div

	repaint = (connection) ->
		# Repaint a connection.
		# connection: {source, target, element}
		unless connection.deleted?
			p1 = connection.source.offset()
			p2 = connection.target.offset()
			w1 = connection.source.width()
			w2 = connection.target.width()
			h1 = connection.source.height()
			h2 = connection.target.height()
			connection.element.css(generateLineCSS(p1.left+w1/2, p1.top+h1/2, p2.left+w2/2, p2.top+h2/2))

	return {
		repaintVariables: (element=null) ->
			# Repaint all the connections of the children variables of this equation.
			# element: An element to repaint the variables of. Optional - will repaint everything
			# if not set.

			if element?
				variables = ($(variable).attr("id") for variable in element.find(".variable"))
				for connection in connections
					if connection.source.attr("id") in variables or connection.target.attr("id") in variables
						repaint(connection)
			else
				for connection in connections
					repaint(connection)

		connect: (source, target) ->
			# Connect two elements with a connection.
			# source, target: The two elements to connect.
			# -> The jQuery element of that connection.

			p1 = source.offset()
			p2 = target.offset()
			w1 = source.width()
			w2 = target.width()
			h1 = source.height()
			h2 = target.height()
			element = generateLine(p1.left+w1/2, p1.top+h1/2, p2.left+w2/2, p2.top+h2/2)
			element.attr("id", "line-#{connections.length}")
			$("#connection-space").append(element)

			connection =
				source: source
				target: target
				element: element

			connections.push(connection)

			return element

		removeAllVariableConnections: (formula) ->
			# Hide all connection lines from the given formula.

			# Get all the variables.
			variables = formula.find(".variable").addBack(formula.attr("id"))
			for connection in connections
				for variable in variables
					variable = $(variable)
					if variable.is(connection.source) or variable.is(connection.target)
						connection.element.remove?()
						connection.deleted = true

		setEquivalency: (a, b) ->
			# Set a equivalent to b.
			# a, b: Variable IDs.

			# Add the equivalency.
			equivalency = equivalenciesIndex.add(a, b)

			# Draw lines between every equivalency of a and b.
			for c in equivalency
				cID = new RegExp("^variable-equation-\\d+-#{c}$")
				for d in equivalency
					dID = new RegExp("^variable-equation-\\d+-#{d}$")
					# Does a line exist already?
					exists = false
					for connection in connections
						sourceID = connection.source.attr("id")
						targetID = connection.target.attr("id")
						if (
							(sourceID.match(cID) and targetID.match(dID)) or
							(sourceID.match(dID) and targetID.match(cID))
						)
							exists = true
							break

					unless exists
						@connect($('[id^="variable-equation"][id$="-' + c + '"]'), $('[id^="variable-equation"][id$="-' + d + '"]'))

	}