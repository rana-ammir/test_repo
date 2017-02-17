$ ->
	from_range = parseInt($('#progress-slider').data("progress"))
	task_id = $('#progress-slider').data("taskId")
	$('#progress-slider').ionRangeSlider
	  min: 0
	  max: 100
	  from: from_range
	  type: 'single'
	  step: 5
	  postfix: '%'
	  grid: true
	  onFinish: (data) ->
	  	$.ajax
	  		type: "PUT"
	  		url: "/tasks/"+task_id
	  		data: {task: {progress: data.from, request: "slider"} }
	  		
	$(document).on 'ifChecked',".complete-checkbox", (e) ->
	  e.preventDefault()
	  task_id = $(this).data("taskId")
	  $.ajax
  		type: "PUT"
  		url: "/tasks/"+task_id
  		data: {task: {progress: 100.00, status: "Completed"}, checked: "true" }
  		success: (data) ->
  			$('#progress-slider').data('ionRangeSlider').update from: 100

	$(document).on 'ifUnchecked',".completed-check", (e) ->
	  e.preventDefault()
	  task_id = $(this).data("taskId")
	  $.ajax
  		type: "PUT"
  		url: "/tasks/"+task_id
  		data: {task: {status: "In-Progress", completion_date: "", progress: 99.99}, checked: "false" }
  		success: (data) ->
  			$('#progress-slider').data('ionRangeSlider').update from: 99

	$(document).on 'click',".asset-task-link", (e) ->
	  e.preventDefault()
	  console.log("okok")
	  task_id = $(this).data("id")
	  $.ajax
  		type: "GET"
  		url: "/tasks/new_task_attachment/"+task_id
  		data: {id: task_id}