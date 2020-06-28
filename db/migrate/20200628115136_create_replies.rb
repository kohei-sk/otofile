class CreateReplies < ActiveRecord::Migration[5.2]
  def change
    create_table :replies do |t|
      t.string :r_uid
      t.text :reply
      t.references :comment, foreign_key: true

      t.timestamps
    end
  end
end
