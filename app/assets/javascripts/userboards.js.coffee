$ ->
	$('.footable').footable()
	
	$('.i-checks').iCheck
	  checkboxClass: 'icheckbox_square-green'
	  radioClass: 'iradio_square-green'

	$(document).on 'ifChanged',".userboard-active", (e) ->
		e.preventDefault()
		id = $(this).val()
		status = $(this).prop("checked")
		$.ajax
			type: "PUT"
			url: "/userboards/"+id
			data: {id: id, userboard: {status: status} }