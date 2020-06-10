class AddOmsgToUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :onemessages, :user, foreign_key: true
  end
end
