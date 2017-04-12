(function() {
  $(function() {
    $(document).on('change', ".plan-select-field", function(e) {
      var plan_id;
      e.preventDefault();
      plan_id = $(this).val();
      if (plan_id.length === 0) {
        return $(".select-plan-link").attr("href", "#");
      } else {
        return $(".select-plan-link").attr("href", "/strategic_plan/plans/" + plan_id);
      }
    });
    return $(document).on('change', ".division-select-field", function(e) {
      var division_id, plan_id;
      e.preventDefault();
      plan_id = $(".plan-hf-in-plan-show").val();
      division_id = $(this).val();
      if (division_id.length === 0) {
        return $(".select-division-link").attr("href", "#");
      } else {
        return $(".select-division-link").attr("href", "/strategic_plan/plans/" + plan_id + "/divisions/" + division_id);
      }
    });
  });

}).call(this);
