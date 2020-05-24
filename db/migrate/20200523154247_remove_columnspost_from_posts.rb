class RemoveColumnspostFromPosts < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :artist, :string
    remove_column :posts, :song, :string
    remove_column :posts, :ytid, :string
  end
end
