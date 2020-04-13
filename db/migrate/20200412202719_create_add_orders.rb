class CreateAddOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :type
      t.string :resturant
      t.string :status
      t.timestamps
    end
  end
end
