JS-Algebra
==========

Computer algebra system for JavaScript. Represent, rearrange and solve equations.

Currently can solve equations involving multiplication, division, and powers, such as:

```
E = m * c**2
Ek = 1/2 * m * v**2
```

These equations can have values substituted into them.

```coffeescript
equation.toString() # E = m * c**2
equation.sub({c: 2}) # E = 4 * m
```

Also outputs as HTML for [MatthewJA]/**[Graphical-Equation-Manipulator]**.

Coming soon:
- Addition and subtraction
- Better interface
- Parsing equations and expressions
- Outputting LaTeX code
- Outputting Mathematica code

[MatthewJA]: http://github.com/MatthewJA
[Graphical-Equation-Manipulator]: http://github.com/MatthewJA/Graphical-Equation-Manipulator
