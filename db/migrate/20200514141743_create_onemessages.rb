class CreateOnemessages < ActiveRecord::Migration[5.2]
  def change
    create_table :onemessages do |t|
      t.text :message

      t.timestamps
    end
  end
end
