class AddSaveAddressIdToAdditionalInfo < ActiveRecord::Migration[5.2]
  def change
    add_column :additional_infos, :save_address_id, :integer
  end
end
