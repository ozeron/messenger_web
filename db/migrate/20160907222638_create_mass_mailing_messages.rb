class CreateMassMailingMessages < ActiveRecord::Migration
  def change
    create_table :mass_mailing_messages do |t|
      t.belongs_to :mass_mailing, index: true
      t.belongs_to :message, index: true
      t.timestamps null: false
    end
  end
end
