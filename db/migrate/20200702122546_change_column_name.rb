class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :order_products, :type, :product_type
  end
end
