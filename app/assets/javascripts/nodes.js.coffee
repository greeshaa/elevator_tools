# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
	builds = $('#node_build_id').html()
	$('#node_street_id').change ->
		street  = $('#node_street_id :selected').text()
		options = $(builds).filter("optgroup[label='#{street}']").html()
		if options
			$('#node_build_id').html(options)
		else
			$('#node_build_id').empty()

	porches = $('#node_porch_id').html()
	$('#node_build_id').change ->
		build  = $('#node_build_id :selected').text()
		options = $(porches).filter("optgroup[label='#{build}']").html()
		if options
			$('#node_porch_id').html(options)
		else
			$('#node_porch_id').empty()