class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :fullname
      t.integer :contactNumber
      t.string :username
      t.string :userRole

      t.timestamps
    end
  end
end
