class UserboardsController < ApplicationController
  before_action :set_userboard, only: [:show, :edit, :update, :destroy]
  after_filter :discard_flash, only: :update
  
  def index
    @organization = current_user.organization
    @userboards = Userboard.current_organization_user_userboards(@organization.users)
  end

  def show
  end

  def new
    @userboard = Userboard.new
  end

  def edit
  end

  def create
    @userboard = Userboard.new(userboard_params)
    respond_to do |format|
      if @userboard.save
        format.html { redirect_to userboards_path, notice: 'Userboard was successfully created.' }
        format.json { render action: 'show', status: :created, location: @userboard }
      else
        format.html { render action: 'new' }
        format.json { render json: @userboard.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @userboard.update(userboard_params)
        format.html { redirect_to userboards_path, notice: 'Userboard was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @userboard.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @userboard.destroy
    respond_to do |format|
      format.html { redirect_to userboards_url }
      format.json { head :no_content }
    end
  end

  def my_board
    @userboards = current_user.userboards
    @tasks = current_user.tasks
  end

  private
    def discard_flash
      flash.discard if request.xhr?
    end

    def set_userboard
      @userboard = Userboard.find(params[:id])
    end

    def userboard_params
      params.require(:userboard).permit(:name, :userboard_type, :color, :status, :user_id, :task_id)
    end
end
