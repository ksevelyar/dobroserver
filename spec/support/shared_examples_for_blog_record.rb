require 'spec_helper'

shared_examples "BlogRecord" do
  it { is_expected.to validate_presence_of :user_id }
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :content }
  it { is_expected.to validate_presence_of :slug }

  it do
    create factory, title: "Уникальный заголовок"
    is_expected.to validate_uniqueness_of(:title)
    is_expected.to validate_uniqueness_of(:slug)
  end

  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:images).dependent(:destroy) }
  it { is_expected.to have_many(:attachments).dependent(:destroy) }

  let(:factory) { described_class.to_s.underscore.to_sym }

  describe "#published?" do
    it "returns true if record published" do
      blog_record = create factory
      expect(blog_record.published?).to be_truthy
    end

    it "returns false if published_at in future" do
      blog_record = create factory, published_at: Time.now + 42.years
      expect(blog_record.published?).to be_falsey
    end

    it "returns false if self.published == false" do
      blog_record = create factory, published: false
      expect(blog_record.published?).to be_falsey
    end
  end

  describe "#update_files_dir" do
    it "updates file directory after update" do
      blog_record = create factory
      expect(BlogRecordUploader).to receive(:update_files_dir).
        with(blog_record.type, blog_record.slug, "new_title")

      blog_record.update(title: "new_title")
    end
  end

  describe "#remove_files_dir" do
    it "removes file directory after destroy" do
      blog_record = create factory
      expect(BlogRecordUploader).to receive(:remove_files_dir).
        with(blog_record.type, blog_record.slug)

      blog_record.destroy
    end
  end
end
