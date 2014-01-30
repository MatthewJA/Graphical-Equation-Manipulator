define ["jquery", "backend/formulae", "frontend/settings"], ($, formulae, settings) ->

	return ->
		# <li id="formula-kinetic-energy" class="search-result">
		# 	<math>
		# 		<msub><mi>E</mi><mi>k</mi></msub>
		# 		<mo>=</mo>
		# 		<mfrac>
		# 			<mrow><mn>1</mn></mrow>
		# 			<mrow><mn>2</mn></mrow>
		# 		</mfrac>
		# 		<mo>&middot;</mo>
		# 		<mi>m</mi>
		# 		<mo>&middot;</mo>
		# 		<msup>
		# 			<mi>v</mi>
		# 			<mn>2</mn>
		# 		</msup>
		# 	</math>
		# </li>
		for formula in formulae.getAllFormulaNames()
			$("#search-results ul").append($('<li id="formula-' + formula + '" class="search-result">' + formulae.get(formula).toMathML(null, false, "0", true) + '</li>'))
		if settings.get("mathJaxEnabled")
			MathJax.Hub.Queue(["Typeset", MathJax.Hub])