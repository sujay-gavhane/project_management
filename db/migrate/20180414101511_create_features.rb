class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.string :title, null: false
      t.text :description
      t.integer :developer_id
      t.integer :project_id
      t.string :status, null: false, default: 'todo'

      t.timestamps null: false
    end
  end
end
