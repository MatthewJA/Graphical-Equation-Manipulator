# Functions for rendering and rerendering content.
# Some of these are wrappers.

define ["mathjax"], (MathJax) ->

	# Rerender MathJax in the whiteboard.
	# @param callback [Function] Optional. A callback function.
	math = (callback) ->
		MathJax.Hub.Queue(["Typeset", MathJax.Hub])
		MathJax.Hub.Queue(callback)

	return {
		math: math
	}