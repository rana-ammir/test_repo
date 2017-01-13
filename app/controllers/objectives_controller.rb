class ObjectivesController < ApplicationController
  before_action :set_objective, only: [:show, :edit, :update, :destroy]

  def index
    @area = Area.find(params[:area_id]) 
    @plan = Plan.find(params[:plan_id])
    @division = Division.find(params[:division_id])
    @department = Department.find(params[:department_id])
    @goal = Goal.find(params[:goal_id])
    @objectives = Objective.all
    @objective = @goal.objectives.new
  end

  def show
  end

  def new
    @objective = Objective.new
  end

  def edit
  end

  def create
    @goal = Goal.find(params[:goal_id])
    @objective = Objective.new(objective_params)
    respond_to do |format|
      if @objective.save
        format.html { redirect_to goal_objectives_path(goal_id: @goal.id), notice: 'Objective was successfully created.' }
        format.json { render action: 'show', status: :created, location: @objective }
      else
        format.html { render action: 'new' }
        format.json { render json: @objective.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @objective.update(objective_params)
        format.html { redirect_to @objective, notice: 'Objective was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @objective.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @objective.destroy
    respond_to do |format|
      format.html { redirect_to objectives_url }
      format.json { head :no_content }
    end
  end

  private
    def set_objective
      @objective = Objective.find(params[:id])
    end

    def objective_params
      params.require(:objective).permit(:description, :number, :goal_id, :status, :begin_on, :end_on,
       :totalhours, :percent_complete, :strategies_count, :requested_by_date, :on_going_carry_forward,
       :budgeted_dollars, :actual_hours,  assets_attributes: [:id, :title, :asset, :_destroy])
    end
end
