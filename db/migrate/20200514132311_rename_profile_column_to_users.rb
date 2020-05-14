class RenameProfileColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    rename_columns :users, :profile, :message
  end
end
