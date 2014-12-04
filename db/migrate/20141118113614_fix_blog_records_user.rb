class FixBlogRecordsUser < ActiveRecord::Migration
  def change
    rename_column :blog_records, :user_id, :admin_user_id
  end
end
