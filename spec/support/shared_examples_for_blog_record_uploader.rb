require 'spec_helper'

shared_examples "BlogRecordUploader" do
  let(:old_path) { "#{Rails.root}/public/uploads/posts/old_slug" }
  let(:new_path) { "#{Rails.root}/public/uploads/posts/new_slug" }

  after(:all) do
    FileUtils.rm_r new_path
  end

  describe ".update_files_dir" do
    it "renames slug directory" do
      FileUtils.mkdir_p old_path
      described_class.update_files_dir "Post", "old_slug", "new_slug"

      FileTest.exists?(old_path).should be_false
      FileTest.exists?(new_path).should be_true
    end
  end

  describe ".remove_files_dir" do
    it "removes slug directory" do
      FileUtils.mkdir_p old_path
      described_class.remove_files_dir "Post", "old_slug"

      FileTest.exists?(old_path).should be_false
    end
  end
end
