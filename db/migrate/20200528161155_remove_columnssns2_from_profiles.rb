class RemoveColumnssns2FromProfiles < ActiveRecord::Migration[5.2]
  def change
    remove_column :profiles, :sns_t, :string
    remove_column :profiles, :sns_f, :string
    remove_column :profiles, :sns_i, :string
    remove_column :profiles, :sns_l, :string
    remove_column :profiles, :userlink, :string
  end
end
