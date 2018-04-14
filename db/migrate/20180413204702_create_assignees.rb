class CreateAssignees < ActiveRecord::Migration
  def change
    create_table :assignees do |t|
      t.integer :employee_id, null: false
      t.integer :project_id, null: false
    end
  end
end
