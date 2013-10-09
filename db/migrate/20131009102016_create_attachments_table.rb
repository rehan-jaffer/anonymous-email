class CreateAttachmentsTable < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.attachment :upload
    end
  end
end
