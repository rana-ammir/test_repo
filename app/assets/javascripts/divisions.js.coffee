# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
	$(document).on  'change',".department-select-field", (e) ->
		e.preventDefault()
		plan_id = $(".plan-hf-in-division-show").val()
		division_id = $(".division-hf-in-division-show").val()
		area_id = $(this).val()
		if division_id.length == 0
			$(".select-department-link").attr("href", "#")
		else
			$(".select-department-link").attr("href", "/strategic_plan/plans/"+plan_id+"/divisions/"+division_id+"/areas/"+area_id)		