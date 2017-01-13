# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
	$(document).on  'change',".plan-select-field", (e) ->
		e.preventDefault()
		plan_id = $(this).val()
		if plan_id.length == 0
			$(".select-plan-link").attr("href", "#")
		else
			$(".select-plan-link").attr("href", "/strategic_plan/plans/" + plan_id)

	$(document).on  'change',".division-select-field", (e) ->
		e.preventDefault()
		plan_id = $(".plan-hf-in-plan-show").val()
		division_id = $(this).val()
		if division_id.length == 0
			$(".select-division-link").attr("href", "#")
		else
			$(".select-division-link").attr("href", "/strategic_plan/plans/"+plan_id+"/divisions/" + division_id)		