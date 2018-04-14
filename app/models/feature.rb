class Feature < ActiveRecord::Base
  belongs_to :developer, class_name: 'Employee'
  belongs_to :project
end
