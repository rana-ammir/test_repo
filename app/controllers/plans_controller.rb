class PlansController < ApplicationController
  before_action :set_plan, only: [:show, :edit, :update, :destroy]
  before_filter :load_strategic_plans_list, only: :strategic_plan
  def index
    @organization = current_user.organization
    @plans = @organization.plans
  end

  def show
  end

  def new
    @plan = Plan.new
  end

  def edit
  end

  def create
    params[:plan][:begin_on].length == 0 ? begin_on = params[:plan][:begin_on] = nil : 
      begin_on = Date.strptime(params[:plan][:begin_on], "%m/%d/%Y")
    params[:plan][:end_on].length == 0 ? end_on = params[:plan][:end_on] = nil : 
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
    params[:plan][:begin_on].length == 0 ? begin_on = params[:plan][:begin_on] = nil : 
      begin_on = Date.strptime(params[:plan][:begin_on], "%m/%d/%Y")
    params[:plan][:end_on].length == 0 ? end_on = params[:plan][:end_on] = nil : 
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
  def strategic_plan
  end

  private
    def set_plan
      @plan = Plan.find(params[:id])
    end

    def plan_params
      params.require(:plan).permit(:name, :organization_id, :department_id, :status, :end_on, :begin_on, :fiscal_year)
    end
end
