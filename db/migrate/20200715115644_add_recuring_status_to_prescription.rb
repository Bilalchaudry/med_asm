class AddRecuringStatusToPrescription < ActiveRecord::Migration[5.2]
  def change
    add_column :prescriptions, :recuring_status, :integer
  end
end
