# frozen_string_literal: true

class CreateAttachments < ActiveRecord::Migration[4.2]
  def change
    create_table :attachments do |t|
      t.string :attachment
      t.integer :blog_record_id
    end
    add_index :attachments, :blog_record_id
  end
end
