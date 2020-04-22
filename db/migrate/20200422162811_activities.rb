class Activities < ActiveRecord::Migration[6.0]
  def change
    create_table :activities do |t|
      t.integer :user_id
      t.string :action
      t.integer :order_id
      t.integer :recipient_id
      t.timestamps
    end
  end
end
