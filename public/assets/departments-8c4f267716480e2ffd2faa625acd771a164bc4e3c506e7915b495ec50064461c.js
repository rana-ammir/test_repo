(function() {
  $(function() {
    return $(document).on('change', ".area-select-field", function(e) {
      var area_id, department_id, division_id, plan_id;
      e.preventDefault();
      plan_id = $(".plan-hf-in-department-show").val();
      division_id = $(".division-hf-in-department-show").val();
      department_id = $(".department-hf-in-department-show").val();
      area_id = $(this).val();
      if (area_id.length === 0) {
        return $(".select-area-link").attr("href", "#");
      } else {
        return $(".select-area-link").attr("href", "/strategic_plan/plans/" + plan_id + "/divisions/" + division_id + "/departments/" + department_id + "/areas/" + area_id);
      }
    });
  });

}).call(this);
