class AddColumnsToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :song, :string
  end
end
