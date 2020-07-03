class AddMedicineTagToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :medicine_tag, :string
  end
end
