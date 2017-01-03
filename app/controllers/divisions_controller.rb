class DivisionsController < ApplicationController
  before_action :set_division, only: [:show, :edit, :update, :destroy]

  def index
    @divisions = current_user.organization.divisions
  end

  def show
  end

  def new
    @division = Division.new
  end

  def edit
  end

  def create
    @organization = current_user.organization
    @division = Division.create(division_params)
    redirect_to organization_divisions_path
  end

  def update
    respond_to do |format|
      if @division.update(division_params)
        format.html { redirect_to organization_divisions_path, notice: 'Division was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @division.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @division.destroy
    respond_to do |format|
      format.html { redirect_to organization_divisions_path }
      format.json { head :no_content }
    end
  end

  private
    def set_division
      @division = Division.find(params[:id])
    end

    def division_params
      params.require(:division).permit(:name, :organization_id)
    end
end
