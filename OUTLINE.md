# Code Outline
This document describes in general how the code of GEM is structured, file by file.

Last updated as of [695f816e0b5f5e18dc60e3c9b67629f549fbd5ff](https://github.com/MatthewJA/Graphical-Equation-Manipulator/commit/695f816e0b5f5e18dc60e3c9b67629f549fbd5ff).

## /src/
### gem
This is the main file, which configures RequireJS and all other libraries. It also contains the main function, which is called to start the application. When the document has loaded<sup>$</sup>, libraries are loaded by this file and the frontend is setup by `frontend/setupFrontend`. This file then calls `frontend/finishLoading` to hide the preloader and show the application.

### preloader
Called as soon as possible, which is just before RequireJS starts loading things. Simulates the orbit of planets and also defines `window.getParameter`, which `gem` uses to check if MathJax is disabled before it attempts to load MathJax.

## /src/frontend/
### addEquation
A function which adds a Coffeequate equation to the application. This involves adding it to the `backend/equationIndex` and also putting it on the whiteboard (which this file also covers).

### addExpression
See `frontend/addEquation`, but for expressions.

### blank
An empty object. This object is loaded instead of MathJax if MathJax is disabled.

### connections
Contains everything to do with variable connections. Repaints the connections, connects two elements, and sets variables to be equivalent. Equivalencies are stored in `backend/equivalenciesIndex`.

### finishLoading
Hides the preloader and shows the application. Also sets `window.loadedGEM` to `true`.

### generateSearchResults
Puts search result elements into the search results box on the screen. This involves loading equations from `backend/formulae` and then putting them onto the screen.

### getParameter
A function which checks what value a get parameter holds.

### makeEquation
Wrapper for making a new equation in the CAS.

### rewrite
Replaces expressions with other expressions, equations with other equations, or variables with other variables.

### setEventHandlers
Probably the most involved section of the frontend. This file deals with making equations, expressions, and variables interactive. An element can be passed into here, or null, and event handlers will be set for that element's children, or for all elements, respectively.

### setSearchResultHandlers
Similar interface to `frontend/setEventHandlers`, but this time making search results able to be dragged or clicked onto the whiteboard.

### settings
An object holding the settings for the application. Retrieve settings with `get`, set them with `set`, and get an array of all setting names with `keys`.

### setupFrontend
Initialises the frontend. Sets window event handlers, as well as all event handlers for interactive elements currently on the screen. Generates any initial data that needs to be on the screen.

### setupSettings
Converts get parameters into settings.

### substituteEquation
Takes the ID of an equation and an expression, and a variable, and substitutes the equation into the expression, eliminating the variable. Calls `backend/substituteEquation` for the actual substitution - this just handles the frontend stuff.

## /src/backend/

### equationIndex
Stores all equations known to the application as an array. The ID of the equation is its position in that array. This returns an object which can `get`, `add`, and `set` equations in this index.

### equivalenciesIndex
Stores all equivalencies between variables. `get` and `add` are the only things that need to be dealt with here. `get`ting an equivalency will return an array of the variable and any other variables it is equivalent to.

### expressionIndex
See `backend/equationIndex`, but for expressions.

### formulae
Stores all physics equations known to the application. These equations can be copied by the `get` method. This is the only place where the CAS is directly used.

### solveEquation
Takes an equationID and a variable and solves that equation for that variable, returning an equation.

### substituteEquation
Substitutes an equation into an expression, eliminating a variable, and returns the result.

### variableIndex
Maps variable IDs to variable names. Used to give variables unique names in `frontend/addEquation`.
