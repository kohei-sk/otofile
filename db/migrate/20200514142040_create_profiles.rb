class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.text :sns_t
      t.text :sns_f
      t.text :sns_i
      t.text :sns_l
      t.text :userlink
      t.text :trendartist
      t.text :torendsong
      t.string :fvcate
      t.text :fvartist
      t.text :fvsong
      t.string :fvmv
      t.text :myband
      t.string :h_year1
      t.string :h_year2
      t.string :h_year3
      t.string :h_year4
      t.string :h_year5
      t.text :h_content1
      t.text :h_content2
      t.text :h_content3
      t.text :h_content4
      t.text :h_content5

      t.timestamps
    end
  end
end
