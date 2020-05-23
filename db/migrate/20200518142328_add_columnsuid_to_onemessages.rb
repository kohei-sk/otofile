class AddColumnsuidToOnemessages < ActiveRecord::Migration[5.2]
  def change
    add_column :onemessages, :onemessage_uid, :string
  end
end
