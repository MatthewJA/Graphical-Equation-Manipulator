define ["jsPlumb", "frontend/settings", "jquery"], (jsPlumb, settings, $) ->

	return {

		repaintVariables: (element=null) ->
			# Repaint all the connections of the children variables of this equation.
			# element: An element to repaint the variables of. Optional - will repaint everything
			# if not set.

			if element?
				for variable in element.find(".variable")
					jsPlumb.repaint(variable)
			else
				jsPlumb.repaintEverything()

		connect: (source, target) ->
			# Connect two elements with jsPlumb.
			# source, target: The two elements to connect.
			jsPlumb.connect {
				source: source
				target: target
			}, settings.get("connectionSettings")

		setupJsPlumb: ->
			jsPlumb.ready ->
				jsPlumb.Defaults.Container = $("#connection-space")
				$(window).resize ->
					jsPlumb.repaintEverything()

		setVisibleBetween: (source, target, visibility) ->
			# Set the visibility of a connection between source and target.
			# source, target: The source and target of the connection.
			# visibility: Boolean. True for visible, false for invisible.
			if source?
				for connection in (jsPlumb.getConnections
					source: source
					target: target)
					connection.setVisible(visibility)
			else
				for connection in (jsPlumb.getConnections
					target: target)
					connection.setVisible(visibility)
	}