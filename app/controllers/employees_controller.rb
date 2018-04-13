class EmployeesController < ApplicationController
  before_action :authenticate_employee!
  load_and_authorize_resource

  def index
    @employees = Employee.all
  end
end
