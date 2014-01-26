define ["jquery"], ($) ->

	# Alert the user with a tooltip at the given element.

	# To achieve this, I'm going to mess with jQuery UI tooltip a little bit.

	timeout = 2000

	return (element, value) ->
		$(element).tooltip(
			content: value
			items: "*"
			disabled: false
			hide:
				effect: "fade"
				duration: timeout/2
				delay: timeout
		).off("mouseover mouseout")

		$(element).tooltip("open")

		window.setTimeout (->
			$(element).tooltip("option", "hide", {effect: "fade", duration: timeout/2, delay:0})
			$(element).tooltip("close")
			$(element).tooltip("disable")), timeout