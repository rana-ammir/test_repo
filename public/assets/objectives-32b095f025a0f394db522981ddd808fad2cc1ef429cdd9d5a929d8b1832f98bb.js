(function() {
  $(function() {
    $(document).on('click', ".asset-obj-link", function(e) {
      var area_id, department_id, division_id, goal_id, objective_id, plan_id;
      e.preventDefault();
      objective_id = $(this).data("objectiveId");
      plan_id = $(this).data("planId");
      division_id = $(this).data("divisionId");
      department_id = $(this).data("departmentId");
      goal_id = $(this).data("goalId");
      area_id = $(this).data("areaId");
      return $.ajax({
        type: "GET",
        url: "/objectives/new_objective_attachment/" + objective_id,
        data: {
          objective_id: objective_id,
          plan_id: plan_id,
          division_id: division_id,
          department_id: department_id,
          goal_id: goal_id,
          area_id: area_id
        }
      });
    });
    $(document).on('click', ".user-assign-link", function(e) {
      var objective_id;
      e.preventDefault();
      objective_id = $(this).data("objectiveId");
      $(".objective-hf").val(objective_id);
      return $.ajax({
        type: "GET",
        url: "/objectives/get_objective_users",
        data: {
          objective_id: objective_id
        },
        success: function(data) {
          return $(document).ready(function() {
            return $(".user-objective-chkbox").bootstrapSwitch({
              size: "mini"
            });
          });
        }
      });
    });
    $('#user-name-autocomplete').bind('railsAutocomplete.select', function(event, data) {
      return $('.user-hf').val(data.item.key);
    });
    $(document).on('click', ".team-assign-link", function(e) {
      var objective_id;
      e.preventDefault();
      objective_id = $(this).data("objectiveId");
      $(".obj-hf").val(objective_id);
      return $.ajax({
        type: "GET",
        url: "/objectives/get_objective_teams",
        data: {
          objective_id: objective_id
        }
      });
    });
    $('#team-name-autocomplete').bind('railsAutocomplete.select', function(event, data) {
      return $('.team-hf').val(data.item.key);
    });
    $(document).on('click', ".delete-assigned-user", function(e) {
      var objective_id, user_id;
      e.preventDefault();
      objective_id = $(this).data("objectiveId");
      user_id = $(this).data("userId");
      return $.ajax({
        type: "GET",
        url: "/objectives/destroy_user_objective",
        data: {
          objective_id: objective_id,
          user_id: user_id
        },
        success: function(data) {
          return $(document).ready(function() {
            return $(".user-objective-chkbox").bootstrapSwitch({
              size: "mini"
            });
          });
        }
      });
    });
    $(document).on('click', ".delete-assigned-team", function(e) {
      var objective_id, team_id;
      e.preventDefault();
      objective_id = $(this).data("objectiveId");
      team_id = $(this).data("teamId");
      return $.ajax({
        type: "GET",
        url: "/objectives/destroy_team_objective",
        data: {
          objective_id: objective_id,
          team_id: team_id
        }
      });
    });
    $(document).on('click', ".edit-objective-link", function(e) {
      var area_id, department_id, division_id, goal_id, objective_id, plan_id;
      e.preventDefault();
      objective_id = $(this).data("objectiveId");
      plan_id = $(this).data("planId");
      division_id = $(this).data("divisionId");
      department_id = $(this).data("departmentId");
      goal_id = $(this).data("goalId");
      area_id = $(this).data("areaId");
      return $.ajax({
        type: "GET",
        url: "/strategic_plan/plans/" + plan_id + "/divisions/" + division_id + "/areas/" + area_id + "/goals/" + goal_id + "/objectives/" + objective_id + "/edit",
        data: {
          objective_id: objective_id,
          plan_id: plan_id,
          division_id: division_id,
          department_id: department_id,
          goal_id: goal_id,
          area_id: area_id
        }
      });
    });
    $(document).on('click', ".datepicker", function(e) {
      e.preventDefault();
      $(this).focus();
      return $(this).datepicker();
    });
    $(document).on('click', ".obj-status-modal", function(e) {
      var area_id, department_id, division_id, goal_id, objective_id, plan_id;
      e.preventDefault();
      objective_id = $(this).data("objectiveId");
      plan_id = $(this).data("planId");
      division_id = $(this).data("divisionId");
      department_id = $(this).data("departmentId");
      goal_id = $(this).data("goalId");
      area_id = $(this).data("areaId");
      return $.ajax({
        type: "GET",
        url: "/strategic_plan/plans/" + plan_id + "/divisions/" + division_id + "/areas/" + area_id + "/goals/" + goal_id + "/objectives/" + objective_id + "/edit",
        data: {
          request: "edit_objective_status",
          objective_id: objective_id,
          plan_id: plan_id,
          division_id: division_id,
          department_id: department_id,
          goal_id: goal_id,
          area_id: area_id
        }
      });
    });
    $(document).on('click', ".asset-obj-all", function(e) {
      var objective_id;
      e.preventDefault();
      objective_id = $(this).data("objectiveId");
      return $.ajax({
        type: "GET",
        url: "/objectives/get_all_objective_attachments",
        data: {
          objective_id: objective_id
        }
      });
    });
    $(document).on('shown.bs.modal', "#user-assign-modal-form", function(e) {
      return $(".user-objective-chkbox").bootstrapSwitch({
        size: "mini"
      });
    });
    $(document).on('switchChange.bootstrapSwitch', ".user-objective-chkbox", function(event, state) {
      var objective_id, owner_status, user_objective_id;
      owner_status = state;
      user_objective_id = $(this).data("userObjectiveId");
      objective_id = $(this).data("objectiveId");
      return $.ajax({
        type: "PUT",
        url: "/objectives/update_objective_user",
        data: {
          owner: owner_status,
          user_objective_id: user_objective_id,
          objective_id: objective_id
        },
        success: function(data) {
          return $(document).ready(function() {
            return $(".user-objective-chkbox").bootstrapSwitch({
              size: "mini"
            });
          });
        }
      });
    });
    $(document).on('hide.bs.modal', "#user-assign-modal-form", function(e) {
      if ($(".user-objective-chkbox").length > 0) {
        if ($(".user-objective-chkbox:checked").length === 0) {
          e.preventDefault();
          return alert("Please make one owner.");
        }
      } else {
        return $(this).hide();
      }
    });
    return $(document).on('submit', ".user-objective-form", function(e) {
      var _this;
      e.preventDefault();
      _this = $(this);
      return $.ajax({
        type: "POST",
        url: "/objectives/create_user_objective",
        data: _this.serialize(),
        success: function() {
          return $(document).ready(function() {
            return $(".user-objective-chkbox").bootstrapSwitch({
              size: "mini"
            });
          });
        }
      });
    });
  });

}).call(this);
