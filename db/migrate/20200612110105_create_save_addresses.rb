class CreateSaveAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :save_addresses do |t|
      t.string :address
      t.float :latitude
      t.float :longitude
      t.boolean :default
      t.integer :user_id

      t.timestamps
    end
  end
end
