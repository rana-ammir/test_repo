class UsersController < ApplicationController
	skip_before_action :authenticate_user!, :only => [:forgot_password, :generate_new_password_email]

	def forgot_password
		user = User.find_by_email(params[:email])
	end

	def generate_new_password_email 
		user = User.find_by_email(params[:email])
		if user
			user.send_reset_password_instructions 
			redirect_to root_path 
		else
			render action: 'forgot_password'
		end
	end

	def index
		@users = User.organization_administrator!
	end

	def new
		@user = User.new	
	end

	def create
		@user = User.create(user_params.merge(department_id: params["/members"]["department_id"]))
		redirect_to members_path
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		@user.update(user_params)
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

	private
		def user_params
      params.require(:user).permit(:role_id, :username, :first_name, :last_name, :organization_id, :division_id, :department_id, :job_title, :email, :password, :password_confirmation)
    end
end
