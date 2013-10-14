class AddReceivedMailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :received_emails, :integer
  end
end
