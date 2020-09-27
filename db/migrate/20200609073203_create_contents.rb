class CreateContents < ActiveRecord::Migration[5.2]
  def change
    create_table :contents do |t|
      t.string :content
      t.string :page_type

      t.timestamps
    end
  end
end
