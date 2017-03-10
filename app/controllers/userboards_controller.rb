class UserboardsController < ApplicationController
  before_action :set_userboard, only: [:show, :edit, :update, :destroy]

  def index
    @userboards = Userboard.all
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
        format.html { redirect_to @userboard, notice: 'Userboard was successfully created.' }
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
        format.html { redirect_to @userboard, notice: 'Userboard was successfully updated.' }
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

  private
    def set_userboard
      @userboard = Userboard.find(params[:id])
    end

    def userboard_params
      params[:userboard]
    end
end
