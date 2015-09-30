class AddAttachmentPictureToSpots < ActiveRecord::Migration
  def self.up
    change_table :spots do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :spots, :picture
  end
end
