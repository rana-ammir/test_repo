class TacticsController < ApplicationController
  before_action :set_tactic, only: [:show, :edit, :update, :destroy]
  before_action :set_tactic_params, only: [:index, :edit, :new_tactic_attachment]
  before_action :set_tactic_method_parameter, only: [:get_tactic_teams, :create_user_tactic,
   :get_tactic_users, :create_team_tactic, :destroy_user_tactic, :destroy_team_tactic, :new_tactic_attachment]

  def index
    @tactics = @strategy.tactics
    @tactic = Tactic.new
  end

  def show
  end

  def new
    @tactic = Tactic.new
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def create
    params[:tactic][:end_on].length == 0 ? end_on = params[:tactic][:end_on] = nil : 
      end_on = Date.strptime(params[:tactic][:end_on], "%m/%d/%Y")
    @tactic = Tactic.new(tactic_params.merge(end_on: end_on))
    if @tactic.save
      flash[:notics] = "Tactic created sucessfully."
    else
      flash[:alert] = "Tactic can not be created."
    end
    tactics_redirect_path
  end

  def update
    if params[:tactic][:end_on].present?
      params[:tactic][:end_on].length == 0 ? end_on = params[:tactic][:end_on] = nil : 
      end_on = Date.strptime(params[:tactic][:end_on], "%m/%d/%Y")
      @tactic.update(tactic_params.merge(end_on: end_on))
    else
      @tactic.update(tactic_params)
    end
    tactics_redirect_path
  end

  def destroy
    @tactic.destroy
    tactics_redirect_path
  end

  def new_tactic_attachment
    @asset = @tactic.assets.build
    respond_to do |format|
      format.js
    end
  end

  def create_user_tactic
    @tactic = Tactic.find(params[:tactic_id])
    if @tactic.users.present?
      @user_tactic = UserTactic.existing_user_tactic(params[:user_id], params[:tactic_id]).first_or_create(user_id: params[:user_id], tactic_id: params[:tactic_id])
    else
      @user_tactic = UserTactic.create(user_id: params[:user_id], tactic_id: params[:tactic_id], owner: true)
    end
    @users = @tactic.users.reload
    respond_to do |format|
      format.js
    end
  end

  def get_tactic_users
    @users = @tactic.users
    respond_to do |format|
      format.js
    end
  end

  def update_tactic_user
    @user_tactic = UserTactic.find(params[:user_tactic_id])
    @tactic = Tactic.find(params[:tactic_id])
    @user_tactics = UserTactic.where(tactic_id: @tactic.id)
    @user_tactics.update_all(owner: false)
    @user_tactic.update(owner: params[:owner])
    @users = @tactic.users 
  end

  def create_team_tactic
    @team_tactic = TeamTactic.where(team_id: params[:team_id], tactic_id: params[:tactic_id]).first_or_create(team_id: params[:team_id], tactic_id: params[:tactic_id])
    @teams = @tactic.teams
    respond_to do |format|
      format.js
    end   
  end

  def get_tactic_teams
    @teams = @tactic.teams
    respond_to do |format|
      format.js
    end
  end 

  def destroy_user_tactic
    @user_tactic = UserTactic.where(user_id: params[:user_id], tactic_id: params[:tactic_id]).first
    @user_tactic.destroy
    @users = @tactic.users
    respond_to do |format|
      format.js
    end
  end

  def destroy_team_tactic
    @team_tactic = TeamTactic.where(team_id: params[:team_id], tactic_id: params[:tactic_id]).first
    @team_tactic.destroy
    @teams = @tactic.teams
    respond_to do |format|
      format.js
    end
  end

  private
    def set_tactic
      @tactic = Tactic.find(params[:id])
    end

    def set_tactic_method_parameter
      @tactic = Tactic.find(params[:tactic_id])
    end
    
    def set_tactic_params
      @area = Area.find(params[:area_id]) 
      @plan = Plan.find(params[:plan_id])
      @division = Division.find(params[:division_id])
      @goal = Goal.find(params[:goal_id])
      @objective = Objective.find(params[:objective_id])
      @strategy = Strategy.find(params[:strategy_id])
    end

    def tactics_redirect_path
      redirect_to plan_division_area_goal_objective_strategy_tactics_path(plan_id: params[:plan_id], 
        division_id: params[:division_id], department_id: params[:department_id], area_id: params[:area_id], 
        goal_id: params[:goal_id], objective_id: params[:objective_id], strategy_id: params[:strategy_id])
    end

    def tactic_params
      params.require(:tactic).permit(:description, :begin_on, :end_on, :completed_on, :percent_complete,
        :percent_of_strategy, :assignee_id, :status, :strategy_id, :number, :days, :hours, :totalhours,
        :actual_days, :actual_hours, :total_actual_hours, assets_attributes: [:id, :title, :asset, :_destroy])
    end
end
