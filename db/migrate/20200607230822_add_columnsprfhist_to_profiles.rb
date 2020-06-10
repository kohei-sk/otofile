class AddColumnsprfhistToProfiles < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :history, :string
  end
end
