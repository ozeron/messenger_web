class AddConnectionParametersToUser < ActiveRecord::Migration
  def change
    add_column :users, :connection_parameters, :json, default: {}
  end
end
