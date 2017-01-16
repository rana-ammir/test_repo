class ObjectivesController < ApplicationController
  before_action :set_objective, only: [:show, :edit, :update, :destroy]

  def index
    @area = Area.find(params[:area_id]) 
    @plan = Plan.find(params[:plan_id])
    @division = Division.find(params[:division_id])
    @department = Department.find(params[:department_id])
    @goal = Goal.find(params[:goal_id])
    @objectives = @goal.objectives
    @objective = Objective.new
  end

  def show
  end

  def new
    @objective = Objective.new
  end

  def edit
  end

  def create
    params[:objective][:requested_by_date].length == 0 ? requested_by_date = params[:objective][:requested_by_date] = nil : 
      requested_by_date = Date.strptime(params[:objective][:requested_by_date], "%m/%d/%Y")
    @objective = Objective.create(objective_params.merge(requested_by_date: requested_by_date))
    objectives_redirect_path
  end

  def update
    params[:objective][:requested_by_date].length == 0 ? requested_by_date = params[:objective][:requested_by_date] = nil : 
      requested_by_date = Date.strptime(params[:objective][:requested_by_date], "%m/%d/%Y")
    @objective.update(objective_params.merge(requested_by_date: requested_by_date))
    objectives_redirect_path
  end

  def destroy
    @objective.destroy
    objectives_redirect_path  
  end

  private
    def set_objective
      @objective = Objective.find(params[:id])
    end
    
    def objectives_redirect_path
      redirect_to plan_division_department_area_goal_objectives_path(plan_id: params[:plan_id],
          goal_id: params[:goal_id], division_id: params[:division_id],
          department_id: params[:department_id], area_id: params[:area_id])
    end

    def objective_params
      params.require(:objective).permit(:description, :number, :goal_id, :status, :begin_on, :end_on,
       :totalhours, :percent_complete, :strategies_count, :requested_by_date, :on_going_carry_forward,
       :budgeted_dollars, :actual_hours,  assets_attributes: [:id, :title, :asset, :_destroy])
    end
end
