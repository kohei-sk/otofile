class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :artist
      t.string :ytid
      t.text :comment
      t.string :p_userid

      t.timestamps
    end
  end
end
