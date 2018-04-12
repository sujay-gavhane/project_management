class EmployeesController < ApplicationController
  before_action :authenticate_employee!

  def index
    @employees = Employee.all
  end
end
