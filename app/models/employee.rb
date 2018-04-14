class Employee < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :developers, class_name: 'Employee', foreign_key: 'manager_id'
  belongs_to :manager, class_name: 'Employee'
  has_many :managing_projects, class_name: 'Project', foreign_key: 'manager_id'
  has_many :projects, through: :assignees
  has_many :assignees

  after_create :assign_default_role

  def assign_default_role
    unless self.email == 'test@projectmanagement.com'
      self.add_role(:developer) if self.roles.blank?
      manager = Employee.joins(:roles).where('roles.name = ?', 'manager')
      self.update_attributes(manager_id: manager.first.id)
    end
  end
end
