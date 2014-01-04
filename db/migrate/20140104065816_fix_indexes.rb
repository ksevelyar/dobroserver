class FixIndexes < ActiveRecord::Migration
  def change
    add_index :comments, :blog_record_id
    add_index :images, :blog_record_id
    add_index :attachments, :blog_record_id

    remove_index :blog_records, :type
    add_index :blog_records, :published_at

    remove_index :blog_records_tags, :blog_record_id
    add_index :blog_records_tags, [:blog_record_id, :tag_id]
  end
end
