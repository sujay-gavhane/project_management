class Feature < ActiveRecord::Base
  belongs_to :developer, class_name: 'Employee'
  belongs_to :project
  scope :by_status_project_developer, ->(project_id, developer_id, status) { where(status: status, project_id: project_id, developer_id: developer_id)}
end
