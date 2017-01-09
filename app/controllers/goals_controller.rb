class GoalsController < ApplicationController
  before_action :set_goal, only: [:show, :edit, :update, :destroy]
  before_filter :load_strategic_plans_list, only: :index
  def index
    @goals = Goal.all
    @goal = Goal.new
  end

  def show
  end

  def new
    @goal = Goal.new
  end

  def edit
    @divisions = current_user.organization.divisions
    @division = @goal.area.division
    @areas = @division.areas
  end

  def create
    @goal = Goal.new(goal_params)

    respond_to do |format|
      if @goal.save
        format.html { redirect_to goals_path, notice: 'Goal was successfully created.' }
        format.json { render action: 'show', status: :created, location: @goal }
      else
        format.html { render action: 'new' }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @goal.update(goal_params)
        format.html { redirect_to goals_path, notice: 'Goal was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @goal.destroy
    respond_to do |format|
      format.html { redirect_to goals_url }
      format.json { head :no_content }
    end
  end

  def get_selected_division
    @division = Division.find(params[:division_id])
    @areas = @division.areas
    respond_to do |format|
      format.js
    end
  end

  def get_selected_area_goals
    @area = Area.find(params[:area_id])
    @goals = @area.goals
    respond_to do |format|
      format.js
    end
  end

  def new_goal_attachment
    @goal = Goal.find(params[:goal_id])
    @asset = @goal.assets.build
    respond_to do |format|
      format.js
    end
  end

  private
    def set_goal
      @goal = Goal.find(params[:id])
    end

    def goal_params
      params.require(:goal).permit(:description, :number, :area_id, :department_id, :active, assets_attributes: [:id, :title, :asset, :_destroy])
    end
end
