(function() {
  $(function() {
    $('.footable').footable();
    $('.i-checks').iCheck({
      checkboxClass: 'icheckbox_square-green',
      radioClass: 'iradio_square-green'
    });
    $(document).on('ifChanged', ".userboard-active", function(e) {
      var id, status;
      e.preventDefault();
      id = $(this).val();
      status = $(this).prop("checked");
      return $.ajax({
        type: "PUT",
        url: "/userboards/" + id,
        data: {
          id: id,
          userboard: {
            status: status
          }
        }
      });
    });
    $(".task-status").on('change', function(e) {
      var status;
      e.preventDefault();
      status = $(this).val();
      return $.ajax({
        type: "GET",
        url: "/userboards/get_filtered_tasks",
        data: {
          status: status
        },
        success: function(data) {
          return $('.footable').footable();
        }
      });
    });
    $(document).on('change', ".assign-userboard", function(e) {
      var task_id, userboard_id;
      e.preventDefault();
      userboard_id = $(this).val();
      task_id = $(this).data("taskId");
      return $.ajax({
        type: "POST",
        url: "/userboards/assign_userboard_to_task",
        data: {
          userboard_id: userboard_id,
          task_id: task_id
        }
      });
    });
    $(document).on('click', ".userboard-btn", function(e) {
      var userboard_id;
      e.preventDefault();
      userboard_id = $(this).data('userboardId');
      return $.ajax({
        type: "GET",
        url: "/userboards/get_userboard_tasks",
        data: {
          userboard_id: userboard_id
        },
        success: function(data) {
          return $('.footable').footable();
        }
      });
    });
    $(".footable-toggle").css({
      "font-size": "9px"
    });
    $(".sort-remove span").remove();
    return $('.clickable').click(function() {
      var span;
      span = $(this).find('span');
      $(this).find('.footable-toggle').remove();
      if (span.hasClass('glyphicon-plus') === true) {
        span.removeClass('glyphicon-plus').addClass('glyphicon-minus');
      } else {
        span.removeClass('glyphicon-minus').addClass('glyphicon-plus');
      }
    });
  });

}).call(this);
