class ChangeDoseQuantityFromOrderProducts < ActiveRecord::Migration[5.2]
  def change
    change_column :order_products, :dose_quantity, :string
  end
end
