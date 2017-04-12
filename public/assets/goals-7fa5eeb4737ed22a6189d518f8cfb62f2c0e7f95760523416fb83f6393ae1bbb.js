(function() {
  $(function() {
    $(".new-goal-area-field").hide();
    $(document).on('change', ".goal-division", function(e) {
      var division_id;
      e.preventDefault();
      division_id = $(this).val();
      if ($('.goal-division').val().length === 0) {
        $(".goal-area-select").hide();
        $(".new-goal-area-field").hide();
        $(".goals-table").hide();
      } else {
        $(".goal-area-select").show();
      }
      return $.ajax({
        type: "GET",
        url: "goals/get_selected_division",
        data: {
          division_id: division_id
        }
      });
    });
    $(document).on('change', ".goal-area-field", function(e) {
      var area_id;
      e.preventDefault();
      area_id = $(this).val();
      $(".area-division-id").val(area_id);
      if ($(".goal-area-field").val().length === 0) {
        $(".new-goal-area-field").hide();
        $(".goals-table").hide();
      } else {
        $(".new-goal-area-field").show();
        $(".goals-table").show();
      }
      return $.ajax({
        type: "GET",
        url: "goals/get_selected_area_goals",
        data: {
          area_id: area_id
        }
      });
    });
    $(document).on('click', ".asset-goal-link", function(e) {
      var goal_id;
      e.preventDefault();
      goal_id = $(this).data("goalId");
      return $.ajax({
        type: "GET",
        url: "/goals/new_goal_attachment/" + goal_id,
        data: {
          goal_id: goal_id
        }
      });
    });
    return $(document).on('change', ".goal-edit-division", function(e) {
      var division_id;
      e.preventDefault();
      division_id = $(this).val();
      return $.ajax({
        type: "GET",
        url: "/goals/get_selected_division",
        data: {
          division_id: division_id,
          request: "edit_goal"
        }
      });
    });
  });

}).call(this);
