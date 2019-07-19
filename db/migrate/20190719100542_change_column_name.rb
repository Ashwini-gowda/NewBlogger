class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :userRole, :role
  end
end
