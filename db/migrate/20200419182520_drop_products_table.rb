class DropProductsTable < ActiveRecord::Migration[5.0]
  def change
    drop_table :groupfriends
  end
end
