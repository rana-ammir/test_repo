(function() {
  $(function() {
    $(document).on('click', ".edit-tactic-link", function(e) {
      var area_id, department_id, division_id, goal_id, objective_id, plan_id, strategy_id, tactic_id;
      e.preventDefault();
      tactic_id = $(this).data("tacticId");
      strategy_id = $(this).data("strategyId");
      objective_id = $(this).data("objectiveId");
      plan_id = $(this).data("planId");
      division_id = $(this).data("divisionId");
      department_id = $(this).data("departmentId");
      goal_id = $(this).data("goalId");
      area_id = $(this).data("areaId");
      return $.ajax({
        type: "GET",
        url: "/strategic_plan/plans/" + plan_id + "/divisions/" + division_id + "/areas/" + area_id + "/goals/" + goal_id + "/objectives/" + objective_id + "/strategies/" + strategy_id + "/tactics/" + tactic_id + "/edit",
        data: {
          tactic_id: tactic_id,
          strategy_id: strategy_id,
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
    $(document).on('click', ".asset-tactic-link", function(e) {
      var area_id, department_id, division_id, goal_id, objective_id, plan_id, strategy_id, tactic_id;
      e.preventDefault();
      tactic_id = $(this).data("tacticId");
      strategy_id = $(this).data("strategyId");
      objective_id = $(this).data("objectiveId");
      plan_id = $(this).data("planId");
      division_id = $(this).data("divisionId");
      department_id = $(this).data("departmentId");
      goal_id = $(this).data("goalId");
      area_id = $(this).data("areaId");
      return $.ajax({
        type: "GET",
        url: "/tactics/new_tactic_attachment/" + tactic_id,
        data: {
          tactic_id: tactic_id,
          strategy_id: strategy_id,
          objective_id: objective_id,
          plan_id: plan_id,
          division_id: division_id,
          department_id: department_id,
          goal_id: goal_id,
          area_id: area_id
        }
      });
    });
    $(document).on('click', ".all-asset-tactic", function(e) {
      var tactic_id;
      e.preventDefault();
      tactic_id = $(this).data("tacticId");
      return $.ajax({
        type: "GET",
        url: "/tactics/get_all_tactic_attachments",
        data: {
          tactic_id: tactic_id
        }
      });
    });
    $(document).on('click', ".user-assign-link", function(e) {
      var tactic_id;
      e.preventDefault();
      tactic_id = $(this).data("tacticId");
      $(".tactic-hf").val(tactic_id);
      return $.ajax({
        type: "GET",
        url: "/tactics/get_tactic_users",
        data: {
          tactic_id: tactic_id
        },
        success: function(data) {
          return $(document).ready(function() {
            return $(".user-tactic-chkbox").bootstrapSwitch({
              size: "mini"
            });
          });
        }
      });
    });
    $('#user-name-autocomplete').bind('railsAutocomplete.select', function(event, data) {
      return $('.user-hf').val(data.item.key);
    });
    $(document).on('click', ".delete-assigned-user", function(e) {
      var tactic_id, user_id;
      e.preventDefault();
      tactic_id = $(this).data("tacticId");
      user_id = $(this).data("userId");
      return $.ajax({
        type: "GET",
        url: "/tactics/destroy_user_tactic",
        data: {
          tactic_id: tactic_id,
          user_id: user_id
        },
        success: function(data) {
          return $(document).ready(function() {
            return $(".user-tactic-chkbox").bootstrapSwitch({
              size: "mini"
            });
          });
        }
      });
    });
    $(document).on('click', ".team-assign-link", function(e) {
      var tactic_id;
      e.preventDefault();
      tactic_id = $(this).data("tacticId");
      $(".tactic-hf").val(tactic_id);
      return $.ajax({
        type: "GET",
        url: "/tactics/get_tactic_teams",
        data: {
          tactic_id: tactic_id
        }
      });
    });
    $('#team-name-autocomplete').bind('railsAutocomplete.select', function(event, data) {
      return $('.team-hf').val(data.item.key);
    });
    $(document).on('click', ".delete-assigned-team", function(e) {
      var tactic_id, team_id;
      e.preventDefault();
      tactic_id = $(this).data("tacticId");
      team_id = $(this).data("teamId");
      return $.ajax({
        type: "GET",
        url: "/tactics/destroy_team_tactic",
        data: {
          tactic_id: tactic_id,
          team_id: team_id
        }
      });
    });
    $(document).on('click', ".publish-tactic-link", function(e) {
      var tactic_id;
      e.preventDefault();
      tactic_id = $(this).data("tacticId");
      return $.ajax({
        type: "POST",
        url: "/tasks/publish_tactic_task",
        data: {
          tactic_id: tactic_id
        },
        success: function(data) {
          return $("html, body").animate({
            scrollTop: "0px"
          });
        }
      });
    });
    $(document).on('shown.bs.modal', "#user-assign-modal-form", function(e) {
      return $(".user-tactic-chkbox").bootstrapSwitch({
        size: "mini"
      });
    });
    $(document).on('switchChange.bootstrapSwitch', ".user-tactic-chkbox", function(event, state) {
      var owner_status, tactic_id, user_tactic_id;
      owner_status = state;
      user_tactic_id = $(this).data("userTacticId");
      tactic_id = $(this).data("tacticId");
      return $.ajax({
        type: "PUT",
        url: "/tactics/update_tactic_user",
        data: {
          owner: owner_status,
          user_tactic_id: user_tactic_id,
          tactic_id: tactic_id
        },
        success: function(data) {
          return $(document).ready(function() {
            return $(".user-tactic-chkbox").bootstrapSwitch({
              size: "mini"
            });
          });
        }
      });
    });
    $(document).on('hide.bs.modal', "#user-assign-modal-form", function(e) {
      if ($(".user-tactic-chkbox").length > 0) {
        if ($(".user-tactic-chkbox:checked").length === 0) {
          e.preventDefault();
          return alert("Please make one owner.");
        }
      } else {
        return $(this).hide();
      }
    });
    return $(document).on('submit', ".user-tactic-form", function(e) {
      var _this;
      e.preventDefault();
      _this = $(this);
      return $.ajax({
        type: "POST",
        url: "/tactics/create_user_tactic",
        data: _this.serialize(),
        success: function() {
          return $(document).ready(function() {
            return $(".user-tactic-chkbox").bootstrapSwitch({
              size: "mini"
            });
          });
        }
      });
    });
  });

}).call(this);
