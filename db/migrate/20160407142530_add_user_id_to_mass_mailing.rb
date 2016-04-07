class AddUserIdToMassMailing < ActiveRecord::Migration
  def change
    add_column :mass_mailings, :sender_id, :integer
  end
end
