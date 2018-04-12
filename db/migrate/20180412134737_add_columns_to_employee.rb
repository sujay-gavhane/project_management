class AddColumnsToEmployee < ActiveRecord::Migration
  def change
    add_column :employees, :first_name, :string
    add_column :employees, :last_name, :string
    add_column :employees, :manager_id, :integer
  end
end
