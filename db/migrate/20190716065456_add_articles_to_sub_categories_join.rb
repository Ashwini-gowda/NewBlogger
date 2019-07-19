class AddArticlesToSubCategoriesJoin < ActiveRecord::Migration[5.2]
  def up
    create_table :articles_sub_categories, :id => false do |t|
      t.integer "article_id"
      t.integer "sub_category_id"
    end
    add_index :articles_sub_categories, ["article_id", "sub_category_id"]
  end
  def down
    drop_table :articles_sub_categories
  end
end
