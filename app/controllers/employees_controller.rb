class EmployeesController < ApplicationController
  before_action :authenticate_employee!
  load_and_authorize_resource
  before_action :find_emaployee, only: [:edit, :update]
  def index
    @employees = Employee.all
  end

  def edit
  end

  def update
    role = @employee.roles.first.name
    if role == 'developer'
      @employee.remove_role :developer
      @employee.add_role :manager
      redirect_to employees_path, notice: 'Role updated successfully.'
    else
      redirect_to edit_employee_path(@employee), alert: 'Error while updating role.'
    end
  end

  private

  def find_emaployee
    @employee = Employee.find(params[:id])
  end
end
