class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.json :connection_parameters, default: {}
      t.string :type
      t.timestamps null: false
    end
  end
end
