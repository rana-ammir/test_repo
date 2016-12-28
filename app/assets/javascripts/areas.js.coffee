$ ->
	$(".area-division").on 'change', (e) ->
		e.preventDefault()
		division_id = $(this).val()
		$(".area-division-id").val(division_id)
		if $('.area-division').val().length == 0
			$(".new-area-form").hide()
			$(".area-list-table").hide()
		else
			$(".new-area-form").show()
			$(".area-list-table").show()
		$.ajax
			type: "GET"
			url: "/areas/get_selected_division"
			data: {division_id: division_id}

	$(".new-area-form").hide()
	