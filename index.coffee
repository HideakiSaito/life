$ = require('jquery')
chroma = require('chroma-js')

scale = ["#F6CE59", "#BDCF5E", "#87CA74", "#56C08F", "#37B2A6", "#45A1B2", "#688CAF", "#85769E", "#956282", "#975162"]

$ ->
	$('.week').each (index, week) ->

		progress = index / 52 / 10
		decade = Math.floor(progress) + 1
		start_color = scale[decade - 1]
		end_color = scale[decade]
		progress = progress % 1
		color = chroma.interpolate(start_color, end_color, progress, 'lch').hex()

		$(week).css(backgroundColor: color)
		if index % 52 == 0
			year = Math.ceil(index / 52)
			$(week).text(year)

	$('#panic-btn').click (e) ->
		bday = new Date($("#bday")[0].value)
		currentTime = new Date();
		weeksCount = Math.ceil((currentTime - bday) / 1000 / 60 / 60 / 24 / 7)
		$('.week').slice(0, weeksCount).each (index, el) =>
			delayedPaniced = -> 
				el.classList.add("paniced")
			setTimeout(delayedPaniced, index)
			$('#monster').removeClass("disable")
		
	$('.week').click (e) ->
		$(e.currentTarget).toggleClass('clicked')
	$('.week').addClass('interactive')