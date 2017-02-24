$ ->
	initializeDraggableElement = ->
		$('#external-events div.external-event').each ->
		  $(this).data 'event',
		    title: $.trim($(this).text())
		    stick: true
		  $(this).draggable
		    zIndex: 1111999
		    revert: true
		    revertDuration: 0
	
	initializeIcheck = ->
		$('.i-checks').iCheck
		  checkboxClass: 'icheckbox_square-green'
		  radioClass: 'iradio_square-green'

	$(document).on 'click',".task-filter", (e) ->
		e.preventDefault()
		status = $(this).data("status")
		active = $(this).prop("checked")
		$.ajax
			type: "GET"
			url: "/activities/get_filtered_tasks"
			data: {status: status}
			success: (data) ->
				initializeDraggableElement()
				initializeIcheck()

	initializeDraggableElement()
	initializeIcheck()