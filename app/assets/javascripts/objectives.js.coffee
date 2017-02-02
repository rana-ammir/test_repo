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
			success: (data) ->
				$(".user-objective-chkbox").bootstrapSwitch(
					size: "mini")

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

	$(document).on 'click',".delete-assigned-user", (e) ->
		e.preventDefault()
		objective_id = $(this).data("objectiveId")
		user_id = $(this).data("userId")
		$.ajax
			type: "GET"
			url: "/objectives/destroy_user_objective"
			data: {objective_id: objective_id, user_id: user_id}
			success: (data) ->
				$(".user-objective-chkbox").bootstrapSwitch(
					size: "mini")
				
	$(document).on 'click',".delete-assigned-team", (e) ->
		e.preventDefault()
		objective_id = $(this).data("objectiveId")
		team_id = $(this).data("teamId")
		$.ajax
			type: "GET"
			url: "/objectives/destroy_team_objective"
			data: {objective_id: objective_id, team_id: team_id}

	$(document).on 'click',".edit-objective-link", (e) ->
		e.preventDefault()
		objective_id = $(this).data("objectiveId")
		plan_id = $(this).data("planId")
		division_id = $(this).data("divisionId")
		department_id = $(this).data("departmentId")
		goal_id = $(this).data("goalId")
		area_id = $(this).data("areaId")
		$.ajax
			type: "GET"
			url: "/strategic_plan/plans/"+plan_id+"/divisions/"+division_id+"/departments/"+department_id+"/areas/"+area_id+"/goals/"+goal_id+"/objectives/"+objective_id+"/edit"
			data: {objective_id: objective_id, plan_id: plan_id, division_id: division_id, department_id: department_id, goal_id: goal_id, area_id: area_id}

	$(document).on 'click',".datepicker", (e) ->
		e.preventDefault()
		$(this).focus()
		$(this).datepicker()

	$(document).on 'click',".obj-status-modal", (e) ->
		e.preventDefault()
		objective_id = $(this).data("objectiveId")
		plan_id = $(this).data("planId")
		division_id = $(this).data("divisionId")
		department_id = $(this).data("departmentId")
		goal_id = $(this).data("goalId")
		area_id = $(this).data("areaId")
		$.ajax
			type: "GET"
			url: "/strategic_plan/plans/"+plan_id+"/divisions/"+division_id+"/departments/"+department_id+"/areas/"+area_id+"/goals/"+goal_id+"/objectives/"+objective_id+"/edit"
			data: {request: "edit_objective_status", objective_id: objective_id, plan_id: plan_id, division_id: division_id, department_id: department_id, goal_id: goal_id, area_id: area_id}

	$(document).on 'shown.bs.modal',"#user-assign-modal-form", (e) ->
	  $(".user-objective-chkbox").bootstrapSwitch(size: "mini")

	$(document).on 'switchChange.bootstrapSwitch',".user-objective-chkbox", (event, state) ->  
	  owner_status = state
	  user_objective_id = $(this).data("userObjectiveId")
	  $.ajax
	  	type: "PUT"
	  	url: "/objectives/update_objective_user"
	  	data: {owner: owner_status, user_objective_id: user_objective_id}	
	  	success: (data) ->
	  		$(".user-objective-chkbox").bootstrapSwitch(
	  			size: "mini")

	$(document).on 'hide.bs.modal',"#user-assign-modal-form", (e) ->
	  if $(".user-objective-chkbox:not(:checked)").length > 1
	  	e.preventDefault()
	  	alert("Please make atleast one owner.")
	  else
	  	$(this).hide()	
