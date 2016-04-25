class AddAttachmentsToMessages < ActiveRecord::Migration
  def change
  	 add_attachment :messages, :pic1
  end
end
