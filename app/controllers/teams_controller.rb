class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]
  autocomplete :team, :name
  
  def index
    @teams = current_user.organization.teams.where(active: true)
  end

  def show
    @team_user = TeamUser.new
    @team_users = @team.users.not_organization_administrator
  end

  def new
    @team = Team.new
  end

  def edit
  end

  def create
    @team = Team.new(team_params)
    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
        format.json { render action: 'show', status: :created, location: @team }
      else
        format.html { render action: 'new' }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
    @team_user = TeamUser.create(user_id: current_user.id ,team_id: @team.id)
  end

  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url }
      format.json { head :no_content }
    end
  end

  def assign_member
    @team_user = TeamUser.where(user_id: params[:team_user][:user_id],
      team_id: params[:team_user][:team_id]).first_or_create(team_user_params)
    redirect_to team_path(id: params[:team_user][:team_id])
  end
  
  def remove_assigned_member
    @team_user = TeamUser.find_by(user_id: params[:user_id])
    @team_user.destroy
    redirect_to team_path(id: params[:id])
  end

  def autocomplete_team_name
    @organization = current_user.organization
    @organization_teams = @organization.teams
    @teams = @organization_teams.where("name LIKE ?", "%#{params[:term].downcase}%")
    render json: @teams.map{|f| {"value" => f.name , "key" => f.id} }.to_json
  end
  
  private
    def set_team
      @team = Team.find(params[:id])
    end

    def team_params
      params.require(:team).permit(:name, :organization_id)
    end
    def team_user_params
      params.require(:team_user).permit(:user_id, :team_id)
    end
end
