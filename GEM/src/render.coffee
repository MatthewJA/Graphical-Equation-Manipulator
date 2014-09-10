# Functions for rendering and rerendering content.
# Some of these are wrappers.

define ["mathjax"], (MathJax) ->

	# Rerender MathJax in the whiteboard.
	math = -> MathJax.Hub.Queue([MathJax.Hub, "Typeset", "#whiteboard"])

	return {
		math: math
	}