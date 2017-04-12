(function() {
  $(function() {
    $(".division-select").on('change', function(e) {
      var division_id;
      e.preventDefault();
      $(".edit-department").remove();
      division_id = $(this).val();
      return $.ajax({
        type: "GET",
        url: "/members/get_selected_division",
        data: {
          division_id: division_id
        }
      });
    });
    $('.i-checks').iCheck({
      checkboxClass: 'icheckbox_square-green',
      radioClass: 'iradio_square-green'
    });
    return $(document).on('ifChanged', ".member-active", function(e) {
      var active, id;
      e.preventDefault();
      id = $(this).val();
      active = $(this).prop("checked");
      return $.ajax({
        type: "PUT",
        url: "/members/" + id,
        data: {
          id: id,
          user: {
            active: active
          }
        }
      });
    });
  });

}).call(this);
