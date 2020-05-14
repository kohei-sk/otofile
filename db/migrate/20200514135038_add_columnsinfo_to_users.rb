class AddColumnsinfoToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :sns_t, :text
    add_column :users, :sns_f, :text
    add_column :users, :sns_i, :text
    add_column :users, :sns_l, :text
    add_column :users, :userlink, :text
    add_column :users, :trendartist, :text
    add_column :users, :torendsong, :text
    add_column :users, :fvcate, :string
    add_column :users, :fvartist, :text
    add_column :users, :fvsong, :text
    add_column :users, :fvmv, :string
    add_column :users, :myband, :text
    add_column :users, :h_year1, :string
    add_column :users, :h_year2, :string
    add_column :users, :h_year3, :string
    add_column :users, :h_year4, :string
    add_column :users, :h_year5, :string
    add_column :users, :h_content1, :text
    add_column :users, :h_content2, :text
    add_column :users, :h_content3, :text
    add_column :users, :h_content4, :text
    add_column :users, :h_content5, :text
  end
end
