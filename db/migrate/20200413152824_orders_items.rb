class OrdersItems < ActiveRecord::Migration[6.0]
  def change
    create_table :orders_items do |t|
      t.integer :order_id
      t.string :quantity
      t.string :item
      t.integer :price
      t.string :status
      t.string :comment
      # t.references :user_id, foreign_key: true
      t.timestamps
    end
  end
end
