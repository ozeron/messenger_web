class AddStatusTextToMassMailingNode < ActiveRecord::Migration
  def change
    add_column :mass_mailings_nodes, :status_text, :string, default: 'pending'
  end
end
