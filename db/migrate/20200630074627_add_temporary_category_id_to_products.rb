class AddTemporaryCategoryIdToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :temporary_category_id, :integer
  end
end
