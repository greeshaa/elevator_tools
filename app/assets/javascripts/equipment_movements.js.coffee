# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
	builds = $('#equipment_movement_build_id').html()
	$('#equipment_movement_street_id').change ->
		street  = $('#equipment_movement_street_id :selected').text()
		options = $(builds).filter("optgroup[label='#{street}']").html()
		if options
			$('#equipment_movement_build_id').html(options)
		else
			$('#equipment_movement_build_id').empty()

	porches = $('#equipment_movement_porch_id').html()
	$('#equipment_movement_build_id').change ->
		build  = $('#equipment_movement_build_id :selected').text()
		options = $(porches).filter("optgroup[label='#{build}']").html()
		if options
			$('#equipment_movement_porch_id').html(options)
		else
			$('#equipment_movement_porch_id').empty()