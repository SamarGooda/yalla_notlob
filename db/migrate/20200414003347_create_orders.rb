class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
        t.references :user, foreign_key: true
        t.string :kind
        t.string :resturant
        t.string :status
        t.string :menu
        t.timestamps
      end
    end
  end



