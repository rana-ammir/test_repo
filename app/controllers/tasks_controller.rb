class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  after_filter :discard_flash, only: :publish_tactic_task

  def index
    @tasks = current_user.organization.tasks
  end

  def show
  end

  def new
    @task = Task.new
    @current_org_users = current_user.organization.users.not_organization_administrator
  end

  def edit
    @current_org_users = current_user.organization.users.not_organization_administrator
  end

  def create
    @task = Task.new(task_params)
    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    if params[:checked]== "true" || params[:task][:progress] == "100"
      @task.update(task_params.merge(completion_date: Date.today, status: "Completed")) 
    elsif params[:checked]== "false" || params[:task][:progress].to_i < 100
      @task.update(task_params.merge(completion_date: nil, status: "In-Progress"))
    else
      @task.update(task_params)
    end
    respond_to do |format|
        format.js
        format.html { redirect_to @task }
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.json { head :no_content }
    end
  end

  def publish_tactic_task
    @tactic = Tactic.find(params[:tactic_id])
    @task = Task.find_task(@tactic.id).first_or_initialize(
      tactic_id: @tactic.id,
      due_date: @tactic.end_on,
      description: @tactic.description,
      requestor_id: @tactic.tactic_user_obj_owner,
      task_type: "SP",
      status: "New",
      progress: @tactic.percent_of_strategy,
      organization_id: current_user.organization.id,
      assigned_to_id: @tactic.tactic_user_owner)  
    respond_to do |format|
      if @task.valid?
        @task.save
        format.js { flash.now[:notice] = "Task published successfully."}
      else
        format.js { flash.now[:alert] = "Task could not be published."}
      end
    end
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def discard_flash
      flash.discard if request.xhr?
    end
    
    def task_params
      params.require(:task).permit(:tactic_id, :organization_id, :task_type, :description, :status, :due_date, :requestor_id, :assigned_to_id, :actual_hours, :completion_date, :progress)
    end
end
