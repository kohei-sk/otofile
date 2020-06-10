class CreateHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :histories do |t|
      t.references :profile, foreign_key: true
      t.string :history
      t.string :year
      t.string :event

      t.timestamps
    end
  end
end
