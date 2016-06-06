class AddTypeToMassMilingNodes < ActiveRecord::Migration
  def change
    add_column :mass_mailings_nodes, :type, :string, default: ''
  end
end
