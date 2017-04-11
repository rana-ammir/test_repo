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

	$(".task-status").on 'change', (e) ->
		e.preventDefault()
		status = $(this).val() 
		$.ajax
			type: "GET"
			url: "/userboards/get_filtered_tasks"
			data: {status: status}
			success: (data) ->
				$('.footable').footable()
	
	$(document).on 'change',".assign-userboard", (e) ->
		e.preventDefault()
		userboard_id = $(this).val()
		task_id = $(this).data("taskId")
		$.ajax
			type: "POST"
			url: "/userboards/assign_userboard_to_task"
			data: {userboard_id: userboard_id, task_id: task_id}

	$(document).on 'click',".userboard-btn", (e) ->
		e.preventDefault()
		userboard_id = $(this).data('userboardId')
		$.ajax
			type: "GET"
			url: "/userboards/get_userboard_tasks"
			data: {userboard_id: userboard_id}		
			success: (data) ->
				$('.footable').footable()

	$(".footable-toggle").css({ "font-size": "9px" });
	$(".sort-remove span").remove();

	$('.clickable').click ->
	  span = $(this).find('span')
	  $(this).find('.footable-toggle').remove()
	  if span.hasClass('glyphicon-plus') == true
	    span.removeClass('glyphicon-plus').addClass 'glyphicon-minus'
	  else
	    span.removeClass('glyphicon-minus').addClass 'glyphicon-plus'
	  return