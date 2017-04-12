(function() {
  $(function() {
    return $(document).on('change', ".department-select-field", function(e) {
      var area_id, division_id, plan_id;
      e.preventDefault();
      plan_id = $(".plan-hf-in-division-show").val();
      division_id = $(".division-hf-in-division-show").val();
      area_id = $(this).val();
      if (division_id.length === 0) {
        return $(".select-department-link").attr("href", "#");
      } else {
        return $(".select-department-link").attr("href", "/strategic_plan/plans/" + plan_id + "/divisions/" + division_id + "/areas/" + area_id);
      }
    });
  });

}).call(this);
