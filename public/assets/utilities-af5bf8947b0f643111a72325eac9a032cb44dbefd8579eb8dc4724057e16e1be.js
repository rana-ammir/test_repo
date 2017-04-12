(function() {
  $(function() {
    var getDropdownValues;
    getDropdownValues = function() {
      var class_name, id, link, plan_id;
      plan_id = $(".selected_plan").val();
      class_name = $(".selected_option_dropdown").data("className");
      id = $(".selected_option_dropdown").val();
      link = $(".generate_report_link");
      if (class_name !== void 0 && class_name.length !== 0 && id !== void 0 && id.length !== 0 && plan_id !== void 0 && plan_id.length !== 0) {
        return link.attr("href", "/utilities/generate_report_hours.pdf?plan_id=" + plan_id + "&class_name=" + class_name + "&id=" + id);
      } else {
        return link.attr("href", "#");
      }
    };
    $(".selected_plan").on('change', function(e) {
      e.preventDefault();
      return getDropdownValues();
    });
    $(".selected_member_filter").on('change', function(e) {
      var member_filter_id;
      e.preventDefault();
      member_filter_id = $(this).val();
      if (member_filter_id.length > 0) {
        return $.ajax({
          type: "GET",
          url: "/utilities/get_filtered_members",
          data: {
            member_filter_id: member_filter_id
          }
        });
      } else if (member_filter_id.length < 1) {
        return $(".report-for-dropdown").remove();
      }
    });
    return $(document).on('change', ".selected_option_dropdown", function(e) {
      e.preventDefault();
      return getDropdownValues();
    });
  });

}).call(this);
