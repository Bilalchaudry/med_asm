class AddGenderToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :gender, :integer
    rename_column :users, :user_name, :full_name
  end
end
