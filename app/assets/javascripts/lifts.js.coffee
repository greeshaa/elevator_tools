# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
	builds = $('#lift_build').html()
	$('#lift_street').change ->
		street  = $('#lift_street :selected').text()
		options = $(builds).filter("optgroup[label='#{street}']").html()
		if options
			$('#lift_build').html(options)
		else
			$('#lift_build').empty()