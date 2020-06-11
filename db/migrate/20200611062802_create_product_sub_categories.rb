class CreateProductSubCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :product_sub_categories do |t|
      t.references :product_categories, foreign_key: true
      t.references :products, foreign_key: true

      t.timestamps
    end
  end
end
