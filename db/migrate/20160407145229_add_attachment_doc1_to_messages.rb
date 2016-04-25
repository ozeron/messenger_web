class AddAttachmentDoc1ToMessages < ActiveRecord::Migration
  def self.up
    change_table :messages do |t|
      t.attachment :doc1
    end
  end

  def self.down
    remove_attachment :messages, :doc1
  end
end
