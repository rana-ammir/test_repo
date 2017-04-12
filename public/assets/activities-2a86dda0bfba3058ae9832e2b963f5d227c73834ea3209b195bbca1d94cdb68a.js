(function() {
  $(function() {
    var initializeDraggableElement, initializeIcheck;
    initializeDraggableElement = function() {
      return $('#external-events div.external-event').each(function() {
        $(this).data('event', {
          title: $.trim($(this).text()),
          stick: true
        });
        return $(this).draggable({
          zIndex: 1111999,
          revert: true,
          revertDuration: 0
        });
      });
    };
    initializeIcheck = function() {
      return $('.i-checks').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green'
      });
    };
    $(document).on('click', ".task-filter", function(e) {
      var active, status;
      e.preventDefault();
      status = $(this).data("status");
      active = $(this).prop("checked");
      return $.ajax({
        type: "GET",
        url: "/activities/get_filtered_tasks",
        data: {
          status: status
        },
        success: function(data) {
          initializeDraggableElement();
          return initializeIcheck();
        }
      });
    });
    $(document).on('click', ".userboard-btn", function(e) {
      var userboard_id;
      e.preventDefault();
      userboard_id = $(this).data('userboardId');
      return $.ajax({
        type: "GET",
        url: "/activities/get_userboard_tasks",
        data: {
          userboard_id: userboard_id
        },
        success: function(data) {
          initializeDraggableElement();
          return initializeIcheck();
        }
      });
    });
    initializeDraggableElement();
    return initializeIcheck();
  });

}).call(this);
