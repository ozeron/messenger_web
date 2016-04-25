class AddRemoteUrlToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :pic1_remote, :string, default: ''
    add_column :messages, :doc1_remote, :string, default: ''
  end
end
