class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :author
      t.text :content, limit: 2048
      t.integer :user_id

      t.timestamps
    end
  end
end
