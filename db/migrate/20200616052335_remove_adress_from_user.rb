class RemoveAdressFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :address, :string
    remove_column :users, :latitude
    remove_column :users, :longitude
    remove_column :users, :phone_verified
    change_column_default(:users, :gender, from: nil, to: 0)
  end
end
