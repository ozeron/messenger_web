class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name, null: false
      t.text :description, default: ''
      t.integer :parent_id
      t.timestamps null: false
    end
  end
end
