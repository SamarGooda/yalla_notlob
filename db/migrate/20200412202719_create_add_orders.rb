class CreateAddOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :add_orders do |t|

      t.timestamps
    end
  end
end
