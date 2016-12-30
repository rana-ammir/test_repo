class UsersController < ApplicationController
	skip_before_action :authenticate_user!, :only => [:forgot_password, :generate_new_password_email, :get_selected_division]

	def index
		@users = current_user.organization.users.not_organization_administrator
	end

	def new
		@user = User.new	
	end

	def create
		@user = User.create(user_params.merge(department_id: params["/members"]["department_id"]))
		redirect_to members_path
	end

	def edit
		@array_of_roles = User::Role::DISPLAY_NAMES.to_a
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if params["/members"].present?
			@user.update(user_params.merge(department_id: params["/members"]["department_id"]))
		else
			@user.update(user_params)
		end
		redirect_to members_path
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
		redirect_to members_path
	end

	def get_selected_division
		@division = Division.find(params[:division_id])
		@departments = @division.departments
		respond_to do |format|
			format.js
		end
	end

	def forgot_password
		user = User.find_by_email(params[:email])
	end

	def generate_new_password_email 
		user = User.find_by_email(params[:email])
		if user
			user.send_reset_password_instructions 
			redirect_to root_path 
		else
			redirect_to action: 'forgot_password'
			flash[:alert] = "We could not find the Email you entered. Please try again."
		end
	end

	private
		def user_params
      params.require(:user).permit(:role_id, :username, :current_password, :first_name, :last_name, :organization_id, :division_id, :department_id, :job_title, :email, :password, :password_confirmation)
    end
end
