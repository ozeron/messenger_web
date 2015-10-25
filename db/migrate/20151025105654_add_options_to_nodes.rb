class AddOptionsToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :options, :json, default: {}
  end
end
