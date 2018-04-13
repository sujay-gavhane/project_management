class ProjectsController < ApplicationController
  before_action :authenticate_employee!
  before_action :authorize_employee
  before_action :find_project, only: [:edit, :update, :destroy]

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
