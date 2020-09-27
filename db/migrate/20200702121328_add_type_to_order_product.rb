class AddTypeToOrderProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :order_products, :type, :string
  end
end
