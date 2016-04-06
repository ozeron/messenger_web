class AddRemoteUrlToMessage < ActiveRecord::Migration
  def change
  	add_column :messages, :pic1_remote, :string, default:"No attachment"
  end
end
