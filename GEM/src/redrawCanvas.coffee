# Clear and redraw the canvas.

define ["index"], (index) ->

    return ->
        context = $("#lines-canvas")[0].getContext("2d")
        context.clearRect(0, 0, context.canvas.width, context.canvas.height)
        index.line.redrawAll(context)