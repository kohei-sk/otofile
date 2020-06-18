class AddColumnshdrToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :hdrimg, :string
  end
end
