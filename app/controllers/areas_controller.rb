class AreasController < ApplicationController
  before_action :set_area, only: [:show, :edit, :update, :destroy]

  def index
    @areas = Area.all
    @area = Area.new
  end

  def show
    @plan = Plan.find(params[:plan_id])
    @division = Division.find(params[:division_id])
    @goals = @area.goals.sort_asc_goals
  end

  def new
    @area = Area.new
  end

  def edit
  end

  def create
    @area = Area.new(area_params)

    respond_to do |format|
      if @area.save
        format.html { redirect_to areas_path, notice: 'Area was successfully created.' }
        format.json { render action: 'show', status: :created, location: @area }
      else
        format.html { render action: 'index' }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @area.update(area_params)
        format.html { redirect_to areas_path, notice: 'Area was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @area.destroy
    respond_to do |format|
      format.html { redirect_to areas_url }
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

  private
    def set_area
      @area = Area.find(params[:id])
    end

    def area_params
      params.require(:area).permit(:number, :division_id, :description)
    end
end
