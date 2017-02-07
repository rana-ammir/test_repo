class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  after_filter :discard_flash, only: :publish_tactic_task

  def index
    @tasks = Task.all
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render action: 'show', status: :created, location: @task }
      else
        format.html { render action: 'new' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
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
    @task = Task.create(tactic_id: @tactic.id, due_date: @tactic.end_on, description: @tactic.description, requestor_id: @tactic.tactic_user_obj_owner.id, task_type: "SP", status: "New")  
    respond_to do |format|
      format.js { flash.now[:notice] = "Task published successfully."}
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
      params.require(:task).permit(:tactic_id, :task_type, :description, :status, :due_date, :requestor_id, :assigned_to_id, :actual_hours, :completion_date, :progress)
    end
end
