class AddUserIdToPrescription < ActiveRecord::Migration[5.2]
  def change
    add_column :prescriptions, :user_id, :integer
  end
end
