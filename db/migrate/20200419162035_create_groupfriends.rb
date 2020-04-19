class CreateGroupfriends < ActiveRecord::Migration[5.0]
  def change
    create_table :groupfriends do |t|
          t.references :friend
          t.references :group
          t.timestamps
    
    end
  end
end
