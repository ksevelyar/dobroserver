require 'spec_helper'

shared_examples "BlogRecord" do
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :title }
  it { should validate_presence_of :content }
  it { should validate_presence_of :slug }

  it do
    create factory, title: "Уникальный заголовок"
    should validate_uniqueness_of(:title)
    should validate_uniqueness_of(:slug)
  end

  it { should belong_to(:user) }
  it { should have_many(:images).dependent(:destroy) }
  it { should have_many(:attachments).dependent(:destroy) }

  let(:factory) { described_class.to_s.underscore.to_sym }

  describe "#published?" do
    it "returns true if record published" do
      blog_record = create factory
      blog_record.published?.should be_true
    end

    it "returns false if published_at in future" do
      blog_record = create factory, published_at: Time.now + 42.years
      blog_record.published?.should be_false
    end

    it "returns false if self.published == false" do
      blog_record = create factory, published: false
      blog_record.published?.should be_false
    end
  end

  describe "#update_files_dir" do
    it "updates file directory after update" do
      blog_record = create factory
      BlogRecordUploader.should_receive(:update_files_dir).
        with(blog_record.type, blog_record.slug, "new_title")

      blog_record.update(title: "new_title")
    end
  end

  describe "#remove_files_dir" do
    it "removes file directory after destroy" do
      blog_record = create factory
      BlogRecordUploader.should_receive(:remove_files_dir).
        with(blog_record.type, blog_record.slug)

      blog_record.destroy
    end
  end
end
