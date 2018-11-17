class ImageUploader < BlogRecordUploader
  include CarrierWave::MiniMagick

  version :preview, if: :big? do
    process resize_to_limit: [950, 600]
  end

  protected

  def big?(image)
    image = MiniMagick::Image.open(image.path)
    (image[:width] > 950) || (image[:height] > 600)
  end
end
