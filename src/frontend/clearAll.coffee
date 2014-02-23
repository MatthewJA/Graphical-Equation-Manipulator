define ["backend/clearAll", "jquery"], (clearAll, $) ->
	->
		$(".expression").add(".line").add("#whiteboard-panel .equation").remove()
		clearAll()