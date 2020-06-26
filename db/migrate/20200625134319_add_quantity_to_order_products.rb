class AddQuantityToOrderProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :order_products, :quantity, :integer
    add_column :order_products, :price, :integer
    add_column :order_products, :timing, :string
    add_column :order_products, :dose_quantity, :float
    add_column :order_products, :comment, :string
    add_column :order_products, :start_date, :date
    add_column :order_products, :end_date, :date
  end
end
