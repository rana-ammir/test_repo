$ ->
	$(document).on 'click',".edit-strategy-link", (e) ->
		e.preventDefault()
		strategy_id = $(this).data("strategyId")
		objective_id = $(this).data("objectiveId")
		plan_id = $(this).data("planId")
		division_id = $(this).data("divisionId")
		department_id = $(this).data("departmentId")
		goal_id = $(this).data("goalId")
		area_id = $(this).data("areaId")
		$.ajax
			type: "GET"
			url: "/strategic_plan/plans/"+plan_id+"/divisions/"+division_id+"/departments/"+department_id+"/areas/"+area_id+"/goals/"+goal_id+"/objectives/"+objective_id+"/strategies/"+strategy_id+"/edit"
			data: {strategy_id: strategy_id, objective_id: objective_id, plan_id: plan_id, division_id: division_id, department_id: department_id, goal_id: goal_id, area_id: area_id}

	$(document).on 'click',".datepicker", (e) ->
		e.preventDefault()
		$(this).focus()
		$(this).datepicker()

	$(document).on 'click',".asset-strategy-link", (e) ->
		e.preventDefault()
		strategy_id = $(this).data("strategyId")
		objective_id = $(this).data("objectiveId")
		plan_id = $(this).data("planId")
		division_id = $(this).data("divisionId")
		department_id = $(this).data("departmentId")
		goal_id = $(this).data("goalId")
		area_id = $(this).data("areaId")
		$.ajax
			type: "GET"
			url: "/strategies/new_strategy_attachment/"+strategy_id
			data: {strategy_id: strategy_id, objective_id: objective_id, plan_id: plan_id, division_id: division_id, department_id: department_id, goal_id: goal_id, area_id: area_id}

	$(document).on 'click',".user-assign-link", (e) ->
		e.preventDefault()
		strategy_id = $(this).data("strategyId")
		$(".strategy-hf").val(strategy_id)
		$.ajax
			type: "GET"
			url: "/strategies/get_strategy_users"
			data: {strategy_id: strategy_id}
			success: (data) ->
				$(document).ready ->
					$(".user-strategy-chkbox").bootstrapSwitch(
						size: "mini")

	$('#user-name-autocomplete').bind 'railsAutocomplete.select', (event, data) ->
		$('.user-hf').val(data.item.key)

	$(document).on 'click',".delete-assigned-user", (e) ->
		e.preventDefault()
		strategy_id = $(this).data("strategyId")
		user_id = $(this).data("userId")
		$.ajax
			type: "GET"
			url: "/strategies/destroy_user_strategy"
			data: {strategy_id: strategy_id, user_id: user_id}
			success: (data) ->
				$(document).ready ->
					$(".user-strategy-chkbox").bootstrapSwitch(
						size: "mini")

	$(document).on 'click',".team-assign-link", (e) ->
		e.preventDefault()
		strategy_id = $(this).data("strategyId")
		$(".strategy-hf").val(strategy_id)
		$.ajax
			type: "GET"
			url: "/strategies/get_strategy_teams"
			data: {strategy_id: strategy_id}

	$('#team-name-autocomplete').bind 'railsAutocomplete.select', (event, data) ->
		$('.team-hf').val(data.item.key)

	$(document).on 'click',".delete-assigned-team", (e) ->
		e.preventDefault()
		strategy_id = $(this).data("strategyId")
		team_id = $(this).data("teamId")
		$.ajax
			type: "GET"
			url: "/strategies/destroy_team_strategy"
			data: {strategy_id: strategy_id, team_id: team_id}

	$(document).on 'shown.bs.modal',"#user-assign-modal-form", (e) ->
	  $(".user-strategy-chkbox").bootstrapSwitch(size: "mini")

	$(document).on 'switchChange.bootstrapSwitch',".user-strategy-chkbox", (event, state) ->  
	  owner_status = state
	  user_strategy_id = $(this).data("userStrategyId")
	  strategy_id = $(this).data("strategyId")
	  $.ajax
	  	type: "PUT"
	  	url: "/strategies/update_strategy_user"
	  	data: {owner: owner_status, user_strategy_id: user_strategy_id, strategy_id: strategy_id}	
	  	success: (data) ->
	  		$(document).ready ->
	  			$(".user-strategy-chkbox").bootstrapSwitch(
	  				size: "mini")

	$(document).on 'hide.bs.modal',"#user-assign-modal-form", (e) ->
	  	if $(".user-strategy-chkbox").length > 0
		  	if $(".user-strategy-chkbox:checked").length == 0
		  		e.preventDefault()
		  		alert("Please make one owner.")
		  else
		  	$(this).hide()

	$(document).on 'submit',".user-strategy-form", (e) ->
		e.preventDefault()
		_this = $(this)
		$.ajax
			type: "POST"
			url: "/strategies/create_user_strategy"
			data: _this.serialize()
			success: ->
				$(document).ready ->
					$(".user-strategy-chkbox").bootstrapSwitch(
						size: "mini")

