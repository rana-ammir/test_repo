(function() {
  $(function() {
    $(".area-division").on('change', function(e) {
      var division_id;
      e.preventDefault();
      division_id = $(this).val();
      $(".area-division-id").val(division_id);
      if ($('.area-division').val().length === 0) {
        $(".new-area-form").hide();
        $(".area-list-table").hide();
      } else {
        $(".new-area-form").show();
        $(".area-list-table").show();
      }
      return $.ajax({
        type: "GET",
        url: "/areas/get_selected_division",
        data: {
          division_id: division_id
        }
      });
    });
    return $(".new-area-form").hide();
  });

}).call(this);
