class DepartmentsController < ApplicationController
  before_action :set_department, only: [:show, :edit, :update, :destroy]

  def index
    @division = Division.find(params[:division_id])
    @departments = @division.departments
  end

  def show
    @plan = Plan.find(params[:plan_id])
    @division = Division.find(params[:division_id])
  end

  def new
    @division = Division.find(params[:division_id])
    @department = Department.new
  end

  def edit
    @division = Division.find(params[:division_id])
    @department = Department.find(params[:id])
  end

  def create
    @department = Department.create(department_params)
    redirect_to  organization_division_departments_path
  end

  def update
    @department = Department.find(params[:id])
    respond_to do |format|
      if @department.update(department_params)
        format.html { redirect_to organization_division_departments_path, notice: 'Department was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  
  def destroy
    @department = Department.find(params[:id])
    @department.destroy
    respond_to do |format|
      format.html { redirect_to organization_division_departments_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_department
      @department = Department.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def department_params
      params.require(:department).permit(:name, :division_id)
    end
end
