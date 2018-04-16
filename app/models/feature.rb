class Feature < ActiveRecord::Base
  belongs_to :developer, class_name: 'Employee'
  belongs_to :project
  scope :by_status_project_developer, ->(project_id, developer_id, status) { where(status: status, project_id: project_id, developer_id: developer_id)}
  scope :status_by_project_manager, ->(project_id, status) { where(status: status, project_id: project_id)}
  
  validates :title, presence: true
  validates :developer_id, presence: true
end
