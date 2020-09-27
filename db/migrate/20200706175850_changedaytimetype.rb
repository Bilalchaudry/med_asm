class Changedaytimetype < ActiveRecord::Migration[5.2]
  def change
    change_column :reminders, :timing, 'integer USING CAST(timing AS integer)'
  end
end
