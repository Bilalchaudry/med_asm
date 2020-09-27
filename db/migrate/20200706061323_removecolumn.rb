class Removecolumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :reminders, :noon_time
    remove_column :reminders, :evening_time
    rename_column :reminders, :morning_time, :time
  end
end
