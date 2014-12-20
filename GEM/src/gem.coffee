###
Graphical Equation Manipulator

Matthew Alger, based on Buck Shlegeris' pyGEM.
https://github.com/MatthewJA/Graphical-Equation-Manipulator
https://github.com/bshlgrs/pyGEM

Licensed under GPL v3.
###

require.config
    baseUrl: "./src"
    paths:
        jquery: "vendor/jquery-2.1.1.min"
        coffeequate: "vendor/coffeequate.min"
        mathjax: "http://cdn.mathjax.org/mathjax/latest/" +
            "MathJax.js?config=MML_HTMLorMML.js"
        jqueryui: "vendor/jquery-ui.min"
    shim:
        jqueryui: ["jquery"]
        mathjax:
            exports: "MathJax"
            init: ->
                MathJax.Hub.Config
                    config: ["MMLorHTML.js"]
                    jax: ["input/MathML", "output/HTML-CSS"]
                    extensions: ["mml2jax.js","MathMenu.js","MathZoom.js"]
                    showMathMenu: false
                    showMathMenuMSIE: false
                MathJax.Hub.Startup.onload()
                return MathJax

require [
    "jquery"
    "Expression"
    "render"
    "jqueryui"
], ($, Expression, render, ui) ->

    # Trigger the flag that we've finished loading.
    window.gem.loaded = true # window.gem is defined in the preloader.

    # Setup the resize event handler so that the canvas resizes itself to the
    # whiteboard. We want to resize the canvas every time the window changes
    # size. We only fire the update function after we've stopped resizing for a
    # while so that the browser doesn't lag while resizing.
    canvas = $("#lines-canvas")[0]
    resizeTimer = null
    window.gem.updateCanvasSize = ->
        width = $("#whiteboard").width()
        height = $("#whiteboard").height()
        canvas.width = width
        canvas.height = height
        # Gotta redraw everything.
        require ["redrawCanvas"], (redrawCanvas) ->
            redrawCanvas()
    $(window).resize(->
        clearTimeout(resizeTimer)
        resizeTimer = setTimeout(window.gem.updateCanvasSize, 50))

    require ["addEquation", "addExpression", "formulae", "Line", "index"], (addEquation, addExpression, formulae, Line, index) ->
        addEquation(formulae.getEquation("angular-momentum"))
        addEquation(formulae.getEquation("momentum"))
        addEquation(formulae.getEquation("torque"))
        addEquation(formulae.getEquation("force"))