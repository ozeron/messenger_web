class AddNodesCounterToMassMailing < ActiveRecord::Migration
  def change
    add_column :mass_mailings, :processed_node_counter, :integer, default: 0
  end
end
