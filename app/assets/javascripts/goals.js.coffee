# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
	$(".new-goal-area-field").hide()
	
	$(document).on  'change',".goal-division", (e) ->
		e.preventDefault()
		division_id = $(this).val()
		if $('.goal-division').val().length == 0
			$(".goal-area-select").hide()
			$(".new-goal-area-field").hide()
			$(".goals-table").hide()
		else
			$(".goal-area-select").show()
		$.ajax
			type: "GET"
			url: "goals/get_selected_division"
			data: {division_id: division_id}

	$(document).on  'change',".goal-area-field", (e) ->
		e.preventDefault()
		area_id = $(this).val()
		$(".area-division-id").val(area_id)
		if $(".goal-area-field").val().length == 0
			$(".new-goal-area-field").hide()
			$(".goals-table").hide()
		else
			$(".new-goal-area-field").show()
			$(".goals-table").show()
		$.ajax
			type: "GET"
			url: "goals/get_selected_area_goals"
			data: {area_id: area_id}

	$(document).on 'click',".asset-goal-link", (e) ->
		e.preventDefault()
		goal_id = $(this).data("goalId")
		$.ajax
			type: "GET"
			url: "/goals/new_goal_attachment/"+goal_id
			data: {goal_id: goal_id}

	$(document).on  'change',".goal-edit-division", (e) ->
		e.preventDefault()
		division_id = $(this).val()
		$.ajax
			type: "GET"
			url: "/goals/get_selected_division"
			data: {division_id: division_id, request: "edit_goal" }