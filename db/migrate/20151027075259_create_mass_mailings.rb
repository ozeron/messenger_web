class CreateMassMailings < ActiveRecord::Migration
  def change
    create_table :mass_mailings do |t|
      t.string :title
      t.integer :message_id
      t.datetime :started
      t.datetime :finished

      t.timestamps null: false
    end

    create_table :mass_mailings_nodes do |t|
      t.belongs_to :mass_mailing, index: true
      t.belongs_to :node, index: true
    end
  end
end
