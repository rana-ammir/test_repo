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
			url: "/strategic_plan/plans/"+plan_id+"/divisions/"+division_id+"/areas/"+area_id+"/goals/"+goal_id+"/objectives/"+objective_id+"/strategies/"+strategy_id+"/tactics/"+tactic_id+"/edit"
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

	$(document).on 'click',".all-asset-tactic", (e) ->
		e.preventDefault()
		tactic_id = $(this).data("tacticId")
		$.ajax
			type: "GET"
			url: "/tactics/get_all_tactic_attachments"
			data: {tactic_id: tactic_id}

	$(document).on 'click',".user-assign-link", (e) ->
		e.preventDefault()
		tactic_id = $(this).data("tacticId")
		$(".tactic-hf").val(tactic_id)
		$.ajax
			type: "GET"
			url: "/tactics/get_tactic_users"
			data: {tactic_id: tactic_id}
			success: (data) ->
				$(document).ready ->
					$(".user-tactic-chkbox").bootstrapSwitch(
						size: "mini")

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
			success: (data) ->
				$(document).ready ->
					$(".user-tactic-chkbox").bootstrapSwitch(
						size: "mini")

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
	
	$(document).on 'click',".publish-tactic-link", (e) ->
		e.preventDefault()
		tactic_id = $(this).data("tacticId")
		$.ajax
			type: "POST"
			url: "/tasks/publish_tactic_task"
			data: {tactic_id: tactic_id}
			success: (data) ->
				$("html, body").animate({ scrollTop: "0px" })
				
	$(document).on 'shown.bs.modal',"#user-assign-modal-form", (e) ->
	  $(".user-tactic-chkbox").bootstrapSwitch(size: "mini")

	$(document).on 'switchChange.bootstrapSwitch',".user-tactic-chkbox", (event, state) ->  
	  owner_status = state
	  user_tactic_id = $(this).data("userTacticId")
	  tactic_id = $(this).data("tacticId")
	  $.ajax
	  	type: "PUT"
	  	url: "/tactics/update_tactic_user"
	  	data: {owner: owner_status, user_tactic_id: user_tactic_id, tactic_id: tactic_id}	
	  	success: (data) ->
	  		$(document).ready ->
	  			$(".user-tactic-chkbox").bootstrapSwitch(
	  				size: "mini")

	$(document).on 'hide.bs.modal',"#user-assign-modal-form", (e) ->
	  	if $(".user-tactic-chkbox").length > 0
		  	if $(".user-tactic-chkbox:checked").length == 0
		  		e.preventDefault()
		  		alert("Please make one owner.")
		  else
		  	$(this).hide()

	$(document).on 'submit',".user-tactic-form", (e) ->
		e.preventDefault()
		_this = $(this)
		$.ajax
			type: "POST"
			url: "/tactics/create_user_tactic"
			data: _this.serialize()
			success: ->
				$(document).ready ->
					$(".user-tactic-chkbox").bootstrapSwitch(size: "mini")