(function() {
  $(function() {
    $(document).on('click', ".edit-strategy-link", function(e) {
      var area_id, department_id, division_id, goal_id, objective_id, plan_id, strategy_id;
      e.preventDefault();
      strategy_id = $(this).data("strategyId");
      objective_id = $(this).data("objectiveId");
      plan_id = $(this).data("planId");
      division_id = $(this).data("divisionId");
      department_id = $(this).data("departmentId");
      goal_id = $(this).data("goalId");
      area_id = $(this).data("areaId");
      return $.ajax({
        type: "GET",
        url: "/strategic_plan/plans/" + plan_id + "/divisions/" + division_id + "/areas/" + area_id + "/goals/" + goal_id + "/objectives/" + objective_id + "/strategies/" + strategy_id + "/edit",
        data: {
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
    $(document).on('click', ".asset-strategy-link", function(e) {
      var area_id, department_id, division_id, goal_id, objective_id, plan_id, strategy_id;
      e.preventDefault();
      strategy_id = $(this).data("strategyId");
      objective_id = $(this).data("objectiveId");
      plan_id = $(this).data("planId");
      division_id = $(this).data("divisionId");
      department_id = $(this).data("departmentId");
      goal_id = $(this).data("goalId");
      area_id = $(this).data("areaId");
      return $.ajax({
        type: "GET",
        url: "/strategies/new_strategy_attachment/" + strategy_id,
        data: {
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
    $(document).on('click', ".asset-strategy-all", function(e) {
      var strategy_id;
      e.preventDefault();
      strategy_id = $(this).data("strategyId");
      return $.ajax({
        type: "GET",
        url: "/tactics/get_all_tactic_attachments",
        data: {
          strategy_id: strategy_id
        }
      });
    });
    $(document).on('click', ".user-assign-link", function(e) {
      var strategy_id;
      e.preventDefault();
      strategy_id = $(this).data("strategyId");
      $(".strategy-hf").val(strategy_id);
      return $.ajax({
        type: "GET",
        url: "/strategies/get_strategy_users",
        data: {
          strategy_id: strategy_id
        },
        success: function(data) {
          return $(document).ready(function() {
            return $(".user-strategy-chkbox").bootstrapSwitch({
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
      var strategy_id, user_id;
      e.preventDefault();
      strategy_id = $(this).data("strategyId");
      user_id = $(this).data("userId");
      return $.ajax({
        type: "GET",
        url: "/strategies/destroy_user_strategy",
        data: {
          strategy_id: strategy_id,
          user_id: user_id
        },
        success: function(data) {
          return $(document).ready(function() {
            return $(".user-strategy-chkbox").bootstrapSwitch({
              size: "mini"
            });
          });
        }
      });
    });
    $(document).on('click', ".team-assign-link", function(e) {
      var strategy_id;
      e.preventDefault();
      strategy_id = $(this).data("strategyId");
      $(".strategy-hf").val(strategy_id);
      return $.ajax({
        type: "GET",
        url: "/strategies/get_strategy_teams",
        data: {
          strategy_id: strategy_id
        }
      });
    });
    $('#team-name-autocomplete').bind('railsAutocomplete.select', function(event, data) {
      return $('.team-hf').val(data.item.key);
    });
    $(document).on('click', ".delete-assigned-team", function(e) {
      var strategy_id, team_id;
      e.preventDefault();
      strategy_id = $(this).data("strategyId");
      team_id = $(this).data("teamId");
      return $.ajax({
        type: "GET",
        url: "/strategies/destroy_team_strategy",
        data: {
          strategy_id: strategy_id,
          team_id: team_id
        }
      });
    });
    $(document).on('shown.bs.modal', "#user-assign-modal-form", function(e) {
      return $(".user-strategy-chkbox").bootstrapSwitch({
        size: "mini"
      });
    });
    $(document).on('switchChange.bootstrapSwitch', ".user-strategy-chkbox", function(event, state) {
      var owner_status, strategy_id, user_strategy_id;
      owner_status = state;
      user_strategy_id = $(this).data("userStrategyId");
      strategy_id = $(this).data("strategyId");
      return $.ajax({
        type: "PUT",
        url: "/strategies/update_strategy_user",
        data: {
          owner: owner_status,
          user_strategy_id: user_strategy_id,
          strategy_id: strategy_id
        },
        success: function(data) {
          return $(document).ready(function() {
            return $(".user-strategy-chkbox").bootstrapSwitch({
              size: "mini"
            });
          });
        }
      });
    });
    $(document).on('hide.bs.modal', "#user-assign-modal-form", function(e) {
      if ($(".user-strategy-chkbox").length > 0) {
        if ($(".user-strategy-chkbox:checked").length === 0) {
          e.preventDefault();
          return alert("Please make one owner.");
        }
      } else {
        return $(this).hide();
      }
    });
    return $(document).on('submit', ".user-strategy-form", function(e) {
      var _this;
      e.preventDefault();
      _this = $(this);
      return $.ajax({
        type: "POST",
        url: "/strategies/create_user_strategy",
        data: _this.serialize(),
        success: function() {
          return $(document).ready(function() {
            return $(".user-strategy-chkbox").bootstrapSwitch({
              size: "mini"
            });
          });
        }
      });
    });
  });

}).call(this);
