class ProjectsController < ApplicationController
  before_action :authenticate_employee!
  before_action :authorize_employee
  before_action :find_project, only: [:edit, :update, :assign_project, :show]

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(projects_params)
    if @project.save
      redirect_to projects_path, notice: 'Project Created Successfully'
    else
      redirect_to new_project_path, alert: @project.errors.full_messages.join('<br>')
    end
  end

  def index
    @projects = Project.where(manager_id: current_employee.id).order('created_at desc')
  end

  def edit
  end

  def update
    if @project.update_attributes(projects_params)
      redirect_to projects_path, notice: 'Project Updated Successfully'
    else
      redirect_to edit_project_path(@project), alert: @project.errors.full_messages.join('<br>')
    end
  end

  def show
    @employees = Employee.joins(:roles).where('roles.name = ?', 'developer')
  end

  def assign_project
    if params[:developers].present? 
      Assignee.transaction do
        params[:developers].each do |developer|
          Assignee.find_or_create_by(employee_id: developer, project_id: @project.id)
        end
      end
      redirect_to projects_path, notice: 'Assigned Successfully'
    else
      redirect_to project_path(@project.id), alert: "Please select atleast on developer"
    end
  end

  private

  def authorize_employee
    authorize! :manage, Project
  end

  def find_project
    @project = Project.find(params[:id])
  end

  def projects_params
    params.require(:project).permit(:title, :description, :manager_id)
  end
end
