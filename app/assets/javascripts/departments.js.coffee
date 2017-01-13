# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
	$(document).on  'change',".area-select-field", (e) ->
		e.preventDefault()
		plan_id = $(".plan-hf-in-department-show").val()
		division_id = $(".division-hf-in-department-show").val()
		department_id = $(".department-hf-in-department-show").val()
		area_id = $(this).val()
		if area_id.length == 0
			$(".select-area-link").attr("href", "#")
		else
			$(".select-area-link").attr("href", "/strategic_plan/plans/"+plan_id+"/divisions/"+division_id+"/departments/"+department_id+"/areas/"+area_id)