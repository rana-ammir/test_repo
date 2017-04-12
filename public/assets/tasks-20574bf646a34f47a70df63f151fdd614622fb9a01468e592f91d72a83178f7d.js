(function() {
  $(function() {
    var from_range, task_id;
    from_range = parseInt($('#progress-slider').data("progress"));
    task_id = $('#progress-slider').data("taskId");
    $('#progress-slider').ionRangeSlider({
      min: 0,
      max: 100,
      from: from_range,
      type: 'single',
      step: 5,
      postfix: '%',
      grid: true,
      onFinish: function(data) {
        return $.ajax({
          type: "PUT",
          url: "/tasks/" + task_id,
          data: {
            task: {
              progress: data.from,
              request: "slider"
            }
          }
        });
      }
    });
    $(document).on('ifChecked', ".complete-checkbox", function(e) {
      e.preventDefault();
      task_id = $(this).data("taskId");
      return $.ajax({
        type: "PUT",
        url: "/tasks/" + task_id,
        data: {
          task: {
            progress: 100.00,
            status: "Completed"
          },
          checked: "true"
        },
        success: function(data) {
          return $('#progress-slider').data('ionRangeSlider').update({
            from: 100
          });
        }
      });
    });
    $(document).on('ifUnchecked', ".completed-check", function(e) {
      e.preventDefault();
      task_id = $(this).data("taskId");
      return $.ajax({
        type: "PUT",
        url: "/tasks/" + task_id,
        data: {
          task: {
            status: "In-Progress",
            completion_date: "",
            progress: 99.99
          },
          checked: "false"
        },
        success: function(data) {
          return $('#progress-slider').data('ionRangeSlider').update({
            from: 99
          });
        }
      });
    });
    return $(document).on('click', ".asset-task-link", function(e) {
      e.preventDefault();
      console.log("okok");
      task_id = $(this).data("id");
      return $.ajax({
        type: "GET",
        url: "/tasks/new_task_attachment/" + task_id,
        data: {
          id: task_id
        }
      });
    });
  });

}).call(this);
