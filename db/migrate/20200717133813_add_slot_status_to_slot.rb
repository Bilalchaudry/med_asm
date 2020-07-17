class AddSlotStatusToSlot < ActiveRecord::Migration[5.2]
  def change
    add_column :slots, :slot_status, :boolean
  end
end
