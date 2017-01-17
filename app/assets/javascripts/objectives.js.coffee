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