class RemoveRecipientIdFromNotifications < ActiveRecord::Migration[6.0]
  def change

    remove_column :notifications, :recipient_id, :integer
  end
end
