define ["jquery", "backend/formulae", "frontend/settings", "frontend/setSearchResultHandlers"], ($, formulae, settings, setSearchResultHandlers) ->

	return (condition) ->
		# Format: <li id="formula-kinetic-energy" class="search-result"></li>

		# Clear existing formulae.
		$("#search-results ul").empty()
		# Fill with new formulae.
		for formula in formulae.getAllFormulaNames()
			if (not condition?) or condition(formula)
				$("#search-results ul").append($('<li id="formula-' + formula + '" class="search-result">' + formulae.get(formula).toMathML(null, false, "0", true) + '</li>'))
		if settings.get("mathJaxEnabled")
			MathJax.Hub.Queue(["Typeset", MathJax.Hub])
			MathJax.Hub.Queue ->
				setSearchResultHandlers()
		else
			setSearchResultHandlers()