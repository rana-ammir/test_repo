class ActivitiesController < ApplicationController
  before_action :set_activity, only: [:show, :edit, :update, :destroy]

  def index
    @organization = current_user.organization
    @tasks = @organization.tasks.active_tasks
    @activities = @organization.activities
  end

  def show
  end

  def new
    @activity = Activity.new
  end

  def edit
    respond_to do |format|
      format.js
      format.html
    end
  end

  def create
    @activity = Activity.where(task_id: params[:activity][:task_id]).first_or_initialize(activity_params)
    respond_to do |format|
      if @activity.save
        format.html { redirect_to @activity, notice: 'Activity was successfully created.' }
        format.json { render json: {activity: @activity.calendar_json}, action: 'show', status: :created, location: @activity}
      else
        format.html { render action: 'new' }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @activity.update(activity_params)
        format.html { redirect_to activities_path, notice: 'Activity was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @activity.destroy
    respond_to do |format|
      format.html { redirect_to activities_url }
      format.json { render json: @activity }
    end
  end

  def get_filtered_tasks
    @tasks = Task.filter_task(params[:status])
    respond_to do |format|
      format.js
    end
  end

  private
    def set_activity
      @activity = Activity.find(params[:id])
    end

    def activity_params
      params.require(:activity).permit(:activity_date, :start_time, :end_time, :hours, :created_by_user_id,
       :updated_by_user_id, :description, :task_id, :updated_at, :completion_flag)
    end
end
