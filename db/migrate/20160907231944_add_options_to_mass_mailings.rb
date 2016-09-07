class AddOptionsToMassMailings < ActiveRecord::Migration
  def change
      remove_column :mass_mailings, :account_id, :integer
      add_column :mass_mailings, :span, :integer, default: 0
      add_column :mass_mailings, :comment_count, :integer, default: 20
      add_column :mass_mailings, :comment_strategy, :string, default: 'default'
  end
end
