(function() {
  $(function() {
    $('.i-checks').iCheck({
      checkboxClass: 'icheckbox_square-green',
      radioClass: 'iradio_square-green'
    });
    return $(document).on('ifChanged', ".team-active", function(e) {
      var active, id;
      e.preventDefault();
      id = $(this).val();
      active = $(this).prop("checked");
      return $.ajax({
        type: "PUT",
        url: "/teams/" + id,
        data: {
          id: id,
          team: {
            active: active
          }
        }
      });
    });
  });

}).call(this);
