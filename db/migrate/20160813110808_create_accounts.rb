class CreateAccounts < ActiveRecord::Migration
  def up
    create_table :accounts do |t|
      t.json :connection_parameters, default: {}
      t.string :type
      t.timestamps null: false
    end

    User.all.each do |user|
      Account.create(connection_parameters: user.connection_parameters)
    end
  end

  def down
    drop_table :accounts
  end
end
