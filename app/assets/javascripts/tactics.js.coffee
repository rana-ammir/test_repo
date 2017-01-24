$ ->
	$(document).on 'click',".edit-tactic-link", (e) ->
		e.preventDefault()
		tactic_id = $(this).data("tacticId")
		strategy_id = $(this).data("strategyId")
		objective_id = $(this).data("objectiveId")
		plan_id = $(this).data("planId")
		division_id = $(this).data("divisionId")
		department_id = $(this).data("departmentId")
		goal_id = $(this).data("goalId")
		area_id = $(this).data("areaId")
		$.ajax
			type: "GET"
			url: "/strategic_plan/plans/"+plan_id+"/divisions/"+division_id+"/departments/"+department_id+"/areas/"+area_id+"/goals/"+goal_id+"/objectives/"+objective_id+"/strategies/"+strategy_id+"/tactics/"+tactic_id+"/edit"
			data: {tactic_id: tactic_id, strategy_id: strategy_id, objective_id: objective_id, plan_id: plan_id, division_id: division_id, department_id: department_id, goal_id: goal_id, area_id: area_id}

	$(document).on 'click',".datepicker", (e) ->
		e.preventDefault()
		$(this).focus()
		$(this).datepicker()

	$(document).on 'click',".asset-tactic-link", (e) ->
		e.preventDefault()
		tactic_id = $(this).data("tacticId")
		strategy_id = $(this).data("strategyId")
		objective_id = $(this).data("objectiveId")
		plan_id = $(this).data("planId")
		division_id = $(this).data("divisionId")
		department_id = $(this).data("departmentId")
		goal_id = $(this).data("goalId")
		area_id = $(this).data("areaId")
		$.ajax
			type: "GET"
			url: "/tactics/new_tactic_attachment/"+tactic_id
			data: {tactic_id: tactic_id, strategy_id: strategy_id, objective_id: objective_id, plan_id: plan_id, division_id: division_id, department_id: department_id, goal_id: goal_id, area_id: area_id}

	$(document).on 'click',".user-assign-link", (e) ->
		e.preventDefault()
		tactic_id = $(this).data("tacticId")
		$(".tactic-hf").val(tactic_id)
		$.ajax
			type: "GET"
			url: "/tactics/get_tactic_users"
			data: {tactic_id: tactic_id}

	$('#user-name-autocomplete').bind 'railsAutocomplete.select', (event, data) ->
		$('.user-hf').val(data.item.key)

	$(document).on 'click',".delete-assigned-user", (e) ->
		e.preventDefault()
		tactic_id = $(this).data("tacticId")
		user_id = $(this).data("userId")
		$.ajax
			type: "GET"
			url: "/tactics/destroy_user_tactic"
			data: {tactic_id: tactic_id, user_id: user_id}

	$(document).on 'click',".team-assign-link", (e) ->
		e.preventDefault()
		tactic_id = $(this).data("tacticId")
		$(".tactic-hf").val(tactic_id)
		$.ajax
			type: "GET"
			url: "/tactics/get_tactic_teams"
			data: {tactic_id: tactic_id}

	$('#team-name-autocomplete').bind 'railsAutocomplete.select', (event, data) ->
		$('.team-hf').val(data.item.key)

	$(document).on 'click',".delete-assigned-team", (e) ->
		e.preventDefault()
		tactic_id = $(this).data("tacticId")
		team_id = $(this).data("teamId")
		$.ajax
			type: "GET"
			url: "/tactics/destroy_team_tactic"
			data: {tactic_id: tactic_id, team_id: team_id}
