class CreateRemainders < ActiveRecord::Migration[5.2]
  def change
    create_table :remainders do |t|
      t.string :timing
      t.string :dose_quantity
      t.string :comment
      t.date :start_date
      t.date :end_date
      t.string :noon_instructions
      t.string :evening_instructions
      t.string :evening_time
      t.string :noon_time
      t.string :noon_dose
      t.string :evening_dose
      t.references :order_product, foreign_key: true

      t.timestamps
    end
  end
end
