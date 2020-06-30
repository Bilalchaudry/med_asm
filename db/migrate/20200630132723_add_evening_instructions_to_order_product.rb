class AddEveningInstructionsToOrderProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :order_products, :noon_instructions, :string
    add_column :order_products, :evening_instruction, :string
  end
end
