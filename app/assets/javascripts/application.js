// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
//
//= require jquery/jquery-2.1.1.js
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require autocomplete-rails
//= require bootstrap-sprockets
//= require metisMenu/jquery.metisMenu.js
//= require pace/pace.min.js
//= require bootstrap-switch.js
//= require peity/jquery.peity.min.js
//= require slimscroll/jquery.slimscroll.min.js
//= require inspinia.js
//= require appviews.js
//= require tables.js
//= require cocoon
//= require datapicker/bootstrap-datepicker.js
//= require bootstrap-datepicker
//= require forms.js
//= require rails.validations

$('document').ready(function() {
  setTimeout((function() {
    $('.alert').slideUp();
  }), 5000);
});

$(document).ready(function() {
  $('.datepicker').datepicker({
  	todayHighlight: true,
  	format: 'mm/dd/yyyy',
  	autoclose: true
  });
});
