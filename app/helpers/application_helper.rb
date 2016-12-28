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
end
