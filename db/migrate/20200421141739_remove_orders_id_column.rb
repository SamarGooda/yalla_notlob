class RemoveOrdersIdColumn < ActiveRecord::Migration[6.0]
  def change
    remove_column :order_items, :orders_id 
  end
end
