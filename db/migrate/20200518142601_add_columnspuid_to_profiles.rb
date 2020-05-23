class AddColumnspuidToProfiles < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :profile_uid, :string
  end
end
