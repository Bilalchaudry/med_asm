class RemoveRoleFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :role, :string
    add_column :users, :role, :integer, default: 1
  end
end
