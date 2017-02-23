$ ->
	$(document).on 'click',".task-filter", (e) ->
		e.preventDefault()
		status = $(this).data("status")
		active = $(this).prop("checked")
		$.ajax
			type: "GET"
			url: "/activities/get_filtered_tasks"
			data: {status: status}