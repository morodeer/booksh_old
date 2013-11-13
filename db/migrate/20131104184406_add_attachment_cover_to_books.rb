class AddAttachmentCoverToBooks < ActiveRecord::Migration
  def change
    change_table :books do |t|
      t.attachment :cover
    end
  end
end
