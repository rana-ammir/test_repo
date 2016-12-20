#= require active_admin/base
#= require jquery
#= require jquery-ui
#= require autocomplete-rails
$ ->
	$('#user_organization_id').bind 'railsAutocomplete.select', (event, data) ->
    console.log(data.item.key)
    $('#organization_id').val(data.item.key)
  