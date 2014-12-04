ActiveAdmin.register Page do
  permit_params :content, :title, :published, :published_at

  index do
    # column :thumb, max_width: "150px", min_width: "100px" do |post|
    #   image_tag post.images.first.image_url(:preview), size: "140x112"
    # end

    column :id

    column :title
    column :published
    column :published_at
    actions
  end


  controller do
    defaults finder: :find_by_slug
  end
end
