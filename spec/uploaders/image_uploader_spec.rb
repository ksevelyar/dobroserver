require 'spec_helper'

describe ImageUploader do
  it 'creates previews for large images' do
    post = create(:post)
    image = create(:image, blog_record_id: post.id)

    expect(image.image.versions[:preview]).to be_present

    FileUtils.rm_rf "#{Rails.root}/public/uploads/posts/#{post.slug}"
  end
end
