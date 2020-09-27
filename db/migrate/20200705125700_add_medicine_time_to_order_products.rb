class AddMedicineTimeToOrderProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :order_products, :medicine_time, :time
    add_column :reminders, :morning_time, :time
    add_column :reminders, :noon_time, :time
    add_column :reminders, :evening_time, :time
  end
end
