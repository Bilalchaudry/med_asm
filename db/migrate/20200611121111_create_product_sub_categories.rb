class CreateProductSubCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :product_sub_categories do |t|
      t.references :product_category, foreign_key: true
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
