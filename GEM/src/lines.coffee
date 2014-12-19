# Describes lines and functions to handle them.

define [], ->

    class Line
        constructor: (@a, @b) ->
            # Defines a line from a to b.
            # a: $(Element)
            # b: $(Element)

        startPosition: ->
            # Get the first [x, y] value.
            offset = @a.offset()
            width = @a.width()
            height = @a.height()
            return [offset.left - width/2, offset.top - height/2]

        endPosition: ->
            # Get the last [x, y] value.
            offset = @b.offset()
            width = @b.width()
            height = @b.height()
            return [offset.left - width/2, offset.top - height/2]

        draw: (context) ->
            # Draw this line onto a canvas.
            # context: The canvas context.

            if context.setLineDash?
                context.setLineDash([5])
            else
                # Set deprecated dash styles if setLineDash isn't defined.
                context.mozDash([5])
                context.webkitLineDash = [5]
            context.strokeStyle = "#AAAAAA"

            context.beginPath()
            console.log(@startPosition()...)
            context.moveTo(@startPosition()...)
            context.lineTo(@endPosition()...)
            context.stroke()

    return Line