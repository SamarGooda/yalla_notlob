class CreateOrderItems < ActiveRecord::Migration[6.0]
  def change
    create_table :order_items do |t|
      t.references :orders, foreign_key: true
      t.integer :quantity
      t.string :item
      t.decimal :price
      t.string :status
      t.text :comment
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
