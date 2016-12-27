class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
  	devise_parameter_sanitizer.permit(:sign_up, keys: [:role_id, :username, :first_name, :last_name, :address, :organization_name, :organization_id])
  	devise_parameter_sanitizer.permit(:account_update, keys: [:role_id, :username, :first_name, :last_name,:organization_id, :division_id, :department_id, :email, :password, :password_confirmation, :current_password, :job_title])
  end
end
