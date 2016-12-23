#= require active_admin/base
#= require jquery
#= require jquery-ui
#= require autocomplete-rails
$ ->
	$('#user_organization_name').bind 'railsAutocomplete.select', (event, data) ->
    $('#organization_id').val(data.item.key)
    $('#user_division_id').data(organization_id: data.item.key)

  $('.division-select').on 'change', (e) ->
  	division_id = $(this).val()
  	$.ajax
  		type: 'GET'
  		url: '/members/get_selected_division'
  		data: {division_id: division_id, request_type: "admin"}
		