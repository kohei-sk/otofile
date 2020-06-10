class AddColumnsprfToProfiles < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :free_area, :text
    add_column :profiles, :fes_sche, :text
    add_column :profiles, :fes_his, :text
    add_column :profiles, :fav_playlist, :text
  end
end
