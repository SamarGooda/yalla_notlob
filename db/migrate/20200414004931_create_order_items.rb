class CreateOrderItems < ActiveRecord::Migration[6.0]
  def change
    create_table :order_items do |t|
      t.references :orders, foreign_key: true
      t.string :quantity
      t.string :item
      t.integer :price
      t.string :status
      t.string :comment
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
