class AddColumnsYtidToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :ytid, :string
  end
end
