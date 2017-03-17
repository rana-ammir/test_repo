class UserboardsController < ApplicationController
  before_action :set_userboard, only: [:show, :edit, :update, :destroy]
  after_filter :discard_flash, only: :update
  
  def index
    @organization = current_user.organization
    @userboards = Userboard.current_organization_user_userboards(@organization.users)
  end

  def show
  end

  def new
    @userboard = Userboard.new
  end

  def edit
  end

  def create
    @userboard = Userboard.new(userboard_params)
    respond_to do |format|
      if @userboard.save
        format.html { redirect_to userboards_path, notice: 'Userboard was successfully created.' }
        format.json { render action: 'show', status: :created, location: @userboard }
      else
        format.html { render action: 'new' }
        format.json { render json: @userboard.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @userboard.update(userboard_params)
        format.html { redirect_to userboards_path, notice: 'Userboard was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @userboard.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @userboard.destroy
    respond_to do |format|
      format.html { redirect_to userboards_url }
      format.json { head :no_content }
    end
  end

  def my_board
    @userboards = current_user.userboards
    @tasks = current_user.tasks.active_tasks
  end

  def get_filtered_tasks
    @userboards = current_user.userboards
    if params[:status] == "All"
      @tasks = current_user.tasks
    elsif params[:status] == "Not-Complete"
      @tasks = current_user.tasks.active_tasks
    else
      @tasks = current_user.tasks.filter_task(params[:status])
    end
    respond_to do |format|
      format.js
    end
  end

  def assign_userboard_to_task
    @task = Task.find(params[:task_id])
    @task.update(userboard_id: params[:userboard_id])
    respond_to do |format|
      format.js
    end
  end

  def get_userboard_tasks
    @userboard = Userboard.find(params[:userboard_id])
    @userboards = current_user.userboards
    @tasks = @userboard.tasks
    respond_to do |format|
      format.js
    end
  end
  
  private
    def discard_flash
      flash.discard if request.xhr?
    end

    def set_userboard
      @userboard = Userboard.find(params[:id])
    end

    def userboard_params
      params.require(:userboard).permit(:name, :userboard_type, :color, :status, :user_id)
    end
end
