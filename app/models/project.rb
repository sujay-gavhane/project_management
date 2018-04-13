class Project < ActiveRecord::Base
  belongs_to :manager, class_name: 'Employee'

  validates :title, presence: true
end
