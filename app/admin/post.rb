ActiveAdmin.register Post do

  permit_params :raw_content, :tag_names, :title, :published, :published_at

#   scope :all
  scope :draft

  index do
    # column :thumb, max_width: "150px", min_width: "100px" do |post|
    #   image_tag post.images.first.image_url(:preview), size: "140x112"
    # end

    column :id

    column :title
    column :tags
    column :published
    column :published_at
    actions
  end
#
#   form do |f|
#     f.inputs "Основная информация" do
#       f.input :title, label: "Название"
#       f.input :body, input_html: { class: :tinymce }, label: "Программа"
#       f.input :teaser, input_html: { class: :tinymce }, label: "Тизер для главной"
#       f.input :cost_includes, label: "Цена включает"
#       f.input :cost_not_includes, label: "Цена не включает"
#       f.input :requirement, label: "Необходимо (виза, страховка)"
#       f.input :region_description, label: "Описание региона"
#       f.input :wallpaper, label: "Обложка"
#       f.input :wallpaper_cache, as: :hidden
#     end
#
#     f.inputs "Регионы" do
#       f.input :regions, as: :check_boxes
#     end
#
#     f.inputs "Повары" do
#       f.input :chefs, as: :check_boxes
#     end
#
#     f.inputs "Тип" do
#       f.input :julia_vysotskaya
#       f.input :new
#       f.input :weekend
#       f.input :main_page
#       f.input :published
#     end
#
#     f.inputs "Фотографии" do
#       f.has_many :photos, allow_destroy: true, new_record: false do |p|
#         #p.form_buffers.last << image_tag(p.object.image.url, size: "300x200").html_safe
#
#         css = if p.object.small?
#                 "small"
#               else
#                 "big"
#               end
#
#         p.form_buffers.last << image_tag(p.object.image.url(:thumb), class: css).html_safe
#       end
#
#       f.input :photo_files, as: :file, input_html: { multiple: true }
#     end
#
#     f.actions
#   end
#
#   # OPTIMIZE Загрузка нескольких фотографий за раз
#   controller do
#     after_filter :set_photos, only: [:create, :update]
#
#     private
#
#     def set_photos
#       photo_files = params[:travel][:photo_files]
#
#       if photo_files.present?
#         photo_files.each do |file|
#           resource.photos.build(image: file)
#         end
#
#         resource.save
#       end
#     end
#   end

  controller do
    defaults finder: :find_by_slug
  end
end
