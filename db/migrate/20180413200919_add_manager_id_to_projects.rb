class AddManagerIdToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :manager_id, :integer, null: false
  end
end
