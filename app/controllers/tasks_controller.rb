class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

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
    @task = Task.create(tactic_id: params[:tactic_id], due_date: @tactic.end_on, description: @tactic.description, requestor_id: @tactic.strategy.objective.id, type: "Strategic", status: "New")  
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:tactic).permit(:tactic_id, :type, :description, :status, :due_date, :requestor_id, :assigned_to_id, :actual_hours, :completion_date, :progress)
    end
end
