# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
	$(".division-select").on 'change', (e) ->
		e.preventDefault()
		$(".edit-department").remove()
		division_id = $(this).val() 
		$.ajax
			type: "GET"
			url: "/members/get_selected_division"
			data: {division_id: division_id}

	$('.i-checks').iCheck
	  checkboxClass: 'icheckbox_square-green'
	  radioClass: 'iradio_square-green'

	$(document).on 'ifChanged',".member-active", (e) ->
		e.preventDefault()
		id = $(this).val()
		active = $(this).prop("checked")
		$.ajax
			type: "PUT"
			url: "/members/"+id
			data: {id: id, user: {active: active}}