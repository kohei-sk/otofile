class RemoveColumnsmessageFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :message, :text
  end
end
