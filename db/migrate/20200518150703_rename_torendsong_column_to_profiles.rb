class RenameTorendsongColumnToProfiles < ActiveRecord::Migration[5.2]
  def change
    rename_column :profiles, :torendsong, :trendsong
  end
end
