# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
	$('#datatables').dataTable();

	builds = $('#lift_build').html()
	$('#lift_street').change ->
		street  = $('#lift_street :selected').text()
		options = $(builds).filter("optgroup[label='#{street}']").html()
		if options
			$('#lift_build').html(options)
		else
			$('#lift_build').empty()

	porches = $('#lift_porch_id').html()
	$('#lift_build').change ->
		build  = $('#lift_build :selected').text()
		options = $(porches).filter("optgroup[label='#{build}']").html()
		if options
			$('#lift_porch_id').html(options)
		else
			$('#lift_porch_id').empty()