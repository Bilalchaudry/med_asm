class Removecolumns < ActiveRecord::Migration[5.2]
  def change
    remove_column :remainders, :noon_instructions, :string
    remove_column :remainders, :evening_instructions, :string
    remove_column :remainders, :noon_dose, :string
    remove_column :remainders, :evening_dose, :string
    remove_column :remainders, :noon_time, :string
    remove_column :remainders, :evening_time, :string
  end
end
