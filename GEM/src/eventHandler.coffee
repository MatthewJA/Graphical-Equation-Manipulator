# Setup event handlers for various elements.

define ["jquery", "redrawCanvas", "index"], ($, redrawCanvas, index) ->

    # Properties of draggable equations and expressions.
    draggableFormulaProperties =
        # Constrain movement within the whiteboard.
        containment: "#whiteboard"
        scroll: false

        # Ensure only non-variable parts can be dragged.
        cancel: ".variable"

        # Called upon starting dragging.
        start: (event, ui) ->

        # Called upon drag.
        drag: (event, ui) ->
            redrawCanvas()

        # Called upon stopping dragging.
        stop: (event, ui) ->
            $(@).css("left",
                "#{parseInt($(@).css("left"))/($("#main").width()/100)}%")
            $(@).css("top",
                "#{parseInt($(@).css("top"))/($("#main").height()/100)}%")

    # Properties of draggable variables.
    draggableVariableProperties =
        # Constrain movement within the whiteboard.
        containment: "#whiteboard"
        scroll: false

        # Revert position if we drop in the wrong spot.
        revert: true

        # Clone the variable so it is removed from its clipped area.
        helper: "clone"
        appendTo: "#whiteboard"

        # Called upon starting dragging.
        start: (event, ui) ->
            # Hide the original variable we are dragging.
            $(event.target).fadeTo(0, 0)
            # Remove the grabbed cursor --- the mouseup handler won't ever fire
            # because we eventually release far away from here.
            $(event.target).removeClass("grabbed")
            if $(event.target).parents(".equation").length != 0
                $(ui.helper).addClass("equationHelper variable")
            else
                $(ui.helper).addClass("expressionHelper variable")

            # We also want the cursor to return to normal once we're done
            # dragging. If we don't do this step, we get weird UI lag.
            $(ui.helper).mouseup(mouseupHandler)

        # Called upon drag.
        drag: (event, ui) ->

        # Called upon stopping dragging.
        stop: (event, ui) ->
            # Show the original variable we are dragging.
            $(event.target).fadeTo(0, 1)

    # Properties of droppable variables.
    droppableVariableProperties =
        drop: (event, ui) ->
            draggedLabel = ui.draggable.text()
            droppedLabel = $(@).text()

            draggedIsEquation = !!ui.draggable.parents(".equation").length
            droppedIsEquation = !!$(@).parents(".equation").length

            if droppedIsEquation and draggedIsEquation
                index.equivalency.add(ui.draggable, $(@))

    # Event handler for double-clicked variables.
    dblclickVariableHandler = (event) ->
        variable = $(event.target).closest(".variable")
        label = variable.text()
        equation = $(event.target).closest(".equation")
        isEquation = !!equation.length
        if isEquation
            equationId = equation.attr("id").split("equation-")[1]
            equation = index.equation.get(equationId)
            expressions = equation.solveFor(label)
            require ["addExpression"], (addExpression) ->
                for expression in expressions
                    console.log("adding expression", expression)
                    addExpression(expression)

    # Event handler for mousedown on draggable equations and expressions.
    mousedownHandler = (event) ->
        $(event.target).addClass("grabbed")

    mouseupHandler = (event) ->
        $(event.target).removeClass("grabbed")

    # Set event handlers on an equation and its components.
    #
    # @param element [$.Element] An element to set event handlers for.
    equation = (element) ->
        # Set draggable.
        element.draggable(draggableFormulaProperties)
        # Set position to absolute to handle positioning problems.
        element.css("position","absolute")
        # Set grabby handlers.
        element.mousedown(mousedownHandler)
               .mouseup(mouseupHandler)
        # Set variables to be draggable.
        element.find(".variable").draggable(draggableVariableProperties)
                                 .droppable(droppableVariableProperties)
                                 .dblclick(dblclickVariableHandler)

    # Set event handlers on an expression and its components.
    #
    # @param element [$.Element] An element to set event handlers for.
    expression = (element) ->
        # Set draggable.
        element.draggable(draggableFormulaProperties)
        # Set position to absolute to handle positioning problems.
        element.css("position","absolute")
        # Set grabby handlers.
        element.mousedown(mousedownHandler)
               .mouseup(mouseupHandler)
        # Set variables to be draggable.
        element.find(".variable").draggable(draggableVariableProperties)
                                 .droppable(droppableVariableProperties)
                                 .dblclick(dblclickVariableHandler)

    return {
        equation: equation
        expression: expression
    }