class OrderFriends < ActiveRecord::Migration[6.0]
  def change
    create_table :orders_friends do |t|
      t.string :status
      # t.references :order_id, foreign_key: true
      # t.references :user_id, foreign_key: true
      t.timestamps
     end
    end
  end
