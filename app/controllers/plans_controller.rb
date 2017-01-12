class PlansController < ApplicationController
  before_action :set_plan, only: [:show, :edit, :update, :destroy]

  def index
    @plans = Plan.all
  end

  def show
  end

  def new
    @plan = Plan.new
  end

  def edit
  end

  def create
    begin_on = Date.strptime(params[:plan][:begin_on], "%m/%d/%Y")
    end_on = Date.strptime(params[:plan][:end_on], "%m/%d/%Y")
    @plan = Plan.new(plan_params.merge(begin_on: begin_on, end_on: end_on))
    respond_to do |format|
      if @plan.save
        format.html { redirect_to plans_path, notice: 'Plan was successfully created.' }
        format.json { render action: 'show', status: :created, location: @plan }
      else
        format.html { render action: 'new' }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    begin_on = Date.strptime(params[:plan][:begin_on], "%m/%d/%Y")
    end_on = Date.strptime(params[:plan][:end_on], "%m/%d/%Y")
    respond_to do |format|
      if @plan.update(plan_params.merge(begin_on: begin_on, end_on: end_on))
        format.html { redirect_to plans_path, notice: 'Plan was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @plan.destroy
    respond_to do |format|
      format.html { redirect_to plans_url }
      format.json { head :no_content }
    end
  end

  private
    def set_plan
      @plan = Plan.find(params[:id])
    end

    def plan_params
      params.require(:plan).permit(:name, :organization_id, :department_id, :status, :end_on, :begin_on, :fiscal_year)
    end
end
