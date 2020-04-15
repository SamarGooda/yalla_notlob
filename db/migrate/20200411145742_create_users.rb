class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email, null: false, default: ""
      t.string :fname, null:false, default: ""
      t.string :lname, null:false, default: ""
      t.string :image, null:false, default: ""
      t.string :password_digest, null: false, default: ""

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
