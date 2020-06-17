class RemoveDeviceTokenFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :device_token, :string
    remove_column :users, :status
    remove_column :users, :role
  end
end
