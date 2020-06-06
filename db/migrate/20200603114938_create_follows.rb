class CreateFollows < ActiveRecord::Migration[5.2]
  def change
    create_table :follows do |t|
      t.string :u_id
      t.string :f_id

      t.timestamps
    end
  end
end
