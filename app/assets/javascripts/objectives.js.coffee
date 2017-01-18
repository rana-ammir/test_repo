$ ->
	$(document).on 'click',".asset-obj-link", (e) ->
		e.preventDefault()
		objective_id = $(this).data("objectiveId")
		plan_id = $(this).data("planId")
		division_id = $(this).data("divisionId")
		department_id = $(this).data("departmentId")
		goal_id = $(this).data("goalId")
		area_id = $(this).data("areaId")
		$.ajax
			type: "GET"
			url: "/objectives/new_objective_attachment/"+objective_id
			data: {objective_id: objective_id, plan_id: plan_id, division_id: division_id, department_id: department_id, goal_id: goal_id, area_id: area_id}

	$(document).on 'click',".user-assign-link", (e) ->
		e.preventDefault()
		objective_id = $(this).data("objectiveId")
		$(".objective-hf").val(objective_id)
		$.ajax
			type: "GET"
			url: "/objectives/get_objective_users"
			data: {objective_id: objective_id}


	$('#user-name-autocomplete').bind 'railsAutocomplete.select', (event, data) ->
		$('.user-hf').val(data.item.key)

	$(document).on 'click',".team-assign-link", (e) ->
		e.preventDefault()
		objective_id = $(this).data("objectiveId")
		$(".obj-hf").val(objective_id)
		$.ajax
			type: "GET"
			url: "/objectives/get_objective_teams"
			data: {objective_id: objective_id}


	$('#team-name-autocomplete').bind 'railsAutocomplete.select', (event, data) ->
		$('.team-hf').val(data.item.key)		