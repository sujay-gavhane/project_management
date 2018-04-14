class Project < ActiveRecord::Base
  belongs_to :manager, class_name: 'Employee'
  has_many :assignees
  has_many :employees, through: :assignees
  has_many :features

  validates :title, presence: true, uniqueness: true
end
