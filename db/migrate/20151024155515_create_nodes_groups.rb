class CreateNodesGroups < ActiveRecord::Migration
  def change
    create_table :node_groups do |t|
      t.integer :node_id
      t.integer :group_id
    end

    add_index :node_groups, [:node_id, :group_id], unique: true
  end
end
