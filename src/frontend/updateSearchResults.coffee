define ["jquery", "backend/formulae", "frontend/settings", "frontend/setSearchResultHandlers"], ($, formulae, settings, setSearchResultHandlers) ->

	return (condition) ->
		# Format: <li id="formula-kinetic-energy" class="search-result"></li>

		# Clear existing formulae.
		$("#search-results ul").empty()
		# Fill with new formulae.
		for formula in formulae.getAllFormulaNames()
			if (not condition?) or condition(formulae.getKeywords(formula))
				ele = $('<li id="formula-' + formula + '" class="search-result" title="' + formulae.getName(formula) + '">' + formulae.getEquation(formula).toMathML(null, false, "0", true) + '</li>')
				$("#search-results ul").append(ele)
				ele.tooltip()
				ele.tooltip("option", "hide", {effect: "fade", duration: 50, delay:0})
		if settings.get("mathJaxEnabled")
			MathJax.Hub.Queue(["Typeset", MathJax.Hub])
			MathJax.Hub.Queue ->
				setSearchResultHandlers()
		else
			setSearchResultHandlers()