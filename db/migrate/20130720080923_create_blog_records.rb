class CreateBlogRecords < ActiveRecord::Migration
  def change
    create_table :blog_records do |t|
      t.string :type
      t.text :content
      t.text :description
      t.string :title
      t.boolean :published
      t.datetime :published_at
      t.integer :user_id
      t.string :slug

      t.timestamps
    end
    add_index :blog_records, :slug, unique: true
    add_index :blog_records, :type
  end
end
