class AddReceivedMailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :integer, :received_emails
  end
end
