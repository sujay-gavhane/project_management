class FeaturesController < ApplicationController
  before_action :authenticate_employee!
  before_action :authorize_employee, except: [:todo_list, :move_back, :move_forword, :manager_features_view]
  before_action :find_feature, only: [:edit, :update, :move_forword, :move_back]
  before_action :find_project, except: [:todo_list, :move_back, :move_forword, :manager_features_view]

  def new
    @feature = Feature.new
  end

  def create
    @feature = Feature.new(features_params)
    if @feature.save
      redirect_to project_features_path, notice: 'Feature Created Successfully'
    else
      redirect_to new_project_feature_path, alert: @feature.errors.full_messages.join('<br>')
    end
  end

  def index
    @features = @project.features.order('created_at desc')
  end

  def edit
  end

  def update
    if @feature.update_attributes(features_params)
      redirect_to project_features_path, notice: 'Feature Updated Successfully'
    else
      redirect_to edit_project_feature_path(@project, @feature), alert: @feature.errors.full_messages.join('<br>')
    end
  end

  def todo_list
    authorize! :view, :todo_list
    @projects = current_employee.projects
  end

  def move_forword
    authorize! :write, :move_forword
    case @feature.status
    when 'todo'
      @feature.update_attributes(status: 'inprogress')
      @message = { notice: "#{@feature.title} moved to In Progress", feature: @feature.id}
    when 'inprogress'
      @feature.update_attributes(status: 'done')
      @message = { notice: "#{@feature.title} moved to Done", feature: @feature.id}
    else
      @message = { alert: "#{@feature.title} can not be move forword."}
    end
  end

  def move_back
    authorize! :write, :move_back
    case @feature.status
    when 'done'
      @feature.update_attributes(status: 'inprogress')
      @message = { notice: "#{@feature.title} moved to In Progress", feature: @feature.id}
    when 'inprogress'
      @feature.update_attributes(status: 'todo')
      @message = { notice: "#{@feature.title} moved to ToDo", feature: @feature.id}
    else
      @message = { alert: "#{@feature.title} can not be move backword."}
    end
  end

  def manager_features_view
    @projects = current_employee.managing_projects
  end

  private

  def authorize_employee
    authorize! :manage, Feature
  end

  def find_feature
    @feature = Feature.find(params[:id])
  end

  def find_project
    @project = Project.find(params[:project_id])
  end

  def features_params
    params.require(:feature).permit(:title, :description, :developer_id, :status, :project_id)
  end
end
