class StrategiesController < ApplicationController
  before_action :set_strategy, only: [:show, :edit, :update, :destroy]

  def index
    @strategies = Strategy.all
  end

  def show
  end

  def new
    @strategy = Strategy.new
  end

  def edit
  end

  def create
    @strategy = Strategy.new(strategy_params)

    respond_to do |format|
      if @strategy.save
        format.html { redirect_to @strategy, notice: 'Strategy was successfully created.' }
        format.json { render action: 'show', status: :created, location: @strategy }
      else
        format.html { render action: 'new' }
        format.json { render json: @strategy.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @strategy.update(strategy_params)
        format.html { redirect_to @strategy, notice: 'Strategy was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @strategy.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @strategy.destroy
    respond_to do |format|
      format.html { redirect_to strategies_url }
      format.json { head :no_content }
    end
  end

  private
    def set_strategy
      @strategy = Strategy.find(params[:id])
    end

    def strategy_params
      params.require(:strategy).permit(:description, :fiscal_year, :budget_dollars, :budget_fte, :begin_on, :end_on, :percent_complete, :percent_of_objective, :completed_on, :objective_id, :number, :totalhours, :tactics_count, :actual_hours)
    end
end
