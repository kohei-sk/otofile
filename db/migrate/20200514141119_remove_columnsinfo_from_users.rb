class RemoveColumnsinfoFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :sns_t, :text
    remove_column :users, :sns_f, :text
    remove_column :users, :sns_i, :text
    remove_column :users, :sns_l, :text
    remove_column :users, :userlink, :text
    remove_column :users, :trendartist, :text
    remove_column :users, :torendsong, :text
    remove_column :users, :fvcate, :string
    remove_column :users, :fvartist, :text
    remove_column :users, :fvsong, :text
    remove_column :users, :fvmv, :string
    remove_column :users, :myband, :text
    remove_column :users, :h_year1, :string
    remove_column :users, :h_year2, :string
    remove_column :users, :h_year3, :string
    remove_column :users, :h_year4, :string
    remove_column :users, :h_year5, :string
    remove_column :users, :h_content1, :text
    remove_column :users, :h_content2, :text
    remove_column :users, :h_content3, :text
    remove_column :users, :h_content4, :text
    remove_column :users, :h_content5, :text
  end
end
