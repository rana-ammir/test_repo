class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :prepare_exception_notifier
  before_filter :set_current_user
  
  def set_current_user
    User.current_user = current_user
  end
  
  def load_strategic_plans_list
    @strategy_plans_list = Plan.organization_plans_list(current_user.organization.id).active_plans.sort_asc_plans unless ( current_user.blank? and current_user.organization.id.blank? )
  end

  protected

  def configure_permitted_parameters
  	devise_parameter_sanitizer.permit(:sign_up, keys: [:role_id, :username, :first_name, :last_name, :address, :organization_name , :hours_in_day, :organization_id, :job_title])
  	devise_parameter_sanitizer.permit(:account_update, keys: [:role_id, :username, :first_name, :last_name,:organization_id, :division_id, :department_id, :email, :password, :password_confirmation, :current_password, :job_title, :avatar])
  end

  private
  def prepare_exception_notifier
    request.env["exception_notifier.exception_data"] = {
      :current_user => current_user
    }
  end
end
