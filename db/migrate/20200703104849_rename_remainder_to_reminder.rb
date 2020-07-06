class RenameRemainderToReminder < ActiveRecord::Migration[5.2]
  def change
    rename_table :remainders, :reminders
  end
end
