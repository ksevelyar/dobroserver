class CreateBlogRecordsTags < ActiveRecord::Migration
  def change
    create_table :blog_records_tags, id: false do |t|
      t.integer :blog_record_id
      t.integer :tag_id
    end
    add_index :blog_records_tags, [:blog_record_id, :tag_id]
  end
end
