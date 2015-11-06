class AddColumnStatusToMassMailing < ActiveRecord::Migration
  def change
    add_column :mass_mailings, :status, :string, default: 'pending'
  end
end
