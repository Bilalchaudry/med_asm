class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :prescription_id
      t.float :total_amount

      t.timestamps
    end
  end
end
