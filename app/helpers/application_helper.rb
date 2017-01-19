module ApplicationHelper
  def is_active_controller(controller_name)
      params[:controller] == controller_name ? "active" : nil
  end

  def is_active_action(action_name)
      params[:action] == action_name ? "active" : nil
  end

  def is_active_controller_action(controller_name, action_name)
  	params[:action] == action_name and params[:controller] == controller_name ? "active" : nil
  end

  def role_name
  	User::Role::DISPLAY_NAMES
  end

  def unassigned_users
    users = current_user.organization.users.not_organization_administrator
  end

  def on_going_carry_forward_icons(value)
    if value == 0
      "fa-check-circle-o"
    elsif value == 1
      "fa-circle-o"
    else
      "fa-check-circle"
    end
  end
  
end
