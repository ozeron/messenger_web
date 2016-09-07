class AddAccountToMassMailings < ActiveRecord::Migration
  def change
    add_column :mass_mailings, :account_id, :integer
  end
end
