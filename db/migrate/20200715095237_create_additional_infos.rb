class CreateAdditionalInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :additional_infos do |t|
      t.string :city
      t.string :state
      t.string :street_no
      t.string :house_building_no
      t.string :appartment_office_name
      t.references :order

      t.timestamps
    end
  end
end
