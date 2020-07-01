class AddEveningTineToOrderProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :order_products, :evening_time, :string
    add_column :order_products, :noon_time, :string
    add_column :order_products, :noon_dose, :string
    add_column :order_products, :evening_dose, :string
  end
end
