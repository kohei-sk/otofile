class AddColumns2ToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :userid, :string
    add_column :users, :userimg, :string
  end
end
