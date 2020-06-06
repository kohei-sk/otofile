class AddColumnssns2ToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :sns_t, :string
    add_column :users, :sns_f, :string
    add_column :users, :sns_i, :string
    add_column :users, :sns_l, :string
    add_column :users, :userlink, :string
  end
end
