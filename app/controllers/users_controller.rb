class UsersController < ApplicationController
	skip_before_action :authenticate_user!, :only => [:forgot_password, :generate_new_password_email, :get_selected_division]
	autocomplete :user, :first_name
	
	def index
		@users = current_user.organization.users.not_organization_administrator
	end

	def new
		@user = User.new	
	end

	def create
		@user = User.create(user_params)
		redirect_to members_path
	end

	def edit
		@array_of_roles = User::Role::DISPLAY_NAMES.to_a
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if params[:user][:password].blank?
      @user.update_without_password(user_params)
    else
      @user.update_attributes(user_params)
    end
    if @user.errors.blank?
      redirect_to edit_member_path(id: @user.id), :notice => "User updated successfully."
    else
      render :edit
    end
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
		redirect_to members_path
	end

	def get_selected_division
		@division = Division.find(params[:division_id])
		@departments = @division.departments
		@user = User.new
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

	def autocomplete_user_name
		@users = User.where("LOWER(first_name) LIKE ?", "%#{params[:term].downcase}%").not_organization_administrator.where(organization_id: current_user.organization_id)
		render json: @users.map{|f| {"value" => "#{f.first_name} #{f.last_name}" , "key" => f.id} }.to_json
	end

	def profile
		@user = current_user
		@teams = @user.teams
	end

	private
		def user_params
      params.require(:user).permit(:role_id, :username, :current_password, :first_name, :last_name, :organization_id, :division_id, :department_id, :job_title, :email, :password, :password_confirmation, :avatar)
    end
end
