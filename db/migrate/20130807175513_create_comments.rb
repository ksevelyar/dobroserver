class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :name
      t.string :email
      t.text :content
      t.integer :blog_record_id
      t.string :ip

      t.timestamps
    end
    add_index :comments, :blog_record_id
  end
end
