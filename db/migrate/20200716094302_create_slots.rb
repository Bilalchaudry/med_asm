class CreateSlots < ActiveRecord::Migration[5.2]
  def change
    create_table :slots do |t|
      t.string :day_time
      t.string :slot_time
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
