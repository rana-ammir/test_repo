# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
	getDropdownValues = ->
		plan_id = $(".selected_plan").val()
		class_name = $(".selected_option_dropdown").data("className")
		id = $(".selected_option_dropdown").val()
		link = $(".generate_report_link")
		if class_name != undefined && class_name.length != 0 && id != undefined && id.length != 0 && plan_id != undefined && plan_id.length != 0
			link.attr("href", "/utilities/generate_report_hours.pdf?plan_id="+plan_id+"&class_name="+class_name+"&id="+id)
		else
			link.attr("href", "#")
		
	$(".selected_plan").on 'change', (e) ->
		e.preventDefault()
		getDropdownValues()
	
	$(".selected_member_filter").on 'change', (e) ->
		e.preventDefault()
		member_filter_id = $(this).val()
		if member_filter_id.length > 0
			$.ajax
				type: "GET"
				url: "/utilities/get_filtered_members"
				data: {member_filter_id: member_filter_id}
		else if member_filter_id.length < 1
			$(".report-for-dropdown").remove()

	$(document).on 'change',".selected_option_dropdown", (e) ->
		e.preventDefault()
		getDropdownValues()