class Removecolumnorderproducts < ActiveRecord::Migration[5.2]
  def change
    remove_column :order_products, :noon_instructions, :string
    remove_column :order_products, :evening_instruction, :string
    remove_column :order_products, :noon_dose, :string
    remove_column :order_products, :evening_dose, :string
    remove_column :order_products, :noon_time, :string
    remove_column :order_products, :evening_time, :string
    remove_column :order_products, :timing, :string
    remove_column :order_products, :dose_quantity, :string
    remove_column :order_products, :comment, :string
  end
end
