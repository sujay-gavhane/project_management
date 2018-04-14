class FeaturesController < ApplicationController
  before_action :authenticate_employee!
  before_action :authorize_employee
  before_action :find_feature, only: [:edit, :update]
  before_action :find_project

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
