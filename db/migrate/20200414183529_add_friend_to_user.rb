class AddFriendToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :friends, :friend_id, :integer
  end
end
