class RemoveColumnsmessageFromUsers < ActiveRecord::Migration[5.2]
  def up
    remove_column :users, :profile, :text
  end

  def down
    add_column :users, :profile
  end
end
