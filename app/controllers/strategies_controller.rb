class StrategiesController < ApplicationController
  before_action :set_strategy, only: [:show, :edit, :update, :destroy]
  before_action :set_strategy_params, only: [:index, :edit, :new_strategy_attachment]
  before_action :set_strategy_method_parameter, only: [:get_strategy_teams, :create_user_strategy,
   :get_strategy_users, :create_team_strategy, :destroy_user_strategy, :destroy_team_strategy]

  def index
    @strategies = @objective.strategies
    @strategy = Strategy.new
  end

  def show
  end

  def new
    @strategy = Strategy.new
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def create
    params[:strategy][:end_on].length == 0 ? end_on = params[:strategy][:end_on] = nil : 
      end_on = Date.strptime(params[:strategy][:end_on], "%m/%d/%Y")
    @strategy = Strategy.new(strategy_params.merge(end_on: end_on))
    if @strategy.save
    else
      flash[:alert] = "Strategy can not be created."
    end
    strategies_redirect_path
  end

  def update
    if params[:strategy][:end_on].present?
      params[:strategy][:end_on].length == 0 ? end_on = params[:strategy][:end_on] = nil : 
      end_on = Date.strptime(params[:strategy][:end_on], "%m/%d/%Y")
      @strategy.update(strategy_params.merge(end_on: end_on))
    else
      @strategy.update(strategy_params)
    end
    strategies_redirect_path
  end

  def destroy
    @strategy.destroy
    strategies_redirect_path
  end

  def new_strategy_attachment
    @strategy = Strategy.find(params[:strategy_id])
    @asset = @strategy.assets.build
    respond_to do |format|
      format.js
    end
  end

  def create_user_strategy
    @user_strategy = UserStrategy.where(user_id: params[:user_id], strategy_id: params[:strategy_id]).first_or_create(user_id: params[:user_id], strategy_id: params[:strategy_id])
    @users = @strategy.users
    respond_to do |format|
      format.js
    end
  end

  def get_strategy_users
    @users = @strategy.users
    respond_to do |format|
      format.js
    end
  end

  def create_team_strategy
    @team_strategy = TeamStrategy.where(team_id: params[:team_id], strategy_id: params[:strategy_id]).first_or_create(team_id: params[:team_id], strategy_id: params[:strategy_id])
    @teams = @strategy.teams
    respond_to do |format|
      format.js
    end   
  end

  def get_strategy_teams
    @teams = @strategy.teams
    respond_to do |format|
      format.js
    end
  end 

  def destroy_user_strategy
    @user_strategy = UserStrategy.where(user_id: params[:user_id], strategy_id: params[:strategy_id]).first
    @user_strategy.destroy
    @users = @strategy.users
    respond_to do |format|
      format.js
    end
  end

  def destroy_team_strategy
    @team_strategy = TeamStrategy.where(team_id: params[:team_id], strategy_id: params[:strategy_id]).first
    @team_strategy.destroy
    @teams = @strategy.teams
    respond_to do |format|
      format.js
    end
  end

  private
    def set_strategy
      @strategy = Strategy.find(params[:id])
    end
    
    def set_strategy_method_parameter
      @strategy = Strategy.find(params[:strategy_id])
    end
    
    def set_strategy_params
      @area = Area.find(params[:area_id]) 
      @plan = Plan.find(params[:plan_id])
      @division = Division.find(params[:division_id])
      @department = Department.find(params[:department_id])
      @goal = Goal.find(params[:goal_id])
      @objective = Objective.find(params[:objective_id])
    end

    def strategy_params
      params.require(:strategy).permit(:description, :fiscal_year, :budget_dollars, :budget_fte, :begin_on, :end_on, :percent_complete, :percent_of_objective, :completed_on, :objective_id, :number, :totalhours, :tactics_count, :actual_hours, assets_attributes: [:id, :title, :asset, :_destroy])
    end

    def strategies_redirect_path
      redirect_to plan_division_department_area_goal_objective_strategies_path(plan_id: params[:plan_id], 
        division_id: params[:division_id], department_id: params[:department_id], area_id: params[:area_id], goal_id: params[:goal_id], objective_id: params[:objective_id])
    end
end
