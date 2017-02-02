class ObjectivesController < ApplicationController
  before_action :set_objective, only: [:show, :edit, :update, :destroy]
  before_action :set_objective_params, only: [:index, :new_objective_attachment, :edit] 
  def index
    @objectives = @goal.objectives
    @objective = Objective.new
  end

  def show
  end

  def new
    @objective = Objective.new
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def create
    params[:objective][:requested_by_date].length == 0 ? requested_by_date = params[:objective][:requested_by_date] = nil : 
      requested_by_date = Date.strptime(params[:objective][:requested_by_date], "%m/%d/%Y")
    @objective = Objective.new(objective_params.merge(requested_by_date: requested_by_date))
    @plan_objective = PlanObjective.new(plan_id: params[:plan_id], objective_id: @objective.id)
    if @objective.save and @plan_objective.save
    else
      flash[:alert] = "Objective can not be created."
    end
    objectives_redirect_path
  end

  def update
    if params[:objective][:requested_by_date].present?
      params[:objective][:requested_by_date].length == 0 ? requested_by_date = params[:objective][:requested_by_date] = nil : 
      requested_by_date = Date.strptime(params[:objective][:requested_by_date], "%m/%d/%Y")
      @objective.update(objective_params.merge(requested_by_date: requested_by_date))
    else
      @objective.update(objective_params)
    end
    objectives_redirect_path
  end

  def destroy
    @objective.destroy
    objectives_redirect_path  
  end

  def new_objective_attachment
    @objective = Objective.find(params[:objective_id])
    @asset = @objective.assets.build
    respond_to do |format|
      format.js
    end
  end

  def create_user_objective
    @objective = Objective.find(params[:objective_id])
    if @objective.users.present?
      @user_objective = UserObjective.where(user_id: params[:user_id], objective_id: params[:objective_id]).first_or_create(user_id: params[:user_id], objective_id: params[:objective_id])
    else
        @user_objective = UserObjective.where(user_id: params[:user_id], objective_id: params[:objective_id]).first_or_create(user_id: params[:user_id], objective_id: params[:objective_id], owner: true)
    end
    @users = @objective.users
    respond_to do |format|
      format.js
    end
  end

  def get_objective_users
    @objective = Objective.find(params[:objective_id])
    @users = @objective.users
    respond_to do |format|
      format.js
    end
  end

  def create_team_objective
    @team_objective = TeamObjective.where(team_id: params[:team_id], objective_id: params[:objective_id]).first_or_create(team_id: params[:team_id], objective_id: params[:objective_id])
    @objective = Objective.find(params[:objective_id])
    @teams = @objective.teams
    respond_to do |format|
      format.js
    end   
  end

  def get_objective_teams
    @objective = Objective.find(params[:objective_id])
    @teams = @objective.teams
    respond_to do |format|
      format.js
    end
  end 

  def update_objective_user
    @user_objective = UserObjective.find(params[:user_objective_id])
    @user_objectives = UserObjective.where(objective_id: @user_objective.objective_id)
    @user_objectives.each do |user_objective|
      user_objective.update(owner: false)
    end  
    @user_objective.update(owner: params[:owner])
    @objective = @user_objective.objective
    @users = @objective.users 
  end

  def destroy_user_objective
    @user_objective = UserObjective.where(user_id: params[:user_id], objective_id: params[:objective_id]).first
    @user_objective.destroy
    @objective = Objective.find(params[:objective_id])
    @users = @objective.users
    respond_to do |format|
      format.js
    end
  end

  def destroy_team_objective
    @team_objective = TeamObjective.where(team_id: params[:team_id], objective_id: params[:objective_id]).first
    @team_objective.destroy
    @objective = Objective.find(params[:objective_id])
    @teams = @objective.teams
    respond_to do |format|
      format.js
    end
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

    def set_objective_params
      @area = Area.find(params[:area_id]) 
      @plan = Plan.find(params[:plan_id])
      @division = Division.find(params[:division_id])
      @department = Department.find(params[:department_id])
      @goal = Goal.find(params[:goal_id])
    end

    def objective_params
      params.require(:objective).permit(:description, :number, :goal_id, :status, :begin_on, :end_on,
       :totalhours, :percent_complete, :strategies_count, :requested_by_date, :on_going_carry_forward,
       :budgeted_dollars, :actual_hours,  assets_attributes: [:id, :title, :asset, :_destroy])
    end
end
