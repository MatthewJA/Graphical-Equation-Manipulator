require.config
	baseUrl: "../src"
	urlArgs: "cb=" + Math.random() # Cache breaker
	paths:
		"spec": "../tests/spec"
		"jquery": "../tests/jquery.min"
		"JSAlgebra": "../src"
	shim:
		"jquery":
			exports: ["jquery"]

require ["jquery"], ($) ->
	jasmineEnv = jasmine.getEnv()
	htmlReporter = new jasmine.HtmlReporter()
	jasmineEnv.addReporter(htmlReporter)

	specs = [
		"spec/failure"
		"spec/simpleEquations"
	]

	jasmineEnv.specFilter = (spec) ->
		htmlReporter.specFilter(spec)

	$ ->
		require specs, ->
			jasmineEnv.execute()