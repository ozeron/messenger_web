class AddStatusToMassMailingNode < ActiveRecord::Migration
  def change
    add_column :mass_mailings_nodes, :status, :string, default: 'pending'
  end
end
