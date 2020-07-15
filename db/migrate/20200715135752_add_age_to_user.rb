class AddAgeToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :age, :string
    add_column :users, :blood_group, :integer
  end
end
