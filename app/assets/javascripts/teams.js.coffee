$ ->
	$('.i-checks').iCheck
	  checkboxClass: 'icheckbox_square-green'
	  radioClass: 'iradio_square-green'

	$(document).on 'ifChanged',".team-active", (e) ->
		e.preventDefault()
		id = $(this).val()
		active = $(this).prop("checked")
		$.ajax
			type: "PUT"
			url: "/teams/"+id
			data: {id: id, team: {active: active}}