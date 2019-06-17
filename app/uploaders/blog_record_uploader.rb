# frozen_string_literal: true

class BlogRecordUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    parent    = model.blog_record.type.pluralize.underscore
    slug      = model.blog_record.slug
    file_type = mounted_as.to_s.pluralize
    "uploads/#{parent}/#{slug}/#{file_type}"
  end

  def self.update_files_dir(type, old_slug, new_slug)
    old_path = "#{Rails.root}/public/uploads/#{type.pluralize.underscore}/#{old_slug}"
    new_path = "#{Rails.root}/public/uploads/#{type.pluralize.underscore}/#{new_slug}"

    FileUtils.mv(old_path, new_path) if FileTest.exists?(old_path) && !FileTest.exists?(new_path)
  end

  def self.remove_files_dir(type, slug)
    path = "#{Rails.root}/public/uploads/#{type.pluralize.underscore}/#{slug}"

    FileUtils.rm_r(path) if FileTest.exists?(path)
  end
end
