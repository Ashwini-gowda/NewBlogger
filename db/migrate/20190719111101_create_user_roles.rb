class CreateUserRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :user_roles do |t|
      t.string :name
      t.integer :parent_role_id

      t.timestamps
    end
  end
end
